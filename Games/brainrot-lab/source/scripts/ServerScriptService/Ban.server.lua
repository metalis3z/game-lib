local Players = game:GetService("Players")

local bannedUsers = {
	[10320767553] = true,
	[8089172473] = true,
	[5829193492] = true,
	[10958537380] = true,
	
}

Players.PlayerAdded:Connect(function(player)
	if bannedUsers[player.UserId] then
		player:Kick("Você foi banido deste jogo.")
	end
end)