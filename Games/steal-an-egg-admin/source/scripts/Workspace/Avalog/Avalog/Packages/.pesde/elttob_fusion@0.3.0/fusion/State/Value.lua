-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local change = require(Parent.Graph.change)
local isSimilar = require(Parent.Utility.isSimilar)
local never = require(Parent.Utility.never)
local nicknames = require(Parent.Utility.nicknames)
local v1 = {
    type = "State",
    kind = "Value",
    timeliness = "lazy",
    dependencySet = table.freeze({})
}
local v2 = table.freeze({ __index = v1 })

local function Value(v3, v4) -- line 32 | captures: External, nicknames, v2
    local v5 = os.clock()
    if not (v4 ~= nil or typeof(v3) == "table" and (v3[1] ~= nil or next(v3) == nil)) then
        External.logError("scopeMissing", nil, "Value", "myScope:Value(initialValue)")
    end
    local v6 = {
        validity = "valid",
        createdAt = v5,
        dependentSet = {},
        lastChange = os.clock(),
        scope = v3,
        _EXTREMELY_DANGEROUS_usedAsValue = v4
    }
    local v7 = setmetatable(v6, v2)

    local function v8() -- line 51 | captures: v7
        v7.scope = nil
    end

    v7.oldestTask = v8
    nicknames[v7.oldestTask] = "Value"
    table.insert(v3, v8)
    return v7
end

function v1.get(v9, v10) -- line 60 | captures: External, never
    External.logError("stateGetWasRemoved")
    return never()
end

function v1.set(v11, v12) -- line 67 | captures: change, isSimilar
    local _EXTREMELY_DANGEROUS_usedAsValue = v11._EXTREMELY_DANGEROUS_usedAsValue
    if not isSimilar(_EXTREMELY_DANGEROUS_usedAsValue, v12) then
        v11._EXTREMELY_DANGEROUS_usedAsValue = v12
        change(v11)
    end
    return v12
end

function v1._evaluate(v13) -- line 79
    return true
end

table.freeze(v1)
return Value
