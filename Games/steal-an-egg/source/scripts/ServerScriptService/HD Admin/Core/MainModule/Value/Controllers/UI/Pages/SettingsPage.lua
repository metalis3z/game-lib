--!strict
-- LOCAL FIRST
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local frontend = modules.Parent.Controllers.UI
local Icons = require(frontend.Config.Icons)
local SettingsYou = require(frontend.Config.SettingsYou)
local SettingsGame = require(frontend.Config.SettingsGame)
local Permissions = require(frontend.Util.Permissions)
local NoPermissionPlaceholder = require(frontend.Components.NoPermissionPlaceholder)


-- CONFIG
local TAB_DEFS: { TabBar.Tab } = {
	{ label = "You", icon = Icons.UserSettingsFill },
	{ label = "Game", icon = Icons.FileSettingsFill },
}
local TAB_SETTINGS = {
	[1] = SettingsYou,
	[2] = SettingsGame,
}


-- LOCAL
local packages = modules.Parent.Packages
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local TabBar = require(frontend.Components.TabBar)
local Pressable = require(frontend.Components.Pressable)
local SettingsList = require(frontend.Components.SettingsList)
local TabbedScroller = require(frontend.Components.TabbedScroller)
local Remote = require(modules.Objects.Remote)
local changeYouSetting = Remote.get("ChangeYouSetting")
local changeGameSetting = Remote.get("ChangeGameSetting")
local getDefaultYouSettings = Remote.get("GetDefaultYouSettings")
local clientUser = require(modules.References.clientUser)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>


