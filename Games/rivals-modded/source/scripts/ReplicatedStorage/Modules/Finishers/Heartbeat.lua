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
    local v5 = script.Particles.Attachment:Clone();
    v5.Parent = p4._is_humanoid and p4._subject.Parent.UpperTorso or p4._subject;
    table.insert(p4._destroy_these, v5);

    for _, child in pairs(v5:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(child, 0.25);
        end;
    end;

    Utility:PlayParticles(v5);
    wait(0.5);

    for i = 1, 3 do
        p4:CreateSound("rbxassetid://127325407221199", 1.5 - i * 0.25, 1, nil, true, 5);
        wait(0.9);
        local _ = i;
    end;

    p4:CreateSound("rbxassetid://106567630436220", 0.75, 1, nil, true, 5);
end;

function u1._Init(p6) -- Line: 51
end;

return u1;