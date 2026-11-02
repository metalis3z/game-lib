-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 6
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._last_update = -1;
    v2._time_remaining = nil;
    v2:_Init();

    return v2;
end;

function u1.GetTimeRemaining(p3) -- Line: 21
    if p3._time_remaining then
        local v4 = p3._time_remaining - (tick() - p3._last_update);
        local math_ceil_ret = math.ceil(v4);

        return math.max(0, math_ceil_ret);
    end;
end;

function u1._UpdateTimer(p5, p6) -- Line: 33
    p5._last_update = tick();
    p5._time_remaining = p6;
end;

function u1._Fetch(p7) -- Line: 38
    -- upvalues: ReplicatedStorage (copy)
    p7:_UpdateTimer(ReplicatedStorage.Remotes.Misc.RequestEventTimer:InvokeServer());
end;

function u1._Init(u8) -- Line: 42
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.Misc.UpdateEventTimer.OnClientEvent:Connect(function(p9) -- Line: 43
        -- upvalues: u8 (copy)
        u8:_UpdateTimer(p9);
    end);
    task.defer(u8._Fetch, u8);
end;

return u1._new();