local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local Humanoid = character:WaitForChild("Humanoid")

Humanoid.HealthChanged:Connect(function(Damage)
	script.Parent.Size = UDim2.new(Damage / Humanoid.MaxHealth, 0,1,0)
end)
