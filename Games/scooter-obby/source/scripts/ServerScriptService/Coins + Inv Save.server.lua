local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local DataStore2 = require(ReplicatedStorage.ModuleScripts.DataStore2)
local LeaderboardDataStore = game:GetService("DataStoreService"):GetOrderedDataStore("leaderboard")
local LeaderboardDataStore2 = game:GetService("DataStoreService"):GetOrderedDataStore("leaderboard2")
local ih =require(ServerScriptService.InventoryHandler)
DataStore2.Combine("DATA", "coins")
DataStore2.Combine("DATA", "wins")

Players.PlayerAdded:Connect(function(player)
	local inventory = ih.GetInventory(player)
	local leaderstats = player:WaitForChild("leaderstats")
	local coinsStat = Instance.new("NumberValue", leaderstats)
	coinsStat.Name = "Coins"
	
	local TimeStat = Instance.new("NumberValue", player.hidden)
	TimeStat.Name = "Time"
	TimeStat.Value = game:GetService('DataStoreService'):GetDataStore('TimeSave'):GetAsync(player.UserId)
	
	local coinStore = DataStore2("coins", player)

	coinsStat.Value = coinStore:Get(0)

	coinStore:OnUpdate()
	
	local winsStore = DataStore2("wins", player)
	local wins = winsStore:Get(0)
	player:WaitForChild("leaderstats")
	local winsStat = Instance.new("NumberValue", player.leaderstats)
	winsStat.Name = "Wins"
	winsStat.Value = wins
	
	local totalWinsStore = DataStore2("totalWins", player)
	local totalWins = Instance.new("IntValue",player)
	totalWins.Name = "TotalWins"
	totalWins.Value = totalWinsStore:Get(0)
	
	local BestTimeStore = DataStore2("bestTime", player)
	local bestTime = Instance.new("IntValue",player)
	bestTime.Name = "bestTime"
	bestTime.Value = BestTimeStore:Get(10^30)
	
	if player.UserId>0 then--Prevent errors
		local Total = totalWins.Value
		if Total then
			pcall(function()
				LeaderboardDataStore:UpdateAsync(player.UserId,function(oldVal)
					return tonumber(Total)
				end)
			end)
		end
	end

	if player.UserId>0 then--Prevent errors
		local Total = bestTime.Value
		if Total then
			pcall(function()
				LeaderboardDataStore2:UpdateAsync(player.UserId,function(oldVal)
					return tonumber(Total)
				end)
			end)
		end
	end

	local function callRemote(value)
		winsStat.Value = value
	end

	winsStore:OnUpdate(callRemote)
end)

script.GiveWin.Event:Connect(function(player)
	local winsStore = DataStore2("wins", player)
	local totalWinsStore = DataStore2("totalWins", player)
	winsStore:Increment(1)
	totalWinsStore:Increment(1)
end)

script.DeductWins.Event:Connect(function(player, amount)
	local winsStore = DataStore2("wins", player)
	winsStore:Increment(amount)
end)
