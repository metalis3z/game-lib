-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 8
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.FighterInterface = p2;
    v3.RefillAmmoVignette = v3.FighterInterface.Frame:WaitForChild("RefillAmmoVignette");
    v3.RefillAmmoVignetteTexture = v3.RefillAmmoVignette:WaitForChild("Texture");
    v3._refill_ammo_effect_hash = 0;
    v3:_Init();

    return v3;
end;

function u1.RefillAmmoEffect(u4) -- Line: 26
    -- upvalues: Utility (copy)
    if not u4.FighterInterface:IsActive() then
        return;
    end;

    u4._refill_ammo_effect_hash = u4._refill_ammo_effect_hash + 1;
    local _refill_ammo_effect_hash = u4._refill_ammo_effect_hash;
    u4.FighterInterface:CreateSound("rbxassetid://93185674378015", 1, 1, script, true, 10);
    u4.FighterInterface:CreateSound("rbxassetid://96308464356768", 1.5, 1, script, true, 10);
    task.spawn(Utility.RenderstepForLoop, Utility, 0, 100, 4, function(p5) -- Line: 40
        -- upvalues: _refill_ammo_effect_hash (copy), u4 (copy)
        if _refill_ammo_effect_hash ~= u4._refill_ammo_effect_hash then
            return true;
        end;

        local v6 = 0 + 1 * (p5 / 100);
        u4.RefillAmmoVignette.ImageTransparency = v6;
        u4.RefillAmmoVignetteTexture.ImageTransparency = v6;
    end);
end;

function u1.Destroy(p7) -- Line: 53
    p7._refill_ammo_effect_hash = p7._refill_ammo_effect_hash + 1;
end;

function u1._Init(p8) -- Line: 61
end;

return u1;