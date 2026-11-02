--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local SearchBar = require(frontend.Components.SearchBar)
local ScrollList = require(frontend.Components.ScrollList)
local CheckItem = require(frontend.Components.CheckItem)
local Checkbox = require(frontend.Components.Checkbox)
local SplitRow = require(frontend.Components.SplitRow)
local Pressable = require(frontend.Components.Pressable)
local Icons = require(frontend.Config.Icons)
local Players = game:GetService("Players")
local GroupService = game:GetService("GroupService")
local MarketplaceService = game:GetService("MarketplaceService")


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
-- Mirrors ItemSelector.luau PickerItem shape
type PickerItem = {
	key: string,
	label: string,
	header: string,
	body: string?,
	icon: string?,
	rawValue: any,
	category: ("player" | "qualifier" | "custom" | "preset")?,
	configurable: string?,
}
-- Config injected by ItemSelector via PanelGui
type ItemSelectorConfig = {
	title: string,
	allItems: Fusion.Value<{ PickerItem }>,
	pendingKeys: Fusion.Value<{ [string]: boolean }>,
	canAddAnyUser: boolean,
	canAdd: boolean?,
	addFlow: ("User" | "Product" | "Group")?,
	maxItems: number,
	configurableValues: Fusion.Value<{[string]: string}>,
	onAddItem: ((item: PickerItem) -> ())?,
	setPreview: ((item: PickerItem?) -> ())?,
	onConfirm: () -> (),
	onRemoveCustomUser: ((key: string) -> ())?,
	pendingOrderedKeys: Fusion.Value<{string}>?,
	limitPickerToOneItem: boolean?,
	singleSelection: boolean?,
	displayServerPlayersInPicker: boolean?,
}
type Props = {
	config: Fusion.Value<ItemSelectorConfig?>,
	onConfirmBack: (() -> ())?,
	onOpenConfigureGroupRoles: ((groupId: number, currentEntry: any?) -> ())?,
	onOpenViewCommandsForTag: ((tag: string) -> ())?,
	idle: Fusion.UsedAs<boolean>?,
}


-- LOCAL FUNCTIONS
local INFO_TYPE_OPTIONS: { { id: string, label: string, enum: Enum.InfoType, searchDescription: string? } } = {
	{id = "GamePass", label = "GamePass", enum = Enum.InfoType.GamePass, searchDescription = "Search GamePass ID..."},
	{id = "Asset", label = "Asset", enum = Enum.InfoType.Asset, searchDescription = "Search Accessory/Emote/Asset ID"},
	{id = "Bundle", label = "Bundle", enum = Enum.InfoType.Bundle, searchDescription = "Search Bundle ID..."},
}

local function resolveUser(query: string): (any?, string?)
	local uid: number?
	local numeric = tonumber(query)
	if numeric then
		uid = numeric :: number
	else
		local ok, id = pcall(Players.GetUserIdFromNameAsync, Players, query)
		if not ok then return nil, "No user found" end
		uid = id
	end
	local okName, name = pcall(Players.GetNameFromUserIdAsync, Players, uid :: number)
	if not okName or typeof(name) ~= "string" then return nil, "No user found" end
	local username = name :: string
	local inServer = Players:GetPlayerByUserId(uid :: number)
	local displayName = if inServer then inServer.DisplayName else username
	local userName = if inServer then inServer.Name else username
	return {
		key = tostring(uid),
		label = displayName .. " @" .. userName,
		header = displayName,
		body = "@" .. userName,
		icon = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(uid) .. "&w=48&h=48",
		rawValue = if inServer then inServer else uid,
		category = "custom",
	}, nil
end

local function resolveGroup(query: string): (any?, string?)
	local gid = tonumber(query)
	if not gid or gid <= 0 then return nil, "Enter a valid group ID" end
	local ok, info: any = pcall(function()
		return GroupService:GetGroupInfoAsync(gid :: number)
	end)
	if not ok or typeof(info) ~= "table" then return nil, `No group found for "{query}"` end
	local groupName = if typeof(info.Name) == "string" then info.Name else "Group " .. tostring(gid)
	return {
		key = "group:" .. tostring(gid),
		label = groupName,
		header = groupName,
		body = tostring(gid),
		icon = "rbxthumb://type=GroupIcon&id=" .. tostring(gid) .. "&w=150&h=150",
		rawValue = {type = "AnyMember", groupId = gid},
		category = "custom",
		groupConfig = true,
		roleLabel = "All Roles",
	}, nil
end

local function resolveProduct(query: string, typeId: string, infoEnum: Enum.InfoType): (any?, string?)
	local id = tonumber(query)
	if not id or id <= 0 then return nil, "Enter a valid ID" end
	local ok, info: any = pcall(function()
		return MarketplaceService:GetProductInfo(id :: number, infoEnum)
	end)
	if not ok or typeof(info) ~= "table" then return nil, "Could not find a " .. typeId .. " with that id" end
	local name = if typeof(info.Name) == "string" then info.Name else ("#" .. tostring(id))
	local iconImage = ""
	if typeof(info.IconImageAssetId) == "number" and info.IconImageAssetId > 0 then
		iconImage = "rbxassetid://" .. tostring(info.IconImageAssetId)
	end
	return {
		key = string.lower(typeId) .. ":" .. tostring(id),
		label = name,
		header = name,
		icon = if #iconImage > 0 then iconImage else nil,
		rawValue = {type = typeId, id = id :: number},
		category = "custom",
		productConfig = true,
	}, nil
