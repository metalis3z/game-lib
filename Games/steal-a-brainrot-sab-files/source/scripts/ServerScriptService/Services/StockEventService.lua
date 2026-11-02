local StockEventService = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")
local MemoryStoreService = game:GetService("MemoryStoreService")
local HttpService = game:GetService("HttpService")
local PlotService = require(ServerScriptService.Services.PlotService)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local StealService = require(ServerScriptService.Services.StealService)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local EventService = require(ServerScriptService.Services.EventService)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)
local TimeUtils = require(ReplicatedStorage.Utils.TimeUtils)
local StockMachineData = require(ReplicatedStorage.Datas.StockMachine)
local AnimalsDB = require(ReplicatedStorage.Datas.Animals)
local Rarities = require(ReplicatedStorage.Datas.Rarities)
local SetFocused = Net:RemoteEvent("StockEventService/SetFocused")
local Update = Net:RemoteEvent("StockEventService/Update")
local Return = Net:RemoteEvent("StockEventService/Return")
local Redeem = Net:RemoteEvent("StockEventService/Redeem")
local Delivery = Net:RemoteFunction("StockEventService/Delivery")
local StandardReturn = Net:RemoteEvent("PlotService/Return")
local CreateDynamicRecipe = Net:RemoteFunction("StockEventService/CreateDynamicRecipe")
local UnSet = Net:RemoteFunction("StockEventService/UnSet")
local STOCK_KEY = "StockEvent_Chipso_and_Queso"
local STOCK_KEY_2 = "StockEvent_Chipso_and_Queso_2"
local DEFAULT_STOCK   = 50000
local DEFAULT_STOCK_2 = 250000
local INITIAL_KEEPHIDDEN = false
local FFlags = require(ReplicatedStorage.Packages.FFlags)
local PRESET_STOCKS = {
	[1] = {
		"Chicleteira Surfeiteira,Girafini Raftini,La Grande Combinasion",
		"La Summer Grande",
		100000,

		"Tuff Toucan,Sammyni Fattini,4th Bros", 
		"Capitano Americano",                    
		250000,
	},
}
local GLOBAL_STOCK_MAP_KEY  = "GlobalStockRecipe"
local GLOBAL_STOCK_KEY_1    = "GlobalStock_Slot1"
local GLOBAL_STOCK_KEY_2    = "GlobalStock_Slot2"
local GlobalStockMap    = MemoryStoreService:GetSortedMap("GlobalStockRecipes")
local StockCounterMap1  = MemoryStoreService:GetSortedMap("GlobalStockCounters1")
local StockCounterMap2  = MemoryStoreService:GetSortedMap("GlobalStockCounters2")
local CurrentStock  = DEFAULT_STOCK
local CurrentStock2 = DEFAULT_STOCK_2
local EventActive    = false
local EVENT_DURATION = 100000000000
local EVENT_INTERVAL = 7200
local NextEventTime  = 0
local EventWasActive = false
local hasexecuted    = false

local globalStockIsActive = false

local LockedRecipe  = nil
local LockedRecipe2 = nil


local STOCK_POSITION = Vector3.new(-379.368, -4.935, 15.516)

local STOCK_HIDDEN_POSITION = Vector3.new(30000, 30000, 30000)

local function GetEventStatus()
	local CurrentTime = workspace:GetServerTimeNow()
	return {
		Active      = true, 
		NextEvent   = CurrentTime + 1000000000000,
		CurrentTime = CurrentTime,
	}
end

local function formatNumber(value)
	local formatted = tostring(math.max(0, math.floor(value)))
	while true do
		local k
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
		if k == 0 then break end
	end
	return formatted
end

local function UpdateCountdownDisplay()
	local eventsFolder = workspace:FindFirstChild("Events")
	local stockFolder  = eventsFolder and eventsFolder:FindFirstChild("Stock")
	local model        = stockFolder  and stockFolder:FindFirstChild("Model")
	local overhead     = model and model:FindFirstChild("Overhead")
	local gui          = overhead and overhead:FindFirstChild("BillboardGui")
	local CountdownGui = gui and gui:FindFirstChild("Countdown")
	if not CountdownGui then return end

	local EventStatus  = GetEventStatus()
	EventActive = EventStatus.Active
	if not EventActive then hasexecuted = false end
	EventWasActive = EventActive
	CountdownGui.Text = formatNumber(CurrentStock + CurrentStock2) .. " Left"
end

local function TeleportStockModel()
	local model = workspace.Events.Stock.Model
	if model then
		model:PivotTo(CFrame.new(STOCK_POSITION) * CFrame.Angles(0, math.rad(180), 0))
	end
end

local function HideStockModel()
	local eventsFolder = workspace:FindFirstChild("Events")
	local stockFolder  = eventsFolder and eventsFolder:FindFirstChild("Stock")
	local model        = stockFolder  and stockFolder:FindFirstChild("Model")
	if model then
		model:PivotTo(CFrame.new(STOCK_HIDDEN_POSITION) * CFrame.Angles(0, math.rad(180), 0))
	end
end
UnSet.OnServerInvoke = function()
	HideStockModel()
end


local function getGradientTag(animalName)
	for _, v in pairs(AnimalsDB) do
		if v.DisplayName == animalName or v.Name == animalName then
			local rarityInfo = v.Rarity and Rarities[v.Rarity]
			if rarityInfo and rarityInfo.GradientPreset then
				return string.lower(rarityInfo.GradientPreset)
			end
			return nil
		end
	end
	return nil
end

local function ColoredName(Index: string): string
	local Animal = AnimalsDB[Index]
	local Rarity = Animal and Animal.Rarity
	local RarityData = Rarity and Rarities[Rarity]
	local Color = RarityData and RarityData.Color
	if not (Color and typeof(Color) == "Color3") then
		return Animal and Animal.DisplayName or tostring(Index)
	end
	local Hex = string.format("#%02X%02X%02X",
		math.floor(Color.R * 255), math.floor(Color.G * 255), math.floor(Color.B * 255))
	return string.format('<font color="%s">%s</font>', Hex, (Animal and Animal.DisplayName) or tostring(Index))
