-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local t = require(ReplicatedStorage.Packages.t)
local Player = require(ReplicatedStorage.Shared.Player)
local WaitFor = require(ReplicatedStorage.Packages.WaitFor)
local v1 = {}

v1.__index = v1
v1.__class = "GuardWakeLookAt"

local v2 = {
    Jungle = {
        AuthoredPitchAxis = Vector3.new(-0, -0, -1),
        BasePitch = 0.7853981633974483,
        MaxPitch = 1.3962634015954636,
        MinPitch = 0.17453292519943295,
        TargetPitchScale = -1
    }
}

function v1.new(v3) -- line 24 | captures: t, WaitFor, v1, v2
    t.strict(t.instanceIsA("Model"))(v3)
    local v4 = {}
    local v5 = setmetatable(v4, v1)
    local v6, v7 = WaitFor.Descendant(v3, "Head"):await()
    local HumanoidRootPart = v3:WaitForChild("HumanoidRootPart")
    local Parent = v3.Parent
    local v8 = v6 and v7 ~= nil
    local v9 = ("%* requires a Head descendant for wake look-at"):format((v3:GetFullName()))
    assert(v8, v9)
    local BasePart = v7:IsA("BasePart")
    local v10 = ("%* must be a BasePart"):format((v7:GetFullName()))
    assert(BasePart, v10)
    local BasePart_2 = HumanoidRootPart:IsA("BasePart")
    local v11 = ("%* must be a BasePart"):format((HumanoidRootPart:GetFullName()))
    assert(BasePart_2, v11)
    local v12
    if Parent == nil then
        v12 = false
    else
        v12 = Parent:IsA("Model")
    end
    local v13 = ("%* requires an area Model parent"):format((v3:GetFullName()))
    assert(v12, v13)
    local HeadLookAtBoneName = v3:GetAttribute("HeadLookAtBoneName")
    local v14, v15
    if HeadLookAtBoneName == nil then
        local HeadLookAtMotorName = v3:GetAttribute("HeadLookAtMotorName")
        t.strict(t.optional(t.string))(HeadLookAtMotorName)
        local v16 = HeadLookAtMotorName or "Head"
        local v17
        v17, v14 = WaitFor.Custom(function() -- line 51 | captures: v3, v16
            for v18, v19 in ipairs(v3:GetDescendants()) do
                if v19:IsA("Motor6D") and v19.Name == v16 then
                    return v19
                end
            end
            return nil
        end):await()
        local v20 = v17 and v14 ~= nil
        local v21 = ("%* requires Motor6D \"%*\" for wake look-at"):format(v3:GetFullName(), v16)
        assert(v20, v21)
        local Motor6D = v14:IsA("Motor6D")
        local v22 = ("%* must be a Motor6D"):format((v14:GetFullName()))
        assert(Motor6D, v22)
    else
        t.strict(t.string)(HeadLookAtBoneName)
        local v23
        v23, v15 = WaitFor.Custom(function() -- line 71 | captures: v3, HeadLookAtBoneName
            for v24, v25 in ipairs(v3:GetDescendants()) do
                if v25:IsA("Bone") and v25.Name == HeadLookAtBoneName then
                    return v25
                end
            end
            return nil
        end):await()
        local v26 = v23 and v15 ~= nil
        local v27 = ("%* requires Bone \"%*\" for HeadLookAtBoneName"):format(v3:GetFullName(), HeadLookAtBoneName)
        assert(v26, v27)
        local Bone = v15:IsA("Bone")
        local v28 = ("%* must be a Bone"):format((v15:GetFullName()))
        assert(Bone, v28)
    end
    local v29
    if v15 == nil then
        local v30 = v14 ~= nil
        local v31 = ("%* wake look-at requires a Motor6D or Bone"):format((v3:GetFullName()))
        assert(v30, v31)
        local Part0 = v14.Part0
        local v32 = Part0 ~= nil
        local v33 = ("%* requires Part0 for wake look-at"):format((v14:GetFullName()))
        assert(v32, v33)
        v29 = Part0.CFrame * v14.C0
    else
        v29 = v15.WorldCFrame
    end
    local v34 = v2[Parent.Name]
    local v35 = v29.Rotation:ToObjectSpace(HumanoidRootPart.CFrame.Rotation)
    if v34 ~= nil then
        local v36 = v15 ~= nil
        local v37 = ("%* area look override requires a Bone"):format((v3:GetFullName()))
        assert(v36, v37)
    end
    v5._areaLookOverride = v34
    v5._appliedOffset = CFrame.identity
    v5._bone = v15
    v5._currentOffset = CFrame.identity
    v5._guardModel = v3
    v5._isWaking = false
    v5._jointToFacingRotation = v35
    v5._motor = v14
    v5._preAnimationConnection = nil
    v5._preSimulationConnection = nil
    v5._root = HumanoidRootPart
    v5._targetPitchReference = nil
    v5._targetUserId = nil
    return v5
