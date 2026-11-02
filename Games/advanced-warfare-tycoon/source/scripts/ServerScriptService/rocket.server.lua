game.Players.PlayerAdded:connect(function(player)
	wait(2)
		if game.GamePassService:PlayerHasPass(player,206615866) then
			wait(1)
			game.Lighting.HeatRocket:clone().Parent = player.Backpack
			game.Lighting.HeatRocket:clone().Parent = player.StarterGear
	end
end)