-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Custom = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Custom);
local u1 = setmetatable({}, Custom);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: Custom (copy), u1 (copy)
    local v2 = Custom.new(...);
    local v3 = setmetatable(v2, u1);
    v3._portal_cooldown = 0;
    v3:_Init();

    return v3;
end;

function u1.GetAutoShootReactionTime(p4) -- Line: 22
    return nil;
end;

function u1.StartShooting(p5, ...) -- Line: 26
    return p5:_OpenPortal("StartShooting", ...);
end;

function u1.StartAiming(p6, ...) -- Line: 30
    return p6:_OpenPortal("StartAiming", ...);
end;

function u1._OpenPortal(p7, p8, p9) -- Line: 38
    if p9 or tick() >= p7._portal_cooldown and not p7:IsEquipping() then
        p7._portal_cooldown = tick() + p7.Info.ShootCooldown;
        local CameraData = p7.ClientFighter:GetCameraData();
        p7:_Recoil(1);
        p7.ViewModel:MuzzleFlash();
        p7.ViewModel:StopAnimation("Equip", 0);
        p7.ViewModel:PlayAnimation("Shoot1", p7.Info.ShootCooldown, 0);

        return true, p8, CameraData;
    end;
end;

function u1._Init(p10) -- Line: 55
end;

return u1;