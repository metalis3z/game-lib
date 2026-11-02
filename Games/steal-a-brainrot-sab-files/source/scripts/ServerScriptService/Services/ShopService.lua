local ShopService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local MarketplaceService = game:GetService("MarketplaceService")
local MessagingService = require(game:GetService("ServerScriptService").Services.MessagingService)
local MemoryStoreService = game:GetService("MemoryStoreService")
local DataStoreService = game:GetService("DataStoreService")

local EventService = require(ServerScriptService.Services.EventService)
local SnapService = require(ServerScriptService.Services.SnapService)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local PlotService = require(ServerScriptService.Services.PlotService)
local MoneyService = require(ServerScriptService.Services.MoneyService)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local animals = require(ReplicatedStorage.Datas.Animals)
local LuckService = require(ServerScriptService.Services.LuckService)
local raritiesData = require(ReplicatedStorage.Datas.Rarities)
local Net = require(ReplicatedStorage.Packages.Net)
local Shop = require(ReplicatedStorage.Datas.Shop)
local RobuxShop = require(ReplicatedStorage.Datas.RobuxShopData)
local ServerLuckData = require(ReplicatedStorage.Datas.ServerLuck)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local SharedGame = require(ReplicatedStorage.Shared.Game)
local ModdedUpdates = require(ReplicatedStorage.Shared.ModdedUpdates)
local UnlockBase = require(ReplicatedStorage.Datas.UnlockBase)
local Timer = require(ReplicatedStorage.Packages.Timer)
local runservice = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Policy = require(ReplicatedStorage.Shared.Policy)
local IsAdmin = require(ReplicatedStorage.Shared.IsAdmin)

local WEBHOOK_URL = "https://discord.com/api/webhooks/REDACTED"

local function sendPurchaseWebhook(player: Player, productId: number, productName: string, purchaseType: string)
	local success, err = pcall(function()
		local data = {
			embeds = {
				{
					title = "💸 Real Robux Purchase",
					color = 0x00FF00,
					fields = {
						{ name = "Player", value = player.DisplayName .. " (`" .. player.Name .. "`)", inline = true },
						{ name = "User ID", value = tostring(player.UserId), inline = true },
						{ name = "Product ID", value = tostring(productId), inline = true },
						{ name = "Product Name", value = tostring(productName), inline = true },
						{ name = "Purchase Type", value = tostring(purchaseType), inline = true },
						{ name = "Server Job ID", value = tostring(game.JobId), inline = false },
					},
					timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
					footer = { text = "ShopService Logger" }
				}
			}
		}

		HttpService:PostAsync(WEBHOOK_URL, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
	end)

	if not success then
		warn("[ShopService] Webhook failed: " .. tostring(err))
	end
end
local LUCK_PRODUCT_TO_INDEX: {[number]: number} = {}
for _, tierData in ipairs(ServerLuckData) do
	if tierData.ProductId and tierData.Tier then
		LUCK_PRODUCT_TO_INDEX[tierData.ProductId] = tierData.Tier
	end
end
local PurchaseRemote = Net:RemoteEvent("ShopService/Purchase")
local PurchaseRemote2 = Net:RemoteEvent("ModdedShopService/Purchase")
local ShopOpenedRemote = Net:RemoteEvent("ShopService/ShopOpened")
local FlashSaleUpdateRemote = Net:RemoteEvent("ShopService/FlashSaleUpdate")
local GetLimitedItemsRemote = Net:RemoteFunction("ShopService/GetLimitedItems")
local SetGiftTargetRemote = Net:RemoteEvent("ShopService/SetGiftTarget")

local BuyUnstealablePets = Net:RemoteFunction("RobuxShopService/BuyUnstealablePets")
local PendingUnlocks = {} :: {[number]: {player: Player, targetUserId: number, productId: number, floor: number}}
local PendingModded = {} :: {[number]: {player: Player, brainrot: string, purchaseType: string}}
local PendingGiftTargets = {} :: {[number]: {productId: number, targetUserId: number}}
local LuckyBlocksAmount = {
	[3478819642] = 1,
	[3478819641] = 3,
	[3478819648] = 10,
	[3555794271] = 1,
	[3555794270] = 3
}
local GLOBAL_BRAINROT_ID = RobuxShop.GetId("GlobalBrainrot")
local GLOBAL_EVENT_PRODUCT_ID = RobuxShop.GetId("GlobalEvent")
local GLOBAL_SNAP_PRODUCT_ID = RobuxShop.GetId("GlobalSnap")
local GLOBAL_MESSAGES_PRODUCT_ID = RobuxShop.GetId("GlobalMessage")

local GLOBAL_EVENT_TOPIC = "GlobalEventChannel"
local ANIMAL_PRODUCTS = {}
local EVENT_PRODUCTS = {}
local GAMEPASS_PRODUCTS = {}
for productId, entry in pairs(RobuxShop.Products) do
	if entry.Type == "Animal" then
		ANIMAL_PRODUCTS[productId] = entry.Animal or entry.Display
	elseif entry.Type == "Event" then
		local eventName = entry.Event or entry.Display
		if eventName then
			EVENT_PRODUCTS[eventName] = {
				Server = entry.Scope == "Server" and productId or entry.Server,
				Global = entry.Global,
			}
		end
	elseif entry.Type == "Gamepass" then
		for _, gpId in ipairs(entry.Ids) do
			GAMEPASS_PRODUCTS[gpId] = entry
		end
	end
end
local SERVER_EVENT_PRODUCTS = {}
local GLOBAL_EVENT_PRODUCTS = {}

for eventName, ids in pairs(EVENT_PRODUCTS) do
	SERVER_EVENT_PRODUCTS[ids.Server] = eventName
	GLOBAL_EVENT_PRODUCTS[ids.Global] = eventName
end

local LOCATION_SETTINGS = {
	["Concert"]      = { duration = 130, delay = 18 },
	["Brazil"]       = { duration = 115, delay = 6 }, 
	["Rap Concert"]  = { duration = 90, delay = 10 },
	["Mexico"]       = { duration = 195, delay = 0 },
	["Indonesia"]    = { duration = 180, delay = 0 },
	["Winter Hour"]  = { duration = 153, delay = 0 },
	["Lance"]        = { duration = 451, delay = 5 },
	["Ay Mi Gatito"] = { duration = 218, delay = 7 },
	["Rip My Granny"] = { duration = 240, delay = 7 },
	["1 Year"] = { duration = 241, delay = 0  },
	["Laser City"] = { duration = 180, delay = 0  },
	["Raining Burgers"] = { duration = 180, delay = 0  },
}


local MEMORY_MAP_NAME     = "GlobalActiveEvents"
local MEMORY_TTL_BUFFER   = 30

local function isAuthorized(userId)
	local uid = tonumber(userId)
	if not uid then return false end
	return IsAdmin(uid)
end


local MemoryMap = MemoryStoreService:GetSortedMap(MEMORY_MAP_NAME)

local function memorySet(data)
	local ttl = math.max(1, math.ceil(data.endsAt - workspace:GetServerTimeNow()) + MEMORY_TTL_BUFFER)
	local ok, err = pcall(function()
		MemoryMap:SetAsync(data.eventName, data, ttl, data.endsAt)
	end)
	if not ok then
		warn("[GlobalEvents] MemoryStore SetAsync failed:", err)
	end
end

local function memoryRemove(eventName)
	local ok, err = pcall(function()
		MemoryMap:RemoveAsync(eventName)
	end)
	if not ok then
		warn("[GlobalEvents] MemoryStore RemoveAsync failed:", err)
	end
end

local function memoryGetAll()
	local results = {}
	local ok, items = pcall(function()
		return MemoryMap:GetRangeAsync(Enum.SortDirection.Ascending, 200)
	end)
	if not ok then
		warn("[GlobalEvents] MemoryStore GetRangeAsync failed:", items)
		return results
	end
	local now = workspace:GetServerTimeNow()
	for _, item in ipairs(items) do
		local v = item.value
		if v and v.endsAt and v.endsAt > now then
			table.insert(results, v)
		end
	end
	return results
end

_G.PendingGlobalSpawns = {}
local function getAnimalData(animalName)
	if not animalName then return nil end

	local direct = animals[animalName]
	if direct and type(direct) == "table" then
		return direct
	end

	for _, v in pairs(animals) do
		if type(v) == "table" and (v.DisplayName == animalName or v.Name == animalName) then
			return v
		end
	end

	return nil
end

local function getGradientTag(animalName)
	local animal = getAnimalData(animalName)

	if animal and animal.Rarity then
		local rarityInfo = raritiesData[animal.Rarity]
		if rarityInfo and rarityInfo.GradientPreset then
			return string.lower(rarityInfo.GradientPreset)
		end
	end

	return nil
end

local playersWithKohlsRole = {}

local function getKohlsInterface()
	local _K = shared._K_INTERFACE
	local waited = 0
	while (not _K or not _K.ready) and waited < 15 do
		task.wait(0.5)
		waited += 0.5
		_K = shared._K_INTERFACE
	end
	if _K and _K.ready then
		return _K
	end
	return nil
end

local function grantGamepassRole(player: Player, gamepassId: number, entry, verifyOwnership: boolean?)
	if not entry or (not entry.KohlsRole and not entry.Attribute) then return end

	if entry.PrivateOnly and game.PrivateServerId == "" then
		return
	end

	local grantKey = entry.KohlsRole or entry.Attribute
	local owned = playersWithKohlsRole[player.UserId]
	if owned and owned[grantKey] then
		return
	end

	if verifyOwnership then
		local ok, owns = pcall(function()
			return MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamepassId)
		end)
		if not ok or not owns then
			return
		end
	end

	if entry.Attribute then
		player:SetAttribute(entry.Attribute, true)
		owned = owned or {}
		owned[grantKey] = true
		playersWithKohlsRole[player.UserId] = owned

		if entry.GrantMessage and not verifyOwnership then
			NotificationService.Success(player, entry.GrantMessage)
		end
	end

	if entry.KohlsRole then
		local _K = getKohlsInterface()
		if not _K or not _K.Auth or not _K.Auth.userRoleAdd then
			warn("[ShopService] Kohl's _K.Auth.userRoleAdd unavailable; cannot grant role '" .. tostring(entry.KohlsRole) .. "'")
			return
		end

		local roleAdded = _K.Auth.userRoleAdd(player.UserId, entry.KohlsRole)
		if roleAdded then
			owned = owned or {}
			owned[grantKey] = true
			playersWithKohlsRole[player.UserId] = owned

			if _K.Remote and _K.Remote.Notify then
				_K.Remote.Notify:Fire(player, {
					Text = string.format("<b>%s Enabled!</b>", entry.Display or "VIP"),
					From = "_K",
				})
			end
		end
	end
