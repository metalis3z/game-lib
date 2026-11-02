function onChatted(message, player)
	if message == "/sg BerettaEXT" and game.MarketplaceService:UserOwnsGamePassAsync(player.UserId, 629847637) then
		if player.Spawns.Value > 0 then
			game.Lighting["BerettaEXT"]:Clone().Parent = player.Backpack
			player.Spawns.Value = player.Spawns.Value - 1
			player.PlayerGui.SpawnerViews.Spawner.Enabled = true
			player.PlayerGui.SpawnerViews.Spawner.TextLabel.Text = "You have ".. player.Spawns.Value.." Spawns Left!"
			wait(2)
			player.PlayerGui.SpawnerViews.Spawner.Enabled = false
			
		elseif player.Spawns.Value == 0 then
			player.PlayerGui.SpawnerViews.Spawner2.Enabled = true
			player.PlayerGui.SpawnerViews.Spawner2.TextLabel.Text = "You have no guns left to spawn"
			wait(2)
			player.PlayerGui.SpawnerViews.Spawner2.Enabled = false
		end
	end
end

game.Players.PlayerAdded:connect(function(player)
	player.Chatted:connect(function(message) onChatted(message, player) 
	end)
end)
