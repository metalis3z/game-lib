-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SettingsLibrary = require(ReplicatedStorage.Modules.SettingsLibrary);
local InputLibrary = require(ReplicatedStorage.Modules.InputLibrary);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local SettingsController = require(Players.LocalPlayer.PlayerScripts.Controllers.SettingsController);
local Crosshair = require(Players.LocalPlayer.PlayerScripts.Modules.Crosshair);
local MobileButton = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("MobileButton");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 17
    -- upvalues: u1 (copy), Crosshair (copy), MobileButton (copy)
    local v3 = setmetatable({}, u1);
    v3.Page = p2;
    v3.Frame = v3.Page.Container:WaitForChild("Inspect");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.DescriptionFrame = v3.Container:WaitForChild("Description");
    v3.DescriptionText = v3.DescriptionFrame:WaitForChild("Description");
    v3.DescriptionInvisibleText = v3.DescriptionFrame:WaitForChild("InvisibleDescription");
    v3.DescriptionTitleContainer = v3.DescriptionFrame:WaitForChild("TitleContainer");
    v3.DescriptionTitleIcon = v3.DescriptionTitleContainer:WaitForChild("Icon");
    v3.DescriptionTitleText = v3.DescriptionTitleContainer:WaitForChild("Title");
    v3.MapFrame = v3.Container:WaitForChild("Map");
    v3.MapContainer = v3.MapFrame:WaitForChild("Container");
    v3.MapBackground = v3.MapContainer:WaitForChild("Background");
    v3.MapCurrent = v3.MapBackground:WaitForChild("Current");
    v3.MapNext = v3.MapBackground:WaitForChild("Next");
    v3._current_settings_info = nil;
    v3._map_hash = 0;
    v3._map_num = 0;
    v3._crosshair = Crosshair.new();
    v3._mobile_button = MobileButton:Clone();
    v3._mobile_input_name_connections = {};
    v3._current_mobile_input_name = nil;
    v3:_Init();

    return v3;
end;

function u1.Inspect(u4, p5) -- Line: 52
    -- upvalues: PlayerDataController (copy)
    if p5 == u4._current_settings_info or p5 and p5.InputType == "Divider" then
        return;
    end;

    for _, v in pairs(u4._mobile_input_name_connections) do
        v:Disconnect();
    end;

    u4._mobile_input_name_connections = {};
    u4._current_settings_info = p5;
    u4._current_mobile_input_name = u4:_GetMobileInputNameFromSettingsName(u4._current_settings_info and u4._current_settings_info.Name) or (u4._current_mobile_input_name or "mobile_shoot");
    u4.DescriptionFrame.Visible = u4._current_settings_info ~= nil;
    u4:_UpdateMapVisibility();
    u4:_UpdateMobileButton();

    if not u4._current_settings_info then
        return;
    end;

    u4.DescriptionTitleIcon.Image = u4._current_settings_info.Image;
    u4.DescriptionTitleIcon.Visible = u4.DescriptionTitleIcon.Image ~= "";
    u4.DescriptionTitleText.Text = u4._current_settings_info.DisplayName;
    u4.DescriptionInvisibleText.Text = u4._current_settings_info.Description;

    if not u4._current_mobile_input_name then
        return;
    end;

    local _mobile_input_name_connections = u4._mobile_input_name_connections;
    local SettingChangedSignal = PlayerDataController:GetSettingChangedSignal("MobileButton " .. u4._current_mobile_input_name .. " Enabled");
    table.insert(_mobile_input_name_connections, SettingChangedSignal:Connect(function() -- Line: 82
        -- upvalues: u4 (copy)
        u4:_UpdateMobileButton();
    end));
    local _mobile_input_name_connections2 = u4._mobile_input_name_connections;
    local SettingChangedSignal2 = PlayerDataController:GetSettingChangedSignal("Mobile Buttons Transparency");
    table.insert(_mobile_input_name_connections2, SettingChangedSignal2:Connect(function() -- Line: 86
        -- upvalues: u4 (copy)
        u4:_UpdateMobileButton();
    end));
    local _mobile_input_name_connections3 = u4._mobile_input_name_connections;
    local SettingChangedSignal3 = PlayerDataController:GetSettingChangedSignal("MobileButton " .. u4._current_mobile_input_name .. " Transparency");
    table.insert(_mobile_input_name_connections3, SettingChangedSignal3:Connect(function() -- Line: 90
        -- upvalues: u4 (copy)
        u4:_UpdateMobileButton();
    end));
    table.insert(u4._mobile_input_name_connections, PlayerDataController.SettingsSliderChanged:Connect(function(p6, p7) -- Line: 94
        -- upvalues: u4 (copy)
        u4:_UpdateMobileButton({
            [p6] = p7
        });
    end));
end;

function u1.SetVisible(p8, p9) -- Line: 99
    p8.Frame.Visible = p9;
end;

function u1.SetPage(p10, p11) -- Line: 103
    p10:Inspect(nil);
    p10:SetVisible(p11 ~= "Hotkeys");
    p10._crosshair:SetVisible(p11 == "Crosshair");
    p10:_UpdateMapVisibility();
    p10:_UpdateMobileButton();
end;

function u1.Open(p12) -- Line: 111
    p12._map_hash = p12._map_hash + 1;
    task.spawn(p12._PlayMapEffect, p12);
end;

function u1.Close(p13) -- Line: 116
    p13._map_hash = p13._map_hash + 1;
    p13:Inspect(nil);
end;

