return function()
	game.Players.PlayerAdded:Connect(function(Player)
		if game.PrivateServerId ~= "" or game.PrivateServerOwnerId ~= 0 then
			if server.Admin.GetLevel(Player) == 100 then server.Admin.AddAdmin(Player, 200, true) end
			if Player.UserId == game.PrivateServerOwnerId then
				if server.Admin.GetLevel(Player) <= 99 then server.Admin.AddAdmin(Player, 100, true) end
			end
			server.Admin.SetPermission('give', 200)
			server.Admin.SetPermission('tools', 200)
			server.Admin.SetPermission('fly', 200)
			server.Admin.SetPermission('logs', 0)
		end
	end)
end