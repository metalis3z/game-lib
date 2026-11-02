local BadgeService = game:GetService("BadgeService")
local Players = game:GetService("Players")

local BADGE_ID = 4390952740763262

local function onPlayerAdded(player)
	local success, hasBadge = pcall(function()
		return BadgeService:UserHasBadgeAsync(player.UserId, BADGE_ID)
	end)

	if not success then
		return
	end

	if not hasBadge then
		local awarded, errorMessage = pcall(function()
			return BadgeService:AwardBadgeAsync(player.UserId, BADGE_ID)
		end)

		if not awarded then
			warn("Badge Error. Error: " .. errorMessage)
		end
	end
end

Players.PlayerAdded:Connect(onPlayerAdded)