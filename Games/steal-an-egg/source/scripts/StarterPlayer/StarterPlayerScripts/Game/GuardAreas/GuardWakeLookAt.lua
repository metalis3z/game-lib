-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Player = require(ReplicatedStorage.Library.Player)
local WaitFor = require(ReplicatedStorage.Library.Modules.Packages.WaitFor)
local t = {}

t.__index = t
t.__class = "GuardWakeLookAt"

local t2 = {
	Jungle = {
		AuthoredPitchAxis = Vector3.new(-0, -0, -1),
		BasePitch = 0.7853981633974483,
		MaxPitch = 1.3962634015954636,
		MinPitch = 0.17453292519943295,
		TargetPitchScale = -1
	}
}

function t.new(p1) --[[ new | Line: 79 | Upvalues: Asserts (copy), t (copy), WaitFor (copy), t2 (copy) ]]
	Asserts.Model(p1)

	local v2 = setmetatable({}, t)
	local v3, v4 = WaitFor.Descendant(p1, "Head"):await()
	local HumanoidRootPart = p1:WaitForChild("HumanoidRootPart")
	local v5 = p1.Parent

	assert(if v3 then if v4 == nil then false else true else v3, (("%* requires a Head descendant for wake look-at"):format((p1:GetFullName()))))
	assert(v4:IsA("BasePart"), (("%* must be a BasePart"):format((v4:GetFullName()))))
	assert(HumanoidRootPart:IsA("BasePart"), (("%* must be a BasePart"):format((HumanoidRootPart:GetFullName()))))
	assert(if v5 == nil then false else v5:IsA("Model"), (("%* requires an area Model parent"):format((p1:GetFullName()))))

	local v14 = p1:GetAttribute("HeadLookAtBoneName")
	local v15 = nil
	local v16 = nil

	if v14 == nil then
		local v17 = p1:GetAttribute("HeadLookAtMotorName")

		Asserts.optional.string(v17)

		local v18 = v17 or "Head"
		local v19, v20 = WaitFor.Custom(function() --[[ Line: 114 | Upvalues: p1 (copy), v18 (copy) ]]
			for i, v in ipairs(p1:GetDescendants()) do
				if v:IsA("Motor6D") and v.Name == v18 then
					return v
				end
			end

			return nil
		end):await()

		assert(if v19 then if v20 == nil then false else true else v19, (("%* requires Motor6D \"%*\" for wake look-at"):format(p1:GetFullName(), v18)))
		assert(v20:IsA("Motor6D"), (("%* must be a Motor6D"):format((v20:GetFullName()))))
		v16 = v20
	else
		Asserts.string(v14)

		local v25, v26 = WaitFor.Custom(function() --[[ Line: 96 | Upvalues: p1 (copy), v14 (copy) ]]
			for i, v in ipairs(p1:GetDescendants()) do
				if v:IsA("Bone") and v.Name == v14 then
					return v
				end
			end

			return nil
		end):await()

		assert(if v25 then if v26 == nil then false else true else v25, (("%* requires Bone \"%*\" for HeadLookAtBoneName"):format(p1:GetFullName(), v14)))
		assert(v26:IsA("Bone"), (("%* must be a Bone"):format((v26:GetFullName()))))
		v15 = v26
	end

	local v31

	if v15 == nil then
		assert(if v16 == nil then false else true, (("%* wake look-at requires a Motor6D or Bone"):format((p1:GetFullName()))))

		local Part0 = v16.Part0

		assert(if Part0 == nil then false else true, (("%* requires Part0 for wake look-at"):format((v16:GetFullName()))))
		v31 = Part0.CFrame * v16.C0
	else
		v31 = v15.WorldCFrame
	end

	local v36 = t2[v5.Name]
	local v37 = v31.Rotation:ToObjectSpace(HumanoidRootPart.CFrame.Rotation)

	if v36 ~= nil then
		assert(v15 ~= nil, (("%* area look override requires a Bone"):format((p1:GetFullName()))))
	end

	v2._areaLookOverride = v36
	v2._appliedOffset = CFrame.identity
	v2._bone = v15
	v2._currentOffset = CFrame.identity
	v2._guardModel = p1
	v2._isWaking = false
	v2._jointToFacingRotation = v37
	v2._motor = v16
	v2._preAnimationConnection = nil
	v2._preSimulationConnection = nil
	v2._root = HumanoidRootPart
	v2._targetPitchReference = nil
	v2._targetUserId = nil

	return v2
