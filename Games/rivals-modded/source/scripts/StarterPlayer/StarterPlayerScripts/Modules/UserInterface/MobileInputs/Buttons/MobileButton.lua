-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
game:GetService("GuiService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local InputLibrary = require(ReplicatedStorage.Modules.InputLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local MechanicsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MechanicsController"));
local SettingsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SettingsController"));
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SpectateController"));
require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"));
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("CameraController"));
local EmoteController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("EmoteController"));
local InfiniteParticles = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("InfiniteParticles"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local MobileButtonCooldownSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("MobileButtonCooldownSlot");
local MobileButton = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("MobileButton");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3) -- Line: 30
    -- upvalues: u1 (copy), MobileButton (copy), InputLibrary (copy), InfiniteParticles (copy)
    local v4 = setmetatable({}, u1);
    v4.Buttons = p2;
    v4.Name = p3;
    v4.Frame = MobileButton:Clone();
    v4.InvisibleFrame = v4.Frame:WaitForChild("Invisible");
    v4.ResizeIcon = v4.Frame:WaitForChild("Resize");
    v4.WeaponIcon = v4.Frame:WaitForChild("Weapon");
    v4.IconContainer = v4.Frame:WaitForChild("IconContainer");
    v4.Icon = v4.IconContainer:WaitForChild("Icon");
    v4.AmmoFrame = v4.Frame:WaitForChild("Ammo");
    v4.AmmoIcon = v4.AmmoFrame:WaitForChild("Icon");
    v4.AmmoTitle = v4.AmmoFrame:WaitForChild("Title");
    v4.AmmoTitleStroke = v4.AmmoTitle:WaitForChild("UIStroke");
    v4._local_fighter = nil;
    v4._item_index = InputLibrary.MobileInputNameToItemIndex[v4.Name];
    v4._info = InputLibrary.MobileButtons[v4.Name];
    v4._is_active = false;
    v4._is_scoped = false;
    v4._is_resizing = false;
    v4._resize_connection = nil;
    v4._is_dragging = false;
    v4._drag_connection = nil;
    v4._drag_delta = nil;
    v4._drag_original_position = nil;
    v4._current_cooldown_frame = nil;
    v4._infinite_particles = InfiniteParticles.new(v4.AmmoTitle);
    v4:_Init();

    return v4;
end;

function u1.IsReallyVisible(p5) -- Line: 69
    local v6 = p5.Frame.Visible and p5.Buttons:IsReallyVisible();

    return v6;
end;

function u1.IsWithin(p7, p8, p9) -- Line: 73
    -- upvalues: UILibrary (copy)
    return UILibrary:IsWithinBounds(p8, p9, p7.Frame.AbsolutePosition, p7.Frame.AbsoluteSize);
end;

function u1.SetScoped(p10, p11) -- Line: 77
    if p10._is_scoped == p11 then
        return;
    end;

    p10._is_scoped = p11;
    p10:UpdateVisuals();
end;

function u1.SetActive(p12, p13) -- Line: 86
    p12._is_active = p13;
    p12:UpdateVisuals();
end;

function u1.Input(p14, p15, p16) -- Line: 91
    -- upvalues: CameraController (copy), MechanicsController (copy)
    if not (p16 or not p14.Buttons.MobileInputs.EditorEnabled and p14:_IsVisible(p14.Name)) then
        return;
    end;

    p14:SetActive(p15);

    if p14.Name == "mobile_switchcamerapov" then
        if p15 then
            CameraController.CameraState:TogglePOV();
        end;
    elseif p14.Name == "mobile_crouch" and (MechanicsController.IsSliding and p14:_IsEasySlideEnabled()) then
        if p15 then
            MechanicsController:MobileInput("mobile_jump", true);
        end;
    elseif p14.Name == "mobile_slide" and MechanicsController.IsSliding then
        if p15 then
            MechanicsController:MobileInput("mobile_jump", true);
        end;
    else
        MechanicsController:MobileInput(p14.Name, p15);
    end;
end;

