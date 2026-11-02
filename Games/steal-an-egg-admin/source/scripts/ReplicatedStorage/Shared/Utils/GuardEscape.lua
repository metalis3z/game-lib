-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuardEscapePrediction = require(ReplicatedStorage.Shared.Modules.GuardAreas.GuardEscapePrediction)
require(ReplicatedStorage.Shared.Modules.GuardAreas.Types.Interface)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}
local v2 = t.strict(t.table)

function v1.RequiredSpeedPower(v3) -- line 13 | captures: GuardEscapePrediction, TreadmillUtil, v2
    v2(v3)
    local v4 = GuardEscapePrediction.ResolvePlayerWalkSpeedRequirement(v3, 0.9)
    return TreadmillUtil.RoundSpeedPowerRequirement(TreadmillUtil.WalkSpeedToSpeedPower(v4) * 1.05)
end

return v1
