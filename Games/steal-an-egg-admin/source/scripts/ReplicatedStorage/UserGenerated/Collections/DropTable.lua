-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local v1 = require(ReplicatedStorage.UserGenerated.Randoms.ISAAC).Unique()
local v2 = Asserts.Table({
    Weight = Asserts.FinitePositive,
    Value = Asserts.Any
})
local v3 = Asserts.Table({
    Weight = Asserts.FinitePositive,
    Chance = Asserts.Range(0, 1),
    Value = Asserts.Any
})
local v4 = {}

local function Search(v5, v6) -- line 12
    local v7, v8 = 1, #v5
    while true do
        local v9, v10
        if v7 < v8 then
            v9 = v7 + (v8 - v7) // 2
            if v5[v9] <= v6 then
                v10 = v9 + 1
                v9 = v8
            else
                v10 = v7
            end
        else
            break
        end
        v7 = v10
        v8 = v9
    end
    return v7
end

function v4.Next(v11) -- line 27 | captures: v1, Search
    local v12 = v1:NextDouble()
    local v13 = Search(v11.Uppers, v11.TotalWeight * v12)
    local v14 = v11.Entries[v13]
    return v14.Value, v14
end

function v4.Pick(v15, v16) -- line 33 | captures: Search
    local v17 = if v16 >= 0 then v16 <= 1 else false
    assert(v17)
    local v18 = Search(v15.Uppers, v15.TotalWeight * v16)
    local v19 = v15.Entries[v18]
    return v19.Value, v19
end

local v20 = table.freeze({ __index = table.freeze(v4) })

local function CompareOrderedEntry(v21, v22) -- line 41
    if v21.Weight == v22.Weight then
        return v21.Index < v22.Index
    end
    return v21.Weight < v22.Weight
end

local function new(v23) -- line 50 | captures: Asserts, v2, v20, CompareOrderedEntry
    Asserts.Array(v2)(v23)
    local v24 = #v23
    local v25 = v24 > 0
    assert(v25)
    local v26 = {}
    for v27, v28 in ipairs(v23) do
        local v29 = {
            Index = v27,
            Weight = v28.Weight
        }
        table.insert(v26, v29)
    end
    table.sort(v26, CompareOrderedEntry)
    local v30 = table.create(v24, 0)
    local v31 = {}
    local v32 = 0
    for v33, v34 in ipairs(v26) do
        local v35 = v23[v34.Index]
        local Weight = v35.Weight
        v32 += Weight
        v30[v33] = v32
        local v36 = {
            Chance = 0,
            Weight = Weight,
            Value = v35.Value
        }
        table.insert(v31, v36)
    end
    table.freeze(v30)
    for v37, v38 in ipairs(v31) do
        v38.Chance = v38.Weight / v32
        table.freeze(v38)
    end
    table.freeze(v31)
    local v39 = {
        TotalWeight = v32,
        Entries = v31,
        Uppers = v30
    }
    local v40 = setmetatable(v39, v20)
    table.freeze(v40)
    return v40
end

local freeze = table.freeze
local v41 = {}
local freeze_2 = table.freeze
local v42 = {}

function v42.Add(v43, v44, v45) -- line 83 | captures: Asserts
    Asserts.FinitePositive(v44)
    v43.AssertValue(v45)
    local Entries = v43.Entries
    local v46 = {
        Weight = v44,
        Value = v45
    }
    table.insert(Entries, v46)
    return v43
end

function v42.Build(v47) -- line 89 | captures: new
    return (new(v47.Entries))
end

v41.__index = freeze_2(v42)

local v48 = freeze(v41)
local freeze_3 = table.freeze
local v49 = { new = new }

function v49.IsA(v50) -- line 95 | captures: v20
    if type(v50) == "table" then
        return getmetatable(v50) == v20
    end
    return false
end

function v49.Assert(v51) -- line 103 | captures: v20
    if type(v51) ~= "table" then
        error("table", 2)
    end
    if getmetatable(v51) ~= v20 then
        error("DropTable", 2)
    end
    return v51
end

v49.AssertEntry = v3

function v49.Builder(v52) -- line 114 | captures: Asserts, v48
    Asserts.Function(v52)
    local v53 = {
        AssertValue = v52,
        Entries = {}
    }
    local v54 = setmetatable(v53, v48)
    table.freeze(v54)
    return v54
end

function v49.IsABuilder(v55) -- line 120 | captures: v48
    if type(v55) == "table" then
        return getmetatable(v55) == v48
    end
    return false
end

function v49.AssertBuilder(v56) -- line 128 | captures: v48
    if type(v56) ~= "table" then
        error("table", 2)
    end
    if getmetatable(v56) ~= v48 then
        error("table", 2)
    end
    return v56
end

v49.AssertBuilderEntry = v2
return freeze_3(v49)
