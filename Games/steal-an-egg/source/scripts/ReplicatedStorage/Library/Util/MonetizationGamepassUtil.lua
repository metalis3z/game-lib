-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Gamepasses = require(ReplicatedStorage.Directory.Gamepasses)
local Products = require(ReplicatedStorage.Directory.Products)
local GetPrice = require(ReplicatedStorage.Library.Functions.GetPrice)

require(ReplicatedStorage.Library.Types.Monetization)

local ProductCache = require(ReplicatedStorage.Library.Functions.ProductCache)
local X2Money = Gamepasses.Directory.X2Money
local X2Growth = Gamepasses.Directory.X2Growth
local Lucky = Gamepasses.Directory.Lucky
local v1 = table.freeze({
	[X2Money._id] = true
})
local v2 = table.freeze({
	[Lucky._id] = true
})
local v3 = table.freeze({
	[X2Money._id] = true,
	[Lucky._id] = true
})
local t = {
	SPENDER_TYPES_ENUM = table.freeze({
		MONETIZATION_PROFILE_NON_SPENDER = "NonSpender",
		MONETIZATION_PROFILE_AVATAR_VALUE_ONLY = "AvatarValueOnly",
		MONETIZATION_PROFILE_SPENT_ROBUX = "SpentRobux"
	})
}

local function normalizeRobuxSpentTotal(p1) --[[ normalizeRobuxSpentTotal | Line: 61 ]]
	if typeof(p1) == "number" then
		return math.max(math.floor(p1), 0)
	end

	return 0
end

local function ownsGamepass(p1, p2) --[[ ownsGamepass | Line: 69 ]]
	if typeof(p1) ~= "table" then
		return false
	end

	return p1[p2] == true
end

local function ownsProduct(p1, p2) --[[ ownsProduct | Line: 77 ]]
	if typeof(p1) ~= "table" then
		return false
	end

	return p1[tostring(p2)] == true
end

local function hasOwnedAttribute(p1, p2) --[[ hasOwnedAttribute | Line: 85 | Upvalues: Asserts (copy) ]]
	Asserts.Player(p1)
	Asserts.string(p2)

	return p1:GetAttribute(p2) == true
end

function t.SyncPlayerAttributes(p1, p2, p3, p4) --[[ SyncPlayerAttributes | Line: 96 | Upvalues: Asserts (copy), X2Money (copy), Lucky (copy), t (copy) ]]
	Asserts.Player(p1)
	p1:SetAttribute("MonetizationX2MoneyGamepassOwned", if typeof(p2) == "table" then if p2[X2Money._id] == true then true else false else false)
	p1:SetAttribute("MonetizationLuckyGamepassOwned", if typeof(p2) == "table" then if p2[Lucky._id] == true then true else false else false)
	p1:SetAttribute("MonetizationRobuxSpentTotal", t.GetEffectiveRobuxSpentTotal(p2, p3, p4))
end
function t.OwnsX2Money(p1) --[[ OwnsX2Money | Line: 112 | Upvalues: X2Money (copy) ]]
	if typeof(p1) ~= "table" then
		return false
	end

	return p1[X2Money._id] == true
end
function t.OwnsX2Growth(p1) --[[ OwnsX2Growth | Line: 116 | Upvalues: X2Growth (copy) ]]
	if typeof(p1) ~= "table" then
		return false
	end

	return p1[X2Growth._id] == true
end
function t.OwnsLucky(p1) --[[ OwnsLucky | Line: 120 | Upvalues: Lucky (copy) ]]
	if typeof(p1) ~= "table" then
		return false
	end

	return p1[Lucky._id] == true
end
function t.OwnsVipProduct(p1) --[[ OwnsVipProduct | Line: 124 ]]
	return false
end
function t.PlayerOwnsX2Money(p1) --[[ PlayerOwnsX2Money | Line: 128 | Upvalues: Asserts (copy) ]]
	Asserts.Player(p1)
	Asserts.string("MonetizationX2MoneyGamepassOwned")

	return p1:GetAttribute("MonetizationX2MoneyGamepassOwned") == true
end
function t.PlayerOwnsLucky(p1) --[[ PlayerOwnsLucky | Line: 132 | Upvalues: Asserts (copy) ]]
	Asserts.Player(p1)
	Asserts.string("MonetizationLuckyGamepassOwned")

	return p1:GetAttribute("MonetizationLuckyGamepassOwned") == true
end
function t.PlayerOwnsVipProduct(p1) --[[ PlayerOwnsVipProduct | Line: 136 ]]
	return false
end
function t.NormalizeRobuxSpentTotal(p1) --[[ NormalizeRobuxSpentTotal | Line: 140 ]]
	if typeof(p1) == "number" then
		return math.max(math.floor(p1), 0)
	end

	return 0
