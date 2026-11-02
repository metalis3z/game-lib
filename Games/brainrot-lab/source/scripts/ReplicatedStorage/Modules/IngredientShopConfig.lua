--!strict
-- LOCATION: ReplicatedStorage/Modules/IngredientShopConfig

local IngredientShopConfig = {}

-- Refresh cycle: 20 minutes in seconds
IngredientShopConfig.RefreshInterval = 20 * 60

-- Number of item slots shown in the shop
IngredientShopConfig.Slots = 7

-- Rarity weights (higher = more common). Tune to adjust difficulty.
IngredientShopConfig.RarityWeights = {
	Common = 50,
	Uncommon = 30,
	Rare = 15,
	Epic = 5,
}

-- Ingredient definitions: name -> { Rarity, Price, RobuxPrice, ProductId }
-- ProductId: ID do Developer Product no Creator Hub para compra com Robux.
-- Troque o 0 pelo ID real assim que criar o produto no Creator Hub.
IngredientShopConfig.Ingredients = {
	["Ice Emblem"] = { Rarity = "Common", Price = 100, RobuxPrice = 10, ProductId = 0 },
	["Flower"] = { Rarity = "Common", Price = 150, RobuxPrice = 15, ProductId = 0 },
	["Lighter"] = { Rarity = "Uncommon", Price = 250, RobuxPrice = 25, ProductId = 0 },
	["Phone"] = { Rarity = "Uncommon", Price = 350, RobuxPrice = 35, ProductId = 0 },
	["Star"] = { Rarity = "Rare", Price = 500, RobuxPrice = 50, ProductId = 0 },
	["Taco"] = { Rarity = "Rare", Price = 650, RobuxPrice = 75, ProductId = 0 },
	["Victrola"] = { Rarity = "Epic", Price = 1000, RobuxPrice = 100, ProductId = 0 },
}

return IngredientShopConfig
