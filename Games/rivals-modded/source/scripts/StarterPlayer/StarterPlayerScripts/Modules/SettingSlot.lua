-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Signal = require(ReplicatedStorage.Modules.Signal);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local SettingFrame = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("SettingFrame");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3) -- Line: 13
    -- upvalues: u1 (copy), Signal (copy), SettingFrame (copy)
    assert(not p3, "TEMPLATES NO LONGER SUPPORTED");
    local v4 = setmetatable({}, u1);
    v4.Changed = Signal.new();
    v4.Replicate = Signal.new();
    v4.Hovered = Signal.new();
    v4.SettingFrame = SettingFrame:Clone();
    v4.UIScale = v4.SettingFrame:WaitForChild("UIScale");
    v4.Background = v4.SettingFrame:WaitForChild("Background");
    v4.BackgroundGradient = v4.Background:WaitForChild("UIGradient");
    v4.Container = v4.SettingFrame:WaitForChild("Container");
    v4.DetailsFrame = v4.Container:WaitForChild("Details");
    v4.DetailsIconFrame = v4.DetailsFrame:WaitForChild("Icon");
    v4.DetailsIconLabel = v4.DetailsIconFrame:WaitForChild("Icon");
    v4.DetailsResetButton = v4.DetailsIconFrame:WaitForChild("Reset");
    v4.DetailsDisplayFrame = v4.DetailsFrame:WaitForChild("Display");
    v4.DetailsDisplayDescription = v4.DetailsDisplayFrame:WaitForChild("Description");
    v4.DetailsDisplayTitleContainer = v4.DetailsDisplayFrame:WaitForChild("TitleContainer");
    v4.DetailsDisplayTitleIcon = v4.DetailsDisplayTitleContainer:WaitForChild("Icon");
    v4.DetailsDisplayTitleText = v4.DetailsDisplayTitleContainer:WaitForChild("Title");
    v4.ControlsFrame = v4.Container:WaitForChild("Controls");
    v4.ControlsConfirmFrame = v4.ControlsFrame:WaitForChild("Confirm");
    v4.ControlsConfirmButton = v4.ControlsConfirmFrame:WaitForChild("Button");
    v4.ControlsContainer = v4.ControlsFrame:WaitForChild("Container");
    v4.ControlsSettingFrame = nil;
    v4.SettingsInfo = p2;
    v4.Value = p2.DefaultValue;
    v4._connections = {};
    v4._value_change_cooldown = 0;
    v4._description_override = nil;
    v4:_Init();

    return v4;
end;

function u1.GetSelection(p5) -- Line: 58
    return p5.ControlsSettingFrame;
end;

function u1.Scale(p6, p7) -- Line: 62
    p6.UIScale.Scale = p7;
end;

function u1.ResizeYSize(p8, p9) -- Line: 66
    p8.SettingFrame.Size = UDim2.new(p8.SettingFrame.Size.X.Scale, p8.SettingFrame.Size.X.Offset, p8.SettingFrame.Size.Y.Scale * p9, p8.SettingFrame.Size.Y.Offset * p9);
    p8.Container.Size = UDim2.new(1, 0, 1 / p9, 0);
end;

function u1.OverrideDescription(p10, p11) -- Line: 71
    p10._description_override = p11;
    p10:_UpdateDetails();
end;

function u1.SetSettingsInfo(p12, p13) -- Line: 76
    p12.SettingsInfo = p13;
    p12:_UpdateDetails();
end;

function u1.SetValue(p14, p15, p16, p17) -- Line: 81
    if not ((p14.SettingsInfo.InputType == "Hotkey" or p15 ~= nil) and (p17 or tick() >= p14._value_change_cooldown)) then
        return;
    end;

    p14.Value = p15;
    p14.Changed:Fire(p14.Value);

    if not p16 then
        p14._value_change_cooldown = tick() + 0.05;
        p14.Replicate:Fire(p14.Value);
    end;
end;

function u1.StoreValue(p18, p19) -- Line: 95
    p18.Value = p19;
    p18.Changed:Fire(p18.Value);
end;

function u1.InputValue(p20, ...) -- Line: 100
    if p20.SettingsInfo.IsConfirmSetting then
        p20:StoreValue(...);

        return;
    end;

    p20:SetValue(...);
