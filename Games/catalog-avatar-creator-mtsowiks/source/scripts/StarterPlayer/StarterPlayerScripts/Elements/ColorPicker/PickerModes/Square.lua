-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 4
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.ColorPicker = p2;
    v3:Init();

    return v3;
end;

function u1.Init(p4) -- Line: 12
    local CanvasGroup = Instance.new("CanvasGroup");
    CanvasGroup.BackgroundTransparency = 0;
    CanvasGroup.BackgroundColor3 = Color3.new(1, 1, 1);
    CanvasGroup.Size = UDim2.fromScale(1, 1);
    CanvasGroup.Parent = p4.ColorPicker.Instance:WaitForChild("Picker");
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 6);
    UICorner.Parent = CanvasGroup;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Color = ColorSequence.new(Color3.new(1, 1, 1));
    UIGradient.Parent = CanvasGroup;
    local Frame = Instance.new("Frame");
    Frame.BackgroundColor3 = Color3.new(0, 0, 0);
    Frame.BackgroundTransparency = 0;
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.Parent = CanvasGroup;
    local UIGradient2 = Instance.new("UIGradient");
    UIGradient2.Color = ColorSequence.new(Color3.new(0, 0, 0));
    UIGradient2.Rotation = -90;
    UIGradient2.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) });
    UIGradient2.Parent = Frame;
    p4.Instance = CanvasGroup;
    p4.Gradient = UIGradient;
end;

function u1.SetVisible(p5, p6) -- Line: 43
    p5.Instance.Visible = p6;
end;

function u1.GetColor(p7, p8) -- Line: 47
    return p7.ColorPicker.Color.Hue, math.clamp(p8.X, 0, 1), math.clamp(1 - p8.Y, 0, 1);
end;

function u1.GetPointerPositionFromColor(p9, p10, p11, p12) -- Line: 51
    return UDim2.fromScale(p11, 1 - p12);
end;

function u1.ColorChanged(p13) -- Line: 55
    p13.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.fromHSV(p13.ColorPicker.Color.Hue, 1, 1)) });
end;

return u1;