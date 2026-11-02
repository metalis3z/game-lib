-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
local GuiService = game:GetService("GuiService");
local LocalPlayer = game.Players.LocalPlayer;
local PickerModes = script:WaitForChild("PickerModes");
local Samples = script:WaitForChild("Samples");
local u1 = {
    Circle = require(PickerModes:WaitForChild("Circle")),
    Square = require(PickerModes:WaitForChild("Square")),
    Triangle = require(PickerModes:WaitForChild("Triangle"))
};
local BuiltinSliders = require(script:WaitForChild("BuiltinSliders"));
local MouseMovement = require(script:WaitForChild("MouseMovement"));
local WindowResize = require(script:WaitForChild("WindowResize"));
local History = require(script:WaitForChild("History"));
local u2 = {};
u2.__index = u2;
u2.COLOR_SPACE = {
    HSV = 1,
    RGB = 2
};
u2.PICKER_MODE = {
    CIRCLE = "Circle",
    SQUARE = "Square",
    TRIANGLE = "Triangle"
};

local function template(p3, p4) -- Line: 72
    -- upvalues: template (copy)
    local v5 = {};

    for i, v in pairs(p4) do
        local v6 = p3[i];

        if v6 == nil then
            v6 = v;
        end;

        if typeof(v6) == "table" then
            v6 = template(v6, v) or v6;
        end;

        v5[i] = v6;
    end;

    return v5;
end;

function u2.new(p7) -- Line: 89
    -- upvalues: u2 (copy), template (copy), History (copy)
    local v8 = setmetatable({}, u2);
    local v9 = v8:GetMousePos() + Vector2.new(20, 20);
    v8.Params = template(p7 or {}, {
        Parent = "new",
        ZIndex = 1,
        Scale = 1,
        EnableTransparency = false,
        RealTimeEventCalling = false,
        Position = UDim2.fromOffset(v9.X, v9.Y),
        PickerMode = u2.PICKER_MODE.CIRCLE,
        ColorSpace = u2.COLOR_SPACE.HSV
    });
    v8.History = History.new();
    v8.PickerModes = {};
    v8.Sliders = {};
    v8.Color = {
        Hue = 0,
        Saturation = 1,
        Value = 1
    };
    v8:_init();

    return v8;
end;

function u2.GetHSV(p10) -- Line: 122
    return p10.Color.Hue, p10.Color.Saturation, p10.Color.Value;
end;

function u2.GetColor(p11) -- Line: 126
    return Color3.fromHSV(p11:GetHSV());
end;

function u2.SetColor(p12, p13) -- Line: 130
    local Color = p12.Color;
    local Color2 = p12.Color;
    local Color4 = p12.Color;
    local v14, v15, v16 = p13:ToHSV();
    Color.Hue = v14;
    Color2.Saturation = v15;
    Color4.Value = v16;
    p12:_updateColorVisuals();
    p12:WriteHistory();
    p12:_fireColorChanged();
end;

function u2.GetTransparency(p17) -- Line: 138
    if not p17.Params.EnableTransparency then
        warn("ColorPicker:GetTransparency - Transparency isn\'t enabled");
    end;

    return p17.Color.Transparency;
end;

function u2.SetTransparency(p18, p19) -- Line: 143
    if not p18.Params.EnableTransparency then
        warn("ColorPicker:SetTransparency - Transparency isn\'t enabled");

        return;
    end;

    p18.Color.Transparency = math.clamp(p19, 0, 1);
    p18:_updateColorVisuals();
end;

function u2._setSliderVisible(p20, p21, p22) -- Line: 150
    if p22 and p21.GetValue then
        p21.Value = p21.GetValue();
        p21:UpdateVisual();
    end;

    p21:SetVisible(p22);
end;

function u2._updateColorSpace(p23) -- Line: 159
    -- upvalues: u2 (copy)
    local TextLabel = p23.Instance:WaitForChild("Middle"):WaitForChild("Right"):WaitForChild("ColorSpace"):WaitForChild("TextLabel");
    local v24 = p23.ColorSpace == u2.COLOR_SPACE.HSV;
    TextLabel.Text = v24 and "HSV" or "RGB";
    p23:_setSliderVisible(p23.Sliders.Hue, v24);
    p23:_setSliderVisible(p23.Sliders.Saturation, v24);
    p23:_setSliderVisible(p23.Sliders.Value, v24);
    p23:_setSliderVisible(p23.Sliders.Red, not v24);
    p23:_setSliderVisible(p23.Sliders.Green, not v24);
    p23:_setSliderVisible(p23.Sliders.Blue, not v24);
    p23:_updateSize();
end;

function u2.SetColorSpace(p25, p26) -- Line: 181
    p25.ColorSpace = p26;
    p25:_updateColorSpace();
