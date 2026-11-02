-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Gamepasses = require(ReplicatedStorage.Data.Gamepasses)
require(ReplicatedStorage.Shared.Types.Monetization)
local Marketplace = require(ReplicatedStorage.Shared.Utils.Marketplace)
local Products = require(ReplicatedStorage.Data.Products)
local Price = Marketplace.Price
local t = require(ReplicatedStorage.Packages.t)
local X2Money = Gamepasses.Directory.X2Money
local X2Growth = Gamepasses.Directory.X2Growth
local Lucky = Gamepasses.Directory.Lucky
local v1 = {}

v1[X2Money._id] = true

local v2 = table.freeze(v1)
local v3 = {}

v3[Lucky._id] = true

local v4 = table.freeze(v3)
local v5 = {}

v5[X2Money._id] = true
v5[Lucky._id] = true

local v6 = table.freeze(v5)
local v7 = t.strict(t.number)
local v8 = t.strict(t.instanceIsA("Player"))
local v9 = t.strict(t.string)
local v10 = {
    PROFILES = table.freeze({
        NON_SPENDER = "NonSpender",
        AVATAR_VALUE_ONLY = "AvatarValueOnly",
        SPENT_ROBUX = "SpentRobux"
    })
}

local function wholeRobux(v11) -- line 30
    if typeof(v11) == "number" then
        local v12 = math.floor(v11)
        return (math.max(v12, 0))
    end
    return 0
end

local function countedAttribute(v13, v14) -- line 37 | captures: v8
    v8(v13)
    local v15 = v13:GetAttribute(v14)
    if typeof(v15) ~= "number" then
        v15 = nil
    end
    if typeof(v15) == "number" then
        local v16 = math.floor(v15)
        return (math.max(v16, 0))
    end
    return 0
end

local function switchedAttribute(v17, v18) -- line 52 | captures: v8, v9
    v8(v17)
    v9(v18)
    return v17:GetAttribute(v18) == true
end

local function passHeld(v19, v20) -- line 58
    if typeof(v19) == "table" then
        return v19[v20] == true
    end
    return false
end

local function productHeld(v21, v22) -- line 62
    if typeof(v21) == "table" then
        return v21[tostring(v22)] == true
    end
    return false
end

local function NormalizeRobuxSpend(v23) -- line 66
    if typeof(v23) == "number" then
        local v24 = math.floor(v23)
        return (math.max(v24, 0))
    end
    return 0
end

v10.NormalizeRobuxSpend = NormalizeRobuxSpend

function v10.ProductPrice(v25) -- line 73 | captures: Price, v7
    v7(v25)
    local v26, v27 = Price(v25, true)
    if not (v27 and typeof(v26) == "number") then
        return 0
    end
    local v28 = math.floor(v26)
    return (math.max(v28, 0))
end

function v10.GamepassPrice(v29) -- line 83 | captures: Price, v7
    v7(v29)
    local v30, v31 = Price(v29, false)
    if not (v31 and typeof(v30) == "number") then
        return 0
    end
    local v32 = math.floor(v30)
    return (math.max(v32, 0))
end

function v10.MarketplacePrice(v33, v34) -- line 93 | captures: Marketplace, v7
    v7(v33)
    local v35, v36 = Marketplace.Lookup(v33, v34)
    local v37 = if v36 then v35.Info else nil
    if typeof(v37) == "table" then
        local PriceInRobux = v37.PriceInRobux
        if typeof(PriceInRobux) == "number" then
            local v38 = math.floor(PriceInRobux)
            return (math.max(v38, 0))
        end
    end
    return 0
end

function v10.AvatarAssetPrice(v39) -- line 112 | captures: v10
    return v10.MarketplacePrice(v39, Enum.InfoType.Asset)
end

function v10.AvatarBundlePrice(v40) -- line 115 | captures: v10
    return v10.MarketplacePrice(v40, Enum.InfoType.Bundle)
end

