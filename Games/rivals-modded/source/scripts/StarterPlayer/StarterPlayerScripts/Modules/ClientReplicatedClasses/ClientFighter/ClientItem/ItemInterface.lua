-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local SettingsLibrary = require(ReplicatedStorage.Modules.SettingsLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local SpeedLines = require(script:WaitForChild("SpeedLines"));
local Mouse = require(script:WaitForChild("Mouse"));
local Other = require(script:WaitForChild("Other"));
local ItemInterface = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("ItemInterface");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 25
    -- upvalues: u1 (copy), Signal (copy), ItemInterface (copy), SpeedLines (copy), Mouse (copy), Other (copy)
    local v3 = setmetatable({}, u1);
    v3.ActiveChanged = Signal.new();
    v3.ClientItem = p2;
    v3.Frame = ItemInterface:Clone();
    v3.SpeedLines = SpeedLines.new(v3);
    v3.Mouse = Mouse.new(v3);
    v3.Other = Other.new(v3);
    v3._destroyed = false;
    v3._connections = {};
    v3._fighter_interface_connections = {};
    v3._is_equipped = false;
    v3._original_sizings = {};
    v3._current_duel_subject = nil;
    v3._current_duel_subject_connections = {};
    v3:_Init();

    return v3;
end;

function u1.SetScopeActive(p4, ...) -- Line: 53
    return p4.Mouse.Scope:SetActive(...);
end;

function u1.IsScopeActive(p5, ...) -- Line: 57
    return p5.Mouse.Scope:IsActive(...);
end;

function u1.PlaySpeedLines(p6, ...) -- Line: 61
    return p6.SpeedLines:Create(...);
end;

function u1.DamageEffect(p7, ...) -- Line: 65
    return p7.Mouse.MouseCrosshair:DamageEffect(...);
end;

function u1.IsActive(p8) -- Line: 69
    local v9 = p8.ClientItem.ClientFighter.FighterInterface and p8.ClientItem.ClientFighter.FighterInterface:IsActive();

    return v9;
end;

function u1.CreateSound(p10, ...) -- Line: 73
    -- upvalues: Utility (copy)
    if p10:IsActive() then
        return Utility:CreateSound(...);
    end;
end;

function u1.Equip(p11) -- Line: 81
    p11._is_equipped = true;
end;

function u1.Unequip(p12) -- Line: 85
    p12._is_equipped = false;
    p12.Mouse.Scope:SetActive(false);
end;

function u1.Update(p13, p14, p15, p16) -- Line: 90
    if not (p15.IsSpectating and (not p15.IsHiddenByCutscene and p16.IsActive)) then
        p13.Frame.Visible = false;

        return;
    end;

    p13.Other:Update(p14, p15, p16);
    p13.Mouse:Update(p14, p15, p16);
    p13.SpeedLines:Update(p14, p15, p16);
    p13.Frame.Visible = true;
end;

function u1.Destroy(p17) -- Line: 102
    p17._destroyed = true;

    for _, v in pairs(p17._connections) do
        v:Disconnect();
    end;

    for _, v in pairs(p17._fighter_interface_connections) do
        v:Disconnect();
    end;

    p17._connections = {};
    p17._fighter_interface_connections = {};
    p17:_UpdateCurrentDuelSubject();
    p17.ActiveChanged:Destroy();
    p17.SpeedLines:Destroy();
    p17.Mouse:Destroy();
    p17.Other:Destroy();
    p17.Frame:Destroy();
end;

function u1._UpdateSizing(p18) -- Line: 130
    -- upvalues: UILibrary (copy)
    local v19 = UILibrary.MainGui.AbsoluteSize.X / p18.Frame.AbsoluteSize.X;
    local v20 = UILibrary.MainGui.AbsoluteSize.Y / p18.Frame.AbsoluteSize.Y;

    for _, v in pairs({ "AimingVignette", "SpeedLinesThick", "SpeedLinesThin" }) do
        local v21 = p18.Frame[v];
        p18._original_sizings[v21] = p18._original_sizings[v21] or {
            Position = v21.Position,
            Size = v21.Size
        };
        v21.Size = UDim2.new(p18._original_sizings[v21].Size.X.Scale * v19, p18._original_sizings[v21].Size.X.Offset * v19, p18._original_sizings[v21].Size.Y.Scale * v20, p18._original_sizings[v21].Size.Y.Offset * v20);
        v21.Position = UDim2.new(0.5 + (p18._original_sizings[v21].Position.X.Scale - 0.5) * v19, 0, 0.5 + (p18._original_sizings[v21].Position.Y.Scale - 0.5) * v20, 0);
    end;
end;

function u1._UpdateVisibility(p22) -- Line: 158
    -- upvalues: Pages (copy), GuiService (copy), SpectateController (copy)
    local v23 = not (Pages.PageSystem.CurrentPage or (GuiService.MenuIsOpen or SpectateController:IsSubjectEmoting())) and not (p22._current_duel_subject and (p22._current_duel_subject.DuelInterface and p22._current_duel_subject.DuelInterface.Scoreboard:IsOpen()));
    p22.Mouse:SetVisible(v23);
end;

function u1._UpdateCurrentDuelSubject(u24) -- Line: 167
    -- upvalues: SpectateController (copy)
    for _, v in pairs(u24._current_duel_subject_connections) do
        v:Disconnect();
    end;

    u24._current_duel_subject_connections = {};

    if u24._destroyed then
        return;
    end;

    u24._current_duel_subject = SpectateController.CurrentDuelSubject;
    u24:_UpdateVisibility();

    if not u24._current_duel_subject then
        return;
    end;

    table.insert(u24._current_duel_subject_connections, u24._current_duel_subject.DuelInterface.Scoreboard.VisibilityChanged:Connect(function() -- Line: 185
        -- upvalues: u24 (copy)
        u24:_UpdateVisibility();
    end));
end;

function u1._FighterInterfaceRemoved(p25) -- Line: 190
    for _, v in pairs(p25._fighter_interface_connections) do
        v:Disconnect();
    end;

    p25._fighter_interface_connections = {};
end;

function u1._FighterInterfaceAdded(u26, p27) -- Line: 198
    u26:_FighterInterfaceRemoved();
    table.insert(u26._fighter_interface_connections, p27.ActiveChanged:Connect(function() -- Line: 201
        -- upvalues: u26 (copy)
        u26.ActiveChanged:Fire();
    end));
    u26.ActiveChanged:Fire();
end;

function u1._Setup(p28) -- Line: 208
    -- upvalues: UILibrary (copy)
    p28.Frame.Visible = false;
    p28.Frame.Name = p28.ClientItem.ClientFighter.Player.Name .. " - " .. p28.ClientItem.Name;
    p28.Frame.Parent = UILibrary:GetTo("MainFrame", "ItemInterfaces");
end;

function u1._Init(u29) -- Line: 214
    -- upvalues: UserInputService (copy), CameraController (copy), Pages (copy), GuiService (copy), SpectateController (copy), SettingsLibrary (copy), PlayerDataController (copy)
    u29.Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 215
        -- upvalues: u29 (copy)
        u29:_UpdateSizing();
    end);
    table.insert(u29._connections, u29.ClientItem.ClientFighter.InterfaceAdded:Connect(function(p30) -- Line: 219
        -- upvalues: u29 (copy)
        u29:_FighterInterfaceAdded(p30);
    end));
    table.insert(u29._connections, u29.ClientItem.ClientFighter.InterfaceRemoved:Connect(function() -- Line: 223
        -- upvalues: u29 (copy)
        u29:_FighterInterfaceRemoved();
    end));
    local _connections = u29._connections;
    local PropertyChangedSignal = UserInputService:GetPropertyChangedSignal("MouseIconEnabled");
    table.insert(_connections, PropertyChangedSignal:Connect(function() -- Line: 227
        -- upvalues: u29 (copy)
        u29.Mouse:Refresh();
    end));
    local _connections2 = u29._connections;
    local PropertyChangedSignal2 = UserInputService:GetPropertyChangedSignal("MouseBehavior");
    table.insert(_connections2, PropertyChangedSignal2:Connect(function() -- Line: 231
        -- upvalues: u29 (copy)
        u29.Mouse:Refresh();
    end));
    table.insert(u29._connections, CameraController.POVStateChanged:Connect(function() -- Line: 235
        -- upvalues: u29 (copy)
        u29.Mouse:Refresh();
    end));
    table.insert(u29._connections, Pages.PageSystem.PagesActivity:Connect(function() -- Line: 239
        -- upvalues: u29 (copy)
        u29:_UpdateVisibility();
    end));
    local _connections3 = u29._connections;
    local PropertyChangedSignal3 = GuiService:GetPropertyChangedSignal("MenuIsOpen");
    table.insert(_connections3, PropertyChangedSignal3:Connect(function() -- Line: 243
        -- upvalues: u29 (copy)
        u29:_UpdateVisibility();
    end));
    table.insert(u29._connections, SpectateController.DuelSubjectChanged:Connect(function() -- Line: 247
        -- upvalues: u29 (copy)
        u29:_UpdateCurrentDuelSubject();
    end));
    table.insert(u29._connections, SpectateController.SubjectEmoteStatusChanged:Connect(function() -- Line: 251
        -- upvalues: u29 (copy)
        u29:_UpdateVisibility();
    end));

    if u29.ClientItem.ClientFighter.IsLocalPlayer then
        for i, v in pairs(SettingsLibrary.Info) do
            if v.Section == "Crosshair" then
                local _connections4 = u29._connections;
                local SettingChangedSignal = PlayerDataController:GetSettingChangedSignal(i);
                table.insert(_connections4, SettingChangedSignal:Connect(function() -- Line: 258
                    -- upvalues: u29 (copy)
                    u29.Mouse.MouseCrosshair:Refresh();
                end));
            end;
        end;
    else
        local _connections4 = u29._connections;
        local DataChangedSignal = u29.ClientItem.ClientFighter:GetDataChangedSignal("CompressedCrosshairAppearance");
        table.insert(_connections4, DataChangedSignal:Connect(function() -- Line: 264
            -- upvalues: u29 (copy)
            u29.Mouse.MouseCrosshair:Refresh();
        end));
    end;

    if u29.ClientItem.ClientFighter.FighterInterface then
        task.defer(u29._FighterInterfaceAdded, u29, u29.ClientItem.ClientFighter.FighterInterface);
    end;

    u29:_Setup();
    u29:_UpdateSizing();
    u29:_UpdateVisibility();
    u29.Mouse.MouseCrosshair:Refresh();
    u29.Mouse:Refresh();
    u29:Unequip();
    task.defer(u29._UpdateCurrentDuelSubject, u29);
end;

return u1;