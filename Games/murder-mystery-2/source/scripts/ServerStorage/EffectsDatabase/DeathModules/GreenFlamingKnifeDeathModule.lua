return function(char)
	for _, v in pairs(char:GetChildren()) do
		if v:IsA("BasePart") or v:IsA("MeshPart") then
			v.Color = Color3.fromRGB(0,0,0)
		end
	end    
	for _, v in pairs(char:GetChildren()) do
		if v:IsA("Pants") or v:IsA("Shirt") then
			v:Destroy()
		end
	end

	if char:WaitForChild("Head") then
		local sound = Instance.new("Sound", char.Head)
		sound.SoundId = "rbxassetid://158853971"
		sound.TimePosition = 0
		sound.Volume = 1

		sound:Play()

		wait(3)

		sound:Stop()
	end

	if char:WaitForChild("UpperTorso") then
		local burning = Instance.new("Fire", char.UpperTorso)
		burning.Color = Color3.fromRGB(0, 255, 0)
		burning.SecondaryColor = Color3.fromRGB(0, 255, 0)
		burning.Heat = 5
		burning.Size = 5
	end
end