local StockEventService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

local PlotService = require(ServerScriptService.Services.PlotService)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local StealService = require(ServerScriptService.Services.StealService)
local NotificationService = require(ServerScriptService.Services.NotificationService)

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)

local AnimalsDB = require(ReplicatedStorage.Datas.Animals)
local Rarities = require(ReplicatedStorage.Datas.Rarities)

local StockMachineData = require(ServerStorage.Modules.StockData)

local SetFocused = Net:RemoteEvent("StockEventService/SetFocused")
local Update = Net:RemoteEvent("StockEventService/Update")
local Return = Net:RemoteEvent("StockEventService/Return")
local Redeem = Net:RemoteEvent("StockEventService/Redeem")
local Delivery = Net:RemoteFunction("StockEventService/Delivery")
local StandardReturn = Net:RemoteEvent("PlotService/Return")
local DataStoreService = game:GetService("DataStoreService")
local StockStore = DataStoreService:GetDataStore("GlobalMainStock")

local Stock_Key = "StockEvent_Tuff_Toucan"
local Stock = 300000

local SaveCooldown = false

local function FormatNumber(Number)
	local Text = tostring(Number)
	local Count

	repeat
		Text, Count = Text:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
	until Count == 0

	return Text
end

local function UpdateStockBillboard()
	local StockModel = workspace
		:WaitForChild("Events")
		:WaitForChild("Stock")
		:WaitForChild("Model")

	local Countdown = StockModel
		:WaitForChild("Overhead")
		:WaitForChild("BillboardGui")
		:WaitForChild("Countdown")

	if typeof(CurrentStock) == "number" then
		if CurrentStock <= 0 then
			Countdown.Text = "0 Left"
		else
			Countdown.Text = FormatNumber(CurrentStock) .. " Left"
		end
	else
		Countdown.Text = "Loading..."
	end
end

ReplicatedStorage:SetAttribute("StockEvent", true)

local function loadStock()
	local ok, data = pcall(function()
		return StockStore:GetAsync(Stock_Key)
	end)
	if ok and typeof(data) == "number" then
		return data
	end
end

local function DeepCopy(tbl)
	if type(tbl) ~= "table" then
		return tbl
	end

	local copy = {}
	for k, v in pairs(tbl) do
		copy[k] = DeepCopy(v)
	end

	return setmetatable(copy, getmetatable(tbl))
end

local function saveStock(value)
	if SaveCooldown then return end
	SaveCooldown = true
	task.delay(5, function() SaveCooldown = false end)

	pcall(function()
		StockStore:SetAsync(Stock_Key, value)
	end)
end

local function UpdateStockBatched(newStock: number)
	CurrentStock = newStock
	ReplicatedStorage:SetAttribute(Stock_Key, CurrentStock)
	saveStock(CurrentStock)
	UpdateStockBillboard()
end

local function formatNumber(num)
	local formatted = tostring(num)
	local k
	while true do
		formatted, k = formatted:gsub("^(-?%d+)(%d%d%d)", '%1,%2')
		if k == 0 then break end
	end
	return formatted
end

ReplicatedStorage:GetAttributeChangedSignal(Stock_Key):Connect(function()
	CurrentStock = ReplicatedStorage:GetAttribute(Stock_Key)
end)

local function InitializeStock()
	local existing = loadStock()
	if existing then
		CurrentStock = existing
	else
		CurrentStock = Stock
		saveStock(CurrentStock)
	end
	ReplicatedStorage:SetAttribute(Stock_Key, CurrentStock)
end

local function ConsumeStock(): boolean
	if CurrentStock <= 0 then
		return false
	end
	UpdateStockBatched(math.max(0, CurrentStock - 1))
	return true
end

local function RestoreStock()
	UpdateStockBatched(CurrentStock + 1)
end

local CurrentStock = Stock

local function FindFreePodiumSlot(Podiums)
	for i = 1, 50 do
		if Podiums[i] == nil or Podiums[i] == "Empty" then
			return i
		end
	end
	return nil
