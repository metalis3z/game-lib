-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local AssetService = game:GetService("AssetService")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local Parent = script.Parent.Parent.Parent.Parent.Parent
local Future = require(Parent.Parent.Future)
local AssetTypeFromId = require(Parent.SourceCode.Shared.Utils.AssetTypeFromId)
local v1 = {}

v1[Enum.InfoType.Asset] = "KnownAssets"
v1[Enum.InfoType.Bundle] = "KnownBundles"

local v2 = {}

v2[Enum.InfoType.Asset] = Enum.AvatarItemType.Asset
v2[Enum.InfoType.Bundle] = Enum.AvatarItemType.Bundle

local v3 = {
    KnownAssets = {},
    KnownBundles = {},
    OwnedAssets = {},
    OwnedBundles = {},
    BundleDetails = {},
    BundleAssets = {}
}

function v3.GetBundleIdFromAsset(v4, v5) -- line 36
    for v6, v7 in pairs(v4.BundleAssets) do
        if table.find(v7, v5) ~= nil then
            return v6
        end
    end
    return nil
end

function v3.GetBundle(v8, v9) -- line 46 | captures: AssetService, Future
    if v8.BundleDetails[v9] == nil then
        local v10, v11 = Future.Try(function() -- line 48 | captures: v9, AssetService
            return AssetService:GetBundleDetailsAsync(v9)
        end):Await()
        if v10 then
            v8.BundleAssets[v9] = {}
            for v12, v13 in ipairs(v11.Items) do
                if v13.Type == "Asset" then
                    local v14 = v8.BundleAssets[v9]
                    local Id = v13.Id
                    table.insert(v14, Id)
                end
            end
            v8.BundleDetails[v9] = v11
        end
    end
    return v8.BundleDetails[v9]
end

function v3.OwnsItem(v15, v16, v17) -- line 67 | captures: MarketplaceService, Players, Future
    local v18 = {}
    v18[Enum.AvatarItemType.Asset] = v15.OwnedAssets
    v18[Enum.AvatarItemType.Bundle] = v15.OwnedBundles
    local v19 = v18[v17]
    if v19 then
        if table.find(v19, v16) == nil then
            local v20, v21 = Future.Try(function() -- line 76 | captures: v16, v17, MarketplaceService, Players
                if v17 == Enum.AvatarItemType.Asset then
                    return MarketplaceService:PlayerOwnsAsset(Players.LocalPlayer, v16)
                end
                if v17 == Enum.AvatarItemType.Bundle then
                    return MarketplaceService:PlayerOwnsBundle(Players.LocalPlayer, v16)
                end
                return nil
            end):Await()
            if v20 and v21 then
                table.insert(v19, v16)
            end
        end
        return table.find(v19, v16) ~= nil
    end
    return false
end

function v3.GetItem(v22, v23, v24) -- line 96 | captures: MarketplaceService, Future, AssetTypeFromId, v1, v2
    local v25 = v22[v1[v24]]
    local v26 = v2[v24]
    local v27 = v22:GetExistingItem(v23, v24)
    if v27 then
        return v27
    end
    local v28, v29 = Future.Try(function() -- line 105 | captures: v23, v24, MarketplaceService
        return MarketplaceService:GetProductInfo(v23, v24)
    end):Await()
    if v28 then
        local v30 = {
            Id = v29.AssetId,
            Name = v29.Name,
            Price = v29.PriceInRobux,
            Type = v26,
            AssetType = AssetTypeFromId(v29.AssetTypeId),
            Offsale = not v29.IsForSale
        }
        v25[v23] = v30
        return v30
    end
    return nil
end

function v3.GetExistingItem(v31, v32, v33) -- line 126 | captures: v1, v2
    local v34 = v31[v1[v33]]
    local v35 = v2[v33]
    if v34 and v35 then
        local v36 = v34[v32]
        if v36 then
            return v36
        end
    end
    return nil
end

return v3
