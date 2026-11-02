--!strict


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope

type RenderedEntry = {
	item: any,
	key: string?,
	itemScope: Fusion.Scope,
	instance: Instance,
}

export type Props = {
	items: Fusion.UsedAs<{ any }>,
	visibleItems: Fusion.UsedAs<{ any }>?, -- filtered subset, toggles Visible only
	itemKey: ((item: any) -> string)?, -- stable row identity, enables incremental diffing on list change
	renderItem: (scope: Scope, item: any) -> Instance,
	batchSize: number?,
	batchInterval: number?,
	deconstructInterval: number?,
	padding: UDim?,
	layoutOrder: Fusion.UsedAs<number>?,
	size: Fusion.UsedAs<UDim2>?,
	idle: Fusion.UsedAs<boolean>?,
	idleGrace: number?,
	parentScrollingFrame: ScrollingFrame?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local batchSize = props.batchSize or 4
	local batchBudgetMs = 6
	local batchInterval = if props.batchInterval ~= nil then props.batchInterval else 0.01
	local deconstructInterval = if props.deconstructInterval ~= nil then props.deconstructInterval else 0.03
	local idleGrace = props.idleGrace or 1
	local scrollingFrame = props.parentScrollingFrame
	local itemKey = props.itemKey

	local entries: { RenderedEntry } = {}
	local entriesByKey: { [string]: RenderedEntry } = {}
	local builtCount = 0
	local lastStreamedList: { any }? = nil

	-- Destroying hundreds of removed rows in one frame froze preview toggles for over a second, so they retire a few per frame instead
	local retiredScopes: { Fusion.Scope } = {}
	local retirePumpRunning = false

	local destroyed = false
	table.insert(scope, function()
		destroyed = true
		for index = #entries, 1, -1 do
			Fusion.doCleanup(entries[index].itemScope)
		end
		for index = #retiredScopes, 1, -1 do
			Fusion.doCleanup(retiredScopes[index])
		end
		table.clear(entries)
		table.clear(entriesByKey)
		table.clear(retiredScopes)
		builtCount = 0
	end)

	local function pumpRetired()
		if retirePumpRunning or #retiredScopes == 0 then return end
		retirePumpRunning = true
		task.spawn(function()
			while not destroyed and #retiredScopes > 0 do
				task.wait()
				if destroyed then break end
				debug.profilebegin("HD_StreamRetire")
				local pumpStart = os.clock()
				while #retiredScopes > 0 and (os.clock() - pumpStart) * 1000 < 4 do
					local retired = table.remove(retiredScopes) :: Fusion.Scope
					Fusion.doCleanup(retired)
				end
				debug.profileend()
			end
			retirePumpRunning = false
		end)
	end

	local epoch = 0

	local rootFrame: Frame? = nil
	local rootFrameParent: Instance? = nil
	local listLayout: UIListLayout? = nil

	local function detachForDeconstruct()
		if scrollingFrame then
			scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.None
		end
		if rootFrame then
			rootFrameParent = rootFrame.Parent
			rootFrame.Parent = nil
		end
	end

	local function reattachForConstruct()
		if rootFrame and rootFrameParent then
			rootFrame.Parent = rootFrameParent
		end
		if scrollingFrame then
			scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
		end
	end

	local filterSet: { [any]: true }? = nil

	local function applyFilter()
		local set = filterSet
		debug.profilebegin("HD_ApplyFilter")
		for _, entry in entries do
			(entry.instance :: any).Visible = set == nil or set[entry.item] == true
		end
		debug.profileend()
	end

	if props.visibleItems ~= nil then
		scope:Observer(props.visibleItems :: any):onBind(function()
			local filtered: { any } = Fusion.peek(props.visibleItems :: any) :: any
			if type(filtered) ~= "table" then
				filterSet = nil
			else
				local set: { [any]: true } = {}
				for _, item in filtered do
					set[item] = true
				end
				filterSet = set
			end
			-- Defer to avoid applying mid-graph-update
			task.defer(function()
				if not destroyed then applyFilter() end
			end)
		end)
	end

	local function buildOne(item: any, layoutOrder: number, key: string?)
		local itemScope = Fusion.scoped(Fusion)
		debug.profilebegin("HD_BuildItem")
		local instance = props.renderItem(itemScope, item)
		debug.profileend()
		;(instance :: any).LayoutOrder = layoutOrder
		;(instance :: any).Parent = rootFrame
		if filterSet ~= nil then
			(instance :: any).Visible = filterSet[item] == true
		end
		local entry: RenderedEntry = { item = item, key = key, itemScope = itemScope, instance = instance }
		table.insert(entries, entry)
		if key ~= nil then
			entriesByKey[key] = entry
		end
	end

	local function destroyLast()
		local count = #entries
		if count == 0 then return end
		local entry = entries[count]
		entries[count] = nil :: any
		if entry.key ~= nil and entriesByKey[entry.key] == entry then
			entriesByKey[entry.key] = nil
		end
		Fusion.doCleanup(entry.itemScope)
	end

	-- Rows whose key survives with the same item identity stay alive, so a remote
	-- change to one entry no longer tears down the whole list
	local function diffStream(all: { any }, myEpoch: number)
		local keyOf = itemKey :: (any) -> string
		local targetOrder: { [string]: number } = {}
		local targetItem: { [string]: any } = {}
		local orderedKeys: { string } = {}
		for index, item in all do
			local key = keyOf(item)
			if targetOrder[key] ~= nil then
				warn(`HD Admin StreamList: duplicate itemKey '{key}' ignored`)
				continue
			end
			targetOrder[key] = index
			targetItem[key] = item
			table.insert(orderedKeys, key)
		end

		for index = #entries, 1, -1 do
			local entry = entries[index]
			local key = entry.key :: string
			local newIndex = targetOrder[key]
			if newIndex ~= nil and targetItem[key] == entry.item then
				(entry.instance :: any).LayoutOrder = newIndex
				targetItem[key] = nil
			else
				table.remove(entries, index)
				if entriesByKey[key] == entry then
					entriesByKey[key] = nil
				end
				;(entry.instance :: any).Parent = nil
				table.insert(retiredScopes, entry.itemScope)
			end
		end
		pumpRetired()

		local pending: { { key: string, item: any, order: number } } = {}
		for _, key in orderedKeys do
			local item = targetItem[key]
			if item ~= nil then
				table.insert(pending, {key = key, item = item, order = targetOrder[key]})
			end
		end
		builtCount = #entries
		if #pending == 0 then return end
		local built = 0
		local function step()
			if destroyed or epoch ~= myEpoch then return end
			debug.profilebegin("HD_StreamBatch")
			local batchStart = os.clock()
			local builtThisBatch = 0
			while built < #pending and builtThisBatch < batchSize do
				built += 1
				builtThisBatch += 1
				local pendingEntry = pending[built]
				buildOne(pendingEntry.item, pendingEntry.order, pendingEntry.key)
				if (os.clock() - batchStart) * 1000 >= batchBudgetMs then
					break
				end
			end
			builtCount = #entries
			debug.profileend()
			if built >= #pending then return end
			if batchInterval > 0 then
				task.delay(batchInterval, step)
			else
				task.defer(step)
			end
		end
		task.defer(step)
	end

	local function startStream(all: { any })
		epoch += 1
		local myEpoch = epoch
		local total = #all
		reattachForConstruct()
		if itemKey ~= nil then
			lastStreamedList = all
			diffStream(all, myEpoch)
			return
		end
		-- New list ref = full rebuild, same list = resume from builtCount
		if all ~= lastStreamedList or builtCount > total then
			debug.profilebegin("HD_StreamTeardown")
			for index = #entries, 1, -1 do
				local entry = entries[index]
				;(entry.instance :: any).Parent = nil
				table.insert(retiredScopes, entry.itemScope)
				entries[index] = nil :: any
			end
			table.clear(entriesByKey)
			debug.profileend()
			pumpRetired()
			builtCount = 0
		end
		lastStreamedList = all
		local function step()
			if destroyed or epoch ~= myEpoch then return end
			if builtCount >= total then return end
			debug.profilebegin("HD_StreamBatch")
			local batchStart = os.clock()
			local builtThisBatch = 0
			while builtCount < total and builtThisBatch < batchSize do
				builtCount += 1
				builtThisBatch += 1
				buildOne(all[builtCount], builtCount)
				if (os.clock() - batchStart) * 1000 >= batchBudgetMs then
					break
				end
			end
			debug.profileend()
			if batchInterval > 0 then
				task.delay(batchInterval, step)
			else
				task.defer(step)
			end
		end
		task.defer(step)
	end

	local function startDeconstruct()
		epoch += 1
		local myEpoch = epoch
		detachForDeconstruct()
		local function step()
			if destroyed or epoch ~= myEpoch then return end
			if builtCount <= 0 then return end
			destroyLast()
			builtCount -= 1
			if builtCount <= 0 then
				return
			end
			if deconstructInterval > 0 then
				task.delay(deconstructInterval, step)
			else
				task.defer(step)
			end
		end
		step()
	end

	local allItemsSignal = scope:Computed(function(use)
		local all: { any } = use(props.items :: any) :: any
		return if type(all) == "table" then all else {} :: { any }
	end)
	-- A preview toggle republishes many entries at once, so the recomputes coalesce into one stream pass per frame
	local streamQueued = false
	scope:Observer(allItemsSignal):onBind(function()
		if streamQueued then return end
		streamQueued = true
		task.defer(function()
			streamQueued = false
			if destroyed then return end
			startStream(Fusion.peek(allItemsSignal))
		end)
	end)

	if props.idle ~= nil then
		scope:Observer(props.idle :: any):onChange(function()
			local isIdle = Fusion.peek(props.idle :: any)
			if isIdle then
				epoch += 1
				local myEpoch = epoch
				task.delay(idleGrace, function()
					if destroyed or epoch ~= myEpoch then return end
					startDeconstruct()
				end)
			else
				startStream(Fusion.peek(allItemsSignal))
			end
		end)
	end

	rootFrame = scope:New "Frame" {
		Name = "StreamList",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = props.layoutOrder,
		Size = props.size or UDim2.fromScale(1, 0),

		[Children] = {
			scope:New "UIListLayout" {
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				Padding = props.padding or UDim.new(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
			},
		},
	}

	return rootFrame
end
