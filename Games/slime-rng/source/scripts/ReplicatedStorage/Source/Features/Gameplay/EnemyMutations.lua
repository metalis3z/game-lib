-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: EnemyMutations, time of decompilation: Sun May  3 10:11:18 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)
local t1 = {
	big = 0.01,
	huge = 0.001,
	shiny = 0.004,
	inverted = 0.0004
}
local t2 = {
	big = {
		id = "big",
		unlockUpgradeId = "bigEnemies",
		chanceUpgradeKey = "bigEnemyChance",
		diceItemId = "bigDice",
		spawnCooldown = 30,
		stats = {
			healthMultiplier = 4,
			damageMultiplier = 1.25
		},
		rewards = {
			coinMultiplier = 7,
			goopMultiplier = 6
		},
		loot = {
			guaranteedRollCount = 0,
			diceDropChance = 0.01,
			bonusRollChances = { 0.66 }
		}
	},
	huge = {
		id = "huge",
		unlockUpgradeId = "hugeEnemies",
		chanceUpgradeKey = "hugeEnemyChance",
		diceItemId = "hugeDice",
		spawnCooldown = 420,
		stats = {
			healthMultiplier = 12,
			damageMultiplier = 1.75
		},
		rewards = {
			coinMultiplier = 20,
			goopMultiplier = 20
		},
		loot = {
			guaranteedRollCount = 2,
			diceDropChance = 0.01,
			bonusRollChances = {
				0.5,
				0.5
			}
		}
	},
	shiny = {
		id = "shiny",
		unlockUpgradeId = "shinyEnemies",
		chanceUpgradeKey = "shinyEnemyChance",
		diceItemId = "shinyDice",
		spawnCooldown = 120,
		stats = {
			healthMultiplier = 7,
			damageMultiplier = 1.5
		},
		rewards = {
			coinMultiplier = 13,
			goopMultiplier = 12
		},
		loot = {
			guaranteedRollCount = 1,
			diceDropChance = 0.01,
			bonusRollChances = {
				0.5,
				0.2
			}
		}
	},
	inverted = {
		id = "inverted",
		unlockUpgradeId = "invertedEnemies",
		chanceUpgradeKey = "invertedEnemyChance",
		diceItemId = "invertedDice",
		spawnCooldown = 900,
		stats = {
			healthMultiplier = 20,
			damageMultiplier = 2
		},
		rewards = {
			coinMultiplier = 35,
			goopMultiplier = 34
		},
		loot = {
			guaranteedRollCount = 3,
			diceDropChance = 0.01,
			bonusRollChances = {
				0.75,
				0.5
			}
		}
	}
}
local t3 = {
	pendingUnlockRewardDataKey = "pendingEnemyMutationUnlockRewards",
	enemyMutationOdds = t1,
	configs = t2
}

local function rollExclusiveMutations(t4: {[any]: any}, t5: {[any]: any}, t6: {[any]: any}?) -- line: 185
	-- upvalues: t2 (copy), UpgradeServiceUtils (copy), t1 (copy)
	local n1 = 0

	for _, v32 in t5 do
		local v33 = t2[v32]

		if v33 ~= nil and UpgradeServiceUtils.ownsUpgrade(v33.unlockUpgradeId, t4) and (t6 == nil or (t6[v32] or 0) <= 0) then
			local v34 = t2[v32]
			local n2

			if not v34 then
				n2 = 0
			else
				local v36 = t1[v32] or 0
				local v37 = UpgradeServiceUtils.getUpgradeLevel(v34.chanceUpgradeKey, t4)

				n2 = math.clamp(v36 * math.max(UpgradeServiceUtils.getUpgradeValue(v34.chanceUpgradeKey, v37), 0), 0, 1)
			end

			n1 += n2
		end
	end

	if n1 <= 0 or math.random() >= math.clamp(n1, 0, 1) then
		return nil
	end

	local v38 = math.random() * n1
	local n3 = 0

	for _, v41 in t5 do
		local v42 = t2[v41]

		if v42 == nil or not UpgradeServiceUtils.ownsUpgrade(v42.unlockUpgradeId, t4) or t6 ~= nil and not ((t6[v41] or 0) <= 0) then
			continue
		end

		local v43 = t2[v41]
		local n4

		if not v43 then
			n4 = 0
		else
			local v45 = t1[v41] or 0
			local v46 = UpgradeServiceUtils.getUpgradeLevel(v43.chanceUpgradeKey, t4)

			n4 = math.clamp(v45 * math.max(UpgradeServiceUtils.getUpgradeValue(v43.chanceUpgradeKey, v46), 0), 0, 1)
		end

		n3 += n4

		if v38 <= n3 then
			return v41
		end
	end

	return nil
end

function t3.getConfig(p1) -- line: 217
	-- upvalues: t2 (copy)
	return t2[p1]
end
function t3.getUnlockMutationId(s1: string) -- line: 221
	-- upvalues: t2 (copy)
	for v49, v50 in t2 do
		if s1 == v50.unlockUpgradeId then
			return v49
		end
	end

	return nil
