-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
local AnimationLibrary = require(ReplicatedStorage.Modules.AnimationLibrary);
require(ReplicatedStorage.Modules.BetterDebris);
local Gun = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Gun);
local u1 = setmetatable({}, Gun);
u1.__index = u1;

function u1.new(...) -- Line: 14
    -- upvalues: Gun (copy), u1 (copy)
    local v2 = Gun.new(...);
    local v3 = setmetatable(v2, u1);
    v3.ToggleAimEnabled = nil;
    v3._transition_cooldown = 0;
    v3._blade_cooldown = 0;
    v3._blade_attack_num = 0;
    v3._last_blade_animation_name = nil;
    v3._dash_cooldown = 0;
    v3._fov_offset_speed = 1;
    v3._blade_critical_hit_hash = 0;
    v3._transition_animation_playing = 0;
    v3:_Init();

    return v3;
end;

function u1.CanQuickAttack(p4) -- Line: 37
    -- upvalues: Gun (copy)
    local v5;

    if tick() > p4._transition_cooldown then
        if p4:Get("Mode") == "Gun" then
            return Gun.CanQuickAttack(p4);
        end;

        if tick() > p4._blade_cooldown then
            v5 = not p4:IsEquipping();
        else
            v5 = false;
        end;
    else
        v5 = false;
    end;

    return v5;
end;

function u1.GetAutoShootReactionTime(p6) -- Line: 41
    -- upvalues: Gun (copy)
    return p6:Get("Mode") == "Blade" and 0 or Gun.GetAutoShootReactionTime(p6);
end;

function u1.GetAutoShootReach(p7) -- Line: 45
    -- upvalues: Gun (copy)
    if p7:Get("Mode") == "Blade" then
        return p7.Info.BladeReach;
    end;

    return Gun.GetAutoShootReach(p7);
end;

function u1.GetAimSpeed(p8) -- Line: 49
    return p8._fov_offset_speed;
end;

function u1.GetMobileInputSettings(p9) -- Line: 53
    -- upvalues: Gun (copy)
    if p9:Get("Mode") == "Blade" then
        return p9.Info.BladeModeMobileInputSettings;
    end;

    return Gun.GetMobileInputSettings(p9);
end;

function u1.StartShooting(p10, p11, p12, ...) -- Line: 57
    -- upvalues: Gun (copy)
    local v13 = p12 or p10:Get("Mode");

    if not (p11 or tick() >= p10._transition_cooldown and not p10:IsEquipping()) then
        return false;
    end;

    p10.ViewModel:StopAnimation("To" .. v13);

    if v13 == "Gun" then
        return Gun.StartShooting(p10, p11, ...);
    end;

    if v13 == "Blade" then
        return p10:_StartShootingBladeMode(p11, ...);
    end;

    return false;
end;

function u1.StartAiming(p14, p15, p16, ...) -- Line: 75
    -- upvalues: Gun (copy)
    local v17 = p16 or p14:Get("Mode");

    if not p15 and (v17 == "Gun" and tick() < p14._transition_cooldown or p14:IsEquipping()) then
        return false;
    end;

    p14.ViewModel:StopAnimation("To" .. v17);

    if v17 == "Gun" then
        return Gun.StartAiming(p14, p15, ...);
    end;

    if v17 == "Blade" then
        return p14:_StartAimingBladeMode(p15, ...);
    end;

    return false;
end;

function u1.ReplicateFromServer(p18, p19, ...) -- Line: 93
    -- upvalues: AnimationLibrary (copy), Gun (copy)
    if p19 ~= "BladeCriticalHit" then
        Gun.ReplicateFromServer(p18, p19, ...);

        return;
    end;

    if not p18:IsRendered() then
        return;
    end;

    if not p18.IsEquipped then
        return;
    end;

    local v20 = ... and "BladeAttackOnHitNoAmmo" or "BladeAttackOnHit";
    p18._blade_critical_hit_hash = p18._blade_critical_hit_hash + 1;
    local _blade_critical_hit_hash = p18._blade_critical_hit_hash;
    p18._fov_offset_speed = 5;
    p18:SetReplicate("FOVOffset", -5);

    if p18._last_blade_animation_name then
        p18.ViewModel:StopAnimation(p18._last_blade_animation_name);
    end;

    p18.ViewModel:PlayAnimation(v20, nil, 0);
    wait(AnimationLibrary.Info[p18.ViewModel.Info.Animations[v20]].ActionTimestamp);

    if p18._blade_critical_hit_hash ~= _blade_critical_hit_hash then
        return;
    end;

    p18:SetReplicate("FOVOffset", 5);
    p18:_Recoil(2);
    p18.ViewModel:MuzzleFlash();
    wait(0.125);

    if p18._blade_critical_hit_hash ~= _blade_critical_hit_hash then
        return;
    end;

    p18._fov_offset_speed = 1;
    p18:SetReplicate("FOVOffset", 0);
end;

