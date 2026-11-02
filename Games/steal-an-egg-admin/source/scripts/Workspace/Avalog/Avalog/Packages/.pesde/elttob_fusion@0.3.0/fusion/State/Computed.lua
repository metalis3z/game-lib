-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local parseError = require(Parent.Logging.parseError)
local isSimilar = require(Parent.Utility.isSimilar)
local never = require(Parent.Utility.never)
local depend = require(Parent.Graph.depend)
local castToState = require(Parent.State.castToState)
local peek = require(Parent.State.peek)
local doCleanup = require(Parent.Memory.doCleanup)
local deriveScope = require(Parent.Memory.deriveScope)
local checkLifetime = require(Parent.Memory.checkLifetime)
local scopePool = require(Parent.Memory.scopePool)
local nicknames = require(Parent.Utility.nicknames)
local v1 = {
    type = "State",
    kind = "Computed",
    timeliness = "lazy"
}
local v2 = table.freeze({ __index = v1 })

local function Computed(v3, v4, v5) -- line 46 | captures: External, doCleanup, nicknames, v2
    local v6 = os.clock()
    if typeof(v3) == "function" then
        External.logError("scopeMissing", nil, "Computeds", "myScope:Computed(function(use, scope) ... end)")
    elseif v5 ~= nil then
        External.logWarn("destructorRedundant", "Computed")
    end
    local v7 = {
        lastChange = nil,
        validity = "invalid",
        _EXTREMELY_DANGEROUS_usedAsValue = nil,
        _innerScope = nil,
        createdAt = v6,
        dependencySet = {},
        dependentSet = {},
        scope = v3,
        _processor = v4
    }
    local v8 = setmetatable(v7, v2)

    local function v9() -- line 71 | captures: v8, doCleanup
        v8.scope = nil
        for v10 in pairs(v8.dependencySet) do
            v10.dependentSet[v8] = nil
        end
        if v8._innerScope ~= nil then
            doCleanup(v8._innerScope)
        end
    end

    v8.oldestTask = v9
    nicknames[v8.oldestTask] = "Computed"
    table.insert(v3, v9)
    return v8
end

function v1.get(v11) -- line 86 | captures: External, never
    External.logError("stateGetWasRemoved")
    return never()
end

function v1._evaluate(v12) -- line 93 | captures: External, parseError, isSimilar, depend, castToState, peek, doCleanup, deriveScope, checkLifetime, scopePool
    if v12.scope ~= nil then
        local scope = v12.scope
        local v13 = deriveScope(scope)

        local function use(v14) -- line 101 | captures: v12, scope, depend, castToState, peek, checkLifetime
            local v15 = castToState(v14)
            if v15 ~= nil then
                checkLifetime.bOutlivesA(scope, v12.oldestTask, v15.scope, v15.oldestTask, checkLifetime.formatters.useFunction)
                depend(v12, v15)
            end
            return peek(v14)
        end

        local v16, v17 = xpcall(v12._processor, parseError, use, v13)
        local v18 = scopePool.giveIfEmpty(v13)
        if v16 then
            local v19 = isSimilar(v12._EXTREMELY_DANGEROUS_usedAsValue, v17)
            if v12._innerScope ~= nil then
                doCleanup(v12._innerScope)
            end
            v12._innerScope = v18
            v12._EXTREMELY_DANGEROUS_usedAsValue = v17
            return not v19
        end
        if v18 ~= nil then
            doCleanup(v18)
        end
        External.logErrorNonFatal("callbackError", v17)
    end
    return false
end

table.freeze(v1)
return Computed
