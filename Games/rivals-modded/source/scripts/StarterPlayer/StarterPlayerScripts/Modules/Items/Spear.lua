-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local AnimationLibrary = require(ReplicatedStorage.Modules.AnimationLibrary);
local GameplayUtility = require(ReplicatedStorage.Modules.GameplayUtility);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Melee = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Melee);
local SpearThrowParticles = Players.LocalPlayer.PlayerScripts.Assets.Misc.SpearThrowParticles;
local SpearThrowTrail = Players.LocalPlayer.PlayerScripts.Assets.Misc.SpearThrowTrail;
local u1 = setmetatable({}, Melee);
u1.__index = u1;

function u1.new(...) -- Line: 16
    -- upvalues: Melee (copy), u1 (copy)
    local v2 = Melee.new(...);
    local v3 = setmetatable(v2, u1);
    v3._throw_cooldown = 0;
    v3:_Init();

    return v3;
end;

function u1.CanEasyQuickAttack(p4) -- Line: 30
    local v5 = p4:CanQuickAttack();

    if v5 then
        if tick() > p4._throw_cooldown then
            v5 = not p4:IsEquipping();
        else
            v5 = false;
        end;
    end;

    return v5;
end;

function u1.StartAiming(p6, p7, p8) -- Line: 34
    -- upvalues: AnimationLibrary (copy)
    if not p7 and (p6:IsEquipping() or (tick() < p6._throw_cooldown or p6:Get("Ammo") <= 0)) then
        return false;
    end;

    if p6._last_attack_animation_name then
        p6.ViewModel:StopAnimation(p6._last_attack_animation_name);
    end;

    local v9 = p8 and p6:FromEnum(p8) or (p6:Get("Ammo") <= 1 and "ThrowFinal" or "Throw");
    p6._throw_cooldown = tick() + p6.Info.ThrowCooldown;
    p6._attack_cooldown = tick() + p6.Info.ThrowCooldown;
    p6:CooldownEffect("rbxassetid://86982712098586", p6.Info.ThrowCooldown, v9);
    p6.ViewModel:StopAnimation("Inspect", 0);
    p6.ViewModel:StopAnimation("Throw", 0);
    p6.ViewModel:StopAnimation("ThrowFinal", 0);
    p6.ViewModel:PlayAnimation(v9, AnimationLibrary.Info[p6.ViewModel.Info.Animations[v9]].Length);
    p6:_Shake("SpearThrow");
    task.spawn(p6._PlayThrowParticles, p6);

    return true, "StartAiming", p6.ClientFighter:GetCameraData(), p6:ToEnum(v9);
end;

function u1._PlayThrowParticles(p10) -- Line: 64
    -- upvalues: GameplayUtility (copy), SpearThrowParticles (copy), BetterDebris (copy), Utility (copy), SpearThrowTrail (copy)
    local v11 = nil;
    local v12 = nil;

    if p10.ClientFighter.IsLocalPlayer then
        local CameraData = p10.ClientFighter:GetCameraData(nil, nil, true);
        v11 = (CameraData[utf8.char(0)] * CFrame.new(0.5, -0.5, -0.5)).Position;
        v12 = GameplayUtility:GetMousePositionFromCameraData(p10.ClientFighter:Get("EnvironmentID"), p10.ClientFighter:GetEntityLookupParams(), CameraData[utf8.char(0)], CameraData[utf8.char(1)], CameraData[utf8.char(2)], CameraData[utf8.char(3)]);
    else
        local v13 = p10.ClientFighter.Entity and (p10.ClientFighter.Entity.Head or p10.ClientFighter.Entity.RootPart);

        if v13 then
            local v14 = CFrame.new(v13.Position) * p10.ClientFighter:GetRotationCFrame();
            v11 = v14.Position;
            v12 = GameplayUtility:GetMousePositionFromCameraData(p10.ClientFighter:Get("EnvironmentID"), p10.ClientFighter:GetEntityLookupParams(), v14, v14);
        end;
    end;

    if not (v11 and (v12 and not v11:FuzzyEq(v12))) then
        return;
    end;

    local v15 = SpearThrowParticles:Clone();
    v15.CFrame = CFrame.new(v11, v12) * CFrame.new(0, 0, -math.min(10, (v11 - v12).Magnitude - 1));
    v15.Parent = workspace;
    BetterDebris:AddItem(v15, 5);
    Utility:PlayParticles(v15);
    local v16 = SpearThrowTrail:Clone();
    v16.Parent = workspace;
    v16.Attachment0.WorldCFrame = CFrame.new(v11, v12);
    v16.Attachment1.WorldCFrame = CFrame.new(v12) * v16.Attachment0.WorldCFrame.Rotation;
    BetterDebris:AddItem(v16, 5);
    local Beam1 = v16.Beam1;
    local Beam2 = v16.Beam2;
    local Width0 = Beam1.Width0;
    local Width1 = Beam1.Width1;
    local Width02 = Beam2.Width0;
    local Width12 = Beam2.Width1;
    Utility:RenderstepForLoop(0, 100, 10, function(p17) -- Line: 108
        -- upvalues: Beam1 (copy), Width0 (copy), Width1 (copy), Beam2 (copy), Width02 (copy), Width12 (copy)
        local v18 = (p17 / 100) ^ 3;
        Beam1.Width0 = Width0 + (0 - Width0) * v18;
        Beam1.Width1 = Width1 + (0 - Width1) * v18;
        Beam2.Width0 = Width02 + (0 - Width02) * v18;
        Beam2.Width1 = Width12 + (0 - Width12) * v18;
    end);
    v16:Destroy();
end;

function u1._UpdateViewModelAnimations(p19) -- Line: 120
    local v20 = p19:Get("Ammo") <= 0;
    p19.ViewModel:ChangeEquipAnimation(v20 and "EmptyEquip" or "Equip");
    p19.ViewModel:ChangeIdleAnimation(v20 and "EmptyIdle" or "Idle");
    p19.ViewModel:ChangeInspectAnimation(v20 and "EmptyInspect" or "Inspect");
    p19.ViewModel:ChangeSprintAnimation(v20 and "EmptySprint" or "Sprint");
    local v21;

    if v20 then
        v21 = CFrame.identity;
    else
        v21 = nil;
    end;

    p19.ViewModel:OverrideRootPartOffset(v21);
end;

function u1._Setup(u22) -- Line: 130
    function u22._on_attack_callback() -- Line: 131
        -- upvalues: u22 (copy)
        u22.ViewModel:StopAnimation("Throw", 0);
        u22.ViewModel:StopAnimation("ThrowFinal", 0);
    end;
end;

function u1._Init(u23) -- Line: 137
    u23:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 138
        -- upvalues: u23 (copy)
        u23:_UpdateViewModelAnimations();
    end);
    u23:_Setup();
    task.defer(u23._UpdateViewModelAnimations, u23);
end;

return u1;