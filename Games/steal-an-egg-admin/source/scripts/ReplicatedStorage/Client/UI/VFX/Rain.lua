-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Shared = game:GetService("ReplicatedStorage"):WaitForChild("Shared")
local ScreenSpaceVolume = require(Shared.Utils.Spatial).ScreenSpaceVolume
local RateForDistance = require(Shared.Utils.VFX).RateForDistance
local OnRender = require(Shared.Utils.FrameStepper).OnRender
local ScaleSequence = require(Shared.Utils.VFX).ScaleSequence
local Resizer = require(Shared.Utils.VisualTransform).Resizer
local Audio = require(Shared.Audio)
local v1 = {
    studsAhead = 10,
    studsTall = 2,
    properties = {
        Anchored = true,
        CanCollide = false,
        CanQuery = false,
        CanTouch = false,
        Transparency = 1
    }
}
local v2 = {
    seconds = 3,
    volume = 1,
    rate = 1,
    speed = 1,
    size = 1,
    drag = 2.65,
    manualEmit = 1
}
local v3 = {
    popUpDelay = 0.75,
    manualJitter = 0.35,
    depthJitter = 0.1,
    emitCountAttribute = "EmitCount",
    fallSpeed = NumberRange.new(-30, -20)
}
local v4 = {}

local function fallback(v5, v6) -- line 41
    return v5 or v6
end

local function raiseCanvas() -- line 44 | captures: ScreenSpaceVolume, v1
    local Part = Instance.new("Part")
    for v7, v8 in v1.properties do
        Part[v7] = v8
    end
    local v9, v10 = ScreenSpaceVolume(v1.studsAhead, v1.studsTall)
    Part.CFrame = v9
    Part.Size = v10
    return Part
end

local function ring(v11, v12) -- line 58 | captures: Audio
    if v11 ~= nil and v12 > 0 then
        Audio.Play(v11.Assets, workspace.CurrentCamera, {
            PlaybackSpeed = v11.Pitch,
            Volume = v11.Volume
        })
    end
end

local function shedFrom(v13, v14, v15) -- line 63 | captures: v3
    local v16 = v13:Clone()
    v16.EmissionDirection = Enum.NormalId.Bottom
    v16.Speed = v3.fallSpeed
    v16.Drag = v15
    v16.Parent = v14
    return v16
end

function v4.Fall(v17) -- line 71 | captures: ScreenSpaceVolume, RateForDistance, OnRender, ScaleSequence, Resizer, Audio, v1, v3
    local v18 = {
        seconds = v17.Duration or 3,
        volume = v17.VolumeScale or 1,
        rate = v17.RateScale or 1,
        speed = v17.SpeedScale or 1,
        size = v17.SizeScale or 1,
        drag = v17.Drag or 2.65,
        manualEmit = v17.ManualEmitAmount or 1
    }
    v18.isPopUp = v17.PopUp == true
    v18.isManual = v17.ManualEmitMode == true
    -- [[ raiseCanvas
    local Part = Instance.new("Part")
    for v19, v20 in v1.properties do
        Part[v19] = v20
    end
    local v21, v22 = ScreenSpaceVolume(v1.studsAhead, v1.studsTall)
    Part.CFrame = v21
    Part.Size = v22
    -- ]] raiseCanvas
    local v23 = Resizer()
    local v24 = {}
    local v25 = #v17.Particles
    local v26 = 0
    for v27, v28 in v17.Particles do
        local v29 = script:WaitForChild("ParticleEmitter"):Clone()
        v29.Texture = v28.Texture
        v29.LightEmission = v28.LightEmission or v29.LightEmission
        v29.LightInfluence = v28.LightInfluence or v29.LightInfluence
        if v28.SizeScalar then
            v29.Size = ScaleSequence(v29.Size, v28.SizeScalar)
        else
            v29.Size = v29.Size
        end
        v24[#v24 + 1] = v29
        local v30 = v29.Lifetime.Max / v29.TimeScale
        v26 = math.max(v26, v30)
        local v31 = math.random() * 2 - 1
        v29.ZOffset += v31 * v3.depthJitter
        v29.Rate = RateForDistance(v29.Rate * v18.rate / v25, Part.Position)
        local Speed = v29.Speed
        v29.Speed = v17.SpeedOverride or NumberRange.new(Speed.Min * v18.speed, Speed.Max * v18.speed)
        if v18.size ~= 1 then
            v23(v29, v18.size)
        end
        v29.Drag = v17.DragOverride or v29.Drag
        v29.Enabled = false
        v29.Parent = Part
    end
    Part.Parent = workspace.CurrentCamera
    local v32 = 0
    local v33 = false
    local SprinkleSounds = v17.SprinkleSounds
    if v18.isManual then
        for v34, v35 in v24 do
            local drag = v18.drag
            local v36 = v35:Clone()
            v36.EmissionDirection = Enum.NormalId.Bottom
            v36.Speed = v3.fallSpeed
            v36.Drag = drag
            v36.Parent = Part
            local v37 = math.random() * v3.manualJitter
            local delay = task.delay
            delay(v37, function() -- line 164 | captures: v18, v36
                v36:Emit(v18.manualEmit)
            end)
        end
    elseif v18.isPopUp then
        v32 = v3.popUpDelay
        SprinkleSounds = v17.PopSounds
        for v38, v39 in v24 do
            local v40 = (v39:GetAttribute(v3.emitCountAttribute) or 0) * v18.rate
            local v41 = math.round(v40)
            if v41 > 0 then
                local drag = v18.drag
                local v42 = v39:Clone()
                v42.EmissionDirection = Enum.NormalId.Bottom
                v42.Speed = v3.fallSpeed
                v42.Drag = drag
                v42.Parent = Part
                v42:Emit(v41)
            end
        end
    else
        v33 = true
        for v43, v44 in v24 do
            v44.Enabled = true
        end
    end
    if SprinkleSounds ~= nil and v18.volume > 0 then
        Audio.Play(SprinkleSounds.Assets, workspace.CurrentCamera, {
            PlaybackSpeed = SprinkleSounds.Pitch,
            Volume = SprinkleSounds.Volume
        })
    end

    local function v45(v46, v47) -- line 201 | captures: v32, v33, v17, v18, Part, v24, ScreenSpaceVolume, Audio, v1
        local v48, v49 = ScreenSpaceVolume(v1.studsAhead, v1.studsTall)
        Part.CFrame = v48
        Part.Size = v49
        local v50 = not v18.isManual
        if v50 then
            if v32 <= v47 then
                v50 = v47 < v32 + v18.seconds
            else
                v50 = false
            end
        end
        if v33 == v50 then
            return
        end
        v33 = v50
        local v51 = if v50 then v17.SprinkleSounds else nil
        if v51 ~= nil and v18.volume > 0 then
            Audio.Play(v51.Assets, workspace.CurrentCamera, {
                PlaybackSpeed = v51.Pitch,
                Volume = v51.Volume
            })
        end
        for v52, v53 in v24 do
            v53.Enabled = v50
        end
    end

    local seconds = v18.seconds
    OnRender(v45, v32 + seconds + v26):OnComplete(function() -- line 229 | captures: Part
        Part:Destroy()
    end)
end

return v4
