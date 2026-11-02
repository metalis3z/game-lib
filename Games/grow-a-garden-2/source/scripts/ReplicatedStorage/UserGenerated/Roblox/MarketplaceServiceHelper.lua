--credit to quartz games studio
local MarketplaceService = game:GetService("MarketplaceService")
local Cache = require(game.ReplicatedStorage.UserGenerated.Concurrency.Cache)
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts)
local v1 = Asserts.TablePermissive({
	PurchaseId = Asserts.String,
	PlayerId = Asserts.Integer,
	ProductId = Asserts.Integer,
	PlaceIdWherePurchased = Asserts.Integer,
	CurrencySpent = Asserts.IntegerNonNegative,
	CurrencyType = Asserts.AnyOf(Asserts.Enum(Enum.CurrencyType), Asserts.String),
	ProductPurchaseChannel = Asserts.Enum(Enum.ProductPurchaseChannel)
})
local v2 = Asserts.Table({
	AssetId = Asserts.Integer,
	InfoType = Asserts.Enum(Enum.InfoType)
})
local v3 = Cache.new({
	Callback = function(p1) --[[ Callback | Line: 160 | Upvalues: MarketplaceService (copy) ]]
		return MarketplaceService:GetProductInfo(p1.AssetId, p1.InfoType)
	end,
	AssertKey = function(p1) --[[ AssertKey | Line: 163 | Upvalues: v2 (copy) ]]
		v2(p1)

		return ("%*,%*"):format(p1.AssetId, p1.InfoType.Value)
	end
})

return table.freeze({
	AssertReceiptInfo = v1,
	GetInfoAsync = function(p1, p2, p3) --[[ GetInfoAsync | Line: 173 | Upvalues: Asserts (copy), v3 (copy) ]]
		Asserts.Integer(p1)
		Asserts.Enum(Enum.InfoType)(p2)
		Asserts.Optional(Asserts.Boolean)(p3)

		local t = {
			AssetId = p1,
			InfoType = p2
		}

		if p3 then
			return v3:Get(t)
		end

		return v3:GetAsync(t)
	end
})