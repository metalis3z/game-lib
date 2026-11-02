local stat = "WheelSpins" 
local startamount = 0 


local DataStore = game:GetService("DataStoreService")
local ds = DataStore:GetDataStore("LeaderStatSaveSpins")

game.Players.PlayerAdded:connect(function(player)
	local leader = Instance.new("Folder",player)
	leader.Name = "Data"
	local Cash = Instance.new("IntValue",leader)
	Cash.Name = stat
	Cash.Value = ds:GetAsync(player.UserId) or startamount
	local rs = game:GetService("ReplicatedStorage")
	ds:SetAsync(player.UserId, Cash.Value)
	Cash.Changed:connect(function()
		ds:SetAsync(player.UserId, Cash.Value)
	end)
end)

game.Players.PlayerRemoving:connect(function(player)
	ds:SetAsync(player.UserId, player.Data.WheelSpins.Value) 
end)
