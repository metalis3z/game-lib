-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local BaseDaggers = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.BaseDaggers);
local u1 = setmetatable({}, BaseDaggers);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: BaseDaggers (copy), u1 (copy)
    local v2 = BaseDaggers.new(...);
    local v3 = setmetatable(v2, u1);
    v3.DontUseAmmoReserveToChangeCoreAnimations = true;
    v3:_Init();

    return v3;
end;

function u1._Init(p4) -- Line: 28
    p4:_RegisterAmmoVisual(p4.ItemModel:WaitForChild("Toast 1"):WaitForChild("MeshPart1"), 1);
    p4:_RegisterAmmoVisual(p4.ItemModel:WaitForChild("Toast 1"):WaitForChild("MeshPart2"), 1);
    p4:_RegisterAmmoVisual(p4.ItemModel:WaitForChild("Toast 2"):WaitForChild("MeshPart1"), 2);
    p4:_RegisterAmmoVisual(p4.ItemModel:WaitForChild("Toast 2"):WaitForChild("MeshPart2"), 2);
end;

return u1;