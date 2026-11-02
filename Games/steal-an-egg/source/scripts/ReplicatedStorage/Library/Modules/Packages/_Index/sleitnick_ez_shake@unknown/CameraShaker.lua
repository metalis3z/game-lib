-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local CameraShakeInstance = require(script.CameraShakeInstance)
local CameraShakePresets = require(script.CameraShakePresets)
local Variables = require(ReplicatedStorage.Library.Variables)
local profilebegin = debug.profilebegin
local profileend = debug.profileend
local v1 = 0
local v2 = Vector3.new
local v3 = CFrame.new
local Angles = CFrame.Angles
local rad = math.rad
local v4 = v2()
local CameraShakeState = CameraShakeInstance.CameraShakeState
local Last = Enum.RenderPriority.Last.Value
local CurrentCamera = workspace.CurrentCamera
local t = {}

t.__index = t
t.CameraShakeInstance = CameraShakeInstance
t.Presets = CameraShakePresets

local function defaultCallback(p1) --[[ defaultCallback | Line: 86 | Upvalues: CurrentCamera (copy) ]]
	local v1 = CurrentCamera

	v1.CFrame = v1.CFrame * p1
end

function t.new(p1, p2, p3) --[[ new | Line: 122 | Upvalues: Asserts (copy), t (copy), Last (copy), v4 (copy), defaultCallback (copy) ]]
	Asserts.optional.number(p1)
	Asserts.optional.func(p2)

	local t2 = {
		_running = false,
		_driftConn = nil,
		_renderName = t.NextRenderName()
	}

	t2._renderPriority = if p1 then p1 else Last
	t2._posAddShake = v4
	t2._rotAddShake = v4
	t2._camShakeInstances = {}
	t2._removeInstances = {}
	t2._callback = if p2 then p2 else defaultCallback
	t2._optimizeDrift = p3 or false
	t2._renderBindings = {}
	t2._renderDriftConnections = {}

	return setmetatable(t2, t)
end
function t.NextRenderName() --[[ NextRenderName | Line: 154 | Upvalues: v1 (ref) ]]
	v1 = v1 + 1

	return ("__shake_%.4i__"):format(v1)
end
function t.Start(p1, p2) --[[ Start | Line: 159 | Upvalues: Asserts (copy), RunService (copy), CurrentCamera (copy), profilebegin (copy), profileend (copy) ]]
	if p1._running then
		return
	end

	Asserts.optional.string(p2)
	p1._running = true

	local v1 = p2 or p1._renderName
	local _callback = p1._callback
	local v2 = nil

	RunService:BindToRenderStep(v1, p1._renderPriority, function(p12) --[[ Line: 171 | Upvalues: v2 (ref), CurrentCamera (ref), profilebegin (ref), p1 (copy), profileend (ref), _callback (copy) ]]
		v2 = CurrentCamera.CFrame
		profilebegin("CameraShakerUpdate")

		local v1 = p1:Update(p12)

		profileend()
		_callback(v1)
	end)
	p1._renderBindings[v1] = true

	if p1._optimizeDrift then
		p1._renderDriftConnections[v1] = RunService.Heartbeat:Connect(function() --[[ Line: 187 | Upvalues: v2 (ref), CurrentCamera (ref) ]]
			if v2 then
				CurrentCamera.CFrame = v2
			end
		end)
	end
end
function t.StopByRenderName(p1, p2) --[[ StopByRenderName | Line: 195 | Upvalues: Asserts (copy), RunService (copy) ]]
	Asserts.string(p2)
	assert(p1._renderBindings[p2], (("Attempt to remove an unBinded render name: \"%*\""):format(p2)))

	local v3 = p1._renderDriftConnections[p2]

	if v3 then
		v3:Disconnect()
		p1._renderDriftConnections[p2] = nil
	end

	p1._renderBindings[p2] = nil
	RunService:UnbindFromRenderStep(p2)
