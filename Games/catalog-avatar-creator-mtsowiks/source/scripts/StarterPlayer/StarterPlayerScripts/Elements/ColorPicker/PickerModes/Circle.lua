-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

local function toPolar(p2) -- Line: 4
    return math.atan2(p2.Y, p2.X), p2.Magnitude;
end;

function u1.new(p3) -- Line: 8
    -- upvalues: u1 (copy)
    local v4 = setmetatable({}, u1);
    v4.ColorPicker = p3;
    v4:Init();

    return v4;
end;

function u1.Init(p5) -- Line: 16
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Size = UDim2.fromScale(1, 1);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = "rbxassetid://2849458409";
    ImageLabel.Parent = p5.ColorPicker.Instance:WaitForChild("Picker");
    p5.Instance = ImageLabel;
end;

function u1.SetVisible(p6, p7) -- Line: 26
    p6.Instance.Visible = p7;
end;

function u1.GetColor(p8, p9) -- Line: 30
    local v10 = (p9 - Vector2.new(0.5, 0.5)) * Vector2.new(1, -1);
    local v11 = math.atan2(v10.Y, v10.X);
    local Magnitude = v10.Magnitude;

    return math.clamp((v11 + 3.141592653589793) / 6.283185307179586, 0, 1), math.clamp(Magnitude * 2, 0, 1), p8.ColorPicker.Color.Value;
end;

function u1.GetPointerPositionFromColor(p12, p13, p14, p15) -- Line: 39
    local v16 = p13 * 3.141592653589793 * 2;

    return UDim2.fromScale(0.5 - math.cos(v16) / 2 * p14, 0.5 + math.sin(v16) / 2 * p14);
end;

return u1;