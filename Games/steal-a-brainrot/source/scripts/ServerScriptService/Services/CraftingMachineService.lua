local CraftingMachineService = {} -- CRAFT_INHERITANCE_v1

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local MessagingService = game:GetService("MessagingService")
local MemoryStoreService = game:GetService("MemoryStoreService")
local DataStoreService = game:GetService("DataStoreService")

-- ===== BLOCAGE MEOWL =====
local BLOCKED_CRAFT_ANIMALS = {}
local DELETE_RANGE = 50

local PlotService = require(ServerScriptService.Services.PlotService)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local StealService = require(ServerScriptService.Services.StealService)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)
local CraftingData = require(ServerStorage.Modules.CraftingData)
local AnimalsDB = require(ReplicatedStorage.Datas.Animals)
local Rarities = require(ReplicatedStorage.Datas.Rarities)

local currentCraftingList = nil
local customRecipes = {}
local customRecipeCounter = 0
local autoGenerationEnabled = true

local recipeStore = MemoryStoreService:GetSortedMap("CustomRecipes")
local LimitedStockStore = DataStoreService:GetDataStore("LimitedCraftStock_v1")

-- ===== SOURCE DE VÉRITÉ GLOBALE =====
-- GlobalStockMap est partagé entre TOUS les serveurs en temps réel via MemoryStoreService.
-- UpdateAsync est atomique cross-serveur : impossible de consommer le même slot deux fois.
-- localStockCache = cache d'affichage uniquement, mis à jour via MessagingService.
local GlobalStockMap = MemoryStoreService:GetSortedMap("GlobalLimitedStock_v2")

local LIMITED_ATTR_PREFIX = "LimitedStock_"
local localStockCache = {}   -- rarity -> number (affichage uniquement)
local craftingInProgress = {} -- userId -> bool (anti double-clic local)

local CraftNow = Net:RemoteEvent("CraftingMachineService/CraftNow")
local Update = Net:RemoteEvent("CraftingMachineService/Update")
local Return = Net:RemoteEvent("CraftingMachineService/Return")
local Claim = Net:RemoteEvent("CraftingMachineService/Claim")
local Delivery = Net:RemoteFunction("CraftingMachineService/Delivery")
local Start = Net:RemoteFunction("CraftingMachineService/Start")
local Fetch = Net:RemoteFunction("CraftingMachineService/Fetch")
local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

local ShopService = require(ServerScriptService.Services.ShopService)

local MAX_SECRET_RECIPES = 1
local secretOverrideSeed = nil
local normalRecipeSeed = nil  -- nil = utilise le seed temporel normal

-- ===== HELPERS GLOBAL STOCK =====

local function getGlobalKey(rarity: string): string
	return "GStock_" .. rarity
end

local function readGlobalStock(rarity: string): number?
	local ok, val = pcall(function()
		return GlobalStockMap:GetAsync(getGlobalKey(rarity))
	end)
	if ok and type(val) == "number" then
		return val
	end
	return nil
end

-- Met à jour le cache local + attribut ReplicatedStorage + liste clients + broadcast aux autres serveurs
local function broadcastStockUpdate(rarity: string, newStock: number)
	localStockCache[rarity] = newStock
	ReplicatedStorage:SetAttribute(LIMITED_ATTR_PREFIX .. rarity, newStock)
	pcall(function()
		MessagingService:PublishAsync("GlobalStockBroadcast", {
			Rarity = rarity,
			Stock = newStock,
		})
	end)
	if getCraftingList then
		currentCraftingList = getCraftingList()
		Update:FireAllClients(currentCraftingList)
	end
end

local function persistStock(rarity: string, stock: number)
	pcall(function()
		LimitedStockStore:SetAsync("LimitedCraft_" .. rarity, stock)
	end)
end

-- Initialise le stock dans MemoryStore (uniquement si pas encore défini, sauf forceReset)
local function initGlobalStock(rarity: string, defaultStock: number, forceReset: boolean?)
	if forceReset then
		pcall(function()
			GlobalStockMap:SetAsync(getGlobalKey(rarity), defaultStock, 86400)
		end)
		localStockCache[rarity] = defaultStock
		ReplicatedStorage:SetAttribute(LIMITED_ATTR_PREFIX .. rarity, defaultStock)
		persistStock(rarity, defaultStock)
		print(string.format("[GlobalStock] FORCE RESET: %s | Stock=%d", rarity, defaultStock))
		return
	end

	local existing = readGlobalStock(rarity)
	if existing ~= nil then
		localStockCache[rarity] = existing
		ReplicatedStorage:SetAttribute(LIMITED_ATTR_PREFIX .. rarity, existing)
		print(string.format("[GlobalStock] INIT SKIPPED: %s | Already at %d", rarity, existing))
		return
	end

	local ok, err = pcall(function()
		GlobalStockMap:SetAsync(getGlobalKey(rarity), defaultStock, 86400)
	end)
	if ok then
		localStockCache[rarity] = defaultStock
		ReplicatedStorage:SetAttribute(LIMITED_ATTR_PREFIX .. rarity, defaultStock)
		persistStock(rarity, defaultStock)
		print(string.format("[GlobalStock] INIT: %s | Stock=%d", rarity, defaultStock))
	else
		warn("[GlobalStock] initGlobalStock error:", err)
		-- Fallback: set l'attribut RS même si MemoryStore échoue
		localStockCache[rarity] = defaultStock
		ReplicatedStorage:SetAttribute(LIMITED_ATTR_PREFIX .. rarity, defaultStock)
		persistStock(rarity, defaultStock)
		warn("[GlobalStock] Fallback stock set:", rarity, defaultStock)
	end
