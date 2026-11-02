-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local AnimationLibrary = require(ReplicatedStorage.Modules.AnimationLibrary);
local Signal = require(ReplicatedStorage.Modules.Signal);
local Custom = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Custom);
local u1 = setmetatable({}, Custom);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: Custom (copy), u1 (copy), Signal (copy)
    local v2 = Custom.new(...);
    local v3 = setmetatable(v2, u1);
    v3.AnimationReachedHealTimestamp = Signal.new();
    v3._is_using = false;
    v3._use_cooldown = 0;
    v3._use_hash = 0;
    v3:_Init();

    return v3;
end;

function u1.GetAutoShootReactionTime(p4) -- Line: 29
    return nil;
end;

function u1.CanQuickAttack(p5) -- Line: 33
    local v6 = not p5._is_using;

    if v6 then
        if tick() > p5._use_cooldown then
            v6 = not p5:IsEquipping() and p5.ClientFighter:GetHealth() < p5.ClientFighter:GetMaxHealth();
        else
            v6 = false;
        end;
    end;

    return v6;
end;

function u1.StartShooting(p7, p8) -- Line: 37
    if not p8 and (p7._is_using or (tick() < p7._use_cooldown or (p7:IsEquipping() or p7.ClientFighter:GetHealth() >= p7.ClientFighter:GetMaxHealth()))) then
        return false;
    end;

    p7:_Use("Long");

    return true, "StartShooting";
end;

function u1.StartAiming(p9, p10) -- Line: 47
    if not p10 and (p9._is_using or (tick() < p9._use_cooldown or (p9:IsEquipping() or p9.ClientFighter:GetHealth() >= p9.ClientFighter:GetMaxHealth()))) then
        return false;
    end;

    p9:_Use("Quick");

    return true, "StartAiming";
end;

function u1.Unequip(p11, ...) -- Line: 57
    -- upvalues: Custom (copy)
    p11:_CancelUse();
    Custom.Unequip(p11, ...);
end;

function u1.ReplicateFromServer(p12, p13, ...) -- Line: 62
    -- upvalues: Custom (copy)
    if p13 == "CancelUse" then
        if not p12:IsRendered() then
            return;
        end;

        p12:_CancelUse();

        return;
    end;

    if p13 ~= "SetCooldown" then
        Custom.ReplicateFromServer(p12, p13, ...);

        return;
    end;

    if not p12:IsRendered() then
        return;
    end;

    p12:_SetCooldown();
end;

function u1.Destroy(p14) -- Line: 80
    -- upvalues: Custom (copy)
    p14.AnimationReachedHealTimestamp:Destroy();
    Custom.Destroy(p14);
end;

function u1._SetCooldown(p15) -- Line: 89
    p15._use_cooldown = tick() + p15.Info.Cooldown;
    p15._is_using = false;
    p15:CooldownEffect("rbxassetid://17156089790", p15.Info.Cooldown, "Heal");
end;

function u1._CancelUse(p16) -- Line: 95
    p16._is_using = false;
    p16._use_hash = p16._use_hash + 1;
    p16:StopCooldownEffect("Healing");
    p16.ViewModel:StopAnimation("Use");
    p16.ViewModel:StopAnimation("UseQuick");
end;

function u1._Use(u17, p18) -- Line: 104
    -- upvalues: AnimationLibrary (copy)
    u17._is_using = true;
    local _use_hash = u17._use_hash;
    local u19 = u17.Info[p18 .. "ActionTimestamp"];
    local v20 = p18 == "Long" and "Use" or (p18 == "Quick" and "UseQuick" or nil);
    local u21 = AnimationLibrary.Info[u17.ViewModel.Info.Animations[v20]];
    u17.ViewModel:StopAnimation(u17.ViewModel.Animator:GetEquipAnimationKey());
    u17.ViewModel:PlayAnimation(v20, u21.Length);
    u17:CooldownEffect("rbxassetid://17140223250", u19, "Healing", true);
    task.spawn(function() -- Line: 116
        -- upvalues: u19 (copy), _use_hash (copy), u17 (copy)
        wait(u19);

        if _use_hash ~= u17._use_hash then
            return;
        end;

        u17.AnimationReachedHealTimestamp:Fire();
        u17._use_cooldown = tick() + 1;
        u17._is_using = false;
    end);
    task.spawn(function() -- Line: 132
        -- upvalues: u21 (copy), _use_hash (copy), u17 (copy)
        wait(u21.Length);

        if _use_hash ~= u17._use_hash then
            return;
        end;

        if u17.ViewModel.PlayEquipAnimationOnHeal then
            u17.ViewModel:PlayAnimation(u17.ViewModel.Animator:GetEquipAnimationKey());
        end;
    end);
end;

function u1._Init(p22) -- Line: 145
end;

return u1;