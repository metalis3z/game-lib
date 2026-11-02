-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local AnimationLibrary = require(ReplicatedStorage.Modules.AnimationLibrary);
local GameplayUtility = require(ReplicatedStorage.Modules.GameplayUtility);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Spring = require(ReplicatedStorage.Modules.Spring);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local WrapController = require(Players.LocalPlayer.PlayerScripts.Controllers.WrapController);
local ClientItem = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem);
local TracerEffect = require(Players.LocalPlayer.PlayerScripts.Modules.TracerEffect);
local Projectiles = Players.LocalPlayer.PlayerScripts.Assets:WaitForChild("Projectiles");
local u1 = setmetatable({}, ClientItem);
u1.__index = u1;

function u1.new(...) -- Line: 24
    -- upvalues: ClientItem (copy), u1 (copy), Signal (copy), Spring (copy)
    local v2 = ClientItem.new(...);
    local v3 = setmetatable(v2, u1);
    v3.Shot = Signal.new();
    v3.ProjectileShot = Signal.new();
    v3.ToggleAimEnabled = true;
    v3.Data.IsAiming = false;
    v3._last_shot = 0;
    v3._burst_count = 0;
    v3._shoot_cooldown = 0;
    v3._is_revolver_quick_shooting = nil;
    v3._shoot_animation_num = 1;
    v3._last_shoot_animation_name = nil;
    v3._shoot_cooldown_no_ammo = 0;
    v3._on_shoot_callback = nil;
    v3._shot_but_ammo_hasnt_updated = false;
    v3._reload_threads = {};
    v3._reload_cooldown = 0;
    v3._reload_cancel_cooldown = 0;
    v3._reload_cancel_expiration = 0;
    v3._reload_delay = 0;
    v3._local_tracers = {};
    v3._on_reload_callback = nil;
    v3._projectile_part_to_model = {};
    v3._is_input_queueing = false;
    v3._camera_displacement_spring = Spring.new(Vector2.zero, 1, 25);
    v3._shoot_animation_name_prefix = nil;
    v3._num_shooting_animations = nil;
    v3:_Init();

    return v3;
end;

function u1.CanQuickAttack(p4) -- Line: 65
    local v5;

    if tick() > p4._shoot_cooldown and p4:Get("Ammo") > 0 then
        v5 = not p4:IsEquipping();
    else
        v5 = false;
    end;

    return v5;
end;

function u1.GetAutoShootReactionTime(p6) -- Line: 69
    if p6.Info.BurstCount > 1 then
        return (p6.Info.BurstCooldown * p6.Info.BurstCount) ^ 2;
    end;

    return p6.Info.ShootCooldown ^ 2;
end;

function u1.GetAimSpeed(p7) -- Line: 73
    return p7:Get("IsAiming") and p7.Info.AimSpeed or 1;
end;

function u1.IsFullyAiming(p8) -- Line: 77
    local v9 = p8:Get("IsAiming") and (not p8.Info.AimScopePercent or p8.ViewModel.CurrentAimValue >= p8.Info.AimScopePercent);

    return v9;
end;

function u1.ChangeShootAnimationNamePrefix(p10, p11) -- Line: 81
    p10._shoot_animation_name_prefix = p11;
    p10._num_shooting_animations = #p10.ViewModel:GetAnimationKeys(p10._shoot_animation_name_prefix);
    p10._shoot_animation_num = p10._num_shooting_animations == 0 and 0 or math.clamp(p10._shoot_animation_num, 1, p10._num_shooting_animations);
end;

