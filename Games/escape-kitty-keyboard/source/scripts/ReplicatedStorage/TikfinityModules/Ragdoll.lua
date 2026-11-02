

local v1 = {}
local u2 = game:GetService("Debris")
local u3 = {
	["DURATION"] = 2,
	["FORCE_H"] = 30,
	["FORCE_V"] = 35,
	["TILT_ANGLE"] = 70,
	["SOUND_ID"] = "rbxassetid://129432532096499"
}
function v1.Run(p4) 

	local u5 = p4.Character
	local u6
	if u5 then
		u6 = u5:FindFirstChild("HumanoidRootPart")
	else
		u6 = u5
	end
	local u7
	if u5 then
		u7 = u5:FindFirstChild("Humanoid")
	else
		u7 = u5
	end
	if u6 and (u7 and u7.Health > 0) then
		local v8 = Instance.new("Sound", u6)
		v8.SoundId = u3.SOUND_ID
		v8:Play()
		u2:AddItem(v8, 3)
		u7:ChangeState(Enum.HumanoidStateType.Physics)
		u7.PlatformStand = true
		local v9 = u6.CFrame
		local v10 = CFrame.Angles
		local v11 = u3.TILT_ANGLE
		u6.CFrame = v9 * v10(math.rad(v11), 0, 0)
		local v12 = -u6.CFrame.LookVector
		local v13 = v12.X * u3.FORCE_H
		local v14 = u3.FORCE_V
		local v15 = v12.Z * u3.FORCE_H
		u6.AssemblyLinearVelocity = Vector3.new(v13, v14, v15)
		task.delay(u3.DURATION, function()

			if u5.Parent and u7 then
				u7.PlatformStand = false
				u7:ChangeState(Enum.HumanoidStateType.GettingUp)
				u6.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			end
		end)
	end
end
return v1