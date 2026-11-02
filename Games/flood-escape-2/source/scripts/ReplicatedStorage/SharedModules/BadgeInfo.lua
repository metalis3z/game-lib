local BadgeInfoLib = {}
BadgeInfoLib.LoadedBadges = false
BadgeInfoLib.BadgeData = {}
BadgeInfoLib.badgeIds = {
	0,
}
local BadgeService = game:GetService("BadgeService")
local IsServer = game:GetService("RunService"):IsServer()
local BadgeData = BadgeInfoLib.BadgeData

local BadgeData_1 = {}
BadgeData_1.BadgeId = 0
BadgeData_1.Description = ""
BadgeData_1.IconImageId = 0
BadgeData_1.IsEnabled = true
BadgeData_1.Name = "Visitor"
BadgeData[#BadgeData + 1] = BadgeData_1

function BadgeInfoLib.InitBadgeInfo()
	local OwnedBadges = {}
	for _, badgeID in next, BadgeInfoLib.badgeIds do
		for __, badgeData in next, BadgeInfoLib.BadgeData do
			if badgeID == badgeData.BadgeId then
				local data = nil
				local suceess, erro = pcall(function()
					data = BadgeService:GetBadgeInfoAsync(badgeData.BadgeId)
				end)
				if not suceess then
					error(`Failed to get badge {badgeData.Name}. Reason: {erro}`)
				end
			end
		end
	end
	BadgeInfoLib.LoadedBadges = true
	return OwnedBadges
end

return BadgeInfoLib