function u1.StartShooting(u12, p13, p14) -- Line: 87
    if tick() < (u12._is_revolver_quick_shooting or 0) and not p14 then
        return false;
    end;

    local v15 = u12:Get("Ammo");

    if not p13 then
        if tick() < u12._shoot_cooldown_no_ammo or u12:IsEquipping() then
            return false;
        end;

        if tick() < u12._reload_cooldown and (tick() < u12._reload_cancel_cooldown or (v15 <= 0 or tick() >= u12._reload_cancel_expiration)) then
            return false;
        end;

        if u12.Info.MaxAmmo and (v15 <= 0 and tick() > u12._reload_delay) then
            local v16 = { u12:StartReloading() };

            if v16[1] then
                return table.unpack(v16);
            end;

            u12._shoot_cooldown_no_ammo = tick() + math.max(0.1, u12.Info.ShootCooldown);
            u12:CreateSound("rbxassetid://13087319223", 1, 1, true, 5);

            return false;
        end;

        if tick() < u12._shoot_cooldown then
            if not (u12._is_input_queueing or (u12.Info.InputSpammingEnabled.StartShooting or u12._shoot_cooldown - tick() >= 0.1)) then
                u12._is_input_queueing = true;
                task.delay(u12._shoot_cooldown - tick(), function() -- Line: 114
                    -- upvalues: u12 (copy)
                    u12._is_input_queueing = false;
                    u12.ClientFighter:Input("StartShooting");
                end);
            end;

            return false;
        end;

        if u12.Name == "Minigun" and (u12.ViewModel.IsWindingMinigun or not u12.ViewModel.IsChargingMinigun) then
            task.defer(u12.ViewModel.StartChargingMinigun, u12.ViewModel);

            return false;
        end;
    end;

    if p14 then
        u12._is_revolver_quick_shooting = tick() + u12.Info.QuickShotCooldown * u12.Info.MaxAmmo;
    end;

    u12.ViewModel:StopAnimation("Equip");
    u12.ViewModel:StopAnimation("EquipEmpty");
    u12:_ResetReloadState();
    u12._burst_count = tick() - u12._last_shot >= u12.Info.ShootCooldown and 0 or u12._burst_count;
    u12._burst_count = u12._burst_count % u12.Info.BurstCount + 1;
    u12._last_shot = tick();
    local v17 = u12:IsFullyAiming();
    local v18 = v15 + (p13 and 1 or 0);
    local v19 = p14 and u12.Info.QuickShotCooldown or (u12._burst_count < u12.Info.BurstCount and u12.Info.BurstCooldown or u12.Info.ShootCooldown);
    u12._shoot_cooldown = tick() + v19;

    if u12._num_shooting_animations > 0 then
        local v20 = p14 and (u12.ViewModel.Info.Animations.FinalQuickShot and v18 == 1) and "FinalQuickShot" or (p14 and "QuickShot" or (u12.ViewModel.Info.Animations.FinalShoot and v18 == 1 and "FinalShoot" or (u12.ViewModel.Info.Animations.ShootAiming and v17 and "ShootAiming" or u12._shoot_animation_name_prefix .. u12._shoot_animation_num)));
        u12._shoot_animation_num = u12._num_shooting_animations == 0 and 0 or u12._shoot_animation_num % u12._num_shooting_animations + 1;

        if u12._last_shoot_animation_name then
            u12.ViewModel:StopAnimation(u12._last_shoot_animation_name);
        end;

        u12._last_shoot_animation_name = v20;
        u12.ViewModel:PlayAnimation(v20, v19, 0);
    end;

    local CameraData = u12.ClientFighter:GetCameraData();

    if u12._on_shoot_callback then
        u12._on_shoot_callback(CameraData);
    end;

    u12:_Recoil(v17 and 0.5 or 1);
    u12.ViewModel:MuzzleFlash();

    if v18 < (1 / 0) and v18 <= u12.Info.MaxAmmo * 0.25 then
        u12:CreateSound("rbxassetid://13087319223", 1, 1, true, 5);
    end;

    if u12.ClientFighter.IsLocalPlayer and (u12.Info.IsRaycast and not u12.Info.DisableTracerEffects) then
        u12:_LocalTracers(v17, p14);
    end;

    if u12.Info.AimScopePercent or u12.Name == "Shotgun" then
        task.defer(u12.Input, u12, "FinishAiming");
        u12.ToggleOffMobileInputButton:Fire("mobile_aim");
    end;

    u12._shot_but_ammo_hasnt_updated = true;
    u12.Shot:Fire();

    if u12.ClientFighter:Get("IsSpectating") then
        local _camera_displacement_spring = u12._camera_displacement_spring;
        local Vector2_new = Vector2.new;
        local v21 = math.random() - 0.5;
        _camera_displacement_spring.Value = Vector2_new(0.017453292519943295, math.sign(v21) * 0.017453292519943295) * (v17 and u12.Info.ShootCameraDisplacementRecoilWhileAiming or u12.Info.ShootCameraDisplacementRecoil);
        u12:_StartCameraDisplacementLoop();
    end;

    if not v17 then
        if p14 then
            v17 = false;
        else
            v17 = nil;
        end;
    end;

    return true, "StartShooting", CameraData, v17, p14;
end;

