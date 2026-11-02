-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local Custom = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Custom);
local u1 = setmetatable({}, Custom);
u1.__index = u1;

function u1.new(...) -- Line: 12
    -- upvalues: Custom (copy), u1 (copy), Signal (copy)
    local v2 = Custom.new(...);
    local v3 = setmetatable(v2, u1);
    v3.Airblasted = Signal.new();
    v3._is_using = false;
    v3._use_cooldown = 0;
    v3._airblast_cooldown = 0;
    v3:_Init();

    return v3;
end;

function u1.GetAutoShootReactionTime(p4) -- Line: 30
    return 0;
end;

function u1.GetAutoShootReach(p5) -- Line: 34
    return p5.Info.Reach;
end;

function u1.CanQuickAttack(p6) -- Line: 38
    local v7;

    if tick() > p6._airblast_cooldown then
        v7 = not p6:IsEquipping();
    else
        v7 = false;
    end;

    return v7;
end;

function u1.StartShooting(p8, p9) -- Line: 43
    if not p9 and (p8._is_using or (tick() < p8._use_cooldown or (p8:Get("Ammo") <= 0 or p8:IsEquipping()))) then
        return false;
    end;

    p8._is_using = true;
    p8._use_cooldown = tick() + p8.Info.InternalUseCooldown;
    p8.ViewModel:SetFlameParticlesEnabled(true);
    p8.ViewModel:SetCustomSprintingEnabled((1 / 0));

    if p8.ViewModel.Info.Animations.Using then
        p8.ViewModel:PlayAnimation("Using");
    end;

    return true, "StartShooting";
end;

function u1.FinishShooting(p10, p11) -- Line: 60
    if not (p11 or p10._is_using) then
        return false;
    end;

    p10:_StopUsing();

    return true, "FinishShooting";
end;

function u1.StartAiming(u12, p13) -- Line: 70
    -- upvalues: Utility (copy)
    if not (p13 or tick() >= u12._airblast_cooldown and not u12:IsEquipping()) then
        return false;
    end;

    u12._airblast_cooldown = tick() + u12.Info.AirblastCooldown;
    u12.Airblasted:Fire();
    u12:CooldownEffect("rbxassetid://16828140099", u12.Info.AirblastCooldown, "Airblast");
    u12.ViewModel:Impulse(Vector3.new(0, 0, 30), 0.5);
    u12.ViewModel:StopAnimation("Inspect");
    u12.ViewModel:SetCustomSprintingEnabled(not u12._is_using and 0.5 or nil, true);
    u12:_Recoil(2);

    if u12:Get("QuickAttackQueued") then
        task.delay(0.1, function() -- Line: 86
            -- upvalues: u12 (copy)
            u12.ViewModel:AirblastEffect();
        end);
    else
        u12.ViewModel:AirblastEffect();
    end;

    local CameraData = u12.ClientFighter:GetCameraData();

    if u12.ClientFighter.IsLocalPlayer then
        local RootPart = u12.ClientFighter.Entity.RootPart;
        local v14 = u12.ClientFighter.Entity.RootPart.Velocity * Vector3.new(1, 0, 1);
        local math_max_ret = math.max(0, u12.ClientFighter.Entity.RootPart.Velocity.Y);
        RootPart.Velocity = v14 + Vector3.new(0, math_max_ret, 0) + Utility:DecodeCFrame(CameraData[utf8.char(0)]).LookVector * Vector3.new(0, 1, 0) * -25 * u12.Info.AirblastRecoilKnockback;
    end;

    return true, "StartAiming", CameraData;
end;

function u1.Equip(p15, ...) -- Line: 112
    -- upvalues: Custom (copy)
    Custom.Equip(p15, ...);
    p15:_StopUsing();
end;

function u1.Unequip(p16, ...) -- Line: 117
    -- upvalues: Custom (copy)
    p16:_StopUsing();
    Custom.Unequip(p16, ...);
end;

function u1.ReplicateFromServer(p17, p18, ...) -- Line: 122
    -- upvalues: Custom (copy)
    if p18 == "StopUsing" then
        p17:_StopUsing();

        return;
    end;

    Custom.ReplicateFromServer(p17, p18, ...);
end;

function u1.Destroy(p19) -- Line: 130
    -- upvalues: Custom (copy)
    p19.Airblasted:Destroy();
    p19:_StopUsing();
    Custom.Destroy(p19);
end;

function u1._StopUsing(p20) -- Line: 140
    if not p20._is_using then
        return;
    end;

    p20._is_using = false;
    p20.ViewModel:SetFlameParticlesEnabled(false);
    p20.ViewModel:SetCustomSprintingEnabled(0);

    if p20.ViewModel.Info.Animations.Using then
        p20.ViewModel:StopAnimation("Using");
    end;
end;

function u1._Init(u21) -- Line: 154
    table.insert(u21._connections, u21.ClientFighter.Interrupted:Connect(function() -- Line: 155
        -- upvalues: u21 (copy)
        u21:_StopUsing();
    end));
end;

return u1;