end

local function ColoredName(Index: string): string
	local Animal = AnimalsDB[Index]
	if not Animal then return tostring(Index) end

	local Rarity = Animal.Rarity
	local RarityData = Rarities[Rarity]
	if not RarityData then return Animal.DisplayName or Index end

	if RarityData.GradientPreset then
		local gradientMap = {
			Rainbow = "rainbow",
			Zebra = "zebra",
			OG = "og",
			YellowRed = "yellowred",
			Greenred = "greenred"
		}

		local gradientTag = gradientMap[RarityData.GradientPreset]
		if gradientTag then
			return string.format("<%s>%s</%s>", gradientTag, Animal.DisplayName or Index, gradientTag)
		end
	end

	if RarityData.Color and typeof(RarityData.Color) == "Color3" then
		local hex = RarityData.Color:ToHex()
		return string.format('<font color="#%s">%s</font>', hex, Animal.DisplayName or Index)
	end

	return Animal.DisplayName or tostring(Index)
end

local function IsAnimalRequiredForMainStock(AnimalName: string): boolean
	for _, RequiredAnimal in StockMachineData.MainStock["Tuff Toucan"].Inputs do
		if RequiredAnimal == AnimalName then
			return true
		end
	end
	return false
end

local function HasAllRequiredAnimals(Player: Player): boolean
	local Data = Synchronizer:Get(Player)
	if not Data then return false end

	local Podiums = Data:Get("AnimalPodiums") or {}
	local Available = {}

	for _, PodiumData in Podiums do
		if type(PodiumData) == "table" and PodiumData.Machine and PodiumData.Machine.Type == "MainStock" and not PodiumData.Machine.Active then
			local AnimalName = PodiumData.Index
			Available[AnimalName] = (Available[AnimalName] or 0) + 1
		end
	end

	for _, RequiredAnimal in StockMachineData.MainStock["Tuff Toucan"].Inputs do
		if (Available[RequiredAnimal] or 0) < 1 then
			return false
		end
	end

	return true
end

local function ConsumeAnimals(Player: Player): boolean
	local Data = Synchronizer:Get(Player)
	if not Data then return false end

	local Podiums = Data:Get("AnimalPodiums") or {}
	local Required = {}

	for _, AnimalName in StockMachineData.MainStock["Tuff Toucan"].Inputs do
		Required[AnimalName] = (Required[AnimalName] or 0) + 1
	end

	local ToActivate = {}

	for PodiumIndex, PodiumData in pairs(Podiums) do
		if type(PodiumData) == "table"
			and PodiumData.Machine
			and PodiumData.Machine.Type == "MainStock"
			and not PodiumData.Machine.Active then

			local name = PodiumData.Index
			if Required[name] and Required[name] > 0 then
				table.insert(ToActivate, PodiumIndex)
				Required[name] -= 1
			end
		end
	end

	for _, amount in pairs(Required) do
		if amount > 0 then
			return false
		end
	end

	for _, index in ipairs(ToActivate) do
		Podiums[index].Machine.Active = true
	end

	Data:Set("AnimalPodiums", Podiums)
	return true
end

