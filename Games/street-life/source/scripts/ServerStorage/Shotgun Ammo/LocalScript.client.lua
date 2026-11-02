wait(1)
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local idleA = script:WaitForChild("Animation")

local idleAnim = humanoid:LoadAnimation(idleA)
idleAnim.Looped = true

local tool = script.Parent
local equipped = false

tool.Equipped:Connect(function()
	equipped = true
	idleAnim:Play()
end)

tool.Unequipped:Connect(function()
	equipped = false
	idleAnim:Stop()
end)
