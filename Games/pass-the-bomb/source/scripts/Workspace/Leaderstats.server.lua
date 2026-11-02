local WinsStore = game:GetService("DataStoreService"):GetOrderedDataStore("Wins")

local Players = game:GetService("Players")

function LoadStats(Player)
	
	repeat wait() until Player.Character
	
	local Stats = Instance.new("BoolValue", Player)
	Stats.Name = "leaderstats"
	
	local Rank = Instance.new("StringValue", Stats)
	Rank.Name = "Rank"
	
	local Wins = Instance.new("IntValue", Stats)
	Wins.Name = "Wins"
	
	Rank.Value = Player:GetRoleInGroup(8025572)
	
	Wins.Value = WinsStore:GetAsync(Player.Name) or 0
	
	Wins.Changed:Connect(function(Value)
		WinsStore:SetAsync(Player.Name, Value)
	end)
	
end

Players.PlayerAdded:Connect(LoadStats)

for i, v in pairs(Players:GetPlayers()) do
	LoadStats(v)
end