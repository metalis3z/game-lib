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
        roamKeys = true,
        roamValues = false,
        invalidateInputKey = function(v2) -- invalidateInputKey | line 33
        end,
        invalidateInputValue = function(v3) -- invalidateInputValue | line 36
            v3._inputValueState:set(v3.inputValue)
        end,
        useOutputPair = function(v4, v5) -- useOutputPair | line 39
            return v4.inputKey, v5(v4._outputValueState)
        end
    }
}

local function SubObject(v6, v7, v8, v9) -- line 45 | captures: External, Value, Computed, parseError, doCleanup, v1
    local v10 = {
        maybeScope = v6,
        inputKey = v7,
        inputValue = v8,
        _inputValueState = Value(v6, v8),
        _processor = v9
    }
    v10._outputValueState = Computed(v6, function(v11, v12) -- line 57 | captures: v10, External, parseError, doCleanup
        local v13 = v11(v10._inputValueState)
        local v14, v15 = xpcall(v10._processor, parseError, v11, v12, v13)
        if v14 then
            return v15
        end
        v15.context = ("while processing value %*"):format((tostring(v13)))
        External.logErrorNonFatal("callbackError", v15)
        doCleanup(v12)
        table.clear(v12)
        return nil
    end)
    return (setmetatable(v10, v1))
end

local function ForValues(v16, v17, v18, v19) -- line 74 | captures: External, For, SubObject
    if typeof(v17) == "function" then
        External.logError("scopeMissing", nil, "ForValues", "myScope:ForValues(inputTable, function(scope, use, value) ... end)")
    elseif v19 ~= nil then
        External.logWarn("destructorRedundant", "ForValues")
    end
    return For(v16, v17, function(v20, v21, v22) -- line 88 | captures: v18, SubObject
        return (SubObject(v20, v21, v22, v18))
    end)
end

return ForValues
