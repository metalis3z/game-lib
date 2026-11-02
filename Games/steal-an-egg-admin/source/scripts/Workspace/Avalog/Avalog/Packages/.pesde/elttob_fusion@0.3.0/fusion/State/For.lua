-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local depend = require(Parent.Graph.depend)
local peek = require(Parent.State.peek)
local castToState = require(Parent.State.castToState)
require(Parent.State.For.ForTypes)
local never = require(Parent.Utility.never)
local nicknames = require(Parent.Utility.nicknames)
local Disassembly = require(Parent.State.For.Disassembly)
local v1 = {
    type = "State",
    kind = "For",
    timeliness = "lazy"
}
local v2 = table.freeze({ __index = v1 })

local function For(v3, v4, v5) -- line 36 | captures: nicknames, Disassembly, v2
    local v6 = {
        validity = "invalid",
        createdAt = os.clock(),
        dependencySet = {},
        dependentSet = {},
        scope = v3,
        _EXTREMELY_DANGEROUS_usedAsValue = {},
        _disassembly = Disassembly(v3, v4, v5)
    }
    local v7 = setmetatable(v6, v2)

    local function v8() -- line 63 | captures: v7
        v7.scope = nil
        for v9 in pairs(v7.dependencySet) do
            v9.dependentSet[v7] = nil
        end
    end

    v7.oldestTask = v8
    nicknames[v7.oldestTask] = "For"
    table.insert(v3, v8)
    return v7
end

function v1.get(v10) -- line 76 | captures: External, never
    External.logError("stateGetWasRemoved")
    return never()
end

function v1._evaluate(v11) -- line 83 | captures: depend, peek, castToState
    if v11.scope == nil then
        return false
    end
    local scope = v11.scope
    depend(v11, v11._disassembly)
    table.clear(v11._EXTREMELY_DANGEROUS_usedAsValue)
    v11._disassembly:populate(function(v12) -- line 94 | captures: v11, depend, peek, castToState
        local v13 = castToState(v12)
        if v13 ~= nil then
            depend(v11, v13)
        end
        return peek(v12)
    end, v11._EXTREMELY_DANGEROUS_usedAsValue)
    return true
end

table.freeze(v1)
return For
