-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local u1 = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels["Burst Rifle"]);
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(75, 192, 255));
local u2 = setmetatable({}, u1);
u2.__index = u2;

function u2.new(...) -- Line: 10
    -- upvalues: u1 (copy), u2 (copy)
    local v3 = u1.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2.GetFriendlyTracerColor(p5) -- Line: 22
    -- upvalues: ColorSequence_new_ret (copy)
    return ColorSequence_new_ret;
end;

function u2._Init(p6) -- Line: 30
end;

return u2;