function v10.HasX2Money(v41) -- line 118 | captures: X2Money
    if typeof(v41) == "table" then
        return v41[X2Money._id] == true
    end
    return false
end

function v10.HasX2Growth(v42) -- line 122 | captures: X2Growth
    if typeof(v42) == "table" then
        return v42[X2Growth._id] == true
    end
    return false
end

function v10.HasLucky(v43) -- line 126 | captures: Lucky
    if typeof(v43) == "table" then
        return v43[Lucky._id] == true
    end
    return false
end

local function HasVipProduct(v44) -- line 130
    return false
end

v10.HasVipProduct = HasVipProduct

function v10.PlayerHasX2Money(v45) -- line 133 | captures: v8, v9
    v8(v45)
    v9("MonetizationX2MoneyGamepassOwned")
    return v45:GetAttribute("MonetizationX2MoneyGamepassOwned") == true
end

function v10.PlayerHasLucky(v46) -- line 140 | captures: v8, v9
    v8(v46)
    v9("MonetizationLuckyGamepassOwned")
    return v46:GetAttribute("MonetizationLuckyGamepassOwned") == true
end

local function PlayerHasVipProduct(v47) -- line 147
    return false
end

v10.PlayerHasVipProduct = PlayerHasVipProduct

function v10.SumOwnedRobuxSpend(v48, v49) -- line 150 | captures: Gamepasses, Products, v10
    local v50
    if typeof(v48) == "table" then
        local v51 = 0
        v50 = 0
        for v52, v53 in pairs(Gamepasses.Directory) do
            local v54
            if typeof(v48) == "table" and v48[v53._id] == true then
                v54 = v10.GamepassPrice(v53.ProductId)
            else
                v54 = 0
            end
            v51 += v54
            v50 = v51
        end
    else
        v50 = 0
    end
    if typeof(v49) == "table" then
        local v55 = v50
        for v56, v57 in pairs(Products.Directory) do
            local v58
            if typeof(v49) == "table" then
                local ProductId = v57.ProductId
                v58 = v49[tostring(ProductId)] == true
            else
                v58 = false
            end
            local v59
            if v58 then
                v59 = v10.ProductPrice(v57.ProductId)
            else
                v59 = 0
            end
            v55 += v59
            v50 = v55
        end
    end
    return v50
end

function v10.EffectiveRobuxSpend(v60, v61, v62) -- line 181 | captures: v10
    local v63
    if typeof(v62) == "number" then
        local v64 = math.floor(v62)
        v63 = math.max(v64, 0)
    else
        v63 = 0
    end
    if v63 > 0 then
        return v63
    end
    return (v10.SumOwnedRobuxSpend(v60, v61))
end

local function IsSpender(v65) -- line 194
    local v66
    if typeof(v65) == "number" then
        local v67 = math.floor(v65)
        v66 = math.max(v67, 0)
    else
        v66 = 0
    end
    return v66 > 0
end

v10.IsSpender = IsSpender

function v10.PlayerRobuxSpend(v68) -- line 205 | captures: v8
    v8(v68)
    local MonetizationRobuxSpentTotal = v68:GetAttribute("MonetizationRobuxSpentTotal")
    if typeof(MonetizationRobuxSpentTotal) ~= "number" then
        MonetizationRobuxSpentTotal = nil
    end
    if typeof(MonetizationRobuxSpentTotal) == "number" then
        local v69 = math.floor(MonetizationRobuxSpentTotal)
        return (math.max(v69, 0))
    end
    return 0
end

function v10.IsPlayerSpender(v70) -- line 220 | captures: v10
    return v10.PlayerRobuxSpend(v70) > 0
end

function v10.PlayerAvatarValue(v71) -- line 225 | captures: v8
    v8(v71)
    local MonetizationAvatarMarketplaceValue = v71:GetAttribute("MonetizationAvatarMarketplaceValue")
    if typeof(MonetizationAvatarMarketplaceValue) ~= "number" then
        MonetizationAvatarMarketplaceValue = nil
    end
    if typeof(MonetizationAvatarMarketplaceValue) == "number" then
        local v72 = math.floor(MonetizationAvatarMarketplaceValue)
        return (math.max(v72, 0))
    end
    return 0
