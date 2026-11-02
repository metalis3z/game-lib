-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Distortion = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Distortion);
local MagmaDistortionExplosionParticles = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("MagmaDistortionExplosionParticles");
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(255, 109, 24));
local u1 = setmetatable({}, Distortion);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: Distortion (copy), u1 (copy)
    local v2 = Distortion.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.GetFriendlyTracerColor(p4) -- Line: 23
    -- upvalues: ColorSequence_new_ret (copy)
    return ColorSequence_new_ret;
end;

function u1.ExplosionEffect(p5, p6, p7) -- Line: 27
    -- upvalues: Distortion (copy), MagmaDistortionExplosionParticles (copy)
    Distortion.ExplosionEffect(p5, p6, p7, MagmaDistortionExplosionParticles);
end;

function u1._Init(p8) -- Line: 35
end;

return u1;