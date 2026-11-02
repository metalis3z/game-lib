-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local change = require(Parent.Graph.change)
local nicknames = require(Parent.Utility.nicknames)
local v1 = {
    type = "State",
    kind = "ExternalTime",
    timeliness = "lazy",
    dependencySet = table.freeze({}),
    _EXTREMELY_DANGEROUS_usedAsValue = External.lastUpdateStep()
}
local v2 = table.freeze({ __index = v1 })
local v3 = {}

local function ExternalTime(v4) -- line 33 | captures: nicknames, v2, v3
    local v5 = {
        lastChange = nil,
        validity = "invalid",
        createdAt = os.clock(),
        dependentSet = {},
        scope = v4
    }
    local v6 = setmetatable(v5, v2)

    local function v7() -- line 47 | captures: v6, v3
        v6.scope = nil
        local v8 = table.find(v3, v6)
        if v8 ~= nil then
            table.remove(v3, v8)
        end
    end

    v6.oldestTask = v7
    nicknames[v6.oldestTask] = "ExternalTime"
    table.insert(v4, v7)
    table.insert(v3, v6)
    return v6
end

local function _evaluate(v9) -- line 61
    return true
end

v1._evaluate = _evaluate
External.bindToUpdateStep(function(v10) -- line 72 | captures: External, change, v1, v3
    v1._EXTREMELY_DANGEROUS_usedAsValue = External.lastUpdateStep()
    for v11, v12 in v3 do
        change(v12)
    end
end)
return ExternalTime
