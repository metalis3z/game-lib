-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local AnimationLibrary = require(ReplicatedStorage.Modules.AnimationLibrary);
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
local WarHornEffects = Players.LocalPlayer.PlayerScripts.Assets.Misc.WarHornEffects;
local u1 = setmetatable({}, ClientViewModel);
u1.__index = u1;

function u1.new(...) -- Line: 12
    -- upvalues: ClientViewModel (copy), u1 (copy)
    local v2 = ClientViewModel.new(...);
    local v3 = setmetatable(v2, u1);
    v3._horn_particles = {};
    v3._horn_particles_active = 0;
    v3._use_effect_attachment = v3.Model:FindFirstChild("_warhorn_use", true);
    v3:_Init();

    return v3;
end;

function u1.PlayHornEffect(p4) -- Line: 28
    -- upvalues: AnimationLibrary (copy)
    p4:_IncrementParticlesActive(1);
    task.delay(AnimationLibrary.Info[p4.Info.Animations.Use].ActionTimestamp, p4._IncrementParticlesActive, p4, -1);
end;

function u1._IncrementParticlesActive(p5, p6) -- Line: 37
    p5._horn_particles_active = p5._horn_particles_active + p6;

    for _, v in pairs(p5._horn_particles) do
        v.Enabled = p5._horn_particles_active > 0;
    end;
end;

function u1._Setup(p7) -- Line: 45
    -- upvalues: WarHornEffects (copy)
    for _, child in pairs((WarHornEffects:FindFirstChild(p7.Name) or WarHornEffects.Default).Attachment:GetChildren()) do
        local v8 = child:Clone();
        v8.Parent = p7._use_effect_attachment;
        table.insert(p7._horn_particles, v8);
    end;
end;

function u1._Init(p9) -- Line: 53
    p9:_Setup();
end;

return u1;