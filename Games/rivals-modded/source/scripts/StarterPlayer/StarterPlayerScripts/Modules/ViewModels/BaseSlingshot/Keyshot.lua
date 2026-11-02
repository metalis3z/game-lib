-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local BaseSlingshot = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.BaseSlingshot);
local u1 = setmetatable({}, BaseSlingshot);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: BaseSlingshot (copy), u1 (copy)
    local v2 = BaseSlingshot.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayAimSound(p4, p5) -- Line: 20
    p4:CreateSound("rbxassetid://96253147006478", 0.375, 2 + (p5 and 0.1 or 0), true, 5);
end;

function u1._Init(p6) -- Line: 28
    p6:_RegisterDefaultAmmoVisuals();
end;

return u1;