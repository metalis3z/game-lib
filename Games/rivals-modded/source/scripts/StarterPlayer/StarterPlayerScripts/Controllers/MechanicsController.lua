-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ContextActionService = game:GetService("ContextActionService");
game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local GamepadService = game:GetService("GamepadService");
game:GetService("StarterGui");
local RunService = game:GetService("RunService");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local SettingsLibrary = require(ReplicatedStorage.Modules.SettingsLibrary);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local GameplayUtility = require(ReplicatedStorage.Modules.GameplayUtility);
require(ReplicatedStorage.Modules.BetterDebris);
local InputLibrary = require(ReplicatedStorage.Modules.InputLibrary);
local EnumLibrary = require(ReplicatedStorage.Modules.EnumLibrary);
require(ReplicatedStorage.Modules.ItemLibrary);
require(ReplicatedStorage.Modules.TestLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local UserInterfaceController = require(Players.LocalPlayer.PlayerScripts.Controllers.UserInterfaceController);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local EmoteController = require(Players.LocalPlayer.PlayerScripts.Controllers.EmoteController);
local DebugState = require(Players.LocalPlayer.PlayerScripts.Controllers.DebugController.DebugState);
local u1 = { "Aim", "Sprint", "Crouch" };
local u2 = {
    Aim = false,
    Sprint = false,
    Crouch = false
};
local u3 = {};
u3.__index = u3;

function u3._new() -- Line: 45
    -- upvalues: u3 (copy), Signal (copy)
    local v4 = setmetatable({}, u3);
    v4.StateChanged = Signal.new();
    v4.SlideStep = Signal.new();
    v4.LocalFighter = nil;
    v4.IsCrouching = false;
    v4.IsSprinting = false;
    v4.IsSliding = false;
    v4.CameraLean = 0;
    v4._internal_local_fighter_added = Signal.new();
    v4._controls_connections = {};
    v4._crouching_start_time = 0;
    v4._crouching_release_time = 0;
    v4._sprinting_start_time = 0;
    v4._sprinting_release_time = 0;
    v4._sliding_cooldown = 0;
    v4._sliding_start_time = 0;
    v4._sliding_release_time = 0;
    v4._sliding_velocity = nil;
    v4._sliding_last_floor = nil;
    v4._sliding_last_floor_physical_properties = nil;
    v4._update_slide_direction = nil;
    v4._is_input_spamming = {};
    v4._mobile_input_down = {};
    v4._is_leaning_right = false;
    v4._is_leaning_left = false;
    v4._original_jump_power = nil;
    v4._jump_hash = 0;
    v4._double_jumps_used = {};
    v4._auto_shoot_hash = 0;
    v4._auto_shoot_connection = nil;
    v4._scroll_delta = 0.5;
    v4:_Init();

    return v4;
end;

function u3.AreInputsDisabled(p5) -- Line: 90
    -- upvalues: GamepadService (copy), GuiService (copy), ControlsController (copy), Players (copy), SpectateController (copy)
    if GamepadService.GamepadCursorEnabled or GuiService.SelectedObject then
        return true;
    end;

    if p5.LocalFighter and p5.LocalFighter:Get("IsHiddenByCutscene") then
        return true;
    end;

    if ControlsController.CurrentControls == "Gamepad" then
        local Equipment = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Equipment);

        if require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages).PageSystem.CurrentPage or (Equipment.IsOpen or SpectateController.CurrentDuelSubject and SpectateController.CurrentDuelSubject.DuelInterface.Voting:IsOpen()) then
            return true;
        end;
    end;

    return false;
end;

function u3.IsAlive(p6) -- Line: 111
    local v7 = p6.LocalFighter and p6.LocalFighter:IsAlive();

    return v7;
end;

function u3.IsFrozen(p8) -- Line: 115
    local v9 = p8.LocalFighter and p8.LocalFighter.Entity and p8.LocalFighter.Entity:Get("IsFrozen");

    return v9;
end;

function u3.IsInputDown(p10, p11) -- Line: 120
    -- upvalues: CameraController (copy), ControlsController (copy), InputLibrary (copy)
    local v12 = CameraController:GetPublicState() == CameraController.CameraState.States.ThirdPersonUnlockedMouse and { Enum.UserInputType.MouseButton2 } or nil;

    if ControlsController.CurrentControls == "Touch" then
        return p10:IsMobileInputDown(p11);
    end;

    return InputLibrary:IsInputDown(p11, v12);
end;

function u3.IsMobileInputDown(p13, p14) -- Line: 127
    return p13._mobile_input_down[p14];
end;

function u3.GetTimeSince(p15, p16, p17) -- Line: 132
    return tick() - p15["_" .. string.lower(p16) .. "_" .. string.lower(p17) .. "_time"];
end;

function u3.SetCameraLean(p18, p19) -- Line: 137
    p18.CameraLean = p19;
    p18.LocalFighter.LocalCameraLean = p18.CameraLean;
    p18:_UpdateServerState("CameraLean", p18.CameraLean);
end;

function u3.SetCrouching(p20, p21) -- Line: 144
    -- upvalues: ControlsController (copy)
    if not p21 then
        ControlsController:ToggleInput("Crouch", false);
    end;

    if p21 == p20.IsCrouching then
        return;
    end;

    p20.IsCrouching = p21;
    p20.LocalFighter.IsCrouchingLocally = p20.IsCrouching;
    p20[p20.IsCrouching and "_crouching_start_time" or "_crouching_release_time"] = tick();
    p20:_UpdateServerState("IsCrouching", p20.IsCrouching);
    p20.StateChanged:Fire("IsCrouching");
    p20:_UpdateWalkSpeed();

    if p20.IsCrouching then
        p20:SetSprinting(false);
        local RootPart = p20.LocalFighter.Entity.RootPart;
        local X = p20.LocalFighter.Entity.RootPart.Velocity.X;
        local math_min_ret = math.min(0, p20.LocalFighter.Entity.RootPart.Velocity.Y);
        RootPart.Velocity = Vector3.new(X, math_min_ret, p20.LocalFighter.Entity.RootPart.Velocity.Z);
    end;
end;

function u3.SetSprinting(p22, p23) -- Line: 168
    if p23 == p22.IsSprinting then
        return;
    end;

    if not (p22.LocalFighter and (p22.LocalFighter:CanSprint() and p23)) then
        p23 = false;
    end;

    p22.IsSprinting = p23;
    p22.LocalFighter.IsSprintingLocally = p22.IsSprinting;
    p22[p22.IsSprinting and "_sprinting_start_time" or "_sprinting_release_time"] = tick();
    p22:_UpdateServerState("IsSprinting", p22.IsSprinting);
    p22.StateChanged:Fire("IsSprinting");
    p22:_UpdateWalkSpeed();

    if p22.IsSprinting then
        p22:SetCrouching(false);
    end;
end;

