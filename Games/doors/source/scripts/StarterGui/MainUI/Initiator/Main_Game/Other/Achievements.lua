local module = {}

function module.achievement(player, ID)
	if ID == 1 then
		if not game:GetService("BadgeService"):UserHasBadgeAsync(player.UserId, 2652300422619599) then
			game.ReplicatedStorage.Achievement:FireClient(player, true, "BuddySystem")
			game:GetService("BadgeService"):AwardBadge(player.UserId, 2652300422619599)
		end
	end
end

return module