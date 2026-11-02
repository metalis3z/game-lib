g1 = game.Lighting["G-AK47"]
g2 = game.Lighting.Bow
g3 = game.Lighting.Ithaca


pcall(function()
	game.Players.PlayerAdded:connect(function(player)
		if game.GamePassService:PlayerHasPass(player,205475781) then
			wait()
			g1:Clone().Parent = player.StarterGear
			wait()
			g2:Clone().Parent = player.StarterGear
			wait()
			g3:Clone().Parent = player.StarterGear
		end
	end)
end)