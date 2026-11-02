-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local BaseRevolver = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.BaseRevolver);
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(53, 194, 255));
local u1 = setmetatable({}, BaseRevolver);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: BaseRevolver (copy), u1 (copy)
    local v2 = BaseRevolver.new(...);
    local v3 = setmetatable(v2, u1);
    v3._is_empty = false;
    v3:_Init();

    return v3;
end;

function u1.GetFriendlyTracerColor(p4) -- Line: 24
    -- upvalues: ColorSequence_new_ret (copy)
    return ColorSequence_new_ret;
end;

function u1._UpdateDefaultAnimationsFromAmmo(p5) -- Line: 32
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

function u1._Init(u9) -- Line: 50
    u9.ClientItem:GetDataChangedSignal("AmmoReserve"):Connect(function() -- Line: 51
        -- upvalues: u9 (copy)
        u9:_UpdateDefaultAnimationsFromAmmo();
    end);
    u9.ClientItem:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 55
        -- upvalues: u9 (copy)
        u9:_UpdateDefaultAnimationsFromAmmo();
    end);
    u9:_UpdateDefaultAnimationsFromAmmo();
end;

return u1;