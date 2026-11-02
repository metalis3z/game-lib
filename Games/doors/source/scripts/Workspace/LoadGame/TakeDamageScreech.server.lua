game.ReplicatedStorage.ClientBricks.TakeDamageScreech.OnServerEvent:Connect(function(player)
	player.Stats.Death.Value = "Screech"
	player.Character:FindFirstChild("Humanoid"):TakeDamage(25)
end)