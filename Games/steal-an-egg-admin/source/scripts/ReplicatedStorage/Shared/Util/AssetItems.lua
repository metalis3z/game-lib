-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local AssetEarnings = require(ReplicatedStorage.Shared.Util.AssetEarnings)
local AssetGender = require(ReplicatedStorage.Shared.Util.AssetGender)
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local AssetPalette = require(ReplicatedStorage.Shared.Util.AssetPalette)
local Personalities = require(ReplicatedStorage.Data.Assets).Personalities
local AddCommas = require(ReplicatedStorage.Shared.Utils.Numbers).AddCommas
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.strict(t.string)
local v2 = {}

local function catalogEntry(v3) -- line 17 | captures: Assets
    return Assets.Directory[v3]
end

local function isNamedMutation(v4) -- line 20
    if typeof(v4) == "string" then
        if v4 == "" then
            return false
        end
        return v4 ~= "None"
    end
    return false
end

local function settled(v5) -- line 27 | captures: AssetGender, AssetPalette
    local v6 = {}
    for v7, v8 in ipairs(v5.Mutations) do
        if typeof(v8) == "string" and v8 ~= "" and v8 ~= "None" then
            table.insert(v6, v8)
        end
    end
    local v9 = AssetPalette.SettleFields(v5.Category, v5.EyeColor, v5.ColorSeed, v5.ColorIndex)
    local v10 = if AssetGender.Settle(v5.Category, v5.Gender) == "Male" then "Male" else "Female"
    local v11 = {
        Category = v5.Category,
        Mutations = v6
    }
    local BaseMutation = v5.BaseMutation
    if typeof(BaseMutation) == "string" and BaseMutation ~= "" and BaseMutation ~= "None" then
        v11.BaseMutation = v5.BaseMutation
    else
        v11.BaseMutation = v6[1]
    end
    v11.Scale = v5.Scale
    v11.Gender = v10
    v11.EyeColor = v9.EyeColor
    v11.ColorSeed = v9.ColorSeed
    v11.ColorIndex = v9.ColorIndex
    v11.IsFavorite = v5.IsFavorite
    v11.GeneratedMoney = v5.GeneratedMoney
    v11.LastTick = v5.LastTick
    v11.PendingEggName = v5.PendingEggName
    v11.Claimed = v5.Claimed
    v11.LuckyBlockUnlockTimestamp = v5.LuckyBlockUnlockTimestamp
    v11.LuckyBlockUnlockDuration = v5.LuckyBlockUnlockDuration
    v11.LuckyBlockInstantUnlock = v5.LuckyBlockInstantUnlock
    v11.InFuse = v5.InFuse or false
    v11.SpecialLuckyBlockColumn = v5.SpecialLuckyBlockColumn
    v11.SpecialLuckyBlockCapturedAt = v5.SpecialLuckyBlockCapturedAt
    v11.Personality = v5.Personality
    v11.HasBeenFirstPlaced = v5.HasBeenFirstPlaced
    v11.IsStolenDNA = v5.IsStolenDNA
    return v11
end

function v2.Encode(v12) -- line 81 | captures: settled
    return (settled(v12))
end

function v2.Decode(v13) -- line 84 | captures: settled
    return (settled(v13))
end

function v2.WeightKg(v14) -- line 87 | captures: Assets, AssetItem
    local function v15(...)
        assert(...)
    end

    v15(AssetItem.AssetItemData(v14))
    local ModelWeight = Assets.Directory[v14.Category].ModelWeight
    local Scale = v14.Scale
    return ModelWeight * math.max(Scale, 0) ^ 3
end

function v2.WeightLabel(v16) -- line 91 | captures: AddCommas, v2
    local v17 = v2.WeightKg(v16) * 100
    local v18 = math.round(v17) / 100
    return (("%*Kg"):format((AddCommas((math.max(v18, 0))))))
end

function v2.SalePrice(v19) -- line 95 | captures: AssetEarnings, AssetItem
    local function v20(...)
        assert(...)
    end

    v20(AssetItem.AssetItemData(v19))
    return AssetEarnings.RatePerSecond(v19) * 100
end

function v2.IndexMoneyReward(v21) -- line 99 | captures: AssetEarnings, Personalities
    local v22 = {
        Scale = 1,
        HasBeenFirstPlaced = true,
        Category = v21,
        Mutations = {},
        Personality = Personalities.Personalities.Normal
    }
    local v23 = AssetEarnings.MutationOnlyRatePerSecond(v22) * 100
    return (math.round(v23))
end

function v2.IndexSpeedReward(v24) -- line 109 | captures: Assets
    return Assets.Directory[v24].IndexSpeedReward
end

function v2.RarityRankForCategory(v25) -- line 112 | captures: Assets, v1
    v1(v25)
    local v26 = Assets.Directory[v25]
    local v27 = v26 ~= nil
    local v28 = ("Asset catalog has no entry named %*"):format(v25)
    assert(v27, v28)
    return v26.Rarity.RarityNumber
end

function v2.ProfileIncomePerSecond(v29, v30) -- line 119 | captures: AssetEarnings, settled
    local Inventory = v30.Inventory
    local EquippedAssets = v30.EquippedAssets
    local Gamepasses
    if typeof(Inventory) == "table" and typeof(EquippedAssets) == "table" then
        local Gamepasses_2 = v30.Gamepasses
        if typeof(Gamepasses_2) == "table" then
            Gamepasses = v30.Gamepasses
        end
    else
        return 0
    end
    local Products = v30.Products
    local v31 = if typeof(Products) == "table" then v30.Products else nil
    local v32 = 0
    for v33, v34 in ipairs(EquippedAssets) do
        local v35 = Inventory[v34]
        if typeof(v35) == "table" then
            local v36 = AssetEarnings.LiveRatePerSecond(settled(v35), Gamepasses, v31, v29)
            v32 += math.max(v36, 0)
        end
    end
    return v32
end

return v2
