-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local BaseFlareGun = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.BaseFlareGun);
local u1 = setmetatable({}, BaseFlareGun);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: BaseFlareGun (copy), u1 (copy)
    local v2 = BaseFlareGun.new(...);
    local v3 = setmetatable(v2, u1);
    v3._is_empty = nil;
    v3:_Init();

    return v3;
end;

function u1._UpdateAmmoContext(p4) -- Line: 28
    local v5 = p4.ClientItem:Get("Ammo") <= 0;

    if v5 == p4._is_empty then
        return;
    end;

    p4._is_empty = v5;
    local v6 = p4._is_empty and "Empty" or "";
    p4:ChangeEquipAnimation("Equip" .. v6);
    p4:ChangeIdleAnimation("Idle" .. v6);
    p4:ChangeSprintAnimation("Sprint" .. v6);
    p4:ChangeInspectAnimation("Inspect" .. v6);
end;

function u1._Init(u7) -- Line: 44
    u7.ClientItem:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 45
        -- upvalues: u7 (copy)
        u7:_UpdateAmmoContext();
    end);
    u7:_UpdateAmmoContext();
    u7:_RegisterDefaultAmmoVisuals();
end;

return u1;