function u1.InputEnded(p17, p18) -- Line: 115
    if p17._is_resizing then
        p17._resize_connection:Disconnect();
        p17._resize_connection = nil;
        p17._is_resizing = false;
    end;

    if p17._is_dragging then
        p17._drag_connection:Disconnect();
        p17._drag_connection = nil;
        p17._drag_delta = nil;
        p17._drag_original_position = nil;
        p17._is_dragging = false;
    end;
end;

function u1.Button1Down(u19, u20) -- Line: 135
    u19.Buttons.MobileInputs.DoubleTap:ResetTapWindow();

    if u19:_IsToggleMode() then
        u19:Input(not u19._is_active);

        return;
    end;

    task.spawn(function() -- Line: 143
        -- upvalues: u20 (copy), u19 (copy)
        if not u20 then
            return;
        end;

        while u20.UserInputState ~= Enum.UserInputState.End do
            u20:GetPropertyChangedSignal("UserInputState"):Wait();
        end;

        u19:Button1Up();
    end);
    u19:Input(true);
end;

function u1.Button1Up(p21) -- Line: 158
    p21:Input(false);
end;

function u1.UpdateVisuals(p22) -- Line: 162
    -- upvalues: SettingsController (copy)
    local v23 = (p22._is_active or p22._item_index and (p22._local_fighter and p22._local_fighter.EquippedItem) and p22._local_fighter.EquippedItem == p22._local_fighter.Items[p22._item_index]) and not p22.Buttons.MobileInputs.EditorEnabled;
    local MobileButtonSetting = SettingsController:GetMobileButtonSetting(p22.Name, "Mobile Buttons Transparency", "Transparency");

    if p22._is_scoped and SettingsController:GetMobileButtonSetting(p22.Name, "Opaque Buttons While Scoped") then
        MobileButtonSetting = 0;
    elseif v23 then
        MobileButtonSetting = MobileButtonSetting * 2 - 1;
    end;

    local math_clamp_ret = math.clamp(MobileButtonSetting, 0, 1);
    local math_clamp_ret2 = math.clamp(MobileButtonSetting * 2, 0, 1);
    local math_clamp_ret3 = math.clamp(MobileButtonSetting * 2 - 1, 0, 1);
    p22.InvisibleFrame.Visible = not p22:_IsVisibleSetting();
    p22.IconContainer.ImageTransparency = math_clamp_ret2 * 1 + 0;
    p22.Icon.ImageTransparency = math_clamp_ret;
    p22.Icon.ImageColor3 = v23 and Color3.fromRGB(0, 190, 255) or Color3.fromRGB(0, 0, 0);
    p22.WeaponIcon.ImageTransparency = math_clamp_ret3 * 1 + 0;
    p22.AmmoIcon.ImageTransparency = math_clamp_ret3 * 1 + 0;
    p22.AmmoTitle.TextTransparency = math_clamp_ret3 * 1 + 0;
    p22.AmmoTitleStroke.Transparency = math_clamp_ret3 * 0.125 + 0.875;
end;

function u1.UpdateWeaponIcon(p24) -- Line: 181
    -- upvalues: ItemLibrary (copy), CONSTANTS (copy)
    local v25 = p24:_GetClientItem();
    p24.WeaponIcon.Image = p24._item_index and ((not p24.Buttons.MobileInputs.EditorEnabled and v25 and true or false) and v25.ViewModel:GetImage() or (ItemLibrary.Items[CONSTANTS.DEFAULT_WEAPONS[p24._item_index]].Image or "")) or "";
end;

function u1.UpdatePositionAndSize(p26, p27) -- Line: 190
    -- upvalues: PlayerDataController (copy)
    p26:ResetPositionAndSize();
    local v28 = p27 or PlayerDataController:Get("MobileButtonSettings")[PlayerDataController:Get("SettingsProfile")];

    if not v28 then
        return;
    end;

    local v29 = v28[p26.Name];

    if not v29 then
        return;
    end;

    p26.Frame.Position = UDim2.new(0, v29.Position[1], 0, v29.Position[2]);
    p26.Frame.Size = UDim2.new(0, v29.Size[1], 0, v29.Size[2]);
