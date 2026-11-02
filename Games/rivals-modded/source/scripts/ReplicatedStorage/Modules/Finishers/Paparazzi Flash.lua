-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(p4, ...) -- Line: 20
    -- upvalues: Ragdoll (copy)
    Ragdoll.PlayClient(p4, ...);
    local v5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    local v6 = script.Particles:Clone();
    v6.CFrame = v5.CFrame;
    v6.Parent = workspace;
    table.insert(p4._destroy_these, v6);
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = v5;
    WeldConstraint.Part1 = v6;
    WeldConstraint.Parent = v6;
    p4:CreateSound("rbxassetid://101557890598386", 1 + 0.5 * math.random(), 0.95 + 0.1 * math.random(), nil, true, 10);
    p4:CreateSound("rbxassetid://124233252129930", 1 + 0.5 * math.random(), 0.95 + 0.1 * math.random(), nil, true, 10);
    wait(6.5);

    for _, descendant in pairs(v6:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;
end;

function u1._Init(p7) -- Line: 51
end;

return u1;