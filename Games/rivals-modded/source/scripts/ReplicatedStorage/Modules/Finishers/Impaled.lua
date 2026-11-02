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
    BetterDebris:AddItem(BodyGyro, 1.5);
    local Animation = Instance.new("Animation");
    Animation.AnimationId = "rbxassetid://135124706498215";
    local success, result = pcall(p4._subject.LoadAnimation, p4._subject, Animation);

    if success then
        result:Play(0);
    end;

    wait(1.25);
    local Position = p4._subject.RootPart.Position;
    wait(0.25);
    BodyGyro:Destroy();
    p4:_Ragdoll();
    p4:_AnchorModel();
    local v5 = p4._subject.RootPart.Position - Position;
    p4._subject.RootPart.Velocity = (v5.Magnitude <= 0.01 and Vector3.new(0, 0, 0) or v5.Unit) * -256;
end;

function u1.PlayClient(u6) -- Line: 66
    -- upvalues: BetterDebris (copy), RunService (copy)
    if not u6._is_humanoid then
        return;
    end;

    local Animation = Instance.new("Animation");
    Animation.AnimationId = "rbxassetid://135124706498215";
    local u7 = script.Model:Clone();
    u7.PrimaryPart = u7.HumanoidRootPart;
    u7:PivotTo(u6._subject.RootPart.CFrame);
    u7.Parent = workspace;
    table.insert(u6._destroy_these, u7);
    BetterDebris:AddItem(u7, 2.2);
    table.insert(u6._connections, RunService.RenderStepped:Connect(function() -- Line: 81
        -- upvalues: u7 (copy), u6 (copy)
        u7:PivotTo(u6._subject.RootPart.CFrame);
    end));

    for _, descendant in pairs(u7:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.CollisionGroup = "Noclip";
        end;
    end;

    local success, result = pcall(u7.AnimationController.LoadAnimation, u7.AnimationController, Animation);

    if success then
        result:Play(0);
    end;

    u6:CreateSound("rbxassetid://77810366972840", 1, 1 + 0.1 * math.random(), nil, true, 5);
    wait(1);
    u6:CreateSound("rbxassetid://76979641579471", 1, 1 + 0.1 * math.random(), nil, true, 5);
end;

function u1._Init(p8) -- Line: 108
end;

return u1;