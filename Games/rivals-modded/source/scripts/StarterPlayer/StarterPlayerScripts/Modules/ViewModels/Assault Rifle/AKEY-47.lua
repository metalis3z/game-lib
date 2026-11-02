-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local u1 = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels["Assault Rifle"]);
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(255, 218, 155));
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

function u2.PlayAimSound(p6, p7) -- Line: 26
    p6:CreateSound("rbxassetid://96253147006478", 0.375, 2 + (p7 and 0.1 or 0), true, 5);
end;

function u2._Init(p8) -- Line: 34
end;

return u2;