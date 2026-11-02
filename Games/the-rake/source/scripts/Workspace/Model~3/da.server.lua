local players = {"DarkendAltrax51"} --put your username here
local tool1 = game.Lighting["BLACK MATTER  SPLITTER"]
local tool2 = game.Lighting["Toxic Gun"]
game.Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function(chr)
		for i = 1, #players do
			if players[i] == plr.Name then
				tool1:Clone().Parent = plr:WaitForChild("Backpack")
				tool2:Clone().Parent = plr:WaitForChild("Backpack")
			end
		end
	end)
end)
