local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local humanoid = character:WaitForChild("Humanoid")
		humanoid.BreakJointsOnDeath = false

		humanoid.Died:Connect(function()
			ProximityPromptService.Enabled = false
			task.wait(1)
			if player then
				player:LoadCharacter()
			end
		end)

		task.delay(2, function()
			ProximityPromptService.Enabled = true
		end)
	end)
end)