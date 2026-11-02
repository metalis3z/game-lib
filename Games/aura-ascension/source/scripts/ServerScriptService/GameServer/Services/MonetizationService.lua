local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MonetizationConfig = require(ReplicatedStorage:WaitForChild("Monetization"))
local MathUtility = require(ReplicatedStorage:WaitForChild("Math Utility"))

local FIRST_FREE_REBIRTH_PACK_INDEX = 1
local FIRST_FREE_REBIRTH_PACK_COOLDOWN_SECONDS = tonumber(MonetizationConfig.FirstFreeRebirthPackCooldownSeconds) or 45 * 60
local FREE_AURA_BOOST_PLAYTIME_REQUIREMENTS = MonetizationConfig.FreeAuraBoostPlaytimeRequirements or {
	[1] = 90 * 60,
	[2] = 180 * 60,
	[3] = 270 * 60,
}

local function normalizeBig(value)
	return MathUtility.Normalize(value) or MathUtility.Zero()
end

local function floorBig(value)
	return MathUtility.Floor(value) or MathUtility.Zero()
end

local function addBig(left, right)
	return MathUtility.Add(left, right) or normalizeBig(left)
end

local function isPositiveBig(value)
	return (MathUtility.Compare(value, MathUtility.Zero()) or 0) > 0
end

local MonetizationService = {}
MonetizationService.__index = MonetizationService

function MonetizationService.new()
	return setmetatable({
		AuraBoostProducts = {},
		RebirthPackProducts = {},
	}, MonetizationService)
end

function MonetizationService:Init(registry)
	self.Registry = registry
	self.DataService = registry:Get("DataService")
	self.RemoteBinder = registry:Get("RemoteBinder")

	for index, product in pairs(MonetizationConfig.Products.AuraBoosts or {}) do
		if type(product) == "table" and type(product.Id) == "number" then
			self.AuraBoostProducts[product.Id] = {
				Index = index,
				Boost = tonumber(product.Boost) or 1,
				Id = product.Id,
			}
		end
	end

	for index, product in pairs(MonetizationConfig.Products.RebirthPacks or {}) do
		if type(product) == "table" and type(product.Id) == "number" then
			self.RebirthPackProducts[product.Id] = {
				Index = index,
				Id = product.Id,
			}
		end
	end

	self.RemoteBinder:BindFunction("MonetizationService", "ClaimFreeFirstRebirthPack", function(player)
		return self:ClaimFreeFirstRebirthPack(player)
	end)
	self.RemoteBinder:BindFunction("MonetizationService", "ClaimFreeAuraBoost", function(player, productId)
		return self:ClaimFreeAuraBoost(player, productId)
	end)
end

function MonetizationService:_getProfile(player)
	return self.DataService:GetProfile(player) or self.DataService:WaitForProfile(player, 10)
end

function MonetizationService:GetAuraBoost(player)
	local profile = self:_getProfile(player)
	if not profile then
		return 1
	end
	return math.max(1, tonumber(profile.Monetization.AuraBoost) or 1)
end

function MonetizationService:GetAuraMultiplier(player)
	return self:GetAuraBoost(player)
end

function MonetizationService:_fireProductPurchased(player, payload)
	self.Registry:Get("LegacyBridgeService"):HandleProductPurchased(player, payload)
end

function MonetizationService:_getFirstFreePackProduct()
	return MonetizationConfig.Products.RebirthPacks and MonetizationConfig.Products.RebirthPacks[FIRST_FREE_REBIRTH_PACK_INDEX]
end

function MonetizationService:_getFirstFreePackReadyAt(profile)
	local readyAt = tonumber(profile.Cooldowns.FirstFreeRebirthPackReadyAtPlaytime) or 0
	local firstProduct = self:_getFirstFreePackProduct()
	local buyKey = firstProduct and tostring(firstProduct.Id) or ""
	local claimedCount = tonumber(profile.Monetization.RebirthPackBuys[buyKey]) or 0
	if claimedCount <= 0 and readyAt <= 0 then
		readyAt = FIRST_FREE_REBIRTH_PACK_COOLDOWN_SECONDS
	end
	return readyAt
