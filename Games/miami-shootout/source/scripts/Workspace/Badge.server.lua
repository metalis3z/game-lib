local BadgeID = 2153133259
local TimeNo = 0.1

game.Players.PlayerAdded:connect(function(Player)
	task.wait(TimeNo)
	local BadgeService = game:GetService("BadgeService")
	BadgeService:AwardBadge(Player.userId,BadgeID)
end)
