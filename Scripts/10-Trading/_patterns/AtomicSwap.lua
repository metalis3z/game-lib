--!strict
-- AtomicSwap (clean pattern, ModuleScript - put in ServerScriptService or ServerStorage)
-- Credit: idea taken from smash-egg-for-animals (PetServer "TradeBridge" Execute), brainrot-lab (TradeServer
-- executeTrade re-validation) and steal-a-brainrot (TradeService re-snapshot before swapping).
--
-- What it does:
--   Swaps two sets of items between two inventories ALL-OR-NOTHING. Everything is validated first
--   (ids exist, no id offered twice, item not locked, both sides have room) and only then mutated.
--   Works on plain Lua tables, so it does not care how you store data (ProfileStore, your own DataService...).
--
-- Inventory shape expected: a dictionary { [itemId: string] = itemRecord }
--
-- Usage:
--   local AtomicSwap = require(ServerScriptService.AtomicSwap)
--   local ok, err = AtomicSwap.swap(profileA.Data.Pets, {"id1","id2"}, profileB.Data.Pets, {"id9"}, {
--       maxItemsA = 200, maxItemsB = 200,
--       isLocked = function(item) return item.Equipped or item.PlacedInBase end,
--       newId = function(item) return HttpService:GenerateGUID(false) end, -- optional: re-key moved items
--   })
--   if ok then saveNow(playerA); saveNow(playerB) end   -- save BOTH right away to avoid dupes on crash

local AtomicSwap = {}

export type Inventory = { [string]: any }
export type Options = {
	maxItemsA: number?,
	maxItemsB: number?,
	isLocked: ((item: any) -> boolean)?,
	newId: ((item: any) -> string)?,
}

local function countKeys(t: Inventory): number
	local n = 0
	for _ in t do
		n += 1
	end
	return n
end

-- Returns true, or false + a player-facing reason.
function AtomicSwap.validateOffer(inventory: Inventory, ids: { string }, isLocked: ((any) -> boolean)?): (boolean, string?)
	if type(ids) ~= "table" then
		return false, "Bad offer."
	end
	local seen = {}
	for _, id in ids do
		if type(id) ~= "string" then
			return false, "Bad item id."
		end
		if seen[id] then
			return false, "The same item was offered twice."
		end
		seen[id] = true
		local item = inventory[id]
		if item == nil then
			return false, "An item is no longer in the inventory."
		end
		if isLocked and isLocked(item) then
			return false, "An item is locked (equipped, placed or in use)."
		end
	end
	return true
end

function AtomicSwap.swap(invA: Inventory, idsA: { string }, invB: Inventory, idsB: { string }, opts: Options?): (boolean, string?)
	local o: Options = opts or {}

	-- 1) validate everything before touching anything
	local okA, errA = AtomicSwap.validateOffer(invA, idsA, o.isLocked)
	if not okA then
		return false, errA
	end
	local okB, errB = AtomicSwap.validateOffer(invB, idsB, o.isLocked)
	if not okB then
		return false, errB
	end
	if invA == invB then
		return false, "Cannot trade with yourself."
	end

	-- without newId, an incoming id must not overwrite an item the receiver keeps
	if not o.newId then
		local leavingA, leavingB = {}, {}
		for _, id in idsA do leavingA[id] = true end
		for _, id in idsB do leavingB[id] = true end
		for _, id in idsA do
			if invB[id] ~= nil and not leavingB[id] then
				return false, "Item id collision (pass opts.newId to re-key items)."
			end
		end
		for _, id in idsB do
			if invA[id] ~= nil and not leavingA[id] then
				return false, "Item id collision (pass opts.newId to re-key items)."
			end
		end
	end

	local sizeA, sizeB = countKeys(invA), countKeys(invB)
	if o.maxItemsA and sizeA - #idsA + #idsB > o.maxItemsA then
		return false, "Player A does not have enough inventory space."
	end
	if o.maxItemsB and sizeB - #idsB + #idsA > o.maxItemsB then
		return false, "Player B does not have enough inventory space."
	end

	-- 2) take items out of both sides
	local fromA, fromB = {}, {}
	for _, id in idsA do
		table.insert(fromA, { id = id, item = invA[id] })
		invA[id] = nil
	end
	for _, id in idsB do
		table.insert(fromB, { id = id, item = invB[id] })
		invB[id] = nil
	end

	-- 3) give them to the other side (optionally re-keyed so ids never collide)
	for _, entry in fromA do
		local key = if o.newId then o.newId(entry.item) else entry.id
		invB[key] = entry.item
	end
	for _, entry in fromB do
		local key = if o.newId then o.newId(entry.item) else entry.id
		invA[key] = entry.item
	end

	return true
end

return AtomicSwap
