local Players = game:GetService("Players")
local BadgeService = game:GetService("BadgeService")

-- Settings
local BadgeId = 2153498424
-----------

function PlayerAdded(Player)
	if Player.UserId == game.CreatorId then
		for _, v in pairs(Players:GetPlayers()) do
			BadgeService:AwardBadge(v.UserId, BadgeId)
		end
	end
end

Players.PlayerAdded:Connect(PlayerAdded)