function u1.StartReloading(u22, p23, p24, p25, p26) -- Line: 199
    -- upvalues: AnimationLibrary (copy)
    local v27 = u22:Get("Ammo");
    local v28 = u22:Get("AmmoReserve");

    if u22._shot_but_ammo_hasnt_updated then
        v27 = math.max(0, v27 - 1);
    end;

    if not u22.Info.ReloadType then
        return false;
    end;

    if not (p23 or tick() >= u22._reload_cooldown and (not u22:IsEquipping() and (u22.ClientFighter:Get("InfiniteAmmoReserve") or (not v28 or v28 > 0)))) then
        return false;
    end;

    if u22.Info.MaxAmmo <= v27 then
        return false;
    end;

    task.defer(u22.Input, u22, "FinishAiming");
    u22.ToggleOffMobileInputButton:Fire("mobile_aim");
    u22.ViewModel:StopAnimation("Equip");
    u22.ViewModel:StopAnimation("EquipEmpty");

    if u22._last_shoot_animation_name then
        u22.ViewModel:StopAnimation(u22._last_shoot_animation_name, 0);
    end;

    u22._is_revolver_quick_shooting = nil;
    u22._shoot_animation_num = 1;
    u22:_ResetReloadState();

    if u22._on_reload_callback then
        u22._on_reload_callback();
    end;

    local v29 = v27 == 0;
    local v30 = p24 and u22:FromEnum(p24) or (v29 and u22.Info.NumEmptyReloadFiles > 0 and "EmptyReload" or "Reload");
    local v31 = u22:Get("NumReloadsSoFar") % u22.Info.NumReloadFiles + 1;
    local v32 = u22.Info.ReloadFiles[v30][v31];
    local u33 = p25 and u22:FromEnum(p25) or (v29 and u22.ViewModel.Animator:HasEmptyReloadAnimations() and "EmptyReload" or (v31 == 1 and "Reload" or ("Reload" .. v31 or "Reload")));

    if u22.Info.ReloadType == "Regular" then
        local Length = v32.Length;
        local ActionTimestamp = v32.ActionTimestamp;
        u22._reload_cooldown = tick() + Length;
        u22._reload_cancel_expiration = tick() + v32.ActionTimestamp;
        u22._reload_cancel_cooldown = tick() + (not v29 and 0.25 or Length);
        table.insert(u22._reload_threads, task.spawn(function() -- Line: 249
            -- upvalues: u22 (copy), ActionTimestamp (copy), Length (copy)
            u22:CooldownEffect("rbxassetid://17139961241", ActionTimestamp, "Reload", true);
            wait(ActionTimestamp);
            u22:CooldownEffect("rbxassetid://17156089790", Length - ActionTimestamp, "Reload");
        end));
        table.insert(u22._reload_threads, task.spawn(function() -- Line: 258
            -- upvalues: u22 (copy), u33 (copy), Length (copy)
            u22.ViewModel:PlayAnimation(u33, Length, u22.ViewModel.ShouldPlayReloadAnimationInstantly and 0 or 0.1);
        end));
    else
        if u22.Info.ReloadType ~= "Segmented" then
            return false;
        end;

        local StartLength = v32.StartLength;
        local StartActionTimestamp = v32.StartActionTimestamp;
        local SegmentLength = v32.SegmentLength;
        local SegmentActionTimestamp = v32.SegmentActionTimestamp;
        local FinishLength = v32.FinishLength;
        local FinishActionTimestamp = v32.FinishActionTimestamp;
        local u34;

        if p26 then
            u34 = utf8.codepoint(p26);
        else
            local v35 = (u22.ClientFighter:Get("InfiniteAmmoReserve") or not v28) and (1 / 0) or v28;
            u34 = math.min(v35, u22.Info.MaxAmmo - v27) - (StartActionTimestamp and 1 or 0) - (FinishActionTimestamp and 1 or 0);
        end;

        local v36 = StartActionTimestamp or StartLength + SegmentActionTimestamp;
        u22._reload_cooldown = tick() + (StartLength + SegmentLength * u34 + FinishLength);
        u22._reload_cancel_expiration = (1 / 0);

        if not v29 then
            v36 = tick() + 0.25;
        end;

        u22._reload_cancel_cooldown = v36;
        table.insert(u22._reload_threads, task.spawn(function() -- Line: 279
            -- upvalues: StartActionTimestamp (copy), u22 (copy), StartLength (copy), u34 (copy), SegmentActionTimestamp (copy), SegmentLength (copy), FinishActionTimestamp (copy)
            if StartActionTimestamp then
                u22:CooldownEffect("rbxassetid://17139961241", StartActionTimestamp, "Reload", true);
            end;

            wait(StartLength);

            for i = 1, u34 do
                u22:CooldownEffect("rbxassetid://17139961241", SegmentActionTimestamp, "Reload", true);
                wait(SegmentLength);
                local _ = i;
            end;

            if FinishActionTimestamp then
                u22:CooldownEffect("rbxassetid://17139961241", FinishActionTimestamp, "Reload", true);
            end;
        end));
        table.insert(u22._reload_threads, task.spawn(function() -- Line: 298
            -- upvalues: AnimationLibrary (ref), u22 (copy), u33 (copy), u34 (copy)
            local Length = AnimationLibrary.Info[u22.ViewModel.Info.Animations[u33 .. "Start"]].Length;
            local Length2 = AnimationLibrary.Info[u22.ViewModel.Info.Animations[u33 .. "Segment"]].Length;
            local Length3 = AnimationLibrary.Info[u22.ViewModel.Info.Animations[u33 .. "Finish"]].Length;
            u22.ViewModel:PlayAnimation(u33 .. "Start", Length, u22.ViewModel.ShouldPlayReloadAnimationInstantly and 0 or 0.1);
            wait(Length);

            for i = 1, u34 do
                u22.ViewModel:PlayAnimation(u33 .. "Segment", Length2, 0);
                wait(Length2);
                local _ = i;
            end;

            if u22.ViewModel.Info.Animations[u33 .. "SegmentFinal"] then
                u22.ViewModel:PlayAnimation(u33 .. "SegmentFinal", Length2, 0);
                wait(AnimationLibrary.Info[u22.ViewModel.Info.Animations[u33 .. "SegmentFinal"]].Length);
            end;

            u22.ViewModel:PlayAnimation(u33 .. "Finish", Length3, 0);
        end));
    end;

    return true, "StartReloading", u22:ToEnum(v30), u22:ToEnum(u33);
