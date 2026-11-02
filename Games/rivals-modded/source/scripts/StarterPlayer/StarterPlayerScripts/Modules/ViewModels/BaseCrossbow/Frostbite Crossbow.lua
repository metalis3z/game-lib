-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local BaseCrossbow = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.BaseCrossbow);
local u1 = setmetatable({}, BaseCrossbow);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: BaseCrossbow (copy), u1 (copy)
    local v2 = BaseCrossbow.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1._Init(p4) -- Line: 26
    p4:_RegisterAmmoVisual(p4.ItemModel:WaitForChild("Arrow"):WaitForChild("Stick"));
    p4:_RegisterAmmoVisual(p4.ItemModel:WaitForChild("Arrow"):WaitForChild("Tip"));
end;

return u1;