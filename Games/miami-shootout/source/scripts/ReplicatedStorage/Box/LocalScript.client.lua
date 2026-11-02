local player = game.Players.LocalPlayer
local character = player.Character
local hum = character:WaitForChild("Humanoid")

local track = hum:LoadAnimation(game.Lighting.CarryAnim)

script.Parent.Equipped:Connect(function()
	track:Play()
end)

script.Parent.Unequipped:Connect(function()
	track:Stop()
end)