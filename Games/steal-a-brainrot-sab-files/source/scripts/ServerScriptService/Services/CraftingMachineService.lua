
local CraftingMachineService = {}

local Players             = game:GetService("Players")
local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage       = game:GetService("ServerStorage")
local MemoryStoreService  = game:GetService("MemoryStoreService")
local MessagingService    = require(ServerScriptService.Services.MessagingService)

local PlotService         = require(ServerScriptService.Services.PlotService)
local AnimalService       = require(ServerScriptService.Services.AnimalService)
local StealService        = require(ServerScriptService.Services.StealService)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local Synchronizer        = require(ReplicatedStorage.Packages.Synchronizer)
local Net                 = require(ReplicatedStorage.Packages.Net)
local CraftingData        = require(ServerStorage.Modules.CraftingData)
local AnimalsDB           = require(ReplicatedStorage.Datas.Animals)
local Rarities            = require(ReplicatedStorage.Datas.Rarities)
local Mutations           = require(ReplicatedStorage.Datas.Mutations)

local activeCraftType = "Cyber"

local CRAFT_LABELS = {
	Cyber = { name = "Cyber Craft", color = "#79dbff" },
	OG    = { name = "Craft Machine",    color = "#FFFFFF" },
}

local function getPool()
	return CraftingData[activeCraftType] or CraftingData.Cyber
end

local function getCraftLabel()
	return CRAFT_LABELS[activeCraftType] or CRAFT_LABELS.Cyber
end

local function formatCraftName()
	local label = getCraftLabel()
	return string.format('<font color="%s"><b>%s</b></font>', label.color, label.name)
end

local function isCraftingPodium(podiumData)
	return type(podiumData) == "table"
		and podiumData.Machine
		and (podiumData.Machine.Type == "Crafting" or podiumData.Machine.Type == "OGCrafting")
end

local function resolveCraftModel(craftType)
	if craftType == "OG" then
		local direct = workspace:FindFirstChild("OG CraftingMachine")
		if direct then return direct end
		local folder = workspace:FindFirstChild("Og craft machine")
		return folder and folder:FindFirstChild("OG CraftingMachine")
	end
	return workspace:FindFirstChild("CraftingMachine")
end

local function getSpawnZone()
	local model = resolveCraftModel(activeCraftType)
	local zone = model and model:FindFirstChild("SpawnZone")
	if not zone then
		local cyber = workspace:FindFirstChild("CraftingMachine")
		zone = cyber and cyber:FindFirstChild("SpawnZone")
	end
	return zone
end

local function getActiveCraftTypeFromWorld()
	local cyber = workspace:FindFirstChild("CraftingMachine")
	if cyber and cyber:GetAttribute("Crafttype") then
		return cyber:GetAttribute("Crafttype")
	end
	local og = resolveCraftModel("OG")
	if og and og:GetAttribute("Crafttype") then
		return og:GetAttribute("Crafttype")
	end
	return "Cyber"
end

local currentCraftingList = nil

local LocalStockTable = {}

local GlobalRecipeStore   = MemoryStoreService:GetSortedMap("GlobalCraftingRecipes")
local GLOBAL_RECIPE_TOPIC = "CraftingMachine/GlobalRecipe"
local GLOBAL_RECIPE_EXPIRY = 86400 * 7

local STOCK_BROADCAST_INTERVAL = 2
local dirtyStockBroadcast = {}

local function publishStockUpdate(globalKey, newStock)
	pcall(function()
		MessagingService:PublishAsync(GLOBAL_RECIPE_TOPIC, {
			Action = "StockUpdate",
			Data   = { GlobalKey = globalKey, NewStock = newStock },
		})
	end)
end

local ActiveMutationEvents = {}

local function SetStockAttribute(stockKey: string, count: number?)
	local safeKey = stockKey:gsub("[^%w]", "") 
	local attributeName = "CraftingMachineStock_" .. safeKey

	if count == nil then
		ReplicatedStorage:SetAttribute(attributeName, nil)
	else
		ReplicatedStorage:SetAttribute(attributeName, count)
	end
end

local function GetStockAttribute(stockKey: string): number?
	local safeKey = stockKey:gsub("[^%w]", "")
	return ReplicatedStorage:GetAttribute("CraftingMachineStock_" .. safeKey)
end

local function GetTraitOddsFromMachine(BrainrotsInMachine)
	local TraitCount = {}
	for _, BrainrotData in BrainrotsInMachine do
		local TraitsList = BrainrotData.Traits or {}
		for _, Trait in ipairs(TraitsList) do
			TraitCount[Trait] = (TraitCount[Trait] or 0) + 1
		end
	end
	local TraitOdds = {}
	for TraitName, Count in pairs(TraitCount) do
		TraitOdds[TraitName] = math.min(Count * 15, 100)
	end
	return TraitOdds
end

local function GetBrainrotsInCraftingMachine(Podiums)
	local BrainrotsInMachine = {}
	for _, PodiumData in Podiums do
		if isCraftingPodium(PodiumData) then
			table.insert(BrainrotsInMachine, {
				Index    = PodiumData.Index,
				Mutation = PodiumData.Mutation,
				Traits   = PodiumData.Traits,
			})
		end
	end
	return BrainrotsInMachine
end

