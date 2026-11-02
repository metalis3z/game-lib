return function(char)
	for i,v in pairs(char:GetChildren()) do
		if v:IsA("BasePart") then
			v.Color = Color3.fromRGB(0, 0, 0)
		end
	end
	for i,v in pairs(char:GetChildren()) do
		if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then
			v:Destroy()
		end
	end
	script.Fire:Clone().Parent = char.UpperTorso
	sound = Instance.new("Sound")
	sound.Parent = char.Torso
	sound.SoundId = "rbxassetid://177045481"
	sound.Volume = 1
	sound:Play()
	wait(0.5)
	sound:Stop()
end