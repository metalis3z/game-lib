-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.strict(t.instanceIsA("BasePart"))
local v2 = t.strict(t.Vector3)
local v3 = t.strict(t.number)
local v4 = t.strict(t.optional(t.number))
local v5 = { CLAIM_PRELOAD_DISTANCE_STUDS = 50 }

function v5.GetShortestDistanceToClaimLine(v6, v7) -- line 15 | captures: GuardAreaGeometry, v1, v2
    v1(v6)
    v2(v7)
    local v8 = GuardAreaGeometry.SignedDistanceToLine(v6, v7)
    return (math.abs(v8))
end

function v5.IsSpeedEligible(v9, v10) -- line 20 | captures: v3, v4
    v3(v9)
    v4(v10)
    if v10 == nil then
        return false
    end
    return v10 <= v9
end

function v5.IsWithinClaimPreloadDistance(v11) -- line 27 | captures: v3, v5
    v3(v11)
    return v11 < v5.CLAIM_PRELOAD_DISTANCE_STUDS
end

function v5.ShouldPreloadCarriedEgg(v12, v13, v14) -- line 32 | captures: v4, v5
    v4(v14)
    local v15 = v5.IsSpeedEligible(v12, v13)
    if not v15 then
        if v14 ~= nil then
            return (v5.IsWithinClaimPreloadDistance(v14))
        end
        v15 = false
    end
    return v15
end

return table.freeze(v5)
