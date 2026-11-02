-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Symbol = require(script.Parent.Symbol)
local strict = require(script.Parent.strict)
local Portal = require(script.Parent.Portal)
local v1 = newproxy(true)
local v2 = {
    Portal = Symbol.named("Portal"),
    Host = Symbol.named("Host"),
    Function = Symbol.named("Function"),
    Stateful = Symbol.named("Stateful"),
    Fragment = Symbol.named("Fragment")
}

function v2.of(v3) -- line 25 | captures: v1
    if typeof(v3) == "table" then
        return v3[v1]
    end
    return nil
end

local v4 = {
    string = v2.Host,
    ["function"] = v2.Function,
    table = v2.Stateful
}

function v2.fromComponent(v5) -- line 39 | captures: Portal, v1, v4
    if v5 == Portal then
        return v1.Portal
    end
    return v4[typeof(v5)]
end

getmetatable(v1).__index = v2
strict(v2, "ElementKind")
return v1
