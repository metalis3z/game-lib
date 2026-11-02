-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local GamepadService = game:GetService("GamepadService");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local InputLibrary = require(ReplicatedStorage.Modules.InputLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local UserInterface = Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface");
local MainGui = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("MainGui");
local u1 = { "Shutdown", "PurchasePrompt", "MobileInputs", "Inset", "SwitchCameraPOV", "Pages", "Panels", "Equipment", "Queue", "EliminatedEffect", "Spectate", "HUD", "Lobby", "Notifications", "SideTasks", "Teleporting", "PlayerList", "MatchmakingCountdown", "Spotlight", "JoystickModal", "SideParty", "BossHealth", "MainGlowyBackground", "WarningMessages" };
local u2 = {};
u2.__index = u2;

function u2._new() -- Line: 25
    -- upvalues: u2 (copy), Signal (copy), MainGui (copy)
    local v3 = setmetatable({}, u2);
    v3.ElementsLoaded = Signal.new();
    v3.PageSystemPagesActivity = Signal.new();
    v3.EquipmentOpened = Signal.new();
    v3.MainGui = MainGui;
    v3._are_elements_loaded = false;
    v3._elements = {};
    v3._selected_object_connections = {};
    v3._gamepad_connections = {};
    v3:_Init();

    return v3;
end;

function u2.GetDefaultElement(p4) -- Line: 48
    return p4._elements.Pages and p4._elements.Pages:GetDefaultElement() or nil;
end;

function u2.IsPageOpen(p5, p6) -- Line: 53
    local v7 = p5._elements[p6 or "Pages"];

    return v7 and v7.PageSystem and v7.PageSystem.CurrentPage;
end;

function u2.IsEquipmentOpen(p8) -- Line: 60
    return p8._elements.Equipment and p8._elements.Equipment.IsOpen;
end;

function u2.GetPage(p9, ...) -- Line: 64
    local v10 = p9._elements.Pages and p9._elements.Pages.PageSystem:GetPage(...);

    return v10;
end;

function u2.OpenPage(p11, ...) -- Line: 68
    local v12 = p11._elements.Pages and p11._elements.Pages.PageSystem:OpenPage(...);

    return v12;
end;

function u2.WaitUntilLoaded(p13) -- Line: 72
    if not p13._are_elements_loaded then
        p13.ElementsLoaded:Wait();
    end;
end;

function u2.CloseRequest(p14) -- Line: 78
    local v15 = p14:IsPageOpen();

    if v15 then
        if not v15.CantBeClosedFromInputs then
            p14._elements.Pages:CloseRequest();
        end;

        return;
    end;

    if p14:IsEquipmentOpen() then
        p14._elements.Equipment:CloseRequest();

        return;
    end;

    local v16 = p14:_GetSpectatedDuelInterface();

    if not (v16 and (v16.FinalResults.Buttons.LeaveFrame.Visible or v16.FinalResults.Buttons.ContinueFrame.Visible)) then
        return;
    end;

    if v16.FinalResults.Buttons.ContinueFrame.Visible then
        v16.FinalResults.Buttons:Continue();

        return;
    end;

    v16.FinalResults.Buttons:LeaveRequest();
end;

function u2.PrimaryAction(p17) -- Line: 105
    -- upvalues: Utility (copy)
    if p17._elements.Lobby and (p17._elements.Lobby.Play and (p17._elements.Lobby.Play.IsPlayVisible and Utility:IsUIElementVisible(p17._elements.Lobby.Play.PlayButton))) then
        p17._elements.Lobby.Play:OpenPlayPage();

        return;
    end;

    local v18 = p17:_GetSpectatedDuelInterface();

    if not (v18 and v18.FinalResults.Buttons.PlayAgainFrame.Visible) then
        return;
    end;

    v18.FinalResults.Buttons:PlayAgain();
end;

function u2.SecondaryAction(p19) -- Line: 119
    if not p19._elements.Pages then
        return;
    end;

    local v20 = p19:_GetSpectatedDuelInterface();

    if v20 then
        if v20.FinalResults.Buttons.RematchFrame.Visible then
            v20.FinalResults.Buttons:Rematch();
        end;

        return;
    end;

    local v21 = p19:_GetSpectatedSubject();

    if v21 then
        v21 = v21:Get("IsInShootingRange") or v21:Get("IsInDuel");
    end;

    local v22 = p19:IsPageOpen();

    if not ((v22 or v21) and (not v22 or v22.Name == "Party")) then
        if p19._elements.Lobby and p19._elements.Lobby.Party and p19._elements.Lobby.Party.IsVisible or p19._elements.SideParty and p19._elements.SideParty.IsVisible then
            p19._elements.Pages.PageSystem:OpenPage("Party", true);
        end;
    end;
end;

function u2.TertiaryAction(p23) -- Line: 149
    -- upvalues: Utility (copy)
    if p23._elements.Lobby and (p23._elements.Lobby.Play and (p23._elements.Lobby.Play.IsHubVisible and Utility:IsUIElementVisible(p23._elements.Lobby.Play.HubButton))) then
        p23._elements.Lobby.Play:GoBackToHub();
    end;
end;

function u2.QuaternaryAction(p24) -- Line: 155
    -- upvalues: Utility (copy)
    if p24._elements.Lobby and (p24._elements.Lobby.Play and (p24._elements.Lobby.Play.IsRematchVisible and Utility:IsUIElementVisible(p24._elements.Lobby.Play.RematchButton))) then
        p24._elements.Lobby.Play:RematchRequest();
    end;
end;

function u2._GetSpectatedSubject(p25) -- Line: 165
    -- upvalues: Players (copy)
    return require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController).CurrentSubject;
