wait(math.random(0.5,1.5))
local tool = script.Parent
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local anim = humanoid:LoadAnimation(script.Parent.holdAnimation)
tool.Equipped:Connect(function()
	anim:Play()
	
	game.Players.LocalPlayer.PlayerGui:FindFirstChild("CellPhone").Enabled = true
end)

tool.Unequipped:Connect(function()
	anim:Stop()
	
	game.Players.LocalPlayer.PlayerGui:FindFirstChild("CellPhone").Enabled = false
end)