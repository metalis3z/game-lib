-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SpecialDiceServiceUtils, time of decompilation: Sun May  3 10:12:30 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local JackpotSpinServiceUtils = require(ReplicatedStorage.Source.Features.JackpotSpins.JackpotSpinServiceUtils)
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local t1 = {
	JackpotSpinServiceUtils.ITEM_ID,
	"invertedDice",
	"hugeDice",
	"shinyDice",
	"bigDice"
}
local t2 = {
	JackpotSpinServiceUtils.ITEM_ID,
	"bigDice",
	"hugeDice",
	"shinyDice",
	"invertedDice"
}
local t3 = {
	jackpotSpin = {
		name = "Jackpot Spin",
		description = "Guarantees 3 bonuses and a jackpot on your next roll.",
		layoutOrder = 5,
		priority = 1,
		forcedMutation = nil,
		id = JackpotSpinServiceUtils.ITEM_ID,
		icon = ImageIds.jackpotDice
	},
	bigDice = {
		id = "bigDice",
		name = "Big Dice",
		description = "Guarantees at least a Big slime on your next roll.",
		layoutOrder = 6,
		priority = 5,
		forcedMutation = "big",
		icon = ImageIds.bigDice
	},
	hugeDice = {
		id = "hugeDice",
		name = "Huge Dice",
		description = "Guarantees at least a Huge slime on your next roll.",
		layoutOrder = 7,
		priority = 3,
		forcedMutation = "huge",
		icon = ImageIds.hugeDice
	},
	shinyDice = {
		id = "shinyDice",
		name = "Shiny Dice",
		description = "Guarantees at least a Shiny slime on your next roll.",
		layoutOrder = 8,
		priority = 4,
		forcedMutation = "shiny",
		icon = ImageIds.shinyDice
	},
	invertedDice = {
		id = "invertedDice",
		name = "Inverted Dice",
		description = "Guarantees at least an Inverted slime on your next roll.",
		layoutOrder = 9,
		priority = 2,
		forcedMutation = "inverted",
		icon = ImageIds.invertedDice
	}
}
local t6 = {
	isSpecialDiceItemId = function(p1) --[[ isSpecialDiceItemId ]] -- line: 95
		-- upvalues: t3 (copy)
		return t3[p1] ~= nil
	end,
	getDefinition = function(p2) --[[ getDefinition ]] -- line: 99
		-- upvalues: t3 (copy)
		return t3[p2]
	end,
	getInventoryItemIds = function() --[[ getInventoryItemIds ]] -- line: 103
		-- upvalues: t2 (copy)
		return table.clone(t2)
	end,
	normalizeQueue = function(p3) --[[ normalizeQueue ]] -- line: 107
		-- upvalues: t3 (copy), t1 (copy)
		local t4 = {}

		if type(p3) == "table" then
			for _, v16 in p3 do
				local v17 = t3[v16]

				if v17 then
					t4[v17.id] = (t4[v17.id] or 0) + 1
				end
			end
		end

		local t5 = {}

		for _, v20 in t1 do
			for _ = 1, t4[v20] or 0 do
				table.insert(t5, v20)
			end
		end

		return t5
	end
}

function t6.getCount(p4, p5, p6) -- line: 129
	-- upvalues: t6 (copy)
	local n1 = 0

	for _, v27 in if p6 == nil then t6.normalizeQueue(p4) else t6.migrateQueue(p4, p6) do
		if v27 == p5 then
			n1 += 1
		end
	end

	return n1
end
function t6.getTotalCount(p7, p8) -- line: 144
	-- upvalues: t6 (copy)
	return #if p8 == nil then t6.normalizeQueue(p7) else t6.migrateQueue(p7, p8)
end
function t6.getJackpotArmedCount(p9, p10) -- line: 151
	-- upvalues: t6 (copy), JackpotSpinServiceUtils (copy)
	return t6.getCount(p9, JackpotSpinServiceUtils.ITEM_ID, p10)
