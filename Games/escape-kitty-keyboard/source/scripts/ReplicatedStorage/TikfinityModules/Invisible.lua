

local v1 = {}
local u2 = game:GetService("Debris")
local u3 = game:GetService("SoundService")
local u4 = {
	["DURATION"] = 4,
	["GHOST_TRANSPARENCY"] = 1,
	["SOUND_ID"] = "rbxassetid://136774133309136",
	["SOUND_VOL"] = 0.4
}
function v1.Run(p5) 

	local u6 = p5.Character
	if u6 then
		if u6:FindFirstChild("HumanoidRootPart") then
			task.spawn(function()

				local v7 = Instance.new("Sound")
				v7.SoundId = u4.SOUND_ID
				v7.Volume = u4.SOUND_VOL
				v7.PlaybackSpeed = 0.5
				v7.Parent = u3
				v7:Play()
				u2:AddItem(v7, u4.DURATION + 1)
				local v8 = {}
				for _, v9 in ipairs(u6:GetDescendants()) do
					if v9:IsA("BasePart") and v9.Name ~= "HumanoidRootPart" then
						v8[v9] = v9.Transparency
						v9.Transparency = u4.GHOST_TRANSPARENCY
					elseif v9:IsA("Decal") or v9:IsA("Texture") then
						v8[v9] = v9.Transparency
						v9.Transparency = u4.GHOST_TRANSPARENCY
					end
				end
				task.wait(u4.DURATION)
				if u6.Parent then
					for v10, v11 in pairs(v8) do
						if v10.Parent then
							v10.Transparency = v11
						end
					end
				end
			end)
		end
	else
		return
	end
end
return v1