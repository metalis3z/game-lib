-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("ContentProvider");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local ReplicatedClass = require(ReplicatedStorage.Modules.ReplicatedClass);
local SoundLibrary = require(ReplicatedStorage.Modules.SoundLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Spring = require(ReplicatedStorage.Modules.Spring);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local WrapController = require(Players.LocalPlayer.PlayerScripts.Controllers.WrapController);
local Charm = require(Players.LocalPlayer.PlayerScripts.Modules.Charm);
local ViewModelAnimator = require(script:WaitForChild("ViewModelAnimator"));
local ViewModels = workspace:WaitForChild("ViewModels");
local FirstPerson = ViewModels:WaitForChild("FirstPerson");
local ViewModels2 = ReplicatedStorage.Assets:WaitForChild("Temp"):WaitForChild("ViewModels");
local ScopeGlareGui1 = Players.LocalPlayer.PlayerScripts.UserInterface.ScopeGlareGui1;
local ScopeGlareGui2 = Players.LocalPlayer.PlayerScripts.UserInterface.ScopeGlareGui2;
local MuzzleFlashes = Players.LocalPlayer.PlayerScripts.Assets.Misc.MuzzleFlashes;
local ViewModelRoot = Players.LocalPlayer.PlayerScripts.Assets.Misc.ViewModelRoot;
local ViewModels3 = Players.LocalPlayer.PlayerScripts.Assets.ViewModels;
local Charms = Players.LocalPlayer.PlayerScripts.Modules.Charms;
local Color3_fromRGB_ret = Color3.fromRGB(0, 0, 0);
local u1 = { Vector3.new(0.5, 0.5, 0.5), Vector3.new(-0.5, 0.5, 0.5), Vector3.new(-0.5, 0.5, -0.5), Vector3.new(0.5, 0.5, -0.5), Vector3.new(0.5, -0.5, 0.5), Vector3.new(-0.5, -0.5, 0.5), Vector3.new(-0.5, -0.5, -0.5), Vector3.new(0.5, -0.5, -0.5) };
local u2 = setmetatable({}, ReplicatedClass);
u2.__index = u2;

function u2.new(p3, p4) -- Line: 50
    -- upvalues: ReplicatedClass (copy), u2 (copy), Signal (copy), ItemLibrary (copy), ViewModelRoot (copy), Utility (copy), ViewModels3 (copy), ViewModelAnimator (copy), Spring (copy)
    local v5 = ReplicatedClass.new(p3);
    local v6 = setmetatable(v5, u2);
    v6.AnimationPlayed = Signal.new();
    v6.AnimationStopped = Signal.new();
    v6.Equipped = Signal.new();
    v6.Unequipped = Signal.new();
    v6.ClientItem = p4;
    v6.Name = v6:Get("Name");
    v6.Info = ItemLibrary.ViewModels[v6.Name];
    v6.Model = ViewModelRoot:Clone();
    v6.ItemModel = Utility:LookThrough(ViewModels3, v6.Name):Clone();
    v6.Animator = ViewModelAnimator.new(v6);
    v6.Charm = nil;
    v6.ShouldPlayReloadAnimationInstantly = nil;
    v6.RightArmIKControlDisabled = nil;
    v6.LeftArmIKControlDisabled = nil;
    v6.CurrentBobbingValue = Vector2.zero;
    v6.CurrentRecoilValue = Vector3.new(0, 0, 0);
    v6.CurrentSwayValue = Vector2.zero;
    v6.CurrentJumpValue = 0;
    v6.CurrentAimValue = 0;
    v6.CurrentInspectValue = 0;
    v6.CurrentLandingValue = 0;
    v6._serial = p3;
    v6._destroyed = false;
    v6._connections = {};
    v6._preloaded_sounds = {};
    v6._last_hitmarker_sounds = {};
    v6._left_arm = v6.Model.LeftArm;
    v6._left_arm_shirt_texture = v6._left_arm.ShirtTexture;
    v6._right_arm = v6.Model.RightArm;
    v6._right_arm_shirt_texture = v6._right_arm.ShirtTexture;
    v6._shirt_id = nil;
    v6._left_arm_color = nil;
    v6._right_arm_color = nil;
    v6._body_model = nil;
    v6._original_scale = v6.ItemModel:GetScale();
    v6._equip_spring = Spring.new(0, 0.625, 12.5);
    v6._aim_spring = Spring.new(0, 1, 30);
    v6._crouching_spring = Spring.new(0, 0.875, 17.5);
    v6._sliding_spring = Spring.new(0, 0.5, 12.5);
    v6._sprinting_spring = Spring.new(0, 0.75, v6.Info.PlayAnimationsInstantly and 100 or 15);
    v6._bobbing_speed_spring = Spring.new(0, 1, 20);
    v6._bobbing_value_spring = Spring.new(Vector2.zero, 0.5, 12.5);
    v6._sway_spring = Spring.new(Vector2.zero, 0.5, 12.5);
    v6._landing_spring = Spring.new(0, 0.75, 10);
    v6._jump_spring = Spring.new(0, 0.5, 15);
    v6._tilt_spring = Spring.new(Vector2.zero, 0.5, 15);
    v6._recoil_spring = Spring.new(Vector3.new(0, 0, 0), 0.875, 100);
    v6._unrecoil_spring = Spring.new(Vector3.new(0, 0, 0), 0.375, 25);
    v6._head_raycast_spring = Spring.new(0, 1, 50);
    v6._raycast_tilt_spring = Spring.new(0, 1, 50);
    v6._impulse_position_spring = Spring.new(Vector3.new(0, 0, 0), 0.25, 20);
    v6._inspect_spring = Spring.new(0, 1, 20);
    v6._instant_set_inspect_spring = true;
    v6._render_cooldown = 0;
    v6._is_equipped = false;
    v6._root_part_offset_inverse = v6.Info.RootPartOffset:Inverse();
    v6._root_part_offset_override = nil;
    v6._root_part_offset_override_inverse = nil;
    v6._custom_sprinting_enabled = 0;
    v6._bobbing_tick = 0;
    v6._aim_position_attachment = nil;
    v6._aim_lookat_attachment = nil;
    v6._center_attachment = nil;
    v6._muzzle_attachments = {};
    v6._charm_attachment_model = nil;
    v6._charm_pivot_attachment = nil;
    v6._charm_sub_model = nil;
    v6._scope_glare_attachment = nil;
    v6._scope_glare_gui1 = nil;
    v6._scope_glare_gui2 = nil;
    v6._was_first_person = nil;
    v6._local_transparency_modifiers = {};
    v6._local_transparency_modifier_update = {};
    v6._hidden_submodels = {};
    v6._animation_context_submodels = {};
    v6._arm_submodels = {};
    v6._original_wrap_properties = nil;
    v6._original_object_transparencies = {};
    v6._right_arm_wrapped_part = nil;
    v6._left_arm_wrapped_part = nil;
    v6._wrapped_only_objects = {};
    v6._can_wrap_left_arm = false;
    v6._can_wrap_right_arm = false;
    v6._submodels_behind_head_values = {};
    v6._submodel_boundingbox_attachments = {};
    v6:_Init();

    return v6;
end;

function u2.GetCameraOffset(p7) -- Line: 159
    -- upvalues: Utility (copy)
    if Utility:AngleBetweenVectors(p7.Model.Camera.CFrame.LookVector, p7.Model.HumanoidRootPart.CFrame.LookVector) > 1.5707963267948966 then
        return CFrame.identity;
    end;

    return p7.Model.HumanoidRootPart.CFrame:ToObjectSpace(p7.Model.Camera.CFrame);
end;

function u2.GetImage(p8) -- Line: 168
    return p8.Info.Image;
end;

function u2.IsEquipped(p9) -- Line: 172
    return p9._is_equipped;
end;

function u2.IsRenderingDisabled(p10) -- Line: 176
    local v11;

    if tick() < p10._render_cooldown then
        v11 = true;
    else
        v11 = p10.Animator:IsRenderingDisabled() or (p10.ClientItem.ClientFighter:Get("IsHiddenByEmotes") or p10.ClientItem.ClientFighter:Get("IsHiddenByCutscene")) or p10.ClientItem.ClientFighter.Entity and p10.ClientItem.ClientFighter.Entity:IsEmoting();
    end;

    return v11;
end;

function u2.IsAimingAnimationEnabled(p12) -- Line: 184
    -- upvalues: PlayerDataController (copy)
    local v13 = p12._aim_position_attachment and p12._aim_lookat_attachment and (p12.ClientItem.Info.AimScopePercent or PlayerDataController:GetSetting("ViewModel Aiming"));

    return v13;
end;

function u2.AreAnimationsPlaying(p14, ...) -- Line: 188
    return p14.Animator:AreAnimationsPlaying(...);
end;

function u2.IsAnimationPlaying(p15, ...) -- Line: 192
    return p15.Animator:IsAnimationPlaying(...);
end;

function u2.GetAnimationTrack(p16, ...) -- Line: 196
    return p16.Animator:GetAnimationTrack(...);
end;

function u2.GetAnimationKeys(p17, ...) -- Line: 200
    return p17.Animator:GetAnimationKeys(...);
end;

function u2.Inspect(p18, ...) -- Line: 204
    return p18.Animator:Inspect(...);
end;

function u2.StopInspecting(p19, ...) -- Line: 208
    return p19.Animator:StopInspecting(...);
end;

function u2.PlayAnimation(p20, ...) -- Line: 212
    return p20.Animator:PlayAnimation(...);
end;

function u2.StopAnimation(p21, ...) -- Line: 216
    return p21.Animator:StopAnimation(...);
end;

function u2.ChangeEquipAnimation(p22, ...) -- Line: 220
    return p22.Animator:ChangeEquipAnimation(...);
end;

function u2.ChangeIdleAnimation(p23, ...) -- Line: 224
    return p23.Animator:ChangeIdleAnimation(...);
end;

function u2.ChangeSprintAnimation(p24, ...) -- Line: 228
    return p24.Animator:ChangeSprintAnimation(...);
end;

function u2.ChangeInspectAnimation(p25, ...) -- Line: 232
    return p25.Animator:ChangeInspectAnimation(...);
end;

function u2.GetMuzzlePosition(p26) -- Line: 236
    local v27;

    if p26:IsRenderingDisabled() then
        v27 = p26:_GetDefaultMuzzlePosition();
    else
        v27 = nil;
    end;

    if v27 or #p26._muzzle_attachments <= 0 then
        if v27 or not (p26._body_model and p26._body_model.PrimaryPart) then
            return v27 or p26:_GetDefaultMuzzlePosition();
        end;

        return p26._body_model.PrimaryPart.Position;
    end;

    local v28 = Vector3.new(0, 0, 0);

    for _, v in pairs(p26._muzzle_attachments) do
        v28 = v28 + v.WorldPosition;
    end;

    return v28 / #p26._muzzle_attachments;
end;

function u2.GetMuzzleAttachment(p29) -- Line: 260
    return p29._muzzle_attachments[1];
end;

function u2.GetWrap(p30) -- Line: 264
    -- upvalues: PlayerDataController (copy)
    local v31 = (p30.ClientItem.ClientFighter:Get("IsSpectating") or not PlayerDataController:GetSetting("Wraps Disabled")) and p30:Get("Wrap");

    return v31;
end;

function u2.SetParent(p32, p33) -- Line: 268
    p32.Model.Parent = p33;
    p32.Animator:LoadAnimations();
end;

function u2.SetArmsData(p34, p35, p36, p37) -- Line: 274
    -- upvalues: Color3_fromRGB_ret (copy)
    local v38 = not p35 or typeof(p35) == "string";
    local v39 = "Argument 1 invalid, expected a string or nil, got " .. tostring(p35);
    assert(v38, v39);
    p34._shirt_id = p35 or "";
    p34._left_arm_color = p36 or Color3_fromRGB_ret;
    p34._right_arm_color = p37 or Color3_fromRGB_ret;
    p34:_UpdateArms();
end;

function u2.SetAiming(p40, p41) -- Line: 284
    local v42 = typeof(p41) == "boolean";
    assert(v42, "Argument 1 invalid, expected a boolean");
    p40._aim_spring.Target = p41 and 1 or 0;
    p40._aim_spring.Speed = 30 * (p41 and (p40.ClientItem.Info.AimSpeed or 1) or 1);

    if p41 then
        p40:StopInspecting();
    end;
end;

function u2.SetCustomSprintingEnabled(p43, p44, p45) -- Line: 295
    if p44 then
        p43._custom_sprinting_enabled = tick() + p44;
    end;

    if p45 then
        p43._sprinting_spring.Value = 0;
    end;
end;

function u2.SetCFrame(p46, p47) -- Line: 306
    p46.Model.PrimaryPart.CFrame = p47;
end;

function u2.CreateSound(p48, ...) -- Line: 310
    return p48.ClientItem:CreateSound(...);
end;

function u2.CreateSpectatorSound(p49, ...) -- Line: 314
    return p49.ClientItem:CreateSpectatorSound(...);
end;

function u2.OverrideRootPartOffset(p50, p51) -- Line: 318
    p50._root_part_offset_override = p51;
    local v52 = p50._root_part_offset_override_inverse and p50._root_part_offset_override:Inverse();
    p50._root_part_offset_override_inverse = v52;
end;

function u2.HideSubModel(u53, u54, p55) -- Line: 323
    u53._hidden_submodels[u54] = (u53._hidden_submodels[u54] or 0) + 1;
    u53:_UpdateSubModelVisibility();
    local u56 = u53._hidden_submodels[u54];

    local function callback() -- Line: 329
        -- upvalues: u53 (copy), u54 (copy), u56 (copy)
        if u53._hidden_submodels[u54] ~= u56 then
            return;
        end;

        u53._hidden_submodels[u54] = false;
        u53:_UpdateSubModelVisibility();
    end;

    if p55 > 0 then
        if p55 < (1 / 0) then
            task.delay(p55, callback);
        end;
    else
        task.spawn(callback);
    end;
end;

function u2.Impulse(p57, p58, p59, p60, p61) -- Line: 347
    p57._impulse_position_spring.Position = p61 and p57._impulse_position_spring.Target or p57._impulse_position_spring.Position;
    p57._impulse_position_spring.Velocity = p58;
    p57._impulse_position_spring.Damper = p59 or p57._impulse_position_spring.Damper;
    p57._impulse_position_spring.Speed = p60 or p57._impulse_position_spring.Speed;
end;

function u2.ApplyRecoil(p62, p63) -- Line: 354
    local v64 = typeof(p63) == "Vector3";
    assert(v64, "Argument 1 invalid, expected a Vector3");
    local _recoil_spring = p62._recoil_spring;
    _recoil_spring.Target = _recoil_spring.Target + p63;
    local _unrecoil_spring = p62._unrecoil_spring;
    _unrecoil_spring.Target = _unrecoil_spring.Target + p63;
end;

function u2.Equip(p65, p66) -- Line: 361
    -- upvalues: SoundLibrary (copy)
    p65._is_equipped = true;
    p65.Equipped:Fire(p66);
    p65._instant_set_inspect_spring = true;
    p65._render_cooldown = tick() + 0.1;
    p65.Animator:SetInspectCooldown(0);
    p65.Animator:PlayIdleAnimation();
    p65:CreateSound(SoundLibrary.EquipSounds[math.random(#SoundLibrary.EquipSounds)], p66 and 0.25 or 0.5, 0.9 + 0.2 * math.random(), true, 5);

    if p66 then
        p65._equip_spring.Value = 0.5;

        return;
    end;

    if not p65.Animator:PlayEquipAnimation() then
        p65._equip_spring.Value = 1;
    end;
end;

function u2.Unequip(p67) -- Line: 383
    p67._is_equipped = false;
    p67.Unequipped:Fire();

    if p67._highlight then
        p67._highlight:Destroy();
        p67._highlight = nil;
    end;

    p67.Animator:StopAllAnimations();
end;

function u2.MuzzleFlash(p68) -- Line: 395
    -- upvalues: PlayerDataController (copy), Utility (copy)
    if p68._aim_spring.Target >= 1 and PlayerDataController:GetSetting("Aiming Hides Muzzle Flashes") then
        return;
    end;

    for _, v in pairs(p68._muzzle_attachments) do
        Utility:PlayParticles(v);
    end;
end;

function u2.PlayHitAnimation(p69, p70) -- Line: 405
    if p70 and p69.Info.Animations.HeavyAttackAnimationHit then
        p69:PlayAnimation("HeavyAttackAnimationHit", nil, 0);
    end;
end;

function u2.PlayHitmarkerSound(p71, p72, p73) -- Line: 411
    if #p71._last_hitmarker_sounds > 10 then
        for i = #p71._last_hitmarker_sounds % 10, 1, -1 do
            p71._last_hitmarker_sounds[i]:Destroy();
            table.remove(p71._last_hitmarker_sounds, i);
            local _ = i;
        end;
    end;

    if not p72 then
        p71:_CreateHitmarkerSound("rbxassetid://13110130082", 1.5 / p73, 1 + 0.2 * math.random(), script, true, 1);

        return;
    end;

    p71:_CreateHitmarkerSound("rbxassetid://16537449730", 3 / p73, 1 + 0.2 * math.random(), script, true, 1);
    p71:_CreateHitmarkerSound("rbxassetid://16537337310", 2 / p73, 1 + 0.2 * math.random(), script, true, 1);
end;

function u2.Update(u74, p75, p76, p77) -- Line: 427
    -- upvalues: ViewModels2 (copy), PlayerDataController (copy), Utility (copy), CONSTANTS (copy), CameraController (copy), ItemLibrary (copy), FirstPerson (copy), ViewModels (copy)
    if p77.IsActive then
        local v78 = u74.Animator:IsInspectAnimationPlaying();
        u74._inspect_spring.Target = v78 and 1 or 0;
        local v79;

        if u74._instant_set_inspect_spring then
            v79 = u74._inspect_spring.Target;
        else
            v79 = u74._inspect_spring.Value;
        end;

        u74._inspect_spring.Value = v79;
        u74._instant_set_inspect_spring = false;
        local v80 = u74.ClientItem.ClientFighter:GetCameraSway(true) * 35;
        local State = u74.ClientItem.ClientFighter.Entity.Humanoid:GetState();
        local SprintTrack = u74.Animator:GetSprintTrack();
        local Value = u74._inspect_spring.Value;
        local v81 = u74._aim_spring.Value * (1 - Value * 0.125);
        local v82 = 1 - v81;
        local v83 = u74._recoil_spring.Value - u74._unrecoil_spring.Value;
        local v84 = p76.IsActuallySprinting and u74._aim_spring.Target == 0;

        if u74._highlight or not (p76.IsActuallyFirstPerson and (not u74:IsRenderingDisabled() and PlayerDataController:GetSetting("ViewModel Highlight"))) then
            if u74._highlight and not p76.IsActuallyFirstPerson then
                u74._highlight:Destroy();
                u74._highlight = nil;
            end;
        else
            u74._highlight = Instance.new("Highlight");
            u74._highlight.Name = "ViewModel";
            u74._highlight.FillTransparency = 1;
            u74._highlight.OutlineTransparency = 0.875;
            u74._highlight.OutlineColor = Color3.new();
            u74._highlight.Adornee = u74.Model;
            u74._highlight.Parent = u74.Model;
        end;

        if SprintTrack then
            if v84 and not SprintTrack.IsPlaying then
                u74.Animator:PlaySprintAnimation();
            elseif not v84 and SprintTrack.IsPlaying then
                u74.Animator:StopSprintAnimation();
            end;

            if SprintTrack.IsPlaying then
                SprintTrack:AdjustSpeed(u74.Animator.SprintTrackSpeed * u74._bobbing_speed_spring.Value / 0.1111111111111111 * 0.8);
            end;
        end;

        local v85 = p76.IsActuallyFirstPerson and 0 or 1;
        u74._left_arm.Transparency = v85;
        u74._right_arm.Transparency = v85;
        u74._left_arm_shirt_texture.Transparency = v85;
        u74._right_arm_shirt_texture.Transparency = v85;

        if u74._scope_glare_gui1 and u74._scope_glare_gui2 then
            local Unit = (workspace.CurrentCamera.CFrame.Position - u74._scope_glare_attachment.WorldPosition).Unit;
            local LookVector = u74.ClientItem.ClientFighter.Entity.RootPart.CFrame.LookVector;
            local _scope_glare_gui1 = u74._scope_glare_gui1;
            local v86 = not p76.IsActuallyFirstPerson;

            if v86 then
                if u74._aim_spring.Target >= 1 then
                    v86 = Utility:AngleBetweenVectors(Unit, LookVector) < 0.7853981633974483;
                else
                    v86 = false;
                end;
            end;

            _scope_glare_gui1.Enabled = v86;
            u74._scope_glare_gui2.Enabled = false;
        end;

        if u74:IsRenderingDisabled() then
            u74:SetCFrame(CFrame.identity);
            u74:_StepBehindHeadSubmodels(false);
        elseif p76.IsActuallyFirstPerson then
            u74:_StepBehindHeadSubmodels(true);
            u74:_UpdateHiddenArmSubmodels(true);
            local v87 = (CONSTANTS.DEVICE == "VR" and workspace.CurrentCamera.CFrame * CameraController.VRCameraCFrame.Rotation + CameraController.VRCameraCFrame.Position * 1.4142135623730951 / 2 or workspace.CurrentCamera.CFrame) * p77.ViewModelOffset * (u74._root_part_offset_override or u74.Info.RootPartOffset);
            local _sway_spring = u74._sway_spring;
            _sway_spring.Value = _sway_spring.Value + Vector2.new(v80.Y * 0.5, v80.X);
            local v88 = u74._sway_spring.Value * 0.0003;
            local v89 = u74._aim_lookat_attachment and u74._aim_lookat_attachment.WorldCFrame:ToObjectSpace(u74.Model.PrimaryPart.CFrame) or CFrame.identity;
            local v90 = CFrame.new(v88.Y * 1, -v88.X * 2, 0):Lerp(v89:Inverse() * CFrame.Angles(0, v88.Y * 0.05625, 0) * CFrame.Angles(v88.X * 0.1, 0, 0) * v89, v81);
            local CFrame_new_ret = CFrame.new(u74._impulse_position_spring.Value);
            local Value2 = u74._equip_spring.Value;
            local v91 = CFrame.new(0, -0.5 * Value2, 0.25 * Value2) * CFrame.Angles(-0.7853981633974483 * Value2, 0, 0.7853981633974483 * Value2);
            u74._sliding_spring.Target = p76.IsSliding and 1 or 0;
            local CFrame_Angles_ret = CFrame.Angles(0, 0, -0.3490658503988659 * (u74._sliding_spring.Value * v82));
            local v92;

            if u74.Info.DisableProceduralSprinting then
                v92 = CFrame.identity;
            else
                local v93 = v84 and not (SprintTrack and SprintTrack.IsPlaying or v78) and tick() > u74._custom_sprinting_enabled;
                u74._sprinting_spring.Target = (v93 or State == Enum.HumanoidStateType.Climbing) and 1 or 0;
                local Value3 = u74._sprinting_spring.Value;
                v92 = CFrame.Angles(0, 0.4363323129985824 * Value3, 0) * CFrame.Angles(-0.4363323129985824 * Value3, 0, 0);
            end;

            u74._bobbing_speed_spring.Target = p76.MoveSpeed / CONSTANTS.BASE_WALKSPEED * 0.1111111111111111 * (p76.IsGrounded and 1 or 0.05);
            u74._bobbing_tick = u74._bobbing_tick + u74._bobbing_speed_spring.Value * p75 * 60;
            local v94 = v84 and (SprintTrack and SprintTrack.IsPlaying) and 0.25 or 1;
            local v95 = math.max(0, p76.MoveSpeed / CONSTANTS.BASE_WALKSPEED) ^ 2.5 * ((p76.IsSliding or p76.IsBeingKnockedBack) and 0 or 1) * v94 * 0.05 * (u74.ClientItem.Info.AimScopePercent and 1 or v82);
            local v96 = u74.Info.FramesPerSecond and math.floor(u74._bobbing_tick * u74.Info.FramesPerSecond) / u74.Info.FramesPerSecond or u74._bobbing_tick;
            local v97 = math.sin(v96) * v95 * 2;
            local v98 = math.cos(v96 * 2 + 1.5707963267948966) * v95;
            u74._bobbing_value_spring.Target = Vector2.new(v97, v98);
            local v99 = u74.Info.FramesPerSecond and u74._bobbing_value_spring.Target or u74._bobbing_value_spring.Value;
            local CFrame_new_ret2 = CFrame.new(v99.X, v99.Y, 0);
            u74._landing_spring.Velocity = p76.JustLanded and -10 - 15 * v82 or u74._landing_spring.Velocity;
            local Value3 = u74._landing_spring.Value;
            local CFrame_new_ret3 = CFrame.new(0, Value3 * 0.125, 0);
            local _jump_spring = u74._jump_spring;
            local v100 = math.abs(p76.PlayerVelocity.Y) ^ 1.25 * math.sign(p76.PlayerVelocity.Y);
            _jump_spring.Target = math.max(-16 * v82, v100);
            local v101 = u74._jump_spring.Value * (2 - 1.5 * v81);
            local CFrame_Angles = CFrame.Angles;
            local math_rad_ret = math.rad(-v101 / 6);
            local v102 = CFrame_Angles(math.clamp(math_rad_ret, -0.7853981633974483, 0.7853981633974483), 0, 0);
            local v103 = u74:IsAimingAnimationEnabled();
            local v104;

            if u74.Info.FramesPerSecond then
                v104 = math.floor(v81 * u74.Info.FramesPerSecond + (u74.ClientItem.Info.AimScopePercent and 0 or 0.5)) / u74.Info.FramesPerSecond or v81;
            else
                v104 = v81;
            end;

            local v105 = not v103 and CFrame.identity or CFrame.lookAt(u74._aim_position_attachment.WorldPosition, u74._aim_lookat_attachment.WorldPosition, u74._aim_position_attachment.WorldCFrame.UpVector):ToObjectSpace(u74.Model.PrimaryPart.CFrame);
            local CFrame_new_ret4 = CFrame.new(v105.Position);
            local v106 = v105 - v105.Position;
            local v107 = p76.IsActuallyFirstPerson and (u74.ClientItem.Info.AimScopePercent or (1 / 0)) <= v81 and CFrame.new(0, 0, 10) or (not v103 and CFrame.identity or CFrame.identity:Lerp((u74._root_part_offset_override_inverse or u74._root_part_offset_inverse) * p77.ViewModelOffset:Inverse(), v81) * CFrame.identity:Lerp(CFrame_new_ret4, v104) * CFrame.identity:Lerp(v106, v104));
            local v108 = -p76.MoveVelocity:Cross(u74.ClientItem.ClientFighter.Entity.RootPart.CFrame.LookVector).Y / CONSTANTS.BASE_WALKSPEED * (1 + v81);
            local v109 = p76.MoveVelocity:Cross(u74.ClientItem.ClientFighter.Entity.RootPart.CFrame.RightVector).Y / CONSTANTS.BASE_WALKSPEED * (1 - v81 * 0.75);
            u74._tilt_spring.Target = Vector2.new(v108, p76.IsSliding and 0 or v109);
            local Value4 = u74._tilt_spring.Value;
            local v110 = v89:Inverse() * CFrame.Angles(Value4.Y * 0.06981317007977318 * 0.5, 0, Value4.X * 0.06981317007977318) * v89;
            local CFrame_new = CFrame.new;
            local Vector3_new_ret = Vector3.new(0, 0, v83.Z);
            local X = v83.X;
            local math_abs_ret = math.abs(v83.Y);
            local v111 = CFrame_new(Vector3_new_ret, (Vector3.new(X, math_abs_ret, v83.Z - 1))) * CFrame.Angles(math.abs(v83.Y) * 0.7853981633974483, 0, 1.5707963267948966 * -v83.X);
            local v112 = CFrame.new(v83.X * 2, -v83.Z / 10, v83.Z) * CFrame.Angles(0, v83.X * -2.5, v83.X * 10);
            local v113 = v89:Inverse() * CFrame.identity:Lerp(v111, 1 - v81) * CFrame.identity:Lerp(v112, v81) * v89;
            u74:SetCFrame(v87 * v90 * CFrame_new_ret * v91 * CFrame_Angles_ret * v92 * CFrame_new_ret2 * CFrame_new_ret3 * v102 * v107 * v110 * v113);
            u74.CurrentBobbingValue = v99;
            u74.CurrentSwayValue = v88;
            u74.CurrentJumpValue = v101;
            u74.CurrentLandingValue = Value3;
        else
            local RotationCFrame = u74.ClientItem.ClientFighter:GetRotationCFrame();
            u74:SetCFrame(CFrame.new(u74.ClientItem.ClientFighter.Entity.Head.Position) * RotationCFrame);
            u74:_StepBehindHeadSubmodels(nil, RotationCFrame);
            u74:_UpdateHiddenArmSubmodels(false);
        end;

        if u74.Charm then
            task.defer(u74.Charm.Update, u74.Charm, p75, not p76.IsActuallyFirstPerson);
        end;

        if u74._was_first_person ~= p76.IsActuallyFirstPerson then
            u74._was_first_person = p76.IsActuallyFirstPerson;

            for i, v in pairs(u74._arm_submodels) do
                i:ScaleTo(v.OriginalScale * (p76.IsActuallyFirstPerson and 1 or 1.7));
            end;

            if ItemLibrary.THIRD_PERSON_VIEWMODEL_BLACKLIST[u74.Name] then
                u74:_UpdateWrap();
            end;
        end;

        u74.CurrentRecoilValue = v83;
        u74.CurrentAimValue = v81;
        u74.CurrentInspectValue = Value;
        local v114;

        if p76.IsActuallyFirstPerson then
            v114 = FirstPerson;
        else
            v114 = ViewModels;
        end;

        u74:SetParent(v114);

        return true;
    end;

    if u74.Model ~= ViewModels2 then
        pcall(function() -- Line: 432
            -- upvalues: u74 (copy), ViewModels2 (ref)
            u74:SetParent(ViewModels2);
        end);
    end;
end;

function u2.Destroy(p115) -- Line: 691
    -- upvalues: ReplicatedClass (copy)
    p115._destroyed = true;

    for _, v in pairs(p115._preloaded_sounds) do
        v:Destroy();
    end;

    for _, v in pairs(p115._connections) do
        v:Disconnect();
    end;

    for i in pairs(p115._wrapped_only_objects) do
        i:Destroy();
    end;

    p115.Equipped:Destroy();
    p115.Unequipped:Destroy();
    p115.AnimationPlayed:Destroy();
    p115.AnimationStopped:Destroy();

    if p115.Charm then
        p115.Charm:Destroy();
    end;

    p115.Animator:Destroy();
    p115.ItemModel:Destroy();
    p115.Model:Destroy();
    ReplicatedClass.Destroy(p115);
end;

function u2._UpdateHiddenArmSubmodels(p116, p117) -- Line: 726
    for i, v in pairs(p116._arm_submodels) do
        local v118 = v.HideInThirdPerson and not p117 and 1 or 0;

        for _, descendant in pairs(i:GetDescendants()) do
            if descendant:IsA("BasePart") then
                p116:_LocalTransparencyModifier(descendant, "HiddenArmSubmodel", v118);
            end;
        end;
    end;
end;

function u2._IsSubmodelBehindHead(p119, p120, p121) -- Line: 741
    -- upvalues: Utility (copy)
    local _ = p119._animation_context_submodels[p120];
    local v122 = p119.ClientItem.ClientFighter.Entity and (p119.ClientItem.ClientFighter.Entity.Head or p119.ClientItem.ClientFighter.Entity.RootPart);

    if not (v122 and p120.PrimaryPart) then
        return false;
    end;

    local v123 = p121 or v122.CFrame.Rotation;

    for _, v in pairs(p119._submodel_boundingbox_attachments[p120]) do
        if v.WorldPosition:FuzzyEq(v122.Position) or Utility:AngleBetweenVectors(v.WorldPosition - v122.Position, v123.LookVector) < 1.5707963267948966 then
            return false;
        end;
    end;

    return true;
end;

function u2._StepBehindHeadSubmodels(p124, p125, p126) -- Line: 763
    for _, child in pairs(p124.ItemModel:GetChildren()) do
        local v127;

        if p125 == nil then
            v127 = not p124:_IsSubmodelBehindHead(child, p126);
        else
            v127 = p125;
        end;

        local v128 = v127 or false;

        if p124._submodels_behind_head_values[child] ~= v128 then
            p124._submodels_behind_head_values[child] = v128;
            local v129 = v128 and 0 or 1;

            for _, descendant in pairs(child:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    p124:_LocalTransparencyModifier(descendant, "BehindHead", v129);
                end;
            end;

            if p124.Charm and child == p124._charm_sub_model then
                p124.Charm:SetHidden(not v128);
            end;
        end;
    end;
end;

function u2._GetDefaultMuzzlePosition(p130) -- Line: 788
    return (CFrame.new(p130.ClientItem.ClientFighter.Entity.Head.Position) * p130.ClientItem.ClientFighter:GetRotationCFrame() * CFrame.new(0.5, -0.5, -0.5)).Position;
end;

function u2._AnimationWait(p131, ...) -- Line: 792
    return p131.Animator:AnimationWait(...);
end;

function u2._CreateHitmarkerSound(p132, ...) -- Line: 796
    local v133 = p132.ClientItem.ItemInterface:CreateSound(...);

    if v133 then
        table.insert(p132._last_hitmarker_sounds, v133);
    end;
end;

function u2._UpdateLocalTransparencyModifiers(p134) -- Line: 804
    for i in pairs(p134._local_transparency_modifiers) do
        p134:_UpdateLocalTransparencyModifier(i);
    end;
end;

function u2._UpdateLocalTransparencyModifier(u135, u136) -- Line: 810
    u135._local_transparency_modifier_update[u136] = true;
    task.defer(function() -- Line: 813
        -- upvalues: u135 (copy), u136 (copy)
        if not u135._local_transparency_modifier_update[u136] then
            return;
        end;

        u135._local_transparency_modifier_update[u136] = nil;
        local v137 = 0;

        for _, v in pairs(u135._local_transparency_modifiers[u136]) do
            v137 = math.max(v137, v);
        end;

        u136.LocalTransparencyModifier = v137;

        for _, descendant in pairs(u136:GetDescendants()) do
            if descendant:IsA("Texture") or (descendant:IsA("Beam") or (descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Decal")))) then
                descendant.LocalTransparencyModifier = v137;
            end;
        end;
    end);
end;

function u2._LocalTransparencyModifier(p138, p139, p140, p141) -- Line: 836
    if not p139 then
        return;
    end;

    p138._local_transparency_modifiers[p139] = p138._local_transparency_modifiers[p139] or {};

    if p138._local_transparency_modifiers[p139][p140] == p141 then
        return;
    end;

    p138._local_transparency_modifiers[p139][p140] = p141;
    p138:_UpdateLocalTransparencyModifier(p139);
end;

function u2._UpdateWrap(p142) -- Line: 851
    -- upvalues: ItemLibrary (copy), WrapController (copy)
    local v143;

    if ItemLibrary.THIRD_PERSON_VIEWMODEL_BLACKLIST[p142.Name] and not p142._was_first_person then
        v143 = nil;
    else
        v143 = p142:GetWrap();
    end;

    if not (v143 or p142._original_wrap_properties) then
        return;
    end;

    local v144 = v143 ~= nil;
    local v145;

    if v144 then
        v145 = p142._can_wrap_left_arm;
    else
        v145 = v144;
    end;

    local v146;

    if v144 then
        v146 = p142._can_wrap_right_arm;
    else
        v146 = v144;
    end;

    p142:_LocalTransparencyModifier(p142._left_arm, "FistsWrap", v145 and 1 or 0);
    p142:_LocalTransparencyModifier(p142._left_arm_shirt_texture, "FistsWrap", v145 and 1 or 0);
    p142:_LocalTransparencyModifier(p142._right_arm, "FistsWrap", v146 and 1 or 0);
    p142:_LocalTransparencyModifier(p142._right_arm_shirt_texture, "FistsWrap", v146 and 1 or 0);

    for i, v in pairs(p142._wrapped_only_objects) do
        local v147;

        if v144 then
            v147 = i.Name == "LeftArmWrapped" and p142._can_wrap_left_arm;

            if not v147 then
                if i.Name == "RightArmWrapped" then
                    v147 = p142._can_wrap_right_arm;
                else
                    v147 = false;
                end;
            end;
        else
            v147 = v144;
        end;

        i.Parent = v147 and v and v or nil;
    end;

    p142._original_wrap_properties = p142._original_wrap_properties or WrapController:RecordOriginalWrapProperties(p142.Model);
    WrapController:ApplyWrap(p142._original_wrap_properties, v143);
    p142:_UpdateLocalTransparencyModifiers();
end;

function u2._UpdateSubModelVisibility(p148) -- Line: 881
    for _, child in pairs(p148.ItemModel:GetChildren()) do
        local v149 = p148._animation_context_submodels[child];
        local v150 = p148._hidden_submodels[child.Name];

        if v149 or v150 ~= nil then
            local v151 = (v150 or v149 and not p148:AreAnimationsPlaying(v149)) and 1 or 0;

            for _, descendant in pairs(child:GetDescendants()) do
                if descendant:IsA("BasePart") or descendant:IsA("Texture") then
                    p148:_LocalTransparencyModifier(descendant, "SubModelVisibility", v151);
                end;
            end;
        end;
    end;
end;

function u2._UpdateArms(p152) -- Line: 900
    -- upvalues: WrapController (copy)
    WrapController:ResetWrap(p152._original_wrap_properties);
    p152._original_wrap_properties = nil;
    p152._right_arm_shirt_texture.Texture = p152._shirt_id;
    p152._left_arm_shirt_texture.Texture = p152._shirt_id;
    p152._right_arm.Color = p152._right_arm_color;
    p152._left_arm.Color = p152._left_arm_color;
    p152._right_arm_wrapped_part.Color = p152._right_arm_color;
    p152._left_arm_wrapped_part.Color = p152._left_arm_color;

    if p152.Name == "Hand Gun" then
        for _, child in pairs(p152.ItemModel:GetChildren()) do
            if child:FindFirstChild("MeshPart") then
                child.MeshPart.Color = child:GetAttribute("IsRightHand") and p152._right_arm_color or p152._left_arm_color;
            end;
        end;
    end;

    p152:_UpdateWrap();
end;

function u2._Setup(p153) -- Line: 922
    -- upvalues: CosmeticLibrary (copy), CONSTANTS (copy), u1 (copy), MuzzleFlashes (copy), ScopeGlareGui1 (copy), ScopeGlareGui2 (copy), Charms (copy), Charm (copy), SoundLibrary (copy), ViewModels2 (copy)
    if CosmeticLibrary.IGNORE_TRANSPARENCY_WHITELIST[p153.ClientItem.Name] then
        for _, descendant in pairs(p153.ItemModel:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant:SetAttribute("IgnoreTransparency", true);
            end;
        end;
    end;

    p153.Model.Name = (p153.ClientItem.ClientFighter.Player and (p153.ClientItem.ClientFighter.Player.Name or "???") or "???") .. " - " .. p153.ClientItem.Name .. " - " .. p153.Name;
    p153._right_arm.Mesh.Scale = CONSTANTS.DEVICE == "VR" and Vector3.new(0, 0, 0) or p153._right_arm.Mesh.Scale;
    p153._left_arm.Mesh.Scale = CONSTANTS.DEVICE == "VR" and Vector3.new(0, 0, 0) or p153._left_arm.Mesh.Scale;
    p153._right_arm_wrapped_part = p153.Model.RightArmWrapped;
    p153._right_arm_wrapped_part.Parent = nil;
    p153._wrapped_only_objects[p153._right_arm_wrapped_part] = p153.Model;
    p153._left_arm_wrapped_part = p153.Model.LeftArmWrapped;
    p153._left_arm_wrapped_part.Parent = nil;
    p153._wrapped_only_objects[p153._left_arm_wrapped_part] = p153.Model;
    p153.ItemModel.Name = "ItemVisual";
    p153.ItemModel.Parent = p153.Model;
    p153._body_model = p153.Model:FindFirstChild("Body");
    p153._aim_position_attachment = p153.Model:FindFirstChild("_aim_position", true);
    p153._aim_lookat_attachment = p153.Model:FindFirstChild("_aim_lookat", true);
    p153._center_attachment = p153.Model:FindFirstChild("_center", true);
    p153._charm_attachment_model = p153.Model:FindFirstChild("_charm_attachment_model", true);
    p153._charm_pivot_attachment = p153._charm_attachment_model and p153._charm_attachment_model:FindFirstChild("_charm_pivot_attachment", true) or p153.Model:FindFirstChild("_charm_pivot_attachment", true);
    p153._scope_glare_attachment = p153.Model:FindFirstChild("_scope_glare", true);
    local PrimaryPart = p153.Model.PrimaryPart;
    local CFrame_identity = CFrame.identity;
    local v154 = nil;

    for _, child in pairs(p153.ItemModel:GetChildren()) do
        if child.Name == "_fake" then
            p153._can_wrap_left_arm = child:FindFirstChild("LeftArmWrapped");
            p153._can_wrap_right_arm = child:FindFirstChild("RightArmWrapped");
            task.defer(child.Destroy, child);
        else
            child.PrimaryPart = child.Primary;
            v154 = v154 or child.PrimaryPart.CFrame;
            local v155 = child.Name == "_right_arm" and "RightArm" or (child.Name == "_left_arm" and "LeftArm" or nil);

            if v155 then
                p153._arm_submodels[child] = {
                    OriginalScale = child:GetScale(),
                    HideInThirdPerson = child:GetAttribute("HideInThirdPerson")
                };
                local v156 = p153.Model[v155];
                child.Parent = v156;
                child:PivotTo(v156.CFrame);
                local WeldConstraint = Instance.new("WeldConstraint");
                WeldConstraint.Part0 = v156;
                WeldConstraint.Part1 = child.PrimaryPart;
                WeldConstraint.Parent = child.PrimaryPart;
            else
                local Motor6D = Instance.new("Motor6D");
                Motor6D.Part0 = PrimaryPart;
                Motor6D.Part1 = child.PrimaryPart;
                Motor6D.Name = "ItemVisual[\"" .. child.Name .. "\"]";
                Motor6D.C0 = child:GetAttribute("C0") or child.PrimaryPart.CFrame:ToObjectSpace(v154):Inverse() * CFrame_identity;
                Motor6D.C1 = child:GetAttribute("C1") or CFrame.identity;
                Motor6D.Parent = PrimaryPart;
            end;

            local v157 = child;

            for _, descendant in pairs(child:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    descendant.CastShadow = false;
                    descendant.CanCollide = false;
                    descendant.CanTouch = false;
                    descendant.CanQuery = false;
                    descendant.Massless = true;

                    if descendant ~= v157.PrimaryPart then
                        local WeldConstraint = Instance.new("WeldConstraint");
                        WeldConstraint.Part0 = v157.PrimaryPart;
                        WeldConstraint.Part1 = descendant;
                        WeldConstraint.Parent = v157.PrimaryPart;
                        descendant.Anchored = false;
                    end;
                end;
            end;

            v157.PrimaryPart.Anchored = false;

            if not v155 then
                v157.PrimaryPart.Name = v157.Name .. "Primary";
                v157:PivotTo(PrimaryPart.CFrame);
                local Attribute = v157:GetAttribute("AnimationContexts");

                if Attribute then
                    p153._animation_context_submodels[v157] = {};
                    local v158 = 1;

                    for i = 1, #Attribute do
                        local v159;

                        if string.sub(Attribute, i - 1, i) == ", " then
                            local v160 = p153._animation_context_submodels[v157];
                            local string_sub_ret = string.sub(Attribute, v158, i - 2);
                            table.insert(v160, string_sub_ret);
                            v158 = i + 1;
                            v159 = i;
                        else
                            v159 = i;
                        end;
                    end;

                    if v158 <= #Attribute then
                        local v161 = p153._animation_context_submodels[v157];
                        local string_sub_ret = string.sub(Attribute, v158, #Attribute);
                        table.insert(v161, string_sub_ret);
                    end;
                end;

                if p153._charm_pivot_attachment and p153._charm_pivot_attachment:IsDescendantOf(v157) then
                    p153._charm_sub_model = v157;
                end;

                p153._submodel_boundingbox_attachments[v157] = {};
                local BoundingBox, v162 = v157:GetBoundingBox();

                for i, v in pairs(u1) do
                    local Attachment = Instance.new("Attachment");
                    Attachment.Name = "_boundingbox" .. i;
                    Attachment.Parent = v157.PrimaryPart;
                    Attachment.WorldCFrame = BoundingBox * CFrame.new(v162 * v);
                    table.insert(p153._submodel_boundingbox_attachments[v157], Attachment);
                end;
            end;
        end;
    end;

    for _, descendant in pairs(p153.Model:GetDescendants()) do
        if descendant.Name == "_muzzle" then
            table.insert(p153._muzzle_attachments, descendant);
            local Attribute = descendant:GetAttribute("MuzzleFlashParticlesName");
            local v163 = Attribute and MuzzleFlashes:FindFirstChild(Attribute) or MuzzleFlashes:FindFirstChild(p153.Name) or (MuzzleFlashes:FindFirstChild(p153.ClientItem.Name) or MuzzleFlashes.Default);
            local v164 = descendant;

            for _, child in pairs(v163.Attachment:GetChildren()) do
                child:Clone().Parent = v164;
            end;
        end;
    end;

    if p153._scope_glare_attachment then
        p153._scope_glare_gui1 = ScopeGlareGui1:Clone();
        p153._scope_glare_gui1.Enabled = false;
        p153._scope_glare_gui1.Parent = p153._scope_glare_attachment;
        p153._scope_glare_gui2 = ScopeGlareGui2:Clone();
        p153._scope_glare_gui2.Enabled = false;
        p153._scope_glare_gui2.Parent = p153._scope_glare_attachment;
    end;

    if p153._charm_pivot_attachment then
        if p153:Get("Charm") then
            local v165 = p153:Get("Charm");
            local v166 = Charms:FindFirstChild(v165.Name, true);
            p153.Charm = (v166 and require(v166) or Charm).new(p153, v165, p153._charm_pivot_attachment);
            p153.Charm:SetParent(p153.Model);
        else
            if p153._charm_pivot_attachment then
                p153._charm_pivot_attachment:Destroy();
            end;

            if p153._charm_attachment_model then
                p153._charm_attachment_model:Destroy();
            end;
        end;
    end;

    if p153.ClientItem.ClientFighter.IsLocalPlayer then
        for _, v in pairs(p153.Info.Animations) do
            SoundLibrary:PreloadSounds(SoundLibrary.AnimationSounds[v], p153._preloaded_sounds);
        end;

        if SoundLibrary.ViewModelSounds[p153.Name] then
            SoundLibrary:PreloadSounds(SoundLibrary.ViewModelSounds[p153.Name], p153._preloaded_sounds);
        end;
    end;

    p153:SetArmsData(nil, nil, nil);
    p153:SetParent(ViewModels2);
    p153:SetCFrame(CFrame.identity);
end;

function u2._Init(u167) -- Line: 1138
    -- upvalues: PlayerDataController (copy)
    u167.Animator.AnimationPlayed:Connect(function(...) -- Line: 1139
        -- upvalues: u167 (copy)
        u167.AnimationPlayed:Fire(...);
        u167:_UpdateSubModelVisibility();
    end);
    u167.Animator.AnimationStopped:Connect(function(...) -- Line: 1144
        -- upvalues: u167 (copy)
        u167.AnimationStopped:Fire(...);
        u167:_UpdateSubModelVisibility();
    end);
    local _connections = u167._connections;
    local DataChangedSignal = u167.ClientItem.ClientFighter:GetDataChangedSignal("IsSpectating");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 1149
        -- upvalues: u167 (copy)
        u167:_UpdateWrap();
    end));
    local _connections2 = u167._connections;
    local SettingChangedSignal = PlayerDataController:GetSettingChangedSignal("Wraps Disabled");
    table.insert(_connections2, SettingChangedSignal:Connect(function() -- Line: 1153
        -- upvalues: u167 (copy)
        u167:_UpdateWrap();
    end));
    u167:_Setup();
    u167:_UpdateWrap();
end;

return u2;