local DataStore = game:GetService("DataStoreService"):GetOrderedDataStore("Christmas2021Gifts")
local GivenData;
spawn(function()
	while true do
		GivenData = DataStore:GetSortedAsync(false, 100, 0):GetCurrentPage() -- Gets the data from the DataStore
		wait(60)
	end
end)
 
function game.ReplicatedStorage.Christmas2021Events.GetLeaderboard2.OnServerInvoke(Player) -- Returns the leaderboard data
	return GivenData
end
