-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedABTests = require(ReplicatedStorage.UserGenerated.ABTests.SharedABTests)
local DeepFreezeUnsafe = require(ReplicatedStorage.UserGenerated.Collections.DeepFreezeUnsafe)
local Bindable = require(ReplicatedStorage.UserGenerated.Concurrency.Bindable)
local LocalPlayer = Players.LocalPlayer
local v1 = false
local v2 = Bindable.new()
local v3

local function GetAssignmentsAsync(v4, v5) -- line 15 | captures: v3, LocalPlayer
    local v6
    if typeof(v4) == "Instance" then
        v6 = v4:IsA("Player")
    else
        v6 = false
    end
    assert(v6)
    local v7 = type(v5) == "boolean"
    assert(v7)
    if v4 == LocalPlayer then
        while true do
            local v8 = v3
            if v8 then
                return v8
            end
            if v5 and v4.Parent then
                task.wait()
                continue
            end
            break
        end
    end
    return nil
end

local v9

local function GetAttribute(v10, v11, v12) -- line 37 | captures: v9, LocalPlayer
    local v13 = type(v11) == "string"
    assert(v13)
    local v14
    if v10 == LocalPlayer then
        v14 = v9
    else
        local v15
        if typeof(v10) == "Instance" then
            v15 = v10:IsA("Player")
        else
            v15 = false
        end
        assert(v15)
    end
    local v16 = v14 and v14[v11]
    if v16 == nil then
        return v12, false
    end
    return v16, true
end

local function GetAttributeAsync(v17, v18, v19) -- line 57 | captures: GetAssignmentsAsync, GetAttribute
    local v20 = type(v18) == "string"
    assert(v20)
    if GetAssignmentsAsync(v17, true) then
        return GetAttribute(v17, v18, v19)
    end
    return v19, false
end

local v21 = Bindable.new()
local v22 = Bindable.new()
SharedABTests.UpdateRemote.OnClientEvent:Connect(function(v23, v24) -- line 67 | captures: v1, v3, v9, DeepFreezeUnsafe, LocalPlayer, v2, v21, v22
    DeepFreezeUnsafe(v23)
    DeepFreezeUnsafe(v24)
    v9 = v23
    v3 = v24
    v1 = true
    v2:Fire()
    v21:Fire(LocalPlayer)
    v22:Fire()
end)
local freeze = table.freeze
local v25 = {}

function v25.GetAttributes(v26) -- line 78 | captures: v9, LocalPlayer
    if v26 == LocalPlayer then
        return v9
    end
    local v27
    if typeof(v26) == "Instance" then
        v27 = v26:IsA("Player")
    else
        v27 = false
    end
    assert(v27)
    return nil
end

v25.GetAttribute = GetAttribute
v25.GetAttributeAsync = GetAttributeAsync
v25.GetAssignmentsAsync = GetAssignmentsAsync

function v25.GetJobAttributes() -- line 89 | captures: v9, LocalPlayer
    if LocalPlayer == LocalPlayer then
        return v9
    end
    local v28
    if typeof(LocalPlayer) == "Instance" then
        v28 = LocalPlayer:IsA("Player")
    else
        v28 = false
    end
    assert(v28)
    return nil
end

function v25.GetJobAttribute(v29, v30) -- line 98 | captures: LocalPlayer, GetAttribute
    return GetAttribute(LocalPlayer, v29, v30)
end

function v25.GetJobAttributeAsync(v31, v32) -- line 101 | captures: LocalPlayer, GetAttributeAsync
    return GetAttributeAsync(LocalPlayer, v31, v32)
end

function v25.GetJobAssignments() -- line 104 | captures: v3
    return v3
end

function v25.GetJobAssignmentsAsync(v33) -- line 107 | captures: LocalPlayer, GetAssignmentsAsync
    return (GetAssignmentsAsync(LocalPlayer, v33))
end

function v25.IsLoaded() -- line 110 | captures: v1
    return v1
end

v25.Loaded = v2
v25.PlayerUpdated = v21
v25.JobUpdated = v22
return freeze(v25)
