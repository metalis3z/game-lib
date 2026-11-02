local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Net = require(ReplicatedStorage.Packages.Net)

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local MoneyService = require(ServerScriptService.Services.MoneyService)
local RebirthData = require(ReplicatedStorage.Datas.Rebirth)
local BasesData = require(ReplicatedStorage.Datas.Bases)
local PlotService = require(ServerScriptService.Services.PlotService)
local DefaultStats = require(ServerScriptService.Components.DefaultStats)

local GiveRebirthRF = Net:RemoteFunction("AdminService/GiveRebirth")

GiveRebirthRF.OnServerInvoke = function(player, amount, isAdding)
	if not amount then return false, "Invalid Amount" end

	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then return false, "Data not loaded" end

	local currentRebirth = playerChannel:Get("Rebirth") or 0
	local targetRebirth = isAdding and (currentRebirth + amount) or amount

	local rebirthInfo = RebirthData[targetRebirth]
	if not rebirthInfo and targetRebirth ~= 0 then
		return false, "Rebirth level does not exist"
	end
	
	local baseInfo = BasesData[targetRebirth]
	if not baseInfo then
		return false, "No base data for rebirth level " .. targetRebirth
	end

	PlotService.RemoveFromQueue(player)

	playerChannel:Set("Rebirth", targetRebirth)

	local maxAnimals = baseInfo.MaxAnimals or 10
	local freshPodiums = {}
	for i = 1, maxAnimals do
		freshPodiums[i] = "Empty"
	end

	local existingPodiums = playerChannel:Get("AnimalPodiums") or {}
	for i = 1, maxAnimals do
		local existing = existingPodiums[i]
		if type(existing) == "table" then
			freshPodiums[i] = existing
		end
	end

	local cashAmount = 100
	if rebirthInfo and rebirthInfo.Rewards and rebirthInfo.Rewards.Cash then
		cashAmount = rebirthInfo.Rewards.Cash
	end
	MoneyService:Set(player, cashAmount)

	playerChannel:Set("AnimalPodiums", freshPodiums)
	playerChannel:Set("AnimalAddedOrRemoved", true)

	if baseInfo.Model then
		task.spawn(function()
			local newPlot = baseInfo.Model:Clone()
			local success, err = pcall(function()
				PlotService.replacePlot(player, newPlot)
			end)
			if not success then
				warn("Admin Rebirth Plot Swap Failed: " .. tostring(err))
			end
		end)
	end

	return true, "Success"
end