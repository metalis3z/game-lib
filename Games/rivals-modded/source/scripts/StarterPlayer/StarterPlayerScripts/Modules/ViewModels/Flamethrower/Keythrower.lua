-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local WrapController = require(Players.LocalPlayer.PlayerScripts.Controllers.WrapController);
local Flamethrower = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Flamethrower);
local u1 = setmetatable({}, Flamethrower);
u1.__index = u1;

function u1.new(...) -- Line: 9
    -- upvalues: Flamethrower (copy), u1 (copy)
    local v2 = Flamethrower.new(...);
    local v3 = setmetatable(v2, u1);
    v3._inspect_fire_effect_hash = 0;
    v3:_Init();

    return v3;
end;

function u1.Destroy(p4) -- Line: 23
    -- upvalues: Flamethrower (copy)
    p4._inspect_fire_effect_hash = p4._inspect_fire_effect_hash + 1;
    Flamethrower.Destroy(p4);
end;

function u1._CreateFlameSoundEffects(p5) -- Line: 32
    return { p5:CreateSound("rbxassetid://17209245734", 1, 1, true), p5:CreateSound("rbxassetid://129124742663895", 2.25, 2, true) };
end;

function u1._InspectFireEffect(p6) -- Line: 36
    p6._inspect_fire_effect_hash = p6._inspect_fire_effect_hash + 1;
    local _inspect_fire_effect_hash = p6._inspect_fire_effect_hash;
    wait(2.9);

    if p6._inspect_fire_effect_hash ~= _inspect_fire_effect_hash then
        return;
    end;

    p6:SetFlameParticlesEnabled(true);
    local _flame_particles_hash = p6._flame_particles_hash;
    wait(0.2);

    if p6._flame_particles_hash ~= _flame_particles_hash then
        return;
    end;

    p6:SetFlameParticlesEnabled(false);
end;

function u1._Setup(p7) -- Line: 59
    -- upvalues: WrapController (copy)
    WrapController:ApplyWrap(WrapController:RecordOriginalWrapProperties(p7._flame_particles), p7.ClientItem:GetWrap(), true);
end;

function u1._Init(u8) -- Line: 63
    u8.AnimationPlayed:Connect(function(p9) -- Line: 64
        -- upvalues: u8 (copy)
        if p9 == "Inspect" then
            u8:_InspectFireEffect();
        end;
    end);
    u8.Unequipped:Connect(function() -- Line: 70
        -- upvalues: u8 (copy)
        local v10 = u8;
        v10._inspect_fire_effect_hash = v10._inspect_fire_effect_hash + 1;
    end);
    task.defer(function() -- Line: 74
        -- upvalues: u8 (copy)
        u8.ClientItem.Airblasted:Connect(function() -- Line: 75
            -- upvalues: u8 (ref)
            local v11 = u8;
            v11._inspect_fire_effect_hash = v11._inspect_fire_effect_hash + 1;
        end);
    end);
    u8:_Setup();
end;

return u1;