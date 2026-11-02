-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

game:GetService("UserInputService");
game:GetService("RunService");
local Samples = script.Parent:WaitForChild("Samples");
local MouseMovement = require(script.Parent:WaitForChild("MouseMovement"));
local u1 = {};
u1.__index = u1;

local function lerp(p2, p3, p4) -- Line: 10
    return p2 + (p3 - p2) * p4;
end;

function u1.new(p5, p6, p7, p8) -- Line: 14
    -- upvalues: u1 (copy)
    local v9 = setmetatable({}, u1);
    v9.ColorPicker = p5;
    v9.TextLabel = p6;
    v9.Priority = p7;
    v9.MaxValue = p8;
    v9.Visible = true;
    v9.Value = 0;
    v9:Init();

    return v9;
end;

function u1.Create(p10) -- Line: 27
    -- upvalues: Samples (copy)
    local Sliders = p10.ColorPicker.Instance:WaitForChild("Sliders");
    local v11 = Samples:WaitForChild("SliderSample"):Clone();
    v11.Name = string.format("%02d", p10.Priority);
    v11.Text.Text = p10.TextLabel;
    v11.Parent = Sliders;
    p10.Instance = v11;
end;

function u1.SetValue(p12, p13) -- Line: 38
    p12.Value = math.clamp(p13, 0, 1);

    if p12.OnManualChange then
        p12.OnManualChange(p12.Value);
    end;

    p12:UpdateVisual();
end;

function u1.SetVisible(p14, p15) -- Line: 49
    p14.Visible = p15;
    p14.Instance.Visible = p14.Visible;
end;

function u1.UpdateVisual(p16) -- Line: 54
    local Slider = p16.Instance:WaitForChild("Slider");
    local Select = Slider:WaitForChild("Select");
    local Input = p16.Instance:WaitForChild("Input");
    Select.Position = UDim2.new(0, -3 + (Slider.Size.X.Offset - 14 - -3) * p16.Value, 0.5, 0);
    Input.Text = math.round(p16.Value * p16.MaxValue);

    if p16.OnValueChanged then
        p16.OnValueChanged();
    end;
end;

function u1.ColorAdjusted(p17) -- Line: 67
    if p17.GetValue then
        p17.Value = p17.GetValue();
        p17:UpdateVisual();
    end;
end;

function u1.Init(u18) -- Line: 74
    -- upvalues: MouseMovement (copy)
    u18:Create();
    u18:SetVisible(false);
    local SliderButton = u18.Instance:WaitForChild("SliderButton");
    local Slider = u18.Instance:WaitForChild("Slider");
    u18._mouseMovement = MouseMovement.new(function() -- Line: 81
        -- upvalues: u18 (copy), Slider (copy)
        local v19 = ((u18.ColorPicker:GetMousePos() - Vector2.new(4, 0)).X - Slider.AbsolutePosition.X) / (Slider.AbsoluteSize.X - 10);
        local v20 = math.clamp(v19, 0, 1);

        if u18.Value ~= v20 then
            u18:SetValue(v20);

            if u18.ColorPicker.Params.RealTimeEventCalling then
                u18.ColorPicker:_fireColorChanged();
            end;
        end;
    end);
    u18._mouseMovement:OnDisconnect(function() -- Line: 93
        -- upvalues: u18 (copy)
        u18.ColorPicker:_fireColorChanged();
        u18.ColorPicker:WriteHistory();
    end);
    SliderButton.MouseButton1Down:Connect(function() -- Line: 98
        -- upvalues: u18 (copy)
        u18._mouseMovement:Connect();
    end);
    local Input = u18.Instance:WaitForChild("Input");
    Input.FocusLost:Connect(function() -- Line: 103
        -- upvalues: Input (copy), u18 (copy)
        u18:SetValue((tonumber(Input.Text) or 0) / u18.MaxValue);
        u18.ColorPicker:WriteHistory();
        u18.ColorPicker:_fireColorChanged();
    end);
end;

function u1.Destroy(p21) -- Line: 112
    if p21._mouseMovement then
        p21._mouseMovement:Destroy();
        p21._mouseMovement = nil;
    end;

    if p21.Instance then
        p21.Instance:Destroy();
        p21.Instance = nil;
    end;
end;

return u1;