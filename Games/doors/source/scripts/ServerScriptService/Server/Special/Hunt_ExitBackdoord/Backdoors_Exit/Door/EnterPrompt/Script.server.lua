script.Parent.Triggered:Connect(function(f)
	local module = require(game.ReplicatedStorage.ClientModules.Module_AdminPanel)
	
	game.ReplicatedStorage.EntityInfo.EnterSecret:FireClient(f)
	
	if game.MarketplaceService:PlayerOwnsAsset(f, module.gamepass_id) and f.PlayerStats.AdminPanel.Value == true then
		return
	end
	
	if not game:GetService("BadgeService"):UserHasBadgeAsync(f.UserId, 4118658648353416) then
		game.ReplicatedStorage.EntityInfo.AchievementUnlock:FireClient(f, "Hunt")
		game:GetService("BadgeService"):AwardBadge(f.UserId, 4118658648353416)
	end
end)