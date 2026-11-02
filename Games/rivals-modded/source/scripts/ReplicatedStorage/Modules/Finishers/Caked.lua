-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4, ...) -- Line: 22
    -- upvalues: Ragdoll (copy), BetterDebris (copy)
    Ragdoll.PlayServer(p4, ...);
    local v5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
    BodyVelocity.Velocity = Random.new():NextUnitVector() * Vector3.new(1, 0, 1) * 24;
    BodyVelocity.Parent = v5;
    table.insert(p4._destroy_these, BodyVelocity);
    BetterDebris:AddItem(BodyVelocity, 0.2);
end;

function u1.PlayClient(p6, ...) -- Line: 35
    -- upvalues: Ragdoll (copy), Utility (copy)
    Ragdoll.PlayClient(p6, ...);
    local v7 = p6._is_humanoid and p6._subject.Parent:FindFirstChild("Head");

    if not v7 then
        return;
    end;

    local v8 = script.Model:Clone();
    v8.PrimaryPart = v8.Primary;
    v8:PivotTo(v7.CFrame);
    v8.Parent = v7;
    table.insert(p6._destroy_these, v8);
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = v7;
    WeldConstraint.Part1 = v8.Primary;
    WeldConstraint.Parent = v8;
    local v9 = script.Particles.Attachment:Clone();
    v9.Parent = v7;
    table.insert(p6._destroy_these, v9);
    Utility:PlayParticles(v9);
    p6:CreateSound("rbxassetid://106768039815049", 1.25, 1 + 0.1 * math.random(), nil, true, 5);
    p6:CreateSound("rbxassetid://113457984699397", 1.75, 1 + 0.1 * math.random(), nil, true, 5);
end;

function u1._Init(p10) -- Line: 68
end;

return u1;