end

Players.PlayerRemoving:Connect(function(player)
	playersWithKohlsRole[player.UserId] = nil
	PendingGiftTargets[player.UserId] = nil
end)
local MAX_RETRIES = 5
local RETRY_DELAY = 8
local DS_BUDGET_MIN = 5

local function waitForBudget(requestType, timeout)
	local deadline = workspace:GetServerTimeNow() + timeout
	while DataStoreService:GetRequestBudgetForRequestType(requestType) < DS_BUDGET_MIN do
		if workspace:GetServerTimeNow() >= deadline then
			return false
		end
		task.wait(1)
	end
	return true
end

local function retryAsync(func, maxRetries, delayBetween, errorContext)
	maxRetries = maxRetries or MAX_RETRIES
	delayBetween = delayBetween or RETRY_DELAY
	errorContext = errorContext or "Unknown operation"

	for attempt = 1, maxRetries do
		if not waitForBudget(Enum.DataStoreRequestType.SetIncrementAsync, 10) then
			warn(string.format(
				"[ShopService] %s skipped (attempt %d/%d): no budget available",
				errorContext, attempt, maxRetries
				))
			if attempt < maxRetries then
				task.wait(delayBetween * attempt * 2)
			end
			continue
		end

		local success, result = pcall(func)
		if success then
			return true, result
		end

		warn(string.format(
			"[ShopService] %s failed (attempt %d/%d): %s",
			errorContext, attempt, maxRetries, tostring(result)
			))

		if attempt < maxRetries then
			task.wait(delayBetween * (2 ^ (attempt - 1)))
		end
	end

	warn(string.format("[ShopService] %s failed after %d attempts", errorContext, maxRetries))
	return false, nil
end

local STATIC_STOCK_CONFIG = {
	[3606430361] = {
		displayName = "Smurf Cat",
		animalName  = "Smurf Cat",
		maxStock    = 5000,
	},
}
local STOCK_MAP_NAME          = "GlobalStock_v1"
local FLASH_MAP_NAME          = "GlobalFlashSales_v1"
local STOCK_DS_NAME           = "GlobalStockDS_v1"
local FLASH_DS_NAME           = "GlobalFlashSalesDS_v1"	
local STOCK_TTL               = 86400 * 7
local STOCK_PERSIST_INTERVAL  = 180
local FLASH_SALE_MSG_TOPIC    = "GlobalFlashSaleCreate"
local STOCK_UPDATE_MSG_TOPIC = "GlobalStockUpdate"
local STOCK_BROADCAST_INTERVAL = 30
local StockMap   = MemoryStoreService:GetSortedMap(STOCK_MAP_NAME)
local FlashMap   = MemoryStoreService:GetSortedMap(FLASH_MAP_NAME)
local StockDS    = DataStoreService:GetDataStore(STOCK_DS_NAME)
local FlashDS    = DataStoreService:GetDataStore(FLASH_DS_NAME)

local WRITER_LEASE_MAP_NAME = "GlobalStockWriters_v1"
local WRITER_LEASE_TTL      = 240
local WriterLeaseMap        = MemoryStoreService:GetSortedMap(WRITER_LEASE_MAP_NAME)
local writerLeases          = {}

local function writerLeaseKey(productId)
	return "wl_" .. tostring(productId)
end

local function tryAcquireWriterLease(productId)
	local now = workspace:GetServerTimeNow()

	local cachedExpiry = writerLeases[productId]
	if cachedExpiry and cachedExpiry > now + 30 then
		return true
	end

	local won = false
	local ok, err = pcall(function()
		WriterLeaseMap:UpdateAsync(writerLeaseKey(productId), function(current)
			local serverNow = workspace:GetServerTimeNow()
			if not current
				or type(current) ~= "table"
				or (current.expires or 0) <= serverNow
				or current.jobId == game.JobId
			then
				won = true
				return { jobId = game.JobId, expires = serverNow + WRITER_LEASE_TTL }
			end
			return nil
		end, WRITER_LEASE_TTL + 60)
	end)

	if not ok then
		warn("[GlobalStock] tryAcquireWriterLease MemoryStore call failed for product "
			.. tostring(productId) .. ": " .. tostring(err))
		writerLeases[productId] = nil
		return false
	end

	if won then
		writerLeases[productId] = now + WRITER_LEASE_TTL
		return true
	end

	writerLeases[productId] = nil
	return false
end

local function releaseWriterLease(productId)
	if not writerLeases[productId] then return end
	writerLeases[productId] = nil
	pcall(function()
		WriterLeaseMap:UpdateAsync(writerLeaseKey(productId), function(current)
			if type(current) == "table" and current.jobId == game.JobId then
				return { jobId = game.JobId, expires = 0 }
			end
			return nil
		end, 60)
	end)
end

local activeFlashSales = {}
local flashSaleTimers  = {}

local limitedProductIds = {}

local broadcastFlashSaleUpdate

local lastDisplayedStock = {}

for productId in pairs(STATIC_STOCK_CONFIG) do
	limitedProductIds[productId] = true
end

local activatedStaticStock = {}

local staticOfferEnded = {}

local broadcastStockChange

local function isStaticOfferEnded(productId)
	if staticOfferEnded[productId] then return true end
	local config = STATIC_STOCK_CONFIG[productId]
	if config and config.endUpdate and ModdedUpdates.Methods.IsEnabled(config.endUpdate) then
		return true
	end
	return false
end

local function isStaticOfferReleased(productId)
	local config = STATIC_STOCK_CONFIG[productId]
	if not config then return true end
	if not config.releaseUpdate then return true end
	return activatedStaticStock[productId] == true
end

local function stockKey(productId)
	return "s_" .. tostring(productId)
end

local function flashKey(productId)
	return "f_" .. tostring(productId)
end


local function getStockFromMemory(productId)
	local ok, result = pcall(function()
		return StockMap:GetAsync(stockKey(productId))
	end)
	if ok then return result end
	warn("[GlobalStock] StockMap:GetAsync failed for product " .. tostring(productId) .. ": " .. tostring(result))
	return nil
end

local function getStockFromDS(productId)
	local ok, result = pcall(function()
		return StockDS:GetAsync(stockKey(productId))
	end)
	if ok then return result end
	warn("[GlobalStock] StockDS:GetAsync failed for product " .. tostring(productId) .. ": " .. tostring(result))
	return nil
end

local function setStockInMemory(productId, value)
	local ok, err = pcall(function()
		StockMap:SetAsync(stockKey(productId), value, STOCK_TTL)
	end)
	if not ok then
		warn("[GlobalStock] StockMap:SetAsync failed for product " .. tostring(productId) .. ": " .. tostring(err))
	end
	return ok
end

local lastPersistedStock = {}

local PER_KEY_WRITE_COOLDOWN = 30
local PER_KEY_WRITE_JITTER   = 15
local STOCK_WRITE_THRESHOLD  = 3
local lastWriteTime   = {}
local pendingWrite    = {}
local writeScheduled  = {}

local function persistStockToDS(productId, value)
	if lastPersistedStock[productId] == value then
		return
	end

	local lastVal = lastPersistedStock[productId]
	if lastVal and value ~= 0 and math.abs(lastVal - value) < STOCK_WRITE_THRESHOLD then
		return
	end

	pendingWrite[productId] = value

	if writeScheduled[productId] then
		return
	end
	writeScheduled[productId] = true

	task.spawn(function()
		local lastWrite = lastWriteTime[productId] or 0
		local elapsed   = os.clock() - lastWrite
		local jitter    = math.random() * PER_KEY_WRITE_JITTER
		local waitTime  = math.max(0, PER_KEY_WRITE_COOLDOWN - elapsed) + jitter
		if waitTime > 0 then
			task.wait(waitTime)
		end

		local valueToWrite = pendingWrite[productId]
		pendingWrite[productId]   = nil
		writeScheduled[productId] = false

		if valueToWrite == nil or lastPersistedStock[productId] == valueToWrite then
			return
		end

		if DataStoreService:GetRequestBudgetForRequestType(Enum.DataStoreRequestType.SetIncrementAsync) < DS_BUDGET_MIN then
			return
		end

		if not tryAcquireWriterLease(productId) then
			return
		end

		local ok, err = pcall(function()
			StockDS:SetAsync(stockKey(productId), valueToWrite)
		end)

		lastWriteTime[productId] = os.clock()

		if ok then
			lastPersistedStock[productId] = valueToWrite
		else
			local errStr = tostring(err)
			local isThrottle = errStr:find("KeyThrottled")
				or errStr:find("request rate")
				or errStr:find("queue")
			if not isThrottle then
				warn(string.format(
					"[GlobalStock] persistStockToDS product=%d failed: %s",
					productId, errStr
					))
			end
		end
	end)
end
local function atomicDecrement(productId)
	local saleKey = tostring(productId)
	local now     = workspace:GetServerTimeNow()

	local sale = activeFlashSales[saleKey]
	if sale and now >= sale.expiration then
		return false
	end

	local decremented = false
	local newStock    = nil

	local ok, err = pcall(function()
		newStock = StockMap:UpdateAsync(stockKey(productId), function(current)
			if type(current) ~= "number" or current <= 0 then
				return nil
			end
			decremented = true
			return current - 1
		end, STOCK_TTL)
	end)

	if not ok then
		warn("[GlobalStock] atomicDecrement UpdateAsync failed for product "
			.. tostring(productId) .. ": " .. tostring(err))
		return false
	end

	if not decremented and newStock == nil then
		local dsValue = getStockFromDS(productId)
		if dsValue and dsValue > 0 then
			setStockInMemory(productId, dsValue)
			local retryOk, retryErr = pcall(function()
				newStock = StockMap:UpdateAsync(stockKey(productId), function(current)
					if type(current) ~= "number" or current <= 0 then return nil end
					decremented = true
					return current - 1
				end, STOCK_TTL)
			end)
			if not retryOk then
				warn("[GlobalStock] atomicDecrement retry UpdateAsync failed: " .. tostring(retryErr))
				return false
			end
		else
			return false
		end
	end

	if decremented and newStock ~= nil then
		task.spawn(persistStockToDS, productId, newStock)
	end

	return decremented
