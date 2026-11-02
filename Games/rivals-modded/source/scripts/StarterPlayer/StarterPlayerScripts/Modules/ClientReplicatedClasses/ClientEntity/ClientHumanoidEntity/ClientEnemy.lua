-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
require(ReplicatedStorage.Modules.SoundLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientHumanoidEntity = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity);
local Particles = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("ZombieSpawnEffect"):WaitForChild("Particles");
local u1 = setmetatable({}, ClientHumanoidEntity);
u1.__index = u1;

function u1.new(...) -- Line: 16
    -- upvalues: ClientHumanoidEntity (copy), u1 (copy)
    local v2 = ClientHumanoidEntity.new(...);
    local v3 = setmetatable(v2, u1);
    v3._run_track = nil;
    v3._idle_track = nil;
    v3._death_animation_override = false;
    v3._death_sound_override = false;
    v3:_Init();

    return v3;
end;

function u1.ReplicateFromServer(p4, p5, ...) -- Line: 33
    -- upvalues: Particles (copy), BetterDebris (copy), Utility (copy), ClientHumanoidEntity (copy)
    if p5 ~= "ZombieSpawn" then
        ClientHumanoidEntity.ReplicateFromServer(p4, p5, ...);

        return;
    end;

    p4:_PlayAnimation("ZombieSpawn");
    p4:_CreateSound("rbxassetid://109012456164853", 0.5 + 1 * math.random(), 0.875 + 0.25 * math.random());
    local v6 = Particles:Clone();
    v6.Parent = p4.Model:FindFirstChild("Head") or (p4.Model:FindFirstChild("UpperTorso") or p4.RootPart);
    BetterDebris:AddItem(v6, 10);
    Utility:PlayParticles(v6);
    wait(0.5);
    v6.LockedToPart = false;
end;

function u1._DelayedVisibility(p7) -- Line: 55
    local v8 = {};

    for _, descendant in pairs(p7.Model:GetDescendants()) do
        if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
            table.insert(v8, descendant);
        end;
    end;

    for _, v in pairs(v8) do
        v.LocalTransparencyModifier = 1;
    end;

    wait(0.2);

    for _, v in pairs(v8) do
        v.LocalTransparencyModifier = 0;
    end;
end;

function u1._LoadAnimation(p9, p10) -- Line: 75
    if p10 then
        return p9.Humanoid:LoadAnimation(p9:_CreateAnimation(p10));
    end;

    return nil;
end;

function u1._SetupTracks(u11) -- Line: 79
    u11._run_track = u11:_LoadAnimation(u11:Get("RunAnimation"));
    u11._idle_track = u11:_LoadAnimation(u11:Get("IdleAnimation"));

    if u11._idle_track then
        u11._idle_track:Play();
    end;

    if u11._run_track then
        u11._run_track:AdjustWeight(0, 0);
        u11.Humanoid.Running:Connect(function(p12) -- Line: 90
            -- upvalues: u11 (copy)
            if not u11:IsAlive() then
                return;
            end;

            if not u11._run_track.IsPlaying then
                u11._run_track:Play();
            end;

            u11._run_track:AdjustWeight(p12 >= 0.5 and 1 or 0);
            u11._run_track:AdjustSpeed(p12 * 1.25 / 16 / (u11.RootPart.Size.Y / 2));
        end);
    end;
end;

function u1._Init(u13) -- Line: 105
    u13.Died:Connect(function() -- Line: 106
        -- upvalues: u13 (copy)
        if u13._idle_track then
            u13._idle_track:Stop(0);
            u13._idle_track:Play();
            u13._idle_track = nil;
        end;

        if u13._run_track then
            u13._run_track:Stop(0);
            u13._run_track:Destroy();
            u13._run_track = nil;
        end;

        local _ = u13._death_sound_override;
        local _ = u13._death_animation_override;
    end);
    pcall(u13._SetupTracks, u13);
    task.defer(u13._DelayedVisibility, u13);
end;

return u1;