end


local function ReadGlobalStock1(): number
	local ok, val = pcall(function()
		return StockCounterMap1:GetAsync(GLOBAL_STOCK_KEY_1)
	end)
	if ok then
		local resolved = type(val) == "number" and val or 0
		CurrentStock = resolved
		ReplicatedStorage:SetAttribute(STOCK_KEY, CurrentStock)
		return resolved
	end
	return CurrentStock
end

local function ReadGlobalStock2(): number
	local ok, val = pcall(function()
		return StockCounterMap2:GetAsync(GLOBAL_STOCK_KEY_2)
	end)
	if ok then
		local resolved = type(val) == "number" and val or 0
		CurrentStock2 = resolved
		ReplicatedStorage:SetAttribute(STOCK_KEY_2, CurrentStock2)
		return resolved
	end
	return CurrentStock2
end

local function ReadBothGlobalStocks()
	local done = 0
	task.spawn(function()
		ReadGlobalStock1()
		done += 1
	end)
	task.spawn(function()
		ReadGlobalStock2()
		done += 1
	end)
	while done < 2 do task.wait() end
end

local BATCH_INTERVAL          = 10
local pendingSyncBroadcast    = false
local lastBroadcastReceived   = 0

local function ScheduleStockBroadcast()
	if pendingSyncBroadcast then return end
	pendingSyncBroadcast = true
	task.delay(BATCH_INTERVAL, function()
		pendingSyncBroadcast = false
		local real1 = ReadGlobalStock1()
		local real2 = ReadGlobalStock2()
	end)
end
local function IsGlobalStockActive(): boolean
	return globalStockIsActive
end


local function AtomicConsumeStock1(): boolean
	local consumed = false
	local newValue = nil
	local ok, err = pcall(function()
		StockCounterMap1:UpdateAsync(GLOBAL_STOCK_KEY_1, function(current)
			current = current or 0
			if current <= 0 then
				return nil
			end
			consumed = true
			newValue = current - 1
			return newValue
		end, 604800)
	end)
	if not ok then
		warn("[StockEventService] AtomicConsumeStock1 failed:", err)
		return false
	end
	if consumed and newValue ~= nil then
		CurrentStock = newValue
		ReplicatedStorage:SetAttribute(STOCK_KEY, CurrentStock)
		ScheduleStockBroadcast()
	else
		CurrentStock = 0
		ReplicatedStorage:SetAttribute(STOCK_KEY, 0)
	end
	return consumed
end

local function AtomicConsumeStock2(): boolean
	local consumed = false
	local newValue = nil
	local ok, err = pcall(function()
		StockCounterMap2:UpdateAsync(GLOBAL_STOCK_KEY_2, function(current)
			current = current or 0
			if current <= 0 then
				return nil
			end
			consumed = true
			newValue = current - 1
			return newValue
		end, 604800)
	end)
	if not ok then
		warn("[StockEventService] AtomicConsumeStock2 failed:", err)
		return false
	end
	if consumed and newValue ~= nil then
		CurrentStock2 = newValue
		ReplicatedStorage:SetAttribute(STOCK_KEY_2, CurrentStock2)
		ScheduleStockBroadcast()
	else
		CurrentStock2 = 0
		ReplicatedStorage:SetAttribute(STOCK_KEY_2, 0)
	end
	return consumed
end

local function LocalConsumeStock1(): boolean
	if CurrentStock <= 0 then return false end
	CurrentStock = CurrentStock - 1
	ReplicatedStorage:SetAttribute(STOCK_KEY, CurrentStock)
	return true
end

local function LocalConsumeStock2(): boolean
	if CurrentStock2 <= 0 then return false end
	CurrentStock2 = CurrentStock2 - 1
	ReplicatedStorage:SetAttribute(STOCK_KEY_2, CurrentStock2)
	return true
end

local function SetGlobalStock(amount1: number, amount2: number?)
	local ok1, err1 = pcall(function()
		StockCounterMap1:SetAsync(GLOBAL_STOCK_KEY_1, amount1, 604800)
	end)
	if not ok1 then warn("[StockEventService] SetGlobalStock1 failed:", err1) end
	CurrentStock = amount1
	ReplicatedStorage:SetAttribute(STOCK_KEY, CurrentStock)

	if amount2 then
		local ok2, err2 = pcall(function()
			StockCounterMap2:SetAsync(GLOBAL_STOCK_KEY_2, amount2, 604800)
		end)
		if not ok2 then warn("[StockEventService] SetGlobalStock2 failed:", err2) end
		CurrentStock2 = amount2
		ReplicatedStorage:SetAttribute(STOCK_KEY_2, CurrentStock2)
	end
end

local function ClearGlobalStockEntries()
	pcall(function() GlobalStockMap:RemoveAsync(GLOBAL_STOCK_MAP_KEY) end)
	pcall(function() StockCounterMap1:RemoveAsync(GLOBAL_STOCK_KEY_1) end)
	pcall(function() StockCounterMap2:RemoveAsync(GLOBAL_STOCK_KEY_2) end)
	globalStockIsActive = false
	warn("[StockEventService] Global stock exhausted — MemoryStore entries cleared.")
end

local REVERT_DEBOUNCE = false
local function RevertToDefaultStock()
	if REVERT_DEBOUNCE then return end
	REVERT_DEBOUNCE = true

	warn("[StockEventService] Stock exhausted — reverting to server-local default preset.")

	if IsGlobalStockActive() then
		ClearGlobalStockEntries()
	end

	CurrentStock  = 0
	CurrentStock2 = 0
	ReplicatedStorage:SetAttribute(STOCK_KEY,   0)
	ReplicatedStorage:SetAttribute(STOCK_KEY_2, 0)

	ReplicatedStorage:SetAttribute("LockedRecipe_Taco2",       nil)
	ReplicatedStorage:SetAttribute("LockedIngredients_Taco2",  nil)
	ReplicatedStorage:SetAttribute("LockedRecipe2_Taco2",      nil)
	ReplicatedStorage:SetAttribute("LockedIngredients2_Taco2", nil)
	LockedRecipe  = nil
	LockedRecipe2 = nil

	UpdateCountdownDisplay()

	for _, p in ipairs(Players:GetPlayers()) do
		NotificationService.Notify(p, "The Taco Truck has sold out! Restocking shortly...")
	end

	task.delay(3, function()
		REVERT_DEBOUNCE = false
		StockEventService.startStock(PRESET_STOCKS[1], nil, true, true)
	end)
