-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
require(ReplicatedStorage.Modules.BetterDebris);
require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 12
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(p4) -- Line: 24
    -- upvalues: Players (copy), RunService (copy)
    local u5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    local CFrame_Angles_ret = CFrame.Angles(0, math.random() * 3.141592653589793 * 2, 0);
    local v6 = p4._is_humanoid and Players:GetPlayerFromCharacter(p4._subject.Parent);
    local v7 = v6 and v6.DisplayName or "";
    local u8 = script.Model:Clone();
    u8.Tomb.Part.Front.Player.Text = v7;
    u8.Tomb.Part.Back.Player.Text = v7;
    u8.Parent = workspace;
    table.insert(p4._destroy_these, u8);
    local v9 = RunService.RenderStepped:Connect(function() -- Line: 37
        -- upvalues: u8 (copy), u5 (copy), CFrame_Angles_ret (copy)
        u8:PivotTo(CFrame.new(u5.Position) * CFrame_Angles_ret + Vector3.new(0, 2.25, 0));
    end);
    table.insert(p4._connections, v9);
    local success, result = pcall(u8.AnimationController.LoadAnimation, u8.AnimationController, u8.Animation);

    if success then
        result:Play(0);
        p4:CreateSound("rbxassetid://85156927480464", 1.5, 0.75, nil, true, 5);
        wait(0.7);

        for _, descendant in pairs((p4._is_humanoid and p4._subject.Parent or p4._subject):GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.Transparency = 1;
            elseif descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or descendant:IsA("Decal"))) then
                descendant:Destroy();
            end;
        end;

        p4:CreateSound("rbxassetid://112796414625817", 2, 0.75, nil, true, 5);
        p4:CreateSound("rbxassetid://75913059184380", 2, 1 + 0.1 * math.random(), nil, true, 10);
        wait(9);
        p4:CreateSound("rbxassetid://125843357117650", 2, 0.75, nil, true, 5);

        if result.IsPlaying then
            result.Stopped:Wait();
        end;

        u8:Destroy();
        wait(3);
    end;

    v9:Disconnect();
end;

function u1._Init(p10) -- Line: 83
end;

return u1;