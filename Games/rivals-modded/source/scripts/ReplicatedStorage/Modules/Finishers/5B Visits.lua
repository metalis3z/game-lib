-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = CFrame.Angles(0, 3.141592653589793, 0) * CFrame.Angles(1.5707963267948966, 0, 1.5707963267948966) * CFrame.Angles(0, -1.5707963267948966, 0);
local u2 = setmetatable({}, Finisher);
u2.__index = u2;

function u2.new(...) -- Line: 15
    -- upvalues: Finisher (copy), u2 (copy)
    local v3 = Finisher.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2.PlayServer(p5, ...) -- Line: 27
    -- upvalues: Finisher (copy)
    Finisher.PlayServer(p5, ...);
    (p5._is_humanoid and p5._subject.RootPart or p5._subject).Anchored = true;
    wait(3.15);

    for _, v in pairs(p5:_GetObjects(true)) do
        if v:IsA("BasePart") then
            v.Anchored = true;
            v.CanCollide = false;
            v.CollisionGroup = "Noclip";
        end;
    end;
end;

function u2.PlayClient(u6) -- Line: 45
    -- upvalues: RunService (copy), u1 (copy), Utility (copy), Players (copy)
    local u7 = u6._is_humanoid and u6._subject.RootPart or u6._subject;

    if u6._is_humanoid then
        pcall(function() -- Line: 49
            -- upvalues: u6 (copy)
            local Animation = Instance.new("Animation");
            Animation.AnimationId = "rbxassetid://102021872417441";
            u6._subject:LoadAnimation(Animation):Play();
        end);
    end;

    local u8 = nil;
    local u9 = script:WaitForChild("Sign"):Clone();
    u9.Parent = workspace;
    table.insert(u6._destroy_these, u9);
    u6:CreateSound("rbxassetid://8970814778", 1, 0.9, nil, true, 5);
    local CFrame_new_ret = CFrame.new(0, 256, 0);
    local CFrame_identity = CFrame.identity;
    local _ = u9.Size;
    local u10 = tick();
    local v15 = RunService.RenderStepped:Connect(function() -- Line: 72
        -- upvalues: u10 (copy), u8 (ref), u7 (copy), CFrame_new_ret (copy), CFrame_identity (copy), u9 (copy), u1 (ref)
        local v11 = (tick() - u10) / 3.15;
        local v12 = math.clamp(v11, 0, 1) ^ 2;
        local v13 = (tick() - (u10 + 3.15)) / 4;
        local _ = math.clamp(v13, 0, 1) ^ 2;
        local v14 = CFrame.new(u8 and u8.Position or u7.Position) * CFrame_new_ret:Lerp(CFrame_identity, v12) + Vector3.new(0, u9.Size.X / 2, 0);
        local CFrame_new_ret2 = CFrame.new(v14.Position * Vector3.new(1, 0, 1), workspace.CurrentCamera.CFrame.Position * Vector3.new(1, 0, 1));
        u9:PivotTo(v14 * (CFrame_new_ret2.LookVector == CFrame_new_ret2.LookVector and CFrame_new_ret2.Rotation or CFrame.identity) * u1);
    end);
    table.insert(u6._connections, v15);
    wait(3.15);
    u6:CreateSound("rbxassetid://105824621418784", 1.25, 1, nil, true, 5);
    u6:CreateSound("rbxassetid://89635888410432", 1.25, 1, nil, true, 5);
    local Camera = Instance.new("Camera");
    u8 = script.Flattened:Clone();
    u8.CFrame = CFrame.new(u7.Position);
    u8.Parent = workspace;
    table.insert(u6._destroy_these, u8);

    for _, descendant in pairs(u8:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(descendant, 3);
        end;
    end;

    Utility:PlayParticles(u8);
    local SurfaceGui = u8.SurfaceGui;
    SurfaceGui.ViewportFrame.CurrentCamera = Camera;
    SurfaceGui.Adornee = u8;
    SurfaceGui.Parent = Players.LocalPlayer.PlayerGui;
    table.insert(u6._destroy_these, SurfaceGui);
    local v16 = u6._is_humanoid and u6._subject.Parent or u6._subject;
    v16.Archivable = true;
    local v17 = v16:Clone();
    v17:PivotTo(v17:GetPivot().Rotation);
    v17.Parent = SurfaceGui.ViewportFrame;
    Camera.CFrame = CFrame.new(Vector3.new(0, 15, 0), Vector3.new(0, 0, 0)) * CFrame.Angles(0, 0, 3.141592653589793);
    Camera.FieldOfView = 30;
    Camera.Parent = SurfaceGui.ViewportFrame;

    for _, descendant in pairs(v16:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Transparency = 1;
        elseif descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or descendant:IsA("Decal"))) then
            descendant:Destroy();
        end;
    end;

    wait(2);
    u8.CanCollide = false;
    wait(2);
    v15:Disconnect();
    u9:Destroy();
end;

function u2._Init(p18) -- Line: 144
end;

return u2;