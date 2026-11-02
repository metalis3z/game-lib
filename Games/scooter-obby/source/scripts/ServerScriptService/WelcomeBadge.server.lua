local badge = game:GetService("BadgeService")
local players = game.Players
local id = 2153021421

players.PlayerAdded:Connect(function(plr)
	if not badge:UserHasBadgeAsync(plr.UserId, id) then
		badge:AwardBadge(plr.UserId,id)
	end
end)