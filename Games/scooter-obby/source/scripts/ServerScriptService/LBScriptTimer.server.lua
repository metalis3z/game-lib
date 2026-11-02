local DataVer = "189774"

local DataStoreService = game:GetService("DataStoreService")
local Store = DataStoreService:GetOrderedDataStore("leaderboard2")

_G.ForceSet = function(plrName, newTime)
	local num = tonumber(newTime)

	num = num * 1000
	print(num)
	Store:UpdateAsync(game.Players[plrName].UserId,function(oldVal)
		return tonumber(num)
	end)
end


game.ReplicatedStorage.ApplyTime.OnServerEvent:Connect(function(plr, newTime)
	local num = tonumber(newTime)
	local oldData = Store:GetAsync(plr.Name)
	if oldData then
		oldData = oldData / 1000
	else
		oldData = 1000
	end
	
	
	if num < oldData then
		if num <= 6.30 then
			plr:Kick("No Cheating Allowed!")
		else
			num = num * 1000
			print(num)
			Store:UpdateAsync(plr.UserId,function(oldVal)
				return tonumber(num)
			end)
		end
	end
	
end)