end

-- Décrémente le stock de façon ATOMIQUE (thread-safe cross-serveur via UpdateAsync)
-- Retourne (success, newStock)
local function tryConsumeGlobalStock(rarity: string): (boolean, number)
	local newStock = nil
	local ok, err = pcall(function()
		newStock = GlobalStockMap:UpdateAsync(getGlobalKey(rarity), function(currentStock)
			if currentStock == nil or currentStock <= 0 then
				return nil  -- annuler = sold out
			end
			return currentStock - 1
		end, 86400)
	end)

	if not ok then
		warn("[GlobalStock] tryConsumeGlobalStock error:", err)
	-- Fallback: utiliser le cache local si MemoryStore indisponible
	local cached = localStockCache[rarity]
	if type(cached) == 'number' and cached > 0 then
		localStockCache[rarity] = cached - 1
		ReplicatedStorage:SetAttribute(LIMITED_ATTR_PREFIX .. rarity, cached - 1)
		return true, cached - 1
	end
		return false, -1
	end

	if newStock == nil then
		-- UpdateAsync a annulé = sold out
		return false, 0
	end

	return true, newStock
end

-- Remet +1 dans le stock (si craft échoue après consommation)
local function restoreGlobalStock(rarity: string): number
	local newStock = nil
	local ok, err = pcall(function()
		newStock = GlobalStockMap:UpdateAsync(getGlobalKey(rarity), function(currentStock)
			if currentStock == nil then return nil end
			return currentStock + 1
		end, 86400)
	end)
	if not ok then
		warn("[GlobalStock] restoreGlobalStock error:", err)
		return -1
	end
	return newStock or -1
end

local function clearGlobalStock(rarity: string)
	localStockCache[rarity] = nil
	ReplicatedStorage:SetAttribute(LIMITED_ATTR_PREFIX .. rarity, nil)
	pcall(function() GlobalStockMap:RemoveAsync(getGlobalKey(rarity)) end)
	pcall(function() LimitedStockStore:RemoveAsync("LimitedCraft_" .. rarity) end)
end

function CraftingMachineService.getLimitedStock(rarity: string): number?
	return localStockCache[rarity]
end

-- ===== FIN HELPERS GLOBAL STOCK =====

