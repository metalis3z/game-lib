-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PlayerUpgradeUtils, time of decompilation: Sun May  3 10:11:35 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)
local t2 = {
	MIN_WALK_SPEED = 16,
	DEFAULT_WALK_SPEED = 22,
	getMagnetLevel = function(t1: {[any]: any}?) --[[ getMagnetLevel ]] -- line: 10
		-- upvalues: UpgradeServiceUtils (copy)
		return UpgradeServiceUtils.getUpgradeLevel("magnet", t1 or {})
	end
}

function t2.getMagnetRadius(t3: {[any]: any}?) -- line: 14
	-- upvalues: t2 (copy), UpgradeServiceUtils (copy)
	local v6 = t2.getMagnetLevel(t3)

	return UpgradeServiceUtils.getUpgradeValue("magnetRadius", v6)
end
function t2.getWalkSpeedLevel(t4: {[any]: any}?) -- line: 19
	-- upvalues: UpgradeServiceUtils (copy)
	return UpgradeServiceUtils.getUpgradeLevel("walkSpeed", t4 or {})
end
function t2.getWalkSpeed(t5: {[any]: any}?) -- line: 23
	-- upvalues: t2 (copy), UpgradeServiceUtils (copy)
	local v9 = t2.getWalkSpeedLevel(t5)

	return UpgradeServiceUtils.getUpgradeValue("walkSpeed", v9)
end
function t2.getAppliedWalkSpeed(t6: {[any]: any}?, n1: number?) -- line: 28
	-- upvalues: t2 (copy)
	local v12 = t2.getWalkSpeed(t6)

	if type(n1) ~= "number" then
		return (math.clamp(t2.DEFAULT_WALK_SPEED, t2.MIN_WALK_SPEED, v12))
	end

	return (math.clamp(math.round(n1), t2.MIN_WALK_SPEED, v12))
end
function t2.getMaxEnemies(t7: {[any]: any}?) -- line: 40
	-- upvalues: UpgradeServiceUtils (copy)
	local v14 = UpgradeServiceUtils.getUpgradeLevel("enemyCount", t7 or {})

	return (math.max(1, UpgradeServiceUtils.getUpgradeValue("enemyCount", v14)))
end

return t2
