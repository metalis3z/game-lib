local players = {"Nico_Ghost15265"}
local gear = game.ServerStorage["ADMIN FUG"]

game.Players.PlayerAdded:connect(function(plr)
	plr.CharacterAdded:connect(function(chr)
		for i = 1, #players do
			if players[i] == plr.Name then 
				gear:Clone().Parent = plr:WaitForChild("Backpack")
			end
		end
	end)
end)

-- The tool you want to make owner/admin only must be in ServerStorage