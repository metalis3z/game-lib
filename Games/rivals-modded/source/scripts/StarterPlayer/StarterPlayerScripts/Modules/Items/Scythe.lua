-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.BetterDebris);
require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local Melee = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Melee);
local u1 = setmetatable({}, Melee);
u1.__index = u1;

function u1.new(...) -- Line: 12
    -- upvalues: Melee (copy), u1 (copy)
    local v2 = Melee.new(...);
    local v3 = setmetatable(v2, u1);
    v3._dash_cooldown = 0;
    v3:_Init();

    return v3;
end;

function u1.CanEasyQuickAttack(p4) -- Line: 26
    local v5 = p4:CanQuickAttack();

    if v5 then
        if tick() > p4._dash_cooldown then
            v5 = not p4:IsEquipping();
        else
            v5 = false;
        end;
    end;

    return v5;
end;

function u1.StartAiming(p6, p7) -- Line: 30
    if not (p7 or tick() >= p6._dash_cooldown and not p6:IsEquipping()) then
        return false;
    end;

    p6._dash_cooldown = tick() + p6.Info.DashCooldown;
    p6:CooldownEffect("rbxassetid://16828140099", p6.Info.DashCooldown, "Dash");
    p6.ViewModel:StopAnimation("Inspect");

    if p6.ViewModel:GetAnimationTrack("Dash") then
        if p6._last_attack_animation_name then
            p6.ViewModel:StopAnimation(p6._last_attack_animation_name);
        end;

        p6.ViewModel:PlayAnimation("Dash");
    end;

    if not p7 then
        local v8 = p6.ClientFighter:GetMoveVector(true, false, workspace.CurrentCamera.CFrame.LookVector) * p6.Info.DashSpeed;
        p6.ClientFighter.Entity:HardDash(v8, p6.Info.DashDuration);
    end;

    p6:CreateSound("rbxassetid://16492958314", 1, 1 + 0.1 * math.random(), true);

    if p6.ItemInterface then
        p6.ItemInterface:PlaySpeedLines(p6.Info.DashDuration);
    end;

    return true, "StartAiming";
end;

function u1.FinishAiming(p9, p10) -- Line: 63
    return false;
end;

function u1._Setup(u11) -- Line: 71
    function u11._on_attack_callback() -- Line: 72
        -- upvalues: u11 (copy)
        u11.ViewModel:StopAnimation("Dash", 0);
    end;
end;

function u1._Init(p12) -- Line: 77
    p12:_Setup();
end;

return u1;