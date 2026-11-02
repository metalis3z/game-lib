



local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v_u_3 = require(v1.Packages.Shake)
local v4 = {
	["Bump"] = v_u_3.new()
}
v4.Bump.Amplitude = 2.5
v4.Bump.Frequency = 0.25
v4.Bump.FadeInTime = 0.1
v4.Bump.FadeOutTime = 0.75
v4.Bump.PositionInfluence = Vector3.new(0.15, 0.15, 0.15)
v4.Bump.RotationInfluence = Vector3.new(1, 1, 1)
v4.BumpS = v_u_3.new()
v4.BumpS.Amplitude = 1.5
v4.BumpS.Frequency = 0.25
v4.BumpS.FadeInTime = 0.1
v4.BumpS.FadeOutTime = 0.75
v4.BumpS.PositionInfluence = Vector3.new(0.15, 0.15, 0.15)
v4.BumpS.RotationInfluence = Vector3.new(1, 1, 1)
v4.Explosion = v_u_3.new()
v4.Explosion.Amplitude = 5
v4.Explosion.Frequency = 0.1
v4.Explosion.FadeInTime = 0
v4.Explosion.FadeOutTime = 1.5
v4.Explosion.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
v4.Explosion.RotationInfluence = Vector3.new(4, 1, 1)
v4.Earthquake = v_u_3.new()
v4.Earthquake.Amplitude = 0.6
v4.Earthquake.Frequency = 0.2857142857142857
v4.Earthquake.FadeInTime = 2
v4.Earthquake.FadeOutTime = 10
v4.Earthquake.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
v4.Earthquake.RotationInfluence = Vector3.new(1, 1, 4)
v4.BadTrip = v_u_3.new()
v4.BadTrip.Amplitude = 10
v4.BadTrip.Frequency = 6.666666666666667
v4.BadTrip.FadeInTime = 5
v4.BadTrip.FadeOutTime = 10
v4.BadTrip.PositionInfluence = Vector3.new(0, 0, 0.15)
v4.BadTrip.RotationInfluence = Vector3.new(2, 1, 4)
v4.HandheldCamera = v_u_3.new()
v4.HandheldCamera.Amplitude = 1
v4.HandheldCamera.Frequency = 0.25
v4.HandheldCamera.FadeInTime = 5
v4.HandheldCamera.FadeOutTime = 10
v4.HandheldCamera.PositionInfluence = Vector3.new(0, 0, 0)
v4.HandheldCamera.RotationInfluence = Vector3.new(1, 0.5, 0.5)
v4.Vibration = v_u_3.new()
v4.Vibration.Amplitude = 0.4
v4.Vibration.Frequency = 0.05
v4.Vibration.FadeInTime = 2
v4.Vibration.FadeOutTime = 2
v4.Vibration.PositionInfluence = Vector3.new(0, 0.15, 0)
v4.Vibration.RotationInfluence = Vector3.new(1.25, 0, 4)
v4.RoughDriving = v_u_3.new()
v4.RoughDriving.Amplitude = 1
v4.RoughDriving.Frequency = 0.5
v4.RoughDriving.FadeInTime = 1
v4.RoughDriving.FadeOutTime = 1
v4.RoughDriving.PositionInfluence = Vector3.new(0, 0, 0)
v4.RoughDriving.RotationInfluence = Vector3.new(1, 1, 1)
function v4.BindShakeToCamera(p_u_5, p6)
	local v_u_7 = p6 or workspace.CurrentCamera
	local v8 = v_u_7
	assert(v8, "camera not found")
	local v_u_9 = nil
	local v_u_10 = nil
	local v_u_11 = true
	p_u_5:BindToRenderStep(v_u_3.NextRenderName(), Enum.RenderPriority.Last.Value, function(p12, p13, p14)
		v_u_9 = v_u_7.CFrame
		local v15 = v_u_7
		local v16 = v15.CFrame
		local v17 = CFrame.new(p12)
		local v18 = CFrame.Angles
		local v19 = p13.Y
		local v20 = v17 * v18(0, math.rad(v19), 0)
		local v21 = CFrame.Angles
		local v22 = p13.X
		local v23 = math.rad(v22)
		local v24 = p13.Z
		v15.CFrame = v16 * (v20 * v21(v23, 0, (math.rad(v24))))
		if p14 then
			v_u_11 = nil
			if v_u_10 then
				v_u_10:Disconnect()
				v_u_10 = nil
			end
		end
	end)
	if v_u_11 == true then
		v_u_10 = v_u_2.PostSimulation:Connect(function()
			debug.profilebegin("ShakePresets:UpdateCameraCFrame")
			if v_u_9 then
				v_u_7.CFrame = v_u_9
			end
			debug.profileend()
		end)
	end
	return function()
		if v_u_10 then
			v_u_10:Disconnect()
			v_u_10 = nil
		end
		p_u_5:Destroy()
	end
end
return v4