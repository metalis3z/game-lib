-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local Melee = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Melee);
local u1 = setmetatable({}, Melee);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Melee (copy), u1 (copy)
    local v2 = Melee.new(...);
    local v3 = setmetatable(v2, u1);
    v3._deflect_cooldown = 0;
    v3._deflect_hash = 0;
    v3._deflect_num = 0;
    v3:_Init();

    return v3;
end;

function u1.CanEasyQuickAttack(p4) -- Line: 26
    local v5 = p4:CanQuickAttack();

    if v5 then
        if tick() > p4._deflect_cooldown then
            v5 = not p4:IsEquipping();
        else
            v5 = false;
        end;
    end;

    return v5;
end;

function u1.StartAiming(u6, p7) -- Line: 30
    if p7 or tick() >= u6._deflect_cooldown and not u6:IsEquipping() then
        u6._deflect_cooldown = tick() + u6.Info.DeflectDuration + u6.Info.DeflectCooldown;
        u6._attack_cooldown = tick() + u6.Info.DeflectDuration;
        u6:_StartDeflecting();
        u6:CooldownEffect("rbxassetid://16828414433", u6.Info.DeflectDuration, "Deflect", true);
        task.delay(u6.Info.DeflectDuration, function() -- Line: 40
            -- upvalues: u6 (copy)
            u6:CooldownEffect("rbxassetid://16828414433", u6.Info.DeflectCooldown, "Deflect");
        end);

        return true, "StartAiming";
    end;
end;

function u1.ReplicateFromServer(p8, p9, ...) -- Line: 48
    -- upvalues: Melee (copy)
    if p9 ~= "DeflectHit" then
        Melee.ReplicateFromServer(p8, p9, ...);

        return;
    end;

    if not p8:IsRendered() then
        return;
    end;

    p8.ViewModel:StopAnimation("DeflectIdle", 0);
    p8.ViewModel:StopAnimation("Deflect" .. p8._deflect_num);
    p8._deflect_num = p8._deflect_num == #p8.ViewModel:GetAnimationKeys("Deflect") and 1 or p8._deflect_num + 1;
    p8.ViewModel:PlayAnimation("Deflect" .. p8._deflect_num, 1, 0);
    p8.ViewModel:PlayDeflectHitParticles();
    p8.ViewModel:PlayDeflectHitSounds();
end;

function u1._StopDeflectionAnimations(p10) -- Line: 69
    for i = 1, #p10.ViewModel:GetAnimationKeys("Deflect") do
        p10.ViewModel:StopAnimation("Deflect" .. i);
        local _ = i;
    end;
end;

function u1._StartDeflecting(u11) -- Line: 75
    if u11._last_attack_animation_name then
        u11.ViewModel:StopAnimation(u11._last_attack_animation_name);
    end;

    u11._deflect_hash = u11._deflect_hash + 1;
    local _deflect_hash = u11._deflect_hash;
    u11:SetReplicate("FOVOffset", 5);
    u11.ViewModel:StopAnimation("Equip", 0);
    u11.ViewModel:PlayAnimation("DeflectIdle", u11.Info.DeflectDuration);

    if u11:Get("QuickAttackQueued") then
        task.delay(0.1, function() -- Line: 89
            -- upvalues: u11 (copy)
            u11.ViewModel:PlayDeflectActiveParticles();
        end);
    else
        u11.ViewModel:PlayDeflectActiveParticles();
    end;

    task.spawn(function() -- Line: 96
        -- upvalues: u11 (copy), _deflect_hash (copy)
        wait(u11.Info.DeflectDuration);

        if u11._deflect_hash ~= _deflect_hash then
            return;
        end;

        u11:_StopDeflecting();
        wait(u11.Info.DeflectCooldown);

        if u11._deflect_hash ~= _deflect_hash then
            return;
        end;

        u11:StopCooldownEffect("Deflect");
    end);
end;

function u1._StopDeflecting(p12) -- Line: 115
    p12._deflect_hash = p12._deflect_hash + 1;
    p12:SetReplicate("FOVOffset", 0);
    p12.ViewModel:ClearDeflectActiveParticles();
    p12:_StopDeflectionAnimations();
end;

function u1._Setup(u13) -- Line: 122
    function u13._on_attack_callback() -- Line: 123
        -- upvalues: u13 (copy)
        u13.ViewModel:StopAnimation("DeflectIdle", 0);
        u13:_StopDeflectionAnimations();
    end;
end;

function u1._Init(p14) -- Line: 129
    p14:_Setup();
end;

return u1;