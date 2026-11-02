-- Created and Supported by LSPLASH

game:GetService("ReplicatedStorage"):FindFirstChild("EntityInfo"):WaitForChild("RushTrigger").OnServerEvent:Connect(function(p1)
	
	if not game:GetService("BadgeService"):UserHasBadgeAsync(p1.UserId, 2153561657) then
		game.ReplicatedStorage.EntityInfo.AchievementUnlock:FireClient(p1, "DeathByRush")
		game:GetService("BadgeService"):AwardBadge(p1.UserId, 2153561657)
	end
	
	if p1 then
		if p1:FindFirstChild("Stats") then
			if p1:FindFirstChild("Stats"):WaitForChild("Death") then
				p1:FindFirstChild("Stats"):WaitForChild("Death").Value = "Rush"
			end
		end
	end
	
	if p1 then
		if p1.PlayerStats then
			if p1.PlayerStats.RushDeaths then
				if p1.PlayerStats.RushDeaths.Value == 0 then
					p1.PlayerStats.RushDeaths.Value = 1
					game.ReplicatedStorage.EntityInfo.DeathHint:FireClient(p1, {"You died to Rush...", "Pay attention to any cues that may hint at its arrival."}, "Blue")
					game.ReplicatedStorage.EntityInfo.Jumpscare:FireClient(p1, "Rush")
				elseif p1.PlayerStats.RushDeaths.Value == 1 then
					p1.PlayerStats.RushDeaths.Value = 2
					game.ReplicatedStorage.EntityInfo.DeathHint:FireClient(p1, {"You died to Rush again...", "Pay attention to the lights. They are related to its arrival."}, "Blue")
					game.ReplicatedStorage.EntityInfo.Jumpscare:FireClient(p1, "Rush")
				elseif p1.PlayerStats.RushDeaths.Value == 2 then
					p1.PlayerStats.RushDeaths.Value = 0
					game.ReplicatedStorage.EntityInfo.DeathHint:FireClient(p1, {"It seems you are having trouble with Rush...", "The lights will always flicker when it is near. Whenever this happens, find a hiding spot!"}, "Blue")
					game.ReplicatedStorage.EntityInfo.Jumpscare:FireClient(p1, "Rush")
				end
			end
		end
	end
end)