end;

function u1.StartAiming(p37, p38) -- Line: 328
    if not p38 and (p37:Get("IsAiming") or (tick() < p37._reload_cooldown or p37:IsEquipping())) then
        return false;
    end;

    p37:SetReplicate("IsAiming", true);
    p37.StopSprinting:Fire();
    p37.ViewModel:SetAiming(true);
    p37:SetReplicate("FOVOffset", p37.Info.AimFOVOffset);
    p37:_StartAimAssist();

    if p37.ClientFighter:Get("IsSpectating") then
        p37:CreateSound("rbxassetid://13949557885", 1, 1, true, 5);

        if p37.ViewModel.PlayAimSound then
            p37.ViewModel:PlayAimSound(true);
        end;
    end;

    if p37.Info.AimScopePercent then
        p37.ViewModel:StopAnimation(p37.ViewModel.Animator:GetInspectAnimationKey());
        p37.ViewModel:StopAnimation(p37.ViewModel.Animator:GetRareInspectAnimationKey());
    end;

    return true, "StartAiming";
end;

function u1.FinishAiming(p39, p40) -- Line: 356
    if not p39:Get("IsAiming") then
        return false;
    end;

    p39:_FinishAiming();
    p39.AttemptToSprintAgain:Fire();

    if p39.ClientFighter:Get("IsSpectating") then
        p39:CreateSound("rbxassetid://13949557844", 1, 1, true, 5);

        if p39.ViewModel.PlayAimSound then
            p39.ViewModel:PlayAimSound(false);
        end;
    end;

    return true, "FinishAiming";
end;

function u1.StartSprinting(p41, p42) -- Line: 375
    p41:SimulateInputFromGameplayMechanic("FinishAiming", true);

    return false;
end;

function u1.Equip(p43, ...) -- Line: 381
    -- upvalues: ClientItem (copy)
    ClientItem.Equip(p43, ...);
    p43._is_revolver_quick_shooting = nil;
    p43._shoot_cooldown = p43._shoot_cooldown and p43._shoot_cooldown >= (1 / 0) and 0 or p43._shoot_cooldown;
    p43:_ResetReloadState();
end;

function u1.Unequip(p44, ...) -- Line: 389
    -- upvalues: ClientItem (copy)
    p44._is_revolver_quick_shooting = nil;
    p44._shoot_cooldown = p44._shoot_cooldown and p44._shoot_cooldown >= (1 / 0) and 0 or p44._shoot_cooldown;
    p44:_ResetReloadState();
    p44:_FinishAiming();
    ClientItem.Unequip(p44, ...);
end;

