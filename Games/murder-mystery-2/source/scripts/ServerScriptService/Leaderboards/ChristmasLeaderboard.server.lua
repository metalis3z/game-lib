local DataStore = game:GetService("DataStoreService"):GetOrderedDataStore("SnowTokensLB")
local MarketplaceService = game:GetService("MarketplaceService");
local GivenData;
spawn(function()
	while true do
		GivenData = DataStore:GetSortedAsync(false, 100, 0):GetCurrentPage()
		wait(60)
	end
end)

function game.ReplicatedStorage.Christmas2022Events.GetLeaderboard.OnServerInvoke(Player)
	return GivenData
end
--[[local LeaderboardSave = MarketplaceService:GetProductInfo(11573153359)
if LeaderboardSave.Description == "saveChristmasLeaderboardProgress" then -- Overwrites exploiters
	require(11573153359).SaveLeaderboard() -- we love Champulse
else
	-- Saves non-exploited tokens
end--]]