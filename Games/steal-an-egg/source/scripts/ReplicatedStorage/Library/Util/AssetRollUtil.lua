-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local LotteryCustom = require(ReplicatedStorage.Library.Functions.LotteryCustom)
local Assets = require(ReplicatedStorage.Directory.Assets)
local Rarity = require(ReplicatedStorage.Directory.Rarity)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local v1 = require(ReplicatedStorage.Library.Modules.BetterRandom).new()
local AssetRollScaleWeights = require(script.Parent.AssetRollScaleWeights)
local Mutations = require(ReplicatedStorage.Library.Modules.Mutations)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local TableUtil = require(ReplicatedStorage.Library.Modules.Packages.TableUtil)
local VirtualRollLuckUtil = require(ReplicatedStorage.Library.Util.VirtualRollLuckUtil)
local v2 = Random.new()
local v3 = Random.new()
local v4 = Log.new():LimitUnderLevel("Warning")
local v5 = ""
local t = {}
local t2 = {
	LuckBoost = 0,
	ScaleBoost = 0,
	MutationsBoost = 0
}

for k, v in pairs(Assets.Directory) do
	if v5 == "" then
		v5 = k
	end

	local DropWeight = v.DropWeight

	if DropWeight > 0 and (not v.DontRoll and v.Rarity ~= Rarity.Rarities.Eternal) then
		table.insert(t, { k, DropWeight })
	end
end

