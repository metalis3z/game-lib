game.ReplicatedStorage.ClientBricks.EntityDeath.OnServerEvent:Connect(function(player, p1)
	player.Stats.Death.Value = p1
end)