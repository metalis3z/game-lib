local SantaMerchantService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local MarketplaceService = game:GetService("MarketplaceService")
local MemoryStoreService = game:GetService("MemoryStoreService")
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local SantaData = require(ReplicatedStorage.Datas.SantaMerchantData)
local Animals = require(ReplicatedStorage.Datas.Animals)

local AnimalService = require(ServerScriptService.Services.AnimalService)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local MessagingService = require(ServerScriptService.Services.MessagingService)

local CollectGoldElfRE = Net:RemoteEvent("SantaMerchantService/CollectGoldElf")
local CollectBrotinhoElfRE = Net:RemoteEvent("SantaMerchantService/CollectBrotinhoElf")
local SetFocusedRE = Net:RemoteEvent("SantaMerchantService/SetFocused")
local AnimationRE = Net:RemoteEvent("SantaMerchantService/Animation")
local BuySantaRF = Net:RemoteFunction("SantaMerchantService/Buy")


local SANTA_EVENT_ENABLED = false


local OVERRIDE_MAP_NAME = "SantaMerchantOverrides_v1"
local OVERRIDE_KEY = "ACTIVE"
local OVERRIDE_TTL = 86400 * 7
local OVERRIDE_MSG_TOPIC = "SantaMerchantSlotOverride"
local OVERRIDE_ATTRIBUTE = "SantaMerchantOverrides"
local DEFAULT_CURRENCY = "elf"
local VALID_CURRENCIES = { elf = true, brotinho = true }


local CURRENCY_PATHS = {
	elf = "ChristmasEvent.GoldElves",
	brotinho = "ChristmasEvent.BrotinhoCoins",
}
local CURRENCY_MAX = {
	elf = 5000,
	brotinho = 5000,
}
local CURRENCY_LABELS = {
	elf = "Gold Elves",
	brotinho = "Brotinho Coins",
}

local OverrideMap = MemoryStoreService:GetSortedMap(OVERRIDE_MAP_NAME)

local activeOverrides = {}

local MIN_RESERVE_BLOCK = 1
local MAX_RESERVE_BLOCK = 10
local RESERVE_FRACTION = 0.10

local reservationInFlight = {}

local function normalizeCurrency(currency)
	if currency == nil then
		return DEFAULT_CURRENCY
	end
	if type(currency) ~= "string" then
		return nil
	end
	currency = string.lower(currency)
	if not VALID_CURRENCIES[currency] then
		return nil
	end
	return currency
end

local function publishOverridesToClients()
	if next(activeOverrides) == nil then
		ReplicatedStorage:SetAttribute(OVERRIDE_ATTRIBUTE, nil)
		return
	end

	local ok, encoded = pcall(function()
		return HttpService:JSONEncode(activeOverrides)
	end)

	if ok and encoded then
		ReplicatedStorage:SetAttribute(OVERRIDE_ATTRIBUTE, encoded)
	else
		warn("[SantaMerchantService] Failed to JSON-encode slot overrides:", encoded)
	end
end

local function applyOverrideLocally(slot, animalName, cost, currency, stockCount)
	activeOverrides[tostring(slot)] = {
		Animal = animalName,
		Cost = cost,
		Currency = currency,
		Slot = slot,
		Stock = stockCount,
		Reserve = 0,
	}
	reservationInFlight[tostring(slot)] = nil
	publishOverridesToClients()
end

local function clearOverridesLocally()
	table.clear(activeOverrides)
	table.clear(reservationInFlight)
	publishOverridesToClients()
end


local function memoryWriteOverride(slot, record)
	local ok, err = pcall(function()
		OverrideMap:UpdateAsync(OVERRIDE_KEY, function(old)
			if type(old) ~= "table" then
				old = {}
			end
			old[tostring(slot)] = record
			return old
		end, OVERRIDE_TTL)
	end)
	if not ok then
		warn("[SantaMerchantService] MemoryStore write failed:", err)
	end
	return ok
end


