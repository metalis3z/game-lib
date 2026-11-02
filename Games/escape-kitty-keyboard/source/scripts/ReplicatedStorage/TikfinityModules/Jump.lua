

local v1 = {}
local u2 = game:GetService("Debris")
local u3 = {
	["POWER"] = 120,
	["SOUND_ID"] = "rbxassetid://9111926008",
	["VOLUME"] = 0.1
}
function v1.Run(p4) 

	local v5 = p4.Character
	local v6
	if v5 then
		v6 = v5:FindFirstChild("HumanoidRootPart")
	else
		v6 = v5
	end
	if v5 then
		v5 = v5:FindFirstChild("Humanoid")
	end
	if v6 and v5 then
		local v7 = Instance.new("Sound", v6)
		v7.SoundId = u3.SOUND_ID
		v7.Volume = u3.VOLUME
		v7:Play()
		u2:AddItem(v7, 2)
		local v8 = Instance.new("Attachment", v6)
		local v9 = Instance.new("LinearVelocity", v6)
		v9.Attachment0 = v8
		v9.MaxForce = 100000
		local v10 = u3.POWER
		v9.VectorVelocity = Vector3.new(0, v10, 0)
		v5:ChangeState(Enum.HumanoidStateType.Jumping)
		u2:AddItem(v8, 0.2)
		u2:AddItem(v9, 0.2)
	end
end
return v1