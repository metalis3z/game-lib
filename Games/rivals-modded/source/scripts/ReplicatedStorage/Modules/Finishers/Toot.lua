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

function u1.PlayClient(p4, ...) -- Line: 21
    -- upvalues: Ragdoll (copy), Utility (copy)
    Ragdoll.PlayClient(p4, ...);
    wait(0.75);
    local v5 = script.Particles.Attachment:Clone();
    v5.Parent = p4._is_humanoid and p4._subject.Parent.LowerTorso or p4._subject;
    table.insert(p4._destroy_these, v5);
    Utility:PlayParticles(v5);
    p4:CreateSound("rbxassetid://16924073325", 1, 1 + 0.2 * math.random(), nil, true, 5);
end;

function u1._Init(p6) -- Line: 39
end;

return u1;