end;

function u2._updatePickerMode(p27) -- Line: 186
    for i, v in pairs(p27.PickerModes) do
        v:SetVisible(i == p27.PickerMode);
    end;

    local PickerMode = p27.Instance:WaitForChild("Options"):WaitForChild("PickerMode");

    for _, child in pairs(PickerMode:GetChildren()) do
        if child:IsA("Frame") then
            local v28 = child.Name == p27.PickerMode;
            child.Icon.ImageTransparency = v28 and 0 or 0.5;
            child.Selected.Visible = v28;
        end;
    end;

    p27:_updateColorVisuals();
end;

function u2.SetPickerMode(p29, p30) -- Line: 203
    p29.PickerMode = p30;
    p29:_updatePickerMode();
end;

function u2._getPickerMode(p31, p32) -- Line: 208
    -- upvalues: u1 (copy)
    if not p31.PickerModes[p32] then
        p31.PickerModes[p32] = u1[p32].new(p31);
    end;

    return p31.PickerModes[p32];
end;

function u2._fireColorChanged(p33) -- Line: 216
    p33._colorChangedEvent:Fire(p33:GetColor(), p33.Color.Transparency or 0);
end;

function u2.GetMousePos(p34) -- Line: 220
    -- upvalues: GuiService (copy), UserInputService (copy)
    local Height = GuiService.TopbarInset.Height;

    return UserInputService:GetMouseLocation() - Vector2.new(0, Height);
end;

function u2._updateColorVisuals(p35) -- Line: 225
    -- upvalues: u2 (copy)
    local v36 = p35:_getPickerMode(p35.PickerMode);
    local v37, v38, v39 = p35:GetHSV();
    local Select = p35.Instance:WaitForChild("Picker"):WaitForChild("Select");
    Select.ImageColor3 = Color3.fromHSV(0, 0, p35.PickerMode == u2.PICKER_MODE.CIRCLE and (0.4 + v39 * 0.6 or 1) or 1);
    Select.Position = v36:GetPointerPositionFromColor(v37, v38, v39);

    if v36.ColorChanged then
        v36:ColorChanged();
    end;

    local Middle = p35.Instance:WaitForChild("Middle");
    local Color = Middle:WaitForChild("Right"):WaitForChild("Color");
    Color.BackgroundColor3 = p35:GetColor();
    Color.BackgroundTransparency = p35.Color.Transparency or 0;
    Middle:WaitForChild("Hex"):WaitForChild("Input").Text = string.format("#%s", p35:GetColor():ToHex());

    for _, v in pairs(p35.Sliders) do
        if v.Visible and v.GetValue then
            v:ColorAdjusted();
        end;
    end;
end;

function u2._updateSize(p40) -- Line: 256
    local v41 = 0;

    for _, v in pairs(p40.Sliders) do
        if v.Visible then
            v41 = v41 + 1;
        end;
    end;

    p40.Instance.Size = UDim2.fromOffset(238, 256 + (v41 > 0 and v41 * 26 or 0));
end;

function u2._updateHistoryVisuals(p42) -- Line: 267
    local History2 = p42.Instance:WaitForChild("Options"):WaitForChild("History");
    local Button = History2:WaitForChild("Undo"):WaitForChild("Button");
    local Button2 = History2:WaitForChild("Redo"):WaitForChild("Button");
    Button.ImageTransparency = p42.History._currentIndex <= 1 and 0.5 or 0;
    Button2.ImageTransparency = p42.History._currentIndex == #p42.History.Records and 0.5 or 0;
end;

function u2.WriteHistory(p43) -- Line: 276
    p43.History:WriteHistory(table.clone(p43.Color));
    p43:_updateHistoryVisuals();
end;

function u2.IncrementHistory(p44, p45) -- Line: 281
    local v46 = p44.History:IncrementHistory(p45);

    if v46 then
        p44.Color = table.clone(v46);
        p44:_updateHistoryVisuals();
        p44:_updateColorVisuals();
        p44:_fireColorChanged();
    end;
end;

