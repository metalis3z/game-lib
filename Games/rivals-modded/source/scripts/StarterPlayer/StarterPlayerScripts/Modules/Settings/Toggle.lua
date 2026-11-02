-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local SettingSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("SettingSlot"));
local Color3_fromRGB_ret = Color3.fromRGB(0, 0, 0);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 255, 255);
local Color3_fromRGB_ret3 = Color3.fromRGB(100, 255, 50);
local u1 = setmetatable({}, SettingSlot);
u1.__index = u1;

function u1.new(...) -- Line: 14
    -- upvalues: SettingSlot (copy), u1 (copy)
    local v2 = SettingSlot.new(...);
    local v3 = setmetatable(v2, u1);
    v3.ToggleContainer = v3.ControlsSettingFrame:WaitForChild("Container");
    v3.Background = v3.ToggleContainer:WaitForChild("Background");
    v3.Button = v3.ToggleContainer:WaitForChild("Button");
    v3.Slider = v3.Button:WaitForChild("Slider");
    v3._custom_value_set = false;
    v3:_Init();

    return v3;
end;

function u1._Update(p4) -- Line: 39
    local v5 = p4.Value and UDim2.new(0.75, 0, 0.5, 0) or UDim2.new(0.25, 0, 0.5, 0);

    if p4.Slider:IsDescendantOf(game) then
        p4.Slider:TweenPosition(v5, "Out", "Quint", 0.5, true);

        return;
    end;

    p4.Slider.Position = v5;
end;

function u1._Toggle(p6) -- Line: 49
    p6:InputValue(not p6.Value);
end;

function u1._Init(u7) -- Line: 53
    -- upvalues: Color3_fromRGB_ret (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy), ButtonEffect (copy)
    u7.Changed:Connect(function() -- Line: 54
        -- upvalues: u7 (copy)
        u7:_Update();
    end);
    u7.Button.MouseButton1Click:Connect(function() -- Line: 58
        -- upvalues: u7 (copy)
        u7:_Toggle();
    end);
    u7.Slider:GetPropertyChangedSignal("Position"):Connect(function() -- Line: 62
        -- upvalues: u7 (copy), Color3_fromRGB_ret (ref), Color3_fromRGB_ret (ref), Color3_fromRGB_ret2 (ref), Color3_fromRGB_ret3 (ref)
        local v8 = (u7.Slider.Position.X.Scale - 0.25) / 0.5;
        u7.Slider.ImageColor3 = Color3_fromRGB_ret:Lerp(Color3_fromRGB_ret, v8);
        u7.Background.ImageColor3 = Color3_fromRGB_ret2:Lerp(Color3_fromRGB_ret3, v8);
    end);
    u7:_Update();
    ButtonEffect:Add(u7.Button, nil, {
        ReleaseRatio = 0.95,
        HoverRatio = 0.95
    });
end;

return u1;