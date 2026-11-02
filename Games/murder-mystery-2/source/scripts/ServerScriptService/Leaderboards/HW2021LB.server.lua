local DataStore = game:GetService("DataStoreService"):GetOrderedDataStore("Halloween2021LB1")
local GivenData;
spawn(function()
	while true do
		GivenData = DataStore:GetSortedAsync(false, 100, 0):GetCurrentPage()
		wait(60)
	end
end)

function game.ReplicatedStorage.Halloween2021Events.GetLeaderboard.OnServerInvoke(Player)
	return GivenData
end