function u3.PlayMechanicsSound(p24, ...) -- Line: 186
    -- upvalues: ReplicatedStorage (copy)
    if p24.LocalFighter then
        ReplicatedStorage.Remotes.Replication.Fighter.PlayMechanicsSound:FireServer(...);

        return p24.LocalFighter:PlayMechanicsSound(...);
    end;
end;

function u3.StopSliding(p25, p26) -- Line: 196
    -- upvalues: CONSTANTS (copy)
    if not p25.IsSliding then
        return;
    end;

    if p25._sliding_last_floor then
        p25._sliding_last_floor.CustomPhysicalProperties = p25._sliding_last_floor_physical_properties;
        p25._sliding_last_floor = nil;
        p25._sliding_last_floor_physical_properties = nil;
    end;

    if p25._sliding_velocity then
        p25._sliding_velocity:Destroy();
        p25._sliding_velocity = nil;
    end;

    p25._sliding_cooldown = tick() + 0.25;
    p25._update_slide_direction = nil;
    p25.IsSliding = false;
    p25.LocalFighter.IsSlidingLocally = false;
    p25._sliding_release_time = tick();
    p25:_UpdateServerState("IsSliding", false);
    p25.StateChanged:Fire("IsSliding");
    p25:_UpdateWalkSpeed();

    if p25:IsAlive() then
        p25.LocalFighter.Entity:StopSlidingAnimation();
        p25.LocalFighter.Entity.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true);

        if p26 then
            local v27 = p25.LocalFighter.Entity.RootPart.Velocity * 0.6 + Vector3.new(0, CONSTANTS.BASE_JUMPPOWER * 0.5, 0);
            p25.LocalFighter.Entity:AirborneTrigger(v27, 12, true);
        end;

        if p25:IsInputDown("Sprint") then
            p25:SetSprinting(true);
        end;
    end;
end;

function u3.Slide(u28) -- Line: 238
    -- upvalues: Utility (copy), RunService (copy)
    if u28.IsSliding or (tick() < u28._sliding_cooldown or not (u28:IsAlive() and (u28.LocalFighter.Entity.Humanoid:GetState() ~= Enum.HumanoidStateType.Climbing and not (u28.LocalFighter:AreItemsLocked() or (not u28.LocalFighter:CanSlide() or u28:IsFrozen()))))) then
        return;
    end;

    u28._sliding_cooldown = (1 / 0);
    u28.IsSliding = true;
    u28.LocalFighter.IsSlidingLocally = true;
    u28._sliding_start_time = tick();
    u28:_UpdateServerState("IsSliding", true);
    u28.StateChanged:Fire("IsSliding");
    u28.LocalFighter.Entity.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false);
    u28.LocalFighter.Entity.Humanoid.AutoRotate = false;
    u28.LocalFighter.Entity:AirborneCancel();
    u28:SetCrouching(false);
    u28:SetSprinting(false);
    u28:_UpdateWalkSpeed();
    u28._sliding_velocity = Instance.new("BodyVelocity");
    u28._sliding_velocity.Parent = u28.LocalFighter.Entity.RootPart;
    local v29 = tick();
    local Y = u28.LocalFighter.Entity.RootPart.Position.Y;
    local v30 = nil;
    local u31 = nil;
    local v32 = u28:PlayMechanicsSound("Slide");
    local v33 = tick() + 0.25;
    local Rotation = u28.LocalFighter.Entity.RootPart.CFrame.Rotation;
    local v34 = u28:_GetWalkSpeed(true);

    function u28._update_slide_direction(p35) -- Line: 271
        -- upvalues: u31 (ref), u28 (copy)
        u31 = p35 or u28.LocalFighter:GetMoveVector(true, true, u28.LocalFighter.Entity.RootPart.CFrame.LookVector);
        task.spawn(u28.LocalFighter.Entity.PlaySlidingAnimationAsync, u28.LocalFighter.Entity, u31);
    end;

    u28._update_slide_direction();
    local v36 = 0;

    while u28:IsAlive() and (u28.IsSliding and tick() < v29 + 1) do
        local Floor = u28.LocalFighter:GetFloor();
        local Y2 = u28.LocalFighter.Entity.RootPart.Position.Y;

        if Floor then
            v30 = nil;
        else
            v30 = v30 or tick();
        end;

        if Y2 < Y - 1 then
            v29 = tick();

            if v32 and v33 < tick() then
                v32.TimePosition = 0;
                v32.Volume = 0;
            end;

            v33 = tick() + 0.25;
        else
            Y2 = math.max(Y, Y2);
        end;

        if v32 and (v32.Volume == 0 and Floor) then
            v32.TimePosition = 0;
            v32.Volume = 0.375;
        end;

        local v37 = u31.Magnitude <= 0.01 and u28.LocalFighter.Entity.RootPart.CFrame.LookVector or u31.Unit;
        local v38 = Vector3.new(0, 1, 0);

        if Floor ~= u28._sliding_last_floor then
            if u28._sliding_last_floor then
                u28._sliding_last_floor.CustomPhysicalProperties = u28._sliding_last_floor_physical_properties;
                u28._sliding_last_floor = nil;
                u28._sliding_last_floor_physical_properties = nil;
            end;

            if Floor and not Floor:IsA("Terrain") then
                u28._sliding_last_floor = Floor;
                u28._sliding_last_floor_physical_properties = u28._sliding_last_floor.CurrentPhysicalProperties;
            end;
        end;

        if Floor then
            local Position = u28.LocalFighter.Entity.RootPart.Position;
            local v39 = Position + v37 * 0.1;
            local v40 = Utility:Raycast(Position, Position + Vector3.new(0, -1, 0), 999, { Floor }, Enum.RaycastFilterType.Include);
            local v41 = Utility:Raycast(v39, v39 + Vector3.new(0, -1, 0), 999, { Floor }, Enum.RaycastFilterType.Include);

            if Utility:AngleBetweenVectors((v41.Position - v40.Position).Unit, Vector3.new(-0, -1, -0)) > 0.7853981633974483 then
                v37 = (v41.Position - v40.Position).Unit;
                v38 = v41.Normal or (v40.Normal or v38);
            end;
        end;

        if v38.Magnitude < 0.5 then
            u28.SlideStep:Fire();
        end;

        if Floor then
            v36 = (tick() - v29) / 1 or v36;
        end;

        local v42 = u28.LocalFighter:Get("SlidingSpeedMax") or 3;
        local v43 = v37 * (v42 + (1 - v42) * v36) * v34;
        local v44 = not v30 and Vector3.new(0, 0, 0) or v38 * -workspace.Gravity * (tick() - v30) ^ 2;
        u28._sliding_velocity.Velocity = v43 + v44;
        u28._sliding_velocity.MaxForce = Vector3.new(1, v30 and 0.1 or 1, 1) * 100000;

        if v43.Magnitude > 0.01 then
            u28.LocalFighter.Entity.RootPart.CFrame = u28.LocalFighter.Entity.RootPart.CFrame:Lerp(CFrame.new(u28.LocalFighter.Entity.RootPart.Position, u28.LocalFighter.Entity.RootPart.Position + v43), 0.25);
            Rotation = u28.LocalFighter.Entity.RootPart.CFrame.Rotation;
        else
            u28.LocalFighter.Entity.RootPart.CFrame = CFrame.new(u28.LocalFighter.Entity.RootPart.Position) * Rotation;
        end;

        RunService.RenderStepped:Wait();
        Y = Y2;
    end;

    v32:Destroy();

    if u28.IsSliding then
        u28:StopSliding();
    end;