function u2._create(u47) -- Line: 292
    -- upvalues: LocalPlayer (copy), Samples (copy), MouseMovement (copy), u2 (copy), WindowResize (copy), UserInputService (copy), RunService (copy)
    u47.UI = u47.Params.Parent;

    if u47.UI and u47.UI ~= "new" then
        assert(u47.UI.ZIndexBehavior == Enum.ZIndexBehavior.Sibling, "ColorPicker - ZIndexBehavior needs to be \'Sibling\'");
    else
        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Name = "COLOR_PICKER_UI";
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
        u47.UI = ScreenGui;
        u47._deleteUIOnClose = true;
    end;

    local v48 = Samples:WaitForChild("ColorPickerSample"):Clone();
    v48.Position = u47.Params.Position;
    v48.ZIndex = u47.Params.ZIndex;
    v48.Parent = u47.UI;
    u47.Instance = v48;
    local Picker = u47.Instance:WaitForChild("Picker");
    u47._pickerMouseMovement = MouseMovement.new(function() -- Line: 315
        -- upvalues: u47 (copy), Picker (copy)
        local v49 = (u47:GetMousePos() - Picker.AbsolutePosition) / Picker.AbsoluteSize;
        local Color = u47.Color;
        local Color2 = u47.Color;
        local Color4 = u47.Color;
        local v50, v51, v52 = u47:_getPickerMode(u47.PickerMode):GetColor(v49);
        Color.Hue = v50;
        Color2.Saturation = v51;
        Color4.Value = v52;
        u47:_updateColorVisuals();

        if u47.Params.RealTimeEventCalling then
            u47:_fireColorChanged();
        end;
    end);
    u47._pickerMouseMovement:OnDisconnect(function() -- Line: 325
        -- upvalues: u47 (copy)
        u47:_fireColorChanged();
        u47:WriteHistory();
    end);
    Picker:WaitForChild("Button").MouseButton1Down:Connect(function() -- Line: 330
        -- upvalues: u47 (copy)
        u47._pickerMouseMovement:Connect();
    end);
    local Middle = u47.Instance:WaitForChild("Middle");
    local Input = Middle:WaitForChild("Hex"):WaitForChild("Input");
    Input.FocusLost:Connect(function() -- Line: 337
        -- upvalues: Input (copy), u47 (copy)
        local success, result = pcall(function() -- Line: 338
            -- upvalues: Input (ref)
            return Color3.fromHex(Input.Text);
        end);
        u47:SetColor(success and result and result or Color3.new(1, 1, 1));
    end);
    Middle:WaitForChild("Right"):WaitForChild("ColorSpace"):WaitForChild("Button").MouseButton1Down:Connect(function() -- Line: 345
        -- upvalues: u47 (copy), u2 (ref)
        u47:SetColorSpace(u47.ColorSpace == u2.COLOR_SPACE.HSV and u2.COLOR_SPACE.RGB or u2.COLOR_SPACE.HSV);
    end);
    u47._windowAdjust = MouseMovement.new(function(p53, p54) -- Line: 351
        -- upvalues: u47 (copy)
        local v55 = (u47:GetMousePos() or Vector2.zero) - p53;
        u47.Instance.Position = p54 + UDim2.fromOffset(v55.X, v55.Y);
    end);
    local Topbar = u47.Instance:WaitForChild("Topbar");
    Topbar:WaitForChild("Button").MouseButton1Down:Connect(function() -- Line: 358
        -- upvalues: u47 (copy)
        u47._windowAdjust:Connect(u47:GetMousePos() or Vector2.zero, u47.Instance.Position);
    end);
    local Button = Topbar:WaitForChild("Info"):WaitForChild("Button");
    local Info = u47.Instance:WaitForChild("Info");
    Info.Visible = false;
    Info:WaitForChild("Title").Text = "Version v3.0.1";
    Button.MouseButton1Down:Connect(function() -- Line: 368
        -- upvalues: Info (copy)
        Info.Visible = not Info.Visible;
    end);
    u47.WindowResize = WindowResize.new(u47);

    if not UserInputService.TouchEnabled and (UserInputService.KeyboardEnabled and UserInputService.MouseEnabled) then
        u47.WindowResize:Create();
    end;

    u47.WindowResize:SetScale(u47.Params.Scale);
    local PickerMode = u47.Instance:WaitForChild("Options"):WaitForChild("PickerMode");

    for _, child in pairs(PickerMode:GetChildren()) do
        if child:IsA("Frame") then
            child.Button.MouseButton1Down:Connect(function() -- Line: 384
                -- upvalues: u47 (copy), child (copy)
                u47:SetPickerMode(child.Name);
            end);
        end;
    end;

    local History2 = u47.Instance:WaitForChild("Options"):WaitForChild("History");
    local Button2 = History2:WaitForChild("Undo"):WaitForChild("Button");
    local Button3 = History2:WaitForChild("Redo"):WaitForChild("Button");

    local function _historyActionMouseDown(u56) -- Line: 396
        -- upvalues: u47 (copy), RunService (ref), UserInputService (ref)
        u47:IncrementHistory(u56);
        local u57 = nil;
        local u58 = os.clock() + 0.5;
        u57 = RunService.Heartbeat:Connect(function() -- Line: 401
            -- upvalues: UserInputService (ref), u57 (ref), u58 (ref), u47 (ref), u56 (copy)
            if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                if u58 <= os.clock() then
                    u47:IncrementHistory(u56);
                    u58 = os.clock() + 0.1;
                end;

                return;
            end;

            u57:Disconnect();
            u57 = nil;
        end);
    end;

    Button2.MouseButton1Down:Connect(function() -- Line: 416
        -- upvalues: u47 (copy), RunService (ref), UserInputService (ref)
        u47:IncrementHistory(-1);
        local u59 = nil;
        local u60 = os.clock() + 0.5;
        local u61 = -1;
        u59 = RunService.Heartbeat:Connect(function() -- Line: 401
            -- upvalues: UserInputService (ref), u59 (ref), u60 (ref), u47 (ref), u61 (copy)
            if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                if u60 <= os.clock() then
                    u47:IncrementHistory(u61);
                    u60 = os.clock() + 0.1;
                end;

                return;
            end;

            u59:Disconnect();
            u59 = nil;
        end);
    end);
    Button3.MouseButton1Down:Connect(function() -- Line: 417
        -- upvalues: u47 (copy), RunService (ref), UserInputService (ref)
        u47:IncrementHistory(1);
        local u62 = nil;
        local u63 = os.clock() + 0.5;
        local u64 = 1;
        u62 = RunService.Heartbeat:Connect(function() -- Line: 401
            -- upvalues: UserInputService (ref), u62 (ref), u63 (ref), u47 (ref), u64 (copy)
            if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                if u63 <= os.clock() then
                    u47:IncrementHistory(u64);
                    u63 = os.clock() + 0.1;
                end;

                return;
            end;

            u62:Disconnect();
            u62 = nil;
        end);
    end);
    u47.Instance:WaitForChild("Options"):WaitForChild("Close"):WaitForChild("Button").MouseButton1Down:Connect(function() -- Line: 421
        -- upvalues: u47 (copy)
        u47._windowClosedEvent:Fire(u47:GetColor());
        u47:Destroy();
    end);

    if u47.Params.EnableTransparency then
        local Color = u47.Instance:WaitForChild("Middle"):WaitForChild("Right"):WaitForChild("Color");
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Image = "rbxassetid://111137375763311";
        ImageLabel.ImageColor3 = Color3.new(1, 1, 1);
        ImageLabel.ImageTransparency = 0.5;
        ImageLabel.ScaleType = Enum.ScaleType.Tile;
        ImageLabel.TileSize = UDim2.fromOffset(14, 14);
        ImageLabel.ZIndex = -1;
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.Position = Color.Position;
        ImageLabel.Size = Color.Size;
        ImageLabel.Parent = Color.Parent;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(0, 4);
        UICorner.Parent = ImageLabel;
    end;