local function getCraftingList()
	local currentTime = workspace:GetServerTimeNow()
	local refreshInterval = 1800
	local listSeed = normalRecipeSeed or math.floor(currentTime / refreshInterval)
	local rng = Random.new(listSeed)
	local craftingList = {
		List = {},
		Refresh = (math.floor(currentTime / refreshInterval) + 1) * refreshInterval
	}
	local usedBrainrots = {}
	local customRarities = {}
	local secretCount = 0

	for key, customRecipe in pairs(customRecipes) do
		craftingList.List[key] = table.clone(customRecipe)
		local stock = CraftingMachineService.getLimitedStock(key)
		if stock ~= nil then
			craftingList.List[key].LimitedStock = stock
		end
		for _, requiredAnimal in customRecipe.Recipe do
			usedBrainrots[requiredAnimal] = true
		end
		-- Ne pas compter les recettes limitées comme des raretés custom
		-- car elles ont un prefix "Limited_"
		if not string.find(key, "_") then
			customRarities[key] = true
			if key == "Secret" or string.sub(key, 1, 6) == "Secret" then
				secretCount = secretCount + 1
			end
		end
	end

	if not autoGenerationEnabled then
		return craftingList
	end

	for rarity, rarityData in CraftingData.Rarities do
		if customRarities[rarity] then continue end
		if #rarityData.Brainrots == 0 then continue end -- skip raretés vides (ex: OG sans recettes)
		if #rarityData.Brainrots > 0 then
			local maxRecipes = 1
			if rarity == "Secret" then
				maxRecipes = math.max(1, MAX_SECRET_RECIPES - secretCount)
			end
			for recipeNum = 1, maxRecipes do
				local availableBrainrots = {}
				for _, brainrot in rarityData.Brainrots do
					table.insert(availableBrainrots, brainrot) -- pas de vérification conflit
				end
				if #availableBrainrots > 0 then
					local selectedBrainrot = availableBrainrots[rng:NextInteger(1, #availableBrainrots)]
					for _, requiredAnimal in selectedBrainrot.Recipe do
						usedBrainrots[requiredAnimal] = true
					end
					local listKey = rarity
					if rarity == "Secret" and recipeNum > 1 then
						listKey = "Secret_" .. tostring(recipeNum)
					end
					craftingList.List[listKey] = {
						Name = selectedBrainrot.Name,
						Recipe = selectedBrainrot.Recipe,
						Cost = selectedBrainrot.Cost,
						CraftTime = rarityData.CraftTime
					}
				end
			end
		end
	end
	return craftingList
end

local function skipAllCraftsLocal()
	local skippedCount = 0
	for _, player in ipairs(Players:GetPlayers()) do
		local data = Synchronizer:Get(player)
		if data then
			local craftingData = data:Get("CraftingMachine")
			if craftingData and craftingData.Rarity and craftingData.FinishTime then
				if workspace:GetServerTimeNow() < craftingData.FinishTime then
					craftingData.FinishTime = workspace:GetServerTimeNow() - 1
					data:Set("CraftingMachine", craftingData)
					CraftNow:FireClient(player, craftingData.Rarity)
					NotificationEvent:FireClient(player,
						'<font color="#00FF00"><b>Your craft is ready!</b></font> You can now claim it!',
						5, "Sounds.Sfx.Success", "Down")
					skippedCount += 1
				end
			end
		end
	end
	return skippedCount
end

local function loadPersistedRecipes()
	pcall(function()
		local saved = recipeStore:GetAsync("Secret")
		if saved then customRecipes["Secret"] = saved end
		local savedAuto = recipeStore:GetAsync("autoGenerationEnabled")
		if savedAuto ~= nil then autoGenerationEnabled = savedAuto end
	end)
end

local function listenCrossServer()
	pcall(function()
		if not _G._sub_CraftingMachineService then _G._sub_CraftingMachineService = true
		pcall(function()
		MessagingService:SubscribeAsync("RecipeUpdate", function(message)
			local data = message.Data
			if not data then return end

			if data.Action == "setCustomRecipe" and data.Rarity and data.Recipe then
				customRecipes[data.Rarity] = data.Recipe
				-- Lire le vrai stock depuis MemoryStore pour le cache local
				if data.LimitedStock and data.LimitedStock > 0 then
					local realStock = readGlobalStock(data.Rarity)
					if realStock ~= nil then
						localStockCache[data.Rarity] = realStock
						ReplicatedStorage:SetAttribute(LIMITED_ATTR_PREFIX .. data.Rarity, realStock)
					end
				end
				currentCraftingList = getCraftingList()
				Update:FireAllClients(currentCraftingList)
				if data.ExecutorName and data.BrainrotName then
					local msg = string.format('<font color="#FFD700">%s</font> added <font color="#FF69B4">%s</font> as a limited in <font color="#00FFFF">%s</font>!',
						data.ExecutorName, data.BrainrotName, data.Rarity)
					for _, player in ipairs(Players:GetPlayers()) do
						NotificationService.Notify(player, msg, 8, "Sounds.Sfx.Success")
					end
				end

			elseif data.Action == "removeCustomRecipe" and data.Rarity then
				customRecipes[data.Rarity] = nil
				currentCraftingList = getCraftingList()
				Update:FireAllClients(currentCraftingList)

			elseif data.Action == "clearAllRecipes" then
				customRecipes = {}
				currentCraftingList = {List = {}, Refresh = 0}
				Update:FireAllClients(currentCraftingList)

			elseif data.Action == "setAutoGeneration" and data.Enabled ~= nil then
				autoGenerationEnabled = data.Enabled
				currentCraftingList = getCraftingList()
				Update:FireAllClients(currentCraftingList)
			end
		end)
		end) end
	end)

	pcall(function()
		MessagingService:SubscribeAsync("SkipAllCrafts", function()
			skipAllCraftsLocal()
		end)
	end)

	pcall(function()
		MessagingService:SubscribeAsync("GLOBAL_SECRET_REFRESH", function(message)
			for rarity in pairs(customRecipes) do clearGlobalStock(rarity) end
			customRecipes = {}
			if message.Data and message.Data.seed then
				secretOverrideSeed = message.Data.seed
			end
			currentCraftingList = getCraftingList()
			Update:FireAllClients(currentCraftingList)
		end)
	end)

	-- Réception des broadcasts de stock des AUTRES serveurs
	-- Met uniquement à jour le cache local + affichage, pas le MemoryStore
	pcall(function()
		MessagingService:SubscribeAsync("GlobalStockBroadcast", function(message)
			local data = message.Data
			if not data or not data.Rarity or data.Stock == nil then return end
			local rarity = data.Rarity
			local newStock = data.Stock

			localStockCache[rarity] = newStock
			ReplicatedStorage:SetAttribute(LIMITED_ATTR_PREFIX .. rarity, newStock)

			print(string.format("[GlobalStock] BROADCAST RECEIVED: %s | Stock=%d", rarity, newStock))

			currentCraftingList = getCraftingList()
			Update:FireAllClients(currentCraftingList)
		end)
	end)
end

Fetch.OnServerInvoke = function(player: Player)
	return getCraftingList()
end

Start.OnServerInvoke = function(player: Player, rarity: string, brainrotName: string)
	local data = Synchronizer:Get(player)
	if not data then return false end

	-- Anti double-clic : bloquer si ce joueur est déjà en train de crafter
	local userId = player.UserId
	if craftingInProgress[userId] then return false end
	craftingInProgress[userId] = true
	-- Timeout de sécurité: remettre à nil après 10s max
	task.delay(10, function()
		if craftingInProgress[userId] then
			craftingInProgress[userId] = nil
		end
	end)

	local success = false

	-- Scope pour pouvoir faire return proprement
	local function doStart()
		local craftingList = getCraftingList()
		local craftingItem = craftingList.List[rarity]
		if not craftingItem or craftingItem.Name ~= brainrotName then return end

		local coins = data:Get("Coins") or 0
		if coins < craftingItem.Cost then return end

		local podiums = data:Get("AnimalPodiums") or {}
		local available = {}
		for _, podiumData in podiums do
			if type(podiumData) == "table" and
				podiumData.Machine and
				podiumData.Machine.Type == "Crafting" and
				not podiumData.Machine.Active then
				local animalName = podiumData.Index
				available[animalName] = (available[animalName] or 0) + 1
			end
		end

		local required = {}
		for _, animalName in craftingItem.Recipe do
			required[animalName] = (required[animalName] or 0) + 1
		end
		for animalName, count in required do
			if (available[animalName] or 0) < count then return end
		end

		local currentCraft = data:Get("CraftingMachine")
		if currentCraft and currentCraft.StartTime and currentCraft.FinishTime and
			workspace:GetServerTimeNow() < currentCraft.FinishTime then
			return
		end

		-- ===== CONSOMMATION ATOMIQUE DU STOCK GLOBAL =====
		local isLimited = localStockCache[rarity] ~= nil
		-- Fallback: vérifier aussi l'attribut RS si cache local vide
		if not isLimited then
			local rsStock = game:GetService("ReplicatedStorage"):GetAttribute(LIMITED_ATTR_PREFIX .. rarity)
			isLimited = rsStock ~= nil
			if isLimited then
				localStockCache[rarity] = rsStock
			end
		end
		local consumed = false
		local stockAfterConsume = -1

		if isLimited then
			-- Vérif rapide sur le cache avant l'appel MemoryStore
			if (localStockCache[rarity] or 0) <= 0 then
				NotificationService.Error(player, "Sold Out! This limited recipe is no longer available.")
				return
			end

			-- UpdateAsync garantit qu'un seul joueur prend le dernier slot même en simultané cross-serveur
			local ok
			ok, stockAfterConsume = tryConsumeGlobalStock(rarity)
			if not ok then
				NotificationService.Error(player, "Sold Out! This limited recipe is no longer available.")
				return
			end
			consumed = true
			print(string.format("[GlobalStock] CONSUMED: %s | Player=%s | Stock restant=%d", rarity, player.Name, stockAfterConsume))
		end

		-- Re-lire les podiums après le MemoryStore pour l'état le plus frais
		podiums = data:Get("AnimalPodiums") or {}

		local toConsume = {}
		for _, animalName in craftingItem.Recipe do
			table.insert(toConsume, animalName)
		end

		for _, podiumData in podiums do
			if type(podiumData) == "table" and
				podiumData.Machine and
				podiumData.Machine.Type == "Crafting" and
				not podiumData.Machine.Active then
				local animalName = podiumData.Index
				local index = table.find(toConsume, animalName)
				if index then
					podiumData.Machine.Active = true
					table.remove(toConsume, index)
					if #toConsume == 0 then break end
				end
			end
		end

		if #toConsume ~= 0 then
			-- Animaux manquants → restituer le slot dans MemoryStore
			if consumed then
				local restored = restoreGlobalStock(rarity)
				if restored >= 0 then
					broadcastStockUpdate(rarity, restored)
					persistStock(rarity, restored)
					print(string.format("[GlobalStock] RESTORED (animal missing): %s | Stock=%d", rarity, restored))
				end
			end
			return
		end

		data:Set("Coins", coins - craftingItem.Cost)
		data:Set("AnimalPodiums", podiums)

		local currentTime = workspace:GetServerTimeNow()
		local craftTime = craftingItem.CraftTime
		if not craftTime or craftTime <= 0 then
			local rarityData = CraftingData.Rarities[rarity] or CraftingData.Rarities[craftingItem.OriginalRarity or ""]
			craftTime = (rarityData and rarityData.CraftTime) or 900
		end
		-- [CraftInheritance] Collecte mutations/traits des animaux dans la machine
		local _inMuts = {}
		local _inTraits = {}
		for _, _pd in (data:Get("AnimalPodiums") or {}) do
			if type(_pd)=="table" and _pd.Machine and _pd.Machine.Type=="Crafting" then
				if _pd.Mutation and _pd.Mutation~="" then table.insert(_inMuts,_pd.Mutation) end
				if type(_pd.Traits)=="table" then
					for _,_tr in ipairs(_pd.Traits) do
						local _d=false; for _,_e in ipairs(_inTraits) do if _e==_tr then _d=true break end end
						if not _d then table.insert(_inTraits,_tr) end
				end end end
		end
		data:Set("CraftingMachine", {
			Brainrot = brainrotName,
			Rarity = rarity,
			StartTime = currentTime,
			FinishTime = currentTime + craftTime,
			InputMutations = _inMuts,
			InputTraits = _inTraits
		})

		NotificationService.Notify(player, "Crafting started!", 5, "Sounds.Sfx.Success")

		if consumed then
			-- Broadcaster le nouveau stock à tous les serveurs
			broadcastStockUpdate(rarity, stockAfterConsume)
			persistStock(rarity, stockAfterConsume)
		else
			currentCraftingList = getCraftingList()
			Update:FireAllClients(currentCraftingList)
		end

		success = true
	end

	local startOk, startErr = pcall(doStart)
	if not startOk then
		warn('[CraftingMachine] doStart error:', startErr)
	end
	craftingInProgress[userId] = nil
	return success
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

	local craftingList = getCraftingList()
	local isRequired = false
	for rarity, craftData in craftingList.List do
		if craftData.Recipe then
			for _, requiredAnimal in craftData.Recipe do
				if requiredAnimal == animalName then
					isRequired = true
					break
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

	local podiums = data:Get("AnimalPodiums") or {}
	local stolenAnimalData = stealData.StolenAnimalData
	local traits = stolenAnimalData.Traits
	if traits and #traits == 0 then traits = nil end

	local originalPodiumIndex = stealData.PodiumIndex
	if originalPodiumIndex and podiums[originalPodiumIndex] then
		local existingPodium = podiums[originalPodiumIndex]
		existingPodium.Machine = { Type = "Crafting", Active = false }
		podiums[originalPodiumIndex] = existingPodium
	else
		local availableSlot = nil
		for i = 1, 50 do
			if not podiums[i] then availableSlot = i break end
		end
		if not availableSlot then return false end
		podiums[availableSlot] = {
			IndexOnPlot = originalPodiumIndex or availableSlot,
			Index = animalName,
			LastCollect = stolenAnimalData.LastCollect or workspace:GetServerTimeNow(),
			OfflineGain = stolenAnimalData.OfflineGain or nil,
			Mutation = stolenAnimalData.Mutation,
			Traits = traits,
			Machine = { Type = "Crafting", Active = false }
		}
	end

	data:Set("AnimalPodiums", podiums)
	data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
	StealService:CancelSteal(player)

	local a = AnimalsDB[animalName]
	local r = a and a.Rarity
	local rd = r and Rarities[r]
	local c = rd and rd.Color
	local coloredAnimalName = animalName
	if c and typeof(c) == "Color3" then
		local hex = string.format("#%02X%02X%02X", math.floor(c.R*255), math.floor(c.G*255), math.floor(c.B*255))
		coloredAnimalName = string.format('<font color="%s">%s</font>', hex, (a and a.DisplayName) or animalName)
	end

	NotificationService.Notify(player, string.format("You have added %s to the Crafting Machine!", coloredAnimalName), 5, "Sounds.Sfx.Success")
	return true
end

Return.OnServerEvent:Connect(function(player: Player, podiumIndex: number)
	local data = Synchronizer:Get(player)
	if not data then return end
	local podiums = data:Get("AnimalPodiums") or {}
	local podiumData = podiums[podiumIndex]
	if podiumData and podiumData.Machine and
		podiumData.Machine.Type == "Crafting" and
		not podiumData.Machine.Active then
		podiumData.Machine = nil
		podiums[podiumIndex] = podiumData
		data:Set("AnimalPodiums", podiums)
		data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
	end
end)

Claim.OnServerEvent:Connect(function(player: Player)
	local data = Synchronizer:Get(player)
	if not data then warn("[CraftingMachine] Claim failed: No player data") return end

	local craftingData = data:Get("CraftingMachine")
	if not craftingData or not craftingData.FinishTime then
		warn("[CraftingMachine] Claim failed: No crafting data or FinishTime")
		return
	end
	if workspace:GetServerTimeNow() < craftingData.FinishTime then
		warn("[CraftingMachine] Claim failed: Not finished yet")
		return
	end
	if not craftingData.Brainrot or not craftingData.Rarity then
		warn("[CraftingMachine] Claim failed: Missing Brainrot or Rarity.")
		return
	end

	if BLOCKED_CRAFT_ANIMALS[craftingData.Brainrot] then
		warn("[CraftingMachine] Blocked:", craftingData.Brainrot, "for", player.Name)
		data:Set("CraftingMachine", {})
		local podiums = data:Get("AnimalPodiums") or {}
		for podiumIndex, podiumData in podiums do
			if type(podiumData) == "table" and podiumData.Machine and
				podiumData.Machine.Type == "Crafting" and podiumData.Machine.Active then
				podiums[podiumIndex] = nil
			end
		end
		data:Set("AnimalPodiums", podiums)
		data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
		local char = player.Character
		if char and char.PrimaryPart then
			local origin = char.PrimaryPart.Position
			for _, obj in ipairs(workspace:GetDescendants()) do
				if obj:IsA("Model") then
					local indexAttr = obj:GetAttribute("Index")
					if indexAttr == craftingData.Brainrot then
						local primary = obj.PrimaryPart
						if primary and primary:IsA("BasePart") then
							if (primary.Position - origin).Magnitude <= DELETE_RANGE then
								local e = Instance.new("Explosion")
								e.Position = primary.Position
								e.BlastRadius = 0
								e.BlastPressure = 0
								e.Parent = workspace
								obj:Destroy()
							end
						end
					end
				end
			end
		end
		NotificationService.Error(player, "This brainrot cannot be obtained from crafting!")
		return
	end

	local plot = PlotService.getPlot(player)
	if not plot then warn("[CraftingMachine] Claim failed: No plot") return end

	print("[CraftingMachine] Claiming:", craftingData.Brainrot, "Rarity:", craftingData.Rarity)
	local animalData = AnimalsDB[craftingData.Brainrot]
	if not animalData then
		warn("[CraftingMachine] ERREUR: Animal introuvable dans AnimalsDB pour:", craftingData.Brainrot)
		return
	end

	-- Libérer les podiums et vider la machine AVANT de spawn
	-- pour que getFreePodium trouve des slots disponibles
	data:Set("CraftingMachine", {})
	local podiums = data:Get("AnimalPodiums") or {}
	for podiumIndex, podiumData in podiums do
		if type(podiumData) == "table" and podiumData.Machine and
			podiumData.Machine.Type == "Crafting" and podiumData.Machine.Active then
			podiums[podiumIndex] = nil
		end
	end
	data:Set("AnimalPodiums", podiums)
	data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())

	CraftNow:FireClient(player, craftingData.Rarity)

	-- Chercher AnimalTarget récursivement dans le plot
	local animalTarget = plot:FindFirstChild("AnimalTarget", true)
	warn("[CraftingMachine] DEBUG Claim - plot:", plot:GetFullName())
	warn("[CraftingMachine] DEBUG Claim - animalTarget:", animalTarget and animalTarget:GetFullName() or "NIL")
	warn("[CraftingMachine] DEBUG Claim - SpawnZone:", workspace.CraftingMachine.SpawnZone:GetFullName())
	warn("[CraftingMachine] DEBUG Claim - animalData:", animalData and animalData.DisplayName or "NIL")
	if not animalTarget then
		warn("[CraftingMachine] AnimalTarget introuvable dans le plot de", player.Name, "- fallback Road.End")
		animalTarget = workspace.Road.End
	end

	-- [CraftInheritance] Calcul mutation/trait finale
	local _RS = game:GetService("ReplicatedStorage")
	local _eventMuts = {
		["BloodmoonEvent"]={C=10,M="Bloodrot"},["CandyEvent"]={C=5,M="Candy"},
		["MoltenEvent"]={C=7,M="Lava"},["GalaxyEvent"]={C=7,M="Galaxy"},
		["YinYangEvent"]={C=12,M="YinYang"},["RadioactiveEvent"]={C=12,M="Radioactive"},
		["CursedEvent"]={C=7,M="Cursed"},["DivineEvent"]={C=6,M="Divine"},["CyberEvent"]={C=5,M="Cyber"}
	}
	local _finalMut = nil
	local _finalTraits = {}
	-- 1) Vérifier event actif (chances réduites vs spawn normal)
	for _evName, _evData in pairs(_eventMuts) do
		if _RS:GetAttribute(_evName) then
			if math.random(1,100) <= _evData.C then _finalMut = _evData.M end
			break
		end
	end
	-- 2) Héritage mutation depuis inputs (15%) si pas déjà une mutation event
	if not _finalMut then
		local _im = craftingData.InputMutations or {}
		if #_im > 0 and math.random(1,100) <= 15 then
			_finalMut = _im[math.random(1,#_im)]
		end
	end
	-- 3) Héritage traits (20% par trait)
	for _, _tr in ipairs(craftingData.InputTraits or {}) do
		if math.random(1,100) <= 20 then table.insert(_finalTraits, _tr) end
	end
	if #_finalTraits == 0 then _finalTraits = nil end
	if _finalMut or _finalTraits then
		warn("[CraftInheritance] Mutation:", tostring(_finalMut), "| Traits:", _finalTraits and table.concat(_finalTraits,", ") or "aucun")
	end
	AnimalService.spawnAnimalCustom(animalData, _finalMut, _finalTraits, nil, {
		Start = workspace.CraftingMachine.SpawnZone,
		End = animalTarget,
		Owner = player
	}, nil)
	warn("[CraftingMachine] DEBUG - spawnAnimalCustom appelé pour", player.Name, "animal:", animalData.DisplayName)
end)