end
function t3.normalizePendingUnlockRewards(p2) -- line: 231
	-- upvalues: t2 (copy)
	local t7 = {}

	if type(p2) ~= "table" then
		return t7
	end

	for _, v54 in p2 do
		if type(v54) == "string" and t2[v54] ~= nil then
			table.insert(t7, v54)
		end
	end

	return t7
end
function t3.appendPendingUnlockReward(p3, p4) -- line: 246
	-- upvalues: t3 (copy)
	local v57 = t3.normalizePendingUnlockRewards(p3)

	table.insert(v57, p4)

	return v57
end
function t3.consumePendingUnlockReward(p5) -- line: 252
	-- upvalues: t3 (copy)
	local v59 = t3.normalizePendingUnlockRewards(p5)
	local v60 = v59[1]

	if v60 ~= nil then
		table.remove(v59, 1)
	end

	return v59, v60
end
function t3.isUnlocked(p6, t8: {[any]: any}?) -- line: 262
	-- upvalues: t2 (copy), UpgradeServiceUtils (copy)
	local v63 = t8 or {}
	local v64 = t2[p6]

	return v64 ~= nil and UpgradeServiceUtils.ownsUpgrade(v64.unlockUpgradeId, v63)
end
function t3.getRollChance(p7, t9: {[any]: any}?) -- line: 266
	-- upvalues: t2 (copy), t1 (copy), UpgradeServiceUtils (copy)
	local v67 = t9 or {}
	local v68 = t2[p7]

	if not v68 then
		return 0
	end

	local v69 = t1[p7] or 0
	local v70 = UpgradeServiceUtils.getUpgradeLevel(v68.chanceUpgradeKey, v67)

	return (math.clamp(v69 * math.max(UpgradeServiceUtils.getUpgradeValue(v68.chanceUpgradeKey, v70), 0), 0, 1))
end
function t3.roll(t10: {[any]: any}?, t11: {[any]: any}?) -- line: 270
	-- upvalues: rollExclusiveMutations (copy), Mutations (copy), t2 (copy), UpgradeServiceUtils (copy), t1 (copy)
	local v73 = t10 or {}
	local t12 = {}
	local v75 = false
	local v76 = rollExclusiveMutations(v73, Mutations.sizeMutations, t11)

	if v76 ~= nil then
		t12[v76] = true
		v75 = true
	end

	for _, v78 in Mutations.modifierMutations do
		local v79 = t2[v78]

		if v79 ~= nil and UpgradeServiceUtils.ownsUpgrade(v79.unlockUpgradeId, v73) and (t11 == nil or (t11[v78] or 0) <= 0) then
			local v80 = math.random()
			local v81 = t2[v78]
			local n5

			if not v81 then
				n5 = 0
			else
				local v83 = t1[v78] or 0
				local v84 = UpgradeServiceUtils.getUpgradeLevel(v81.chanceUpgradeKey, v73)

				n5 = math.clamp(v83 * math.max(UpgradeServiceUtils.getUpgradeValue(v81.chanceUpgradeKey, v84), 0), 0, 1)
			end

			if v80 <= n5 then
				t12[v78] = true
				v75 = true
			end
		end
	end

	if v75 then
		return t12
	end

	return nil
end
function t3.withForcedMutation(p8, p9) -- line: 298
	-- upvalues: Mutations (copy)
	if p9 == nil then
		if p8 then
			return (table.clone(p8))
		end

		return nil
	end

	local v87 = if not p8 then {} else table.clone(p8)

	if Mutations.get(p9).category == "size" then
		for _, v89 in Mutations.sizeMutations do
			v87[v89] = nil
		end
	end

	v87[p9] = true

	if next(v87) then
		return v87
	end

	return nil
end
function t3.getSpawnModifiers(p10) -- line: 318
	-- upvalues: Mutations (copy), t2 (copy)
	local t13 = {
		coinMultiplier = 1,
		healthMultiplier = 1,
		damageMultiplier = 1,
		speedMultiplier = 1,
		attackSpeedMultiplier = 1,
		scale = Mutations.getSizeScale(p10)
	}

	if not p10 then
		return t13
	end

	for _, v93 in Mutations.sortedMutations do
		if p10[v93] then
			local v94 = t2[v93]

			if v94 then
				t13.coinMultiplier = t13.coinMultiplier + ((v94.rewards.coinMultiplier or 1) - 1)
				t13.healthMultiplier = t13.healthMultiplier + ((v94.stats.healthMultiplier or 1) - 1)
				t13.damageMultiplier = t13.damageMultiplier + ((v94.stats.damageMultiplier or 1) - 1)
				t13.speedMultiplier = t13.speedMultiplier + ((v94.stats.speedMultiplier or 1) - 1)
				t13.attackSpeedMultiplier = t13.attackSpeedMultiplier + ((v94.stats.attackSpeedMultiplier or 1) - 1)
			end
		end
	end

	return t13
end
function t3.getGoopRewardMultiplier(p11) -- line: 353
	-- upvalues: Mutations (copy), t2 (copy)
	local n6 = 1

	if not p11 then
		return n6
	end

	for _, v98 in Mutations.sortedMutations do
		local v99 = t2[v98]

		if p11[v98] and v99 then
			n6 += (v99.rewards.goopMultiplier or 1) - 1
		end
	end

	return n6
end

return t3
