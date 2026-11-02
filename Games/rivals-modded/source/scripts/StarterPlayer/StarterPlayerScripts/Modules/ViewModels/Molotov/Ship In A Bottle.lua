-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Molotov = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Molotov);
local u1 = setmetatable({}, Molotov);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: Molotov (copy), u1 (copy)
    local v2 = Molotov.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1._Init(p4) -- Line: 26
end;

return u1;