local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Bindable = require(ReplicatedStorage.UserGenerated.Concurrency.Bindable)
local SharedFastFlags = require(ReplicatedStorage.UserGenerated.FastFlags.SharedFastFlags)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local DeepCopyPureUnsafe = require(ReplicatedStorage.UserGenerated.Collections.DeepCopyPureUnsafe)
local DeepFreezeUnsafe = require(ReplicatedStorage.UserGenerated.Collections.DeepFreezeUnsafe)
local DeepEqualsPureUnsafe = require(ReplicatedStorage.UserGenerated.Collections.DeepEqualsPureUnsafe)
local ObjectPaths = require(ReplicatedStorage.UserGenerated.Strings.ObjectPaths)

local NullValue = SharedFastFlags.NullValue
local UpdateRemote = SharedFastFlags.UpdateRemote

-- metatable for flag objects
local FlagMeta = {}
FlagMeta.__index = FlagMeta

function FlagMeta:Get()
    return self.Value
end

function FlagMeta:GetAsync()
    return self.Value
end

function FlagMeta:IsLoaded()
    return self.ValueLoaded
end

table.freeze(FlagMeta)

local flags = {}       -- key -> flag object
local replicatedKeys = {} -- set of keys that are replicated
local loaded = false
local loadedBindable = Bindable.new()

local function EncodeValue(v)
    if v == nil then
        return NullValue
    end
    return v
end

local function Create(key, assertion, default, isReplicated)
    Asserts.String(key)
    Asserts.Function(assertion)
    assertion(default)
    Asserts.Optional(Asserts.Storable)(default)

    local frozen = DeepCopyPureUnsafe(default)
    DeepFreezeUnsafe(frozen)

    assert(not flags[key], ("ConflictingKeys: %s"):format(key))
    for existingKey in pairs(flags) do
        if ObjectPaths.HasHierarchicalOverlap(key, existingKey) then
            error(("ConflictingKeys: %s, %s"):format(key, existingKey))
        end
    end

    local flag = setmetatable({
        Replicated = isReplicated,
        Changed = Bindable.new(),
        Loaded = Bindable.new(),
        Key = key,
        DefaultValue = frozen,
        Assertion = assertion,
        ValueLoaded = true,
        Value = frozen,
    }, FlagMeta)

    flags[key] = flag
    if isReplicated then
        replicatedKeys[key] = true
    end
    return flag
end

local ServerFastFlags = { Loaded = loadedBindable }

function ServerFastFlags.IsA(value)
    if type(value) == "table" then
        return getmetatable(value) == FlagMeta
    end
    return false
end

function ServerFastFlags.Assert(value)
    if not (type(value) == "table" and getmetatable(value) == FlagMeta) then
        error("FastFlag", 2)
    end
    return value
end

function ServerFastFlags.Replicated(key, assertion, default)
    return Create(key, assertion, default, true)
end

function ServerFastFlags.Private(key, assertion, default)
    return Create(key, assertion, default, false)
end

function ServerFastFlags.Get(key)
    local flag = flags[key]
    if flag then
        return flag
    end
    Asserts.String(key)
    error(("UnknownKey: '%s'"):format(key))
end

function ServerFastFlags.IsLoaded()
    return loaded
end

-- Push all replicated flag values to all clients
local function syncToClients(isInitial)
    local payload = {}
    for key in pairs(replicatedKeys) do
        local flag = flags[key]
        payload[key] = EncodeValue(flag.Value)
    end
    DeepFreezeUnsafe(payload)
    UpdateRemote:FireAllClients(payload, isInitial)
end

-- Mark as loaded and fire the loaded bindable
if not loaded then
    loaded = true
    loadedBindable:Fire()
end

-- Sync replicated flags to clients on startup
task.defer(function()
    syncToClients(true)
end)

table.freeze(ServerFastFlags)
return ServerFastFlags