CraftNow.OnServerEvent:Connect(function(player: Player)
	-- Géré par PurchaseCraftNow
end)

function CraftingMachineService:PurchaseCraftNow(player: Player, expectedRarity: string)
	local data = Synchronizer:Get(player)
	if not data then return false end
	local craftingData = data:Get("CraftingMachine")
	if not craftingData or not craftingData.StartTime or not craftingData.FinishTime then return false end
	if craftingData.Rarity ~= expectedRarity then return false end
	local currentTime = workspace:GetServerTimeNow()
	if currentTime >= craftingData.FinishTime then return false end
	data:Set("CraftingMachine.FinishTime", currentTime)
	NotificationService.Notify(player, "Craft completed!", 5, "Sounds.Sfx.Success")
	return true
end

function CraftingMachineService.skipAllCrafts()
	local skippedCount = skipAllCraftsLocal()
	pcall(function() MessagingService:PublishAsync("SkipAllCrafts", { trigger = true }) end)
	return skippedCount
end

function CraftingMachineService:Start()
	loadPersistedRecipes()
	listenCrossServer()

	-- Lire les stocks existants depuis MemoryStore au démarrage du serveur
	task.spawn(function()
		for rarity in pairs(customRecipes) do
			local stock = readGlobalStock(rarity)
			if stock ~= nil then
				localStockCache[rarity] = stock
				ReplicatedStorage:SetAttribute(LIMITED_ATTR_PREFIX .. rarity, stock)
				print(string.format("[GlobalStock] STARTUP CACHE: %s | Stock=%d", rarity, stock))
			end
		end
	end)

	for _, player in Players:GetChildren() do
		local data = Synchronizer:Wait(player)
		if data then
			if not data:Get("CraftingMachine") then data:Set("CraftingMachine", {}) end
			task.wait(1)
			Update:FireClient(player, getCraftingList())
		end
	end

	Players.PlayerAdded:Connect(function(player)
		local data = Synchronizer:Wait(player)
		if data then
			if not data:Get("CraftingMachine") then data:Set("CraftingMachine", {}) end
			task.wait(1)
			Update:FireClient(player, getCraftingList())
		end
	end)

	-- Resync périodique depuis MemoryStore toutes les 30s
	-- Pour rattraper les messages MessagingService éventuellement perdus
	task.spawn(function()
		while true do
			task.wait(5)
			for rarity in pairs(customRecipes) do
				if localStockCache[rarity] ~= nil then
					local realStock = readGlobalStock(rarity)
					if realStock ~= nil and realStock ~= localStockCache[rarity] then
						print(string.format("[GlobalStock] RESYNC: %s | cache=%d → real=%d",
							rarity, localStockCache[rarity], realStock))
						localStockCache[rarity] = realStock
						ReplicatedStorage:SetAttribute(LIMITED_ATTR_PREFIX .. rarity, realStock)
						currentCraftingList = getCraftingList()
						Update:FireAllClients(currentCraftingList)
					end
				end
			end
		end
	end)

	-- Rotation des recettes toutes les 30 min
	task.spawn(function()
		while true do
			local currentTime = workspace:GetServerTimeNow()
			local nextRefresh = (math.floor(currentTime / 1800) + 1) * 1800
			task.wait(nextRefresh - currentTime)
			for rarity in pairs(customRecipes) do clearGlobalStock(rarity) end
			customRecipes = {}
			secretOverrideSeed = os.time()
			currentCraftingList = getCraftingList()
			Update:FireAllClients(currentCraftingList)
			pcall(function()
				MessagingService:PublishAsync("GLOBAL_SECRET_REFRESH", { seed = secretOverrideSeed })
			end)
		end
	end)
