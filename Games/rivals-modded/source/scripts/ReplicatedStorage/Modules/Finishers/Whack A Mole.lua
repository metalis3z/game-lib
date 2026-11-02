-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 15
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4) -- Line: 27
    -- upvalues: BetterDebris (copy)
    if not p4._is_humanoid then
        return;
    end;

    local RootPart = p4._subject.RootPart;

    for _, v in pairs(p4:_GetObjects(true)) do
        if v:IsA("BasePart") and v ~= RootPart then
            v.CollisionGroup = "Noclip";
        end;
    end;

    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.CFrame = CFrame.new(Vector3.new(0, 0, 0), RootPart.CFrame.LookVector * Vector3.new(1, 0, 1));
    BodyGyro.MaxTorque = Vector3.new(100000, 100000, 100000);
    BodyGyro.Parent = RootPart;
    table.insert(p4._destroy_these, BodyGyro);
    BetterDebris:AddItem(BodyGyro, 2.85);
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
    BodyVelocity.Velocity = Vector3.new(0, 0, 0);
    BodyVelocity.Parent = RootPart;
    table.insert(p4._destroy_these, BodyGyro);
    BetterDebris:AddItem(BodyGyro, 2.85);
    local Animation = Instance.new("Animation");
    Animation.AnimationId = "rbxassetid://96799926007713";
    local success, result = pcall(p4._subject.LoadAnimation, p4._subject, Animation);

    if success then
        result:Play(0);
    end;

    wait(2.8);
    p4:_Ragdoll();
    p4:_AnchorModel();
end;

function u1.PlayClient(u5) -- Line: 69
    -- upvalues: BetterDebris (copy), RunService (copy), Utility (copy)
    if not u5._is_humanoid then
        return;
    end;

    local Animation = Instance.new("Animation");
    Animation.AnimationId = "rbxassetid://96799926007713";
    local u6 = script.Model:Clone();
    u6.PrimaryPart = u6.HumanoidRootPart;
    u6.Parent = workspace;
    table.insert(u5._destroy_these, u6);
    BetterDebris:AddItem(u6, 2.85);
    table.insert(u5._connections, RunService.RenderStepped:Connect(function() -- Line: 83
        -- upvalues: u6 (copy), u5 (copy)
        u6:PivotTo(u5._subject.RootPart.CFrame);
    end));

    for _, descendant in pairs(u6:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.CollisionGroup = "Noclip";
        end;
    end;

    local success, result = pcall(u6.AnimationController.LoadAnimation, u6.AnimationController, Animation);

    if success then
        result:Play(0);
    end;

    wait(2);
    u5:CreateSound("rbxassetid://83406711884881", 1, 1 + 0.1 * math.random(), nil, true, 5);
    Utility:PlayParticles(u6.Hole);
end;

function u1._Init(p7) -- Line: 109
end;

return u1;