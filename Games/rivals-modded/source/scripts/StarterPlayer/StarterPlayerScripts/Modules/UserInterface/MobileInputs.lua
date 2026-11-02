-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Signal = require(ReplicatedStorage.Modules.Signal);
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"));
local SettingsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SettingsController"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local EditorLogic = require(script:WaitForChild("EditorLogic"));
local DoubleTap = require(script:WaitForChild("DoubleTap"));
local Joystick = require(script:WaitForChild("Joystick"));
local Buttons = require(script:WaitForChild("Buttons"));
Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("MobileButton");
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 18
    -- upvalues: u1 (copy), Signal (copy), UILibrary (copy), DoubleTap (copy), Joystick (copy), Buttons (copy), EditorLogic (copy)
    local v2 = setmetatable({}, u1);
    v2.EditorEnabledChanged = Signal.new();
    v2.Frame = UILibrary:GetTo("MobileInputs");
    v2.EditorEnabled = false;
    v2.DoubleTap = DoubleTap.new(v2);
    v2.Joystick = Joystick.new(v2);
    v2.Buttons = Buttons.new(v2);
    v2.EditorLogic = EditorLogic.new(v2);
    v2:_Init();

    return v2;
end;

function u1.SwitchProfile(p3, p4) -- Line: 39
    -- upvalues: SettingsController (copy)
    local v5 = typeof(p4) == "number";
    assert(v5);
    p3.EditorLogic:ApplyEdits();
    SettingsController:SwitchSettingsProfile(p4);
end;

function u1._IsEnabled(p6) -- Line: 49
    -- upvalues: ControlsController (copy)
    return ControlsController.CurrentControls == "Touch";
end;

function u1._VerifyControls(p7) -- Line: 53
    local v8 = p7:_IsEnabled();
    p7.EditorLogic:SetEnabled(false);
    p7.DoubleTap:VerifyControls(v8);
    p7.Buttons:VerifyControls(v8);
end;

function u1._SetupVisibility(u9) -- Line: 61
    -- upvalues: Players (copy), ControlsController (copy)
    local EliminatedEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("EliminatedEffect"));
    local Equipment = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Equipment"));
    local Pages = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Pages"));

    local function update() -- Line: 66
        -- upvalues: u9 (copy), EliminatedEffect (copy), Equipment (copy), Pages (copy)
        local Frame = u9.Frame;
        local v10 = u9:_IsEnabled() and not (EliminatedEffect:IsVisible() or Equipment.IsOpen) and not Pages.PageSystem.CurrentPage;
        Frame.Visible = v10;
    end;

    ControlsController.ControlsChanged:Connect(update);
    EliminatedEffect.VisibilityChanged:Connect(update);
    Pages.PageSystem.PagesActivity:Connect(update);
    Equipment.Opened:Connect(update);
    local Frame = u9.Frame;
    local v11 = u9:_IsEnabled() and not (EliminatedEffect:IsVisible() or Equipment.IsOpen) and not Pages.PageSystem.CurrentPage;
    Frame.Visible = v11;
end;

function u1._Init(u12) -- Line: 77
    -- upvalues: ControlsController (copy)
    u12.EditorLogic.EnabledChanged:Connect(function() -- Line: 78
        -- upvalues: u12 (copy)
        u12.EditorEnabled = u12.EditorLogic.Enabled;
        u12.EditorEnabledChanged:Fire();
    end);
    ControlsController.ControlsChanged:Connect(function() -- Line: 83
        -- upvalues: u12 (copy)
        u12:_VerifyControls();
    end);
    task.defer(u12._SetupVisibility, u12);
    task.defer(u12._VerifyControls, u12);
end;

return u1._new();