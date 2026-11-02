-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local checkLifetime = require(Parent.Memory.checkLifetime)
local depend = require(Parent.Graph.depend)
local change = require(Parent.Graph.change)
local evaluate = require(Parent.Graph.evaluate)
local castToState = require(Parent.State.castToState)
local peek = require(Parent.State.peek)
local ExternalTime = require(Parent.Animation.ExternalTime)
local Stopwatch = require(Parent.Animation.Stopwatch)
local packType = require(Parent.Animation.packType)
local unpackType = require(Parent.Animation.unpackType)
local springCoefficients = require(Parent.Animation.springCoefficients)
local nicknames = require(Parent.Utility.nicknames)
local v1 = {
    type = "State",
    kind = "Spring",
    timeliness = "eager"
}
local v2 = table.freeze({ __index = v1 })

local function Spring(v3, v4, v5, v6) -- line 60 | captures: External, checkLifetime, evaluate, castToState, peek, ExternalTime, Stopwatch, nicknames, v2
    local v7 = os.clock()
    if not (typeof(v3) == "table" and castToState(v3) == nil) then
        External.logError("scopeMissing", nil, "Springs", "myScope:Spring(goalState, speed, damping)")
    end
    local v8 = castToState(v4)
    local v9
    if v8 == nil then
    else
        v9 = Stopwatch(v3, ExternalTime(v3))
        v9:unpause()
    end
    local v10 = v5 or 10
    local v11 = v6 or 1
    local v12 = {
        lastChange = nil,
        validity = "invalid",
        _activeDamping = -1,
        _activeGoal = nil,
        _activeNumSprings = 0,
        _activeSpeed = -1,
        _activeType = "",
        createdAt = v7,
        dependencySet = {},
        dependentSet = {},
        scope = v3,
        _activeLatestP = {},
        _activeLatestV = {},
        _activeStartP = {},
        _activeStartV = {},
        _activeTargetP = {},
        _damping = v11,
        _EXTREMELY_DANGEROUS_usedAsValue = peek(v4),
        _goal = v4,
        _speed = v10,
        _stopwatch = v9
    }
    local v13 = setmetatable(v12, v2)

    local function v14() -- line 107 | captures: v13
        v13.scope = nil
        for v15 in pairs(v13.dependencySet) do
            v15.dependentSet[v13] = nil
        end
    end

    v13.oldestTask = v14
    nicknames[v13.oldestTask] = "Spring"
    table.insert(v3, v14)
    if v8 ~= nil then
        checkLifetime.bOutlivesA(v3, v13.oldestTask, v8.scope, v8.oldestTask, checkLifetime.formatters.animationGoal)
    end
    local v16 = castToState(v10)
    if v16 ~= nil then
        checkLifetime.bOutlivesA(v3, v13.oldestTask, v16.scope, v16.oldestTask, checkLifetime.formatters.parameter, "speed")
    end
    local v17 = castToState(v11)
    if v17 ~= nil then
        checkLifetime.bOutlivesA(v3, v13.oldestTask, v17.scope, v17.oldestTask, checkLifetime.formatters.parameter, "damping")
    end
    evaluate(v13, true)
    return v13
end

function v1.addVelocity(v18, v19) -- line 148 | captures: External, change, evaluate, unpackType
    evaluate(v18, false)
    local v20 = typeof(v19)
    if v20 ~= v18._activeType then
        External.logError("springTypeMismatch", nil, v20, v18._activeType)
    end
    local v21 = unpackType(v19, v20)
    for v22, v23 in v18._activeLatestV do
        v21[v22] += v23
    end
    v18._activeStartP = table.clone(v18._activeLatestP)
    v18._activeStartV = v21
    v18._stopwatch:zero()
    v18._stopwatch:unpause()
    change(v18)
end

function v1.get(v24) -- line 168 | captures: External
    return External.logError("stateGetWasRemoved")
end

