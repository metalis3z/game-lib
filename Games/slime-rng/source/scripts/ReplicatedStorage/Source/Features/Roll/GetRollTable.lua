-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: GetRollTable, time of decompilation: Sun May  3 10:11:42 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MonetizationServiceUtils = require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceUtils)
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local RollStatResolver = require(ReplicatedStorage.Source.Features.Roll.RollStatResolver)

return function(_, t1: {[any]: any}?) -- line: 25
	-- upvalues: RollStatResolver (copy), MonetizationServiceUtils (copy), UpgradeServiceUtils (copy)
	local v7 = RollStatResolver.resolve({
		upgradesOwned = if not t1 then nil else t1.upgradesOwned,
		specialLuckBonus = if not t1 then nil else t1.specialLuckBonus,
		zoneLuckBonus = if not t1 then nil else t1.zoneLuckBonus,
		modifiers = if not t1 then nil else t1.modifiers,
		ownsProductKey = if not t1 then nil else t1.ownsProductKey,
		luckOverrideEnabled = if not t1 then nil else t1.luckOverrideEnabled,
		luckOverrideValue = if not t1 then nil else t1.luckOverrideValue
	})

	return {
		rolls = 0,
		luck = v7.luck,
		maxLuck = v7.maxLuck,
		luckOverridden = v7.luckOverridden,
		columns = MonetizationServiceUtils.getRollColumns(if not t1 then nil else t1.ownsProductKey),
		extraRollChance = UpgradeServiceUtils.getUpgradeValue("extraRollChance", UpgradeServiceUtils.getUpgradeLevel("extraRollChance", if not t1 then {} else t1.upgradesOwned or {})),
		luckRollChance = v7.luckRollChance,
		jackpotChance = v7.jackpotChance,
		rollTime = v7.rollTime,
		rollSpeedMultiplier = v7.rollSpeedMultiplier,
		unlockedMutations = UpgradeServiceUtils.getUnlockedMutations(if not t1 then nil else t1.upgradesOwned),
		activeSpecialRolls = if not t1 then {} else t1.activeSpecialRolls or {},
		specialRollProgression = if not t1 then nil else t1.specialRollProgression
	}
end
