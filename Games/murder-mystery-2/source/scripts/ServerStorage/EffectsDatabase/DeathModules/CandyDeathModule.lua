return function(char)
	for _, v in pairs(char:GetChildren()) do
		if v:IsA("BasePart") then
			local Emitter = Instance.new("ParticleEmitter", v)
	
			Emitter.Texture = "rbxassetid://2683075854"
			Emitter.Size = NumberSequence.new(0.5)
			Emitter.Lifetime = NumberRange.new(0.5)
			Emitter.Rate = 14
		end
	end
	
	if char:WaitForChild("Head") then
		local CANDY = Instance.new("Sound", char.Head)
		CANDY.SoundId = "rbxassetid://160060487"
		CANDY.TimePosition = 0
		CANDY.Volume = 0.9
				
		CANDY:Play()
		
		wait(2)
		
		CANDY:Stop()
	end
end