local rs = game:GetService("ReplicatedStorage")
local perStageReward = 100

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local DataStore2 = require(ReplicatedStorage.ModuleScripts.DataStore2)
DataStore2.Combine("DATA", "coins")

-- sanity checks
local lastStageTimes = {}
local hasSameTime = {}
local lastTimeBetween = {}

rs.RemoteEvents.stageUpdate.OnServerEvent:Connect(function(player, value)
	local coinStore = DataStore2("coins", player)
	
	if not lastStageTimes[player.Name] then
		lastStageTimes[player.Name] = 0
	end
	if os.clock() - lastStageTimes[player.Name] <= .15 then
		if player:GetAttribute("Safe") == true then
			return
		end
		player:Kick("ruh oh (1)")
	end
	if player:GetAttribute("Safe") == true then
		player:SetAttribute("Safe", false)
	end
	if not hasSameTime[player.Name] then
		hasSameTime[player.Name] = 0
	end
	
	if not lastTimeBetween[player.Name] then
		lastTimeBetween[player.Name] = 0
	end
	
	if os.clock() - lastStageTimes[player.Name] == lastTimeBetween[player.Name] then
		hasSameTime[player.Name] += 1
	else
		hasSameTime[player.Name] = 0
	end
	
	if hasSameTime[player.Name] == 3 then
		player:Kick("ruh oh (3)")
	end
	
	lastStageTimes[player.Name] = os.clock()
	lastTimeBetween[player.Name] = os.clock() - lastStageTimes[player.Name]
	
	if (player.leaderstats.Stage.Value - value) <= -5 then
		player:Kick("ruh oh (4)")
	end
	
	player.leaderstats.Stage.Value = value
	if player.hidden.HighestStage.Value < value then
		player.hidden.HighestStage.Value = value
		local multiplier = 1
		if player:GetAttribute("isVIP") then
			multiplier += .25
		end
		if player:GetAttribute("isMVP") then
			multiplier += .5
		end
		local finalAmount = perStageReward * multiplier
		if player:GetAttribute("hasDoubleCoins") then
			finalAmount *= 2
		end
		rs.RemoteEvents.cashNotification:FireClient(player, finalAmount)
		coinStore:Increment(finalAmount)
		player.leaderstats.Coins.Value = coinStore:Get(0)
	end
end)

script.CoinTake.Event:Connect(function(player, finalAmount)
	local coinStore = DataStore2("coins", player)
	coinStore:Increment(finalAmount)
	player.leaderstats.Coins.Value = coinStore:Get(0)
end)

rs.RemoteEvents.stageUpdateServer.Event:Connect(function(player, value)
	local coinStore = DataStore2("coins", player)
	player.leaderstats.Stage.Value = value
	if player.hidden.HighestStage.Value < value then
		player.hidden.HighestStage.Value = value
		local multiplier = 1
		if player:GetAttribute("isVIP") then
			multiplier += .25
		end
		if player:GetAttribute("isMVP") then
			multiplier += .5
		end
		local finalAmount = perStageReward * multiplier
		if player:GetAttribute("hasDoubleCoins") then
			finalAmount *= 2
		end
		rs.RemoteEvents.cashNotification:FireClient(player, finalAmount)
		coinStore:Increment(finalAmount)
		player.leaderstats.Coins.Value = coinStore:Get(0)
	end
end)