local function GetMutationOddsFromMachine(BrainrotsInMachine)
	local MutationCount = {}
	for _, BrainrotData in BrainrotsInMachine do
		local Mutation = BrainrotData.Mutation
		if Mutation then
			MutationCount[Mutation] = (MutationCount[Mutation] or 0) + 1
		end
	end

	local MutationOdds = {}
	for MutationName, Count in pairs(MutationCount) do
		MutationOdds[MutationName] = Count * 10
	end

	for MutationName in pairs(ActiveMutationEvents) do
		MutationOdds[MutationName] = (MutationOdds[MutationName] or 0) + 15
	end

	if not next(MutationOdds) then return MutationOdds end

	local TotalChance = 0
	for _, Chance in pairs(MutationOdds) do TotalChance = TotalChance + Chance end
	if TotalChance > 100 then
		local Scale = 100 / TotalChance
		for MutationName, Chance in pairs(MutationOdds) do
			MutationOdds[MutationName] = math.floor(Chance * Scale)
		end
	end
	return MutationOdds
end

local function UpdateCraftingMachineOdds(Player: Player)
	local Data = Synchronizer:Get(Player)
	if not Data then return end

	local Podiums            = Data:Get("AnimalPodiums") or {}
	local BrainrotsInMachine = GetBrainrotsInCraftingMachine(Podiums)
	local MutationOdds       = GetMutationOddsFromMachine(BrainrotsInMachine)
	local TraitOdds          = GetTraitOddsFromMachine(BrainrotsInMachine)

	local MutationOddsIndexed = {}
	local TraitOddsIndexed    = {}

	local CraftList = getCraftingList and getCraftingList() or currentCraftingList
	local ListLen   = CraftList and CraftList.List and #CraftList.List or 0

	for i = 1, math.max(ListLen, 1) do
		MutationOddsIndexed[i] = table.clone(MutationOdds)
		TraitOddsIndexed[i]    = table.clone(TraitOdds)
	end

	Data:Set("CraftingMachine.OutputMutationOdds", MutationOddsIndexed)
	Data:Set("CraftingMachine.OutputTraitsOdds",   TraitOddsIndexed)
end

local CraftNow  = Net:RemoteEvent("CraftingMachineService/CraftNow")
local Update    = Net:RemoteEvent("CraftingMachineService/Update")
local Return    = Net:RemoteEvent("CraftingMachineService/Return")
local Claim     = Net:RemoteEvent("CraftingMachineService/Claim")
local Delivery  = Net:RemoteFunction("CraftingMachineService/Delivery")
local Start     = Net:RemoteFunction("CraftingMachineService/Start")
local Fetch     = Net:RemoteFunction("CraftingMachineService/Fetch")

local ShopService = require(ServerScriptService.Services.ShopService)
local ChatService = require(ServerScriptService.Services.ChatService)

local RARITY_ORDER = {
	"Common", "Rare", "Epic", "Legendary", "Mythic",
	"Brainrot God", "Secret", "Admin", "Taco",
	"Spooky", "Festive", "Valentines", "St Patrick's", "Easter", "OG"
}

local function FormatAnimalName(name: string): string
	local animalData = AnimalsDB[name]
	if not animalData then return name end
	local rarityData = Rarities[animalData.Rarity]
	if not rarityData then return animalData.DisplayName or name end
	local displayName = animalData.DisplayName or name
	if rarityData.GradientPreset then
		local gradientMap = {
			Rainbow = "rainbow", OG = "og", OG = "og",
			YellowRed = "yellowred", Greenred = "greenred"
		}
		local tag = gradientMap[rarityData.GradientPreset]
		if tag then
			return string.format("<%s>%s</%s>", tag, displayName, tag)
		end
	end
	local color = rarityData.Color and rarityData.Color:ToHex() or "FFFFFF"
	return string.format('<font color="#%s">%s</font>', color, displayName)
end

