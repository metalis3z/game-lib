-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local GuardEscapePrediction = require(ReplicatedStorage.Library.Modules.GuardAreas.GuardEscapePrediction)

require(ReplicatedStorage.Library.Modules.GuardAreas.Types.Interface)

local TreadmillUtil = require(ReplicatedStorage.Library.Util.TreadmillUtil)

return function(p1) --[[ Line: 16 | Upvalues: Asserts (copy), GuardEscapePrediction (copy), TreadmillUtil (copy) ]]
	Asserts.table(p1)

	return TreadmillUtil.RoundSpeedPowerRequirement(TreadmillUtil.WalkSpeedToSpeedPower((GuardEscapePrediction.ResolvePlayerWalkSpeedRequirement(p1, 0.9))) * 1.05)
end