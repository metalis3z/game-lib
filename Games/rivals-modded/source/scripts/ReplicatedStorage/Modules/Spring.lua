-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = {};

function u1.new(p2, p3, p4, p5) -- Line: 38
    -- upvalues: u1 (copy)
    local v6 = p2 or 0;
    local v7 = p5 or os.clock;
    local v8 = {
        _clock = v7,
        _time0 = v7(),
        _position0 = v6,
        _velocity0 = 0 * v6,
        _target = v6,
        _damper = p3 or 1,
        _speed = p4 or 1
    };

    return setmetatable(v8, u1);
end;

function u1.Impulse(p9, p10) -- Line: 58
    p9.Velocity = p9.Velocity + p10;
end;

function u1.TimeSkip(p11, p12) -- Line: 67
    local v13 = p11._clock();
    local v14, v15 = p11:_positionVelocity(v13 + p12);
    p11._position0 = v14;
    p11._velocity0 = v15;
    p11._time0 = v13;
end;

function u1.__index(p16, p17) -- Line: 143
    -- upvalues: u1 (copy)
    if u1[p17] then
        return u1[p17];
    end;

    if p17 == "Value" or (p17 == "Position" or p17 == "p") then
        local v18, _ = p16:_positionVelocity(p16._clock());

        return v18;
    end;

    if p17 == "Velocity" or p17 == "v" then
        local _, v19 = p16:_positionVelocity(p16._clock());

        return v19;
    end;

    if p17 == "Target" or p17 == "t" then
        return p16._target;
    end;

    if p17 == "Damper" or p17 == "d" then
        return p16._damper;
    end;

    if p17 == "Speed" or p17 == "s" then
        return p16._speed;
    end;

    if p17 == "Clock" then
        return p16._clock;
    end;

    error(("%q is not a valid member of Spring"):format((tostring(p17))), 2);
end;

function u1.__newindex(p20, p21, p22) -- Line: 165
    local v23 = p20._clock();

    if p21 == "Value" or (p21 == "Position" or p21 == "p") then
        local _, v24 = p20:_positionVelocity(v23);
        p20._position0 = p22;
        p20._velocity0 = v24;
        p20._time0 = v23;

        return;
    end;

    if p21 == "Velocity" or p21 == "v" then
        local v25, _ = p20:_positionVelocity(v23);
        p20._position0 = v25;
        p20._velocity0 = p22;
        p20._time0 = v23;

        return;
    end;

    if p21 == "Target" or p21 == "t" then
        local v26, v27 = p20:_positionVelocity(v23);
        p20._position0 = v26;
        p20._velocity0 = v27;
        p20._target = p22;
        p20._time0 = v23;

        return;
    end;

    if p21 == "Damper" or p21 == "d" then
        local v28, v29 = p20:_positionVelocity(v23);
        p20._position0 = v28;
        p20._velocity0 = v29;
        p20._damper = p22;
        p20._time0 = v23;

        return;
    end;

    if p21 == "Speed" or p21 == "s" then
        local v30, v31 = p20:_positionVelocity(v23);
        p20._position0 = v30;
        p20._velocity0 = v31;
        p20._speed = p22 < 0 and 0 or p22;
        p20._time0 = v23;

        return;
    end;

    if p21 ~= "Clock" then
        error(("%q is not a valid member of Spring"):format((tostring(p21))), 2);

        return;
    end;

    local v32, v33 = p20:_positionVelocity(v23);
    p20._position0 = v32;
    p20._velocity0 = v33;
    p20._clock = p22;
    p20._time0 = p22();
end;

function u1._positionVelocity(p34, p35) -- Line: 207
    local _position0 = p34._position0;
    local _velocity0 = p34._velocity0;
    local _target = p34._target;
    local _damper = p34._damper;
    local _speed = p34._speed;
    local v36 = _speed * (p35 - p34._time0);
    local v37 = _damper * _damper;
    local v38, v39, v40;

    if v37 < 1 then
        v38 = math.sqrt(1 - v37);
        local v41 = math.exp(-_damper * v36) / v38;
        v39 = v41 * math.cos(v38 * v36);
        v40 = v41 * math.sin(v38 * v36);
    elseif v37 == 1 then
        v38 = 1;
        v39 = math.exp(-_damper * v36) / v38;
        v40 = v39 * v36;
    else
        v38 = math.sqrt(v37 - 1);
        local v42 = math.exp((-_damper + v38) * v36) / (2 * v38);
        local v43 = math.exp((-_damper - v38) * v36) / (2 * v38);
        v39 = v42 + v43;
        v40 = v42 - v43;
    end;

    return (v38 * v39 + _damper * v40) * _position0 + (1 - (v38 * v39 + _damper * v40)) * _target + v40 / _speed * _velocity0, -_speed * v40 * _position0 + _speed * v40 * _target + (v38 * v39 - _damper * v40) * _velocity0;
end;

return u1;