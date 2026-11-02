-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local AnimationLibrary = require(ReplicatedStorage.Modules.AnimationLibrary);
require(ReplicatedStorage.Modules.BetterDebris);
require(ReplicatedStorage.Modules.Utility);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local Melee = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Melee);
local u1 = setmetatable({}, Melee);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: Melee (copy), u1 (copy)
    local v2 = Melee.new(...);
    local v3 = setmetatable(v2, u1);
    v3._is_slamming = false;
    v3._slam_hash = 0;
    v3._slam_cooldown = 0;
    v3._leap_cooldown = 0;
    v3:_Init();

    return v3;
end;

function u1.StartAiming(u4, p5, p6) -- Line: 30
    -- upvalues: AnimationLibrary (copy)
    local v7;

    if p5 then
        v7 = p6;
    else
        v7 = u4.ClientFighter.Entity and (u4.ClientFighter.Entity:IsAirborne() or not u4.ClientFighter.Entity:IsGrounded());
    end;

    local v8 = v7 and true or false;

    if not p5 then
        if v8 then
            p6 = not u4.ClientFighter.Entity:GetFloor(u4.Info.SlamFloorDistance);
        else
            p6 = v8;
        end;
    end;

    local v9 = p6 and true or false;

    if not p5 then
        if u4:IsEquipping() then
            return false;
        end;

        if v9 and tick() < u4._slam_cooldown then
            return false;
        end;

        if v8 and not v9 then
            return false;
        end;

        if u4.ClientFighter.Entity.Humanoid:GetState() == Enum.HumanoidStateType.Climbing then
            return false;
        end;

        if not (v8 or (v9 or tick() >= u4._leap_cooldown)) then
            return false;
        end;
    end;

    u4.ClientFighter.Entity:AirborneCancel();

    if v9 then
        u4._slam_hash = u4._slam_hash + 1;
        local _slam_hash = u4._slam_hash;
        u4._is_slamming = true;
        u4._slam_cooldown = tick() + u4.Info.SlamCooldown;
        u4._attack_cooldown = (1 / 0);
        u4.ClientFighter.Entity.RootPart.Velocity = Vector3.new(0, -128, 0);
        u4:CooldownEffect("rbxassetid://127897416506738", u4.Info.SlamCooldown, "Slam");
        task.spawn(function() -- Line: 66
            -- upvalues: u4 (copy), AnimationLibrary (ref), _slam_hash (copy)
            u4.ViewModel:PlayAnimation("SlamIntro", (1 / 0), 0);
            wait(AnimationLibrary.Info[u4.ViewModel.Info.Animations.SlamIntro].Length);

            if _slam_hash ~= u4._slam_hash then
                return;
            end;

            u4.ViewModel:PlayAnimation("SlamLoop", (1 / 0), 0);
        end);
    else
        u4._leap_cooldown = tick() + u4.Info.LeapCooldown;
        local v10 = u4.ClientFighter:GetCameraData(nil, nil, true)[utf8.char(1)].LookVector * 32 * Vector3.new(1, 0, 1) + Vector3.new(0, 24, 0);
        u4.ClientFighter.Entity:AirborneTrigger(v10, 2, true);
        u4:CreateSound("rbxassetid://98587858115094", 1 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), true, 10);
    end;

    return true, "StartAiming", v9;
end;

function u1.Unequip(p11) -- Line: 90
    -- upvalues: Melee (copy)
    p11:_CancelSlam();
    Melee.Unequip(p11);
end;

function u1.ReplicateFromServer(p12, p13, ...) -- Line: 95
    -- upvalues: CameraController (copy), Melee (copy)
    if p13 == "SlamAttack" then
        if not p12:IsRendered() then
            return;
        end;

        local v14, v15 = ...;
        p12:_CancelSlam();
        p12._attack_cooldown = tick() + p12.Info.SlamEndLag;
        p12.ViewModel:PlayAnimation("SlamOutro", 0, 0);
        p12.ViewModel:SlamEffect(v14, v15);
        p12.ViewModel:SlamSoundEffect(v14, v15);

        if p12.ClientFighter:Get("IsSpectating") then
            CameraController:ShakeOnce(50, 10, 0.1, 0.4, Vector3.new(0.25, 0.25, 0), Vector3.new(0, 0, 0));
        end;
    else
        if p13 == "CancelSlam" then
            if not p12:IsRendered() then
                return;
            end;

            p12:_CancelSlam();

            return;
        end;

        Melee.ReplicateFromServer(p12, p13, ...);
    end;
end;

function u1._CancelSlam(p16) -- Line: 127
    p16._slam_hash = p16._slam_hash + 1;

    if not p16._is_slamming then
        return;
    end;

    p16._is_slamming = false;
    p16._attack_cooldown = 0;
    p16.ViewModel:StopAnimation("SlamIntro");
    p16.ViewModel:StopAnimation("SlamLoop");
    p16.ViewModel.Animator:SetInspectCooldown(0);
end;

function u1._Init(p17) -- Line: 142
end;

return u1;