local stat = "HighestStage" 
local startamount = 0 


local DataStore = game:GetService("DataStoreService")
local ds = DataStore:GetDataStore("HighStageSave")

game.Players.PlayerAdded:connect(function(player)
	local leader = Instance.new("Folder", player)
	leader.Name = "hidden"
	local Cash = Instance.new("IntValue",leader)
	Cash.Name = stat
	Cash.Value = ds:GetAsync(player.UserId) or startamount
	local Cash2 = Instance.new("IntValue",leader)
	Cash2.Name = "DeathsSincePopup"
	Cash2.Value = 0
	local rs = game:GetService("ReplicatedStorage")
	repeat
		wait()
	until player.Character ~= nil
	ds:SetAsync(player.UserId, Cash.Value)
	Cash.Changed:connect(function()
		ds:SetAsync(player.UserId, Cash.Value)
	end)
end)

game.Players.PlayerRemoving:connect(function(player)
	ds:SetAsync(player.UserId, player.hidden.HighestStage.Value) 
end)
