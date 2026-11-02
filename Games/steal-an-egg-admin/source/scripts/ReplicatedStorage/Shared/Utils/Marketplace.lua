-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local MarketplaceService = game:GetService("MarketplaceService")
local v1 = {}
local v2 = {}

function v1.Lookup(v3, v4) -- line 9 | captures: MarketplaceService, v2
    local v5 = type(v3) == "number"
    assert(v5, "marketplace id must be a number")
    local v6 = if typeof(v4) == "EnumItem" then v4.EnumType == Enum.InfoType else false
    assert(v6, "invalid info type")
    local v7 = v2[v4]
    if v7 == nil then
        v7 = {}
        v2[v4] = v7
    end
    local v8 = v7[v3]
    if v8 == nil then
        v8 = {}
        v7[v3] = v8
    end
    local v9 = time()
    if v8.Info == nil then
        if v8.LastFailure then
            if not (v9 - v8.LastFailure < 900) then
                local v10, v11 = pcall(MarketplaceService.GetProductInfo, MarketplaceService, v3, v4)
                if v10 then
                    v8.Info = v11
                    v8.LastUpdated = time()
                    v8.LastFailure = nil
                    return v8, true
                end
                v8.LastFailure = time()
                warn((("marketplace lookup failed for id %* as %*: %*"):format(v3, v4.Name, v11)))
            end
        else
            local v12, v13 = pcall(MarketplaceService.GetProductInfo, MarketplaceService, v3, v4)
            if v12 then
                v8.Info = v13
                v8.LastUpdated = time()
                v8.LastFailure = nil
                return v8, true
            end
            v8.LastFailure = time()
            warn((("marketplace lookup failed for id %* as %*: %*"):format(v3, v4.Name, v13)))
        end
        return v8, false
    end
    if not (v8.LastUpdated and v9 - v8.LastUpdated < 900) then
        return
    end
    return v8, true
end

function v1.Info(v14, v15) -- line 61 | captures: v1
    local v16 = v15 or Enum.InfoType.Product
    return v1.Lookup(v14, v16).Info
end

function v1.Price(v17, v18) -- line 68 | captures: v1
    local v19 = if v18 then Enum.InfoType.Product else Enum.InfoType.GamePass
    local Info = v1.Lookup(v17, v19).Info
    if Info == nil then
        warn((("no marketplace price is available for id %*"):format(v17)))
        return 0, false
    end
    local IsForSale = Info.IsForSale
    local v20
    if IsForSale then
        local PriceInRobux = Info.PriceInRobux
        v20 = type(PriceInRobux) == "number"
    end
    if not IsForSale or not v20 then
        return 0, false
    end
    return Info.PriceInRobux, true
end

return table.freeze(v1)
