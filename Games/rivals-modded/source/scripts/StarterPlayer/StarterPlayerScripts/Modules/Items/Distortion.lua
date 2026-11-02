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
    v3._vortex_cooldown = 0;
    v3:_Init();

    return v3;
end;

function u1.StartAiming(p4, p5) -- Line: 24
    if p5 or tick() >= p4._vortex_cooldown and not p4:IsEquipping() then
        p4._vortex_cooldown = tick() + p4.Info.VortexCooldown;
        local CameraData = p4.ClientFighter:GetCameraData();
        p4:_Recoil(1);
        p4:CooldownEffect("rbxassetid://76793585944473", p4.Info.VortexCooldown, "Vortex");
        p4.ViewModel:MuzzleFlash();
        p4.ViewModel:StopAnimation("Inspect");
        p4.ViewModel:StopAnimation("Equip", 0);
        p4.ViewModel:PlayAnimation("Shoot1");

        return true, "StartAiming", CameraData;
    end;
end;

function u1.FinishAiming(p6, p7) -- Line: 43
    return false;
end;

function u1.StartSprinting(p8, p9) -- Line: 47
    return false;
end;

function u1._Init(p10) -- Line: 55
end;

return u1;