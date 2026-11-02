-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Wildcat = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Wildcat);
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(149, 43, 255));
local u1 = setmetatable({}, Wildcat);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Wildcat (copy), u1 (copy)
    local v2 = Wildcat.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.GetFriendlyTracerColor(p4) -- Line: 22
    -- upvalues: ColorSequence_new_ret (copy)
    return ColorSequence_new_ret;
end;

function u1._Init(p5) -- Line: 30
end;

return u1;