-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage:WaitForChild("Shared")
local ScreenSpaceVolume = require(Shared.Utils.Spatial).ScreenSpaceVolume
local RateForDistance = require(Shared.Utils.VFX).RateForDistance
local Resizer = require(Shared.Utils.VisualTransform).Resizer
local Audio = require(Shared.Audio)
local FrameStepper = require(Shared.Utils.FrameStepper)
local t = require(ReplicatedStorage.Packages.t)
local v1 = {
    studsAhead = 5,
    studsTall = 1,
    properties = {
        Anchored = true,
        CanCollide = false,
        CanQuery = false,
        CanTouch = false,
        Transparency = 1
    }
}
local v2 = {
    seconds = 5,
    volume = 1,
    rate = 1,
    speed = 1,
    size = 1
}
local v3 = {
    startDelay = 0.75,
    depthJitter = 0.1,
    drag = 2.65,
    emitCountAttribute = "EmitCount",
    speed = NumberRange.new(-30, -20),
    soundIds = { "rbxassetid://101532170790748" },
    pitch = { 0.95, 1.05 },
    volume = NumberRange.new(1.9, 2.1)
}
local v4 = {}
local v5 = { 253, 255, 106 }

v4[1] = { 168, 100, 253 }
v4[2] = { 41, 205, 255 }
v4[3] = { 120, 255, 68 }
v4[4] = { 255, 85, 85 }
v4[5] = v5

local v6 = table.create(#v4)
for v7, v8 in v4 do
    v6[v7] = Color3.fromRGB(v8[1], v8[2], v8[3])
end
local v9 = {}

local function fallback(v10, v11) -- line 58
    return v10 or v11
end

local function optedIn(v12) -- line 61
    return v12 ~= false
end

local function raiseCanvas() -- line 65 | captures: ScreenSpaceVolume, v1
    local Part = Instance.new("Part")
    for v13, v14 in v1.properties do
        Part[v13] = v14
    end
    local v15, v16 = ScreenSpaceVolume(v1.studsAhead, v1.studsTall)
    Part.CFrame = v15
    Part.Size = v16
    return Part
end

function v9.Burst(v17) -- line 79 | captures: ScreenSpaceVolume, RateForDistance, Resizer, Audio, FrameStepper, t, v1, v3, v6
    t.strict(t.optional(t.table))(v17)
    local v18 = v17 or {}
    local v19 = {
        seconds = v18.Duration or 5,
        volume = v18.VolumeScale or 1,
        rate = v18.RateScale or 1,
        speed = v18.SpeedScale or 1,
        size = v18.SizeScale or 1
    }
    v19.isPopUp = v18.PopUp ~= false
    v19.wantsSound = v18.PopSounds ~= false
    -- [[ raiseCanvas
    local Part = Instance.new("Part")
    for v20, v21 in v1.properties do
        Part[v20] = v21
    end
    local v22, v23 = ScreenSpaceVolume(v1.studsAhead, v1.studsTall)
    Part.CFrame = v22
    Part.Size = v23
    -- ]] raiseCanvas
    local v24 = Resizer()
    local v25 = {}
    local v26 = 0
    for v27, v28 in v18.Colors or v6 do
        local v29 = script:WaitForChild("ParticleEmitter"):Clone()
        v25[#v25 + 1] = v29
        local v30 = v29.Lifetime.Max / v29.TimeScale
        v26 = math.max(v26, v30)
        v29.Color = ColorSequence.new(v28)
        if v18.Texture ~= nil and v18.Texture ~= "" then
            v29.Texture = v18.Texture
        end
        local v31 = math.random() * 2 - 1
        v29.ZOffset += v31 * v3.depthJitter
        v29.Rate = RateForDistance(v29.Rate * v19.rate, Part.Position)
        local Speed = v29.Speed
        v29.Speed = NumberRange.new(Speed.Min * v19.speed, Speed.Max * v19.speed)
        if v19.size ~= 1 then
            v24(v29, v19.size)
        end
        v29.Enabled = false
        v29.Parent = Part
    end
    Part.Parent = workspace.CurrentCamera
    local v32 = if v19.isPopUp then v3.startDelay else 0
    local v33 = not v19.isPopUp
    for v34, v35 in v25 do
        if v19.isPopUp then
            local v36 = (v35:GetAttribute(v3.emitCountAttribute) or 0) * v19.rate
            local v37 = math.round(v36)
            if v37 > 0 then
                local v38 = v35:Clone()
                v38.EmissionDirection = Enum.NormalId.Bottom
                v38.Speed = v3.speed
                v38.Drag = v3.drag
                v38.Parent = Part
                v38:Emit(v37)
            end
        else
            v35.Enabled = true
        end
    end
    if v19.isPopUp and v19.volume > 0 and v19.wantsSound then
        Audio.Play(v3.soundIds, workspace.CurrentCamera, {
            PlaybackSpeed = v3.pitch,
            Volume = {
                v3.volume.Min * v19.volume,
                v3.volume.Max * v19.volume
            }
        })
    end
    local OnRender = FrameStepper.OnRender

    local function v39(v40, v41) -- line 169 | captures: v32, v33, v19, Part, v25, ScreenSpaceVolume, v1
        local v42, v43 = ScreenSpaceVolume(v1.studsAhead, v1.studsTall)
        Part.CFrame = v42
        Part.Size = v43
        local v44 = if v32 <= v41 then v41 < v32 + v19.seconds else false
        if v33 ~= v44 then
            v33 = v44
            for v45, v46 in v25 do
                v46.Enabled = v44
            end
        end
    end

    local seconds = v19.seconds
    return OnRender(v39, v32 + seconds + v26):OnComplete(function() -- line 186 | captures: Part
        Part:Destroy()
    end)
end

return v9
