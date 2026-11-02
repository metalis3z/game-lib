--[[
	ReceiptRouter  (ModuleScript, server only)

	One MarketplaceService.ProcessReceipt for the whole game:
	  * a table of developer products -> grant functions (no giant if/elseif chain)
	  * idempotent: every PurchaseId is remembered in the BUYER's saved data, so a receipt that
	    Roblox re-delivers after a crash is never granted twice
	  * an in-flight lock so the same receipt cannot run twice at once
	  * optional CanBuy check used both before prompting and when the receipt arrives
	  * gifting: a separate "gift" product id for each giftable product; the buyer picks a
	    target first (server validated), the grant goes to the target, the receipt is recorded
	    on the buyer
	  * a small prompt helper with a cooldown

	Credit: receipt-id memory + in-flight lock + "server test" from steal-an-egg Core_Purchases;
	product table with callbacks from punching-simulator Purchases and BIG Paintball Products;
	gift ids from slime-rng MonetizationService / grow-a-garden-2 (giftId per product);
	"purchase history by userId:purchaseId" from work-at-a-pizza-place PurchaseService.

	Usage (server):
		local ReceiptRouter = require(game.ServerScriptService.ReceiptRouter)

		ReceiptRouter.Init({
			-- Return the player's live saved-data table (or nil while loading). It must persist
			-- whatever is stored under data.ProcessedReceipts.
			GetData = function(player) return MyData:Get(player) end,
			-- Optional: save right away after a grant.
			SaveNow = function(player) MyData:SaveNow(player) end,
			-- Optional: tell the client something happened.
			Notify = function(player, kind, productName, otherPlayer) end,
		})

		ReceiptRouter.Register(1111111, "Coins1000", function(player, data)
			data.Coins += 1000
			return true -- return true only when the item really was given
		end)

		ReceiptRouter.Register(2222222, "StarterPack", function(player, data)
			if data.OwnedPacks.Starter then
				-- Bought twice (two prompts open at once): give a substitute instead of failing,
				-- because returning false leaves a PAID receipt pending forever.
				data.Coins += 25000
				return true
			end
			data.OwnedPacks.Starter = true
			data.Coins += 5000
			return true
		end, function(player, data)
			if data.OwnedPacks.Starter then
				return false, "You already own the starter pack."
			end
			return true
		end)

		-- Same reward, separate product the buyer pays for when gifting:
		ReceiptRouter.RegisterGift(3333333, 1111111)

		-- Wire to your remotes (validate types first!):
		--   SetGiftTarget.OnServerEvent -> ReceiptRouter.SetGiftTarget(player, userId)
		--   Buy.OnServerInvoke           -> return ReceiptRouter.Prompt(player, productId)
]]

local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local ReceiptRouter = {}

local MAX_REMEMBERED = 200 -- receipt ids kept per player
local GIFT_TARGET_TTL = 300 -- seconds a chosen gift target stays valid
local PROMPT_COOLDOWN = 1
local DATA_WAIT = 10

local options = nil
local products = {} -- [productId] = { Name, Grant, CanBuy }
local giftToBase = {} -- [giftProductId] = baseProductId
local giftTargets = {} -- [buyer] = { UserId, At }
local inFlight = {} -- [purchaseId] = true
local lastPrompt = {} -- [player] = os.clock()

local function waitForData(player)
	local deadline = os.clock() + DATA_WAIT
	local data = options.GetData(player)
	while not data and player.Parent == Players and os.clock() < deadline do
		task.wait(0.25)
		data = options.GetData(player)
	end
	return data
end

local function remember(data, purchaseId)
	local list = data.ProcessedReceipts
	if type(list) ~= "table" then
		list = {}
		data.ProcessedReceipts = list
	end
	list[purchaseId] = os.time()

	-- Keep the list bounded: drop the oldest entries.
	local count = 0
	for _ in pairs(list) do
		count += 1
	end
	while count > MAX_REMEMBERED do
		local oldestId, oldestTime = nil, math.huge
		for id, at in pairs(list) do
			if at < oldestTime then
				oldestId, oldestTime = id, at
			end
		end
		list[oldestId] = nil
		count -= 1
	end
end

local function notify(...)
	if options.Notify then
		task.spawn(options.Notify, ...)
	end
end

-- Who receives a gift product. Falls back to the buyer when the target left.
local function resolveRecipient(buyer)
	local target = giftTargets[buyer]
	giftTargets[buyer] = nil
	if target and os.time() - target.At <= GIFT_TARGET_TTL then
		local player = Players:GetPlayerByUserId(target.UserId)
		if player and player ~= buyer then
			return player, true
		end
	end
	return buyer, false
end