end;

function u3.Jump(u45, p46, p47, p48) -- Line: 382
    if not u45:IsAlive() or (u45:IsFrozen() or not p48 and u45.LocalFighter.Entity:IsAirborne()) then
        return;
    end;

    u45._original_jump_power = u45._original_jump_power or u45.LocalFighter.Entity.Humanoid.JumpPower;
    u45._jump_hash = u45._jump_hash + 1;
    local _jump_hash = u45._jump_hash;
    u45.LocalFighter.Entity.Humanoid.JumpPower = (p46 or u45._original_jump_power) * (p47 or 1);
    u45.LocalFighter.Entity.Humanoid.Jump = true;

    if p46 or p47 then
        task.defer(function() -- Line: 395
            -- upvalues: _jump_hash (copy), u45 (copy)
            if _jump_hash ~= u45._jump_hash or not u45:IsAlive() then
                return;
            end;

            u45.LocalFighter.Entity.Humanoid.JumpPower = u45._original_jump_power;
            u45._original_jump_power = nil;
        end);
    end;
end;

function u3.DoubleJump(p49) -- Line: 406
    if not p49:IsAlive() or p49:IsFrozen() then
        return;
    end;

    local MoveVector = p49.LocalFighter:GetMoveVector(true, true);
    p49.LocalFighter.Entity.RootPart.Velocity = MoveVector * p49.LocalFighter.Entity.Humanoid.WalkSpeed * 1 + Vector3.new(0, p49.LocalFighter.Entity.Humanoid.JumpPower * 1.1, 0);
    p49.LocalFighter.Entity:AirborneRedirect();
    p49:PlayMechanicsSound("DoubleJump");
end;

function u3.JumpRequest(p50, ...) -- Line: 419
    p50:Jump(...);
end;

function u3.DoubleJumpRequest(p51) -- Line: 423
    local v52 = p51.LocalFighter and p51.LocalFighter.EquippedItem and p51.LocalFighter.EquippedItem:Get("ObjectID");
    local v53 = p51.LocalFighter and (p51.LocalFighter.EquippedItem and not p51.LocalFighter:Get("DisableDoubleJumping")) and p51.LocalFighter.EquippedItem.Info.MaxDoubleJumps;

    if v52 and (v53 and ((p51._double_jumps_used[v52] or 0) < (v53 or 0) and not p51.LocalFighter:IsGrounded())) then
        p51._double_jumps_used[v52] = (p51._double_jumps_used[v52] or 0) + 1;
        p51:DoubleJump();
    end;
end;

function u3.HighJump(p54) -- Line: 433
    if not p54:IsAlive() then
        return;
    end;

    p54:StopSliding(true);
    p54:_SpamJumpRequests(nil, 1.25, true);
end;

function u3.EquippedItemInput(p55, ...) -- Line: 442
    if not p55.LocalFighter then
        return;
    end;

    p55.LocalFighter:Input(...);
end;

function u3.SimulateInputBegan(u56, p57, p58) -- Line: 451
    -- upvalues: InputLibrary (copy), UserInterfaceController (copy), u1 (copy), ControlsController (copy), CameraController (copy), SpectateController (copy), PlayerDataController (copy), EmoteController (copy), CONSTANTS (copy), ReplicatedStorage (copy)
    if InputLibrary:InputIs(p57, "UseEmote") then
        local Page = UserInterfaceController:GetPage("PickEmote");

        if Page and Page:IsOpen() then
            Page:SetAllEmotesOpen(true);
        end;
    end;

    if u56:AreInputsDisabled() then
        return;
    end;

    for _, v in pairs(u1) do
        if InputLibrary:InputIs(p57, v) and ControlsController:IsToggled(v) then
            ControlsController:ToggleInput(v, false);

            return u56:SimulateInputEnded(p57, p58);
        end;

        if InputLibrary:InputIs(p57, v) and u56:_IsToggleInput(v) then
            ControlsController:ToggleInput(v, true);
        end;
    end;

    if p58 and (not UserInterfaceController:IsPageOpen("Panels") and ControlsController.CurrentControls == "MouseKeyboard") then
        return;
    end;

    if CameraController:GetPublicState() == CameraController.CameraState.States.ThirdPersonUnlockedMouse and p57.UserInputType == Enum.UserInputType.MouseButton2 then
        return;
    end;

    if InputLibrary:InputIs(p57, "OpenPlayerList") then
        if SpectateController.CurrentDuelSubject then
            SpectateController.CurrentDuelSubject.DuelInterface.Scoreboard:Open(true);
        end;
    elseif InputLibrary:InputIs(p57, "Ping") then
        u56.LocalFighter:Ping();
    end;

    if not u56:IsAlive() then
        return;
    end;

    if InputLibrary:InputIs(p57, "Jump") and u56.LocalFighter.Entity.Humanoid:GetState() ~= Enum.HumanoidStateType.Climbing then
        if u56.IsSliding then
            u56:HighJump();

            return;
        end;

        u56:DoubleJumpRequest();
        u56:_SpamJumpRequests();

        return;
    end;

    if not InputLibrary:InputIs(p57, "Crouch") or (u56.IsSliding or u56:IsFrozen()) then
        if InputLibrary:InputIs(p57, "Slide") and (not u56.IsSliding and u56.LocalFighter:IsGrounded()) then
            u56:Slide();

            return;
        end;

        if (InputLibrary:InputIs(p57, "Sprint") or InputLibrary:InputIs(p57, "AutoSprint")) and not u56.IsSliding then
            u56:SetSprinting(true);

            return;
        end;

        if InputLibrary:InputIs(p57, "LeanLeft") then
            if not u56._is_leaning_left then
                u56._is_leaning_left = true;
                u56:SetCameraLean(u56.CameraLean - 1);

                return;
            end;
        elseif InputLibrary:InputIs(p57, "LeanRight") then
            if not u56._is_leaning_right then
                u56._is_leaning_right = true;
                u56:SetCameraLean(u56.CameraLean + 1);

                return;
            end;
        else
            if EmoteController:CanEmote() then
                for i = 1, CONSTANTS.MAX_EQUIPPABLE_EMOTES do
                    local v59;

                    if InputLibrary:InputIs(p57, "UseEmote" .. i) then
                        EmoteController:UseEmote((tostring(i)));
                        v59 = i;
                    else
                        v59 = i;
                    end;
                end;
            end;

            if InputLibrary:InputIs(p57, "EquipPrimary") then
                u56.LocalFighter:EquipItem(1);

                return;
            end;

            if InputLibrary:InputIs(p57, "EquipSecondary") then
                u56.LocalFighter:EquipItem(2);

                return;
            end;

            if InputLibrary:InputIs(p57, "EquipMelee") then
                u56.LocalFighter:EquipItem(3);

                return;
            end;

            if InputLibrary:InputIs(p57, "EquipUtility") then
                u56.LocalFighter:EquipItem(4);

                return;
            end;

            if InputLibrary:InputIs(p57, "EquipLast") then
                u56.LocalFighter:EquipIncrement(-1);

                return;
            end;

            if InputLibrary:InputIs(p57, "EquipNext") then
                u56.LocalFighter:EquipIncrement(1);

                return;
            end;

            if InputLibrary:InputIs(p57, "QuickMelee") then
                u56.LocalFighter:QuickAttackDown("Melee", p57);

                return;
            end;

            if InputLibrary:InputIs(p57, "QuickUtility") then
                u56.LocalFighter:QuickAttackDown("Utility", p57);

                return;
            end;

            if InputLibrary:InputIs(p57, "UseEmote") and EmoteController:CanEmote() then
                local Page = UserInterfaceController:GetPage("PickEmote");

                if not (Page and Page:IsOpen()) then
                    UserInterfaceController:OpenPage("PickEmote", true);

                    return;
                end;
            else
                if u56.LocalFighter.EquippedItem then
                    for _, v in pairs(InputLibrary.ItemInputs) do
                        if InputLibrary:InputIs(p57, v) then
                            task.spawn(function() -- Line: 565
                                -- upvalues: InputLibrary (ref), v (copy), u56 (copy)
                                local StartName = InputLibrary.Inputs[v].StartName;

                                if u56.LocalFighter.EquippedItem.Info.InputSpammingEnabled[StartName] then
                                    u56:_InputSpam(v, StartName);

                                    return;
                                end;

                                u56:EquippedItemInput(StartName);
                            end);
                        end;
                    end;

                    return;
                end;

                if InputLibrary:InputIs(p57, "Shoot") and (u56.LocalFighter.Entity and u56.LocalFighter.Entity:Get("IsGrabbingSnowball")) then
                    local CameraData = u56.LocalFighter:GetCameraData(nil, nil, true, true);
                    local v60 = CameraData[utf8.char(2)];
                    local v61 = CameraData[utf8.char(3)];

                    if v60 then
                        v60 = v60.CFrame * v61;
                    end;

                    if v60 then
                        ReplicatedStorage.Remotes.Replication.Fighter.SnowballThrow:FireServer(v60.Position);
                    end;
                end;
            end;
        end;

        return;
    end;

    local v62 = u56.IsSprinting or tick() - u56._sprinting_release_time < 0.125;
    local v63;

    if ControlsController.CurrentControls == "Touch" then
        v63 = PlayerDataController:GetSetting("Easy Slide Mobile");
    else
        v63 = PlayerDataController:GetSetting("Easy Slide");
    end;

    if v63 and (v62 and (u56.LocalFighter:GetMoveVector(true, true).Magnitude > 0.01 and u56.LocalFighter:IsGrounded())) then
        u56:Slide();

        return;
    end;

    u56:SetCrouching(true);
