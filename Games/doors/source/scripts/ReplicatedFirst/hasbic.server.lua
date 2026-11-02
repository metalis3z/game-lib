if not game:GetService("BadgeService"):UserHasBadgeAsync(game.Players:GetPlayerFromCharacter(hit.Parent).UserId, 2133145485414729) then
	game.ReplicatedStorage.EntityInfo.AchievementUnlock:FireClient(game.Players:GetPlayerFromCharacter(hit.Parent), "SurviveDupe")
	game:GetService("BadgeService"):AwardBadge(game.Players:GetPlayerFromCharacter(hit.Parent).UserId, 2133145485414729)
end