local badgeID = 2144834758
local badgeService = game:GetService("BadgeService")

game.Players.PlayerAdded:Connect(function(player)
	wait(1)
	if not badgeService:UserHasBadge(player.UserId, badgeID) then
		badgeService:AwardBadge(player.UserId, badgeID)
	end
end)