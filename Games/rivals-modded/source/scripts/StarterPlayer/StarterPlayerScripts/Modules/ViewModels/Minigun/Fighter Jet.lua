-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Minigun = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Minigun);
local u1 = setmetatable({}, Minigun);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: Minigun (copy), u1 (copy)
    local v2 = Minigun.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1._CreateMinigunShootingSounds(p4) -- Line: 26
    local v5 = p4:CreateSound("rbxassetid://17246880027", 8.75, 0.75, true);
    v5.TimePosition = 0.25 + 0.25 * math.random();
    v5.Looped = true;

    return { v5 };
end;

function u1._CreateMinigunWindingSounds(p6) -- Line: 34
    local v7 = p6:CreateSound("rbxassetid://17251084003", 0.5, 0.75, true);
    v7.TimePosition = 2;
    v7.Looped = true;

    return { v7 };
end;

function u1._Init(p8) -- Line: 42
end;

return u1;