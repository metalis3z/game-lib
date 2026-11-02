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

function u1._Init(p4) -- Line: 26
    p4:_RegisterAmmoVisual(p4.ItemModel:WaitForChild("Ball"):WaitForChild("MeshPart1"));
    p4:_RegisterAmmoVisual(p4.ItemModel:WaitForChild("Ball"):WaitForChild("MeshPart2"));
end;

return u1;