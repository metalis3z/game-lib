game.ReplicatedStorage.PreShopUse.OnServerEvent:Connect(function(player)
	--game.Workspace.GameSettings.Players:FindFirstChild("Player_"..player.Name).PlayerReady.Value = true

	if not player.Backpack:FindFirstChild("Lighter") then
		if player.Items.Lighter.Value == true then
			if player.Items.LighterBuyed.Value == false then
				player.Items.LighterBuyed.Value = true
				game.Workspace.GameSettings.ItemsStock:FindFirstChild("Lighter").Value = game.Workspace.GameSettings.ItemsStock:FindFirstChild("Lighter").Value - 1
				wait(0.1)
				local lighter = game.ServerStorage.Lighter:Clone()
				lighter.Parent = player.Backpack
				player.PlayerStats.Knobs.Value = player.PlayerStats.Knobs.Value - 50
			end
		end
	end

	if not player.Backpack:FindFirstChild("Vitamins") then
		if player.Items.Vitamins.Value == true then
			if player.Items.VitaminsBuyed.Value == false then
				player.Items.VitaminsBuyed.Value = true
				game.Workspace.GameSettings.ItemsStock:FindFirstChild("Vitamins").Value = game.Workspace.GameSettings.ItemsStock:FindFirstChild("Vitamins").Value - 1
				wait(0.2)
				local lighter = game.ServerStorage.Vitamins:Clone()
				lighter.Parent = player.Backpack
				player.PlayerStats.Knobs.Value = player.PlayerStats.Knobs.Value - 100
			end
		end
	end

	if not player.Backpack:FindFirstChild("Lockpick") then
		if player.Items.Lockpick.Value == true then
			if player.Items.LockpickBuyed.Value == false then
				player.Items.LockpickBuyed.Value = true
				game.Workspace.GameSettings.ItemsStock:FindFirstChild("Lockpick").Value = game.Workspace.GameSettings.ItemsStock:FindFirstChild("Lockpick").Value - 1
				wait(0.3)
				local lighter = game.ServerStorage.Lockpick:Clone()
				lighter.Parent = player.Backpack
				player.PlayerStats.Knobs.Value = player.PlayerStats.Knobs.Value - 50
			end
		end
	end

	if not player.Backpack:FindFirstChild("Flashlight") then
		if player.Items.Flashlight.Value == true then
			if player.Items.FlashlightBuyed.Value == false then
				player.Items.FlashlightBuyed.Value = true
				game.Workspace.GameSettings.ItemsStock:FindFirstChild("Flashlight").Value = game.Workspace.GameSettings.ItemsStock:FindFirstChild("Flashlight").Value - 1
				wait(0.4)
				local lighter = game.ServerStorage.Flashlight:Clone()
				lighter.Parent = player.Backpack
				player.PlayerStats.Knobs.Value = player.PlayerStats.Knobs.Value - 100
			end
		end
	end

end)