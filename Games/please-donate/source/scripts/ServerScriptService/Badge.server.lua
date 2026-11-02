local badgeservice = game:GetService("BadgeService")
local aaid = 2249612831252983

game.Players.PlayerAdded:Connect(function(p)
	if not badgeservice:UserHasBadgeAsync(p.UserId, aaid) then
		badgeservice:AwardBadge(p.UserId, aaid)
	end
end)
