script.Parent:WaitForChild("Humanoid").Died:Connect(function()
	script.Parent.Parent = workspace.Players.Spectating
	task.wait(3)
	script.Parent:Destroy()
end)