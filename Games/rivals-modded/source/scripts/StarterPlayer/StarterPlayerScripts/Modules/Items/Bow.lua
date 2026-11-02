-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local AnimationLibrary = require(ReplicatedStorage.Modules.AnimationLibrary);
local Gun = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Gun);
local u1 = setmetatable({}, Gun);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Gun (copy), u1 (copy)
    local v2 = Gun.new(...);
    local v3 = setmetatable(v2, u1);
    v3.ToggleAimEnabled = nil;
    v3._is_charging = false;
    v3._charge_hash = 0;
    v3:_Init();

    return v3;
end;

function u1.StartAiming(u4, p5) -- Line: 27
    -- upvalues: AnimationLibrary (copy)
    if not p5 then
        if u4._is_charging or (tick() < u4._shoot_cooldown or (tick() < u4._reload_cooldown or (tick() < u4._shoot_cooldown_no_ammo or u4:IsEquipping()))) then
            return false;
        end;

        if u4:Get("Ammo") <= 0 then
            local v6 = { u4:StartReloading() };

            if v6[1] then
                return table.unpack(v6);
            end;

            u4._shoot_cooldown_no_ammo = tick() + u4.Info.ShootCooldown;
            u4:CreateSound("rbxassetid://13087319223", 1, 1, true, 5);

            return false;
        end;
    end;

    local ChargeLevelTimestamps = u4.Info.ChargeLevelTimestamps;
    u4._is_charging = true;
    u4._shoot_cooldown = (1 / 0);
    u4._reload_cooldown = (1 / 0);
    u4:_StartAimAssist();
    u4._on_shoot_callback();
    u4.ViewModel:StopAnimation("Equip", 0);
    u4.ViewModel:PlayAnimation("Charge", (1 / 0), 0.1);

    if u4.ItemInterface then
        u4.ItemInterface.Charge:Set(1);
        u4.ItemInterface.Charge:Start(ChargeLevelTimestamps);
    end;

    u4._charge_hash = u4._charge_hash + 1;
    local _charge_hash = u4._charge_hash;
    task.spawn(function() -- Line: 64
        -- upvalues: ChargeLevelTimestamps (copy), _charge_hash (copy), u4 (copy)
        for i, v in pairs(ChargeLevelTimestamps) do
            if v > 0 then
                wait(v - (ChargeLevelTimestamps[i - 1] or 0));

                if _charge_hash ~= u4._charge_hash then
                    return;
                end;

                u4:SetReplicate("FOVOffset", 5 * (i - 1));
                u4.ViewModel:PlayChargeEffect(i);

                if u4.ItemInterface then
                    u4.ItemInterface.Charge:Set(i);
                    u4.ItemInterface.Charge:Play();
                end;
            end;
        end;
    end);
    task.spawn(function() -- Line: 87
        -- upvalues: AnimationLibrary (ref), u4 (copy), _charge_hash (copy)
        wait(AnimationLibrary.Info[u4.ViewModel.Info.Animations.Charge].Length);

        if _charge_hash ~= u4._charge_hash then
            return;
        end;

        u4.ViewModel:PlayAnimation("ChargeLoop", (1 / 0), 0);
    end);

    return true, "StartAiming";
end;

function u1.FinishAiming(p7, p8) -- Line: 100
    if not (p8 or p7._is_charging) then
        return false;
    end;

    p7:_StopCharging();

    return true, "FinishAiming", p7.ClientFighter:GetCameraData();
end;

function u1.StartSprinting(p9, p10) -- Line: 112
    return false;
end;

function u1.Unequip(p11, ...) -- Line: 116
    -- upvalues: Gun (copy)
    task.spawn(p11.Input, p11, "FinishAiming");
    task.defer(p11._StopCharging, p11, true);
    Gun.Unequip(p11, ...);
end;

function u1._StopCharging(p12, p13) -- Line: 126
    local ChargeReleaseCooldown = p12.Info.ChargeReleaseCooldown;
    p12._is_charging = false;
    p12._charge_hash = p12._charge_hash + 1;
    p12._shoot_cooldown = tick() + ChargeReleaseCooldown;
    p12._reload_cooldown = tick() + ChargeReleaseCooldown;
    p12:_FinishAimAssist();
    p12:SetReplicate("FOVOffset", 0);

    if not p13 then
        p12.ViewModel:PlayAnimation("ChargeRelease", ChargeReleaseCooldown, 0);
    end;

    p12.ViewModel:StopAnimation("ChargeLoop", 0.1);
    p12.ViewModel:StopAnimation("Charge", 0.1);

    if p12.ItemInterface then
        p12.ItemInterface.Charge:Stop(p13);
    end;
end;

function u1._Setup(u14) -- Line: 148
    function u14._on_shoot_callback() -- Line: 149
        -- upvalues: u14 (copy)
        u14.ViewModel:StopAnimation("ChargeLoop", 0);
        u14.ViewModel:StopAnimation("ChargeRelease", 0);
    end;
end;

function u1._Init(u15) -- Line: 155
    table.insert(u15._connections, u15.ClientFighter.Interrupted:Connect(function() -- Line: 156
        -- upvalues: u15 (copy)
        u15:_StopCharging(true);
    end));
    u15:_Setup();
end;

return u1;