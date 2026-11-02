-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local FollowerLoop = require(script.FollowerLoop)
local SurfaceTracker = require(script.SurfaceTracker)
local v1 = {}

function v1.AttachToModel(v2, v3, v4) -- line 9 | captures: FollowerLoop, SurfaceTracker
    FollowerLoop.Drop(v2)
    local v5 = v4 or {}
    if v5.MaxActivationDistance ~= nil then
        v2.MaxActivationDistance = v5.MaxActivationDistance
    end
    local v6 = FollowerLoop.MakeAnchor(v5.PartName, v3:GetPivot())
    local v7 = SurfaceTracker.new(v3, v6)
    v2.RequiresLineOfSight = false
    return FollowerLoop.Add(v2, v3, v6, v7, v5)
end

return v1
