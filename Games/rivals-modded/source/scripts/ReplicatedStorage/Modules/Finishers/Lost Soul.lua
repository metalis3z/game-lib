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
    local v5 = {};

    for _, child in pairs(script.Particles:GetChildren()) do
        local v6 = child:Clone();
        v6.Parent = p4._is_humanoid and p4._subject.RootPart or p4._subject;
        table.insert(p4._destroy_these, v6);
        table.insert(v5, v6);

        if v6:IsA("Attachment") then
            v6.WorldCFrame = CFrame.new(v6.WorldPosition);
        end;
    end;

    Utility:PlayParticles(v5);
    p4:CreateSound("rbxassetid://105446759660735", 1, 1 + 0.2 * math.random(), nil, true, 5);
end;

function u1._Init(p7) -- Line: 46
end;

return u1;