end
function t6.migrateQueue(p11, p12) -- line: 159
	-- upvalues: t6 (copy), JackpotSpinServiceUtils (copy)
	local v34 = t6.normalizeQueue(p11)
	local v35 = math.max(JackpotSpinServiceUtils.getArmedAmount(p12) - t6.getJackpotArmedCount(v34), 0)

	if v35 <= 0 then
		return v34
	end

	local v36 = table.clone(v34)

	for _ = 1, v35 do
		table.insert(v36, JackpotSpinServiceUtils.ITEM_ID)
	end

	return t6.normalizeQueue(v36)
end
function t6.append(p13, p14) -- line: 179
	-- upvalues: t6 (copy)
	local v40 = t6.normalizeQueue(p13)

	table.insert(v40, p14)

	return t6.normalizeQueue(v40)
end
function t6.removeFirst(p15, p16) -- line: 185
	-- upvalues: t6 (copy)
	local v43 = t6.normalizeQueue(p15)
	local v44 = table.clone(v43)

	for v45, v46 in v44 do
		if v46 == p16 then
			table.remove(v44, v45)

			return t6.normalizeQueue(v44), true
		end
	end

	return v43, false
end
function t6.getActiveItemId(p17, p18) -- line: 199
	-- upvalues: t6 (copy)
	return ((if p18 == nil then t6.normalizeQueue(p17) else t6.migrateQueue(p17, p18)))[1]
end
function t6.consumeActive(p19) -- line: 206
	-- upvalues: t6 (copy)
	local v50 = t6.normalizeQueue(p19)
	local v51 = v50[1]

	if v51 == nil then
		return v50, nil
	end

	local v52 = table.clone(v50)

	table.remove(v52, 1)

	return v52, v51
end
function t6.getItemIcon(p20) -- line: 218
	-- upvalues: t3 (copy)
	local v54 = if not p20 then nil else t3[p20]

	if v54 then
		return v54.icon
	end

	return nil
end
function t6.getForcedMutationId(p21) -- line: 223
	-- upvalues: t3 (copy)
	local v56 = if not p21 then nil else t3[p21]

	if v56 then
		return v56.forcedMutation
	end

	return nil
end

local function applyForcedMutation(p22, p23) -- line: 228
	-- upvalues: Mutations (copy)
	if p23 == nil then
		if p22 then
			return (table.clone(p22))
		end

		return nil
	end

	local v59 = if not p22 then {} else table.clone(p22)

	if Mutations.get(p23).category == "size" then
		for _, v61 in Mutations.sizeMutations do
			v59[v61] = nil
		end
	end

	v59[p23] = true

	return next(v59) and v59 or nil
end

function t6.applyToRolledSlimeData(p24, p25) -- line: 245
	-- upvalues: applyForcedMutation (copy)
	if p25 == nil then
		return {
			id = p24.id,
			level = p24.level,
			xp = p24.xp,
			mutations = if not p24.mutations then nil else table.clone(p24.mutations)
		}
	end

	return {
		id = p24.id,
		level = p24.level,
		xp = p24.xp,
		mutations = applyForcedMutation(p24.mutations, p25)
	}
end
function t6.applyToRollResult(p26, p27) -- line: 266
	-- upvalues: t6 (copy)
	if p27 == nil or p26.id == nil then
		return p26
	end

	return t6.applyToRolledSlimeData(p26, p27)
end
function t6.applyToRollResults(p28, p29) -- line: 277
	-- upvalues: t6 (copy)
	if p29 == nil then
		return p28
	end

	local t7 = {}

	for v69, v70 in p28 do
		local t8 = table.create(#v70)

		for v72, v73 in v70 do
			t8[v72] = t6.applyToRollResult(v73, p29)
		end

		t7[v69] = t8
	end

	return t7
end
function t6.applyToJackpotSpinData(p30, p31) -- line: 297
	-- upvalues: t6 (copy)
	if p31 == nil then
		return p30
	end

	local t9 = table.create(#p30.options)

	for v77, v78 in p30.options do
		t9[v77] = t6.applyToRolledSlimeData(v78, p31)
	end

	return {
		reward = t6.applyToRolledSlimeData(p30.reward, p31),
		options = t9,
		rewardIndex = p30.rewardIndex
	}
end

return t6
