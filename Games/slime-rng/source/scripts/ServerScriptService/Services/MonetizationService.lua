local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local DataService = require(ReplicatedStorage.Packages.DataService).server
local Products = require(ReplicatedStorage.Source.Features.Monetization.Modules.Products)
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)

local _luckLadderService = nil
local function getLuckLadderService()
	if _luckLadderService then return _luckLadderService end
	local ok, svc = pcall(function()
		local ServerScriptService = game:GetService("ServerScriptService")
		local Services = ServerScriptService:FindFirstChild("Services")
		local mod = Services and Services:FindFirstChild("LuckLadderService")
		return mod and require(mod)
	end)
	if ok and svc then
		_luckLadderService = svc
	end
	return _luckLadderService
end

local MonetizationService = {}

-- ─── Safe data getter ─────────────────────────────────────────────────────────
local function safeGet(data, key)
	local val = data:get(key)
	if type(val) == "function" then val = val() end
	return val
end


local BOOST_DURATION = 3600 -- 1 hour per charge

local function addBoost(player, data, boostKey: string, charges: number)
	local boosts = safeGet(data, "boosts") or {}
	local existing = type(boosts[boostKey]) == "table" and boosts[boostKey] or {}

	local currentAmount      = type(existing.amount)      == "number" and existing.amount      or 0
	local currentRemaining   = type(existing.timeRemaining)  == "number" and existing.timeRemaining  or 0
	local currentExpiration  = type(existing.expirationTime) == "number" and existing.expirationTime or 0

	local now = os.time()
	-- If not currently active, start fresh from now
	local baseExpiry = math.max(currentExpiration, now)
	local newExpiry  = baseExpiry + (BOOST_DURATION * charges)
	local newRemaining = newExpiry - now

	DataService:set(player, { "boosts", boostKey, "amount"        }, currentAmount + charges)
	DataService:set(player, { "boosts", boostKey, "timeRemaining" }, newRemaining)
	DataService:set(player, { "boosts", boostKey, "expirationTime"}, newExpiry)

	print(string.format(
		"[MonetizationService] Boost %s: +%d charges | timeRemaining: %ds | expires: %d | player: %s",
		boostKey, charges, newRemaining, newExpiry, player.Name
		))
end

local function getMonetizationRemoteEvent()
	local networker031 = ReplicatedStorage.Packages._Index["leifstout_networker@0.3.1"].networker
	local remotes = networker031:FindFirstChild("_remotes")
	local svc = remotes and remotes:FindFirstChild("MonetizationService")
	return svc and svc:FindFirstChild("RemoteEvent")
end

local function fireClient(player, ...)
	local re = getMonetizationRemoteEvent()
	if re then re:FireClient(player, ...) end
end

local productIdToKey  = {}
local giftIdToKey     = {}
local gamepassIdToKey = {}

for key, product in pairs(Products) do
	if type(product) == "table" and product.id then
		if product.isPass then
			gamepassIdToKey[product.id] = key
		else
			productIdToKey[product.id] = key
		end
		if product.giftId then
			giftIdToKey[product.giftId] = key
		end
	end
end

