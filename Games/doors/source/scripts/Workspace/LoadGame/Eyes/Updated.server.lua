game.ReplicatedStorage.EntityInfo.SetEyesDeath.OnServerEvent:Connect(function(pl)
	pl.Stats.Death.Value = "Eyes"
	
	game.ReplicatedStorage.Bricks.DeathHint:FireClient(pl, {"You died to the Eyes..", "They don't like to be stared at."}, "Blue")
end)