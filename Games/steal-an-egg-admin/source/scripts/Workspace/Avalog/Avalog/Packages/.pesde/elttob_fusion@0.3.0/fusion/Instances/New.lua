-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local defaultProps = require(Parent.Instances.defaultProps)
local applyInstanceProps = require(Parent.Instances.applyInstanceProps)

local function New(v1, v2) -- line 19 | captures: External, defaultProps, applyInstanceProps
    if v2 == nil then
        External.logError("scopeMissing", nil, "instances using New", "myScope:New \"" .. v1 .. "\" { ... }")
    end
    return function(v3) -- line 31 | captures: v1, v2, External, defaultProps, applyInstanceProps
        local v4, v5 = pcall(Instance.new, v2)
        if not v4 then
            External.logError("cannotCreateClass", nil, v2)
        end
        local v6 = defaultProps[v2]
        if v6 ~= nil then
            for v7, v8 in pairs(v6) do
                v5[v7] = v8
            end
        end
        table.insert(v1, v5)
        applyInstanceProps(v1, v3, v5)
        return v5
    end
end

return New
