-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DropTable = require(ReplicatedStorage.Library.DropTable)
local BrainrotItem = require(ReplicatedStorage.Library.Items.BrainrotItem)
local Assets = require(ReplicatedStorage.Directory.Assets)

local function getId(p1) --[[ getId | Line: 16 ]]
	return p1._id
end

local function getWeight(p1) --[[ getWeight | Line: 20 ]]
	return p1.DropWeight
end

local function getRarity(p1) --[[ getRarity | Line: 24 ]]
	return p1.Rarity._id
end

local function makeItem(p1) --[[ makeItem | Line: 28 | Upvalues: BrainrotItem (copy) ]]
	local ok, result = pcall(function() --[[ Line: 31 | Upvalues: BrainrotItem (ref), p1 (copy) ]]
		return BrainrotItem(p1)
	end)

	if ok and result then
		return result
	end

	error(("Could not construct BrainrotItem for asset id \'%s\'"):format((tostring(p1))))
end

local list = {}

for k, v in pairs(Assets.Directory or Assets) do
	local v2
	local _id = v._id
	local DropWeight = v.DropWeight

	if _id ~= nil and (typeof(DropWeight) == "number" and (DropWeight ~= 1 and DropWeight > 0)) then
		local ok, result = pcall(function() --[[ Line: 31 | Upvalues: BrainrotItem (copy), _id (copy) ]]
			return BrainrotItem(_id)
		end)

		if ok and result then
			v2 = result
		else
			error(("Could not construct BrainrotItem for asset id \'%s\'"):format((tostring(_id))))
		end

		table.insert(list, {
			Weight = DropWeight,
			Value = v2,
			__rarity = v.Rarity._id,
			__id = _id
		})
	end
end

if #list == 0 then
	warn("[RollOneSim] No valid entries found. Check field names in getId/getWeight/getRarity.")

	return
end

local v3 = DropTable.new(list)
local v4 = Random.new()

local function makeBiasedRNG(p1) --[[ makeBiasedRNG | Line: 73 | Upvalues: DropTable (copy), v4 (copy) ]]
	return function() --[[ Line: 74 | Upvalues: DropTable (ref), p1 (copy), v4 (ref) ]]
		return DropTable.SimulateRolls(p1, v4:NextNumber())
	end
end

local t = {}
local list3 = {
	"Basic",
	"Rare",
	"Epic",
	"Legendary",
	"Mythical",
	"BrainrotGod",
	"Secret",
	"Eternal",
	"Unknown"
}

for i, v in ipairs(v3.entries) do
	local v5 = list[i]

	for i2, v6 in ipairs(list) do
		if v6.Value == v.Value and v6.Weight == v.Weight then
			v5 = v6

			break
		end
	end

	t[v] = v5
end

local function getItemRarity(p1, p2) --[[ getItemRarity | Line: 103 ]]
	if not (p1 and p1.GetRarity) then
		return p2 or "Unknown"
	end

	local ok, result = pcall(function() --[[ Line: 105 | Upvalues: p1 (copy) ]]
		return p1:GetRarity()
	end)

	if ok and result ~= nil then
		return result._id
	end

	return p2 or "Unknown"
end

local function getItemId(p1, p2) --[[ getItemId | Line: 115 ]]
	if not (p1 and p1.GetId) then
		return p2 or "?"
	end

	local ok, result = pcall(function() --[[ Line: 117 | Upvalues: p1 (copy) ]]
		return p1:GetId()
	end)

	if ok and result ~= nil then
		return result
	end

	return p2 or "?"
end

local t2 = {}

for i, v in ipairs({ 1, 10 }) do
	local function f6() --[[ Line: 74 | Upvalues: DropTable (copy), v (copy), v4 (copy) ]]
		return DropTable.SimulateRolls(v, v4:NextNumber())
	end

	local t3 = {}
	local t4 = {}

	for i2 = 1, 200000 do
		local v7, v8
		local v9 = v3:RollOne(f6)

		if v9 and v9.Item then
			local v10 = t[v9.Entry]
			local Item = v9.Item
			local v11 = v10 and v10.__rarity

			if Item and Item.GetRarity then
				local ok, result = pcall(function() --[[ Line: 105 | Upvalues: Item (copy) ]]
					return Item:GetRarity()
				end)

				v7 = if ok and result ~= nil then result._id else v11 or "Unknown"
			else
				v7 = v11 or "Unknown"
			end

			local Item2 = v9.Item
			local v12 = if v10 then v10.__id else v10

			if Item2 and Item2.GetId then
				local ok, result = pcall(function() --[[ Line: 117 | Upvalues: Item2 (copy) ]]
					return Item2:GetId()
				end)

				v8 = if ok and result ~= nil then result else v12 or "?"
			else
				v8 = v12 or "?"
			end

			t3[v7] = (t3[v7] or 0) + 1
			t4[v8] = (t4[v8] or 0) + 1
		end
	end

	t2[v] = {
		byRarity = t3,
		byId = t4
	}
end

local function pct(p1) --[[ pct | Line: 153 ]]
	return (p1 or 0) / 200000 * 100
end

print(("== RollOne Sim using DropTable.SimulateRolls, TRIALS=%d =="):format(200000))

local t3 = {}

for k, v in pairs(t2[10].byId) do
	table.insert(t3, {
		id = k,
		base = t2[1].byId[k] or 0,
		x10 = v
	})
end

table.sort(t3, function(p1, p2) --[[ Line: 165 ]]
	return p1.x10 > p2.x10
end)
print("== Per-Entry snapshot (top 30 by x10 observed %) ==")

for j = 1, math.min(30, #t3) do
	local v13 = t3[j]

	print(string.format("%-40s | base=%8.5f%%  x10=%8.5f%%", v13.id, (v13.base or 0) / 200000 * 100, (v13.x10 or 0) / 200000 * 100))
end

print("\n== Per-Rarity Totals (baseline vs x10) ==")

for i, v in ipairs(list3) do
	local v14 = t2[1].byRarity[v] or 0
	local v15 = t2[10].byRarity[v] or 0

	if v14 + v15 > 0 then
		print(string.format("%-12s  base=%8.5f%%   x10=%8.5f%%", v, (v14 or 0) / 200000 * 100, (v15 or 0) / 200000 * 100))
	end
end

for k, v in pairs(t2[1].byRarity) do
	local v16 = false

	for i, v5 in ipairs(list3) do
		if v5 == k then
			v16 = true

			break
		end
	end

	if not v16 then
		print(string.format("%-12s  base=%8.5f%%   x10=%8.5f%%", k, (t2[1].byRarity[k] or 0 or 0) / 200000 * 100, (t2[10].byRarity[k] or 0 or 0) / 200000 * 100))
	end
end

return {}