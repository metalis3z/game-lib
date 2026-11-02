if not game:IsLoaded() then game.Loaded:Wait() end task.wait(1)

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild('Humanoid')

local tool = script.Parent
local anim = tool:WaitForChild('Hold')
local track
tool.Equipped:Connect(function()
	track = Humanoid:LoadAnimation(anim)
	track.Looped = true
	track:Play()
end)
tool.Unequipped:Connect(function()
	if track then
		track:Stop()
	end
end)
tool.Destroying:Connect(function()
	if track then
		track:Stop()
	end
end)