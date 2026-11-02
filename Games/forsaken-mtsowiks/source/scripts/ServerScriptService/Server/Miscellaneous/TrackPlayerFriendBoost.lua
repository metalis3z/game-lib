local module = {
	CurrentBoosts = {}
}

MULTIPLIER_PER_FRIEND = 0.04
MAX_FRIEND_BOOST = 0.2

function AddToPlayerBoost(Player : Player, Amount : number)
	if not module.CurrentBoosts[Player] then
		module.CurrentBoosts[Player] = 0
	end
	module.CurrentBoosts[Player] = math.clamp(module.CurrentBoosts[Player]+Amount, 0, MAX_FRIEND_BOOST)
end

function module.Start()
	game.Players.PlayerAdded:Connect(function(NewPlayer)
		module.CurrentBoosts[NewPlayer] = 0
		for _, Player in pairs(game.Players:GetPlayers()) do
			if Player == NewPlayer then continue end
			if NewPlayer:IsFriendsWith(Player.UserId) then
				AddToPlayerBoost(NewPlayer, MULTIPLIER_PER_FRIEND)
				AddToPlayerBoost(Player, MULTIPLIER_PER_FRIEND)
			end
		end
	end)
	
	game.Players.PlayerRemoving:Connect(function(LeavingPlayer)
		module.CurrentBoosts[LeavingPlayer] = nil
		for _, Player in pairs(game.Players:GetPlayers()) do
			if Player == LeavingPlayer then continue end
			if Player:IsFriendsWith(LeavingPlayer.UserId) then
				AddToPlayerBoost(Player, -MULTIPLIER_PER_FRIEND)
			end
		end
	end)
end

function module:GetPlayerBoost(Player : Player)
	return module.CurrentBoosts[Player] or 0
end

return module