local function grantProduct(player: Player, productKey: string, isGift: boolean?, fromUserId: number?)
	local data = DataService:waitForData(player)
	if not data then
		warn("[MonetizationService] No data for", player.Name)
		return false
	end

	print("[MonetizationService] Granting:", productKey, "to", player.Name)

	-- ── Coins ─────────────────────────────────────────────────────────────
	if productKey == "coinsSmall" then
		local coins = safeGet(data, "coins") or 0
		DataService:set(player, "coins", coins + 400000)
		print("[MonetizationService] +400,000 coins to", player.Name)

	elseif productKey == "coinsMedium" then
		local coins = safeGet(data, "coins") or 0
		DataService:set(player, "coins", coins + 6000000)
		print("[MonetizationService] +6,000,000 coins to", player.Name)

	elseif productKey == "coinsLarge" then
		local coins = safeGet(data, "coins") or 0
		DataService:set(player, "coins", coins + 16000000)
		print("[MonetizationService] +16,000,000 coins to", player.Name)

	elseif productKey == "luckBoost" then
		addBoost(player, data, "luck", 1)

	elseif productKey == "ultraLuckBoost" then
		addBoost(player, data, "ultraLuck", 1)

	elseif productKey == "coinBoost" then
		addBoost(player, data, "currency", 1)

	elseif productKey == "rollSpeedBoost" then
		addBoost(player, data, "rollSpeed", 1)

	elseif productKey == "foodSnack" then
		local items = safeGet(data, "items") or {}
		local new = table.clone(items)
		new.apple  = (new.apple  or 0) + 20
		new.carrot = (new.carrot or 0) + 10
		new.banana = (new.banana or 0) + 5
		DataService:set(player, "items", new)

	elseif productKey == "foodMeal" then
		local items = safeGet(data, "items") or {}
		local new = table.clone(items)
		new.watermelon = (new.watermelon or 0) + 20
		new.pizza      = (new.pizza      or 0) + 10
		new.chicken    = (new.chicken    or 0) + 5
		DataService:set(player, "items", new)

	elseif productKey == "foodFeast" then
		local items = safeGet(data, "items") or {}
		local new = table.clone(items)
		new.pizza     = (new.pizza     or 0) + 40
		new.chicken   = (new.chicken   or 0) + 20
		new.drumstick = (new.drumstick or 0) + 10
		DataService:set(player, "items", new)

	elseif productKey == "jackpotSpinSingle" then
		local n = safeGet(data, "armedJackpotSpins") or 0
		DataService:set(player, "armedJackpotSpins", n + 1)

	elseif productKey == "jackpotSpinBundle" then
		local n = safeGet(data, "armedJackpotSpins") or 0
		DataService:set(player, "armedJackpotSpins", n + 3)

	elseif productKey == "jackpotSpinCrate" then
		local n = safeGet(data, "armedJackpotSpins") or 0
		DataService:set(player, "armedJackpotSpins", n + 10)

	elseif productKey == "starterPack" then
		local otp = safeGet(data, "__oneTimePurchases") or {}
		local pid = tostring(Products.starterPack.id)
		if otp[pid] then
			warn("[MonetizationService] Starter pack already owned by", player.Name)
			return false
		end
		local newOtp = table.clone(otp)
		newOtp[pid] = true
		DataService:set(player, "__oneTimePurchases", newOtp)

		local coins = safeGet(data, "coins") or 0
		DataService:set(player, "coins", coins + 100000)

		local mushyData = { id = "mushy", level = 1, xp = 0, mutations = nil }
		local mushyKey  = InventoryServiceUtils.genKey(mushyData)
		local inventory = safeGet(data, "inventory") or {}
		local newInv = table.clone(inventory)
		newInv[mushyKey] = mushyData
		DataService:set(player, "inventory", newInv)

		addBoost(player, data, "luck",      3)
		addBoost(player, data, "rollSpeed", 2)

		local items = safeGet(data, "items") or {}
		local newItems = table.clone(items)
		newItems.apple = (newItems.apple or 0) + 10
		DataService:set(player, "items", newItems)
		print("[MonetizationService] Granted starter pack to", player.Name)

	elseif string.match(productKey, "^luckLadder%d+$") then
		local mult = tonumber(string.match(productKey, "luckLadder(%d+)"))
		if mult then
			local lls = getLuckLadderService()
			if lls then
				lls:applyPurchase(player, mult)
				print("[MonetizationService] LuckLadder purchase routed to LuckLadderService x" .. mult)
			else
				warn("[MonetizationService] LuckLadderService not found, writing directly")
				local now = os.time()
				DataService:set(player, "luckLadder", {
					multiplier        = mult,
					expirationTime    = now + 900,
					lastPurchaserName = player.Name,
				})
			end
		else
			warn("[MonetizationService] Could not parse luckLadder multiplier:", productKey)
		end

	else
		warn("[MonetizationService] Unknown productKey:", productKey, "for", player.Name)
		return false
	end

	fireClient(player, "_purchaseCompleted", { productKey = productKey })

	if isGift and fromUserId then
		fireClient(player, "_receivedGift", { productKey = productKey, fromUserId = fromUserId })
	end

	return true
