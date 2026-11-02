-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Packages.Promise)
local Log = require(ReplicatedStorage.Packages.Log)
local NewUid = require(ReplicatedStorage.Shared.Utils.Codec).NewUid
local Signal = require(ReplicatedStorage.Packages.Signal)
local t = require(ReplicatedStorage.Packages.t)
local v1 = Log.new()
local v2

local function defaultKeyOf(v3) -- line 14 | captures: t
    t.strict(t.instanceIsA("Player"))(v3)
    return v3.UserId
end

local function locate(v4, v5) -- line 19
    local v6 = v4.keyOf(v5)
    local v7 = assert(v6, "the key parser produced nothing for this player")
    return v4.store[v7], v7
end

local v8 = {
    ProfileRemoving = Signal.new(),
    ProfileAdded = Signal.new(),
    is = function(v9) -- is | line 27 | captures: v2
        return typeof(v9) == "table" and getmetatable(v9) == v2
    end
}

function v8.new(v10, v11) -- line 36 | captures: v2, NewUid, t, defaultKeyOf
    t.strict(t.optional(t.callback))(v11)
    t.strict(t.optional(t.table))(v10)
    local v12 = { id = NewUid() }
    v12.store = v10 or {}
    v12.keyOf = v11 or defaultKeyOf
    local v13 = v2
    return (setmetatable(v12, v13))
end

function v8.Get(v14, v15) -- line 54 | captures: Promise
    local v16 = v14.keyOf(v15)
    local v17 = assert(v16, "the key parser produced nothing for this player")
    local v18 = v14.store[v17]
    if v18 == nil then
        return Promise.reject("no profile is registered under that lookup"), false
    end
    return Promise.resolve(v18), true
end

function v8.GetAll(v19) -- line 65
    return table.clone(v19.store)
end

function v8.GetAssert(v20, v21) -- line 68
    return v20:Get(v21):expect()
end

function v8.GetAsync(v22, v23) -- line 71 | captures: v2, Promise, locate
    local v24 = v22.keyOf(v23)
    local v25 = assert(v24, "the key parser produced nothing for this player")
    local v26 = v22.store[v25]
    if v26 then
        return v26
    end
    local v27 = select(2, locate(v22, v23))

    local function mine(v28, v29, v30) -- line 79 | captures: v22, v27
        if v28 == v22.id then
            return v29 == v27
        end
        return false
    end

    local v31 = Promise.fromEvent(v2.ProfileAdded, mine):andThen(function(v32, v33, v34) -- line 84
        return v34
    end)
    local v35 = Promise.fromEvent(v2.ProfileRemoving, mine):andThen(function() -- line 88 | captures: v27, Promise
        return Promise.reject((("player %* left before a profile arrived"):format(v27)))
    end)
    return Promise.race({ v31, v35 }):expect()
end

function v8.IsProfileRegistered(v36, v37) -- line 93
    local v38 = v36.keyOf(v37)
    local v39 = assert(v38, "the key parser produced nothing for this player")
    return not not v36.store[v39]
end

function v8.Set(v40, v41, ...) -- line 98 | captures: v2
    local v42 = v40.keyOf(v41)
    local v43 = assert(v42, "the key parser produced nothing for this player")
    local v44 = v40.store[v43]
    v40.store[v43] = ...
    if not v44 then
        v2.ProfileAdded:Fire(v40.id, v43, ...)
    end
end

function v8.Remove(v45, v46) -- line 108 | captures: v2, v1
    local v47 = v45.keyOf(v46)
    local v48 = assert(v47, "the key parser produced nothing for this player")
    local v49 = v45.store[v48]
    if v49 == nil then
        return false, v1:AtWarning():Log((("nothing to remove for an unloaded player: %*"):format(v48)))
    end
    v2.ProfileRemoving:Fire(v45.id, v48, v49)
    v45.store[v48] = nil
    return true
end

v2 = v8
v2.__index = v2
return v2
