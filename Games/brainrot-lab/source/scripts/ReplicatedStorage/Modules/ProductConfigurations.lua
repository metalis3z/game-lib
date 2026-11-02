--!strict
-- LOCATION: ReplicatedStorage/Modules/ProductConfigurations

local ProductConfigurations = {}

ProductConfigurations.Products = {
	["SkipRebirth"] = 3708461216,
	["RandomItem"] = 3708461275,
	["Revive"] = 3708461298,

	["ItemProduct1"] = 3708461330,
	["ItemProduct2"] = 3708461364,
	["ItemProduct3"] = 3708461383,

	["CashProduct1"] = 3708461424,
	["CashProduct2"] = 3708461465,
	["CashProduct3"] = 3708461501,

	["SpinsX3"] = 3544825393,
	["SpinsX9"] = 3544825505,

	["DoubleOffline"] = 3708461588,
}

ProductConfigurations.GamePasses = {
	["VIP"] = 1949637295,
	["StarterPack"] = 1948551326,
	["ProPack"] = 1947927292,
}

ProductConfigurations.PackRewards = {
	["StarterPack"] = {
		Money = 5000,
		Items = {
			{Name = "BombombiniGusini", Mutation = "Normal", Level = 50},
			{Name = "CappuccinoAssassino", Mutation = "Normal", Level = 50}
		}
	},
	["ProPack"] = {
		Money = 50000,
		Items = {
			{Name = "TricTracBarabum", Mutation = "Normal", Level = 100},
			{Name = "TrippiTroppi", Mutation = "Normal", Level = 100}
		}
	}
}

ProductConfigurations.ItemProductRewards = {
	["ItemProduct1"] = {Name = "SmurfCat", Mutation = "Normal", Level = 25},
	["ItemProduct2"] = {Name = "TralaleroTralala", Mutation = "Normal", Level = 50},
	["ItemProduct3"] = {Name = "StrawberryElephant", Mutation = "Normal", Level = 100},
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
		Name = "StrawberryElephant",
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