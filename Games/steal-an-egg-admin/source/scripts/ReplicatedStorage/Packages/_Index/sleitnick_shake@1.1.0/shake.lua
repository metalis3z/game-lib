-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
game:GetService("ReplicatedStorage")
local v1 = Random.new()
local v2 = 0
local v3 = {}

v3.__index = v3

function v3.new() -- line 12 | captures: RunService, v1, v3
    local v4 = {}
    local v5 = setmetatable(v4, v3)
    v5.Amplitude = 1
    v5.Frequency = 1
    v5.FadeInTime = 1
    v5.FadeOutTime = 1
    v5.SustainTime = 0
    v5.Sustain = false
    v5.PositionInfluence = Vector3.new(1, 1, 1)
    v5.RotationInfluence = Vector3.new(1, 1, 1)
    if RunService:IsRunning() then
        v5.TimeFunction = time
    else
        v5.TimeFunction = os.clock
    end
    v5._timeOffset = v1:NextNumber(-1000000, 1000000)
    v5._startTime = 0
    v5._running = false
    v5._signalConnections = {}
    v5._renderBindings = {}
    return v5
end

local function InverseSquare(v6, v7) -- line 36
    local v8 = if v7 >= 1 then v7 else 1
    return v6 * (1 / (v8 * v8))
end

v3.InverseSquare = InverseSquare

function v3.NextRenderName() -- line 45 | captures: v2
    v2 += 1
    return ("__shake_%.4i__"):format(v2)
end

local function Start(v9) -- line 49
    v9._startTime = v9.TimeFunction()
    v9._running = true
end

v3.Start = Start

function v3.Stop(v10) -- line 53 | captures: RunService
    v10._running = false
    for v11, v12 in v10._renderBindings do
        RunService:UnbindFromRenderStep(v12)
    end
    table.clear(v10._renderBindings)
    for v13, v14 in v10._signalConnections do
        v14:Disconnect()
    end
    table.clear(v10._signalConnections)
end

local function IsShaking(v15) -- line 70
    return v15._running
end

v3.IsShaking = IsShaking

local function StopSustain(v16) -- line 73
    v16.Sustain = false
    v16.SustainTime = v16.TimeFunction() - v16._startTime - v16.FadeInTime
end

v3.StopSustain = StopSustain

local function Update(v17) -- line 78
    local v18 = v17.TimeFunction()
    local v19 = v18 - v17._startTime
    local v20 = (v18 + v17._timeOffset) / v17.Frequency % 10000
    local v21 = if v19 < v17.FadeInTime then v19 / v17.FadeInTime else 1
    local v22, v23
    if v17.Sustain then
        v23 = false
        v22 = 1
    elseif v17.FadeInTime + v17.SustainTime < v19 then
        if v17.FadeOutTime == 0 then
            v23 = true
            v22 = 1
        else
            v22 = 1 - (v19 - v17.FadeInTime - v17.SustainTime) / v17.FadeOutTime
            if v17.Sustain then
                v23 = false
            else
                v23 = v17.FadeInTime + v17.SustainTime + v17.FadeOutTime <= v19
            end
        end
    else
        v23 = false
        v22 = 1
    end
    local v24 = math.noise(v20, 0) / 2
    local v25 = math.noise(0, v20) / 2
    local v26 = math.noise(v20, v20) / 2
    local v27 = Vector3.new(v24, v25, v26) * v17.Amplitude * math.min(v21, v22)
    if v23 then
        v17:Stop()
    end
    return v17.PositionInfluence * v27, v17.RotationInfluence * v27, v23
end

v3.Update = Update

local function OnSignal(v28, v29, v30) -- line 111
    local v31 = v29:Connect(function() -- line 112 | captures: v28, v30
        v30(v28:Update())
    end)
    local _signalConnections = v28._signalConnections
    table.insert(_signalConnections, v31)
    return v31
end

v3.OnSignal = OnSignal

function v3.BindToRenderStep(v32, v33, v34, v35) -- line 118 | captures: RunService
    RunService:BindToRenderStep(v33, v34, function() -- line 119 | captures: v32, v35
        v35(v32:Update())
    end)
    local _renderBindings = v32._renderBindings
    table.insert(_renderBindings, v33)
end

function v3.Clone(v36) -- line 124 | captures: v3
    local v37 = v3.new()
    for v38, v39 in {
            "Amplitude",
            "Frequency",
            "FadeInTime",
            "FadeOutTime",
            "SustainTime",
            "Sustain",
            "PositionInfluence",
            "RotationInfluence",
            "TimeFunction"
        } do
        v37[v39] = v36[v39]
    end
    return v37
end

local function Destroy(v40) -- line 144
    v40:Stop()
end

v3.Destroy = Destroy

return {
    new = v3.new,
    InverseSquare = v3.InverseSquare,
    NextRenderName = v3.NextRenderName
}
