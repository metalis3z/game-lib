local CupidsMachineService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local PlotService = require(ServerScriptService.Services.PlotService)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local StealService = require(ServerScriptService.Services.StealService)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)

local AnimalsDB = require(ReplicatedStorage.Datas.Animals)
local Rarities = require(ReplicatedStorage.Datas.Rarities)

local CraftDone = Net:RemoteEvent("CupidsMachineService/CraftDone")
local Update = Net:RemoteEvent("CupidsMachineService/Update")
local ReturnRE = Net:RemoteEvent("CupidsMachineService/Return")
local Claim = Net:RemoteEvent("CupidsMachineService/Claim")
local Skip = Net:RemoteEvent("CupidsMachineService/Skip")

local Delivery = Net:RemoteFunction("CupidsMachineService/Delivery")
local Start = Net:RemoteFunction("CupidsMachineService/Start")
local Fetch = Net:RemoteFunction("CupidsMachineService/Fetch")
local setrecipe = Net:RemoteFunction("CupidsMachineService/SetRecipe")

local CRAFT_TIME = 30
local REFRESH_TIME = 1800
local MAX_BRAINROTS = 2
local DEFAULT_INSTANT_SKIPS = 100000000000000
local DEFAULT_COST = 250

local sharedRng = Random.new()

local currentRecipe = nil

local PRESET_DUOS = {
	{ "Chicleteira Bicicleteira", "Chicleteirina Bicicleteirina" },
	{ "Dul Dul Dul", "Luv Luv Luv" },
	{ "Karkerkar Kurkur", "Karkerheart Luvkur" },
}

local MATCH_NAMES = { "Love Match", "Heart Match", "Cupid's Pick", "Random Match", "Secret Match" }

local DEFAULT_OUTPUTS = {
	{ Name = "Heart Lucky Block",  Chance = 45.0    },
	{ Name = "Nothing",            Chance = 40.1875 },
	{ Name = "Cupid Cupid Sahur",  Chance = 14.5    },
	{ Name = "Lovin Rose",         Chance = 0.25    },
}

local processingClaim = setmetatable({}, { __mode = "k" })

local function buildDefaultMachineData()
	return {
		StartTime = 0,
		FinishTime = 0,
		InstantSkips = DEFAULT_INSTANT_SKIPS,
	}
end

local function makeColoredName(animalName, animalData)
	if not animalData then return animalName end
	local rarityData = Rarities[animalData.Rarity]
	local color = rarityData and rarityData.Color
	if color and typeof(color) == "Color3" then
		local hex = string.format("#%02X%02X%02X",
			math.floor(color.R * 255),
			math.floor(color.G * 255),
			math.floor(color.B * 255))
		return string.format('<font color="%s">%s</font>', hex, animalData.DisplayName or animalName)
	end
	return animalData.DisplayName or animalName
end

local function cleanPlayerData(player)
	local data = Synchronizer:Get(player)
	if not data then return end

	local machineData = data:Get("CupidsMachine")
	local now = workspace:GetServerTimeNow()
	local isActive = machineData
		and machineData.StartTime and machineData.StartTime ~= 0
		and (machineData.FinishTime or 0) > now
	if isActive then return end

	data:Set("CupidsMachine", buildDefaultMachineData())

	local podiums = data:Get("AnimalPodiums") or {}
	local changed = false
	for i, podium in pairs(podiums) do
		if type(podium) == "table" and podium.Machine and podium.Machine.Type == "Cupids" then
			podium.Machine = nil
			podiums[i] = podium
			changed = true
		end
	end

	if changed then
		data:Set("AnimalPodiums", podiums)
		data:Set("AnimalAddedOrRemoved", now)
	end
end

