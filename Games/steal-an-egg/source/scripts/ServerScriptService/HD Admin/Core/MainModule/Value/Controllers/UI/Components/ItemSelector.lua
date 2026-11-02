--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local InputRow = require(script.Parent.InputRow)
local Pressable = require(frontend.Components.Pressable)
local Navigate = require(frontend.Util.Navigate)
local Players = game:GetService("Players")
local Parser: any = nil
local function getParser(): any
	if not Parser then Parser = require(modules.Parser) end
	return Parser
end


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	title: string?,
	default: any?,
	canAnyUserBeAddedToPicker: boolean?,
	displayServerPlayersInPicker: boolean?,
	displayQualifiersInPicker: boolean?,
	pickerGetter: (() -> { any })?,
	presetGetter: (() -> { any })?,
	itemsGetter: ((scope: any) -> any)?,
	maxItems: number?,
	sharedCustomUsers: Fusion.Value<{ [string]: any }>?,
	value: Fusion.Value<any>?,
	onOpen: ((config: any) -> ())?,
	isOrderedPicker: boolean?,
	limitPickerToOneItem: boolean?,
	singleSelection: boolean?, -- checkbox UI stays but picking one clears the rest
	labelSize: UDim2?,
	labelTextSize: number?,
	itemToEntry: ((item: PickerItem) -> any)?,
	entryToKey: ((entry: any) -> string?)?,
	hydrateEntry: ((entry: any) -> PickerItem?)?,
	addFlow: ("User" | "Product" | "Group")?,
	autoOpen: Fusion.Value<boolean>?, -- host sets true to open on arrival, consumed back to false
}
export type PickerItem = {
	key: string,
	label: string,
	header: string,
	body: string?,
	icon: string?,
	rawValue: any,
	category: "player" | "qualifier" | "custom" | "preset",
	configurable: string?,
	hiddenFromPicker: boolean?, -- kept in allItems for summary matching, filtered from the open picker
}


-- LOCAL FUNCTIONS
local function playerToItem(player: Player): PickerItem
	return {
		key = tostring(player.UserId),
		label = player.DisplayName .. " @" .. player.Name,
		header = player.DisplayName,
		body = "@" .. player.Name,
		icon = "https://www.roblox.com/headshot-thumbnail/image?userId="
			.. player.UserId .. "&width=48&height=48&format=png",
		rawValue = player, -- unparsePlayer handles Player instances -> "@Name"
		category = "player",
	}
end

local function toolToItem(tool: Tool): PickerItem
	local textureId: string = (tool :: any).TextureId or ""
	return {
		key = tool.Name,
		label = tool.Name,
		header = tool.Name,
		icon = if textureId ~= "" then textureId else nil,
		rawValue = tool,
		category = "qualifier",
	}
end

