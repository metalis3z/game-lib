script.Parent.Triggered:Connect(function()
	for i, v in pairs(game.Players:GetPlayers()) do
		
		if v then
			local module = require(game.ReplicatedStorage.ClientModules.Module_AdminPanel)

			game.ReplicatedStorage.EntityInfo.EnterSecret:FireClient(v)

			local ach = "EscapeBackdoor"
			local p1_player = v

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
		end
	end
end)