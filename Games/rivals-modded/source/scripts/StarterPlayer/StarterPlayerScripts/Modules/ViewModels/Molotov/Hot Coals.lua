-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Molotov = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Molotov);
local u1 = setmetatable({}, Molotov);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: Molotov (copy), u1 (copy)
    local v2 = Molotov.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1._Init(u4) -- Line: 26
    u4.Animator.AnimationStopped:Connect(function(p5) -- Line: 27
        -- upvalues: u4 (copy)
        local EquipAnimationKey = u4.Animator:GetEquipAnimationKey();
        local IdleAnimationKey = u4.Animator:GetIdleAnimationKey();

        if p5 ~= EquipAnimationKey then
            return;
        end;

        local AnimationTrack = u4.Animator:GetAnimationTrack(EquipAnimationKey);

        if AnimationTrack then
            AnimationTrack:Stop(0);
        end;

        local AnimationTrack2 = u4.Animator:GetAnimationTrack(IdleAnimationKey);

        if AnimationTrack2 then
            AnimationTrack2:Stop(0);
            AnimationTrack2:Play(0);
        end;
    end);
end;

return u1;