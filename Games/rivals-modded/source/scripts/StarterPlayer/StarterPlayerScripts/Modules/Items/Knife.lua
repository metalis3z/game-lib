-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.Utility);
local Melee = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Melee);
local u1 = setmetatable({}, Melee);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: Melee (copy), u1 (copy)
    local v2 = Melee.new(...);
    local v3 = setmetatable(v2, u1);
    v3._heavy_attack_num = 0;
    v3._backstab_hash = 0;
    v3._fov_offset_speed = 1;
    v3:_Init();

    return v3;
end;

function u1.GetAimSpeed(p4) -- Line: 29
    return p4._fov_offset_speed;
end;

function u1.StartAiming(u5, p6, p7) -- Line: 33
    if not (p6 or tick() >= u5._attack_cooldown and not u5:IsEquipping()) then
        return false;
    end;

    u5._attack_cooldown = tick() + u5.Info.HeavyAttackCooldown;
    u5:CooldownEffect("rbxassetid://133090003053503", u5.Info.HeavyAttackCooldown, "HeavyAttack");

    if u5._last_attack_animation_name then
        u5.ViewModel:StopAnimation(u5._last_attack_animation_name);
    end;

    u5._heavy_attack_num = u5._heavy_attack_num % #u5.ViewModel:GetAnimationKeys("HeavyAttack") + 1;
    local v8 = p7 and u5:FromEnum(p7) or "HeavyAttack" .. u5._heavy_attack_num;
    u5._last_attack_animation_name = v8;
    u5.ViewModel:StopAnimation("HeavyAttackAnimationHit");
    u5.ViewModel:StopAnimation("Equip");
    u5.ViewModel:PlayAnimation(v8, u5.Info.HeavyAttackCooldown);
    task.delay(0.1, function() -- Line: 54
        -- upvalues: u5 (copy)
        u5:_Shake("Bump");
    end);
    local CameraData, v9 = u5.ClientFighter:GetCameraData();

    if u5.ClientFighter.IsLocalPlayer then
        u5:_ImpactMarkerSlash(u5.Info.HeavyAttackReach, CameraData, v9);
    end;

    if u5:Get("DashOnAim") then
        if not p6 then
            local v10 = u5.ClientFighter:GetMoveVector(true, false, workspace.CurrentCamera.CFrame.LookVector) * 100;
            u5.ClientFighter.Entity:HardDash(v10, 0.25);
        end;

        u5:CreateSound("rbxassetid://16492958314", 1, 1 + 0.1 * math.random(), true);
    end;

    return true, "StartAiming", CameraData, u5:ToEnum(v8);
end;

function u1.ReplicateFromServer(p11, p12, ...) -- Line: 78
    -- upvalues: Melee (copy)
    if p12 ~= "BackstabEffect" then
        Melee.ReplicateFromServer(p11, p12, ...);

        return;
    end;

    if not p11:IsRendered() then
        return;
    end;

    p11._backstab_hash = p11._backstab_hash + 1;
    local _backstab_hash = p11._backstab_hash;
    p11._fov_offset_speed = 5;
    p11:SetReplicate("FOVOffset", -10);
    wait(0.25);

    if p11._backstab_hash ~= _backstab_hash then
        return;
    end;

    p11._fov_offset_speed = 1;
    p11:SetReplicate("FOVOffset", 0);
end;

function u1._Setup(u13) -- Line: 107
    function u13._on_attack_callback() -- Line: 108
        -- upvalues: u13 (copy)
        u13.ViewModel:StopAnimation("HeavyAttackAnimationHit");
    end;
end;

function u1._Init(p14) -- Line: 113
    p14:_Setup();
end;

return u1;