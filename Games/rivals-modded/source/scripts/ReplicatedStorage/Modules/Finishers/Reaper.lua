-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("Players");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 12
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4, ...) -- Line: 24
    -- upvalues: Ragdoll (copy)
    local v5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    v5.Anchored = true;
    wait(0.9);
    v5.Anchored = false;
    local v6 = p4._is_humanoid and p4._subject.Parent:FindFirstChild("Waist", true);

    if v6 then
        v6:Destroy();
    end;

    Ragdoll.PlayServer(p4, ...);
    local v7 = p4._is_humanoid and p4._subject.Parent:FindFirstChild("UpperTorso");

    if v7 then
        local v8 = Random.new():NextUnitVector() * Vector3.new(1, 0, 1);
        local math_random_ret = math.random();
        v7.Velocity = (v8 + Vector3.new(0, math_random_ret, 0)) * (50 + 150 * math.random());
    end;
end;

function u1.PlayClient(p9) -- Line: 48
    -- upvalues: RunService (copy), Utility (copy)
    local u10 = p9._is_humanoid and p9._subject.RootPart or p9._subject;
    local CFrame_Angles_ret = CFrame.Angles(0, math.random() * 3.141592653589793 * 2, 0);

    if p9._is_humanoid then
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://4769412289";
        local success, result = pcall(p9._subject.LoadAnimation, p9._subject, Animation);

        if success then
            result:Play(0);
            result:AdjustSpeed(0.16666666666666666);
        end;
    end;

    local u11 = script.Model:Clone();
    u11.Parent = workspace;
    table.insert(p9._destroy_these, u11);
    local v12 = RunService.RenderStepped:Connect(function() -- Line: 68
        -- upvalues: u11 (copy), u10 (copy), CFrame_Angles_ret (copy)
        u11:PivotTo(CFrame.new(u10.Position) * CFrame_Angles_ret);
    end);
    table.insert(p9._connections, v12);
    local success, result = pcall(u11.AnimationController.LoadAnimation, u11.AnimationController, u11.Animation);

    if success then
        result:Play(0);
        p9:CreateSound("rbxassetid://85156927480464", 2, 1, nil, true, 5);
        wait(0.7);
        p9:CreateSound("rbxassetid://14111617408", 2, 1, nil, true, 5);
        p9:CreateSound("rbxassetid://14111617269", 1.5, 1, nil, true, 5);
        wait(0.2);
        Utility:PlayParticles(u11.HumanoidRootPart.Particles);

        if result.IsPlaying then
            result.Stopped:Wait();
        end;

        u11:Destroy();
        wait(3);
    end;

    v12:Disconnect();
end;

function u1._Init(p13) -- Line: 106
end;

return u1;