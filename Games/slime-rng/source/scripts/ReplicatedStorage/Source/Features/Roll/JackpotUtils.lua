-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: JackpotUtils, time of decompilation: Sun May  3 10:11:46 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Sift = require(ReplicatedStorage.Packages.Sift)
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)
local v5 = Slimes.getSortedSlimes()
local t1 = {
	defaultBonusJackpotChance = 0.001,
	bonusTeaseMultiplier = 100,
	maxBonusStartChance = 0.25,
	bonusChainLengthForJackpot = 3,
	jackpotRewardLuckMultiplier = 1000,
	jackpotMutatedRewardLuckMultiplierFactor = 0.025,
	jackpotRewardLuckBonusStartZone = 10,
	jackpotRewardLuckBonusPerZone = 200,
	jackpotRewardMutationStackChanceMultiplier = 0.25,
	jackpotRewardMutationLuckStartZone = 3,
	jackpotRewardMutationLuckFullZone = 7,
	jackpotMaxMutatedOptionCount = 3,
	jackpotOptionCount = 6,
	jackpotFakeOptionRollCount = 20,
	jackpotRewardMutationLuckMultipliers = {
		big = 36,
		huge = 50,
		shiny = 43,
		inverted = 90
	}
}
local t2 = {
	[181] = {
		id = "lucky",
		mutations = nil
	}
}
local t3 = {
	[181] = {{
		{
			kind = "BONUS"
		},
		{
			kind = "BONUS"
		},
		{
			kind = "BONUS"
		}
	}}
}
local t4 = {
	enums = t1
}

local function getUnlockedMutationIds(p1, t5: {[any]: any}) -- line: 111
	local t6 = {}

	for _, v48 in t5 do
		local unlockedMutations = p1.unlockedMutations

		if unlockedMutations == nil or unlockedMutations[v48] == true then
			table.insert(t6, v48)
		end
	end

	return t6
