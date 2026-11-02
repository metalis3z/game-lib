-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Gun = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Gun);
local u1 = setmetatable({}, Gun);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Gun (copy), u1 (copy)
    local v2 = Gun.new(...);
    local v3 = setmetatable(v2, u1);
    v3.ToggleAimEnabled = nil;
    v3:_Init();

    return v3;
end;

function u1.StartAiming(p4, p5) -- Line: 24
    if p5 or tick() >= p4._shoot_cooldown and (tick() >= p4._reload_cooldown and (p4:Get("Ammo") > 0 and not p4:IsEquipping())) then
        p4._reload_cooldown = tick() + 1.5;
        task.delay(1.5, p4._CheckReload, p4);
        p4.ViewModel:StopAnimation("Inspect");
        p4.ViewModel:PlayAnimation("Throw", 1);

        return true, "StartAiming", p4.ClientFighter:GetCameraData();
    end;
end;

function u1.FinishAiming(p6, p7) -- Line: 39
    return false;
end;

function u1.StartSprinting(p8, p9) -- Line: 43
    return false;
end;

function u1._Init(p10) -- Line: 51
end;

return u1;