end



local function InitializeStock()

end

local function GetRecipeData(MachineType: string, RecipeKey: string)
	if StockMachineData[MachineType] and StockMachineData[MachineType][RecipeKey] then
		return StockMachineData[MachineType][RecipeKey]
	end
	return nil
end

local function ManageEventUpdates()
	while true do
		UpdateCountdownDisplay()
		task.wait(30)
	end
end

local function HasAllRequiredAnimals(Player: Player, MachineType: string, RecipeKey: string): boolean
	local Data = Synchronizer:Get(Player)
	if not Data then return false end

	local Recipe
	if LockedRecipe2 and LockedRecipe2.MachineType == MachineType and LockedRecipe2.Output == RecipeKey then
		Recipe = LockedRecipe2
	elseif LockedRecipe and LockedRecipe.MachineType == MachineType and LockedRecipe.Output == RecipeKey then
		Recipe = LockedRecipe
	else
		Recipe = GetRecipeData(MachineType, RecipeKey)
	end
	if not Recipe or not Recipe.Inputs then return false end

	local Podiums      = Data:Get("AnimalPodiums") or {}
	local Requirements = table.clone(Recipe.Inputs)
	for _, PodiumData in pairs(Podiums) do
		if type(PodiumData) == "table"
			and PodiumData.Machine
			and PodiumData.Machine.Type == MachineType
			and PodiumData.Machine.RecipeKey == RecipeKey
			and not PodiumData.Machine.Active
		then
			local idx = table.find(Requirements, tostring(PodiumData.Index))
			if idx then table.remove(Requirements, idx) end
		end
	end
	return #Requirements == 0
end

local DeliveryDebounce = {}

Delivery.OnServerInvoke = function(Player: Player, Hitbox: BasePart, MachineType: string, RecipeKey: string): boolean
	if DeliveryDebounce[Player.UserId] then return false end
	DeliveryDebounce[Player.UserId] = true
	task.delay(0.5, function() DeliveryDebounce[Player.UserId] = nil end)

	local Data      = Synchronizer:Get(Player)
	local StealData = StealService:GetStealData(Player)
	if not Data or not StealData or not StealData.StolenAnimalData then return false end

	local StolenAnimalData    = StealData.StolenAnimalData
	local OriginalPodiumIndex = StealData.PodiumIndex
	local InternalName        = StolenAnimalData.Index

	local Podiums    = Data:Get("AnimalPodiums") or {}
	local slotsToAdd = {}

	local function checkRecipeNeedsAnimal(recipe, slotKey)
		if not recipe or not slotKey then return end
		if recipe.MachineType ~= MachineType then return end
		local reqs = table.clone(recipe.Inputs)
		for _, pData in pairs(Podiums) do
			if type(pData) == "table" and pData.Machine
				and pData.Machine.Type == MachineType
				and pData.Machine.RecipeKey == slotKey
				and not pData.Machine.Active
			then
				local idx = table.find(reqs, pData.Index)
				if idx then table.remove(reqs, idx) end
			end
		end
		if table.find(reqs, InternalName) then
			table.insert(slotsToAdd, slotKey)
		end
	end

	if LockedRecipe  and LockedRecipe.MachineType  == MachineType then checkRecipeNeedsAnimal(LockedRecipe,  LockedRecipe.Output)  end
	if LockedRecipe2 and LockedRecipe2.MachineType == MachineType then checkRecipeNeedsAnimal(LockedRecipe2, LockedRecipe2.Output) end

	if #slotsToAdd == 0 then
		NotificationService.Error(Player, "This brainrot is not needed!")
		return false
	end

	StealData.StolenAnimalData = nil
	Player:SetAttribute("StealingIndex", nil)
	StealService:CancelSteal(Player)

	local PlotChannel = nil
	local Plot = PlotService.getPlot(Player)
	if Plot then PlotChannel = Synchronizer:Get(Plot) end
	if not PlotChannel then
		for _, channel in pairs(Synchronizer:GetAllChannels()) do
			local owner = channel:Get("Owner")
			if owner == Player.Name or owner == Player then
				PlotChannel = channel
				break
			end
		end
	end

	local AnimalList = if PlotChannel then PlotChannel:Get("AnimalList") else Data:Get("AnimalList") or {}
	Podiums[OriginalPodiumIndex] = nil
	if AnimalList[OriginalPodiumIndex] then AnimalList[OriginalPodiumIndex] = nil end

	local insertedAny = false
	for _, slotKey in ipairs(slotsToAdd) do
		local AvailableSlot = nil
		for i = 1, 50 do
			if not Podiums[i] then AvailableSlot = i break end
		end
		if AvailableSlot then
			Podiums[AvailableSlot] = {
				Index       = InternalName,
				LastCollect = StolenAnimalData.LastCollect or workspace:GetServerTimeNow(),
				Traits      = StolenAnimalData.Traits,
				Machine     = { Type = MachineType, Active = false, RecipeKey = slotKey },
			}
			insertedAny = true
		end
	end
	if not insertedAny then return false end

	if PlotChannel then
		PlotChannel:Set("AnimalList", nil)
		PlotChannel:Set("AnimalList", AnimalList)
	else
		Data:Set("AnimalList", AnimalList)
	end
	Data:Set("AnimalPodiums", Podiums)
	Data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())

	for _, slotKey in ipairs(slotsToAdd) do
		if HasAllRequiredAnimals(Player, MachineType, slotKey) then
			Net:RemoteEvent("StockMachine/RecipeFinished"):FireClient(Player, MachineType, slotKey)
		end
	end

	local animalTag         = getGradientTag(InternalName)
	local coloredAnimalName = ColoredName(InternalName)
	local finalDisplayName  = animalTag
		and string.format("<%s>%s</%s>", animalTag, coloredAnimalName, animalTag)
		or  coloredAnimalName
	NotificationService.Notify(Player, string.format("You gave Sammy %s!", finalDisplayName))
	return true
