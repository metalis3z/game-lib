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
	
	script.ParticleEmitter1:Clone().Parent = char.UpperTorso
	script.ParticleEmitter1:Clone().Parent = char.LeftUpperArm
	script.ParticleEmitter1:Clone().Parent = char.LeftLowerArm
	script.ParticleEmitter1:Clone().Parent = char.RightUpperArm
	script.ParticleEmitter1:Clone().Parent = char.RightLowerArm
	script.ParticleEmitter1:Clone().Parent = char.LowerTorso
	script.ParticleEmitter1:Clone().Parent = char.LeftLowerLeg
	script.ParticleEmitter1:Clone().Parent = char.LeftUpperLeg
	script.ParticleEmitter1:Clone().Parent = char.RightLowerLeg
	script.ParticleEmitter1:Clone().Parent = char.RightUpperLeg
	
	if char:WaitForChild("Head") then
		local sound = Instance.new("Sound", char.Head)
		sound.SoundId = "rbxassetid://157325701"
		sound.TimePosition = 0
		sound.Volume = 1

		sound:Play()

		wait(3)

		sound:Stop()
	end
end