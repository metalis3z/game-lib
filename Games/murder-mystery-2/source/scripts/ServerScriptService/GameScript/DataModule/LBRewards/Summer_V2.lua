local GiveRewards = true
local Data = require(script.Parent.Parent)
return function(DataTable, Player)
	if GiveRewards then
		local Rank = 1
		local Data, Key = game:GetService("DataStoreService"):GetOrderedDataStore("Summer2023NewPlayers"):GetSortedAsync(false, 100, 0):GetCurrentPage()
		for _, Entry in pairs(Data) do
			if Entry.key == Player.Name and not DataTable[Player.Name]["Summer2023"]["GotReward2"] then
				DataTable[Player.Name]["Summer2023"]["GotReward2"] = true
				if Rank == 1 then
					DataTable[Player.Name]["Summer2023"]["Rank2"] = Rank
					return "GoldSummerBlade"
				elseif Rank == 2 then
					DataTable[Player.Name]["Summer2023"]["Rank2"] = Rank
					return "SilverSummerBlade"
				elseif Rank == 3 then
					DataTable[Player.Name]["Summer2023"]["Rank2"] = Rank
					return "BronzeSummerBlade"
				elseif Rank >= 4 then
					DataTable[Player.Name]["Summer2023"]["Rank2"] = Rank
					return "BlueSummerBlade"
				end
			end
			Rank = Rank + 1;
		end;
	end
end