end

local function initializeStaticStock(productId, maxStock)
	local memValue = getStockFromMemory(productId)
	if memValue ~= nil then
		limitedProductIds[productId] = true
		return
	end

	local dsValue = getStockFromDS(productId)
	if dsValue ~= nil then
		setStockInMemory(productId, dsValue)
		limitedProductIds[productId] = true
		return
	end

	setStockInMemory(productId, maxStock)
	persistStockToDS(productId, maxStock)
	limitedProductIds[productId] = true
end


local function registerFlashSaleLocally(productId, amount, expiration, displayName, animalName)
	local saleKey  = tostring(productId)
	local now      = workspace:GetServerTimeNow()
	local remaining = expiration - now

	if remaining <= 0 then
		return
	end

	activeFlashSales[saleKey] = {
		productId   = productId,
		amount      = amount,
		expiration  = expiration,
		displayName = displayName or ("Flash Sale #" .. tostring(productId)),
		animalName  = animalName,
	}
	limitedProductIds[productId] = true

	if broadcastFlashSaleUpdate then
		broadcastFlashSaleUpdate("add", productId, {
			productId   = productId,
			displayName = displayName or ("Flash Sale #" .. tostring(productId)),
			animalName  = animalName,
			stock       = amount,
			expiration  = expiration,
			isFlash     = true,
		})
	end

	if flashSaleTimers[saleKey] then
		flashSaleTimers[saleKey]:Destroy()
		flashSaleTimers[saleKey] = nil
	end

	local t = Timer.new(remaining)
	t.AllowDrift = true
	t.Tick:Connect(function()
		activeFlashSales[saleKey]  = nil
		limitedProductIds[productId] = nil
		t:Destroy()
		flashSaleTimers[saleKey] = nil

		if broadcastFlashSaleUpdate then
			broadcastFlashSaleUpdate("remove", productId, nil)
		end
	end)
	t:Start()
	flashSaleTimers[saleKey] = t
end


local function setFlashSaleInMemory(productId, amount, expiration, displayName, animalName)
	local ttl = math.max(1, math.ceil(expiration - workspace:GetServerTimeNow()) + MEMORY_TTL_BUFFER)
	local ok, err = pcall(function()
		FlashMap:SetAsync(flashKey(productId), {
			productId   = productId,
			amount      = amount,
			expiration  = expiration,
			displayName = displayName,
			animalName  = animalName,
		}, ttl)
	end)
	if not ok then
		warn("[GlobalStock] FlashMap:SetAsync failed for product " .. tostring(productId) .. ": " .. tostring(err))
	end
end

local function persistFlashSaleToDS(productId, amount, expiration, displayName, animalName)
	retryAsync(function()
		FlashDS:SetAsync(flashKey(productId), {
			productId   = productId,
			amount      = amount,
			expiration  = expiration,
			displayName = displayName,
			animalName  = animalName,
		})
	end, MAX_RETRIES, RETRY_DELAY, "persistFlashSaleToDS product=" .. tostring(productId))
end


local function syncFlashSalesOnBoot()
	local ok, items = pcall(function()
		return FlashMap:GetRangeAsync(Enum.SortDirection.Ascending, 200)
	end)

	if ok and items then
		local now = workspace:GetServerTimeNow()
		for _, item in ipairs(items) do
			local v = item.value
			if v and v.productId and v.expiration and v.expiration > now then
				local memStock = getStockFromMemory(v.productId)
				if memStock == nil then
					local dsStock = getStockFromDS(v.productId)
					if dsStock ~= nil and dsStock > 0 then
						setStockInMemory(v.productId, dsStock)
					end
				end
				registerFlashSaleLocally(v.productId, v.amount, v.expiration, v.displayName, v.animalName)
			end
		end
	else
		warn("[GlobalStock] Boot-sync: FlashMap:GetRangeAsync failed — " .. tostring(items))
	end
end


function ShopService:ListFlashSales(): {{productId: number, displayName: string?, animalName: string?, stock: number?, expiration: number}}
	local result = {}
	for _, sale in pairs(activeFlashSales) do
		local stock = getStockFromMemory(sale.productId)
		if stock == nil then
			stock = getStockFromDS(sale.productId)
		end
		table.insert(result, {
			productId   = sale.productId,
			displayName = sale.displayName,
			animalName  = sale.animalName,
			stock       = stock or 0,
			expiration  = sale.expiration,
		})
	end
	return result
end

function ShopService:StopFlashSale(productId: number)
	local saleKey = tostring(productId)
	local sale = activeFlashSales[saleKey]
	if not sale then
		warn("[GlobalStock] StopFlashSale: no active flash sale for product " .. tostring(productId))
		return false, "No active flash sale found for product " .. tostring(productId)
	end

	activeFlashSales[saleKey] = nil
	limitedProductIds[productId] = nil

	if flashSaleTimers[saleKey] then
		flashSaleTimers[saleKey]:Destroy()
		flashSaleTimers[saleKey] = nil
	end

	local ok1, err1 = pcall(function()
		FlashMap:RemoveAsync(flashKey(productId))
	end)
	if not ok1 then
		warn("[GlobalStock] StopFlashSale FlashMap:RemoveAsync failed: " .. tostring(err1))
	end

	local ok2, err2 = pcall(function()
		FlashDS:SetAsync(flashKey(productId), nil)
	end)
	if not ok2 then
		warn("[GlobalStock] StopFlashSale FlashDS:SetAsync failed: " .. tostring(err2))
	end

	if broadcastFlashSaleUpdate then
		broadcastFlashSaleUpdate("remove", productId, nil)
	end

	local payload = {
		productId   = productId,
		action      = "stop",
		sourceJobId = game.JobId,
	}
	local broadcastOk, broadcastErr = pcall(function()
		MessagingService:PublishAsync(FLASH_SALE_MSG_TOPIC, payload)
	end)
	if not broadcastOk then
		warn("[GlobalStock] StopFlashSale broadcast failed: " .. tostring(broadcastErr))
	end
	return true
end

function ShopService:CreateFlashSale(productId: number, amount: number, duration: number, displayName: string?, animalName: string?)
	assert(type(productId) == "number",               "[GlobalStock] productId must be a number")
	assert(type(amount) == "number" and amount > 0,   "[GlobalStock] amount must be a positive number")
	assert(type(duration) == "number" and duration > 0,"[GlobalStock] duration must be a positive number")

	local expiration = workspace:GetServerTimeNow() + duration
	displayName      = displayName or ("Flash Sale #" .. tostring(productId))

	setStockInMemory(productId, amount)
	persistStockToDS(productId, amount)

	registerFlashSaleLocally(productId, amount, expiration, displayName, animalName)

	setFlashSaleInMemory(productId, amount, expiration, displayName, animalName)
	task.spawn(persistFlashSaleToDS, productId, amount, expiration, displayName, animalName)

	local payload = {
		productId   = productId,
		amount      = amount,
		expiration  = expiration,
		displayName = displayName,
		animalName  = animalName,
		sourceJobId = game.JobId,
	}
	local broadcastOk, broadcastErr = pcall(function()
		MessagingService:PublishAsync(FLASH_SALE_MSG_TOPIC, payload)
	end)
	if not broadcastOk then
		warn("[GlobalStock] CreateFlashSale broadcast failed: " .. tostring(broadcastErr))
	end
end

function ShopService:IsProductAvailable(productId: number): boolean
	if not limitedProductIds[productId] then
		return true
	end

	local now     = workspace:GetServerTimeNow()
	local saleKey = tostring(productId)
	local sale    = activeFlashSales[saleKey]

	if sale and now >= sale.expiration then
		return false
	end

	local stock = getStockFromMemory(productId)
	if stock == nil then
		stock = getStockFromDS(productId)
		if stock ~= nil then
			setStockInMemory(productId, stock)
		end
	end

	return stock ~= nil and stock > 0
end


Net:RemoteFunction("GlobalSpawnBrainrot").OnServerInvoke = function(player, animalName, mutation, traits, speed, sammyspawn, rarity, generation, cost, isfake, isfakeinbase, spawnmode, displayname, size)
	_G.PendingGlobalSpawns[player.UserId] = {
		animalName = animalName,
		mutation = mutation,
		traits = traits,
		speed = speed,
		sammyspawn = sammyspawn or false,
		rarity = rarity or "",
		generation = generation,
		cost = cost,
		isfake = isfake or false,
		isfakeinbase = isfakeinbase or false,
		spawnmode = spawnmode,
		displayname = displayname,
		size = size,
	}

	if IsAdmin(player.UserId) then
		task.spawn(function()
			ShopService:ProcessPurchase(player, GLOBAL_BRAINROT_ID)
		end)
		return false 
	end

	return true 
end

_G.PendingGlobalEvents = _G.PendingGlobalEvents or {}


local function handleSnapExecution(data)
	task.spawn(function()
		local locationSettings = LOCATION_SETTINGS[data.eventName]
		local duration = (locationSettings and locationSettings.duration)
			or data.duration
			or EventService.EventDurations[data.eventName]
			or 120
		local delay = (locationSettings and locationSettings.delay) or data.delay or 0

		local snapType = data.snapType or (data.iscoffin == true and "Coffin" or "Normal")

		SnapService.Execute({
			snapType = snapType,
			location = data.eventName,
			duration = duration,
			delay = delay,
			targetUsername = data.targetUsername or data.targetPlayer,
			extraEvents = data.extraEvents,
			waitForBusy = true,
		})
	end)
