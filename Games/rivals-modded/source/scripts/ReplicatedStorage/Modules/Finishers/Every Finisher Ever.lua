-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local Finishers = ReplicatedStorage.Modules.Finishers;
local u1 = setmetatable({}, Finisher);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Finisher (copy), u1 (copy)
    local v2 = Finisher.new(...);
    local v3 = setmetatable(v2, u1);
    v3._finishers = {};
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4) -- Line: 24
    local BindableEvent = Instance.new("BindableEvent");
    local v5 = 0;
    local u6 = 0;

    for _, v in pairs(p4._finishers) do
        v5 = v5 + 1;
        p4:_InternalThread(task.spawn, function() -- Line: 32
            -- upvalues: v (copy), u6 (ref), BindableEvent (copy)
            pcall(v.PlayServer, v);
            u6 = u6 + 1;
            BindableEvent:Fire();
        end);
    end;

    while u6 < v5 do
        BindableEvent.Event:Wait();
    end;
end;

function u1.PlayClient(p7) -- Line: 44
    local BindableEvent = Instance.new("BindableEvent");
    local v8 = 0;
    local u9 = 0;

    for _, v in pairs(p7._finishers) do
        v8 = v8 + 1;
        p7:_InternalThread(task.spawn, function() -- Line: 52
            -- upvalues: v (copy), u9 (ref), BindableEvent (copy)
            pcall(v.PlayClient, v);
            u9 = u9 + 1;
            BindableEvent:Fire();
        end);
    end;

    while u9 < v8 do
        BindableEvent.Event:Wait();
    end;
end;

function u1.Destroy(p10) -- Line: 64
    -- upvalues: Finisher (copy)
    for _, v in pairs(p10._finishers) do
        v:Destroy();
    end;

    Finisher.Destroy(p10);
end;

function u1._Setup(p11) -- Line: 76
    -- upvalues: Finishers (copy)
    for _, child in pairs(Finishers:GetChildren()) do
        if child ~= script then
            local _finishers = p11._finishers;
            local new = require(child).new;
            table.insert(_finishers, new(p11._subject, p11._is_final_finisher, p11._eliminator));
        end;
    end;
end;

function u1._Init(p12) -- Line: 84
    p12:_Setup();
end;

return u1;