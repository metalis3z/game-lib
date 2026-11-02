--credit to quartz games studio
local NormalShop = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("SeedShop"):WaitForChild("Frame"):WaitForChild("NormalShop")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SeedData = require(ReplicatedStorage.SharedModules.SeedData)
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local RestockStoreController = require(ReplicatedStorage.ClientModules.RestockStoreController)
local SeedShopFlags = require(ReplicatedStorage.SharedModules.Flags.SeedShopFlags)
local t = {}

for i, v in ipairs(SeedData) do
	if v.RestockShop then
		table.insert(t, v)
	end
end

table.sort(t, function(p1, p2) --[[ Line: 18 ]]
	return p1.SeedShopDisplayOrder < p2.SeedShopDisplayOrder
end)
RestockStoreController.Init({
	shopName = "SeedShop",
	purchasedRestockKey = "Seeds",
	devProductPrefix = "Seed",
	requireRarity = true,
	scrollingFrame = NormalShop,
	stockItems = ReplicatedStorage.StockValues.SeedShop.Items,
	purchaseEvent = Networking.SeedShop.PurchaseSeed,
	personalRestockEvent = Networking.SeedShop.PersonalRestock,
	items = t,
	priceOverrides = SeedShopFlags.PriceOverrides,
	getItemName = function(p1) --[[ getItemName | Line: 33 ]]
		return p1.SeedName
	end,
	getItemImage = function(p1) --[[ getItemImage | Line: 34 ]]
		return p1.SeedImage and p1.SeedImage.Value
	end,
	getItemCost = function(p1) --[[ getItemCost | Line: 35 ]]
		return p1.PurchasePrice
	end,
	getItemRarity = function(p1) --[[ getItemRarity | Line: 36 ]]
		return p1.Rarity
	end
})