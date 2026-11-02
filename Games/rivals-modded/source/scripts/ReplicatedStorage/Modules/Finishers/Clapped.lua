-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Spring = require(ReplicatedStorage.Modules.Spring);
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
    p4:_AnchorModel(0);
    wait(0.3);
    p4:_HideBody();
end;

function u1.PlayClient(p5) -- Line: 34
    -- upvalues: Spring (copy), RunService (copy), Utility (copy), Players (copy)
    local v6 = p5._is_humanoid and p5._subject.RootPart or p5._subject;
    local CFrame_Angles_ret = CFrame.Angles(0, math.random() * 3.141592653589793 * 2, 0);
    local v7 = p5._is_humanoid and p5._subject.Parent or p5._subject;
    v7.Archivable = true;
    local v8 = v7:Clone();
    table.insert(p5._destroy_these, v8);
    local v9 = script.Model:Clone();
    v9.Parent = workspace;
    table.insert(p5._destroy_these, v9);
    local v10 = v9.Left:GetPivot():ToObjectSpace(v9.PrimaryPart.CFrame):Inverse();
    local v11 = v9.Right:GetPivot():ToObjectSpace(v9.PrimaryPart.CFrame):Inverse();
    local v12 = Spring.new(v6.Position, 1, 10);
    local Size = v9.Right.Size;
    local Size2 = v9.Left.Size;
    local v13 = tick();

    while tick() < v13 + 0.3 do
        local v14 = (tick() - v13) / 0.3;
        local v15 = math.clamp(v14, 0, 1) ^ 2;
        v12.Target = v6.Position;
        v9.PrimaryPart.CFrame = CFrame.new(v12.Value) * CFrame_Angles_ret;
        v9.Right.Size = Size * (v15 * 1 + 1);
        v9.Left.Size = Size2 * (v15 * 1 + 1);
        v9.Right:PivotTo(v9.PrimaryPart.CFrame * v11 * CFrame.Angles(0, 0, v15 * -2.356194490192345));
        v9.Left:PivotTo(v9.PrimaryPart.CFrame * v10 * CFrame.Angles(0, 0, v15 * 2.356194490192345));
        RunService.RenderStepped:Wait();
    end;

    p5:CreateSound("rbxassetid://100411689677104", 1.5, 1, v9.Primary, true, 5);
    p5:CreateSound("rbxassetid://92760487729234", 2.5, 1, v9.Primary, true, 5);
    Utility:PlayParticles(v9);
    local v16 = script.Flattened:Clone();
    v16.CFrame = CFrame.new(v6.Position) * CFrame_Angles_ret;
    v16.RotVelocity = Vector3.new(0, 20, 0) + Random.new():NextUnitVector() * 5;
    v16.Parent = workspace;
    table.insert(p5._destroy_these, v16);

    for _, v in pairs(p5:_GetObjects(true)) do
        if v:IsA("BasePart") then
            local NoCollisionConstraint = Instance.new("NoCollisionConstraint");
            NoCollisionConstraint.Part0 = v;
            NoCollisionConstraint.Part1 = v16;
            NoCollisionConstraint.Parent = v16;
        end;
    end;

    local v17 = { CFrame_Angles_ret * CFrame.new(0, 0, 15), CFrame_Angles_ret * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 15) };

    for i, v in pairs(v17) do
        local Camera = Instance.new("Camera");
        local v18 = v16[i];
        v18.ViewportFrame.CurrentCamera = Camera;
        v18.Adornee = v16;
        v18.Parent = Players.LocalPlayer.PlayerGui;
        local v19 = v8:Clone();
        v19:PivotTo(v19:GetPivot().Rotation);
        v19.Parent = v18.ViewportFrame;
        Camera.CFrame = CFrame.new(v.Position, Vector3.new(0, 0, 0));
        Camera.FieldOfView = 30;
        Camera.Parent = v18.ViewportFrame;
    end;

    local Pivot = v9:GetPivot();
    local v20 = tick();

    while tick() < v20 + 0.1 do
        local v21 = math.random() - 0.5;
        local v22 = math.random() - 0.5;
        local v23 = math.random() - 0.5;
        v9:PivotTo(Pivot + Vector3.new(v21, v22, v23) * math.random() * 1);
        RunService.RenderStepped:Wait();
    end;

    for _, descendant in pairs(v9:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Anchored = false;
        end;
    end;
end;

function u1._Init(p24) -- Line: 131
end;

return u1;