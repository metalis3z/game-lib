-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Quaternion = require(ReplicatedStorage.Modules:WaitForChild("Quaternion"));
local u1 = {
    _type = "QuaternionSpring"
};

function u1.new(p2: any, p3: number?, p4: number?, p5: (() -> number)?) -- Line: 119
    -- upvalues: Quaternion (copy), u1 (copy)
    local v6 = p2 or Quaternion.identity;
    local v7 = p5 or os.clock;
    local v8 = {
        _velocity = Vector3.new(0, 0, 0),
        _clock = v7,
        _time = v7(),
        _position = v6,
        _target = v6,
        _damping = p3 or 1,
        _speed = p4 or 1,
        _initial = v6
    };

    return setmetatable(v8, u1);
end;

function u1.Reset(p9, p10) -- Line: 148
    local v11 = p10 or p9._initial;
    p9._position = v11;
    p9._target = v11;
    p9._velocity = Vector3.new(0, 0, 0);
end;

function u1.Impulse(p12: any, p13: vector) -- Line: 170
    p12._velocity = p12._velocity + p13;
end;

local function _positionVelocity(p14: any, p15: number) -- Line: 177
    local _position = p14._position;
    local _velocity = p14._velocity;
    local _target = p14._target;
    local _damping = p14._damping;
    local _speed = p14._speed;
    local v16 = _speed * (p15 - p14._time);
    local v17 = _damping * _damping;
    local v18, v19, v20;

    if v17 < 1 then
        v18 = math.sqrt(1 - v17);
        local v21 = math.exp(-_damping * v16) / v18;
        v19 = v21 * math.cos(v18 * v16);
        v20 = v21 * math.sin(v18 * v16);
    elseif v17 == 1 then
        v19 = math.exp(-_damping * v16);
        v20 = v19 * v16;
        v18 = 1;
    else
        v18 = math.sqrt(v17 - 1);
        local v22 = 2 * v18;
        local v23 = math.exp((-_damping + v18) * v16) / v22;
        local v24 = math.exp((-_damping - v18) * v16) / v22;
        v19 = v23 + v24;
        v20 = v23 - v24;
    end;

    local v25 = _position:Slerp(_target, 1 - (v18 * v19 + _damping * v20)):Integrate(_velocity, v20 / _speed);
    local v26, v27 = _position:Difference(_target):ToAxisAngle();

    return v25, v26 * v27 * (_speed * v20) + _velocity * (v18 * v19 - _damping * v20);
end;

function u1.TimeSkip(p28: any, p29: number) -- Line: 228
    -- upvalues: _positionVelocity (copy)
    local v30 = p28._clock();
    local v31, v32 = _positionVelocity(p28, v30 + p29);
    p28._position = v31;
    p28._velocity = v32;
    p28._time = v30;
end;

function u1.__index(p33: any, p34: string) -- Line: 238
    -- upvalues: u1 (copy), _positionVelocity (copy)
    if u1[p34] then
        return u1[p34];
    end;

    if p34 == "Position" or p34 == "p" then
        local v35, _ = _positionVelocity(p33, p33._clock());

        return v35;
    end;

    if p34 == "Velocity" or p34 == "v" then
        local _, v36 = _positionVelocity(p33, p33._clock());

        return v36;
    end;

    if p34 == "Target" or p34 == "t" then
        return p33._target;
    end;

    if p34 == "Damping" or p34 == "d" then
        return p33._damping;
    end;

    if p34 == "Speed" or p34 == "s" then
        return p33._speed;
    end;

    if p34 == "Clock" then
        return p33._clock;
    end;

    error(string.format("%q is not a valid member of QuaternionSpring.", (tostring(p34))), 2);
end;

function u1.__newindex(p37: any, p38: string, p39: any) -- Line: 259
    -- upvalues: _positionVelocity (copy)
    local v40 = p37._clock();

    if p38 == "Position" or p38 == "p" then
        local _, v41 = _positionVelocity(p37, v40);
        p37._position = p39;
        p37._velocity = v41;
        p37._time = v40;

        return;
    end;

    if p38 == "Velocity" or p38 == "v" then
        local v42, _ = _positionVelocity(p37, v40);
        p37._position = v42;
        p37._velocity = p39;
        p37._time = v40;

        return;
    end;

    if p38 == "Target" or p38 == "t" then
        local v43, v44 = _positionVelocity(p37, v40);
        p37._position = v43;
        p37._velocity = v44;
        p37._target = p39;
        p37._time = v40;

        return;
    end;

    if p38 == "Damping" or p38 == "d" then
        local v45, v46 = _positionVelocity(p37, v40);
        p37._position = v45;
        p37._velocity = v46;
        p37._damping = p39;
        p37._time = v40;

        return;
    end;

    if p38 == "Speed" or p38 == "s" then
        local v47, v48 = _positionVelocity(p37, v40);
        p37._position = v47;
        p37._velocity = v48;
        p37._speed = p39 < 0 and 0 or p39;
        p37._time = v40;

        return;
    end;

    if p38 ~= "Clock" then
        error(string.format("%q is not a valid member of QuaternionSpring.", (tostring(p38))), 2);

        return;
    end;

    local v49, v50 = _positionVelocity(p37, v40);
    p37._position = v49;
    p37._velocity = v50;
    p37._clock = p39;
    p37._time = p39();
end;

return u1;