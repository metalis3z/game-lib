local DataStore = game:GetService("DataStoreService"):GetOrderedDataStore("Summer2023NewPlayers") -- Gets the Service
local GivenData;
spawn(function()
	while true do
		GivenData = DataStore:GetSortedAsync(false, 100, 0):GetCurrentPage() -- Gets the data from the DataStore
		wait(60)
	end
end)

function game.ReplicatedStorage.Summer2023Events.GetLeaderboard.OnServerInvoke(Player) -- Returns the leaderboard data
	return GivenData
end