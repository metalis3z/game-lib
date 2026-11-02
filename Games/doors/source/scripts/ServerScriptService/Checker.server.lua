local Function = game.ReplicatedStorage:FindFirstChild("CheckLimbs", true)

game.ReplicatedStorage.EntityInfo.CheckLimbs.OnServerEvent:Connect(function(pla)
	return "Lol test again BROOO"
end)

local ach = "SurviveSeek"
local p1_player = player

if game.Players[p1_player.Name].InGameStats.Achievements:FindFirstChild(ach) then
	local achive = game.Players[p1_player.Name].InGameStats.Achievements:FindFirstChild(ach)
	local req = require(game.ReplicatedStorage.Achievements)[ach]

	if achive.Value == false then
		achive.Value = true
		if not game:GetService("BadgeService"):UserHasBadgeAsync(p1_player.UserId, req.BadgeId) then
			game.ReplicatedStorage.EntityInfo.AchievementUnlock:FireClient(p1_player, ach)
			game:GetService("BadgeService"):AwardBadge(p1_player.UserId, req.BadgeId)
		end
	end

end