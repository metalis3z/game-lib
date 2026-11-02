-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local u1 = setmetatable({}, Finisher);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Finisher (copy), u1 (copy)
    local v2 = Finisher.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4) -- Line: 22
    if not p4._is_humanoid then
        return;
    end;

    p4:_AnchorModel(false, 0);
    local v5 = script.Model:Clone();
    v5:SetPrimaryPartCFrame(p4._subject.RootPart.CFrame);
    v5.PrimaryPart.Anchored = true;
    v5.Parent = p4._subject;
    table.insert(p4._destroy_these, v5);
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = v5.PrimaryPart;
    WeldConstraint.Part1 = p4._subject.RootPart;
    WeldConstraint.Parent = v5;
    v5.PrimaryPart.Anchored = false;
    local Animation = Instance.new("Animation");
    Animation.AnimationId = "rbxassetid://72904319869602";
    table.insert(p4._destroy_these, Animation);
    local success, result = pcall(p4._subject.LoadAnimation, p4._subject, Animation);

    if success then
        table.insert(p4._destroy_these, result);
        result:Play(0);
    end;

    p4._subject.RootPart.Velocity = Random.new():NextUnitVector() * (24 + 8 * math.random());
    p4._subject.RootPart.RotVelocity = Vector3.new(0, 1, 0) * (0 + 36 * math.random());
end;

function u1.PlayClient(p6) -- Line: 57
    if not p6._is_humanoid then
        return;
    end;

    p6:CreateSound("rbxassetid://88366458741976", 1, 1 + 0.25 * math.random(), p6._subject.RootPart, true, 10);
end;

function u1._Init(p7) -- Line: 69
end;

return u1;