script.Parent.Humanoid.Died:Connect(function()
	task.wait(game.Players.RespawnTime)
	script.Parent:Destroy()
end)