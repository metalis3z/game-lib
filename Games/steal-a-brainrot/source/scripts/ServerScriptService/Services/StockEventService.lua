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

local Return = Net:RemoteEvent("StockEventService/Return")
local Redeem = Net:RemoteEvent("StockEventService/Redeem")
local Delivery = Net:RemoteFunction("StockEventService/Delivery")
local StandardReturn = Net:RemoteEvent("PlotService/Return")
local ListItems = Net:RemoteFunction("StockEventService/ListItems")

local DataStoreService = game:GetService("DataStoreService")
local StockStore = DataStoreService:GetDataStore("Taco8")

local StockKeys = {
	["Meowl"] = "StockEvent_Meowl",
	["Roki Elephant"] = "StockEvent_Roki_Elephant",
}

local DefaultStock = {
	["Meowl"] = 10,
	["Roki Elephant"] = 20,
}

local CurrentStock = {}
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

	local TotalStock = 0

	for _,value in pairs(CurrentStock) do
		if typeof(value) == "number" then
			TotalStock += value
		end
	end

	if TotalStock <= 0 then
		Countdown.Text = "SOLD OUT"
		Countdown.TextColor3 = Color3.fromRGB(255,0,0)
	else
		Countdown.Text = FormatNumber(TotalStock).." Left"
		Countdown.TextColor3 = Color3.fromRGB(255,255,255)
	end
end

