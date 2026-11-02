-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
game:GetService("ReplicatedStorage")
local Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
local v1 = require(Packages:WaitForChild("t"))
local CameraShakeInstance = require(script.CameraShakeInstance)
local CameraShakePresets = require(script.CameraShakePresets)
local profilebegin = debug.profilebegin
local profileend = debug.profileend
local v2 = 0
local new = CFrame.new
local Angles = CFrame.Angles
local rad = math.rad
local v3 = Vector3.new()
local CameraShakeState = CameraShakeInstance.CameraShakeState
local Value = Enum.RenderPriority.Last.Value
local CurrentCamera = workspace.CurrentCamera
local v4 = {}

v4.__index = v4
v4.CameraShakeInstance = CameraShakeInstance
v4.Presets = CameraShakePresets

local function defaultCallback(v5) -- line 27 | captures: CurrentCamera
    CurrentCamera.CFrame *= v5
end

function v4.new(v6, v7, v8) -- line 31 | captures: v1, v3, Value, v4, defaultCallback
    v1.strict(v1.optional(v1.number))(v6)
    v1.strict(v1.optional(v1.callback))(v7)
    local v9 = {
        _running = false,
        _renderName = v4.NextRenderName()
    }
    v9._renderPriority = v6 or Value
    v9._posAddShake = v3
    v9._rotAddShake = v3
    v9._camShakeInstances = {}
    v9._removeInstances = {}
    v9._callback = v7 or defaultCallback
    v9._optimizeDrift = v8 or false
    v9._renderBindings = {}
    v9._renderDriftConnections = {}
    return (setmetatable(v9, v4))
end

function v4.NextRenderName() -- line 56 | captures: v2
    v2 += 1
    return ("__shake_%.4i__"):format(v2)
end

function v4.Start(v10, v11) -- line 60 | captures: RunService, v1, profilebegin, profileend, CurrentCamera
    if v10._running then
        return
    end
    v1.strict(v1.optional(v1.string))(v11)
    v10._running = true
    local v12 = v11 or v10._renderName
    local _callback = v10._callback
    local CFrame
    local _renderPriority = v10._renderPriority
    RunService:BindToRenderStep(v12, _renderPriority, function(v13) -- line 74 | captures: CFrame, v10, _callback, profilebegin, profileend, CurrentCamera
        CFrame = CurrentCamera.CFrame
        profilebegin("CameraShakerUpdate")
        local v14 = v10:Update(v13)
        profileend()
        _callback(v14)
    end)
    v10._renderBindings[v12] = true
    if v10._optimizeDrift then
        v10._renderDriftConnections[v12] = RunService.Heartbeat:Connect(function() -- line 86 | captures: CFrame, CurrentCamera
            if CFrame then
                CurrentCamera.CFrame = CFrame
            end
        end)
    end
end

function v4.StopByRenderName(v15, v16) -- line 93 | captures: RunService, v1
    v1.strict(v1.string)(v16)
    local v17 = v15._renderBindings[v16]
    local v18 = ("Attempt to remove an unBinded render name: \"%*\""):format(v16)
    assert(v17, v18)
    local v19 = v15._renderDriftConnections[v16]
    if v19 then
        v19:Disconnect()
        v15._renderDriftConnections[v16] = nil
    end
    v15._renderBindings[v16] = nil
    RunService:UnbindFromRenderStep(v16)
end

local function Stop(v20) -- line 105
    if v20._running then
        v20._running = false
        for v21 in v20._renderBindings do
            v20:StopByRenderName(v21)
        end
    end
end

v4.Stop = Stop

local function StopSustained(v22, v23) -- line 117
    for v24, v25 in pairs(v22._camShakeInstances) do
        if v25.fadeOutDuration == 0 then
            v25:StartFadeOut(v23 or v25.fadeInDuration)
        end
    end
end

v4.StopSustained = StopSustained

function v4.Update(v26, v27) -- line 130 | captures: new, Angles, rad, v3, CameraShakeState
    local v28 = v3
    local v29 = v3
    local _camShakeInstances = v26._camShakeInstances
    local v30 = #_camShakeInstances
    for v31 = 1, v30 do
        local v32 = _camShakeInstances[v31]
        local v33 = v32:GetState()
        if v33 == CameraShakeState.Inactive then
            if v32.DeleteOnInactive then
                v26._removeInstances[#v26._removeInstances + 1] = v31
            end
        elseif v33 ~= CameraShakeState.Inactive then
            local v34 = v32:UpdateShake(v27)
            v28, v29 = v28 + v34 * v32.PositionInfluence, v29 + v34 * v32.RotationInfluence
        end
    end
    local v35 = #v26._removeInstances
    for v36 = v35, 1, -1 do
        table.remove(_camShakeInstances, v26._removeInstances[v36])
        v26._removeInstances[v36] = nil
    end
    local v37 = new(v28)
    local Y = v29.Y
    local v38 = rad(Y)
    local v39 = v37 * Angles(0, v38, 0)
    local X = v29.X
    local v40 = rad(X)
    local Z = v29.Z
    return v39 * Angles(v40, 0, (rad(Z)))
end

local function Shake(v41, v42) -- line 163
    local v43 = if type(v42) == "table" then v42._camShakeInstance else false
    assert(v43, "ShakeInstance must be of type CameraShakeInstance")
    v41._camShakeInstances[#v41._camShakeInstances + 1] = v42
    return v42
end

v4.Shake = Shake

function v4.ShakeFromPresetName(v44, v45) -- line 170 | captures: v1, CameraShakePresets
    v1.strict(v1.string)(v45)
    return v44:Shake(CameraShakePresets[v45])
end

local function ShakeSustain(v46, v47) -- line 175
    local v48 = if type(v47) == "table" then v47._camShakeInstance else false
    assert(v48, "ShakeInstance must be of type CameraShakeInstance")
    v46._camShakeInstances[#v46._camShakeInstances + 1] = v47
    v47:StartFadeIn(v47.fadeInDuration)
    return v47
end

v4.ShakeSustain = ShakeSustain

function v4.ShakeOnce(v49, v50, v51, v52, v53, v54, v55) -- line 183 | captures: CameraShakeInstance
    local v56 = CameraShakeInstance.new(v50, v51, v52, v53)
    if typeof(v54) == "Vector3" then
        v56.PositionInfluence = v54
    else
        v56.PositionInfluence = Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448)
    end
    v56.RotationInfluence = typeof(v55) == "Vector3" and v55 or Vector3.new(1, 1, 1)
    v49._camShakeInstances[#v49._camShakeInstances + 1] = v56
    return v56
end

function v4.StartShake(v57, v58, v59, v60, v61, v62) -- line 204 | captures: CameraShakeInstance
    local v63 = CameraShakeInstance.new(v58, v59, v60)
    if typeof(v61) == "Vector3" then
        v63.PositionInfluence = v61
    else
        v63.PositionInfluence = Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448)
    end
    v63.RotationInfluence = typeof(v62) == "Vector3" and v62 or Vector3.new(1, 1, 1)
    v63:StartFadeIn(v60)
    v57._camShakeInstances[#v57._camShakeInstances + 1] = v63
    return v63
end

return v4
