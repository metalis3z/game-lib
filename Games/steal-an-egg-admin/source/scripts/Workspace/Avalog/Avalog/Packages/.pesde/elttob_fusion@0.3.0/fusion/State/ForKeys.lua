-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local doCleanup = require(Parent.Memory.doCleanup)
local For = require(Parent.State.For)
local Value = require(Parent.State.Value)
local Computed = require(Parent.State.Computed)
require(Parent.State.For.ForTypes)
local parseError = require(Parent.Logging.parseError)
local v1 = {
    __index = {
        roamKeys = false,
        roamValues = true,
        invalidateInputKey = function(v2) -- invalidateInputKey | line 33
            v2._inputKeyState:set(v2.inputKey)
        end,
        invalidateInputValue = function(v3) -- invalidateInputValue | line 36
        end,
        useOutputPair = function(v4, v5) -- useOutputPair | line 39
            return v5(v4._outputKeyState), v4.inputValue
        end
    }
}

local function SubObject(v6, v7, v8, v9) -- line 45 | captures: External, doCleanup, Value, Computed, parseError, v1
    local v10 = {
        maybeScope = v6,
        inputKey = v7,
        inputValue = v8,
        _inputKeyState = Value(v6, v7),
        _processor = v9
    }
    v10._outputKeyState = Computed(v6, function(v11, v12) -- line 57 | captures: v10, External, doCleanup, parseError
        local v13 = v11(v10._inputKeyState)
        local v14, v15 = xpcall(v10._processor, parseError, v11, v12, v13)
        if v14 then
            return v15
        end
        v15.context = ("while processing key %*"):format((tostring(v13)))
        External.logErrorNonFatal("callbackError", v15)
        doCleanup(v12)
        table.clear(v12)
        return nil
    end)
    return (setmetatable(v10, v1))
end

local function ForKeys(v16, v17, v18, v19) -- line 74 | captures: External, For, SubObject
    if typeof(v17) == "function" then
        External.logError("scopeMissing", nil, "ForKeys", "myScope:ForKeys(inputTable, function(scope, use, key) ... end)")
    elseif v19 ~= nil then
        External.logWarn("destructorRedundant", "ForKeys")
    end
    return For(v16, v17, function(v20, v21, v22) -- line 88 | captures: v18, SubObject
        return (SubObject(v20, v21, v22, v18))
    end)
end

return ForKeys
