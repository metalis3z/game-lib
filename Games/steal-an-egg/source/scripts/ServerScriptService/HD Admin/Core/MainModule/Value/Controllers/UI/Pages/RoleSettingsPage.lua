--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local SettingsList = require(frontend.Components.SettingsList)
local SettingsRole = require(frontend.Config.SettingsRole)
local RoleLockRules = require(frontend.Config.RoleLockRules)
local Pressable = require(frontend.Components.Pressable)
local Popup = require(frontend.Components.Popup)
local DataPopup = require(frontend.Components.DataPopup)
local Toggle = require(frontend.Components.Toggle)
local serializeRole = require(frontend.Util.SerializeRole)
local parseRole = require(frontend.Util.ParseRole)
local Icons = require(frontend.Config.Icons)
local Permissions = require(frontend.Util.Permissions)
local Remote = require(modules.Objects.Remote)
local changeRoleSetting = Remote.get("ChangeRoleSetting")
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	targetRoleKey: Fusion.Value<string>?,
	onItemSelectorOpen: any?,
	panelClosed: UsedAs<boolean>?,
	onDeleted: (() -> ())?, -- fired after successful DeleteRole (page should navigate back)
	onOpenViewCommandsForRole: ((roleKey: string) -> ())?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local targetRoleKey: Fusion.Value<string> = props.targetRoleKey or scope:Value("")

	local activeKey: Fusion.Value<string> = scope:Value(Fusion.peek(targetRoleKey))

	local useDefaultRolesFuse: any = (scope :: any):Fuse("everyone", {"GameSettings", "SystemSettings", "UseDefaultRoles"})

	-- Game-wide UseDefaultRoles previews every role as defaults with fields locked
	local useDefaultsLiveFuse: Fusion.Value<boolean> = scope:Computed(function(use)
		return use(useDefaultRolesFuse) == true
	end) :: any

	-- UseDefaultRoles gating is added here, the shared rules don't know about it
	local lockRule = function(ctx: any)
		local title: string = ctx.obj.title
		if typeof(title) ~= "string" then return nil end
		if title == "key" or title == "rank" or title == "data" then return nil end
		local rules = RoleLockRules.getRulesFor(title)
		local vbt = ctx.valueByTitle
		return scope:Computed(function(use)
			if use(useDefaultsLiveFuse) == true then return true end
			for _, rule in rules do
				if rule.parent then
					local pv = vbt[rule.parent]
					if pv and use(pv) == true then return true end
				end
				if rule.parents then
					for _, parent in rule.parents do
						local pv = vbt[parent]
						if pv and use(pv) == true then return true end
					end
				end
				if rule.requiredTrue then
					for _, requiredTitle in rule.requiredTrue do
						local pv = vbt[requiredTitle]
						if pv and use(pv) ~= true then return true end
					end
				end
			end
			return false
		end)
	end

	local canEditTarget = Permissions.canEditRoleByKey(scope, activeKey)
	local hasEditAll = Permissions.hasPermission(scope, "mayEditAll")

	-- Removing a perm stays allowed so you can downgrade roles without holding every perm
	local softLockRule = function(ctx: any)
		local obj: any = ctx.obj
		local title: string = obj.title
		if typeof(title) ~= "string" then return nil end
		if title == "key" or title == "rank" or title == "data" then return nil end
		local vbt = ctx.valueByTitle
		local isToggle = obj.inputType == "Toggle"
		local fieldHasPerm: any = if isToggle then Permissions.hasPermission(scope, title) else nil
		return scope:Computed(function(use)
			-- Rank check runs first so mayEditAll can't bypass an own-rank target
			if use(canEditTarget) ~= true then return true end
			if use(hasEditAll) == true then return false end
			if not isToggle then return false end
			-- Without the perm, only toggling off is allowed
			if use(fieldHasPerm) == true then return false end
			local fieldValue = vbt[title]
			local current = if fieldValue then use(fieldValue) else nil
			return current ~= true
		end)
	end


	local controllerRef: Fusion.Value<any> = scope:Value(nil :: any)

	local function getDefaults(): any
		local key = Fusion.peek(activeKey)
		if key == "" then return nil end
		local clientUser = require(modules.References.clientUser)
		local defaults = clientUser.everyone:get("DefaultRoleInfo")
		if typeof(defaults) == "table" then
			return defaults[key]
		end
		return nil
	end

	local function syncDisplayOverride()
		local controller = Fusion.peek(controllerRef)
		if not controller then return end
		if Fusion.peek(useDefaultsLiveFuse) == true then
			local defaults = getDefaults()
			if defaults then
				controller.beginDisplayOverride(defaults)
			end
		else
			controller.endDisplayOverride()
		end
	end

	scope:Observer(useDefaultsLiveFuse):onChange(syncDisplayOverride)
	scope:Observer(controllerRef):onChange(syncDisplayOverride)

	local nameFused: any, nameRefuse: any = (scope :: any):Fuse("everyone", {"RoleInfo", "_", "name"})
	local roleName: Fusion.Computed<string> = scope:Computed(function(use)
		local name = use(nameFused)
		if typeof(name) == "string" and name ~= "" then return name end
		local key = use(activeKey)
		return if typeof(key) == "string" then key else ""
	end)

	-- Restore Defaults and Use Studio Defaults are meaningless for user-created
	-- roles with no studio defaults to fall back to
	local defaultRoleInfoFuse: any = (scope :: any):Fuse("everyone", "DefaultRoleInfo")
	local isLoaderRole = scope:Computed(function(use)
		local key = use(activeKey)
		if typeof(key) ~= "string" or key == "" then return false end
		local defaults = use(defaultRoleInfoFuse)
		return typeof(defaults) == "table" and (defaults :: any)[key] ~= nil
	end)


	local rootFrame = scope:New "Frame" {
		Name = "RoleSettingsPage",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
	}

	-- A fresh scope per open, fully torn down on close so each open starts clean
	local activePopupScope: any = nil
	local activePopupInstance: Instance? = nil

	local function closeDeletePopup()
		if activePopupInstance then
			(activePopupInstance :: Instance):Destroy()
			activePopupInstance = nil
		end
		if activePopupScope then
			Fusion.doCleanup(activePopupScope)
			activePopupScope = nil
		end
	end

	local openDeletePopup: () -> ()

	openDeletePopup = function()
		closeDeletePopup()

		local popupScope: any = Fusion.scoped(Fusion)
		activePopupScope = popupScope

		local visible: Fusion.Value<boolean> = popupScope:Value(true)
		local confirmToggle: Fusion.Value<boolean> = popupScope:Value(false)
		local inFlight: Fusion.Value<boolean> = popupScope:Value(false)
		local canConfirm: Fusion.Computed<boolean> = popupScope:Computed(function(use)
			if use(inFlight) then return false end
			return use(confirmToggle) == true and use(roleName) ~= ""
		end)

		local function confirmDelete()
			if not Fusion.peek(canConfirm) then return end
			local key = Fusion.peek(activeKey)
			if typeof(key) ~= "string" or key == "" then return end
			inFlight:set(true)
			task.spawn(function()
				local deleteRoleRemote = Remote.get("DeleteRole")
				local ok, err = (deleteRoleRemote :: any):invokeServerAsync(key)
				-- The popup may have been destroyed before the response returned
				if activePopupScope ~= popupScope then return end
				inFlight:set(false)
				if ok then
					closeDeletePopup()
					if props.onDeleted then
						props.onDeleted()
					end
				else
					local Prompt = require(modules.Prompt)
					Prompt.warn(tostring(err or "Failed to delete role"))
				end
			end)
		end

		local popup = Popup(popupScope, {
			visible = visible,
			title = "Delete Role",
			dismissible = true,
			backdropDismiss = true,
			onClose = function()
				if Fusion.peek(inFlight) then return end
				closeDeletePopup()
			end,
			content = {
				popupScope:New "TextLabel" {
					Name = "Prompt",
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					FontFace = popupScope:Computed(function(use)
						return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Light))
					end),
					LayoutOrder = 1,
					RichText = true,
					Size = UDim2.fromScale(1, 0),
					Text = "This action cannot be undone.",
					TextColor3 = Theme.Color.NeutralContentDark,
					TextSize = Theme.TextSize.Body,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
				},
				Toggle(popupScope, {
					title = "Confirm",
					value = confirmToggle,
				}),
			},
			actions = {
				Pressable(popupScope, {
					name = "CancelButton",
					size = UDim2.fromOffset(96, 34),
					backgroundColor = Theme.Color.Neutral,
					onActivate = function()
						if Fusion.peek(inFlight) then return end
						closeDeletePopup()
					end,
					layoutOrder = 1,
					[Children] = {
						popupScope:New "UICorner" {
							CornerRadius = popupScope:Computed(function(use)
								return UDim.new(0, use(Theme.Layout.CornerRadius) :: number)
							end),
						},
						popupScope:New "UIStroke" {
							ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
							Color = Theme.Color.NeutralStroke,
						},
						popupScope:New "TextLabel" {
							Name = "Label",
							AnchorPoint = Vector2.new(0.5, 0.5),
							BackgroundTransparency = 1,
							FontFace = popupScope:Computed(function(use)
								return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
							end),
							Position = UDim2.fromScale(0.5, 0.5),
							Size = UDim2.fromScale(1, 1),
							Text = "Cancel",
							TextColor3 = Theme.Color.BaseContent,
							TextSize = Theme.TextSize.Body,
							TextXAlignment = Enum.TextXAlignment.Center,
							TextYAlignment = Enum.TextYAlignment.Center,
						},
					},
				}),
				Pressable(popupScope, {
					name = "ConfirmDeleteButton",
					size = UDim2.fromOffset(140, 34),
					backgroundColor = popupScope:Computed(function(use)
						return if use(canConfirm)
							then use(Theme.Color.Primary)
							else (use(Theme.Color.Primary) :: Color3):Lerp(Color3.new(0, 0, 0), 0.3)
					end),
					interactable = canConfirm,
					onActivate = confirmDelete,
					layoutOrder = 2,
					[Children] = {
						popupScope:New "UICorner" {
							CornerRadius = popupScope:Computed(function(use)
								return UDim.new(0, use(Theme.Layout.CornerRadius) :: number)
							end),
						},
						popupScope:New "UIStroke" {
							ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
							Color = Theme.Color.NeutralStroke,
						},
						popupScope:New "TextLabel" {
							Name = "Label",
							AnchorPoint = Vector2.new(0.5, 0.5),
							BackgroundTransparency = 1,
							FontFace = popupScope:Computed(function(use)
								return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
							end),
							Position = UDim2.fromScale(0.5, 0.5),
							Size = UDim2.fromScale(1, 1),
							Text = popupScope:Computed(function(use)
								return if use(inFlight) then "Deleting..." else "Delete"
							end),
							TextColor3 = Theme.Color.PrimaryContent,
							TextSize = Theme.TextSize.Body,
							TextXAlignment = Enum.TextXAlignment.Center,
							TextYAlignment = Enum.TextYAlignment.Center,
							TextTransparency = popupScope:Computed(function(use)
								return if use(canConfirm) then 0 else 0.35
							end),
						},
					},
				}),
			},
			zIndex = 100,
		})
		;(popup :: any).Parent = rootFrame
		activePopupInstance = popup :: Instance
	end

	-- Build once, rebind on switch
	local hasBuilt = false

	local function buildDangerZoneButton(opts: {
		name: string,
		label: any,
		baseColor: any,
		textColor: any,
		icon: string?,
		strokeColor: any?, -- when set, uses a solid stroke colour instead of the default gradient
		onActivate: () -> (),
	}): Instance
		local isHovered: Fusion.Value<boolean> = scope:Value(false)
		local isPressed: Fusion.Value<boolean> = scope:Value(false)
		local buttonColor = scope:Computed(function(use)
			local base = use(opts.baseColor) :: Color3
			local luminance = 0.299 * base.R + 0.587 * base.G + 0.114 * base.B
			local tint = if luminance > 0.5 then Color3.new(0, 0, 0) else Color3.new(1, 1, 1)
			if use(isPressed) then
				return base:Lerp(tint, 0.20)
			elseif use(isHovered) then
				return base:Lerp(tint, 0.10)
			end
			return base
		end)
		return Pressable(scope, {
			name = opts.name,
			size = UDim2.new(1, 0, 0, 38),
			backgroundColor = buttonColor,
			onHoverChanged = function(hovered) isHovered:set(hovered) end,
			onPressChanged = function(pressed) isPressed:set(pressed) end,
			onActivate = opts.onActivate,
			[Children] = {
				scope:New "UICorner" {
					CornerRadius = UDim.new(0, 9),
				},
				if opts.strokeColor then scope:New "UIStroke" {
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					Color = opts.strokeColor,
				} else scope:New "UIStroke" {
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					Color = Color3.new(1, 1, 1),
					[Children] = {
						scope:New "UIGradient" {
							Color = scope:Computed(function(use)
								local base = use(opts.baseColor) :: Color3
								local stroke = use(Theme.Color.NeutralContent)
								return ColorSequence.new({
									ColorSequenceKeypoint.new(0, stroke),
									ColorSequenceKeypoint.new(1, base),
								})
							end),
							Rotation = 90,
						},
					},
				},
				scope:New "Frame" {
					Name = "Content",
					AnchorPoint = Vector2.new(0.5, 0.5),
					AutomaticSize = Enum.AutomaticSize.X,
					BackgroundTransparency = 1,
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.new(0, 0, 1, 0),
					[Children] = {
						scope:New "UIListLayout" {
							FillDirection = Enum.FillDirection.Horizontal,
							HorizontalAlignment = Enum.HorizontalAlignment.Center,
							VerticalAlignment = Enum.VerticalAlignment.Center,
							Padding = UDim.new(0, 6),
							SortOrder = Enum.SortOrder.LayoutOrder,
						},
						if opts.icon then scope:New "ImageLabel" {
							Name = "Icon",
							BackgroundTransparency = 1,
							Image = opts.icon,
							ImageColor3 = opts.textColor,
							LayoutOrder = 1,
							Size = UDim2.fromOffset(20, 20),
						} else nil,
						scope:New "TextLabel" {
							Name = "Label",
							AutomaticSize = Enum.AutomaticSize.X,
							BackgroundTransparency = 1,
							FontFace = scope:Computed(function(use)
								return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
							end),
							LayoutOrder = 2,
							Size = UDim2.new(0, 0, 1, 0),
							Text = opts.label,
							TextColor3 = opts.textColor,
							TextSize = scope:Computed(function(use)
								return math.round(17 * (use(Theme.Layout.ContentScale) :: number))
							end),
							TextTruncate = Enum.TextTruncate.SplitWord,
							TextXAlignment = Enum.TextXAlignment.Center,
							TextYAlignment = Enum.TextYAlignment.Center,
						},
					},
				},
			},
		})
	end

	-- RichText embeds the warning glyph inline so the banner is one wrapping
	-- TextLabel, avoiding the UIFlexItem + TextWrapped layout quirks
	local function buildReadOnlyNotice(): Instance
		return scope:New "Frame" {
			Name = "ReadOnlyNotice",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = Theme.Color.Primary,
			BackgroundTransparency = 0.88,
			LayoutOrder = -1,
			Size = UDim2.new(1, 0, 0, 0),
			Visible = scope:Computed(function(use)
				return use(canEditTarget) ~= true
			end),
			[Children] = {
				scope:New "UIStroke" {
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					Color = Theme.Color.Primary,
					Thickness = 1,
				},
				scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
				scope:New "UIPadding" {
					PaddingLeft = UDim.new(0, 10),
					PaddingRight = UDim.new(0, 10),
					PaddingTop = UDim.new(0, 8),
					PaddingBottom = UDim.new(0, 8),
				},
				scope:New "TextLabel" {
					Name = "Label",
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					FontFace = scope:Computed(function(use)
						return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
					end),
					RichText = true,
					Size = UDim2.new(1, 0, 0, 0),
					Text = scope:Computed(function(use)
						local name = use(roleName)
						if name ~= "" then
							return `This role is read-only: you can only edit ranks in-game lower than yours`
						end
						return "Read-only: you don't have permission to edit this role. Its rank is at or above your own."
					end),
					TextColor3 = Theme.Color.Primary,
					TextSize = Theme.TextSize.Body,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
				},
			},
		}
	end

	local function buildDangerZone(): Instance
		local isLocked = useDefaultsLiveFuse

		local restoreButton = buildDangerZoneButton({
			name = "RestoreDefaultsButton",
			label = "Restore Defaults",
			baseColor = Theme.Color.Neutral,
			textColor = Theme.Color.BaseContent,
			onActivate = function()
				local controller = Fusion.peek(controllerRef)
				if controller and controller.restoreDefaults then
					controller.restoreDefaults()
				end
			end,
		})

		local deleteButton = buildDangerZoneButton({
			name = "DeleteRoleButton",
			label = scope:Computed(function(use)
				local name = use(roleName)
				return if name ~= "" then `Delete '{name}'` else "Delete Role"
			end),
			baseColor = Theme.Color.Primary,
			textColor = Theme.Color.PrimaryContent,
			icon = Icons.WarningFill,
			onActivate = openDeletePopup,
		})

		-- With both buttons hidden the heading and divider would sit above nothing
		return scope:New "Frame" {
			Name = "DangerZone",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 0),
			Visible = canEditTarget,
			[Children] = {
				scope:New "UIListLayout" {
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Left,
					Padding = UDim.new(0, 0),
					SortOrder = Enum.SortOrder.LayoutOrder,
				},
				scope:New "UIPadding" {
					PaddingTop = UDim.new(0, 18),
				},
				scope:New "TextLabel" {
					Name = "Heading",
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundTransparency = 1,
					FontFace = scope:Computed(function(use)
						return Font.new(use(Theme.Font.Heading), use(Theme.FontWeight.Heading))
					end),
					LayoutOrder = 1,
					Text = "Danger Zone",
					TextColor3 = Theme.Color.BaseContent,
					TextSize = Theme.TextSize.Title,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextTransparency = scope:Computed(function(use)
						return if use(isLocked) == true then 0.65 else 0
					end),
				},
				scope:New "Frame" {
					Name = "DividerWrap",
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					LayoutOrder = 2,
					Size = UDim2.new(1, 0, 0, 0),
					[Children] = {
						scope:New "UIPadding" {
							PaddingTop = UDim.new(0, 6),
							PaddingBottom = UDim.new(0, 10),
						},
						scope:New "Frame" {
							Name = "Divider",
							BackgroundColor3 = Theme.Color.NeutralContent,
							Size = UDim2.new(1, 0, 0, 1),
						},
					},
				},
				scope:New "Frame" {
					Name = "ButtonStack",
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					ClipsDescendants = false,
					LayoutOrder = 3,
					Size = UDim2.fromScale(1, 0),
					Interactable = scope:Computed(function(use)
						return not (use(isLocked) == true)
					end),
					[Children] = {
						scope:New "Frame" {
							Name = "Inner",
							AutomaticSize = Enum.AutomaticSize.Y,
							BackgroundTransparency = 1,
							Size = UDim2.fromScale(1, 0),
							[Children] = {
								scope:New "UIListLayout" {
									FillDirection = Enum.FillDirection.Vertical,
									HorizontalFlex = Enum.UIFlexAlignment.Fill,
									Padding = UDim.new(0, 8),
									SortOrder = Enum.SortOrder.LayoutOrder,
								},
								scope:New "Frame" {
									Name = "RestoreWrap",
									BackgroundTransparency = 1,
									LayoutOrder = 1,
									Size = UDim2.new(1, 0, 0, 38),
									Visible = scope:Computed(function(use)
										return use(isLoaderRole) == true and use(canEditTarget) == true
									end),
									[Children] = { restoreButton },
								},
								scope:New "Frame" {
									Name = "DeleteWrap",
									BackgroundTransparency = 1,
									LayoutOrder = 3,
									Size = UDim2.new(1, 0, 0, 38),
									Visible = canEditTarget,
									[Children] = { deleteButton },
								},
							},
						},
						scope:New "Frame" {
							Name = "LockOverlay",
							BackgroundColor3 = Theme.Color.Base,
							BackgroundTransparency = scope:Computed(function(use)
								return if use(isLocked) == true then 0.35 else 1
							end),
							Size = UDim2.fromScale(1, 1),
							ZIndex = 20,
						},
					},
				},
			},
		}
	end

	-- Parallels the delete popup, fresh scope per open
	local activeDataPopupScope: any = nil
	local activeDataPopupInstance: Instance? = nil

	local function closeDataPopup()
		if activeDataPopupInstance then
			(activeDataPopupInstance :: Instance):Destroy()
			activeDataPopupInstance = nil
		end
		if activeDataPopupScope then
			Fusion.doCleanup(activeDataPopupScope)
			activeDataPopupScope = nil
		end
	end

	local function openDataPopup()
		closeDataPopup()
		local popupScope: any = Fusion.scoped(Fusion)
		activeDataPopupScope = popupScope
		local visible: Fusion.Value<boolean> = popupScope:Value(true)
		local roleInfoTable: any = nil
		do
			local clientUser = require(modules.References.clientUser)
			local key = Fusion.peek(activeKey)
			local all = clientUser.everyone:get("RoleInfo")
			if typeof(all) == "table" and typeof(key) == "string" then
				roleInfoTable = (all :: any)[key]
			end
		end
		local copyText = if typeof(roleInfoTable) == "table" then serializeRole(roleInfoTable) else "return {}"
		local popup = DataPopup(popupScope, {
			visible = visible,
			copyText = copyText,
			hideLoad = useDefaultsLiveFuse,
			onClose = function()
				closeDataPopup()
			end,
			onLoad = function(pasted: string): (boolean, string)
				local ok, resultOrErr, count = parseRole(pasted)
				if not ok then
					return false, "Failed loading data, please re-write"
				end
				local parsed = resultOrErr :: {[string]: any}
				-- Applied as pending changes through the controller so the user can review
				local controller = Fusion.peek(controllerRef)
				if not controller or not controller.setFieldValue then
					return false, "Settings list not ready"
				end
				for fieldName, value in parsed do
					controller.setFieldValue(fieldName, value)
				end
				return true, `Successfully updated {count or 0} role values`
			end,
		})
		;(popup :: any).Parent = rootFrame
		activeDataPopupInstance = popup :: Instance
	end

	local function buildSettingsList(key: string)
		hasBuilt = true
		activeKey:set(key)
		nameRefuse({"RoleInfo", key, "name"})

		local sl = SettingsList(scope, {
			settingsData = SettingsRole,
			stateSource = "everyone",
			pathPrefix = { "RoleInfo", key },
			onItemSelectorOpen = props.onItemSelectorOpen,
			onChangeRemote = changeRoleSetting,
			changeRemoteArgsBuilder = function(info: any)
				return Fusion.peek(activeKey), info.title, info.intendedValue
			end,
			getDefaults = getDefaults,
			panelClosed = props.panelClosed,
			lockRule = lockRule,
			softLockRule = softLockRule,
			controllerRef = controllerRef,
			contentLocked = useDefaultsLiveFuse,
			undoOnDestroy = true,
			headerSlot = buildReadOnlyNotice(),
			-- The wrapper also needs to know, otherwise the parent layout reserves
			-- sibling padding above the hidden notice
			headerSlotVisible = scope:Computed(function(use)
				return use(canEditTarget) ~= true
			end),
			footerSlot = buildDangerZone(),
			objectOverrides = {
				data = {
					onActivate = openDataPopup,
					buttonText = scope:Computed(function(use)
						return if use(useDefaultsLiveFuse) == true then "Copy" else "Copy or Load"
					end),
				},
				viewCommands = {
					onActivate = function()
						local key = Fusion.peek(activeKey)
						if typeof(key) == "string" and key ~= "" and props.onOpenViewCommandsForRole then
							props.onOpenViewCommandsForRole(key)
						end
					end,
				},
			},
		})
		;(sl :: any).Parent = rootFrame
	end

	local function switchToRole(key: string)
		if not hasBuilt then
			buildSettingsList(key)
			return
		end
		activeKey:set(key)
		nameRefuse({"RoleInfo", key, "name"})
		local controller = Fusion.peek(controllerRef)
		if controller and controller.rebindToPath then
			controller.rebindToPath({ "RoleInfo", key })
		end
		task.defer(syncDisplayOverride)
	end

	scope:Observer(targetRoleKey):onChange(function()
		local key = Fusion.peek(targetRoleKey)
		if typeof(key) == "string" and key ~= "" then
			switchToRole(key)
		else
			local controller = Fusion.peek(controllerRef)
			if controller then
				controller.undoChanges()
			end
		end
	end)

	local initialKey = Fusion.peek(targetRoleKey)
	if typeof(initialKey) == "string" and initialKey ~= "" then
		switchToRole(initialKey)
	end

	table.insert(scope :: any, closeDeletePopup)
	table.insert(scope :: any, closeDataPopup)

	return rootFrame
end