end;

function u1.CancelInputs(p21) -- Line: 108
end;

function u1.Destroy(p22) -- Line: 112
    for _, v in pairs(p22._connections) do
        v:Disconnect();
    end;

    p22.Changed:Destroy();
    p22.Replicate:Destroy();
    p22.Hovered:Destroy();
    p22.SettingFrame:Destroy();
end;

function u1._Confirm(p23) -- Line: 127
    p23:SetValue(p23.Value, nil, true);
end;

function u1._UpdateDetails(p24, p25) -- Line: 131
    local v26 = p25 or p24.Value;
    p24.DetailsDisplayDescription.Text = p24._description_override or p24.SettingsInfo.Description;
    local DetailsDisplayTitleContainer = p24.DetailsDisplayTitleContainer;
    local v27;

    if p24.DetailsDisplayDescription.Text == "" then
        v27 = UDim2.new(p24.DetailsDisplayTitleContainer.Position.X.Scale, p24.DetailsDisplayTitleContainer.Position.X.Offset, 0.5, 0);
    else
        v27 = p24.DetailsDisplayTitleContainer.Position;
    end;

    DetailsDisplayTitleContainer.Position = v27;
    local v28;

    if p24.SettingsInfo.InputType == "Divider" then
        v28 = false;
    else
        v28 = v26 ~= p24.SettingsInfo.DefaultValue;
    end;

    p24.DetailsResetButton.Visible = v28;
    local v29;

    if p24.DetailsIconLabel.Image == "" then
        v29 = false;
    else
        v29 = not p24.DetailsResetButton.Visible;
    end;

    p24.DetailsIconLabel.Visible = v29;
    p24.DetailsIconFrame.Visible = not p24.ControlsConfirmFrame.Visible and (p24.DetailsIconLabel.Visible or p24.DetailsResetButton.Visible);
    local v30;

    if p24.DetailsDisplayTitleIcon.Image == "" then
        v30 = false;
    else
        v30 = not (p24.DetailsIconFrame.Visible and p24.DetailsIconLabel.Visible);
    end;

    p24.DetailsDisplayTitleIcon.Visible = v30;
end;

function u1._Setup(p31) -- Line: 142
    p31.DetailsIconLabel.Image = p31.SettingsInfo.Image;
    p31.DetailsDisplayTitleIcon.Image = p31.SettingsInfo.Image;
    p31.DetailsDisplayTitleText.Text = p31.SettingsInfo.DisplayName;
    p31.ControlsConfirmFrame.Visible = p31.SettingsInfo.IsConfirmSetting;

    for _, child in pairs(p31.ControlsContainer:GetChildren()) do
        if child.Name == p31.SettingsInfo.InputType then
            child.Visible = true;
            p31.ControlsSettingFrame = child;
        else
            child.Visible = false;
            pcall(task.defer, child.Destroy, child);
        end;
    end;
end;

function u1._Init(u32) -- Line: 159
    -- upvalues: ButtonEffect (copy)
    u32.Changed:Connect(function() -- Line: 160
        -- upvalues: u32 (copy)
        u32:_UpdateDetails();
    end);
    u32.SettingFrame.MouseEnter:Connect(function() -- Line: 164
        -- upvalues: u32 (copy)
        u32.Hovered:Fire();
    end);
    u32.SettingFrame.SelectionChanged:Connect(function(p33) -- Line: 168
        -- upvalues: u32 (copy)
        if p33 then
            u32.Hovered:Fire();
        end;
    end);
    u32.DetailsResetButton.MouseButton1Click:Connect(function() -- Line: 174
        -- upvalues: u32 (copy)
        u32:SetValue(u32.SettingsInfo.DefaultValue);
    end);
    u32.ControlsConfirmButton.MouseButton1Click:Connect(function() -- Line: 178
        -- upvalues: u32 (copy)
        u32:_Confirm();
    end);
    u32:_Setup();
    u32:_UpdateDetails();
    ButtonEffect:Add(u32.DetailsResetButton);
    task.defer(ButtonEffect.Add, ButtonEffect, u32.ControlsConfirmButton);
end;

return u1;