local function processReceipt(receipt)
	local purchaseId = tostring(receipt.PurchaseId)
	local buyer = Players:GetPlayerByUserId(receipt.PlayerId)
	if not buyer then
		return Enum.ProductPurchaseDecision.NotProcessedYet -- re-delivered when they join again
	end

	local buyerData = waitForData(buyer)
	if not buyerData then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end
	if type(buyerData.ProcessedReceipts) == "table" and buyerData.ProcessedReceipts[purchaseId] then
		return Enum.ProductPurchaseDecision.PurchaseGranted -- already given before a crash/rejoin
	end
	if inFlight[purchaseId] then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	local baseId = giftToBase[receipt.ProductId]
	local product = products[baseId or receipt.ProductId]
	if not product then
		warn(("[ReceiptRouter] No handler for product %d"):format(receipt.ProductId))
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	local recipient, isGift = buyer, false
	if baseId then
		recipient, isGift = resolveRecipient(buyer)
	end
	local recipientData = if recipient == buyer then buyerData else waitForData(recipient)
	if not recipientData then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	inFlight[purchaseId] = true
	local ok, granted = pcall(product.Grant, recipient, recipientData, receipt)
	if ok and granted then
		remember(buyerData, purchaseId)
	end
	inFlight[purchaseId] = nil

	if not ok then
		warn(("[ReceiptRouter] %s failed for %s: %s"):format(product.Name, recipient.Name, tostring(granted)))
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end
	if not granted then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	if options.SaveNow then
		task.spawn(options.SaveNow, buyer)
		if recipient ~= buyer then
			task.spawn(options.SaveNow, recipient)
		end
	end
	if isGift then
		notify(buyer, "GiftSent", product.Name, recipient)
		notify(recipient, "GiftReceived", product.Name, buyer)
	else
		notify(buyer, "Purchased", product.Name)
	end
	return Enum.ProductPurchaseDecision.PurchaseGranted
end

------------------------------------------------------------------------
-- Public API
------------------------------------------------------------------------

function ReceiptRouter.Init(opts)
	assert(type(opts) == "table" and type(opts.GetData) == "function", "ReceiptRouter.Init needs GetData")
	options = opts
	MarketplaceService.ProcessReceipt = processReceipt
	Players.PlayerRemoving:Connect(function(player)
		giftTargets[player] = nil
		lastPrompt[player] = nil
	end)
end

-- grant(player, data, receipt) -> boolean ; canBuy(player, data) -> (boolean, reason?)
function ReceiptRouter.Register(productId, name, grant, canBuy)
	assert(products[productId] == nil, "Product registered twice: " .. tostring(productId))
	products[productId] = { Name = name, Grant = grant, CanBuy = canBuy }
end

function ReceiptRouter.RegisterGift(giftProductId, baseProductId)
	assert(products[baseProductId], "Register the base product before its gift version")
	giftToBase[giftProductId] = baseProductId
end

-- Call from a RemoteEvent before the client prompts a gift product.
function ReceiptRouter.SetGiftTarget(buyer, targetUserId)
	if type(targetUserId) ~= "number" or targetUserId == buyer.UserId then
		return false
	end
	if not Players:GetPlayerByUserId(targetUserId) then
		return false
	end
	giftTargets[buyer] = { UserId = targetUserId, At = os.time() }
	return true
end

-- Returns (allowed, reason). Checks the RECIPIENT for gifts when a target is set.
function ReceiptRouter.CanBuy(player, productId)
	local baseId = giftToBase[productId]
	local product = products[baseId or productId]
	if not product then
		return false, "Unknown product."
	end
	local who = player
	if baseId and giftTargets[player] then
		who = Players:GetPlayerByUserId(giftTargets[player].UserId) or player
	end
	local data = options.GetData(who)
	if not data then
		return false, "Data is still loading."
	end
	if product.CanBuy then
		local ok, allowed, reason = pcall(product.CanBuy, who, data)
		if not ok or not allowed then
			return false, reason or "You can't buy this right now."
		end
	end
	return true
end

-- Server-side prompt with a pre-check and a short cooldown. Returns (prompted, reason).
function ReceiptRouter.Prompt(player, productId)
	if type(productId) ~= "number" then
		return false, "Invalid product."
	end
	local now = os.clock()
	if now - (lastPrompt[player] or 0) < PROMPT_COOLDOWN then
		return false, "Please wait a moment."
	end
	local allowed, reason = ReceiptRouter.CanBuy(player, productId)
	if not allowed then
		return false, reason
	end
	lastPrompt[player] = now
	local ok = pcall(MarketplaceService.PromptProductPurchase, MarketplaceService, player, productId)
	return ok, if ok then nil else "Could not open the purchase prompt."
end

return ReceiptRouter
