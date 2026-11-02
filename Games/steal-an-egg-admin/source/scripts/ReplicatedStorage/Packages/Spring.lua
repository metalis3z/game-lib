-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}

local function getIsValueValid(v2) -- line 7
    if v2 == v2 then
        return v2 ~= nil
    end
    return false
end

function v1.new(v3, v4) -- line 11 | captures: v1
    local v5
    if v3 == v3 and v3 ~= nil then
        v5 = v3
    elseif typeof(v3) == "Vector3" then
        v5 = Vector3.new(0, 0, 0)
    else
        v5 = 0
    end
    local v6 = v4 or tick
    local v7 = {
        _damper = 1,
        _speed = 1,
        _clock = v6,
        _time0 = v6(),
        _position0 = v5,
        _velocity0 = 0 * v5,
        _target = v5
    }
    return (setmetatable(v7, v1))
end

local function Impulse(v8, v9) -- line 39
    if v9 == v9 and v9 ~= nil then
        v8.Velocity += v9
    end
end

v1.Impulse = Impulse

local function TimeSkip(v10, v11) -- line 46
    local v12 = v10._clock()
    local v13, v14 = v10:_positionVelocity(v12 + v11)
    v10._position0 = v13
    v10._velocity0 = v14
    v10._time0 = v12
end

v1.TimeSkip = TimeSkip

local function getPosition(v15) -- line 54
    return v15:_positionVelocity(v15._clock())
end

v1.getPosition = getPosition

function v1.__index(v16, v17) -- line 57 | captures: v1
    if v1[v17] then
        return v1[v17]
    end
    if v17 ~= "Value" and v17 ~= "Position" and v17 ~= "p" then
        if v17 == "Velocity" or v17 == "v" then
            local v18, v19 = v16:_positionVelocity(v16._clock())
            _ = v18
            return v19
        end
        if v17 == "Target" or v17 == "t" then
            return v16._target
        end
        if v17 == "Damper" or v17 == "d" then
            return v16._damper
        end
        if v17 == "Speed" or v17 == "s" then
            return v16._speed
        end
        if v17 == "Clock" then
            return v16._clock
        end
        local v20 = ("%q is not a valid member of Spring"):format((tostring(v17)))
        error(v20, 2)
    else
        return (v16:_positionVelocity(v16._clock()))
    end
end

local function __newindex(v21, v22, v23) -- line 85
    local v24 = v21._clock()
    if not (v23 == v23 and v23 ~= nil) then
        return
    end
    if v22 ~= "Value" and v22 ~= "Position" and v22 ~= "p" then
        if v22 == "Velocity" or v22 == "v" then
            v21._position0 = v21:_positionVelocity(v24)
            v21._velocity0 = v23
            v21._time0 = v24
        elseif v22 == "Target" or v22 == "t" then
            local v25, v26 = v21:_positionVelocity(v24)
            v21._position0 = v25
            v21._velocity0 = v26
            v21._target = v23
            v21._time0 = v24
        elseif v22 == "Damper" or v22 == "d" then
            local v27, v28 = v21:_positionVelocity(v24)
            v21._position0 = v27
            v21._velocity0 = v28
            v21._damper = math.clamp(v23, 0, 1)
            v21._time0 = v24
        elseif v22 == "Speed" or v22 == "s" then
            local v29, v30 = v21:_positionVelocity(v24)
            v21._position0 = v29
            v21._velocity0 = v30
            if v23 >= 0 then
                v21._speed = v23
            else
                v21._speed = 0
            end
            v21._time0 = v24
        elseif v22 == "Clock" then
            local v31, v32 = v21:_positionVelocity(v24)
            v21._position0 = v31
            v21._velocity0 = v32
            v21._clock = v23
            v21._time0 = v23()
        else
            local v33 = ("%q is not a valid member of Spring"):format((tostring(v22)))
            error(v33, 2)
        end
    else
        local v34, v35 = v21:_positionVelocity(v24)
        _ = v34
        v21._position0 = v23
        v21._velocity0 = v35
        v21._time0 = v24
    end
end

v1.__newindex = __newindex

local function _positionVelocity(v36, v37) -- line 147
    local _position0 = v36._position0
    local _velocity0 = v36._velocity0
    local _target = v36._target
    local _damper = v36._damper
    local _speed = v36._speed
    local v38 = _speed * (v37 - v36._time0)
    local v39 = _damper * _damper
    local v40, v41, v42
    if v39 < 1 then
        local v43 = 1 - v39
        v40 = math.sqrt(v43)
        local v44 = -_damper * v38
        local v45 = math.exp(v44) / v40
        local v46 = v40 * v38
        v41 = v45 * math.cos(v46)
        local v47 = v40 * v38
        v42 = v45 * math.sin(v47)
    elseif v39 == 1 then
        local v48 = -_damper * v38
        v41 = math.exp(v48) / 1
        v42 = v41 * v38
    else
        local v49 = v39 - 1
        v40 = math.sqrt(v49)
        local v50 = (-_damper + v40) * v38
        local v51 = math.exp(v50) / (2 * v40)
        local v52 = (-_damper - v40) * v38
        local v53 = math.exp(v52) / (2 * v40)
        v41 = v51 + v53
        v42 = v51 - v53
    end
    return (v40 * v41 + _damper * v42) * _position0 + (1 - (v40 * v41 + _damper * v42)) * _target + v42 / _speed * _velocity0, -_speed * v42 * _position0 + _speed * v42 * _target + (v40 * v41 - _damper * v42) * _velocity0
end

v1._positionVelocity = _positionVelocity
return v1
