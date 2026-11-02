local DataStoreService = game:GetService("DataStoreService")
local DataStore = DataStoreService:GetDataStore("Yxles")

game.Players.PlayerAdded:Connect(function(Player)
	local Leaderstats = Instance.new("Folder")
	Leaderstats.Name = "leaderstats"
	Leaderstats.Parent = Player
	--Leaderstats.Visible = false -- Makes it so that you can't see the "Cash" section in the leaderboard.

	local Currency = Instance.new("IntValue")
	Currency.Parent = Leaderstats
	Currency.Name = "Coins" -- Name of your currency.
	Currency.Value = 500 -- The starting money you get when you first join.

	local Data = DataStore:GetAsync(Player.UserId)
	if Data then
		Currency.Value = Data
	end
end)

-- Autosaving part
game.Players.PlayerRemoving:Connect(function(Player)
	DataStore:SetAsync(Player.UserId, Player.leaderstats.Yxles.Value) -- Change "Coins" to the  name of your currency.
end)