function u1._StartShootingBladeMode(u21, p22) -- Line: 145
    if not p22 and tick() < u21._blade_cooldown then
        return false;
    end;

    u21._blade_cooldown = tick() + u21.Info.BladeCooldown;

    if u21._last_blade_animation_name then
        u21.ViewModel:StopAnimation(u21._last_blade_animation_name);
    end;

    u21._blade_attack_num = u21._blade_attack_num % #u21.ViewModel:GetAnimationKeys("BladeAttack") + 1;
    u21._last_blade_animation_name = "BladeAttack" .. u21._blade_attack_num;
    u21.ViewModel:StopAnimation("Dash", 0);
    u21.ViewModel:StopAnimation("BladeAttackOnHitNoAmmo");
    u21.ViewModel:StopAnimation("BladeAttackOnHit");
    u21.ViewModel:StopAnimation("BladeEquip");
    u21.ViewModel:StopAnimation("Equip");
    u21.ViewModel:PlayAnimation(u21._last_blade_animation_name, u21.Info.BladeCooldown);
    task.delay(0.1, function() -- Line: 166
        -- upvalues: u21 (copy)
        u21:_Shake("Bump");
    end);
    local CameraData, v23 = u21.ClientFighter:GetCameraData();

    if u21.ClientFighter.IsLocalPlayer then
        u21:_ImpactMarkerSlash(u21.Info.BladeReach, CameraData, v23);
    end;

    return true, "StartShooting", CameraData;
end;

function u1._StartAimingBladeMode(p24, p25) -- Line: 179
    if not p25 and tick() < p24._dash_cooldown then
        return false;
    end;

    p24._dash_cooldown = tick() + p24.Info.DashCooldown;
    p24:CooldownEffect("rbxassetid://16828140099", p24.Info.DashCooldown, "Dash");

    if not p25 then
        local v26 = p24.ClientFighter:GetMoveVector(true, false, workspace.CurrentCamera.CFrame.LookVector) * p24.Info.DashSpeed;
        p24.ClientFighter.Entity:HardDash(v26, p24.Info.DashDuration);
    end;

    p24:CreateSound("rbxassetid://16492958314", 1, 1 + 0.1 * math.random(), true);

    if p24.ItemInterface then
        p24.ItemInterface:PlaySpeedLines(p24.Info.DashDuration);
    end;

    if p24.ViewModel:GetAnimationTrack("Dash") then
        if p24._last_attack_animation_name then
            p24.ViewModel:StopAnimation(p24._last_attack_animation_name);
        end;

        if p24._last_blade_animation_name then
            p24.ViewModel:StopAnimation(p24._last_blade_animation_name);
        end;

        p24.ViewModel:StopAnimation("BladeAttackOnHitNoAmmo");
        p24.ViewModel:StopAnimation("BladeAttackOnHit");
        p24.ViewModel:StopAnimation("BladeEquip");
        p24.ViewModel:StopAnimation("Equip");
        p24.ViewModel:PlayAnimation("Dash");
    end;

    return true, "StartAiming";
end;

function u1._ModeChanged(p27, p28) -- Line: 219
    if p27._last_shoot_animation_name then
        p27.ViewModel:StopAnimation(p27._last_shoot_animation_name);
    end;

    if p27._last_blade_animation_name then
        p27.ViewModel:StopAnimation(p27._last_blade_animation_name);
    end;

    local v29 = p27:Get("Mode");
    local v30 = v29 == "Blade" and "Blade" or "";
    p27.ViewModel:ChangeEquipAnimation(v30 .. "Equip");
    p27.ViewModel:ChangeIdleAnimation(v30 .. "Idle");
    p27.ViewModel:ChangeSprintAnimation(v30 .. "Sprint");
    p27.ViewModel:ChangeInspectAnimation(v30 .. "Inspect");

    if not p28 then
        p27.ViewModel:PlayAnimation("To" .. v29 .. (v29 == "Gun" and (p27._blade_attack_num or "") or ""));

        for _, v in pairs({ "Shoot", "BladeAttack" }) do
            local v31 = v;

            for i = 1, #p27.ViewModel:GetAnimationKeys(v) do
                p27.ViewModel.Animator:BlockAnimation(v31 .. i, 0.25);
                local _ = i;
            end;
        end;
    end;

    p27.ToggleAimEnabled = v29 == "Gun";
end;

function u1._Setup(u32) -- Line: 250
    function u32._on_shoot_callback() -- Line: 251
        -- upvalues: u32 (copy)
        u32.ViewModel:StopAnimation("Dash", 0);
    end;
end;

function u1._Init(u33) -- Line: 256
    u33.Shot:Connect(function() -- Line: 257
        -- upvalues: u33 (copy)
        u33.ViewModel:StopAnimation("BladeAttackOnHit");
        u33.ViewModel:StopAnimation("BladeAttackOnHitNoAmmo");
    end);
    u33:GetDataChangedSignal("Mode"):Connect(function() -- Line: 271
        -- upvalues: u33 (copy)
        task.spawn(u33.Input, u33, "FinishAiming");
        u33._blade_attack_num = u33:Get("Mode") == "Blade" and 0 or u33._blade_attack_num;
        u33._transition_cooldown = tick() + u33.Info.TransitionCooldown - 0.1;
        u33:_ModeChanged();
        u33.ToggleOffMobileInputButton:Fire("mobile_aim");
    end);
    u33:_Setup();
    u33:_ModeChanged(true);
end;

return u1;