local function reserveStockBlock(slotKey, slot)
	if reservationInFlight[slotKey] then
		local waited = 0
		while reservationInFlight[slotKey] and waited < 5 do
			waited += task.wait()
		end
		local record = activeOverrides[slotKey]
		if type(record) == "table" and record.Stock ~= nil then
			local ok, pool = pcall(function()
				local stored = OverrideMap:GetAsync(OVERRIDE_KEY)
				if type(stored) == "table" and type(stored[slotKey]) == "table" then
					return tonumber(stored[slotKey].Stock)
				end
				return nil
			end)
			if ok and pool ~= nil then
				record.Stock = pool + (record.Reserve or 0)
				publishOverridesToClients()
			end
		end
		return
	end

	reservationInFlight[slotKey] = true

	local granted = 0
	local pool = nil
	local ok, err = pcall(function()
		OverrideMap:UpdateAsync(OVERRIDE_KEY, function(old)
			if type(old) ~= "table" then
				return nil
			end
			local rec = old[slotKey]
			if type(rec) ~= "table" or rec.Stock == nil then
				granted = 0
				return old
			end
			local available = tonumber(rec.Stock) or 0
			if available <= 0 then
				granted = 0
				pool = 0
				return old
			end
			local block = math.clamp(
				math.ceil(available * RESERVE_FRACTION),
				MIN_RESERVE_BLOCK,
				MAX_RESERVE_BLOCK
			)
			granted = math.min(block, available)
			rec.Stock = available - granted
			pool = rec.Stock
			return old
		end, OVERRIDE_TTL)
	end)

	reservationInFlight[slotKey] = false

	if not ok then
		warn("[SantaMerchantService] MemoryStore stock reservation failed (will retry):", err)
		return
	end

	local record = activeOverrides[slotKey]
	if type(record) == "table" and record.Stock ~= nil then
		record.Reserve = (record.Reserve or 0) + granted
		if pool ~= nil then
			record.Stock = pool + (record.Reserve or 0)
		end
		publishOverridesToClients()
	end
end

local function claimStockForPurchase(slot)
	local key = tostring(slot)
	local record = activeOverrides[key]
	if type(record) ~= "table" then
		return false
	end
	if record.Stock == nil then
		return true
	end

	if (record.Reserve or 0) <= 0 then
		reserveStockBlock(key, slot)
		record = activeOverrides[key]
		if type(record) ~= "table" then
			return false
		end
		if record.Stock == nil then
			return true
		end
	end

	if (record.Reserve or 0) <= 0 then
		if (tonumber(record.Stock) or 0) ~= 0 then
			record.Stock = 0
			publishOverridesToClients()
		end
		return false
	end

	record.Reserve = record.Reserve - 1
	record.Stock = math.max((tonumber(record.Stock) or 0) - 1, 0)
	publishOverridesToClients()
	return true
end

local function refundLocalReserve(slot)
	local key = tostring(slot)
	local record = activeOverrides[key]
	if type(record) == "table" and record.Stock ~= nil then
		record.Reserve = (record.Reserve or 0) + 1
		record.Stock = (tonumber(record.Stock) or 0) + 1
		publishOverridesToClients()
	end
end

local function returnAllReserves()
	local toReturn = {}
	local any = false
	for slotKey, record in pairs(activeOverrides) do
		if type(record) == "table" and record.Stock ~= nil and (record.Reserve or 0) > 0 then
			toReturn[slotKey] = record.Reserve
			record.Reserve = 0
			any = true
		end
	end
	if not any then
		return
	end
	pcall(function()
		OverrideMap:UpdateAsync(OVERRIDE_KEY, function(old)
			if type(old) ~= "table" then
				return old
			end
			for slotKey, amount in pairs(toReturn) do
				local rec = old[slotKey]
				if type(rec) == "table" and rec.Stock ~= nil then
					rec.Stock = (tonumber(rec.Stock) or 0) + amount
				end
			end
			return old
		end, OVERRIDE_TTL)
	end)
end


local function memoryClearOverrides()
	local ok, err = pcall(function()
		OverrideMap:RemoveAsync(OVERRIDE_KEY)
	end)
	if not ok then
		warn("[SantaMerchantService] MemoryStore clear failed:", err)
	end
	return ok
end

local function memoryReadOverrides()
	local ok, result = pcall(function()
		return OverrideMap:GetAsync(OVERRIDE_KEY)
	end)
	if not ok then
		warn("[SantaMerchantService] MemoryStore read failed:", result)
		return nil
	end
	if type(result) ~= "table" then
		return nil
	end
	return result
