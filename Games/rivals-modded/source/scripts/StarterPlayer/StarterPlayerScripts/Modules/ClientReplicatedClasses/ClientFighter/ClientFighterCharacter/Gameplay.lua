-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local Spring = require(ReplicatedStorage.Modules.Spring);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local DashParticles = Players.LocalPlayer.PlayerScripts.Assets.Misc.DashParticles;
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 16
    -- upvalues: u1 (copy), Signal (copy), Spring (copy)
    local v3 = setmetatable({}, u1);
    v3.RedirectSliding = Signal.new();
    v3.ClientFighterCharacter = p2;
    v3._destroyed = false;
    v3._fov_offset_spring = Spring.new(0, 0.75, 10);
    v3._hard_dashes = {};
    v3:_Init();

    return v3;
end;

function u1.GetFOVOffset(p4) -- Line: 36
    return p4._fov_offset_spring.Value;
end;

function u1.CancelHardDash(p5, p6) -- Line: 40
    local v7 = p5._hard_dashes[p6];

    if not v7 then
        return;
    end;

    v7.Velocity:Destroy();

    for _, v in pairs(v7.Threads) do
        pcall(task.cancel, v);
    end;

    p5._hard_dashes[p6] = nil;
    local RootPart = p5.ClientFighterCharacter.RootPart;
    RootPart.AssemblyLinearVelocity = RootPart.AssemblyLinearVelocity * v7.StopVector;
end;

function u1.HardDash(u8, p9, u10, p11, p12, u13) -- Line: 57
    -- upvalues: BetterDebris (copy), DashParticles (copy), RunService (copy)
    u8.ClientFighterCharacter:AirborneCancel();
    u8.ClientFighterCharacter.ClientFighter.StopSliding:Fire();
    u8.ClientFighterCharacter.Sounds:DisableFootsteps(u10);
    local u14 = {
        Velocity = Instance.new("BodyVelocity"),
        Threads = {},
        StopVector = p12 or Vector3.new(0, 0, 0),
        Velocity = Instance.new("BodyVelocity")
    };
    u14.Velocity.MaxForce = Vector3.new(40000, 40000, 40000);
    u14.Velocity.Velocity = p9;
    u14.Velocity.Parent = u8.ClientFighterCharacter.RootPart;
    BetterDebris:AddItem(u14.Velocity, u10 + 0.1);
    table.insert(u14.Threads, task.delay(u10, function() -- Line: 74
        -- upvalues: u13 (copy), u8 (copy), u14 (copy)
        if u13 then
            u8:CancelHardDash(u13);
        end;

        u14.Velocity:Destroy();
        local RootPart = u8.ClientFighterCharacter.RootPart;
        RootPart.AssemblyLinearVelocity = RootPart.AssemblyLinearVelocity * u14.StopVector;
        u8.ClientFighterCharacter:AirborneCancel();
        u8.ClientFighterCharacter.ClientFighter.StopSliding:Fire();
    end));

    if not p11 then
        table.insert(u14.Threads, task.spawn(function() -- Line: 86
            -- upvalues: u8 (copy), DashParticles (ref), BetterDebris (ref), u10 (copy), RunService (ref)
            local RootPart = u8.ClientFighterCharacter.RootPart;

            if not RootPart then
                return;
            end;

            local v15 = DashParticles:Clone();
            v15.Parent = RootPart;
            BetterDebris:AddItem(v15, u10 + 5);
            local Position = RootPart.Position;
            local v16 = tick() + u10;

            for _, child in pairs(v15:GetChildren()) do
                if child:IsA("ParticleEmitter") then
                    child.Enabled = true;
                end;
            end;

            while not u8._destroyed and tick() < v16 do
                if (Position - RootPart.Position).Magnitude > 0.01 then
                    v15.CFrame = CFrame.new(RootPart.Position, Position) * CFrame.Angles(0, 3.141592653589793, 0);
                end;

                RunService.Heartbeat:Wait();
            end;

            for _, child in pairs(v15:GetChildren()) do
                if child:IsA("ParticleEmitter") then
                    child.Enabled = false;
                end;
            end;
        end));
    end;

    if u13 then
        u8._hard_dashes[u13] = u14;
    end;
end;

function u1.WarpTo(p17, p18) -- Line: 128
    -- upvalues: Utility (copy), CameraController (copy)
    if not (p17.ClientFighterCharacter.ClientFighter.IsLocalPlayer and p17.ClientFighterCharacter:IsAlive()) then
        return;
    end;

    p17.ClientFighterCharacter.RootPart.CFrame = p18;
    p17._fov_offset_spring.Value = 10;
    local v19 = Utility:AngleBetweenVectors(p18.LookVector, Vector3.new(0, 1, 0)) < 0.7853981633974483 and true or Utility:AngleBetweenVectors(p18.LookVector, Vector3.new(-0, -1, -0)) < 0.7853981633974483;

    if not v19 then
        CameraController:MimicRotation(p18);
    end;

    if p17.ClientFighterCharacter.ClientFighter:IsSliding() and not v19 then
        p17.RedirectSliding:Fire(p18.LookVector);

        return;
    end;

    local Velocity = p17.ClientFighterCharacter.RootPart.Velocity;
    local LookVector = p18.LookVector;
    local math_sqrt_ret = math.sqrt(Velocity.Magnitude);
    local v20 = LookVector * math.max(16, math_sqrt_ret);
    local v21;

    if v19 then
        v21 = Velocity.Unit * math.max((Velocity * (Vector3.new(1, 0, 1)).Unit).Magnitude, p17.ClientFighterCharacter.Humanoid.WalkSpeed);
    else
        v21 = nil;
    end;

    if not (v21 and (v21 == v21 and (v21.Magnitude > 0.001 and v21))) then
        v21 = nil;
    end;

    p17.ClientFighterCharacter:AirborneTrigger(v20, 12, nil, v21);
end;

function u1.Update(p22, p23, p24) -- Line: 154
end;

function u1.Destroy(p25) -- Line: 158
    p25._destroyed = true;
end;

function u1._Init(p26) -- Line: 166
end;

return u1;