

local v1 = {}
local u2 = game:GetService("Debris")
local u3 = game:GetService("SoundService")
local v4 = game:GetService("ReplicatedStorage")
local u5 = require(v4:WaitForChild("Config"))
local u6 = require(v4:WaitForChild("ClientState"))
local u7 = {
	["SLOW_SPEED"] = 4,
	["DURATION"] = 3,
	["SOUND_ID"] = "rbxassetid://128475171868078",
	["SOUND_VOL"] = 0.4
}
function v1.Run(p8) 

	local v9 = p8.Character
	if v9 then
		local u10 = v9:FindFirstChild("Humanoid")
		if u10 and v9:FindFirstChild("HumanoidRootPart") then
			local v11 = Instance.new("Sound")
			v11.Name = "TurtleSound"
			v11.SoundId = u7.SOUND_ID
			v11.Volume = u7.SOUND_VOL
			v11.PlaybackSpeed = 0.6
			v11.Parent = u3
			v11:Play()
			u2:AddItem(v11, u7.DURATION + 1)
			local u12 = os.clock() + u7.DURATION
			u10:SetAttribute("TurtleResetTime", u12)
			u10.WalkSpeed = u7.SLOW_SPEED
			task.delay(u7.DURATION, function()

				if u10 and u10.Parent then
					local v13 = u10:GetAttribute("TurtleResetTime")
					if v13 and v13 <= u12 + 0.05 then
						local v14 = u6:Get()
						u10.WalkSpeed = v14.CustomWalkSpeed and v14.CustomWalkSpeed > 0 and v14.CustomWalkSpeed or u5.CalculateMaxSpeed(v14.Level)
					end
				end
			end)
		end
	else
		return
	end
end
return v1