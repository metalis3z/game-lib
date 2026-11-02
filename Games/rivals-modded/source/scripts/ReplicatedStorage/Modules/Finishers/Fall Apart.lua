-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local u1 = setmetatable({}, Finisher);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: Finisher (copy), u1 (copy)
    local v2 = Finisher.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4) -- Line: 20
    p4:_BreakJoints();
    p4:_InternalThread(task.delay, 0.25, p4._BreakJoints, p4);
    p4:_AnchorModel();

    for _, v in pairs(p4:_GetObjects()) do
        if v:IsA("BasePart") then
            local AssemblyLinearVelocity = v.AssemblyLinearVelocity;
            local v5 = math.random() - 0.5;
            local math_random_ret = math.random();
            local v6 = math.random() - 0.5;
            v.AssemblyLinearVelocity = AssemblyLinearVelocity + Vector3.new(v5, math_random_ret, v6) * 10;
        end;
    end;
end;

function u1.PlayClient(p7) -- Line: 32
end;

function u1._Init(p8) -- Line: 40
end;

return u1;