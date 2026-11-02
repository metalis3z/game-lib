-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 9
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4, ...) -- Line: 21
    -- upvalues: Ragdoll (copy), Utility (copy)
    Ragdoll.PlayServer(p4, ...);
    Utility:Knockback(p4._is_humanoid and p4._subject.Parent.Head or p4._subject, Random.new():NextUnitVector() * Vector3.new(1, 0, 1) * 50 + Vector3.new(0, 25, 0));
    p4:CreateSound("rbxassetid://127579435864391", 1, 1.5 + 0.25 * math.random(), nil, true, 5);
end;

function u1._Init(p5) -- Line: 36
end;

return u1;