end

local function ConsumeAnimals(Player: Player, MachineType: string, RecipeKey: string): boolean
	local Data   = Synchronizer:Get(Player)
	local Recipe
	if LockedRecipe2 and LockedRecipe2.MachineType == MachineType and LockedRecipe2.Output == RecipeKey then
		Recipe = LockedRecipe2
	else
		Recipe = (LockedRecipe and LockedRecipe.MachineType == MachineType) and LockedRecipe or GetRecipeData(MachineType, RecipeKey)
	end
	if not Data or not Recipe then return false end

	local Podiums   = Data:Get("AnimalPodiums") or {}
	local ToConsume = table.clone(Recipe.Inputs)
	for PodiumIndex, PodiumData in Podiums do
		if type(PodiumData) == "table" and PodiumData.Machine
			and PodiumData.Machine.Type == MachineType
			and PodiumData.Machine.RecipeKey == RecipeKey
			and not PodiumData.Machine.Active
		then
			local idx = table.find(ToConsume, PodiumData.Index)
			if idx then
				PodiumData.Machine.Active = true
				table.remove(ToConsume, idx)
				if #ToConsume == 0 then break end
			end
		end
	end
	Data:Set("AnimalPodiums", Podiums)
	return #ToConsume == 0
end

local function RemoveAnimalFromAllSlots(Data, animalIndex: string, machineType: string)
	local Podiums          = Data:Get("AnimalPodiums") or {}
	local changed          = false
	local recoveredEntries = {}

	for idx, pd in pairs(Podiums) do
		if type(pd) == "table"
			and pd.Index == animalIndex
			and pd.Machine
			and pd.Machine.Type == machineType
			and not pd.Machine.Active
		then
			table.insert(recoveredEntries, { Index = pd.Index, LastCollect = pd.LastCollect, Traits = pd.Traits, Mutation = pd.Mutation })
			Podiums[idx] = nil
			changed = true
		end
	end

	if #recoveredEntries > 0 then
		for i = 1, 200 do
			if Podiums[i] == nil then
				Podiums[i] = recoveredEntries[1]
				changed = true
				break
			end
		end
	end

	if changed then
		Data:Set("AnimalPodiums", Podiums)
		Data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
	end
	return changed
end

Return.OnServerEvent:Connect(function(Player: Player, PodiumIndex: number)
	local Data = Synchronizer:Get(Player)
	if not Data then return end
	local Podiums    = Data:Get("AnimalPodiums") or {}
	local PodiumData = Podiums[PodiumIndex]
	if not (PodiumData and PodiumData.Machine and not PodiumData.Machine.Active) then return end
	RemoveAnimalFromAllSlots(Data, PodiumData.Index, PodiumData.Machine.Type)
end)

StandardReturn.OnServerEvent:Connect(function(Player: Player, PodiumIndex: number)
	local Data = Synchronizer:Get(Player)
	if not Data then return end
	local Podiums    = Data:Get("AnimalPodiums") or {}
	local PodiumData = Podiums[PodiumIndex]
	if not (PodiumData and PodiumData.Machine and not PodiumData.Machine.Active) then return end
	RemoveAnimalFromAllSlots(Data, PodiumData.Index, PodiumData.Machine.Type)
end)

local RedeemDebounce = {}

