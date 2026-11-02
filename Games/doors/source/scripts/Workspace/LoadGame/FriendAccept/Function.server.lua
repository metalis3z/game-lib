-- Created and Supported by LSPLASH

game:GetService("ReplicatedStorage"):FindFirstChild("EntityInfo"):WaitForChild("FriendAccept").OnServerEvent:Connect(function(p1)
	
	local module = require(game.ReplicatedStorage.ClientModules.Module_AdminPanel)

	if game.MarketplaceService:PlayerOwnsAsset(p1, module.gamepass_id) and p1.PlayerStats.AdminPanel.Value == true then
		return
	end
	
	local ach = "PlayFriend"
	local p1_player = p1

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
	
end)