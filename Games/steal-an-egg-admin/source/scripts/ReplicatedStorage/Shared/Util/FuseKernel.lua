-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local AssetEarnings = require(ReplicatedStorage.Shared.Util.AssetEarnings)
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.numberMinExclusive((-1/0))
local v2 = t.intersection(v1, t.numberMaxExclusive((1/0)))
local v3 = t.strict(t.boolean)
local v4 = t.strict(v2)
local v5 = t.strict(t.optional(t.string))
local v6 = t.strict(t.string)
local v7 = t.strict(t.table)
local v8 = {}

local function averageOf(v9) -- line 20 | captures: v4, v7
    v7(v9)
    local v10 = #v9 == 3
    local v11 = ("A fuse consumes exactly %* pets"):format(3)
    assert(v10, v11)
    local v12 = 0
    for v13, v14 in ipairs(v9) do
        v4(v14)
        local v15 = v14 > 0
        assert(v15, "Every fuse input needs a positive scale")
        v12 += v14
    end
    return v12 / 3
end

local function refusalFor(v16, v17, v18) -- line 34 | captures: Assets
    local v19 = Assets.Directory[v16.Category]
    if v19 == nil or v19.CannotFuse == true then
        return "That pet cannot be fused"
    end
    if v16.IsFavorite == true then
        return "Favorite pets cannot be fused"
    end
    if v18 == (v16.InFuse == true) then
        if v17 == nil then
            return nil
        end
        if v16.Category == v17 then
            return nil
        end
        return "All three pets must be the same category"
    end
    if v18 then
        return "That pet is not in this fuse machine"
    end
    return "That pet is already in a fuse machine"
end

function v8.MayEnterFuse(v20, v21, v22, v23) -- line 57 | captures: Assets, AssetItem, v3, v5, v6
    local function v24(...)
        assert(...)
    end

    v6(v20)
    v24(AssetItem.SerializedAssetItemData(v21))
    v5(v22)
    v3(v23)
    local v25 = Assets.Directory[v21.Category]
    local v26
    if v25 == nil or v25.CannotFuse == true then
        v26 = "That pet cannot be fused"
    elseif v21.IsFavorite == true then
        v26 = "Favorite pets cannot be fused"
    elseif v23 == (v21.InFuse == true) then
        if v22 == nil or v21.Category == v22 then
        else
            v26 = "All three pets must be the same category"
        end
    elseif v23 then
        v26 = "That pet is not in this fuse machine"
    else
        v26 = "That pet is already in a fuse machine"
    end
    return v26 == nil, v26
end

function v8.BandWeightBias(v27, v28, v29) -- line 89 | captures: v4, averageOf
    v4(v28)
    v4(v29)
    local v30 = v28 > 0
    assert(v30, "A scale band cannot start at or below zero")
    local v31 = v28 <= v29
    assert(v31, "A scale band cannot end below where it starts")
    local v32 = averageOf(v27)
    local v33 = math.log(v32) / 0.6931471805599453
    local v34 = (v28 + v29) / 2
    local v35 = v33 * (math.log(v34) / 0.6931471805599453) * 0.6
    return (math.exp(v35))
end

function v8.DrawFusedScale(v36, v37) -- line 99 | captures: EggRecords, v8, averageOf
    averageOf(v36)
    return EggRecords.DrawAssetScale(v37, function(v38, v39) -- line 101 | captures: v36, v8
        return v8.BandWeightBias(v36, v38, v39)
    end)
end

function v8.PriceFor(v40) -- line 105 | captures: AssetEarnings, AssetItem
    local function v41(...)
        assert(...)
    end

    v41(AssetItem.AssetItemDataArray(v40))
    local v42 = #v40 == 3
    local v43 = ("Pricing a fuse needs exactly %* pets"):format(3)
    assert(v42, v43)
    local v44 = 0
    local v45 = 0
    for v46, v47 in ipairs(v40) do
        v45 += AssetEarnings.RatePerSecond(v47) * 180
        local v48 = #v47.Mutations
        v44 = math.max(v44, v48)
    end
    local v49
    if v44 == 1 then
        v49 = 2
    elseif v44 >= 2 then
        v49 = 3
    else
        v49 = 1
    end
    local v50 = math.floor(v45) * v49
    return (math.floor(v50))
end

return v8
