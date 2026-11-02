-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local checkLifetime = require(Parent.Memory.checkLifetime)
local castToState = require(Parent.State.castToState)
local v1 = {}

local function Out(v2) -- line 21 | captures: External, checkLifetime, castToState, v1
    local v3 = v1[v2]
    if v3 == nil then
        v3 = {
            type = "SpecialKey",
            kind = "Out",
            stage = "observer"
        }

        function v3.apply(v4, v5, v6, v7) -- line 30 | captures: v2, External, checkLifetime, castToState
            local function v8(v9, ...)
                table.insert(v9, ...)
            end

            local v10, v11 = pcall(v7.GetPropertyChangedSignal, v7, v2)
            if not v10 then
                External.logError("invalidOutProperty", nil, v7.ClassName, v2)
            end
            if not castToState(v6) then
                External.logError("invalidOutType")
            end
            if v6.kind ~= "Value" then
                External.logError("invalidOutType")
            end
            checkLifetime.bOutlivesA(v5, v7, v6.scope, v6.oldestTask, checkLifetime.formatters.propertyOutputsTo, v2)
            v6:set(v7[v2])
            v8(v5, v11:Connect(function() -- line 58 | captures: v6, v7, v2
                v6:set(v7[v2])
            end))
        end

        v1[v2] = v3
    end
    return v3
end

return Out
