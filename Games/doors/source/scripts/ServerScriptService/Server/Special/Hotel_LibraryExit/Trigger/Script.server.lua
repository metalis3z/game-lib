script.Parent.Touched:Connect(function(part)
	local player = game.Players:GetPlayerFromCharacter(part.Parent)
	
	game.Workspace.GameSettings.Server.RunRush.Value = true
	
	local module = require(game.ReplicatedStorage.ClientModules.Module_AdminPanel)

	if module:haveAccess(player) and player.PlayerStats.AdminPanel.Value == true then
		return
	end
	
	local ach = "SurviveFigureLibrary"
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
end)