end;

function u1.ResetPositionAndSize(p30) -- Line: 209
    local v31 = math.min(p30.Buttons.Frame.AbsoluteSize.X, p30.Buttons.Frame.AbsoluteSize.Y) <= 500;
    local v32 = v31 and UDim2.new() or UDim2.new(0, 0, 0, -45);
    local v33 = v31 and 1 or 1.7894736842105263;
    local v34 = v31 and 1 or 1.7142857142857142;
    p30.Frame.Position = v32 + UDim2.new(p30._info.DefaultPosition.X.Scale, p30._info.DefaultPosition.X.Offset * v33, p30._info.DefaultPosition.Y.Scale, p30._info.DefaultPosition.Y.Offset * v33);
    p30.Frame.Size = UDim2.new(0, p30._info.DefaultSize.X.Offset * v34, 0, p30._info.DefaultSize.Y.Offset * v34);
end;

function u1.UpdateVisibility(p35) -- Line: 228
    p35.Frame.Visible = p35:_IsVisible();

    if not p35.Frame.Visible then
        p35:SetActive(false);
    end;
end;

function u1.UpdateMobileInputSettings(p36) -- Line: 236
    if not (p36._info.IsCoreInput or p36._info.QuickAttackType) then
        p36:Input(false, true);
    end;

    p36:UpdateVisibility();
end;

function u1.Update(p37, p38) -- Line: 244
    p37._infinite_particles:Update(p38);
end;

function u1._GetClientItem(p39) -- Line: 252
    return p39._item_index and p39._local_fighter and p39._local_fighter.Items[p39._item_index];
end;

function u1._UpdateAmmo(p40) -- Line: 256
    -- upvalues: PlayerDataController (copy), ItemLibrary (copy)
    local v41 = not p40.Buttons.MobileInputs.EditorEnabled and p40:_GetClientItem();

    if not v41 then
        p40.AmmoFrame.Visible = false;

        return;
    end;

    local AmmoVariables, v42, v43, v44 = v41:GetAmmoVariables();
    local Setting = PlayerDataController:GetSetting("Touch Button Ammo");
    local v45 = AmmoVariables and AmmoVariables <= 0 and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(255, 255, 255);
    local v46 = v44 and "∞" or (v42 or "");
    local v47 = v42 and v42 <= 0 and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(255, 255, 255);
    p40.AmmoFrame.Visible = AmmoVariables and Setting;
    p40.AmmoTitle.Text = string.format("<font color=\"%s\">%s</font>", AmmoVariables and AmmoVariables <= 0 and "rgb(255,50,50)" or "rgb(255,255,255)", v43 and "∞" or (AmmoVariables or "")) .. (v46 == "" and "" or string.format("<font size=\"8\" color=\"%s\"> %s</font>", v42 and v42 <= 0 and "rgb(255,50,50)" or "rgb(255,255,255)", v46));

    if v42 then
        v45 = v47 or v45;
    end;

    p40.AmmoIcon.ImageColor3 = v45;
    p40.AmmoIcon.Image = v41.Info.AmmoType and ItemLibrary.Ammos[v41.Info.AmmoType].Image or "";
    p40._infinite_particles:SetActive(v43, v44);
end;

function u1._GetMobileInputSettingsFromEquippedItem(p48) -- Line: 283
    -- upvalues: InputLibrary (copy)
    local v49 = p48._local_fighter and p48._local_fighter.EquippedItem and p48._local_fighter.EquippedItem:GetMobileInputSettings();

    if v49 then
        v49 = v49[InputLibrary.MobileButtons[p48.Name].InputName];
    end;

    return v49;
end;

function u1._IsEasySlideEnabled(p50) -- Line: 289
    -- upvalues: PlayerDataController (copy)
    local v51 = PlayerDataController:GetSetting("Easy Slide Mobile") and not PlayerDataController:GetSetting("MobileButton mobile_slide Enabled");

    return v51;
end;

