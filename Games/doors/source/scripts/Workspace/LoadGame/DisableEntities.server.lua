game.ReplicatedStorage.ClientBricks.Menu.DisableRush.OnServerEvent:Connect(function(player, value)
	game.Workspace.GameSettings.DisableRush_Entity.Value = value
end)

game.ReplicatedStorage.ClientBricks.Menu.DisableEyes.OnServerEvent:Connect(function(player, value)
	game.Workspace.GameSettings.DisableEyes_Entity.Value = value
end)

game.ReplicatedStorage.ClientBricks.Menu.DisableHalt.OnServerEvent:Connect(function(player, value)
	game.Workspace.GameSettings.DisableHalt_Entity.Value = value
end)

game.ReplicatedStorage.ClientBricks.Menu.DisableJack.OnServerEvent:Connect(function(player, value)
	game.Workspace.GameSettings.DisableJack_Entity.Value = value
end)