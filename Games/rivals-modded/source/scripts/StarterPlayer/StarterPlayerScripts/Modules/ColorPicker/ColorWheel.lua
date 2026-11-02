-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ColorPicker = require(Players.LocalPlayer.PlayerScripts.Modules.ColorPicker);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(0, 0, 0);
local u1 = setmetatable({}, ColorPicker);
u1.__index = u1;

function u1.new(...) -- Line: 16
    -- upvalues: ColorPicker (copy), u1 (copy)
    local v2 = ColorPicker.new(...);
    local v3 = setmetatable(v2, u1);
    v3.ColorWheelFrame = v3.Frame:WaitForChild("ColorWheel");
    v3.Picture = v3.ColorWheelFrame:WaitForChild("Picture");
    v3.PictureIcon = v3.Picture:WaitForChild("Icon");
    v3.Cursor = v3.ColorWheelFrame:WaitForChild("Cursor");
    v3.CursorImage = v3.Cursor:WaitForChild("ImageLabel");
    v3.ValueSliderFrame = v3.Frame:WaitForChild("ValueSlider");
    v3.ValueColor = v3.ValueSliderFrame:WaitForChild("Color");
    v3.Slider = v3.ValueSliderFrame:WaitForChild("Slider");
    v3._color_picker_connection = nil;
    v3._ignore_next_cursor_and_slider_update = false;
    v3:_Init();

    return v3;
end;

function u1.Destroy(p4) -- Line: 40
    -- upvalues: ColorPicker (copy)
    p4:_ClearConnections();
    ColorPicker.Destroy(p4);
end;

function u1._ClearConnections(p5) -- Line: 49
    if p5._color_picker_connection then
        p5._color_picker_connection:Disconnect();
        p5._color_picker_connection = nil;
    end;
end;

function u1._UpdateValueColor(p6) -- Line: 56
    -- upvalues: Utility (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy)
    local v7, v8, v9 = Utility:Color3FromHex(p6.Value):ToHSV();
    local Color3_fromHSV_ret = Color3.fromHSV(v7, v8, 1);
    p6.ValueColor.BackgroundColor3 = Color3_fromHSV_ret;
    p6.PictureIcon.ImageColor3 = Color3.new(v9, v9, v9);
    local v10;

    if v9 < 0.35 then
        v10 = Color3_fromRGB_ret;
    else
        v10 = Color3_fromRGB_ret2;
    end;

    p6.CursorImage.ImageColor3 = v10;
end;

function u1._UpdateFromCursorAndSlider(p11) -- Line: 65
    -- upvalues: Utility (copy)
    local v12 = p11.Cursor.AbsolutePosition + p11.Cursor.AbsoluteSize / 2 - (p11.Picture.AbsolutePosition + p11.Picture.AbsoluteSize / 2);
    local v13 = v12.Magnitude / (p11.Picture.AbsoluteSize.Y / 2);
    local v14 = math.atan(v12.Y / v12.X) + (v12.X < 0 and 3.141592653589793 or 0);
    local math_clamp_ret = math.clamp(v14 ~= v14 and 0 or (v14 + 1.5707963267948966) / 6.283185307179586, 0, 1);
    local math_clamp_ret2 = math.clamp(v13, 0, 1);
    local math_clamp_ret3 = math.clamp(1 - p11.Slider.Position.Y.Scale, 0, 1);
    p11:SetColor(Utility:HexFromColor3((Color3.fromHSV(math_clamp_ret, math_clamp_ret2, math_clamp_ret3))), true);
end;

function u1._RepositionCursorAndSlider(u15) -- Line: 80
    -- upvalues: Utility (copy)
    if u15._ignore_next_cursor_and_slider_update then
        task.defer(function() -- Line: 82
            -- upvalues: u15 (copy)
            u15._ignore_next_cursor_and_slider_update = false;
        end);

        return;
    end;

    local v16 = Utility:Color3FromHex(u15.Value);
    local v17, v18, v19 = v16:ToHSV(v16);
    local v20 = v17 * 6.283185307179586 - 1.5707963267948966;
    local v21 = v18 * (u15.Picture.AbsoluteSize.Y / 2);
    local v22 = math.cos(v20) * v21 / u15.Picture.AbsoluteSize.X;
    local v23 = math.sin(v20) * v21 / u15.Picture.AbsoluteSize.Y;
    u15.Slider.Position = UDim2.new(0.5, 0, 1 - v19, 0);
    u15.Cursor.Position = UDim2.new(0.5 + v22, 0, 0.5 + v23, 0);
