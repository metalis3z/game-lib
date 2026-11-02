game.ReplicatedStorage.ClientBricks.Entities.EyesKill.OnServerEvent:Connect(function(plat)
	game.ReplicatedStorage.Bricks.DeathHint:FireServer(plat, {"You died to the Eyes..", "They don't like to be stared at."}, "Blue")
	game.ReplicatedStorage.Bricks.GetStatistics:FireServer(plat, "Eyes")
end)