end;

function u3.SimulateInputEnded(p64, p65) -- Line: 588
    -- upvalues: CameraController (copy), u1 (copy), InputLibrary (copy), ControlsController (copy), SpectateController (copy), UserInterfaceController (copy)
    if not p64.LocalFighter then
        return;
    end;

    if CameraController:GetPublicState() == CameraController.CameraState.States.ThirdPersonUnlockedMouse and p65.UserInputType == Enum.UserInputType.MouseButton2 then
        return;
    end;

    for _, v in pairs(u1) do
        if InputLibrary:InputIs(p65, v) and (p64:_IsToggleInput(v) and ControlsController:IsToggled(v)) then
            return;
        end;
    end;

    if InputLibrary:InputIs(p65, "Crouch") then
        if p64.IsCrouching then
            p64:SetCrouching(false);

            if p64:IsInputDown("Sprint") then
                p64:SetSprinting(true);
            end;
        end;
    elseif InputLibrary:InputIs(p65, "Sprint") or InputLibrary:InputIs(p65, "AutoSprint") then
        p64:SetSprinting(false);
    elseif InputLibrary:InputIs(p65, "LeanLeft") then
        if p64._is_leaning_left then
            p64._is_leaning_left = false;
            p64:SetCameraLean(p64.CameraLean + 1);
        end;
    elseif InputLibrary:InputIs(p65, "LeanRight") and p64._is_leaning_right then
        p64._is_leaning_right = false;
        p64:SetCameraLean(p64.CameraLean - 1);
    end;

    if InputLibrary:InputIs(p65, "QuickMelee") then
        p64.LocalFighter:QuickAttackUp("Melee");

        return;
    end;

    if InputLibrary:InputIs(p65, "QuickUtility") then
        p64.LocalFighter:QuickAttackUp("Utility");

        return;
    end;

    if InputLibrary:InputIs(p65, "OpenPlayerList") then
        if SpectateController.CurrentDuelSubject then
            SpectateController.CurrentDuelSubject.DuelInterface.Scoreboard:Open(false);
        end;
    elseif InputLibrary:InputIs(p65, "UseEmote") and ControlsController.CurrentControls == "MouseKeyboard" then
        local Page = UserInterfaceController:GetPage("PickEmote");

        if Page then
            Page:PickEarly();
        end;
    elseif p64.LocalFighter.EquippedItem then
        for _, v in pairs(InputLibrary.ItemInputs) do
            if InputLibrary:InputIs(p65, v) then
                p64:EquippedItemInput(InputLibrary.Inputs[v].FinishName);
            end;
        end;
    end;
end;

function u3.MobileInput(p66, p67, p68) -- Line: 651
    -- upvalues: InputLibrary (copy)
    if p68 and p66:AreInputsDisabled() then
        return;
    end;

    local v69 = InputLibrary.MobileButtons[p67];
    local v70;

    if v69 then
        v70 = v69.InputName or p67;
    else
        v70 = p67;
    end;

    p66._mobile_input_down[v70] = p68;
    p66[p68 and "SimulateInputBegan" or "SimulateInputEnded"](p66, p67, false);
end;

function u3.WaitForLocalFighter(p71) -- Line: 662
    if not p71.LocalFighter then
        p71._internal_local_fighter_added:Wait();
    end;

    return p71.LocalFighter;
end;

