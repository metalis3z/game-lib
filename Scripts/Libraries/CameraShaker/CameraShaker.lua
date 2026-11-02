--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- CQNBBHR5cGUGbnVtYmVySFJlbmRlclByaW9yaXR5IG11c3QgYmUgYSBudW1iZXIgKGUuZy46IEVudW0uUmVuZGVyUHJpb3JpdHkuQ2FtZXJhLlZhbHVlKQZhc3NlcnQIZnVuY3Rpb24bQ2FsbGJhY2sgbXVzdCBiZSBhIGZ1bmN0aW9uCF9ydW5uaW5nC19yZW5kZXJOYW1lDENhbWVyYVNoYWtlcg9fcmVuZGVyUHJpb3JpdHkMX3Bvc0FkZFNoYWtlDF9yb3RBZGRTaGFrZRJfY2FtU2hha2VJbnN0YW5jZXMQX3JlbW92ZUluc3RhbmNlcwlfY2FsbGJhY2sMc2V0bWV0YXRhYmxlA25ldxJDYW1lcmFTaGFrZXJVcGRhdGUGVXBkYXRlBGdhbWUKUnVuU2VydmljZQpHZXRTZXJ2aWNlEEJpbmRUb1JlbmRlclN0ZXAFU3RhcnQUVW5iaW5kRnJvbVJlbmRlclN0ZXAEU3RvcAVwYWlycw9mYWRlT3V0RHVyYXRpb24OZmFkZUluRHVyYXRpb24MU3RhcnRGYWRlT3V0DVN0b3BTdXN0YWluZWQIR2V0U3RhdGUISW5hY3RpdmUQRGVsZXRlT25JbmFjdGl2ZQtVcGRhdGVTaGFrZRFQb3NpdGlvbkluZmx1ZW5jZRFSb3RhdGlvbkluZmx1ZW5jZQV0YWJsZQZyZW1vdmUBWQFYAVoRX2NhbVNoYWtlSW5zdGFuY2UxU2hha2VJbnN0YW5jZSBtdXN0IGJlIG9mIHR5cGUgQ2FtZXJhU2hha2VJbnN0YW5jZQVTaGFrZQtTdGFydEZhZGVJbgxTaGFrZVN1c3RhaW4GdHlwZW9mB1ZlY3RvcjMJU2hha2VPbmNlClN0YXJ0U2hha2UHX19pbmRleAVkZWJ1Zwxwcm9maWxlYmVnaW4KcHJvZmlsZWVuZAZDRnJhbWUGQW5nbGVzBG1hdGgDcmFkB3JlcXVpcmUGc2NyaXB0E0NhbWVyYVNoYWtlSW5zdGFuY2UQQ2FtZXJhU2hha2VTdGF0ZRJDYW1lcmFTaGFrZVByZXNldHMHUHJlc2V0cwALBgICAAAAOLsoAANSBQAApAQBAAAAAECfBAIC8AQCAAIAAACpAwABqQMBAIEBAwQDAAAAbwQDAKQCBQAAAEBAnwIDAbsoAQNSBQEApAQBAAAAAECf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

-- https://lua.expert/
local t = {}

t.__index = t

local profilebegin = debug.profilebegin
local profileend = debug.profileend
local v1 = Vector3.new
local v2 = CFrame.new
local Angles = CFrame.Angles
local rad = math.rad
local v3 = v1()
local CameraShakeInstance = require(script.CameraShakeInstance)
local CameraShakeState = CameraShakeInstance.CameraShakeState

t.CameraShakeInstance = CameraShakeInstance
t.Presets = require(script.CameraShakePresets)
function t.new(p1, p2) --[[ new | Line: 87 | Upvalues: v3 (copy), t (copy) ]]
	assert(if type(p1) == "number" then true else false, "RenderPriority must be a number (e.g.: Enum.RenderPriority.Camera.Value)")
	assert(if type(p2) == "function" then true else false, "Callback must be a function")

	return setmetatable({
		_running = false,
		_renderName = "CameraShaker",
		_renderPriority = p1,
		_posAddShake = v3,
		_rotAddShake = v3,
		_camShakeInstances = {},
		_removeInstances = {},
		_callback = p2
	}, t)