Redeem.OnServerEvent:Connect(function(Player: Player, MachineType: string, RecipeKey: string)
	if RedeemDebounce[Player.UserId] then return end
	local Data = Synchronizer:Get(Player)
	if not Data then return end
	RedeemDebounce[Player.UserId] = true

	local Recipe
	if LockedRecipe2 and LockedRecipe2.MachineType == MachineType and LockedRecipe2.Output == RecipeKey then
		Recipe = LockedRecipe2
	else
		Recipe = (LockedRecipe and LockedRecipe.MachineType == MachineType) and LockedRecipe or GetRecipeData(MachineType, RecipeKey)
	end

	if not Recipe then
		RedeemDebounce[Player.UserId] = nil
		return
	end

	if not HasAllRequiredAnimals(Player, MachineType, RecipeKey) then
		RedeemDebounce[Player.UserId] = nil
		NotificationService.Error(Player, "You don't have all required animals!")
		return
	end

	local isSlot2     = (LockedRecipe2 and LockedRecipe2.MachineType == MachineType and LockedRecipe2.Output == RecipeKey)
	local globalStock = IsGlobalStockActive()

	local stockToCheck = isSlot2 and CurrentStock2 or CurrentStock
	if stockToCheck <= 0 then
		RedeemDebounce[Player.UserId] = nil
		NotificationService.Error(Player, "Stock is empty!")
		if CurrentStock <= 0 and CurrentStock2 <= 0 then
			RevertToDefaultStock()
		end
		UpdateCountdownDisplay()
		return
	end

	local consumed
	if globalStock then
		consumed = isSlot2 and AtomicConsumeStock2() or AtomicConsumeStock1()
	else
		consumed = isSlot2 and LocalConsumeStock2() or LocalConsumeStock1()
	end

	if not consumed then
		RedeemDebounce[Player.UserId] = nil
		NotificationService.Error(Player, "Stock is empty!")
		if globalStock then
			if isSlot2 then ReadGlobalStock2() else ReadGlobalStock1() end
		end
		if CurrentStock <= 0 and CurrentStock2 <= 0 then
			RevertToDefaultStock()
		end
		UpdateCountdownDisplay()
		return
	end

	if not ConsumeAnimals(Player, MachineType, RecipeKey) then
		if globalStock then
			if isSlot2 then
				local refundOk = pcall(function()
					StockCounterMap2:UpdateAsync(GLOBAL_STOCK_KEY_2, function(c) return (c or 0) + 1 end, 604800)
				end)
				if refundOk then
					CurrentStock2 = CurrentStock2 + 1
					ReplicatedStorage:SetAttribute(STOCK_KEY_2, CurrentStock2)
				end
				ReadGlobalStock2()
			else
				local refundOk = pcall(function()
					StockCounterMap1:UpdateAsync(GLOBAL_STOCK_KEY_1, function(c) return (c or 0) + 1 end, 604800)
				end)
				if refundOk then
					CurrentStock = CurrentStock + 1
					ReplicatedStorage:SetAttribute(STOCK_KEY, CurrentStock)
				end
				ReadGlobalStock1()
			end
		else
			if isSlot2 then
				CurrentStock2 = CurrentStock2 + 1
				ReplicatedStorage:SetAttribute(STOCK_KEY_2, CurrentStock2)
			else
				CurrentStock = CurrentStock + 1
				ReplicatedStorage:SetAttribute(STOCK_KEY, CurrentStock)
			end
		end
		RedeemDebounce[Player.UserId] = nil
		return
	end

	local Podiums = Data:Get("AnimalPodiums") or {}
	for idx, PodiumData in pairs(Podiums) do
		if type(PodiumData) == "table" and PodiumData.Machine
			and PodiumData.Machine.Type == MachineType
			and PodiumData.Machine.RecipeKey == RecipeKey
			and PodiumData.Machine.Active
		then
			Podiums[idx] = nil
		end
	end

	AnimalService.SpawnForcedAnimal(AnimalsDB[Recipe.Output])
	Data:Set("AnimalPodiums", Podiums)
	Data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
	NotificationService.Success(Player, string.format("%s Spawned!", Recipe.Output))

	if CurrentStock <= 0 and CurrentStock2 <= 0 then
		RevertToDefaultStock()
	end

	task.delay(3, function() RedeemDebounce[Player.UserId] = nil end)
end)

local function CleanupInvalidMachineItems(Player: Player)
	local Data = Synchronizer:Get(Player)
	if not Data then return end

	if not LockedRecipe and not LockedRecipe2 then return end

	local Podiums = Data:Get("AnimalPodiums") or {}
	local Changed = false
	for Index, PodiumData in pairs(Podiums) do
		if type(PodiumData) == "table" and PodiumData.Machine then
			local IsValid1 = LockedRecipe  and table.find(LockedRecipe.Inputs,  PodiumData.Index)
			local IsValid2 = LockedRecipe2 and table.find(LockedRecipe2.Inputs, PodiumData.Index)
			if not (IsValid1 or IsValid2) then
				PodiumData.Machine = nil
				Changed = true
			end
		end
	end
	if Changed then
		Data:Set("AnimalPodiums", Podiums)
		Data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
	end
end

local function PlayerAdded(Player: Player)
	local Data = Synchronizer:Wait(Player)
	if not Data then return end

	if IsGlobalStockActive() then
		TeleportStockModel()
	end

	CleanupInvalidMachineItems(Player)
end