function u3._CanAutoShoot(p72) -- Line: 674
    -- upvalues: ControlsController (copy), DebugState (copy)
    if p72.LocalFighter and (p72.LocalFighter.EquippedItem and not p72.LocalFighter:Get("IsHiddenByCutscene")) then
        return (ControlsController.CurrentControls == "Touch" or ControlsController.CurrentControls == "Gamepad") and true or (p72.LocalFighter:Get("CheaterMode") or DebugState:Get("AreHandicapsEnabled"));
    end;

    return false;
end;

function u3._ToggleAutoShoot(u73) -- Line: 682
    -- upvalues: PlayerDataController (copy), Players (copy), Utility (copy), GameplayUtility (copy), RunService (copy)
    u73._auto_shoot_hash = u73._auto_shoot_hash + 1;
    local _auto_shoot_hash = u73._auto_shoot_hash;

    if u73._auto_shoot_connection then
        u73._auto_shoot_connection:Disconnect();
        u73._auto_shoot_connection = nil;
    end;

    if not u73:_CanAutoShoot() then
        return;
    end;

    local v74 = u73.LocalFighter:Get("CheaterMode");
    local u75 = v74 and 0 or PlayerDataController:GetSetting("Auto Shoot Reaction Time") / 1000;
    local v76;

    if v74 then
        v76 = nil;
    else
        v76 = PlayerDataController:GetSetting("Auto Shoot");
    end;

    local v77;

    if v74 then
        v77 = nil;
    else
        v77 = u73.LocalFighter:Get("AutoShootRestriction");
    end;

    local u78;

    if v74 then
        u78 = nil;
    else
        u78 = v77 or v76;
    end;

    if v76 == "Disabled" or v77 == "Disabled" then
        return;
    end;

    local u79 = nil;
    local u80 = 0;
    local u81 = true;

    local function can_autoshoot() -- Line: 709
        -- upvalues: u73 (copy), u80 (ref), u79 (ref), Players (ref), Utility (ref), GameplayUtility (ref)
        local v82 = u73.LocalFighter and u73.LocalFighter.EquippedItem and u73.LocalFighter:IsAlive();

        if not v82 then
            return;
        end;

        local AutoShootReactionTime = u73.LocalFighter.EquippedItem:GetAutoShootReactionTime();
        local AutoShootReach = u73.LocalFighter.EquippedItem:GetAutoShootReach();

        if not (AutoShootReactionTime and AutoShootReach) then
            return;
        end;

        if u80 < tick() then
            u80 = tick() + 2;
            u79 = u73.LocalFighter:GetRaycastWhitelist(true, { u73.LocalFighter }, nil, true);
        end;

        if Players.LocalPlayer.PlayerGui:FindFirstChild("FlashbangGui") then
            return;
        end;

        local v83 = Utility:Raycast(workspace.CurrentCamera.CFrame.Position, workspace.CurrentCamera.CFrame.Position + workspace.CurrentCamera.CFrame.LookVector * AutoShootReach, AutoShootReach, u79, Enum.RaycastFilterType.Include);

        if not v83.Instance then
            return;
        end;

        if Utility:AngleBetweenVectors(workspace.CurrentCamera.CFrame.LookVector, CFrame.new(u73.LocalFighter.Entity.RootPart.Position, v83.Instance.Position).LookVector) >= 1.5707963267948966 then
            return;
        end;

        local v84 = v83.Instance and (v83.Instance.AssemblyRootPart and v83.Instance.AssemblyRootPart.Parent) and v83.Instance.AssemblyRootPart.Parent:HasTag("Entity") and GameplayUtility:GetEntityFromModel(v83.Instance.AssemblyRootPart.Parent);

        if not (v84 and (not v84.AimAssistBlacklist and v84:IsAlive())) then
            return;
        end;

        if not GameplayUtility:GetSmokeCloudBetweenPoints(workspace.CurrentCamera.CFrame.Position, v83.Position) then
            return u73.LocalFighter.EquippedItem, AutoShootReactionTime;
        end;
    end;

    local function finish_shooting(p85) -- Line: 763
        -- upvalues: u81 (ref), u73 (copy)
        if not u81 then
            return;
        end;

        u81 = false;
        task.delay(p85 or 0, u73.EquippedItemInput, u73, "FinishShooting");
    end;

    local function start_shooting() -- Line: 772
        -- upvalues: u81 (ref), u73 (copy)
        u81 = true;
        u73:EquippedItemInput("StartShooting");

        if u73.LocalFighter.EquippedItem and u73.LocalFighter.EquippedItem.Name ~= "Flamethrower" then
            if not u81 then
                return;
            end;

            u81 = false;
            task.delay(0.03, u73.EquippedItemInput, u73, "FinishShooting");
        end;
    end;

    local u86 = false;

    local function hold(p87) -- Line: 784
        -- upvalues: u86 (ref), u73 (copy), can_autoshoot (copy), u81 (ref), RunService (ref), _auto_shoot_hash (copy)
        if u86 then
            return;
        end;

        u86 = true;
        local EquippedItem = u73.LocalFighter.EquippedItem;
        local v88 = tick() + p87;

        while true do
            local _, v89 = can_autoshoot();

            if not v89 or u73.LocalFighter.EquippedItem ~= EquippedItem then
                break;
            end;

            if v88 < tick() then
                u81 = true;
                u73:EquippedItemInput("StartShooting");

                if u73.LocalFighter.EquippedItem and (u73.LocalFighter.EquippedItem.Name ~= "Flamethrower" and u81) then
                    u81 = false;
                    task.delay(0.03, u73.EquippedItemInput, u73, "FinishShooting");
                end;
            end;

            RunService.RenderStepped:Wait();

            if _auto_shoot_hash ~= u73._auto_shoot_hash then
                return;
            end;
        end;

        u86 = false;
    end;

    u73._auto_shoot_connection = RunService.RenderStepped:Connect(function() -- Line: 815
        -- upvalues: u86 (ref), can_autoshoot (copy), u81 (ref), u73 (copy), u78 (copy), u75 (copy), hold (copy)
        if u86 then
            return;
        end;

        local _, v90 = can_autoshoot();

        if v90 then
            local v91;

            if u78 == "Dynamic" then
                v91 = math.clamp(v90, 0.025, 0.125);
            else
                v91 = u75;
            end;

            task.defer(hold, v91);

            return;
        end;

        if not u81 then
            return;
        end;

        u81 = false;
        task.delay(0, u73.EquippedItemInput, u73, "FinishShooting");
    end);
end;

function u3._IsToggleInput(p92, p93) -- Line: 833
    -- upvalues: ControlsController (copy), u2 (copy), SettingsLibrary (copy), PlayerDataController (copy)
    local v94;

    if ControlsController.CurrentControls == "Touch" then
        v94 = u2[p93];
    else
        v94 = nil;
    end;

    local v95 = "Toggle " .. p93;

    if v94 == nil then
        v94 = SettingsLibrary.Info[v95] and PlayerDataController:GetSetting(v95);
    end;

    local v96 = p92.LocalFighter and p92.LocalFighter.EquippedItem and p92.LocalFighter.EquippedItem.ToggleAimEnabled;

    if v94 then
        v94 = p93 ~= "Aim" and true or v96;
    end;

    return v94;
