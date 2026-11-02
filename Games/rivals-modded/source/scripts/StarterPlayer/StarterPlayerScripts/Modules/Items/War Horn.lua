-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local AnimationLibrary = require(ReplicatedStorage.Modules.AnimationLibrary);
local Custom = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Custom);
local u1 = setmetatable({}, Custom);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Custom (copy), u1 (copy)
    local v2 = Custom.new(...);
    local v3 = setmetatable(v2, u1);
    v3._use_cooldown = 0;
    v3._use_hash = 0;
    v3:_Init();

    return v3;
end;

function u1.GetAutoShootReactionTime(p4) -- Line: 25
    return nil;
end;

function u1.CanQuickAttack(p5) -- Line: 29
    local v6;

    if tick() > p5._use_cooldown then
        v6 = not p5:IsEquipping();
    else
        v6 = false;
    end;

    return v6;
end;

function u1.StartShooting(p7, p8) -- Line: 33
    -- upvalues: AnimationLibrary (copy)
    if not (p8 or tick() >= p7._use_cooldown and not p7:IsEquipping()) then
        return false;
    end;

    p7._use_cooldown = tick() + p7.Info.Cooldown;
    p7:CooldownEffect("rbxassetid://17156089790", p7.Info.Cooldown, "Use");
    p7.ViewModel:StopAnimation("Equip");
    p7.ViewModel:PlayAnimation("Use", AnimationLibrary.Info[p7.ViewModel.Info.Animations.Use].Length);
    p7.ViewModel:PlayHornEffect();

    return true, "StartShooting";
end;

function u1.Unequip(p9, ...) -- Line: 47
    -- upvalues: Custom (copy)
    p9._use_hash = p9._use_hash + 1;
    Custom.Unequip(p9, ...);
end;

function u1._CancelUse(p10) -- Line: 56
    p10._is_using = false;
    p10._use_hash = p10._use_hash + 1;
    p10:StopCooldownEffect("Use");
    p10.ViewModel:StopAnimation("Use");
    p10.ViewModel:StopAnimation("UseQuick");
end;

function u1._Init(p11) -- Line: 65
end;

return u1;