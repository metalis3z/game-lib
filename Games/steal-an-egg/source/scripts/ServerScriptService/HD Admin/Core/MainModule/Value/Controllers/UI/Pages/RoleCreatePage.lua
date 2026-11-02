--!strict


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local State = require(modules.Objects.State)
local DEFAULT_ROLE = require(modules.References.defaultRole)
local deepCopyTable = require(modules.TableUtil.deepCopyTable)
local SettingsList = require(frontend.Components.SettingsList)
local SettingsRole = require(frontend.Config.SettingsRole)
local RoleLockRules = require(frontend.Config.RoleLockRules)
local Pressable = require(frontend.Components.Pressable)
local DataPopup = require(frontend.Components.DataPopup)
local serializeRole = require(frontend.Util.SerializeRole)
local parseRole = require(frontend.Util.ParseRole)
local Remote = require(modules.Objects.Remote)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	onItemSelectorOpen: any?,
	panelClosed: UsedAs<boolean>?,
	idle: UsedAs<boolean>?, -- false while this page is active; reset on each open
	onCreated: ((newRoleKey: string) -> ())?, -- fired after successful CreateRole
	onCancel: (() -> ())?, -- fired when user clicks Cancel
}


-- ADDITIONAL
-- Per-field hiding keeps the About Data row while key/rank (auto-generated) and
-- useDefaults (studio-backed roles only) don't apply on Create
local HIDDEN_TITLES: {[string]: true} = { key = true, rank = true, useDefaults = true }


