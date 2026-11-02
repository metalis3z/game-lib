-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local For = require(Parent.State.For)
local Value = require(Parent.State.Value)
local Computed = require(Parent.State.Computed)
require(Parent.State.For.ForTypes)
local parseError = require(Parent.Logging.parseError)
local doCleanup = require(Parent.Memory.doCleanup)
local v1 = {
    __index = {
        roamKeys = false,
        roamValues = false,
        invalidateInputKey = function(v2) -- invalidateInputKey | line 33
            v2._inputKeyState:set(v2.inputKey)
        end,
        invalidateInputValue = function(v3) -- invalidateInputValue | line 36
            v3._inputValueState:set(v3.inputValue)
        end,
        useOutputPair = function(v4, v5) -- useOutputPair | line 39
            local v6 = v5(v4._outputPairState)
            return v6.key, v6.value
        end
    }
}

local function SubObject(v7, v8, v9, v10) -- line 46 | captures: External, Value, Computed, parseError, doCleanup, v1
    local v11 = {
        maybeScope = v7,
        inputKey = v8,
        inputValue = v9,
        _inputKeyState = Value(v7, v8),
        _inputValueState = Value(v7, v9),
        _processor = v10
    }
    v11._outputPairState = Computed(v7, function(v12, v13) -- line 59 | captures: v11, External, parseError, doCleanup
        local v14 = v12(v11._inputKeyState)
        local v15 = v12(v11._inputValueState)
        local v16, v17, v18 = xpcall(v11._processor, parseError, v12, v13, v14, v15)
        if v16 then
            return {
                key = v17,
                value = v18
            }
        end
        v17.context = ("while processing key %* and value %*"):format(tostring(v15), (tostring(v15)))
        External.logErrorNonFatal("callbackError", v17)
        doCleanup(v13)
        table.clear(v13)
        return {
            key = nil,
            value = nil
        }
    end)
    return (setmetatable(v11, v1))
end

local function ForPairs(v19, v20, v21, v22) -- line 77 | captures: External, For, SubObject
    if typeof(v20) == "function" then
        External.logError("scopeMissing", nil, "ForPairs", "myScope:ForPairs(inputTable, function(scope, use, key, value) ... end)")
    elseif v22 ~= nil then
        External.logWarn("destructorRedundant", "ForPairs")
    end
    return For(v19, v20, function(v23, v24, v25) -- line 91 | captures: v21, SubObject
        return (SubObject(v23, v24, v25, v21))
    end)
end

return ForPairs
