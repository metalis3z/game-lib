return function(char)
	for i,v in pairs(char:GetChildren()) do
		if v:IsA("BasePart") then
			v.Material = Enum.Material.Neon
			v.Color = Color3.fromRGB(174, 44, 255)
		end
	end
	for i,v in pairs(char:GetChildren()) do
		if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then
			v:Destroy()
		end
	end
	
	local hat = Instance.new("Accessory")
	hat.Name = "CustomHat"
	hat.Parent = char
	hat.AccessoryType = Enum.AccessoryType.Hat
	hat.AttachmentPos = Vector3.new(0, 0.5, 0) -- Adjust the position if needed
	hat.Handle = Instance.new("MeshPart")
	hat.Handle.MeshId = "rbxassetid://13916906201"
	hat.Handle.Parent = hat
	
	
	script.Fire:Clone().Parent = char.UpperTorso
	sound = Instance.new("Sound")
	sound.Parent = char.UpperTorso
	sound.SoundId = "rbxassetid://9114572131"
	sound.Volume = 1
	sound:Play()
	wait(0.3)
	sound:Stop()
end
