-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
require(ReplicatedStorage.Modules.Utility);
local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
local TweenInfo_new_ret2 = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In);
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
    -- upvalues: Ragdoll (copy), BetterDebris (copy)
    Ragdoll.PlayServer(p4, ...);
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(0, 10000, 0);
    BodyVelocity.Velocity = Vector3.new(0, -100, 0);
    BodyVelocity.Parent = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    BetterDebris:AddItem(BodyVelocity, 3);
end;

function u1.PlayClient(p5, ...) -- Line: 37
    -- upvalues: Ragdoll (copy), TweenService (copy), TweenInfo_new_ret (copy), RunService (copy), TweenInfo_new_ret2 (copy)
    Ragdoll.PlayClient(p5, ...);
    local v6 = p5._is_humanoid and p5._subject.RootPart or p5._subject;
    local v7 = p5:_GetGroundPosition(v6.Position, { p5._is_humanoid and p5._subject.Parent or p5._subject });

    for _, v in pairs(p5:_GetObjects(true)) do
        if v:IsA("BasePart") and v ~= v6 then
            v:Destroy();
        end;
    end;

    v6.Size = Vector3.new(0, 0, 0);
    local u8 = script.DustPile:Clone();
    u8.Anchored = true;
    u8.Size = Vector3.new(0, 0, 0);
    u8.CFrame = CFrame.new(v7) * CFrame.new(0, u8.Size.Y / 2, 0);
    u8.CollisionGroup = "IgnoreEntities";
    u8.Parent = v6;
    table.insert(p5._destroy_these, u8);
    TweenService:Create(u8, TweenInfo_new_ret, {
        Size = script.DustPile.Size
    }):Play();
    local u9 = script.Particles:Clone();
    u9.Parent = u8;
    table.insert(p5._destroy_these, u9);
    local v10 = RunService.RenderStepped:Connect(function() -- Line: 64
        -- upvalues: u9 (copy), u8 (copy)
        u9.CFrame = CFrame.new(u8.Position + Vector3.new(0, 1, 0));
    end);
    table.insert(p5._connections, v10);
    p5:CreateSound("rbxassetid://118654142384127", 1.25, 0.95 + 0.1 * math.random(), u9, true, 10);
    wait(1);
    v10:Disconnect();

    for _, descendant in pairs(u9:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    u8.Smoke.smoke1.Enabled = false;
    u8.Smoke.smoke2.Enabled = false;
    wait(1);
    u9:Destroy();
    wait(1);
    TweenService:Create(u8, TweenInfo_new_ret2, {
        Size = Vector3.new(0, 0, 0)
    }):Play();
    wait(1);
end;

function u1._Init(p11) -- Line: 100
end;

return u1;