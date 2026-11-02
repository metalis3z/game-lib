--!strict

--[[

Panels and sidebar notices share one pool, ordered by whichever was interacted
with most recently. A layer's ZIndex is its position in that pool, so the numbers
stay small no matter how long the session runs.

The layers pinned above the pool (top hints, centre messages, the emote preview
and the command bar) keep their own fixed ZIndex and never take part

--]]


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local UserInputService = game:GetService("UserInputService")
local Fusion = require(packages.Fusion)
local scope = Fusion.scoped({Value = Fusion.Value})
local LayerOrder = {}


-- TYPES
type Scope = Fusion.Scope


-- LOCAL STATE
local orderValue: Fusion.Value<{string}> = scope:Value({})
local groupById: {[string]: string} = {}
local instanceById: {[string]: GuiObject} = {}
local blockers: {() -> boolean} = {}
local connected = false


-- LOCAL FUNCTIONS
local function sameOrder(a: {string}, b: {string}): boolean
	if #a ~= #b then return false end
	for index, id in a do
		if b[index] ~= id then return false end
	end
	return true
end

-- Layers register while Fusion is mid-update, and writing a Value other Computeds
-- read would re-enter that graph, so each reorder waits for the current one to finish
local function reorder(mutate: (current: {string}) -> {string})
	task.defer(function()
		local current = Fusion.peek(orderValue)
		local updated = mutate(current)
		if sameOrder(updated, current) then return end
		orderValue:set(updated)
	end)
end

-- Raised layers keep their relative order so a notice stack doesn't shuffle
local function moveToFront(ids: {[string]: boolean})
	reorder(function(current)
		local kept = {}
		local moved = {}
		for _, id in current do
			if ids[id] then
				table.insert(moved, id)
			else
				table.insert(kept, id)
			end
		end
		for _, id in moved do
			table.insert(kept, id)
		end
		return kept
	end)
end

local function layerAt(point: Vector2): string?
	local order = Fusion.peek(orderValue)
	for index = #order, 1, -1 do
		local id = order[index]
		local instance = instanceById[id]
		if instance and instance.Parent and instance.Visible then
			local topLeft = instance.AbsolutePosition
			local size = instance.AbsoluteSize
			if point.X >= topLeft.X and point.X <= topLeft.X + size.X
				and point.Y >= topLeft.Y and point.Y <= topLeft.Y + size.Y then
				return id
			end
		end
	end
	return nil
end

local function onInputBegan(input: InputObject)
	if input.UserInputType ~= Enum.UserInputType.MouseButton1
		and input.UserInputType ~= Enum.UserInputType.Touch then
		return
	end
	for _, blocker in blockers do
		if blocker() then return end
	end
	local id = layerAt(Vector2.new(input.Position.X, input.Position.Y))
	if id then
		LayerOrder.raise(id)
	end
end


-- FUNCTIONS
-- The layer leaves the pool when its scope is destroyed. Layers sharing a group
-- raise together
function LayerOrder.register(layerScope: Scope, id: string, group: string?): Fusion.Computed<number>
	if group then
		groupById[id] = group
	end
	reorder(function(current)
		local updated = table.clone(current)
		table.insert(updated, id)
		return updated
	end)
	table.insert(layerScope :: any, function()
		LayerOrder.unregister(id)
	end)
	return (layerScope :: any):Computed(function(use)
		local order = use(orderValue)
		for index, otherId in order do
			if otherId == id then
				return index
			end
		end
		-- The list catches up a frame later, and a fresh layer is heading for the
		-- front, so claim that slot now instead of rendering behind for a frame
		return #order + 1
	end)
end

-- The instance arrives after register because the ZIndex has to exist before the
-- layer can be built. We need it to work out what a press landed on
function LayerOrder.attach(id: string, instance: GuiObject)
	instanceById[id] = instance
end

function LayerOrder.unregister(id: string)
	groupById[id] = nil
	instanceById[id] = nil
	reorder(function(current)
		local kept = {}
		for _, otherId in current do
			if otherId ~= id then
				table.insert(kept, otherId)
			end
		end
		return kept
	end)
end

function LayerOrder.raise(id: string)
	local group = groupById[id]
	local targets: {[string]: boolean} = {}
	if group then
		for otherId, otherGroup in groupById do
			if otherGroup == group then
				targets[otherId] = true
			end
		end
	else
		targets[id] = true
	end
	moveToFront(targets)
end

-- While a blocker says yes, presses stop raising anything. The centre messages use
-- this so clicking a modal card can't reorder the panels sat behind it
function LayerOrder.addBlocker(predicate: () -> boolean)
	table.insert(blockers, predicate)
end

function LayerOrder.init(initScope: Scope)
	if connected then return end
	connected = true
	local conn = UserInputService.InputBegan:Connect(onInputBegan)
	table.insert(initScope :: any, conn)
end


return LayerOrder
