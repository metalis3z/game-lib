-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local BaseBow = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.BaseBow);
local u1 = setmetatable({}, BaseBow);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: BaseBow (copy), u1 (copy)
    local v2 = BaseBow.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayChargeSound(p4, p5) -- Line: 20
    -- upvalues: BaseBow (copy)
    BaseBow.PlayChargeSound(p4, p5);
    p4:CreateSound("rbxassetid://113094896439924", 1, 1 + 0.1 * p5, true, 10);
end;

function u1._Init(p6) -- Line: 29
    p6:_RegisterAmmoVisual(p6.ItemModel:WaitForChild("Arrow"):WaitForChild("Feather"));
    p6:_RegisterAmmoVisual(p6.ItemModel:WaitForChild("Arrow"):WaitForChild("Stick"));
    p6:_RegisterAmmoVisual(p6.ItemModel:WaitForChild("Arrow"):WaitForChild("Tip"));
end;

return u1;