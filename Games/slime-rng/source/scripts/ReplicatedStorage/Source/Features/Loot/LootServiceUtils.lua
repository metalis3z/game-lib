-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: LootServiceUtils, time of decompilation: Sun May  3 10:12:02 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InventoryItemUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryItemUtils)
local MonetizationServiceUtils = require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceUtils)
local SpecialDiceServiceUtils = require(ReplicatedStorage.Source.Features.SpecialDice.SpecialDiceServiceUtils)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local Food = require(ReplicatedStorage.Source.Game.Items.Food)
local t1 = {
	luck = "lootLuck",
	ultraLuck = "lootUltraLuck",
	currency = "lootCurrency",
	rollSpeed = "lootRollSpeed"
}

local function createBoostLoot(s1: string, s2: string, n1: number) -- line: 52
	-- upvalues: InventoryItemUtils (copy), t1 (copy)
	local v29 = InventoryItemUtils.getDefinition(s1)

	assert(v29 and v29.kind == "boost", string.format("Missing boost item definition for '%s'", s1))

	return {
		kind = "boost",
		id = s1,
		itemId = v29.id,
		name = v29.name,
		description = v29.description,
		icon = v29.icon,
		modelName = s2,
		upgradeId = t1[s1],
		weight = n1,
		onCollected = function(t2: {[any]: any}, p1) --[[ onCollected ]] -- line: 69
			-- upvalues: v29 (copy)
			return t2.addBoost(p1, v29.boostKind, 1)
		end
	}
end

local t3 = {
	createBoostLoot("luck", "luckPotion", 1000),
	createBoostLoot("ultraLuck", "ultraLuckPotion", 1000),
	createBoostLoot("currency", "coinPotion", 1000),
	(createBoostLoot("rollSpeed", "rollSpeedPotion", 1000))
}
local v9 = table.clone(t3)

for _, v11 in Food.getSortedFoods() do
	table.insert(v9, ((function(s3: string) --[[ createFoodLoot ]] -- line: 75
		-- upvalues: Food (copy)
		local v31 = Food.getFood(s3)

		assert(v31 ~= nil, string.format("Missing food definition for '%s'", s3))

		local t4 = {
			kind = "food",
			id = s3,
			itemId = v31.id,
			name = v31.name,
			description = Food.getDescription(v31.id),
			icon = v31.icon,
			modelName = v31.id
		}
		local id = v31.id

		t4.upgradeId = `loot{ string.upper((string.sub(id, 1, 1))) }{ string.sub(id, 2) }`
		t4.weight = v31.weight

		function t4.onCollected(t5: {[any]: any}, p2) -- line: 89
			-- upvalues: v31 (copy)
			return t5.addItem(p2, v31.id, 1)
		end

		return t4
	end)(v11.id)))
end

local t6 = {}

for _, v14 in SpecialDiceServiceUtils.getInventoryItemIds() do
	local v15 = (function(p3) --[[ createSpecialDiceLoot ]] -- line: 95
		-- upvalues: SpecialDiceServiceUtils (copy)
		local v35 = SpecialDiceServiceUtils.getDefinition(p3)

		if v35.forcedMutation == nil then
			return nil
		end

		return {
			kind = "specialDice",
			weight = 0,
			id = v35.id,
			itemId = v35.id,
			name = v35.name,
			description = v35.description,
			icon = v35.icon,
			modelName = v35.id,
			upgradeId = `mutatedEnemy{ v35.id }`,
			onCollected = function(t7: {[any]: any}, p4) --[[ onCollected ]] -- line: 111
				-- upvalues: v35 (copy)
				return t7.addItem(p4, v35.id, 1)
			end
		}
	end)(v14)

	if v15 then
		table.insert(t6, v15)
	end
end

local t8 = {}
local t9 = {}

for _, v19 in v9 do
	t8[v19.id] = v19
	t9[v19.upgradeId] = v19
end

for _, v21 in t6 do
	t8[v21.id] = v21
	t9[v21.upgradeId] = v21
end

local t10 = {}

local function rollWeightedDefinition(t11: {[any]: any}, n2: number?) -- line: 151
	local n3 = 0

	for _, v40 in t11 do
		n3 += v40.weight
	end

	if n3 <= 0 then
		return nil
	end

	local v41 = (n2 or math.random()) * n3

	for _, v43 in t11 do
		v41 -= v43.weight

		if v41 <= 0 then
			return v43
		end
	end

	return t11[#t11]
end
local function getUnlockedDefinitions(t12: {[any]: any}) -- line: 172
	-- upvalues: v9 (copy)
	local t13 = {}
	local t14 = {}

	for _, v48 in v9 do
		if t12[v48.upgradeId] then
			if v48.kind == "food" then
				table.insert(t14, v48)
			else
				table.insert(t13, v48)
			end
		end
	end

	return t13, t14
end

function t10.getDefinitions() -- line: 189
	-- upvalues: v9 (copy)
	return table.clone(v9)
end
function t10.getDefinition(s4: string) -- line: 193
	-- upvalues: t8 (copy)
	return t8[s4]
end
function t10.getDefinitionFromUpgradeId(s5: string) -- line: 197
	-- upvalues: t9 (copy)
	return t9[s5]
end
function t10.getLootUpgradeId(s6: string) -- line: 201
	-- upvalues: t8 (copy)
	local v52 = t8[s6]

	if v52 then
		return v52.upgradeId
	end

	return nil
end
function t10.getDespawnDuration() -- line: 206
	return 180
end
function t10.getMinDropDelay(p5) -- line: 210
	-- upvalues: MonetizationServiceUtils (copy)
	return MonetizationServiceUtils.getLootMinDropDelay(20, p5)
end
function t10.getDropChance(p6) -- line: 214
	-- upvalues: MonetizationServiceUtils (copy)
	return MonetizationServiceUtils.getLootDropChance(0.015, p6)
end
function t10.getFoodDropChance() -- line: 218
	return 0.9
end
function t10.rollDefinition(t15: {[any]: any}, n4: number?, n5: number?, n6: number?, n7: number?, p7, b1: boolean?) -- line: 222
	-- upvalues: t10 (copy), getUnlockedDefinitions (copy), rollWeightedDefinition (copy)
	if not b1 and (n4 or math.random()) > t10.getDropChance(p7) then
		return nil
	end

	local v62, v63 = getUnlockedDefinitions(t15 or {})

	if #v62 == 0 and #v63 == 0 then
		return nil
	end

	local v64 = (n5 or math.random()) <= 0.9

	if v64 and #v63 > 0 then
		return (rollWeightedDefinition(v63, n7))
	end

	if not v64 and #v62 > 0 then
		return (rollWeightedDefinition(v62, n6))
	end

	if #v63 > 0 then
		return (rollWeightedDefinition(v63, n7))
	end

	return (rollWeightedDefinition(v62, n6))
end
function t10.isExpired(t16: {[any]: any}, n8: number) -- line: 256
	return n8 >= t16.expiresAt
end

return t10
