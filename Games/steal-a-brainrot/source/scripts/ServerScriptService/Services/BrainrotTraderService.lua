local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Workspace = game:GetService("Workspace")
local Net = require(ReplicatedStorage.Packages.Net)
local BrainrotTraderData = require(ServerStorage.Modules.BrainrotTraderData)
local AnimalData = require(ReplicatedStorage.Datas.Animals)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local PlotService = require(ServerScriptService.Services.PlotService)
local StealService = require(ServerScriptService.Services.StealService)

local BrainrotTraderService = {}

local RemoteAnimation = Net:RemoteEvent("BrainrotTraderService/Animation")
local RemoteUpdate = Net:RemoteEvent("BrainrotTraderService/Update")
local RemoteReturn = Net:RemoteEvent("BrainrotTraderService/Return")
local RemoteTrade = Net:RemoteEvent("BrainrotTraderService/Trade")
local RemoteDelivery = Net:RemoteFunction("BrainrotTraderService/Delivery")
local RemoteFetch = Net:RemoteFunction("BrainrotTraderService/Fetch")

local CurrentTrader = {}
local RefreshTime = 0
local PlayerPodiums = {}

local function generateTrader()
	local allAnimals = {}

	for _, group in ipairs(BrainrotTraderData.Groups) do
		for _, brainrotData in ipairs(group.Brainrots) do
			local animalName = brainrotData.Name

			if AnimalData[animalName] then
				table.insert(allAnimals, animalName)
			else
				warn(animalName, "not found in AnimalData")
			end
		end
	end

	if #allAnimals == 0 then
		warn("No valid animals found for trader")
		return
	end

	CurrentTrader = {
		Refresh = os.clock() + 7200,
		List = {}
	}

	for i = 1, 6 do
		local slotId = tostring(i)
		local selectedAnimal = allAnimals[math.random(1, #allAnimals)]

		local recipeCount = math.random(2, 4)
		local recipe = {}

		for j = 1, recipeCount do
			table.insert(recipe, allAnimals[math.random(1, #allAnimals)])
		end

		CurrentTrader.List[slotId] = {
			Name = selectedAnimal,
			Template = "Normal",
			Recipe = recipe
		}
	end
end

generateTrader()
RefreshTime = CurrentTrader.Refresh

RemoteFetch.OnServerInvoke = function(player)
	return CurrentTrader
end

RemoteUpdate.OnServerEvent:Connect(function(player, newData)
	if player and newData and newData.List then
		CurrentTrader = newData
		RefreshTime = newData.Refresh
		for _, plr in Players:GetPlayers() do
			RemoteUpdate:FireClient(plr, CurrentTrader)
		end
	end
end)

RemoteTrade.OnServerEvent:Connect(function(player, slotId, animalName)
	if player and slotId and animalName and CurrentTrader.List[slotId] then
		local traderSlot = CurrentTrader.List[slotId]
		if traderSlot.Name == animalName then
			local playerData = Synchronizer:Get(player)
			if not playerData then return end

			local podiums = playerData:Get("AnimalPodiums") or {}
			local availableBrainrots = {}

			for podiumIndex, podiumData in pairs(podiums) do
				if type(podiumData) == "table" and podiumData.Machine and podiumData.Machine.Type == "BrainrotTrader" and not podiumData.Machine.Active then
					local animalIndex = podiumData.Index
					availableBrainrots[animalIndex] = (availableBrainrots[animalIndex] or 0) + 1
				end
			end

			local hasAllRequired = true
			local requiredCounts = {}

			for _, requiredAnimal in ipairs(traderSlot.Recipe) do
				requiredCounts[requiredAnimal] = (requiredCounts[requiredAnimal] or 0) + 1
			end

			for requiredAnimal, requiredCount in pairs(requiredCounts) do
				local availableCount = availableBrainrots[requiredAnimal] or 0
				if availableCount < requiredCount then
					hasAllRequired = false
					break
				end
			end

			if hasAllRequired then
				local animalsToConsume = {}
				for requiredAnimal, requiredCount in pairs(requiredCounts) do
					for i = 1, requiredCount do
						table.insert(animalsToConsume, requiredAnimal)
					end
				end

				for podiumIndex, podiumData in pairs(podiums) do
					if type(podiumData) == "table" and podiumData.Machine and podiumData.Machine.Type == "BrainrotTrader" and not podiumData.Machine.Active then
						local animalIndex = podiumData.Index
						local consumeIndex = table.find(animalsToConsume, animalIndex)
						if consumeIndex then
							podiumData.Machine.Active = true
							podiums[podiumIndex] = podiumData
							table.remove(animalsToConsume, consumeIndex)
							if #animalsToConsume == 0 then
								break
							end
						end
					end
				end

				playerData:Set("AnimalPodiums", podiums)
				playerData:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())

				print(player.Name .. " traded for " .. animalName .. " in slot " .. slotId)

				RemoteAnimation:FireClient(player, animalName)

				NotificationService.Notify(player, string.format("You traded for <font color='#00ff00'>%s</font>!", animalName))

				task.spawn(function()
					task.wait(2)
					local animalData = AnimalData[animalName]
					if animalData then
						local brainrotTrader = Workspace:FindFirstChild("BrainrotTrader")
						if brainrotTrader then
							local spawnCFrame = brainrotTrader:FindFirstChild("SpawnCFrame")
							if spawnCFrame then
								local plot = PlotService.getPlot(player)
								if plot then
									local endCFrame = plot.AnimalTarget and plot.AnimalTarget.CFrame or Workspace.Road.Start.CFrame
									AnimalService.spawnAnimalCustom(animalData, nil, nil, nil, {
										Start = spawnCFrame,
										End = endCFrame,
										Owner = player
									})
								end
							end
						end
					end
				end)
			else
				NotificationService.Error(player, "You don't have the required brainrots for this trade!")
			end
		end
	end
end)

RemoteReturn.OnServerEvent:Connect(function(player, podiumId)
	if player and podiumId then
		print(player.Name .. " returned podium " .. podiumId)
		if PlayerPodiums[player.UserId] then
			PlayerPodiums[player.UserId][podiumId] = nil
		end

		local playerData = Synchronizer:Get(player)
		if playerData then
			local podiums = playerData:Get("AnimalPodiums") or {}
			if podiums[podiumId] and podiums[podiumId].Machine and podiums[podiumId].Machine.Type == "BrainrotTrader" then
				podiums[podiumId].Machine = nil
				podiums[podiumId] = podiums[podiumId]
				playerData:Set("AnimalPodiums", podiums)
				playerData:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
			end
		end
	end
end)

RemoteDelivery.OnServerInvoke = function(player, hitbox)
	local playerData = Synchronizer:Get(player)
	if not playerData then return false end

	local stealData = StealService:GetStealData(player)
	if not stealData then return false end

	local stolenAnimalData = stealData.StolenAnimalData
	if not stolenAnimalData then return false end

	local animalName = stolenAnimalData.Index or "Noobini Pizzanini"

	local podiums = playerData:Get("AnimalPodiums") or {}
	local availableSlot = nil

	for i = 1, 50 do
		if not podiums[i] then
			availableSlot = i
			break
		end
	end

	if not availableSlot then
		NotificationService.Error(player, "No available podium slots")
		StealService:CancelSteal(player)
		return false
	end

	local Traits = stolenAnimalData.Traits
	if Traits and #Traits == 0 then
		Traits = nil
	end

	local OriginalPodiumIndex = stealData.PodiumIndex

	if OriginalPodiumIndex and podiums[OriginalPodiumIndex] then
		local ExistingPodium = podiums[OriginalPodiumIndex]
		ExistingPodium.Machine = {
			Type = "BrainrotTrader",
			Active = false
		}
		podiums[OriginalPodiumIndex] = ExistingPodium
	else
		podiums[availableSlot] = {
			IndexOnPlot = OriginalPodiumIndex or availableSlot,
			Index = animalName,
			LastCollect = stolenAnimalData.LastCollect or workspace:GetServerTimeNow(),
			OfflineGain = stolenAnimalData.OfflineGain or nil,
			Traits = Traits,
			Machine = {
				Type = "BrainrotTrader",
				Active = false
			}
		}
	end

	playerData:Set("AnimalPodiums", podiums)
	playerData:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())

	StealService:CancelSteal(player)
	NotificationService.Notify(player, string.format("You gave the brainrot to the <font color='#006fff'>Brainrot Dealer</font></stroke>"))

	return true
end

Players.PlayerAdded:Connect(function(player)
	PlayerPodiums[player.UserId] = {}
	RemoteUpdate:FireClient(player, CurrentTrader)
end)

Players.PlayerRemoving:Connect(function(player)
	PlayerPodiums[player.UserId] = nil
end)

for _, player in Players:GetPlayers() do
	PlayerPodiums[player.UserId] = {}
	RemoteUpdate:FireClient(player, CurrentTrader)
end

task.spawn(function()
	while true do
		if os.clock() >= RefreshTime then
			generateTrader()
			for _, plr in Players:GetPlayers() do
				RemoteUpdate:FireClient(plr, CurrentTrader)
			end
		end
		task.wait(1)
	end
end)

BrainrotTraderService.CurrentTrader = CurrentTrader

return BrainrotTraderService