end

Net:Handle("BrainrotToCraft/RequestList", (function(player: Player)
	local CommandsService = require(ServerScriptService.Services.CommandsService)
	local role = CommandsService:GetRoleAsync(player)
	if role ~= "Dev" and role ~= "Lead" then return {} end
	local brainrotNames = {}
	for _, rarityData in CraftingData.Rarities do
		for _, brainrot in rarityData.Brainrots do
			table.insert(brainrotNames, brainrot.Name)
		end
	end
	return brainrotNames
end))

function CraftingMachineService.updateList(newList)
	currentCraftingList = newList
	Update:FireAllClients(currentCraftingList)
end

function CraftingMachineService.getList()
	return getCraftingList()
end

function CraftingMachineService.setCustomRecipe(rarity: string, recipeData: table, limitedStock: number?, executor: Player?, forceResetStock: boolean?)
	-- Créer une clé unique pour la recette limitée (nouvelle entrée, pas remplacement)
	local limitedKey = "Limited_" .. rarity

	-- Stocker la rareté originale pour le style du contour
	recipeData.OriginalRarity = rarity

	customRecipes[limitedKey] = recipeData

	if limitedStock and limitedStock > 0 then
		initGlobalStock(limitedKey, limitedStock, forceResetStock)
		pcall(function()
			MessagingService:PublishAsync("GlobalStockBroadcast", {
				Rarity = limitedKey,
				Stock = localStockCache[limitedKey] or limitedStock,
			})
		end)
	else
		clearGlobalStock(limitedKey)
	end

	currentCraftingList = getCraftingList()
	Update:FireAllClients(currentCraftingList)

	pcall(function() recipeStore:SetAsync(limitedKey, recipeData, 86400) end)
	pcall(function()
		MessagingService:PublishAsync("RecipeUpdate", {
			Action = "setCustomRecipe",
			Rarity = limitedKey,
			Recipe = recipeData,
			LimitedStock = limitedStock,
			ExecutorName = executor and executor.Name or "Admin",
			BrainrotName = recipeData.Name
		})
	end)

	return limitedKey
