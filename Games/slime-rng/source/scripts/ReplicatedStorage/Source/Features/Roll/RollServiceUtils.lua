-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RollServiceUtils, time of decompilation: Sun May  3 10:11:44 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Sift = require(ReplicatedStorage.Packages.Sift)
local JackpotUtils = require(ReplicatedStorage.Source.Features.Roll.JackpotUtils)
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local v5 = require(ReplicatedStorage.Source.Game.Items.Slimes).getSortedSlimes()
local t1 = {
	luckRollChance = 0.18,
	maxNonSlimeRolls = 8
}
local t2 = {
	[1] = {{{
		id = "goopy"
	}}},
	[2] = {{{
		id = "fin"
	}}},
	[3] = {{{
		id = "sunset"
	}}},
	[4] = {{
		{
			kind = "LUCK",
			multiplier = 2
		},
		{
			kind = "LUCK",
			multiplier = 4
		},
		{
			id = "buggy"
		}
	}},
	[5] = {{{
		id = "goopy"
	}}},
	[6] = {{{
		id = "sunset"
	}}},
	[7] = {{
		{
			kind = "LUCK",
			multiplier = 2
		},
		{
			id = "leafy"
		}
	}},
	[8] = {{{
		id = "fin"
	}}},
	[9] = {{{
		id = "sunset"
	}}},
	[10] = {{{
		id = "goopy"
	}}},
	[11] = {{{
		id = "cat"
	}}},
	[24] = {{
		{
			kind = "LUCK",
			multiplier = 2
		},
		{
			kind = "LUCK",
			multiplier = 4
		},
		{
			kind = "LUCK",
			multiplier = 8
		},
		{
			kind = "LUCK",
			multiplier = 16
		},
		{
			id = "orca"
		}
	}},
	[62] = {{{
		id = "spike"
	}}}
}
local t3 = {
	enums = t1
}

local function getUnlockedMutationIds(p1, t4: {[any]: any}) -- line: 141
	local t5 = {}

	for _, v32 in t4 do
		local unlockedMutations = p1.unlockedMutations

		if unlockedMutations == nil or unlockedMutations[v32] == true then
			table.insert(t5, v32)
		end
	end

	return t5
