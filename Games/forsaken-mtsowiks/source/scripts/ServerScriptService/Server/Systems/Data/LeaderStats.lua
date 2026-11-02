local module = {}

module.AddStats = function(_, Player : Player)
	task.spawn(function()
		local newStats = script.Template:Clone()
		newStats.Parent = Player
		newStats.Name = "leaderstats"
		
		Player:WaitForChild("PlayerData")
		local plrData : Folder = Player.PlayerData
		plrData:WaitForChild("Stats")
		local statsFolder : Folder = plrData.Stats
		local moneyVal = statsFolder:FindFirstChild("Money", true)
		local kChanceVal = statsFolder:FindFirstChild("KillerChance", true)
		
		newStats.Money.Value = moneyVal.Value
		newStats.KillerChance.Value = kChanceVal.Value
		
		moneyVal:GetPropertyChangedSignal("Value"):Connect(function()
			newStats.Money.Value = moneyVal.Value
		end)
		kChanceVal:GetPropertyChangedSignal("Value"):Connect(function()
			newStats.KillerChance.Value = kChanceVal.Value
		end)
	end)
end

return module