end

function CraftingMachineService.addCustomRecipe(rarity: string, recipeData: table, limitedStock: number?)
	customRecipeCounter = customRecipeCounter + 1
	local uniqueKey = rarity .. "_" .. tostring(customRecipeCounter)
	customRecipes[uniqueKey] = recipeData
	if limitedStock and limitedStock > 0 then
		initGlobalStock(uniqueKey, limitedStock)
	end
	currentCraftingList = getCraftingList()
	Update:FireAllClients(currentCraftingList)
	pcall(function() recipeStore:SetAsync(uniqueKey, recipeData, 86400) end)
	pcall(function()
		MessagingService:PublishAsync("RecipeUpdate", {
			Action = "setCustomRecipe",
			Rarity = uniqueKey,
			Recipe = recipeData
		})
	end)
	return uniqueKey
end

function CraftingMachineService.removeCustomRecipe(rarity: string)
	customRecipes[rarity] = nil
	clearGlobalStock(rarity)
	if currentCraftingList and currentCraftingList.List[rarity] then
		currentCraftingList.List[rarity] = nil
		Update:FireAllClients(currentCraftingList)
	end
	pcall(function() recipeStore:RemoveAsync(rarity) end)
	pcall(function()
		MessagingService:PublishAsync("RecipeUpdate", { Action = "removeCustomRecipe", Rarity = rarity })
	end)
