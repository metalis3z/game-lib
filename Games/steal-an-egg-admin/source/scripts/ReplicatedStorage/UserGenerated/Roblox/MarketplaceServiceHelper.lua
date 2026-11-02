-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local MarketplaceService = game:GetService("MarketplaceService")
local Cache = require(game.ReplicatedStorage.UserGenerated.Concurrency.Cache)
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts)
local TablePermissive = Asserts.TablePermissive
local v1 = {
    PurchaseId = Asserts.String,
    PlayerId = Asserts.Integer,
    ProductId = Asserts.Integer,
    PlaceIdWherePurchased = Asserts.Integer,
    CurrencySpent = Asserts.IntegerNonNegative
}

v1.CurrencyType = Asserts.AnyOf(Asserts.Enum(Enum.CurrencyType), Asserts.String)
v1.ProductPurchaseChannel = Asserts.Enum(Enum.ProductPurchaseChannel)

local v2 = TablePermissive(v1)
local v3 = Asserts.Table({
    AssetId = Asserts.Integer,
    InfoType = Asserts.Enum(Enum.InfoType)
})
local new = Cache.new
local v4 = {}

function v4.Callback(v5) -- line 24 | captures: MarketplaceService
    return MarketplaceService:GetProductInfo(v5.AssetId, v5.InfoType)
end

function v4.AssertKey(v6) -- line 27 | captures: v3
    v3(v6)
    return (("%*,%*"):format(v6.AssetId, v6.InfoType.Value))
end

local v7 = new(v4)
local freeze = table.freeze
local v8 = { AssertReceiptInfo = v2 }

function v8.GetInfoAsync(v9, v10, v11) -- line 34 | captures: Asserts, v7
    Asserts.Integer(v9)
    Asserts.Enum(Enum.InfoType)(v10)
    Asserts.Optional(Asserts.Boolean)(v11)
    local v12 = {
        AssetId = v9,
        InfoType = v10
    }
    if v11 then
        return v7:Get(v12)
    end
    return v7:GetAsync(v12)
end

return freeze(v8)
