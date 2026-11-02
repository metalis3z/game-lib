--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local CommandButton = require(frontend.Components.CommandButton)
local CopyPopup = require(frontend.Components.CopyPopup)
local Pressable = require(frontend.Components.Pressable)
local RoleBadge = require(frontend.Components.RoleBadge)
local Icons = require(frontend.Config.Icons)
local InputObjects = require(frontend.Config.InputObjects)
local ItemSelector = require(frontend.Components.ItemSelector)
local Args = require(modules.Parser.Args)
local Modifiers = require(modules.Parser.Modifiers)
local Parser = require(modules.Parser)
local ParserSettings = require(modules.Parser.ParserSettings)
local clientUser = require(modules.References.clientUser)
local everyone = clientUser.everyone
local Platform = require(frontend.Util.Platform)
local Permissions = require(frontend.Util.Permissions)
local ModifierUtil = require(frontend.Util.Cmdbar.ModifierUtil)
local Players = game:GetService("Players")


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	commandKey: Fusion.Value<string>, -- set by PanelGui before navigating here
	unlockRole: Fusion.Value<string?>?, -- the Commands page section that opened this run, so unlock invites match it
	activeCommands: Fusion.Value<{[string]: boolean}>?,
	onItemSelectorOpen: ((config: any) -> ())?, -- Forwarded to ItemSelector widgets so they can open the page
	sharedCustomUsers: Fusion.Value<{ [string]: any }>?, -- forwarded to ItemSelector widgets
	autoOpenUserArg: Fusion.Value<boolean>?, -- when true, the first players arg opens its picker on arrival (the + on Permanent Members / Bans)
	showRoles: UsedAs<boolean>?, -- the vet page sets this so the command's Commands page roles show under the title
	initialArgTokens: {string}?, -- raw chat tokens parsed into argVals on first bind; consumed once so later commandKey changes start blank
	initialModifierTokens: {string}?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local commandKey = props.commandKey

	local commandInfo: Fusion.Value<any?> = scope:Value(nil)
	local destroyed = false
	table.insert(scope :: any, { Destroy = function() destroyed = true end })
	scope:Observer(commandKey):onBind(function()
		local key = Fusion.peek(commandKey)
		if key == "" then return end
		local cached = everyone:get("CommandInfo", key)
		if cached ~= nil then
			if not destroyed then
				commandInfo:set(cached)
			end
			return
		end
		task.spawn(function()
			local success, info = everyone:fetchAsync("CommandInfo", key)
			if not destroyed and success then
				commandInfo:set(info)
			end
		end)
	end)

	local seededModifiers = if props.initialModifierTokens
		then table.clone(props.initialModifierTokens)
		else {}
	local selectedModifiers: Fusion.Value<{string}> = scope:Value(seededModifiers)

	-- Consumed on the first bind so re-opening the same command doesn't re-seed
	local initialArgTokensConsumed = false

	-- The epoch modifiers tick the current time so the number is on hand for the capsule box
	local nowEpoch: Fusion.Value<number> = scope:Value(os.time())
	task.spawn(function()
		while not destroyed do
			task.wait(1)
			if not destroyed then
				nowEpoch:set(os.time())
			end
		end
	end)

	local function modifierPickerGetter(): { ItemSelector.PickerItem }
		local all = Modifiers.getAll()
		local result: { any } = {}
		for key, detail in all do
			local modifierDetail = detail :: any
			if modifierDetail.aliasOf then continue end
			if typeof(modifierDetail.displayOrder) ~= "number" then continue end
			if not Permissions.canUseModifierNow(modifierDetail) then continue end
			-- Bare perm is turned down on per-player commands, offering it would only earn a rejection
			if ModifierUtil.isRejectedOn(key, Fusion.peek(commandInfo)) then continue end
			local body: any = modifierDetail.description
			if modifierDetail.configurable == "epochTime" then
				body = scope:Computed(function(use)
					return `{modifierDetail.description}. Epoch time now: {use(nowEpoch)}`
				end)
			end
			table.insert(result, {
				key = "modifier:" .. tostring(key):lower(),
				label = tostring(key),
				header = tostring(key),
				body = body,
				rawValue = tostring(key),
				category = "qualifier",
				configurable = modifierDetail.configurable,
				displayOrder = modifierDetail.displayOrder,
			})
		end
		table.sort(result, function(entryA: any, entryB: any)
			return entryA.displayOrder < entryB.displayOrder
		end)
		return result
	end

	-- Per-arg value cache keyed by "commandKey:argIndex", capped to LRU limit
	local MAX_CACHED_COMMANDS = 20
	local argValueCache: {[string]: Fusion.Value<any>} = {}
	-- Same keying, nil idle / true passed / false failed
	local argValidationStatusCache: {[string]: Fusion.Value<boolean?>} = {}
	local cachedCommandOrder: {string} = {}

	local argChangeCounter: Fusion.Value<number> = scope:Value(0)

	local function touchCommandCache(cmdKey: string)
		local idx = table.find(cachedCommandOrder, cmdKey)
		if idx then table.remove(cachedCommandOrder, idx) end
		table.insert(cachedCommandOrder, cmdKey)
		while #cachedCommandOrder > MAX_CACHED_COMMANDS do
			local evictKey = table.remove(cachedCommandOrder, 1) :: string
			for cacheKey in argValueCache do
				if cacheKey:match("^(.+):") == evictKey then
					argValueCache[cacheKey] = nil
					argValidationStatusCache[cacheKey] = nil
				end
			end
		end
	end

	local function getArgValidationStatus(cacheKey: string): Fusion.Value<boolean?>
		if not argValidationStatusCache[cacheKey] then
			argValidationStatusCache[cacheKey] = scope:Value(nil :: boolean?)
		end
		return argValidationStatusCache[cacheKey]
	end

	-- Must be called from Observer callbacks, not Computeds
	local function getArgValue(cacheKey: string, defaultVal: any): Fusion.Value<any>
		if not argValueCache[cacheKey] then
			local value = scope:Value(defaultVal)
			argValueCache[cacheKey] = value
			scope:Observer(value):onChange(function()
				local activeKey = Fusion.peek(commandKey)
				local argCmdKey = cacheKey:match("^(.+):")
				if activeKey ~= argCmdKey then return end
				task.defer(function()
					argChangeCounter:set(Fusion.peek(argChangeCounter) + 1)
				end)
			end)
		end
		return argValueCache[cacheKey]
	end

	type ArgConfigEntry = {
		inputType: string,
		inputConfig: any,
		argVal: Fusion.Value<any>,
		argKey: string,
		uiHidden: boolean,
		revealedBy: { dependsOn: string, equals: any?, equalsAny: {any}? }?,
		validationStatus: Fusion.Value<boolean?>?, -- set for args that run a text check
	}
	local argConfigs: Fusion.Value<{ArgConfigEntry}> = scope:Value({})

	scope:Observer(commandInfo):onBind(function()
		local info = Fusion.peek(commandInfo) :: any
		local key = Fusion.peek(commandKey) :: string
		if type(info) ~= "table" then
			argConfigs:set({})
			return
		end
		touchCommandCache(key)
		-- Switching commands can leave a now-rejected modifier selected, so it goes
		do
			local kept: {string} = {}
			local dropped = false
			for _, modifierName in Fusion.peek(selectedModifiers) do
				if ModifierUtil.isRejectedOn(modifierName, info) then
					dropped = true
				else
					table.insert(kept, modifierName)
				end
			end
			if dropped then
				selectedModifiers:set(kept)
			end
		end
		local argNames: {string} = (info :: any).args or {}
		local configs: {ArgConfigEntry} = {}
		local firstArgVal: Fusion.Value<any>? = nil
		local userArgAssigned = false
		for argIndex, argName in argNames do
			local argDetail = Args.get(argName :: any)
			if not argDetail then continue end
			local inputConfig = argDetail.inputObject
			if not inputConfig then continue end
			local inputType = inputConfig.inputType
			if not inputType then continue end
			local widgetDefaultVal = inputConfig.default
			-- allowEmpty fields start blank, so ignore the default inherited from the alias source
			if (inputConfig :: any).allowEmpty == true then
				widgetDefaultVal = nil
			end
			if widgetDefaultVal == nil and (argDetail :: any).playerArg == true then
				widgetDefaultVal = "me"
			end
			local cacheKey = key .. ":" .. argIndex
			local argVal = getArgValue(cacheKey, widgetDefaultVal)
			if argIndex == 1 then firstArgVal = argVal end
			local mergedConfig = table.clone(inputConfig) :: any
			mergedConfig.value = argVal
			mergedConfig.title = mergedConfig.title or (argDetail :: any).display or (argDetail :: any).key or tostring(argName)
			if inputType == "ItemSelector" then
				mergedConfig.onOpen = props.onItemSelectorOpen
				if (inputConfig :: any).canAnyUserBeAddedToPicker then
					mergedConfig.sharedCustomUsers = props.sharedCustomUsers
				end
				-- Not every user picker is flagged playerArg (the ban command's AnyUser
				-- isn't), so also catch the user and server-player pickers
				local isUserArg = (argDetail :: any).playerArg == true
					or (inputConfig :: any).canAnyUserBeAddedToPicker == true
					or (inputConfig :: any).displayServerPlayersInPicker == true
				if not userArgAssigned and isUserArg then
					userArgAssigned = true
					mergedConfig.autoOpen = props.autoOpenUserArg
				end
			end
			if (inputType == "TextInput" or inputType == "InputFields") and (inputConfig :: any).filterText then
				mergedConfig.firstArgValue = firstArgVal
			end
			local validationStatus: Fusion.Value<boolean?>? = nil
			local runsTextCheck = (inputType == "TextInput" and ((inputConfig :: any).filterText == true or (inputConfig :: any).mustBeStringSafe == true))
				or (inputType == "InputFields" and (inputConfig :: any).filterText == true)
			if runsTextCheck then
				validationStatus = getArgValidationStatus(cacheKey)
				mergedConfig.validationStatus = validationStatus
			end
			table.insert(configs, {
				inputType = inputType,
				inputConfig = mergedConfig,
				argVal = argVal,
				argKey = (argDetail :: any).key or tostring(argName),
				uiHidden = (argDetail :: any).uiHidden == true,
				revealedBy = (argDetail :: any).revealedBy,
				validationStatus = validationStatus,
			})
		end
		argConfigs:set(configs)

		-- Per-token failures stay silent, the slot keeps its default rather than break the UI
		if not initialArgTokensConsumed and props.initialArgTokens then
			initialArgTokensConsumed = true
			local tokens = props.initialArgTokens :: {string}
			local localPlayer = Players.LocalPlayer
			local localUserId = if localPlayer then localPlayer.UserId else 0
			for argIndex, argName in argNames do
				local token = tokens[argIndex]
				if typeof(token) ~= "string" or token == "" then continue end
				local argDetail = Args.get(argName :: any) :: any
				if not argDetail or typeof(argDetail.parse) ~= "function" then continue end
				local cacheKey = key .. ":" .. argIndex
				local argVal = argValueCache[cacheKey]
				if not argVal then continue end
				-- callerUserId lets player-qualifier parses resolve client-side
				local ok, parsed = pcall(function() return argDetail:parse(token, localUserId) end)
				if ok and parsed ~= nil then
					argVal:set(parsed)
				end
			end
		end
	end)

	-- Mirrors the widget visibility so hidden slots don't leak into the command string
	local function isSlotRevealed(entry: ArgConfigEntry, configs: {ArgConfigEntry}): boolean
		if not entry.uiHidden then return true end
		if not entry.revealedBy then return false end
		local depKey = (entry.revealedBy :: any).dependsOn
		local depTarget = (entry.revealedBy :: any).equals
		local depTargetAny: {any}? = (entry.revealedBy :: any).equalsAny
		for _, other in configs do
			if other.argKey == depKey then
				local current = Fusion.peek(other.argVal)
				if depTargetAny then
					for _, candidate in depTargetAny do
						if current == candidate then return true end
					end
					return false
				end
				return current == depTarget
			end
		end
		return false
	end

	-- Pending or idle checks don't block, only a confirmed failure
	local function evaluateRunGate(): (boolean, string?)
		local configs = Fusion.peek(argConfigs) :: {ArgConfigEntry}
		for _, entry in configs do
			local statusVal = entry.validationStatus
			if not statusVal then continue end
			if not isSlotRevealed(entry, configs) then continue end
			if Fusion.peek(statusVal) == false then
				return false, "Text checks failed, please review and retry"
			end
		end
		return true, nil
	end

	local commandString: Fusion.Value<string> = scope:Value("")
	local commandStringSeq = 0
	local commandStringDirty = false
	local function flushCommandStringUpdate()
		if not commandStringDirty then return end
		commandStringDirty = false
		commandStringSeq += 1
		local seq = commandStringSeq
		local info = Fusion.peek(commandInfo) :: any
		local key = Fusion.peek(commandKey) :: string
		local configs = Fusion.peek(argConfigs) :: {ArgConfigEntry}
		-- Forced empty for disableModifiers commands, otherwise stale selections
		-- unparse into the command string after switching commands
		local modifierKeys: {string} = if type(info) == "table" and (info :: any).disableModifiers
			then {}
			else Fusion.peek(selectedModifiers) :: {string}
		if type(info) ~= "table" then
			commandString:set("")
			return
		end
		local argNames: {string} = (info :: any).args or {}
		local unpackedArgs: {any} = {}
		for argIndex = 1, #argNames do
			local entry: ArgConfigEntry? = configs[argIndex]
			local val = if entry then Fusion.peek(entry.argVal) else nil
			if entry then
				local empty = ParserSettings.EmptyUnparsedValue
				-- Hidden-and-not-revealed slots get "-" verbatim, the per-type defaulting
				-- below would auto-fill Options[1] or "0s"
				if not isSlotRevealed(entry, configs) then
					unpackedArgs[argIndex] = empty
					continue
				end
				if entry.inputType == "TextInput" and val == "" then
					val = empty
				elseif entry.inputType == "NumberInput" and val == nil then
					val = empty
				elseif entry.inputType == "InputFields" and typeof(val) == "table" then
					local allEmpty = true
					for _, fieldValue in val :: {any} do
						if typeof(fieldValue) == "string" and fieldValue ~= "" then allEmpty = false; break end
					end
					if allEmpty then val = {empty} end
				elseif entry.inputType == "Options" and (val == nil or val == "") then
					local cfg = entry.inputConfig :: any
					local opts = cfg.optionsArray
					val = if typeof(opts) == "table" and #opts > 0 then opts[1] else (cfg.default or empty)
				elseif entry.inputType == "ItemSelector" then
					local isEmpty = val == nil or (typeof(val) == "table" and #val == 0) or val == ""
					if isEmpty then
						local cfg = entry.inputConfig :: any
						if cfg.canAnyUserBeAddedToPicker then
							local lp = Players.LocalPlayer
							val = { if lp then lp.UserId else 0 }
						elseif cfg.displayQualifiersInPicker then
							val = { "me" }
						else
							val = { empty }
						end
					end
				end
			end
			unpackedArgs[argIndex] = val
		end
		task.spawn(function()
			local ok, result = pcall(Parser.unparse, key, modifierKeys, table.unpack(unpackedArgs))
			if not destroyed and seq == commandStringSeq then
				commandString:set(if ok and type(result) == "string" then result else "")
			end
		end)
	end
	local function scheduleCommandStringUpdate()
		if not commandStringDirty then
			commandStringDirty = true
			task.defer(flushCommandStringUpdate)
		end
	end
	scope:Observer(commandInfo):onBind(function()
		scheduleCommandStringUpdate()
	end)
	scope:Observer(argChangeCounter):onChange(function()
		scheduleCommandStringUpdate()
	end)
	scope:Observer(selectedModifiers):onChange(function()
		scheduleCommandStringUpdate()
	end)

	local isPopupOpen: Fusion.Value<boolean> = scope:Value(false)

	local defaultPrefix = scope:Fuse("perm", {"YouSettings", "Prefix"})

	local roleInfoFuse = scope:Fuse("everyone", "RoleInfo")
	local showRolesRow = scope:Computed(function(use): boolean
		local showRolesProp: any = props.showRoles
		if showRolesProp == nil or not use(showRolesProp) then return false end
		local info = use(commandInfo) :: any
		local directRoles = if type(info) == "table" then (info :: any).directRoles else nil
		return typeof(directRoles) == "table" and #(directRoles :: {any}) > 0
	end)
	local rolesRow = scope:Computed(function(use, innerScope)
		if not use(showRolesRow) then return nil end
		local info = use(commandInfo) :: any
		local directRoles = (info :: any).directRoles
		local roleInfo = use(roleInfoFuse)
		local badges: {any} = {
			innerScope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				HorizontalFlex = Enum.UIFlexAlignment.None,
				VerticalFlex = Enum.UIFlexAlignment.None,
				Padding = UDim.new(0, 6),
				SortOrder = Enum.SortOrder.LayoutOrder,
			},
		}
		for index, roleKey in directRoles :: {string} do
			local role = if typeof(roleInfo) == "table" then (roleInfo :: any)[roleKey] else nil
			table.insert(badges, RoleBadge(innerScope, {
				id = roleKey,
				name = if typeof(role) == "table" and typeof((role :: any).name) == "string" then (role :: any).name else roleKey,
				color = if typeof(role) == "table" and typeof((role :: any).color) == "Color3" then (role :: any).color else nil,
				large = true,
				pillHeight = 31,
				textSize = 18,
				layoutOrder = index,
			}))
		end
		return innerScope:New "Frame" {
			Name = "CommandRoles",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = -4,
			Size = UDim2.fromScale(1, 0),
			[Children] = badges,
		}
	end)

	local commandSignature: Fusion.Computed<string> = scope:Computed(function(use)
		local info = use(commandInfo) :: any
		if type(info) ~= "table" then return "" end
		local prefix = (info :: any).prefix or use(defaultPrefix) or ";"
		local name = (info :: any).name or ""
		local argNames: {string} = (info :: any).args or {}
		local argPlaceholders = {}
		for _, argName in argNames do
			-- A command can override an arg with a table, so the name comes off the resolved detail
			local argDetail = Args.get(argName :: any)
			local label = (argDetail and (argDetail.display or argDetail.key)) or tostring(argName)
			table.insert(argPlaceholders, "<" .. tostring(label) .. ">")
		end
		local signature = prefix .. name
		if #argPlaceholders > 0 then
			signature = signature .. " " .. table.concat(argPlaceholders, " ")
		end
		return signature
	end)

	return scope:New "Frame" {
		Name = "RunPage",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,

		[Children] = {
			scope:New "Frame" {
				Name = "Content",
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),

				[Children] = {
					scope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Vertical,
						HorizontalFlex = Enum.UIFlexAlignment.Fill,
						SortOrder = Enum.SortOrder.LayoutOrder,
					},

					scope:New "ScrollingFrame" {
						Name = "ArgsScroller",
						LayoutOrder = 1,
						Size = UDim2.fromScale(1, 0),
						BackgroundTransparency = 1,
						CanvasSize = UDim2.new(),
						AutomaticCanvasSize = Enum.AutomaticSize.Y,
						BottomImage = "rbxassetid://16547643439",
						MidImage = "rbxassetid://16547330984",
						ScrollBarImageColor3 = Theme.Color.NeutralContentDark,
						ScrollBarImageTransparency = if Platform.isMobile then 1 else 0,
						ScrollBarThickness = if Platform.isMobile then 2 else 8,
						ScrollingDirection = Enum.ScrollingDirection.Y,
						TopImage = "rbxassetid://16547667444",
						VerticalScrollBarInset = if Platform.isMobile then Enum.ScrollBarInset.Always else Enum.ScrollBarInset.ScrollBar,

						[Children] = {
							scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
							scope:New "UIListLayout" {
								HorizontalFlex = Enum.UIFlexAlignment.Fill,
								FillDirection = Enum.FillDirection.Vertical,
								Padding = UDim.new(0, 12),
								SortOrder = Enum.SortOrder.LayoutOrder,
							},
							scope:New "UIPadding" {
								Name = "UIPadding",
								PaddingLeft = UDim.new(0, 1),
								PaddingRight = UDim.new(0, 6),
								PaddingBottom = UDim.new(0, 6),
							},

							scope:New "TextLabel" {
								Name = "SignatureTitle",
							LayoutOrder = -5,
							AutomaticSize = Enum.AutomaticSize.Y,
							BackgroundTransparency = 1,
							Size = UDim2.fromScale(1, 0),
							FontFace = scope:Computed(function(use)
								return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
							end),
							Text = commandSignature,
							TextColor3 = Theme.Color.BaseContent,
							TextSize = Theme.TextSize.Subtitle,
							TextWrapped = true,
							TextXAlignment = Enum.TextXAlignment.Center,

							[Children] = {
								scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
								scope:New "UIPadding" {
									PaddingLeft = UDim.new(0, 2),
									PaddingRight = UDim.new(0, 2),
									PaddingTop = UDim.new(0, 4),
									-- Tucks the roles row closer when it shows
									PaddingBottom = scope:Computed(function(use)
										return UDim.new(0, if use(showRolesRow) then 0 else 4)
									end),
								},
							},
						},

						scope:New "Frame" {
							Name = "Divider",
							LayoutOrder = -1,
							BackgroundColor3 = Theme.Color.NeutralStroke,
							BorderSizePixel = 0,
							Size = UDim2.new(1, 0, 0, 1),
					},

					rolesRow,

					scope:ForValues(argConfigs, function(_, innerScope, entry: ArgConfigEntry)
						local factory = (InputObjects :: any).items[entry.inputType] :: ((Fusion.Scope, any) -> any)?
						if not factory then return nil end
						local widget = factory(innerScope, entry.inputConfig)
						if not entry.uiHidden then return widget end
						-- No revealedBy spec means always hidden
						local visible: any = false
						if entry.revealedBy then
							local depKey = (entry.revealedBy :: any).dependsOn
							-- equalsAny wins when both are set
							local depTarget = (entry.revealedBy :: any).equals
							local depTargetAny: {any}? = (entry.revealedBy :: any).equalsAny
							local snapshot = Fusion.peek(argConfigs) :: {ArgConfigEntry}
							local depArgVal: Fusion.Value<any>? = nil
							for _, other in snapshot do
								if other.argKey == depKey then
									depArgVal = other.argVal
									break
								end
							end
							if depArgVal then
								visible = innerScope:Computed(function(use)
									local current = use(depArgVal :: any)
									if depTargetAny then
										for _, candidate in depTargetAny do
											if current == candidate then return true end
										end
										return false
									end
									return current == depTarget
								end)
							end
						end
						return innerScope:New "Frame" {
							Name = "ArgWrap_" .. entry.argKey,
							AutomaticSize = Enum.AutomaticSize.Y,
							BackgroundTransparency = 1,
							Size = UDim2.fromScale(1, 0),
							Visible = visible,
							[Children] = { widget },
						}
					end),						scope:New "Frame" {
							Name = "ModifierSelectorWrapper",
							LayoutOrder = 9999,								AutomaticSize = Enum.AutomaticSize.Y,
							Size = UDim2.fromScale(1, 0),
							BackgroundTransparency = 1,
							-- disableModifiers hides the picker, the server drops their modifiers too
							Visible = scope:Computed(function(use)
								local info = use(commandInfo)
								if typeof(info) ~= "table" then return true end
								return not (info :: any).disableModifiers
							end),

							[Children] = {
								-- One modifier at a time. The perm sugars cover every sane pairing,
								-- while the checkbox UI keeps the capsule config boxes
								ItemSelector(scope, {
									title = "Modifiers",
									value = selectedModifiers,
									pickerGetter = modifierPickerGetter,
									onOpen = props.onItemSelectorOpen,
									isOrderedPicker = true,
									singleSelection = true,
								}),
							},
						},
					},
				},

				scope:New "Frame" {
					Name = "Divider",
					LayoutOrder = 2,
					Size = UDim2.new(1, 0, 0, 1),
					BackgroundColor3 = Theme.Color.NeutralStroke,
				},

				scope:New "Frame" {
					Name = "BottomBar",
					LayoutOrder = 3,
					AutomaticSize = Enum.AutomaticSize.Y,
					Size = UDim2.fromScale(1, 0),
					BackgroundTransparency = 1,

					[Children] = {
						scope:New "UIPadding" {
						Name = "UIPadding",
						PaddingBottom = UDim.new(0, 4),
						PaddingTop = UDim.new(0, 14),
						PaddingLeft = UDim.new(0, 1),
						PaddingRight = UDim.new(0, 1),
						},
						scope:New "UIListLayout" {
							FillDirection = Enum.FillDirection.Horizontal,
							SortOrder = Enum.SortOrder.LayoutOrder,
							VerticalAlignment = Enum.VerticalAlignment.Center,
							Padding = scope:Computed(function(use) return UDim.new(0, math.round((use(Theme.Layout.Spacing) :: number) * 0.5)) end),
						},

						CommandButton(scope, {
							commandKey = commandKey,
							text = commandString,
							commandText = commandString,
							unlockRole = props.unlockRole,
							chatSource = "ClientPreviewRun",
							runOnly = true,
							runGate = evaluateRunGate,
							activeCommands = props.activeCommands,
							layoutOrder = 1,
							textSize = 18,
						size = UDim2.new(1, 0, 0, 44),
						onCommandActivate = function()
							isPopupOpen:set(true)
						end,
						onCopy = function()
							isPopupOpen:set(true)
						end,
					}),
					},
				},
			},
		},

		CopyPopup(scope, {
			text = commandString,
			visible = isPopupOpen,
		}),
	},
}
end
