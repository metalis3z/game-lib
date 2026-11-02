local SantaMerchantService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local DataStoreService = game:GetService("DataStoreService")
local MarketplaceService = game:GetService("MarketplaceService")

local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local SantaData = require(ReplicatedStorage.Datas.SantaMerchantData)
local Animals = require(ReplicatedStorage.Datas.Animals)

local AnimalService = require(ServerScriptService.Services.AnimalService)
local NotificationService = require(ServerScriptService.Services.NotificationService)

local CollectGoldElfRE = Net:RemoteEvent("SantaMerchantService/CollectGoldElf")
local SetFocusedRE = Net:RemoteEvent("SantaMerchantService/SetFocused")
local AnimationRE = Net:RemoteEvent("SantaMerchantService/Animation")
local BuySantaRF = Net:RemoteFunction("SantaMerchantService/Buy")

local MetaStore = DataStoreService:GetDataStore("SantaMerchantMeta_V4")

local SANTA_EVENT_ENABLED = false

local function createStockAttributes()
	for _, item in ipairs(SantaData.Brainrots) do
		local attrName = "SantaMerchant_" .. item.Brainrot:gsub("%s", "_")
	end
end

local function stockAttribute(name)
	return "SantaMerchant_" .. name:gsub("%s", "_")
end

local function loadMeta()
	if not SANTA_EVENT_ENABLED then
		return
	end

	local data
	pcall(function()
		data = MetaStore:GetAsync("GLOBAL")
	end)

	if type(data) ~= "table" then
		data = {}
	end

	for _, item in ipairs(SantaData.Brainrots) do
		local attrName = stockAttribute(item.Brainrot)
		local stock = item.Stock

		if data.Stocks and data.Stocks[item.Brainrot] ~= nil then
			stock = data.Stocks[item.Brainrot]
		end
	end
end

local function doRestock()
	if not SANTA_EVENT_ENABLED then
		return
	end

	MetaStore:UpdateAsync("GLOBAL", function(old)
		old = old or {}

		local now = os.time()
		if old.NextStockId and old.NextStockId > now then
			return old
		end

		old.StockId = (old.StockId or 0) + 1
		old.NextStockId = now + 3600
		old.Stocks = {}

		for _, item in ipairs(SantaData.Brainrots) do
			old.Stocks[item.Brainrot] = item.Stock
		end

		return old
	end)

	loadMeta()
end

BuySantaRF.OnServerInvoke = function(player, merchantId, index)
	if not SANTA_EVENT_ENABLED then
		return false
	end

	if type(index) ~= "number" or index % 1 ~= 0 then
		return false
	end

	local entry = SantaData.Brainrots[index]
	if not entry then
		return false
	end

	local channel = Synchronizer:Get(player)
	if not channel then
		return false
	end

	local price = entry.Price
	local elves = channel:Get("ChristmasEvent.GoldElves") or 0

	if elves < price then
		NotificationService.Error(player, "Not enough Gold Elves!")
		return false
	end

	local success = false

	MetaStore:UpdateAsync("GLOBAL", function(old)
		old = old or {}
		old.Stocks = old.Stocks or {}

		local currentStock = old.Stocks[entry.Brainrot] or entry.Stock

		if currentStock <= 0 then
			return old
		end

		old.Stocks[entry.Brainrot] = currentStock - 1
		success = true
		return old
	end)

	if not success then
		if SANTA_EVENT_ENABLED then
			NotificationService.Error(player, "You can't buy this product!")
		end
		return false
	end

	channel:Increase("ChristmasEvent.GoldElves", -price)

	local attrName = stockAttribute(entry.Brainrot)
	local current = ReplicatedStorage:GetAttribute(attrName) or 1

	local animalData = Animals[entry.Brainrot]
	if animalData then
		pcall(function()
			AnimalService.spawnAnimalCustom(
				animalData,
				nil,
				nil,
				nil,
				{
					Start = workspace.Road.Start,
					End = workspace.Road.End,
					Owner = player
				},
				0
			)
		end)
	end

	NotificationService.Success(player, "Purchase successful!")
	AnimationRE:FireAllClients("Buy")

	return true
end

CollectGoldElfRE.OnServerEvent:Connect(function(player)
	if not SANTA_EVENT_ENABLED then return end

	local channel = Synchronizer:Get(player)
	if channel then
		channel:Increase("ChristmasEvent.GoldElves", 1)
	end
end)

function SantaMerchantService:Start()
	createStockAttributes()

	if not SANTA_EVENT_ENABLED then
		return
	end

	loadMeta()

	task.spawn(function()
		while true do
			if not SANTA_EVENT_ENABLED then
				task.wait(1)
				continue
			end

			local nextTime = ReplicatedStorage:GetAttribute("SantaMerchantNextStockId")

			if type(nextTime) == "number" and os.time() >= nextTime then
				doRestock()
			end

			task.wait(1)
		end
	end)
end

return SantaMerchantService