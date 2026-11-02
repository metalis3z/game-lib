local welcomebadge = game:GetService("BadgeService")

game.Players.PlayerAdded:Connect(function(player)
	if not welcomebadge:UserHasBadgeAsync(player.UserId, 2993466280435769) then
		welcomebadge:AwardBadge(player.UserId, 2993466280435769)
	end
end)