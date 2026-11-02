-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
game:GetService("GuiService");
local RunService = game:GetService("RunService");
local VRService = game:GetService("VRService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local QuaternionSpring = require(ReplicatedStorage.Modules.QuaternionSpring);
local GameplayUtility = require(ReplicatedStorage.Modules.GameplayUtility);
require(ReplicatedStorage.Modules.DebugLibrary);
local InputLibrary = require(ReplicatedStorage.Modules.InputLibrary);
require(ReplicatedStorage.Modules.TaskLibrary);
require(ReplicatedStorage.Modules.TestLibrary);
local Quaternion = require(ReplicatedStorage.Modules.Quaternion);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Spring = require(ReplicatedStorage.Modules.Spring);
local Signal = require(ReplicatedStorage.Modules.Signal);
require(Players.LocalPlayer.PlayerScripts.Controllers.PrivateServerController);
local UserInterfaceController = require(Players.LocalPlayer.PlayerScripts.Controllers.UserInterfaceController);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local SettingsController = require(Players.LocalPlayer.PlayerScripts.Controllers.SettingsController);
local DebugState = require(Players.LocalPlayer.PlayerScripts.Controllers.DebugController.DebugState);
local CameraShaker = require(Players.LocalPlayer.PlayerScripts.Modules.CameraShaker);
local CameraState = require(script:WaitForChild("CameraState"));
local Value = Enum.RenderPriority.Camera.Value;
local u1 = Vector2.new(0.77, 1) * 0.008726646259971648;
local u2 = {
    MouseKeyboard = 1,
    Touch = 0.875,
    Gamepad = 0.75
};
local u3 = {};
u3.__index = u3;

function u3._new() -- Line: 38
    -- upvalues: u3 (copy), Signal (copy), CameraState (copy), Spring (copy), QuaternionSpring (copy), Quaternion (copy)
    local v4 = setmetatable({}, u3);
    v4.StateChanged = Signal.new();
    v4.ActiveStateChanged = Signal.new();
    v4.POVStateChanged = Signal.new();
    v4.CustomFreecamStateChanged = Signal.new();
    v4.RotationDeltaApplied = Signal.new();
    v4.SubjectChanged = Signal.new();
    v4.CameraState = CameraState.new(v4);
    v4.Rotation = Vector2.zero;
    v4.ShakeCFrame = CFrame.identity;
    v4.ViewModelOffsetCFrame = CFrame.identity;
    v4.VRCameraCFrame = nil;
    v4._current_subject = nil;
    v4._current_duel_subject = nil;
    v4._third_person_override = nil;
    v4._external_fov_offsets = {};
    v4._is_editing_mobile_buttons = false;
    v4._last_dt = 0;
    v4._last_mouse_behavior = nil;
    v4._gamepad_rotation_input = Vector2.zero;
    v4._bobbing_tick = 0;
    v4._fov_gameplay_spring = Spring.new(60, 0.75, 30);
    v4._fov_weapons_spring = Spring.new(0, 1, 20);
    v4._position_spring = Spring.new(Vector3.new(0, 0, 0), 0.75, 30);
    v4._pov_spring = Spring.new(Vector3.new(0, 0, 0), 0.875, 25);
    v4._sway_spring = Spring.new(Vector2.zero, 0.5, 12.5);
    v4._bobbing_speed_spring = Spring.new(0, 0.5, 12.5);
    v4._bobbing_value_spring = Spring.new(0, 0.75, 12.5);
    v4._jump_spring = Spring.new(0, 0.5, 15);
    v4._sliding_spring = Spring.new(0, 0.5, 15);
    v4._leaning_spring = Spring.new(0, 1, 20);
    v4._camera_shaker = nil;
    v4._collision_whitelist = {};
    v4._next_collision_whitelist_fetch = 0;
    v4._viewmodel_animation_spring = QuaternionSpring.new(Quaternion.fromCFrame(CFrame.identity), 1, 10);
    v4._crosshair_disabled = false;
    v4._base_fov = 80;
    v4._gameplay_fov_effects_enabled = true;
    v4._shake_enabled = true;
    v4._open_playerlist_input_down = false;
    v4._inverted_identity_vector = Vector2.one;
    v4._camera_sensitivity = 1;
    v4._camera_sensitivity_ads_multiplier = 1;
    v4._camera_sensitivity_ads_multiplier_scoped = 1;
    v4._camera_sensitivity_x = 1;
    v4._camera_sensitivity_y = 1;
    v4._fov_offset_strength = 0;
    v4._fov_offset_strength_scoped = 0;
    v4._gamepad_deadzone = 0.25;
    v4:_Init();

    return v4;
end;

function u3.GetPublicState(p5, ...) -- Line: 108
    return p5.CameraState:GetPublicState(...);
end;

function u3.GetCurrentSubject(p6) -- Line: 112
    return p6._current_subject;
end;

function u3.IsSubjectEmoting(p7) -- Line: 116
    local CurrentSubject = p7:GetCurrentSubject();
    local v8 = CurrentSubject and CurrentSubject.Entity and CurrentSubject.Entity:IsEmoting();

    return v8;
end;

function u3.HasThirdPersonAccess(p9, p10) -- Line: 122
    -- upvalues: DebugState (copy), ControlsController (copy)
    if p9._third_person_override == nil then
        return p9._current_subject and p9._current_subject:Get("CheaterMode") and true or (not p10 and p9:IsSubjectEmoting() and true or (DebugState:Get("AreHandicapsEnabled") or ControlsController.CurrentControls == "Touch"));
    end;

    return p9._third_person_override;
end;

function u3.HasUnlockedMouseAccess(p11) -- Line: 129
    -- upvalues: ControlsController (copy)
    local v12 = p11:HasThirdPersonAccess() and (ControlsController.CurrentControls == "MouseKeyboard" and true or p11:IsSubjectEmoting());

    return v12;
end;

function u3.GetLastHeartbeatDeltaTime(p13) -- Line: 133
    return p13._last_dt;
end;

function u3.GetRenderstepPriority(p14) -- Line: 137
    -- upvalues: Value (copy)
    return Value;
end;

function u3.GetCameraCFrame(p15, p16) -- Line: 141
    -- upvalues: ControlsController (copy)
    local v17 = p16 or p15._current_subject;

    if ControlsController.CurrentControls == "VR" then
        return workspace.CurrentCamera.CFrame * p15.VRCameraCFrame;
    end;

    if not (v17 and v17.Entity) then
        return CFrame.identity;
    end;

    local v18;

    if p15.CameraState:GetPublicState() == p15.CameraState.States.FirstPerson then
        v18 = CFrame.new(p15._leaning_spring.Value * Vector3.new(2, 0.1, 0));
    else
        v18 = CFrame.identity;
    end;

    return CFrame.new(v17.Entity.RootPart.Position) * CFrame.new(p15._position_spring.Value) * p15:GetRotationCFrame() * v18;
end;

function u3.GetRotationCFrame(p19, p20) -- Line: 158
    local v21 = p20 or p19.Rotation;

    return CFrame.Angles(0, v21.Y, 0) * CFrame.Angles(v21.X, 0, 0);
end;

function u3.GetGamepadRotationInput(p22, p23) -- Line: 166
    return p23 and Vector2.new(p22._gamepad_rotation_input.Y, p22._gamepad_rotation_input.X) or p22._gamepad_rotation_input;
end;

function u3.GetExternalFOVOffset(p24) -- Line: 170
    local v25 = 0;

    for _, v in pairs(p24._external_fov_offsets) do
        v25 = v25 + v;
    end;

    return v25;
end;

function u3.GetCameraSensitivity(p26) -- Line: 180
    local v27 = p26._current_subject and p26._current_subject.EquippedItem and p26._current_subject.EquippedItem:Get("IsAiming");
    local v28;

    if v27 and (p26._current_subject and p26._current_subject.EquippedItem and p26._current_subject.EquippedItem.Info.AimScopePercent) then
        v28 = p26._camera_sensitivity_ads_multiplier_scoped;
    else
        v28 = not v27 and 1 or p26._camera_sensitivity_ads_multiplier;
    end;

    return p26._camera_sensitivity * (v28 or 1);
end;

function u3.SetRotation(p29, p30) -- Line: 189
    if p29._current_subject and (p29._current_subject.Entity and p29._current_subject.Entity:Get("IsFrozen")) then
        return;
    end;

    p29.Rotation = Vector2.new(math.clamp(p30.X, -1.5690509975429023, 1.5690509975429023), p30.Y);
end;

function u3.SetSubject(p31, p32) -- Line: 198
    p31._current_subject = p32;
    p31.SubjectChanged:Fire();
end;

function u3.SetDuelSubject(p33, p34) -- Line: 204
    p33._current_duel_subject = p34;
end;

function u3.SetExternalFOVOffset(p35, p36, p37) -- Line: 208
    if p37 == 0 then
        p37 = nil;
    end;

    p35._external_fov_offsets[p36] = p37;
end;

function u3.SetThirdPersonOverride(p38, p39) -- Line: 212
    p38._third_person_override = p39;
    p38.CameraState:VerifyPOV();
end;

function u3.SetIsEditingMobileButtons(p40, p41) -- Line: 217
    p40._is_editing_mobile_buttons = p41;
end;

function u3.Freeze(p42, p43) -- Line: 221
    -- upvalues: UserInputService (copy)
    if p43 and not p42.IsFrozen then
        UserInputService.MouseIconEnabled = true;
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
    elseif not p43 and p42.IsFrozen then
        p42._last_mouse_behavior = nil;
    end;

    p42.IsFrozen = p43;
    p42:Update(0);
end;

function u3.ApplyRotationDelta(p44, p45, p46) -- Line: 234
    local v47;

    if p46 then
        v47 = Vector2.one;
    else
        v47 = p44._inverted_identity_vector * p44:GetCameraSensitivity() * Vector2.new(p44._camera_sensitivity_y, p44._camera_sensitivity_x);
    end;

    local v48 = p45 * v47;
    p44:SetRotation(p44.Rotation + v48);
    p44.RotationDeltaApplied:Fire(v48);
end;

function u3.ShakeOnce(p49, ...) -- Line: 242
    p49._camera_shaker:ShakeOnce(...);
end;

function u3.Shake(p50, ...) -- Line: 246
    p50._camera_shaker:Shake(...);
end;

function u3.MimicRotation(p51, p52) -- Line: 251
    local v53, v54, _ = p52:ToOrientation();
    p51:SetRotation(Vector2.new(v53, v54));
end;

-- Dead in a duel with nobody left to spectate (a trade, the break after a round): the camera
-- would otherwise be handed to Roblox's default one, orbiting the body in third person. It stays
-- where the player was looking instead, until they spawn or there is someone to watch.
local u_FighterController = nil;

local function is_dead_in_duel()
    -- upvalues: u_FighterController (ref), Players (copy)
    u_FighterController = u_FighterController or require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
    local LocalFighter = u_FighterController.LocalFighter;

    return LocalFighter ~= nil and LocalFighter:Get("IsInDuel") == true and not LocalFighter:IsAlive();
end;

function u3.Update(p55, p56) -- Line: 257
    -- upvalues: CollectionService (copy), UserInputService (copy), ControlsController (copy), CONSTANTS (copy), UserInterfaceController (copy), Quaternion (copy), GameplayUtility (copy), Utility (copy)
    if p55.IsFrozen or p55.CameraState:GetPublicState() == p55.CameraState.States.CustomFreecam then
        return;
    end;

    local v57 = p56 or 0;
    local v58;

    if p55._current_subject == nil then
        v58 = false;
    else
        v58 = p55._current_subject:IsAlive() and p55._current_subject;
    end;

    local CameraState2 = p55.CameraState;
    local v59;

    if v58 then
        v59 = v58:IsActive();
    else
        v59 = v58;
    end;

    CameraState2:SetActive(v59);
    local PublicState = p55.CameraState:GetPublicState();
    local v60;

    if not PublicState and p55._current_duel_subject and not p55._current_duel_subject.LocalDueler then
        v60 = p55._current_duel_subject.Map and p55._current_duel_subject.Map:GetSpectatePart() or CollectionService:GetTagged("WaitingRoomSpectate")[1];
    else
        v60 = nil;
    end;

    if v60 then
        UserInputService.MouseIconEnabled = true;
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
        workspace.CurrentCamera.CameraSubject = nil;
        workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        workspace.CurrentCamera.CFrame = v60.CFrame;

        return;
    end;

    if not v58 and is_dead_in_duel() then
        UserInputService.MouseIconEnabled = true;
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
        workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;

        return;
    end;

    local v61 = PublicState == p55.CameraState.States.ThirdPersonUnlockedMouse and true or not (v58 and v58.IsLocalPlayer);
    local v62;

    if PublicState then
        v62 = PublicState ~= p55.CameraState.States.ThirdPersonUnlockedMouse;
    else
        v62 = PublicState;
    end;

    local v63;

    if v58 then
        v63 = v58.EquippedItem;
    else
        v63 = v58;
    end;

    local v64 = p55:_Modal();
    local v65;

    if v64 then
        v65 = ControlsController.CurrentControls == "MouseKeyboard";
    else
        v65 = v64;
    end;

    local v66 = v62 and not (v61 or (ControlsController.CurrentControls ~= "MouseKeyboard" or v65)) and Enum.MouseBehavior.LockCenter or Enum.MouseBehavior.Default;
    local CameraType = workspace.CurrentCamera.CameraType;
    local v67;

    if v58 and v58.Entity then
        v67 = v58.Entity.Humanoid or nil;
    else
        v67 = nil;
    end;

    workspace.CurrentCamera.CameraSubject = v67;
    workspace.CurrentCamera.CameraType = v62 and Enum.CameraType.Scriptable or Enum.CameraType.Custom;
    UserInputService.MouseIconEnabled = v65 or (not (v63 and v58) or (not v58.IsLocalPlayer or (ControlsController.CurrentControls == "Touch" and true or (p55._crosshair_disabled and v61 and v61 or p55:IsSubjectEmoting()))));

    if v66 == Enum.MouseBehavior.LockCenter or v66 ~= p55._last_mouse_behavior then
        UserInputService.MouseBehavior = v66;
        p55._last_mouse_behavior = v66;
    end;

    if not v62 then
        p55:MimicRotation(workspace.CurrentCamera.CFrame.Rotation * CFrame.Angles(0.17453292519943295, 0, 0));
    end;

    if not v58 then
        workspace.CurrentCamera.FieldOfView = p55._base_fov;

        return;
    end;

    local CFrame_new_ret = CFrame.new(v58.Entity.RootPart.Position);
    local v68;

    if CameraType == Enum.CameraType.Custom and workspace.CurrentCamera.CameraType ~= Enum.CameraType.Custom then
        v68 = (workspace.CurrentCamera.CFrame.Position - CFrame_new_ret.Position).Magnitude < 128;
    else
        v68 = false;
    end;

    if v68 then
        p55._fov_gameplay_spring.Value = workspace.CurrentCamera.FieldOfView;
    end;

    local IsLocalPlayer = v58.IsLocalPlayer;
    v58:IsSprinting();
    local v69 = v58:IsCrouching();
    local v70 = v58:IsSliding();
    local v71 = v58:IsGrounded();
    local v72 = v58 and (v58.Entity and v58.Entity.Humanoid) and v58.Entity.Humanoid:GetState() == Enum.HumanoidStateType.Climbing;
    local RotationCFrame = v58:GetRotationCFrame();
    local v73 = v58:GetCameraSway() * 0.25;
    local CameraLean = v58:GetCameraLean();
    local ClampedVelocity = v58.Entity:GetClampedVelocity();
    local Magnitude = (ClampedVelocity * Vector3.new(1, 0, 1)).Magnitude;
    local v74;

    if v63 and v63.Info.AimScopePercent then
        v74 = p55._fov_offset_strength_scoped;
    else
        v74 = p55._fov_offset_strength;
    end;

    p55._fov_weapons_spring.Speed = 20 * v58:GetAimSpeed();
    p55._fov_weapons_spring.Target = PublicState == p55.CameraState.States.ThirdPersonUnlockedMouse and 0 or v58:GetFOVOffset() * v74;
    p55._fov_gameplay_spring.Target = p55._base_fov + (p55._gameplay_fov_effects_enabled and (math.max(0, Magnitude - CONSTANTS.BASE_WALKSPEED) * 10 / CONSTANTS.BASE_WALKSPEED or 0) or 0) + p55:GetExternalFOVOffset();
    workspace.CurrentCamera.FieldOfView = p55._fov_gameplay_spring.Value + p55._fov_weapons_spring.Value * (p55._fov_gameplay_spring.Value / 80);
    p55._position_spring.Target = Vector3.new(0, 1.75, 0) + Vector3.new(0, v70 and -3 or (v72 and -2.5 or (v69 and -2 or 0)), 0);

    if workspace.CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
        return;
    end;

    if v68 then
        p55._position_spring.Value = workspace.CurrentCamera.CFrame:ToObjectSpace(CFrame_new_ret):Inverse().Position * 0.5;
    end;

    if ControlsController.CurrentControls == "Gamepad" and not (v64 or UserInterfaceController:IsPageOpen()) then
        p55:ApplyRotationDelta(p55._gamepad_rotation_input * p55:_GetFOVMultiplier() * v57 * 60);
    end;

    local CFrame_new_ret2 = CFrame.new(p55._position_spring.Value);
    local CFrame_identity = CFrame.identity;
    local CFrame_identity2 = CFrame.identity;

    if PublicState == p55.CameraState.States.FirstPerson and not IsLocalPlayer then
        p55._bobbing_speed_spring.Target = Magnitude / CONSTANTS.BASE_WALKSPEED * (v71 and 1 or 0) * 0.111;
        p55._bobbing_tick = p55._bobbing_tick + p55._bobbing_speed_spring.Value * v57 * 60;
        local _bobbing_value_spring = p55._bobbing_value_spring;
        local math_sin_ret = math.sin(p55._bobbing_tick);
        _bobbing_value_spring.Target = (math.abs(math_sin_ret) - 0.5) * (Magnitude / CONSTANTS.BASE_WALKSPEED) ^ 2 * (v70 and 0 or 1) * 0.125;
        local Value2 = p55._bobbing_value_spring.Value;
        CFrame_identity = CFrame.new(0, Value2, 0);
        CFrame_identity2 = CFrame.Angles(Value2 * 0.08726646259971647, 0, 0);
    end;

    local CFrame_new_ret3 = CFrame.new(p55._pov_spring.Value);
    local _sway_spring = p55._sway_spring;
    _sway_spring.Value = _sway_spring.Value + Vector2.new(v73.Y * 0.5, v73.X);
    local v75 = p55._sway_spring.Value * (IsLocalPlayer and 0 or 0.025);
    local CFrame_Angles_ret = CFrame.Angles(v75.X, 0, v75.Y);
    local v76 = IsLocalPlayer and CFrame.identity;

    if not v76 then
        local CFrame_Angles = CFrame.Angles;
        local v77 = tick() * 0.23983 % 6.283185307179586;
        local v78 = math.sin(v77) * 0.004363323129985824;
        local v79 = tick() * 0.372721 % 6.283185307179586;
        local v80 = math.sin(v79) * 0.004363323129985824;
        local v81 = tick() * 0.43123 % 6.283185307179586;
        v76 = CFrame_Angles(v78, v80, math.sin(v81) * 0.004363323129985824);
    end;

    p55._jump_spring.Target = ClampedVelocity.Y;
    local CFrame_Angles = CFrame.Angles;
    local math_rad_ret = math.rad(-(p55._jump_spring.Value / CONSTANTS.BASE_GRAVITY * (IsLocalPlayer and 0 or 0.5)) / 15);
    local v82 = CFrame_Angles(math.clamp(math_rad_ret, -0.7853981633974483, 0.7853981633974483), 0, 0);
    p55._sliding_spring.Target = v70 and 1 or 0;
    local CFrame_Angles_ret2 = CFrame.Angles(0, 0, -0.08726646259971647 * p55._sliding_spring.Value);
    p55._leaning_spring.Target = PublicState == p55.CameraState.States.FirstPerson and CameraLean and CameraLean or 0;
    local Value2 = p55._leaning_spring.Value;
    local v83 = CFrame.new(Value2 * Vector3.new(2, 0.1, 0)) * CFrame.Angles(0, 0, Value2 * -0.08726646259971647);
    p55._viewmodel_animation_spring.Target = Quaternion.fromCFrame(v63 and (v63.ViewModel and v63.ViewModel:GetCameraOffset()) or CFrame.identity);
    p55.ViewModelOffsetCFrame = CFrame.identity;
    local v84 = CFrame_new_ret * CFrame_new_ret2 * (CFrame_identity * RotationCFrame * CFrame_identity2 * CFrame_new_ret3 * CFrame_Angles_ret * v76 * v82 * CFrame_Angles_ret2 * v83 * p55.ViewModelOffsetCFrame * p55.ShakeCFrame);
    local Position = v84.Position;

    if tick() > p55._next_collision_whitelist_fetch then
        p55._next_collision_whitelist_fetch = tick() + 5;
        p55._collision_whitelist = GameplayUtility:GetRaycastWhitelist(v58:Get("EnvironmentID"));
    end;

    local v85 = Utility:Raycast(v58.Entity.RootPart.Position, v84.Position, (v84.Position - v58.Entity.RootPart.Position).Magnitude, p55._collision_whitelist, Enum.RaycastFilterType.Include);

    if v85.Instance then
        Position = v58.Entity.RootPart.Position + (v84.Position - v58.Entity.RootPart.Position).Unit * ((v58.Entity.RootPart.Position - v85.Position).Magnitude - 0.5);
    end;

    workspace.CurrentCamera.CFrame = CFrame.new(Position) * v84.Rotation;
end;

function u3._UpdateSettings(p86) -- Line: 440
    -- upvalues: PlayerDataController (copy)
    p86._crosshair_disabled = PlayerDataController:GetSetting("Crosshair Disabled");
    p86._base_fov = PlayerDataController:GetSetting("Camera FOV");
    p86._gameplay_fov_effects_enabled = PlayerDataController:GetSetting("Camera FOV Effects");
    p86._shake_enabled = PlayerDataController:GetSetting("Camera Shake");
    p86._inverted_identity_vector = Vector2.new(PlayerDataController:GetSetting("Camera Inverted Y") and -1 or 1, PlayerDataController:GetSetting("Camera Inverted X") and -1 or 1);
    p86._camera_sensitivity = PlayerDataController:GetSetting("Camera Sensitivity");
    p86._camera_sensitivity_ads_multiplier = PlayerDataController:GetSetting("Camera Sensitivity ADS");
    p86._camera_sensitivity_ads_multiplier_scoped = PlayerDataController:GetSetting("Camera Sensitivity Scoped");
    p86._camera_sensitivity_x = PlayerDataController:GetSetting("Camera Sensitivity X");
    p86._camera_sensitivity_y = PlayerDataController:GetSetting("Camera Sensitivity Y");
    p86._fov_offset_strength = PlayerDataController:GetSetting("Camera Zoom Effects");
    p86._fov_offset_strength_scoped = PlayerDataController:GetSetting("Camera Zoom Effects Scoped");
    p86._gamepad_deadzone = PlayerDataController:GetSetting("Gamepad Deadzone");
end;

function u3._Modal(p87) -- Line: 456
    -- upvalues: UserInterfaceController (copy)
    local v88 = p87._current_duel_subject and p87._current_duel_subject.DuelInterface and p87._current_duel_subject.DuelInterface.Scoreboard:IsOpen();

    return v88 or (UserInterfaceController:IsPageOpen() or p87._open_playerlist_input_down);
end;

function u3._GetFOVMultiplier(p89) -- Line: 462
    return workspace.CurrentCamera.FieldOfView < p89._base_fov and workspace.CurrentCamera.FieldOfView / p89._base_fov or 1;
end;

function u3._InputChanged(p90, p91, p92) -- Line: 466
    -- upvalues: ControlsController (copy), u2 (copy), u1 (copy)
    if p92 or p90._is_editing_mobile_buttons then
        return;
    end;

    if ControlsController.CurrentControls == "MouseKeyboard" and (p91.UserInputType ~= Enum.UserInputType.MouseMovement and p91.UserInputType ~= Enum.UserInputType.MouseWheel) then
        return;
    end;

    local v93 = u2[ControlsController.CurrentControls];

    if ControlsController.CurrentControls == "MouseKeyboard" or ControlsController.CurrentControls == "Touch" then
        p90:ApplyRotationDelta(Vector2.new(p91.Delta.Y, p91.Delta.X) * u1 * v93 * p90:_GetFOVMultiplier() * -1);

        return;
    end;

    if ControlsController.CurrentControls == "Gamepad" and (p91.KeyCode == Enum.KeyCode.Thumbstick1 or p91.KeyCode == Enum.KeyCode.Thumbstick2) then
        local v94 = (Vector2.new(p91.Position.X, p91.Position.Y).Magnitude - p90._gamepad_deadzone) / (1 - p90._gamepad_deadzone);
        local math_max_ret = math.max(0, v94);
        local v95 = p91.Position.X * math_max_ret;
        local v96 = math.floor(p91.Position.Y * math_max_ret * 10 + 0.5) * v93;
        local v97 = -math.floor(v95 * 10 + 0.5) * v93;
        p90._gamepad_rotation_input = Vector2.new(v96, v97) * 0.01;
    end;
end;

function u3._Setup(u98) -- Line: 495
    -- upvalues: VRService (copy), CameraShaker (copy)
    if VRService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) then
        u98.VRCameraCFrame = VRService:GetUserCFrame(Enum.UserCFrame.RightHand);
    end;

    u98._camera_shaker = CameraShaker.new(Enum.RenderPriority.Camera.Value + 1, function(p99) -- Line: 500
        -- upvalues: u98 (copy)
        u98.ShakeCFrame = u98._shake_enabled and p99 and p99 or CFrame.identity;
    end);
    u98._camera_shaker:Start();
