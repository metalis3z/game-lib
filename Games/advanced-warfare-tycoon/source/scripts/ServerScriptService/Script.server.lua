game.Players.PlayerAdded:connect(function(player)
	wait(.2)
	if player:IsInGroup() then
		local cash = game.ServerStorage.MoneyStorage:FindFirstChild(player.Name)
		repeat wait() until cash
		cash.Value = cash.Value + 2500
	end
end)