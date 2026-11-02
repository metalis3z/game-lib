-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = { 38, 93, 113, 125, 130, 139, 150 };
local u2 = setmetatable({}, Ragdoll);
u2.__index = u2;

function u2.new(...) -- Line: 14
    -- upvalues: Ragdoll (copy), u2 (copy)
    local v3 = Ragdoll.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2.PlayClient(u5, ...) -- Line: 26
    -- upvalues: Ragdoll (copy), Utility (copy), RunService (copy), u1 (copy), BetterDebris (copy)
    Ragdoll.PlayClient(u5, ...);
    local u6 = u5._is_humanoid and u5._subject.RootPart or u5._subject;
    local CFrame_Angles_ret = CFrame.Angles(0, math.random() * 3.141592653589793 * 2, 0);
    local u7 = script.Model:Clone();
    u7.Parent = workspace;
    table.insert(u5._destroy_these, u7);

    for _, child in pairs(u7.HumanoidRootPart.Attachment:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(child, 2);
        end;
    end;

    local v8 = RunService.RenderStepped:Connect(function() -- Line: 42
        -- upvalues: u7 (copy), u6 (copy), CFrame_Angles_ret (copy)
        u7:PivotTo(CFrame.new(u6.Position) * CFrame_Angles_ret);
    end);
    table.insert(u5._connections, v8);
    u5:CreateSound("rbxassetid://99054783153991", 1, 1 + 0.05 * math.random(), nil, true, 5);
    local success, result = pcall(u7.AnimationController.LoadAnimation, u7.AnimationController, u7.Animation);

    if success then
        result:Play(0);
        result:AdjustSpeed(1.5);
        u5:_InternalThread(task.spawn, function() -- Line: 56
            -- upvalues: u1 (ref), u7 (copy), Utility (ref), u5 (copy)
            local v9 = 0;

            for i, v in pairs(u1) do
                v9 = v9 + wait((v - 1 * i) / 60 / 1.5 - v9);
                local Attachment = u7.HumanoidRootPart.Attachment;
                local v10 = math.random() - 0.5;
                local v11 = math.random() - 0.5;
                local v12 = math.random() - 0.5;
                Attachment.Position = Vector3.new(v10, v11, v12) * 5;
                Utility:PlayParticles(u7.HumanoidRootPart.Attachment);
                u5:CreateSound("rbxassetid://11170608962", 0.75, 1 + 0.125 * i, nil, true, 5);
                u5:CreateSound("rbxassetid://14796313153", 1, 1 + 0.125 * i, nil, true, 5);
            end;
        end);

        if result.IsPlaying then
            result.Stopped:Wait();
        end;
    end;

    for _, descendant in pairs(u7:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Transparency = 1;
        end;
    end;

    BetterDebris:AddItem(u7, 3);
    v8:Disconnect();
end;

function u2._Init(p13) -- Line: 87
end;

return u2;