end;

function u3._AutoSprintEnabled(p97) -- Line: 842
    -- upvalues: PlayerDataController (copy), ControlsController (copy)
    return PlayerDataController:GetSetting("Auto Sprint") or ControlsController.CurrentControls == "Touch";
end;

function u3._UpdateServerState(p98, p99, ...) -- Line: 846
    -- upvalues: ReplicatedStorage (copy), EnumLibrary (copy)
    ReplicatedStorage.Remotes.Replication.Fighter.UpdateState:FireServer(EnumLibrary:ToEnum(p99), ...);
end;

function u3._InputSpam(p100, p101, p102) -- Line: 851
    -- upvalues: RunService (copy)
    if p100._is_input_spamming[p101] then
        return;
    end;

    p100._is_input_spamming[p101] = true;

    while p100.LocalFighter and (p100.LocalFighter.EquippedItem and (p100.LocalFighter.EquippedItem.Info.InputSpammingEnabled[p102] and p100:IsInputDown(p101))) do
        local v103 = p100:_IsToggleInput(p101);
        p100:EquippedItemInput(p102);
        local v104 = not v103 and p100.LocalFighter.EquippedItem.Info.InputSpammingEnabled[p102];

        if not v104 then
            break;
        end;

        if v104 <= 0 then
            RunService.RenderStepped:Wait();
        else
            wait(v104);
        end;
    end;

    p100._is_input_spamming[p101] = false;
end;

function u3._SpamJumpRequests(p105, ...) -- Line: 882
    -- upvalues: RunService (copy)
    while not p105.IsSliding and p105:IsInputDown("Jump") do
        p105:JumpRequest(...);
        RunService.RenderStepped:Wait();
    end;
end;

function u3._GetWalkSpeed(p106, p107) -- Line: 890
    -- upvalues: UserInterfaceController (copy), CosmeticLibrary (copy), CONSTANTS (copy)
    if p106:IsFrozen() then
        return 0;
    end;

    local v108 = p106.LocalFighter.Entity:IsEmoting();
    local CurrentEmote = p106.LocalFighter.Entity:GetCurrentEmote();
    local v109 = UserInterfaceController:IsPageOpen();
    local v110 = p106.IsSprinting and not v108 and (p106.LocalFighter:Get("SprintingSpeedBoost") or 0.5) or 0;
    local v111 = p106.LocalFighter and p106.LocalFighter.Entity and (p106.LocalFighter.Entity:GetBoost("Speed") or 0) or 0;

    return CONSTANTS.BASE_WALKSPEED * (1 + (v110 + v111)) * ((v109 and v109.Name == "PickEmote" and 0 or 1) * (v108 and CosmeticLibrary.Cosmetics[CurrentEmote.Name].TraversalWalkSpeedMultiplier or 1) * (p106.LocalFighter and p106.LocalFighter.EquippedItem and (p106.LocalFighter.EquippedItem.Info.WalkSpeedMultiplier or 1) or 1) * (p106.IsCrouching and 0.5 or 1) * (p106.IsSliding and not p107 and 0 or 1));
end;

function u3._UpdateWalkSpeed(p112) -- Line: 913
    if p112.IsSliding or not p112:IsAlive() then
        return;
    end;

    p112.LocalFighter.Entity.Humanoid.WalkSpeed = p112:_GetWalkSpeed();
end;

function u3._UpdateCharacterRotation(p113) -- Line: 921
    -- upvalues: CameraController (copy)
    if p113.IsSliding or not p113:IsAlive() then
        return;
    end;

    local PublicState = CameraController:GetPublicState();
    local v114 = p113.LocalFighter.Entity:IsEmoting();
    p113.LocalFighter.Entity.Humanoid.AutoRotate = not PublicState or PublicState == CameraController.CameraState.States.ThirdPersonUnlockedMouse;

    if not (PublicState and (PublicState ~= CameraController.CameraState.States.CustomFreecam and (PublicState ~= CameraController.CameraState.States.ThirdPersonUnlockedMouse or not v114))) then
        return;
    end;

    local v115 = workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1);

    if v115.Magnitude > 0.01 then
        p113.LocalFighter.Entity.RootPart.CFrame = CFrame.new(p113.LocalFighter.Entity.RootPart.Position, p113.LocalFighter.Entity.RootPart.Position + v115);
    end;
end;

function u3._SetupControls(u116) -- Line: 942
    -- upvalues: RunService (copy), ControlsController (copy), UserInputService (copy), CameraController (copy), PlayerDataController (copy)
    for _, v in pairs(u116._controls_connections) do
        v:Disconnect();
    end;

    u116._controls_connections = {};

    if u116:IsMobileInputDown("AutoSprint") then
        task.spawn(u116.MobileInput, u116, "AutoSprint", false);
    end;

    if not u116.LocalFighter then
        return;
    end;

    RunService.RenderStepped:Connect(function() -- Line: 958
        -- upvalues: u116 (copy)
        u116:_UpdateCharacterRotation();
        u116:_UpdateWalkSpeed();

        if not u116:_AutoSprintEnabled() then
            return;
        end;

        local v117 = u116.LocalFighter and not u116.IsCrouching and not u116.IsSliding and u116.LocalFighter:GetMoveVector();

        if v117 then
            v117 = v117.Magnitude >= 0.9;
        end;

        if v117 and not u116.IsSprinting then
            u116:MobileInput("AutoSprint", true);

            return;
        end;

        if not v117 and u116.IsSprinting then
            u116:MobileInput("AutoSprint", false);
        end;
    end);

    if ControlsController.CurrentControls == "Touch" then
        return;
    end;

    table.insert(u116._controls_connections, UserInputService.InputBegan:Connect(function(...) -- Line: 982
        -- upvalues: u116 (copy)
        u116:SimulateInputBegan(...);
    end));
    table.insert(u116._controls_connections, UserInputService.InputEnded:Connect(function(...) -- Line: 986
        -- upvalues: u116 (copy)
        u116:SimulateInputEnded(...);
    end));

    if ControlsController.CurrentControls == "MouseKeyboard" then
        table.insert(u116._controls_connections, UserInputService.InputChanged:Connect(function(p118, p119) -- Line: 992
            -- upvalues: CameraController (ref), u116 (copy), PlayerDataController (ref)
            if p119 or (CameraController:GetPublicState() == CameraController.CameraState.States.ThirdPersonUnlockedMouse or not (u116:IsAlive() and PlayerDataController:GetSetting("Scroll Equip"))) then
                return;
            end;

            if p118.UserInputType == Enum.UserInputType.MouseWheel then
                local v120 = math.floor(u116._scroll_delta + p118.Position.Z) - math.floor(u116._scroll_delta);
                local v121 = u116;
                v121._scroll_delta = v121._scroll_delta + p118.Position.Z;

                if math.abs(v120) > 0 then
                    u116.LocalFighter:EquipIncrement(-math.sign(v120));
                end;
            end;
        end));
    end;
