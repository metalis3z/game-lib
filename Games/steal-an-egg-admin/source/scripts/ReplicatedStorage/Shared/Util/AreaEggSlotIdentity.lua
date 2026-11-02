-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.strict(t.instanceIsA("Model"))
local v2 = t.strict(t.string)
local v3 = {}

local function rankOf(v4) -- line 11
    local EggSpotBottom = v4.EggSpotBottom
    local BasePart = EggSpotBottom:IsA("BasePart")
    local v5 = ("%* is missing its EggSpotBottom marker"):format((v4:GetFullName()))
    assert(BasePart, v5)
    local Position = EggSpotBottom.Position
    local v6 = { model = v4 }
    local v7 = {}
    local v8 = Position.X * 1000
    local v9 = math.round(v8)
    local v10 = Position.Z * 1000
    local v11 = math.round(v10)
    v7[1] = v9
    v7[2] = v11
    local v12 = Position.Y * 1000
    v7[3] = math.round(v12)
    v6.grid = v7
    v6.label = v4.Name
    return v6
end

local function precedes(v13, v14) -- line 27
    for v15 = 1, 3 do
        if v13.grid[v15] ~= v14.grid[v15] then
            return v13.grid[v15] < v14.grid[v15]
        end
    end
    return v13.label < v14.label
end

function v3.SortedNests(v16) -- line 42 | captures: v1, rankOf, precedes
    v1(v16)
    local Nests = v16.Nests
    local v17 = Nests:IsA("Folder") or Nests:IsA("Model")
    local v18 = ("%* must keep its nests in a Folder or a Model"):format((v16:GetFullName()))
    assert(v17, v18)
    local v19 = {}
    for v20, v21 in Nests:GetChildren() do
        if v21:IsA("Model") then
            local v22 = rankOf(v21)
            table.insert(v19, v22)
        end
    end
    table.sort(v19, precedes)
    local v23 = table.create(#v19)
    for v24, v25 in v19 do
        v23[v24] = v25.model
    end
    return v23
end

function v3.NestIdFor(v26, v27) -- line 66 | captures: v1, v3
    v1(v26)
    v1(v27)
    local v28 = v3.SortedNests(v26)
    local v29 = table.find(v28, v27)
    if v29 == nil then
        local v30 = v27:GetFullName()
        error((("%* does not sit under %*"):format(v30, (v26:GetFullName()))))
    end
    return string.format("Slot_%03d", v29)
end

function v3.NestFor(v31, v32) -- line 77 | captures: v1, v2, v3
    v1(v31)
    v2(v32)
    local v33 = string.match(v32, "^Slot_(%d+)$")
    local v34 = v33 ~= nil
    local v35 = ("%* does not name a nest slot"):format(v32)
    assert(v34, v35)
    local v36 = tonumber(v33)
    local v37 = v36 ~= nil
    local v38 = ("%* carries a slot number that will not parse"):format(v32)
    assert(v37, v38)
    local v39 = v3.SortedNests(v31)[v36]
    local v40 = v39 ~= nil
    local v41 = ("%* has nothing at slot %*"):format(v31.Name, v32)
    assert(v40, v41)
    return v39
end

function v3.SlotKey(v42, v43) -- line 91 | captures: v2
    v2(v42)
    v2(v43)
    return string.format("%s:%s", v42, v43)
end

function v3.LooksLikeFirstAreaUid(v44) -- line 96 | captures: v2
    v2(v44)
    return string.find(v44, "FirstAreaEgg_", 1, true) == 1
end

function v3.FirstAreaOwnerUserId(v45) -- line 101 | captures: v2
    v2(v45)
    local v46 = string.match(v45, "^FirstAreaEgg_(-?%d+)_")
    if v46 == nil then
        return nil
    end
    return (tonumber(v46))
end

return table.freeze(v3)
