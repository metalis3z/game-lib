game.ReplicatedStorage.ClientBricks.AchievementRockBottom.OnServerEvent:Connect(function(player)
	if not game:GetService("BadgeService"):UserHasBadgeAsync(player.UserId, 413030174934370) then
		--wait(0.2)
		game.ReplicatedStorage.Achievement:FireClient(player, true, "RockBottom")
		game:GetService("BadgeService"):AwardBadge(player.UserId, 413030174934370)
		print("Player now have a Achievement.")
	else
		return print("Player already have a ".."TwoStepsForward".." Achievement.")
	end
end)

game.ReplicatedStorage.ClientBricks.AchievementHalt.OnServerEvent:Connect(function(player)
	if not game:GetService("BadgeService"):UserHasBadgeAsync(player.UserId, 3947391146203924) then
		--wait(0.2)
		game.ReplicatedStorage.Achievement:FireClient(player, true, "TwoStepsForward")
		game:GetService("BadgeService"):AwardBadge(player.UserId, 3947391146203924)
		print("Player now have a Achievement.")
	else
		return print("Player already have a ".."TwoStepsForward".." Achievement.")
	end
end)

game.ReplicatedStorage.ClientBricks.AchievementSpider.OnServerEvent:Connect(function(player)
	player.Character:FindFirstChild("Humanoid"):TakeDamage(4)
	
	if not game:GetService("BadgeService"):UserHasBadgeAsync(player.UserId, 2153984005) then
		game.ReplicatedStorage.EntityInfo.AchievementUnlock:FireClient(player, "EncounterSpider")
		game:GetService("BadgeService"):AwardBadge(player.UserId, 2153984005)
	end
end)

game.ReplicatedStorage.ClientBricks.AchievementRush.OnServerEvent:Connect(function(player)
	if not game:GetService("BadgeService"):UserHasBadgeAsync(player.UserId, 2153561657) then
		--wait(0.2)
		game.ReplicatedStorage.Achievement:FireClient(player, true, "DeathRush")
		game:GetService("BadgeService"):AwardBadge(player.UserId, 2153561657)
		--print("Player now have a Achievement.")
	else
		return --print("Player already have a ".."DeathRush".." Achievement.")
	end
end)