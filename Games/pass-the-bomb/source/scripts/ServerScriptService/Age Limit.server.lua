function accage(player)
	if player.AccountAge >= 100 then 
	else
		player:Kick("Sorry! Your account must be over 100 days old in-order to join this season. \n\nThis measure is set in-order to prevent DDOS attacks and alternative accounts.\n\nFor more information, please contact the event hoster.")
	end
end

game.Players.PlayerAdded:connect(accage)

