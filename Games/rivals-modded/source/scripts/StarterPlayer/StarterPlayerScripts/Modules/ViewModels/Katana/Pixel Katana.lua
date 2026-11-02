-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Katana = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Katana);
local u1 = setmetatable({}, Katana);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: Katana (copy), u1 (copy)
    local v2 = Katana.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayDeflectHitSounds(p4) -- Line: 20
    p4:CreateSound("rbxassetid://103220108305486", 1.25, 1 + 0.25 * math.random(), true, 5);
    p4:CreateSound("rbxassetid://127511989334071", 1, 0.9 + 0.2 * math.random(), true, 5);
end;

function u1._Init(p5) -- Line: 29
end;

return u1;