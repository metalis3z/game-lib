-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 8
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._last_fetch = tick();
    v2._last_server_time = workspace:GetServerTimeNow();
    v2:_Init();

    return v2;
end;

function u1.Get(p3) -- Line: 23
    -- upvalues: CONSTANTS (copy)
    if CONSTANTS.IS_SERVER then
        return os.time();
    end;

    return p3._last_server_time + (tick() - p3._last_fetch);
end;

function u1.GetRounded(p4) -- Line: 27
    -- upvalues: CONSTANTS (copy)
    if CONSTANTS.IS_SERVER then
        return os.time();
    end;

    local v5 = p4:Get() + 0.5;

    return math.floor(v5);
end;

function u1.WaitUntil(p6, p7) -- Line: 31
    wait(p7 - p6:Get());
end;

function u1._Init(p8) -- Line: 39
end;

return u1._new();