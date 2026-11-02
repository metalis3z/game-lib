game.Workspace.GameSettings.Fires.ScreechCrucifix.OnServerEvent:Connect(function(player, model)
	local ScreechCloned = game.ReplicatedStorage.Entities.Screech:Clone()

	ScreechCloned.Parent = game.Workspace
	ScreechCloned:PivotTo(model)
end)