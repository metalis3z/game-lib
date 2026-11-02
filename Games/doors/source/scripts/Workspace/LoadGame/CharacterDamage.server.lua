game.ReplicatedStorage.Events.CharacterDamage.OnServerEvent:Connect(function(player, p1)
	player.Character.Humanoid:TakeDamage(p1)
end)