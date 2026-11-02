-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4, ...) -- Line: 25
    -- upvalues: Ragdoll (copy), Utility (copy), BetterDebris (copy)
    Ragdoll.PlayServer(p4, ...);

    if not p4._is_humanoid then
        return;
    end;

    local v5 = script.Part:Clone();
    v5.CFrame = p4._subject.RootPart.CFrame;
    v5.Parent = workspace;
    Utility:PlayParticles(v5);
    BetterDebris:AddItem(v5, 10);
    table.insert(p4._destroy_these, v5);
    local v6 = Random.new():NextUnitVector();
    local v7 = (v6 * Vector3.new(1, 0, 1) + Vector3.new(0, 1, 0) * math.abs(v6.Y)) * (16 + 16 * math.random());
    local Position = p4._subject.Parent:GetPivot().Position;
    local v8 = Utility:Raycast(Position, Position + v7, v7.Magnitude, { p4._subject.Parent }, Enum.RaycastFilterType.Exclude);
    p4._subject.Parent:PivotTo(CFrame.new(v8.Position) * CFrame.Angles(math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2));
end;

function u1.PlayClient(p9, ...) -- Line: 47
    -- upvalues: Ragdoll (copy)
    p9:CreateSound("rbxassetid://77408061407414", 1, 1 + 0.1 * math.random(), nil, true, 5);
    Ragdoll.PlayClient(p9, ...);
end;

function u1._Init(p10) -- Line: 56
end;

return u1;