-- COMPONENT
return function(scope: Scope, props: Props)
	local filteredSettings: {any} = {}
	for _, category in SettingsRole :: any do
		local keptObjects: {any} = {}
		for _, obj in category.objects do
			if typeof(obj.title) == "string" and HIDDEN_TITLES[obj.title] then continue end
			table.insert(keptObjects, obj)
		end
		if #keptObjects == 0 then continue end
		table.insert(filteredSettings, {
			heading = category.heading,
			objects = keptObjects,
		})
	end

	-- Seeded with the full DEFAULT_ROLE template. Name is blanked so the user
	-- must provide one before Create enables
	local function buildSeed(): {[string]: any}
		local seed = deepCopyTable(DEFAULT_ROLE) :: any
		seed.name = ""
		seed.key = nil
		seed.rank = nil
		seed.useDefaults = nil
		return seed
	end
	local scratchState = State.new(false, buildSeed())

	-- Same shared RoleLockRules as RoleSettingsPage, with no useDefaults gating on Create
	local lockRule = function(ctx: any)
		local title: string = ctx.obj.title
		if typeof(title) ~= "string" then return nil end
		local rules = RoleLockRules.getRulesFor(title)
		if #rules == 0 then return nil end
		local vbt = ctx.valueByTitle
		return scope:Computed(function(use)
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

	local inFlight: Fusion.Value<boolean> = scope:Value(false)
	local errorMessage: Fusion.Value<string> = scope:Value("")
	local nameFused: Fusion.Value<any> = (scope :: any):Fuse(scratchState, "name")
	local canConfirm: Fusion.Computed<boolean> = scope:Computed(function(use)
		if use(inFlight) then return false end
		local name = use(nameFused)
		return typeof(name) == "string" and (name :: string):gsub("%s", "") ~= ""
	end)

	local rootFrame = scope:New "Frame" {
		Name = "RoleCreatePage",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
	}

	local controllerRef: Fusion.Value<any> = scope:Value(nil :: any)

	local function confirmCreate()
		if not Fusion.peek(canConfirm) then return end
		inFlight:set(true)
		errorMessage:set("")
		task.spawn(function()
			local payload = scratchState:getAll()
			local createRoleRemote = Remote.get("CreateRole")
			local ok, result = (createRoleRemote :: any):invokeServerAsync(payload)
			inFlight:set(false)
			if ok then
				if props.onCreated then
					props.onCreated(tostring(result))
				end
			else
				local msg = tostring(result or "Failed to create role")
				errorMessage:set(msg)
				local Prompt = require(modules.Prompt)
				Prompt.warn(msg)
			end
		end)
	end

	-- In a footerSlot so it scrolls with the form and sits beneath the last category
	local function buildActions(): Instance
		local cancelButton = Pressable(scope, {
			name = "CancelButton",
			size = UDim2.fromOffset(96, 34),
			backgroundColor = Theme.Color.Neutral,
			onActivate = function()
				if Fusion.peek(inFlight) then return end
				if props.onCancel then props.onCancel() end
			end,
			layoutOrder = 1,
			[Children] = {
				scope:New "UICorner" {
					CornerRadius = scope:Computed(function(use)
						return UDim.new(0, use(Theme.Layout.CornerRadius) :: number)
					end),
				},
				scope:New "UIStroke" {
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					Color = Theme.Color.NeutralStroke,
				},
				scope:New "TextLabel" {
					Name = "Label",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					FontFace = scope:Computed(function(use)
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
		})

		local createButton = Pressable(scope, {
			name = "CreateButton",
			size = UDim2.fromOffset(140, 34),
			backgroundColor = scope:Computed(function(use)
				return if use(canConfirm)
					then use(Theme.Color.Primary)
					else (use(Theme.Color.Primary) :: Color3):Lerp(Color3.new(0, 0, 0), 0.3)
			end),
			interactable = canConfirm,
			onActivate = confirmCreate,
			layoutOrder = 2,
			[Children] = {
				scope:New "UICorner" {
					CornerRadius = scope:Computed(function(use)
						return UDim.new(0, use(Theme.Layout.CornerRadius) :: number)
					end),
				},
				scope:New "UIStroke" {
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					Color = Theme.Color.NeutralStroke,
				},
				scope:New "TextLabel" {
					Name = "Label",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					FontFace = scope:Computed(function(use)
						return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
					end),
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.fromScale(1, 1),
					Text = scope:Computed(function(use)
						return if use(inFlight) then "Creating..." else "Create"
					end),
					TextColor3 = Theme.Color.PrimaryContent,
					TextSize = Theme.TextSize.Body,
					TextXAlignment = Enum.TextXAlignment.Center,
					TextYAlignment = Enum.TextYAlignment.Center,
					TextTransparency = scope:Computed(function(use)
						return if use(canConfirm) then 0 else 0.35
					end),
				},
			},
		})

		return scope:New "Frame" {
			Name = "ActionsRow",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 0),
			[Children] = {
				scope:New "UIPadding" {
					PaddingTop = UDim.new(0, 18),
				},
				scope:New "UIListLayout" {
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = scope:Computed(function(use) return UDim.new(0, use(Theme.Layout.Padding) :: number) end),
				},
				cancelButton,
				createButton,
			},
		}
	end

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
		local snapshot = scratchState:getAll()
		local copyText = serializeRole(snapshot)
		local popup = DataPopup(popupScope, {
			visible = visible,
			copyText = copyText,
			onClose = function() closeDataPopup() end,
			onLoad = function(pasted: string): (boolean, string)
				local ok, resultOrErr, count = parseRole(pasted)
				if not ok then
					return false, "Failed loading data, please re-write"
				end
				local parsed = resultOrErr :: {[string]: any}
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

	local sl = SettingsList(scope, {
		settingsData = filteredSettings,
		stateSource = scratchState :: any,
		pathPrefix = nil, -- no prefix; settingPath maps directly into the scratch state
		onItemSelectorOpen = props.onItemSelectorOpen,
		-- No onChangeRemote, edits stay local in scratchState until Create is pressed
		panelClosed = props.panelClosed,
		controllerRef = controllerRef,
		undoOnDestroy = false,
		hideConfirmBar = true, -- our own Cancel/Create row replaces the ConfirmBar
		footerSlot = buildActions(),
		lockRule = lockRule,
		objectOverrides = { data = { onActivate = openDataPopup } },
	})
	;(sl :: any).Parent = rootFrame
	table.insert(scope :: any, closeDataPopup)

	-- Observer:onChange doesn't fire on the initial value, so the first open uses
	-- the constructor seed and later opens reset
	if props.idle ~= nil then
		scope:Observer(props.idle :: any):onChange(function()
			if Fusion.peek(props.idle :: any) == true then return end
			scratchState:setAll(buildSeed())
			inFlight:set(false)
			errorMessage:set("")
			local controller = Fusion.peek(controllerRef)
			if controller and controller.scrollToTop then
				controller.scrollToTop()
			end
		end)
	end

	table.insert(scope :: any, function()
		if scratchState and scratchState.destroy then
			scratchState:destroy()
		end
	end)

	return rootFrame
end