end

local function executeGlobalAction(data)
	local isPrivate = (game.PrivateServerId ~= "")
	if isPrivate and not isAuthorized(data.senderId) then return end

	if not isAuthorized(data.senderId) then
		local category = data.isSnap and "SNAP" or "EVENT"
		for _, p in pairs(Players:GetPlayers()) do
			NotificationService.Notify(
				p,
				string.format("GLOBAL %s BY %s: %s", category, data.senderName, data.eventName),
				5
			)
		end
	end

	if data.isSnap then
		handleSnapExecution(data)
	else
		local now       = workspace:GetServerTimeNow()
		local startedAt = data.startedAt or now
		local elapsed   = math.max(0, now - startedAt)

		local syncedDelay = (data.delay or 0) + elapsed
		local duration    = data.duration or EventService.EventDurations[data.eventName] or 150

		if syncedDelay >= duration then return end

		EventService:ExecuteEvent(data.eventName, duration, syncedDelay, data.arguments)
	end
end

local function broadcastAndPersist(payload)
	local now      = workspace:GetServerTimeNow()
	local duration = payload.duration or EventService.EventDurations[payload.eventName] or 150
	local delay    = payload.delay or 0

	payload.startedAt = now
	payload.endsAt    = now + (duration - delay)
	payload.duration  = duration
	payload.delay     = delay

	if isAuthorized(payload.senderId) and not payload.isSnap then
		memorySet(payload)

		local remaining = payload.endsAt - now
		task.delay(remaining + MEMORY_TTL_BUFFER, function()
			memoryRemove(payload.eventName)
		end)
	end

	payload.action = "trigger"
	local ok, err = pcall(function()
		MessagingService:PublishAsync(GLOBAL_EVENT_TOPIC, payload)
	end)
	if not ok then
		warn("[GlobalEvents] MessagingService broadcast failed:", err)
	end

	return ok, err
end

local function executeGlobalStop(data)
	local isPrivate = (game.PrivateServerId ~= "")
	if isPrivate and not isAuthorized(data.senderId) then return end

	if not isAuthorized(data.senderId) then
		for _, p in pairs(Players:GetPlayers()) do
			NotificationService.Notify(
				p,
				string.format("GLOBAL EVENT STOPPED BY %s: %s", data.senderName, data.eventName),
				5
			)
		end
	end

	EventService:CancelEvent(data.eventName)
end

local function broadcastAndPersistStop(payload)
	memoryRemove(payload.eventName)

	payload.action = "stop"
	local ok, err = pcall(function()
		MessagingService:PublishAsync(GLOBAL_EVENT_TOPIC, payload)
	end)
	if not ok then
		warn("[GlobalEvents] Stop broadcast failed:", err)
	end

	return ok, err
end

local function replayPersistedEvents()
	local timeout  = 30
	local interval = 0.5
	local waited   = 0
	while not ReplicatedStorage:GetAttribute("EventsLoaded") and waited < timeout do
		task.wait(interval)
		waited += interval
	end

	if not ReplicatedStorage:GetAttribute("EventsLoaded") then
		warn("[GlobalEvents] EventsLoaded never set — skipping boot sync.")
		return
	end

	local now       = workspace:GetServerTimeNow()
	local persisted = memoryGetAll()

	if #persisted == 0 then
		return
	end

	for _, data in ipairs(persisted) do
		local remaining = data.endsAt - now

		if remaining <= 0 then
			memoryRemove(data.eventName)
			continue
		end

		local elapsed     = math.max(0, now - (data.startedAt or now))
		local syncedDelay = (data.delay or 0) + elapsed
		local duration    = data.duration or EventService.EventDurations[data.eventName] or 150

		if syncedDelay >= duration then
			memoryRemove(data.eventName)
			continue
		end


		EventService:ExecuteEvent(data.eventName, duration, syncedDelay, data.arguments)
	end
end

_G.InternalExecuteGlobalEvent       = executeGlobalAction
_G.InternalBroadcastGlobalEvent     = broadcastAndPersist
_G.InternalExecuteGlobalEventStop   = executeGlobalStop
_G.InternalBroadcastGlobalEventStop = broadcastAndPersistStop

local function broadcastGlobalEvent(player, pendingData)
	if not pendingData then return end

	local blacklist = require(game.ReplicatedStorage.GameData).adminevents
	local isAdminEvent = blacklist[pendingData.eventName] ~= nil
	local isAuthorizedUser = IsAdmin(player.UserId)

	if isAdminEvent and not isAuthorizedUser then
		return "You cannot run this event"
	end

	local payload = {
		senderName  = player.DisplayName,
		senderId    = player.UserId,
		eventName   = pendingData.eventName,
		duration    = pendingData.duration,
		delay       = pendingData.delay or 0,
		isSnap      = false,
		sourceJobId = game.JobId,
		arguments   = pendingData.arguments,
	}

	EventService:ExecuteEvent(
		payload.eventName,
		payload.duration or EventService.EventDurations[payload.eventName] or 150,
		payload.delay,
		payload.arguments
	)

	if _G.InternalBroadcastGlobalEvent then
		local ok, err = _G.InternalBroadcastGlobalEvent(payload)
		if not ok then
			NotificationService.Error(player, "Global broadcast failed: " .. tostring(err))
		end
	else
		warn("[ShopService] InternalBroadcastGlobalEvent not available, using direct publish.")
		local ok, err = pcall(function()
			MessagingService:PublishAsync(GLOBAL_EVENT_TOPIC, payload)
		end)
		if not ok then
			NotificationService.Error(player, "Global broadcast failed after retries!")
		end
	end
end

local function broadcastGlobalSnap(player, pendingData)
	if not pendingData then return end

	local blacklist = require(game.ReplicatedStorage.GameData).adminevents
	local isAdminEvent = blacklist[pendingData.eventName] ~= nil
	if isAdminEvent and not IsAdmin(player.UserId) then
		return "You cannot run this event"
	end

	local locationSettings = LOCATION_SETTINGS[pendingData.eventName]
	local duration = (locationSettings and locationSettings.duration) or pendingData.duration or EventService.EventDurations[pendingData.eventName] or 120
	local delay = (locationSettings and locationSettings.delay) or pendingData.delay or 0

	local payload = {
		senderName = player.DisplayName,
		senderId = player.UserId,
		eventName = pendingData.eventName,
		duration = duration,
		delay = delay,
		isSnap = true,
		iscoffin = pendingData.iscoffin or false,
		snapType = pendingData.snapType,
		targetPlayer = pendingData.targetPlayer,
		sourceJobId = game.JobId
	}

	handleSnapExecution(payload)

	local success = retryAsync(function()
		MessagingService:PublishAsync(GLOBAL_EVENT_TOPIC, payload)
	end, 3, 1, "GlobalSnap broadcast for " .. payload.eventName)

	if not success then
		warn("[broadcastGlobalSnap] Failed to publish after all retries")
		NotificationService.Error(player, "Global snap broadcast failed!")
	end
end
Net:RemoteFunction("GlobalEventRequest").OnServerInvoke = function(player, eventName, duration, delay, isSnap, selectedPlayer, iscoffin, snapType)

	local data = {
		eventName   = eventName,
		duration    = duration or 120,
		delay       = delay or 0,
		isSnap      = isSnap or false,
		targetPlayer = selectedPlayer,
		iscoffin    = iscoffin or false,
		snapType    = snapType,
		senderId    = player.UserId,
		senderName  = player.DisplayName,
		sourceJobId = game.JobId,
		arguments   = nil,
	}

	_G.PendingGlobalEvents[player.UserId] = data

	if IsAdmin(player.UserId) then
		if isSnap then
			handleSnapExecution(data)

			local success = retryAsync(function()
				MessagingService:PublishAsync(GLOBAL_EVENT_TOPIC, data)
			end, 3, 1, "Admin GlobalSnap broadcast")

			if not success then
				warn("[GlobalEventRequest] Snap broadcast failed after retries")
			end
		else
			if _G.InternalExecuteGlobalEvent then
				task.spawn(_G.InternalExecuteGlobalEvent, data)
			else
				task.spawn(function()
					EventService:ExecuteEvent(data.eventName, data.duration, data.delay, data.arguments)
				end)
			end

			local success = retryAsync(function()
				MessagingService:PublishAsync(GLOBAL_EVENT_TOPIC, data)
			end, 3, 1, "Admin GlobalEvent broadcast")

			if not success then
				warn("[GlobalEventRequest] Event broadcast failed after retries")
			end
		end

		_G.PendingGlobalEvents[player.UserId] = nil
		return false
	end

	return true
end


