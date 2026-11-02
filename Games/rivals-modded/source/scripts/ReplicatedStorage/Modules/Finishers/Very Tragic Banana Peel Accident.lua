-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local u1 = setmetatable({}, Finisher);
u1.__index = u1;

function u1.new(...) -- Line: 12
    -- upvalues: Finisher (copy), u1 (copy)
    local v2 = Finisher.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4) -- Line: 24
    -- upvalues: BetterDebris (copy)
    if not p4._is_humanoid then
        return;
    end;

    local Animation = Instance.new("Animation");
    Animation.AnimationId = "rbxassetid://89773418199914";
    local success, result = pcall(p4._subject.LoadAnimation, p4._subject, Animation);

    if success then
        result:Play(0);
    end;

    local RootPart = p4._subject.RootPart;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Velocity = Vector3.new(0, 0, 0);
    BodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000);
    BodyVelocity.Parent = RootPart;
    table.insert(p4._destroy_these, BodyVelocity);
    BetterDebris:AddItem(BodyVelocity, 0.3);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.CFrame = CFrame.new(Vector3.new(0, 0, 0), RootPart.CFrame.LookVector * Vector3.new(1, 0, 1));
    BodyGyro.MaxTorque = Vector3.new(100000, 100000, 100000);
    BodyGyro.Parent = RootPart;
    table.insert(p4._destroy_these, BodyGyro);
    BetterDebris:AddItem(BodyGyro, 0.3);
    wait(0.3);
    BodyGyro:Destroy();
    BodyVelocity:Destroy();
    p4:_Ragdoll();
    p4:_AnchorModel();
end;

function u1.PlayClient(p5) -- Line: 63
    if not p5._is_humanoid then
        return;
    end;

    local v6 = script.Peel:Clone();
    v6.MeshPart1.CollisionGroup = "IgnoreEntities";
    v6.MeshPart2.CollisionGroup = "IgnoreEntities";
    v6.MeshPart3.CollisionGroup = "IgnoreEntities";
    v6.Primary.CollisionGroup = "IgnoreEntities";
    v6.Parent = workspace;
    v6:PivotTo(p5._subject.RootPart.CFrame * CFrame.new(-0.5, -2.5, -1));
    table.insert(p5._destroy_these, v6);
    p5:CreateSound("rbxassetid://8845788882", 2, 1, nil, true, 5);
    wait(0.075);
    v6.PrimaryPart.Anchored = false;
    v6.PrimaryPart.Velocity = ((CFrame.new(p5._subject.RootPart.Position, v6.PrimaryPart.Position).LookVector * Vector3.new(1, 0, 1)).Unit + Vector3.new(0, 2, 0)) * 20;
    v6.PrimaryPart.RotVelocity = Random.new():NextUnitVector() * (15 + 60 * math.random());
end;

function u1._Init(p7) -- Line: 90
end;

return u1;