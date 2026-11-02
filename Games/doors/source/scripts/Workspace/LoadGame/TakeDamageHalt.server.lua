game.ReplicatedStorage.ClientBricks.StressServer.OnServerEvent:Connect(function(player)
	player:FindFirstChild("Stats").StressMult.Value = player:FindFirstChild("Stats").StressMult.Value + 1
end)