end;

function u1._Setup(u24) -- Line: 102
    -- upvalues: CONSTANTS (copy), RunService (copy), UILibrary (copy)
    u24.Cursor.Visible = true;
    u24.Slider.Visible = true;

    if CONSTANTS.DEVICE == "Console" then
        return;
    end;

    u24.ColorWheelFrame.InputBegan:Connect(function(p25) -- Line: 109
        -- upvalues: u24 (copy), RunService (ref), UILibrary (ref)
        if p25.UserInputType == Enum.UserInputType.MouseButton1 or p25.UserInputType == Enum.UserInputType.Touch then
            u24:_ClearConnections();
            u24._color_picker_connection = RunService.RenderStepped:Connect(function() -- Line: 113
                -- upvalues: UILibrary (ref), u24 (ref)
                local v26 = UILibrary:GetMouseLocation() - (u24.Picture.AbsolutePosition + u24.Picture.AbsoluteSize / 2);
                local math_clamp_ret = math.clamp(v26.Magnitude, 0, u24.Picture.AbsoluteSize.Y / 2);
                local v27 = math.atan(v26.Y / v26.X) + (v26.X < 0 and 3.141592653589793 or 0);
                local v28 = math.cos(v27) * math_clamp_ret / u24.Picture.AbsoluteSize.X;
                local v29 = math.sin(v27) * math_clamp_ret / u24.Picture.AbsoluteSize.Y;
                u24._ignore_next_cursor_and_slider_update = true;
                u24.Cursor.Position = UDim2.new(0.5 + v28, 0, 0.5 + v29, 0);
                u24.Cursor.Visible = true;
                u24:_UpdateFromCursorAndSlider();
            end);
        end;
    end);
    u24.ColorWheelFrame.InputEnded:Connect(function(p30) -- Line: 129
        -- upvalues: u24 (copy)
        if p30.UserInputType == Enum.UserInputType.MouseButton1 or p30.UserInputType == Enum.UserInputType.Touch then
            u24:_ClearConnections();
            u24:SetColor(u24.Value);
        end;
    end);
    u24.ValueSliderFrame.InputBegan:Connect(function(p31) -- Line: 136
        -- upvalues: u24 (copy), RunService (ref), UILibrary (ref)
        if p31.UserInputType == Enum.UserInputType.MouseButton1 or p31.UserInputType == Enum.UserInputType.Touch then
            u24:_ClearConnections();
            u24._color_picker_connection = RunService.RenderStepped:Connect(function() -- Line: 140
                -- upvalues: UILibrary (ref), u24 (ref)
                local v32 = (UILibrary:GetMouseLocation().Y - u24.ValueSliderFrame.AbsolutePosition.Y) / u24.ValueSliderFrame.AbsoluteSize.Y;
                local math_clamp_ret = math.clamp(v32, 0, 1);
                u24._ignore_next_cursor_and_slider_update = true;
                u24.Slider.Position = UDim2.new(0.5, 0, math_clamp_ret, 0);
                u24.Slider.Visible = true;
                u24:_UpdateFromCursorAndSlider();
            end);
        end;
    end);
    u24.ValueSliderFrame.InputEnded:Connect(function(p33) -- Line: 155
        -- upvalues: u24 (copy)
        if p33.UserInputType == Enum.UserInputType.MouseButton1 or p33.UserInputType == Enum.UserInputType.Touch then
            u24:_ClearConnections();
            u24:SetColor(u24.Value);
        end;
    end);
end;

function u1._Init(u34) -- Line: 164
    u34.Updated:Connect(function() -- Line: 165
        -- upvalues: u34 (copy)
        u34:_UpdateValueColor();
        u34:_RepositionCursorAndSlider();
    end);
    u34.Changed:Connect(function() -- Line: 170
        -- upvalues: u34 (copy)
        u34:_UpdateValueColor();
        u34:_RepositionCursorAndSlider();
    end);
    u34:_Setup();
    u34:_RepositionCursorAndSlider();
end;

return u1;