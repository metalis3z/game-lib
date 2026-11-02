-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}

v1["&"] = "&amp;"
v1["<"] = "&lt;"
v1[">"] = "&gt;"
v1["\""] = "&quot;"

local v2 = {}

local function escape(v3) -- line 17 | captures: v1
    return (v3:gsub("[&<>\"]", v1))
end

local function colourRun(v4) -- line 20 | captures: Mutations, v1
    local v5 = Mutations.Get(v4)
    return v5 and ("<font color=\"#%*\">%*</font>"):format(v5.Tint:ToHex(), (v5.Label:gsub("[&<>\"]", v1)))
end

function v2.IsDroppable(v6) -- line 29 | captures: Mutations
    if typeof(v6) == "string" then
        if v6 == "" then
            return false
        end
        return Mutations.RollChanceOf(v6) > 0
    end
    return false
end

function v2.FirstDroppable(v7, v8) -- line 40 | captures: v2
    local v9 = if typeof(v8) == "table" then v8 else {}
    local v10 = #v9
    for v11 = 0, v10 do
        local v12 = if v11 == 0 then v7 else v9[v11]
        if v2.IsDroppable(v12) then
            return v12
        end
    end
    return nil
end

function v2.Compose(v13, v14, v15) -- line 62 | captures: Mutations
    local v16 = Mutations.Sanitize(v14, v15)
    local v17 = table.create(#v16)
    for v18, v19 in ipairs(v16) do
        v17[v18] = Mutations.LabelOf(v19)
    end
    if #v16 == 0 then
        return v13
    end
    return (("%* %*"):format(table.concat(v17, " + "), v13))
end

function v2.WithMass(v20, v21, v22, v23) -- line 74 | captures: v2
    local v24 = v2.Compose(v20, v21, v22)
    return string.format("%s (%.2f kg)", v24, v23)
end

function v2.ForRecord(v25) -- line 78 | captures: Assets, AssetItem, v2
    local function v26(...)
        assert(...)
    end

    v26(AssetItem.AssetItemData(v25))
    return v2.Compose(Assets.Directory[v25.Category].DisplayName or "Unknown", v25.Mutations, v25.BaseMutation)
end

function v2.MutationRun(v27, v28) -- line 82 | captures: Mutations, t, v1
    t.strict(t.table)(v27)
    t.strict(t.optional(t.string))(v28)
    local v29 = {}
    for v30, v31 in Mutations.Sanitize(v27, v28) do
        local v32 = Mutations.Get(v31)
        local v33 = v32 and ("<font color=\"#%*\">%*</font>"):format(v32.Tint:ToHex(), (v32.Label:gsub("[&<>\"]", v1)))
        v29[#v29 + 1] = v33
    end
    if #v29 == 0 then
        return nil
    end
    return (table.concat(v29, ", "))
end

return v2
