local RebirthService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local PlotService = require(ServerScriptService.Services.PlotService)
local MoneyService = require(ServerScriptService.Services.MoneyService)
local NotificationService = require(ServerScriptService.Services.NotificationService)

local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local RebirthData = require(ReplicatedStorage.Datas.Rebirth)
local BasesData = require(ReplicatedStorage.Datas.Bases)
local SharedGame = require(ReplicatedStorage.Shared.Game)

local DefaultStats = require(ServerScriptService.Components.DefaultStats)

local RequestRebirth = Net:RemoteFunction("Rebirth/RequestRebirth")

local lastRebirthTime: {[Player]: number} = {}

RequestRebirth.OnServerInvoke = function(player: Player): (boolean, string)
	local currentTime = os.time()

	if lastRebirthTime[player] and (currentTime - lastRebirthTime[player] < 0.5) then
		return false, "Hold on! You need to wait a bit before doing that again."
	end

	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then
		return false, "Please wait, Your data is still loading."
	end

	local currentValue = playerChannel:Get("Rebirth")
	local nextRebirth = RebirthData[currentValue + 1]

	if not nextRebirth then
		return false, "You are already at the highest rebirth level."
	end

	local function failWithCooldown(message: string)
		lastRebirthTime[player] = currentTime
		return false, message
	end

	if nextRebirth.Requirements and nextRebirth.Requirements.Cash then
		local playerCoins = playerChannel:Get("Coins") or 0
		if playerCoins < nextRebirth.Requirements.Cash then
			return failWithCooldown("You need to meet all the requirements before you can rebirth!")
		end
	end

	if nextRebirth.Requirements and nextRebirth.Requirements.RequiredCharacters then
		local currentAnimalPodiums = playerChannel:Get("AnimalPodiums") or {}
		local playerAnimals: {[string]: number} = {}

		for _, animalData in pairs(currentAnimalPodiums) do
			if typeof(animalData) == "table" and animalData.Index then
				local animalName = animalData.Index
				playerAnimals[animalName] = (playerAnimals[animalName] or 0) + 1
			end
		end

		for _, requiredCharacter in ipairs(nextRebirth.Requirements.RequiredCharacters) do
			if not playerAnimals[requiredCharacter] or playerAnimals[requiredCharacter] < 1 then
				return failWithCooldown("You need to meet all the requirements before you can rebirth!")
			end
		end
	end

	playerChannel:Set("AnimalPodiums", DefaultStats.AnimalPodiums)

	if nextRebirth.Requirements and nextRebirth.Rewards.Cash then
		MoneyService:Set(player, nextRebirth.Rewards.Cash)
	end

	if nextRebirth.Rewards.AnimalSlot then
		local currentAnimalPodiums = playerChannel:Get("AnimalPodiums") or {}
		local currentSlots = 0
		for i = 1, 100 do
			if currentAnimalPodiums[i] ~= nil then
				currentSlots = i
			else
				break
			end
		end
		for i = 1, nextRebirth.Rewards.AnimalSlot do
			currentAnimalPodiums[currentSlots + i] = "Empty"
		end
		playerChannel:Set("AnimalPodiums", currentAnimalPodiums)
	end

	local currentBase = BasesData[nextRebirth.RebirthNumber].Model
	local newPlotClone = currentBase:Clone()
	if newPlotClone.PrimaryPart then
		newPlotClone.PrimaryPart.Anchored = true
	end

	playerChannel:Set("Rebirth", nextRebirth.RebirthNumber)
	MoneyService:Set(player, nextRebirth.Rewards.Cash)
	PlotService.replacePlot(player, newPlotClone)
	lastRebirthTime[player] = currentTime
	return true, "You successfully rebirthed!"
end

Players.PlayerRemoving:Connect(function(player: Player)
	lastRebirthTime[player] = nil
end)

return RebirthService
