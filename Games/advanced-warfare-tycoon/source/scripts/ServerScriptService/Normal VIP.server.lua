pcall(function()
	game.Players.PlayerAdded:connect(function(player)
		if game.GamePassService:PlayerHasPass(player,204143610) then
			repeat wait() until game.ServerStorage.MoneyStorage
			local cashmoney = game.ServerStorage.MoneyStorage:WaitForChild(player.Name)
			cashmoney.Value = cashmoney.Value + 1500
			local msg = Instance.new("Hint",workspace)
			msg.Text = player.Name.." joined the game as a VIP"
			wait(2)
			msg:Destroy()
		end
	end)
end)