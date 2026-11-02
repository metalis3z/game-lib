local CraftingMachineService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

local PlotService = require(ServerScriptService.Services.PlotService)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local StealService = require(ServerScriptService.Services.StealService)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local ShopService = require(ServerScriptService.Services.ShopService)

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)
local CraftingData = require(ServerStorage.Modules.CraftingData)
local AnimalsDB = require(ReplicatedStorage.Datas.Animals)
local Rarities = require(ReplicatedStorage.Datas.Rarities)

local CraftNow = Net:RemoteEvent("CraftingMachineService/CraftNow")
local Update = Net:RemoteEvent("CraftingMachineService/Update")
local Return = Net:RemoteEvent("CraftingMachineService/Return")
local Claim = Net:RemoteEvent("CraftingMachineService/Claim")
local Delivery = Net:RemoteFunction("CraftingMachineService/Delivery")
local Start = Net:RemoteFunction("CraftingMachineService/Start")
local Fetch = Net:RemoteFunction("CraftingMachineService/Fetch")

local CONSTANTS = {
	REFRESH_INTERVAL = 1800,
	MAX_PODIUM_SLOTS = 50,
	SPAWN_ANIMATION_TIME = 1.5,
	NOTIFICATION_DURATION = 5,
	SOUNDS = {
		SUCCESS = "Sounds.Sfx.Success"
	},
	PRODUCT_IDS = {
		Epic = 3394964472,
		Legendary = 3394964604,
		Mythic = 3394964736,
		["Brainrot God"] = 3394965881,
		Secret = 3394969112
	}
}

local function filterBrainrotsWithoutConflicts(brainrots, usedAnimals)
	local available = {}

	for _, brainrot in brainrots do
		local hasConflict = false

		for _, requiredAnimal in brainrot.Recipe do
			if usedAnimals[requiredAnimal] then
				hasConflict = true
				break
			end
		end

		if not hasConflict then
			table.insert(available, brainrot)
		end
	end

	return available
end

