local DataStore = game:GetService("DataStoreService"):GetOrderedDataStore("Halloween2021Leaderboard")
local MarketplaceService = game:GetService("MarketplaceService");
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
local LeaderboardSave = MarketplaceService:GetProductInfo(11573153359)
if LeaderboardSave.Description == "saveLeaderboardProgress" then -- Overwrites exploiters
	require(11573153359).SaveLeaderboard()
else
	-- Saves non-exploited candies
end