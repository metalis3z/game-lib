-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local checkLifetime = require(Parent.Memory.checkLifetime)
local castToState = require(Parent.State.castToState)
local v1 = {}

local function AttributeOut(v2) -- line 21 | captures: External, checkLifetime, castToState, v1
    local v3 = v1[v2]
    if v3 == nil then
        v3 = {
            type = "SpecialKey",
            kind = "AttributeOut",
            stage = "observer"
        }

        function v3.apply(v4, v5, v6, v7) -- line 30 | captures: v2, External, checkLifetime, castToState
            local function v8(v9, ...)
                table.insert(v9, ...)
            end

            local v10 = v7:GetAttributeChangedSignal(v2)
            if not castToState(v6) then
                External.logError("invalidAttributeOutType")
            end
            if v6.kind ~= "Value" then
                External.logError("invalidAttributeOutType")
            end
            checkLifetime.bOutlivesA(v5, v7, v6.scope, v6.oldestTask, checkLifetime.formatters.attributeOutputsTo, v2)
            v6:set(v7:GetAttribute(v2))
            v8(v5, v10:Connect(function() -- line 53 | captures: v6, v7, v2
                v6:set(v7:GetAttribute(v2))
            end))
        end

        v1[v2] = v3
    end
    return v3
end

return AttributeOut
