local character = script.Parent
local humanoid = character:FindFirstChild("Humanoid")
local Sound = script:WaitForChild('LowHealthSound')

humanoid.HealthChanged:Connect(function()
	if humanoid.Health <= 30 then
		if humanoid.Health <= 0 then
			if character:FindFirstChildOfClass('Tool') then
				character:FindFirstChildOfClass('Tool').Parent = game:FindService('Players'):GetPlayerFromCharacter(character).Backpack
			end
			game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
		end
		Sound:Play()
	else
		Sound:Stop()
	end
end)