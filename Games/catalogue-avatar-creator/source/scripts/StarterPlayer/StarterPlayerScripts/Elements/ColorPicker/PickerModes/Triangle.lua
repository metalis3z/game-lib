-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

local function heightToTriangleHeight(p2) -- Line: 5
    return p2 / 0.8660254037844386 - 0.0669872981077807;
end;

local u3 = { Vector2.new(0.5, 0), Vector2.new(0, 1), Vector2.new(1, 1) };

function u1.new(p4) -- Line: 16
    -- upvalues: u1 (copy)
    local v5 = setmetatable({}, u1);
    v5.ColorPicker = p4;
    v5:Init();

    return v5;
end;

function u1.Init(p6) -- Line: 24
    local Frame = Instance.new("Frame");
    Frame.BackgroundTransparency = 1;
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.Parent = p6.ColorPicker.Instance:WaitForChild("Picker");
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Size = UDim2.fromScale(1, 1);
    ImageLabel.Image = "rbxassetid://119614645478849";
    ImageLabel.ImageColor3 = Color3.new(1, 0, 0);
    ImageLabel.ZIndex = 1;
    ImageLabel.Parent = Frame;
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.BackgroundTransparency = 1;
    ImageLabel2.Size = UDim2.fromScale(1, 1);
    ImageLabel2.Image = "rbxassetid://114393129271758";
    ImageLabel2.ImageColor3 = Color3.new(1, 1, 1);
    ImageLabel2.ZIndex = 2;
    ImageLabel2.Parent = Frame;
    local ImageLabel3 = Instance.new("ImageLabel");
    ImageLabel3.BackgroundTransparency = 1;
    ImageLabel3.Size = UDim2.fromScale(1, 1);
    ImageLabel3.Image = "rbxassetid://90395096352510";
    ImageLabel3.ImageColor3 = Color3.new(1, 1, 1);
    ImageLabel3.ZIndex = 3;
    ImageLabel3.Parent = Frame;
    p6.Instance = Frame;
    p6.ColorImage = ImageLabel;
end;

function u1.SetVisible(p7, p8) -- Line: 58
    p7.Instance.Visible = p8;
end;

function u1.GetColor(p9, p10) -- Line: 62
    -- upvalues: u3 (copy)
    local X = p10.X;
    local v11 = math.clamp(p10.Y / 0.8660254037844386 - 0.0669872981077807, 0, 1);
    local v12 = math.clamp(X, 0.5 - v11 / 2, v11 / 2 + 0.5);
    local v13 = u3[1];
    local v14 = u3[2];
    local v15 = u3[3];
    local v16 = ((v14.Y - v15.Y) * (v12 - v15.X) + (v15.X - v14.X) * (v11 - v15.Y)) / ((v14.Y - v15.Y) * (v13.X - v15.X) + (v15.X - v14.X) * (v13.Y - v15.Y));
    local v17 = ((v15.Y - v13.Y) * (v12 - v15.X) + (v13.X - v15.X) * (v11 - v15.Y)) / ((v14.Y - v15.Y) * (v13.X - v15.X) + (v15.X - v14.X) * (v13.Y - v15.Y));
    local v18 = math.clamp(v16, 0, 1);
    local v19 = math.clamp(v17, 0, 1);
    local v20 = math.clamp(1 - v16 - v17, 0, 1);
    local v21 = Color3.fromHSV(p9.ColorPicker.Color.Hue, 1, 1);
    local _, v22, v23 = Color3.new(v18 * v21.R + v19 * 0 + v20 * 1, v18 * v21.G + v19 * 0 + v20 * 1, v18 * v21.B + v19 * 0 + v20 * 1):ToHSV();

    return p9.ColorPicker.Color.Hue, v22, v23;
end;

function u1.GetPointerPositionFromColor(p24, p25, p26, p27) -- Line: 107
    local v28 = Vector2.new(0.5, 0):Lerp(Vector2.new(1, 1), 1 - p26):Lerp(Vector2.new(0, 1), 1 - p27);

    return UDim2.fromScale(v28.X, 0.0669872981077807 + v28.Y * 0.8660254037844386);
end;

function u1.ColorChanged(p29) -- Line: 112
    p29.ColorImage.ImageColor3 = Color3.fromHSV(p29.ColorPicker.Color.Hue, 1, 1);
end;

return u1;