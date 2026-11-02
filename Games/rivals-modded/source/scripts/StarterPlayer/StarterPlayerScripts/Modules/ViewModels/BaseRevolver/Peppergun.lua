-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local BaseRevolver = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.BaseRevolver);
local u1 = setmetatable({}, BaseRevolver);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: BaseRevolver (copy), u1 (copy)
    local v2 = BaseRevolver.new(...);
    local v3 = setmetatable(v2, u1);
    v3._is_empty = false;
    v3:_Init();

    return v3;
end;

function u1._UpdateDefaultAnimationsFromAmmo(p4) -- Line: 28
    local v5 = p4.ClientItem:Get("Ammo");
    p4.ClientItem:Get("AmmoReserve");
    local v6 = v5 <= 0;

    if v6 == p4._is_empty then
        return;
    end;

    p4._is_empty = v6;
    local v7 = p4._is_empty and "Empty" or "";
    p4:ChangeEquipAnimation("Equip" .. v7);
    p4:ChangeIdleAnimation("Idle" .. v7);
    p4:ChangeSprintAnimation("Sprint" .. v7);
    p4:ChangeInspectAnimation("Inspect" .. v7);
end;

function u1._Init(u8) -- Line: 46
    u8.ClientItem:GetDataChangedSignal("AmmoReserve"):Connect(function() -- Line: 47
        -- upvalues: u8 (copy)
        u8:_UpdateDefaultAnimationsFromAmmo();
    end);
    u8.ClientItem:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 51
        -- upvalues: u8 (copy)
        u8:_UpdateDefaultAnimationsFromAmmo();
    end);
    u8:_RegisterDefaultAmmoVisuals();
    u8:_UpdateDefaultAnimationsFromAmmo();
end;

return u1;