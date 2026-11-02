return function(char)
	local lol = script.god:Clone()
	for _, v in pairs(char:GetChildren()) do
		if v:IsA("BasePart") then
			v.BrickColor = BrickColor.new("Really black")
		end
	end
	
	if char:FindFirstChild("Shirt") then
		char:FindFirstChild("Shirt"):Destroy()
	else
		return
	end

	if char:FindFirstChild("Pants") then
		char:FindFirstChild("Pants"):Destroy()
	else
		return
	end
	
	local sound = Instance.new("Sound")
	sound.Parent = char.Head
	sound.Volume = 0.2
	sound.SoundId = "http://www.roblox.com/asset/?id=177045481"
	sound:Play()
	
	local Fire = Instance.new("Fire")
	Fire.Heat = 9
	Fire.Size = 5
	Fire.SecondaryColor = Color3.new(0/255,0/255,0/255)
	Fire.Parent = char.Head
	wait(0.15)
	lol.Parent = Fire

end