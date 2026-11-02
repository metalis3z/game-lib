-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
local FlamethrowerAirblasts = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("FlamethrowerAirblasts");
local FlamethrowerFlames = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("FlamethrowerFlames");
local u1 = setmetatable({}, ClientViewModel);
u1.__index = u1;

function u1.new(...) -- Line: 14
    -- upvalues: ClientViewModel (copy), u1 (copy)
    local v2 = ClientViewModel.new(...);
    local v3 = setmetatable(v2, u1);
    v3._flame_particles = {};
    v3._flame_particles_hash = 0;
    v3._flame_sounds = nil;
    v3._flame_particles_enabled_count = 0;
    v3._flame_particles_enabled = false;
    v3:_Init();

    return v3;
end;

function u1.SetFlameParticlesEnabled(u4, p5) -- Line: 32
    -- upvalues: Utility (copy)
    u4._flame_particles_enabled_count = u4._flame_particles_enabled_count + (p5 and 1 or -1);
    local v6 = u4._flame_particles_enabled_count > 0;

    if v6 == u4._flame_particles_enabled then
        return;
    end;

    u4._flame_particles_enabled = v6;
    u4._flame_particles_hash = u4._flame_particles_hash + 1;
    local _flame_particles_hash = u4._flame_particles_hash;

    for _, v in pairs(u4._flame_particles) do
        if v:IsA("ParticleEmitter") then
            v.Enabled = u4._flame_particles_enabled;
        elseif v:IsA("Light") then
            if u4._flame_particles_enabled then
                v.Brightness = 10;
            else
                task.spawn(Utility.RenderstepForLoop, Utility, 0, 100, 10, function(p7) -- Line: 52
                    -- upvalues: _flame_particles_hash (copy), u4 (copy), v (copy)
                    if _flame_particles_hash ~= u4._flame_particles_hash then
                        return true;
                    end;

                    v.Brightness = 20 * (1 - p7 / 100);
                end);
            end;
        end;
    end;

    if u4._flame_particles_enabled then
        u4:PlayFlameSoundEffect();

        return;
    end;

    u4:StopFlameSoundEffect();
end;

function u1.PlayFlameSoundEffect(p8, p9) -- Line: 70
    p8:StopFlameSoundEffect(false);
    p8._flame_sounds = p8._flame_sounds or p8:_CreateFlameSoundEffects();

    for _, v in pairs(p8._flame_sounds) do
        v.Looped = true;
    end;
end;

function u1.StopFlameSoundEffect(p10, p11) -- Line: 80
    -- upvalues: Utility (copy)
    local u12 = p10._flame_sounds and Utility:CloneTable(p10._flame_sounds);
    p10._flame_sounds = nil;

    if not u12 or #u12 == 0 then
        return;
    end;

    local u13 = {};

    for _, v in pairs(u12) do
        u13[v] = v.Volume;
    end;

    task.spawn(Utility.RenderstepForLoop, Utility, 0, 100, 4, function(p14) -- Line: 95
        -- upvalues: u12 (copy), u13 (copy)
        for _, v in pairs(u12) do
            v.Volume = u13[v] * (1 - p14 / 100);
        end;
    end);
end;

function u1.PlayAirblastSoundEffect(p15) -- Line: 102
    p15:CreateSound("rbxassetid://17209245422", 1, 1, true, 5);
end;

function u1.AirblastEffect(p16) -- Line: 106
    -- upvalues: FlamethrowerAirblasts (copy), BetterDebris (copy), Utility (copy)
    local v17 = {};

    for _, child in pairs((FlamethrowerAirblasts:FindFirstChild(p16.Name) or FlamethrowerAirblasts.Default).Attachment:GetChildren()) do
        local v18 = child:Clone();
        v18.Parent = p16._muzzle_attachments[1];
        BetterDebris:AddItem(v18, 5);
        table.insert(v17, v18);
    end;

    Utility:PlayParticles(v17);
    p16:PlayAirblastSoundEffect();
end;

function u1._CreateFlameSoundEffects(p19) -- Line: 124
    return { p19:CreateSound("rbxassetid://17209245734", 1.5, 1, true) };
end;

function u1._Setup(p20) -- Line: 128
    -- upvalues: FlamethrowerFlames (copy)
    for _, child in pairs((FlamethrowerFlames:FindFirstChild(p20.Name) or FlamethrowerFlames.Default).Attachment:GetChildren()) do
        local v21 = child:Clone();
        v21.Parent = p20._muzzle_attachments[1];
        table.insert(p20._flame_particles, v21);
    end;
end;

function u1._Init(p22) -- Line: 136
    p22:_Setup();
end;

return u1;