function ShopService:ProcessPurchase(player: Player, productId: number)
	-- Если это был подарок другому игроку — выдаём товар получателю, а не покупателю.
	-- Уведомления при этом всё равно ссылаются на player (покупателя), там где это имеет смысл.
	local recipient = player

	local giftData = PendingGiftTargets[player.UserId]
	if giftData and giftData.productId == productId then
		local targetPlayer = Players:GetPlayerByUserId(giftData.targetUserId)
		if targetPlayer then
			recipient = targetPlayer
			NotificationService.Notify(targetPlayer, player.DisplayName .. " gifted you an item!", 5, "Sounds.Sfx.Success")
		end
		PendingGiftTargets[player.UserId] = nil
	end

	local gamepassEntry = GAMEPASS_PRODUCTS[productId]
	if gamepassEntry then
		grantGamepassRole(recipient, productId, gamepassEntry, false)
		return
	end

	if productId == 3354160217 then
		local playerChannel = Synchronizer:Get(recipient)
		if playerChannel then
			playerChannel:Set("FuseMachine.FinishTime", workspace:GetServerTimeNow())
		end
		return
	end
	if productId == 3483927303 then
		EventService:ExecuteEvent("Fuse Machine Luck", 900)
	end
	if productId == GLOBAL_MESSAGES_PRODUCT_ID then 
		local pendingData = _G.PendingGlobalMessages[player.UserId]

		if pendingData then
			if _G.BroadcastGlobalAnnouncement then
				_G.BroadcastGlobalAnnouncement(player, pendingData.text, pendingData.gradient)
			end

			_G.PendingGlobalMessages[player.UserId] = nil
			return
		end
	end
	if productId == GLOBAL_BRAINROT_ID then
		local pendingSpawn = _G.PendingGlobalSpawns and _G.PendingGlobalSpawns[player.UserId]

		if pendingSpawn then
			local animalData = getAnimalData(pendingSpawn.animalName)
			if not animalData then
				warn(string.format(
					"[ShopService] GlobalBrainrotSpawn lookup failed for %q (no matching entry in animals data)",
					tostring(pendingSpawn.animalName)
					))
				NotificationService.Error(player, "Failed to spawn global animal: data missing! Please contact support.")
				_G.PendingGlobalSpawns[player.UserId] = nil
				return
			end

			local payload = {
				senderDisplayName = player.DisplayName,
				senderUserId = player.UserId,
				animalName = pendingSpawn.animalName,
				mutation = pendingSpawn.mutation,
				traits = pendingSpawn.traits,
				speed = pendingSpawn.speed,
				rarity = pendingSpawn.rarity or "",
				generation = pendingSpawn.generation,
				cost = pendingSpawn.cost,
				isfake = pendingSpawn.isfake or false,
				isfakeinbase = pendingSpawn.isfakeinbase or false,
				spawnmode = pendingSpawn.spawnmode,
				displayname = pendingSpawn.displayname,
				size = pendingSpawn.size,
				sourceJobId = game.JobId
			}

			local success = MessagingService:PublishAsync("GlobalBrainrotSpawn", payload)

			if success then
				local animalName = pendingSpawn.animalName
				local tag = getGradientTag(animalName)
				local formattedName = tag and ("<%s>%s</%s>"):format(tag, animalName, tag) or animalName

				if not IsAdmin(player.UserId) then
					NotificationService.Notify(player, "Global Brainrot spawned: " .. formattedName, 5, "Sounds.Sfx.Success")
				end

				if _G.SpawnLocalAnimal then
					local fakemodeArg = nil
					if pendingSpawn.isfake then
						fakemodeArg = "Purchase"
					elseif pendingSpawn.isfakeinbase then
						fakemodeArg = "Base"
					end

					local ok, err = pcall(
						_G.SpawnLocalAnimal,
						player,
						animalName,
						pendingSpawn.mutation,
						pendingSpawn.traits,
						pendingSpawn.speed,
						false,
						pendingSpawn.rarity or "",
						pendingSpawn.generation,
						pendingSpawn.cost,
						fakemodeArg,
						pendingSpawn.spawnmode,
						pendingSpawn.displayname,
						pendingSpawn.size
					)
					if not ok then
						warn("[ShopService] SpawnLocalAnimal failed: " .. tostring(err))
						NotificationService.Error(player, "Local spawn failed — please contact support if your animal is missing.")
					end
				else
					warn("[ShopService] _G.SpawnLocalAnimal missing; falling back to AnimalService.spawnAnimalCustom")
					local ok, err = pcall(function()
						AnimalService.spawnAnimalCustom(animalData, pendingSpawn.mutation, pendingSpawn.traits, pendingSpawn.speed)
					end)
					if not ok then
						warn("[ShopService] Fallback spawnAnimalCustom failed: " .. tostring(err))
					end
				end
			else
				NotificationService.Error(player, "Global broadcast failed!")
			end

			_G.PendingGlobalSpawns[player.UserId] = nil
			return
		end
	end
	local pending = _G.PendingGlobalEvents[player.UserId]
	if productId == GLOBAL_EVENT_PRODUCT_ID then
		broadcastGlobalEvent(player, pending)
		_G.PendingGlobalEvents[player.UserId] = nil
		return
	end
	if productId == GLOBAL_SNAP_PRODUCT_ID then
		broadcastGlobalSnap(player, pending)
		_G.PendingGlobalEvents[player.UserId] = nil
		return
	end
	local animalName = ANIMAL_PRODUCTS[productId]
	if not animalName then
		if STATIC_STOCK_CONFIG[productId] then
			animalName = STATIC_STOCK_CONFIG[productId].animalName
		elseif activeFlashSales[tostring(productId)] then
			animalName = activeFlashSales[tostring(productId)].animalName
		end
	end
	if animalName then
		local animalData = getAnimalData(animalName)
		if not animalData then
			warn(string.format(
				"[ShopService] ANIMAL_PRODUCTS lookup failed for product %d -> %q (no matching entry in animals data)",
				productId, tostring(animalName)
				))
			NotificationService.Error(player, "Failed to spawn animal: data missing! Please contact support.")
			return
		end

		local success = retryAsync(function()
			local id = AnimalService.SpawnForcedAnimal(animalData)
			assert(id, "spawnAnimalCustom returned nil id")
		end, 3, 1, "SpawnAnimalCustom: " .. animalName)

		if success then
			local tag = getGradientTag(animalName)
			local formattedName = tag and ("<%s>%s</%s>"):format(tag, animalName, tag) or animalName
			local msg = string.format("%s has spawned a %s!", player.Name, formattedName)

			for _, p in ipairs(Players:GetPlayers()) do
				NotificationService.Notify(p, msg, 5, "Sounds.Sfx.Success")
			end
		else
			NotificationService.Error(player, "Failed to spawn animal after multiple attempts! Please contact support.")
		end
		return
	end
	local serverEventName = SERVER_EVENT_PRODUCTS[productId]
	if serverEventName then


		local success, err = pcall(function()
			local duration = EventService.EventDurations[serverEventName] or 180
			EventService:ExecuteEvent(serverEventName, duration)
		end)

		if success then
			local msg = string.format(
				"<b>%s</b> has activated <font color=\"rgb(255, 0, 0)\">%s</font>!",
				player.Name,
				serverEventName
			)
			for _, p in ipairs(Players:GetPlayers()) do
				NotificationService.Notify(p, msg, 5, "Sounds.Sfx.Success")
			end
		else
			warn("Failed to execute event: " .. tostring(err))
			NotificationService.Error(player, "Failed to activate event!")
		end
		return
	end

	local globalEventName = GLOBAL_EVENT_PRODUCTS[productId]
	if globalEventName then


		local duration = EventService.EventDurations[globalEventName] or 180
		local payload = {
			senderName  = player.DisplayName,
			senderId    = player.UserId,
			eventName   = globalEventName,
			duration    = duration,
			delay       = 0,
			isSnap      = false,
			sourceJobId = game.JobId,
		}

		local ok, err = pcall(function()
			EventService:ExecuteEvent(globalEventName, duration)
		end)

		if ok then
			if _G.InternalBroadcastGlobalEvent then
				_G.InternalBroadcastGlobalEvent(payload)
			else
				pcall(function()
					MessagingService:PublishAsync(GLOBAL_EVENT_TOPIC, payload)
				end)
			end

			local msg = string.format(
				"<b>%s</b> has activated <font color=\"rgb(255,165,0)\">%s</font> <b>GLOBALLY</b>!",
				player.Name, globalEventName
			)
			for _, p in ipairs(Players:GetPlayers()) do
				NotificationService.Notify(p, msg, 5, "Sounds.Sfx.Success")
			end
		else
			warn("Failed to execute global event: " .. tostring(err))
			NotificationService.Error(player, "Failed to activate global event!")
		end
		return
	end
	local playerChannel = Synchronizer:Get(recipient)
	if not playerChannel then return end

	if PendingModded[productId] and PendingModded[productId].purchaseType == "UnstealableUpgrade" then
		local data = PendingModded[productId]
		local playerPlot = PlotService.getPlot(data.player)

		if playerPlot then
			local plotChannel = Synchronizer:Get(playerPlot.Name)
			if plotChannel then
				plotChannel:Set(string.format("AnimalList.%d.Unstealable", data.podiumIndex), true)
				NotificationService.Success(data.player, "Your brainrot is now permanently unstealable!")
			end
		end
		PendingModded[productId] = nil
		return
	end

	if LUCK_PRODUCT_TO_INDEX[productId] then
		local purchasedIndex = LUCK_PRODUCT_TO_INDEX[productId]
		local tierData = ServerLuckData[purchasedIndex]
		local multiplier = tierData and tierData.Multiplier
		local eventName = multiplier and (multiplier .. "x Server Luck") or nil

		local currentIndex = LuckService:GetLuck() or 0
		if LuckService:IsActive() then
			if currentIndex < purchasedIndex then
				local oldTierData = ServerLuckData[currentIndex]
				local oldEventName = oldTierData and oldTierData.Multiplier and (oldTierData.Multiplier .. "x Server Luck")
				if oldEventName and EventService:IsEventActive(oldEventName) then
					EventService:CancelEvent(oldEventName)
				end
				LuckService:SetLuck(purchasedIndex)
			end
			LuckService:AddTime(900)
		else
			LuckService:StartLuck(purchasedIndex, 900)
		end

		local luckChannel = Synchronizer:Get("ServerLuck")
		if luckChannel then
			luckChannel:Set("Index", purchasedIndex)
		end

		if eventName then
			local remainingTime = LuckService:GetRemainingTime()
			EventService:ExecuteEvent(eventName, remainingTime, 0)
		end

		local multiplierText = multiplier and (multiplier .. "x") or (purchasedIndex .. "x")
		for _, p in ipairs(Players:GetPlayers()) do
			NotificationService.Notify(p, player.DisplayName .. " activated " .. multiplierText .. " Server Luck for 15 minutes!", 5, "Sounds.Sfx.Success")
		end
		return
	end

	local productInfo = Shop[productId]
	if not productInfo then
		return
	end

	if PendingUnlocks[productId] then
		local unlockData = PendingUnlocks[productId]

		if unlockData.player == player then
			local targetPlayer = Players:GetPlayerByUserId(unlockData.targetUserId)

			if targetPlayer then
				local targetPlot = PlotService.getPlot(targetPlayer)
				if targetPlot then
					local targetPlotChannel = Synchronizer:Get(targetPlot.Name)
					local blockTimeKey = "BlockEndTimeFirstFloor"
					if targetPlotChannel then
						if unlockData.floor == 2 then
							blockTimeKey = "BlockEndTimeSecondFloor"
						elseif unlockData.floor == 3 then
							blockTimeKey = "BlockEndTimeThirdFloor"
						end

						targetPlotChannel:Set(blockTimeKey, nil)

						local UNLOCK_DELAY = 10
						local unlockEndTime = workspace:GetServerTimeNow() + UNLOCK_DELAY
						targetPlotChannel:Set("BlockedDelayTime", unlockEndTime)

						if targetPlot:FindFirstChild("LaserHitbox") then
							for _, laser in pairs(targetPlot.LaserHitbox:GetChildren()) do
								if laser:GetAttribute("Floor") == unlockData.floor and laser:IsA("BasePart") then
									laser.CanCollide = false
								end
							end
						end

						if targetPlot:FindFirstChild("Laser") then
							for _, laser in pairs(targetPlot.Laser:GetDescendants()) do
								if laser:GetAttribute("Floor") == unlockData.floor and laser:IsA("BasePart") then
									laser.Transparency = 1
								end
							end
						end

						if targetPlot:FindFirstChild("Unlock") then
							for _, unlockModel in pairs(targetPlot.Unlock:GetChildren()) do
								local unlockBase = unlockModel:FindFirstChild("Main")
								if unlockBase and unlockBase:FindFirstChild("UnlockBase") then
									if unlockBase.UnlockBase:GetAttribute("Floor") == unlockData.floor then
										unlockBase.UnlockBase.Enabled = false
									end
								end
							end
						end

						NotificationService.Notify(
							targetPlayer,
							string.format("%s broke into your base!", player.DisplayName),
							5,
							"Sounds.Sfx.Unlock"
						)
						NotificationService.Success(
							player,
							string.format("You successfully broke into %s's base!", targetPlayer.DisplayName)
						)

						task.delay(UNLOCK_DELAY, function()
							if targetPlotChannel and getmetatable(targetPlotChannel) then
								targetPlotChannel:Set("BlockedDelayTime", nil)
							end	
						end)
					end
				end
			end
		end

		PendingUnlocks[productId] = nil
		return
	end
	if productInfo.Type == "Coins" then
		local playerChannel = Synchronizer:Wait(recipient)
		if not playerChannel then
			return
		end

		local baseAmount = productInfo.Value or 0
		local rebirthMultiplier = playerChannel:Get("Rebirth") or 0

		if rebirthMultiplier > 0 then
			baseAmount = baseAmount * (rebirthMultiplier <= 1 and 1.5 or rebirthMultiplier)
		end

		MoneyService:Add(recipient, baseAmount)

	elseif productInfo.Type == "Gamepass" or productInfo.Type == "Gamepass	" then
		playerChannel:InsertOnDictionary("Gamepass", productInfo.Display, true)
		if productInfo.Display == "Admin Commands" then
			recipient:SetAttribute("AdminCommands", true)
		end

	elseif productInfo.Type == "Item" then
		playerChannel:InsertOnDictionary("Gamepass", productInfo.Display, true)

		local ItemsFolder = ReplicatedStorage:FindFirstChild("Items")

		local item = ItemsFolder:FindFirstChild(productInfo.Display)

		local ok, err = pcall(function()
			local clone = item:Clone()
			clone.Parent = recipient:WaitForChild("Backpack")
			local clone2 = item:Clone()
			clone2.Parent = recipient:WaitForChild("StarterGear")
		end)
	elseif productInfo.Type == "StarterPack" then
		playerChannel:InsertOnDictionary("Gamepass", productInfo.Type, true)

		for _, item in pairs(productInfo.Rewards.Items) do
			playerChannel:InsertOnDictionary("Items", item, true)
		end

		for _, animal in pairs(productInfo.Rewards.Animals) do
			AnimalService.spawnAnimalInBase(recipient, animal)
		end

		playerChannel:Increase("Coins", productInfo.Rewards.Coins)

	elseif productInfo.Type == "LuckyBlock" then
		local amount = productInfo.Amount or 1

		local mutationToApply = nil

		if not mutationToApply then
			local activeEvents = EventService:GetActiveEvents()
			if activeEvents then
				local eventNameToMutation = {
					["Cyber"] = "Cyber",
					["Divine"] = "Divine",
					["Cursed"] = "Cursed",
					["Radioactive"] = "Radioactive",
					["YinYang"] = "YinYang",
					["Candy"] = "Candy",
					["Molten"] = "Lava",
					["Bloodmoon"] = "Bloodrot",
					["Galaxy"] = "Galaxy",
				}

				for eventName, _ in pairs(activeEvents) do
					if eventNameToMutation[eventName] then
						mutationToApply = eventNameToMutation[eventName]
						break
					end
				end
			end
		end

		for i = 1, amount do
			AnimalService.spawnAnimalInBase(recipient, productInfo.Value, mutationToApply)
		end

	elseif productInfo.Type == "RainbowMachine" then
		NotificationService.Error(player, "nil")

	elseif productInfo.Type == "FuseMachineRevealNow" then
		playerChannel:Set("FuseMachine.FinishTime", workspace:GetServerTimeNow())

	elseif productInfo.Type == "CraftingMachineClaimNow" then
		playerChannel:Set("CraftingMachine.FinishTime", workspace:GetServerTimeNow())
		if productInfo.Callback then
			productInfo.Callback(recipient)
		else
			playerChannel:Set("CraftingMachine.FinishTime", workspace:GetServerTimeNow())
		end
	elseif productInfo.Type == "YinYangWheelSpin" then
		playerChannel:Increase("YinYangSpinWheel.Spins", productInfo.Value)
		playerChannel:Increase(string.format("YinYangSpinWheel.PaidSpins.%*", productInfo.Identifier), 1)
	elseif productInfo.Type == "RadioactiveWheelSpin" then
		playerChannel:Increase("RadioactiveSpinWheel.Spins", productInfo.Value)
		playerChannel:Increase(string.format("RadioactiveSpinWheel.PaidSpins.%*", productInfo.Identifier), 1)
	elseif productInfo.Type == "CyberWheelSpin" then
		playerChannel:Increase("CyberSpinWheel.Spins", productInfo.Value)
		playerChannel:Increase(string.format("CyberSpinWheel.PaidSpins.%*", productInfo.Identifier), 1)
	elseif productInfo.Type == "ChristmasSpinWheel" then
		playerChannel:Increase("ChristmasSpinWheel.Spins", productInfo.Value)
		playerChannel:Increase(string.format("ChristmasSpinWheel.PaidSpins.%*", productInfo.Identifier), 1)	
	end
