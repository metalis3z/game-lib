-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Slider = require(script.Parent:WaitForChild("Slider"));
local u1 = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.16666666666666666, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.3333333333333333, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.6666666666666666, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(0.8333333333333334, Color3.fromRGB(255, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
});

return {
    Transparency = function(u2) -- Line: 14, Name: Transparency
        -- upvalues: Slider (copy)
        local v3 = Slider.new(u2, "T", 4, 100);
        local Gradient = v3.Instance:WaitForChild("Slider"):WaitForChild("Gradient");
        Gradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) });
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.Position = UDim2.fromOffset(4, 4);
        ImageLabel.Size = UDim2.new(0, 165, 1, -8);
        ImageLabel.Image = "rbxassetid://111137375763311";
        ImageLabel.ImageTransparency = 0.5;
        ImageLabel.ScaleType = Enum.ScaleType.Tile;
        ImageLabel.TileSize = UDim2.fromOffset(10, 10);
        ImageLabel.ZIndex = -1;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(0.5, 0);
        UICorner.Parent = ImageLabel;
        ImageLabel.Parent = v3.Instance;

        function v3.OnManualChange(p4) -- Line: 38
            -- upvalues: u2 (copy)
            u2.Color.Transparency = p4;
            u2:_updateColorVisuals();
        end;

        function v3.GetValue() -- Line: 43
            -- upvalues: u2 (copy)
            return u2.Color.Transparency or 0;
        end;

        function v3.OnValueChanged() -- Line: 47
            -- upvalues: Gradient (copy), u2 (copy)
            Gradient.Color = ColorSequence.new(u2:GetColor());
        end;

        return v3;
    end,

    Hue = function(u5) -- Line: 55, Name: Hue
        -- upvalues: Slider (copy), u1 (copy)
        local v6 = Slider.new(u5, "H", 1, 360);
        v6.Instance:WaitForChild("Slider"):WaitForChild("Gradient").Color = u1;

        function v6.OnManualChange(p7) -- Line: 60
            -- upvalues: u5 (copy)
            u5.Color.Hue = p7;
            u5:_updateColorVisuals();
        end;

        function v6.GetValue() -- Line: 65
            -- upvalues: u5 (copy)
            return u5.Color.Hue or 0;
        end;

        return v6;
    end,

    Saturation = function(u8) -- Line: 72, Name: Saturation
        -- upvalues: Slider (copy)
        local u9 = Slider.new(u8, "S", 2, 100);

        function u9.OnManualChange(p10) -- Line: 74
            -- upvalues: u8 (copy)
            u8.Color.Saturation = p10;
            u8:_updateColorVisuals();
        end;

        function u9.GetValue() -- Line: 79
            -- upvalues: u8 (copy)
            return u8.Color.Saturation or 0;
        end;

        function u9.OnValueChanged() -- Line: 83
            -- upvalues: u8 (copy), u9 (copy)
            local Hue = u8.Color.Hue;
            local _ = u8.Color.Saturation;
            local Value = u8.Color.Value;
            u9.Instance:WaitForChild("Slider"):WaitForChild("Gradient").Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromHSV(Hue, 1, Value)) });
        end;

        return u9;
    end,

    Value = function(u11) -- Line: 98, Name: Value
        -- upvalues: Slider (copy)
        local u12 = Slider.new(u11, "V", 3, 100);

        function u12.OnManualChange(p13) -- Line: 100
            -- upvalues: u11 (copy)
            u11.Color.Value = p13;
            u11:_updateColorVisuals();
        end;

        function u12.GetValue() -- Line: 105
            -- upvalues: u11 (copy)
            return u11.Color.Value or 0;
        end;

        function u12.OnValueChanged() -- Line: 109
            -- upvalues: u11 (copy), u12 (copy)
            local Hue = u11.Color.Hue;
            local Saturation = u11.Color.Saturation;
            local _ = u11.Color.Value;
            u12.Instance:WaitForChild("Slider"):WaitForChild("Gradient").Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromHSV(Hue, Saturation, 1)) });
        end;

        return u12;
    end,

    Red = function(u14) -- Line: 125, Name: Red
        -- upvalues: Slider (copy)
        local u15 = Slider.new(u14, "R", 1, 255);

        function u15.OnManualChange(p16) -- Line: 127
            -- upvalues: u14 (copy)
            local v17 = u14:GetColor();
            local Color = u14.Color;
            local Color2 = u14.Color;
            local Color4 = u14.Color;
            local v18, v19, v20 = Color3.new(p16, v17.G, v17.B):ToHSV();
            Color.Hue = v18;
            Color2.Saturation = v19;
            Color4.Value = v20;
            u14:_updateColorVisuals();
        end;

        function u15.GetValue() -- Line: 135
            -- upvalues: u14 (copy)
            return u14:GetColor().R or 0;
        end;

        function u15.OnValueChanged() -- Line: 139
            -- upvalues: u14 (copy), u15 (copy)
            local v21 = u14:GetColor();
            local G = v21.G;
            local B = v21.B;
            u15.Instance:WaitForChild("Slider"):WaitForChild("Gradient").Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, G, B)), ColorSequenceKeypoint.new(1, Color3.new(1, G, B)) });
        end;

        return u15;
    end,

    Green = function(u22) -- Line: 153, Name: Green
        -- upvalues: Slider (copy)
        local u23 = Slider.new(u22, "G", 2, 255);

        function u23.OnManualChange(p24) -- Line: 155
            -- upvalues: u22 (copy)
            local v25 = u22:GetColor();
            local Color = u22.Color;
            local Color2 = u22.Color;
            local Color4 = u22.Color;
            local v26, v27, v28 = Color3.new(v25.R, p24, v25.B):ToHSV();
            Color.Hue = v26;
            Color2.Saturation = v27;
            Color4.Value = v28;
            u22:_updateColorVisuals();
        end;

        function u23.GetValue() -- Line: 163
            -- upvalues: u22 (copy)
            return u22:GetColor().G or 0;
        end;

        function u23.OnValueChanged() -- Line: 167
            -- upvalues: u22 (copy), u23 (copy)
            local v29 = u22:GetColor();
            local R = v29.R;
            local B = v29.B;
            u23.Instance:WaitForChild("Slider"):WaitForChild("Gradient").Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(R, 0, B)), ColorSequenceKeypoint.new(1, Color3.new(R, 1, B)) });
        end;

        return u23;
    end,

    Blue = function(u30) -- Line: 181, Name: Blue
        -- upvalues: Slider (copy)
        local u31 = Slider.new(u30, "B", 3, 255);

        function u31.OnManualChange(p32) -- Line: 183
            -- upvalues: u30 (copy)
            local v33 = u30:GetColor();
            local Color = u30.Color;
            local Color2 = u30.Color;
            local Color4 = u30.Color;
            local v34, v35, v36 = Color3.new(v33.R, v33.G, p32):ToHSV();
            Color.Hue = v34;
            Color2.Saturation = v35;
            Color4.Value = v36;
            u30:_updateColorVisuals();
        end;

        function u31.GetValue() -- Line: 191
            -- upvalues: u30 (copy)
            return u30:GetColor().B or 0;
        end;

        function u31.OnValueChanged() -- Line: 195
            -- upvalues: u30 (copy), u31 (copy)
            local v37 = u30:GetColor();
            local R = v37.R;
            local G = v37.G;
            u31.Instance:WaitForChild("Slider"):WaitForChild("Gradient").Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(R, G, 0)), ColorSequenceKeypoint.new(1, Color3.new(R, G, 1)) });
        end;

        return u31;
    end
};