end

function MonetizationService:_getNextAuraBoostProduct(profile)
	local currentBoost = math.max(1, tonumber(profile.Monetization.AuraBoost) or 1)
	local products = MonetizationConfig.Products.AuraBoosts or {}
	local bestProduct = nil
	local bestIndex = nil
	for index, product in pairs(products) do
		local boostValue = type(product) == "table" and tonumber(product.Boost) or nil
		if boostValue and boostValue > currentBoost then
			if not bestProduct or boostValue < (tonumber(bestProduct.Boost) or math.huge) then
				bestProduct = product
				bestIndex = index
			end
		end
	end
	return bestIndex, bestProduct, currentBoost
end

function MonetizationService:_getFreeAuraBoostRequirement(index)
	return FREE_AURA_BOOST_PLAYTIME_REQUIREMENTS[index]
end

function MonetizationService:GetFreeAuraBoostState(player)
	local profile = self:_getProfile(player)
	if not profile then
		return {
			ok = false,
			reason = "PROFILE_NOT_READY",
			ready = false,
		}
	end
	local index, product, currentBoost = self:_getNextAuraBoostProduct(profile)
	if not index or not product then
		return {
			ok = true,
			ready = false,
			claimable = false,
			currentBoost = currentBoost,
		}
	end
	local requirement = self:_getFreeAuraBoostRequirement(index)
	local timePlayed = tonumber(profile.Stats.TimePlayed) or 0
	if not requirement then
		return {
			ok = true,
			ready = false,
			claimable = false,
			currentBoost = currentBoost,
			productId = product.Id,
			index = index,
		}
	end
	local remaining = math.max(0, requirement - timePlayed)
	return {
		ok = true,
		ready = remaining <= 0,
		claimable = true,
		remaining = remaining,
		requiredPlaytime = requirement,
		timePlayed = timePlayed,
		currentBoost = currentBoost,
		productId = product.Id,
		index = index,
		boost = tonumber(product.Boost) or currentBoost,
	}
end

function MonetizationService:GrantAuraBoostByProductId(player, productId)
	local product = self.AuraBoostProducts[productId]
	if not product then
		return false
	end
	if FREE_AURA_BOOST_PLAYTIME_REQUIREMENTS[product.Index] then
		return false
	end

	local profile = self:_getProfile(player)
	if not profile then
		return false
	end

	local currentBoost = math.max(1, tonumber(profile.Monetization.AuraBoost) or 1)
	local newBoost = math.max(currentBoost, product.Boost)
	self.DataService:Mutate(player, function(data)
		data.Monetization.AuraBoost = newBoost
	end)
	self.Registry:Get("PlayerService"):SyncReplicatedState(player)
	self:_fireProductPurchased(player, {
		Type = "AuraBoost",
		ProductId = productId,
		Boost = newBoost,
	})
	return true
end

function MonetizationService:ClaimFreeAuraBoost(player, productId)
	local profile = self:_getProfile(player)
	if not profile then
		return { ok = false, reason = "PROFILE_NOT_READY" }
	end

	local index, product = self:_getNextAuraBoostProduct(profile)
	if not index or not product then
		return { ok = false, reason = "MAX_BOOST" }
	end
	if type(productId) == "number" and product.Id ~= productId then
		return { ok = false, reason = "INVALID_PRODUCT" }
	end
	local requirement = self:_getFreeAuraBoostRequirement(index)
	if not requirement then
		return { ok = false, reason = "NOT_FREE" }
	end

	local timePlayed = tonumber(profile.Stats.TimePlayed) or 0
	local remaining = math.max(0, requirement - timePlayed)
	if remaining > 0 then
		return {
			ok = false,
			reason = "COOLDOWN",
			remaining = remaining,
			requiredPlaytime = requirement,
		}
	end

	local newBoost = math.max(1, tonumber(product.Boost) or 1)
	self.DataService:Mutate(player, function(data)
		data.Monetization.AuraBoost = math.max(1, tonumber(data.Monetization.AuraBoost) or 1, newBoost)
	end)
	self.Registry:Get("PlayerService"):SyncReplicatedState(player)
	self:_fireProductPurchased(player, {
		Type = "AuraBoost",
		ProductId = product.Id,
		Boost = newBoost,
		FreeClaim = true,
	})
	return {
		ok = true,
		boost = newBoost,
		productId = product.Id,
	}