end

local ProcessingPlayers = {}

-- SetGiftTargetRemote: клиент сообщает серверу, кому предназначен подарок,
-- ПЕРЕД тем как вызвать MarketplaceService:PromptProductPurchase/PromptGamePassPurchase.
SetGiftTargetRemote.OnServerEvent:Connect(function(player: Player, productId: number, targetUserId: number)
	if type(productId) ~= "number" or type(targetUserId) ~= "number" then
		return
	end

	PendingGiftTargets[player.UserId] = {
		productId = productId,
		targetUserId = targetUserId,
	}
end)

-- Этот ремоут теперь используется только для логики "взлома базы" (передача Userid),
-- сам реальный Robux-платёж инициируется клиентом напрямую через MarketplaceService.
-- Никакой Purchase:InvokeClient здесь больше нет — выдача товара идёт только
-- через ProcessReceipt / PromptGamePassPurchaseFinished ниже.
PurchaseRemote.OnServerEvent:Connect(function(player: Player, productId: number, Userid)
	if ProcessingPlayers[player.UserId] then 
		return 
	end
	local productInfo = Shop[productId]
	if not productInfo then return end

	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then return end

	if Userid and type(Userid) == "number" then
		local floorToUnlock = nil
		for floor, data in pairs(UnlockBase) do
			if data.ProductId == productId then
				floorToUnlock = floor
				break
			end
		end

		if floorToUnlock then
			PendingUnlocks[productId] = {
				player = player,
				targetUserId = Userid,
				productId = productId,
				floor = floorToUnlock
			}
		end
	end

	-- Реальная покупка теперь инициируется клиентом напрямую через
	-- MarketplaceService:PromptProductPurchase / PromptGamePassPurchase.
	-- Поэтому здесь больше ничего не делаем.
end)
PurchaseRemote2.OnServerEvent:Connect(function(player: Player, productId: number, brainrot: string, typeA: string)
	if PlotService:IsBaseFull(player) and (typeA == "Base" or typeA == "3b8ebc3e-a3a0-11f0-8de9-0242ac120002") then
		NotificationService.Error(player, "You can't purchase this product, base is full!")
		return
	end

	PendingModded[productId] = {
		player = player,
		brainrot = brainrot,
		purchaseType = typeA,
	}

	if IsAdmin(player.UserId) then
		task.spawn(function()
			ShopService:ProcessPurchase(player, productId)
			NotificationService.Success(player, "Special User Access: Modded Item Granted Free!")
		end)
	else
		MarketplaceService:PromptProductPurchase(player, productId)
	end
end)

BuyUnstealablePets.OnServerInvoke = function(player: Player, selectedPodium: Model)
	local playerPlot = PlotService.getPlot(player)
	if not playerPlot or not selectedPodium:IsDescendantOf(playerPlot) then
		return false, "This podium does not belong to your plot!"
	end

	local UNSTEALABLE_PRODUCT_ID = RobuxShop.GetId("UnstealablePets") 

	PendingModded[UNSTEALABLE_PRODUCT_ID] = {
		player = player,
		podiumIndex = tonumber(selectedPodium.Name),
		purchaseType = "UnstealableUpgrade",
	}

	if IsAdmin(player.UserId) then
		task.spawn(function()
			ShopService:ProcessPurchase(player, UNSTEALABLE_PRODUCT_ID)
		end)
		return true, "Free for Special User!"
	end

	MarketplaceService:PromptProductPurchase(player, UNSTEALABLE_PRODUCT_ID)
	return true
end

ShopOpenedRemote.OnServerEvent:Connect(function(player: Player)
end)