CreateDynamicRecipe.OnServerInvoke = function(Player, OutputName, Ingredients, MachineType, OutputName2, Ingredients2, StockAmount, StockAmount2)
	local Data = Synchronizer:Get(Player)
	if not Data then return false, "Data not loaded" end

	local gameData  = require(game:GetService("ReplicatedStorage").GameData)
	local blacklist = gameData.UnSpawnableBrainrots
	local isAuthorized = (Player.UserId == 0 or Player.UserId == 1215597321)

	local function isBlacklisted(name)
		if isAuthorized then return false end
		if blacklist[name] then return true end
		local animal = AnimalsDB[name]
		return animal and blacklist[animal.DisplayName]
	end

	if not AnimalsDB[OutputName]                          then return false, "Invalid output: " .. tostring(OutputName) end
	if isBlacklisted(OutputName)                          then return false, OutputName .. " is blacklisted." end
	if type(Ingredients) ~= "table" or #Ingredients == 0  then return false, "No ingredients provided for slot 1." end

	for _, ingredientName in ipairs(Ingredients) do
		if type(ingredientName) ~= "string" then return false, "Invalid ingredient type in slot 1." end
		if not AnimalsDB[ingredientName]     then return false, "Invalid ingredient in slot 1: " .. tostring(ingredientName) end
		if isBlacklisted(ingredientName)     then return false, "Ingredient '" .. ingredientName .. "' is blacklisted." end
	end

	if OutputName2 ~= nil or Ingredients2 ~= nil then
		if type(OutputName2) ~= "string" or OutputName2 == ""  then return false, "Invalid slot 2 output name." end
		if not AnimalsDB[OutputName2]                           then return false, "Invalid slot 2 output: " .. tostring(OutputName2) end
		if isBlacklisted(OutputName2)                          then return false, OutputName2 .. " (slot 2) is blacklisted." end
		if type(Ingredients2) ~= "table" or #Ingredients2 == 0 then return false, "No ingredients provided for slot 2." end
		for _, ingredientName in ipairs(Ingredients2) do
			if type(ingredientName) ~= "string" then return false, "Invalid ingredient type in slot 2." end
			if not AnimalsDB[ingredientName]     then return false, "Invalid ingredient in slot 2: " .. tostring(ingredientName) end
			if isBlacklisted(ingredientName)     then return false, "Slot 2 ingredient '" .. ingredientName .. "' is blacklisted." end
		end
	end

	TeleportStockModel()

	for _, targetPlayer in pairs(Players:GetPlayers()) do
		local targetData = Synchronizer:Get(targetPlayer)
		if not targetData then continue end
		local Podiums = targetData:Get("AnimalPodiums") or {}
		local changed = false
		for index, podiumData in pairs(Podiums) do
			if type(podiumData) == "table" and podiumData.Machine and podiumData.Machine.Type == MachineType then
				podiumData.Machine = nil
				changed = true
			end
		end
		if changed then
			targetData:Set("AnimalPodiums", Podiums)
			targetData:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
			NotificationService.Notify(targetPlayer, "The recipe has changed! Machine items have been returned to inventory.")
		end
	end

	ReplicatedStorage:SetAttribute("LockedIngredients_" .. MachineType, nil)
	ReplicatedStorage:SetAttribute("LockedRecipe_" .. MachineType, nil)

	local ValidIngredients = {}
	for _, name in ipairs(Ingredients) do
		if type(name) == "string" and name ~= "" and name ~= "Label" then
			local cleaned = name:match("^%s*(.-)%s*$"):gsub("[\n\r]", "")
			if cleaned ~= "" and AnimalsDB[cleaned] then
				table.insert(ValidIngredients, cleaned)
			else
				warn("StockEventService: Invalid animal name ignored:", tostring(cleaned))
			end
		end
	end
	if #ValidIngredients == 0 then return false, "No valid ingredients after cleaning" end

	LockedRecipe = { Output = OutputName, Inputs = ValidIngredients, MachineType = MachineType }
	ReplicatedStorage:SetAttribute("LockedIngredients_" .. MachineType, table.concat(ValidIngredients, ","))
	ReplicatedStorage:SetAttribute("LockedRecipe_" .. MachineType, OutputName)

	local newStock2 = nil
	if OutputName2 and Ingredients2 and type(Ingredients2) == "table" and #Ingredients2 > 0 then
		local ValidIngredients2 = {}
		for _, name in ipairs(Ingredients2) do
			if type(name) == "string" and name ~= "" and name ~= "Label" then
				local cleaned = name:match("^%s*(.-)%s*$"):gsub("[\n\r]", "")
				if cleaned ~= "" and AnimalsDB[cleaned] then
					table.insert(ValidIngredients2, cleaned)
				else
					warn("StockEventService (slot2): Invalid animal name ignored:", tostring(cleaned))
				end
			end
		end
		if #ValidIngredients2 > 0 then
			LockedRecipe2 = { Output = OutputName2, Inputs = ValidIngredients2, MachineType = MachineType }
			newStock2 = DEFAULT_STOCK_2
			ReplicatedStorage:SetAttribute("LockedIngredients2_" .. MachineType, table.concat(ValidIngredients2, ","))
			ReplicatedStorage:SetAttribute("LockedRecipe2_" .. MachineType, OutputName2)
		end
	else
		LockedRecipe2 = nil
		ReplicatedStorage:SetAttribute("LockedRecipe2_" .. MachineType, nil)
		ReplicatedStorage:SetAttribute("LockedIngredients2_" .. MachineType, nil)
		ReplicatedStorage:SetAttribute(STOCK_KEY_2, nil)
	end

	local customStock1 = StockAmount or DEFAULT_STOCK
	local customStock2 = StockAmount2 or newStock2
	SetGlobalStock(customStock1, customStock2)
	ReplicatedStorage:SetAttribute("RecipeUpdateTick_" .. MachineType, os.clock())
	UpdateCountdownDisplay()

	local tag1          = getGradientTag(OutputName)
	local valentineData = Rarities["Valentine"]
	local valHex        = (valentineData and valentineData.Color) and valentineData.Color:ToHex() or "ff00ff"
	local displayName1  = tag1 and ("<%s>%s</%s>"):format(tag1, OutputName, tag1) or OutputName
	local successMsg    = ('Sammy set <font color="#%s">Taco Truck</font> to %s!'):format(valHex, displayName1)
	if OutputName2 then
		local tag2         = getGradientTag(OutputName2)
		local displayName2 = tag2 and ("<%s>%s</%s>"):format(tag2, OutputName2, tag2) or OutputName2
		successMsg = successMsg .. " + " .. displayName2
	end
	for _, p in ipairs(Players:GetPlayers()) do
		NotificationService.Notify(p, successMsg, 5, "Sounds.Sfx.Success")
	end
	return true, "Recipe globally locked and machines cleared!"
end

