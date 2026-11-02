game.ReplicatedStorage.EntityInfo.HaltClear.OnServerEvent:Connect(function()
	game.Workspace.GameSettings.Server.RunRush.Value = true
	game.Workspace.CurrentRooms.CurrentRoom.HaltCorridorValue.Value = false
end)