function u1._IsVisibleSetting(p52) -- Line: 293
    -- upvalues: PlayerDataController (copy)
    return PlayerDataController:GetSetting("MobileButton " .. p52.Name .. " Enabled");
end;

function u1._IsToggleMode(p53) -- Line: 297
    return p53._info.AlwaysToggle or p53:_GetMobileInputSettingsFromEquippedItem() == true;
end;

function u1._IsVisible(p54) -- Line: 301
    -- upvalues: SpectateController (copy), CameraController (copy), EmoteController (copy)
    if p54.Buttons.MobileInputs.EditorEnabled then
        return true;
    end;

    if not (p54._local_fighter and p54:_IsVisibleSetting()) then
        return false;
    end;

    if SpectateController.CurrentDuelSubject then
        if SpectateController.CurrentDuelSubject.DuelInterface.Voting:IsOpen() then
            return false;
        end;

        if not (SpectateController.CurrentDuelSubject.LocalDueler or p54._info.VisibleWhileSpectatingForeignDuel) then
            return false;
        end;
    end;

    if not p54._info.AlwaysVisible and p54:_GetMobileInputSettingsFromEquippedItem() == nil then
        return false;
    end;

    if p54._info.HideIfDead and not p54._local_fighter:IsAlive() then
        return false;
    end;

    if p54.Name == "mobile_quickmelee" and #p54._local_fighter.Items < p54._local_fighter:GetQuickAttackIndex(p54._info.QuickAttackType) then
        return false;
    end;

    if p54.Name == "mobile_quickutility" and #p54._local_fighter.Items < p54._local_fighter:GetQuickAttackIndex(p54._info.QuickAttackType) then
        return false;
    end;

    if p54.Name == "mobile_equipnext" and #p54._local_fighter.Items < 2 then
        return false;
    end;

    if p54.Name == "mobile_switchcamerapov" and not (CameraController:GetPublicState() or SpectateController.CurrentDuelSubject and not SpectateController.CurrentDuelSubject.LocalDueler) then
        return false;
    end;

    if p54.Name == "mobile_openplayerlist" and not SpectateController.CurrentDuelSubject then
        return false;
    end;

    if p54.Name == "mobile_equipprimary" and #p54._local_fighter.Items < 1 then
        return false;
    end;

    if p54.Name == "mobile_equipsecondary" and #p54._local_fighter.Items < 2 then
        return false;
    end;

    if p54.Name == "mobile_equipmelee" and #p54._local_fighter.Items < 3 then
        return false;
    end;

    if p54.Name == "mobile_equiputility" and #p54._local_fighter.Items < 4 then
        return false;
    end;

    return (p54.Name ~= "mobile_useemote" or EmoteController:CanEmote()) and true or false;
end;

function u1._UpdateCameraSinking(p55) -- Line: 376
    -- upvalues: SettingsController (copy)
    p55.Frame.Active = not SettingsController:GetMobileButtonSetting(p55.Name, "Camera Mobile Button Sinking", "Camera Sinking");
end;

function u1._UpdateEditorVisuals(p56) -- Line: 380
    p56.ResizeIcon.Visible = p56.Buttons.MobileInputs.EditorEnabled;

    if p56._current_cooldown_frame then
        p56._current_cooldown_frame.Visible = not p56.Buttons.MobileInputs.EditorEnabled;
    end;
end;

