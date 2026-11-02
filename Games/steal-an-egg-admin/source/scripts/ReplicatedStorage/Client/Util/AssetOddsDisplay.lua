-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.numberMinExclusive((-1/0))
local v2 = t.intersection(v1, t.numberMaxExclusive((1/0)))
local v3 = t.strict(t.table)
local v4 = t.strict(v2)
local v5 = {}

local function skeletonFor(v6) -- line 16
    if not (v6 < 1000) then
        local v7 = math.log10(v6) / 3
        local v8 = v6 / 1000 ^ math.floor(v7)
        if v8 < 10 then
            return ".##"
        end
        if v8 < 100 then
            return ".#"
        end
    end
    return "."
end

local function compactOdds(v9) -- line 29 | captures: Simple
    local v10 = math.max(1, v9)
    local v11 = math.log10(v10)
    local v12 = 10 ^ (math.floor(v11) - 3 + 1)
    local v13 = v10 / v12
    local v14 = math.floor(v13) * v12
    local v15
    if v14 >= 1000 then
        local v16 = math.log10(v14) / 3
        local v17 = v14 / 1000 ^ math.floor(v16)
        if v17 < 10 then
            v15 = ".##"
        elseif v17 >= 100 then
            v15 = "."
        else
            v15 = ".#"
        end
    else
        v15 = "."
    end
    return string.lower(Simple.FormatCompact(v14, v15))
end

function v5.Resolve(v18, v19) -- line 48 | captures: Mutations, v3
    v3(v18)
    local VisualOdds = v18.VisualOdds
    if typeof(VisualOdds) == "number" then
        if not (VisualOdds > 0) then
            VisualOdds = nil
        end
    else
        local DropWeight = v18.DropWeight
        if typeof(DropWeight) == "number" and DropWeight > 0 then
            VisualOdds = 1 / DropWeight
        else
            VisualOdds = nil
        end
    end
    if VisualOdds == nil or v19 == nil then
        return VisualOdds
    end
    return VisualOdds * Mutations.RarityFactorFor(v19.Mutations, v19.BaseMutation)
end

function v5.Describe(v20, v21, v22) -- line 65 | captures: Simple, v3, v5
    v3(v20)
    local v23 = v5.Resolve(v20, v22)
    if v23 == nil then
        return "1/?"
    end
    local v24 = if v21 then "1 in " else "1/"
    local v25 = math.max(1, v23)
    local v26 = math.log10(v25)
    local v27 = 10 ^ (math.floor(v26) - 3 + 1)
    local v28 = v25 / v27
    local v29 = math.floor(v28) * v27
    local v30
    if v29 >= 1000 then
        local v31 = math.log10(v29) / 3
        local v32 = v29 / 1000 ^ math.floor(v31)
        if v32 < 10 then
            v30 = ".##"
        elseif v32 >= 100 then
            v30 = "."
        else
            v30 = ".#"
        end
    else
        v30 = "."
    end
    return (("%*%*"):format(v24, (string.lower(Simple.FormatCompact(v29, v30)))))
end

function v5.DescribeItem(v33, v34, v35) -- line 94 | captures: AssetItem, v5
    local function v36(...)
        assert(...)
    end

    v36(AssetItem.AssetItemData(v34))
    return v5.Describe(v33, v35, {
        Mutations = v34.Mutations,
        BaseMutation = v34.BaseMutation
    })
end

function v5.Compact(v37) -- line 98 | captures: v4, compactOdds
    v4(v37)
    return compactOdds(v37)
end

return v5
