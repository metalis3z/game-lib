--!strict
-- LOCATION: ReplicatedStorage/Modules/ProductConfigurations

local ProductConfigurations = {}

ProductConfigurations.Products = {
	["SkipRebirth"] = 3535477160,
	["RandomItem"] = 3541134967,
	["Revive"] = 3544743480,

	["ItemProduct1"] = 3507422194,
	["ItemProduct2"] = 3507422461,
	["ItemProduct3"] = 3507422665,

	["CashProduct1"] = 3507413234,
	["CashProduct2"] = 3507413478,
	["CashProduct3"] = 3507414088,

	["SpinsX3"] = 3544825393,
	["SpinsX9"] = 3544825505,

	["DoubleOffline"] = 3576736118,
}

ProductConfigurations.GamePasses = {
	["VIP"] = 1664438543,
	["StarterPack"] = 1664754284,
	["ProPack"] = 1664576483,
}

ProductConfigurations.PackRewards = {
	["StarterPack"] = {
		Money = 5000,
		Items = {
			{Name = "SWAGGY BROS", Mutation = "Normal", Level = 1},
			{Name = "SWAG SODA", Mutation = "Normal", Level = 1}
		}
	},
	["ProPack"] = {
		Money = 50000,
		Items = {
			{Name = "Stoppo Luminino", Mutation = "Normal", Level = 1},
			{Name = "Spaghetti Tualetti", Mutation = "Normal", Level = 1}
		}
	}
}

ProductConfigurations.ItemProductRewards = {
	["ItemProduct1"] = {Name = "Smurf Cat", Mutation = "Normal", Level = 1},
	["ItemProduct2"] = {Name = "Skibidi Toilet", Mutation = "Normal", Level = 1},
	["ItemProduct3"] = {Name = "Rinooccio Verdini", Mutation = "Normal", Level = 1},
}

ProductConfigurations.CashProductRewards = {
	["CashProduct1"] = 10000,
	["CashProduct2"] = 100000,
	["CashProduct3"] = 1000000,
}

ProductConfigurations.LimitedItem = {
	ProductId = 3576746061,
	MaxStock = 999,
	StockKey = "LimitedItem01",
	Reward = {
		Name = "Strawberry Elephant",
		Mutation = "Normal",
		Level = 1
	}
}

-- Helper to find name by ID
function ProductConfigurations.GetProductById(id: number)
	for name, productId in pairs(ProductConfigurations.Products) do
		if productId == id then return name end
	end

	if ProductConfigurations.LimitedItem and id == ProductConfigurations.LimitedItem.ProductId then
		return "LimitedItem"
	end

	return nil
end

function ProductConfigurations.GetGamePassById(id: number)
	for name, passId in pairs(ProductConfigurations.GamePasses) do
		if passId == id then return name end
	end
	return nil
end

return ProductConfigurations