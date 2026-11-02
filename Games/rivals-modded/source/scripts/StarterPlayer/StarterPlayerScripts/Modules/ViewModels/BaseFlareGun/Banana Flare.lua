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
    v3:_Init();

    return v3;
end;

function u1._UpdateViewModelAnimations(p4) -- Line: 26
    p4.Animator:ChangeRareInspectAnimation(p4.ClientItem:Get("Ammo") > 0 and "RareInspect" or "nil");
end;

function u1._Init(u5) -- Line: 30
    local _connections = u5._connections;
    local DataChangedSignal = u5.ClientItem:GetDataChangedSignal("Ammo");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 31
        -- upvalues: u5 (copy)
        u5:_UpdateViewModelAnimations();
    end));
    u5:_RegisterDefaultAmmoVisuals();
    task.defer(u5._UpdateViewModelAnimations, u5);
end;

return u1;