end;

function u2._init(p65) -- Line: 449
    -- upvalues: BuiltinSliders (copy)
    p65:_create();
    p65._colorChangedEvent = Instance.new("BindableEvent");
    p65.ColorChanged = p65._colorChangedEvent.Event;
    p65._windowClosedEvent = Instance.new("BindableEvent");
    p65.WindowClosed = p65._windowClosedEvent.Event;
    p65.Sliders.Hue = BuiltinSliders.Hue(p65);
    p65.Sliders.Saturation = BuiltinSliders.Saturation(p65);
    p65.Sliders.Value = BuiltinSliders.Value(p65);
    p65.Sliders.Red = BuiltinSliders.Red(p65);
    p65.Sliders.Green = BuiltinSliders.Green(p65);
    p65.Sliders.Blue = BuiltinSliders.Blue(p65);

    if p65.Params.EnableTransparency then
        p65.Sliders.Transparency = BuiltinSliders.Transparency(p65);
        p65.Sliders.Transparency:SetVisible(true);
    end;

    p65:SetPickerMode(p65.Params.PickerMode);
    p65:SetColorSpace(p65.Params.ColorSpace);
    local Color = p65.Color;
    local Color2 = p65.Color;
    p65.Color.Hue = 0;
    Color.Saturation = 0;
    Color2.Value = 1;
    p65:_updateColorVisuals();
    p65:_updateSize();
    p65.Instance.Visible = true;
end;

function u2.Destroy(p66) -- Line: 486
    for _, v in pairs(p66.Sliders) do
        v:Destroy();
    end;

    for _, v in pairs({ "_colorChangedEvent", "_windowClosedEvent", "History", "_windowAdjust", "_pickerMouseMovement", "Instance", "WindowResize" }) do
        if p66[v] then
            p66[v]:Destroy();
            p66[v] = nil;
        end;
    end;

    if p66.UI and p66._deleteUIOnClose then
        p66.UI:Destroy();
        p66.UI = nil;
    end;
end;

return u2;