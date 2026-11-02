game.ReplicatedStorage.PreShop.Lighter.OnServerEvent:Connect(function(player)
	player.Items.Lighter.Value = true
end)

game.ReplicatedStorage.PreShop.Vitamins.OnServerEvent:Connect(function(player)
	player.Items.Vitamins.Value = true
end)

game.ReplicatedStorage.PreShop.LighterUn.OnServerEvent:Connect(function(player)
	player.Items.Lighter.Value = false
end)

game.ReplicatedStorage.PreShop.VitaminsUn.OnServerEvent:Connect(function(player)
	player.Items.Vitamins.Value = false
end)

game.ReplicatedStorage.PreShop.Lockpick.OnServerEvent:Connect(function(player)
	player.Items.Lockpick.Value = true
end)

game.ReplicatedStorage.PreShop.LockpickUn.OnServerEvent:Connect(function(player)
	player.Items.Lockpick.Value = false
end)

game.ReplicatedStorage.PreShop.Flashlight.OnServerEvent:Connect(function(player)
	player.Items.Flashlight.Value = true
end)

game.ReplicatedStorage.PreShop.FlashlightUn.OnServerEvent:Connect(function(player)
	player.Items.Flashlight.Value = false
end)