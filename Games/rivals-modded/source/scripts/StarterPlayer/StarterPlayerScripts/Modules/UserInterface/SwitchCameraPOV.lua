-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.CONSTANTS);
require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"));
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("CameraController"));
require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 16
    -- upvalues: u1 (copy), UILibrary (copy)
    local v2 = setmetatable({}, u1);
    v2.Frame = UILibrary:GetTo("MainFrame", "BottomStack", "SwitchCameraPOV");
    v2.Container = v2.Frame:WaitForChild("Container");
    v2.Title = v2.Container:WaitForChild("Title");
    v2.KeybindIcon = v2.Container:WaitForChild("Keybind");
    v2._effect_hash = 0;
    v2:_Init();

    return v2;
end;

function u1._SwitchEffect(p3) -- Line: 41
end;

function u1._UpdateControls(p4) -- Line: 76
    -- upvalues: ControlsController (copy)
    p4.KeybindIcon.Visible = ControlsController.CurrentControls ~= "Touch";
end;

function u1._Init(u5) -- Line: 80
    -- upvalues: CameraController (copy), ControlsController (copy)
    CameraController.POVStateChanged:Connect(function(p6, p7, p8) -- Line: 81
        -- upvalues: u5 (copy)
        if p8 then
            u5:_SwitchEffect();
        end;
    end);
    ControlsController.ControlsChanged:Connect(function() -- Line: 87
        -- upvalues: u5 (copy)
        u5:_UpdateControls();
    end);
    u5:_UpdateControls();
end;

return u1._new();