end;

function u2._GetSpectatedDuelInterface(p26) -- Line: 170
    -- upvalues: Players (copy)
    local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);

    return SpectateController.CurrentDuelSubject and SpectateController.CurrentDuelSubject.DuelInterface;
end;

function u2._CheckSelectedObjectVisible(p27) -- Line: 175
    -- upvalues: GuiService (copy), Utility (copy), GamepadService (copy)
    if GuiService.SelectedObject and not Utility:IsUIElementVisible(GuiService.SelectedObject) then
        GamepadService:DisableGamepadCursor();
    end;
end;

function u2._UpdateSelectedObject(u28) -- Line: 181
    -- upvalues: Players (copy), GuiService (copy), GamepadService (copy)
    if not Players.LocalPlayer:FindFirstChild("PlayerGui") then
        return;
    end;

    if not GuiService.SelectedObject then
        local DefaultElement = u28:GetDefaultElement();
        local v29;

        if DefaultElement and (DefaultElement:IsDescendantOf(Players.LocalPlayer.PlayerGui) and DefaultElement) then
            v29 = DefaultElement;
        else
            v29 = nil;
        end;

        if DefaultElement then
            GamepadService:EnableGamepadCursor(v29);
            GuiService.SelectedObject = v29;

            return;
        end;

        GamepadService:DisableGamepadCursor();
        GuiService.SelectedObject = nil;

        return;
    end;

    for _, v in pairs(u28._selected_object_connections) do
        v:Disconnect();
    end;

    u28._selected_object_connections = {};
    table.insert(u28._selected_object_connections, GuiService.SelectedObject.AncestryChanged:Connect(function() -- Line: 207
        -- upvalues: u28 (copy)
        u28:_CheckSelectedObjectVisible();
    end));
    local _selected_object_connections = u28._selected_object_connections;
    local PropertyChangedSignal = GuiService.SelectedObject:GetPropertyChangedSignal("Visible");
    table.insert(_selected_object_connections, PropertyChangedSignal:Connect(function() -- Line: 211
        -- upvalues: u28 (copy)
        u28:_CheckSelectedObjectVisible();
    end));
    u28:_CheckSelectedObjectVisible();
end;

function u2._UpdateGamepadControls(p30) -- Line: 218
    -- upvalues: ControlsController (copy)
    for _, v in pairs(p30._gamepad_connections) do
        v:Disconnect();
    end;

    for _, v in pairs(p30._selected_object_connections) do
        v:Disconnect();
    end;

    p30._gamepad_connections = {};
    p30._selected_object_connections = {};

    if ControlsController.CurrentControls == "Gamepad" then
    end;
end;

function u2._Setup(u31) -- Line: 243
    -- upvalues: u1 (copy), UserInterface (copy), Players (copy)
    task.defer(function() -- Line: 244
        -- upvalues: u1 (ref), u31 (copy), UserInterface (ref)
        for _, v in pairs(u1) do
            u31._elements[v] = require(UserInterface:WaitForChild(v));
        end;

        u31._elements.Pages.PageSystem.PagesActivity:Connect(function(...) -- Line: 251
            -- upvalues: u31 (ref)
            u31.PageSystemPagesActivity:Fire(...);
        end);
        u31._elements.Equipment.Opened:Connect(function(...) -- Line: 255
            -- upvalues: u31 (ref)
            u31.EquipmentOpened:Fire(...);
        end);
        u31._are_elements_loaded = true;
        u31.ElementsLoaded:Fire();
    end);
    u31.MainGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui");
end;

function u2._Init(u32) -- Line: 267
    -- upvalues: ControlsController (copy), UserInputService (copy), InputLibrary (copy)
    ControlsController.ControlsChanged:Connect(function() -- Line: 268
        -- upvalues: u32 (copy)
        u32:_UpdateGamepadControls();
    end);
    UserInputService.InputBegan:Connect(function(p33, p34) -- Line: 272
        -- upvalues: InputLibrary (ref), u32 (copy)
        if p34 then
            return;
        end;

        if InputLibrary:InputIs(p33, "UICancelAction") then
            u32:CloseRequest();

            return;
        end;

        if InputLibrary:InputIs(p33, "UIPrimaryAction") then
            u32:PrimaryAction();

            return;
        end;

        if InputLibrary:InputIs(p33, "UISecondaryAction") then
            u32:SecondaryAction();

            return;
        end;

        if InputLibrary:InputIs(p33, "UITertiaryAction") then
            u32:TertiaryAction();

            return;
        end;

        if InputLibrary:InputIs(p33, "UIQuaternaryAction") then
            u32:QuaternaryAction();
        end;
    end);
    u32:_Setup();
    u32:_UpdateGamepadControls();
end;

return u2._new();