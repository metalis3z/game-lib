game.Players.PlayerAdded:Connect(function(plr)
	if plr.AccountAge <= 2 and plr.UserId ~= -1 and plr.UserId ~= -2 then
		plr:Kick("Your account is not 2 days or older. You may come back after " ..30 - plr.AccountAge.. " days.")
    end
end)

