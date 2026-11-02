-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local checkLifetime = require(Parent.Memory.checkLifetime)
local depend = require(Parent.Graph.depend)
local evaluate = require(Parent.Graph.evaluate)
local castToState = require(Parent.State.castToState)
local peek = require(Parent.State.peek)
local ExternalTime = require(Parent.Animation.ExternalTime)
local Stopwatch = require(Parent.Animation.Stopwatch)
local lerpType = require(Parent.Animation.lerpType)
local getTweenRatio = require(Parent.Animation.getTweenRatio)
local getTweenDuration = require(Parent.Animation.getTweenDuration)
local nicknames = require(Parent.Utility.nicknames)
local v1 = {
    type = "State",
    kind = "Tween",
    timeliness = "eager"
}
local v2 = table.freeze({ __index = v1 })

local function Tween(v3, v4, v5) -- line 51 | captures: External, checkLifetime, evaluate, castToState, peek, ExternalTime, Stopwatch, nicknames, v2
    local v6 = os.clock()
    if castToState(v3) then
        External.logError("scopeMissing", nil, "Tweens", "myScope:Tween(goalState, tweenInfo)")
    end
    local v7 = castToState(v4)
    local v8
    if v7 == nil then
    else
        v8 = Stopwatch(v3, ExternalTime(v3))
    end
    local v9 = {
        lastChange = nil,
        validity = "invalid",
        _activeDuration = nil,
        _activeElapsed = nil,
        _activeFrom = nil,
        _activeTo = nil,
        _activeTweenInfo = nil,
        createdAt = v6,
        dependencySet = {},
        dependentSet = {},
        scope = v3,
        _EXTREMELY_DANGEROUS_usedAsValue = peek(v4),
        _goal = v4,
        _stopwatch = v8
    }
    v9._tweenInfo = v5 or TweenInfo.new()
    local v10 = setmetatable(v9, v2)

    local function v11() -- line 87 | captures: v10
        v10.scope = nil
        for v12 in pairs(v10.dependencySet) do
            v12.dependentSet[v10] = nil
        end
    end

    v10.oldestTask = v11
    nicknames[v10.oldestTask] = "Tween"
    table.insert(v3, v11)
    if v7 ~= nil then
        checkLifetime.bOutlivesA(v3, v10.oldestTask, v7.scope, v7.oldestTask, checkLifetime.formatters.animationGoal)
    end
    local v13 = castToState(v5)
    if v13 ~= nil then
        checkLifetime.bOutlivesA(v3, v10.oldestTask, v13.scope, v13.oldestTask, checkLifetime.formatters.parameter, "tween info")
    end
    evaluate(v10, true)
    return v10
end

function v1.get(v14) -- line 121 | captures: External
    return External.logError("stateGetWasRemoved")
end

function v1._evaluate(v15) -- line 127 | captures: External, depend, castToState, peek, lerpType, getTweenRatio, getTweenDuration
    local v16 = castToState(v15._goal)
    if v16 == nil then
        v15._EXTREMELY_DANGEROUS_usedAsValue = v15._goal
    else
        depend(v15, v16)
        local v17 = peek(v16)
        if v17 == v17 then
            local _stopwatch = v15._stopwatch
            local v18 = peek(v15._tweenInfo)
            if not (v15._activeTo == v17 and (not (v15._activeElapsed < v15._activeDuration) or v15._activeTweenInfo == v18)) then
                v15._activeDuration = getTweenDuration(v18)
                v15._activeFrom = v15._EXTREMELY_DANGEROUS_usedAsValue
                v15._activeTo = v17
                v15._activeTweenInfo = v18
                _stopwatch:zero()
                _stopwatch:unpause()
            end
            depend(v15, _stopwatch)
            v15._activeElapsed = peek(_stopwatch)
            local v19
            if v15._activeFrom == v15._activeTo then
                v19 = false
            else
                local _activeElapsed = v15._activeElapsed
                if v15._activeDuration <= _activeElapsed then
                    v19 = false
                else
                    local _activeTo = v15._activeTo
                    local v20 = typeof(_activeTo)
                    local _activeFrom = v15._activeFrom
                    v19 = v20 == typeof(_activeFrom)
                end
            end
            if not v19 then
                v15._activeFrom = v15._activeTo
                v15._activeElapsed = v15._activeDuration
                _stopwatch:pause()
            end
            local v21 = getTweenRatio(v18, v15._activeElapsed)
            local _EXTREMELY_DANGEROUS_usedAsValue = v15._EXTREMELY_DANGEROUS_usedAsValue
            local v22 = lerpType(v15._activeFrom, v15._activeTo, v21)
            if v22 ~= v22 then
                External.logWarn("tweenNanMotion")
                v22 = v15._activeTo
            end
            v15._EXTREMELY_DANGEROUS_usedAsValue = v22
            return _EXTREMELY_DANGEROUS_usedAsValue ~= v22
        end
        External.logWarn("tweenNanGoal")
    end
    return false
end

table.freeze(v1)
return Tween
