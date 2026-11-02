-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local FestiveLightsCircuit = require(Players.LocalPlayer.PlayerScripts.Modules.FestiveLightsCircuit);
local Exogun = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Exogun);
local MidnightFestiveExogunExplosionParticles = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("MidnightFestiveExogunExplosionParticles");
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(22, 5, 255));
local u1 = setmetatable({}, Exogun);
u1.__index = u1;

function u1.new(...) -- Line: 12
    -- upvalues: Exogun (copy), u1 (copy), FestiveLightsCircuit (copy)
    local v2 = Exogun.new(...);
    local v3 = setmetatable(v2, u1);
    v3._festive_lights_circuit = FestiveLightsCircuit.new(0.5, v3.ItemModel:WaitForChild("Body"):WaitForChild("Light1"), v3.ItemModel:WaitForChild("Body"):WaitForChild("Light2"), v3.ItemModel:WaitForChild("Body"):WaitForChild("Light3"));
    v3:_Init();

    return v3;
end;

function u1.GetFriendlyTracerColor(p4) -- Line: 26
    -- upvalues: ColorSequence_new_ret (copy)
    return ColorSequence_new_ret;
end;

function u1.ExplosionEffect(p5, p6, p7) -- Line: 30
    -- upvalues: Exogun (copy), MidnightFestiveExogunExplosionParticles (copy)
    Exogun.ExplosionEffect(p5, p6, p7, MidnightFestiveExogunExplosionParticles);
end;

function u1.Update(p8, p9, p10, p11) -- Line: 34
    -- upvalues: Exogun (copy)
    Exogun.Update(p8, p9, p10, p11);

    if not p11.IsActive then
        return;
    end;

    p8._festive_lights_circuit:Update(p9);
end;

function u1.Destroy(p12) -- Line: 44
    -- upvalues: Exogun (copy)
    p12._festive_lights_circuit:Destroy();
    Exogun.Destroy(p12);
end;

function u1._Init(p13) -- Line: 53
end;

return u1;