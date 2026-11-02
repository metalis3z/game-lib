game:GetService('Players').PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		character:WaitForChild("Humanoid").Died:Connect(function()
			wait(6)
			player.CashCollected.Value = 0
		end)
	end)
end)
