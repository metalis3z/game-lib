-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 9
    -- upvalues: u1 (copy), Signal (copy)
    local v2 = setmetatable({}, u1);
    v2.TimerUpdated = Signal.new();
    v2._finish_times = {};
    v2._step_callbacks = {};
    v2:_Init();

    return v2;
end;

function u1.GetTimeRemaining(p3, p4) -- Line: 26
    if not p3._finish_times[p4] then
        return -1;
    end;

    local v5 = p3._finish_times[p4] - tick();
    local math_ceil_ret = math.ceil(v5);

    return math.max(0, math_ceil_ret);
end;

function u1.GetTimeRemainingFormatted(p6, p7) -- Line: 30
    -- upvalues: Utility (copy)
    local TimeRemaining = p6:GetTimeRemaining(p7);

    return TimeRemaining == -1 and "• • •" or Utility:TimeFormat2(TimeRemaining);
end;

function u1.SetTimeRemaining(p8, p9, p10) -- Line: 36
    p8._finish_times[p9] = tick() + p10;
    p8.TimerUpdated:Fire(p9);
end;

function u1.OnStep(p11, p12, p13, p14) -- Line: 41
    p11._step_callbacks[p12] = p13 and p14 and { p13, p14 } or nil;
    p11:_Step(p12);
end;

function u1._Step(p15, p16) -- Line: 50
    local v17 = p15._step_callbacks[p16];

    if not v17 then
        return;
    end;

    local success, result = pcall(v17[2], p15:GetTimeRemaining(v17[1]), p15:GetTimeRemainingFormatted(v17[1]));

    if not success then
        warn("ON STEP CALLBACK ERRORED:", result);
    end;
end;

function u1._StepLoop(p18) -- Line: 64
    while true do
        for i in pairs(p18._step_callbacks) do
            p18:_Step(i);
        end;

        wait(1);
    end;
end;

function u1._FetchTimers(p19) -- Line: 74
    -- upvalues: ReplicatedStorage (copy)
    p19:SetTimeRemaining("TaskRefresh", ReplicatedStorage.Remotes.Misc.RequestTaskRefreshTimeRemaining:InvokeServer());
    p19:SetTimeRemaining("AdventCalendar", ReplicatedStorage.Remotes.Misc.RequestAdventCalendarTimeRemaining:InvokeServer());
end;

function u1._Init(u20) -- Line: 79
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.Misc.UpdateTaskRefreshTimeRemaining.OnClientEvent:Connect(function(p21) -- Line: 80
        -- upvalues: u20 (copy)
        u20:SetTimeRemaining("TaskRefresh", p21);
    end);
    ReplicatedStorage.Remotes.Misc.UpdateAdventCalendarTimeRemaining.OnClientEvent:Connect(function(p22) -- Line: 84
        -- upvalues: u20 (copy)
        u20:SetTimeRemaining("AdventCalendar", p22);
    end);
    task.spawn(u20._StepLoop, u20);
    task.spawn(u20._FetchTimers, u20);
end;

return u1._new();