-- COMPONENT
return function(scope: Scope, props: any?)
	local onItemSelectorOpen = props and (props :: any).onItemSelectorOpen
	local panelClosed = props and (props :: any).panelClosed

	local activeTab: Fusion.Value<number> = scope:Value(1)

	-- Denied tabs swap to a placeholder body but the tab bar stays visible
	local canViewByTab = {
		[1] = Permissions.canViewPage(scope, "YouSettings"),
		[2] = Permissions.canViewPage(scope, "GameSettings"),
	}

	local destroyed = false
	table.insert(scope, function()
		destroyed = true
	end)

	local tabControllers: { Fusion.Value<any> } = {
		scope:Value(nil :: any),
		scope:Value(nil :: any),
	}

	-- Read SavedGameSettings, not GameSettings. The local preview overwrites
	-- GameSettings so the Confirm bar could never appear
	local useDefaultGameSettingsFuse: any = (scope :: any):Fuse("everyone",
		{"SavedGameSettings", "SystemSettings", "UseDefaultGameSettings"})
	-- Deep fuses only fetch the leaf path, so pull the whole table now
	task.spawn(function()
		clientUser.everyone:fetchAsync("SavedGameSettings")
		clientUser.everyone:fetchAsync("DefaultGameSettings")
	end)
	local localUseDefaultGameSettings: Fusion.Value<boolean> = scope:Value(
		Fusion.peek(useDefaultGameSettingsFuse) == true
	)
	-- Inferring pending-ness from local ~= server mistakes cold-open replication
	-- lag for a real toggle and lights the Confirm bar with no interaction
	local userDirtiedToggle = false
	local function gameTogglePending(): boolean
		return userDirtiedToggle
	end
	-- Resync local from server whenever no user toggle is pending
	scope:Observer(useDefaultGameSettingsFuse):onChange(function()
		if destroyed then return end
		if not userDirtiedToggle then
			localUseDefaultGameSettings:set(Fusion.peek(useDefaultGameSettingsFuse) == true)
		end
	end)
	local useDefaultsLive: Fusion.Computed<boolean> = scope:Computed(function(use)
		return use(localUseDefaultGameSettings) == true
	end)

	-- The preview writes the target view into clientUser.everyone so live consumers
	-- react immediately, snapshotting the original on first divergence. Both toggle
	-- directions build a view, USD-off under server USD-on has nothing to restore
	local deepCopyTable = require(modules.TableUtil.deepCopyTable)
	local previewSnapshot: any = nil
	local previewIsOurWrite = false
	local function buildForcedView(): any?
		local default = clientUser.everyone:get("DefaultGameSettings")
		if typeof(default) ~= "table" then return nil end
		local forced: any = deepCopyTable(default)
		if typeof(forced.SystemSettings) ~= "table" then forced.SystemSettings = {} end
		local source = previewSnapshot
		if typeof(source) ~= "table" then source = clientUser.everyone:get("SavedGameSettings") end
		if typeof(source) == "table" and typeof(source.SystemSettings) == "table" then
			for _, flag in {"UseDefaultGameSettings", "UseDefaultRoles"} do
				if source.SystemSettings[flag] ~= nil then
					forced.SystemSettings[flag] = source.SystemSettings[flag]
				end
			end
		end
		forced.SystemSettings.UseDefaultGameSettings = true
		return forced
	end
	local function buildSavedView(): any?
		local saved = clientUser.everyone:get("SavedGameSettings")
		if typeof(saved) ~= "table" then return nil end
		local view: any = deepCopyTable(saved)
		if typeof(view.SystemSettings) ~= "table" then view.SystemSettings = {} end
		view.SystemSettings.UseDefaultGameSettings = false
		return view
	end
	local function applyPreview(targetUsd: boolean)
		local view = if targetUsd then buildForcedView() else buildSavedView()
		if not view then
			-- Still in flight from cold open, block and retry unless the user moved on
			task.spawn(function()
				clientUser.everyone:fetchAsync("SavedGameSettings")
				clientUser.everyone:fetchAsync("DefaultGameSettings")
				if destroyed then return end
				local stillNeedsThisTarget = (Fusion.peek(localUseDefaultGameSettings) == true) == targetUsd
				local stillDiverged = (Fusion.peek(localUseDefaultGameSettings) == true)
					~= (Fusion.peek(useDefaultGameSettingsFuse) == true)
				if not (stillNeedsThisTarget and stillDiverged) then return end
				applyPreview(targetUsd)
			end)
			return
		end
		previewIsOurWrite = true
		clientUser.everyone:set("GameSettings", view)
		previewIsOurWrite = false
	end
	local function startPreview()
		if previewSnapshot ~= nil then return end
		previewSnapshot = clientUser.everyone:get("GameSettings")
		applyPreview(Fusion.peek(localUseDefaultGameSettings) == true)
	end
	local function endPreview(restore: boolean)
		if previewSnapshot == nil then return end
		if restore then
			previewIsOurWrite = true
			clientUser.everyone:set("GameSettings", previewSnapshot)
			previewIsOurWrite = false
		end
		previewSnapshot = nil
	end
	-- Another admin can commit mid-preview, adopt the new snapshot and re-apply
	local previewWatcher = (scope :: any):Fuse("everyone", "GameSettings")
	scope:Observer(previewWatcher):onChange(function()
		if previewIsOurWrite then return end
		if previewSnapshot == nil then return end
		previewSnapshot = Fusion.peek(previewWatcher)
		applyPreview(Fusion.peek(localUseDefaultGameSettings) == true)
	end)
	scope:Observer(localUseDefaultGameSettings):onChange(function()
		if destroyed then return end
		local localVal = Fusion.peek(localUseDefaultGameSettings) == true
		local serverVal = Fusion.peek(useDefaultGameSettingsFuse) == true
		if localVal ~= serverVal then
			if previewSnapshot == nil then
				startPreview()
			else
				applyPreview(localVal)
			end
		else
			endPreview(true)
		end
	end)

	local toggleDirtyFlag: Fusion.Value<boolean> = scope:Value(false)
	local activeHasPendingChanges = scope:Computed(function(use)
		local active = use(activeTab)
		local controller = use(tabControllers[active])
		local controllerPending = if controller then use(controller.hasPendingChanges) else false
		if active == 2 then
			if use(toggleDirtyFlag) then return true end
		end
		return controllerPending
	end)

	local function callActiveConfirm()
		local active = Fusion.peek(activeTab)
		local controller = Fusion.peek(tabControllers[active])
		if controller then controller.confirmChanges() end
		if active == 2 and userDirtiedToggle then
			local newValue = Fusion.peek(localUseDefaultGameSettings)
			task.spawn(function()
				(changeGameSetting :: any):invokeServerAsync(
					{"SystemSettings", "UseDefaultGameSettings"},
					newValue
				)
			end)
			-- Clear without restoring, the server's replication overwrites our forced view
			endPreview(false)
			userDirtiedToggle = false
			toggleDirtyFlag:set(false)
		end
	end

	local function callActiveUndo()
		local active = Fusion.peek(activeTab)
		local controller = Fusion.peek(tabControllers[active])
		if controller then controller.undoChanges() end
		if active == 2 then
			userDirtiedToggle = false
			toggleDirtyFlag:set(false)
			localUseDefaultGameSettings:set(Fusion.peek(useDefaultGameSettingsFuse) == true)
		end
	end

	if panelClosed then
		scope:Observer(panelClosed):onChange(function()
			if destroyed then return end
			if Fusion.peek(panelClosed) == true then
				for _, controllerRef in tabControllers do
					local controller = Fusion.peek(controllerRef)
					if controller then controller.undoChanges() end
				end
				-- Also revert the USD preview so local-only state can't leak across sessions
				localUseDefaultGameSettings:set(Fusion.peek(useDefaultGameSettingsFuse) == true)
			end
		end)
	end

	-- Saved per-player overrides stay in perm and reactivate when CanChangeX flips back on
	local canChangeYouTheme = (scope :: any):Fuse("everyone",
		{"GameSettings", "SystemSettings", "CanChangeYouSettingsTheme"})
	local canChangeYouPrimaryColor = (scope :: any):Fuse("everyone",
		{"GameSettings", "SystemSettings", "CanChangeYouSettingsPrimaryColor"})
	local canChangeYouFont = (scope :: any):Fuse("everyone",
		{"GameSettings", "SystemSettings", "CanChangeYouSettingsFont"})
	local canChangeYouPrefix = (scope :: any):Fuse("everyone",
		{"GameSettings", "SystemSettings", "CanChangeYouSettingsPrefix"})
	local canChangeYouContentScale = (scope :: any):Fuse("everyone",
		{"GameSettings", "SystemSettings", "CanChangeYouSettingsContentScale"})
	local canChangeYouMenuHeight = (scope :: any):Fuse("everyone",
		{"GameSettings", "SystemSettings", "CanChangeYouSettingsMenuHeight"})
	local canChangeYouVolume = (scope :: any):Fuse("everyone",
		{"GameSettings", "SystemSettings", "CanChangeYouSettingsVolume"})
	local canChangeYouPitch = (scope :: any):Fuse("everyone",
		{"GameSettings", "SystemSettings", "CanChangeYouSettingsPitch"})
	-- Theme-level locks take priority, and hiddenByTitle overrides the per-row
	-- lockSetting check so both conditions OR together here
	local youThemeRowHidden = scope:Computed(function(use)
		return use(canChangeYouTheme) == false
	end)
	local youPrimaryColorRowHidden = scope:Computed(function(use)
		if use(canChangeYouPrimaryColor) == false then return true end
		if use(Theme.Settings.LockPrimaryColor) == true then return true end
		return false
	end)
	local youFontRowHidden = scope:Computed(function(use)
		if use(canChangeYouFont) == false then return true end
		if use(Theme.Settings.LockFont) == true then return true end
		return false
	end)
	local youPrefixRowHidden = scope:Computed(function(use)
		return use(canChangeYouPrefix) == false
	end)
	local youContentScaleRowHidden = scope:Computed(function(use)
		return use(canChangeYouContentScale) == false
	end)
	local youMenuHeightRowHidden = scope:Computed(function(use)
		return use(canChangeYouMenuHeight) == false
	end)
	local youVolumeRowHidden = scope:Computed(function(use)
		return use(canChangeYouVolume) == false
	end)
	local youPitchRowHidden = scope:Computed(function(use)
		return use(canChangeYouPitch) == false
	end)
	-- With every CanChange flag off the You tab has nothing to show
	local allYouRowsHidden = scope:Computed(function(use)
		return use(canChangeYouTheme) == false
			and use(canChangeYouPrimaryColor) == false
			and use(canChangeYouFont) == false
			and use(canChangeYouContentScale) == false
			and use(canChangeYouMenuHeight) == false
			and use(canChangeYouPrefix) == false
			and use(canChangeYouVolume) == false
			and use(canChangeYouPitch) == false
	end)

	local function buildContentWithRestore(innerScope: Fusion.Scope, tabIdx: number, settingsList: any, locked: Fusion.UsedAs<boolean>?): any
		local baseColor = Theme.Color.Neutral
		local textColor = Theme.Color.BaseContent
		local isHovered: Fusion.Value<boolean> = innerScope:Value(false)
		local isPressed: Fusion.Value<boolean> = innerScope:Value(false)
		local function isLockedValue(use: any): boolean
			if locked == nil then return false end
			return use(locked :: any) == true
		end
		local buttonColor = innerScope:Computed(function(use)
			local base = use(baseColor) :: Color3
			local luminance = 0.299 * base.R + 0.587 * base.G + 0.114 * base.B
			local tint = if luminance > 0.5 then Color3.new(0, 0, 0) else Color3.new(1, 1, 1)
			if isLockedValue(use) then return base end
			if use(isPressed) then
				return base:Lerp(tint, 0.20)
			elseif use(isHovered) then
				return base:Lerp(tint, 0.10)
			end
			return base
		end)
		local labelTransparency = innerScope:Computed(function(use)
			return if isLockedValue(use) then 0.65 else 0
		end)
		local interactable = innerScope:Computed(function(use)
			return not isLockedValue(use)
		end)
		local restoreButton = Pressable(innerScope, {
			name = "RestoreDefaultsButton",
			size = UDim2.new(1, 0, 0, 38),
			backgroundColor = buttonColor,
			layoutOrder = 2,
			interactable = interactable,
			onHoverChanged = function(hovered) isHovered:set(hovered) end,
			onPressChanged = function(pressed) isPressed:set(pressed) end,
			onActivate = function()
				if locked ~= nil and Fusion.peek(locked :: any) == true then return end
				local controller = Fusion.peek(tabControllers[tabIdx])
				if controller and controller.restoreDefaults then
					controller.restoreDefaults()
				end
			end,
			[Children] = {
				innerScope:New "UICorner" { CornerRadius = UDim.new(0, 9) },
				innerScope:New "UIStroke" {
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					Color = Color3.new(1, 1, 1),
					[Children] = {
						innerScope:New "UIGradient" {
							Color = innerScope:Computed(function(use)
								local base = use(baseColor) :: Color3
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
				innerScope:New "Frame" {
					Name = "Content",
					AnchorPoint = Vector2.new(0.5, 0.5),
					AutomaticSize = Enum.AutomaticSize.X,
					BackgroundTransparency = 1,
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.new(0, 0, 1, 0),
					[Children] = {
						innerScope:New "UIListLayout" {
							FillDirection = Enum.FillDirection.Horizontal,
							HorizontalAlignment = Enum.HorizontalAlignment.Center,
							VerticalAlignment = Enum.VerticalAlignment.Center,
							Padding = UDim.new(0, 6),
							SortOrder = Enum.SortOrder.LayoutOrder,
						},
						innerScope:New "TextLabel" {
							Name = "Label",
							AutomaticSize = Enum.AutomaticSize.X,
							BackgroundTransparency = 1,
							FontFace = innerScope:Computed(function(use)
								return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
							end),
							LayoutOrder = 2,
							Size = UDim2.new(0, 0, 1, 0),
							Text = "Restore Defaults",
							TextColor3 = textColor,
							TextSize = innerScope:Computed(function(use)
								return math.round(17 * (use(Theme.Layout.ContentScale) :: number))
							end),
							TextTransparency = labelTransparency,
							TextTruncate = Enum.TextTruncate.SplitWord,
							TextXAlignment = Enum.TextXAlignment.Center,
							TextYAlignment = Enum.TextYAlignment.Center,
						},
					},
				},
			},
		})
		local dangerZone = innerScope:New "Frame" {
			Name = "DangerZone",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = 2,
			Size = UDim2.fromScale(1, 0),
			[Children] = {
				innerScope:New "UIListLayout" {
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Left,
					Padding = UDim.new(0, 0),
					SortOrder = Enum.SortOrder.LayoutOrder,
				},
				innerScope:New "TextLabel" {
					Name = "Heading",
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundTransparency = 1,
					FontFace = innerScope:Computed(function(use)
						return Font.new(use(Theme.Font.Heading), use(Theme.FontWeight.Heading))
					end),
					LayoutOrder = 1,
					Text = "Danger Zone",
					TextColor3 = Theme.Color.BaseContent,
					TextSize = Theme.TextSize.Title,
					TextXAlignment = Enum.TextXAlignment.Left,
				},
				innerScope:New "Frame" {
					Name = "DividerWrap",
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					LayoutOrder = 2,
					Size = UDim2.new(1, 0, 0, 0),
					[Children] = {
						innerScope:New "UIPadding" {
							PaddingTop = UDim.new(0, 6),
							PaddingBottom = UDim.new(0, 4),
						},
						innerScope:New "Frame" {
							Name = "Divider",
							BackgroundColor3 = Theme.Color.NeutralContent,
							Size = UDim2.new(1, 0, 0, 1),
						},
					},
				},
				innerScope:New "Frame" {
					Name = "Rows",
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					LayoutOrder = 3,
					Size = UDim2.fromScale(1, 0),
					[Children] = {
						innerScope:New "UIPadding" { PaddingTop = UDim.new(0, 6) },
						restoreButton,
					},
				},
			},
		}

		-- LayoutOrder set directly, wrapping in another auto-size Frame broke canvas sizing
		local settingsListInstance: Instance = settingsList :: any
		settingsListInstance.LayoutOrder = 1
		return innerScope:New "Frame" {
			Name = "TabContentStack_" .. tostring(tabIdx),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 0),
			[Children] = {
				innerScope:New "UIListLayout" {
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					Padding = UDim.new(0, 18),
					SortOrder = Enum.SortOrder.LayoutOrder,
				},
				settingsList,
				dangerZone,
			},
		}
	end

	local function buildTabContent(innerScope: Fusion.Scope, tabIdx: number): any
		local settingsData = TAB_SETTINGS[tabIdx]
		if tabIdx == 1 then
			-- Fetched fresh per click, defaults may have changed since the panel opened
			local function getYouDefaults(): any
				local success, result = (getDefaultYouSettings :: any):invokeServerAsync()
				if success and typeof(result) == "table" then
					return result
				end
				return nil
			end
			local settingsList = SettingsList(innerScope, {
				settingsData = settingsData,
				stateSource = "perm",
				onItemSelectorOpen = onItemSelectorOpen,
				onChangeRemote = changeYouSetting,
				getDefaults = getYouDefaults,
				hiddenByTitle = {
					Theme = youThemeRowHidden,
					["Primary Color"] = youPrimaryColorRowHidden,
					Font = youFontRowHidden,
					["Content Scale"] = youContentScaleRowHidden,
					["Menu Height"] = youMenuHeightRowHidden,
					Prefix = youPrefixRowHidden,
					["SFX Volume"] = youVolumeRowHidden,
					["Music Volume"] = youVolumeRowHidden,
					["Cmd Volume"] = youVolumeRowHidden,
					["SFX Pitch"] = youPitchRowHidden,
					["Music Pitch"] = youPitchRowHidden,
					["Cmd Pitch"] = youPitchRowHidden,
				},
				noScroll = true,
				controllerRef = tabControllers[tabIdx],
			})
			local regularContent = buildContentWithRestore(innerScope, tabIdx, settingsList)
			local regularSize = innerScope:Computed(function(use)
				return if use(allYouRowsHidden) then UDim2.new() else UDim2.fromScale(1, 0)
			end)
			local regularAutoSize = innerScope:Computed(function(use)
				return if use(allYouRowsHidden) then Enum.AutomaticSize.None else Enum.AutomaticSize.Y
			end)
			local regularVisible = innerScope:Computed(function(use)
				return use(allYouRowsHidden) ~= true
			end)
			local placeholderVisible = innerScope:Computed(function(use)
				return use(allYouRowsHidden) == true
			end)
			return innerScope:New "Frame" {
				Name = "YouTabContent",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 0),
				[Children] = {
					innerScope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Vertical,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						SortOrder = Enum.SortOrder.LayoutOrder,
					},
					innerScope:New "Frame" {
						Name = "RegularWrap",
						AutomaticSize = regularAutoSize,
						BackgroundTransparency = 1,
						LayoutOrder = 1,
						Size = regularSize,
						Visible = regularVisible,
						[Children] = { regularContent },
					},
					innerScope:New "TextLabel" {
						Name = "EmptyPlaceholder",
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						FontFace = innerScope:Computed(function(use)
							return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
						end),
						LayoutOrder = 2,
						Size = UDim2.fromScale(1, 0),
						Text = "This game has hidden its settings",
						TextColor3 = Theme.Color.NeutralContentDark,
						TextSize = Theme.TextSize.Subtitle,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Center,
						Visible = placeholderVisible,
						[Children] = {
							innerScope:New "UIPadding" {
								PaddingTop = UDim.new(0, 24),
								PaddingBottom = UDim.new(0, 24),
							},
						},
					},
				},
			}
		end
		-- The Game user's perm.Settings is the source of truth, replicated to everyone.GameSettings
		local function getGameDefaults(): any
			-- DefaultGameSettings is already filled in, so this is a sync read
			local defaultRoot = clientUser.everyone:get("DefaultGameSettings")
			if typeof(defaultRoot) ~= "table" then return nil end
			local out: {[string]: {[string]: any}} = {}
			for _, category in settingsData do
				local headingDefaults: {[string]: any} = {}
				for _, obj in category.objects do
					-- DefaultGameSettings drops the leading "GameSettings" segment, so skip it
					local value: any = defaultRoot
					for index = 2, #obj.settingPath do
						if typeof(value) ~= "table" then
							value = nil
							break
						end
						value = (value :: any)[obj.settingPath[index]]
					end
					headingDefaults[obj.title] = value
				end
				out[category.heading] = headingDefaults
			end
			return out
		end
		local settingsList = SettingsList(innerScope, {
			settingsData = settingsData,
			stateSource = "everyone",
			onItemSelectorOpen = onItemSelectorOpen,
			onChangeRemote = changeGameSetting,
			-- The banner toggles own the UseDefault* rows, the list shouldn't render them
			hiddenByTitle = {
				UseDefaultRoles = true,
				UseDefaultGameSettings = true,
			},
			-- The pathway is relative to gameUser.perm.Settings, so strip the leading "GameSettings"
			changeRemoteArgsBuilder = function(info: any)
				local pathway = table.clone(info.settingPath)
				table.remove(pathway, 1)
				return pathway, info.intendedValue
			end,
			getDefaults = getGameDefaults,
			lockRule = function(ctx: any)
				if ctx.obj.title == "MinimumAccountAge" then
					local shouldKickValue = ctx.valueByTitle["EnableMinimumAccountAge"]
					if shouldKickValue then
						return scope:Computed(function(use)
							if use(useDefaultsLive) == true then return true end
							return use(shouldKickValue) ~= true
						end)
					end
				end
				return useDefaultsLive
			end,
			contentLocked = useDefaultsLive,
			noScroll = true,
			controllerRef = tabControllers[tabIdx],
		})

		local function toggleUseDefaultGameSettings()
			local newLocal = not Fusion.peek(localUseDefaultGameSettings)
			local serverVal = Fusion.peek(useDefaultGameSettingsFuse) == true
			-- Toggling back to match the server cancels the pending toggle
			userDirtiedToggle = newLocal ~= serverVal
			toggleDirtyFlag:set(userDirtiedToggle)
			localUseDefaultGameSettings:set(newLocal)
		end
		local toggleHovered: Fusion.Value<boolean> = innerScope:Value(false)
		local togglePressed: Fusion.Value<boolean> = innerScope:Value(false)
		local trackColor = innerScope:Computed(function(use)
			local base = if use(localUseDefaultGameSettings)
				then use(Theme.Color.Primary) else use(Theme.Color.NeutralContent)
			local lum = 0.299 * base.R + 0.587 * base.G + 0.114 * base.B
			local tint = if lum > 0.5 then Color3.new(0, 0, 0) else Color3.new(1, 1, 1)
			if use(togglePressed) then return base:Lerp(tint, 0.20)
			elseif use(toggleHovered) then return base:Lerp(tint, 0.10) end
			return base
		end)
		local useDefaultsRow = innerScope:New "Frame" {
			Name = "UseDefaultsRow",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = 0,
			Size = UDim2.fromScale(1, 0),
			[Children] = {
				innerScope:New "Frame" {
					Name = "UseDefaultsLabel",
					BackgroundColor3 = Theme.Color.Neutral,
					Size = UDim2.new(1, 0, 0, 38),
					[Children] = {
						innerScope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
						innerScope:New "UIStroke" {
							ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
							Color = Theme.Color.NeutralStroke,
						},
						innerScope:New "UIPadding" {
							PaddingLeft = UDim.new(0, 12),
							PaddingRight = UDim.new(0, 8),
						},
						innerScope:New "UIListLayout" {
							FillDirection = Enum.FillDirection.Horizontal,
							VerticalAlignment = Enum.VerticalAlignment.Center,
							HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
							SortOrder = Enum.SortOrder.LayoutOrder,
						},
						innerScope:New "TextLabel" {
							Name = "Label",
							AutomaticSize = Enum.AutomaticSize.XY,
							BackgroundTransparency = 1,
							FontFace = innerScope:Computed(function(use)
								return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Regular))
							end),
							LayoutOrder = 1,
							Text = "Use Studio Defaults",
							TextColor3 = Theme.Color.NeutralContentDark,
							TextSize = Theme.TextSize.Subtitle,
						},
						Pressable(innerScope, {
							name = "UseDefaultsToggle",
							size = UDim2.fromOffset(48, 26),
							layoutOrder = 2,
							onActivate = toggleUseDefaultGameSettings,
							onHoverChanged = function(hovered) toggleHovered:set(hovered) end,
							onPressChanged = function(pressed) togglePressed:set(pressed) end,
							[Children] = {
								innerScope:New "Frame" {
									Name = "Track",
									BackgroundColor3 = trackColor,
									Size = UDim2.fromScale(1, 1),
									[Children] = {
										innerScope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
										innerScope:New "Frame" {
											Name = "Thumb",
											AnchorPoint = Vector2.new(0, 0.5),
											BackgroundColor3 = Color3.new(1, 1, 1),
											Position = innerScope:Spring(innerScope:Computed(function(use)
												return if use(localUseDefaultGameSettings)
													then UDim2.new(1, -22, 0.5, 0)
													else UDim2.new(0, 4, 0.5, 0)
											end), 40, 1),
											Size = UDim2.fromOffset(16, 16),
											ZIndex = 2,
											[Children] = {
												innerScope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
											},
										},
									},
								},
							},
						}),
					},
				},
			},
		}

		local gameTabContent = innerScope:New "Frame" {
			Name = "GameTabContent",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 0),
			[Children] = {
				innerScope:New "UIListLayout" {
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					Padding = UDim.new(0, 18),
					SortOrder = Enum.SortOrder.LayoutOrder,
				},
				useDefaultsRow,
				(function()
					local sl: Instance = settingsList :: any
					sl.LayoutOrder = 1
					return settingsList
				end)(),
			},
		}
		return buildContentWithRestore(innerScope, tabIdx, gameTabContent, useDefaultsLive)
	end

	-- Shared with TabbedScroller's footerHeight so the scroll area resizes in sync
	local confirmBarHeight: any = scope:Spring(scope:Computed(function(use)
		return if use(activeHasPendingChanges) then 54 else 0
	end), 40, 1)

	local confirmBar = scope:New "Frame" {
		Name = "ConfirmBarWrap",
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		Size = UDim2.fromScale(1, 1),

		[Children] = {
			scope:New "Frame" {
				Name = "ConfirmBar",
				AnchorPoint = Vector2.new(0, 0.5),
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundColor3 = Theme.Color.Neutral,
				Position = UDim2.new(0, 2, 0.5, 0),
				Size = UDim2.new(1, -7, 0, -2),

				[Children] = {
					scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
					scope:New "UIStroke" {
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Color = Theme.Color.NeutralContent,
					},
					scope:New "UIPadding" {
						PaddingBottom = UDim.new(0, 14),
						PaddingLeft = UDim.new(0, 12),
						PaddingRight = UDim.new(0, 4),
						PaddingTop = UDim.new(0, 14),
					},

					scope:New "Frame" {
						Name = "LabelGroup",
						AnchorPoint = Vector2.new(0, 0.5),
						AutomaticSize = Enum.AutomaticSize.XY,
						BackgroundTransparency = 1,
						Position = UDim2.fromScale(0, 0.5),
						[Children] = {
							scope:New "UIListLayout" {
								FillDirection = Enum.FillDirection.Horizontal,
								SortOrder = Enum.SortOrder.LayoutOrder,
								VerticalAlignment = Enum.VerticalAlignment.Center,
							},
							scope:New "TextLabel" {
								Name = "Label",
								AutomaticSize = Enum.AutomaticSize.XY,
								BackgroundTransparency = 1,
								FontFace = scope:Computed(function(use)
									return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
								end),
								Text = "Confirm?",
								TextColor3 = Theme.Color.BaseContent,
								TextSize = Theme.TextSize.Subtitle,
							},
						},
					},

					scope:New "Frame" {
						Name = "ButtonGroup",
						AnchorPoint = Vector2.new(1, 0.5),
						AutomaticSize = Enum.AutomaticSize.XY,
						BackgroundTransparency = 1,
						Position = UDim2.fromScale(1, 0.5),
						[Children] = {
							scope:New "UIListLayout" {
								FillDirection = Enum.FillDirection.Horizontal,
								HorizontalFlex = Enum.UIFlexAlignment.None,
								Padding = UDim.new(0, 6),
								SortOrder = Enum.SortOrder.LayoutOrder,
								VerticalAlignment = Enum.VerticalAlignment.Center,
							},

							Pressable(scope, {
								name = "ConfirmButton",
								size = UDim2.new(0, 0, 0, 0),
								automaticSize = Enum.AutomaticSize.XY,
								backgroundColor = Theme.Color.Primary,
								layoutOrder = 1,
								onActivate = callActiveConfirm,
								[Children] = {
									scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
									scope:New "UIPadding" {
										PaddingBottom = UDim.new(0, 7),
										PaddingLeft = UDim.new(0, 12),
										PaddingRight = UDim.new(0, 12),
										PaddingTop = UDim.new(0, 7),
									},
									scope:New "TextLabel" {
										Name = "Label",
										AutomaticSize = Enum.AutomaticSize.XY,
										BackgroundTransparency = 1,
										FontFace = scope:Computed(function(use)
											return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
										end),
										Text = "Confirm",
										TextColor3 = Theme.Color.PrimaryContent,
										TextSize = Theme.TextSize.Subtitle,
									},
								},
							}),

							Pressable(scope, {
								name = "UndoButton",
								size = UDim2.new(0, 0, 0, 0),
								automaticSize = Enum.AutomaticSize.XY,
								backgroundColor = Theme.Color.NeutralContent,
								layoutOrder = 2,
								onActivate = callActiveUndo,
								[Children] = {
									scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
									scope:New "UIPadding" {
										PaddingBottom = UDim.new(0, 7),
										PaddingLeft = UDim.new(0, 12),
										PaddingRight = UDim.new(0, 12),
										PaddingTop = UDim.new(0, 7),
									},
									scope:New "TextLabel" {
										Name = "Label",
										AutomaticSize = Enum.AutomaticSize.XY,
										BackgroundTransparency = 1,
										FontFace = scope:Computed(function(use)
											return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
										end),
										Text = "Undo",
										TextColor3 = Theme.Color.BaseContent,
										TextSize = Theme.TextSize.Subtitle,
									},
								},
							}),
						},
					},
				},
			},
		},
	}

	return scope:New "Frame" {
		Name = "SettingsPage",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),

		[Children] = {
			TabbedScroller(scope, {
				tabs = TAB_DEFS,
				activeTabRef = activeTab,
				buildTabContent = function(innerScope: Fusion.Scope, tabIdx: number): any
					local canView = canViewByTab[tabIdx]
					local body = buildTabContent(innerScope, tabIdx)
					return innerScope:New "Frame" {
						Name = "TabGate_" .. tabIdx,
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1),
						AutomaticSize = Enum.AutomaticSize.Y,
						[Children] = {
							innerScope:New "Frame" {
								Name = "Body",
								BackgroundTransparency = 1,
								Size = UDim2.fromScale(1, 1),
								AutomaticSize = Enum.AutomaticSize.Y,
								Visible = canView,
								[Children] = { body },
							},
							innerScope:New "Frame" {
								Name = "Denied",
								BackgroundTransparency = 1,
								Size = UDim2.new(1, 0, 0, 160),
								Visible = innerScope:Computed(function(use): boolean
									return not use(canView)
								end),
								[Children] = {
									NoPermissionPlaceholder(innerScope, {}),
								},
							},
						},
					}
				end,
				footerSlot = confirmBar,
				footerHeight = confirmBarHeight,
			}),
		},
	}
end
