-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
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
    Ragdoll.PlayServer(p4, ...);
    wait(1.0833333333333333);

    for _, v in pairs(p4:_GetObjects(true)) do
        if v:IsA("BasePart") then
            v.Anchored = true;
            v.CanCollide = false;
            v.CollisionGroup = "Noclip";
        end;
    end;
end;

function u1.PlayClient(p5, ...) -- Line: 38
    -- upvalues: Ragdoll (copy), RunService (copy), Utility (copy), Players (copy)
    Ragdoll.PlayClient(p5, ...);
    local u6 = p5._is_humanoid and p5._subject.RootPart or p5._subject;
    local CFrame_Angles_ret = CFrame.Angles(0, math.random() * 3.141592653589793 * 2, 0);
    local u7 = script.Model:Clone();
    u7.Parent = workspace;
    table.insert(p5._destroy_these, u7);
    local v8 = RunService.RenderStepped:Connect(function() -- Line: 48
        -- upvalues: u7 (copy), u6 (copy), CFrame_Angles_ret (copy)
        u7:PivotTo(CFrame.new(u6.Position) * CFrame_Angles_ret - Vector3.new(0, 1.5, 0));
    end);
    table.insert(p5._connections, v8);
    p5:CreateSound("rbxassetid://85156927480464", 2, 0.75, nil, true, 5);
    local success, result = pcall(u7.AnimationController.LoadAnimation, u7.AnimationController, u7.Animation);

    if success then
        result:Play(0);
        wait(1.0833333333333333);
        p5:CreateSound("rbxassetid://4164190231", 1, 1 + 0.1 * math.random(), nil, true, 5);
        local Camera = Instance.new("Camera");
        local v9 = script.Flattened:Clone();
        v9.CFrame = CFrame.new(u6.Position);
        v9.Parent = workspace;
        table.insert(p5._destroy_these, v9);

        for _, descendant in pairs(v9:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                Utility:ScaleParticleEmitter(descendant, 2);
            end;
        end;

        Utility:PlayParticles(v9);
        local SurfaceGui = v9.SurfaceGui;
        SurfaceGui.ViewportFrame.CurrentCamera = Camera;
        SurfaceGui.Adornee = v9;
        SurfaceGui.Parent = Players.LocalPlayer.PlayerGui;
        table.insert(p5._destroy_these, SurfaceGui);
        local v10 = p5._is_humanoid and p5._subject.Parent or p5._subject;
        v10.Archivable = true;
        local v11 = v10:Clone();
        v11:PivotTo(v11:GetPivot().Rotation);
        v11.Parent = SurfaceGui.ViewportFrame;
        Camera.CFrame = CFrame.new(Vector3.new(0, 15, 0), Vector3.new(0, 0, 0)) * CFrame.Angles(0, 0, 3.141592653589793);
        Camera.FieldOfView = 30;
        Camera.Parent = SurfaceGui.ViewportFrame;

        for _, descendant in pairs(v10:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.Transparency = 1;
            elseif descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or descendant:IsA("Decal"))) then
                descendant:Destroy();
            end;
        end;

        if result.IsPlaying then
            result.Stopped:Wait();
        end;

        u7:Destroy();
        wait(3);
    end;

    v8:Disconnect();
end;

function u1._Init(p12) -- Line: 121
end;

return u1;