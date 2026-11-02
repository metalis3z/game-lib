local d = false

script.Parent.Touched:Connect(function(part)
	if d == false then
		d = true
		
		local player = game.Players:GetPlayerFromCharacter(part.Parent)
		
		local module = require(game.ReplicatedStorage.ClientModules.Module_AdminPanel)

		if game.MarketplaceService:PlayerOwnsAsset(player, module.gamepass_id) and player.PlayerStats.AdminPanel.Value == true then
			return
		end
		
		if not game:GetService("BadgeService"):UserHasBadgeAsync(player.UserId, 2146093931) then
			game.ReplicatedStorage.EntityInfo.AchievementUnlock:FireClient(player, "SurviveSeek")
			game:GetService("BadgeService"):AwardBadge(player.UserId, 2146093931)
		end
	end
end)