function u1._SetupEditorLogic(u57) -- Line: 388
    -- upvalues: UILibrary (copy), RunService (copy), UserInputService (copy)
    local function update_resize() -- Line: 389
        -- upvalues: u57 (copy), UILibrary (ref)
        local v58 = u57.Frame.AbsolutePosition + u57.Frame.AbsoluteSize * u57.Frame.AnchorPoint - UILibrary:GetMouseLocation();
        local v59 = math.sqrt(v58.X ^ 2 + v58.Y ^ 2) * 2;
        local math_max_ret = math.max(v59, 35);
        u57.Frame.Size = UDim2.new(0, math_max_ret, 0, math_max_ret);
    end;

    local u60 = nil;

    local function update_drag(p61) -- Line: 398
        -- upvalues: u57 (copy), u60 (ref)
        local v62 = u57;
        v62._drag_delta = v62._drag_delta + (not u60 and Vector3.new(0, 0, 0) or p61.Position - u60);
        u60 = p61.Position;
        u57.Frame.Position = UDim2.new(0, math.clamp(u57._drag_original_position.X + u57._drag_delta.X, 0, u57.Buttons.Frame.AbsoluteSize.X), 0, (math.clamp(u57._drag_original_position.Y + u57._drag_delta.Y, 0, u57.Buttons.Frame.AbsoluteSize.Y)));
    end;

    u57.Frame.Resize.MouseButton1Down:Connect(function() -- Line: 410
        -- upvalues: u57 (copy), RunService (ref), update_resize (copy)
        if not u57.Buttons.MobileInputs.EditorEnabled or u57._is_resizing then
            return;
        end;

        u57.Buttons.MobileInputs.EditorLogic:PendEdits();
        u57._is_resizing = true;
        u57._resize_connection = RunService.RenderStepped:Connect(update_resize);
    end);
    u57.Frame.MouseButton1Down:Connect(function() -- Line: 421
        -- upvalues: u57 (copy), u60 (ref), UserInputService (ref), update_drag (copy)
        if not u57.Buttons.MobileInputs.EditorEnabled or u57._is_dragging then
            return;
        end;

        u57.Buttons.MobileInputs.EditorLogic:PendEdits();
        u60 = nil;
        u57._is_dragging = true;
        u57._drag_original_position = u57.Frame.AbsolutePosition + u57.Frame.AbsoluteSize * u57.Frame.AnchorPoint - u57.Buttons.Frame.AbsolutePosition;
        u57._drag_delta = Vector3.new(0, 0, 0);
        u57._drag_connection = UserInputService.InputChanged:Connect(update_drag);
    end);
end;

