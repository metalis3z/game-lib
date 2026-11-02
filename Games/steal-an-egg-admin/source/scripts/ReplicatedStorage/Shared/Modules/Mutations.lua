-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function v1(v2, ...)
    table.insert(v2, ...)
end

local function v3(v4, ...)
    table.insert(v4, ...)
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Catalog = require(script.Catalog)
local v5 = require(ReplicatedStorage.Packages.Log).new()
local Types = require(script.Types)
local t = require(ReplicatedStorage.Packages.t)
local Visuals = require(script.Visuals)
local v6 = {}
local v7 = {}
local v8 = {}
local v9 = 0
for v10, v11 in Catalog do
    local v12 = v10 == v11.Id
    local v13 = ("Mutations | Catalog key \"%*\" does not match its Id \"%*\""):format(v10, v11.Id)
    assert(v12, v13)
    if Constants.IS_STUDIO then
        local v14, v15 = Types.MutationSpec(v11)
        local v16 = ("Mutations | \"%*\" does not match the MutationSpec schema: %*"):format(v10, v15)
        assert(v14, v16)
    end
    v6[v10] = true
    v7[v10] = v10
    v9 += v11.RollWeight
    v1(v8, table.freeze({
        v10,
        v11.RollWeight
    }))
end
local v17 = 100 - v9
local v18 = math.max(0, v17)

if Constants.IS_STUDIO then
    local v19 = v18 > 0
    local v20 = ("Mutations | Roll weights total %*, which leaves no room for \"None\""):format(v9)
    assert(v19, v20)
end
v3(v8, table.freeze({ "None", v18 }))
table.freeze(v6)
table.freeze(v7)
table.freeze(v8)
local v21 = {
    NO_MUTATION = "None",
    TOTAL_ROLL_WEIGHT = 100,
    IdSet = v6
}

function v21.All() -- line 46 | captures: Catalog
    return Catalog
end

function v21.Ids() -- line 49 | captures: v7
    return v7
end

function v21.IsKnown(v22) -- line 52 | captures: t, v6
    t.strict(t.string)(v22)
    return v6[v22] == true
end

function v21.Get(v23) -- line 58 | captures: Catalog, v5
    local v24 = Catalog[v23]
    if v24 then
        return v24
    end
    v5:AtWarning():Log((("Mutations.Get | Unknown mutation \"%*\""):format((tostring(v23)))))
    return nil
end

function v21.LabelOf(v25) -- line 66 | captures: Catalog, t
    t.strict(t.string)(v25)
    local v26 = Catalog[v25]
    if v26 then
        return v26.Label
    end
    return v25
end

function v21.RollTable() -- line 75 | captures: v8
    return v8
end

function v21.RollChanceOf(v27) -- line 78 | captures: Catalog
    local v28 = Catalog[v27]
    if not v28 or v28.RollWeight <= 0 then
        return 0
    end
    return v28.RollWeight / 100
end

function v21.Sanitize(v29, v30) -- line 85 | captures: v6
    local v31 = {}
    local v32 = {}

    local function include(v33) -- line 88 | captures: v31, v32, v6
        if not (typeof(v33) == "string") or v32[v33] or not v6[v33] then
            return
        end
        v32[v33] = true
        table.insert(v31, v33)
    end

    if typeof(v30) == "string" and not v32[v30] and v6[v30] then
        v32[v30] = true
        table.insert(v31, v30)
    end
    if typeof(v29) == "table" then
        for v34, v35 in ipairs(v29) do
            if typeof(v35) == "string" and not v32[v35] and v6[v35] then
                v32[v35] = true
                table.insert(v31, v35)
            end
        end
    end
    return v31
end

function v21.EggModelName(v36, v37) -- line 110 | captures: Catalog, v21
    for v38, v39 in v21.Sanitize(v36, v37) do
        local v40 = Catalog[v39]
        if v40 and v40.EggModelName then
            return v40.EggModelName
        end
    end
    return nil
end

function v21.EggDisplayName(v41, v42) -- line 120 | captures: Catalog, v21
    for v43, v44 in v21.Sanitize(v41, v42) do
        local v45 = Catalog[v44]
        if v45 and v45.EggDisplayName then
            return v45.EggDisplayName
        end
    end
    return nil
end

function v21.EggIcon(v46, v47) -- line 130 | captures: Catalog, v21
    for v48, v49 in v21.Sanitize(v46, v47) do
        local v50 = Catalog[v49]
        if v50 and v50.EggIcon then
            return v50.EggIcon
        end
    end
    return nil
end

function v21.EarningsFor(v51) -- line 140 | captures: Catalog, v5
    local v52 = 1
    for v53, v54 in v51 do
        local v55 = Catalog[v54]
        if v55 then
            local v56 = v55.EarningsScalar - 1
            v52 += math.max(0, v56)
        else
            v5:AtError():Log((("Mutations.EarningsFor | Unknown mutation \"%*\""):format((tostring(v54)))))
        end
    end
    return (math.max(1, v52))
end

function v21.RarityFactorFor(v57, v58) -- line 156 | captures: v21
    local v59 = 1
    for v60, v61 in v21.Sanitize(v57, v58) do
        local v62 = v21.RollChanceOf(v61)
        if v62 > 0 then
            v59 *= 1 / v62
        end
    end
    return v59
end

function v21.ApplyTo(v63, v64, v65) -- line 167 | captures: Catalog, t, Visuals
    t.strict(t.Instance)(v63)
    t.strict(t.string)(v64)
    t.strict(t.optional(t.number))(v65)
    local v66 = Catalog[v64]
    local v67 = ("Mutations.ApplyTo | Unknown mutation \"%*\""):format(v64)
    local v68 = assert(v66, v67)
    local v69 = Visuals.GetFXPart(v63)
    if not v69 then
        return
    end
    local v70 = Visuals.ShouldApplyMetalCombo(v63, v64)
    local v71
    if v65 == nil then
    else
        v71 = Random.new(Visuals.SeedFor(v65, v64))
    end
    Visuals.WithVisualRandom(v71, function() -- line 186 | captures: v63, v65, v68, v69, v70, Visuals
        v68:Apply(v63, v69)
        if v70 then
            local v72 = assert(v65, "A Golden and Silver combination requires a visual seed")
            Visuals.ApplyMetalCombo(v63, v72)
        end
    end)
end

function v21.ClearFrom(v73, v74) -- line 194 | captures: Catalog, t, Visuals
    t.strict(t.Instance)(v73)
    t.strict(t.string)(v74)
    local v75 = Catalog[v74]
    local v76 = ("Mutations.ClearFrom | Unknown mutation \"%*\""):format(v74)
    local v77 = assert(v75, v76)
    local v78 = Visuals.GetFXPart(v73)
    if v78 then
        v77:Clear(v73, v78)
    end
end

function v21.ClearAllFrom(v79) -- line 206 | captures: Catalog, t, Visuals
    t.strict(t.Instance)(v79)
    local v80 = Visuals.GetFXPart(v79)
    if v80 then
        for v81, v82 in Catalog do
            local spawn = task.spawn
            local v83 = v82
            spawn(function() -- line 217 | captures: v79, v80, v83
                v83:Clear(v79, v80)
            end)
        end
    end
end

return v21
