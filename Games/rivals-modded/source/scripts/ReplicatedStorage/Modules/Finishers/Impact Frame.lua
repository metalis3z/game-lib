-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local Utility = require(ReplicatedStorage.Modules.Utility);
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

    local RootPart = p4._subject.RootPart;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Velocity = Vector3.new(0, 0, 0);
    BodyVelocity.MaxForce = Vector3.new(10000, 0, 10000);
    BodyVelocity.Parent = RootPart;
    table.insert(p4._destroy_these, BodyVelocity);
    BetterDebris:AddItem(BodyVelocity, 0.5);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.CFrame = CFrame.new(Vector3.new(0, 0, 0), RootPart.CFrame.LookVector * Vector3.new(1, 0, 1));
    BodyGyro.MaxTorque = Vector3.new(100000, 100000, 100000);
    BodyGyro.Parent = RootPart;
    table.insert(p4._destroy_these, BodyGyro);
    BetterDebris:AddItem(BodyGyro, 0.5);
    wait(0.5);
    BodyVelocity:Destroy();
    BodyGyro:Destroy();
    p4:_Ragdoll();
    p4:_AnchorModel();
    local BodyVelocity2 = Instance.new("BodyVelocity");
    BodyVelocity2.MaxForce = Vector3.new(100000, 100000, 100000);
    BodyVelocity2.Velocity = RootPart.CFrame.RightVector * 64;
    BodyVelocity2.Parent = RootPart;
    table.insert(p4._destroy_these, BodyVelocity2);
    BetterDebris:AddItem(BodyVelocity2, 0.2);
end;

function u1.PlayClient(p5) -- Line: 61
    -- upvalues: Utility (copy)
    if not p5._is_humanoid then
        return;
    end;

    local Animation = Instance.new("Animation");
    Animation.AnimationId = "rbxassetid://101848673881346";
    local success, result = pcall(p5._subject.LoadAnimation, p5._subject, Animation);

    if success then
        result:Play(0);
    end;

    wait(0.25);
    local v6 = script.Particles:Clone();
    v6.Parent = workspace;
    v6.CFrame = (p5._is_humanoid and p5._subject.RootPart or p5._subject).CFrame;
    table.insert(p5._destroy_these, v6);
    Utility:PlayParticles(v6);
    p5:CreateSound("rbxassetid://79427627396361", 1.5, 0.95 + 0.1 * math.random(), nil, true, 5);
    local Highlight = Instance.new("Highlight");
    Highlight.FillColor = Color3.fromRGB(255, 255, 255);
    Highlight.OutlineColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 0;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Parent = p5._subject.Parent;
    table.insert(p5._destroy_these, Highlight);
    wait(0.05);
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
    wait(0.05);
    Highlight.FillColor = Color3.fromRGB(255, 255, 255);
    Highlight.OutlineColor = Color3.fromRGB(0, 0, 0);
    wait(0.05);
    Highlight:Destroy();
end;

function u1._Init(p7) -- Line: 113
end;

return u1;