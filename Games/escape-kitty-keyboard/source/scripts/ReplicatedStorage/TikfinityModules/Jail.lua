

local v1 = {}
local u2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("Debris")
local u4 = {
	["DURATION"] = 2.8,
	["MODEL_NAME"] = "PrisonCage",
	["SOUND_ID"] = "rbxassetid://102841351704442",
	["SOUND_VOLUME"] = 0.2,
	["FREEZE_DURING_SPAWN"] = true
}
function v1.Run(u5) 

	local u6 = u5.Character
	if u6 then
		u6 = u6:FindFirstChild("HumanoidRootPart")
	end
	if u6 then
		task.spawn(function()

			local v7 = u2:FindFirstChild(u4.MODEL_NAME)
			if v7 then
				if u4.FREEZE_DURING_SPAWN then
					u6.Anchored = true
				end
				local v8 = v7:Clone()
				v8.Name = "LocalCage_" .. u5.Name
				v8:PivotTo(u6.CFrame)
				v8.Parent = workspace
				if u4.FREEZE_DURING_SPAWN then
					u6.Anchored = false
				end
				local v9 = Instance.new("Sound", u6)
				v9.SoundId = u4.SOUND_ID
				v9.Volume = u4.SOUND_VOLUME
				v9:Play()
				u3:AddItem(v9, 2)
				task.wait(u4.DURATION)
				if v8 then
					v8:Destroy()
				end
			else
				warn("[Tikfinity] Mod\195\168le \'" .. u4.MODEL_NAME .. "\' introuvable dans ReplicatedStorage")
			end
		end)
	end
end
return v1