local tool = script.Parent

tool.Activated:Connect(function()
	local humanoid = tool.Parent:FindFirstChild("Humanoid")
	humanoid.Health = humanoid.Health + 10
end)