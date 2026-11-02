local stat = "Stage" 
local startamount = 0 


local DataStore = game:GetService("DataStoreService")
local ds = DataStore:GetDataStore("LeaderStatSave")

game.Players.PlayerAdded:connect(function(player)
	local leader = Instance.new("Folder",player)
	leader.Name = "leaderstats"
	local Cash = Instance.new("IntValue",leader)
	Cash.Name = stat
	Cash.Value = ds:GetAsync(player.UserId) or startamount
	local rs = game:GetService("ReplicatedStorage")
	repeat
		wait()
	until player.Character ~= nil
	if workspace:FindFirstChild(Cash.Value) then
		player.Character:MoveTo(workspace[Cash.Value].Checkpoint.Part.Position + Vector3.new(0,2,0))
	end
	ds:SetAsync(player.UserId, Cash.Value)
	Cash.Changed:connect(function()
		ds:SetAsync(player.UserId, Cash.Value)
	end)
	wait(3)
	rs.RemoteEvents.clientTP:FireClient(player)
end)

game.Players.PlayerRemoving:connect(function(player)
	ds:SetAsync(player.UserId, player.leaderstats.Stage.Value) 
end)
