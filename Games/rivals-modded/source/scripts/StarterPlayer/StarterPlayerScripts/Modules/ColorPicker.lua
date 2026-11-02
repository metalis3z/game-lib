-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 10
    -- upvalues: u1 (copy), Signal (copy)
    local v3;

    if typeof(p2) == "Instance" then
        v3 = p2:IsA("Frame");
    else
        v3 = false;
    end;

    local v4 = "Argument 1 invalid, expected a Frame, got " .. tostring(p2);
    assert(v3, v4);
    local v5 = setmetatable({}, u1);
    v5.Frame = p2;
    v5.RedFrame = v5.Frame:WaitForChild("Red");
    v5.RedTextBox = v5.RedFrame:WaitForChild("Box");
    v5.GreenFrame = v5.Frame:WaitForChild("Green");
    v5.GreenTextBox = v5.GreenFrame:WaitForChild("Box");
    v5.BlueFrame = v5.Frame:WaitForChild("Blue");
    v5.BlueTextBox = v5.BlueFrame:WaitForChild("Box");
    v5.HexFrame = v5.Frame:WaitForChild("Hex");
    v5.HexTextBox = v5.HexFrame:WaitForChild("Box");
    v5.HexOutline = v5.HexFrame:WaitForChild("Outline");
    v5.Value = nil;
    v5.Updated = Signal.new();
    v5.Changed = Signal.new();
    v5:_Init();

    return v5;
end;

function u1.SetColor(p6, p7, p8) -- Line: 42
    p6.Value = p7;
    p6.Updated:Fire(p6.Value, p8 or false);
    p6:_ValueChanged();
end;

function u1.SetStartingColor(p9, p10) -- Line: 49
    p9.Value = p10;
    p9.Changed:Fire(p9.Value);
    p9:_ValueChanged();
end;

function u1.Destroy(p11) -- Line: 55
    p11.Updated:Destroy();
    p11.Changed:Destroy();
end;

function u1._ClampColorChannel(p12, p13) -- Line: 65
    local v14 = tonumber(p13) or 0;
    local math_floor_ret = math.floor(v14);

    return math.clamp(math_floor_ret, 0, 255);
end;

function u1._ValueChanged(p15) -- Line: 69
    -- upvalues: Utility (copy)
    local Value = p15.Value;
    local v16 = Utility:Color3FromHex(Value);
    local v17 = p15:_ClampColorChannel(v16.R * 255);
    local v18 = p15:_ClampColorChannel(v16.G * 255);
    local v19 = p15:_ClampColorChannel(v16.B * 255);
    p15.RedTextBox.Text = v17;
    p15.GreenTextBox.Text = v18;
    p15.BlueTextBox.Text = v19;
    p15.HexTextBox.Text = Value;
    p15.HexOutline.ImageColor3 = v16;
end;

function u1._UpdateFromRGB(p20) -- Line: 85
    -- upvalues: Utility (copy)
    local v21 = p20:_ClampColorChannel(p20.RedTextBox.Text);
    local v22 = p20:_ClampColorChannel(p20.GreenTextBox.Text);
    local v23 = p20:_ClampColorChannel(p20.BlueTextBox.Text);
    p20:SetColor((Utility:HexFromColor3((Color3.fromRGB(v21, v22, v23)))));
end;

function u1._UpdateFromHex(p24) -- Line: 95
    -- upvalues: Utility (copy)
    local string_lower_ret = string.lower(p24.HexTextBox.Text);
    p24:SetColor(Utility:IsValidHex(string_lower_ret) and string_lower_ret and string_lower_ret or "#000000");
end;

function u1._Init(u25) -- Line: 102
    u25.RedTextBox.FocusLost:Connect(function() -- Line: 103
        -- upvalues: u25 (copy)
        u25:_UpdateFromRGB();
    end);
    u25.GreenTextBox.FocusLost:Connect(function() -- Line: 107
        -- upvalues: u25 (copy)
        u25:_UpdateFromRGB();
    end);
    u25.BlueTextBox.FocusLost:Connect(function() -- Line: 111
        -- upvalues: u25 (copy)
        u25:_UpdateFromRGB();
    end);
    u25.HexTextBox.FocusLost:Connect(function() -- Line: 115
        -- upvalues: u25 (copy)
        u25:_UpdateFromHex();
    end);
    u25:SetStartingColor("#ffffff");
end;

return u1;