end;

function u3._Init(u100) -- Line: 507
    -- upvalues: UserInputService (copy), Utility (copy), InputLibrary (copy), SettingsController (copy), PlayerDataController (copy), VRService (copy), RunService (copy), Value (copy)
    u100.StateChanged:Connect(function() -- Line: 508
        -- upvalues: u100 (copy)
        local PublicState = u100.CameraState:GetPublicState();
        u100._pov_spring.Target = PublicState == u100.CameraState.States.ThirdPerson and Vector3.new(3, 1.5, 7.5) or (PublicState == u100.CameraState.States.ThirdPersonMirrored and Vector3.new(-3, 1.5, 7.5) or (PublicState == u100.CameraState.States.ThirdPersonUnlockedMouse and Vector3.new(0, 3, 10) or Vector3.new(0, 0, 0)));
    end);
    u100.CameraState.StateChanged:Connect(function(p101, p102) -- Line: 517
        -- upvalues: u100 (copy)
        u100.StateChanged:Fire(p101, p102);

        if not (p101 and p102) then
            u100.ActiveStateChanged:Fire(p101, p102);
        end;

        if p101 == u100.CameraState.States.CustomFreecam or p102 == u100.CameraState.States.CustomFreecam then
            u100.CustomFreecamStateChanged:Fire(p101, p102);
        end;

        local table_find_ret = table.find(u100.CameraState.POVStates, p101);
        local table_find_ret2 = table.find(u100.CameraState.POVStates, p102);

        if table_find_ret or table_find_ret2 then
            u100.POVStateChanged:Fire(p101, p102, table_find_ret and table_find_ret2);
        end;
    end);
    UserInputService.InputBegan:Connect(function(p103, p104) -- Line: 536
        -- upvalues: u100 (copy), Utility (ref), InputLibrary (ref), SettingsController (ref), PlayerDataController (ref)
        local PublicState = u100.CameraState:GetPublicState();
        local v105;

        if PublicState == u100.CameraState.States.CustomFreecam then
            v105 = Utility:IsTextBoxFocused();
        else
            v105 = p104;
        end;

        if not v105 and InputLibrary:InputIs(p103, "HideHUD") then
            SettingsController:ChangeSetting("Hide HUD", not PlayerDataController:GetSetting("Hide HUD"));
        end;

        if u100.IsFrozen or not PublicState then
            return;
        end;

        if p104 or not InputLibrary:InputIs(p103, "SwitchCameraPOV") then
            if not p104 and InputLibrary:InputIs(p103, "OpenPlayerList") then
                u100._open_playerlist_input_down = true;
            end;

            return;
        end;

        u100.CameraState:TogglePOV();
    end);
    UserInputService.InputChanged:Connect(function(...) -- Line: 556
        -- upvalues: u100 (copy)
        if u100.IsFrozen or not u100.CameraState:GetPublicState() then
            return;
        end;

        u100:_InputChanged(...);
    end);
    UserInputService.InputEnded:Connect(function(p106, p107) -- Line: 564
        -- upvalues: InputLibrary (ref), u100 (copy)
        if InputLibrary:InputIs(p106, "OpenPlayerList") then
            u100._open_playerlist_input_down = false;
        end;
    end);
    VRService.UserCFrameChanged:Connect(function(p108, p109) -- Line: 570
        -- upvalues: u100 (copy), VRService (ref)
        if u100.IsFrozen or not u100.CameraState:GetPublicState() then
            return;
        end;

        local v110 = VRService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) and VRService:GetUserCFrame(Enum.UserCFrame.RightHand);
        local v111 = VRService:GetUserCFrameEnabled(Enum.UserCFrame.Head) and VRService:GetUserCFrame(Enum.UserCFrame.Head);
        local v112 = v110 or (v111 or CFrame.identity);
        u100.VRCameraCFrame = CFrame.new((v111 or (v110 or CFrame.identity)).Position) * (v112 - v112.Position);
    end);
    RunService:BindToRenderStep("CameraController", Value, function(p113) -- Line: 583
        -- upvalues: u100 (copy)
        u100._last_dt = p113;
        u100:Update(p113);
    end);
    PlayerDataController:GetSettingChangedSignal("Crosshair Disabled"):Connect(function() -- Line: 588
        -- upvalues: u100 (copy)
        u100:_UpdateSettings();
    end);
    PlayerDataController:GetSettingChangedSignal("Camera FOV"):Connect(function() -- Line: 592
        -- upvalues: u100 (copy)
        u100:_UpdateSettings();
    end);
    PlayerDataController:GetSettingChangedSignal("Camera FOV Effects"):Connect(function() -- Line: 596
        -- upvalues: u100 (copy)
        u100:_UpdateSettings();
    end);
    PlayerDataController:GetSettingChangedSignal("Camera Inverted X"):Connect(function() -- Line: 600
        -- upvalues: u100 (copy)
        u100:_UpdateSettings();
    end);
    PlayerDataController:GetSettingChangedSignal("Camera Inverted Y"):Connect(function() -- Line: 604
        -- upvalues: u100 (copy)
        u100:_UpdateSettings();
    end);
    PlayerDataController:GetSettingChangedSignal("Camera Shake"):Connect(function() -- Line: 608
        -- upvalues: u100 (copy)
        u100:_UpdateSettings();
    end);
    PlayerDataController:GetSettingChangedSignal("Camera Sensitivity"):Connect(function() -- Line: 612
        -- upvalues: u100 (copy)
        u100:_UpdateSettings();
    end);
    PlayerDataController:GetSettingChangedSignal("Camera Sensitivity ADS"):Connect(function() -- Line: 616
        -- upvalues: u100 (copy)
        u100:_UpdateSettings();
    end);
    PlayerDataController:GetSettingChangedSignal("Camera Zoom Effects"):Connect(function() -- Line: 620
        -- upvalues: u100 (copy)
        u100:_UpdateSettings();
    end);
    PlayerDataController:GetSettingChangedSignal("Camera Zoom Effects Scoped"):Connect(function() -- Line: 624
        -- upvalues: u100 (copy)
        u100:_UpdateSettings();
    end);
    PlayerDataController:GetSettingChangedSignal("Gamepad Deadzone"):Connect(function() -- Line: 628
        -- upvalues: u100 (copy)
        u100:_UpdateSettings();
    end);
    PlayerDataController:GetSettingChangedSignal("Camera Sensitivity X"):Connect(function() -- Line: 632
        -- upvalues: u100 (copy)
        u100:_UpdateSettings();
    end);
    PlayerDataController:GetSettingChangedSignal("Camera Sensitivity Y"):Connect(function() -- Line: 636
        -- upvalues: u100 (copy)
        u100:_UpdateSettings();
    end);
    PlayerDataController:GetSettingChangedSignal("Camera Sensitivity Scoped"):Connect(function() -- Line: 640
        -- upvalues: u100 (copy)
        u100:_UpdateSettings();
    end);
    PlayerDataController.SettingsSliderChanged:Connect(function(p114, p115) -- Line: 644
        -- upvalues: u100 (copy)
        if p114 == "Camera FOV" then
            u100._base_fov = p115;
        end;
    end);
    u100:_Setup();
    u100:_UpdateSettings();
end;

return u3._new();