function u1._HookFighter(u63) -- Line: 436
    -- upvalues: MechanicsController (copy), PlayerDataController (copy), SettingsController (copy), MobileButtonCooldownSlot (copy), BetterDebris (copy), TweenService (copy), Utility (copy)
    u63._local_fighter = MechanicsController:WaitForLocalFighter();
    u63._local_fighter:GetDataChangedSignal("InfiniteAmmo"):Connect(function() -- Line: 439
        -- upvalues: u63 (copy)
        u63:_UpdateAmmo();
    end);
    u63._local_fighter:GetDataChangedSignal("InfiniteAmmoReserve"):Connect(function() -- Line: 443
        -- upvalues: u63 (copy)
        u63:_UpdateAmmo();
    end);
    PlayerDataController:GetSettingChangedSignal("Touch Button Ammo"):Connect(function() -- Line: 447
        -- upvalues: u63 (copy)
        u63:_UpdateAmmo();
    end);

    if u63._item_index then
        local u64 = {};
        local u65 = {};
        local u66 = {};
        local u67 = nil;

        local function cleanup_cooldown_effect() -- Line: 457
            -- upvalues: u64 (ref), u65 (ref), u63 (copy)
            for _, v in pairs(u64) do
                v:Disconnect();
            end;

            for _, v in pairs(u65) do
                v:Destroy();
            end;

            u64 = {};
            u65 = {};
            u63._current_cooldown_frame = nil;
        end;

        local function cooldown_effect(p68) -- Line: 471
            -- upvalues: cleanup_cooldown_effect (copy), SettingsController (ref), u63 (copy), MobileButtonCooldownSlot (ref), BetterDebris (ref), u65 (ref), u64 (ref), TweenService (ref)
            if p68.IsReversed then
                return;
            end;

            cleanup_cooldown_effect();
            local Variables, v69, v70 = p68.GetVariables();
            local v71 = SettingsController:GetMobileButtonSetting(u63.Name, "Mobile Buttons Transparency", "Transparency") * 2 - 1;
            local v72 = MobileButtonCooldownSlot:Clone();
            v72.Right.Frame.UIStroke.Transparency = v71;
            v72.Left.Frame.UIStroke.Transparency = v71;
            v72.Icon.Image = "";
            v72.Parent = u63.Frame;
            BetterDebris:AddItem(v72, Variables);
            table.insert(u65, v72);
            u63._current_cooldown_frame = v72;
            local UIGradient = v72.Right.Frame.UIStroke.UIGradient;
            local UIGradient2 = v72.Left.Frame.UIStroke.UIGradient;

            local function set(p73) -- Line: 493
                -- upvalues: UIGradient (copy), UIGradient2 (copy)
                local v74 = 1 - p73;
                local math_clamp_ret = math.clamp(v74 * 2, 0, 1);
                local math_clamp_ret2 = math.clamp(v74 * 2 - 1, 0, 1);
                UIGradient.Rotation = math_clamp_ret * 180 + -180;
                UIGradient2.Rotation = math_clamp_ret2 * 180 + 0;
            end;

            local NumberValue = Instance.new("NumberValue");
            NumberValue.Value = v69;
            table.insert(u65, NumberValue);
            local PropertyChangedSignal = NumberValue:GetPropertyChangedSignal("Value");
            table.insert(u64, PropertyChangedSignal:Connect(function() -- Line: 507
                -- upvalues: NumberValue (copy), UIGradient (copy), UIGradient2 (copy)
                local v75 = 1 - NumberValue.Value;
                local math_clamp_ret = math.clamp(v75 * 2, 0, 1);
                local math_clamp_ret2 = math.clamp(v75 * 2 - 1, 0, 1);
                UIGradient.Rotation = math_clamp_ret * 180 + -180;
                UIGradient2.Rotation = math_clamp_ret2 * 180 + 0;
            end));
            TweenService:Create(NumberValue, TweenInfo.new(Variables, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                Value = v70
            }):Play();
            u63:_UpdateEditorVisuals();
        end;

        local function update_client_item() -- Line: 516
            -- upvalues: u63 (copy), u67 (ref), cleanup_cooldown_effect (copy), u64 (ref), u66 (ref), TweenService (ref), Utility (ref), cooldown_effect (copy)
            local v76 = u63._local_fighter.Items[u63._item_index];

            if v76 == u67 then
                return;
            end;

            cleanup_cooldown_effect();

            for _, v in pairs(u64) do
                v:Disconnect();
            end;

            u66 = {};
            u67 = v76;
            u63:_UpdateAmmo();

            if not u67 then
                return;
            end;

            local DataChangedSignal = u67:GetDataChangedSignal("Ammo");
            table.insert(u66, DataChangedSignal:Connect(function() -- Line: 537
                -- upvalues: u63 (ref)
                u63:_UpdateAmmo();
            end));
            local DataChangedSignal2 = u67:GetDataChangedSignal("AmmoReserve");
            table.insert(u66, DataChangedSignal2:Connect(function() -- Line: 541
                -- upvalues: u63 (ref)
                u63:_UpdateAmmo();
            end));
            table.insert(u66, u67.EquipFailedEffect:Connect(function() -- Line: 545
                -- upvalues: u63 (ref), TweenService (ref), Utility (ref)
                if not u63:IsReallyVisible() then
                    return;
                end;

                u63.WeaponIcon.ImageColor3 = Color3.fromRGB(127, 0, 0);
                u63.WeaponIcon.Position = UDim2.new(0.5, 0, 0.75, 0);
                TweenService:Create(u63.WeaponIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ImageColor3 = Color3.fromRGB(255, 255, 255),
                    Position = UDim2.new(0.5, 0, 0.5, 0)
                }):Play();
                Utility:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5);
            end));
            table.insert(u66, u67.Cooldowns.CooldownAdded:Connect(cooldown_effect));

            for _, v in pairs(u67.Cooldowns.Cooldowns) do
                task.spawn(cooldown_effect, v);
            end;
        end;

        u63._local_fighter.ItemAdded:Connect(update_client_item);
        u63._local_fighter.ItemRemoved:Connect(update_client_item);
        update_client_item();
    end;

    u63:UpdateVisibility();
    u63:UpdateVisuals();
    u63:UpdateWeaponIcon();