end;

function u3._BindMovementActionsLoop(p122) -- Line: 1010
    -- upvalues: Players (copy), ContextActionService (copy), InputLibrary (copy), PlayerDataController (copy)
    local ControlModule = require(Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"));
    local Keyboard = require(Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"):WaitForChild("Keyboard"));

    local function get_keyboard_module() -- Line: 1016
        -- upvalues: ControlModule (copy), Keyboard (copy)
        for i, v in pairs(ControlModule.controllers) do
            if i == Keyboard then
                return v;
            end;
        end;
    end;

    local u139 = {
        WalkForward = { "moveForwardAction", function(p123, p124, p125) -- Line: 1024
                -- upvalues: ControlModule (copy), Keyboard (copy)
                local v126 = nil;

                for i, v in pairs(ControlModule.controllers) do
                    if i == Keyboard then
                        v126 = v;
                        break;
                    end;
                end;

                if v126 then
                    v126.forwardValue = p124 == Enum.UserInputState.Begin and -1 or 0;
                    v126:UpdateMovement(p124);

                    return Enum.ContextActionResult.Pass;
                end;
            end },
        WalkBackward = { "moveBackwardAction", function(p127, p128, p129) -- Line: 1036
                -- upvalues: ControlModule (copy), Keyboard (copy)
                local v130 = nil;

                for i, v in pairs(ControlModule.controllers) do
                    if i == Keyboard then
                        v130 = v;
                        break;
                    end;
                end;

                if v130 then
                    v130.backwardValue = p128 == Enum.UserInputState.Begin and 1 or 0;
                    v130:UpdateMovement(p128);

                    return Enum.ContextActionResult.Pass;
                end;
            end },
        WalkLeftward = { "moveLeftAction", function(p131, p132, p133) -- Line: 1048
                -- upvalues: ControlModule (copy), Keyboard (copy)
                local v134 = nil;

                for i, v in pairs(ControlModule.controllers) do
                    if i == Keyboard then
                        v134 = v;
                        break;
                    end;
                end;

                if v134 then
                    v134.leftValue = p132 == Enum.UserInputState.Begin and -1 or 0;
                    v134:UpdateMovement(p132);

                    return Enum.ContextActionResult.Pass;
                end;
            end },
        WalkRightward = { "moveRightAction", function(p135, p136, p137) -- Line: 1060
                -- upvalues: ControlModule (copy), Keyboard (copy)
                local v138 = nil;

                for i, v in pairs(ControlModule.controllers) do
                    if i == Keyboard then
                        v138 = v;
                        break;
                    end;
                end;

                if v138 then
                    v138.rightValue = p136 == Enum.UserInputState.Begin and 1 or 0;
                    v138:UpdateMovement(p136);

                    return Enum.ContextActionResult.Pass;
                end;
            end }
    };

    local function update(p140) -- Line: 1080
        -- upvalues: u139 (copy), ContextActionService (ref), InputLibrary (ref)
        local table_unpack_ret, v141 = table.unpack(u139[p140]);

        if ContextActionService:GetBoundActionInfo(table_unpack_ret) then
            ContextActionService:UnbindAction(table_unpack_ret);
        end;

        local Inputs = InputLibrary:GetInputs(p140);

        if Inputs and #Inputs > 0 then
            ContextActionService:BindActionAtPriority(table_unpack_ret, v141, false, 2000, table.unpack(Inputs));
        end;
    end;

    for i in pairs(u139) do
        local u142 = i;

        for _, v in pairs(InputLibrary.HOTKEY_FORMATS) do
            for _, v2 in pairs(v) do
                PlayerDataController:GetSettingChangedSignal(string.format(v2, u142)):Connect(function() -- Line: 1097
                    -- upvalues: update (copy), u142 (copy)
                    update(u142);
                end);
            end;
        end;
    end;

    while true do
        for i, v in pairs(u139) do
            local table_unpack_ret, _ = table.unpack(v);
            local BoundActionInfo = ContextActionService:GetBoundActionInfo(table_unpack_ret);
            local v143 = not (BoundActionInfo and (BoundActionInfo.inputTypes and BoundActionInfo.inputTypes[1]));

            if not v143 then
                if typeof(BoundActionInfo.inputTypes[1]) == "EnumItem" then
                    v143 = BoundActionInfo.inputTypes[1].EnumType == Enum.PlayerActions;
                else
                    v143 = false;
                end;
            end;

            if v143 then
                update(i);
            end;
        end;

        wait(1);
    end;
end;

function u3._DisableRobloxJumpButton(p144) -- Line: 1121
    -- upvalues: ContextActionService (copy)
    while true do
        if next(ContextActionService:GetBoundActionInfo("jumpAction") or {}) then
            ContextActionService:UnbindAction("jumpAction");
        end;

        wait(1);
    end;
end;

function u3._HookFighter(u145) -- Line: 1133
    -- upvalues: Players (copy), PlayerDataController (copy), CONSTANTS (copy)
    u145.LocalFighter = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController):WaitForLocalFighter();
    u145.LocalFighter.StopSliding:Connect(function() -- Line: 1136
        -- upvalues: u145 (copy)
        u145:StopSliding();
    end);
    u145.LocalFighter:GetDataChangedSignal("AutoShootRestriction"):Connect(function() -- Line: 1140
        -- upvalues: u145 (copy)
        u145:_ToggleAutoShoot();
    end);
    u145.LocalFighter:GetDataChangedSignal("CheaterMode"):Connect(function() -- Line: 1144
        -- upvalues: u145 (copy)
        u145:_ToggleAutoShoot();
    end);
    u145.LocalFighter:GetDataChangedSignal("IsHiddenByCutscene"):Connect(function() -- Line: 1148
        -- upvalues: u145 (copy)
        u145:_ToggleAutoShoot();
    end);
    local u146 = {};
    u145.LocalFighter.EquippedItemChanged:Connect(function(p147) -- Line: 1154
        -- upvalues: u146 (ref), u145 (copy)
        for _, v in pairs(u146) do
            v:Disconnect();
        end;

        u146 = {};
        u145:_UpdateWalkSpeed();
        u145:_ToggleAutoShoot();

        if not p147 then
            return;
        end;

        table.insert(u146, p147.StopSprinting:Connect(function() -- Line: 1168
            -- upvalues: u145 (ref)
            u145:SetSprinting(false);
        end));
        table.insert(u146, p147.AttemptToSprintAgain:Connect(function() -- Line: 1172
            -- upvalues: u145 (ref)
            if u145:IsInputDown("Sprint") or u145:IsInputDown("AutoSprint") then
                u145:SetSprinting(true);
            end;
        end));
    end);

    local function update_auto_jump() -- Line: 1179
        -- upvalues: u145 (copy), PlayerDataController (ref)
        if u145.LocalFighter.Entity and u145.LocalFighter.Entity.Humanoid then
            u145.LocalFighter.Entity.Humanoid.AutoJumpEnabled = PlayerDataController:GetSetting("Auto Jump") or u145.LocalFighter.Entity:IsAirborne();
        end;
    end;

    PlayerDataController:GetSettingChangedSignal("Auto Jump"):Connect(update_auto_jump);

    local function entity_added(u148) -- Line: 1187
        -- upvalues: u145 (copy), CONSTANTS (ref), PlayerDataController (ref)
        u145._original_humanoid_animations = {};
        u145._double_jumps_used = {};
        u145:SetCrouching(false);
        u145:SetSprinting(false);
        u145:StopSliding();
        u145:_UpdateWalkSpeed();
        u148.Humanoid.CameraOffset = Vector3.new(0, 1, 0);
        local BodyForce = Instance.new("BodyForce");
        BodyForce.Name = "CustomGravity";
        BodyForce.Parent = u148.RootPart;

        local function update_gravity() -- Line: 1205
            -- upvalues: u145 (ref), u148 (copy), CONSTANTS (ref), BodyForce (copy)
            local v149 = not u145.IsCrouching and u148:Get("Gravity") or 1;
            BodyForce.Force = Vector3.new(0, u148.RootPart.AssemblyMass * workspace.Gravity * (1 - CONSTANTS.BASE_GRAVITY * v149), 0);
            u148.Humanoid.JumpPower = CONSTANTS.BASE_JUMPPOWER;
        end;

        u148:GetDataChangedSignal("Gravity"):Connect(update_gravity);
        u148.EmoteStatusChanged:Connect(update_gravity);
        u145.StateChanged:Connect(update_gravity);
        local v150 = u145.IsCrouching and 1 or (u148:Get("Gravity") or 1);
        BodyForce.Force = Vector3.new(0, u148.RootPart.AssemblyMass * workspace.Gravity * (1 - CONSTANTS.BASE_GRAVITY * v150), 0);
        u148.Humanoid.JumpPower = CONSTANTS.BASE_JUMPPOWER;
        u148.Model.DescendantAdded:Connect(function(p151) -- Line: 1219, Name: descendant_added
            -- upvalues: update_gravity (copy)
            if p151:IsA("BasePart") then
                p151:GetPropertyChangedSignal("AssemblyMass"):Connect(update_gravity);
                p151:GetPropertyChangedSignal("Mass"):Connect(update_gravity);
            end;
        end);

        for _, descendant in pairs(u148.Model:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant:GetPropertyChangedSignal("AssemblyMass"):Connect(update_gravity);
                descendant:GetPropertyChangedSignal("Mass"):Connect(update_gravity);
            end;
        end;

        u148.Humanoid.Jumping:Connect(function() -- Line: 1232
            -- upvalues: u145 (ref), u148 (copy), CONSTANTS (ref), BodyForce (copy)
            local v152 = not u145.IsCrouching and u148:Get("Gravity") or 1;
            BodyForce.Force = Vector3.new(0, u148.RootPart.AssemblyMass * workspace.Gravity * (1 - CONSTANTS.BASE_GRAVITY * v152), 0);
            u148.Humanoid.JumpPower = CONSTANTS.BASE_JUMPPOWER;
            u145:StopSliding(true);
        end);
        u148.Humanoid.StateChanged:Connect(function(p153, p154) -- Line: 1237
            -- upvalues: u145 (ref), u148 (copy), CONSTANTS (ref), BodyForce (copy)
            local v155 = u145.IsCrouching and 1 or (u148:Get("Gravity") or 1);
            BodyForce.Force = Vector3.new(0, u148.RootPart.AssemblyMass * workspace.Gravity * (1 - CONSTANTS.BASE_GRAVITY * v155), 0);
            u148.Humanoid.JumpPower = CONSTANTS.BASE_JUMPPOWER;

            if p154 == Enum.HumanoidStateType.Climbing then
                u145:StopSliding();

                return;
            end;

            if p154 == Enum.HumanoidStateType.Landed then
                u145._double_jumps_used = {};
            end;
        end);
        u148.Humanoid.Died:Connect(function() -- Line: 1247
            -- upvalues: u145 (ref)
            u145:SetSprinting(false);
            u145:SetCrouching(false);
            u145:StopSliding();
        end);
        u148.AirborneChanged:Connect(function() -- Line: 1253
            -- upvalues: u145 (ref), u148 (copy), PlayerDataController (ref)
            u145:_UpdateServerState("IsAirborne", u148:IsAirborne());

            if u145.LocalFighter.Entity and u145.LocalFighter.Entity.Humanoid then
                u145.LocalFighter.Entity.Humanoid.AutoJumpEnabled = PlayerDataController:GetSetting("Auto Jump") or u145.LocalFighter.Entity:IsAirborne();
            end;
        end);
        u148.RedirectSliding:Connect(function(p156) -- Line: 1258
            -- upvalues: u145 (ref)
            if u145._update_slide_direction then
                u145._update_slide_direction(p156);
            end;
        end);

        if u145.LocalFighter.Entity and u145.LocalFighter.Entity.Humanoid then
            u145.LocalFighter.Entity.Humanoid.AutoJumpEnabled = PlayerDataController:GetSetting("Auto Jump") or u145.LocalFighter.Entity:IsAirborne();
        end;
    end;

    u145.LocalFighter.EntityAdded:Connect(entity_added);

    if u145.LocalFighter.Entity then
        task.spawn(entity_added, u145.LocalFighter.Entity);
    end;

    u145._internal_local_fighter_added:Fire();
    u145:_SetupControls();
    u145:_ToggleAutoShoot();
    task.defer(u145._DisableRobloxJumpButton, u145);
    task.defer(u145._BindMovementActionsLoop, u145);
end;

function u3._Init(u157) -- Line: 1281
    -- upvalues: ControlsController (copy), PlayerDataController (copy), DebugState (copy)
    ControlsController.ControlsChanged:Connect(function() -- Line: 1282
        -- upvalues: u157 (copy)
        u157:_SetupControls();
        u157:_ToggleAutoShoot();
    end);
    PlayerDataController:GetSettingChangedSignal("Auto Shoot"):Connect(function() -- Line: 1287
        -- upvalues: u157 (copy)
        u157:_ToggleAutoShoot();
    end);
    PlayerDataController:GetSettingChangedSignal("Auto Shoot Reaction Time"):Connect(function() -- Line: 1291
        -- upvalues: u157 (copy)
        u157:_ToggleAutoShoot();
    end);
    DebugState:GetDataChangedSignal("AreHandicapsEnabled"):Connect(function() -- Line: 1295
        -- upvalues: u157 (copy)
        u157:_ToggleAutoShoot();
    end);
    task.defer(u157._HookFighter, u157);
end;

return u3._new();