local function buildRandomRecipe(animal1, animal2)
	local ingredients
	if type(animal1) == "string" and type(animal2) == "string"
		and AnimalsDB[animal1] and AnimalsDB[animal2] then
		ingredients = { animal1, animal2 }
	else
		local selectedPair = #PRESET_DUOS > 0
			and PRESET_DUOS[sharedRng:NextInteger(1, #PRESET_DUOS)]
			or { "Noobini Pizzanini", "Toto to Sanur" }
		ingredients = { selectedPair[1], selectedPair[2] }
	end

	local matchName = string.format("%s #%d",
		MATCH_NAMES[sharedRng:NextInteger(1, #MATCH_NAMES)],
		sharedRng:NextInteger(1, 99))

	return {
		Recipe = {
			Name = matchName,
			Recipe = ingredients,
			Cost = DEFAULT_COST,
		},
		Outputs = DEFAULT_OUTPUTS,
		Refresh = workspace:GetServerTimeNow() + REFRESH_TIME,
	}
end

setrecipe.OnServerInvoke = function(player, animal1, animal2)
	currentRecipe = buildRandomRecipe(animal1, animal2)
	Update:FireAllClients(currentRecipe)
	return currentRecipe
end

local function refreshAll()
	currentRecipe = buildRandomRecipe()
	Update:FireAllClients(currentRecipe)
end

Fetch.OnServerInvoke = function(player)
	cleanPlayerData(player)

	if not currentRecipe then
		currentRecipe = buildRandomRecipe()
	end

	local data = Synchronizer:Get(player)
	local machineData = (data and data:Get("CupidsMachine")) or buildDefaultMachineData()

	return {
		Recipe       = currentRecipe.Recipe,
		Outputs      = currentRecipe.Outputs,
		Refresh      = currentRecipe.Refresh,
		StartTime    = machineData.StartTime or 0,
		FinishTime   = machineData.FinishTime or 0,
		InstantSkips = machineData.InstantSkips or DEFAULT_INSTANT_SKIPS,
	}
end

Delivery.OnServerInvoke = function(player, hitbox)
	local data = Synchronizer:Get(player)
	if not data then return false end
	local stealData = StealService:GetStealData(player)
	if not stealData or not stealData.StolenAnimalData then
		return false
	end
	
	local machineData = data:Get("CupidsMachine") or {}
	if machineData.StartTime and machineData.StartTime ~= 0 then
		NotificationService.Error(player, "Machine is running!")
		return false
	end


	local animalName = stealData.StolenAnimalData.Index

	if not currentRecipe then
		currentRecipe = buildRandomRecipe()
	end

	local neededInRecipe = 0
	if currentRecipe.Recipe and currentRecipe.Recipe.Recipe then
		for _, requiredBrainrot in ipairs(currentRecipe.Recipe.Recipe) do
			if requiredBrainrot == animalName then
				neededInRecipe = neededInRecipe + 1
			end
		end
	end

	if neededInRecipe == 0 then
		NotificationService.Error(player, "This brainrot is not in the current random match!")
		StealService:CancelSteal(player)
		return false
	end

	local podiums = data:Get("AnimalPodiums") or {}
	local availablePodiumIndex   = nil
	local sameNameInMachine      = 0
	local totalInMachine         = 0

	for podiumIndex, podium in pairs(podiums) do
		if type(podium) == "table" then
			local inMachine = podium.Machine and podium.Machine.Type == "Cupids"
			if inMachine then
				totalInMachine = totalInMachine + 1
				if podium.Index == animalName then
					sameNameInMachine = sameNameInMachine + 1
				end
			elseif podium.Index == animalName and not availablePodiumIndex then
				availablePodiumIndex = podiumIndex
			end
		end
	end

	if totalInMachine >= MAX_BRAINROTS then
		NotificationService.Error(player, "Machine is full!")
		StealService:CancelSteal(player)
		return false
	end

	if sameNameInMachine >= neededInRecipe then
		NotificationService.Error(player, "This brainrot is already in machine!")
		StealService:CancelSteal(player)
		return false
	end

	if not availablePodiumIndex then
		if sameNameInMachine > 0 then
			NotificationService.Error(player, "You need another copy of this brainrot!")
		else
			NotificationService.Error(player, "You must own the brainrot!")
		end
		return false
	end

	local podium = podiums[availablePodiumIndex]
	podium.Machine = { Type = "Cupids", Active = false }
	podiums[availablePodiumIndex] = podium

	data:Set("AnimalPodiums", podiums)
	data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
	StealService:CancelSteal(player)

	local animalData = AnimalsDB[animalName]
	if animalData then
		NotificationService.Notify(player,
			"Added " .. makeColoredName(animalName, animalData) .. " to machine!",
			5, "Sounds.Sfx.Success")
	end

	return true
end

ReturnRE.OnServerEvent:Connect(function(player, podiumIndex)
	local data = Synchronizer:Get(player)
	if not data then return end

	local machineData = data:Get("CupidsMachine") or {}
	if machineData.StartTime and machineData.StartTime ~= 0 then
		NotificationService.Error(player, "Machine is running!")
		return
	end

	local podiums = data:Get("AnimalPodiums") or {}
	local podium = podiums[podiumIndex]

	if not podium or not podium.Machine or podium.Machine.Type ~= "Cupids" then
		return
	end

	if podium.Machine.Active then
		NotificationService.Error(player, "Cannot return active brainrot!")
		return
	end

	podium.Machine = nil
	podiums[podiumIndex] = podium
	data:Set("AnimalPodiums", podiums)
	data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
end)

Start.OnServerInvoke = function(player)
	local data = Synchronizer:Get(player)
	if not data then return false end

	if not currentRecipe then
		currentRecipe = buildRandomRecipe()
	end

	local recipe = currentRecipe.Recipe
	if not recipe then
		NotificationService.Error(player, "No recipe available!")
		return false
	end

	local machineData = data:Get("CupidsMachine") or {}
	if machineData.StartTime and machineData.StartTime ~= 0
		and workspace:GetServerTimeNow() < (machineData.FinishTime or 0) then
		NotificationService.Error(player, "Already running!")
		return false
	end

	local coins = data:Get("Coins") or 0
	if coins < recipe.Cost then
		NotificationService.Error(player, "Need $" .. recipe.Cost .. " coins!")
		return false
	end

	local recipeBrainrots = {}
	for _, brainrot in ipairs(recipe.Recipe) do
		recipeBrainrots[brainrot] = (recipeBrainrots[brainrot] or 0) + 1
	end

	local podiums = data:Get("AnimalPodiums") or {}
	local brainrotCount = {}
	for _, p in pairs(podiums) do
		if type(p) == "table" and p.Machine and p.Machine.Type == "Cupids" and not p.Machine.Active then
			brainrotCount[p.Index] = (brainrotCount[p.Index] or 0) + 1
		end
	end

	for brainrot, needed in pairs(recipeBrainrots) do
		if (brainrotCount[brainrot] or 0) < needed then
			NotificationService.Error(player, "Need " .. brainrot .. " in machine!")
			return false
		end
	end

	for i, p in pairs(podiums) do
		if type(p) == "table" and p.Machine and p.Machine.Type == "Cupids" then
			p.Machine.Active = true
			podiums[i] = p
		end
	end

	data:Set("Coins", coins - recipe.Cost)
	data:Set("AnimalPodiums", podiums)

	local now = workspace:GetServerTimeNow()
	data:Set("CupidsMachine", {
		StartTime    = now,
		FinishTime   = now + CRAFT_TIME,
		InstantSkips = DEFAULT_INSTANT_SKIPS,
	})

	NotificationService.Notify(player, "Machine started!", 5, "Sounds.Sfx.Success")

	Update:FireClient(player, currentRecipe)

	return true
end

Claim.OnServerEvent:Connect(function(player)
	if processingClaim[player] then return end

	local data = Synchronizer:Get(player)
	if not data then return end

	local machineData = data:Get("CupidsMachine") or {}
	if not machineData.FinishTime or machineData.FinishTime == 0 then
		NotificationService.Error(player, "Nothing to claim!")
		return
	end

	if workspace:GetServerTimeNow() < machineData.FinishTime then
		NotificationService.Error(player, "Not finished yet!")
		return
	end

	local plot = PlotService.getPlot(player)
	if not plot then
		NotificationService.Error(player, "No plot!")
		return
	end

	processingClaim[player] = true

	local ok, err = pcall(function()
		if not currentRecipe then
			currentRecipe = buildRandomRecipe()
		end

		local resultItem
		local success = false
		if currentRecipe.Outputs and #currentRecipe.Outputs > 0 then
			local roll = sharedRng:NextNumber(0, 100)
			local cumulative = 0
			for _, output in ipairs(currentRecipe.Outputs) do
				cumulative = cumulative + output.Chance
				if roll <= cumulative then
					resultItem = output.Name
					success = (resultItem ~= "Nothing")
					break
				end
			end
		end

		local podiums = data:Get("AnimalPodiums") or {}
		local usedBrainrots = {}
		for i, p in pairs(podiums) do
			if type(p) == "table" and p.Machine and p.Machine.Type == "Cupids" then
				usedBrainrots[#usedBrainrots + 1] = p.Index
				podiums[i] = nil
			end
		end

		data:Set("AnimalPodiums", podiums)
		data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())

		CraftDone:FireAllClients(success, usedBrainrots)

		if success and resultItem then
			local animalData = AnimalsDB[resultItem]
			if animalData then
				task.wait(7.5)
				local currentPlot = PlotService.getPlot(player)
				if currentPlot and player.Parent then
					AnimalService.spawnAnimalCustom(animalData, nil, nil, nil, {
						Start = workspace.CupidsMachine.SpawnZone,
						End   = currentPlot.AnimalTarget,
						Owner = player,
					}, nil, true)

				end
			end
		else
			NotificationService.Notify(player, "Failed to match!", 5, "Sounds.Sfx.Error")
		end

		data:Set("CupidsMachine", buildDefaultMachineData())

		currentRecipe = buildRandomRecipe()
		Update:FireAllClients(currentRecipe)
	end)

	processingClaim[player] = nil

	if not ok then
		warn("[CupidsMachineService] Claim error:", err)
	end
end)

Skip.OnServerEvent:Connect(function(player)
	local data = Synchronizer:Get(player)
	if not data then return end

	local machineData = data:Get("CupidsMachine") or {}
	if not machineData.StartTime or machineData.StartTime == 0 then
		NotificationService.Error(player, "Nothing to skip!")
		return
	end

	local now = workspace:GetServerTimeNow()
	if now >= (machineData.FinishTime or 0) then
		NotificationService.Error(player, "Already finished!")
		return
	end

	machineData.FinishTime = now
	data:Set("CupidsMachine", machineData)

	NotificationService.Notify(player, "Skipped!", 3, "Sounds.Sfx.Success")
end)

Players.PlayerRemoving:Connect(function(player)
	processingClaim[player] = nil
end)

function CupidsMachineService:Start()
	refreshAll()

	task.spawn(function()
		while true do
			task.wait(REFRESH_TIME)
			refreshAll()
		end
	end)

	local function initPlayer(player)
		local data = Synchronizer:Wait(player)
		if not data then return end
		data:Set("CupidsMachine", buildDefaultMachineData())
		Update:FireClient(player, currentRecipe)
	end

	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(initPlayer, player)
	end

	Players.PlayerAdded:Connect(function(player)
		task.spawn(initPlayer, player)
	end)
end

return CupidsMachineService