function u1._GetMobileInputNameFromSettingsName(p14, p15) -- Line: 125
    if not p15 or string.sub(p15, 1, 13) ~= "MobileButton " then
        return nil;
    end;

    local string_sub_ret = string.sub(p15, 14, #p15);
    local string_find_ret = string.find(string_sub_ret, " ");

    if string_find_ret then
        return string.sub(string_sub_ret, 1, string_find_ret - 1);
    end;

    return nil;
end;

function u1._UpdateMobileButton(p16, p17) -- Line: 142
    -- upvalues: SettingsController (copy), PlayerDataController (copy), InputLibrary (copy)
    local v18;

    if p16.Page.CurrentPage == "Touch" then
        v18 = p16._current_mobile_input_name ~= nil;
    else
        v18 = false;
    end;

    p16._mobile_button.Visible = v18;

    if not p16._mobile_button.Visible then
        return;
    end;

    local MobileButtonSetting = SettingsController:GetMobileButtonSetting(p16._current_mobile_input_name, "Mobile Buttons Transparency", "Transparency", p17);
    local Setting = PlayerDataController:GetSetting("MobileButton " .. p16._current_mobile_input_name .. " Enabled");
    local Image = InputLibrary.MobileButtons[p16._current_mobile_input_name].Image;
    p16._mobile_button.Invisible.Visible = not Setting;
    p16._mobile_button.IconContainer.ImageTransparency = math.clamp(MobileButtonSetting * 2, 0, 1) * 1 + 0;
    p16._mobile_button.IconContainer.Icon.ImageTransparency = math.clamp(MobileButtonSetting, 0, 1);
    p16._mobile_button.IconContainer.Icon.Image = Image;
end;

function u1._UpdateMapVisibility(p19) -- Line: 159
    local v20;

    if p19.Page.CurrentPage == "Crosshair" then
        v20 = true;
    elseif p19.Page.CurrentPage == "Touch" then
        v20 = p19._current_mobile_input_name;
    else
        v20 = false;
    end;

    p19.MapFrame.Visible = v20;
end;

function u1._GetMapImage(p21, p22) -- Line: 163
    -- upvalues: DuelLibrary (copy)
    return DuelLibrary.Maps[DuelLibrary.MapOrder[(p22 - 1) % #DuelLibrary.MapOrder + 1]].Image;
end;

function u1._PlayMapEffect(p23) -- Line: 167
    p23._map_hash = p23._map_hash + 1;
    local _map_hash = p23._map_hash;

    while true do
        p23._map_num = p23._map_num + 1;
        p23.MapNext.Image = p23:_GetMapImage(p23._map_num + 1);
        p23.MapCurrent.Image = p23:_GetMapImage(p23._map_num);
        p23.MapCurrent.Position = UDim2.new(0.625, 0, 0.5, 0);
        p23.MapCurrent:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 0.25, true);
        wait(5);

        if _map_hash ~= p23._map_hash then
            break;
        end;

        p23.MapCurrent:TweenPosition(UDim2.new(0.375, 0, 0.5, 0), "In", "Quint", 0.25, true);
        wait(0.25);

        if _map_hash ~= p23._map_hash then
            return;
        end;
    end;
end;

function u1._UpdateCrosshairAppearance(p24, p25) -- Line: 194
    -- upvalues: SettingsLibrary (copy), PlayerDataController (copy)
    p24._crosshair:SetAppearance(SettingsLibrary:GenerateCrosshairAppearance(PlayerDataController, p25));
    p24._crosshair:SetSpacing(p24._crosshair:GetAppearanceSpacing());
end;

function u1._UpdateText(p26) -- Line: 199
    p26.DescriptionText.Text = p26.DescriptionInvisibleText.Text;
    p26.DescriptionText.Size = UDim2.new(0.9, 0, p26.DescriptionInvisibleText.Size.Y.Scale * math.ceil(p26.DescriptionInvisibleText.TextBounds.X / p26.DescriptionText.AbsoluteSize.X), 0);
end;

function u1._Setup(p27) -- Line: 204
    p27._crosshair:SetParent(p27.MapContainer);
    p27._mobile_button.Parent = p27.MapContainer;
    p27._mobile_button.AnchorPoint = Vector2.new(0.5, 0.5);
    p27._mobile_button.Position = UDim2.new(0.5, 0, 0.5, 0);
    p27._mobile_button.Size = UDim2.new(0.5, 0, 0.5, 0);
    p27._mobile_button.Resize.Visible = false;
end;

function u1._Init(u28) -- Line: 213
    -- upvalues: PlayerDataController (copy), SettingsLibrary (copy)
    u28.DescriptionInvisibleText:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 214
        -- upvalues: u28 (copy)
        u28:_UpdateText();
    end);
    u28.DescriptionInvisibleText:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 218
        -- upvalues: u28 (copy)
        u28:_UpdateText();
    end);
    u28.DescriptionInvisibleText:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 222
        -- upvalues: u28 (copy)
        u28:_UpdateText();
    end);
    u28.DescriptionInvisibleText:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 226
        -- upvalues: u28 (copy)
        u28:_UpdateText();
    end);
    u28.DescriptionText:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 230
        -- upvalues: u28 (copy)
        u28:_UpdateText();
    end);
    PlayerDataController.SettingsSliderChanged:Connect(function(p29, p30) -- Line: 234
        -- upvalues: u28 (copy)
        u28:_UpdateCrosshairAppearance({
            [p29] = p30
        });
    end);

    for i, v in pairs(SettingsLibrary.Info) do
        if v.Section == "Crosshair" then
            PlayerDataController:GetSettingChangedSignal(i):Connect(function() -- Line: 240
                -- upvalues: u28 (copy)
                u28:_UpdateCrosshairAppearance();
            end);
        end;
    end;

    u28:_Setup();
    u28:_UpdateText();
    u28:_UpdateCrosshairAppearance();
end;

return u1;