end

local function _getJointTransform(v38) -- line 120
    local _bone = v38._bone
    if _bone == nil then
        local _motor = v38._motor
        local v39 = _motor ~= nil
        local v40 = ("%* wake look-at requires a Motor6D or Bone"):format((v38._guardModel:GetFullName()))
        assert(v39, v40)
        return _motor.Transform
    end
    return _bone.Transform
end

v1._getJointTransform = _getJointTransform

local function _setJointTransform(v41, v42) -- line 130
    local _bone = v41._bone
    if _bone == nil then
        local _motor = v41._motor
        local v43 = _motor ~= nil
        local v44 = ("%* wake look-at requires a Motor6D or Bone"):format((v41._guardModel:GetFullName()))
        assert(v43, v44)
        _motor.Transform = v42
    else
        _bone.Transform = v42
    end
end

v1._setJointTransform = _setJointTransform

local function _getAnimationJointWorldCFrame(v45) -- line 141
    local _bone = v45._bone
    if _bone == nil then
        local _motor = v45._motor
        local v46 = _motor ~= nil
        local v47 = ("%* wake look-at requires a Motor6D or Bone"):format((v45._guardModel:GetFullName()))
        assert(v46, v47)
        local Part0 = _motor.Part0
        local v48 = Part0 ~= nil
        local v49 = ("%* requires Part0 for wake look-at"):format((_motor:GetFullName()))
        assert(v48, v49)
        local v50 = _motor.Transform * v45._appliedOffset:Inverse()
        return Part0.CFrame * _motor.C0 * v50
    end
    return _bone.TransformedWorldCFrame * v45._appliedOffset:Inverse()
end

v1._getAnimationJointWorldCFrame = _getAnimationJointWorldCFrame

local function _getAnimationJointTransform(v51) -- line 155
    return v51:_getJointTransform() * v51._appliedOffset:Inverse()
end

v1._getAnimationJointTransform = _getAnimationJointTransform

function v1._getTargetOffset(v52) -- line 159 | captures: Players, Player
    if v52._isWaking then
        local v53 = Player.Optional.HumanoidRootPart(Players.LocalPlayer)
        if v53 == nil or (v53.Position - v52._root.Position).Magnitude > 400 then
            return CFrame.identity
        end
        local _targetUserId = v52._targetUserId
        if _targetUserId == nil then
            return CFrame.identity
        end
        local v54 = tonumber(_targetUserId)
        local v55 = v54 ~= nil
        local v56 = ("%*.WakeTargetPlayer must be a user id"):format((v52._guardModel:GetFullName()))
        assert(v55, v56)
        local v57 = Players:GetPlayerByUserId(v54)
        if v57 == nil then
            return CFrame.identity
        end
        local v58 = Player.Optional.Head(v57)
        if v58 == nil then
            return CFrame.identity
        end
        local v59 = v52:_getAnimationJointWorldCFrame()
        local v60 = CFrame.new(v59.Position) * v52._root.CFrame.Rotation
        local v61 = v58.Position - v60.Position
        if v61.Magnitude <= 0.001 then
            return CFrame.identity
        end
        local v62 = v60:VectorToObjectSpace(v61.Unit)
        local Y = v62.Y
        local v63 = math.asin(Y)
        local X = v62.X
        local v64 = -v62.Z
        local v65 = -math.atan2(X, v64)
        local v66 = math.clamp(v65, -1.0471975511965976, 1.0471975511965976)
        local _areaLookOverride = v52._areaLookOverride
        if _areaLookOverride == nil then
            local v67 = math.clamp(v63, -0.6108652381980153, 0.6108652381980153)
            local v68 = (v60 * CFrame.Angles(v67, v66, 0)).Rotation * v52._jointToFacingRotation:Inverse()
            return v59.Rotation:ToObjectSpace(v68)
        end
        local _targetPitchReference = v52._targetPitchReference
        if _targetPitchReference == nil then
            v52._targetPitchReference = v63
            _targetPitchReference = v63
        end
        local v69 = v52:_getAnimationJointTransform()
        local v70 = v59.Rotation * v69.Rotation:Inverse()
        local v71 = _areaLookOverride.BasePitch + (v63 - _targetPitchReference) * _areaLookOverride.TargetPitchScale
        local MinPitch = _areaLookOverride.MinPitch
        local MaxPitch = _areaLookOverride.MaxPitch
        local v72 = math.clamp(v71, MinPitch, MaxPitch)
        local v73 = CFrame.fromAxisAngle(_areaLookOverride.AuthoredPitchAxis, v72)
        local v74 = CFrame.fromAxisAngle(v52._root.CFrame.UpVector, v66) * v70 * v73
        return v59.Rotation:ToObjectSpace(v74 * v69.Rotation)
    end
    return CFrame.identity
