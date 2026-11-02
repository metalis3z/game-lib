-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 10
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.FighterInterface = p2;
    v3.Frame = v3.FighterInterface.BottomRight.Container:WaitForChild("Spectators");
    v3.Icon = v3.Frame:WaitForChild("Icon");
    v3.Title = v3.Frame:WaitForChild("Value");
    v3.Background = v3.Frame:WaitForChild("Background");
    v3.BackgroundGradient = v3.Background:WaitForChild("UIGradient");
    v3._connections = {};
    v3:_Init();

    return v3;
end;

function u1.UpdateParent(u4) -- Line: 31
    -- upvalues: PlayerDataController (copy)
    task.defer(pcall, function() -- Line: 32
        -- upvalues: PlayerDataController (ref), u4 (copy)
        local v5 = PlayerDataController:GetSetting("Spectators Display") == "Bottom Center";
        local v6 = PlayerDataController:GetSetting("Spectators Display") == "Bottom Left";
        u4.Icon.Position = v6 and UDim2.new(0.162, 0, 0.5, 0) or UDim2.new(0.838, 0, 0.5, 0);
        u4.Title.Position = v6 and UDim2.new(0.162, 0, 0.5, 0) or UDim2.new(0.838, 0, 0.5, 0);
        u4.Icon.AnchorPoint = v6 and Vector2.new(1, 0.5) or Vector2.new(0, 0.5);
        u4.Title.AnchorPoint = v6 and Vector2.new(0, 0.5) or Vector2.new(1, 0.5);
        u4.Title.TextXAlignment = v6 and Enum.TextXAlignment.Left or Enum.TextXAlignment.Right;
        u4.BackgroundGradient.Rotation = v6 and 0 or 180;
        u4.Frame.Parent = v5 and u4.FighterInterface.BottomCenter.Container or (v6 and u4.FighterInterface.BottomLeft.Container or u4.FighterInterface.BottomRight.Container);
        u4:Refresh();
        u4:_UpdateBackground();
    end);
end;

function u1.Refresh(p7) -- Line: 51
    -- upvalues: PlayerDataController (copy)
    local v8 = p7.FighterInterface.ClientFighter:Get("NumSpectators");
    local Frame = p7.Frame;
    local v9;

    if v8 > 0 then
        v9 = PlayerDataController:GetSetting("Spectators Display") ~= "Disabled";
    else
        v9 = false;
    end;

    Frame.Visible = v9;
    p7.Title.Text = v8;
    p7:_UpdateBackground();
end;

function u1.Destroy(p10) -- Line: 60
    for _, v in pairs(p10._connections) do
        v:Disconnect();
    end;

    p10._connections = {};
end;

function u1._UpdateBackground(p11) -- Line: 72
    -- upvalues: UILibrary (copy), PlayerDataController (copy), ControlsController (copy)
    local v12 = math.min(p11.Frame.AbsolutePosition.X - UILibrary.MainGui.AbsolutePosition.X, UILibrary.MainGui.AbsolutePosition.X + UILibrary.MainGui.AbsoluteSize.X - (p11.Frame.AbsolutePosition.X + p11.Frame.AbsoluteSize.X)) * 2;
    p11.Background.Size = UDim2.new(1, v12, 0.875, 0);
    local v13 = PlayerDataController:GetSetting("Padded HUD") == "Using Controller" and ControlsController.CurrentControls == "Gamepad" and true or PlayerDataController:GetSetting("Padded HUD") == "Always On";
    local v14 = PlayerDataController:GetSetting("Spectators Display") ~= "Bottom Center";

    if v14 then
        v14 = not v13;
    end;

    p11.Background.Visible = v14;
end;

function u1._Init(u15) -- Line: 85
    -- upvalues: UILibrary (copy)
    u15.Frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 86
        -- upvalues: u15 (copy)
        u15:_UpdateBackground();
    end);
    u15.Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 90
        -- upvalues: u15 (copy)
        u15:_UpdateBackground();
    end);
    local _connections = u15._connections;
    local PropertyChangedSignal = UILibrary.MainGui:GetPropertyChangedSignal("AbsolutePosition");
    table.insert(_connections, PropertyChangedSignal:Connect(function() -- Line: 94
        -- upvalues: u15 (copy)
        u15:_UpdateBackground();
    end));
    local _connections2 = u15._connections;
    local PropertyChangedSignal2 = UILibrary.MainGui:GetPropertyChangedSignal("AbsoluteSize");
    table.insert(_connections2, PropertyChangedSignal2:Connect(function() -- Line: 98
        -- upvalues: u15 (copy)
        u15:_UpdateBackground();
    end));
    u15:UpdateParent();
    u15:_UpdateBackground();
end;

return u1;