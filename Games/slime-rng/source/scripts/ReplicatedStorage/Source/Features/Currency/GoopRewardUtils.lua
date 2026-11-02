-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: GoopRewardUtils, time of decompilation: Sun May  3 10:11:30 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)
local t3 = {
	isUnlocked = function(t1: {[any]: any}) --[[ isUnlocked ]] -- line: 7
		-- upvalues: UpgradeServiceUtils (copy)
		return UpgradeServiceUtils.ownsUpgrade("goop", t1 or {})
	end,
	getBaseEnemyGoopReward = function(n1: number) --[[ getBaseEnemyGoopReward ]] -- line: 11
		if n1 <= 3 then
			return 1
		end

		if n1 <= 6 then
			return n1 - 2
		end

		if n1 < 13 then
			return (math.round((n1 - 5) * 1.135 ^ (n1 - 6) + 5))
		end

		return (math.round(1.4 ^ (n1 - 13) * 27))
	end,
	getDropChance = function(t2: {[any]: any}) --[[ getDropChance ]] -- line: 24
		-- upvalues: UpgradeServiceUtils (copy)
		return UpgradeServiceUtils.getGoopDropRate(t2)
	end
}

function t3.getEnemyGoopReward(n2: number, t4: {[any]: any}, n3: number?) -- line: 28
	-- upvalues: t3 (copy)
	local v10 = t3.getDropChance(t4)

	if v10 <= 0 then
		return 0
	end

	if v10 < (n3 or math.random()) then
		return 0
	end

	return t3.getBaseEnemyGoopReward(n2)
end
function t3.getGuaranteedEnemyGoopReward(n4: number, t5: {[any]: any}) -- line: 45
	-- upvalues: t3 (copy)
	if not t3.isUnlocked(t5 or {}) then
		return 0
	end

	return t3.getBaseEnemyGoopReward(n4)
end
function t3.getAverageEnemyGoopReward(n5: number, t6: {[any]: any}) -- line: 53
	-- upvalues: t3 (copy)
	local v15 = t3.getDropChance(t6)

	if v15 <= 0 then
		return 0
	end

	return t3.getBaseEnemyGoopReward(n5) * v15
end

return t3
