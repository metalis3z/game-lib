


if game.Players.LocalPlayer:FindFirstChild("ServerStats") then
	
	
	if game.Players.LocalPlayer.ServerStats.Hunger.Value < 100 then
		game.Players.LocalPlayer.ServerStats.Hunger.Value = game.Players.LocalPlayer.ServerStats.Hunger.Value + 35
	end
end

