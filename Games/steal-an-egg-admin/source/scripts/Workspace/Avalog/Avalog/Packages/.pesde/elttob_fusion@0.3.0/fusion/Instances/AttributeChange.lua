-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local v1 = {}

local function AttributeChange(v2) -- line 17 | captures: External, v1
    local v3 = v1[v2]
    if v3 == nil then
        v3 = {
            type = "SpecialKey",
            kind = "AttributeChange",
            stage = "observer"
        }

        function v3.apply(v4, v5, v6, v7) -- line 26 | captures: v2, External
            local function v8(v9, ...)
                table.insert(v9, ...)
            end

            if typeof(v6) ~= "function" then
                External.logError("invalidAttributeChangeHandler", nil, v2)
            end
            v8(v5, v7:GetAttributeChangedSignal(v2):Connect(function() -- line 37 | captures: v6, v7, v2
                v6(v7:GetAttribute(v2))
            end))
        end

        v1[v2] = v3
    end
    return v3
end

return AttributeChange
