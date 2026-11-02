
while task.wait(math.random(1, 5)) do
	for count = math.random(1, 5), math.random(5, 20) do
		local static: Sound = script:GetChildren()[math.random(1, #script:GetChildren())]:Clone()
		static.Parent = script.Parent
		static:Play()
		static.Ended:Connect(function()
			static:Destroy()
		end)
		for _, effect in script.Parent:GetDescendants() do
			if effect:IsA("ParticleEmitter") then
				effect.Enabled = true
			end
			if effect:IsA("Light") then
				effect.Brightness = math.random(1, 3)
			end
		end
		task.wait(math.random(0.1, 0.5))
	end
	for _, effect in script.Parent:GetDescendants() do
		if effect:IsA("ParticleEmitter") then
			effect.Enabled = false
		end
		if effect:IsA("Light") then
			effect.Brightness = 0
		end
	end
end