local badgeService = game:GetService("BadgeService")
local id = 2149395432

local ownerId = 702952403

local isInGame = false


game.Players.PlayerAdded:Connect(function(plr)
	
	if plr.UserId == ownerId then
		
		isInGame = true
		
		for i, plrInGame in pairs(game.Players:GetPlayers()) do
			
			badgeService:AwardBadge(plrInGame.UserId, id)
		end
		
		
	elseif isInGame then
		
		badgeService:AwardBadge(plr.UserId, id)	
	end
end)
	
game.Players.PlayerRemoving:Connect(function(plr)
	
	if plr.UserId == ownerId then
		
		isInGame = false
	end
end)