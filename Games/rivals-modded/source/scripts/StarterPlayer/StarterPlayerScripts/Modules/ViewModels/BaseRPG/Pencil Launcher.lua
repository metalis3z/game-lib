-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local BaseRPG = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.BaseRPG);
local u1 = setmetatable({}, BaseRPG);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: BaseRPG (copy), u1 (copy)
    local v2 = BaseRPG.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1._Init(p4) -- Line: 26
    p4:_RegisterAmmoVisual(p4.ItemModel:WaitForChild("Rocket"):WaitForChild("Lead"));
    p4:_RegisterAmmoVisual(p4.ItemModel:WaitForChild("Rocket"):WaitForChild("Wood"));
    p4:_RegisterAmmoVisual(p4.ItemModel:WaitForChild("Rocket"):WaitForChild("Yellow"));
    p4:_RegisterAmmoVisual(p4.ItemModel:WaitForChild("Rocket"):WaitForChild("Neck"));
end;

return u1;