end

local function _applyOffset(v75, v76) -- line 219
    v75:_setJointTransform(v75:_getJointTransform() * v76)
    v75._appliedOffset = v76
end

v1._applyOffset = _applyOffset

local function _restoreAppliedOffset(v77) -- line 223
    v77:_setJointTransform(v77:_getJointTransform() * v77._appliedOffset:Inverse())
    v77._appliedOffset = CFrame.identity
end

v1._restoreAppliedOffset = _restoreAppliedOffset

local function _isOffsetAtRest(v78) -- line 228
    local v79, v80, v81 = v78._currentOffset:ToOrientation()
    local v82 = math.abs(v79)
    local v83 = math.abs(v80)
    local v84 = math.abs(v81)
    return math.max(v82, v83, v84) <= 0.001
end

v1._isOffsetAtRest = _isOffsetAtRest

local function _step(v85, v86) -- line 237
    local v87 = v85:_getTargetOffset()
    local v88 = v86 * -3.5
    local v89 = 1 - math.exp(v88)
    v85._currentOffset = v85._currentOffset:Lerp(v87, v89)
    v85:_applyOffset(v85._currentOffset)
    if v85._isWaking or not v85:_isOffsetAtRest() then
        return false
    end
    v85._currentOffset = CFrame.identity
    v85:_restoreAppliedOffset()
    return true
end

v1._step = _step

function v1._ensureAnimation(v90) -- line 249 | captures: RunService
    if v90._preSimulationConnection ~= nil then
        return
    end
    local v91 = v90._preAnimationConnection == nil
    assert(v91, "wake look-at frame connections must share a lifecycle")
    local PreAnimation = RunService.PreAnimation
    v90._preAnimationConnection = PreAnimation:Connect(function() -- line 255 | captures: v90
        v90:_restoreAppliedOffset()
    end)
    local PreSimulation = RunService.PreSimulation
    v90._preSimulationConnection = PreSimulation:Connect(function(v92) -- line 258 | captures: v90
        if v90:_step(v92) then
            v90:_disconnectAnimation()
        end
    end)
end

local function _disconnectAnimation(v93) -- line 264
    local _preAnimationConnection = v93._preAnimationConnection
    if _preAnimationConnection ~= nil then
        v93._preAnimationConnection = nil
        _preAnimationConnection:Disconnect()
    end
    local _preSimulationConnection = v93._preSimulationConnection
    if _preSimulationConnection ~= nil then
        v93._preSimulationConnection = nil
        _preSimulationConnection:Disconnect()
    end
end

v1._disconnectAnimation = _disconnectAnimation

function v1.SetWaking(v94, v95, v96) -- line 276 | captures: t
    t.strict(t.boolean)(v95)
    t.strict(t.optional(t.string))(v96)
    if v95 then
        if v94._isWaking and v96 == v94._targetUserId then
        end
    else
        v94._targetPitchReference = nil
    end
    v94._isWaking = v95
    v94._targetUserId = v96
    if v95 or not v94:_isOffsetAtRest() then
        v94:_ensureAnimation()
    end
end

local function Destroy(v97) -- line 293
    v97._isWaking = false
    v97._targetPitchReference = nil
    v97._targetUserId = nil
    v97._currentOffset = CFrame.identity
    v97:_restoreAppliedOffset()
    v97:_disconnectAnimation()
end

v1.Destroy = Destroy
return v1
