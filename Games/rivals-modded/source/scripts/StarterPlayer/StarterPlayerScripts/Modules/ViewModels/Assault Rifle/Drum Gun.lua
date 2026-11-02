-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local u1 = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels["Assault Rifle"]);
local u2 = setmetatable({}, u1);
u2.__index = u2;

function u2.new(...) -- Line: 8
    -- upvalues: u1 (copy), u2 (copy)
    local v3 = u1.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2._UpdateDefaultAnimationsFromAmmo(p5) -- Line: 26
    local v6 = p5.ClientItem:Get("Ammo");
    p5.ClientItem:Get("AmmoReserve");
    local v7 = v6 <= 0;

    if v7 == p5._is_empty then
        return;
    end;

    p5._is_empty = v7;
    local v8 = p5._is_empty and "Empty" or "";
    p5:ChangeEquipAnimation("Equip" .. v8);
    p5:ChangeIdleAnimation("Idle" .. v8);
    p5:ChangeSprintAnimation("Sprint" .. v8);
    p5:ChangeInspectAnimation("Inspect" .. v8);
end;

function u2._Init(u9) -- Line: 44
    u9.ClientItem:GetDataChangedSignal("AmmoReserve"):Connect(function() -- Line: 45
        -- upvalues: u9 (copy)
        u9:_UpdateDefaultAnimationsFromAmmo();
    end);
    u9.ClientItem:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 49
        -- upvalues: u9 (copy)
        u9:_UpdateDefaultAnimationsFromAmmo();
    end);
    u9:_UpdateDefaultAnimationsFromAmmo();
end;

return u2;