function u1.Update(p45, ...) -- Line: 398
    -- upvalues: ClientItem (copy)
    ClientItem.Update(p45, ...);

    if p45.ItemInterface then
        local AimScopePercent = p45.Info.AimScopePercent;

        if AimScopePercent then
            if p45.ViewModel.CurrentAimValue >= p45.Info.AimScopePercent then
                AimScopePercent = p45.ClientFighter:IsActuallyFirstPerson();
            else
                AimScopePercent = false;
            end;
        end;

        if not p45.ItemInterface:IsScopeActive() and AimScopePercent then
            p45.ItemInterface:SetScopeActive(true);

            return;
        end;

        if p45.ItemInterface:IsScopeActive() and not AimScopePercent then
            p45.ItemInterface:SetScopeActive(false);
        end;
    end;
end;

function u1.ReplicateFromServer(p46, p47, ...) -- Line: 413
    -- upvalues: ClientItem (copy)
    if p47 == "ShootEffect" then
        if not p46:IsRendered() then
            return;
        end;

        p46:_ShootEffect(...);

        return;
    end;

    if p47 == "ProjectileEffect" then
        if not p46:IsRendered() then
            return;
        end;

        p46:_ProjectileEffect(...);

        return;
    end;

    if p47 ~= "ResetReloadState" then
        ClientItem.ReplicateFromServer(p46, p47, ...);

        return;
    end;

    if not p46:IsRendered() then
        return;
    end;

    p46:_ResetReloadState();
end;

function u1.Destroy(p48) -- Line: 437
    -- upvalues: ClientItem (copy)
    p48.Shot:Destroy();
    p48.ProjectileShot:Destroy();
    p48:_ResetReloadState();
    p48:_FinishAiming();

    for _, v in pairs(p48._projectile_part_to_model) do
        v:Destroy();
    end;

    ClientItem.Destroy(p48);
end;

function u1._StartCameraDisplacementLoop(u49) -- Line: 455
    -- upvalues: RunService (copy), CameraController (copy)
    if u49._camera_displacement_loop_active or u49._camera_displacement_spring.Value.Magnitude < 0.001 then
        return;
    end;

    task.spawn(function() -- Line: 460
        -- upvalues: u49 (copy), RunService (ref), CameraController (ref)
        u49._camera_displacement_loop_active = true;

        while true do
            local v50 = RunService.RenderStepped:Wait();

            if u49._destroyed or (u49._camera_displacement_spring.Value.Magnitude < 0.001 or not u49.ClientFighter:Get("IsSpectating")) then
                break;
            end;

            CameraController:ApplyRotationDelta(u49._camera_displacement_spring.Value * v50, true);
        end;

        u49._camera_displacement_loop_active = false;
    end);
end;

function u1._FinishAiming(p51) -- Line: 477
    p51:SetReplicate("IsAiming", false);
    p51.ViewModel:SetAiming(false);
    p51:SetReplicate("FOVOffset", 0);
    p51:_FinishAimAssist();
end;

