-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = { 50, 55, 57, 58, 62, 63, 75, 78, 104, 107, 111, 115 };
local u2 = { "rbxassetid://11800684674", "rbxassetid://11800684590", "rbxassetid://11800684481" };
local u3 = setmetatable({}, Ragdoll);
u3.__index = u3;

function u3.new(...) -- Line: 15
    -- upvalues: Ragdoll (copy), u3 (copy)
    local v4 = Ragdoll.new(...);
    local v5 = setmetatable(v4, u3);
    v5:_Init();

    return v5;
end;

function u3.PlayClient(u6, ...) -- Line: 27
    -- upvalues: Ragdoll (copy), Utility (copy), RunService (copy), u1 (copy), u2 (copy), BetterDebris (copy)
    Ragdoll.PlayClient(u6, ...);
    local u7 = u6._is_humanoid and u6._subject.RootPart or u6._subject;
    local CFrame_Angles_ret = CFrame.Angles(0, math.random() * 3.141592653589793 * 2, 0);
    local u8 = script.Model:Clone();
    u8.Parent = workspace;
    table.insert(u6._destroy_these, u8);

    for _, child in pairs(u8.HumanoidRootPart.Attachment:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(child, 1.5);
        end;
    end;

    local v9 = RunService.RenderStepped:Connect(function() -- Line: 43
        -- upvalues: u8 (copy), u7 (copy), CFrame_Angles_ret (copy)
        u8:PivotTo(CFrame.new(u7.Position) * CFrame_Angles_ret);
    end);
    table.insert(u6._connections, v9);
    local success, result = pcall(u8.AnimationController.LoadAnimation, u8.AnimationController, u8.Animation);

    if success then
        result:Play(0);
        result:AdjustSpeed(1);
        u6:_InternalThread(task.spawn, function() -- Line: 55
            -- upvalues: u1 (ref), u8 (copy), Utility (ref), u6 (copy), u2 (ref)
            local v10 = 0.08333333333333333;

            for i, v in pairs(u1) do
                v10 = v10 + wait((v - 1 * i) / 60 / 1 - v10);
                local Attachment = u8.HumanoidRootPart.Attachment;
                local v11 = math.random() - 0.5;
                local v12 = math.random() - 0.5;
                local v13 = math.random() - 0.5;
                Attachment.Position = Vector3.new(v11, v12, v13) * 5;
                Utility:PlayParticles(u8.HumanoidRootPart.Attachment);
                u6:CreateSound(u2[math.random(#u2)], 0.4 + 0.4 * (i / #u1), 0.9 + 0.2 * math.random(), nil, true, 5);
            end;
        end);

        if result.IsPlaying then
            result.Stopped:Wait();
        end;
    end;

    for _, descendant in pairs(u8:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Transparency = 1;
        end;
    end;

    BetterDebris:AddItem(u8, 3);
    v9:Disconnect();
end;

function u3._Init(p14) -- Line: 85
end;

return u3;