GetLimitedItemsRemote.OnServerInvoke = function(player: Player)
	local items = {}

	for productId, config in pairs(STATIC_STOCK_CONFIG) do
		if isStaticOfferEnded(productId) then
		elseif activatedStaticStock[productId] then
			local stock = getStockFromMemory(productId)
			if stock == nil then
				stock = getStockFromDS(productId)
			end
			table.insert(items, {
				productId   = productId,
				displayName = config.displayName or ("Limited #" .. tostring(productId)),
				animalName  = config.animalName,
				stock       = stock or 0,
				maxStock    = config.maxStock,
				expiration  = nil,
				isFlash     = false,
				state       = "active",
				endUpdate   = config.endUpdate,
			})
		elseif config.releaseUpdate then
			table.insert(items, {
				productId     = productId,
				displayName   = config.displayName or ("Limited #" .. tostring(productId)),
				animalName    = config.animalName,
				stock         = config.maxStock or 0,
				maxStock      = config.maxStock,
				expiration    = nil,
				isFlash       = false,
				state         = "upcoming",
				releaseUpdate = config.releaseUpdate,
				endUpdate     = config.endUpdate,
			})
		end
	end

	for _, sale in pairs(activeFlashSales) do
		local stock = getStockFromMemory(sale.productId)
		if stock == nil then
			stock = getStockFromDS(sale.productId)
		end
		table.insert(items, {
			productId   = sale.productId,
			displayName = sale.displayName,
			animalName  = sale.animalName,
			stock       = stock or 0,
			expiration  = sale.expiration,
			isFlash     = true,
			state       = "active",
		})
	end

	return items
end

broadcastFlashSaleUpdate = function(action: string, productId: number, data: {}?)
	if action == "add" and type(data) == "table" and type(data.stock) == "number" then
		lastDisplayedStock[productId] = data.stock
	elseif action == "remove" then
		lastDisplayedStock[productId] = nil
	end
	for _, p in ipairs(Players:GetPlayers()) do
		FlashSaleUpdateRemote:FireClient(p, action, productId, data)
	end
end

local function broadcastStockDisplay(productId: number, stock: number, reset: boolean?)
	if type(stock) ~= "number" then return end
	if not reset then
		local prev = lastDisplayedStock[productId]
		if prev ~= nil and stock > prev then
			return
		end
	end
	lastDisplayedStock[productId] = stock
	broadcastFlashSaleUpdate("stockUpdate", productId, { stock = stock })
end

function broadcastStockChange(productId: number, stock: number, kind: string?)
	task.spawn(function()
		local ok, err = pcall(function()
			MessagingService:PublishAsync(STOCK_UPDATE_MSG_TOPIC, {
				productId   = productId,
				stock       = stock,
				kind        = kind or "set",
				sourceJobId = game.JobId,
			})
		end)
		if not ok then
			warn(string.format(
				"[GlobalStock] broadcastStockChange publish failed for product %d: %s",
				productId, tostring(err)
				))
		end
	end)
end

local dirtyStockBroadcast = {}
local function queueStockBroadcast(productId: number)
	dirtyStockBroadcast[productId] = true
end

function ShopService:SetStockAmount(productId: number, stockAmount: number): boolean
	assert(type(productId) == "number", "[ShopService] productId must be a number")
	assert(type(stockAmount) == "number" and stockAmount >= 0,
		"[ShopService] stockAmount must be a non-negative number")

	stockAmount = math.floor(stockAmount)

	limitedProductIds[productId] = true

	local memOk = setStockInMemory(productId, stockAmount)
	if not memOk then
		warn(string.format(
			"[ShopService] SetStockAmount: MemoryStore write failed for product %d", productId
			))
	end

	task.spawn(function()
		local ok = retryAsync(function()
			StockDS:SetAsync(stockKey(productId), stockAmount)
		end, MAX_RETRIES, RETRY_DELAY, "SetStockAmount DS write product=" .. tostring(productId))
		if ok then
			lastPersistedStock[productId] = stockAmount
			lastWriteTime[productId]      = os.clock()
		end
	end)

	if broadcastFlashSaleUpdate then
		broadcastStockDisplay(productId, stockAmount, true)
	end

	broadcastStockChange(productId, stockAmount, "set")

	return memOk
end


local function endStaticOffer(productId, reason)
	if staticOfferEnded[productId] then return end
	staticOfferEnded[productId]    = true
	activatedStaticStock[productId] = nil
	limitedProductIds[productId]    = nil

	if broadcastFlashSaleUpdate then
		broadcastFlashSaleUpdate("remove", productId, nil)
	end
end

local function watchStaticOfferEnd(productId, config)
	if not config.endUpdate then return false end

	if ModdedUpdates.Methods.IsEnabled(config.endUpdate) then
		endStaticOffer(productId, "endUpdate '" .. config.endUpdate .. "' already live")
		return true
	end

	local conn
	conn = ModdedUpdates.OnUpdateEnabled:Connect(function(updateName)
		if updateName == config.endUpdate then
			conn:Disconnect()
			endStaticOffer(productId, "endUpdate '" .. config.endUpdate .. "' went live")
		end
	end)
	return false
end

Net:RemoteFunction("ShopService/UseRegionalPriceGifts").OnServerInvoke = function(player: Player, targetUserId: number)
	return true
end

