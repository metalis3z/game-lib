-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local CameraShakeInstance = require(script.Parent.CameraShakeInstance)
local v1 = {}

function v1.Bump() -- line 10 | captures: CameraShakeInstance
    local v2 = CameraShakeInstance.new(2.5, 4, 0.1, 0.75)
    v2.PositionInfluence = Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448)
    v2.RotationInfluence = Vector3.new(1, 1, 1)
    return v2
end

function v1.Explosion() -- line 16 | captures: CameraShakeInstance
    local v3 = CameraShakeInstance.new(5, 10, 0, 1.5)
    v3.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
    v3.RotationInfluence = Vector3.new(4, 1, 1)
    return v3
end

function v1.Earthquake() -- line 22 | captures: CameraShakeInstance
    local v4 = CameraShakeInstance.new(0.6, 3.5, 2, 10)
    v4.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
    v4.RotationInfluence = Vector3.new(1, 1, 4)
    return v4
end

function v1.BadTrip() -- line 28 | captures: CameraShakeInstance
    local v5 = CameraShakeInstance.new(10, 0.15, 5, 10)
    v5.PositionInfluence = Vector3.new(0, 0, 0.15000000596046448)
    v5.RotationInfluence = Vector3.new(2, 1, 4)
    return v5
end

function v1.HandheldCamera() -- line 34 | captures: CameraShakeInstance
    local v6 = CameraShakeInstance.new(1, 0.25, 5, 10)
    v6.PositionInfluence = Vector3.new(0, 0, 0)
    v6.RotationInfluence = Vector3.new(1, 0.5, 0.5)
    return v6
end

function v1.Vibration() -- line 40 | captures: CameraShakeInstance
    local v7 = CameraShakeInstance.new(0.4, 20, 2, 2)
    v7.PositionInfluence = Vector3.new(0, 0.15000000596046448, 0)
    v7.RotationInfluence = Vector3.new(1.25, 0, 4)
    return v7
end

function v1.RoughDriving() -- line 46 | captures: CameraShakeInstance
    local v8 = CameraShakeInstance.new(1, 2, 1, 1)
    v8.PositionInfluence = Vector3.new(0, 0, 0)
    v8.RotationInfluence = Vector3.new(1, 1, 1)
    return v8
end

function v1.WeakEarthquake() -- line 52 | captures: CameraShakeInstance
    local v9 = CameraShakeInstance.new(0.3, 1.5, 1, 5)
    v9.PositionInfluence = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
    v9.RotationInfluence = Vector3.new(0.5, 0.5, 1)
    return v9
end

local v10 = {}
local Bump = t.literal("Bump")
local Explosion = t.literal("Explosion")
local Earthquake = t.literal("Earthquake")
local BadTrip = t.literal("BadTrip")
local HandheldCamera = t.literal("HandheldCamera")
local Vibration = t.literal("Vibration")

v10._allPresetsLiteral = t.union(Bump, Explosion, Earthquake, BadTrip, HandheldCamera, Vibration, t.literal("RoughDriving"))

local v11 = {}

function v11.__index(v12, v13) -- line 68 | captures: v1
    local v14 = v1[v13]
    if type(v14) == "function" then
        return v14()
    end
    error("No preset found with index \"" .. v13 .. "\"")
end

return (setmetatable(v10, v11))
