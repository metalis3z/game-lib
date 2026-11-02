-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.Utility);
local ClientItem = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem);
local u1 = setmetatable({}, ClientItem);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: ClientItem (copy), u1 (copy)
    local v2 = ClientItem.new(...);
    local v3 = setmetatable(v2, u1);
    v3._last_attack = 0;
    v3._burst_count = 0;
    v3._attack_cooldown = 0;
    v3._attack_num = 0;
    v3._attack_hash = 0;
    v3._last_attack_animation_name = nil;
    v3._on_attack_callback = nil;
    v3:_Init();

    return v3;
end;

function u1.GetAutoShootReach(p4) -- Line: 30
    return p4.Info.AttackReach;
end;

function u1.CanQuickAttack(p5) -- Line: 34
    local v6 = not p5:IsEquipping();

    if v6 then
        if tick() > p5._attack_cooldown then
            v6 = not p5.Info.NeedsAmmoToAttack or p5:Get("Ammo") > 0;
        else
            v6 = false;
        end;
    end;

    return v6;
end;

function u1.StartShooting(u7, p8, p9) -- Line: 38
    if not p8 and (u7:IsEquipping() or (tick() < u7._attack_cooldown or u7.Info.NeedsAmmoToAttack and u7:Get("Ammo") <= 0)) then
        return false;
    end;

    if u7._last_attack_animation_name then
        u7.ViewModel:StopAnimation(u7._last_attack_animation_name, u7.Info.BurstCount > 1 and 0 or nil);
    end;

    u7._burst_count = tick() - u7._last_attack >= u7.Info.AttackCooldown and 0 or u7._burst_count;
    u7._burst_count = u7._burst_count % u7.Info.BurstCount + 1;
    u7._last_attack = tick();
    local v10 = u7._burst_count < u7.Info.BurstCount and u7.Info.BurstCooldown or u7.Info.AttackCooldown;
    u7._attack_cooldown = tick() + v10;
    u7._attack_hash = u7._attack_hash + 1;
    local _attack_hash = u7._attack_hash;
    u7._attack_num = u7._attack_num % #u7.ViewModel:GetAnimationKeys("Attack") + 1;
    local v11 = p9 and u7:FromEnum(p9) or "Attack" .. u7._attack_num;
    u7._last_attack_animation_name = v11;
    u7.ViewModel:StopAnimation("Equip");
    u7.ViewModel:PlayAnimation(v11, v10);

    if u7._on_attack_callback then
        u7._on_attack_callback();
    end;

    task.delay(u7.Info.AttackDelay, function() -- Line: 68
        -- upvalues: _attack_hash (copy), u7 (copy)
        if _attack_hash ~= u7._attack_hash then
            return;
        end;

        if u7.ClientFighter.IsLocalPlayer then
            local CameraData, v12 = u7.ClientFighter:GetCameraData();
            u7:_ImpactMarkerSlash(u7.Info.AttackReach, CameraData, v12);
        end;

        u7:_Shake("Bump");
    end);

    return true, "StartShooting", u7.ClientFighter:GetCameraData(), u7:ToEnum(v11);
end;

function u1.Equip(p13, ...) -- Line: 86
    -- upvalues: ClientItem (copy)
    ClientItem.Equip(p13, ...);
    p13._attack_hash = p13._attack_hash + 1;
end;

function u1.Unequip(p14, ...) -- Line: 91
    -- upvalues: ClientItem (copy)
    p14._attack_hash = p14._attack_hash + 1;
    ClientItem.Unequip(p14, ...);
end;

function u1._Init(p15) -- Line: 100
end;

return u1;