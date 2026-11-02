-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local u1 = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels["Paintball Gun"]);
local Color3_fromRGB_ret = Color3.fromRGB(255, 116, 165);
local u2 = setmetatable({}, u1);
u2.__index = u2;

function u2.new(...) -- Line: 10
    -- upvalues: u1 (copy), u2 (copy)
    local v3 = u1.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2.GetPaintballColor(p5) -- Line: 22
    -- upvalues: Color3_fromRGB_ret (copy)
    return Color3_fromRGB_ret;
end;

function u2._Init(p6) -- Line: 30
end;

return u2;