end
function t.Stop(p1) --[[ Stop | Line: 209 ]]
	if not p1._running then
		return
	end

	p1._running = false

	for v1 in p1._renderBindings do
		p1:StopByRenderName(v1)
	end
end
function t.StopSustained(p1, p2) --[[ StopSustained | Line: 220 ]]
	for k, v in pairs(p1._camShakeInstances) do
		if v.fadeOutDuration == 0 then
			v:StartFadeOut(if p2 then p2 else v.fadeInDuration)
		end
	end
end
function t.Update(p1, p2) --[[ Update | Line: 228 | Upvalues: v4 (copy), CameraShakeState (copy), Variables (copy), v3 (copy), Angles (copy), rad (copy) ]]
	local sum = v4
	local sum2 = v4
	local _camShakeInstances = p1._camShakeInstances

	for i = 1, #_camShakeInstances do
		local v1 = _camShakeInstances[i]
		local v2 = v1:GetState()

		if v2 == CameraShakeState.Inactive and v1.DeleteOnInactive then
			p1._removeInstances[#p1._removeInstances + 1] = i

			continue
		end

		if v2 ~= CameraShakeState.Inactive then
			local v32 = v1:UpdateShake(p2)

			sum = sum + v32 * v1.PositionInfluence
			sum2 = sum2 + v32 * v1.RotationInfluence
		end
	end

	for j = #p1._removeInstances, 1, -1 do
		table.remove(_camShakeInstances, p1._removeInstances[j])
		p1._removeInstances[j] = nil
	end

	if Variables.IsInteractingWithNpc then
		sum = v4
		sum2 = v4
	end

	return v3(sum) * Angles(0, rad(sum2.Y), 0) * Angles(rad(sum2.X), 0, (rad(sum2.Z)))
end
function t.Shake(p1, p2) --[[ Shake | Line: 263 ]]
	assert(if type(p2) == "table" then p2._camShakeInstance else false, "ShakeInstance must be of type CameraShakeInstance")
	p1._camShakeInstances[#p1._camShakeInstances + 1] = p2

	return p2
end
function t.ShakeFromPresetName(p1, p2) --[[ ShakeFromPresetName | Line: 274 | Upvalues: Asserts (copy), CameraShakePresets (copy) ]]
	Asserts.string(p2)

	return p1:Shake(CameraShakePresets[p2])
end
function t.ShakeSustain(p1, p2) --[[ ShakeSustain | Line: 284 ]]
	assert(if type(p2) == "table" then p2._camShakeInstance else false, "ShakeInstance must be of type CameraShakeInstance")
	p1._camShakeInstances[#p1._camShakeInstances + 1] = p2
	p2:StartFadeIn(p2.fadeInDuration)

	return p2
end
function t.ShakeOnce(p1, p2, p3, p4, p5, p6, p7) --[[ ShakeOnce | Line: 296 | Upvalues: CameraShakeInstance (copy) ]]
	local v1 = CameraShakeInstance.new(p2, p3, p4, p5)

	v1.PositionInfluence = if typeof(p6) == "Vector3" and p6 then p6 else Vector3.new(0.15, 0.15, 0.15)
	v1.RotationInfluence = if typeof(p7) == "Vector3" and p7 then p7 else Vector3.new(1, 1, 1)
	p1._camShakeInstances[#p1._camShakeInstances + 1] = v1

	return v1
end
function t.StartShake(p1, p2, p3, p4, p5, p6) --[[ StartShake | Line: 314 | Upvalues: CameraShakeInstance (copy) ]]
	local v1 = CameraShakeInstance.new(p2, p3, p4)

	v1.PositionInfluence = if typeof(p5) == "Vector3" and p5 then p5 else Vector3.new(0.15, 0.15, 0.15)
	v1.RotationInfluence = if typeof(p6) == "Vector3" and p6 then p6 else Vector3.new(1, 1, 1)
	v1:StartFadeIn(p4)
	p1._camShakeInstances[#p1._camShakeInstances + 1] = v1

	return v1
end

return t