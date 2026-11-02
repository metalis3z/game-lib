local function onPlayerJoin(Player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "stored"
	leaderstats.Parent = Player
	
	local cash = Instance.new("IntValue")
	cash.Name = "Money"
	cash.Value = 150000
	cash.Parent = leaderstats
	
	local Bank = Instance.new("IntValue")
	Bank.Name = "Bank"
	Bank.Value = 150000
	Bank.Parent = leaderstats
end

game.Players.PlayerAdded:Connect(onPlayerJoin) 