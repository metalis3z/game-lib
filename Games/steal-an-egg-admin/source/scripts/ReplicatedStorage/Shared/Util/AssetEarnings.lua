-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AdminBoosts = require(ReplicatedStorage.Shared.Util.AdminBoosts)
local Assets = require(ReplicatedStorage.Data.Assets)
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local MonetizationEntitlements = require(ReplicatedStorage.Shared.Util.MonetizationEntitlements)
require(ReplicatedStorage.Shared.Types.Monetization)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local PlayerEarningsBoost = require(ReplicatedStorage.Shared.Util.PlayerEarningsBoost)
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.numberMinExclusive((-1/0))
local v2 = t.intersection(v1, t.numberMaxExclusive((1/0)))
local v3 = t.strict(v2)
local v4 = {}

local function scalePayoutFactor(v5) -- line 19 | captures: v3
    v3(v5)
    local v6 = v5 > 0
    assert(v6, "Payout factor is undefined for a non-positive asset scale")
    if v5 <= 5 then
        return v5 ^ 1.85
    end
    return (v5 / 5) ^ 1.2 * 19.637875755794113
end

local function catalogEarningRate(v7) -- line 28 | captures: Assets
    local v8 = Assets.Directory[v7.Category]
    if v8 then
        local EarningRate = v8.EarningRate
        return tonumber(EarningRate) or 0
    end
    return 0
end

local function entitledRate(v9, v10, v11) -- line 41 | captures: Assets, AssetItem, MonetizationEntitlements, Mutations, v3
    local function v12(...)
        assert(...)
    end

    v12(AssetItem.AssetItemData(v9))
    local v13 = Assets.Directory[v9.Category]
    local v14
    if v13 then
        local EarningRate = v13.EarningRate
        v14 = tonumber(EarningRate)
    else
        v14 = 0
    end
    local Scale = v9.Scale
    v3(Scale)
    local v15 = Scale > 0
    assert(v15, "Payout factor is undefined for a non-positive asset scale")
    local v16 = if Scale > 5 then (Scale / 5) ^ 1.2 * 19.637875755794113 else Scale ^ 1.85
    local v17 = v14 * v16 * Mutations.EarningsFor(v9.Mutations) * (1 + MonetizationEntitlements.AssetMoneyAdditiveBonus(v10, v11))
    local v18 = math.round(v17)
    return (math.max(v18, 1))
end

function v4.RatePerSecond(v19, v20, v21) -- line 64 | captures: AssetItem, entitledRate
    local function v22(...)
        assert(...)
    end

    v22(AssetItem.AssetItemData(v19))
    return (entitledRate(v19, v20, v21))
end

function v4.LiveRatePerSecond(v23, v24, v25, v26) -- line 68 | captures: AdminBoosts, PlayerEarningsBoost, entitledRate
    local v27 = entitledRate(v23, v24, v25) * AdminBoosts.ReadMultiplier(AdminBoosts.EARNINGS) * PlayerEarningsBoost.GetMultiplier(v26)
    return (math.round(v27))
end

function v4.MutationOnlyRatePerSecond(v28) -- line 72 | captures: AssetItem, entitledRate
    local function v29(...)
        assert(...)
    end

    v29(AssetItem.AssetItemData(v28))
    return (entitledRate(v28))
end

function v4.CatalogRatePerSecond(v30) -- line 76 | captures: Assets, AssetItem, v3
    local function v31(...)
        assert(...)
    end

    v31(AssetItem.AssetItemData(v30))
    local v32 = Assets.Directory[v30.Category]
    local v33
    if v32 then
        local EarningRate = v32.EarningRate
        v33 = tonumber(EarningRate)
    else
        v33 = 0
    end
    local Scale = v30.Scale
    v3(Scale)
    local v34 = Scale > 0
    assert(v34, "Payout factor is undefined for a non-positive asset scale")
    local v35 = if Scale > 5 then (Scale / 5) ^ 1.2 * 19.637875755794113 else Scale ^ 1.85
    return v33 * v35
end

return v4