end

function v10.PlayerHasAvatarValue(v73) -- line 240 | captures: v10
    return v10.PlayerAvatarValue(v73) > 0
end

function v10.SyncPlayerFlags(v74, v75, v76, v77) -- line 245 | captures: X2Money, Lucky, v8, v10
    v8(v74)
    local v78 = if typeof(v75) == "table" then v75[X2Money._id] == true else false
    v74:SetAttribute("MonetizationX2MoneyGamepassOwned", v78)
    local v79 = if typeof(v75) == "table" then v75[Lucky._id] == true else false
    v74:SetAttribute("MonetizationLuckyGamepassOwned", v79)
    v74:SetAttribute("MonetizationRobuxSpentTotal", v10.EffectiveRobuxSpend(v75, v76, v77))
end

function v10.SyncPlayerAvatarValue(v80, v81) -- line 253 | captures: v8
    v8(v80)
    local v82
    if typeof(v81) == "number" then
        local v83 = math.floor(v81)
        v82 = math.max(v83, 0)
    else
        v82 = 0
    end
    v80:SetAttribute("MonetizationAvatarMarketplaceValue", v82)
end

function v10.ProfileFor(v84, v85) -- line 264 | captures: v10
    local PROFILES = v10.PROFILES
    local v86
    if typeof(v85) == "number" then
        local v87 = math.floor(v85)
        v86 = math.max(v87, 0)
    else
        v86 = 0
    end
    if v86 > 0 then
        return PROFILES.SPENT_ROBUX
    end
    local v88
    if typeof(v84) == "number" then
        local v89 = math.floor(v84)
        v88 = math.max(v89, 0)
    else
        v88 = 0
    end
    if v88 > 0 then
        return PROFILES.AVATAR_VALUE_ONLY
    end
    return PROFILES.NON_SPENDER
end

function v10.PlayerProfile(v90) -- line 287 | captures: v8, v10
    v8(v90)
    local v91 = v10.PlayerAvatarValue(v90)
    return v10.ProfileFor(v91, v10.PlayerRobuxSpend(v90))
end

function v10.PlayerMayTakeBackSteal(v92) -- line 292 | captures: v10
    return v10.PlayerProfile(v92) ~= v10.PROFILES.NON_SPENDER
end

function v10.AssetMoneyAdditiveBonus(v93, v94) -- line 297 | captures: v10
    if v10.HasX2Money(v93) then
        return 1
    end
    return 0
end

function v10.PlayerAssetMoneyAdditiveBonus(v95) -- line 303 | captures: v10
    if v10.PlayerHasX2Money(v95) then
        return 1
    end
    return 0
end

function v10.GameplayBlockLuckPercent(v96) -- line 309 | captures: v10
    if v10.HasLucky(v96) then
        return 10
    end
    return 0
end

function v10.PlayerGameplayBlockLuckPercent(v97) -- line 315 | captures: v10
    if v10.PlayerHasLucky(v97) then
        return 10
    end
    return 0
end

function v10.FuseRarestWeightMultiplier(v98) -- line 321 | captures: v10
    if v10.HasLucky(v98) then
        return 1.1
    end
    return 1
end

function v10.PlayerFuseRarestWeightMultiplier(v99) -- line 327 | captures: v10
    if v10.PlayerHasLucky(v99) then
        return 1.1
    end
    return 1
end

function v10.OwnedGamepassesForPlayer(v100) -- line 333 | captures: v2, v4, v6, v8, v10
    v8(v100)
    local v101 = v10.PlayerHasX2Money(v100)
    local v102 = v10.PlayerHasLucky(v100)
    if v101 then
        if v102 then
            return v6
        end
        return v2
    end
    if v102 then
        return v4
    end
    return nil
end

function v10.OwnedProductsForPlayer(v103) -- line 357 | captures: v8
    v8(v103)
    return nil
end

return v10