function StockEventService.applyStockConfig(config, isReceiver, prefetchedStocks)
	globalStockIsActive = true

	local function parseIngredients(str)
		local t = {}
		for part in str:gmatch("[^,]+") do
			table.insert(t, part:match("^%s*(.-)%s*$"))
		end
		return t
	end

	local recipe1, result1, stockAmt1 = config[1], config[2], config[3]
	local recipe2, result2, stockAmt2 = config[4], config[5], config[6]
	local ingredients1 = parseIngredients(recipe1)

	if not (isReceiver and INITIAL_KEEPHIDDEN) then
		TeleportStockModel()
	end

	for _, Player in pairs(Players:GetPlayers()) do
		local Data = Synchronizer:Get(Player)
		if not Data then continue end
		local Podiums = Data:Get("AnimalPodiums") or {}
		local changed = false
		for idx, pd in pairs(Podiums) do
			if type(pd) == "table" and pd.Machine and pd.Machine.Type == "Taco2" then
				pd.Machine = nil
				changed = true
			end
		end
		if changed then
			Data:Set("AnimalPodiums", Podiums)
			Data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
		end
	end

	local amt1 = stockAmt1 or DEFAULT_STOCK
	local amt2 = nil

	LockedRecipe = { Output = result1, Inputs = ingredients1, MachineType = "Taco2" }
	ReplicatedStorage:SetAttribute("LockedRecipe_Taco2",      result1)
	ReplicatedStorage:SetAttribute("LockedIngredients_Taco2", table.concat(ingredients1, ","))

	if recipe2 and result2 then
		local ingredients2 = parseIngredients(recipe2)
		amt2 = stockAmt2 or DEFAULT_STOCK_2
		LockedRecipe2 = { Output = result2, Inputs = ingredients2, MachineType = "Taco2" }
		ReplicatedStorage:SetAttribute("LockedRecipe2_Taco2",      result2)
		ReplicatedStorage:SetAttribute("LockedIngredients2_Taco2", table.concat(ingredients2, ","))
	else
		LockedRecipe2 = nil
		ReplicatedStorage:SetAttribute("LockedRecipe2_Taco2",      nil)
		ReplicatedStorage:SetAttribute("LockedIngredients2_Taco2", nil)
		ReplicatedStorage:SetAttribute(STOCK_KEY_2,                nil)
	end

	if not isReceiver then
		SetGlobalStock(amt1, amt2)
		CurrentStock = amt1
		ReplicatedStorage:SetAttribute(STOCK_KEY, CurrentStock)
		if amt2 then
			CurrentStock2 = amt2
			ReplicatedStorage:SetAttribute(STOCK_KEY_2, CurrentStock2)
		else
			CurrentStock2 = 0
			ReplicatedStorage:SetAttribute(STOCK_KEY_2, 0)
		end
		ReplicatedStorage:SetAttribute("RecipeUpdateTick_Taco2", os.clock())
	else
		if prefetchedStocks then
			if type(prefetchedStocks.stock1) == "number" then
				CurrentStock = prefetchedStocks.stock1
				ReplicatedStorage:SetAttribute(STOCK_KEY, CurrentStock)
			else
				ReadGlobalStock1()
			end

			if amt2 then
				if type(prefetchedStocks.stock2) == "number" then
					CurrentStock2 = prefetchedStocks.stock2
					ReplicatedStorage:SetAttribute(STOCK_KEY_2, CurrentStock2)
				else
					ReadGlobalStock2()
				end
			else
				CurrentStock2 = 0
				ReplicatedStorage:SetAttribute(STOCK_KEY_2, 0)
			end
		else
			if amt2 then
				ReadBothGlobalStocks()
			else
				ReadGlobalStock1()
				CurrentStock2 = 0
				ReplicatedStorage:SetAttribute(STOCK_KEY_2, 0)
			end
		end
		ReplicatedStorage:SetAttribute("RecipeUpdateTick_Taco2", os.clock())
	end

	ReplicatedStorage:SetAttribute("RecipeUpdateTick_Taco2", os.clock())
	UpdateCountdownDisplay()
end

function StockEventService.starglobalstock(config, executorUserId)
	if executorUserId ~= 0 and executorUserId ~= 1215597321 then
		return false, "Unauthorized."
	end

	ClearGlobalStockEntries()

	local encoded = HttpService:JSONEncode(config)
	local setOk, setErr = pcall(function()
		GlobalStockMap:SetAsync(GLOBAL_STOCK_MAP_KEY, encoded, 604800)
	end)
	if not setOk then
		warn("[StockEventService] Failed to write config to MemoryStore:", setErr)
	end
	globalStockIsActive = true

	local stockAmt1 = config[3] or DEFAULT_STOCK
	local stockAmt2 = config[6] or (config[4] and config[5] and DEFAULT_STOCK_2 or nil)

	local writeOk1, writeErr1 = pcall(function()
		StockCounterMap1:SetAsync(GLOBAL_STOCK_KEY_1, stockAmt1, 604800)
	end)
	if not writeOk1 then
		warn("[StockEventService] Failed to write stock1 to MemoryStore:", writeErr1)
	end

	local writeOk2, writeErr2 = true, nil
	if stockAmt2 then
		writeOk2, writeErr2 = pcall(function()
			StockCounterMap2:SetAsync(GLOBAL_STOCK_KEY_2, stockAmt2, 604800)
		end)
		if not writeOk2 then
			warn("[StockEventService] Failed to write stock2 to MemoryStore:", writeErr2)
		end
	end

	StockEventService.applyStockConfig(config, false)


	for _, p in ipairs(Players:GetPlayers()) do
		NotificationService.Notify(p, "The Taco Truck recipe has been updated!", 5, "Sounds.Sfx.Success")
	end

	return true, "Global stock set and broadcast to all servers!"
end

function StockEventService.startStock(config, executorUserId, keepHidden, skipGlobalCheck)
	if not skipGlobalCheck then
		if globalStockIsActive then
			local remaining = CurrentStock + CurrentStock2
			return false, string.format(
				"Cannot start local stock — global stock still has %s items remaining.",
				formatNumber(remaining))
		end
		local checkOk, stored = pcall(function()
			return GlobalStockMap:GetAsync(GLOBAL_STOCK_MAP_KEY)
		end)
		if checkOk and stored ~= nil then
			globalStockIsActive = true
			local remaining = CurrentStock + CurrentStock2
			return false, string.format(
				"Cannot start local stock — global stock still has %s items remaining.",
				formatNumber(remaining))
		end
	end

	local recipe1, result1, stockAmt1 = config[1], config[2], config[3]
	local recipe2, result2, stockAmt2 = config[4], config[5], config[6]

	local function parseIngredients(str)
		local t = {}
		for part in str:gmatch("[^,]+") do
			table.insert(t, part:match("^%s*(.-)%s*$"))
		end
		return t
	end

	local ingredients1 = parseIngredients(recipe1)
	local amt1 = stockAmt1 or DEFAULT_STOCK

	LockedRecipe = { Output = result1, Inputs = ingredients1, MachineType = "Taco2" }
	ReplicatedStorage:SetAttribute("LockedRecipe_Taco2",      result1)
	ReplicatedStorage:SetAttribute("LockedIngredients_Taco2", table.concat(ingredients1, ","))

	local amt2 = nil
	if recipe2 and result2 then
		local ingredients2 = parseIngredients(recipe2)
		amt2 = stockAmt2 or DEFAULT_STOCK_2
		LockedRecipe2 = { Output = result2, Inputs = ingredients2, MachineType = "Taco2" }
		ReplicatedStorage:SetAttribute("LockedRecipe2_Taco2",      result2)
		ReplicatedStorage:SetAttribute("LockedIngredients2_Taco2", table.concat(ingredients2, ","))
	end

	if not keepHidden then
		TeleportStockModel()

		CurrentStock = amt1
		ReplicatedStorage:SetAttribute(STOCK_KEY, CurrentStock)

		if amt2 then
			CurrentStock2 = amt2
			ReplicatedStorage:SetAttribute(STOCK_KEY_2, CurrentStock2)
		else
			CurrentStock2 = 0
			ReplicatedStorage:SetAttribute(STOCK_KEY_2, 0)
		end

		ReplicatedStorage:SetAttribute("RecipeUpdateTick_Taco2", os.clock())
		UpdateCountdownDisplay()
	else
		CurrentStock  = 0
		CurrentStock2 = 0
		ReplicatedStorage:SetAttribute(STOCK_KEY,   0)
		ReplicatedStorage:SetAttribute(STOCK_KEY_2, 0)
		ReplicatedStorage:SetAttribute("RecipeUpdateTick_Taco2", os.clock())
		UpdateCountdownDisplay()
	end
	return true, "Local stock started!"
