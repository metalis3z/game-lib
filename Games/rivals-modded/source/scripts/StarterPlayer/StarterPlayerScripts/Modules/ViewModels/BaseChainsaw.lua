-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
local ChainsawParticles = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("ChainsawParticles");
local u1 = setmetatable({}, ClientViewModel);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: ClientViewModel (copy), u1 (copy)
    local v2 = ClientViewModel.new(...);
    local v3 = setmetatable(v2, u1);
    v3._spike_toggle = false;
    v3._spike_parts = {};
    v3._next_toggle = 0;
    v3._hold_particles = {};
    v3._idle_sound_hash = 0;
    v3:_Init();

    return v3;
end;

function u1.CreateHoldSounds(p4) -- Line: 29
    return { p4:CreateSound("rbxassetid://16359327230", 0.5, 1, true) };
end;

function u1.PlayStartingHoldSounds(p5) -- Line: 33
end;

function u1.EnableParticles(p6, p7) -- Line: 37
    for _, v in pairs(p6._hold_particles) do
        v.Enabled = p7;
    end;
end;

function u1.Update(p8, p9, p10, p11) -- Line: 43
    -- upvalues: ClientViewModel (copy)
    ClientViewModel.Update(p8, p9, p10, p11);

    if not p11.IsActive then
        return;
    end;

    if tick() < p8._next_toggle then
        return;
    end;

    p8._next_toggle = tick() + 0.03;
    p8._spike_toggle = not p8._spike_toggle;

    for i, v in pairs(p8._spike_parts) do
        p8:_LocalTransparencyModifier(i, "Update", v == p8._spike_toggle and 0 or 1);
    end;
end;

function u1._PlayIdleSound(p12, p13, p14) -- Line: 66
    local v15 = p14 or 0.2;

    if v15 > 0 then
        wait(v15);

        if p13 ~= p12._idle_sound_hash then
            return;
        end;
    end;

    local v16 = p12:CreateSound("rbxassetid://13645858587", 0.375, 1, true);

    if v16 then
        v16.Looped = true;
    end;

    local v17 = p12:CreateSound("rbxassetid://13646484249", 0.375, 1, true);

    if v17 then
        v17.Looped = true;
    end;

    local v18 = p12:CreateSound("rbxassetid://13646484113", 0.25, 1, true);

    if v18 then
        v18.Looped = true;
    end;
end;

function u1._RegisterSpikesPart(p19, p20, p21) -- Line: 96
    p19._spike_parts[p20] = p21;
end;

function u1._RegisterBlade(p22, p23) -- Line: 100
    -- upvalues: ChainsawParticles (copy)
    for _, child in pairs((ChainsawParticles:FindFirstChild(p22.Name) or ChainsawParticles.Default):GetChildren()) do
        local v24 = child:Clone();
        v24.Parent = p23;
        table.insert(p22._hold_particles, v24);
    end;
end;

function u1._Init(u25) -- Line: 108
    u25.Equipped:Connect(function() -- Line: 109
        -- upvalues: u25 (copy)
        local v26 = u25;
        v26._idle_sound_hash = v26._idle_sound_hash + 1;
        u25:_PlayIdleSound(u25._idle_sound_hash);
    end);
    u25.Unequipped:Connect(function() -- Line: 114
        -- upvalues: u25 (copy)
        local v27 = u25;
        v27._idle_sound_hash = v27._idle_sound_hash + 1;
    end);
end;

return u1;