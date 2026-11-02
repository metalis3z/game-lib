-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Symbol = require(script.Parent.Symbol)
local strict = require(script.Parent.strict)
local v1 = newproxy(true)
local v2 = {}

local function addType(v3) -- line 19 | captures: Symbol, v2
    v2[v3] = Symbol.named("Roact" .. v3)
end

v2.Binding = Symbol.named("RoactBinding")
v2.Element = Symbol.named("RoactElement")
v2.HostChangeEvent = Symbol.named("RoactHostChangeEvent")
v2.HostEvent = Symbol.named("RoactHostEvent")
v2.StatefulComponentClass = Symbol.named("RoactStatefulComponentClass")
v2.StatefulComponentInstance = Symbol.named("RoactStatefulComponentInstance")
v2.VirtualNode = Symbol.named("RoactVirtualNode")
v2.VirtualTree = Symbol.named("RoactVirtualTree")

function v2.of(v4) -- line 32 | captures: v1
    if typeof(v4) == "table" then
        return v4[v1]
    end
    return nil
end

getmetatable(v1).__index = v2

getmetatable(v1).__tostring = function() -- line 42
    return "RoactType"
end

strict(v2, "Type")
return v1
