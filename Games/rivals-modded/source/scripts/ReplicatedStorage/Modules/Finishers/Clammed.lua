-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
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
    if not p4._is_humanoid then
        return;
    end;

    p4._subject.RootPart.Anchored = true;
    local Animation = Instance.new("Animation");
    Animation.AnimationId = "rbxassetid://106864398124698";
    local success, result = pcall(p4._subject.LoadAnimation, p4._subject, Animation);

    if success then
        result:Play(0);
    end;

    wait(2.15);
    p4:_HideBody();
end;

function u1.PlayClient(u5) -- Line: 47
    -- upvalues: BetterDebris (copy), RunService (copy)
    if not u5._is_humanoid then
        return;
    end;

    local Animation = Instance.new("Animation");
    Animation.AnimationId = "rbxassetid://106864398124698";
    local u6 = script.Model:Clone();
    u6.PrimaryPart = u6.HumanoidRootPart;
    u6:PivotTo(u5._subject.RootPart.CFrame);
    u6.Parent = workspace;
    table.insert(u5._destroy_these, u6);
    BetterDebris:AddItem(u6, 2.15);

    for _, descendant in pairs(u6:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.CollisionGroup = "Noclip";
        end;
    end;

    local success, result = pcall(u6.AnimationController.LoadAnimation, u6.AnimationController, Animation);

    if success then
        result:Play(0);
    end;

    u5:_InternalThread(task.spawn, function() -- Line: 74
        -- upvalues: u5 (copy)
        wait(1.3);
        u5:CreateSound("rbxassetid://113843062064513", 0.75, 1 + 0.1 * math.random(), nil, true, 5);
        u5:CreateSound("rbxassetid://95086117365305", 0.75, 1 + 0.1 * math.random(), nil, true, 5);
    end);
    local v7 = RunService.RenderStepped:Connect(function() -- Line: 80
        -- upvalues: u6 (copy), u5 (copy)
        u6:PivotTo(u5._subject.RootPart.CFrame);
    end);
    table.insert(u5._connections, v7);
    wait(2.15);
    v7:Disconnect();
end;

function u1._Init(p8) -- Line: 95
end;

return u1;