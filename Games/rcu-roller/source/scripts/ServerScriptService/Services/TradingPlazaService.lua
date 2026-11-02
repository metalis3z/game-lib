local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
local Players = game:GetService("Players")

local TradingPlazaService = Knit.CreateService({
	Name = "TradingPlazaService",
	Client = {
		boothClaimed  = Knit.CreateSignal(),
		boothRemoved  = Knit.CreateSignal(),
		boothChanged  = Knit.CreateSignal(),
		offerCreated  = Knit.CreateSignal(),
		offerRemoved  = Knit.CreateSignal(),
		teleportToBooth = Knit.CreateSignal(),
	},
})

-- State
local booths        = {}   -- [boothId] = {ownerId, ownerName, boothSkin, offers={}}
local offers        = {}   -- [offerId]  = {boothId, sellerId, sellerName, itemData, price, slot}
local playerToBooth = {}   -- [userId]   = boothId
local nextOfferId   = 1
local MAX_OFFERS    = 6

-- ─────────────────────────── Helpers ──────────────────────────────────────

local function getBoothIds()
	local ids = {}
	local boothFolder = workspace:FindFirstChild("Booths")
	if boothFolder then
		for _, part in ipairs(boothFolder:GetChildren()) do
			table.insert(ids, part.Name)
		end
	end
	if #ids == 0 then
		for i = 1, 20 do
			table.insert(ids, "booth" .. i)
		end
	end
	return ids
end

local function findFreeBooth()
	for _, boothId in ipairs(getBoothIds()) do
		if not booths[boothId] then
			return boothId
		end
	end
	return nil
end

local function getExclusiveCount(data)
	local inv = data and data.inventory and data.inventory.exclusive
	if type(inv) ~= "table" then return 0 end
	local count = 0
	for _, _ in pairs(inv) do
		count += 1
	end
	return count
end

local function hasExclusiveItem(data, itemId)
	local inv = data and data.inventory and data.inventory.exclusive
	if type(inv) ~= "table" then return false end
	for _, item in pairs(inv) do
		if item.id == itemId or item == itemId then
			return true
		end
	end
	return false
end

local function removeExclusiveItem(data, itemId)
	local inv = data and data.inventory and data.inventory.exclusive
	if type(inv) ~= "table" then return false end
	for key, item in pairs(inv) do
		if item.id == itemId or item == itemId then
			inv[key] = nil
			return true
		end
	end
	return false
end

local function boothPublicData(boothId)
	local b = booths[boothId]
	if not b then return nil end
	local publicOffers = {}
	for offerId, offer in pairs(b.offers) do
		publicOffers[offerId] = {
			item         = offer.itemData,
			tokens       = offer.price,
			slot         = offer.slot,
			sellerName   = offer.sellerName,
		}
	end
	return {
		ownerDisplayName = b.ownerName,
		ownerUsername    = b.ownerName,
		ownerUserId      = b.ownerId,
		equippedBooth    = b.boothSkin,
		offers           = publicOffers,
	}
end

-- ─────────────────────────── Booth management ─────────────────────────────

function TradingPlazaService:ClaimBooth(player)
	local userId = player.UserId
	if playerToBooth[userId] then return playerToBooth[userId] end

	local boothId = findFreeBooth()
	if not boothId then return nil end

	local DataService = Knit.GetService("DataService")
	local data = DataService:GetData(player)
	local skin = data and data.boothSkin or "Default"

	booths[boothId] = {
		ownerId   = userId,
		ownerName = player.Name,
		boothSkin = skin,
		offers    = {},
	}
	playerToBooth[userId] = boothId

	local pub = boothPublicData(boothId)
	self.Client.boothClaimed:FireAll(boothId, pub)
	self.Client.teleportToBooth:Fire(player, boothId)

	return boothId
end

function TradingPlazaService:RemoveBooth(player)
	local userId = player.UserId
	local boothId = playerToBooth[userId]
	if not boothId then return end

	-- Clean global offers table
	local b = booths[boothId]
	if b then
		for offerId in pairs(b.offers) do
			offers[offerId] = nil
		end
	end

	booths[boothId] = nil
	playerToBooth[userId] = nil

	self.Client.boothRemoved:FireAll(boothId)
end

-- ─────────────────────────── Client RemoteFunctions ───────────────────────

function TradingPlazaService.Client:getAllBooths(_player)
	local result = {}
	for boothId in pairs(booths) do
		result[boothId] = boothPublicData(boothId)
	end
	return result
end

function TradingPlazaService.Client:getBoothData(_player, boothId)
	local b = booths[boothId]
	if not b then return "notFound", nil end
	return "success", boothPublicData(boothId)
end