end
local function rollExclusiveMutations(p2, t7: {[any]: any}) -- line: 122
	-- upvalues: Mutations (copy)
	local n1 = 0

	for _, v54 in t7 do
		local v55 = 1 - math.clamp(Mutations.get(v54).odds, 0, 1)
		local mutationLuckMultipliers = p2.mutationLuckMultipliers
		local v57 = if not mutationLuckMultipliers then nil else mutationLuckMultipliers[v54]

		n1 += math.clamp(1 - v55 ^ if v57 == nil then math.max(p2.mutationLuck or 1, 1) else math.max(v57, 1), 0, 1)
	end

	if n1 <= 0 then
		return nil
	end

	if math.random() >= math.clamp(n1, 0, 1) then
		return nil
	end

	local v58 = math.random() * n1
	local n2 = 0

	for _, v61 in t7 do
		local v62 = 1 - math.clamp(Mutations.get(v61).odds, 0, 1)
		local mutationLuckMultipliers = p2.mutationLuckMultipliers
		local v64 = if not mutationLuckMultipliers then nil else mutationLuckMultipliers[v61]

		n2 += math.clamp(1 - v62 ^ if v64 == nil then math.max(p2.mutationLuck or 1, 1) else math.max(v64, 1), 0, 1)

		if v58 < n2 then
			return v61
		end
	end

	return t7[#t7]
end
local function rollMutations(p3) -- line: 148
	-- upvalues: rollExclusiveMutations (copy), getUnlockedMutationIds (copy), Mutations (copy)
	local t8 = {}
	local v67 = false
	local v68 = rollExclusiveMutations(p3, (getUnlockedMutationIds(p3, Mutations.sizeMutations)))

	if v68 ~= nil then
		t8[v68] = true
		v67 = true
	end

	for _, v70 in getUnlockedMutationIds(p3, Mutations.modifierMutations) do
		local v71 = 1 - math.clamp(Mutations.get(v70).odds, 0, 1)
		local mutationLuckMultipliers = p3.mutationLuckMultipliers
		local v73 = if not mutationLuckMultipliers then nil else mutationLuckMultipliers[v70]
		local v74 = math.clamp(1 - v71 ^ if v73 == nil then math.max(p3.mutationLuck or 1, 1) else math.max(v73, 1), 0, 1)

		if v67 then
			v74 *= math.max(p3.mutationStackChanceMultiplier or 1, 0)
		end

		if math.random() < math.clamp(v74, 0, 1) then
			t8[v70] = true
			v67 = true
		end
	end

	if v67 then
		return t8
	end

	return nil
end
local function rollSlimeId(p4, n3: number?) -- line: 187
	-- upvalues: v5 (copy)
	for i = #v5, 1, -1 do
		local v83 = v5[i]
		local v84 = v83.rollOdds or v83.odds

		if not (not v83.craftable and (n3 == nil or n3 >= v83.minZone)) then
			continue
		end

		local luck = p4.luck

		if math.random() < 1 - (1 - v84) ^ luck then
			return v83.id
		end
	end

	local v88

	for _, v87 in v5 do
		if not v87.craftable and (n3 == nil or n3 >= v87.minZone) then
			v88 = v87

			return v88.id
		end
	end

	v88 = v5[1]

	return v88.id
end
local function getEligibleSlimes(n4: number?) -- line: 199
	-- upvalues: v5 (copy)
	local t9 = {}

	for _, v92 in v5 do
		if not v92.craftable and (n4 == nil or n4 >= v92.minZone) then
			table.insert(t9, v92)
		end
	end

	if #t9 == 0 then
		table.insert(t9, v5[1])
	end

	return t9
end
local function cloneRollTableWithJackpotMutationLuck(p5, n5: number?) -- line: 224
	-- upvalues: t1 (copy)
	local v96 = math.clamp(((n5 or 0) - t1.jackpotRewardMutationLuckStartZone) / (t1.jackpotRewardMutationLuckFullZone - t1.jackpotRewardMutationLuckStartZone), 0, 1)
	local t10 = {}

	for v98, v99 in t1.jackpotRewardMutationLuckMultipliers do
		t10[v98] = v99 * v96
	end

	local v100 = table.clone(p5)

	v100.mutationLuckMultipliers = t10
	v100.mutationStackChanceMultiplier = t1.jackpotRewardMutationStackChanceMultiplier

	return v100
end
local function getFallbackRewardAtOrAboveRarity(n6: number?, n7: number) -- line: 266
	-- upvalues: v5 (copy)
	local v115 = nil

	for i = #v5, 1, -1 do
		local v117 = v5[i]

		if not (not v117.craftable and (n6 == nil or n6 >= v117.minZone)) then
			continue
		end

		v115 = v115 or v117

		if n7 <= 1 / v117.odds then
			return {
				mutations = nil,
				id = v117.id
			}
		end
	end

	if not v115 then
		for _, v119 in v5 do
			if not v119.craftable and (n6 == nil or n6 >= v119.minZone) then
				v115 = v119

				return {
					mutations = nil,
					id = v115.id
				}
			end
		end

		v115 = v5[1]
	end

	return {
		mutations = nil,
		id = v115.id
	}
end
local function rollGuaranteedJackpotMutations(p6, n8: number?) -- line: 288
	-- upvalues: cloneRollTableWithJackpotMutationLuck (copy), rollMutations (copy), Mutations (copy)
	local v122 = cloneRollTableWithJackpotMutationLuck(p6, n8)

	for _ = 1, 16 do
		local v124 = rollMutations(v122)

		if Mutations.hasAny(v124) then
			return v124
		end
	end

	local t11 = {}
	local n9 = 0

	for _, v128 in Mutations.sortedMutations do
		local unlockedMutations = v122.unlockedMutations

		if unlockedMutations == nil or unlockedMutations[v128] == true then
			local v130 = 1 - math.clamp(Mutations.get(v128).odds, 0, 1)
			local mutationLuckMultipliers = v122.mutationLuckMultipliers
			local v132 = if not mutationLuckMultipliers then nil else mutationLuckMultipliers[v128]

			n9 += math.clamp(1 - v130 ^ if v132 == nil then math.max(v122.mutationLuck or 1, 1) else math.max(v132, 1), 0, 1)
			table.insert(t11, v128)
		end
	end

	if n9 <= 0 or #t11 == 0 then
		return nil
	end

	local v133 = math.random() * n9
	local n10 = 0

	for _, v136 in t11 do
		local v137 = 1 - math.clamp(Mutations.get(v136).odds, 0, 1)
		local mutationLuckMultipliers = v122.mutationLuckMultipliers
		local v139 = if not mutationLuckMultipliers then nil else mutationLuckMultipliers[v136]

		n10 += math.clamp(1 - v137 ^ if v139 == nil then math.max(v122.mutationLuck or 1, 1) else math.max(v139, 1), 0, 1)

		if v133 <= n10 then
			return {
				[v136] = true
			}
		end
	end

	return {
		[t11[#t11]] = true
	}
end

function t4.getBonusChances(p7) -- line: 328
	-- upvalues: t1 (copy)
	local v141 = math.clamp(p7.jackpotChance or t1.defaultBonusJackpotChance, 0, 1)
	local v142 = math.clamp(v141 * t1.bonusTeaseMultiplier, v141, t1.maxBonusStartChance)

	return v142, (math.clamp(not (v142 > 0) and 0 or math.sqrt(v141 / v142), 0, 1))
end
function t4.rollReward(p8, n11: number?) -- line: 337
	-- upvalues: t1 (copy), cloneRollTableWithJackpotMutationLuck (copy), rollMutations (copy), Mutations (copy), rollSlimeId (copy), Slimes (copy), getFallbackRewardAtOrAboveRarity (copy)
	local v145 = math.max(p8.luck or 1, 1)
	local v146 = math.max((n11 or 0) - t1.jackpotRewardLuckBonusStartZone, 0)
	local v147 = v145 * (t1.jackpotRewardLuckMultiplier + v146 * t1.jackpotRewardLuckBonusPerZone)
	local v148 = nil
	local n12 = 0

	for _ = 1, 128 do
		local v151 = cloneRollTableWithJackpotMutationLuck(p8, n11)
		local v152 = rollMutations(v151)
		local v153 = Mutations.hasAny(v152)
		local v154 = math.max((n11 or 0) - t1.jackpotRewardLuckBonusStartZone, 0)
		local v155 = t1.jackpotRewardLuckMultiplier + v154 * t1.jackpotRewardLuckBonusPerZone
		local v156 = if not v153 then v155 else v155 * t1.jackpotMutatedRewardLuckMultiplierFactor
		local v157 = table.clone(p8)

		v157.luck = v157.luck * v156

		local t12 = {
			id = rollSlimeId(v157, n11),
			mutations = v152
		}
		local v159 = Slimes.getSlime(t12.id).odds / Mutations.getVisualOddsMultiplier(t12.mutations)
		local v160 = if not (v159 <= 0) then 1 / v159 else 1e999

		if v147 <= v160 then
			return t12
		end

		if n12 < v160 then
			v148 = t12
			n12 = v160
		end
	end

	if v148 ~= nil and v147 <= n12 then
		return v148
	end

	return (getFallbackRewardAtOrAboveRarity(n11, v147))
end

local function rollUniqueReward(p9, n13: number?, t13: {[any]: any}, t14: {[any]: any}) -- line: 369
	-- upvalues: t4 (copy)
	for _ = 1, math.max(#t14 * 4, 8) do
		local v166 = t4.rollReward(p9, n13)

		if not t13[v166.id] then
			return v166
		end
	end

	for i = #t14, 1, -1 do
		local v168 = t14[i]

		if not t13[v168.id] then
			return {
				mutations = nil,
				id = v168.id
			}
		end
	end

	return t4.rollReward(p9, n13)
end
local function getWeakestFakeOptionIndex(t15: {[any]: any}, n14: number) -- line: 395
	-- upvalues: Slimes (copy), Mutations (copy)
	local v171 = nil
	local n15 = 1e999

	for v173, v174 in t15 do
		if v173 ~= n14 then
			local v175 = Slimes.getSlime(v174.id).odds / Mutations.getVisualOddsMultiplier(v174.mutations)
			local v176 = if not (v175 <= 0) then 1 / v175 else 1e999

			if v176 < n15 then
				v171 = v173
				n15 = v176
			end
		end
	end

	return v171
end
local function rollBestFakeOption(p10, n16: number?, t16: {[any]: any}) -- line: 414
	-- upvalues: t1 (copy), t4 (copy), Slimes (copy), Mutations (copy)
	local v180 = nil
	local n17 = 0
	local v182 = nil
	local n18 = 0

	for _ = 1, t1.jackpotFakeOptionRollCount do
		local v185 = t4.rollReward(p10, n16)
		local v186 = Slimes.getSlime(v185.id).odds / Mutations.getVisualOddsMultiplier(v185.mutations)
		local v187 = if not (v186 <= 0) then 1 / v186 else 1e999

		if n17 < v187 then
			v180 = v185
			n17 = v187
		end

		if not t16[v185.id] and n18 < v187 then
			v182 = v185
			n18 = v187
		end
	end

	return v182 or (v180 or t4.rollReward(p10, n16))
end
local function buildSpinData(p11, p12, n19: number?) -- line: 462
	-- upvalues: t1 (copy), getEligibleSlimes (copy), rollUniqueReward (copy), getWeakestFakeOptionIndex (copy), rollBestFakeOption (copy), Mutations (copy), rollGuaranteedJackpotMutations (copy)
	local v198 = math.random(1, t1.jackpotOptionCount)
	local t17 = table.create(t1.jackpotOptionCount)
	local t18 = {
		[p11.id] = true
	}
	local v201 = getEligibleSlimes(n19)

	for i = 1, t1.jackpotOptionCount do
		if i == v198 then
			local t19 = {
				id = p11.id
			}
			local mutations = p11.mutations

			t19.mutations = if mutations ~= nil then table.clone(mutations) else nil
			t17[i] = t19
		else
			local v205 = rollUniqueReward(p12, n19, t18, v201)

			t18[v205.id] = true
			t17[i] = v205
		end
	end

	local v206 = getWeakestFakeOptionIndex(t17, v198)

	if v206 ~= nil then
		t18[t17[v206].id] = nil

		local v207 = rollBestFakeOption(p12, n19, t18)

		t18[v207.id] = true
		t17[v206] = v207
	end

	local n20 = 0

	for _, v210 in t17 do
		if Mutations.hasAny(v210.mutations) then
			n20 += 1
		end
	end

	for v211, v212 in t17 do
		if n20 >= t1.jackpotMaxMutatedOptionCount then
			break
		end

		if v211 ~= v198 and not Mutations.hasAny(v212.mutations) then
			local v213 = rollGuaranteedJackpotMutations(p12, n19)

			if v213 == nil then
				break
			end

			local v214 = table.clone(v212)

			v214.mutations = v213
			t17[v211] = v214
			n20 += 1
		end
	end

	local t20 = {}
	local t21 = {
		id = p11.id
	}
	local mutations = p11.mutations

	t21.mutations = if mutations ~= nil then table.clone(mutations) else nil
	t20.reward = t21
	t20.options = t17
	t20.rewardIndex = v198

	return t20
end

function t4.rollSpinData(p13, n21: number?) -- line: 515
	-- upvalues: buildSpinData (copy), t4 (copy)
	return (buildSpinData(t4.rollReward(p13, n21), p13, n21))
end
function t4.getForcedSpinData(n22: number, p14, n23: number?) -- line: 519
	-- upvalues: t2 (copy), buildSpinData (copy), Sift (copy)
	local v223 = t2[n22]

	if v223 == nil then
		return nil
	end

	return (buildSpinData(Sift.Dictionary.copyDeep(v223), p14, n23))
end
function t4.getForcedTriggerRollResults(n24: number) -- line: 528
	-- upvalues: t3 (copy), Sift (copy)
	local v225 = t3[n24]

	if v225 == nil then
		return nil
	end

	return Sift.Dictionary.copyDeep(v225)
end
function t4.getForcedRollResults(n25: number) -- line: 537
	local t22 = {}

	for i = 1, math.max(math.floor(n25), 1) do
		t22[i] = {
			{
				kind = "BONUS"
			},
			{
				kind = "BONUS"
			},
			{
				kind = "BONUS"
			}
		}
	end

	return t22
end
function t4.isBonusJackpotColumn(p15) -- line: 551
	-- upvalues: t1 (copy)
	if #p15 ~= t1.bonusChainLengthForJackpot then
		return false
	end

	for i = 1, t1.bonusChainLengthForJackpot do
		local v231 = p15[i]

		if type(v231) ~= "table" or v231.kind ~= "BONUS" then
			return false
		end
	end

	return true
end
function t4.getBonusJackpotCount(p16) -- line: 566
	-- upvalues: t4 (copy)
	local n26 = 0

	for _, v235 in p16 do
		if t4.isBonusJackpotColumn(v235) then
			n26 += 1
		end
	end

	return n26
end
function t4.isBonusJackpot(p17) -- line: 578
	-- upvalues: t4 (copy)
	return t4.getBonusJackpotCount(p17) > 0
end
function t4.shouldEndBonusChain(n27: number) -- line: 582
	-- upvalues: t1 (copy)
	return n27 >= t1.bonusChainLengthForJackpot
end

return t4
