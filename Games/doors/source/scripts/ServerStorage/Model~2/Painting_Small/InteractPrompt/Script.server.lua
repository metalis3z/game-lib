script.Parent.Triggered:Connect(function(player)
	game.ReplicatedStorage.Bricks.Caption:FireClient(player, 'This painting is called "'..script.Parent.Parent.PaintingName.Value..'"')
end)