end
local function rollExclusiveMutations(p2, t6: {[any]: any}) -- line: 155
	-- upvalues: Mutations (copy)
	local n1 = 0

	for _, v38 in t6 do
		local v39 = 1 - math.clamp(Mutations.get(v38).odds, 0, 1)
		local mutationLuckMultipliers = p2.mutationLuckMultipliers
		local v41 = if not mutationLuckMultipliers then nil else mutationLuckMultipliers[v38]

		n1 += math.clamp(1 - v39 ^ if v41 == nil then math.max(p2.mutationLuck or 1, 1) else math.max(v41, 1), 0, 1)
	end

	if n1 <= 0 then
		return nil
	end

	if math.random() >= math.clamp(n1, 0, 1) then
		return nil
	end

	local v42 = math.random() * n1
	local n2 = 0

	for _, v45 in t6 do
		local v46 = 1 - math.clamp(Mutations.get(v45).odds, 0, 1)
		local mutationLuckMultipliers = p2.mutationLuckMultipliers
		local v48 = if not mutationLuckMultipliers then nil else mutationLuckMultipliers[v45]

		n2 += math.clamp(1 - v46 ^ if v48 == nil then math.max(p2.mutationLuck or 1, 1) else math.max(v48, 1), 0, 1)

		if v42 < n2 then
			return v45
		end
	end

	return t6[#t6]
end
local function rollWeightedSlime(p3, n3: number?) -- line: 198
	-- upvalues: v5 (copy)
	for i = #v5, 1, -1 do
		local v57 = v5[i]
		local v58 = v57.rollOdds or v57.odds

		if not (not v57.craftable and (n3 == nil or n3 >= v57.minZone)) then
			continue
		end

		local luck = p3.luck

		if math.random() < 1 - (1 - v58) ^ luck then
			return v57
		end
	end

	for _, v61 in v5 do
		if not v61.craftable and (n3 == nil or n3 >= v61.minZone) then
			return v61
		end
	end

	return v5[1]
end

function t3.isNonSlimeRoll(p4) -- line: 210
	return p4.kind ~= nil
end
function t3.isLuckRoll(p5) -- line: 214
	return p5.kind == "LUCK"
end
function t3.isBonusRoll(p6) -- line: 218
	return p6.kind == "BONUS"
end
function t3.getLuckMultiplier(p7) -- line: 222
	-- upvalues: t3 (copy)
	if not t3.isLuckRoll(p7) then
		return nil
	end

	return p7.multiplier
end

local function rollNonSlimeType(p8, s1: string?) -- line: 236
	-- upvalues: JackpotUtils (copy), t1 (copy)
	local v71, v72 = JackpotUtils.getBonusChances(p8)
	local v73 = math.clamp(p8.luckRollChance or t1.luckRollChance, 0, 1)

	if s1 == "LUCK" then
		if math.random() < 1 - (1 - v73) ^ 1 then
			return "LUCK"
		end

		return nil
	end

	if s1 == "BONUS" then
		if math.random() < 1 - (1 - v72) ^ 1 then
			return "BONUS"
		end

		return nil
	end

	if math.random() < 1 - (1 - v71) ^ 1 then
		return "BONUS"
	end

	if math.random() < 1 - (1 - v73) ^ 1 then
		return "LUCK"
	end

	return nil
end

function t3.rollSlimeId(p9, n4: number?) -- line: 256
	-- upvalues: rollWeightedSlime (copy)
	return rollWeightedSlime(p9, n4).id
end
function t3.rollMutations(p10) -- line: 260
	-- upvalues: rollExclusiveMutations (copy), getUnlockedMutationIds (copy), Mutations (copy)
	local t7 = {}
	local v78 = false
	local v79 = rollExclusiveMutations(p10, (getUnlockedMutationIds(p10, Mutations.sizeMutations)))

	if v79 ~= nil then
		t7[v79] = true
		v78 = true
	end

	for _, v81 in getUnlockedMutationIds(p10, Mutations.modifierMutations) do
		local v82 = 1 - math.clamp(Mutations.get(v81).odds, 0, 1)
		local mutationLuckMultipliers = p10.mutationLuckMultipliers
		local v84 = if not mutationLuckMultipliers then nil else mutationLuckMultipliers[v81]
		local v85 = math.clamp(1 - v82 ^ if v84 == nil then math.max(p10.mutationLuck or 1, 1) else math.max(v84, 1), 0, 1)

		if v78 then
			v85 *= math.max(p10.mutationStackChanceMultiplier or 1, 0)
		end

		if math.random() < math.clamp(v85, 0, 1) then
			t7[v81] = true
			v78 = true
		end
	end

	if v78 then
		return t7
	end

	return nil
end
function t3.rollResult(p11, n5: number?, s2: string?, n6: number?, n7: number?) -- line: 292
	-- upvalues: t1 (copy), t3 (copy), rollNonSlimeType (copy)
	local v93 = n5 or 0
	local v94 = n6 or 1
	local v95 = table.clone(p11)

	v95.luck = v95.luck * v94

	if v93 >= t1.maxNonSlimeRolls then
		return {
			id = t3.rollSlimeId(v95, n7),
			mutations = t3.rollMutations(v95)
		}
	end

	local v96 = rollNonSlimeType(p11, s2)

	if v96 == "LUCK" then
		return {
			kind = "LUCK",
			multiplier = v94 * 2
		}
	end

	if v96 == "BONUS" then
		return {
			kind = "BONUS"
		}
	end

	return {
		id = t3.rollSlimeId(v95, n7),
		mutations = t3.rollMutations(v95)
	}
end
function t3.rollColumn(p12, n8: number?) -- line: 318
	-- upvalues: t3 (copy), JackpotUtils (copy)
	local t8 = {}
	local s3 = nil
	local n9 = 1
	local n10 = 0

	repeat
		local v103 = t3.rollResult(p12, #t8, s3, n9, n8)

		if t3.isLuckRoll(v103) then
			s3 = "LUCK"
			n9 = t3.getLuckMultiplier(v103) or n9
		elseif t3.isBonusRoll(v103) then
			s3 = "BONUS"
			n10 += 1
		end

		table.insert(t8, v103)
	until JackpotUtils.shouldEndBonusChain(n10) or not t3.isNonSlimeRoll(v103)

	return t8
end
function t3.getForcedRollResults(n11: number) -- line: 346
	-- upvalues: t2 (copy), JackpotUtils (copy), Sift (copy)
	local v105 = t2[n11]

	if v105 == nil then
		return JackpotUtils.getForcedTriggerRollResults(n11)
	end

	return Sift.Dictionary.copyDeep(v105)
end
function t3.rollResults(p13, n12: number?) -- line: 355
	-- upvalues: t3 (copy)
	local t9 = {}

	for i = 1, p13.columns do
		t9[i] = t3.rollColumn(p13, n12)
	end

	return t9
end

return t3
