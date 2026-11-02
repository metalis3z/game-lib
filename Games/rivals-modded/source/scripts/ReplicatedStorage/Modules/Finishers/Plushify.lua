-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4, ...) -- Line: 23
    -- upvalues: Ragdoll (copy)
    Ragdoll.PlayServer(p4, ...);

    if not p4._is_humanoid then
        return;
    end;

    p4._subject.Parent:ScaleTo(p4._subject.Parent:GetScale() * 0.75);
    local v5 = p4._is_humanoid and p4._subject.Parent:FindFirstChild("Head");

    if not v5 then
        return;
    end;

    v5.Size = v5.Size * 2;

    for _, child in pairs(v5.Parent:GetChildren()) do
        if child:IsA("Accessory") then
            for _, child2 in pairs(child:GetChildren()) do
                if child2:IsA("BasePart") then
                    child2.Size = child2.Size * 2;
                end;
            end;
        end;
    end;
end;

function u1.PlayClient(p6, ...) -- Line: 55
    -- upvalues: Ragdoll (copy)
    Ragdoll.PlayClient(p6, ...);
    p6:CreateSound("rbxassetid://83739663458999", 1.5, 1 + 0.1 * math.random(), nil, true, 5);
end;

function u1._Init(p7) -- Line: 64
end;

return u1;