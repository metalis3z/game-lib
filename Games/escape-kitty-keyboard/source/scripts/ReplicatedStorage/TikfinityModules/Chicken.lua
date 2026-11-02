

local v1 = {}
local u2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("Debris")
local u4 = {
	["DURATION"] = 2.8,
	["COSTUME_NAME"] = "ChickenCostume",
	["SOUND_ID"] = "rbxassetid://4510529019",
	["VOLUME"] = 0.2
}
local function u8(p5) 
	for _, v6 in ipairs(p5:GetDescendants()) do
		local v7 = v6:GetAttribute("ChickenOldTransparency")
		if v7 ~= nil then
			v6.Transparency = v7
			v6:SetAttribute("ChickenOldTransparency", nil)
		end
	end
end
local function u12(p9, p10) 
	for _, v11 in ipairs(p9:GetDescendants()) do
		if v11:IsA("BasePart") and not (p10 and v11:IsDescendantOf(p10)) then
			if v11:GetAttribute("ChickenOldTransparency") == nil then
				v11:SetAttribute("ChickenOldTransparency", v11.Transparency)
			end
			v11.Transparency = 1
		end
	end
end
local function u19(p13) 

	local v14 = p13:FindFirstChild("HumanoidRootPart")
	local v15 = u2:FindFirstChild(u4.COSTUME_NAME)
	if not (v15 and v14) then
		return nil
	end
	local v16 = v15:Clone()
	v16.Name = "ChickenOutfit_Temp"
	v16.Parent = p13
	local v17 = v16:FindFirstChildWhichIsA("BasePart")
	v17.CanCollide = false
	v17.CFrame = v14.CFrame
	local v18 = Instance.new("WeldConstraint", v17)
	v18.Part0 = v17
	v18.Part1 = v14
	return v16
end
function v1.Run(p20) 

	local u21 = p20.Character
	if u21 and u21:FindFirstChild("HumanoidRootPart") then
		task.spawn(function()

			local v22 = u21:FindFirstChild("ChickenOutfit_Temp")
			if v22 then
				v22:Destroy()
			end
			u8(u21)
			local v23 = u19(u21)
			if v23 then
				u12(u21, v23)
				local v24 = Instance.new("Sound", u21.HumanoidRootPart)
				v24.SoundId = u4.SOUND_ID
				v24.Volume = u4.VOLUME
				v24:Play()
				u3:AddItem(v24, u4.DURATION + 1)
				task.wait(u4.DURATION)
				if u21.Parent then
					if v23 then
						v23:Destroy()
					end
					u8(u21)
				end
			end
		end)
	end
end
return v1