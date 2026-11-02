-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local GamepadService = game:GetService("GamepadService");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local u1 = {
    Desktop = "MouseKeyboard",
    Mobile = "Touch",
    Console = "Gamepad",
    VR = "VR"
};
local u2 = {
    [Enum.UserInputType.MouseButton1] = "MouseKeyboard",
    [Enum.UserInputType.MouseButton2] = "MouseKeyboard",
    [Enum.UserInputType.MouseButton3] = "MouseKeyboard",
    [Enum.UserInputType.Keyboard] = "MouseKeyboard",
    [Enum.UserInputType.Touch] = "Touch",
    [Enum.UserInputType.Gamepad1] = "Gamepad",
    [Enum.UserInputType.Gamepad2] = "Gamepad",
    [Enum.UserInputType.Gamepad3] = "Gamepad",
    [Enum.UserInputType.Gamepad4] = "Gamepad",
    [Enum.UserInputType.Gamepad5] = "Gamepad",
    [Enum.UserInputType.Gamepad6] = "Gamepad",
    [Enum.UserInputType.Gamepad7] = "Gamepad",
    [Enum.UserInputType.Gamepad8] = "Gamepad"
};
local u3 = {
    [Enum.KeyCode.W] = "MouseKeyboard",
    [Enum.KeyCode.A] = "MouseKeyboard",
    [Enum.KeyCode.S] = "MouseKeyboard",
    [Enum.KeyCode.D] = "MouseKeyboard"
};
local u4 = {
    ["Mouse & Keyboard"] = "MouseKeyboard",
    ["Touch Buttons"] = "Touch",
    Controller = "Gamepad"
};
local u5 = {};
u5.__index = u5;

function u5._new() -- Line: 35
    -- upvalues: u5 (copy), Signal (copy), u1 (copy), CONSTANTS (copy)
    local v6 = setmetatable({}, u5);
    v6.ControlsChanged = Signal.new();
    v6.CurrentControls = u1[CONSTANTS.DEVICE];
    v6._toggled_inputs = {};
    v6._is_verification_disabled = false;
    v6._set_controls_hash = 0;
    v6._control_scheme_setting = nil;
    v6:_Init();

    return v6;
end;

function u5.IsInputDown(p7, p8) -- Line: 57
    -- upvalues: UserInputService (copy)
    return p8.EnumType == Enum.KeyCode and UserInputService:IsKeyDown(p8) or (p8.EnumType == Enum.UserInputType and UserInputService:IsMouseButtonPressed(p8) or p8.EnumType == Enum.KeyCode and (p7.CurrentControls == "Gamepad" or p7.CurrentControls == "VR") and UserInputService:IsGamepadButtonDown(UserInputService:GetLastInputType(), p8) or p7:IsToggled(p8));
end;

function u5.IsToggled(p9, p10) -- Line: 65
    return p9._toggled_inputs[p10];
end;

function u5.ToggleInput(p11, p12, p13) -- Line: 70
    p11._toggled_inputs[p12] = p13 or nil;
end;

function u5.SetControls(u14, p15) -- Line: 74
    -- upvalues: u4 (copy)
    if u14._control_scheme_setting and u14._control_scheme_setting ~= "Automatic" then
        p15 = u4[u14._control_scheme_setting] or p15;
    end;

    local u16 = p15;

    if not u16 or u16 == u14.CurrentControls then
        return;
    end;

    if u16 == "VR" or u14.CurrentControls == "VR" then
        return;
    end;

    u14._set_controls_hash = u14._set_controls_hash + 1;
    local _set_controls_hash = u14._set_controls_hash;
    task.defer(function() -- Line: 90
        -- upvalues: _set_controls_hash (copy), u14 (copy), u16 (ref)
        if _set_controls_hash ~= u14._set_controls_hash then
            return;
        end;

        u14.CurrentControls = u16;
        u14.ControlsChanged:Fire();
    end);
end;

function u5.DisableVerification(p17, p18) -- Line: 100
    p17._is_verification_disabled = p18;
end;

function u5._ProcessInput(p19, p20, p21) -- Line: 108
    -- upvalues: Utility (copy), GamepadService (copy), GuiService (copy), u2 (copy), u3 (copy)
    if p19._is_verification_disabled or (p21 or Utility:IsTextBoxFocused()) then
        return;
    end;

    if GamepadService.GamepadCursorEnabled or GuiService.SelectedObject then
        return;
    end;

    if (p20.KeyCode == Enum.KeyCode.Thumbstick1 or p20.KeyCode == Enum.KeyCode.Thumbstick2) and (p20.Position * Vector3.new(1, 1, 0)).Magnitude < 0.75 then
        return;
    end;

    p19:SetControls(u2[p20.UserInputType] or u3[p20.KeyCode]);
end;

function u5._SetupControlSchemeSetting(u22) -- Line: 126
    -- upvalues: Players (copy)
    local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);

    local function verify() -- Line: 129
        -- upvalues: u22 (copy), PlayerDataController (copy)
        u22._control_scheme_setting = PlayerDataController:GetSetting("Control Scheme");
        u22:SetControls(u22.CurrentControls);
    end;

    PlayerDataController:GetSettingChangedSignal("Control Scheme"):Connect(verify);
    task.defer(verify);
end;

function u5._Init(u23) -- Line: 138
    -- upvalues: UserInputService (copy)
    UserInputService.InputBegan:Connect(function(...) -- Line: 139
        -- upvalues: u23 (copy)
        u23:_ProcessInput(...);
    end);
    UserInputService.InputChanged:Connect(function(...) -- Line: 143
        -- upvalues: u23 (copy)
        u23:_ProcessInput(...);
    end);
    UserInputService.InputEnded:Connect(function(...) -- Line: 147
        -- upvalues: u23 (copy)
        u23:_ProcessInput(...);
    end);
    task.defer(u23._SetupControlSchemeSetting, u23);
end;

return u5._new();