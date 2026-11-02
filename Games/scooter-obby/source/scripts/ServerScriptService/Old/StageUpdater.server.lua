local rs = game:GetService("ReplicatedStorage")
local perStageReward = 100

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local DataStore2 = require(ReplicatedStorage.ModuleScripts.DataStore2)
DataStore2.Combine("DATA", "coins")

rs.RemoteEvents.stageUpdate.OnServerEvent:Connect(function(player, value)
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

script.CoinTake.Event:Connect(function(player, finalAmount)
	local coinStore = DataStore2("coins", player)
	coinStore:Increment(finalAmount)
	player.leaderstats.Coins.Value = coinStore:Get(0)
	rs.RemoteEvents.cashNotification:FireClient(player, finalAmount)
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
