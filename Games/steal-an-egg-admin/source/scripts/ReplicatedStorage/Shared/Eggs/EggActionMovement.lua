-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.intersection(t.numberMinExclusive((-1/0)), t.numberMaxExclusive((1/0)))

local function u17(v2) -- line 11 | captures: v1
    if typeof(v2) == "CFrame" then
        local v3 = { v2:GetComponents() }
        for v4, v5 in ipairs(v3) do
            if not v1(v5) then
                return false
            end
        end
        return true
    end
    return false
end

local BulkPartMotion = require(ReplicatedStorage.Client.BulkPartMotion)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v6 = {}
local v7 = {}

local function collectParts(v8) -- line 30
    local PrimaryPart = v8.PrimaryPart
    local v9 = { PrimaryPart }
    for v10, v11 in v8:GetDescendants() do
        if v11:IsA("BasePart") and v11 ~= PrimaryPart then
            v11.Anchored = true
            table.insert(v9, v11)
        end
    end
    return v9
end

local function newModelState(v12) -- line 41 | captures: t, BulkPartMotion, Trove, v6, v7, collectParts
    local PrimaryPart = v12.PrimaryPart
    t.strict(t.instanceIsA("BasePart"))(PrimaryPart)
    PrimaryPart.Anchored = true
    local v13 = Trove.new()
    local v14 = {}
    local v15 = collectParts(v12)
    for v16, v17 in v15 do
        v14[v16] = BulkPartMotion.Register(v17)
    end
    v13:Add(function() -- line 54 | captures: v14
        for v18, v19 in v14 do
            v19:Destroy()
        end
    end)
    local v20 = {
        Parts = v15,
        Components = v14,
        Trove = v13
    }
    v13:Connect(v12.DescendantAdded, function(v21) -- line 68 | captures: v20, BulkPartMotion
        if not v21:IsA("BasePart") then
            return
        end
        v21.Anchored = true
        local Parts = v20.Parts
        table.insert(Parts, v21)
        v20.Components[#v20.Parts] = BulkPartMotion.Register(v21)
    end)
    v6[v12] = v20
    v13:Connect(v12.Destroying, function() -- line 78 | captures: v12, v7
        v7.Remove(v12)
    end)
    return v20
end

function v7.SetPivot(v22, v23) -- line 83 | captures: t, u17, v6, newModelState
    t.strict(t.instanceIsA("Model"))(v22)
    t.strict(u17)(v23)
    local v24 = v6[v22] or newModelState(v22)
    local v25 = v22:GetPivot()
    for v26, v27 in v24.Parts do
        local v28 = v25:ToObjectSpace(v27.CFrame)
        v24.Components[v26]:SetCFrame(v23 * v28)
    end
end

function v7.Remove(v29) -- line 102 | captures: t, v6
    t.strict(t.instanceIsA("Model"))(v29)
    local v30 = v6[v29]
    if v30 ~= nil then
        v6[v29] = nil
        v30.Trove:Destroy()
    end
end

return v7
