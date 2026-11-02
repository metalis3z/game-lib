-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SpecialRollUtils, time of decompilation: Sun May  3 10:11:45 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local t1 = {
	"golden",
	"diamond",
	"void"
}
local t2 = {
	"void",
	"diamond",
	"golden"
}
local t3 = {
	golden = {
		upgradeKey = "goldenRolls",
		defaultMultiplier = 2,
		enhancedMultiplier = 2.5,
		image = ImageIds.goldDice,
		baseCadence = UpgradeServiceUtils.enums.luckRolls.golden[1]
	},
	diamond = {
		upgradeKey = "diamondRolls",
		defaultMultiplier = 5,
		enhancedMultiplier = 6.5,
		image = ImageIds.diamondDice,
		baseCadence = UpgradeServiceUtils.enums.luckRolls.diamond[1]
	},
	void = {
		upgradeKey = "voidRolls",
		defaultMultiplier = 50,
		enhancedMultiplier = 65,
		image = ImageIds.voidDice,
		baseCadence = UpgradeServiceUtils.enums.luckRolls.void[1]
	}
}
local t5 = {
	getKinds = function() --[[ getKinds ]] -- line: 40
		-- upvalues: t1 (copy)
		return t1
	end,
	getConfig = function(p1) --[[ getConfig ]] -- line: 44
		-- upvalues: t3 (copy)
		return t3[p1]
	end,
	getUpgradeLevel = function(p2, t4: {[any]: any}?) --[[ getUpgradeLevel ]] -- line: 48
		-- upvalues: t3 (copy), UpgradeServiceUtils (copy)
		local v11 = t3[p2]

		return UpgradeServiceUtils.getUpgradeLevel(v11.upgradeKey, t4 or {})
	end
}

function t5.isUnlocked(p3, t6: {[any]: any}?) -- line: 53
	-- upvalues: t5 (copy)
	return t5.getUpgradeLevel(p3, t6) > 0
end
function t5.getRollCadence(p4, t7: {[any]: any}?) -- line: 57
	-- upvalues: t5 (copy), UpgradeServiceUtils (copy)
	local v16 = t5.getUpgradeLevel(p4, t7)

	if v16 <= 0 then
		return nil
	end

	local v17 = UpgradeServiceUtils.enums.luckRolls[p4]

	return v17[math.min(v16, 3)] or v17[1]
end
function t5.getBaseRollCadence(p5) -- line: 67
	-- upvalues: t3 (copy)
	return t3[p5].baseCadence
end
function t5.getLuckMultiplier(p6, t8: {[any]: any}?) -- line: 71
	-- upvalues: t5 (copy), t3 (copy)
	if t5.getUpgradeLevel(p6, t8) >= 4 then
		return t3[p6].enhancedMultiplier
	end

	return t3[p6].defaultMultiplier
end
function t5.getImage(p7) -- line: 80
	-- upvalues: t3 (copy)
	return t3[p7].image
end
function t5.getHighestPriorityActiveKind(p8) -- line: 84
	-- upvalues: t2 (copy)
	if not p8 then
		return nil
	end

	for _, v24 in t2 do
		if p8[v24] then
			return v24
		end
	end

	return nil
end
function t5.resolveProgression(p9, t9: {[any]: any}?) -- line: 98
	-- upvalues: t1 (copy), t5 (copy)
	local t10 = {}

	for _, v29 in t1 do
		local v30 = t5.getRollCadence(v29, t9) or t5.getBaseRollCadence(v29)
		local v31 = if not p9 then nil else p9[v29]

		if v31 and type(v31.rollsUntilNext) == "number" then
			v30 = math.clamp(math.floor(v31.rollsUntilNext), 0, v30)
		end

		t10[v29] = {
			rollsUntilNext = v30,
			paused = not not v31 and v31.paused == true
		}
	end

	return t10
end
function t5.getProgress(p10, p11, t11: {[any]: any}?) -- line: 122
	-- upvalues: t5 (copy)
	local v35 = t5.getRollCadence(p10, t11) or t5.getBaseRollCadence(p10)
	local v36 = if not p11 then nil else p11[p10]

	return (math.clamp((v35 - (if not v36 then v35 else v36.rollsUntilNext)) / v35, 0, 1))
end

return t5