end
function t._getJointTransform(p1) --[[ _getJointTransform | Line: 165 ]]
	local _bone = p1._bone

	if _bone ~= nil then
		return _bone.Transform
	end

	local _motor = p1._motor

	assert(_motor ~= nil, (("%* wake look-at requires a Motor6D or Bone"):format((p1._guardModel:GetFullName()))))

	return _motor.Transform
end
function t._setJointTransform(p1, p2) --[[ _setJointTransform | Line: 176 ]]
	local _bone = p1._bone

	if _bone ~= nil then
		_bone.Transform = p2

		return
	end

	local _motor = p1._motor

	assert(if _motor == nil then false else true, (("%* wake look-at requires a Motor6D or Bone"):format((p1._guardModel:GetFullName()))))
	_motor.Transform = p2
end
function t._getAnimationJointWorldCFrame(p1) --[[ _getAnimationJointWorldCFrame | Line: 188 ]]
	local _bone = p1._bone

	if _bone ~= nil then
		return _bone.TransformedWorldCFrame * p1._appliedOffset:Inverse()
	end

	local _motor = p1._motor

	assert(_motor ~= nil, (("%* wake look-at requires a Motor6D or Bone"):format((p1._guardModel:GetFullName()))))

	local Part0 = _motor.Part0

	assert(Part0 ~= nil, (("%* requires Part0 for wake look-at"):format((_motor:GetFullName()))))

	return Part0.CFrame * _motor.C0 * (_motor.Transform * p1._appliedOffset:Inverse())
end
function t._getAnimationJointTransform(p1) --[[ _getAnimationJointTransform | Line: 202 ]]
	return p1:_getJointTransform() * p1._appliedOffset:Inverse()
end
function t._getTargetOffset(p1) --[[ _getTargetOffset | Line: 206 | Upvalues: Player (copy), Players (copy) ]]
	if not p1._isWaking then
		return CFrame.identity
	end

	local v1 = Player.Optional.HumanoidRootPart(Players.LocalPlayer)

	if v1 == nil or (v1.Position - p1._root.Position).Magnitude > 400 then
		return CFrame.identity
	end

	local _targetUserId = p1._targetUserId

	if _targetUserId == nil then
		return CFrame.identity
	end

	local v2 = tonumber(_targetUserId)

	assert(v2 ~= nil, (("%*.WakeTargetPlayer must be a user id"):format((p1._guardModel:GetFullName()))))

	local v5 = Players:GetPlayerByUserId(v2)

	if v5 == nil then
		return CFrame.identity
	end

	local v6 = Player.Optional.Head(v5)

	if v6 == nil then
		return CFrame.identity
	end

	local v7 = p1:_getAnimationJointWorldCFrame()
	local v8 = CFrame.new(v7.Position) * p1._root.CFrame.Rotation
	local v9 = v6.Position - v8.Position

	if v9.Magnitude <= 0.001 then
		return CFrame.identity
	end

	local v10 = v8:VectorToObjectSpace(v9.Unit)
	local v11 = math.asin(v10.Y)
	local v14 = math.clamp(-math.atan2(v10.X, -v10.Z), -1.0471975511965976, 1.0471975511965976)
	local _areaLookOverride = p1._areaLookOverride

	if _areaLookOverride == nil then
		local v15 = math.clamp(v11, -0.6108652381980153, 0.6108652381980153)

		return v7.Rotation:ToObjectSpace((v8 * CFrame.Angles(v15, v14, 0)).Rotation * p1._jointToFacingRotation:Inverse())
	end

	local _targetPitchReference = p1._targetPitchReference
	local v17

	if _targetPitchReference == nil then
		p1._targetPitchReference = v11
		v17 = v11
	else
		v17 = _targetPitchReference
	end

	local v18 = p1:_getAnimationJointTransform()
	local v19 = v7.Rotation * v18.Rotation:Inverse()
	local v22 = CFrame.fromAxisAngle(_areaLookOverride.AuthoredPitchAxis, (math.clamp(_areaLookOverride.BasePitch + (v11 - v17) * _areaLookOverride.TargetPitchScale, _areaLookOverride.MinPitch, _areaLookOverride.MaxPitch)))

	return v7.Rotation:ToObjectSpace(CFrame.fromAxisAngle(p1._root.CFrame.UpVector, v14) * v19 * v22 * v18.Rotation)
