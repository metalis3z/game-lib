-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.GameplayUtility);
local Custom = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Custom);
local u1 = setmetatable({}, Custom);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: Custom (copy), u1 (copy)
    local v2 = Custom.new(...);
    local v3 = setmetatable(v2, u1);
    v3._use_cooldown = 0;
    v3._preview_connection = nil;
    v3._preview_model = nil;
    v3:_Init();

    return v3;
end;

function u1.GetAutoShootReactionTime(p4) -- Line: 27
    return nil;
end;

function u1.CanQuickAttack(p5) -- Line: 31
    local v6;

    if tick() > p5._use_cooldown and (p5:Get("Ammo") or (1 / 0)) > 0 then
        v6 = not p5:IsEquipping();
    else
        v6 = false;
    end;

    return v6;
end;

function u1.StartShooting(p7, p8) -- Line: 35
    if not (p8 or tick() >= p7._use_cooldown and ((p7:Get("Ammo") or (1 / 0)) > 0 and not p7:IsEquipping())) then
        return false;
    end;

    p7._use_cooldown = tick() + p7.Info.Cooldown;
    p7:CooldownEffect("rbxassetid://17156089790", p7.Info.Cooldown, "Use");
    p7.ViewModel:StopAnimation("Inspect");
    p7.ViewModel:PlayAnimation("Use", 0.5);

    return true, "StartShooting", p7:_GetPlacementPosition();
end;

function u1.Equip(p9, ...) -- Line: 48
    -- upvalues: Custom (copy)
    Custom.Equip(p9, ...);
    p9:_StartPlacementPreview();
end;

function u1.Unequip(p10, ...) -- Line: 53
    -- upvalues: Custom (copy)
    p10:_StopPlacementPreview();
    Custom.Unequip(p10, ...);
end;

function u1.ReplicateFromServer(p11, p12, ...) -- Line: 58
    -- upvalues: Custom (copy)
    if p12 ~= "MineExplosion" then
        Custom.ReplicateFromServer(p11, p12, ...);

        return;
    end;

    if not p11:IsRendered() then
        return;
    end;

    p11.ViewModel:ExplosionEffect(...);
end;

function u1.Destroy(p13) -- Line: 70
    -- upvalues: Custom (copy)
    p13:_StopPlacementPreview();
    Custom.Destroy(p13);
end;

function u1._GetPlacementPosition(p14) -- Line: 79
    local _, v15 = p14.ClientFighter:GetCameraData();

    return v15.Position;
end;

function u1._StopPlacementPreview(p16) -- Line: 85
    if p16._preview_connection then
        p16._preview_connection:Disconnect();
        p16._preview_connection = nil;
    end;

    if p16._preview_model then
        p16._preview_model:Destroy();
        p16._preview_model = nil;
    end;
end;

function u1._StartPlacementPreview(p17) -- Line: 97
    p17:_StopPlacementPreview();

    if p17.ClientFighter.IsLocalPlayer then
    end;
end;

function u1._Init(p18) -- Line: 141
end;

return u1;