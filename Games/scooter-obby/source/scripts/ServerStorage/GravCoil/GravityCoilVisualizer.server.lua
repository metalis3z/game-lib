local Players = game:GetService("Players")
local Tool = script.Parent

Tool.Equipped:Connect(function(mouse)
	if Tool.Parent == Players.LocalPlayer.Character then
		workspace.Gravity = 70
		script.Parent.Handle.CoilSound:Play()
		script.Parent.Handle.Transparency = 0
	end
end)

Tool.Unequipped:Connect(function(mouse)
	if Tool.Parent.Parent == Players.LocalPlayer then
		workspace.Gravity = 115
		script.Parent.Handle.Transparency = 1
	end
end)

game:GetService("RunService").RenderStepped:Connect(function()
	if workspace:FindFirstChild(Players.LocalPlayer.Name) and workspace:FindFirstChild(Players.LocalPlayer.Name):FindFirstChild("RightUpperArm") then
		local pos = workspace:FindFirstChild(Players.LocalPlayer.Name).RightUpperArm.CFrame
		script.Parent.Handle.CFrame = pos
	end
end)