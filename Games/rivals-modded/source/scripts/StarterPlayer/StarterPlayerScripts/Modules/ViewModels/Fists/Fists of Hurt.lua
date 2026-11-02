-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Fists = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Fists);
local u1 = setmetatable({}, Fists);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: Fists (copy), u1 (copy)
    local v2 = Fists.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayHitmarkerSound(p4, p5, p6) -- Line: 20
    -- upvalues: Fists (copy)
    if p5 then
        Fists.PlayHitmarkerSound(p4, p5, p6);

        return;
    end;

    p4:_CreateHitmarkerSound("rbxassetid://88497957004619", 1.5 / p6, 0.75 + 0.25 * math.random(), script, true, 1);
end;

function u1._Init(p7) -- Line: 32
end;

return u1;