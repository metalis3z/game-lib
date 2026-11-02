local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local idle = script.Parent:WaitForChild("Idle")
local humanoid = character:WaitForChild("Humanoid")

local animation = humanoid:LoadAnimation(idle)

local tool = script.Parent
local proximity = tool:WaitForChild("Handle"):WaitForChild("Plant")

tool.Equipped:Connect(function()
	animation:Play()
	proximity.Enabled = true
end)

tool.Unequipped:Connect(function()
	animation:Stop()
	proximity.Enabled = false
end)