Delivery.OnServerInvoke = function(Player: Player, Hitbox: BasePart): boolean
	local Data = Synchronizer:Get(Player)
	if not Data then return false end

	local StealData = StealService:GetStealData(Player)
	if not StealData then return false end

	local StolenAnimalData = StealData.StolenAnimalData
	if not StolenAnimalData then return false end

	local AnimalName = StolenAnimalData.Index or "Noobini"

	if not IsAnimalRequiredForMainStock(AnimalName) then
		return false
	end

	local Podiums = Data:Get("AnimalPodiums") or {}
	local AvailableSlot = FindFreePodiumSlot(Podiums)

	if not AvailableSlot then
		NotificationService.Error(Player, "No available podium slots")
		StealService:CancelSteal(Player)
		return false
	end

	local Traits = StolenAnimalData.Traits
	local Mutation = StolenAnimalData.Mutation
	if Traits then
		Traits = DeepCopy(Traits)
	end

	local OriginalPodiumIndex = StealData.PodiumIndex

	if OriginalPodiumIndex then
		Podiums[OriginalPodiumIndex] = {
			Index = AnimalName,
			LastCollect = StolenAnimalData.LastCollect or workspace:GetServerTimeNow(),
			OfflineGain = StolenAnimalData.OfflineGain,
			Mutation = Mutation,
			Traits = Traits,
			Machine = {
				Type = "MainStock",
				Active = false
			}
		}
	else
		Podiums[AvailableSlot] = {
			IndexOnPlot = OriginalPodiumIndex or AvailableSlot,
			Index = AnimalName,
			LastCollect = StolenAnimalData.LastCollect or workspace:GetServerTimeNow(),
			OfflineGain = StolenAnimalData.OfflineGain or nil,
			Traits = Traits,
			Machine = {
				Type = "MainStock",
				Active = false
			}
		}
	end

	Data:Set("AnimalPodiums", Podiums)
	Data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())

	StealService:CancelSteal(Player)
	local SuccessSound = ReplicatedStorage.Sounds.Sfx.Success

	NotificationService.Notify(
		Player,
		string.format("You gave Tuff Toucan %s!", ColoredName(AnimalName)),
		5,
		SuccessSound
	)
	return true
end

local function HandleReturn(Player: Player, PodiumIndex: number)
	local Data = Synchronizer:Get(Player)
	if not Data then return end

	local Podiums = Data:Get("AnimalPodiums") or {}
	local PodiumData = Podiums[PodiumIndex]

	if not PodiumData then return end
	if not PodiumData.Machine or PodiumData.Machine.Type ~= "MainStock" then return end

	PodiumData.Machine = nil
	Podiums[PodiumIndex] = PodiumData

	Data:Set("AnimalPodiums", Podiums)
	Data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
end

Return.OnServerEvent:Connect(HandleReturn)
StandardReturn.OnServerEvent:Connect(HandleReturn)

Redeem.OnServerEvent:Connect(function(Player: Player)
	local Data = Synchronizer:Get(Player)
	if not Data then return end

	if not HasAllRequiredAnimals(Player) then
		--		NotificationService.Error(Player, "You don't have all required animals for the MainStock Stock machine!")
		return
	end

	if not ConsumeStock() then
		NotificationService.Error(Player, "Sold Out!")
		return
	end

	local Plot = PlotService.getPlot(Player)
	if not Plot then
		UpdateStockBatched(CurrentStock + 1)
		--		NotificationService.Error(Player, "No plot found!")
		return
	end

	if not ConsumeAnimals(Player) then
		--		NotificationService.Error(Player, "Failed to consume required animals!")
		UpdateStockBatched(CurrentStock + 1)
		return
	end

	AnimalService.SpawnForcedAnimal(AnimalsDB[StockMachineData.MainStock["Tuff Toucan"].Output])

	local Podiums = Data:Get("AnimalPodiums") or {}

	for PodiumIndex, PodiumData in Podiums do
		if type(PodiumData) == "table" and PodiumData.Machine and PodiumData.Machine.Type == "MainStock" and PodiumData.Machine.Active then
			Podiums[PodiumIndex] = "Empty"
		end
	end

	Data:Set("AnimalPodiums", Podiums)
	Data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())

	NotificationService.Success(Player, string.format("%s Spawned!", StockMachineData.MainStock["Tuff Toucan"].Output))
end)

local function PlayerAdded(Player: Player)
	Synchronizer:Wait(Player)
end

function StockEventService:Start()
	InitializeStock()
	UpdateStockBillboard()
	for _, Player in Players:GetPlayers() do
		PlayerAdded(Player)
	end
	Players.PlayerAdded:Connect(PlayerAdded)
end

return StockEventService