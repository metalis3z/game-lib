pcall(function()
	game.Players.PlayerAdded:connect(function(player)
		if game.GamePassService:PlayerHasPass(player,204142290) then
			repeat wait() until game.ServerStorage.MoneyStorage
			local cashmoney = game.ServerStorage.MoneyStorage:WaitForChild(player.Name)
			cashmoney.Value = cashmoney.Value + 4000
			
		end
	end)
end)