-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Flamethrower = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Flamethrower);
local u1 = setmetatable({}, Flamethrower);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: Flamethrower (copy), u1 (copy)
    local v2 = Flamethrower.new(...);
    local v3 = setmetatable(v2, u1);
    v3._inspect_fire_effect_hash = 0;
    v3:_Init();

    return v3;
end;

function u1.Destroy(p4) -- Line: 22
    -- upvalues: Flamethrower (copy)
    p4._inspect_fire_effect_hash = p4._inspect_fire_effect_hash + 1;
    Flamethrower.Destroy(p4);
end;

function u1._CreateFlameSoundEffects(p5) -- Line: 31
    return { p5:CreateSound("rbxassetid://17209245734", 0.5, 1.5, true), p5:CreateSound("rbxassetid://85294603652818", 1.5, 1, true) };
end;

function u1._InspectFireEffect(p6) -- Line: 35
    p6._inspect_fire_effect_hash = p6._inspect_fire_effect_hash + 1;
    local _inspect_fire_effect_hash = p6._inspect_fire_effect_hash;
    wait(1.7);

    if p6._inspect_fire_effect_hash ~= _inspect_fire_effect_hash then
        return;
    end;

    p6:SetFlameParticlesEnabled(true);
    local _flame_particles_hash = p6._flame_particles_hash;
    wait(0.1);

    if p6._flame_particles_hash == _flame_particles_hash then
        p6:SetFlameParticlesEnabled(false);
    end;

    wait(0.2);

    if p6._inspect_fire_effect_hash ~= _inspect_fire_effect_hash then
        return;
    end;

    p6:SetFlameParticlesEnabled(true);
    local _flame_particles_hash2 = p6._flame_particles_hash;
    wait(0.1);

    if p6._flame_particles_hash == _flame_particles_hash2 then
        p6:SetFlameParticlesEnabled(false);
    end;
end;

function u1._Init(u7) -- Line: 72
    u7.AnimationPlayed:Connect(function(p8) -- Line: 73
        -- upvalues: u7 (copy)
        if p8 == "Inspect" then
            u7:_InspectFireEffect();
        end;
    end);
    u7.Unequipped:Connect(function() -- Line: 79
        -- upvalues: u7 (copy)
        local v9 = u7;
        v9._inspect_fire_effect_hash = v9._inspect_fire_effect_hash + 1;
    end);
    task.defer(function() -- Line: 83
        -- upvalues: u7 (copy)
        u7.ClientItem.Airblasted:Connect(function() -- Line: 84
            -- upvalues: u7 (ref)
            local v10 = u7;
            v10._inspect_fire_effect_hash = v10._inspect_fire_effect_hash + 1;
        end);
    end);
end;

return u1;