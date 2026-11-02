-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Gun = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Gun);
local u1 = setmetatable({}, Gun);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: Gun (copy), u1 (copy)
    local v2 = Gun.new(...);
    local v3 = setmetatable(v2, u1);
    v3.ToggleAimEnabled = nil;
    v3:_Init();

    return v3;
end;

function u1.StartAiming(p4, p5) -- Line: 22
    return false;
end;

function u1.FinishAiming(p6, p7) -- Line: 26
    return false;
end;

function u1.StartSprinting(p8, p9) -- Line: 30
    return false;
end;

function u1._UpdateViewModelAnimations(p10) -- Line: 38
    local v11;

    if p10:Get("Ammo") <= 0 then
        v11 = p10:Get("AmmoReserve") <= 0;
    else
        v11 = false;
    end;

    p10.ViewModel:ChangeEquipAnimation(v11 and "EmptyEquip" or "Equip");
    p10.ViewModel:ChangeIdleAnimation(v11 and "EmptyIdle" or "Idle");
    p10.ViewModel:ChangeInspectAnimation(v11 and "EmptyInspect" or "Inspect");
    p10.ViewModel:ChangeSprintAnimation(v11 and "EmptySprint" or "Sprint");
end;

function u1._Init(u12) -- Line: 47
    u12:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 48
        -- upvalues: u12 (copy)
        u12:_UpdateViewModelAnimations();
    end);
    task.defer(u12._UpdateViewModelAnimations, u12);
end;

return u1;