end

function StockEventService.stopglobalstock(executorUserId, presetSlot)
	if executorUserId ~= 0 and executorUserId ~= 1215597321 then
		return false, "Unauthorized."
	end

	ClearGlobalStockEntries()

	CurrentStock  = 0
	CurrentStock2 = 0
	ReplicatedStorage:SetAttribute(STOCK_KEY,   0)
	ReplicatedStorage:SetAttribute(STOCK_KEY_2, 0)

	ReplicatedStorage:SetAttribute("LockedRecipe_Taco2",       nil)
	ReplicatedStorage:SetAttribute("LockedIngredients_Taco2",  nil)
	ReplicatedStorage:SetAttribute("LockedRecipe2_Taco2",      nil)
	ReplicatedStorage:SetAttribute("LockedIngredients2_Taco2", nil)
	LockedRecipe  = nil
	LockedRecipe2 = nil

	HideStockModel()
	UpdateCountdownDisplay()


	for _, p in ipairs(Players:GetPlayers()) do
		NotificationService.Notify(p, "The Taco Truck has been closed by an admin! Restocking shortly...")
	end

	if presetSlot ~= nil then
		local preset = PRESET_STOCKS[presetSlot]
		if not preset then
			return false, string.format("Preset slot %d does not exist.", presetSlot)
		end
		task.delay(1, function()
			StockEventService.starglobalstock(preset, executorUserId)
		end)
		return true, string.format(
			"Global stock stopped and reverting to preset %d (%s)!",
			presetSlot, tostring(preset[2]))
	end

	task.delay(3, function()
		StockEventService.startStock(PRESET_STOCKS[1], nil, true, true)
	end)
	return true, "Global stock force-stopped. Truck hidden, default recipe loaded."
end

function StockEventService:Load()

	InitializeStock()

	do
		local eventsFolder = workspace:FindFirstChild("Events")
		local stockFolder  = eventsFolder and eventsFolder:FindFirstChild("Stock")
		local model        = stockFolder  and stockFolder:FindFirstChild("Model")
		if model then
			model:PivotTo(CFrame.new(STOCK_HIDDEN_POSITION) * CFrame.Angles(0, math.rad(180), 0))
		else
			task.spawn(function()
				local ef = workspace:WaitForChild("Events", 10)
				local sf = ef and ef:WaitForChild("Stock", 10)
				local m  = sf and sf:WaitForChild("Model", 10)
				if m then
					m:PivotTo(CFrame.new(STOCK_HIDDEN_POSITION) * CFrame.Angles(0, math.rad(180), 0))
				else
					warn("[StockEventService] Background: Failed to find Model after waiting!")
				end
			end)
		end
	end

	StockEventService.startStock(PRESET_STOCKS[1], nil, INITIAL_KEEPHIDDEN, true)

	UpdateCountdownDisplay()
end

function StockEventService:Start()


	task.spawn(function()
		local storedConfig   = nil
		local prefetchStock1 = nil
		local prefetchStock2 = nil
		local fetchesDone    = 0

		task.spawn(function()
			local ok, val = pcall(function()
				return GlobalStockMap:GetAsync(GLOBAL_STOCK_MAP_KEY)
			end)
			if ok then storedConfig = val end
			fetchesDone += 1
		end)

		task.spawn(function()
			local ok, val = pcall(function()
				return StockCounterMap1:GetAsync(GLOBAL_STOCK_KEY_1)
			end)
			if ok then prefetchStock1 = val end
			fetchesDone += 1
		end)

		task.spawn(function()
			local ok, val = pcall(function()
				return StockCounterMap2:GetAsync(GLOBAL_STOCK_KEY_2)
			end)
			if ok then prefetchStock2 = val end
			fetchesDone += 1
		end)

		while fetchesDone < 3 do task.wait() end

		if storedConfig then
			globalStockIsActive = true
			local config = HttpService:JSONDecode(storedConfig)
			StockEventService.applyStockConfig(config, true, {
				stock1 = prefetchStock1,
				stock2 = prefetchStock2,
			})
		else
			globalStockIsActive = false
			task.spawn(function()
				pcall(function() StockCounterMap1:RemoveAsync(GLOBAL_STOCK_KEY_1) end)
			end)
			task.spawn(function()
				pcall(function() StockCounterMap2:RemoveAsync(GLOBAL_STOCK_KEY_2) end)
			end)
		end
	end)

	task.spawn(function()
		while true do
			UpdateCountdownDisplay()
			task.wait(1)
		end
	end)

	task.spawn(function()
		while true do
			task.wait(30 + math.random(-5, 5))
			if (os.clock() - lastBroadcastReceived) > 20 then
				if IsGlobalStockActive() then
					ReadBothGlobalStocks()
				end
			end
		end
	end)

	for _, Player in Players:GetChildren() do
		task.spawn(PlayerAdded, Player)
	end
	Players.PlayerAdded:Connect(PlayerAdded)
end

return StockEventService