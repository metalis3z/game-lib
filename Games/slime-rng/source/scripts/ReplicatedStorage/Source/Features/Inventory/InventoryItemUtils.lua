-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: InventoryItemUtils, time of decompilation: Sun May  3 10:11:26 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BoostServiceUtils = require(ReplicatedStorage.Source.Features.Boosts.BoostServiceUtils)
local SpecialDiceServiceUtils = require(ReplicatedStorage.Source.Features.SpecialDice.SpecialDiceServiceUtils)
local Food = require(ReplicatedStorage.Source.Game.Items.Food)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local t1 = {
	luck = {
		id = "luck",
		name = "Luck Boost",
		description = "Doubles your luck for 3 minutes while you're in-game.",
		category = "consumables",
		kind = "boost",
		layoutOrder = 1,
		boostKind = "luck",
		icon = ImageIds.boosts.luck
	},
	ultraLuck = {
		id = "ultraLuck",
		name = "Ultra Luck Boost",
		description = "Triples your luck for 3 minutes while you're in-game.",
		category = "consumables",
		kind = "boost",
		layoutOrder = 2,
		boostKind = "ultraLuck",
		icon = ImageIds.boosts.ultraLuck
	},
	currency = {
		id = "currency",
		name = "Currency Boost",
		description = "Doubles your coin rewards for 3 minutes while you're in-game.",
		category = "consumables",
		kind = "boost",
		layoutOrder = 3,
		boostKind = "currency",
		icon = ImageIds.boosts.currency
	},
	rollSpeed = {
		id = "rollSpeed",
		name = "Roll Speed Boost",
		description = "Doubles your roll speed for 3 minutes while you're in-game.",
		category = "consumables",
		kind = "boost",
		layoutOrder = 4,
		boostKind = "rollSpeed",
		icon = ImageIds.boosts.rollSpeed
	}
}
local t2 = {
	"luck",
	"ultraLuck",
	"currency",
	"rollSpeed"
}

for _, v9 in SpecialDiceServiceUtils.getInventoryItemIds() do
	local v10 = SpecialDiceServiceUtils.getDefinition(v9)

	t1[v9] = {
		category = "consumables",
		kind = "specialDice",
		id = v10.id,
		name = v10.name,
		description = v10.description,
		icon = v10.icon,
		layoutOrder = v10.layoutOrder
	}
	table.insert(t2, v9)
end

for _, v12 in Food.getSortedFoods() do
	t1[v12.id] = {
		category = "consumables",
		kind = "food",
		id = v12.id,
		name = v12.name,
		description = Food.getDescription(v12.id),
		icon = v12.icon,
		layoutOrder = v12.layoutOrder
	}
	table.insert(t2, v12.id)
end

local t3 = {
	getDefinition = function(s1: string) --[[ getDefinition ]] -- line: 100
		-- upvalues: t1 (copy)
		return t1[s1]
	end,
	getSortedConsumableIds = function() --[[ getSortedConsumableIds ]] -- line: 104
		-- upvalues: t2 (copy)
		return table.clone(t2)
	end
}

function t3.getAmountOwned(s2: string, p1, p2) -- line: 108
	-- upvalues: t3 (copy), BoostServiceUtils (copy)
	local v18 = t3.getDefinition(s2)

	if not v18 then
		return 0
	end

	if v18.kind == "boost" then
		return BoostServiceUtils.getBoostData(p1, v18.boostKind).amount
	end

	if v18.kind == "food" or v18.kind == "specialDice" then
		return (math.max(math.floor(((if type(p2) ~= "table" then {} else p2))[s2] or 0), 0))
	end

	return 0
end
function t3.getConsumableEntries(p3, p4) -- line: 126
	-- upvalues: t2 (copy), t1 (copy), t3 (copy)
	local t4 = {}

	for _, v23 in t2 do
		local v24 = t1[v23]
		local v25 = t3.getAmountOwned(v23, p3, p4)

		if v25 > 0 then
			t4[v23] = {
				definition = v24,
				amountOwned = v25
			}
		end
	end

	return t4
end
function t3.getFirstOwnedConsumableId(p5, p6) -- line: 143
	-- upvalues: t2 (copy), t3 (copy)
	for _, v29 in t2 do
		if t3.getAmountOwned(v29, p5, p6) > 0 then
			return v29
		end
	end

	return nil
end

return t3
