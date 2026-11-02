

local v1 = {}
local u2 = game:GetService("Lighting")
local u3 = game:GetService("TweenService")
local u4 = game:GetService("SoundService")
local u5 = game:GetService("Debris")
local u6 = {
	["DURATION"] = 3,
	["BLUR_SIZE"] = 40,
	["FADE_IN"] = 0.3,
	["FADE_OUT"] = 0.5,
	["SOUND_ID"] = "rbxassetid://135541330012995",
	["SOUND_VOL"] = 0.4
}
function v1.Run(_) 

	task.spawn(function()

		local v7 = Instance.new("Sound")
		v7.SoundId = u6.SOUND_ID
		v7.Volume = u6.SOUND_VOL
		v7.Parent = u4
		v7:Play()
		u5:AddItem(v7, u6.DURATION + 1)
		local v8 = Instance.new("BlurEffect")
		v8.Name = "TikfinityBlur"
		v8.Size = 0
		v8.Parent = u2
		u3:Create(v8, TweenInfo.new(u6.FADE_IN), {
			["Size"] = u6.BLUR_SIZE
		}):Play()
		task.wait(u6.DURATION)
		local v9 = u3:Create(v8, TweenInfo.new(u6.FADE_OUT), {
			["Size"] = 0
		})
		v9:Play()
		v9.Completed:Wait()
		v8:Destroy()
	end)
end
return v1