end

function CraftingMachineService.getCustomRecipes()
	return customRecipes
end

function CraftingMachineService.clearCustomRecipes()
	for rarity in pairs(customRecipes) do clearGlobalStock(rarity) end
	customRecipes = {}
end

function CraftingMachineService.clearAllRecipes()
	for rarity in pairs(customRecipes) do clearGlobalStock(rarity) end
	customRecipes = {}
	currentCraftingList = {List = {}, Refresh = 0}
	Update:FireAllClients(currentCraftingList)
	pcall(function()
		MessagingService:PublishAsync("RecipeUpdate", { Action = "clearAllRecipes" })
	end)
end

function CraftingMachineService.setAutoGenerationEnabled(enabled: boolean)
	autoGenerationEnabled = enabled
	currentCraftingList = getCraftingList()
	Update:FireAllClients(currentCraftingList)
	pcall(function() recipeStore:SetAsync("autoGenerationEnabled", enabled, 86400) end)
	pcall(function()
		MessagingService:PublishAsync("RecipeUpdate", { Action = "setAutoGeneration", Enabled = enabled })
	end)
end

function CraftingMachineService.isAutoGenerationEnabled()
	return autoGenerationEnabled
end

function CraftingMachineService.forceRefresh(newSeed: number?)
	if newSeed then
		normalRecipeSeed = newSeed
	end
	currentCraftingList = getCraftingList()
	Update:FireAllClients(currentCraftingList)
	return currentCraftingList