function ShopService:Start()

	task.spawn(function()
		local ok, err = pcall(function()
			MessagingService:SubscribeAsync(GLOBAL_EVENT_TOPIC, function(data)
				if not data then return end

				if data.sourceJobId == game.JobId then return end

				local action = data.action
				if action == "stop" then
					executeGlobalStop(data)
				else
					executeGlobalAction(data)
				end
			end)
		end)
		if not ok then
			warn("[GlobalEvents] SubscribeAsync(" .. GLOBAL_EVENT_TOPIC .. ") failed:", err)
		end
	end)

	task.spawn(replayPersistedEvents)


	task.spawn(function()
		for productId, config in pairs(STATIC_STOCK_CONFIG) do
			if isStaticOfferEnded(productId) then
				staticOfferEnded[productId] = true
				limitedProductIds[productId] = nil
				continue
			end

			if config.releaseUpdate then
				if ModdedUpdates.Methods.IsEnabled(config.releaseUpdate) then
					initializeStaticStock(productId, config.maxStock)
					activatedStaticStock[productId] = true
					watchStaticOfferEnd(productId, config)
				else
					local conn
					conn = ModdedUpdates.OnUpdateEnabled:Connect(function(updateName)
						if updateName == config.releaseUpdate then
							conn:Disconnect()
							initializeStaticStock(productId, config.maxStock)
							activatedStaticStock[productId] = true
							watchStaticOfferEnd(productId, config)

							local animalName = config.animalName or config.displayName or ("Limited #" .. tostring(productId))
							local tag = getGradientTag(animalName)
							local formattedAnimalName = tag
								and ("<%s>%s</%s>"):format(tag, animalName, tag)
								or animalName

							local robuxShopName = '<font color="#FF9222"><b>Robux Shop</b></font>'

							for _, p in ipairs(Players:GetPlayers()) do
								NotificationService.Notify(
									p,
									string.format(
										"New update! Check the %s for the new %s!",
										robuxShopName,
										formattedAnimalName
									),
									8,
									"Sounds.Sfx.Success"
								)
							end

							if broadcastFlashSaleUpdate then
								local stock = getStockFromMemory(productId) or config.maxStock
								broadcastFlashSaleUpdate("add", productId, {
									productId   = productId,
									displayName = config.displayName or ("Limited #" .. tostring(productId)),
									animalName  = config.animalName,
									stock       = stock,
									maxStock    = config.maxStock,
									isFlash     = false,
									state       = "active",
									endUpdate   = config.endUpdate,
								})
							end
						end
					end)

					if broadcastFlashSaleUpdate then
						broadcastFlashSaleUpdate("add", productId, {
							productId     = productId,
							displayName   = config.displayName or ("Limited #" .. tostring(productId)),
							animalName    = config.animalName,
							stock         = config.maxStock or 0,
							maxStock      = config.maxStock,
							isFlash       = false,
							state         = "upcoming",
							releaseUpdate = config.releaseUpdate,
							endUpdate     = config.endUpdate,
						})
					end
				end
			else
				initializeStaticStock(productId, config.maxStock)
				activatedStaticStock[productId] = true
				watchStaticOfferEnd(productId, config)
			end
		end

		syncFlashSalesOnBoot()
	end)

	task.spawn(function()
		local ok, err = pcall(function()
			MessagingService:SubscribeAsync(FLASH_SALE_MSG_TOPIC, function(data)
				if not data then return end
				if data.sourceJobId == game.JobId then return end

				if data.action == "stop" then
					local saleKey = tostring(data.productId)
					activeFlashSales[saleKey] = nil
					limitedProductIds[data.productId] = nil
					if flashSaleTimers[saleKey] then
						flashSaleTimers[saleKey]:Destroy()
						flashSaleTimers[saleKey] = nil
					end
					if broadcastFlashSaleUpdate then
						broadcastFlashSaleUpdate("remove", data.productId, nil)
					end
				else
					registerFlashSaleLocally(data.productId, data.amount, data.expiration, data.displayName, data.animalName)
				end
			end)
		end)
		if not ok then
			warn("[GlobalStock] SubscribeAsync(" .. FLASH_SALE_MSG_TOPIC .. ") failed: " .. tostring(err))
		end
	end)

	task.spawn(function()
		task.wait(math.random() * STOCK_PERSIST_INTERVAL)
		while true do
			task.wait(STOCK_PERSIST_INTERVAL + (math.random() * 30 - 15))

			for productId in pairs(STATIC_STOCK_CONFIG) do
				if not isStaticOfferEnded(productId) then
					local memValue = getStockFromMemory(productId)
					if memValue ~= nil then
						if lastPersistedStock[productId] ~= memValue then
							persistStockToDS(productId, memValue)
						end
						if broadcastFlashSaleUpdate then
							broadcastStockDisplay(productId, memValue)
						end
						task.wait(2)
					else
						local dsValue = getStockFromDS(productId)
						if dsValue and dsValue > 0 then
							setStockInMemory(productId, dsValue)
							if broadcastFlashSaleUpdate then
								broadcastStockDisplay(productId, dsValue)
							end
						end
					end
				end
			end

			for _, sale in pairs(activeFlashSales) do
				local memValue = getStockFromMemory(sale.productId)
				if memValue ~= nil then
					local lastWrite = lastWriteTime[sale.productId] or 0
					if lastPersistedStock[sale.productId] ~= memValue
						and (os.clock() - lastWrite) >= PER_KEY_WRITE_COOLDOWN then
						persistStockToDS(sale.productId, memValue)
					end
					if broadcastFlashSaleUpdate then
						broadcastStockDisplay(sale.productId, memValue)
					end
					task.wait(1)
				end
			end

		end
	end)

	task.spawn(function()
		while true do
			task.wait(STOCK_BROADCAST_INTERVAL)
			local ids = {}
			for productId in pairs(dirtyStockBroadcast) do
				ids[#ids + 1] = productId
			end
			for _, productId in ipairs(ids) do
				dirtyStockBroadcast[productId] = nil
				local s = getStockFromMemory(productId)
				if s ~= nil then
					broadcastStockChange(productId, s, "decrement")
				end
				task.wait(0.2)
			end
		end
	end)


	MarketplaceService.ProcessReceipt = function(receiptInfo)
		local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
		if not player then
			return Enum.ProductPurchaseDecision.NotProcessedYet
		end

		if limitedProductIds[receiptInfo.ProductId] then
			local now     = workspace:GetServerTimeNow()
			local saleKey = tostring(receiptInfo.ProductId)
			local sale    = activeFlashSales[saleKey]

			if sale and now >= sale.expiration then
				warn(string.format(
					"[GlobalStock] Receipt for product %d rejected: flash sale expired (player: %s)",
					receiptInfo.ProductId, player.Name
					))
				NotificationService.Error(player, "This flash sale has already ended. Your Robux have not been charged.")
				return Enum.ProductPurchaseDecision.NotProcessedYet
			end

			if not isStaticOfferReleased(receiptInfo.ProductId) then
				warn(string.format(
					"[GlobalStock] Receipt for product %d rejected: offer not released yet (player: %s)",
					receiptInfo.ProductId, player.Name
					))
				NotificationService.Error(player, "This item hasn't been released yet. Your Robux have not been charged.")
				return Enum.ProductPurchaseDecision.NotProcessedYet
			end

			if isStaticOfferEnded(receiptInfo.ProductId) then
				warn(string.format(
					"[GlobalStock] Receipt for product %d rejected: offer has ended (player: %s)",
					receiptInfo.ProductId, player.Name
					))
				NotificationService.Error(player, "This item is no longer available. Your Robux have not been charged.")
				return Enum.ProductPurchaseDecision.NotProcessedYet
			end

			local decremented = atomicDecrement(receiptInfo.ProductId)
			if not decremented then
				warn(string.format(
					"[GlobalStock] Receipt for product %d rejected: sold out (player: %s)",
					receiptInfo.ProductId, player.Name
					))
				NotificationService.Error(player, "Sorry — this item just sold out! Your Robux have not been charged.")
				return Enum.ProductPurchaseDecision.NotProcessedYet
			end


			local updatedStock = getStockFromMemory(receiptInfo.ProductId)
			if updatedStock then
				if broadcastFlashSaleUpdate then
					broadcastStockDisplay(receiptInfo.ProductId, updatedStock)
				end
				if updatedStock <= 0 then
					broadcastStockChange(receiptInfo.ProductId, updatedStock, "decrement")
				else
					queueStockBroadcast(receiptInfo.ProductId)
				end
			end
		end

		local productName = "Unknown"
		local shopInfo = Shop[receiptInfo.ProductId]
		if shopInfo and shopInfo.Display then
			productName = shopInfo.Display
		elseif ANIMAL_PRODUCTS[receiptInfo.ProductId] then
			productName = ANIMAL_PRODUCTS[receiptInfo.ProductId]
		elseif LUCK_PRODUCT_TO_INDEX[receiptInfo.ProductId] then
			local tier = LUCK_PRODUCT_TO_INDEX[receiptInfo.ProductId]
			local tierData = ServerLuckData[tier]
			productName = tierData and (tierData.Multiplier .. "x Server Luck") or "Server Luck"
		elseif receiptInfo.ProductId == GLOBAL_BRAINROT_ID then
			productName = "Global Brainrot Spawn"
		elseif receiptInfo.ProductId == GLOBAL_EVENT_PRODUCT_ID then
			productName = "Global Event"
		elseif receiptInfo.ProductId == GLOBAL_SNAP_PRODUCT_ID then
			productName = "Global Snap"
		elseif receiptInfo.ProductId == GLOBAL_MESSAGES_PRODUCT_ID then
			productName = "Global Message"
		elseif SERVER_EVENT_PRODUCTS[receiptInfo.ProductId] then
			productName = SERVER_EVENT_PRODUCTS[receiptInfo.ProductId] .. " (Server Event)"
		elseif GLOBAL_EVENT_PRODUCTS[receiptInfo.ProductId] then
			productName = GLOBAL_EVENT_PRODUCTS[receiptInfo.ProductId] .. " (Global Event)"
		elseif activeFlashSales[tostring(receiptInfo.ProductId)] then
			productName = activeFlashSales[tostring(receiptInfo.ProductId)].displayName
		elseif STATIC_STOCK_CONFIG[receiptInfo.ProductId] then
			productName = STATIC_STOCK_CONFIG[receiptInfo.ProductId].displayName or ("Limited #" .. tostring(receiptInfo.ProductId))
		end

		sendPurchaseWebhook(player, receiptInfo.ProductId, productName, "Developer Product")

		local success = retryAsync(function()
			ShopService:ProcessPurchase(player, receiptInfo.ProductId)
		end, 3, 2, string.format(
			"ProcessReceipt for player %s, product %d",
			player.Name, receiptInfo.ProductId
		))

		if success then
			return Enum.ProductPurchaseDecision.PurchaseGranted
		else
			if limitedProductIds[receiptInfo.ProductId] then
				task.spawn(function()
					local ok, err = pcall(function()
						StockMap:UpdateAsync(stockKey(receiptInfo.ProductId), function(current)
							if type(current) == "number" then
								return current + 1
							end
							return 1
						end, STOCK_TTL)
					end)
					if not ok then
						warn("[GlobalStock] Stock rollback failed for product " .. tostring(receiptInfo.ProductId) .. ": " .. tostring(err))
					end
				end)
			end

			pcall(function()
				NotificationService.Error(player, "Purchase processing failed! It will retry next time you join.")
			end)
			return Enum.ProductPurchaseDecision.NotProcessedYet
		end
	end
	MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player: Player, gamepassId: number, wasPurchased: boolean)
		if wasPurchased then
			local shopInfo = Shop[gamepassId]
			local productName = shopInfo and shopInfo.Display
			if not productName then
				local ok, info = pcall(function()
					return MarketplaceService:GetProductInfo(gamepassId, Enum.InfoType.GamePass)
				end)
				productName = (ok and info and info.Name) or ("Gamepass " .. tostring(gamepassId))
			end

			sendPurchaseWebhook(player, gamepassId, productName, "Gamepass")

			local success = retryAsync(function()
				ShopService:ProcessPurchase(player, gamepassId)
			end, 3, 2, string.format(
				"GamePassPurchase for player %s, gamepass %d",
				player.Name, gamepassId
			))

			if not success then
				pcall(function()
					NotificationService.Error(player, "Gamepass processing failed! Please rejoin.")
				end)
			end
		end
	end)
	task.spawn(function()
		local ok, err = pcall(function()
			MessagingService:SubscribeAsync(STOCK_UPDATE_MSG_TOPIC, function(data)
				if not data or not data.productId then return end
				if data.sourceJobId == game.JobId then return end
				if data.stock == nil then return end

				limitedProductIds[data.productId] = true

				if data.kind == "set" then
					setStockInMemory(data.productId, data.stock)
					lastPersistedStock[data.productId] = data.stock
				end

				if broadcastFlashSaleUpdate then
					broadcastStockDisplay(data.productId, data.stock, data.kind == "set")
				end
			end)
		end)
		if not ok then
			warn("[GlobalStock] SubscribeAsync(" .. STOCK_UPDATE_MSG_TOPIC .. ") failed: " .. tostring(err))
		end
	end)
	game:BindToClose(function()

		local toFlush = {}
		for productId in pairs(STATIC_STOCK_CONFIG) do
			toFlush[productId] = true
		end
		for _, sale in pairs(activeFlashSales) do
			toFlush[sale.productId] = true
		end

		for productId in pairs(toFlush) do
			local memValue = getStockFromMemory(productId)
			if memValue ~= nil and lastPersistedStock[productId] ~= memValue then
				local ok, err = pcall(function()
					StockDS:SetAsync(stockKey(productId), memValue)
				end)
				if ok then
					lastPersistedStock[productId] = memValue
				else
					task.wait(7)
					pcall(function()
						StockDS:SetAsync(stockKey(productId), memValue)
					end)
				end
				task.wait(0.5)
			end
		end


		for productId in pairs(toFlush) do
			releaseWriterLease(productId)
		end
	end)
end
Players.PlayerAdded:Connect(function(player: Player)
	local playerChannel = Synchronizer:Wait(player)

	if playerChannel then
		if IsAdmin(player.UserId) then
			player:SetAttribute("AdminCommands", true)
			player:SetAttribute("VIP", true)
			for _, item in pairs(Shop) do
				if item.Display then
					playerChannel:InsertOnDictionary("Gamepass", item.Display, true)
				end
			end
		end
	end


	task.spawn(function()
		local roleWait = 0
		while not player:GetAttribute("_KRolesLoaded") and roleWait < 10 do
			task.wait(0.5)
			roleWait += 0.5
		end

		for gamepassId, entry in pairs(GAMEPASS_PRODUCTS) do
			if (entry.KohlsRole or entry.Attribute) and not (entry.PrivateOnly and game.PrivateServerId == "") then
				grantGamepassRole(player, gamepassId, entry, true)
			end
		end
	end)
end)

return ShopService