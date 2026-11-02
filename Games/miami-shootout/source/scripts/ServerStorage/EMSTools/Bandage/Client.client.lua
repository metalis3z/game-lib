local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local idle = script.Parent:WaitForChild("Idle")
local humanoid = character:WaitForChild("Humanoid")

local animation = humanoid:LoadAnimation(idle)

local tool = script.Parent
local proximity = tool:WaitForChild("Handle"):WaitForChild("Heal")

local cooldown = 1
local onCooldown = false

proximity.Triggered:Connect(function(p)
	if p == game.Players.LocalPlayer then
		onCooldown = true
		proximity.Enabled = false
		wait(cooldown)
		proximity.Enabled = true
		onCooldown = false
	end
end)

tool.Equipped:Connect(function()
	animation:Play()
	if not onCooldown then proximity.Enabled = true end
end)

tool.Unequipped:Connect(function()
	animation:Stop()
	proximity.Enabled = false
end)