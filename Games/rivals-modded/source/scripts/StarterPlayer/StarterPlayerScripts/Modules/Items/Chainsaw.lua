-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
local AnimationLibrary = require(ReplicatedStorage.Modules.AnimationLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Melee = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Melee);
local u1 = setmetatable({}, Melee);
u1.__index = u1;

function u1.new(...) -- Line: 14
    -- upvalues: Melee (copy), u1 (copy)
    local v2 = Melee.new(...);
    local v3 = setmetatable(v2, u1);
    v3._is_holding = false;
    v3._hold_cooldown = 0;
    v3._hold_hash = 0;
    v3._hold_sounds = nil;
    v3._hold_sounds_progress = 0;
    v3._hold_particles = {};
    v3:_Init();

    return v3;
end;

function u1.StartAiming(u4, p5) -- Line: 33
    -- upvalues: AnimationLibrary (copy), Utility (copy)
    if not p5 and (u4._is_holding or (tick() < u4._hold_cooldown or (tick() < u4._attack_cooldown or (u4:Get("Ammo") <= 0 or u4:IsEquipping())))) then
        return false;
    end;

    u4._is_holding = true;
    u4._hold_cooldown = tick() + u4.Info.InternalHoldCooldown;
    u4._attack_cooldown = (1 / 0);

    if u4._last_attack_animation_name then
        u4.ViewModel:StopAnimation(u4._last_attack_animation_name);
    end;

    u4.ViewModel:StopAnimation(u4.ViewModel.Animator:GetEquipAnimationKey(), 0);
    u4.ViewModel:PlayAnimation("HoldStart", (1 / 0), 0.1);
    u4.ViewModel:StopAnimation("HoldFinish", 0.1);
    u4._hold_hash = u4._hold_hash + 1;
    local _hold_hash = u4._hold_hash;
    task.spawn(function() -- Line: 54
        -- upvalues: u4 (copy), _hold_hash (copy)
        local v6 = tick();
        local v7 = nil;
        local v8 = nil;

        while u4._is_holding and _hold_hash == u4._hold_hash do
            local HoldSpeedBoostMin = u4.Info.HoldSpeedBoostMin;
            local v9 = u4.Info.HoldSpeedBoostMax - u4.Info.HoldSpeedBoostMin;
            local v10 = (tick() - v6) / u4.Info.HoldSpeedBoostRampTime;
            local v11 = HoldSpeedBoostMin + v9 * math.clamp(v10, 0, 1);
            u4.ClientFighter.Entity:SetBoost("Speed", "ChainsawHold", 0.3, v11);
            u4:_Shake("ChainsawHold");

            if v7 and v7 == u4:Get("Ammo") then
                if tick() - v8 > 0.25 then
                    u4:SimulateInputFromGameplayMechanic("FinishAiming", true);

                    return;
                end;
            else
                v7 = u4:Get("Ammo");
                v8 = tick();
            end;

            wait(0.1);
        end;
    end);
    task.spawn(function() -- Line: 81
        -- upvalues: AnimationLibrary (ref), u4 (copy), _hold_hash (copy)
        wait(AnimationLibrary.Info[u4.ViewModel.Info.Animations.HoldStart].Length);

        if _hold_hash ~= u4._hold_hash then
            return;
        end;

        u4.ViewModel:PlayAnimation("HoldLoop", (1 / 0), 0);
        u4.ViewModel:EnableParticles(true);
    end);

    if not u4._hold_sounds then
        u4._hold_sounds = {};

        for _, v in pairs(u4.ViewModel:CreateHoldSounds()) do
            u4._hold_sounds[v] = v.Volume;
            v.Looped = true;
        end;

        u4.ViewModel:PlayStartingHoldSounds();
    end;

    task.spawn(Utility.RenderstepForLoop, Utility, u4._hold_sounds_progress, 100, 25, function(p12) -- Line: 103
        -- upvalues: _hold_hash (copy), u4 (copy)
        if _hold_hash ~= u4._hold_hash then
            return true;
        end;

        u4._hold_sounds_progress = p12;

        for i, v in pairs(u4._hold_sounds) do
            i.Volume = v * p12 / 100;
        end;
    end);

    return true, "StartAiming";
end;

function u1.FinishAiming(p13, p14) -- Line: 118
    if p14 or p13._is_holding then
        p13:_StopHolding(true);

        return true, "FinishAiming";
    end;
end;

function u1.Equip(p15) -- Line: 128
    -- upvalues: Melee (copy)
    Melee.Equip(p15);
    p15:_StopHolding();
end;

function u1.Unequip(p16) -- Line: 133
    -- upvalues: Melee (copy)
    p16:_StopHolding(true);
    Melee.Unequip(p16);
end;

function u1.ReplicateFromServer(p17, p18, ...) -- Line: 138
    -- upvalues: Melee (copy)
    if p18 == "StopHolding" then
        p17:_StopHolding(true);

        return;
    end;

    Melee.ReplicateFromServer(p17, p18, ...);
end;

function u1.Destroy(p19) -- Line: 146
    -- upvalues: Melee (copy)
    p19:_StopHolding();
    Melee.Destroy(p19);
end;

function u1._StopHolding(u20, p21) -- Line: 155
    -- upvalues: AnimationLibrary (copy), Utility (copy)
    local _is_holding = u20._is_holding;
    u20._hold_hash = u20._hold_hash + 1;
    u20._is_holding = false;
    u20._attack_cooldown = p21 and 0 or u20._attack_cooldown;

    if u20.ClientFighter.Entity then
        u20.ClientFighter.Entity:RemoveBoost("ChainsawHold");
    end;

    if _is_holding then
        u20.ViewModel:PlayAnimation("HoldFinish", AnimationLibrary.Info[u20.ViewModel.Info.Animations.HoldFinish].Length, 0.1);
    end;

    u20.ViewModel:StopAnimation("HoldStart", 0.1);
    u20.ViewModel:StopAnimation("HoldLoop", 0.1);

    if u20._hold_sounds then
        local _hold_hash = u20._hold_hash;
        task.spawn(function() -- Line: 176
            -- upvalues: Utility (ref), u20 (copy), _hold_hash (copy)
            Utility:RenderstepForLoop(u20._hold_sounds_progress, 0, -10, function(p22) -- Line: 177
                -- upvalues: _hold_hash (ref), u20 (ref)
                if _hold_hash ~= u20._hold_hash then
                    return true;
                end;

                u20._hold_sounds_progress = p22;

                for i, v in pairs(u20._hold_sounds) do
                    i.Volume = v * (p22 / 100) ^ 2;
                end;
            end);

            if _hold_hash ~= u20._hold_hash then
                return;
            end;

            for i in pairs(u20._hold_sounds) do
                i:Destroy();
            end;

            u20._hold_sounds = nil;
        end);
    end;

    u20.ViewModel:EnableParticles(false);
end;

function u1._Setup(u23) -- Line: 204
    function u23._on_attack_callback() -- Line: 205
        -- upvalues: u23 (copy)
        u23.ViewModel:StopAnimation("HoldFinish");
    end;
end;

function u1._Init(u24) -- Line: 210
    table.insert(u24._connections, u24.ClientFighter.Interrupted:Connect(function() -- Line: 211
        -- upvalues: u24 (copy)
        if u24._is_holding then
            u24:_StopHolding(true);
        end;
    end));
    u24:_Setup();
end;

return u1;