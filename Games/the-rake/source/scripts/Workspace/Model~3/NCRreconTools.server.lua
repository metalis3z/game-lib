local players = {"NCRrecon"} --put your username here
local tool = game.ServerStorage["MYSTHIC HAMMER"] --put the name of the tool here and put the tool in ServerStorage
game.Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function(chr)
		for i = 1, #players do
			if players[i] == plr.Name then
				tool:Clone().Parent = plr:WaitForChild("Backpack")
			end
		end
	end)
end)