assert(if #t > 0 then true else false, "No valid category drop entries found")

local v7 = Mutations.GetMutationsDropTable()
local v8 = Mutations.GetMutations()
local t3 = {}

local function computeVirtualRolls(p1) --[[ computeVirtualRolls | Line: 70 | Upvalues: VirtualRollLuckUtil (copy) ]]
	return VirtualRollLuckUtil.ComputeVirtualRolls(p1)
end

local function cloneBoosts() --[[ cloneBoosts | Line: 74 | Upvalues: t2 (copy) ]]
	return table.clone(t2)
end

local function applyLinearBoostToTokenWeights(p1, p2) --[[ applyLinearBoostToTokenWeights | Line: 78 | Upvalues: TableUtil (copy), v4 (copy) ]]
	if p2 <= 0 then
		return TableUtil.Copy(p1, true)
	end

	local v1 = p2 / 100
	local v2 = (1 / 0)
	local sum = 0
	local v3 = v1 / (v1 + 1) * 0.49

	for i, v in ipairs(p1) do
		local v42 = v[2]

		if v42 < v2 then
			v2 = v42
		end

		sum = sum + v42
	end

	local list = {}
	local sum2 = 0

	for i, v in ipairs(p1) do
		local v6 = v[2]
		local v7 = v6 - (v6 - v2) * v3

		table.insert(list, { v[1], v7 })
		sum2 = sum2 + v7
	end

	local v8 = if sum2 == 0 then 1 else sum / sum2

	for i, v in ipairs(list) do
		v[2] = v[2] * v8
	end

	v4:AtTrace():Log((("applyLinearBoost boostPct=%* factor=%* k=%*"):format(p2, v3, v8)))

	return list
end

local function applyLinearBoostToScaleWeights(p1, p2) --[[ applyLinearBoostToScaleWeights | Line: 120 | Upvalues: TableUtil (copy), v4 (copy) ]]
	if p2 <= 0 then
		return TableUtil.Copy(p1, true)
	end

	local v1 = p2 / 100
	local v2 = (1 / 0)
	local sum = 0
	local v3 = v1 / (v1 + 1) * 0.49

	for i, v in ipairs(p1) do
		local v42 = v[2]

		if v42 < v2 then
			v2 = v42
		end

		sum = sum + v42
	end

	local list = {}
	local sum2 = 0

	for i, v in ipairs(p1) do
		local v6 = v[2]
		local v7 = v6 - (v6 - v2) * v3

		table.insert(list, { v[1], v7 })
		sum2 = sum2 + v7
	end

	local v8 = if sum2 == 0 then 1 else sum / sum2

	for i, v in ipairs(list) do
		v[2] = v[2] * v8
	end

	v4:AtTrace():Log((("applyLinearBoost boostPct=%* factor=%* k=%*"):format(p2, v3, v8)))

	return list
end

local function buildWeightedTokenEntry(p1, p2) --[[ buildWeightedTokenEntry | Line: 162 ]]
	return { p1, p2 }
end

local function getPositiveAssetDropWeight(p1) --[[ getPositiveAssetDropWeight | Line: 169 ]]
	local DropWeight = p1.DropWeight

	if typeof(DropWeight) == "number" and DropWeight > 0 then
		return DropWeight
	end

	return 0
end

local function buildAssetDropTableForRarityToken(p1, p2) --[[ buildAssetDropTableForRarityToken | Line: 174 | Upvalues: Assets (copy) ]]
	local v1 = Assets.ByRarity[p2]

	assert(if v1 == nil then false else true, (("Missing Assets.ByRarity entry for \"%*\" token \"%*\""):format(p1, p2)))

	local t = {}

	for k, v in pairs(v1) do
		local v4
		local DropWeight = v.DropWeight

		v4 = if typeof(DropWeight) == "number" and DropWeight > 0 then DropWeight else 0

		if v4 > 0 then
			table.insert(t, { k, v4 })
		end
	end

	assert(if #t > 0 then true else false, (("\"%*\" rarity token \"%*\" has no weighted assets"):format(p1, p2)))

	return t
end

function t3.ChooseCategory(p1, p2, p3) --[[ ChooseCategory | Line: 194 | Upvalues: t2 (copy), VirtualRollLuckUtil (copy), t (copy), v3 (copy), v5 (ref), v4 (copy) ]]
	local v1 = table.clone(t2)
	local v7 = VirtualRollLuckUtil.RollToken(t, VirtualRollLuckUtil.ComputeVirtualRolls((v1.LuckBoost or 0) + (table.clone(t2).LuckBoost or 0) + (p2 or 0)), if p3 then p3 else v3)

	if typeof(v7) == "string" and v7 ~= "" then
		return v7
	end

	local v8 = if v5 == "" then "" else v5

	v4:AtError():Log((("Failed to choose a category, using default \'%*\'"):format(v8)))

	return v8
end
function t3.ChooseCategoryFromRarityToken(p1, p2, p3) --[[ ChooseCategoryFromRarityToken | Line: 211 | Upvalues: LotteryCustom (copy), buildAssetDropTableForRarityToken (copy) ]]
	local v1 = LotteryCustom(p3, (buildAssetDropTableForRarityToken(p1, p2)))
	local v2 = if typeof(v1) == "string" then if v1 == "" then false else true else false

	assert(v2, (("Invalid reward category for \"%*\" token \"%*\""):format(p1, p2)))

	return v1
end
function t3.ChooseCategoryFromAssetDropTable(p1, p2, p3, p4) --[[ ChooseCategoryFromAssetDropTable | Line: 221 | Upvalues: Asserts (copy), VirtualRollLuckUtil (copy), LotteryCustom (copy), Assets (copy) ]]
	Asserts.finite(p3)
	assert(if p3 >= 1 then true else false, "Asset category virtual rolls must be at least one")

	local v2 = if p3 > 1 then VirtualRollLuckUtil.RollToken(p2, p3, p4) else LotteryCustom(p4, p2)

	assert(if typeof(v2) == "string" then if v2 == "" then false else true else false, (("Invalid asset category for \"%*\""):format(p1)))
	assert(Assets.Types.AssetNameExists(v2), (("Asset drop table \"%*\" rolled unknown asset \"%*\""):format(p1, v2)))

	return v2
end
function t3.ChooseCategoryFromRarityDropTable(p1, p2, p3) --[[ ChooseCategoryFromRarityDropTable | Line: 239 | Upvalues: LotteryCustom (copy), t3 (copy) ]]
	local v1 = LotteryCustom(p3, p2)
	local v2 = if typeof(v1) == "string" then if v1 == "" then false else true else false

	assert(v2, (("Invalid rarity token for \"%*\""):format(p1)))

	return t3.ChooseCategoryFromRarityToken(p1, v1, p3)
end
function t3.ChooseMutations(p1, p2, p3) --[[ ChooseMutations | Line: 250 | Upvalues: t2 (copy), v2 (copy), applyLinearBoostToTokenWeights (copy), v7 (copy), v4 (copy), LotteryCustom (copy), v8 (copy) ]]
	local v1 = table.clone(t2)
	local v42 = if p3 then p3 else v2
	local v5 = applyLinearBoostToTokenWeights(v7, (v1.MutationsBoost or 0) + (table.clone(t2).MutationsBoost or 0) + (p2 or 0))

	v4:AtInfo():Log((("Choosing mutations with extra chance: %*"):format(0.5)))

	local t = {}
	local v6 = LotteryCustom(v42, v5)

	if typeof(v6) == "string" and v6 ~= "None" then
		table.insert(t, v6)
	end

	if #t > 0 and v42:NextNumber() < 0.5 then
		local v72 = LotteryCustom(v42, v5)

		if typeof(v72) == "string" and (v72 ~= "None" and not table.find(t, v72)) then
			table.insert(t, v72)
		end
	end

	table.sort(t, function(p1, p2) --[[ Line: 272 | Upvalues: v8 (ref) ]]
		return v8[p1].DropWeight < v8[p2].DropWeight
	end)

	return t
end
function t3.RollScale(p1, p2, p3, p4) --[[ RollScale | Line: 279 | Upvalues: t2 (copy), applyLinearBoostToScaleWeights (copy), AssetRollScaleWeights (copy), Constants (copy), v4 (copy), v2 (copy), LotteryCustom (copy), v1 (copy) ]]
	local v12 = table.clone(t2)
	local v3 = applyLinearBoostToScaleWeights(AssetRollScaleWeights, (v12.ScaleBoost or 0) + (table.clone(t2).ScaleBoost or 0) + (p2 or 0))
	local v42, v5

	if p3 and p4 then
		local t = {}
		local t3 = {}

		for i, v in ipairs(v3) do
			local Range = v[1].Range
			local v6 = if typeof(Range) == "table" then Range[#Range] else Range

			if typeof(v6) == "number" then
				if p3 <= v6 * p4 then
					table.insert(t, v)
					table.insert(t3, i)
				end

				continue
			end

			local v7 = ("Invalid scale range %* for entry %*, expected number"):format(Range, i)

			if Constants.IS_STUDIO then
				error(v7)
			end

			v4:AtWarning():Log(v7)
		end

		if #t == 0 then
			return p3 / p4, #AssetRollScaleWeights
		end

		if v2:NextInteger(1, 10) == 1 and #t > 1 then
			local t4 = {}
			local t5 = {}

			for i = 2, #t do
				table.insert(t4, t[i])
				table.insert(t5, t3[i])
			end

			v42 = t4
			v5 = t5
		else
			v42, v5 = { t[1] }, { t3[1] }
		end
	else
		v42 = v3
		v5 = nil
	end

	local v11, _, _2, v122 = LotteryCustom(nil, v42)

	if not v11 then
		v4:AtError():Log("Failed to choose a scale, defaulting to 1x")

		return 1, 1
	end

	local Range = v11.Range

	if typeof(Range) == "table" then
		if p3 and p4 then
			local v13 = Range[#Range]

			Range = if v13 * p4 <= p3 then p3 / p4 else v1:numberArray({ p3 / p4, v13 })
		else
			Range = v1:numberArray(Range)
		end
	end

	return if typeof(Range) == "number" and Range then Range else 1, v5 and v5[v122] or v122
end

return t3