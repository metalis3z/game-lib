-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4, ...) -- Line: 23
    -- upvalues: Ragdoll (copy), BetterDebris (copy)
    Ragdoll.PlayServer(p4, ...);
    local v5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    local v6 = p4._eliminator and p4._eliminator.Character and p4._eliminator.Character:FindFirstChild("HumanoidRootPart");

    if not v6 then
        return;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000);
    BodyVelocity.Velocity = CFrame.new(v6.Position, v5.Position).LookVector * 100;
    BodyVelocity.Parent = v5;
    BetterDebris:AddItem(BodyVelocity, 3);
end;

function u1.PlayClient(p7, ...) -- Line: 40
    -- upvalues: Ragdoll (copy), RunService (copy), Utility (copy)
    Ragdoll.PlayClient(p7, ...);
    local u8 = p7._is_humanoid and p7._subject.RootPart or p7._subject;
    local u9 = p7._eliminator and p7._eliminator.Character and p7._eliminator.Character:FindFirstChild("HumanoidRootPart");

    if not u9 then
        return;
    end;

    local u10 = script.Particles:Clone();
    u10.Parent = workspace;
    table.insert(p7._destroy_these, u10);
    p7:CreateSound("rbxassetid://87269038986811", 1.25, 0.95 + 0.1 * math.random(), u8, true, 10);
    local v11 = RunService.RenderStepped:Connect(function() -- Line: 56
        -- upvalues: u9 (copy), u8 (copy), u10 (copy)
        local CFrame_new_ret = CFrame.new(u9.Position, u8.Position);
        u10.Hit.WorldCFrame = CFrame.new(u8.Position) * CFrame_new_ret.Rotation;
        u10.Start.WorldCFrame = CFrame_new_ret * CFrame.new(0, 0, -1);
    end);
    table.insert(p7._connections, v11);
    local u12 = {};

    for _, descendant in pairs(u10:GetDescendants()) do
        if descendant:IsA("Beam") then
            u12[descendant] = { descendant.Width0, descendant.Width1 };
        end;
    end;

    Utility:RenderstepForLoop(0, 1, 0.01, function(p13) -- Line: 73
        -- upvalues: u12 (copy)
        local v14 = 1 - p13 ^ 4;

        for i, v in pairs(u12) do
            i.Width0 = v[1] * v14;
            i.Width1 = v[2] * v14;
        end;
    end);

    for _, descendant in pairs(u10:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    wait(1);
    v11:Disconnect();
end;

function u1._Init(p15) -- Line: 97
end;

return u1;