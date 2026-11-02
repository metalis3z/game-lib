-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 16
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4, ...) -- Line: 28
    -- upvalues: Ragdoll (copy)
    Ragdoll.PlayServer(p4, ...);
    local v5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    wait(0.5);
    p4:_HideBody({ v5 });
end;

function u1.PlayClient(p6, ...) -- Line: 38
    -- upvalues: Ragdoll (copy), RunService (copy), Utility (copy), Players (copy)
    Ragdoll.PlayClient(p6, ...);
    local v7 = p6._is_humanoid and p6._subject.Parent or p6._subject;
    v7.Archivable = true;
    local v8 = v7:Clone();
    table.insert(p6._destroy_these, v8);
    local u9 = p6:_GetTemplate():Clone();
    u9.Parent = workspace;
    table.insert(p6._destroy_these, u9);
    local Broken = u9:FindFirstChild("Broken");

    if Broken then
        for _, descendant in pairs(Broken:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.LocalTransparencyModifier = 1;
            end;
        end;
    end;

    local u10 = p6._is_humanoid and p6._subject.RootPart or p6._subject;
    local CFrame_Angles_ret = CFrame.Angles(0, math.random() * 3.141592653589793 * 2, 0);
    local u11 = tick();
    local v18 = RunService.Heartbeat:Connect(function() -- Line: 64
        -- upvalues: u10 (copy), u11 (copy), CFrame_Angles_ret (copy), u9 (copy)
        local CFrame_new_ret = CFrame.new(u10.Position);
        local v12, v13, v14;

        if tick() < u11 + 0.5 then
            local v15 = (tick() - u11) / 0.5;
            v12 = math.clamp(v15, 0, 1);
            v13 = CFrame_new_ret * (CFrame_Angles_ret * CFrame.Angles(0, 3.141592653589793, 0):Lerp(CFrame.identity, v12 ^ 6));
            v14 = Vector3.new(0, 128, 0);
        else
            local v16 = (tick() - u11 - 0.5) / 0.5;
            local math_clamp_ret = math.clamp(v16, 0, 1);
            local v17 = math.sin(4.71238898038469 * math_clamp_ret) * (1 - math_clamp_ret);
            v12 = 1 - math.abs(v17);
            v13 = CFrame_new_ret * (CFrame_Angles_ret * CFrame.identity:Lerp(CFrame.Angles(0, 2.827433388230814, 0), 1 - (1 - math_clamp_ret) ^ 6));
            v14 = Vector3.new(0, 12, 0);
        end;

        u9:PivotTo(v13 + v14:Lerp(Vector3.new(0, 0, 0), v12));
    end);
    table.insert(p6._connections, v18);
    wait(0.5);

    if Broken then
        u9.Normal:Destroy();

        for _, descendant in pairs(Broken:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.LocalTransparencyModifier = 0;
            end;
        end;
    end;

    local Camera = Instance.new("Camera");
    local v19 = script.Flattened:Clone();
    v19.CFrame = CFrame.new(u10.Position);
    v19.Parent = workspace;
    table.insert(p6._destroy_these, v19);

    for _, v in pairs({ u9:GetDescendants(), p6:_GetObjects(true) }) do
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
    p6:CreateSound("rbxassetid://122470995632560", 1, 1, nil, true, 5);
    p6:CreateSound("rbxassetid://88491524279903", 1, 1, nil, true, 5);

    if u9.Name == "Piano" then
        p6:CreateSound("rbxassetid://129097983310355", 1, 0.75 + 0.5 * math.random(), nil, true, 5);
    end;

    wait(0.5);
    v18:Disconnect();
    wait(3);
end;

function u1._GetSortedChildren(p21) -- Line: 157
    -- upvalues: Utility (copy)
    local Children = script.Models:GetChildren();
    table.sort(Children, function(p22, p23) -- Line: 160
        -- upvalues: Utility (ref)
        return Utility:StringLessThan(p22.Name, p23.Name);
    end);

    return Children;
end;

function u1._GetTemplate(p24) -- Line: 167
    local v25 = p24:_GetSortedChildren();

    return v25[Random.new(p24._serial and p24._serial.Seed or p24._seed):NextInteger(1, #v25)];
end;

function u1._Init(p26) -- Line: 172
end;

return u1;