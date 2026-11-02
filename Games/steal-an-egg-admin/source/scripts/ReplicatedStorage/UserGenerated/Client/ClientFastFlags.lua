-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function v1(...)
    assert(...)
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
game:GetService("Players")
v1(RunService:IsClient())
local Bindable = require(ReplicatedStorage.UserGenerated.Concurrency.Bindable)
local SharedFastFlags = require(ReplicatedStorage.UserGenerated.FastFlags.SharedFastFlags)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local DeepEqualsPureUnsafe = require(ReplicatedStorage.UserGenerated.Collections.DeepEqualsPureUnsafe)
local DeepCopyPureUnsafe = require(ReplicatedStorage.UserGenerated.Collections.DeepCopyPureUnsafe)
local DeepFreezeUnsafe = require(ReplicatedStorage.UserGenerated.Collections.DeepFreezeUnsafe)
local ObjectPaths = require(ReplicatedStorage.UserGenerated.Strings.ObjectPaths)
local v2 = {}
local v3 = table.freeze({ __index = v2 })

function v2.Get(v4) -- line 19
    return v4.Value
end

function v2.GetAsync(v5) -- line 22
    if not v5.ValueLoaded then
        local v6 = coroutine.running()
        local v7 = v5.Loaded:Connect(function() -- line 27 | captures: v6
            task.spawn(v6)
        end)
        coroutine.yield()
        v7:Disconnect()
    end
    return v5.Value
end

function v2.IsLoaded(v8) -- line 34
    return v8.ValueLoaded
end

table.freeze(v2)
local NullValue = SharedFastFlags.NullValue
local v9 = {}
local v10 = false
local v11 = {}
local v12 = Bindable.new()

local function DecodeValue(v13) -- line 43 | captures: NullValue
    if v13 == NullValue then
        return nil
    end
    return v13
end

local function Create(v14, v15, v16) -- line 49 | captures: v10, v11, Bindable, Asserts, DeepCopyPureUnsafe, DeepFreezeUnsafe, ObjectPaths, v3, NullValue, v9
    Asserts.String(v14)
    Asserts.Function(v15)
    v15(v16)
    Asserts.Optional(Asserts.Storable)(v16)
    local v17 = DeepCopyPureUnsafe(v16)
    DeepFreezeUnsafe(v17)
    local v18 = not v9[v14]
    local v19 = ("ConflictingKeys: %*, %*"):format(v14, v14)
    assert(v18, v19)
    for v20, v21 in pairs(v9) do
        if ObjectPaths.HasHierarchicalOverlap(v14, v20) then
            error((("ConflictingKeys: %*, %*"):format(v14, v20)))
        end
    end
    local v22 = v11[v14]
    local v23, v24
    if v22 == nil then
        v23 = false
        v24 = v17
    else
        local v25
        if v22 == NullValue then
        else
            v25 = v22
        end
        v23 = v10
        v24 = v25
    end
    local v26 = {
        Replicated = true,
        Changed = Bindable.new(),
        Loaded = Bindable.new(),
        Key = v14,
        DefaultValue = v17,
        Assertion = v15,
        ValueLoaded = v23,
        Value = v24
    }
    local v27 = setmetatable(v26, v3)
    v9[v14] = v27
    return v27
end

local v28 = { Loaded = v12 }

function v28.IsA(v29) -- line 89 | captures: v3
    if type(v29) == "table" then
        return getmetatable(v29) == v3
    end
    return false
end

function v28.Assert(v30) -- line 97 | captures: v3
    if not (type(v30) == "table" and getmetatable(v30) == v3) then
        error("FastFlag", 2)
    end
    return v30
end

function v28.Replicated(v31, v32, v33) -- line 108 | captures: Create
    return (Create(v31, v32, v33))
end

function v28.Private(v34, v35, v36) -- line 111
    error("ServerOnly")
end

function v28.Get(v37) -- line 114 | captures: Asserts, v9
    local v38 = v9[v37]
    if v38 then
        return v38
    end
    Asserts.String(v37)
    error((("UnknownKey: '%*'"):format(v37)))
end

function v28.IsLoaded() -- line 122 | captures: v10
    return v10
end

SharedFastFlags.UpdateRemote.OnClientEvent:Connect(function(v39, v40) -- line 126 | captures: v10, v11, DeepEqualsPureUnsafe, DeepFreezeUnsafe, NullValue, v9, v12
    DeepFreezeUnsafe(v39)
    v11 = v39
    local v41 = {}
    local v42 = {}
    for v43, v44 in pairs(v39) do
        local v45 = v9[v43]
        if v45 then
            local v46
            if v44 == NullValue then
            else
                v46 = v44
            end
            local Value = v45.Value
            if not DeepEqualsPureUnsafe(v46, Value) then
                v45.Value = v46
                local v47 = {
                    instance = v45,
                    value = v46,
                    prevValue = Value
                }
                table.insert(v42, v47)
            end
            if v40 and not v45.ValueLoaded then
                v45.ValueLoaded = true
                table.insert(v41, v45)
            end
        end
    end
    local v48 = v40 and not v10
    if v48 then
        v10 = true
    end
    for v49, v50 in ipairs(v41) do
        v50.Loaded:Fire()
    end
    if v48 then
        v12:Fire()
    end
    for v51, v52 in ipairs(v42) do
        v52.instance.Changed:Fire(v52.value, v52.prevValue)
    end
end)
table.freeze(v28)
return v28
