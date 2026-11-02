-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
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
    -- upvalues: TweenService (copy)
    if not p4._is_humanoid then
        return;
    end;

    p4._subject.RootPart.Anchored = true;
    local RootPart = p4._subject.RootPart;
    RootPart.CFrame = RootPart.CFrame * CFrame.Angles(0, math.random() * 3.141592653589793 * 2, 0);
    TweenService:Create(p4._subject.RootPart, TweenInfo.new(1.6, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        CFrame = p4._subject.RootPart.CFrame * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, -10)
    }):Play();
    local Animation = Instance.new("Animation");
    Animation.AnimationId = "rbxassetid://84375821263857";
    local success, result = pcall(p4._subject.LoadAnimation, p4._subject, Animation);

    if success then
        result:Play(0);
    end;

    wait(1.6);
    p4:_HideBody();
end;

function u1.PlayClient(u5) -- Line: 49
    -- upvalues: BetterDebris (copy), RunService (copy)
    if not u5._is_humanoid then
        return;
    end;

    local Animation = Instance.new("Animation");
    Animation.AnimationId = "rbxassetid://84375821263857";
    local u6 = script.Model:Clone();
    u6.PrimaryPart = u6.HumanoidRootPart;
    u6:PivotTo(u5._subject.RootPart.CFrame);
    u6.Parent = workspace;
    table.insert(u5._destroy_these, u6);
    BetterDebris:AddItem(u6, 1.6);

    for _, descendant in pairs(u6:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.CollisionGroup = "Noclip";
        end;
    end;

    local success, result = pcall(u6.AnimationController.LoadAnimation, u6.AnimationController, Animation);

    if success then
        result:Play(0);
    end;

    u5:_InternalThread(task.spawn, function() -- Line: 76
        -- upvalues: u5 (copy)
        u5:CreateSound("rbxassetid://86826830376840", 0.75, 1, nil, true, 5);
        wait(0.15);
        u5:CreateSound("rbxassetid://7127702569", 1, 1.2, nil, true, 5);
        wait(1.4500000000000002);
        u5:CreateSound("rbxassetid://7127702569", 1, 0.8, nil, true, 5);
    end);
    local v7 = RunService.RenderStepped:Connect(function() -- Line: 88
        -- upvalues: u6 (copy), u5 (copy)
        u6:PivotTo(u5._subject.RootPart.CFrame);
    end);
    table.insert(u5._connections, v7);
    wait(1.6);
    v7:Disconnect();
end;

function u1._Init(p8) -- Line: 103
end;

return u1;