function v1.setPosition(v25, v26) -- line 174 | captures: External, change, evaluate, unpackType
    evaluate(v25, false)
    local v27 = typeof(v26)
    if v27 ~= v25._activeType then
        External.logError("springTypeMismatch", nil, v27, v25._activeType)
    end
    v25._activeStartP = unpackType(v26, v27)
    v25._activeStartV = table.clone(v25._activeLatestV)
    v25._stopwatch:zero()
    v25._stopwatch:unpause()
    change(v25)
end

function v1.setVelocity(v28, v29) -- line 190 | captures: External, change, evaluate, unpackType
    evaluate(v28, false)
    local v30 = typeof(v29)
    if v30 ~= v28._activeType then
        External.logError("springTypeMismatch", nil, v30, v28._activeType)
    end
    v28._activeStartP = table.clone(v28._activeLatestP)
    v28._activeStartV = unpackType(v29, v30)
    v28._stopwatch:zero()
    v28._stopwatch:unpause()
    change(v28)
end

function v1._evaluate(v31) -- line 206 | captures: External, depend, castToState, peek, packType, unpackType, springCoefficients
    local v32 = castToState(v31._goal)
    if v32 == nil then
        v31._EXTREMELY_DANGEROUS_usedAsValue = v31._goal
    else
        local v33 = peek(v32)
        if v33 == v33 then
            local v34 = typeof(v33)
            local v35 = v34 ~= v31._activeType
            local _stopwatch = v31._stopwatch
            local v36 = peek(_stopwatch)
            depend(v31, _stopwatch)
            local _EXTREMELY_DANGEROUS_usedAsValue = v31._EXTREMELY_DANGEROUS_usedAsValue
            local v37
            if v35 then
                v37 = v33
            elseif v36 <= 0 then
                v37 = _EXTREMELY_DANGEROUS_usedAsValue
            else
                local v38, v39, v40, v41 = springCoefficients(v36, v31._activeDamping, v31._activeSpeed)
                local _activeNumSprings = v31._activeNumSprings
                local v42 = false
                for v43 = 1, _activeNumSprings do
                    local v44 = v31._activeStartP[v43]
                    local v45 = v31._activeTargetP[v43]
                    local v46 = v31._activeStartV[v43]
                    local v47 = v44 - v45
                    local v48 = v47 * v38 + v46 * v39
                    local v49 = v47 * v40 + v46 * v41
                    if not (v48 == v48 and v49 == v49) then
                        External.logWarn("springNanMotion")
                        v48 = 0
                        v49 = 0
                    end
                    if math.abs(v48) > 0.00001 or math.abs(v49) > 0.00001 then
                        v42 = true
                    end
                    local v50 = v48 + v45
                    v31._activeLatestP[v43] = v50
                    v31._activeLatestV[v43] = v49
                end
                if not v42 then
                    local _activeNumSprings = v31._activeNumSprings
                    for v51 = 1, _activeNumSprings do
                        v31._activeLatestP[v51] = v31._activeTargetP[v51]
                    end
                end
                v37 = packType(v31._activeLatestP, v31._activeType)
            end
            local v52 = peek(v31._speed)
            local v53 = peek(v31._damping)
            if v35 or not (v33 == v31._activeGoal) or not (v52 == v31._activeSpeed) or not (v53 == v31._activeDamping) then
                v31._activeTargetP = unpackType(v33, v34)
                v31._activeNumSprings = #v31._activeTargetP
                if v35 then
                    v31._activeStartP = table.clone(v31._activeTargetP)
                    v31._activeLatestP = table.clone(v31._activeTargetP)
                    v31._activeStartV = table.create(v31._activeNumSprings, 0)
                    v31._activeLatestV = table.create(v31._activeNumSprings, 0)
                else
                    v31._activeStartP = table.clone(v31._activeLatestP)
                    v31._activeStartV = table.clone(v31._activeLatestV)
                end
                v31._activeType = v34
                v31._activeGoal = v33
                v31._activeDamping = v53
                v31._activeSpeed = v52
                _stopwatch:zero()
                _stopwatch:unpause()
            end
            v31._EXTREMELY_DANGEROUS_usedAsValue = v37
            return _EXTREMELY_DANGEROUS_usedAsValue ~= v37
        end
        External.logWarn("springNanGoal")
    end
    return false
end

table.freeze(v1)
return Spring
