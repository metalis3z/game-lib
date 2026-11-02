-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local checkLifetime = require(Parent.Memory.checkLifetime)
local Observer = require(Parent.Graph.Observer)
local castToState = require(Parent.State.castToState)
local peek = require(Parent.State.peek)
local v1 = {}

local function Attribute(v2) -- line 23 | captures: checkLifetime, Observer, castToState, peek, v1
    local v3 = v1[v2]
    if v3 == nil then
        v3 = {
            type = "SpecialKey",
            kind = "Attribute",
            stage = "self"
        }

        function v3.apply(v4, v5, v6, v7) -- line 32 | captures: v2, checkLifetime, Observer, castToState, peek
            if castToState(v6) then
                checkLifetime.bOutlivesA(v5, v7, v6.scope, v6.oldestTask, checkLifetime.formatters.boundAttribute, v2)
                Observer(v5, v6):onBind(function() -- line 45 | captures: v6, v7, v2, peek
                    v7:SetAttribute(v2, peek(v6))
                end)
            else
                v7:SetAttribute(v2, v6)
            end
        end

        v1[v2] = v3
    end
    return v3
end

return Attribute