function u1._ProjectileEffect(u52, u53, u54) -- Line: 484
    -- upvalues: Projectiles (copy), BetterDebris (copy), WrapController (copy), Spring (copy), RunService (copy), PlayerDataController (copy), Utility (copy)
    if not u53 then
        return;
    end;

    u53.Transparency = 1;

    local function get_setting(p55) -- Line: 491
        -- upvalues: u54 (copy), u52 (copy)
        if u54 and u54[p55] ~= nil then
            return u54[p55];
        end;

        return u52.Info[p55];
    end;

    local v56;

    if u54 then
        v56 = u54.ProjectileNameOverride;
    else
        v56 = u54;
    end;

    local v57 = (v56 and Projectiles:FindFirstChild(v56) or (Projectiles:FindFirstChild(u52.ViewModel.Name) or Projectiles[u52.Name])):Clone();
    v57.Parent = workspace;
    u52._projectile_part_to_model[u53] = v57;
    BetterDebris:AddItem(v57, 60);
    WrapController:ApplyWrap(WrapController:RecordOriginalWrapProperties(v57), u52:GetWrap(), true);
    u53.Destroying:Connect(function() -- Line: 503
        -- upvalues: u52 (copy), u53 (copy)
        u52._projectile_part_to_model[u53] = nil;
    end);

    for _, child in pairs(v57:GetChildren()) do
        child.CanCollide = false;
        child.CanTouch = false;
        child.CanQuery = false;
        child.Massless = true;
        child.Anchored = true;
    end;

    u52.ProjectileShot:Fire(u53, v57);
    local v58;

    if u54 and u54.ProjectileLogicOptimized ~= nil then
        v58 = u54.ProjectileLogicOptimized;
    else
        v58 = u52.Info.ProjectileLogicOptimized;
    end;

    if v58 then
        local CFrame_Angles_ret = CFrame.Angles(math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2);
        local v59 = Spring.new(u53.Position, 1, 100);

        while not u52._destroyed and u53:IsDescendantOf(workspace) do
            v59.Target = u53.Position;
            v57:PivotTo(CFrame.new(v59.Value) * u53.CFrame.Rotation * CFrame_Angles_ret);
            RunService.RenderStepped:Wait();
        end;

        v57:Destroy();

        return;
    end;

    local v60 = 0.5;

    for _, descendant in pairs(v57:GetDescendants()) do
        if descendant:IsA("Trail") then
            v60 = math.max(v60, descendant.Lifetime);
        elseif descendant:IsA("ParticleEmitter") then
            v60 = math.max(v60, descendant.Lifetime.Max);
        end;
    end;

    local v61;

    if u54 and u54.ProjectileVisualSpinEnabled ~= nil then
        v61 = u54.ProjectileVisualSpinEnabled;
    else
        v61 = u52.Info.ProjectileVisualSpinEnabled;
    end;

    local v62;

    if u54 and u54.ProjectileType ~= nil then
        v62 = u54.ProjectileType;
    else
        v62 = u52.Info.ProjectileType;
    end;

    local v63;

    if v62 then
        local v64;

        if u54 and u54.ProjectileType ~= nil then
            v64 = u54.ProjectileType;
        else
            v64 = u52.Info.ProjectileType;
        end;

        if v64 == "RaycastProjectile" then
            v63 = u52.ClientFighter:IsActuallyFirstPerson() and PlayerDataController:GetSetting("Projectile Smoothing");
        else
            v63 = false;
            local v65;

            if u54 and u54.ProjectileType ~= nil then
                v65 = u54.ProjectileType;
            else
                v65 = u52.Info.ProjectileType;
            end;

            if v65 == "PhysicalProjectile" then
                local v66;

                if u54 and u54.ProjectilePhysicalClientSided ~= nil then
                    v66 = u54.ProjectilePhysicalClientSided;
                else
                    v66 = u52.Info.ProjectilePhysicalClientSided;
                end;

                v63 = not v66 and (u52.ClientFighter:IsActuallyFirstPerson() and PlayerDataController:GetSetting("Projectile Smoothing"));
            end;
        end;
    else
        v63 = u52.ClientFighter:IsActuallyFirstPerson() and PlayerDataController:GetSetting("Projectile Smoothing");
    end;

    local v67 = Spring.new(u53.Position + (v63 and (-u53.Velocity.Unit * 200 or Vector3.new(0, 0, 0)) or Vector3.new(0, 0, 0)), 1, 40);
    local CFrame_Angles_ret = CFrame.Angles(0, 0, math.random() * 3.141592653589793 * 2);
    local v68 = tick();
    local v69 = tick() + v60;
    local v70 = Vector3.new(0, 0, 0);
    local v71 = 0;
    local v72 = false;
    local v73 = Vector3.new(0, 0, 0);
    local v74 = 0;

    while not u52._destroyed and tick() < v69 do
        if u53:IsDescendantOf(workspace) then
            v69 = tick() + v60;
            v67.Target = u53.Position;
        else
            v67.Target = v67.Target + v70 * v71;

            if not v72 then
                v72 = true;

                for _, descendant in pairs(v57:GetDescendants()) do
                    if descendant:IsA("BasePart") or (descendant:IsA("Texture") or descendant:IsA("Decal")) then
                        descendant.LocalTransparencyModifier = 1;
                    elseif descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    elseif descendant:IsA("Light") then
                        local Brightness = descendant.Brightness;
                        task.spawn(Utility.RenderstepForLoop, Utility, 0, 100, 1, function(p75) -- Line: 582
                            -- upvalues: descendant (copy), Brightness (copy)
                            descendant.Brightness = Brightness * (1 - p75 / 100);
                        end);
                    end;
                end;
            end;
        end;

        v74 = v74 + u53.Velocity.Magnitude * v71 * 0.25;
        local v76 = tick() - v68;
        v67.Speed = math.clamp(v76, 0.01, 1) * 60 + 40;

        if u53.Velocity.Magnitude > 0.01 then
            v73 = u53.Velocity or v73;
        end;

        local v77;

        if v61 then
            v77 = CFrame.Angles(-v74, 0, 0);
        else
            v77 = CFrame.identity;
        end;

        if v73.Magnitude > 0.01 and u52.Name ~= "Flare Gun" then
            v57:PivotTo(CFrame.new(v67.Position, v67.Position + v73) * CFrame_Angles_ret * v77);
        else
            v57:PivotTo(CFrame.new(v67.Position) * CFrame_Angles_ret * u53.CFrame.Rotation * v77);
        end;

        v70 = v73.Magnitude > v70.Magnitude and v73 and v73 or v70;
        v71 = RunService.RenderStepped:Wait();
    end;

    v57:SetAttribute("Destroying", true);
    BetterDebris:AddItem(v57, v60);