function TradingPlazaService.Client:createOffer(player, itemId, price, slot)
	local userId = player.UserId
	local boothId = playerToBooth[userId]
	if not boothId then return "noBooth", nil end

	local b = booths[boothId]
	if not b then return "noBooth", nil end

	if #b.offers >= MAX_OFFERS then return "maxOffers", nil end

	price = tonumber(price)
	if not price or price <= 0 then return "invalidPrice", nil end

	local DataService = Knit.GetService("DataService")
	local data = DataService:GetData(player)
	if not hasExclusiveItem(data, itemId) then return "noItem", nil end

	-- Remove item from seller inventory immediately (held in escrow)
	removeExclusiveItem(data, itemId)

	local offerId = tostring(nextOfferId)
	nextOfferId += 1

	local offerData = {
		boothId    = boothId,
		sellerId   = userId,
		sellerName = player.Name,
		itemData   = { id = itemId },
		price      = price,
		slot       = slot,
	}

	offers[offerId]       = offerData
	b.offers[offerId]     = offerData

	self.Client.offerCreated:FireAll(boothId, offerId, {
		item       = offerData.itemData,
		tokens     = offerData.price,
		slot       = offerData.slot,
		sellerName = offerData.sellerName,
	})
	self.Client.boothChanged:FireAll(boothId, boothPublicData(boothId))

	return "success", offerId
end

function TradingPlazaService.Client:removeOffer(player, offerId)
	local offer = offers[offerId]
	if not offer then return "notFound" end
	if offer.sellerId ~= player.UserId then return "notFound" end

	-- Return item to seller
	local DataService = Knit.GetService("DataService")
	local sellerPlayer = Players:GetPlayerByUserId(offer.sellerId)
	if sellerPlayer then
		local data = DataService:GetData(sellerPlayer)
		if data and data.inventory and data.inventory.exclusive then
			local key = #data.inventory.exclusive + 1
			data.inventory.exclusive[key] = offer.itemData
		end
	end

	local boothId = offer.boothId
	local b = booths[boothId]
	if b then b.offers[offerId] = nil end
	offers[offerId] = nil

	self.Client.offerRemoved:FireAll(boothId, offerId, false)
	self.Client.boothChanged:FireAll(boothId, boothPublicData(boothId))

	return "success"
end

function TradingPlazaService.Client:purchaseOffer(player, offerId, boothId)
	local offer = offers[offerId]
	if not offer then return "offerNotFound", nil end
	if offer.boothId ~= boothId then return "offerNotFound", nil end
	if offer.sellerId == player.UserId then return "ownOffer", nil end

	local DataService = Knit.GetService("DataService")
	local buyerData = DataService:GetData(player)
	local exclusiveCount = getExclusiveCount(buyerData)

	if exclusiveCount < offer.price then
		return "notEnoughTokens", offer.price - exclusiveCount
	end

	-- Deduct tokens from buyer (remove N exclusive items as currency — adjust if tokens are numeric)
	local buyerTokens = buyerData and buyerData.exclusiveTokens
	if type(buyerTokens) == "number" then
		if buyerTokens < offer.price then
			return "notEnoughTokens", offer.price - buyerTokens
		end
		buyerData.exclusiveTokens -= offer.price
	end

	-- Give item to buyer
	if buyerData and buyerData.inventory and type(buyerData.inventory.exclusive) == "table" then
		local key = #buyerData.inventory.exclusive + 1
		buyerData.inventory.exclusive[key] = offer.itemData
	end

	-- Pay seller
	local sellerPlayer = Players:GetPlayerByUserId(offer.sellerId)
	if sellerPlayer then
		local sellerData = DataService:GetData(sellerPlayer)
		if sellerData then
			sellerData.exclusiveTokens = (sellerData.exclusiveTokens or 0) + offer.price
		end
	end

	-- Remove offer
	local b = booths[boothId]
	if b then b.offers[offerId] = nil end
	offers[offerId] = nil

	self.Client.offerRemoved:FireAll(boothId, offerId, true)
	self.Client.boothChanged:FireAll(boothId, boothPublicData(boothId))

	return "success", nil
end

-- ─────────────────────────── Lifecycle ────────────────────────────────────

function TradingPlazaService:KnitStart()
	if not workspace:GetAttribute("isTradingPlaza") then return end

	Players.PlayerAdded:Connect(function(player)
		self:ClaimBooth(player)
	end)

	Players.PlayerRemoving:Connect(function(player)
		self:RemoveBooth(player)
	end)

	-- Claim for any players already in the game
	for _, player in ipairs(Players:GetPlayers()) do
		self:ClaimBooth(player)
	end
end

return TradingPlazaService
