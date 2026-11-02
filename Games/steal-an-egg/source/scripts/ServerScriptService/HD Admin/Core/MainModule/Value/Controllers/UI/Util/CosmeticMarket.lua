--!strict
-- LOCAL
local MarketplaceService = game:GetService("MarketplaceService")
local AvatarEditorService = game:GetService("AvatarEditorService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local Fusion = require(packages.Fusion)
local Prompt = require(modules.Prompt)
local promptPurchaseAsync = require(modules.AssetUtil.promptPurchaseAsync)
local promptSetFavoriteAsync = require(modules.AssetUtil.promptSetFavoriteAsync)

-- These persist across page opens so reopened tiles show instantly. Favourites live
-- on the Roblox account rather than our datastore, so we read them back from Roblox
local priceCache: {[number]: number} = {}
local favouriteCache: {[number]: boolean} = {}


-- FUNCTIONS
local CosmeticMarket = {}

function CosmeticMarket.peekPrice(id: number): number
	return priceCache[id] or 0
end

function CosmeticMarket.peekFavourite(id: number): boolean
	return favouriteCache[id] or false
end

function CosmeticMarket.buy(id: number)
	task.spawn(function()
		local success, warning = promptPurchaseAsync(id)
		if not success and typeof(warning) == "string" and warning ~= "" then
			Prompt.warn(warning)
		end
	end)
end

function CosmeticMarket.notifyComingSoon()
	Prompt.info("Coming soon. Please try again later.")
end

function CosmeticMarket.seedFavourite(id: number, favourited: Fusion.Value<boolean>?)
	if favouriteCache[id] ~= nil then
		if favourited then
			favourited:set(favouriteCache[id])
		end
		return
	end
	task.spawn(function()
		local ok, isFavourited = pcall(function()
			return AvatarEditorService:GetFavorite(id, Enum.AvatarItemType.Asset)
		end)
		-- A toggle may have filled the cache while we were querying, so don't clobber it
		if ok and favouriteCache[id] == nil then
			favouriteCache[id] = isFavourited == true
			if favourited then
				favourited:set(isFavourited == true)
			end
		end
	end)
end

-- Runs inside the star's loading wrapper, so yielding on the prompt is fine
function CosmeticMarket.toggleFavourite(id: number, favourited: Fusion.Value<boolean>)
	local target = not Fusion.peek(favourited)
	local confirmed = promptSetFavoriteAsync(id, target)
	if confirmed then
		favouriteCache[id] = target
		favourited:set(target)
	end
end

function CosmeticMarket.seedPrice(id: number, price: Fusion.Value<number>?)
	if priceCache[id] ~= nil then
		if price then
			price:set(priceCache[id])
		end
		return
	end
	task.spawn(function()
		local ok, info = pcall(function()
			return MarketplaceService:GetProductInfo(id, Enum.InfoType.Asset)
		end)
		if ok and typeof(info) == "table" then
			local amount = (info :: any).PriceInRobux or 0
			priceCache[id] = amount
			if price then
				price:set(amount)
			end
		end
	end)
end


return CosmeticMarket