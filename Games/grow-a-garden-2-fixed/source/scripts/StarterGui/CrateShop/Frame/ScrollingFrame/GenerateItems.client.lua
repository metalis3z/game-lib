--credit to leon games studio
local ScrollingFrame = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("CrateShop"):WaitForChild("Frame"):WaitForChild("ScrollingFrame")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CrateData = require(ReplicatedStorage.SharedModules.CrateData)
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local RestockStoreController = require(ReplicatedStorage.ClientModules.RestockStoreController)
local CrateShopFlags = require(ReplicatedStorage.SharedModules.Flags.CrateShopFlags)
local t = {}
local t2 = {
	Common = 1,
	Uncommon = 2,
	Rare = 3,
	Epic = 4,
	Legendary = 5,
	Mythic = 6,
	Super = 7
}

for v1, v2 in CrateData.GetAllCrates() do
	if v2.RestockChance then
		table.insert(t, v2)
	end
end

table.sort(t, function(p1, p2) --[[ Line: 28 | Upvalues: t2 (copy) ]]
	local v1 = t2[p1.Rarity] or 0
	local v2 = t2[p2.Rarity] or 0

	if v1 == v2 then
		return (p1.RestockChance or 0) > (p2.RestockChance or 0)
	end

	return v1 < v2
end)
RestockStoreController.Init({
	shopName = "CrateShop",
	purchasedRestockKey = "Crates",
	devProductPrefix = "Crate",
	scrollingFrame = ScrollingFrame,
	stockItems = ReplicatedStorage.StockValues.CrateShop.Items,
	purchaseEvent = Networking.CrateShop.PurchaseCrate,
	personalRestockEvent = Networking.CrateShop.PersonalRestock,
	items = t,
	priceOverrides = CrateShopFlags.PriceOverrides,
	getItemName = function(p1) --[[ getItemName | Line: 48 ]]
		return p1.Name
	end,
	getItemImage = function(p1) --[[ getItemImage | Line: 49 ]]
		return p1.IMG
	end,
	getItemCost = function(p1) --[[ getItemCost | Line: 50 ]]
		return p1.Cost or 0
	end,
	getItemRarity = function(p1) --[[ getItemRarity | Line: 51 ]]
		return p1.Rarity
	end
})