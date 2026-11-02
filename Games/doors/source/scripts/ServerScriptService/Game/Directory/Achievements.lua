local module = {}

-- Created and Fixed by BUILDG Studios

function module.achievement(player, ID)
	if ID == 1 then
		if not game:GetService("BadgeService"):UserHasBadgeAsync(player.UserId, 2652300422619599) then
			game.ReplicatedStorage.Achievement:FireClient(player, true, "BuddySystem")
			game:GetService("BadgeService"):AwardBadge(player.UserId, 2652300422619599)
		end
	elseif ID == 2 then
		if not game:GetService("BadgeService"):UserHasBadgeAsync(player.UserId, 1526401216136420) then
			game.ReplicatedStorage.Achievement:FireClient(player, true, "PlsDonate")
			game:GetService("BadgeService"):AwardBadge(player.UserId, 1526401216136420)
		end
	elseif ID == 3 then
		if not game:GetService("BadgeService"):UserHasBadgeAsync(player.UserId, 1532003534552596) then
			game.ReplicatedStorage.Achievement:FireClient(player, true, "HerbOfViridis")
			game:GetService("BadgeService"):AwardBadge(player.UserId, 1532003534552596)
		end
	elseif ID == 4 then
		if not game:GetService("BadgeService"):UserHasBadgeAsync(player.UserId, 413030174934370) then
			game.ReplicatedStorage.Achievement:FireClient(player, true, "RockBottom")
			game:GetService("BadgeService"):AwardBadge(player.UserId, 413030174934370)
		end
	end
end

return module