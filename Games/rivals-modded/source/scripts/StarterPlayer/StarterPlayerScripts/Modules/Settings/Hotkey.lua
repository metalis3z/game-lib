-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local SettingSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("SettingSlot"));
local u1 = setmetatable({}, SettingSlot);
u1.__index = u1;

function u1.new(...) -- Line: 12
    -- upvalues: SettingSlot (copy), u1 (copy)
    local v2 = SettingSlot.new(...);
    local v3 = setmetatable(v2, u1);
    v3.HotkeyContainer = v3.ControlsSettingFrame:WaitForChild("Container");
    v3.HotkeyBackground = v3.HotkeyContainer:WaitForChild("Background");
    v3.HotkeyButton = v3.HotkeyContainer:WaitForChild("Button");
    v3.HotkeyValueText = v3.HotkeyContainer:WaitForChild("Value");
    v3._destroyed = false;
    v3._listening = false;
    v3._listen_connections = {};
    v3:_Init();

    return v3;
end;

function u1.GetSelection(p4) -- Line: 33
    return p4.HotkeyButton;
end;

function u1.Destroy(p5) -- Line: 37
    -- upvalues: SettingSlot (copy)
    p5._destroyed = true;

    for _, v in pairs(p5._listen_connections) do
        v:Disconnect();
    end;

    SettingSlot.Destroy(p5);
end;

function u1._Update(p6) -- Line: 51
    p6:_StopListening();
    p6.HotkeyValueText.Text = typeof(p6.Value) == "EnumItem" and p6.Value.Name or (p6.Value or "");
end;

function u1._Input(p7, p8) -- Line: 56
    p7:_StopListening();
    p7:SetValue(p7.SettingsInfo.VerifyInput(p8));
end;

function u1._StartListening(u9) -- Line: 61
    -- upvalues: UserInputService (copy)
    if u9._listening or u9._destroyed then
        return;
    end;

    u9._listening = true;
    table.insert(u9._listen_connections, UserInputService.InputBegan:Connect(function(p10) -- Line: 68
        -- upvalues: u9 (copy)
        local v11;

        if p10.KeyCode == Enum.KeyCode.Unknown then
            v11 = p10.UserInputType.Name;
        else
            v11 = p10.KeyCode.Name;
        end;

        u9:_Input(v11);
    end));
    table.insert(u9._listen_connections, UserInputService.InputChanged:Connect(function(p12) -- Line: 72
    end));
    u9.HotkeyBackground.ImageColor3 = Color3.fromRGB(127, 127, 127);
    u9.HotkeyValueText.TextStrokeColor3 = Color3.fromRGB(64, 64, 64);
    u9.HotkeyValueText.Text = "• • •";
end;

function u1._StopListening(p13) -- Line: 81
    if not p13._listening then
        return;
    end;

    p13._listening = false;

    for _, v in pairs(p13._listen_connections) do
        v:Disconnect();
    end;

    p13.HotkeyBackground.ImageColor3 = Color3.fromRGB(0, 150, 255);
    p13.HotkeyValueText.TextStrokeColor3 = Color3.fromRGB(0, 75, 127);
end;

function u1._Setup(p14) -- Line: 96
    p14.HotkeyButton.NextSelectionRight = p14.HotkeyButton;
    p14.HotkeyButton.NextSelectionLeft = p14.HotkeyButton;
end;

function u1._Init(u15) -- Line: 101
    -- upvalues: RunService (copy), ControlsController (copy), ButtonEffect (copy)
    u15.Changed:Connect(function() -- Line: 102
        -- upvalues: u15 (copy)
        u15:_Update();
    end);
    u15.HotkeyButton.MouseButton1Click:Connect(function() -- Line: 106
        -- upvalues: RunService (ref), ControlsController (ref), u15 (copy)
        RunService.Heartbeat:Wait();

        if ControlsController.CurrentControls == "Touch" then
            return;
        end;

        u15:_StartListening();
    end);
    u15:_Setup();
    u15:_Update();
    ButtonEffect:Add(u15.HotkeyButton, true);
end;

return u1;