end

function CraftingMachineService.refreshSecretRecipe()
	customRecipes["Secret"] = nil
	clearGlobalStock("Secret")
	secretOverrideSeed = os.time()
	currentCraftingList = getCraftingList()
	Update:FireAllClients(currentCraftingList)
	pcall(function() recipeStore:RemoveAsync("Secret") end)
	pcall(function()
		MessagingService:PublishAsync("GLOBAL_SECRET_REFRESH", { seed = secretOverrideSeed })
	end)
	return true
end

-- Admin : forcer le stock dans MemoryStore et broadcaster à tous
function CraftingMachineService.setLimitedStock(rarity: string, stock: number)
	print(string.format("[GlobalStock] ADMIN SET_STOCK: %s | Stock=%d", rarity, stock))
	if stock <= 0 then
		clearGlobalStock(rarity)
	else
		local ok, err = pcall(function()
			GlobalStockMap:SetAsync(getGlobalKey(rarity), stock, 86400)
		end)
		if ok then
			broadcastStockUpdate(rarity, stock)
			persistStock(rarity, stock)
		else
			warn("[GlobalStock] setLimitedStock error:", err)
		end
	end
	currentCraftingList = getCraftingList()
	Update:FireAllClients(currentCraftingList)
end

function CraftingMachineService.forceResetStock(rarity: string, newStock: number)
	print(string.format("[GlobalStock] FORCE RESET: %s | Stock=%d", rarity, newStock))
	CraftingMachineService.setLimitedStock(rarity, newStock)
end

function CraftingMachineService.restockLimited(rarity: string, amount: number)
	print(string.format("[GlobalStock] ADMIN RESTOCK: %s | +%d", rarity, amount))
	local newStock = nil
	local ok, err = pcall(function()
		newStock = GlobalStockMap:UpdateAsync(getGlobalKey(rarity), function(currentStock)
			if currentStock == nil then return nil end
			return currentStock + amount
		end, 86400)
	end)
	if ok and newStock and newStock > 0 then
		broadcastStockUpdate(rarity, newStock)
		persistStock(rarity, newStock)
		print(string.format("[GlobalStock] RESTOCK DONE: %s | Stock=%d", rarity, newStock))
	else
		warn("[GlobalStock] restockLimited error:", err)
	end
	currentCraftingList = getCraftingList()
	Update:FireAllClients(currentCraftingList)
end

return CraftingMachineService