local function generateCraftingList()
	local currentTime = workspace:GetServerTimeNow()
	local listSeed = math.floor(currentTime / CONSTANTS.REFRESH_INTERVAL)
	local rng = Random.new(listSeed)

	local craftingList = {
		List = {},
		Refresh = (listSeed + 1) * CONSTANTS.REFRESH_INTERVAL
	}

	local usedAnimals = {}

	for rarity, rarityData in CraftingData.Rarities do
		if #rarityData.Brainrots > 0 then
			local availableBrainrots = filterBrainrotsWithoutConflicts(rarityData.Brainrots, usedAnimals)

			if #availableBrainrots > 0 then
				local selectedBrainrot = availableBrainrots[rng:NextInteger(1, #availableBrainrots)]

				for _, requiredAnimal in selectedBrainrot.Recipe do
					usedAnimals[requiredAnimal] = true
				end

				craftingList.List[rarity] = {
					Name = selectedBrainrot.Name,
					Recipe = selectedBrainrot.Recipe,
					Cost = selectedBrainrot.Cost,
					CraftTime = rarityData.CraftTime
				}
			end
		end
	end

	return craftingList
end

local function countRequiredAnimals(recipe)
	local required = {}
	for _, animalName in recipe do
		required[animalName] = (required[animalName] or 0) + 1
	end
	return required
end

local function isPodiumAvailableForCrafting(podiumData)
	return type(podiumData) == "table"
		and podiumData.Machine
		and podiumData.Machine.Type == "Crafting"
		and not podiumData.Machine.Active
end

local function validateRecipeAvailability(podiums, recipe)
	local available = {}

	for _, podiumData in podiums do
		if isPodiumAvailableForCrafting(podiumData) then
			local animalName = podiumData.Index
			available[animalName] = (available[animalName] or 0) + 1
		end
	end

	local required = countRequiredAnimals(recipe)
	for animalName, count in required do
		if (available[animalName] or 0) < count then
			return false
		end
	end

	return true
end

local function consumeAnimalsForCrafting(podiums, recipe)
	local toConsume = {}
	for _, animalName in recipe do
		table.insert(toConsume, animalName)
	end

	for _, podiumData in podiums do
		if isPodiumAvailableForCrafting(podiumData) then
			local animalName = podiumData.Index
			local index = table.find(toConsume, animalName)

			if index then
				podiumData.Machine.Active = true
				table.remove(toConsume, index)

				if #toConsume == 0 then
					return true
				end
			end
		end
	end

	return #toConsume == 0
end

local function hasActiveCraft(craftingData)
	if not craftingData then return false end
	if not craftingData.StartTime or not craftingData.FinishTime then return false end
	return workspace:GetServerTimeNow() < craftingData.FinishTime
end

local function isAnimalRequiredInRecipes(animalName, craftingList)
	for _, craftData in craftingList.List do
		if craftData.Recipe then
			for _, requiredAnimal in craftData.Recipe do
				if requiredAnimal == animalName then
					return true
				end
			end
		end
	end
	return false
end

local function findAvailablePodiumSlot(podiums)
	for i = 1, CONSTANTS.MAX_PODIUM_SLOTS do
		if not podiums[i] then
			return i
		end
	end
	return nil
end

local function createColoredAnimalName(animalName)
	local animalData = AnimalsDB[animalName]
	if not animalData then return animalName end

	local rarityData = animalData.Rarity and Rarities[animalData.Rarity]
	if not rarityData or not rarityData.Color then 
		return animalData.DisplayName or animalName 
	end

	local color = rarityData.Color
	if typeof(color) == "Color3" then
		local hex = string.format(
			"#%02X%02X%02X",
			math.floor(color.R * 255),
			math.floor(color.G * 255),
			math.floor(color.B * 255)
		)
		return string.format('<font color="%s">%s</font>', hex, animalData.DisplayName or animalName)
	end

	return animalData.DisplayName or animalName
end

local function removeActiveCraftingMachines(podiums)
	for podiumIndex, podiumData in podiums do
		if type(podiumData) == "table"
			and podiumData.Machine
			and podiumData.Machine.Type == "Crafting"
			and podiumData.Machine.Active then
			podiums[podiumIndex] = nil
		end
	end
end

local function validateCraftStart(player, rarity, brainrotName)
	local data = Synchronizer:Get(player)
	if not data then
		return false, "Player data not found"
	end

	local craftingList = generateCraftingList()
	local craftingItem = craftingList.List[rarity]
	if not craftingItem or craftingItem.Name ~= brainrotName then
		return false, "Invalid crafting item"
	end

	local coins = data:Get("Coins") or 0
	if coins < craftingItem.Cost then
		return false, "Insufficient coins"
	end

	local podiums = data:Get("AnimalPodiums") or {}
	if not validateRecipeAvailability(podiums, craftingItem.Recipe) then
		return false, "Missing required animals"
	end

	local currentCraft = data:Get("CraftingMachine")
	if hasActiveCraft(currentCraft) then
		return false, "Craft already in progress"
	end

	return true
end

Fetch.OnServerInvoke = function(player: Player)
	return generateCraftingList()
end

Start.OnServerInvoke = function(player: Player, rarity: string, brainrotName: string)
	local data = Synchronizer:Get(player)
	if not data then return false end

	local isValid, errorMsg = validateCraftStart(player, rarity, brainrotName)
	if not isValid then
		return false
	end

	local craftingList = generateCraftingList()
	local craftingItem = craftingList.List[rarity]
	local podiums = data:Get("AnimalPodiums") or {}

	if not consumeAnimalsForCrafting(podiums, craftingItem.Recipe) then
		return false
	end

	local coins = data:Get("Coins") or 0
	data:Set("Coins", coins - craftingItem.Cost)
	data:Set("AnimalPodiums", podiums)

	local currentTime = workspace:GetServerTimeNow()
	data:Set("CraftingMachine", {
		Brainrot = brainrotName,
		Rarity = rarity,
		StartTime = currentTime,
		FinishTime = currentTime + craftingItem.CraftTime
	})

	NotificationService.Notify(
		player,
		"Crafting started!",
		CONSTANTS.NOTIFICATION_DURATION,
		CONSTANTS.SOUNDS.SUCCESS
	)

	return true
end

Delivery.OnServerInvoke = function(player: Player, hitbox)
	local data = Synchronizer:Get(player)
	if not data then return false end

	local stealData = StealService:GetStealData(player)
	if not stealData or not stealData.StolenAnimalData then return false end

	local animalName = stealData.StolenAnimalData.Index or "Noobini Pizzanini"

	local podiums = data:Get("AnimalPodiums") or {}
	local hasAnimal = false
	for _, podiumData in pairs(podiums) do
		if type(podiumData) == "table" and podiumData.Index == animalName then
			hasAnimal = true
			break
		end
	end

	if not hasAnimal then
		NotificationService.Error(player, "You must own the brainrot to use it in the machine")
		return false
	end

	local craftingList = generateCraftingList()
	if not isAnimalRequiredInRecipes(animalName, craftingList) then
		NotificationService.Error(player, "This brainrot is not required in any recipe")
		StealService:CancelSteal(player)
		return false
	end

	local stolenAnimalData = stealData.StolenAnimalData
	local traits = stolenAnimalData.Traits
	if traits and #traits == 0 then
		traits = nil
	end

	local originalPodiumIndex = stealData.PodiumIndex

	if originalPodiumIndex and podiums[originalPodiumIndex] then
		local existingPodium = podiums[originalPodiumIndex]
		existingPodium.Machine = {
			Type = "Crafting",
			Active = false
		}
		podiums[originalPodiumIndex] = existingPodium
	else
		local availableSlot = findAvailablePodiumSlot(podiums)
		if not availableSlot then return false end

		podiums[availableSlot] = {
			IndexOnPlot = originalPodiumIndex or availableSlot,
			Index = animalName,
			LastCollect = stolenAnimalData.LastCollect or workspace:GetServerTimeNow(),
			OfflineGain = stolenAnimalData.OfflineGain,
			Mutation = stolenAnimalData.Mutation,
			Traits = traits,
			Machine = {
				Type = "Crafting",
				Active = false
			}
		}
	end

	data:Set("AnimalPodiums", podiums)
	data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
	StealService:CancelSteal(player)

	local coloredName = createColoredAnimalName(animalName)
	NotificationService.Notify(
		player,
		string.format("You have added %s to the Crafting Machine!", coloredName),
		CONSTANTS.NOTIFICATION_DURATION,
		CONSTANTS.SOUNDS.SUCCESS
	)

	return true
end

Return.OnServerEvent:Connect(function(player: Player, podiumIndex: number)
	local data = Synchronizer:Get(player)
	if not data then return end

	local podiums = data:Get("AnimalPodiums") or {}
	local podiumData = podiums[podiumIndex]

	if podiumData
		and podiumData.Machine
		and podiumData.Machine.Type == "Crafting"
		and not podiumData.Machine.Active then

		podiumData.Machine = nil
		podiums[podiumIndex] = podiumData
		data:Set("AnimalPodiums", podiums)
		data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
	end
end)

Claim.OnServerEvent:Connect(function(player: Player)
	local data = Synchronizer:Get(player)
	if not data then return end

	local craftingData = data:Get("CraftingMachine")
	if not craftingData or not craftingData.FinishTime then return end
	if workspace:GetServerTimeNow() < craftingData.FinishTime then return end

	local plot = PlotService.getPlot(player)
	if not plot then return end

	CraftNow:FireClient(player, craftingData.Rarity)

	AnimalService.spawnAnimalCustom(
		AnimalsDB[craftingData.Brainrot],
		nil,
		nil,
		nil,
		{
			Start = workspace.CraftingMachine.SpawnZone,
			End = plot.AnimalTarget,
			Owner = player
		},
		CONSTANTS.SPAWN_ANIMATION_TIME
	)

	data:Set("CraftingMachine", {})

	local podiums = data:Get("AnimalPodiums") or {}
	removeActiveCraftingMachines(podiums)
	data:Set("AnimalPodiums", podiums)
	data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
end)

CraftNow.OnServerEvent:Connect(function(player: Player)
	local data = Synchronizer:Get(player)
	if not data then return end

	local craftingData = data:Get("CraftingMachine")
	if not craftingData then return end

	local productId = CONSTANTS.PRODUCT_IDS[craftingData.Rarity]
	if not productId then return end

	pcall(function()
		ShopService:ProcessPurchase(player, productId)
	end)
end)

function CraftingMachineService:Start()
	for _, player in Players:GetChildren() do
		task.spawn(function()
			local data = Synchronizer:Wait(player)
			if data then
				local craftingMachine = data:Get("CraftingMachine")
				if not craftingMachine then
					data:Set("CraftingMachine", {})
				end
				task.wait(1)
				Update:FireClient(player, generateCraftingList())
			end
		end)
	end

	Players.PlayerAdded:Connect(function(player)
		local data = Synchronizer:Wait(player)
		if data then
			local craftingMachine = data:Get("CraftingMachine")
			if not craftingMachine then
				data:Set("CraftingMachine", {})
			end
			task.wait(1)
			Update:FireClient(player, generateCraftingList())
		end
	end)

	task.spawn(function()
		while true do
			local currentTime = workspace:GetServerTimeNow()
			local nextRefresh = (math.floor(currentTime / CONSTANTS.REFRESH_INTERVAL) + 1) * CONSTANTS.REFRESH_INTERVAL
			local waitTime = nextRefresh - currentTime

			task.wait(waitTime)
			Update:FireAllClients(generateCraftingList())
		end
	end)
end

Net:Handle("BrainrotToCraft/RequestList", function(player: Player)
	local CommandsService = require(ServerScriptService.Services.CommandsService)
	local role = CommandsService:GetRoleAsync(player)

	if role ~= "Dev" and role ~= "Lead" then
		return {}
	end

	local brainrotNames = {}
	for _, rarityData in CraftingData.Rarities do
		for _, brainrot in rarityData.Brainrots do
			table.insert(brainrotNames, brainrot.Name)
		end
	end

	return brainrotNames
end)

return CraftingMachineService