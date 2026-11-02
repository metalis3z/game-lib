local badgeService = game:GetService("BadgeService")
local id = 2124740439

game.Players.PlayerAdded:Connect(function(plr)
	if not badgeService:UserHasBadgeAsync(plr.UserId, id) then
		badgeService:AwardBadge(plr.UserId, id)
	end
end)