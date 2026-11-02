-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DeepEquals = require(ReplicatedStorage.UserGenerated.Collections.DeepEquals)
local Bindable = require(ReplicatedStorage.UserGenerated.Concurrency.Bindable)
local freeze = table.freeze
local v1 = {
    Get = function(v2) -- Get | line 10
        return v2.Value
    end
}

function v1.Set(v3, v4) -- line 13 | captures: DeepEquals
    local v5
    if v3.Assertion then
        v5 = v3.Assertion(v4)
    else
        v5 = v4
    end
    local Value = v3.Value
    v3.Value = v5
    if not DeepEquals(v5, Value) then
        v3.Changed:Fire(v5, Value)
    end
    return Value
end

local v6 = freeze(v1)
local v7 = table.freeze({ __index = v6 })
local freeze_2 = table.freeze
local v8 = {}

function v8.new(v9, v10) -- line 30 | captures: Bindable, v7
    local v11 = type(v9) == "function"
    assert(v11)
    local v12 = v9(v10)
    local v13 = {
        Changed = Bindable.new(),
        Assertion = v9,
        Value = v12
    }
    v13.Readonly = v13
    return (setmetatable(v13, v7))
end

function v8.Unasserted(v14) -- line 38 | captures: Bindable, v7
    local v15 = {
        Changed = Bindable.new(),
        Value = v14
    }
    v15.Readonly = v15
    return (setmetatable(v15, v7))
end

return freeze_2(v8)
