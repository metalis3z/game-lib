-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Log = require(ReplicatedStorage.Packages.Log)
local Marketplace = require(ReplicatedStorage.Shared.Utils.Marketplace)
require(script.Parent.ProductTypes)
local v1 = if game.CreatorType == Enum.CreatorType.Group then "Group" else "User"
local CreatorId = game.CreatorId
local v2 = Log.new()
local v3 = {}

local function creatorId(v4) -- line 19
    if v4 then
        local v5 = v4.CreatorTargetId or v4.Id
        if v5 and v5 > 0 then
            return v5
        end
    end
    return nil
end

function v3.Validate(v6, v7) -- line 35 | captures: v1, Marketplace, CreatorId, v2
    local v8, v9 = Marketplace.Lookup(v7.ProductId, Enum.InfoType.Product)
    if v9 then
        local Info = v8.Info
        local v10 = Info.PriceInRobux or 0
        if v10 <= 0 then
            local v11 = ("Product %* has an invalid Robux price"):format(v6)
            v2:AtWarning():Log(v11, {
                ProductId = v7.ProductId,
                PriceInRobux = v10
            })
        elseif v10 > 10000 then
            local v12 = ("Product %* is priced above the Studio validation threshold"):format(v6)
            v2:AtWarning():Log(v12, {
                MaxAllowedPrice = 10000,
                ProductId = v7.ProductId,
                PriceInRobux = v10
            })
        end
        local Creator = Info.Creator
        local v13
        if Creator then
            v13 = Creator.CreatorTargetId or Creator.Id
            if not (v13 and v13 > 0) then
                v13 = nil
            end
        end
        if Creator and Creator.CreatorType and v13 then
            if Creator.CreatorType == v1 then
                if v13 ~= CreatorId then
                    local v14 = ("Product %* is owned by the wrong creator"):format(v6)
                    v2:AtWarning():Log(v14, { ProductId = v7.ProductId })
                end
            else
                local v15 = ("Product %* is owned by the wrong creator"):format(v6)
                v2:AtWarning():Log(v15, { ProductId = v7.ProductId })
            end
        end
    else
        local v16 = ("Failed to validate marketplace product info for %*"):format(v6)
        v2:AtWarning():Log(v16, { ProductId = v7.ProductId })
    end
end

return v3
