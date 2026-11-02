-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Exogun = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Exogun);
local RayGunExplosionParticles = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("RayGunExplosionParticles");
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(255, 204, 0));
local u1 = setmetatable({}, Exogun);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: Exogun (copy), u1 (copy)
    local v2 = Exogun.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.GetFriendlyTracerColor(p4) -- Line: 23
    -- upvalues: ColorSequence_new_ret (copy)
    return ColorSequence_new_ret;
end;

function u1.ExplosionEffect(p5, p6, p7) -- Line: 27
    -- upvalues: Exogun (copy), RayGunExplosionParticles (copy)
    Exogun.ExplosionEffect(p5, p6, p7, RayGunExplosionParticles);
end;

function u1._Init(p8) -- Line: 35
end;

return u1;