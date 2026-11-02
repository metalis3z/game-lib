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

function u1._UpdateViewModelAnimations(p8) -- Line: 34
    local v9;

    if p8:Get("Ammo") <= 0 then
        v9 = p8.ViewModel.DontUseAmmoReserveToChangeCoreAnimations or p8:Get("AmmoReserve") <= 0;
    else
        v9 = false;
    end;

    p8.ViewModel:ChangeEquipAnimation(v9 and p8.ViewModel.Info.Animations.EmptyEquip and "EmptyEquip" or "Equip");
    p8.ViewModel:ChangeInspectAnimation(v9 and p8.ViewModel.Info.Animations.EmptyInspect and "EmptyInspect" or "Inspect");
    p8.ViewModel:ChangeIdleAnimation(v9 and p8.ViewModel.Info.Animations.EmptyIdle and "EmptyIdle" or "Idle");
    local v10;

    if v9 and p8.ViewModel.Info.Animations.EmptyIdle then
        v10 = CFrame.identity;
    else
        v10 = nil;
    end;

    p8.ViewModel:OverrideRootPartOffset(v10);
end;

function u1._Init(u11) -- Line: 43
    u11:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 44
        -- upvalues: u11 (copy)
        u11:_UpdateViewModelAnimations();
    end);
    u11:GetDataChangedSignal("AmmoReserve"):Connect(function() -- Line: 48
        -- upvalues: u11 (copy)
        u11:_UpdateViewModelAnimations();
    end);
    task.defer(u11._UpdateViewModelAnimations, u11);
end;

return u1;