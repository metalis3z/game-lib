-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}

function v1.XZ(v2, v3) -- line 9 | captures: t
    t.strict(t.Vector3)(v2)
    t.strict(t.Vector3)(v3)
    local v4 = v2 - v3
    local X = v4.X
    local Z = v4.Z
    return Vector3.new(X, 0, Z).Magnitude
end

return v1