end;

function u1._ResetReloadState(p78) -- Line: 612
    p78._reload_cooldown = 0;

    for _, v in pairs(p78._reload_threads) do
        pcall(task.cancel, v);
    end;

    p78:StopCooldownEffect("Reload");
    p78.ViewModel:StopAnimation("Reload");
    p78.ViewModel:StopAnimation("EmptyReload");
    p78.ViewModel:StopAnimation("ReloadStart");
    p78.ViewModel:StopAnimation("ReloadSegment");
    p78.ViewModel:StopAnimation("ReloadFinish");
    p78.ViewModel:StopAnimation("EmptyReloadStart");
    p78.ViewModel:StopAnimation("EmptyReloadSegment");
    p78.ViewModel:StopAnimation("EmptyReloadFinish");

    for i = 2, p78.Info.NumReloadFiles do
        p78.ViewModel:StopAnimation("Reload" .. i);
        local _ = i;
    end;
end;

function u1._LocalTracers(u79, p80, p81) -- Line: 635
    -- upvalues: GameplayUtility (copy), CONSTANTS (copy)
    local EntityLookupParams = u79.ClientFighter:GetEntityLookupParams();
    local v82 = u79.ClientFighter:Get("EnvironmentID");
    local v83 = u79.ClientFighter:IsCrouching();
    local RaycastWhitelist = u79.ClientFighter:GetRaycastWhitelist(true);
    local u84 = {};

    for i = 1, u79.Info.ShootPellets do
        local Spread = GameplayUtility:GetSpread((p81 and u79.Info.QuickShotSpread or u79.Info.ShootSpread) + math.min(u79.Info.ShootSpreadPerVelocityLimit, u79.ClientFighter.Entity.RootPart.Velocity.Magnitude * u79.Info.ShootSpreadPerVelocityUnit), u79.Info.AimSpreadMultiplier, p80, v83, i, u79.Info.ShootPellets, u79.Info.ShootSpreadConsistent);
        local CameraData = u79.ClientFighter:GetCameraData(RaycastWhitelist, Spread, true);
        local v85 = CameraData[utf8.char(0)];
        local v86 = CameraData[utf8.char(1)];
        local v87 = CameraData[utf8.char(2)];
        local v88 = CameraData[utf8.char(3)];
        local v89 = v87 and (v87.CFrame * v88).Position or (v86 * Spread * CFrame.new(0, 0, -CONSTANTS.MAX_RAYCAST_DISTANCE)).Position;
        local Position = v85.Position;
        local Unit = (v89 - Position).Unit;
        local _ = i;

        for i2 = 0, u79.Info.RaycastBounceCount do
            if Unit ~= Unit then
                table.insert(u84, {
                    Position = Position + Unit * CONSTANTS.MAX_RAYCAST_DISTANCE
                });
                break;
            end;

            local _, v90 = GameplayUtility:GetEntitiesFromRaycast(v82, EntityLookupParams, Position, Unit, CONSTANTS.MAX_RAYCAST_DISTANCE, u79.Info.RaycastPierceCount);
            local v91 = {
                Position = v90.Position
            };

            if i2 > 0 then
                v91.LastRaycastResult = u84[#u84];
                v91.StartPosition = v91.LastRaycastResult.Position;
            end;

            table.insert(u84, v91);

            if not v90.Normal then
                break;
            end;

            Position = v90.Position;
            Unit = GameplayUtility:GetRaycastRedirection(v82, EntityLookupParams, Unit - 2 * Unit:Dot(v90.Normal) * v90.Normal, Position, u79.Info.RaycastBounceRedirectionAngle);
            local _ = i2;
        end;
    end;

    table.insert(u79._local_tracers, u84);
    task.delay(1, function() -- Line: 691
        -- upvalues: u79 (copy), u84 (copy)
        local table_find_ret = table.find(u79._local_tracers, u84);

        if table_find_ret then
            table.remove(u79._local_tracers, table_find_ret);
        end;
    end);
    u79:_Tracers({
        IsEnemy = false,
        IsLocal = true,
        RaycastResults = u84
    });
end;

function u1._CorrectLocalTracers(p92, p93) -- Line: 709
    local table_remove_ret = table.remove(p92._local_tracers, 1);

    if not table_remove_ret then
        return;
    end;

    for i, v in pairs(p93) do
        local v94 = i;

        for i2, v2 in pairs(v) do
            table_remove_ret[v94][i2] = v2;
        end;

        table_remove_ret[v94].StartPosition = table_remove_ret[v94].CurrentTracerPosition;
    end;
end;

function u1._Tracers(p95, p96, p97) -- Line: 726
    -- upvalues: TracerEffect (copy)
    local v98 = {};
    local v99 = p95.ViewModel.GetFriendlyTracerColor and p95.ViewModel:GetFriendlyTracerColor();
    v98.FriendlyTracerColor = v99;
    v98.ActuallyFirstPerson = p95.ClientFighter:IsActuallyFirstPerson();
    v98.MuzzlePosition = p95.ViewModel:GetMuzzlePosition();
    local v100, v101, v102 = TracerEffect:VerifyTracerData(p96, p97, v98);

    if p95.ViewModel.CustomTracers then
        return p95.ViewModel:CustomTracers(v100, v101, v102);
    end;

    TracerEffect:Play(v100, v101, v102);
end;

function u1._ShootEffect(p103, p104) -- Line: 742
    -- upvalues: Players (copy)
    local v105 = {};

    for i, v in pairs(p104) do
        v105[utf8.codepoint(i) + 1] = {
            Position = v[utf8.char(0)] or nil,
            Instance = v[utf8.char(1)] or nil,
            Normal = v[utf8.char(2)] or nil,
            LastRaycastIndex = v[utf8.char(3)] and utf8.codepoint(v[utf8.char(3)]) + 1 or nil
        };
    end;

    for _, v in pairs(v105) do
        local v106;

        if v.LastRaycastIndex then
            v106 = v105[v.LastRaycastIndex] or nil;
        else
            v106 = nil;
        end;

        v.LastRaycastResult = v106;
        v.LastRaycastIndex = nil;
        local v107;

        if v.LastRaycastResult then
            v107 = v.LastRaycastResult.Position or nil;
        else
            v107 = nil;
        end;

        v.StartPosition = v107;
    end;

    if not p103.ClientFighter.IsLocalPlayer or #p103._local_tracers <= 0 then
        p103:_Tracers({
            RaycastResults = v105,
            IsEnemy = Players.LocalPlayer:GetAttribute("TeamID") ~= p103.ClientFighter.Player:GetAttribute("TeamID"),
            IsLocal = p103.ClientFighter.IsLocalPlayer
        });
    end;

    p103:_ImpactMarkers(v105);
end;

function u1._CheckReload(p108) -- Line: 775
    if p108:Get("Ammo") <= 0 then
        if p108.Name == "Daggers" then
            p108._reload_delay = tick() + 0.2;
            wait(0.2);
        end;

        p108:SimulateInputFromGameplayMechanic("StartReloading");
    end;
end;

function u1._Init(u109) -- Line: 786
    u109:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 787
        -- upvalues: u109 (copy)
        u109._shot_but_ammo_hasnt_updated = false;
        u109:_CheckReload();
    end);
    u109:GetDataChangedSignal("AmmoReserve"):Connect(function() -- Line: 792
        -- upvalues: u109 (copy)
        u109:_CheckReload();
    end);
    u109.ViewModel.AnimationPlayed:Connect(function(p110) -- Line: 796
        -- upvalues: u109 (copy)
        if (p110 == u109.ViewModel.Animator:GetInspectAnimationKey() or p110 == u109.ViewModel.Animator:GetRareInspectAnimationKey()) and u109._last_shoot_animation_name then
            u109.ViewModel:StopAnimation(u109._last_shoot_animation_name, 0);
        end;
    end);
    table.insert(u109._connections, u109.ClientFighter.Interrupted:Connect(function() -- Line: 804
        -- upvalues: u109 (copy)
        u109:_ResetReloadState();
        u109:SimulateInputFromGameplayMechanic("FinishAiming", true);
    end));
    u109:ChangeShootAnimationNamePrefix("Shoot");
end;

return u1;