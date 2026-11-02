-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Exogun = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Exogun);
local PearlExogunExplosionParticles = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("PearlExogunExplosionParticles");
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(255, 215, 246));
local u1 = setmetatable({}, Exogun);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: Exogun (copy), u1 (copy)
    local v2 = Exogun.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.GetFriendlyTracerColor(p4) -- Line: 25
    -- upvalues: ColorSequence_new_ret (copy)
    return ColorSequence_new_ret;
end;

function u1.ExplosionEffect(p5, p6, p7) -- Line: 29
    -- upvalues: Exogun (copy), PearlExogunExplosionParticles (copy), Utility (copy)
    Exogun.ExplosionEffect(p5, p6, p7, PearlExogunExplosionParticles);
    Utility:CreateSound("rbxassetid://121938614359106", 1, 1 + 0.25 * math.random(), p6, true, 10);
end;

function u1._Init(p8) -- Line: 38
end;

return u1;