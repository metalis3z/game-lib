script.Parent.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") then
		local plrhum = hit.Parent
		local p1 = game.Players:GetPlayerFromCharacter(hit.Parent)
		local playername = game.Players:GetPlayerFromCharacter(hit.Parent).Name
		if game.Players:GetPlayerFromCharacter(hit.Parent) then
			if game.Players:GetPlayerFromCharacter(hit.Parent).Character:GetAttribute("CrucifixEnabled", true) then
				game.Players:GetPlayerFromCharacter(hit.Parent).Character:FindFirstChild("Crucifix").Function:Fire(script.Parent.Parent)
			elseif game.Players:GetPlayerFromCharacter(hit.Parent).Character:GetAttribute("CrucifixEnabled", false) then

				local ach = "DontTryToRun"
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
				
				game.Players:GetPlayerFromCharacter(hit.Parent).Character.Humanoid.Health = 0
			else
				
				local ach = "DontTryToRun"
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
				
				game.Players:GetPlayerFromCharacter(hit.Parent).Character.Humanoid.Health = 0
			end
		end
	end
end)