end

local function grantGamepass(player: Player, gamepassId: number)
	local data = DataService:waitForData(player)
	if not data then return end
	local gp = safeGet(data, "__gamepasses") or {}
	local newGp = table.clone(gp)
	newGp[tostring(gamepassId)] = true
	DataService:set(player, "__gamepasses", newGp)
	local key = gamepassIdToKey[gamepassId]
	print("[MonetizationService] Granted gamepass:", key or gamepassId, "to", player.Name)
	if key then
		fireClient(player, "_purchaseCompleted", { productKey = key })
	end
end

local function syncGamepassesOnJoin(player: Player)
	task.wait(2)
	local data = DataService:waitForData(player)
	if not data then return end
	local gp = safeGet(data, "__gamepasses") or {}
	local newGp = table.clone(gp)
	local changed = false
	for key, product in pairs(Products) do
		if type(product) == "table" and product.isPass and product.id then
			local ok, owns = pcall(MarketplaceService.UserOwnsGamePassAsync,
				MarketplaceService, player.UserId, product.id)
			if ok and owns then
				local strId = tostring(product.id)
				if not newGp[strId] then
					newGp[strId] = true
					changed = true
					print("[MonetizationService] Synced gamepass:", key, "for", player.Name)
				end
			end
		end
	end
	if changed then
		DataService:set(player, "__gamepasses", newGp)
	end
	print("[MonetizationService] Gamepass sync done for", player.Name)
end

function MonetizationService:init()
	local networker031 = ReplicatedStorage.Packages._Index["leifstout_networker@0.3.1"].networker
	local remotes = networker031:WaitForChild("_remotes", 10)
	if not remotes then warn("[MonetizationService] _remotes not found"); return end

	local svcRemotes = remotes:WaitForChild("MonetizationService", 10)
	if not svcRemotes then warn("[MonetizationService] MonetizationService remotes not found"); return end

	local rf = svcRemotes:FindFirstChild("RemoteFunction")
	if rf then
		rf.OnServerInvoke = function(player, method, ...)
			if method == "promptGift" then return self:promptGift(player, ...) end
			warn("[MonetizationService] Unknown method:", method)
			return false, nil
		end
		print("[MonetizationService] OnServerInvoke set")
	end

	MarketplaceService.ProcessReceipt = function(receiptInfo)
		local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
		if not player then
			return Enum.ProductPurchaseDecision.NotProcessedYet
		end
		local productId = receiptInfo.ProductId
		local key = productIdToKey[productId] or giftIdToKey[productId]
		if not key then
			warn("[MonetizationService] Unknown product ID:", productId)
			return Enum.ProductPurchaseDecision.PurchaseGranted
		end
		local isGift = giftIdToKey[productId] ~= nil and productIdToKey[productId] == nil
		local ok, result = pcall(grantProduct, player, key, isGift, nil)
		if ok and result then
			return Enum.ProductPurchaseDecision.PurchaseGranted
		else
			warn("[MonetizationService] Failed to grant:", key, result)
			return Enum.ProductPurchaseDecision.NotProcessedYet
		end
	end

	MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, gamepassId, wasPurchased)
		if wasPurchased then grantGamepass(player, gamepassId) end
	end)

	Players.PlayerAdded:Connect(function(player)
		task.spawn(syncGamepassesOnJoin, player)
	end)
	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(syncGamepassesOnJoin, player)
	end

	print("[MonetizationService] Initialized")
end

function MonetizationService:promptGift(player: Player, targetUserId: number, giftId: number)
	if type(targetUserId) ~= "number" or type(giftId) ~= "number" then
		return false, "Invalid parameters"
	end
	local targetPlayer = Players:GetPlayerByUserId(targetUserId)
	if not targetPlayer then return false, "Player not found" end
	if targetPlayer == player then return false, "Cannot gift yourself" end
	local productKey = giftIdToKey[giftId]
	if not productKey then return false, "Unknown gift" end
	local ok, result = pcall(grantProduct, targetPlayer, productKey, true, player.UserId)
	if not ok or not result then return false, "Failed to grant gift" end
	return true, nil
end

return MonetizationService