end;

function u1._HookPages(u77) -- Line: 573
    -- upvalues: Players (copy)
    require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages")).PageSystem.PagesActivity:Connect(function() -- Line: 576
        -- upvalues: u77 (copy)
        u77:Button1Up();
    end);
end;

function u1._Setup(u78) -- Line: 581
    -- upvalues: MechanicsController (copy), InputLibrary (copy)
    u78.Frame.Name = u78.Name;
    u78.Icon.Image = u78._item_index and "rbxassetid://16793449322" or u78._info.Image;

    if u78.Name ~= "mobile_crouch" then
        if u78.Name == "mobile_slide" then
            MechanicsController.StateChanged:Connect(function() -- Line: 600, Name: update_icon
                -- upvalues: u78 (copy), MechanicsController (ref), InputLibrary (ref)
                u78.Icon.Image = MechanicsController.IsSliding and InputLibrary.MobileButtons.mobile_jump.Image or u78._info.Image;
            end);
            u78.Icon.Image = MechanicsController.IsSliding and InputLibrary.MobileButtons.mobile_jump.Image or u78._info.Image;
        end;

        return;
    end;

    local function update_icon() -- Line: 586
        -- upvalues: MechanicsController (ref), u78 (copy), InputLibrary (ref)
        if not MechanicsController.IsSliding then
            task.spawn(MechanicsController.MobileInput, MechanicsController, "mobile_jump", false);
        end;

        u78.Icon.Image = not u78:_IsEasySlideEnabled() and u78._info.Image or MechanicsController.IsSliding and InputLibrary.MobileButtons.mobile_jump.Image or (MechanicsController.IsSprinting and InputLibrary.MobileButtons.mobile_slide.Image or u78._info.Image);
    end;

    MechanicsController.StateChanged:Connect(update_icon);
    update_icon();
end;

function u1._Init(u79) -- Line: 610
    -- upvalues: PlayerDataController (copy)
    u79.Buttons.MobileInputs.EditorEnabledChanged:Connect(function() -- Line: 611
        -- upvalues: u79 (copy)
        u79:_UpdateEditorVisuals();
        u79:UpdateVisuals();
    end);
    PlayerDataController:GetSettingChangedSignal("MobileButton " .. u79.Name .. " Enabled"):Connect(function() -- Line: 616
        -- upvalues: u79 (copy)
        u79:UpdateVisuals();
        u79:UpdateVisibility();
    end);
    PlayerDataController:GetSettingChangedSignal("Camera Mobile Button Sinking"):Connect(function() -- Line: 621
        -- upvalues: u79 (copy)
        u79:_UpdateCameraSinking();
    end);
    PlayerDataController:GetSettingChangedSignal("MobileButton " .. u79.Name .. " Camera Sinking"):Connect(function() -- Line: 625
        -- upvalues: u79 (copy)
        u79:_UpdateCameraSinking();
    end);
    PlayerDataController:GetSettingChangedSignal("Mobile Buttons Transparency"):Connect(function() -- Line: 629
        -- upvalues: u79 (copy)
        u79:UpdateVisuals();
    end);
    PlayerDataController:GetSettingChangedSignal("MobileButton " .. u79.Name .. " Transparency"):Connect(function() -- Line: 633
        -- upvalues: u79 (copy)
        u79:UpdateVisuals();
    end);
    PlayerDataController:GetSettingChangedSignal("MobileButton " .. u79.Name .. " Override"):Connect(function() -- Line: 637
        -- upvalues: u79 (copy)
        u79:_UpdateCameraSinking();
        u79:UpdateVisuals();
    end);
    u79:_Setup();
    u79:_SetupEditorLogic();
    u79:_UpdateEditorVisuals();
    u79:_UpdateCameraSinking();
    u79:_UpdateAmmo();
    u79:UpdateVisuals();
    u79:UpdateWeaponIcon();
    u79:UpdatePositionAndSize();
    u79:UpdateVisibility();
    task.defer(u79._HookPages, u79);
    task.defer(u79._HookFighter, u79);
end;

return u1;