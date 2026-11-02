game.Players.PlayerAdded:Connect(function(Player)
	local Gui = script.ShopGui:Clone()
	Gui.Parent = Player.PlayerGui
end)
	