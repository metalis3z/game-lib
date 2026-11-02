-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local applyInstanceProps = require(Parent.Instances.applyInstanceProps)

local function Hydrate(v1, v2) -- line 16 | captures: External, applyInstanceProps
    if v2 == nil then
        External.logError("scopeMissing", nil, "instances using Hydrate", "myScope:Hydrate (instance) { ... }")
    end
    return function(v3) -- line 23 | captures: v1, v2, applyInstanceProps
        table.insert(v1, v2)
        applyInstanceProps(v1, v3, v2)
        return v2
    end
end

return Hydrate