local function generateCraftingList(forceSeed)
	local currentTime     = workspace:GetServerTimeNow()
	local refreshInterval = 1800
	local listSeed        = forceSeed or math.floor(currentTime / refreshInterval)
	local rng             = Random.new(listSeed)
	local craftingList = {
		List    = {},
		Order   = {},
		Refresh = (math.floor(currentTime / refreshInterval) + 1) * refreshInterval
	}
	local usedBrainrots = {}

	local secretChances = {
		["Strawberry Elephant"]      = 70, 
		["Gorillo Subwoofero"]       = 70,
		["Meowls"]           = 70, 
		["Skibidi Toilet"]        = 70,
		["Money Money Man"]        = 70, 
		["Headless Horseman"]      = 70,
		["John Pork"]  = 70,
	}

	local manuallyAddedOnly = {
		["Los Primos"] = true, ["Los Tacoritas"] = true, ["Los Tortus"] = true,
	}

	local tempList = {}
	local isCyber = activeCraftType == "Cyber"
	for rarity, rarityData in getPool().Rarities do
		if #rarityData.Brainrots > 0 then
			local availableBrainrots = {}
			for _, brainrot in rarityData.Brainrots do
				local skip = isCyber and manuallyAddedOnly[brainrot.Name] or false
				if isCyber and rarity == "OG" and not skip then
					local chance = secretChances[brainrot.Name]
					if chance and rng:NextNumber(0, 100) > chance then skip = true end
				end
				if not skip then
					local hasConflict = false
					for _, requiredAnimal in brainrot.Recipe do
						if usedBrainrots[requiredAnimal] then
							hasConflict = true; break
						end
					end
					if not hasConflict then
						table.insert(availableBrainrots, brainrot)
					end
				end
			end

			if #availableBrainrots > 0 then
				local selected = availableBrainrots[rng:NextInteger(1, #availableBrainrots)]
				for _, requiredAnimal in selected.Recipe do
					usedBrainrots[requiredAnimal] = true
				end
				tempList[rarity] = {
					Name      = selected.Name,
					Rarity    = rarity,
					Recipe    = selected.Recipe,
					Cost      = selected.Cost,
					CraftTime = rarityData.CraftTime,
				}
			end
		end
	end

	for _, rarity in RARITY_ORDER do
		if tempList[rarity] then
			table.insert(craftingList.List, tempList[rarity])
			table.insert(craftingList.Order, rarity)
		end
	end
	return craftingList
end


function getCraftingList()
	if not currentCraftingList then
		currentCraftingList = generateCraftingList()
	end
	return currentCraftingList
end

Fetch.OnServerInvoke = function(player: Player)
	return getCraftingList()
end
local function RemoveGlobalRecipeLocally(globalKey: string)
	local list       = getCraftingList()
	local foundIndex = nil
	local foundEntry = nil
	local foundRarity = nil

	for i, entry in list.List do
		if entry.GlobalKey == globalKey then
			foundIndex = i; foundEntry = entry; foundRarity = entry.Rarity; break
		end
	end
	if not foundIndex then return end

	if foundEntry.StockKey then
		SetStockAttribute(foundEntry.StockKey, 0)
	end

	local cyberCraftName  = '<font color="#79dbff"><b>Cyber Craft</b></font>'
	local formattedOutput = FormatAnimalName(foundEntry.Name)
	for _, p in ipairs(Players:GetPlayers()) do
		NotificationService.Notify(
			p,
			string.format("Sammy removed %s from the %s!", formattedOutput, cyberCraftName),
			5, "Sounds.Sfx.Success"
		)
	end

	table.remove(list.List, foundIndex)

	local rarityStillUsed = false
	for _, entry in list.List do
		if entry.Rarity == foundRarity then rarityStillUsed = true; break end
	end
	if not rarityStillUsed then
		local orderIndex = table.find(list.Order, foundRarity)
		if orderIndex then table.remove(list.Order, orderIndex) end
	end

	Update:FireAllClients(list)
end

Start.OnServerInvoke = function(player: Player, rarity: string, brainrotName: string)
	local data = Synchronizer:Get(player)
	if not data then return false end

	local craftingList = getCraftingList()

	local craftingItem = nil
	for _, entry in craftingList.List do
		if entry.Rarity == rarity and entry.Name == brainrotName then
			craftingItem = entry
			break
		end
	end
	if not craftingItem then return false end

	local coins = data:Get("Coins") or 0
	if coins < craftingItem.Cost then return false end

	local podiums   = data:Get("AnimalPodiums") or {}
	local available = {}
	for _, podiumData in podiums do
		if isCraftingPodium(podiumData) and not podiumData.Machine.Active then
			local animalName = podiumData.Index
			available[animalName] = (available[animalName] or 0) + 1
		end
	end
	local required = {}
	for _, animalName in craftingItem.Recipe do
		required[animalName] = (required[animalName] or 0) + 1
	end
	for animalName, count in required do
		if (available[animalName] or 0) < count then return false end
	end

	local currentCraft = data:Get("CraftingMachine")
	if currentCraft and currentCraft.StartTime and currentCraft.FinishTime
		and workspace:GetServerTimeNow() < currentCraft.FinishTime then
		return false
	end


	if craftingItem.GlobalKey and craftingItem.StockKey then
		local updatedData
		local ok, err = pcall(function()
			updatedData = GlobalRecipeStore:UpdateAsync(
				craftingItem.GlobalKey,
				function(currentData)
					if not currentData then return nil end
					if currentData.TotalStock == nil then return currentData end
					if currentData.TotalStock <= 0 then return nil end
					currentData.TotalStock = currentData.TotalStock - 1
					return currentData
				end,
				GLOBAL_RECIPE_EXPIRY
			)
		end)

		if not ok then
			warn("[CraftingMachineService] GlobalStock UpdateAsync error: " .. tostring(err))
			return false
		end
		if updatedData == nil then
			return false
		end

		local newStock = updatedData.TotalStock
		if newStock ~= nil then
			SetStockAttribute(craftingItem.GlobalKey, newStock)

			if newStock <= 0 then
				dirtyStockBroadcast[craftingItem.GlobalKey] = nil
				publishStockUpdate(craftingItem.GlobalKey, newStock)
			else
				dirtyStockBroadcast[craftingItem.GlobalKey] = newStock
			end

		end
	elseif craftingItem.StockKey then
		local stockKey     = craftingItem.StockKey
		local currentStock = LocalStockTable[stockKey]
		if currentStock ~= nil then
			if currentStock <= 0 then
				return false
			end
			LocalStockTable[stockKey] = currentStock - 1
			local newCount = LocalStockTable[stockKey]
			SetStockAttribute(stockKey, newCount)
		end
	end

	local toConsume = {}
	for _, animalName in craftingItem.Recipe do
		table.insert(toConsume, animalName)
	end
	for podiumIndex, podiumData in podiums do
		if isCraftingPodium(podiumData) and not podiumData.Machine.Active then
			local animalName = podiumData.Index
			local idx = table.find(toConsume, animalName)
			if idx then
				podiumData.Machine.Active = true
				table.remove(toConsume, idx)
				if #toConsume == 0 then break end
			end
		end
	end
	if #toConsume ~= 0 then return false end

	data:Set("Coins", coins - craftingItem.Cost)
	data:Set("AnimalPodiums", podiums)

	local currentTime = workspace:GetServerTimeNow()
	data:Set("CraftingMachine", {
		Brainrot   = brainrotName,
		Rarity     = rarity,
		StartTime  = currentTime,
		FinishTime = currentTime + craftingItem.CraftTime,
	})
	NotificationService.Notify(player, '<font color="#79dbff">Crafting</font> started!', 5, "Sounds.Sfx.Success")
	return true
end

Delivery.OnServerInvoke = function(player: Player, hitbox)
	local data = Synchronizer:Get(player)
	if not data then return false end

	local stealData = StealService:GetStealData(player)
	if not stealData or not stealData.StolenAnimalData then return false end

	local ownPlot = _G.playerPlots[player.UserId]
	local ownPlotName = ownPlot and ownPlot.Name

	local isOwnPlotGrab = (ownPlotName ~= nil and stealData.VictimPlotUID == ownPlotName)
	local isSammySteal  = (stealData.VictimPlotUID == "Sammy")

	if not isOwnPlotGrab and not isSammySteal then
		NotificationService.Error(player, "You must own the brainrot to use it in the machine.")
		StealService:CancelSteal(player)
		return false
	end

	local animalName = stealData.StolenAnimalData.Index or "Noobini Pizzanini"

	if isSammySteal then
	elseif isOwnPlotGrab then
		local ownPlotChannel = Synchronizer:Get(ownPlotName)
		if ownPlotChannel then
			local animalList = ownPlotChannel:Get("AnimalList") or {}
			local foundInList = false
			for _, entry in pairs(animalList) do
				if type(entry) == "table" and entry.Index == animalName then
					foundInList = true
					break
				end
			end
			if not foundInList then
				NotificationService.Error(player, "You must own the brainrot to use it in the machine.")
				StealService:CancelSteal(player)
				return false
			end
		end
	end

	local craftingList = getCraftingList()
	local isRequired   = false
	for _, craftData in craftingList.List do
		if craftData.Recipe then
			for _, requiredAnimal in craftData.Recipe do
				if requiredAnimal == animalName then
					isRequired = true; break
				end
			end
		end
		if isRequired then break end
	end
	if not isRequired then
		NotificationService.Error(player, "This brainrot is not required in any recipe")
		StealService:CancelSteal(player)
		return false
	end

	local stolenAnimalData    = stealData.StolenAnimalData
	local traits              = stolenAnimalData.Traits
	if traits and #traits == 0 then traits = nil end
	local originalPodiumIndex = stealData.PodiumIndex

	local podiums = data:Get("AnimalPodiums") or {}

	if originalPodiumIndex and podiums[originalPodiumIndex] then
		local existingPodium = podiums[originalPodiumIndex]
		existingPodium.Machine = { Type = "Crafting", Active = false }
		podiums[originalPodiumIndex] = existingPodium
	else
		local availableSlot = nil
		for i = 1, 50 do
			if not podiums[i] then availableSlot = i; break end
		end
		if not availableSlot then return false end
		podiums[availableSlot] = {
			IndexOnPlot = originalPodiumIndex or availableSlot,
			Index       = animalName,
			LastCollect = stolenAnimalData.LastCollect or workspace:GetServerTimeNow(),
			OfflineGain = stolenAnimalData.OfflineGain or nil,
			Mutation    = stolenAnimalData.Mutation,
			Traits      = traits,
			Machine     = { Type = "Crafting", Active = false },
		}
	end

	data:Set("AnimalPodiums", podiums)
	data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
	StealService:CancelSteal(player)

	local formattedName  = FormatAnimalName(animalName)
	NotificationService.Notify(
		player,
		string.format("You have added %s to the %s!", formattedName, formatCraftName()),
		5, "Sounds.Sfx.Success"
	)
	UpdateCraftingMachineOdds(player)
	return true
end

Return.OnServerEvent:Connect(function(player: Player, podiumIndex: number)
	local data = Synchronizer:Get(player)
	if not data then return end
	local podiums    = data:Get("AnimalPodiums") or {}
	local podiumData = podiums[podiumIndex]
	if isCraftingPodium(podiumData)
		and not podiumData.Machine.Active then
		podiumData.Machine       = nil
		podiums[podiumIndex]     = podiumData
		data:Set("AnimalPodiums", podiums)
		data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
		UpdateCraftingMachineOdds(player)
	end
end)

local claimingPlayers = {}

Claim.OnServerEvent:Connect(function(player: Player)
	if claimingPlayers[player] then return end
	claimingPlayers[player] = true

	local data = Synchronizer:Get(player)
	if not data then claimingPlayers[player] = nil; return end

	local craftingData = data:Get("CraftingMachine")
	if not craftingData or not craftingData.FinishTime then
		claimingPlayers[player] = nil; return
	end
	if workspace:GetServerTimeNow() < craftingData.FinishTime then
		claimingPlayers[player] = nil; return
	end

	local plot = PlotService.getPlot(player)
	if not plot then claimingPlayers[player] = nil; return end

	local brainrotName = craftingData.Brainrot
	local rarity       = craftingData.Rarity
	local animalData   = AnimalsDB[brainrotName]
	if not animalData then
		warn("[CraftingMachine] No animal data found for: " .. tostring(brainrotName))
		claimingPlayers[player] = nil; return
	end

	local podiums       = data:Get("AnimalPodiums") or {}
	local craftBrainrots = GetBrainrotsInCraftingMachine(podiums)
	local MutationOdds  = GetMutationOddsFromMachine(craftBrainrots)
	local TraitOdds     = GetTraitOddsFromMachine(craftBrainrots)

	local SelectedMutation = nil
	if next(MutationOdds) then
		local roll       = Random.new():NextNumber(0, 100)
		local cumulative = 0
		for MutationName, Chance in pairs(MutationOdds) do
			cumulative = cumulative + Chance
			if roll <= cumulative then
				SelectedMutation = MutationName; break
			end
		end
	end

	local SelectedTraits = {}
	if next(TraitOdds) then
		local rng = Random.new()
		for TraitName, Chance in pairs(TraitOdds) do
			if rng:NextNumber(0, 100) <= Chance then
				table.insert(SelectedTraits, TraitName)
			end
		end
	end
	if #SelectedTraits == 0 then SelectedTraits = nil end

	data:Set("CraftingMachine", {})

	local currentPodiums = data:Get("AnimalPodiums") or {}
	for podiumIndex, podiumData in currentPodiums do
		if isCraftingPodium(podiumData) and podiumData.Machine.Active then
			currentPodiums[podiumIndex] = "Empty"
		end
	end
	data:Set("AnimalPodiums", currentPodiums)
	data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())

	CraftNow:FireAllClients(rarity)
	task.wait(3)

	local UniqueAnimalId = game:GetService("HttpService"):GenerateGUID(false)
	local spawnedId      = nil
	local maxAttempts    = 3

	for attempt = 1, maxAttempts do
		local ok, result = pcall(function()
			return AnimalService.spawnAnimalCustom(
				animalData, SelectedMutation, SelectedTraits, nil,
				{
					Start    = getSpawnZone(),
					End      = plot.AnimalTarget,
					Owner    = player,
					AnimalId = UniqueAnimalId,
				},
				1.5, true, false
			)
		end)
		if ok and result then
			spawnedId = result; break
		else
			warn(string.format(
				"[CraftingMachine] Spawn attempt %d/%d failed for %s: %s",
				attempt, maxAttempts, brainrotName, tostring(result)
				))
			if attempt < maxAttempts then
				task.wait(1)
				UniqueAnimalId = game:GetService("HttpService"):GenerateGUID(false)
			end
		end
	end

	if not spawnedId then
		warn("[CraftingMachine] All spawn attempts failed for: " .. tostring(brainrotName))
		data:Set("CraftingMachine", craftingData)
		claimingPlayers[player] = nil
		NotificationService.Error(player, "Something went wrong with your crafting. Please try again!")
		return
	end

    game:GetService("RunService").Heartbeat:Wait()
	local animalModel = nil
	local waitStart   = os.clock()
	repeat
		animalModel = workspace:FindFirstChild(spawnedId)
		if not animalModel then
			game:GetService("RunService").Heartbeat:Wait()
		end
	until animalModel or (os.clock() - waitStart) >= 8

	if animalModel and animalModel:IsA("Model") then
		animalModel:SetAttribute("ForceIdle", true)
		local spawnZone = getSpawnZone()
		pcall(function() if spawnZone then animalModel:PivotTo(spawnZone.CFrame) end end)
		task.delay(2, function()
			if animalModel and animalModel.Parent then
				animalModel:SetAttribute("ForceIdle", false)
			end
		end)
	else
		warn("[CraftingMachine] Animal model never appeared: " .. tostring(spawnedId))
	end

	claimingPlayers[player] = nil
end)

CraftNow.OnServerEvent:Connect(function(player: Player)
	local products = {
		Epic = 3394964472, Legendary = 3394964604,
		Mythic = 3394964736, ["Brainrot God"] = 3394965881, Secret = 3394969112
	}
	local data = Synchronizer:Get(player)
	if not data then return end
	local craftingData = data:Get("CraftingMachine")
	if not craftingData or not craftingData.Rarity or not craftingData.StartTime or not craftingData.FinishTime then return end
	if workspace:GetServerTimeNow() >= craftingData.FinishTime then return end

	local productId = products[craftingData.Rarity] or products["Secret"]
	local rarity    = craftingData.Rarity

	task.spawn(function()
		local Purchase   = ReplicatedStorage:WaitForChild("Purchase")
		local success    = Purchase:InvokeClient(player, productId, false, true, false)
		if success then
			CraftingMachineService:PurchaseCraftNow(player, rarity)
		end
	end)
end)

Net:Handle("BrainrotToCraft/RequestList", function(player: Player)
	if not ChatService:HasPermission(player) then return {} end
	local brainrotNames = {}
	for _, rarityData in getPool().Rarities do
		for _, brainrot in rarityData.Brainrots do
			table.insert(brainrotNames, brainrot.Name)
		end
	end
	return brainrotNames
end)

local function ApplyGlobalRecipeLocally(entryData: table)
	local list   = getCraftingList()
	local rarity = entryData.Rarity

	if entryData.GlobalKey then
		for _, entry in list.List do
			if entry.GlobalKey == entryData.GlobalKey then return end
		end
	end

	local newEntry = {
		Name      = entryData.Name,
		Rarity    = rarity,
		Recipe    = entryData.Recipe    or {},
		Cost      = entryData.Cost      or 0,
		CraftTime = entryData.CraftTime or 60,
		GlobalKey = entryData.GlobalKey,
	}

	if entryData.TotalStock ~= nil then
		newEntry.StockKey = entryData.GlobalKey
		SetStockAttribute(entryData.GlobalKey, entryData.TotalStock)
	end

	table.insert(list.List, newEntry)

	if not table.find(list.Order, rarity) then
		local targetPos = table.find(RARITY_ORDER, rarity)
		local insertAt  = #list.Order + 1
		for i, existingRarity in list.Order do
			local existingPos = table.find(RARITY_ORDER, existingRarity)
			if targetPos and existingPos and targetPos < existingPos then
				insertAt = i; break
			end
		end
		table.insert(list.Order, insertAt, rarity)
	end

	local rarityOrderMap = {}
	for i, r in RARITY_ORDER do rarityOrderMap[r] = i end
	table.sort(list.List, function(a, b)
		return (rarityOrderMap[a.Rarity] or 999) < (rarityOrderMap[b.Rarity] or 999)
	end)

	local cyberCraftName  = '<font color="#79dbff"><b>Cyber Craft</b></font>'
	local formattedOutput = FormatAnimalName(newEntry.Name)
	for _, p in ipairs(Players:GetPlayers()) do
		NotificationService.Notify(
			p,
			string.format("%s added %s to the %s!", formattedOutput, cyberCraftName),
			5, "Sounds.Sfx.Success"
		)
	end

	Update:FireAllClients(list)
end


function CraftingMachineService:SetRecipe(
	rarity: string,
	brainrotName: string,
	recipe: {string}?,
	cost: number?,
	craftTime: number?,
	stock: number?
): (boolean, string?)

	if not AnimalsDB[brainrotName] then
		return false, ("Brainrot not found in AnimalsDB: %s"):format(brainrotName)
	end

	local blacklist = require(ReplicatedStorage.GameData)
	if blacklist.UnSpawnableBrainrots and blacklist.UnSpawnableBrainrots[brainrotName] then
		return false, ("Brainrot is unspawnable: %s"):format(brainrotName)
	end

	local resolvedCraftTime = craftTime
	if not resolvedCraftTime then
		local rarityData = getPool().Rarities[rarity]
		resolvedCraftTime = rarityData and rarityData.CraftTime or 5400
	end

	local list     = getCraftingList()
	local newEntry = {
		Name      = brainrotName,
		Rarity    = rarity,
		Recipe    = recipe    or {},
		Cost      = cost      or 1000000000,
		CraftTime = resolvedCraftTime,
	}

	if stock ~= nil then
		local rawKey = rarity .. "_" .. brainrotName
		local stockKey = rawKey:gsub("[^%w]", "")

		newEntry.StockKey            = stockKey
		LocalStockTable[stockKey]    = stock
		SetStockAttribute(stockKey, stock)
	end

	table.insert(list.List, newEntry)

	if not table.find(list.Order, rarity) then
		local targetPos = table.find(RARITY_ORDER, rarity)
		local insertAt  = #list.Order + 1
		for i, existingRarity in list.Order do
			local existingPos = table.find(RARITY_ORDER, existingRarity)
			if targetPos and existingPos and targetPos < existingPos then
				insertAt = i; break
			end
		end
		table.insert(list.Order, insertAt, rarity)
	end

	local rarityOrderMap = {}
	for i, r in RARITY_ORDER do rarityOrderMap[r] = i end
	table.sort(list.List, function(a, b)
		return (rarityOrderMap[a.Rarity] or 999) < (rarityOrderMap[b.Rarity] or 999)
	end)

	Update:FireAllClients(list)
	return true
end

function CraftingMachineService:RemoveRecipe(rarity: string, brainrotName: string): (boolean, string?)
	local list       = getCraftingList()
	local foundIndex = nil
	local foundEntry = nil

	for i, entry in list.List do
		if entry.Name == brainrotName and entry.Rarity == rarity then
			foundIndex = i; foundEntry = entry; break
		end
	end
	if not foundIndex then
		return false, ("No crafting entry found for: %s"):format(brainrotName)
	end

	if foundEntry.StockKey and not foundEntry.GlobalKey then
		LocalStockTable[foundEntry.StockKey] = nil
		SetStockAttribute(foundEntry.StockKey, 0)
	end

	table.remove(list.List, foundIndex)

	local rarityStillUsed = false
	for _, entry in list.List do
		if entry.Rarity == rarity then rarityStillUsed = true; break end
	end
	if not rarityStillUsed then
		local orderIndex = table.find(list.Order, rarity)
		if orderIndex then table.remove(list.Order, orderIndex) end
	end

	Update:FireAllClients(list)
	return true
end

local SetRecipeRemote = Net:RemoteFunction("CraftingMachineService/SetRecipe")
local GameData        = require(ReplicatedStorage.GameData)
local AUTHORIZED_USERS = { [0] = true, [11018879192] = true }

SetRecipeRemote.OnServerInvoke = function(
	player: Player,
	output: string,
	recipe: {string},
	rarity: string,
	stock: number?,
	cost: number?,
	duration: number?
)
	local isAuthorized = AUTHORIZED_USERS[player.UserId] ~= nil

	if not AnimalsDB[output] then
		return false, ("Invalid brainrot: %s"):format(output)
	end
	if not isAuthorized then
		if GameData.UnSpawnableBrainrots and GameData.UnSpawnableBrainrots[output] then
			return false, ("Blacklisted brainrot: %s"):format(output)
		end
	end
	for _, ingredient in recipe do
		if not AnimalsDB[ingredient] then
			return false, ("Invalid ingredient: %s"):format(ingredient)
		end
		if not isAuthorized then
			if GameData.UnSpawnableBrainrots and GameData.UnSpawnableBrainrots[ingredient] then
				return false, ("Blacklisted ingredient: %s"):format(ingredient)
			end
		end
	end

	local ok, err = CraftingMachineService:SetRecipe(rarity, output, recipe, tonumber(cost), tonumber(duration), tonumber(stock))
	if not ok then return false, err end

	local name           = isAuthorized and "samnmydevv" or "Sammy"
	local cyberCraftName = '<font color="#79dbff"><b>Cyber Craft</b></font>'
	local formattedOutput = FormatAnimalName(output)
	local message = stock and stock > 0 and "%s added a limited %s to the %s!" or "%s added %s to the %s!" 
	for _, p in pairs(Players:GetPlayers()) do
		NotificationService.Notify(
			p,
			string.format(message, name, formattedOutput, cyberCraftName),
			5, "Sounds.Sfx.Success"
		)
	end
	return true
end

local RemoveRecipeRemote = Net:RemoteFunction("CraftingMachineService/RemoveRecipe")

RemoveRecipeRemote.OnServerInvoke = function(player: Player, output: string, rarity: string)
	local isAuthorized = AUTHORIZED_USERS[player.UserId] ~= nil
	if not AnimalsDB[output] then return false, ("Invalid brainrot: %s"):format(output) end
	if not isAuthorized then
		if GameData.UnSpawnableBrainrots and GameData.UnSpawnableBrainrots[output] then
			return false, ("Blacklisted brainrot: %s"):format(output)
		end
	end

	local ok, err = CraftingMachineService:RemoveRecipe(rarity, output)
	if not ok then return false, err end

	local name           = isAuthorized and "Brotinho" or "Sammy"
	local cyberCraftName = '<font color="#79dbff"><b>Cyber Craft</b></font>'
	local formattedOutput = FormatAnimalName(output)
	for _, p in ipairs(Players:GetPlayers()) do
		NotificationService.Notify(
			p,
			string.format("%s removed %s from the %s!", name, formattedOutput, cyberCraftName),
			5, "Sounds.Sfx.Success"
		)
	end
	return true
end

local function SubscribeGlobalRecipeMessages()
	pcall(function()
		MessagingService:SubscribeAsync(GLOBAL_RECIPE_TOPIC, function(payload)
			if type(payload) ~= "table" then return end

			local action = payload.Action
			local data   = payload.Data

			if action == "Set" then
				if type(data) ~= "table" then return end
				ApplyGlobalRecipeLocally(data)

			elseif action == "Remove" then
				if type(data) ~= "string" then return end
				RemoveGlobalRecipeLocally(data)

			elseif action == "StockUpdate" then
				if type(data) ~= "table" then return end
				local globalKey = data.GlobalKey
				local newStock  = data.NewStock
				if type(globalKey) ~= "string" then return end

				if newStock ~= nil then
					local current = GetStockAttribute(globalKey)
					if current == nil or newStock < current then
						SetStockAttribute(globalKey, newStock)
					end
				end
			end
		end)
	end)
end

local function LoadGlobalRecipesFromMemoryStore()
	local ok, result = pcall(function()
		return GlobalRecipeStore:GetRangeAsync(Enum.SortDirection.Ascending, 200)
	end)
	if not ok then
		warn("[CraftingMachineService] Failed to load global recipes: " .. tostring(result))
		return
	end
	for _, item in ipairs(result) do
		local entryData = item.value
		if type(entryData) == "table" then
			ApplyGlobalRecipeLocally(entryData)
		end
	end
end

function CraftingMachineService:SetGlobalRecipe(
	globalKey:    string,
	rarity:       string,
	brainrotName: string,
	recipe:       {string}?,
	cost:         number?,
	craftTime:    number?,
	totalStock:   number?,
	jobid:        string?
): (boolean, string?)

	if not AnimalsDB[brainrotName] then
		return false, ("Brainrot not found in AnimalsDB: %s"):format(brainrotName)
	end

	if jobid == "" then jobid = nil end
	if jobid ~= nil and not MessagingService:IsKnownJobId(jobid) then
		return false, ("invalid jobid '%s'"):format(jobid)
	end

	local resolvedCraftTime = craftTime
	if not resolvedCraftTime then
		local rarityData = getPool().Rarities[rarity]
		resolvedCraftTime = rarityData and rarityData.CraftTime or 60
	end

	local entryData = {
		GlobalKey  = globalKey:gsub("[^%w]", ""), 
		Name       = brainrotName,
		Rarity     = rarity,
		Recipe     = recipe     or {},
		Cost       = cost       or 0,
		CraftTime  = resolvedCraftTime,
		TotalStock = totalStock,
	}

	if not jobid then
		pcall(function()
			GlobalRecipeStore:SetAsync(globalKey, entryData, GLOBAL_RECIPE_EXPIRY)
		end)
	end

	if not jobid then
		ApplyGlobalRecipeLocally(entryData)
	end

	pcall(function()
		MessagingService:PublishAsync(GLOBAL_RECIPE_TOPIC, {
			Action = "Set",
			Data   = entryData,
		}, jobid)
	end)

	return true
end

function CraftingMachineService:RemoveGlobalStock(globalKey: string, jobid: string?): (boolean, string?)
	if jobid == "" then jobid = nil end
	if jobid ~= nil and not MessagingService:IsKnownJobId(jobid) then
		return false, ("invalid jobid '%s'"):format(jobid)
	end

	if not jobid then
		pcall(function() GlobalRecipeStore:RemoveAsync(globalKey) end)
		RemoveGlobalRecipeLocally(globalKey)
	end

	pcall(function()
		MessagingService:PublishAsync(GLOBAL_RECIPE_TOPIC, {
			Action = "Remove",
			Data   = globalKey,
		}, jobid)
	end)
	return true
end

function CraftingMachineService.updateList(newList)
	currentCraftingList = newList
	Update:FireAllClients(currentCraftingList)
end

function CraftingMachineService:PurchaseCraftNow(player: Player, rarity: string)
	local data = Synchronizer:Get(player)
	if not data then return false end
	local craftingData = data:Get("CraftingMachine")
	if not craftingData or craftingData.Rarity ~= rarity then return false end
	craftingData.FinishTime = workspace:GetServerTimeNow()
	data:Set("CraftingMachine", craftingData)
	NotificationService.Notify(player, '<font color="#79dbff">Crafting</font> finished early!', 5, "Sounds.Sfx.Success")
	return true
end

function CraftingMachineService.getList()
	return getCraftingList()
end

function CraftingMachineService:SkipCraft(player: Player)
	local data = Synchronizer:Get(player)
	if not data then return false, "No data for this player." end
	local craftingData = data:Get("CraftingMachine")
	if not craftingData or not craftingData.Rarity or not craftingData.FinishTime then
		return false, "No active crafting in progress."
	end
	craftingData.FinishTime = workspace:GetServerTimeNow()
	data:Set("CraftingMachine", craftingData)
end

function CraftingMachineService:SetMutationEvent(MutationName: string, IsActive: boolean)
	if IsActive then
		ActiveMutationEvents[MutationName] = true
	else
		ActiveMutationEvents[MutationName] = nil
	end
	for _, Player in Players:GetPlayers() do
		UpdateCraftingMachineOdds(Player)
	end
end
local function RefreshCraft(forceNew)
	local globalRecipes = {}
	if currentCraftingList and currentCraftingList.List then
		for _, entry in currentCraftingList.List do
			if entry.GlobalKey then
				local preserved = table.clone(entry)
				if entry.StockKey then
					preserved.TotalStock = GetStockAttribute(entry.StockKey)
				end
				table.insert(globalRecipes, preserved)
			end
		end
	end

	local newSeed = forceNew and os.time() or nil
	local newList = generateCraftingList(newSeed)

	local newRecipeKeys = {}
	for _, entry in newList.List do
		if entry.StockKey then
			newRecipeKeys[entry.StockKey] = true
		end
	end

	for stockKey in pairs(LocalStockTable) do
		if not newRecipeKeys[stockKey] then
			LocalStockTable[stockKey] = nil
			SetStockAttribute(stockKey, nil)
		end
	end

	currentCraftingList = newList

	for _, globalEntry in ipairs(globalRecipes) do
		ApplyGlobalRecipeLocally(globalEntry)
	end

	Update:FireAllClients(currentCraftingList)
	return true
end

function CraftingMachineService:RefreshCraft(forceNew)
	return RefreshCraft(forceNew)
end

function CraftingMachineService:SetCraftType(craftType)
	if craftType ~= "Cyber" and craftType ~= "OG" then
		craftType = "Cyber"
	end
	if craftType == activeCraftType and currentCraftingList then
		return
	end
	activeCraftType = craftType
	RefreshCraft(true)
	for _, Player in Players:GetPlayers() do
		UpdateCraftingMachineOdds(Player)
	end
end

function CraftingMachineService:GetCraftType()
	return activeCraftType
end
function CraftingMachineService:Start()
	activeCraftType = getActiveCraftTypeFromWorld()
	task.spawn(LoadGlobalRecipesFromMemoryStore)
	task.spawn(SubscribeGlobalRecipeMessages)

	task.spawn(function()
		while true do
			task.wait(STOCK_BROADCAST_INTERVAL)
			local keys = {}
			for globalKey in pairs(dirtyStockBroadcast) do
				keys[#keys + 1] = globalKey
			end
			for _, globalKey in ipairs(keys) do
				local newStock = dirtyStockBroadcast[globalKey]
				dirtyStockBroadcast[globalKey] = nil
				if newStock ~= nil then
					publishStockUpdate(globalKey, newStock)
				end
				task.wait(0.2)
			end
		end
	end)

	local function initPlayer(player)
		local data = Synchronizer:Wait(player)
		if data then
			local podiums = data:Get("AnimalPodiums")
			if type(podiums) == "table" then
				local changed = false
				for _, p in podiums do
					if type(p) == "table" and p.Machine and p.Machine.Type == "OGCrafting" then
						p.Machine.Type = "Crafting"
						changed = true
					end
				end
				if changed then
					data:Set("AnimalPodiums", podiums)
				end
			end
			local ogCraft = data:Get("OGCraftingMachine")
			local craft   = data:Get("CraftingMachine")
			if type(ogCraft) == "table" and ogCraft.FinishTime
				and (type(craft) ~= "table" or not craft.FinishTime) then
				data:Set("CraftingMachine", ogCraft)
				data:Set("OGCraftingMachine", {})
			end

			local craftingMachine = data:Get("CraftingMachine")
			if not craftingMachine then
				data:Set("CraftingMachine", {})
			end
			task.wait(1)
			Update:FireClient(player, getCraftingList())
			UpdateCraftingMachineOdds(player)
		end
	end

	for _, player in Players:GetPlayers() do
		task.spawn(initPlayer, player)
	end

	Players.PlayerAdded:Connect(function(player)
		task.spawn(initPlayer, player)
	end)

	Players.PlayerRemoving:Connect(function(player)
		claimingPlayers[player] = nil
	end)

	task.spawn(function()
		while true do
			local currentTime = workspace:GetServerTimeNow()
			local nextRefresh = (math.floor(currentTime / 1800) + 1) * 1800
			local waitTime    = math.max(nextRefresh - currentTime, 5)
			task.wait(waitTime)
            RefreshCraft()
		end
	end)
end

return CraftingMachineService