end

local function createStockAttributes()

	for _, item in ipairs(SantaData.Brainrots) do
		local attrName = "SantaMerchant_" .. item.Brainrot:gsub("%s", "_")

		ReplicatedStorage:SetAttribute(attrName, item.Stock or 0)
	end

	ReplicatedStorage:SetAttribute("SantaMerchantStockId", 0)
	ReplicatedStorage:SetAttribute("SantaMerchantNextStockId", 0)
end

local function stockAttribute(name)
	return "SantaMerchant_" .. name:gsub("%s", "_")
end

local function loadMeta()

	if not SANTA_EVENT_ENABLED then
		ReplicatedStorage:SetAttribute("SantaMerchantNextStockId", 0)
		return
	end

	ReplicatedStorage:SetAttribute("SantaMerchantStockId", 0)
	ReplicatedStorage:SetAttribute("SantaMerchantNextStockId", 0)
end

local function doRestock()

	return
end

local function purchaseOverrideSlot(player, override)
	local channel = Synchronizer:Get(player)
	if not channel then
		return false
	end

	local animalName = override.Animal
	local animalData = Animals[animalName]
	if not animalData then
		NotificationService.Error(player, "This item is unavailable right now.")
		return false
	end

	local currency = normalizeCurrency(override.Currency) or DEFAULT_CURRENCY
	local cost = tonumber(override.Cost) or 0
	if cost < 0 then cost = 0 end

	local path = CURRENCY_PATHS[currency]
	local label = CURRENCY_LABELS[currency] or "currency"

	local hasLimitedStock = override.Stock ~= nil
	if hasLimitedStock then
		if not claimStockForPurchase(override.Slot) then
			NotificationService.Error(player, "This item is sold out!")
			return false
		end
	end

	if cost > 0 then
		local balance = channel:Get(path) or 0
		if balance < cost then
			if hasLimitedStock then
				refundLocalReserve(override.Slot)
			end
			NotificationService.Error(player, "Not enough " .. label .. "!")
			return false
		end
		channel:Set(path, balance - cost)
	end

	task.delay(2.5, function()
		if animalData then
			pcall(function()
				AnimalService.spawnAnimalCustom(
					animalData,
					nil,
					nil,
					nil,
					{
						Start = workspace:FindFirstChild("Santa Merchant").SpawnPart,
						End = workspace.Road.End,
						Owner = player
					},
					1.5,
					true
				)
			end)
		end
	end)

	NotificationService.Success(player, "Purchase successful!")
	AnimationRE:FireAllClients("1")
	return true
end

BuySantaRF.OnServerInvoke = function(player, merchantId, index)

	if type(index) ~= "number" or index % 1 ~= 0 then
		return false
	end

	local channel = Synchronizer:Get(player)
	if not channel then
		return false
	end

	local override = activeOverrides[tostring(index)]
	if override then
		return purchaseOverrideSlot(player, override)
	end

	if not SANTA_EVENT_ENABLED then
		return false
	end

	local entry = SantaData.Brainrots[index]
	if not entry then
		return false
	end

	local price = entry.Price
	local elves = channel:Get("ChristmasEvent.GoldElves") or 0

	if elves < price then
		NotificationService.Error(player, "Not enough Gold Elves!")
		return false
	end

	local attrName = stockAttribute(entry.Brainrot)
	local currentStock = ReplicatedStorage:GetAttribute(attrName) or 0

	if currentStock <= 0 then
		if SANTA_EVENT_ENABLED then
			NotificationService.Error(player, "You can't buy this product!")
		end
		return false
	end

	ReplicatedStorage:SetAttribute(attrName, currentStock - 1)

	channel:Increase("ChristmasEvent.GoldElves", -price)

	local animalData = Animals[entry.Brainrot]

	NotificationService.Success(player, "Purchase successful!")
	AnimationRE:FireAllClients("1")
	task.delay(2.5, function()
		if animalData then
			pcall(function()
				AnimalService.spawnAnimalCustom(
					animalData,
					nil,
					nil,
					nil,
					{
						Start = workspace:FindFirstChild("Santa Merchant").SpawnPart,
						End = workspace.Road.End,
						Owner = player
					},
					1.5,
					true
				)
			end)
		end
	end)
	return true
