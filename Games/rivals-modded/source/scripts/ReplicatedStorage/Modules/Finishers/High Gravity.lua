-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4, ...) -- Line: 22
    -- upvalues: Ragdoll (copy), BetterDebris (copy)
    Ragdoll.PlayServer(p4, ...);
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(0, 10000, 0);
    BodyVelocity.Velocity = Vector3.new(0, -100, 0);
    BodyVelocity.Parent = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    BetterDebris:AddItem(BodyVelocity, 3);
end;

function u1.PlayClient(p5, ...) -- Line: 32
    -- upvalues: Ragdoll (copy), RunService (copy)
    Ragdoll.PlayClient(p5, ...);
    local u6 = p5._is_humanoid and p5._subject.RootPart or p5._subject;
    local u7 = script.Particles:Clone();
    u7.Parent = u6;
    table.insert(p5._destroy_these, u7);
    local v8 = RunService.RenderStepped:Connect(function() -- Line: 41
        -- upvalues: u7 (copy), u6 (copy)
        u7.CFrame = CFrame.new(u6.Position);
    end);
    table.insert(p5._connections, v8);
    p5:CreateSound("rbxassetid://71853893910123", 2, 1, nil, true, 5);
    wait(3);
    v8:Disconnect();

    for _, descendant in pairs(u7:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;
end;

function u1._Init(p9) -- Line: 64
end;

return u1;