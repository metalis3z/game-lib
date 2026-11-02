function onChatted(message, player)
	if message == "/sg Halloween22Drum" and game.MarketplaceService:UserOwnsGamePassAsync(player.UserId, 271378374) then
		if player.Limit.Value > 0 then
			game.ReplicatedStorage.Firearms.Halloween22Drum:Clone().Parent = player.Backpack -- put all guns in a folder called "Firearms" in replicated storage
			player.Limit.Value = player.Limit.Value - 1
			player.PlayerGui.SpawnerViews.Spawner.Enabled = true
			player.PlayerGui.SpawnerViews.Spawner.TextLabel.Text = "You have ".. player.Limit.Value.."/15 guns left to spawn!"
			wait(2)
			player.PlayerGui.SpawnerViews.Spawner.Enabled = false
			
		elseif player.Limit.Value == 0 then
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