end


function SantaMerchantService:ReplaceSlot(animalName, cost, slot, currency, stockCount)

	if type(animalName) ~= "string" or animalName == "" then
		warn("[SantaMerchantService] ReplaceSlot: animalName must be a non-empty string.")
		return false, "animalName must be a non-empty string."
	end

	cost = tonumber(cost)
	if not cost or cost < 0 then
		warn("[SantaMerchantService] ReplaceSlot: cost must be a non-negative number.")
		return false, "cost must be a non-negative number."
	end

	slot = tonumber(slot)
	if not slot or slot < 1 or slot % 1 ~= 0 then
		warn("[SantaMerchantService] ReplaceSlot: slot must be a positive integer.")
		return false, "slot must be a positive integer."
	end

	local normalized = normalizeCurrency(currency)
	if not normalized then
		warn("[SantaMerchantService] ReplaceSlot: invalid currency '" .. tostring(currency) .. "' (expected 'elf' or 'brotinho').")
		return false, "currency must be 'elf' or 'brotinho'."
	end

	if stockCount ~= nil then
		stockCount = tonumber(stockCount)
		if not stockCount or stockCount < 0 or stockCount % 1 ~= 0 then
			warn("[SantaMerchantService] ReplaceSlot: stockCount must be a non-negative integer (or nil for unlimited).")
			return false, "stockCount must be a non-negative integer."
		end
	end

	local record = {
		Animal = animalName,
		Cost = cost,
		Currency = normalized,
		Slot = slot,
		Stock = stockCount,
	}

	memoryWriteOverride(slot, record)

	applyOverrideLocally(slot, animalName, cost, normalized, stockCount)

	MessagingService:PublishAsync(OVERRIDE_MSG_TOPIC, {
		action = "replace",
		slot = slot,
		animalName = animalName,
		cost = cost,
		currency = normalized,
		stockCount = stockCount,
		sourceJobId = game.JobId,
	})

	return true
end

function SantaMerchantService:ClearSlotOverrides()

	memoryClearOverrides()
	clearOverridesLocally()

	MessagingService:PublishAsync(OVERRIDE_MSG_TOPIC, {
		action = "clear",
		sourceJobId = game.JobId,
	})

	return true
end


function SantaMerchantService:AddCurrency(player, currency, amount)
	if typeof(player) ~= "Instance" or not player:IsA("Player") then
		return false, "invalid player"
	end

	local normalized = normalizeCurrency(currency)
	if not normalized then
		warn("[SantaMerchantService] AddCurrency: invalid currency '" .. tostring(currency) .. "'.")
		return false, "invalid currency"
	end

	amount = tonumber(amount)
	if not amount or amount == 0 then
		return false, "invalid amount"
	end

	local channel = Synchronizer:Get(player)
	if not channel then
		return false, "no player channel"
	end

	local path = CURRENCY_PATHS[normalized]
	local maxValue = CURRENCY_MAX[normalized]

	local current = channel:Get(path) or 0
	local newAmount = current + amount
	if maxValue then
		newAmount = math.clamp(newAmount, 0, maxValue)
	end

	channel:Set(path, newAmount)
	return true, newAmount
end

function SantaMerchantService:Start()

	createStockAttributes()


	task.spawn(function()
		MessagingService:SubscribeAsync(OVERRIDE_MSG_TOPIC, function(data)
			if type(data) ~= "table" then
				return
			end
			if data.sourceJobId == game.JobId then
				return
			end

			if data.action == "replace" then
				local normalized = normalizeCurrency(data.currency) or DEFAULT_CURRENCY
				applyOverrideLocally(data.slot, data.animalName, data.cost, normalized, data.stockCount)
			elseif data.action == "clear" then
				clearOverridesLocally()
			end
			
		end)
	end)

	task.spawn(function()
		local stored = memoryReadOverrides()
		if stored then
			for slotKey, record in pairs(stored) do
				if type(record) == "table" then
					activeOverrides[slotKey] = record
				end
			end
			publishOverridesToClients()
		end
	end)

	game:BindToClose(function()
		returnAllReserves()
	end)

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