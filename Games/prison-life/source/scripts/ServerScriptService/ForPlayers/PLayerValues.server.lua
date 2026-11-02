game.Players.PlayerAdded:Connect(function(player)
	local sprint = Instance.new("BoolValue", player)
	sprint.Name = "sprint"
	sprint.Value = true
	
	local valuearrest = Instance.new("BoolValue")
	valuearrest.Parent = player
	valuearrest.Name = "valueArrest"
	valuearrest.Value = false
	
	local punch = Instance.new("BoolValue")
	punch.Parent = player
	punch.Name = "IsPunching"
	punch.Value = false
	
	local crawl = Instance.new("BoolValue", player)
	crawl.Name = "crawl"
	crawl.Value = false
	player.CharacterAdded:Connect(function(char)
		char:WaitForChild("Humanoid").Died:Connect(function()
			sprint.Value = true
			valuearrest.Value = false
		end)
	end)
end)