end


-- COMPONENT
return function(scope: Scope, props: Props)
	local searchText: Fusion.Value<string> = scope:Value("")

	local function peekConfig(): ItemSelectorConfig?
		return Fusion.peek(props.config) :: ItemSelectorConfig?
	end

	local canAdd = scope:Computed(function(use)
		local cfg = use(props.config) :: ItemSelectorConfig?
		if not cfg then return false end
		if (cfg :: any).canAdd == true then return true end
		return cfg.canAddAnyUser == true
	end)

	local limitPickerToOneItem = scope:Computed(function(use)
		local cfg = use(props.config) :: ItemSelectorConfig?
		return if cfg then (cfg :: any).limitPickerToOneItem == true else false
	end)

	local useStream = scope:Computed(function(use)
		local cfg = use(props.config) :: ItemSelectorConfig?
		return if cfg then (cfg :: any).displayServerPlayersInPicker == true else true
	end)

	-- hiddenFromPicker items still list while selected, otherwise a saved value
	-- backed by one could never be deselected. Once seen they stay for the session
	local stickyHiddenKeys: {[string]: true} = {}
	local lastStickyConfig: any = nil
	local allItems = scope:Computed(function(use)
		local cfg = use(props.config) :: ItemSelectorConfig?
		if not cfg then return {} end
		if cfg ~= lastStickyConfig then
			lastStickyConfig = cfg
			stickyHiddenKeys = {}
		end
		local raw = use(cfg.allItems :: any) :: { PickerItem }
		local pending = use(cfg.pendingKeys :: any) :: { [string]: boolean }
		local visible: { PickerItem } = {}
		for _, item in raw do
			local hidden = (item :: any).hiddenFromPicker == true
			if hidden and typeof(pending) == "table" and pending[item.key] == true then
				stickyHiddenKeys[item.key] = true
			end
			if not hidden or stickyHiddenKeys[item.key] == true then
				table.insert(visible, item)
			end
		end
		return visible
	end)

	local filteredItems: Fusion.Computed<{ PickerItem }> = scope:Computed(function(use)
		local items = use(allItems) :: { PickerItem }
		local query = string.lower((string.gsub(use(searchText) :: string, "%s", "")))
		if #query == 0 then return items end
		local result: { PickerItem } = {}
		for _, item in items do
			local cat = (item :: any).category or "custom"
			local searchable = string.lower(item.label)
				.. (if (item :: any).header then string.lower((item :: any).header) else "")
				.. (if (item :: any).body and cat ~= "qualifier" then " " .. string.lower((item :: any).body) else "")
				-- Include key so an id-based search still matches the resolved row
				.. " " .. string.lower(tostring(item.key))
			if string.find(searchable, query, 1, true) then
				table.insert(result, item)
			end
		end
		return result
	end)

	local addFlow = scope:Computed(function(use): string?
		local cfg = use(props.config) :: ItemSelectorConfig?
		if not cfg then return nil end
		local canAddNow = (cfg :: any).canAdd == true or cfg.canAddAnyUser == true
		if not canAddNow then return nil end
		return (cfg :: any).addFlow or "User"
	end)

	local selectedTypeId: Fusion.Value<string> = scope:Value("GamePass")

	local isResolving: Fusion.Value<boolean> = scope:Value(false)
	local resolveError: Fusion.Value<string> = scope:Value("")
	local destroyed = false
	table.insert(scope :: any, function() destroyed = true end)

	local placeholder = scope:Computed(function(use): string
		local flow = use(addFlow)
		if flow == "User" then return "Search by name or user ID..." end
		if flow == "Group" then return "Search by group ID..." end
		if flow == "Product" then
			local typeId = use(selectedTypeId)
			for _, opt in INFO_TYPE_OPTIONS do
				if opt.id == typeId and opt.searchDescription then return opt.searchDescription :: string end
			end
			return "Search by product ID..."
		end
		return "Filter..."
	end)

	local function infoEnumFor(typeId: string): Enum.InfoType
		for _, opt in INFO_TYPE_OPTIONS do
			if opt.id == typeId then return opt.enum end
		end
		return Enum.InfoType.GamePass
	end

	local function keyExists(cfg: ItemSelectorConfig, key: string): boolean
		for _, item in Fusion.peek(cfg.allItems :: any) :: { any } do
			if item.key == key then return true end
		end
		return false
	end

	-- Only an identical username suppresses the lookup, a partial one still searches
	local function userAlreadyListed(cfg: ItemSelectorConfig, query: string): boolean
		local numeric = tonumber(query) ~= nil
		local lowerQuery = string.lower(query)
		for _, item in Fusion.peek(cfg.allItems :: any) :: { any } do
			if numeric then
				if item.key == query then return true end
			else
				local body = (item :: any).body
				if typeof(body) == "string" then
					local username = string.lower((string.gsub(body, "^@", "")))
					if username == lowerQuery then return true end
				end
			end
		end
		return false
	end

	-- The version drops stale async results
	local resolveVersion = 0
	local function runResolve()
		local cfg = peekConfig()
		local flow = Fusion.peek(addFlow) :: string?
		local text = (string.gsub(Fusion.peek(searchText) :: string, "%s+", ""))
		resolveVersion += 1
		local thisVersion = resolveVersion
		resolveError:set("")
		if cfg and cfg.setPreview then cfg.setPreview(nil) end
		if not cfg or not flow or #text == 0 then
			isResolving:set(false)
			return
		end
		if flow == "User" then
			if userAlreadyListed(cfg, text) then
				isResolving:set(false)
				return
			end
		elseif flow == "Group" then
			if not tonumber(text) then
				resolveError:set("Enter a valid group ID")
				isResolving:set(false)
				return
			end
			if keyExists(cfg, "group:" .. text) then
				isResolving:set(false)
				return
			end
		elseif flow == "Product" then
			if not tonumber(text) then
				resolveError:set("Enter a valid ID")
				isResolving:set(false)
				return
			end
			if keyExists(cfg, string.lower(Fusion.peek(selectedTypeId) :: string) .. ":" .. text) then
				isResolving:set(false)
				return
			end
		end
		isResolving:set(true)
		local typeId = Fusion.peek(selectedTypeId) :: string
		local infoEnum = infoEnumFor(typeId)
		task.delay(0.3, function()
			if destroyed or thisVersion ~= resolveVersion then return end
			task.spawn(function()
				local item: any, errMsg: string?
				if flow == "User" then
					item, errMsg = resolveUser(text)
				elseif flow == "Group" then
					item, errMsg = resolveGroup(text)
				else
					item, errMsg = resolveProduct(text, typeId, infoEnum)
				end
				if destroyed or thisVersion ~= resolveVersion then return end
				isResolving:set(false)
				local liveCfg = peekConfig()
				if item == nil then
					-- Soft not-found noise stays quiet while filtering by name, a bare
					-- id is unambiguously an add attempt so its error surfaces
					if flow == "User" and tonumber(text) == nil then
						resolveError:set("")
					else
						resolveError:set(errMsg or "")
					end
					return
				end
				if liveCfg == nil then return end
				-- Re-check, state may have moved
				if keyExists(liveCfg, item.key) then return end
				if liveCfg.setPreview then liveCfg.setPreview(item) end
			end)
		end)
	end
	scope:Observer(searchText):onChange(runResolve)
	scope:Observer(selectedTypeId):onChange(runResolve)

	-- Clearing searchText re-runs the resolver, which drops any leftover preview
	scope:Observer(props.config :: any):onChange(function()
		searchText:set("")
		resolveError:set("")
		isResolving:set(false)
		selectedTypeId:set("GamePass")
	end)

	local function makeTypeChip(chipScope: Scope, optId: string, optLabel: string)
		local isActive = chipScope:Computed(function(use)
			return use(selectedTypeId) == optId
		end)
		return Pressable(chipScope, {
			name = "TypeChip_" .. optId,
			automaticSize = Enum.AutomaticSize.XY,
			backgroundColor = chipScope:Computed(function(use)
				return if use(isActive) then use(Theme.Color.Primary) else use(Theme.Color.Neutral)
			end),
			size = UDim2.fromOffset(0, 0),
			onActivate = function()
				selectedTypeId:set(optId)
			end,
			[Children] = {
				chipScope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
				chipScope:New "UIPadding" {
					PaddingTop = UDim.new(0, 8),
					PaddingBottom = UDim.new(0, 8),
					PaddingLeft = UDim.new(0, 14),
					PaddingRight = UDim.new(0, 14),
				},
				chipScope:New "TextLabel" {
					Name = "Label",
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundTransparency = 1,
					FontFace = chipScope:Computed(function(use)
						return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
					end),
					Text = optLabel,
					TextColor3 = chipScope:Computed(function(use)
						return if use(isActive) then use(Theme.Color.PrimaryContent) else use(Theme.Color.BaseContent)
					end),
					TextSize = Theme.TextSize.Subtitle,
				},
			},
		})
	end

	local HEADER_CUSTOM: any = { key = "__cat_custom", isHeader = true, label = "Custom" }
	local HEADER_PLAYERS: any = { key = "__cat_players", isHeader = true, label = "In-Game" }
	local HEADER_QUALIFIERS: any = { key = "__cat_qualifiers", isHeader = true, label = "Qualifiers" }
	local HEADER_PRESETS: any = { key = "__cat_presets", isHeader = true, label = "Presets" }

	local function buildGrouped(items: { PickerItem }): { any }
		local custom: { PickerItem } = {}
		local players: { PickerItem } = {}
		local qualifiers: { PickerItem } = {}
		local presets: { PickerItem } = {}
		for _, item in items do
			local cat = (item :: any).category or "custom"
			if cat == "qualifier" then
				table.insert(qualifiers, item)
			elseif cat == "player" then
				table.insert(players, item)
			elseif cat == "preset" then
				table.insert(presets, item)
			else
				table.insert(custom, item)
			end
		end
		local categoryCount = (if #custom > 0 then 1 else 0)
			+ (if #players > 0 then 1 else 0)
			+ (if #qualifiers > 0 then 1 else 0)
			+ (if #presets > 0 then 1 else 0)
		local showHeaders = categoryCount > 1
		local result: { any } = {}
		if #presets > 0 then
			if showHeaders then table.insert(result, HEADER_PRESETS) end
			for _, item in presets do table.insert(result, item) end
		end
		if #custom > 0 then
			if showHeaders then table.insert(result, HEADER_CUSTOM) end
			for _, item in custom do table.insert(result, item) end
		end
		if #players > 0 then
			if showHeaders then table.insert(result, HEADER_PLAYERS) end
			for _, item in players do table.insert(result, item) end
		end
		if #qualifiers > 0 then
			if showHeaders then table.insert(result, HEADER_QUALIFIERS) end
			for _, item in qualifiers do table.insert(result, item) end
		end
		return result
	end

	local groupedAllItems = scope:Computed(function(use)
		local items = use(allItems) :: { PickerItem }
		return buildGrouped(items)
	end)

	local filteredGroupedItems = scope:Computed(function(use)
		local items = use(filteredItems) :: { PickerItem }
		return buildGrouped(items)
	end)

	-- ForValues reuses rows by table identity, so a row that leaves and re-enters
	-- would recreate at the bottom. Rows read their position from this map
	local itemOrder = scope:Computed(function(use)
		local order: {[any]: number} = {}
		for index, item in use(filteredGroupedItems) :: {any} do
			order[item] = index
		end
		return order
	end)

	local selectedCount = scope:Computed(function(use)
		local cfg = use(props.config) :: ItemSelectorConfig?
		if not cfg then return 0 end
		local keys = use(cfg.pendingKeys :: any) :: { [string]: boolean }
		local count = 0
		for _ in keys do count += 1 end
		return count
	end)

	local function toggleKey(key: string)
		local cfg = peekConfig()
		if not cfg then return end
		local current = Fusion.peek(cfg.pendingKeys :: any) :: { [string]: boolean }
		-- Radio behaviour keeps the checkbox UI, limitPickerToOneItem hides the
		-- checkboxes and confirms instantly so capsule boxes never show
		if cfg.singleSelection and not current[key] then
			cfg.pendingKeys:set({ [key] = true })
			if cfg.pendingOrderedKeys then
				cfg.pendingOrderedKeys:set({ key })
			end
			return
		end
		local maxItems: number = cfg.maxItems
		local countSelected = 0
		for _ in current do countSelected += 1 end
		local copy = table.clone(current)
		local wasAdded = false
		if copy[key] then
			copy[key] = nil
		elseif countSelected < maxItems then
			copy[key] = true
			wasAdded = true
		end
		cfg.pendingKeys:set(copy)
		if cfg.pendingOrderedKeys then
			local currentOrdered = Fusion.peek(cfg.pendingOrderedKeys :: any) :: {string}
			local idx = table.find(currentOrdered, key)
			local orderedCopy = table.clone(currentOrdered)
			if idx then
				table.remove(orderedCopy, idx)
			elseif wasAdded then
				table.insert(orderedCopy, key)
			end
			cfg.pendingOrderedKeys:set(orderedCopy)
		end
	end

	local function makeRow(innerScope: Scope, item: any)
		if item.isHeader then
			return innerScope:New "TextLabel" {
				Name = "CategoryHeader",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 0),
				FontFace = innerScope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
				end),
				Text = item.label,
				TextColor3 = Theme.Color.NeutralContentDark,
				TextSize = Theme.TextSize.Label,
				TextXAlignment = Enum.TextXAlignment.Left,
				[Children] = {
					innerScope:New "UIPadding" {
						PaddingTop = UDim.new(0, 6),
						PaddingBottom = UDim.new(0, 2),
						PaddingLeft = UDim.new(0, 4),
					},
				},
			}
		end

		local pickerItem = item :: PickerItem
		local isSelected = innerScope:Computed(function(use)
			local cfg = use(props.config) :: ItemSelectorConfig?
			if not cfg then return false end
			return (use(cfg.pendingKeys :: any) :: { [string]: boolean })[pickerItem.key] == true
		end)

		local cfgNow = peekConfig()
		local orderNumber: Fusion.Computed<number?>? = if cfgNow ~= nil and (cfgNow :: any).pendingOrderedKeys ~= nil and (cfgNow :: any).singleSelection ~= true
			then innerScope:Computed(function(use): number?
				local cfg2 = use(props.config) :: ItemSelectorConfig?
				if not cfg2 or not (cfg2 :: any).pendingOrderedKeys then return nil end
				local ordered = use((cfg2 :: any).pendingOrderedKeys :: any) :: {string}
				local idx = table.find(ordered, pickerItem.key)
				return if idx then idx else nil
			end)
			else nil

		local cfgForLimit = peekConfig()
		local isLimitOne = cfgForLimit ~= nil and (cfgForLimit :: any).limitPickerToOneItem == true

		local fontFamily: string? = (pickerItem :: any).fontFamily
		local labelFont: Font? = if fontFamily
			then Font.new(fontFamily)
			else nil

		-- Early return so we don't waste a CheckItem instance per tag row
		if (pickerItem :: any).tagConfig == true then
			local tag: string? = if typeof((pickerItem :: any).rawValue) == "string"
				then (pickerItem :: any).rawValue
				else nil
			local headerText = (pickerItem :: any).header :: string? or pickerItem.label or pickerItem.key
			local tagDisplayText = string.format("<b>%s</b>", headerText)
			-- body is like "12 Commands", pull the numeric prefix
			local bodyText = (pickerItem :: any).body :: string?
			local countText: string? = if bodyText then bodyText:match("^(%d+)") else nil

			return SplitRow(innerScope, {
				name = "TagRow_" .. pickerItem.key,
				height = 38,

				left = {
					name = "TagToggle",
					fills = true,
					onActivate = function()
						toggleKey(pickerItem.key)
					end,
					[Children] = {
						innerScope:New "Frame" {
							Name = "ContentGroup",
							BackgroundTransparency = 1,
							Size = UDim2.fromScale(1, 1),
							[Children] = {
								innerScope:New "UIPadding" {
									PaddingLeft = UDim.new(0, 12),
									PaddingRight = UDim.new(0, 12),
								},
								innerScope:New "UIListLayout" {
									FillDirection = Enum.FillDirection.Horizontal,
									VerticalAlignment = Enum.VerticalAlignment.Center,
									Padding = UDim.new(0, 10),
									SortOrder = Enum.SortOrder.LayoutOrder,
								},

								Checkbox(innerScope, {
									checked = isSelected,
									layoutOrder = 1,
								}),

								innerScope:New "TextLabel" {
									Name = "Label",
									BackgroundTransparency = 1,
									FontFace = innerScope:Computed(function(use)
										return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Regular))
									end),
									LayoutOrder = 2,
									RichText = true,
									Size = UDim2.new(1, 0, 1, 0),
									Text = tagDisplayText,
									TextColor3 = Theme.Color.BaseContent,
									TextSize = Theme.TextSize.Subtitle,
									TextTruncate = Enum.TextTruncate.SplitWord,
									TextXAlignment = Enum.TextXAlignment.Left,
									TextYAlignment = Enum.TextYAlignment.Center,
									[Children] = {
										innerScope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
									},
								},

								if countText then innerScope:New "Frame" {
									Name = "CountBadge",
									AutomaticSize = Enum.AutomaticSize.X,
									BackgroundColor3 = Theme.Color.NeutralStroke,
									LayoutOrder = 3,
									Size = UDim2.new(0, 0, 0, 22),
									[Children] = {
										innerScope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
										innerScope:New "UIPadding" {
											PaddingLeft = UDim.new(0, 6),
											PaddingRight = UDim.new(0, 6),
										},
										-- Min width so single-digit badges roughly match "10"+
										innerScope:New "UISizeConstraint" {
											MinSize = Vector2.new(22, 0),
										},
										-- Centres the label when MinSize pads the badge wider than the text
										innerScope:New "UIListLayout" {
											FillDirection = Enum.FillDirection.Horizontal,
											HorizontalAlignment = Enum.HorizontalAlignment.Center,
											HorizontalFlex = Enum.UIFlexAlignment.None,
											VerticalAlignment = Enum.VerticalAlignment.Center,
											VerticalFlex = Enum.UIFlexAlignment.None,
											SortOrder = Enum.SortOrder.LayoutOrder,
										},
										innerScope:New "TextLabel" {
											Name = "Count",
											AutomaticSize = Enum.AutomaticSize.X,
											BackgroundTransparency = 1,
											FontFace = innerScope:Computed(function(use)
												return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
											end),
											Size = UDim2.new(0, 0, 1, 0),
											Text = countText,
											TextColor3 = Theme.Color.NeutralContentMain,
											TextSize = Theme.TextSize.Small,
											TextYAlignment = Enum.TextYAlignment.Center,
										},
									},
								} else nil,
							},
						},
					},
				},

				right = {
					name = "ViewCommandsButton",
					fills = false,
					onActivate = function()
						if tag and props.onOpenViewCommandsForTag then
							props.onOpenViewCommandsForTag(tag)
						end
					end,
					[Children] = {
						innerScope:New "ImageLabel" {
							Name = "Icon",
							AnchorPoint = Vector2.new(0.5, 0.5),
							BackgroundTransparency = 1,
							Image = Icons.Pages.Commands,
							ImageColor3 = Theme.Color.NeutralContentMain,
							Position = UDim2.fromScale(0.5, 0.5),
							Size = UDim2.fromOffset(16, 16),
						},
					},
				},
			})
		end

		local checkItem = CheckItem(innerScope, {
			header = (pickerItem :: any).header and innerScope:Value((pickerItem :: any).header) or nil,
			-- A live-state body (the epoch tick) passes straight through, not frozen into a Value
			body = if typeof((pickerItem :: any).body) == "table"
				then (pickerItem :: any).body
				else (pickerItem :: any).body and innerScope:Value((pickerItem :: any).body) or nil,
			icon = pickerItem.icon and innerScope:Value(pickerItem.icon) or nil,
			category = (pickerItem :: any).category and innerScope:Value((pickerItem :: any).category) or nil,
			colorIndicator = (pickerItem :: any).color,
			hintIcon = (pickerItem :: any).hintIcon,
			hintText = (pickerItem :: any).hintText,
			checked = isSelected,
			labelFont = labelFont,
			orderNumber = orderNumber,
			hideCheckbox = isLimitOne,
			strongSelected = if isLimitOne then isSelected else nil,
			onCheck = function(_checked: boolean)
				if isLimitOne then
					local cfg3 = peekConfig()
					if cfg3 then
						cfg3.pendingKeys:set({ [pickerItem.key] = true })
						cfg3.onConfirm()
					end
					if props.onConfirmBack then props.onConfirmBack() end
				else
					toggleKey(pickerItem.key)
				end
			end,
			onRemove = if (pickerItem :: any).category == "custom" then function()
				local cfg = peekConfig()
				if cfg and cfg.onRemoveCustomUser then
					cfg.onRemoveCustomUser(pickerItem.key)
				end
			end else nil,
		})

		if (pickerItem :: any).groupConfig == true then
			local roleLabel = (pickerItem :: any).roleLabel or "All Roles"
			-- Don't capture rawValue, resyncFromValue mutates it in-place on role
			-- switches so a capture would freeze at first render. Read live at click time
			local function getLiveRawValue(): any return (pickerItem :: any).rawValue end
			local initialRaw = getLiveRawValue()
			local groupId: number? = if typeof(initialRaw) == "table" and typeof((initialRaw :: any).groupId) == "number"
				then (initialRaw :: any).groupId
				else nil
			return innerScope:New "Frame" {
				Name = "GroupConfigItem",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 0),
				[Children] = {
					innerScope:New "UIListLayout" {
						HorizontalFlex = Enum.UIFlexAlignment.Fill,
						SortOrder = Enum.SortOrder.LayoutOrder,
					},
					checkItem,
					innerScope:New "Frame" {
						Name = "ConfigInput",
						LayoutOrder = 1,
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundColor3 = Theme.Color.Base,
						Size = UDim2.fromScale(1, 0),
						Visible = isSelected,
						[Children] = {
							innerScope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
							innerScope:New "UIStroke" {
								ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
								Color = Theme.Color.NeutralStroke,
							},
							innerScope:New "UIPadding" {
								PaddingBottom = UDim.new(0, 6),
								PaddingLeft = UDim.new(0, 6),
								PaddingRight = UDim.new(0, 10),
								PaddingTop = UDim.new(0, 6),
							},
							innerScope:New "UIListLayout" {
								FillDirection = Enum.FillDirection.Horizontal,
								HorizontalFlex = Enum.UIFlexAlignment.Fill,
								VerticalAlignment = Enum.VerticalAlignment.Center,
								Padding = UDim.new(0, 8),
								SortOrder = Enum.SortOrder.LayoutOrder,
							},
							Pressable(innerScope, {
								name = "CogButton",
								size = UDim2.fromOffset(30, 30),
								backgroundColor = Theme.Color.Neutral,
								layoutOrder = 0,
								iconImage = Icons.SettingsCogFill,
								iconSize = 16,
								onActivate = function()
									if groupId and props.onOpenConfigureGroupRoles then
										props.onOpenConfigureGroupRoles(groupId, getLiveRawValue())
									end
								end,
								[Children] = {
									innerScope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
									innerScope:New "UIAspectRatioConstraint" {
										Name = "UIAspectRatioConstraint",
										AspectType = Enum.AspectType.ScaleWithParentSize,
										DominantAxis = Enum.DominantAxis.Height,
									},
								},
							}),
							innerScope:New "TextLabel" {
								Name = "RoleLabel",
								LayoutOrder = 1,
								AutomaticSize = Enum.AutomaticSize.Y,
								BackgroundTransparency = 1,
								Size = UDim2.fromScale(1, 0),
								FontFace = innerScope:Computed(function(use)
									return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
								end),
								Text = roleLabel,
								TextColor3 = Theme.Color.NeutralContentDark,
								TextSize = Theme.TextSize.Subtitle,
								TextTruncate = Enum.TextTruncate.SplitWord,
								TextXAlignment = Enum.TextXAlignment.Left,
								[Children] = {
									innerScope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
								},
							},
						},
					},
				},
			}
		end

		if (pickerItem :: any).productConfig == true then
			local raw = (pickerItem :: any).rawValue
			local productLabel = ""
			if typeof(raw) == "table" then
				local productType = tostring((raw :: any).type or "")
				local id = tostring((raw :: any).id or "")
				productLabel = productType .. ": " .. id
			end
			return innerScope:New "Frame" {
				Name = "ProductConfigItem",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 0),
				[Children] = {
					innerScope:New "UIListLayout" {
						HorizontalFlex = Enum.UIFlexAlignment.Fill,
						SortOrder = Enum.SortOrder.LayoutOrder,
					},
					checkItem,
					innerScope:New "Frame" {
						Name = "ConfigInput",
						LayoutOrder = 1,
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundColor3 = Theme.Color.Base,
						Size = UDim2.fromScale(1, 0),
						Visible = isSelected,
						[Children] = {
							innerScope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
							innerScope:New "UIStroke" {
								ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
								Color = Theme.Color.NeutralStroke,
							},
							innerScope:New "UIPadding" {
								PaddingBottom = UDim.new(0, 11),
								PaddingLeft = UDim.new(0, 10),
								PaddingRight = UDim.new(0, 10),
								PaddingTop = UDim.new(0, 11),
							},
							innerScope:New "TextLabel" {
								Name = "ProductLabel",
								AutomaticSize = Enum.AutomaticSize.Y,
								BackgroundTransparency = 1,
								Size = UDim2.fromScale(1, 0),
								FontFace = innerScope:Computed(function(use)
									return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
								end),
								Text = productLabel,
								TextColor3 = Theme.Color.NeutralContentDark,
								TextSize = Theme.TextSize.Subtitle,
								TextTruncate = Enum.TextTruncate.SplitWord,
								TextXAlignment = Enum.TextXAlignment.Left,
							},
						},
					},
				},
			}
		end

		local configurableHint: string? = (pickerItem :: any).configurable
		if not configurableHint then
			return checkItem
		end

		local cfg2 = peekConfig()
		local confValues = cfg2 and (cfg2 :: any).configurableValues :: Fusion.Value<{[string]: string}>?
		local inputText: Fusion.Value<string> = innerScope:Value(
			if confValues then ((Fusion.peek(confValues :: any) :: {[string]: string})[pickerItem.key] or "") else ""
		)
		innerScope:Observer(inputText):onChange(function()
			local text = Fusion.peek(inputText)
			local stripped = text:gsub("%s", "")
			if stripped ~= text then
				task.defer(function() inputText:set(stripped) end)
				return
			end
			if confValues then
				local current = Fusion.peek(confValues :: any) :: {[string]: string}
				local copy = table.clone(current)
				copy[pickerItem.key] = stripped
				;(confValues :: any):set(copy)
			end
		end)

		-- Nobody knows the current epoch time off by heart, so the box gets a fill button
		local isEpochBox = configurableHint == "epochTime"
		local textBoxChildren: {any} = {
			innerScope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
			innerScope:New "UIPadding" {
				PaddingBottom = UDim.new(0, 11),
				PaddingLeft = UDim.new(0, 10),
				PaddingRight = UDim.new(0, if isEpochBox then 122 else 10),
				PaddingTop = UDim.new(0, 11),
			},
			innerScope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Theme.Color.NeutralStroke,
			},
		}
		if isEpochBox then
			table.insert(textBoxChildren, innerScope:New "TextButton" {
				Name = "FillCurrentTime",
				AnchorPoint = Vector2.new(1, 0.5),
				AutoLocalize = false,
				BackgroundColor3 = Theme.Color.NeutralContent,
				Position = UDim2.new(1, 112, 0.5, 0),
				Size = UDim2.fromOffset(104, 26),
				FontFace = innerScope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
				end),
				Text = "Fill Current Time",
				TextColor3 = Theme.Color.BaseContent,
				TextSize = Theme.TextSize.Small,
				[Fusion.OnEvent "Activated"] = function()
					inputText:set(tostring(os.time()))
				end,
				[Children] = {
					innerScope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
				},
			})
		end

		return innerScope:New "Frame" {
			Name = "ConfigurableItem",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 0),
			[Children] = {
				innerScope:New "UIListLayout" {
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					SortOrder = Enum.SortOrder.LayoutOrder,
				},
				checkItem,
				innerScope:New "Frame" {
					Name = "ConfigInput",
					LayoutOrder = 1,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 0),
					Visible = isSelected,
					[Children] = {
						innerScope:New "TextBox" {
							Name = "ConfigTextBox",
							AutoLocalize = false,
							AutomaticSize = Enum.AutomaticSize.Y,
							BackgroundColor3 = Theme.Color.Base,
							ClearTextOnFocus = false,
							ClipsDescendants = true,
							FontFace = innerScope:Computed(function(use)
								return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
							end),
							PlaceholderColor3 = Theme.Color.NeutralContentDark,
							PlaceholderText = configurableHint,
							Size = UDim2.fromScale(1, 0),
							Text = inputText,
							TextColor3 = Theme.Color.NeutralContentMain,
							TextSize = Theme.TextSize.Subtitle,
							TextXAlignment = Enum.TextXAlignment.Left,
							[Fusion.OnChange "Text"] = function(new: string)
								inputText:set(new)
							end,
							[Children] = textBoxChildren,
						},
					},
				},
			},
		}
	end

	-- Always Primary so confirming zero items doesn't look disabled
	local confirmBgColor = Theme.Color.Primary
	local confirmStrokeGradient = scope:Computed(function(use)
		local primary = use(Theme.Color.Primary)
		local hue, saturation, value = Color3.toHSV(primary)
		local lighter = Color3.fromHSV(hue, saturation * 0.92, math.min(value * 1.06, 1))
		return ColorSequence.new({
			ColorSequenceKeypoint.new(0, lighter),
			ColorSequenceKeypoint.new(1, primary),
		})
	end)
	local confirmTextColor = Theme.Color.PrimaryContent

	return scope:New "Frame" {
		Name = "ItemSelectorPage",
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

				scope:New "Frame" {
					Name = "ListArea",
				LayoutOrder = 1,
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 0),

				[Children] = {
					scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
					scope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Vertical,
						HorizontalFlex = Enum.UIFlexAlignment.Fill,
						SortOrder = Enum.SortOrder.LayoutOrder,
					},

					ScrollList(scope, {
						isReady = scope:Computed(function(use)
							-- An empty allItems is a valid state for Add-flow pickers and
							-- shouldn't block the list rendering its empty form
							local cfg = use(props.config) :: ItemSelectorConfig?
							return cfg ~= nil
						end),
					items = groupedAllItems,
					visibleItems = filteredGroupedItems,
					renderItem = function(itemScope, item: any)
						local row: any = makeRow(itemScope, item :: any)
						-- StreamList assigns its own LayoutOrders, only the direct path uses the map
						if row and Fusion.peek(useStream) ~= true then
							itemScope:Observer(itemOrder):onBind(function()
								local order = Fusion.peek(itemOrder) :: {[any]: number}
								local index = order[item]
								if index and row.LayoutOrder ~= index then
									row.LayoutOrder = index
								end
							end)
						end
						return row
						end,
						padding = UDim.new(0, 8),
						layoutOrder = 1,
						paddingRight = 10,
						idle = props.idle,
						useStream = useStream,
						headerGap = UDim.new(0, 12),
						header = scope:New "Frame" {
							Name = "HeaderWrapper",
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
									Name = "TypeChips",
									LayoutOrder = 0,
									AutomaticSize = Enum.AutomaticSize.Y,
									BackgroundTransparency = 1,
									Size = UDim2.fromScale(1, 0),
									Visible = scope:Computed(function(use) return use(addFlow) == "Product" end),
									[Children] = (function()
										local chipChildren: { any } = {
											scope:New "UIListLayout" {
												FillDirection = Enum.FillDirection.Horizontal,
												HorizontalFlex = Enum.UIFlexAlignment.None,
												VerticalFlex = Enum.UIFlexAlignment.None,
												Padding = UDim.new(0, 8),
												SortOrder = Enum.SortOrder.LayoutOrder,
											},
										}
										for index, opt in INFO_TYPE_OPTIONS do
											local chip: any = makeTypeChip(scope, opt.id, opt.label)
											chip.LayoutOrder = index
											table.insert(chipChildren, chip)
										end
										return chipChildren
									end)(),
								},

								SearchBar(scope, {
									searchText = searchText,
									placeholderText = placeholder,
									layoutOrder = 1,
								}),

								scope:New "TextLabel" {
									Name = "StatusLabel",
									LayoutOrder = 2,
									AutomaticSize = Enum.AutomaticSize.Y,
									BackgroundTransparency = 1,
									Size = UDim2.fromScale(1, 0),
									FontFace = scope:Computed(function(use)
										return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Regular))
									end),
									Text = scope:Computed(function(use)
										if use(isResolving) then return "Searching..." end
										return use(resolveError) :: string
									end),
									TextColor3 = scope:Computed(function(use)
										if use(isResolving) then return use(Theme.Color.NeutralContentDark) end
										return use(Theme.Color.Error)
									end),
									TextSize = Theme.TextSize.Label,
									TextXAlignment = Enum.TextXAlignment.Left,
									Visible = scope:Computed(function(use)
										return use(isResolving) or #(use(resolveError) :: string) > 0
									end),
									[Children] = {
										scope:New "UIPadding" {
											PaddingLeft = UDim.new(0, 12),
											PaddingRight = UDim.new(0, 12),
											PaddingBottom = UDim.new(0, 4),
										},
									},
								},

								scope:New "TextLabel" {
									Name = "EmptyState",
									LayoutOrder = 3,
									AutomaticSize = Enum.AutomaticSize.Y,
									BackgroundTransparency = 1,
									Size = UDim2.fromScale(1, 0),
									FontFace = scope:Computed(function(use)
										return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Regular))
									end),
									Text = scope:Computed(function(use)
										local flow = use(addFlow)
										if flow == "Group" then return "No groups yet - search a group ID above to add" end
										if flow == "Product" then return "No products yet - pick a type and search an ID above" end
										return "Nobody here yet - search a name or ID above to add"
									end),
									TextColor3 = Theme.Color.NeutralContentDark,
									TextSize = Theme.TextSize.Subtitle,
									TextWrapped = true,
									TextXAlignment = Enum.TextXAlignment.Center,
									Visible = scope:Computed(function(use)
										if not use(canAdd) then return false end
										local cfg = use(props.config) :: ItemSelectorConfig?
										if not cfg then return false end
										local items = use(cfg.allItems :: any) :: { PickerItem }
										return #items == 0
									end),
									[Children] = {
										scope:New "UIPadding" {
											PaddingTop = UDim.new(0, 4),
											PaddingLeft = UDim.new(0, 4),
										},
									},
								},
							},
						},
					}),
				},
			},

			scope:New "Frame" {
				Name = "Divider",
				LayoutOrder = 2,
				Size = UDim2.new(1, 0, 0, 1),
				BackgroundColor3 = Theme.Color.NeutralStroke,
				Visible = scope:Computed(function(use) return not use(limitPickerToOneItem) end),
			},

			scope:New "Frame" {
				Name = "BottomBar",
				LayoutOrder = 3,
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 0),
				Visible = scope:Computed(function(use) return not use(limitPickerToOneItem) end),

				[Children] = {
					scope:New "UIPadding" {
						Name = "UIPadding",
						PaddingBottom = UDim.new(0, 4),
						PaddingLeft = UDim.new(0, 0),
						PaddingRight = UDim.new(0, 0),
						PaddingTop = UDim.new(0, 14),
					},

					Pressable(scope, {
						name = "ConfirmButton",
						automaticSize = Enum.AutomaticSize.Y,
						backgroundColor = confirmBgColor,
						size = UDim2.fromScale(1, 0),

						onActivate = function()
							local cfg = peekConfig()
							if cfg and cfg.onConfirm then
								cfg.onConfirm()
							end
							if props.onConfirmBack then
								props.onConfirmBack()
							end
						end,

						[Children] = {
							scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
							scope:New "UIPadding" {
								PaddingTop = UDim.new(0, 8),
								PaddingBottom = UDim.new(0, 8),
								PaddingLeft = UDim.new(0, 24),
								PaddingRight = UDim.new(0, 24),
							},
							scope:New "UIStroke" {
								ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
								Color = Color3.new(1, 1, 1),
								[Children] = {
									scope:New "UIGradient" {
										Color = confirmStrokeGradient,
										Rotation = 90,
									},
								},
							},
							scope:New "UIListLayout" {
								FillDirection = Enum.FillDirection.Horizontal,
								HorizontalAlignment = Enum.HorizontalAlignment.Center,
								VerticalAlignment = Enum.VerticalAlignment.Center,
								SortOrder = Enum.SortOrder.LayoutOrder,
							},
							scope:New "TextLabel" {
								Name = "Label",
								AutomaticSize = Enum.AutomaticSize.XY,
								BackgroundTransparency = 1,
								Size = UDim2.fromOffset(0, 0),
								FontFace = scope:Computed(function(use)
									return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
								end),
								RichText = true,
								Text = scope:Computed(function(use)
									local count = use(selectedCount)
									return if count == 0 then "Confirm" else string.format("Confirm (%d)", count)
								end),
								TextColor3 = confirmTextColor,
								TextSize = Theme.TextSize.Subtitle,
							},
						},
					}),
				},				},
				},
			},

		},
	}
end
