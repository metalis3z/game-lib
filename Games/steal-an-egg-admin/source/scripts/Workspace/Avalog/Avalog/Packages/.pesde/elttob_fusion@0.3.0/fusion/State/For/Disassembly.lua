-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local depend = require(Parent.Graph.depend)
local peek = require(Parent.State.peek)
local castToState = require(Parent.State.castToState)
require(Parent.State.For.ForTypes)
local doCleanup = require(Parent.Memory.doCleanup)
local deriveScope = require(Parent.Memory.deriveScope)
local scopePool = require(Parent.Memory.scopePool)
local nameOf = require(Parent.Utility.nameOf)
local nicknames = require(Parent.Utility.nicknames)
local v1 = {
    type = "Graph",
    kind = "For.Disassembly",
    timeliness = "lazy"
}
local v2 = table.freeze({ __index = v1 })

local function Disassembly(v3, v4, v5) -- line 46 | captures: doCleanup, nicknames, v2
    local v6 = {
        validity = "invalid",
        createdAt = os.clock(),
        dependencySet = {},
        dependentSet = {},
        scope = v3,
        _inputTable = v4,
        _constructor = v5,
        _subObjects = {}
    }
    local v7 = setmetatable(v6, v2)

    local function v8() -- line 70 | captures: v7, doCleanup
        v7.scope = nil
        for v9 in pairs(v7.dependencySet) do
            v9.dependentSet[v7] = nil
        end
        for v10 in v7._subObjects do
            if v10.maybeScope ~= nil then
                doCleanup(v10.maybeScope)
                v10.maybeScope = nil
            end
        end
    end

    v7.oldestTask = v8
    nicknames[v7.oldestTask] = "For (internal disassembler)"
    table.insert(v3, v8)
    return v7
end

function v1.populate(v11, v12, v13) -- line 89 | captures: External
    local v14 = (1/0)
    local v15 = (-1/0)
    local v16 = false
    for v17 in v11._subObjects do
        local v18, v19 = v17:useOutputPair(v12)
        if v18 == nil or v19 == nil then
            v16 = true
        elseif v13[v18] == nil then
            v13[v18] = v19
            if typeof(v18) == "number" then
                v14, v15 = math.min(v14, v18), math.max(v15, v18)
            end
        else
            External.logErrorNonFatal("forKeyCollision", nil, (tostring(v18)))
        end
    end
    if v16 and v14 < v15 then
        for v20 = v14, v15 do
            local v21 = v13[v20]
            if v21 ~= nil then
                v13[v20] = nil
                v13[v14] = v21
                v14 += 1
            end
        end
    end
end

function v1._evaluate(v22) -- line 129 | captures: External, depend, peek, castToState, doCleanup, deriveScope, scopePool, nameOf
    local scope = v22.scope
    local v23 = castToState(v22._inputTable)
    if v23 ~= nil then
        if v23.scope == nil then
            External.logError("useAfterDestroy", nil, ("The input %*"):format((nameOf(v23, "table"))), "the For object that is watching it")
        end
        depend(v22, v23)
    end
    local v24 = {}
    for v25, v26 in peek(v22._inputTable) do
        v24[v25] = v26
    end
    local v27 = {}
    for v28 in v22._subObjects do
        local inputKey = v28.inputKey
        local inputValue = v28.inputValue
        local v29, v30
        if v28.roamKeys or v24[inputKey] == nil then
            v29 = false
            for v31, v32 in v24 do
                if v28.roamValues then
                    v29 = true
                    v30 = v31
                    break
                end
                if v32 == inputValue then
                    v29 = true
                    v30 = v31
                    break
                end
                v29 = true
                v30 = v31
            end
        else
            v29 = true
            v30 = inputKey
        end
        if v29 then
            local v33 = v24[v30]
            v27[v28] = true
            if v30 ~= inputKey then
                v28.inputKey = v30
                v28:invalidateInputKey()
            end
            if v33 ~= inputValue then
                v28.inputValue = v33
                v28:invalidateInputValue()
            end
            v24[v30] = nil
        elseif v28.maybeScope ~= nil then
            doCleanup(v28.maybeScope)
            v28.maybeScope = nil
        end
    end
    for v34, v35 in v24 do
        local v36 = v22._constructor(deriveScope(scope), v34, v35)
        if v36.maybeScope ~= nil then
            v36.maybeScope = scopePool.giveIfEmpty(v36.maybeScope)
        end
        v27[v36] = true
    end
    v22._subObjects = v27
    return true
end

table.freeze(v1)
return Disassembly
