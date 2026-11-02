-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
game:GetService("GuiService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.CONSTANTS);
local Signal = require(ReplicatedStorage.Modules.Signal);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local SettingSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("SettingSlot"));
local u1 = setmetatable({}, SettingSlot);
u1.__index = u1;

function u1.new(...) -- Line: 16
    -- upvalues: SettingSlot (copy), u1 (copy), Signal (copy)
    local v2 = SettingSlot.new(...);
    local v3 = setmetatable(v2, u1);
    v3.SliderChanged = Signal.new();
    v3.InputBox = v3.ControlsSettingFrame:WaitForChild("SliderInput"):WaitForChild("Box");
    v3.ControlsSettingButtonsFrame = v3.ControlsSettingFrame:WaitForChild("Buttons");
    v3.IncreaseButton = v3.ControlsSettingButtonsFrame:WaitForChild("Increase");
    v3.DecreaseButton = v3.ControlsSettingButtonsFrame:WaitForChild("Decrease");
    v3.SliderContainer = v3.ControlsSettingFrame:WaitForChild("Container");
    v3.Slider = v3.SliderContainer:WaitForChild("Slider");
    v3.Dragger = v3.Slider:WaitForChild("Dragger");
    v3._dragging = false;
    v3._dragging_connection = nil;
    v3._console_dragging_connection = nil;
    v3._console_alpha = nil;
    v3._console_drag_velocity = 0;
    v3:_Init();

    return v3;
end;

function u1.IncreaseValue(p4, p5) -- Line: 44
    local math_max_ret = math.max(1 / p4.SettingsInfo.Increment, (p4.SettingsInfo.Max - p4.SettingsInfo.Min) * 0.1);
    p4:InputValue((p4.SettingsInfo.VerifyInput(p4.Value + math_max_ret * p5)));
end;

function u1.CancelInputs(p6) -- Line: 51
    if p6._console_dragging_connection then
        p6:_StopDraggingConsole();

        return;
    end;

    p6:_StopDragging();
end;

function u1.Destroy(p7) -- Line: 59
    -- upvalues: SettingSlot (copy)
    if p7._dragging_connection then
        p7._dragging_connection:Disconnect();
        p7._dragging_connection = nil;
    end;

    if p7._console_dragging_connection then
        p7._console_dragging_connection:Disconnect();
        p7._console_dragging_connection = nil;
    end;

    p7.SliderChanged:Destroy();
    SettingSlot.Destroy(p7);
end;

function u1._GetDisplayValue(p8, p9) -- Line: 79
    if p8.SettingsInfo.IsPercent then
        return math.floor(p9 * 100 + 0.5) .. "%";
    end;

    return p9;
end;

function u1._UpdateSliderPosition(p10) -- Line: 83
    p10.SliderContainer.Size = UDim2.new(0, (p10.ControlsSettingFrame.AbsolutePosition.X + p10.ControlsSettingFrame.AbsoluteSize.X - p10.SettingFrame.AbsolutePosition.X) / p10.UIScale.Scale, 0.42, 0);
end;

function u1._Update(p11) -- Line: 89
    local UDim2_new_ret = UDim2.new(p11:_GetAlphaFromValue(p11.Value), 0, 0.5, 0);
    p11.InputBox.Text = p11:_GetDisplayValue(p11.Value);

    if p11.Dragger:IsDescendantOf(game) then
        p11.Dragger:TweenPosition(UDim2_new_ret, "Out", "Quint", 0.25, true);

        return;
    end;

    p11.Dragger.Position = UDim2_new_ret;
end;

function u1._VerifyInputBox(p12) -- Line: 101
    local v13 = tonumber(p12.InputBox.Text);
    local v14 = p12.SettingsInfo.VerifyInput(p12.SettingsInfo.IsPercent and (v13 and v13 / 100) or p12.InputBox.Text) or p12.Value;
    p12.InputBox.Text = p12:_GetDisplayValue(v14);
    p12:InputValue(v14);
end;

function u1._GetAlphaFromValue(p15, p16) -- Line: 111
    return (p16 - p15.SettingsInfo.Min) / (p15.SettingsInfo.Max - p15.SettingsInfo.Min);
end;

function u1._GetAlphaFromMouse(p17) -- Line: 115
    -- upvalues: UILibrary (copy)
    local MouseLocation = UILibrary:GetMouseLocation();

    return math.clamp((MouseLocation.X - p17.Slider.AbsolutePosition.X) / p17.Slider.AbsoluteSize.X, 0, 1);
end;

function u1._GetValueFromAlpha(p18, p19) -- Line: 125
    return p18.SettingsInfo.VerifyInput(p18.SettingsInfo.Min + p19 * (p18.SettingsInfo.Max - p18.SettingsInfo.Min));
end;

function u1._GetValueFromMouse(p20) -- Line: 132
    return p20:_GetValueFromAlpha(p20:_GetAlphaFromMouse());
end;

function u1._UpdateDrag(p21) -- Line: 136
    local v22 = p21:_GetValueFromMouse();
    local v23 = p21:_GetAlphaFromMouse();
    local v24 = (v22 - p21.SettingsInfo.Min) / (p21.SettingsInfo.Max - p21.SettingsInfo.Min);
    local UDim2_new_ret = UDim2.new(v24 + (v23 - v24) * 0.5, 0, 0.5, 0);
    p21.Dragger:TweenPosition(UDim2_new_ret, "Out", "Quint", 0.25, true);
    p21.InputBox.Text = p21:_GetDisplayValue(v22);
    p21.SliderChanged:Fire(v22);
