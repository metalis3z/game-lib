-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local AnimationLibrary = require(ReplicatedStorage.Modules.AnimationLibrary);
require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local Melee = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Melee);
local u1 = setmetatable({}, Melee);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: Melee (copy), u1 (copy)
    local v2 = Melee.new(...);
    local v3 = setmetatable(v2, u1);
    v3._build_cooldown = 0;
    v3:_Init();

    return v3;
end;

function u1.CanEasyQuickAttack(p4) -- Line: 27
    local v5 = p4:CanQuickAttack();

    if v5 then
        if tick() > p4._build_cooldown then
            v5 = not p4:IsEquipping();
        else
            v5 = false;
        end;
    end;

    return v5;
end;

function u1.StartAiming(p6, p7) -- Line: 31
    -- upvalues: AnimationLibrary (copy)
    if not (p7 or tick() >= p6._build_cooldown and not p6:IsEquipping()) then
        return false;
    end;

    local _, v8 = p6.ClientFighter:GetCameraData();
    p6._build_cooldown = tick() + p6.Info.BuildCooldown;
    p6:CooldownEffect("rbxassetid://17132668997", p6.Info.BuildCooldown, "Build");
    p6.ViewModel:PlayAnimation("Build", AnimationLibrary.Info[p6.ViewModel.Info.Animations.Build].Length);

    return true, "StartAiming", v8.Position;
end;

function u1.FinishAiming(p9, p10) -- Line: 45
    return false;
end;

function u1.ReplicateFromServer(p11, p12, ...) -- Line: 49
    -- upvalues: Utility (copy), Melee (copy)
    if p12 == "HardenEffect" then
        if not p11:IsRendered() then
            return;
        end;

        Utility:CreateSound("rbxassetid://17138809559", 1.25, 1 + 0.2 * math.random(), ..., true, 5);

        return;
    end;

    if p12 ~= "ThrowEffect" then
        Melee.ReplicateFromServer(p11, p12, ...);

        return;
    end;

    if not p11:IsRendered() then
        return;
    end;

    Utility:CreateSound("rbxassetid://14522189766", 1.25, 2 + 0.25 * math.random(), ..., true, 5);
end;

function u1._Setup(u13) -- Line: 75
    function u13._on_attack_callback() -- Line: 76
        -- upvalues: u13 (copy)
        u13.ViewModel:StopAnimation("Build");
    end;
end;

function u1._Init(p14) -- Line: 81
    p14:_Setup();
end;

return u1;