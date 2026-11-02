-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local GamepadService = game:GetService("GamepadService");
local RunService = game:GetService("RunService");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local PermissionsLibrary = require(ReplicatedStorage.Modules.PermissionsLibrary);
local SettingsLibrary = require(ReplicatedStorage.Modules.SettingsLibrary);
local BountyLibrary = require(ReplicatedStorage.Modules.BountyLibrary);
local InputLibrary = require(ReplicatedStorage.Modules.InputLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local SettingsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SettingsController"));
local Inset = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Inset"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local SettingInputHotkeysDivider = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("SettingInputHotkeysDivider");
local SettingInputHotkeysSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("SettingInputHotkeysSlot");
local SettingHotkeySlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("SettingHotkeySlot");
local Settings = Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Settings");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 34
    -- upvalues: u1 (copy), Signal (copy)
    local v3 = setmetatable({}, u1);
    v3.Hovered = Signal.new();
    v3.ResetSettings = Signal.new();
    v3.Page = p2;
    v3.Frame = v3.Page.Container:WaitForChild("Settings");
    v3.WaitingFrame = v3.Frame:WaitForChild("Waiting");
    v3.DotsFrame = v3.WaitingFrame:WaitForChild("Dots");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.HotkeyHeaderFrame = v3.Container:WaitForChild("HotkeyHeader");
    v3.List = v3.Container:WaitForChild("List");
    v3.Container = v3.List:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.HotkeyTopFrame = v3.Container:WaitForChild("HotkeyTop");
    v3.HotkeyBottomFrame = v3.Container:WaitForChild("HotkeyBottom");
    v3.ResetDefaultFrame = v3.Container:WaitForChild("ResetDefault");
    v3.ResetDefaultContainer = v3.ResetDefaultFrame:WaitForChild("Container");
    v3.ResetDefaultButton = v3.ResetDefaultContainer:WaitForChild("Controls"):WaitForChild("Confirm"):WaitForChild("Button");
    v3.ResetDefaultDescription = v3.ResetDefaultContainer:WaitForChild("Details"):WaitForChild("Display"):WaitForChild("Description");
    v3.MobileEditorFrame = v3.Container:WaitForChild("MobileEditor");
    v3.MobileEditorButton = v3.MobileEditorFrame:WaitForChild("Container"):WaitForChild("Controls"):WaitForChild("Confirm"):WaitForChild("Button");
    v3.SettingObjects = {};
    v3._setting_objects_by_section = {};
    v3._input_hotkeys_slots = {};
    v3._is_listening_for_hotkey = false;
    v3._last_reset_click = 0;
    v3:_Init();

    return v3;
end;

function u1.SetPage(p4, p5) -- Line: 74
    local Frame = p4.Frame;
    local v6;

    if p5 == "Hotkeys" then
        v6 = UDim2.new(0.85, 0, 0.9, 0);
    else
        v6 = UDim2.new(0.5, 0, 0.9, 0);
    end;

    Frame.Size = v6;
    local List = p4.List;
    local v7;

    if p5 == "Hotkeys" then
        v7 = UDim2.new(0.5, 0, 0.075, 0);
    else
        v7 = UDim2.new(0.5, 0, 0, 0);
    end;

    List.Position = v7;
    p4.List.CanvasPosition = Vector2.zero;
    local Layout = p4.Layout;
    local v8;

    if p5 == "Hotkeys" then
        v8 = UDim.new(0, 0);
    else
        v8 = UDim.new(0.01, 0);
    end;

    Layout.Padding = v8;
    p4.HotkeyHeaderFrame.Visible = p5 == "Hotkeys";
    p4.HotkeyTopFrame.Visible = p5 == "Hotkeys";
    p4.HotkeyBottomFrame.Visible = p5 == "Hotkeys";
    local ResetDefaultFrame = p4.ResetDefaultFrame;
    local v9;

    if p5 == "Hotkeys" then
        v9 = UDim2.new(1, 0, 0.11764705882352942, 0);
    else
        v9 = UDim2.new(1, 0, 0.2, 0);
    end;

    ResetDefaultFrame.Size = v9;
    local ResetDefaultContainer = p4.ResetDefaultContainer;
    local v10;

    if p5 == "Hotkeys" then
        v10 = UDim2.new(0.5882352941176471, 0, 0.6, 0);
    else
        v10 = UDim2.new(1, 0, 0.6, 0);
    end;

    ResetDefaultContainer.Size = v10;
    p4.ResetDefaultDescription.Text = string.format("Double tap to reset your %s settings back to default", p5 or "???");
    p4.MobileEditorFrame.Visible = p5 == "Touch";

    for i, v in pairs(p4._setting_objects_by_section) do
        local v11 = i;

        for _, v2 in pairs(v) do
            local v12;

            if p5 == v11 then
                v12 = p4.Container;
            else
                v12 = nil;
            end;

            v2.SettingFrame.Parent = v12;
        end;
    end;

    for _, v in pairs(p4._input_hotkeys_slots) do
        local v13;

        if p5 == "Hotkeys" then
            v13 = p4.Container;
        else
            v13 = nil;
        end;

        v.Parent = v13;
    end;
end;

function u1.Close(p14) -- Line: 98
    for _, v in pairs(p14.SettingObjects) do
        if v.SettingsInfo.InputType == "Color" then
            v:SetOpen(false);
            v:CancelInputs(false);
        end;
    end;
end;

function u1._UpdateSize(p15) -- Line: 111
    -- upvalues: UILibrary (copy)
    p15.List.Size = UDim2.new(1, 0, 0, UILibrary.MainGui.AbsolutePosition.Y + UILibrary.MainGui.AbsoluteSize.Y - p15.List.AbsolutePosition.Y);
end;

function u1._GenerateHotkeys(u16) -- Line: 115
    -- upvalues: SettingsLibrary (copy), SettingInputHotkeysDivider (copy), InputLibrary (copy), SettingInputHotkeysSlot (copy), PlayerDataController (copy), SettingsController (copy), ButtonEffect (copy), Utility (copy), UserInputService (copy), GamepadService (copy), GuiService (copy), SettingHotkeySlot (copy), RunService (copy)
    for i, v in pairs(SettingsLibrary.HOTKEYS_GUIDE) do
        local v17 = i % 2 == 0;

        if v == "Divider" then
            local v18 = SettingInputHotkeysDivider:Clone();
            v18.AlternateBackground.Visible = v17;
            v18.LayoutOrder = i;
            v18.Parent = u16.Container;
            table.insert(u16._input_hotkeys_slots, v18);
        else
            local v19 = InputLibrary.Inputs[v];
            local u20 = {};
            local u21 = SettingInputHotkeysSlot:Clone();
            u21.AlternateBackground.Visible = v17;
            u21.Title.Text = v19.DisplayName;
            u21.Icon.Image = v19.Image;
            u21.LayoutOrder = i;
            table.insert(u16._input_hotkeys_slots, u21);

            local function update_reset_button() -- Line: 138
                -- upvalues: u20 (copy), PlayerDataController (ref), SettingsLibrary (ref), u21 (copy)
                local v22 = false;

                for _, v2 in pairs(u20) do
                    if PlayerDataController:GetSetting(v2[2]) ~= SettingsLibrary.Info[v2[2]].DefaultValue then
                        v22 = true;
                        break;
                    end;
                end;

                u21.Reset.Visible = v22;
                local Icon = u21.Icon;
                local v23;

                if v22 then
                    v23 = UDim2.new(0.15, 0, 0.5, 0);
                else
                    v23 = UDim2.new(0.1, 0, 0.5, 0);
                end;

                Icon.Position = v23;
                local Title = u21.Title;
                local v24;

                if v22 then
                    v24 = UDim2.new(0.175, 0, 0.5, 0);
                else
                    v24 = UDim2.new(0.125, 0, 0.5, 0);
                end;

                Title.Position = v24;
            end;

            u21.Reset.MouseButton1Click:Connect(function() -- Line: 153
                -- upvalues: u20 (copy), SettingsLibrary (ref), SettingsController (ref)
                local v25 = {};

                for _, v2 in pairs(u20) do
                    table.insert(v25, { v2[2], SettingsLibrary.Info[v2[2]].DefaultValue });
                end;

                SettingsController:ChangeSettings(v25);
            end);
            ButtonEffect:Add(u21.Reset);

            local function setup(u26, u27) -- Line: 165
                -- upvalues: SettingsLibrary (ref), Utility (ref), PlayerDataController (ref), u16 (copy), SettingsController (ref), UserInputService (ref), GamepadService (ref), GuiService (ref), update_reset_button (copy)
                local u28 = SettingsLibrary.Info[u27];
                local u29 = {};
                local u30 = nil;

                local function set_text(p31) -- Line: 171
                    -- upvalues: u30 (ref), Utility (ref), u26 (copy)
                    if p31 == u30 then
                        return;
                    end;

                    u30 = p31;
                    local v32;

                    if p31 then
                        v32 = Utility:GetInputEnumFromName(p31);
                    else
                        v32 = p31;
                    end;

                    u26.Listening.Visible = false;
                    u26.Keybind.Visible = true;
                    u26.Keybind:RemoveTag("UIKeybindContainer");

                    if v32 then
                        u26.Keybind:SetAttribute("EnumType", (tostring(v32.EnumType)));
                        u26.Keybind:SetAttribute("EnumName", p31);
                        u26.Keybind:AddTag("UIKeybindContainer");
                    end;
                end;

                local function set_action_buttons_visible(p33) -- Line: 190
                    -- upvalues: PlayerDataController (ref), u27 (copy), u26 (copy)
                    local v34 = PlayerDataController:GetSetting(u27) ~= "nil";
                    u26.Edit.Size = v34 and UDim2.new(0.5, 0, 1, 0) or UDim2.new(1, 0, 1, 0);
                    u26.Edit.BackgroundHalf.Visible = v34;
                    u26.Edit.BackgroundFull.Visible = not v34;
                    u26.Edit.Visible = p33;
                    u26.Unbind.Visible = v34 and p33;
                end;

                local function clear_listen_connections() -- Line: 200
                    -- upvalues: u29 (ref), u16 (ref)
                    for _, v2 in pairs(u29) do
                        v2:Disconnect();
                    end;

                    u29 = {};
                    u16._is_listening_for_hotkey = false;
                end;

                local function input_value(p35) -- Line: 209
                    -- upvalues: clear_listen_connections (copy), u26 (copy), u30 (ref), set_text (copy), SettingsController (ref), u27 (copy)
                    clear_listen_connections();
                    u26.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
                    u30 = nil;
                    set_text(p35);
                    SettingsController:ChangeSetting(u27, p35);
                end;

                u26.Edit.MouseButton1Click:Connect(function() -- Line: 219
                    -- upvalues: set_action_buttons_visible (copy), clear_listen_connections (copy), u16 (ref), u30 (ref), u29 (ref), UserInputService (ref), GamepadService (ref), GuiService (ref), u28 (copy), u26 (copy), set_text (copy), SettingsController (ref), u27 (copy)
                    set_action_buttons_visible(false);
                    clear_listen_connections();
                    u16._is_listening_for_hotkey = true;
                    u30 = nil;
                    table.insert(u29, UserInputService.InputBegan:Connect(function(p36) -- Line: 226
                        -- upvalues: GamepadService (ref), GuiService (ref), u28 (ref), clear_listen_connections (ref), u26 (ref), u30 (ref), set_text (ref), SettingsController (ref), u27 (ref)
                        local v37;

                        if p36.UserInputType == Enum.UserInputType.MouseButton1 and (GamepadService.GamepadCursorEnabled or GuiService.SelectedObject) then
                            v37 = Enum.KeyCode.ButtonR2.Name;
                        elseif p36.KeyCode == Enum.KeyCode.Unknown then
                            v37 = p36.UserInputType.Name;
                        else
                            v37 = p36.KeyCode.Name;
                        end;

                        local v38 = u28.VerifyInput(v37);
                        clear_listen_connections();
                        u26.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
                        u30 = nil;
                        set_text(v38);
                        SettingsController:ChangeSetting(u27, v38);
                    end));
                    u26.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                    u26.Keybind.Visible = false;
                    u26.Listening.Visible = true;
                    GuiService.SelectedObject = nil;
                end);
                u26.Unbind.MouseButton1Click:Connect(function() -- Line: 246
                    -- upvalues: set_action_buttons_visible (copy), SettingsController (ref), u27 (copy)
                    set_action_buttons_visible(false);
                    SettingsController:ChangeSetting(u27, nil);
                end);
                u26.MouseEnter:Connect(function() -- Line: 251
                    -- upvalues: u29 (ref), set_action_buttons_visible (copy)
                    if #u29 == 0 then
                        set_action_buttons_visible(true);
                    end;
                end);
                u26.MouseLeave:Connect(function() -- Line: 257
                    -- upvalues: set_action_buttons_visible (copy)
                    set_action_buttons_visible(false);
                end);

                local function update() -- Line: 261
                    -- upvalues: set_text (copy), PlayerDataController (ref), u27 (copy), update_reset_button (ref)
                    set_text(PlayerDataController:GetSetting(u27));
                    update_reset_button();
                end;

                PlayerDataController:GetSettingChangedSignal(u27):Connect(update);
                set_text(PlayerDataController:GetSetting(u27));
                update_reset_button();
            end;

            local v39 = v;

            for i2, v2 in pairs(InputLibrary.HOTKEY_FORMATS) do
                local v40 = i2;

                for i3, v3 in pairs(v2) do
                    local v41 = u21[v40 .. i3];
                    local string_format_ret = string.format(v3, v39);
                    local v42 = SettingHotkeySlot:Clone();
                    v42.Listening.Visible = false;
                    v42.Edit.Visible = false;
                    v42.Unbind.Visible = false;
                    v42.Parent = v41;
                    table.insert(u20, { v41, string_format_ret });
                    task.defer(setup, v42, string_format_ret);
                end;
            end;

            if i % 3 == 0 then
                RunService.RenderStepped:Wait();
            end;
        end;
    end;
end;

function u1._GenerateSettings(u43) -- Line: 292
    -- upvalues: SettingsLibrary (copy), BountyLibrary (copy), Players (copy), PlayerDataController (copy), PermissionsLibrary (copy), Settings (copy), SettingsController (copy), RunService (copy)
    local table_clone_ret = table.clone(SettingsLibrary.DEPENDENCIES);

    for _, v in pairs(SettingsLibrary.OrderBySections) do
        local v44 = false;

        for i, v2 in pairs(v) do
            if not (v2.InputType == "Hotkey" or v2.Name == "Bounty Rewards Disabled" and not BountyLibrary.Players[tostring(Players.LocalPlayer.UserId)] or (table.find(SettingsLibrary.STAFF_SETTINGS, v2.Name) and not PlayerDataController:IsNosniyGamesTeamMember() or v2.Name == "Staff Team Tools Disabled Leads" and PermissionsLibrary.USE_GROUP_ROLES_INSTEAD_OF_DATASTORES)) then
                local v45 = table_clone_ret[v2.Name];
                local u46 = require(Settings:WaitForChild(v2.InputType)).new(v2);
                u46:OverrideDescription("");
                u46.SettingFrame.LayoutOrder = i;
                u43._setting_objects_by_section[v2.Section] = u43._setting_objects_by_section[v2.Section] or {};
                u43._setting_objects_by_section[v2.Section][v2.Name] = u46;
                u43.SettingObjects[v2.Name] = u46;
                u46.Hovered:Connect(function() -- Line: 326
                    -- upvalues: u43 (copy), u46 (copy)
                    u43.Hovered:Fire(u46);
                end);

                if u46.SettingsInfo.InputType == "Divider" then
                    v44 = true;

                    if i > 1 then
                        u46:SetDividerSpacing(1.5);
                    end;
                elseif v44 then
                    u46:Scale(0.95);
                end;

                local v47, u48;

                if v45 then
                    if v45[3] then
                        v47 = i;
                        u48 = v2;
                    else
                        local Name = v2.Name;
                        v47 = i;
                        u48 = v2;
                        local v49 = v44 and 1 or 0;

                        while table_clone_ret[Name] do
                            Name = table_clone_ret[Name][1];
                            v49 = v49 + 1;
                        end;

                        u46:Scale(1 - v49 * 0.05);
                    end;

                    local function is_visible(p50) -- Line: 358
                        -- upvalues: PlayerDataController (ref), table_clone_ret (copy), is_visible (copy)
                        local v51 = PlayerDataController:GetSetting(table_clone_ret[p50][1]) == table_clone_ret[p50][2];

                        if table_clone_ret[p50][4] then
                            v51 = not v51;
                        end;

                        local v52;

                        if v51 or table_clone_ret[p50][2] == "any" then
                            v52 = not table_clone_ret[table_clone_ret[p50][1]] or is_visible(table_clone_ret[p50][1]);
                        else
                            v52 = false;
                        end;

                        return v52;
                    end;

                    local function update_visibility() -- Line: 369
                        -- upvalues: u46 (copy), is_visible (copy), u48 (copy)
                        u46.SettingFrame.Visible = is_visible(u48.Name);
                    end;

                    PlayerDataController:GetDataChangedSignal("SettingsProfile"):Connect(update_visibility);

                    local function hook(p53) -- Line: 375
                        -- upvalues: PlayerDataController (ref), update_visibility (copy), table_clone_ret (copy), hook (copy)
                        PlayerDataController:GetSettingChangedSignal(p53):Connect(update_visibility);

                        if table_clone_ret[p53] then
                            hook(table_clone_ret[p53][1]);
                        end;
                    end;

                    local v54 = v45[1];
                    PlayerDataController:GetSettingChangedSignal(v54):Connect(update_visibility);

                    if table_clone_ret[v54] then
                        hook(table_clone_ret[v54][1]);
                    end;

                    u46.SettingFrame.Visible = is_visible(u48.Name);
                else
                    v47 = i;
                    u48 = v2;
                end;

                local function v55() -- Line: 388
                    -- upvalues: u46 (copy), PlayerDataController (ref), u48 (copy)
                    u46:SetValue(PlayerDataController:GetSetting(u48.Name), true, true);
                end;

                PlayerDataController:GetSettingChangedSignal(u48.Name):Connect(v55);
                PlayerDataController:GetDataChangedSignal("SettingsProfile"):Connect(v55);
                u46:SetValue(PlayerDataController:GetSetting(u48.Name), true, true);
                u46.Replicate:Connect(function() -- Line: 396
                    -- upvalues: SettingsController (ref), u48 (copy), u46 (copy)
                    SettingsController:ChangeSetting(u48.Name, u46.Value);
                end);

                if u46.SettingsInfo.InputType == "Slider" or u46.SettingsInfo.InputType == "Color" then
                    u46.SliderChanged:Connect(function(p56) -- Line: 401
                        -- upvalues: PlayerDataController (ref), u48 (copy)
                        PlayerDataController.SettingsSliderChanged:Fire(u48.Name, p56);
                    end);
                end;

                if v47 % 3 == 0 then
                    RunService.RenderStepped:Wait();
                end;
            end;
        end;
    end;
end;

function u1._Generate(p57) -- Line: 413
    p57.DotsFrame:AddTag("UILoadingDots");
    p57.WaitingFrame.Visible = true;
    p57.Container.Visible = false;
    p57:_GenerateSettings();
    p57:_GenerateHotkeys();
    p57:SetPage(p57.Page.CurrentPage);
    p57.DotsFrame:RemoveTag("UILoadingDots");
    p57.WaitingFrame.Visible = false;
    p57.Container.Visible = true;
end;

function u1._Init(u58) -- Line: 427
    -- upvalues: Inset (copy), UILibrary (copy), GuiService (copy), ButtonEffect (copy)
    u58.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 428
        -- upvalues: u58 (copy)
        u58.List.CanvasSize = UDim2.new(0, 0, 0, u58.Layout.AbsoluteContentSize.Y);
    end);
    u58.List:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 432
        -- upvalues: u58 (copy)
        u58:_UpdateSize();
    end);
    u58.ResetDefaultButton.MouseButton1Click:Connect(function() -- Line: 436
        -- upvalues: u58 (copy)
        if tick() < u58._last_reset_click + 0.5 then
            u58.ResetSettings:Fire();

            return;
        end;

        u58._last_reset_click = tick();
    end);
    u58.MobileEditorButton.MouseButton1Click:Connect(function() -- Line: 444
        -- upvalues: u58 (copy), Inset (ref)
        u58.Page.Closed:Fire();
        task.defer(Inset.MobileEditorBar.SetVisible, Inset.MobileEditorBar, true, nil, true);
    end);
    UILibrary.MainGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 449
        -- upvalues: u58 (copy)
        u58:_UpdateSize();
    end);
    UILibrary.MainGui:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 453
        -- upvalues: u58 (copy)
        u58:_UpdateSize();
    end);
    GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(function() -- Line: 457
        -- upvalues: u58 (copy), GuiService (ref)
        if u58.Page:IsOpen() and u58._is_listening_for_hotkey then
            task.defer(function() -- Line: 459
                -- upvalues: GuiService (ref)
                GuiService.SelectedObject = nil;
            end);
        end;
    end);
    task.spawn(u58._Generate, u58);
    u58:_UpdateSize();
    ButtonEffect:Add(u58.ResetDefaultButton);
    ButtonEffect:Add(u58.MobileEditorButton);
end;

return u1;