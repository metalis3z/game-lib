-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Signal = require(ReplicatedStorage.Modules.Signal);
local u1 = {
    Speed = true
};
local u2 = {};
u2.__index = u2;

function u2.new(p3) -- Line: 10
    -- upvalues: u2 (copy), Signal (copy)
    local v4 = setmetatable({}, u2);
    v4.BoostsChanged = Signal.new();
    v4.ClientFighterCharacter = p3;
    v4._boosts = {};
    v4:_Init();

    return v4;
end;

function u2.GetBoostByName(p5, p6) -- Line: 29
    local v7 = typeof(p6) == "string";
    local v8 = "Argument 1 invalid, expected a string, got " .. tostring(p6);
    assert(v7, v8);
    p5:_ClearExpiredBoosts();

    return p5._boosts[p6];
end;

function u2.GetBoost(p9, p10) -- Line: 38
    -- upvalues: u1 (copy)
    local v11 = u1[p10];
    local v12 = "Argument 1 invalid, got " .. tostring(p10);
    assert(v11, v12);
    p9:_ClearExpiredBoosts();
    local v13 = 0;

    for _, v in pairs(p9._boosts) do
        if v.Type == p10 then
            v13 = v13 + v.Boost;
        end;
    end;

    return v13;
end;

function u2.SetBoost(p14, p15, p16, p17, p18, p19) -- Line: 59
    -- upvalues: u1 (copy)
    local v20 = u1[p15];
    local v21 = "Argument 1 invalid, got " .. tostring(p15);
    assert(v20, v21);
    local v22 = typeof(p16) == "string";
    local v23 = "Argument 2 invalid, expected a string, got " .. tostring(p16);
    assert(v22, v23);
    local v24 = typeof(p17) == "number";
    local v25 = "Argument 3 invalid, expected a number, got " .. tostring(p17);
    assert(v24, v25);
    local v26 = typeof(p18) == "number";
    local v27 = "Argument 4 invalid, expected a number, got " .. tostring(p18);
    assert(v26, v27);
    local v28 = not p19 or typeof(p19) == "boolean";
    local v29 = "Argument 5 invalid, expected a boolean or nil, got " .. tostring(p19);
    assert(v28, v29);
    p14._boosts[p16] = {
        Type = p15,
        Window = tick() + p17,
        Boost = p18
    };

    if not p19 then
        p14.BoostsChanged:Fire();
    end;
end;

function u2.RemoveBoost(p30, p31, p32) -- Line: 79
    local v33 = typeof(p31) == "string";
    local v34 = "Argument 1 invalid, expected a string, got " .. tostring(p31);
    assert(v33, v34);
    local v35 = not p32 or typeof(p32) == "boolean";
    local v36 = "Argument 2 invalid, expected a boolean or nil, got " .. tostring(p32);
    assert(v35, v36);

    if not p30._boosts[p31] then
        return;
    end;

    p30._boosts[p31] = nil;

    if not p32 then
        p30.BoostsChanged:Fire();
    end;
end;

function u2.Update(p37, p38, p39) -- Line: 94
end;

function u2.Destroy(p40) -- Line: 98
    p40.BoostsChanged:Destroy();
end;

function u2._ClearExpiredBoosts(p41) -- Line: 106
    local v42 = false;

    for i, v in pairs(p41._boosts) do
        if tick() > v.Window then
            p41:RemoveBoost(i, true);
            v42 = true;
        end;
    end;

    if v42 then
        p41.BoostsChanged:Fire();
    end;
end;

function u2._Init(p43) -- Line: 121
end;

return u2;