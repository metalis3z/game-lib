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

function u1.PlayServer(p4, ...) -- Line: 20
    -- upvalues: Ragdoll (copy)
    Ragdoll.PlayServer(p4, ...);

    if not p4._is_humanoid then
        return;
    end;

    p4._subject.Parent:ScaleTo(p4._subject.Parent:GetScale() * 0.5);
end;

function u1.PlayClient(p5, ...) -- Line: 30
    -- upvalues: Ragdoll (copy)
    Ragdoll.PlayClient(p5, ...);
    p5:CreateSound("rbxassetid://84840803158340", 1.5, 1 + 0.1 * math.random(), nil, true, 5);
    local v6 = p5._is_humanoid and p5._subject.Parent:FindFirstChild("Head");

    if not v6 then
        return;
    end;

    local v7 = script.Model:Clone();
    v7.PrimaryPart = v7.Primary;
    v7:PivotTo(v6.CFrame);
    v7:ScaleTo(v7:GetScale() * v6.Size.Y / 1);
    v7.Parent = v6;
    table.insert(p5._destroy_these, v7);
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = v6;
    WeldConstraint.Part1 = v7.Primary;
    WeldConstraint.Parent = v7;
end;

function u1._Init(p8) -- Line: 58
end;

return u1;