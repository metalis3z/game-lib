-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 15
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4, ...) -- Line: 27
    -- upvalues: Ragdoll (copy)
    Ragdoll.PlayServer(p4, ...);
    local v5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    wait(0.794);
    p4:_HideBody({ v5 });
end;

function u1.PlayClient(p6, ...) -- Line: 37
    -- upvalues: Ragdoll (copy), RunService (copy), Utility (copy), Players (copy)
    Ragdoll.PlayClient(p6, ...);
    local v7 = p6._is_humanoid and p6._subject.Parent or p6._subject;
    v7.Archivable = true;
    local v8 = v7:Clone();
    table.insert(p6._destroy_these, v8);
    local u9 = p6._is_humanoid and p6._subject.RootPart or p6._subject;
    local u10 = p6:_GetGroundPosition(u9.Position, p6:_GetObjects(true));
    local u11 = script.Model:Clone();
    u11.Parent = workspace;
    table.insert(p6._destroy_these, u11);
    local u12 = {};

    for _, descendant in pairs(u11:GetDescendants()) do
        if descendant:IsA("BasePart") or (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam")) then
            table.insert(u12, descendant);
        end;
    end;

    local u13 = nil;
    local Unit = (Random.new():NextUnitVector() * Vector3.new(1, 0, 1)).Unit;
    local u14 = tick();
    local v18 = RunService.RenderStepped:Connect(function() -- Line: 65
        -- upvalues: u14 (copy), u13 (ref), u9 (copy), u11 (copy), u10 (copy), Unit (copy), u12 (copy)
        local v15 = (tick() - u14) / 1;
        local v16 = math.clamp(v15, 0, 1) ^ 3;
        local v17 = (1 - math.sin(3.141592653589793 * v16)) ^ 10;

        if not u13 or v16 < 0.4 then
            u13 = u9.Position;
        end;

        u11:PivotTo(CFrame.new(u13.X, u10.Y, u13.Z) * CFrame.new(Vector3.new(0, 0, 0), -Unit).Rotation * CFrame.new(0, 0, v16 * 32 + -16) * CFrame.Angles(0, -1.5707963267948966, 0));

        for _, v in pairs(u12) do
            v.LocalTransparencyModifier = v17;
        end;
    end);
    table.insert(p6._connections, v18);
    p6:CreateSound("rbxassetid://70481114201477", 1, 1 + 0.25 * math.random(), u11:GetChildren()[1], true, 10);
    p6:CreateSound("rbxassetid://96644061235295", 1, 1 + 0.25 * math.random(), u11:GetChildren()[1], true, 10);
    wait(0.5940000000000001);
    p6:CreateSound("rbxassetid://88391131441060", 1, 1 + 0.25 * math.random(), u11:GetChildren()[1], true, 10);
    wait(0.2);
    local Camera = Instance.new("Camera");
    local v19 = script.Flattened:Clone();
    v19.CFrame = CFrame.new(p6:_GetGroundPosition(u9.Position, p6:_GetObjects(true)));
    v19.Parent = workspace;
    table.insert(p6._destroy_these, v19);

    for _, v in pairs({ u11:GetDescendants(), p6:_GetObjects(true) }) do
        for _, v2 in pairs(v) do
            if v2:IsA("BasePart") then
                local NoCollisionConstraint = Instance.new("NoCollisionConstraint");
                NoCollisionConstraint.Part0 = v2;
                NoCollisionConstraint.Part1 = v19;
                NoCollisionConstraint.Parent = v19;
            end;
        end;
    end;

    for _, descendant in pairs(v19:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(descendant, 2);
        end;
    end;

    Utility:PlayParticles(v19);
    local SurfaceGui = v19.SurfaceGui;
    SurfaceGui.ViewportFrame.CurrentCamera = Camera;
    SurfaceGui.Adornee = v19;
    SurfaceGui.Parent = Players.LocalPlayer.PlayerGui;
    table.insert(p6._destroy_these, SurfaceGui);
    local v20 = v8:Clone();
    v20:PivotTo(v20:GetPivot().Rotation);
    v20.Parent = SurfaceGui.ViewportFrame;
    Camera.CFrame = CFrame.new(Vector3.new(0, 15, 0), Vector3.new(0, 0, 0)) * CFrame.Angles(0, 0, 3.141592653589793);
    Camera.FieldOfView = 30;
    Camera.Parent = SurfaceGui.ViewportFrame;
    wait(0.20599999999999996);
    v18:Disconnect();
    wait(3);
    u11:Destroy();
end;

function u1._Init(p21) -- Line: 146
end;

return u1;