end

function MonetizationService:GrantRebirthPackByProductId(player, productId)
	local product = self.RebirthPackProducts[productId]
	if not product then
		return false
	end
	if product.Index == FIRST_FREE_REBIRTH_PACK_INDEX then
		return false
	end

	local profile = self:_getProfile(player)
	if not profile then
		return false
	end

	local currentRebirths = profile.Stats.Rebirths or 0
	local granted = floorBig(MonetizationConfig.GetRebirthPackAdd(product.Index, currentRebirths, player))
	if not isPositiveBig(granted) then
		return false
	end

	self.DataService:Mutate(player, function(data)
		local buyKey = tostring(productId)
		data.Stats.Rebirths = addBig(data.Stats.Rebirths or 0, granted)
		data.Monetization.RebirthPackBuys[buyKey] = (tonumber(data.Monetization.RebirthPackBuys[buyKey]) or 0) + 1
	end)
	self.Registry:Get("PlayerService"):SyncReplicatedState(player)
	self:_fireProductPurchased(player, {
		Type = "RebirthPack",
		ProductId = productId,
		AddedRebirths = granted,
	})
	return true
end

function MonetizationService:ClaimFreeFirstRebirthPack(player)
	local profile = self:_getProfile(player)
	local product = self:_getFirstFreePackProduct()
	if not profile or not product or type(product.Id) ~= "number" then
		return { ok = false, reason = "PROFILE_NOT_READY" }
	end

	local timePlayed = tonumber(profile.Stats.TimePlayed) or 0
	local readyAt = self:_getFirstFreePackReadyAt(profile)
	local remaining = math.max(0, readyAt - timePlayed)
	if remaining > 0 then
		return {
			ok = false,
			reason = "COOLDOWN",
			remaining = remaining,
			readyAt = readyAt,
		}
	end

	local currentRebirths = profile.Stats.Rebirths or 0
	local granted = floorBig(MonetizationConfig.GetRebirthPackAdd(FIRST_FREE_REBIRTH_PACK_INDEX, currentRebirths, player))
	if not isPositiveBig(granted) then
		return { ok = false, reason = "NO_REWARD" }
	end

	local nextReadyAt = timePlayed + FIRST_FREE_REBIRTH_PACK_COOLDOWN_SECONDS
	self.DataService:Mutate(player, function(data)
		local buyKey = tostring(product.Id)
		data.Stats.Rebirths = addBig(data.Stats.Rebirths or 0, granted)
		data.Monetization.RebirthPackBuys[buyKey] = (tonumber(data.Monetization.RebirthPackBuys[buyKey]) or 0) + 1
		data.Cooldowns.FirstFreeRebirthPackReadyAtPlaytime = nextReadyAt
	end)
	self.Registry:Get("PlayerService"):SyncReplicatedState(player)
	self:_fireProductPurchased(player, {
		Type = "RebirthPack",
		ProductId = product.Id,
		AddedRebirths = granted,
		FreeClaim = true,
	})
	return {
		ok = true,
		addedRebirths = granted,
		nextReadyAt = nextReadyAt,
		cooldown = FIRST_FREE_REBIRTH_PACK_COOLDOWN_SECONDS,
	}
end

return MonetizationService