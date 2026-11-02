-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: screenCoveredSource, time of decompilation: Sun May  3 10:11:16 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RollSlice = require(ReplicatedStorage.Source.Features.Roll.RollSlice)
local UpgradeSlice = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeSlice)

return function() -- line: 6
	-- upvalues: UpgradeSlice (copy), RollSlice (copy)
	return UpgradeSlice.shown() or (RollSlice.rollScreenShown() or (RollSlice.rareRollCutsceneShown() or (RollSlice.rareRollCutsceneData() ~= nil or RollSlice.jackpotScreenShown())))
end