local function ColoredName(Index)
	local Animal = AnimalsDB[Index]
	if not Animal then
		return tostring(Index)
	end

	local Rarity = Animal.Rarity
	local RarityData = Rarities[Rarity]

	if not RarityData then
		return Animal.DisplayName or Index
	end

	if RarityData.GradientPreset then
		local gradientMap = {
			Rainbow = "rainbow",
			Zebra = "zebra",
			OG = "og",
			YellowRed = "yellowred",
			Greenred = "greenred",
			SlowGreenRed = "slowgreenred"
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

ListItems.OnServerInvoke = function(Player, Key, MachineName)
	if Key ~= "a694d84f-7b1b-4cec-b21d-c831b291a0c0" then
		return false, "InvalidKey"
	end

	local Data = StockMachineData[MachineName]

	if not Data then
		return false, "Retry"
	end

	return true, Data
end

local function DeepCopy(tbl)
	if type(tbl) ~= "table" then
		return tbl
	end

	local copy = {}

	for k,v in pairs(tbl) do
		copy[k] = DeepCopy(v)
	end

	return setmetatable(copy, getmetatable(tbl))
end

local function InitializeStock()
	for Recipe,Key in pairs(StockKeys) do

		local Success,Stored = pcall(function()
			return StockStore:GetAsync(Key)
		end)

		if Success and typeof(Stored) == "number" then
			CurrentStock[Recipe] = Stored
		else
			CurrentStock[Recipe] = DefaultStock[Recipe]
		end

		ReplicatedStorage:SetAttribute(Key,nil)
		ReplicatedStorage:SetAttribute(Key,CurrentStock[Recipe])
	end
end

local function ConsumeStock(Recipe)
	local Key = StockKeys[Recipe]
	local Stock = CurrentStock[Recipe]

	if not Stock or Stock <= 0 then
		return false
	end

	Stock -= 1
	CurrentStock[Recipe] = Stock

	ReplicatedStorage:SetAttribute(Key,nil)
	ReplicatedStorage:SetAttribute(Key,Stock)

	UpdateStockBillboard()

	if not SaveCooldown then

		SaveCooldown = true

		task.delay(5,function()
			SaveCooldown = false
		end)

		pcall(function()
			StockStore:SetAsync(Key,Stock)
		end)

	end

	return true
end

local function FindFreePodiumSlot(Podiums)
	for Index = 1,50 do
		if Podiums[Index] == nil or Podiums[Index] == "Empty" then
			return Index
		end
	end

	return nil
end

local function HasAllRequiredAnimals(Player)
	local Data = Synchronizer:Get(Player)
	if not Data then return false end

	local Podiums = Data:Get("AnimalPodiums") or {}
	local Available = {}

	for _,PodiumData in pairs(Podiums) do
		if type(PodiumData) == "table"
			and PodiumData.Machine
			and PodiumData.Machine.Type == "Taco8"
			and not PodiumData.Machine.Active then

			local Name = PodiumData.Index
			Available[Name] = (Available[Name] or 0) + 1
		end
	end

	for RecipeName,Recipe in pairs(StockMachineData.Taco8) do

		local Valid = true

		for _,Required in pairs(Recipe.Inputs) do
			if (Available[Required] or 0) < 1 then
				Valid = false
				break
			end
		end

		if Valid then
			return true,RecipeName,Recipe
		end
	end

	return false
end

local function ConsumeAnimals(Player,Recipe)
	local Data = Synchronizer:Get(Player)
	if not Data then return false end

	local Podiums = Data:Get("AnimalPodiums") or {}
	local Required = {}

	for _,AnimalName in pairs(Recipe.Inputs) do
		Required[AnimalName] = (Required[AnimalName] or 0) + 1
	end

	local ToActivate = {}

	for Index,PodiumData in pairs(Podiums) do
		if type(PodiumData) == "table"
			and PodiumData.Machine
			and PodiumData.Machine.Type == "Taco8"
			and not PodiumData.Machine.Active then

			local Name = PodiumData.Index

			if Required[Name] and Required[Name] > 0 then
				table.insert(ToActivate,Index)
				Required[Name] -= 1
			end
		end
	end

	for _,Amount in pairs(Required) do
		if Amount > 0 then
			return false
		end
	end

	for _,Index in ipairs(ToActivate) do
		Podiums[Index].Machine.Active = true
	end

	Data:Set("AnimalPodiums",Podiums)

	return true
end

local function IsValidTacoAnimal(AnimalName)
	for _,Recipe in pairs(StockMachineData.Taco8) do
		for _,Required in pairs(Recipe.Inputs) do
			if Required == AnimalName then
				return true
			end
		end
	end
	return false
end

Delivery.OnServerInvoke = function(Player,MachineName,Hitbox)
	local Data = Synchronizer:Get(Player)
	if not Data then return false end

	local StealData = StealService:GetStealData(Player)
	if not StealData then return false end

	local StolenAnimalData = StealData.StolenAnimalData
	if not StolenAnimalData then return false end

	local AnimalName = StolenAnimalData.Index
	if not IsValidTacoAnimal(AnimalName) then
		return false
	end
	local Traits = StolenAnimalData.Traits
	local Mutation = StolenAnimalData.Mutation

	if Traits then
		Traits = DeepCopy(Traits)
	end

	local Podiums = Data:Get("AnimalPodiums") or {}

	local OriginalPodiumIndex = StealData.PodiumIndex
	local Slot = OriginalPodiumIndex or FindFreePodiumSlot(Podiums)

	if not Slot then
		return false
	end

	Podiums[Slot] = {
		Index = AnimalName,
		LastCollect = StolenAnimalData.LastCollect or workspace:GetServerTimeNow(),
		OfflineGain = StolenAnimalData.OfflineGain,
		Mutation = Mutation,
		Traits = Traits,
		Machine = {
			Type = "Taco8",
			Active = false
		}
	}

	Data:Set("AnimalPodiums",Podiums)
	Data:Set("AnimalAddedOrRemoved",workspace:GetServerTimeNow())

	StealService:CancelSteal(Player)

	local SuccessSound = ReplicatedStorage.Sounds.Sfx.Success

	NotificationService.Notify(
		Player,
		"You gave Sammy "..ColoredName(AnimalName).."!",
		5,
		SuccessSound
	)

	return true
end

local function HandleReturn(Player,PodiumIndex)
	local Data = Synchronizer:Get(Player)
	if not Data then return end

	local Podiums = Data:Get("AnimalPodiums") or {}
	local PodiumData = Podiums[PodiumIndex]

	if not PodiumData then return end
	if not PodiumData.Machine or PodiumData.Machine.Type ~= "Taco8" then return end

	PodiumData.Machine = nil
	Podiums[PodiumIndex] = PodiumData

	Data:Set("AnimalPodiums",Podiums)
	Data:Set("AnimalAddedOrRemoved",workspace:GetServerTimeNow())
end

Return.OnServerEvent:Connect(HandleReturn)
StandardReturn.OnServerEvent:Connect(HandleReturn)

Redeem.OnServerEvent:Connect(function(Player)
	local HasRecipe,RecipeName,Recipe = HasAllRequiredAnimals(Player)
	if not HasRecipe then return end

	if not ConsumeStock(RecipeName) then
		NotificationService.Error(Player,"Sold Out!")
		return
	end

	if not ConsumeAnimals(Player,Recipe) then
		return
	end

	AnimalService.SpawnForcedAnimal(AnimalsDB[Recipe.Output])

	local Data = Synchronizer:Get(Player)
	local Podiums = Data:Get("AnimalPodiums") or {}

	for Index,Value in pairs(Podiums) do
		if type(Value) == "table"
			and Value.Machine
			and Value.Machine.Type == "Taco8"
			and Value.Machine.Active then

			Podiums[Index] = "Empty"
		end
	end

	Data:Set("AnimalPodiums",Podiums)
	Data:Set("AnimalAddedOrRemoved",workspace:GetServerTimeNow())

	NotificationService.Success(Player,Recipe.Output.." Spawned!")
end)

function StockEventService:Start()
	ReplicatedStorage:SetAttribute("StockEvent", true)
	InitializeStock()
	UpdateStockBillboard()

	for _,Player in pairs(Players:GetPlayers()) do
		Synchronizer:Wait(Player)
	end

	Players.PlayerAdded:Connect(function(Player)
		Synchronizer:Wait(Player)

		for Recipe,Key in pairs(StockKeys) do
			ReplicatedStorage:SetAttribute(Key,nil)
			ReplicatedStorage:SetAttribute(Key,CurrentStock[Recipe])
		end
	end)

	task.delay(2,function()
		for Recipe,Key in pairs(StockKeys) do
			ReplicatedStorage:SetAttribute(Key,nil)
			ReplicatedStorage:SetAttribute(Key,CurrentStock[Recipe])
		end
	end)
end

return StockEventService