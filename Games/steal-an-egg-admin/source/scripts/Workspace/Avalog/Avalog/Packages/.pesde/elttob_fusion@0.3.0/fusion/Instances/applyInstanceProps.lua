-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local parseError = require(Parent.Logging.parseError)
local checkLifetime = require(Parent.Memory.checkLifetime)
local Observer = require(Parent.Graph.Observer)
local castToState = require(Parent.State.castToState)
local peek = require(Parent.State.peek)
local xtypeof = require(Parent.Utility.xtypeof)

local function setProperty_unsafe(v1, v2, v3) -- line 34
    v1[v2] = v3
end

local function testPropertyAssignable(v4, v5) -- line 42
    v4[v5] = v4[v5]
end

local function setProperty(v6, v7, v8) -- line 49 | captures: External, parseError, setProperty_unsafe, testPropertyAssignable
    local v9, v10 = xpcall(setProperty_unsafe, parseError, v6, v7, v8)
    if not v9 then
        local v11, v12
        if pcall(testPropertyAssignable, v6, v7) then
            v11 = typeof(v8)
            local v13 = v6[v7]
            v12 = typeof(v13)
            if v11 == v12 then
                External.logErrorNonFatal("propertySetError", v10)
                return
            end
        else
            External.logErrorNonFatal("cannotAssignProperty", nil, v6.ClassName, v7)
            return
        end
        External.logErrorNonFatal("invalidPropertyType", nil, v6.ClassName, v7, v12, v11)
    end
end

local function bindProperty(v14, v15, v16, v17) -- line 74 | captures: checkLifetime, Observer, castToState, peek, setProperty
    if castToState(v17) then
        checkLifetime.bOutlivesA(v14, v15, v17.scope, v17.oldestTask, checkLifetime.formatters.boundProperty, v16)
        Observer(v14, v17):onBind(function() -- line 88 | captures: v15, v16, v17, peek, setProperty
            setProperty(v15, v16, peek(v17))
        end)
    else
        setProperty(v15, v16, v17)
    end
end

local function applyInstanceProps(v18, v19, v20) -- line 97 | captures: External, xtypeof, bindProperty
    local v21 = {
        self = {},
        descendants = {},
        ancestor = {},
        observer = {}
    }
    for v22, v23 in pairs(v19) do
        local v24 = xtypeof(v22)
        if v24 == "string" then
            if v22 ~= "Parent" then
                bindProperty(v18, v20, v22, v23)
            end
        elseif v24 == "SpecialKey" then
            local stage = v22.stage
            local v25 = v21[stage]
            if v25 == nil then
                External.logError("unrecognisedPropertyStage", nil, stage)
            else
                v25[v22] = v23
            end
        else
            External.logError("unrecognisedPropertyKey", nil, v24)
        end
    end
    for v26, v27 in pairs(v21.self) do
        v26:apply(v18, v27, v20)
    end
    for v28, v29 in pairs(v21.descendants) do
        v28:apply(v18, v29, v20)
    end
    if v19.Parent ~= nil then
        bindProperty(v18, v20, "Parent", v19.Parent)
    end
    for v30, v31 in pairs(v21.ancestor) do
        v30:apply(v18, v31, v20)
    end
    for v32, v33 in pairs(v21.observer) do
        v32:apply(v18, v33, v20)
    end
end

return applyInstanceProps
