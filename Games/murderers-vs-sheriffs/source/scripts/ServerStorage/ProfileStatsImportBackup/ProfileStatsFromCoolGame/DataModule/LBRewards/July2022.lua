local GiveRewards = true
local Data = require(script.Parent.Parent)
return function(DataTable,Player)
if GiveRewards then
	local Rank = 1
	local Data,Key = game:GetService("DataStoreService"):GetOrderedDataStore("LeaderboardJuly2022"):GetSortedAsync(false, 100, 0):GetCurrentPage()
	for v26, v27 in pairs(Data) do
		if v27.key == Player.Name and not DataTable[Player.Name]["July2022"]["GotReward"] then
			DataTable[Player.Name]["July2022"]["GotReward"] = true
			if Rank == 1 then
				DataTable[Player.Name]["July2022"]["Rank"] = Rank
				return "GoldCandleflame"
			elseif Rank == 2 then
				DataTable[Player.Name]["July2022"]["Rank"] = Rank
				return "BlueCandleflame"
			elseif Rank == 3 then
				DataTable[Player.Name]["July2022"]["Rank"] = Rank
				return "RedCandleflame"
			elseif Rank >= 4 then
				DataTable[Player.Name]["July2022"]["Rank"] = Rank
				return "GreenCandleflame"
			end
		end
		Rank = Rank + 1;
	end;
end
end
