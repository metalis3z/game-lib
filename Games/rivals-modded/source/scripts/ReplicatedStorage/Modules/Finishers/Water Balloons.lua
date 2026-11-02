-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = { 50, 55, 57, 58, 62, 63, 75, 78, 104, 107, 111, 115 };
local u2 = { "rbxassetid://122599219317279" };
local u3 = {
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 0, 255)
};
local u4 = setmetatable({}, Ragdoll);
u4.__index = u4;

function u4.new(...) -- Line: 16
    -- upvalues: Ragdoll (copy), u4 (copy)
    local v5 = Ragdoll.new(...);
    local v6 = setmetatable(v5, u4);
    v6:_Init();

    return v6;
end;

function u4.PlayClient(u7, ...) -- Line: 28
    -- upvalues: Ragdoll (copy), u3 (copy), Utility (copy), RunService (copy), u1 (copy), u2 (copy), BetterDebris (copy)
    Ragdoll.PlayClient(u7, ...);
    local u8 = u7._is_humanoid and u7._subject.RootPart or u7._subject;
    local CFrame_Angles_ret = CFrame.Angles(0, math.random() * 3.141592653589793 * 2, 0);
    local u9 = script.Model:Clone();
    u9.Parent = workspace;
    table.insert(u7._destroy_these, u9);

    for i = 1, 10 do
        u9["Snowball" .. i].Color = u3[math.random(#u3)];
        local _ = i;
    end;

    for _, child in pairs(u9.HumanoidRootPart.Attachment:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(child, 1.5);
        end;
    end;

    local v10 = RunService.RenderStepped:Connect(function() -- Line: 48
        -- upvalues: u9 (copy), u8 (copy), CFrame_Angles_ret (copy)
        u9:PivotTo(CFrame.new(u8.Position) * CFrame_Angles_ret);
    end);
    table.insert(u7._connections, v10);
    local success, result = pcall(u9.AnimationController.LoadAnimation, u9.AnimationController, u9.Animation);

    if success then
        result:Play(0);
        result:AdjustSpeed(1);
        u7:_InternalThread(task.spawn, function() -- Line: 60
            -- upvalues: u1 (ref), u9 (copy), Utility (ref), u7 (copy), u2 (ref)
            local v11 = 0.08333333333333333;

            for i, v in pairs(u1) do
                v11 = v11 + wait((v - 1 * i) / 60 / 1 - v11);
                local Attachment = u9.HumanoidRootPart.Attachment;
                local v12 = math.random() - 0.5;
                local v13 = math.random() - 0.5;
                local v14 = math.random() - 0.5;
                Attachment.Position = Vector3.new(v12, v13, v14) * 5;
                Utility:PlayParticles(u9.HumanoidRootPart.Attachment);
                u7:CreateSound(u2[math.random(#u2)], 0.4 + 0.4 * (i / #u1), 0.9 + 0.2 * math.random(), nil, true, 5);
            end;
        end);

        if result.IsPlaying then
            result.Stopped:Wait();
        end;
    end;

    for _, descendant in pairs(u9:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Transparency = 1;
        end;
    end;

    BetterDebris:AddItem(u9, 3);
    v10:Disconnect();
end;

function u4._Init(p15) -- Line: 90
end;

return u4;