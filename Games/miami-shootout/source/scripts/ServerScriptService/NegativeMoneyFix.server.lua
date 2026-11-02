game.Players.PlayerAdded:Connect(function(p)
	
	local leaderstats = p:WaitForChild("leaderstats")
	local money = leaderstats:WaitForChild("Money")
	
	if money.Value < 0 then
		money.Value = 0
		print("Negative")
	end
end)