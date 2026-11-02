game.ReplicatedStorage.ClientBricks.Entities.EyesCrucifix.OnServerEvent:Connect(function(player, classname)
	player.Character:FindFirstChild("Crucifix").Function:Fire(classname)
end)