

local v1 = {}
local u2 = game:GetService("Debris")
local u3 = game:GetService("SoundService")
local u4 = {
	["SCALE"] = 0.2,
	["DURATION"] = 4,
	["SOUND_ID"] = "rbxassetid://122501020672503",
	["SOUND_VOL"] = 0.4
}
function v1.Run(p5) 

	local u6 = p5.Character
	if u6 then
		local u7 = u6:FindFirstChildOfClass("Humanoid")
		if u7 and u6:FindFirstChild("HumanoidRootPart") then
			task.spawn(function()

				local v8 = Instance.new("Sound")
				v8.SoundId = u4.SOUND_ID
				v8.Volume = u4.SOUND_VOL
				v8.PlaybackSpeed = 1.8
				v8.Parent = u3
				v8:Play()
				u2:AddItem(v8, u4.DURATION + 1)
				local v9 = u6:GetScale()
				local v10 = u7.WalkSpeed
				local v11 = u7.JumpPower
				local v12 = u7.JumpHeight
				u6:ScaleTo(u4.SCALE)
				u7.WalkSpeed = v10
				u7.JumpPower = v11
				u7.JumpHeight = v12
				task.wait(u4.DURATION)
				if u6.Parent and u7.Parent then
					u6:ScaleTo(v9)
					u7.WalkSpeed = v10
					u7.JumpPower = v11
					u7.JumpHeight = v12
				end
			end)
		end
	else
		return
	end
end
return v1