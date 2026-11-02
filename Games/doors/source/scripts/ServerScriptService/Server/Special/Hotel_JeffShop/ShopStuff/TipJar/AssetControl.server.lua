local ProximityPrompt = script.Parent.DonatePrompt
local clicked = false
local price = 5
local fill = 0

ProximityPrompt.Triggered:Connect(function(player)
	if clicked == false then
		if player.Stats.Gold.Value >= price then
			player.Stats.Gold.Value = player.Stats.Gold.Value - price
			clicked = true
			fill += 0.5
			player.Stats.DonateState.Value += 0.5
			script.Parent.Tag.SoundDecrease:Play()
			wait(script.Parent.Tag.SoundDecrease.TimeLength)
			clicked = false 
		else
			game.ReplicatedStorage.EntityInfo:WaitForChild("FlashSpecify"):FireClient(player, "Cannot")
		end
	end
end)

local doe = false

while true do
	wait(0.1)
	if fill == 0 then
		price = 10
	elseif fill == 1 then
		price = 11
		script.Parent.FillLevel["1"].Transparency = 0
	elseif fill == 2 then
		price = 12
		script.Parent.FillLevel["2"].Transparency = 0
	elseif fill == 3 then
		price = 13
		script.Parent.FillLevel["3"].Transparency = 0
	elseif fill == 4 then
		price = 14
		script.Parent.FillLevel["4"].Transparency = 0
	elseif fill == 5 then
		price = 15
		script.Parent.FillLevel["5"].Transparency = 0
		if doe == false then
			doe = true
			for i, v in pairs(game.Players:GetPlayers()) do
				if v.Character then 
					local ach = "JeffTipFull"
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
		end
		ProximityPrompt.Enabled = false
	end
end