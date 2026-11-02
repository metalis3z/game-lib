-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Shake = require(ReplicatedStorage.Library.Modules.Packages.Shake)
local t = {
	Bump = Shake.new()
}

t.Bump.Amplitude = 2.5
t.Bump.Frequency = 0.25
t.Bump.FadeInTime = 0.1
t.Bump.FadeOutTime = 0.75
t.Bump.PositionInfluence = Vector3.new(0.15, 0.15, 0.15)
t.Bump.RotationInfluence = Vector3.new(1, 1, 1)
t.BumpS = Shake.new()
t.BumpS.Amplitude = 1.5
t.BumpS.Frequency = 0.25
t.BumpS.FadeInTime = 0.1
t.BumpS.FadeOutTime = 0.75
t.BumpS.PositionInfluence = Vector3.new(0.15, 0.15, 0.15)
t.BumpS.RotationInfluence = Vector3.new(1, 1, 1)
t.Explosion = Shake.new()
t.Explosion.Amplitude = 5
t.Explosion.Frequency = 0.1
t.Explosion.FadeInTime = 0
t.Explosion.FadeOutTime = 1.5
t.Explosion.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
t.Explosion.RotationInfluence = Vector3.new(4, 1, 1)
t.Earthquake = Shake.new()
t.Earthquake.Amplitude = 0.6
t.Earthquake.Frequency = 0.2857142857142857
t.Earthquake.FadeInTime = 2
t.Earthquake.FadeOutTime = 10
t.Earthquake.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
t.Earthquake.RotationInfluence = Vector3.new(1, 1, 4)
t.BadTrip = Shake.new()
t.BadTrip.Amplitude = 10
t.BadTrip.Frequency = 6.666666666666667
t.BadTrip.FadeInTime = 5
t.BadTrip.FadeOutTime = 10
t.BadTrip.PositionInfluence = Vector3.new(0, 0, 0.15)
t.BadTrip.RotationInfluence = Vector3.new(2, 1, 4)
t.HandheldCamera = Shake.new()
t.HandheldCamera.Amplitude = 1
t.HandheldCamera.Frequency = 0.25
t.HandheldCamera.FadeInTime = 5
t.HandheldCamera.FadeOutTime = 10
t.HandheldCamera.PositionInfluence = Vector3.new(0, 0, 0)
t.HandheldCamera.RotationInfluence = Vector3.new(1, 0.5, 0.5)
t.Vibration = Shake.new()
t.Vibration.Amplitude = 0.4
t.Vibration.Frequency = 0.05
t.Vibration.FadeInTime = 2
t.Vibration.FadeOutTime = 2
t.Vibration.PositionInfluence = Vector3.new(0, 0.15, 0)
t.Vibration.RotationInfluence = Vector3.new(1.25, 0, 4)
t.RoughDriving = Shake.new()
t.RoughDriving.Amplitude = 1
t.RoughDriving.Frequency = 0.5
t.RoughDriving.FadeInTime = 1
t.RoughDriving.FadeOutTime = 1
t.RoughDriving.PositionInfluence = Vector3.new(0, 0, 0)
t.RoughDriving.RotationInfluence = Vector3.new(1, 1, 1)
function t.BindShakeToCamera(p1, p2) --[[ BindShakeToCamera | Line: 79 | Upvalues: Shake (copy), RunService (copy) ]]
	local v2 = p2 or workspace.CurrentCamera
	local v3 = v2

	assert(v3, "camera not found")

	local v4 = nil
	local v5 = nil
	local v6 = true

	p1:BindToRenderStep(Shake.NextRenderName(), Enum.RenderPriority.Last.Value, function(p1, p2, p3) --[[ Line: 90 | Upvalues: v4 (ref), v2 (ref), v6 (ref), v5 (ref) ]]
		v4 = v2.CFrame

		local v3 = CFrame.new(p1)
		local v42 = v3 * CFrame.Angles(0, math.rad(p2.Y), 0)

		v2.CFrame = v2.CFrame * (v42 * CFrame.Angles(math.rad(p2.X), 0, (math.rad(p2.Z))))

		if not p3 then
			return
		end

		v6 = false

		if not v5 then
			return
		end

		v5:Disconnect()
		v5 = nil
	end)

	if v6 then
		v5 = RunService.PostSimulation:Connect(function() --[[ Line: 109 | Upvalues: v4 (ref), v2 (ref) ]]
			if not v4 then
				return
			end

			v2.CFrame = v4
		end)
	end

	return function() --[[ Line: 116 | Upvalues: v5 (ref), p1 (copy) ]]
		if v5 then
			v5:Disconnect()
			v5 = nil
		end

		p1:Destroy()
	end
end

return t