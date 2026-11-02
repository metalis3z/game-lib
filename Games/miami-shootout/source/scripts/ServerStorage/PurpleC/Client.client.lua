local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Animator = Humanoid:WaitForChild("Animator")
local Animations = script.Parent:WaitForChild('Animations')
local IdleAnim = Animations:WaitForChild('Idle')
local IdleTrack = Animator:LoadAnimation(IdleAnim)
local Tool = script.Parent

Tool.Equipped:Connect(function()
	IdleTrack:Play()
end)

Tool.Unequipped:Connect(function()
	IdleTrack:Stop()
end)