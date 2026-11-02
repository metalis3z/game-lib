-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Guards = require(ReplicatedStorage.Data.Guards)
local MonsterParasite = require(ReplicatedStorage.Data.MonsterParasite)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local freeze = table.freeze
local v1 = {}

function v1.IsEligible(v2) -- line 11 | captures: Guards, MonsterParasite, TreadmillUtil
    local v3 = Guards.Directory[MonsterParasite.EligibilityGuardId]
    if v3 == nil then
        return false
    end
    local v4 = TreadmillUtil.SpeedPowerToWalkSpeed(v2)
    return v3.WalkSpeed <= v4
end

return freeze(v1)
