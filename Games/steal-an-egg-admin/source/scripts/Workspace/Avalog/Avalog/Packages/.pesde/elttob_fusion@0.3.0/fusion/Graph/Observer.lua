-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local checkLifetime = require(Parent.Memory.checkLifetime)
local castToGraph = require(Parent.Graph.castToGraph)
local depend = require(Parent.Graph.depend)
local evaluate = require(Parent.Graph.evaluate)
local nicknames = require(Parent.Utility.nicknames)
local v1 = {
    type = "Observer",
    timeliness = "eager",
    dependentSet = table.freeze({})
}
local v2 = table.freeze({ __index = v1 })

local function Observer(v3, v4) -- line 36 | captures: External, checkLifetime, castToGraph, evaluate, nicknames, v2
    local v5 = os.clock()
    if v4 == nil then
        External.logError("scopeMissing", nil, "Observers", "myScope:Observer(watching)")
    end
    local v6 = {
        lastChange = nil,
        validity = "invalid",
        scope = v3,
        createdAt = v5,
        dependencySet = {},
        _watchingGraph = castToGraph(v4),
        _changeListeners = {}
    }
    local v7 = setmetatable(v6, v2)

    local function v8() -- line 57 | captures: v7
        v7.scope = nil
        for v9 in pairs(v7.dependencySet) do
            v9.dependentSet[v7] = nil
        end
    end

    v7.oldestTask = v8
    nicknames[v7.oldestTask] = "Observer"
    table.insert(v3, v8)
    if v7._watchingGraph ~= nil then
        checkLifetime.bOutlivesA(v3, v7.oldestTask, v7._watchingGraph.scope, v7._watchingGraph.oldestTask, checkLifetime.formatters.observer)
    end
    evaluate(v7, true)
    return v7
end

function v1.onBind(v10, v11) -- line 82 | captures: External
    External.doTaskImmediate(v11)
    return v10:onChange(v11)
end

function v1.onChange(v12, v13) -- line 90
    local v14 = table.freeze({})
    v12._changeListeners[v14] = v13
    return function() -- line 96 | captures: v12, v14
        v12._changeListeners[v14] = nil
    end
end

function v1._evaluate(v15) -- line 101 | captures: External, depend
    if v15._watchingGraph ~= nil then
        depend(v15, v15._watchingGraph)
    end
    for v16, v17 in v15._changeListeners do
        External.doTaskImmediate(v17)
    end
    return true
end

table.freeze(v1)
return Observer