end
function t._applyOffset(p1, p2) --[[ _applyOffset | Line: 275 ]]
	p1:_setJointTransform(p1:_getJointTransform() * p2)
	p1._appliedOffset = p2
end
function t._restoreAppliedOffset(p1) --[[ _restoreAppliedOffset | Line: 280 ]]
	p1:_setJointTransform(p1:_getJointTransform() * p1._appliedOffset:Inverse())
	p1._appliedOffset = CFrame.identity
end
function t._isOffsetAtRest(p1) --[[ _isOffsetAtRest | Line: 285 ]]
	local v1, v2, v3 = p1._currentOffset:ToOrientation()

	return math.max(math.abs(v1), math.abs(v2), (math.abs(v3))) <= 0.001
end
function t._step(p1, p2) --[[ _step | Line: 290 ]]
	p1._currentOffset = p1._currentOffset:Lerp(p1:_getTargetOffset(), 1 - math.exp(p2 * -3.5))
	p1:_applyOffset(p1._currentOffset)

	if p1._isWaking or not p1:_isOffsetAtRest() then
		return false
	end

	p1._currentOffset = CFrame.identity
	p1:_restoreAppliedOffset()

	return true
end
function t._ensureAnimation(p1) --[[ _ensureAnimation | Line: 305 | Upvalues: RunService (copy) ]]
	if p1._preSimulationConnection ~= nil then
		return
	end

	assert(p1._preAnimationConnection == nil, "wake look-at frame connections must share a lifecycle")
	p1._preAnimationConnection = RunService.PreAnimation:Connect(function() --[[ Line: 311 | Upvalues: p1 (copy) ]]
		p1:_restoreAppliedOffset()
	end)
	p1._preSimulationConnection = RunService.PreSimulation:Connect(function(p12) --[[ Line: 314 | Upvalues: p1 (copy) ]]
		if not p1:_step(p12) then
			return
		end

		p1:_disconnectAnimation()
	end)
end
function t._disconnectAnimation(p1) --[[ _disconnectAnimation | Line: 321 ]]
	local _preAnimationConnection = p1._preAnimationConnection

	if _preAnimationConnection ~= nil then
		p1._preAnimationConnection = nil
		_preAnimationConnection:Disconnect()
	end

	local _preSimulationConnection = p1._preSimulationConnection

	if _preSimulationConnection == nil then
		return
	end

	p1._preSimulationConnection = nil
	_preSimulationConnection:Disconnect()
end
function t.SetWaking(p1, p2, p3) --[[ SetWaking | Line: 339 | Upvalues: Asserts (copy) ]]
	Asserts.boolean(p2)
	Asserts.optional.string(p3)

	if not p2 or (not p1._isWaking or p3 ~= p1._targetUserId) then
		p1._targetPitchReference = nil
	end

	p1._isWaking = p2
	p1._targetUserId = p3

	if not p2 and p1:_isOffsetAtRest() then
		return
	end

	p1:_ensureAnimation()
end
function t.Destroy(p1) --[[ Destroy | Line: 353 ]]
	p1._isWaking = false
	p1._targetPitchReference = nil
	p1._targetUserId = nil
	p1._currentOffset = CFrame.identity
	p1:_restoreAppliedOffset()
	p1:_disconnectAnimation()
end

return t