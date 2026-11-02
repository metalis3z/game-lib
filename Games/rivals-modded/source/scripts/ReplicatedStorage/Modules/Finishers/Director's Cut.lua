-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local u1 = setmetatable({}, Finisher);
u1.__index = u1;

function u1.new(...) -- Line: 14
    -- upvalues: Finisher (copy), u1 (copy)
    local v2 = Finisher.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4) -- Line: 26
    -- upvalues: BetterDebris (copy)
    if not p4._is_humanoid then
        return;
    end;

    local RootPart = p4._subject.RootPart;
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.CFrame = CFrame.new(Vector3.new(0, 0, 0), RootPart.CFrame.LookVector * Vector3.new(1, 0, 1));
    BodyGyro.MaxTorque = Vector3.new(100000, 100000, 100000);
    BodyGyro.Parent = RootPart;
    table.insert(p4._destroy_these, BodyGyro);
    BetterDebris:AddItem(BodyGyro, 2);
    local BodyPosition = Instance.new("BodyPosition");
    BodyPosition.Position = RootPart.Position;
    BodyPosition.MaxForce = Vector3.new(1000000, 1000000, 1000000);
    BodyPosition.Parent = RootPart;
    table.insert(p4._destroy_these, BodyGyro);
    BetterDebris:AddItem(BodyGyro, 2);
    local Animation = Instance.new("Animation");
    Animation.AnimationId = "rbxassetid://118451940351578";
    local success, result = pcall(p4._subject.LoadAnimation, p4._subject, Animation);

    if success then
        result:Play(0);
    end;

    wait(2);
    BodyGyro:Destroy();
    p4:_Ragdoll();
    p4:_AnchorModel();
end;

function u1.PlayClient(p5) -- Line: 64
    -- upvalues: BetterDebris (copy), RunService (copy)
    if not p5._is_humanoid then
        return;
    end;

    local RootPart = p5._subject.RootPart;
    local Animation = Instance.new("Animation");
    Animation.AnimationId = "rbxassetid://118451940351578";
    local u6 = script.Model:Clone();
    u6.PrimaryPart = u6.HumanoidRootPart;
    u6:PivotTo(p5._subject.RootPart.CFrame);
    u6.Parent = workspace;
    table.insert(p5._destroy_these, u6);
    BetterDebris:AddItem(u6, 2.4);
    local v7 = RunService.RenderStepped:Connect(function() -- Line: 81
        -- upvalues: u6 (copy), RootPart (copy)
        u6:PivotTo(RootPart.CFrame);
    end);
    table.insert(p5._connections, v7);

    for _, descendant in pairs(u6:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.CollisionGroup = "Noclip";
        end;
    end;

    local success, result = pcall(u6.AnimationController.LoadAnimation, u6.AnimationController, Animation);

    if success then
        result:Play(0);
    end;

    p5:CreateSound("rbxassetid://74600054680969", 2, 1 + 0.2 * math.random(), nil, true, 5);
    wait(1.2);
    p5:CreateSound("rbxassetid://133211885821177", 1.5, 1 + 0.2 * math.random(), nil, true, 5);
end;

function u1._Init(p8) -- Line: 110
end;

return u1;