local function getQualifierItems(): { PickerItem }
	local ok, Qualifiers = pcall(require, modules.Parser.Qualifiers)
	if not ok then return {} end
	local result: { any } = {}
	local all = (Qualifiers :: any).getAll()
	for key, info in all do
		if (info :: any).isHidden then continue end
		local keyStr = tostring(key)
		local keyLower = keyStr:lower()
		local desc: string? = (info :: any).description
		table.insert(result, {
			key = "qualifier:" .. keyLower,
			label = keyStr .. (if desc and #desc > 0 then " - " .. desc else ""),
			header = keyStr,
			body = if desc and #desc > 0 then desc else nil,
			rawValue = keyLower,
			category = "qualifier",
			configurable = (info :: any).configurable,
			displayOrder = (info :: any).displayOrder,
		})
	end
	table.sort(result, function(itemA, itemB)
		local aOrder: number? = itemA.displayOrder
		local bOrder: number? = itemB.displayOrder
		if aOrder and bOrder then
			return aOrder < bOrder
		elseif aOrder then
			return true
		elseif bOrder then
			return false
		else
			return itemA.key < itemB.key
		end
	end)
	return result :: { PickerItem }
end

local function getServerPlayerItems(): { PickerItem }
	local result: { PickerItem } = {}
	for _, player in Players:GetPlayers() do
		table.insert(result, playerToItem(player))
	end
	return result
end

-- writeBack serialises configurable picks as capsule tokens like delay(5), so
-- matching them back against item rawValues needs the config half split off
local function splitCapsule(value: any): (any, string?)
	if typeof(value) ~= "string" then
		return value, nil
	end
	local base, config = (value :: string):match("^(.-)%((.*)%)$")
	if base and #base > 0 then
		return base, config
	end
	return value, nil
end


-- COMPONENT
return function(scope: Scope, props: Props)
	local canAddAnyUser = props.canAnyUserBeAddedToPicker == true
	local title: string = props.title or (if canAddAnyUser then "Users" else "")
	local maxItems: number = props.maxItems or math.huge
	local pickerGetter = props.pickerGetter
	local presetGetter = props.presetGetter
	local showServerPlayers = props.displayServerPlayersInPicker == true
	local showQualifiers = props.displayQualifiersInPicker == true
	local itemToEntry = props.itemToEntry
	local entryToKey = props.entryToKey
	-- Structured (table) values compare by key instead of rawValue
	local usesEntries = itemToEntry ~= nil and entryToKey ~= nil

	local function getPresetItems(): { PickerItem }
		if not presetGetter then return {} end
		local raw = presetGetter()
		local result: { PickerItem } = {}
		for _, item in raw do
			if typeof(item) == "table" and (item :: any).key ~= nil then
				local copy = table.clone(item :: any) :: any
				copy.category = "preset"
				table.insert(result, copy :: PickerItem)
			end
		end
		return result
	end

	local function appendPresets(result: { PickerItem })
		if not presetGetter then return end
		local existingKeys: { [string]: boolean } = {}
		for _, item in result do existingKeys[item.key] = true end
		for _, pi in getPresetItems() do
			if not existingKeys[pi.key] then
				table.insert(result, pi)
			end
		end
	end

	local function buildItems(): { PickerItem }
		if pickerGetter then
			local raw = pickerGetter()
			local result: { PickerItem } = {}
			for _, item in raw do
				if typeof(item) == "Instance" and item:IsA("Player") then
					table.insert(result, playerToItem(item :: Player))
				elseif typeof(item) == "Instance" and (item :: Instance):IsA("Tool") then
					table.insert(result, toolToItem(item :: Tool))
				elseif typeof(item) == "table" and typeof((item :: any).name) == "string" and (item :: any).textureId ~= nil then
					local toolInfo = item :: any
					local iconId: string = toolInfo.textureId or ""
					table.insert(result, {
						key = toolInfo.name,
						label = toolInfo.name,
						header = toolInfo.name,
						icon = if iconId ~= "" then iconId else "rbxassetid://124010401308798",
						rawValue = toolInfo.name,
						category = "qualifier",
					})
				elseif typeof(item) == "string" then
					table.insert(result, { key = item, label = item, header = item, rawValue = item, category = "qualifier" })
				elseif typeof(item) == "table" and (item :: any).key ~= nil and (item :: any).category ~= nil then
					table.insert(result, item :: PickerItem)
				elseif typeof(item) == "EnumItem" then
					local name = (item :: EnumItem).Name
					table.insert(result, { key = tostring(item), label = name, header = name, rawValue = item, category = "qualifier" })
				else
					local text = tostring(item)
					table.insert(result, { key = text, label = text, header = text, rawValue = text, category = "qualifier" })
				end
			end
			appendPresets(result)
			return result
		elseif showServerPlayers or showQualifiers then
			local result: { PickerItem } = {}
			if showServerPlayers then
				for _, item in getServerPlayerItems() do
					table.insert(result, item)
				end
			end
			if showQualifiers then
				for _, qi in getQualifierItems() do
					table.insert(result, qi)
				end
			end
			if canAddAnyUser and props.sharedCustomUsers then
				local shared = Fusion.peek(props.sharedCustomUsers :: any) :: { [string]: PickerItem }
				local existingKeys: { [string]: boolean } = {}
				for _, item in result do existingKeys[item.key] = true end
				for key, item in shared do
					if not existingKeys[key] then
						table.insert(result, item)
					end
				end
			end
			appendPresets(result)
			return result
		end
		if canAddAnyUser and props.sharedCustomUsers then
			local result: { PickerItem } = {}
			local shared = Fusion.peek(props.sharedCustomUsers :: any) :: { [string]: PickerItem }
			for _, item in shared do
				table.insert(result, item)
			end
			appendPresets(result)
			return result
		end
		if presetGetter then
			local result: { PickerItem } = {}
			appendPresets(result)
			return result
		end
		return {}
	end

	local allItems: Fusion.Value<{ PickerItem }>
	if props.itemsGetter then
		local source = (props.itemsGetter :: any)(scope)
		if typeof((source :: any).set) == "function" then
			allItems = source
		else
			-- A Computed has no set, so mirror it into a Value that local edits can write
			allItems = scope:Value(Fusion.peek(source))
			scope:Observer(source):onChange(function()
				allItems:set(Fusion.peek(source))
			end)
		end
	else
		allItems = scope:Value(buildItems())
	end
	local selectedKeys: Fusion.Value<{ [string]: boolean }> = scope:Value({})
	local pendingKeys: Fusion.Value<{ [string]: boolean }> = scope:Value({})
	local configurableValues: Fusion.Value<{[string]: string}> = scope:Value({})
	local isOrderedPicker = props.isOrderedPicker == true
	local selectedOrderedKeys: Fusion.Value<{string}> = scope:Value({})
	local pendingOrderedKeys: Fusion.Value<{string}> = scope:Value({})
	local isPickerOpen: Fusion.Value<boolean> = scope:Value(false)
	local previewKey: string? = nil

	local seedSource: { any }? = nil
	if props.value then
		local existing = Fusion.peek(props.value)
		if type(existing) == "table" and next(existing :: any) ~= nil then
			seedSource = existing :: { any }
		elseif existing ~= nil and type(existing) ~= "table" then
			seedSource = { existing }
		end
	end
	local isRestoring = seedSource ~= nil
	if not seedSource and props.default ~= nil then
		if type(props.default) == "table" then
			seedSource = props.default
		else
			seedSource = { props.default }
		end
	end
	if seedSource then
		local initKeys: { [string]: boolean } = {}
		if usesEntries then
			local seedKeyList: { string } = {}
			local seedKeySet: { [string]: boolean } = {}
			local entryByKey: { [string]: any } = {}
			for _, entry in seedSource :: { any } do
				local key = (entryToKey :: any)(entry)
				if typeof(key) == "string" then
					seedKeySet[key] = true
					entryByKey[key] = entry
					table.insert(seedKeyList, key)
				end
			end
			-- Fill in entries missing from allItems, yields are safe in this one-shot mount path
			local hydrateEntry = props.hydrateEntry
			if hydrateEntry then
				local current = Fusion.peek(allItems) :: { PickerItem }
				local existingKeys: { [string]: boolean } = {}
				for _, item in current do existingKeys[item.key] = true end
				local additions: { PickerItem } = {}
				for _, key in seedKeyList do
					if not existingKeys[key] then
						local ok, synth = pcall(hydrateEntry, entryByKey[key])
						if ok and typeof(synth) == "table" and (synth :: any).key ~= nil then
							table.insert(additions, synth :: PickerItem)
							existingKeys[(synth :: any).key] = true
						end
					end
				end
				if #additions > 0 then
					local merged = table.clone(current)
					for _, addition in additions do table.insert(merged, addition) end
					allItems:set(merged)
				end
			end
			for _, item in Fusion.peek(allItems) do
				if seedKeySet[item.key] then
					initKeys[item.key] = true
				end
			end
		else
			local seedSet: { [any]: boolean } = {}
			local seedConfigs: { [any]: string } = {}
			for _, value in seedSource :: { any } do
				local base, config = splitCapsule(value)
				if config ~= nil then
					seedConfigs[base] = config
				else
					seedSet[value] = true
				end
			end
			local initConfigs: { [string]: string } = {}
			for _, item in Fusion.peek(allItems) do
				if seedSet[item.rawValue] then
					initKeys[item.key] = true
				elseif seedConfigs[item.rawValue] ~= nil and (item :: any).configurable then
					initKeys[item.key] = true
					initConfigs[item.key] = seedConfigs[item.rawValue]
				end
			end
			if next(initConfigs) ~= nil then
				configurableValues:set(initConfigs)
			end
			-- A seed that only fills selectedKeys would still summarise as None
			if isOrderedPicker then
				local orderedSeed: { string } = {}
				for _, value in seedSource :: { any } do
					local base, config = splitCapsule(value)
					for _, item in Fusion.peek(allItems) do
						local matches = if config ~= nil
							then item.rawValue == base and (item :: any).configurable ~= nil
							else item.rawValue == value
						if matches then
							table.insert(orderedSeed, item.key)
							break
						end
					end
				end
				if #orderedSeed > 0 then
					selectedOrderedKeys:set(orderedSeed)
				end
			end
		end
		selectedKeys:set(initKeys)
		-- Skip writeBack when restoring, only write on fresh default seed
		if not isRestoring and props.value then
			local result: { any } = {}
			for _, item in Fusion.peek(allItems) do
				if initKeys[item.key] then
					table.insert(result, if usesEntries then (itemToEntry :: any)(item) else item.rawValue)
				end
			end
			props.value:set(result)
		end
	end

	-- source tells us who changed. External writes refresh PickerItem rawValues,
	-- local allItems changes must not be clobbered with the stale external value
	local isResyncing = false
	local function resyncFromValue(source: ("external" | "items")?)
		if not props.value then return end
		if isResyncing then return end
		local ext = Fusion.peek(props.value :: any)
		local extArr: { any }
		if type(ext) == "table" then
			extArr = ext :: { any }
		elseif ext ~= nil then
			extArr = { ext }
		else
			extArr = {}
		end
		local items = Fusion.peek(allItems) :: { PickerItem }
		if source == "external" and usesEntries and entryToKey then
			local newEntryByKey: {[string]: any} = {}
			for _, entry in extArr do
				local key = (entryToKey :: any)(entry)
				if typeof(key) == "string" then
					newEntryByKey[key] = entry
				end
			end
			-- Replace, don't mutate. Only a new table identity makes ForValues rebuild the row
			local replacements: {[number]: PickerItem}? = nil
			for index, item in items do
				local newEntry = newEntryByKey[item.key]
				if newEntry ~= nil and item.rawValue ~= newEntry then
					local newItem: PickerItem = table.clone(item) :: any
					;(newItem :: any).rawValue = newEntry
					if typeof(newEntry) == "table" then
						local entryType = (newEntry :: any).type
						if entryType == "AnyMember" then
							(newItem :: any).roleLabel = "All Roles"
						elseif entryType == "SpecificRoles" and typeof((newEntry :: any).roles) == "table" then
							local names: {string} = {}
							for _, role in (newEntry :: any).roles :: {any} do
								if typeof(role) == "table" then
									local nm = (role :: any).name
									if typeof(nm) == "string" and #nm > 0 then
										table.insert(names, nm)
									elseif typeof((role :: any).rank) == "number" then
										table.insert(names, "Rank " .. tostring((role :: any).rank))
									end
								end
							end
							;(newItem :: any).roleLabel = if #names == 0 then "All Roles" else table.concat(names, ", ")
						end
					end
					if replacements == nil then replacements = {} end
					;(replacements :: {[number]: PickerItem})[index] = newItem
				end
			end
			if replacements ~= nil then
				local merged = table.clone(items)
				for index, newItem in replacements :: {[number]: PickerItem} do
					merged[index] = newItem
				end
				-- Gate the write, re-entering resyncFromValue reads as cyclic to Fusion
				isResyncing = true
				allItems:set(merged)
				isResyncing = false
				items = Fusion.peek(allItems) :: { PickerItem }
			end
		end
		local currentKeys = Fusion.peek(selectedKeys) :: { [string]: boolean }
		local extKeySet: { [string]: boolean } = {}
		if usesEntries then
			-- Mirrors the mount-time seeding for live updates. The renderer iterates
			-- allItems, so an entry missing there stays invisible
			local hydrateEntry = props.hydrateEntry
			local existingKeys: { [string]: boolean }? = nil
			if hydrateEntry then
				existingKeys = {}
				for _, item in items do (existingKeys :: any)[item.key] = true end
			end
			local additions: { PickerItem } = {}
			for _, entry in extArr do
				local key = (entryToKey :: any)(entry)
				if typeof(key) ~= "string" then continue end
				extKeySet[key] = true
				if hydrateEntry and not (existingKeys :: any)[key] then
					(existingKeys :: any)[key] = true
					local ok, synth = pcall(hydrateEntry, entry)
					if ok and typeof(synth) == "table" and (synth :: any).key ~= nil then
						table.insert(additions, synth :: PickerItem)
					end
				end
			end
			if #additions > 0 then
				local merged = table.clone(items)
				for _, addition in additions do table.insert(merged, addition) end
				isResyncing = true
				allItems:set(merged)
				isResyncing = false
				items = Fusion.peek(allItems) :: { PickerItem }
			end
		else
			local extRawSet: { [any]: boolean } = {}
			local extConfigs: { [any]: string } = {}
			for _, value in extArr do
				local base, config = splitCapsule(value)
				if config ~= nil then
					extConfigs[base] = config
				else
					extRawSet[value] = true
				end
			end
			for _, item in items do
				if extRawSet[item.rawValue] then
					extKeySet[item.key] = true
				elseif extConfigs[item.rawValue] ~= nil and (item :: any).configurable then
					extKeySet[item.key] = true
				end
			end
		end
		local unchanged = true
		for key in extKeySet do
			if not currentKeys[key] then unchanged = false; break end
		end
		if unchanged then
			for key in currentKeys do
				if not extKeySet[key] then unchanged = false; break end
			end
		end
		if unchanged then return end
		isResyncing = true
		selectedKeys:set(extKeySet)
		if isOrderedPicker then
			local newOrdered: { string } = {}
			if usesEntries then
				for _, entry in extArr do
					local key = (entryToKey :: any)(entry)
					if typeof(key) == "string" then table.insert(newOrdered, key) end
				end
			else
				local keyByRaw: { [any]: string } = {}
				local keyByConfigurableRaw: { [any]: string } = {}
				for _, item in items do
					keyByRaw[item.rawValue] = item.key
					if (item :: any).configurable then
						keyByConfigurableRaw[item.rawValue] = item.key
					end
				end
				for _, value in extArr do
					local base, config = splitCapsule(value)
					local key = if config ~= nil then keyByConfigurableRaw[base] else keyByRaw[value]
					if key then table.insert(newOrdered, key) end
				end
			end
			selectedOrderedKeys:set(newOrdered)
		end
		isResyncing = false
	end
	if props.value ~= nil then
		scope:Observer(props.value :: any):onChange(function() resyncFromValue("external") end)
		-- Re-seed when allItems arrives late, otherwise the summary stays None until nudged
		scope:Observer(allItems :: any):onChange(function() resyncFromValue("items") end)
	end

	if showServerPlayers then
		local conn1 = Players.PlayerAdded:Connect(function()
			allItems:set(buildItems())
		end)
		local conn2 = Players.PlayerRemoving:Connect(function()
			allItems:set(buildItems())
		end)
		table.insert(scope :: any, function()
			conn1:Disconnect()
			conn2:Disconnect()
		end)
	end

	if canAddAnyUser and props.sharedCustomUsers then
		scope:Observer(props.sharedCustomUsers :: any):onChange(function()
			local shared = Fusion.peek(props.sharedCustomUsers :: any) :: { [string]: PickerItem }
			local current = Fusion.peek(allItems)
			local existingKeys: { [string]: boolean } = {}
			for _, item in current do existingKeys[item.key] = true end
			local newItems = table.clone(current)
			local changed = false
			for key, item in shared do
				if not existingKeys[key] then
					table.insert(newItems, item)
					changed = true
				end
			end
			local filtered: { PickerItem } = {}
			for _, item in newItems do
				if item.category == "custom" and not shared[item.key] then
					changed = true
				else
					table.insert(filtered, item)
				end
			end
			if changed then
				allItems:set(filtered)
			end
		end)
	end

	local function writeBack()
		if not props.value then return end
		local configVals = Fusion.peek(configurableValues)
		local result: { any } = {}
		local function serialize(item: PickerItem): any
			if usesEntries then
				return (itemToEntry :: any)(item)
			end
			local val = item.rawValue
			local configText = configVals[item.key]
			if typeof(configText) == "string" and #configText > 0 then
				val = getParser().addCapsule(tostring(val), configText)
			end
			return val
		end
		if isOrderedPicker then
			local orderedKeys = Fusion.peek(selectedOrderedKeys) :: {string}
			local itemsByKey: {[string]: PickerItem} = {}
			for _, item in Fusion.peek(allItems) do
				itemsByKey[item.key] = item :: PickerItem
			end
			for _, key in orderedKeys do
				local item = itemsByKey[key]
				if item then
					table.insert(result, serialize(item))
				end
			end
		else
			-- Keep props.value order so a no-change Confirm doesn't reshuffle the array
			-- and trip the role page's deep-equal pending-change check
			local keys = Fusion.peek(selectedKeys)
			local items = Fusion.peek(allItems)
			local itemsByKey: {[string]: PickerItem} = {}
			for _, item in items do
				itemsByKey[item.key] = item
			end
			local includedKeys: {[string]: boolean} = {}
			local current = Fusion.peek(props.value)
			if typeof(current) == "table" then
				for _, entry in current :: {any} do
					local key: string? = nil
					if usesEntries and entryToKey then
						key = (entryToKey :: any)(entry)
					else
						for _, item in items do
							if item.rawValue == entry then key = item.key; break end
						end
					end
					if typeof(key) == "string" and keys[key] and not includedKeys[key] then
						local item = itemsByKey[key]
						if item then
							includedKeys[key] = true
							table.insert(result, serialize(item))
						end
					end
				end
			end
			for _, item in items do
				if keys[item.key] and not includedKeys[item.key] then
					table.insert(result, serialize(item))
				end
			end
		end
		props.value:set(result)
	end

	local function onRemoveCustomUser(key: string)
		if previewKey == key then previewKey = nil end
		local items = Fusion.peek(allItems)
		local newItems: { PickerItem } = {}
		for _, item in items do
			if item.key ~= key then
				table.insert(newItems, item)
			end
		end
		allItems:set(newItems)
		if props.sharedCustomUsers then
			local shared = Fusion.peek(props.sharedCustomUsers :: any) :: { [string]: PickerItem }
			if shared[key] then
				local copy = table.clone(shared)
				copy[key] = nil
				;(props.sharedCustomUsers :: any):set(copy)
			end
		end
		local pCurrent = Fusion.peek(pendingKeys)
		if pCurrent[key] then
			local pCopy = table.clone(pCurrent)
			pCopy[key] = nil
			pendingKeys:set(pCopy)
		end
		local sCurrent = Fusion.peek(selectedKeys)
		if sCurrent[key] then
			local sCopy = table.clone(sCurrent)
			sCopy[key] = nil
			selectedKeys:set(sCopy)
			writeBack()
		end
	end

	-- replacesKey removes that item and carries its selection over to the new one
	local function onAddItem(newItem: PickerItem, replacesKey: string?)
		if typeof(newItem) ~= "table" or typeof(newItem.key) ~= "string" then return end
		local items = Fusion.peek(allItems)
		local copy: { PickerItem } = {}
		local replacedSelectionWas = false
		local replacedPendingWas = false
		local skippedKey: string? = nil
		if typeof(replacesKey) == "string" then
			local sCurrent = Fusion.peek(selectedKeys) :: { [string]: boolean }
			local pCurrent = Fusion.peek(pendingKeys) :: { [string]: boolean }
			replacedSelectionWas = sCurrent[replacesKey] == true
			replacedPendingWas = pCurrent[replacesKey] == true
			for _, existing in items do
				if existing.key == replacesKey then
					skippedKey = replacesKey
				else
					table.insert(copy, existing)
				end
			end
		else
			for _, existing in items do
				if existing.key == newItem.key then return end
				table.insert(copy, existing)
			end
		end
		table.insert(copy, newItem)
		allItems:set(copy)
		-- Auto-select fresh adds, they added it from a sub-page so they want it picked
		local sCopy = table.clone(Fusion.peek(selectedKeys) :: { [string]: boolean })
		local pCopy = table.clone(Fusion.peek(pendingKeys) :: { [string]: boolean })
		if skippedKey then
			sCopy[skippedKey] = nil
			pCopy[skippedKey] = nil
			if replacedSelectionWas then sCopy[newItem.key] = true end
			if replacedPendingWas then pCopy[newItem.key] = true end
		else
			sCopy[newItem.key] = true
			pCopy[newItem.key] = true
		end
		selectedKeys:set(sCopy)
		pendingKeys:set(pCopy)
		writeBack()
		if props.sharedCustomUsers then
			local shared = Fusion.peek(props.sharedCustomUsers :: any) :: { [string]: PickerItem }
			local sharedCopy = table.clone(shared)
			if skippedKey then sharedCopy[skippedKey] = nil end
			if not sharedCopy[newItem.key] then
				sharedCopy[newItem.key] = newItem
			end
			;(props.sharedCustomUsers :: any):set(sharedCopy)
		end
	end

	-- Selecting the preview promotes it to a permanent custom, otherwise it gets dropped
	local function setPreview(item: PickerItem?)
		local items = Fusion.peek(allItems)
		local cleaned: { PickerItem } = {}
		for _, existing in items do
			if existing.key ~= previewKey then table.insert(cleaned, existing) end
		end
		previewKey = nil
		if typeof(item) == "table" and typeof((item :: any).key) == "string" then
			local exists = false
			for _, existing in cleaned do
				if existing.key == (item :: any).key then exists = true break end
			end
			if not exists then
				-- Front of allItems shows at the top of the Custom section
				table.insert(cleaned, 1, item :: PickerItem)
				previewKey = (item :: any).key
			end
		end
		isResyncing = true
		allItems:set(cleaned)
		isResyncing = false
	end

	scope:Observer(pendingKeys):onChange(function()
		local key = previewKey
		if key == nil then return end
		if not (Fusion.peek(pendingKeys) :: { [string]: boolean })[key] then return end
		previewKey = nil
		if props.sharedCustomUsers then
			for _, item in Fusion.peek(allItems) do
				if item.key == key then
					local shared = Fusion.peek(props.sharedCustomUsers :: any) :: { [string]: PickerItem }
					if not shared[key] then
						local copy = table.clone(shared)
						copy[key] = item
						;(props.sharedCustomUsers :: any):set(copy)
					end
					break
				end
			end
		end
	end)

	local summaryText = scope:Computed(function(use)
		if isOrderedPicker then
			local orderedKeys = use(selectedOrderedKeys :: any) :: {string}
			if #orderedKeys == 0 then return "None" end
			local itemsByKey: {[string]: PickerItem} = {}
			for _, item in use(allItems :: any) :: {PickerItem} do
				itemsByKey[item.key] = item
			end
			local names: {string} = {}
			for _, key in orderedKeys do
				local item = itemsByKey[key]
				if item then table.insert(names, item.header) end
			end
			return if #names > 0 then table.concat(names, ", ") else "None"
		else
			local keys = use(selectedKeys :: any) :: {[string]: boolean}
			local items = use(allItems :: any) :: { PickerItem }
			local names: { string } = {}
			for _, item in items do
				if keys[item.key] then
					table.insert(names, item.header)
				end
			end
			if #names == 0 then return "None" end
			return table.concat(names, ", ")
		end
	end)

	local summaryTransparency = scope:Computed(function(use)
		if isOrderedPicker then
			return if #(use(selectedOrderedKeys :: any) :: {string}) > 0 then 0 else 0.5
		end
		local keys = use(selectedKeys :: any) :: {[string]: boolean}
		for _ in keys do return 0 end
		return 0.5
	end)

	return InputRow(scope, {
		title = title,
		name = "ItemSelector",
		labelSize = props.labelSize,
		labelTextSize = props.labelTextSize,
		autoHeight = true,

		[Children] = (function()
			local function onOpenActivate()
				if not props.onOpen then return end
				-- Rebuild on open, the mount-time build can predate replicated data
				if not props.itemsGetter and not usesEntries and props.pickerGetter then
					allItems:set(buildItems())
				end
				isPickerOpen:set(true)
				pendingKeys:set(table.clone(Fusion.peek(selectedKeys :: any) :: { [string]: boolean }))
				if isOrderedPicker then
					pendingOrderedKeys:set(table.clone(Fusion.peek(selectedOrderedKeys :: any) :: {string}))
				end
				props.onOpen({
					title = title ~= "" and title or "Select",
					allItems = allItems,
					pendingKeys = pendingKeys,
					canAddAnyUser = canAddAnyUser,
					canAdd = canAddAnyUser or (props.addFlow == "Product") or (props.addFlow == "Group"),
					maxItems = maxItems,
					onAddItem = onAddItem,
					setPreview = setPreview,
					addFlow = props.addFlow or "User",
					onRemoveCustomUser = onRemoveCustomUser,
					configurableValues = configurableValues,
					pendingOrderedKeys = if isOrderedPicker then pendingOrderedKeys else nil,
					limitPickerToOneItem = props.limitPickerToOneItem == true,
					singleSelection = props.singleSelection == true,
					displayServerPlayersInPicker = props.displayServerPlayersInPicker == true,
					onConfirm = function()
						setPreview(nil)
						selectedKeys:set(table.clone(Fusion.peek(pendingKeys :: any) :: { [string]: boolean }))
						if isOrderedPicker then
							selectedOrderedKeys:set(table.clone(Fusion.peek(pendingOrderedKeys :: any) :: {string}))
						end
						writeBack()
						isPickerOpen:set(false)
					end,
				})
			end
			local openButton = scope:New "TextButton" {
				Name = "OpenButton",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 0),
				Text = "",
				[Fusion.OnEvent "Activated"] = onOpenActivate,

				[Children] = {
					scope:New "TextBox" {
						Name = "TextInput",
						Active = false,
						AutoLocalize = false,
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						ClearTextOnFocus = false,
						ClipsDescendants = true,
						Position = UDim2.new(0, 0, 0, 0),
						Size = UDim2.new(1, -26, 1, 0),
						FontFace = scope:Computed(function(use)
							return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
						end),
						Interactable = false,
						PlaceholderColor3 = Theme.Color.NeutralContentDark,
						PlaceholderText = "None",
						Selectable = false,
						Text = summaryText,
						TextColor3 = Theme.Color.BaseContent,
						TextEditable = false,
						TextSize = Theme.TextSize.Subtitle,
						TextTransparency = summaryTransparency,
						TextTruncate = Enum.TextTruncate.SplitWord,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Top,

						[Children] = {
							scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
						},
					},

					scope:New "ImageLabel" {
						Name = "ChevronIcon",
						AnchorPoint = Vector2.new(1, 0.5),
						BackgroundTransparency = 1,
						Image = "rbxassetid://78914100674850",
						ImageColor3 = Theme.Color.NeutralContentDark,
						Position = UDim2.new(1, 0, 0.5, 0),
						Rotation = 270,
						Size = UDim2.fromOffset(20, 20),
					},
				},
			}
			Navigate.registerActivate(openButton, onOpenActivate)

			if props.autoOpen ~= nil then
				local autoOpenDead = false
				local pending = false
				table.insert(scope :: any, function() autoOpenDead = true end)
				-- pending stops the mount check and the observer double-opening
				local function scheduleOpen()
					if autoOpenDead or pending then return end
					if Fusion.peek(props.autoOpen :: any) ~= true then return end
					pending = true
					-- Defer only the consume, setting autoOpen inside its own observer is
					-- a cyclic Value update. Opening stays immediate so Run doesn't slide in first
					task.defer(function()
						pending = false
						if not autoOpenDead then (props.autoOpen :: any):set(false) end
					end)
					onOpenActivate()
				end
				task.defer(scheduleOpen)
				scope:Observer(props.autoOpen :: any):onChange(scheduleOpen)
			end

			return { openButton }
		end)(),
	})
end