end
function t.Start(p1) --[[ Start | Line: 108 | Upvalues: profilebegin (copy), profileend (copy) ]]
	if not p1._running then
		p1._running = true

		local _callback = p1._callback

		game:GetService("RunService"):BindToRenderStep(p1._renderName, p1._renderPriority, function(p12) --[[ Line: 112 | Upvalues: profilebegin (ref), p1 (copy), profileend (ref), _callback (copy) ]]
			profilebegin("CameraShakerUpdate")

			local v1 = p1:Update(p12)

			profileend()
			_callback(v1)
		end)
	end
end
function t.Stop(p1) --[[ Stop | Line: 121 ]]
	if p1._running then
		game:GetService("RunService"):UnbindFromRenderStep(p1._renderName)
		p1._running = false
	end
end
function t.StopSustained(p1, p2) --[[ StopSustained | Line: 128 ]]
	for k, v in pairs(p1._camShakeInstances) do
		if v.fadeOutDuration == 0 then
			v:StartFadeOut(if p2 then p2 else v.fadeInDuration)
		end
	end
end
function t.Update(p1, p2) --[[ Update | Line: 137 | Upvalues: v3 (copy), CameraShakeState (copy), v2 (copy), Angles (copy), rad (copy) ]]
	local sum = v3
	local sum2 = v3
	local _camShakeInstances = p1._camShakeInstances

	for i = 1, #_camShakeInstances do
		local v1 = _camShakeInstances[i]
		local v22 = v1:GetState()

		if v22 == CameraShakeState.Inactive and v1.DeleteOnInactive then
			p1._removeInstances[#p1._removeInstances + 1] = i

			continue
		end

		if v22 ~= CameraShakeState.Inactive then
			local v32 = v1:UpdateShake(p2)

			sum = sum + v32 * v1.PositionInfluence
			sum2 = sum2 + v32 * v1.RotationInfluence
		end
	end

	for j = #p1._removeInstances, 1, -1 do
		table.remove(_camShakeInstances, p1._removeInstances[j])
		p1._removeInstances[j] = nil
	end

	return v2(sum) * Angles(0, rad(sum2.Y), 0) * Angles(rad(sum2.X), 0, (rad(sum2.Z)))
end
function t.Shake(p1, p2) --[[ Shake | Line: 174 ]]
	assert(if type(p2) == "table" then p2._camShakeInstance else false, "ShakeInstance must be of type CameraShakeInstance")
	p1._camShakeInstances[#p1._camShakeInstances + 1] = p2

	return p2
end
function t.ShakeSustain(p1, p2) --[[ ShakeSustain | Line: 181 ]]
	assert(if type(p2) == "table" then p2._camShakeInstance else false, "ShakeInstance must be of type CameraShakeInstance")
	p1._camShakeInstances[#p1._camShakeInstances + 1] = p2
	p2:StartFadeIn(p2.fadeInDuration)

	return p2
end
function t.ShakeOnce(p1, p2, p3, p4, p5, p6, p7) --[[ ShakeOnce | Line: 189 | Upvalues: CameraShakeInstance (copy) ]]
	local v1 = CameraShakeInstance.new(p2, p3, p4, p5)

	v1.PositionInfluence = if typeof(p6) == "Vector3" and p6 then p6 else Vector3.new(0.15, 0.15, 0.15)
	v1.RotationInfluence = if typeof(p7) == "Vector3" and p7 then p7 else Vector3.new(1, 1, 1)
	p1._camShakeInstances[#p1._camShakeInstances + 1] = v1

	return v1
end
function t.StartShake(p1, p2, p3, p4, p5, p6) --[[ StartShake | Line: 198 | Upvalues: CameraShakeInstance (copy) ]]
	local v1 = CameraShakeInstance.new(p2, p3, p4)

	v1.PositionInfluence = if typeof(p5) == "Vector3" and p5 then p5 else Vector3.new(0.15, 0.15, 0.15)
	v1.RotationInfluence = if typeof(p6) == "Vector3" and p6 then p6 else Vector3.new(1, 1, 1)
	v1:StartFadeIn(p4)
	p1._camShakeInstances[#p1._camShakeInstances + 1] = v1

	return v1
end

return t