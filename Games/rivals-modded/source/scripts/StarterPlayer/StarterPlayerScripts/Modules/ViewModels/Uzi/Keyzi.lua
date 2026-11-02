-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Uzi = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Uzi);
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(255, 218, 155));
local u1 = setmetatable({}, Uzi);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Uzi (copy), u1 (copy)
    local v2 = Uzi.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.GetFriendlyTracerColor(p4) -- Line: 22
    -- upvalues: ColorSequence_new_ret (copy)
    return ColorSequence_new_ret;
end;

function u1.PlayAimSound(p5, p6) -- Line: 26
    p5:CreateSound("rbxassetid://96253147006478", 0.375, 2 + (p6 and 0.1 or 0), true, 5);
end;

function u1._Init(p7) -- Line: 34
end;

return u1;