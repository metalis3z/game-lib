-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Shake = require(ReplicatedStorage.Packages.Shake)
local v1 = {}
local v2 = {
    "Bump",
    2.5,
    0.25,
    0.1,
    0.75,
    Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448),
    (Vector3.new(1, 1, 1))
}
local v3 = {
    "BumpS",
    1.5,
    0.25,
    0.1,
    0.75,
    Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448),
    (Vector3.new(1, 1, 1))
}
local v4 = {
    "Explosion",
    5,
    0.1,
    0,
    1.5,
    Vector3.new(0.25, 0.25, 0.25),
    (Vector3.new(4, 1, 1))
}
local v5 = {
    "Earthquake",
    0.6,
    0.2857142857142857,
    2,
    10,
    Vector3.new(0.25, 0.25, 0.25),
    (Vector3.new(1, 1, 4))
}
local v6 = {
    "BadTrip",
    10,
    6.666666666666667,
    5,
    10,
    Vector3.new(0, 0, 0.15000000596046448),
    (Vector3.new(2, 1, 4))
}
local v7 = {
    "HandheldCamera",
    1,
    0.25,
    5,
    10,
    Vector3.new(0, 0, 0),
    (Vector3.new(1, 0.5, 0.5))
}
local v8 = {
    "Vibration",
    0.4,
    0.05,
    2,
    2,
    Vector3.new(0, 0.15000000596046448, 0),
    (Vector3.new(1.25, 0, 4))
}
local v9 = {
    "RoughDriving",
    1,
    0.5,
    1,
    1,
    Vector3.new(0, 0, 0),
    (Vector3.new(1, 1, 1))
}

v1[1] = v2
v1[2] = v3
v1[3] = v4
v1[4] = v5
v1[5] = v6
v1[6] = v7
v1[7] = v8
v1[8] = v9

local v10 = {}
for v11, v12 in v1 do
    local v13 = Shake.new()
    v13.Amplitude = v12[2]
    v13.Frequency = v12[3]
    v13.FadeInTime = v12[4]
    v13.FadeOutTime = v12[5]
    v13.PositionInfluence = v12[6]
    v13.RotationInfluence = v12[7]
    v10[v12[1]] = v13
end

function v10.DriveCamera(v14, v15) -- line 104 | captures: RunService, Shake
    local v16 = v15
    local CurrentCamera
    if v15 then
        CurrentCamera = v15
    else
        CurrentCamera = workspace.CurrentCamera
        v16 = CurrentCamera
    end
    assert(CurrentCamera, "no camera to attach a shake to")
    local CFrame_2, v17
    local v18 = true
    v14:BindToRenderStep(Shake.NextRenderName(), Enum.RenderPriority.Last.Value, function(v19, v20, v21) -- line 113 | captures: v16, CFrame_2, v17, v18
        CFrame_2 = v16.CFrame
        local v22 = CFrame.new(v19)
        local Y = v20.Y
        local v23 = math.rad(Y)
        local v24 = v22 * CFrame.Angles(0, v23, 0)
        local X = v20.X
        local v25 = math.rad(X)
        local v26 = v16
        local CFrame_3 = v16.CFrame
        local Angles = CFrame.Angles
        local Z = v20.Z
        v26.CFrame = CFrame_3 * (v24 * Angles(v25, 0, (math.rad(Z))))
        if v21 then
            v18 = false
            if v17 then
                v17:Disconnect()
                v17 = nil
            end
        end
    end)
    if v18 then
        v17 = RunService.PostSimulation:Connect(function() -- line 129 | captures: v16, CFrame_2
            if CFrame_2 then
                v16.CFrame = CFrame_2
            end
        end)
    end
    return function() -- line 135 | captures: v17, v14
        if v17 then
            v17:Disconnect()
            v17 = nil
        end
        v14:Destroy()
    end
end

return v10
