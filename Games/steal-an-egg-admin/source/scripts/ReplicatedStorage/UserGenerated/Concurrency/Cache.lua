-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Bindable = require(ReplicatedStorage.UserGenerated.Concurrency.Bindable)
local DeepFreeze = require(game.ReplicatedStorage.UserGenerated.Collections.DeepFreeze)
local Lock = require(game.ReplicatedStorage.UserGenerated.Concurrency.Lock)
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts)

local function ValueAge(v1, v2) -- line 11
    local RetrievedAt = v1.RetrievedAt
    if RetrievedAt then
        return v2 - RetrievedAt
    end
    return nil
end

local function AttemptAge(v3, v4) -- line 18
    local AttemptedAt = v3.AttemptedAt
    if AttemptedAt then
        return v4 - AttemptedAt
    end
    return (1/0)
end

local v5 = {
    RemoveUsedAt = function(v6, v7) -- RemoveUsedAt | line 26
    end,
    InsertUsedAt = function(v8, v9) -- InsertUsedAt | line 27
    end,
    SetUsedAt = function(v10, v11, v12) -- SetUsedAt | line 28
        v10:RemoveUsedAt(v11)
        v11.UsedAt = v12
        v10:InsertUsedAt(v11)
    end,
    Get = function(v13, v14) -- Get | line 33
        local v15 = v13.Cache[v13.AssertKey(v14)]
        if v15 then
            local v16 = os.clock()
            local RetrievedAt = v15.RetrievedAt
            local v17 = if RetrievedAt then v16 - RetrievedAt else nil
            if v17 then
                if v17 < v13.MaxAge then
                    v13:SetUsedAt(v15, v16)
                    return v15.Value
                end
                if v13.ReturnStale then
                    v13:SetUsedAt(v15, v16)
                    return v15.Value
                end
            end
        end
        return nil
    end
}

function AsyncCallback(v18, v19, v20, v21) -- line 60 | captures: DeepFreeze
    local RetrievedAt = v19.RetrievedAt
    local v22 = if RetrievedAt then v21 - RetrievedAt else nil
    if v22 then
        if v22 < v18.MaxAge then
            return v19.Value
        end
    else
        local AttemptedAt = v19.AttemptedAt
        local v23 = if AttemptedAt then v21 - AttemptedAt else (1/0)
        if not (v23 < v18.FailureRetryDelay) then
            v19.AttemptedAt = v21
            local v24, v25 = pcall(v18.Callback, v20)
            local v26 = os.clock()
            v19.AttemptedAt = v26
            v18:SetUsedAt(v19, v26)
            if v24 then
                if v18.Freeze then
                    v25 = DeepFreeze(v25)
                end
                v19.Value = v25
                v19.RetrievedAt = v26
                v18.Updated:Fire(v20)
                return v25
            end
        end
        if v18.ReturnStale then
            return v19.Value
        end
        return nil
    end
end

function v5.GetAsync(v27, v28) -- line 104 | captures: Lock
    local v29 = os.clock()
    local v30 = v27.AssertKey(v28)
    local v31 = v27.Cache[v30]
    if v31 then
        v27:SetUsedAt(v31, v29)
    else
        v31 = {
            Lock = Lock.new(),
            UsedAt = v29
        }
        v27.Cache[v30] = v31
        v27:InsertUsedAt(v31)
    end
    return v31.Lock:Call(AsyncCallback, v27, v31, v28, v29)
end

function v5.Delete(v32, v33) -- line 118
    local v34 = v32.AssertKey(v33)
    if v32.Cache[v34] then
        v32.Cache[v34] = nil
        v32.Deleted:Fire(v33)
    end
end

local v35 = table.freeze({ __index = table.freeze(v5) })
local v36 = Asserts.Table({
    Callback = Asserts.Function,
    AssertKey = Asserts.Function,
    MaxAge = Asserts.Optional(Asserts.NonNegative),
    FailureRetryDelay = Asserts.Optional(Asserts.NonNegative),
    ReturnStale = Asserts.Optional(Asserts.Boolean),
    Freeze = Asserts.Optional(Asserts.Boolean)
})
local freeze = table.freeze
local v37 = {}

function v37.new(v38) -- line 135 | captures: Bindable, v35, v36
    v36(v38)
    local v39 = {
        Updated = Bindable.new(),
        Deleted = Bindable.new(),
        Callback = v38.Callback,
        AssertKey = v38.AssertKey,
        MaxAge = v38.MaxAge or (1/0),
        FailureRetryDelay = v38.FailureRetryDelay or 300
    }
    if v38.ReturnStale == nil then
        v39.ReturnStale = true
    else
        v39.ReturnStale = v38.ReturnStale
    end
    if v38.Freeze == nil then
        v39.Freeze = true
    else
        v39.Freeze = v38.Freeze
    end
    v39.Cache = {}
    local v40 = setmetatable(v39, v35)
    table.freeze(v40)
    return v40
end

return freeze(v37)
