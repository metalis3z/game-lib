local tool = script.Parent
local sound = script.Parent.Handle.Sound
sound.Looped = false

tool.Activated:Connect(function(Player)
	sound:Play()
	wait(2.5)
	local humanoid = tool.Parent:FindFirstChild("Humanoid")
	humanoid.Health =  humanoid.Health + 40
	script.Parent:Destroy()
end)