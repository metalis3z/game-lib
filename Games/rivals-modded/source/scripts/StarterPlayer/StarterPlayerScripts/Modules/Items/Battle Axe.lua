-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.AnimationLibrary);
require(ReplicatedStorage.Modules.BetterDebris);
local Melee = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Melee);
local u1 = setmetatable({}, Melee);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: Melee (copy), u1 (copy)
    local v2 = Melee.new(...);
    local v3 = setmetatable(v2, u1);
    v3._spin_cooldown = 0;
    v3:_Init();

    return v3;
end;

function u1.CanQuickAttack(p4) -- Line: 25
    local v5;

    if tick() > p4._spin_cooldown then
        v5 = not p4:IsEquipping();
    else
        v5 = false;
    end;

    return v5;
end;

function u1.StartAiming(p6, p7) -- Line: 29
    if p7 or tick() >= p6._spin_cooldown and (tick() >= p6._attack_cooldown and not p6:IsEquipping()) then
        p6._spin_cooldown = tick() + p6.Info.SpinCooldown;
        p6._attack_cooldown = tick() + p6.Info.SpinDuration + 0.5;

        if not p7 then
            local v8 = workspace.CurrentCamera.CFrame.LookVector:FuzzyEq(Vector3.new(0, 1, 0)) and Vector3.new(0, 0, 0) or (workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit;
            local v9 = p6.ClientFighter:GetMoveVector(true, true, v8) * p6.Info.SpinSpeed;
            p6.ClientFighter.Entity:HardDash(v9, p6.Info.SpinDuration, true, Vector3.new(0, 0.625, 0));
        end;

        if p6.ItemInterface then
            p6.ItemInterface:PlaySpeedLines(p6.Info.SpinDuration);
        end;

        if p6._last_attack_animation_name then
            p6.ViewModel:StopAnimation(p6._last_attack_animation_name);
        end;

        p6:CooldownEffect("rbxassetid://16828140099", p6.Info.SpinCooldown, "Spin");
        p6.ViewModel:StopAnimation("Equip");
        p6.ViewModel:PlayAnimation("SpinAttack", 1);
        p6.ViewModel:PlaySpinParticles();
        p6:_Shake("BattleAxeSpin");

        return true, "StartAiming", p6.ClientFighter:GetCameraData();
    end;
end;

function u1._Setup(u10) -- Line: 68
    function u10._on_attack_callback() -- Line: 69
        -- upvalues: u10 (copy)
        u10.ViewModel:StopAnimation("SpinAttack");
    end;
end;

function u1._Init(p11) -- Line: 74
    p11:_Setup();
end;

return u1;