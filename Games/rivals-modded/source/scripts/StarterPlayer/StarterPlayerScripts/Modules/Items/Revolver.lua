-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Gun = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Gun);
local u1 = setmetatable({}, Gun);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: Gun (copy), u1 (copy)
    local v2 = Gun.new(...);
    local v3 = setmetatable(v2, u1);
    v3.ToggleAimEnabled = nil;
    v3:_Init();

    return v3;
end;

function u1.StartAiming(p4, p5) -- Line: 22
    return p4:StartShooting(p5, true);
end;

function u1.FinishAiming(p6, p7) -- Line: 26
    return false;
end;

function u1.StartSprinting(p8, p9) -- Line: 30
    return false;
end;

function u1._Init(p10) -- Line: 38
end;

return u1;