end;

function u1._StartDragging(u25) -- Line: 147
    -- upvalues: UserInputService (copy)
    if u25._dragging or tick() < u25._value_change_cooldown then
        return;
    end;

    u25._dragging = true;
    u25._dragging_connection = UserInputService.InputChanged:Connect(function() -- Line: 154
        -- upvalues: u25 (copy)
        u25:_UpdateDrag();
    end);
end;

function u1._StopDragging(p26) -- Line: 159
    if not p26._dragging then
        return;
    end;

    p26._dragging = false;

    if p26._dragging_connection then
        p26._dragging_connection:Disconnect();
    end;

    p26:InputValue(p26:_GetValueFromMouse());
end;

function u1._StartDraggingConsole(u27) -- Line: 173
    -- upvalues: UserInputService (copy), RunService (copy)
    if u27._dragging or tick() < u27._value_change_cooldown then
        return;
    end;

    u27._dragging = true;
    u27._console_alpha = u27:_GetAlphaFromValue(u27.Value);
    u27._dragging_connection = UserInputService.InputChanged:Connect(function(p28) -- Line: 181
        -- upvalues: u27 (copy)
        if p28.KeyCode ~= Enum.KeyCode.Thumbstick1 then
            return;
        end;

        if math.abs(p28.Position.X) < 0.1 then
            u27._console_drag_velocity = 0;

            return;
        end;

        u27._console_drag_velocity = p28.Position.X * 0.01;
    end);
    u27._console_dragging_connection = RunService.RenderStepped:Connect(function(p29) -- Line: 193
        -- upvalues: u27 (copy)
        u27._console_alpha = math.clamp(u27._console_alpha + u27._console_drag_velocity * p29 * 60, 0, 1);
        local v30 = u27:_GetValueFromAlpha(u27._console_alpha);
        u27.Dragger.Position = UDim2.new(u27._console_alpha, 0, 0.5, 0);
        u27.InputBox.Text = u27:_GetDisplayValue(v30);
        u27.SliderChanged:Fire(v30);
    end);
end;

function u1._StopDraggingConsole(p31) -- Line: 204
    if not p31._dragging then
        return;
    end;

    p31._dragging = false;

    if p31._dragging_connection then
        p31._dragging_connection:Disconnect();
    end;

    if p31._console_dragging_connection then
        p31._console_dragging_connection:Disconnect();
    end;

    p31:InputValue(p31:_GetValueFromAlpha(p31._console_alpha));
    p31._console_alpha = nil;
end;

function u1._Setup(u32) -- Line: 224
    -- upvalues: UserInputService (copy)
    u32:ResizeYSize(1.5);
    u32.Dragger.MouseButton1Down:Connect(function() -- Line: 236
        -- upvalues: u32 (copy)
        u32:_StartDragging();
    end);
    table.insert(u32._connections, UserInputService.InputEnded:Connect(function(p33) -- Line: 240
        -- upvalues: u32 (copy)
        if p33.UserInputType == Enum.UserInputType.MouseButton1 or p33.UserInputType == Enum.UserInputType.Touch then
            u32:_StopDragging();
        end;
    end));
end;

function u1._Init(u34) -- Line: 248
    -- upvalues: ButtonEffect (copy)
    u34.Changed:Connect(function() -- Line: 249
        -- upvalues: u34 (copy)
        u34:_Update();
    end);
    u34.SliderChanged:Connect(function(p35) -- Line: 253
        -- upvalues: u34 (copy)
        u34:_UpdateDetails(p35);
    end);
    u34.InputBox.FocusLost:Connect(function() -- Line: 257
        -- upvalues: u34 (copy)
        u34:_VerifyInputBox();
    end);
    u34.IncreaseButton.MouseButton1Click:Connect(function() -- Line: 261
        -- upvalues: u34 (copy)
        u34:IncreaseValue(1);
    end);
    u34.DecreaseButton.MouseButton1Click:Connect(function() -- Line: 265
        -- upvalues: u34 (copy)
        u34:IncreaseValue(-1);
    end);
    u34.IncreaseButton.MouseEnter:Connect(function() -- Line: 269
        -- upvalues: u34 (copy)
        u34.IncreaseButton.ZIndex = 1;
        u34.DecreaseButton.ZIndex = 0;
    end);
    u34.DecreaseButton.MouseEnter:Connect(function() -- Line: 274
        -- upvalues: u34 (copy)
        u34.IncreaseButton.ZIndex = 0;
        u34.DecreaseButton.ZIndex = 1;
    end);
    u34.SettingFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 279
        -- upvalues: u34 (copy)
        u34:_UpdateSliderPosition();
    end);
    u34.ControlsSettingFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 283
        -- upvalues: u34 (copy)
        u34:_UpdateSliderPosition();
    end);
    u34.ControlsSettingFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 287
        -- upvalues: u34 (copy)
        u34:_UpdateSliderPosition();
    end);
    u34.UIScale:GetPropertyChangedSignal("Scale"):Connect(function() -- Line: 291
        -- upvalues: u34 (copy)
        u34:_UpdateSliderPosition();
    end);
    u34:_Setup();
    u34:_Update();
    u34:_UpdateSliderPosition();
    ButtonEffect:Add(u34.Dragger);
    ButtonEffect:Add(u34.IncreaseButton);
    ButtonEffect:Add(u34.DecreaseButton);
end;

return u1;