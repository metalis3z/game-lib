-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
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

function u1.PlayServer(p4) -- Line: 27
    -- upvalues: Ragdoll (copy), RunService (copy)
    Ragdoll.PlayServer(p4);

    if not p4._is_humanoid then
        return;
    end;

    p4:_AnchorModel(0, false);
    local RootPart = p4._subject.RootPart;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
    BodyVelocity.Velocity = Vector3.new(0, 64, 0);
    BodyVelocity.Parent = RootPart;
    table.insert(p4._destroy_these, BodyVelocity);
    wait(0.5);
    local v5 = tick();

    while tick() < v5 + 0.75 do
        local v6 = (tick() - v5) / 0.75;
        local math_clamp_ret = math.clamp(v6, 0, 1);
        BodyVelocity.Velocity = (CFrame.new(Vector3.new(0, 0, 0), Vector3.new(0, 1, 0)) * CFrame.Angles(6.283185307179586 * math_clamp_ret, 0, 0)).LookVector * 64;
        RunService.Heartbeat:Wait();
    end;

    BodyVelocity.Velocity = Vector3.new(0, 64, 0);
    wait(1);
    BodyVelocity:Destroy();
    local v7 = math.random() - 0.5;
    local v8 = math.random() - 0.5;
    RootPart.Velocity = Vector3.new(0, 64, 0) + Vector3.new(v7, 0, v8) * 64 * 0.1;
    p4:_AnchorModel();
end;

function u1.PlayClient(p9) -- Line: 66
    -- upvalues: Ragdoll (copy), Utility (copy)
    Ragdoll.PlayClient(p9);

    if not p9._is_humanoid then
        return;
    end;

    local RootPart = p9._subject.RootPart;
    local v10 = {};

    for _, child in pairs(script.Trail:GetChildren()) do
        local v11 = child:Clone();
        v11.Parent = RootPart;
        table.insert(p9._destroy_these, v11);
        table.insert(v10, v11);
    end;

    p9:CreateSound("rbxassetid://108099224793848", 1.25, 1 + 0.1 * math.random(), nil, true, 5);
    wait(2.25);

    for _, v in pairs(v10) do
        if v:IsA("ParticleEmitter") then
            v.Enabled = false;
        end;

        for _, descendant in pairs(v:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end;

    local v12 = script.Explode.Attachment:Clone();
    v12.Parent = RootPart;
    Utility:PlayParticles(v12);
    table.insert(p9._destroy_these, v12);
    p9:CreateSound("rbxassetid://133816595599115", 1.5, 1 + 0.1 * math.random(), nil, true, 5);
end;

function u1._Init(p13) -- Line: 111
end;

return u1;