end
function t.GetProductPriceInRobux(p1) --[[ GetProductPriceInRobux | Line: 144 | Upvalues: Asserts (copy), GetPrice (copy) ]]
	Asserts.number(p1)

	local v1, v2 = GetPrice(p1, true)

	if not v2 then
		return 0
	end

	if typeof(v1) == "number" then
		return math.max(math.floor(v1), 0)
	end

	return 0
end
function t.GetGamepassPriceInRobux(p1) --[[ GetGamepassPriceInRobux | Line: 155 | Upvalues: Asserts (copy), GetPrice (copy) ]]
	Asserts.number(p1)

	local v1, v2 = GetPrice(p1, false)

	if not v2 then
		return 0
	end

	if typeof(v1) == "number" then
		return math.max(math.floor(v1), 0)
	end

	return 0
end
function t.GetMarketplaceItemPriceInRobux(p1, p2) --[[ GetMarketplaceItemPriceInRobux | Line: 166 | Upvalues: Asserts (copy), ProductCache (copy) ]]
	Asserts.number(p1)

	local v1, v2 = ProductCache.getProductInfo(p1, p2)

	if not v2 then
		return 0
	end

	local Info = v1.Info

	if typeof(Info) ~= "table" then
		return 0
	end

	local PriceInRobux = Info.PriceInRobux

	if typeof(PriceInRobux) == "number" then
		return math.max(math.floor(PriceInRobux), 0)
	end

	return 0
end
function t.GetAvatarAssetPriceInRobux(p1) --[[ GetAvatarAssetPriceInRobux | Line: 182 | Upvalues: t (copy) ]]
	return t.GetMarketplaceItemPriceInRobux(p1, Enum.InfoType.Asset)
end
function t.GetAvatarBundlePriceInRobux(p1) --[[ GetAvatarBundlePriceInRobux | Line: 186 | Upvalues: t (copy) ]]
	return t.GetMarketplaceItemPriceInRobux(p1, Enum.InfoType.Bundle)
end
function t.ComputeOwnedRobuxSpentTotal(p1, p2) --[[ ComputeOwnedRobuxSpentTotal | Line: 190 | Upvalues: Gamepasses (copy), t (copy), Products (copy) ]]
	local sum = 0

	if typeof(p1) == "table" then
		for k, v in pairs(Gamepasses.Directory) do
			if if typeof(p1) == "table" then if p1[v._id] == true then true else false else false then
				sum = sum + t.GetGamepassPriceInRobux(v.ProductId)
			end
		end
	end

	if typeof(p2) == "table" then
		for k, v in pairs(Products.Directory) do
			if if typeof(p2) == "table" then if p2[tostring(v.ProductId)] == true then true else false else false then
				sum = sum + t.GetProductPriceInRobux(v.ProductId)
			end
		end
	end

	return sum
end
function t.GetEffectiveRobuxSpentTotal(p1, p2, p3) --[[ GetEffectiveRobuxSpentTotal | Line: 215 | Upvalues: t (copy) ]]
	local v1 = if typeof(p3) == "number" then math.max(math.floor(p3), 0) else 0

	if v1 > 0 then
		return v1
	end

	return t.ComputeOwnedRobuxSpentTotal(p1, p2)
end
function t.HasSpentRobux(p1) --[[ HasSpentRobux | Line: 228 ]]
	return (if typeof(p1) == "number" then math.max(math.floor(p1), 0) else 0) > 0
end
function t.GetPlayerRobuxSpentTotal(p1) --[[ GetPlayerRobuxSpentTotal | Line: 232 | Upvalues: Asserts (copy) ]]
	Asserts.Player(p1)

	local v1 = p1:GetAttribute("MonetizationRobuxSpentTotal")
	local v2 = if typeof(v1) == "number" then v1 else nil

	if typeof(v2) == "number" then
		return math.max(math.floor(v2), 0)
	end

	return 0
end
function t.PlayerHasSpentRobux(p1) --[[ PlayerHasSpentRobux | Line: 239 | Upvalues: t (copy) ]]
	return t.GetPlayerRobuxSpentTotal(p1) > 0
end
function t.SyncPlayerAvatarMarketplaceValueAttribute(p1, p2) --[[ SyncPlayerAvatarMarketplaceValueAttribute | Line: 243 | Upvalues: Asserts (copy) ]]
	Asserts.Player(p1)
	p1:SetAttribute("MonetizationAvatarMarketplaceValue", if typeof(p2) == "number" then math.max(math.floor(p2), 0) else 0)
end
function t.GetPlayerAvatarMarketplaceValue(p1) --[[ GetPlayerAvatarMarketplaceValue | Line: 252 | Upvalues: Asserts (copy) ]]
	Asserts.Player(p1)

	local v1 = p1:GetAttribute("MonetizationAvatarMarketplaceValue")
	local v2 = if typeof(v1) == "number" then v1 else nil

	if typeof(v2) == "number" then
		return math.max(math.floor(v2), 0)
	end

	return 0
end
function t.PlayerHasPositiveAvatarMarketplaceValue(p1) --[[ PlayerHasPositiveAvatarMarketplaceValue | Line: 259 | Upvalues: t (copy) ]]
	return t.GetPlayerAvatarMarketplaceValue(p1) > 0
end
function t.GetMonetizationProfile(p1, p2) --[[ GetMonetizationProfile | Line: 263 | Upvalues: t (copy) ]]
	local v1 = if typeof(p1) == "number" then math.max(math.floor(p1), 0) else 0

	if (if typeof(p2) == "number" then math.max(math.floor(p2), 0) else 0) > 0 then
		return t.SPENDER_TYPES_ENUM.MONETIZATION_PROFILE_SPENT_ROBUX
	end

	if v1 > 0 then
		return t.SPENDER_TYPES_ENUM.MONETIZATION_PROFILE_AVATAR_VALUE_ONLY
	end

	return t.SPENDER_TYPES_ENUM.MONETIZATION_PROFILE_NON_SPENDER
end
function t.GetPlayerMonetizationProfile(p1) --[[ GetPlayerMonetizationProfile | Line: 280 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.Player(p1)

	return t.GetMonetizationProfile(t.GetPlayerAvatarMarketplaceValue(p1), t.GetPlayerRobuxSpentTotal(p1))
end
function t.PlayerPassesStealTakeBackMonetizationGate(p1) --[[ PlayerPassesStealTakeBackMonetizationGate | Line: 289 | Upvalues: t (copy) ]]
	local isNotMONETIZATION_PROFILE_NON_SPENDER = t.GetPlayerMonetizationProfile(p1) ~= t.SPENDER_TYPES_ENUM.MONETIZATION_PROFILE_NON_SPENDER

	return isNotMONETIZATION_PROFILE_NON_SPENDER
end
function t.GetAssetMoneyAdditiveRebirthBonus(p1, p2) --[[ GetAssetMoneyAdditiveRebirthBonus | Line: 294 | Upvalues: t (copy) ]]
	local count = 0

	if t.OwnsX2Money(p1) then
		count = count + 1
	end

	return count
end
function t.GetAssetMoneyAdditiveRebirthBonusFromPlayer(p1) --[[ GetAssetMoneyAdditiveRebirthBonusFromPlayer | Line: 307 | Upvalues: t (copy) ]]
	local count = 0

	if t.PlayerOwnsX2Money(p1) then
		count = count + 1
	end

	return count
end
function t.GetGameplayBlockLuckPercent(p1) --[[ GetGameplayBlockLuckPercent | Line: 317 | Upvalues: t (copy) ]]
	if t.OwnsLucky(p1) then
		return 10
	end

	return 0
end
function t.GetGameplayBlockLuckPercentFromPlayer(p1) --[[ GetGameplayBlockLuckPercentFromPlayer | Line: 325 | Upvalues: t (copy) ]]
	if t.PlayerOwnsLucky(p1) then
		return 10
	end

	return 0
end
function t.GetFuseRarestWeightMultiplier(p1) --[[ GetFuseRarestWeightMultiplier | Line: 333 | Upvalues: t (copy) ]]
	if t.OwnsLucky(p1) then
		return 1.1
	end

	return 1
end
function t.GetFuseRarestWeightMultiplierFromPlayer(p1) --[[ GetFuseRarestWeightMultiplierFromPlayer | Line: 341 | Upvalues: t (copy) ]]
	if t.PlayerOwnsLucky(p1) then
		return 1.1
	end

	return 1
end
function t.BuildOwnedGamepassesFromPlayer(p1) --[[ BuildOwnedGamepassesFromPlayer | Line: 349 | Upvalues: Asserts (copy), t (copy), v3 (copy), v1 (copy), v2 (copy) ]]
	Asserts.Player(p1)

	local v12 = t.PlayerOwnsX2Money(p1)
	local v22 = t.PlayerOwnsLucky(p1)

	if v12 and v22 then
		return v3
	end

	if v12 then
		return v1
	end

	if v22 then
		return v2
	end

	return nil
end
function t.BuildOwnedProductsFromPlayer(p1) --[[ BuildOwnedProductsFromPlayer | Line: 370 | Upvalues: Asserts (copy) ]]
	Asserts.Player(p1)

	return nil
end

return t