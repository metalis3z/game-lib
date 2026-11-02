-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local GuiService = game:GetService("GuiService");
local StarterGui = game:GetService("StarterGui");
local Players = game:GetService("Players");
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local MobileInputs = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("MobileInputs"));
local Teleporting = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Teleporting"));
local PlayerList = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("PlayerList"));
local Equipment = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Equipment"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Pages"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 15
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2.LocalFighter = nil;
    v2:_Init();

    return v2;
end;

function u1._UpdatePlayerList(p3) -- Line: 35
    -- upvalues: GuiService (copy), PlayerList (copy), StarterGui (copy)
    PlayerList:SetScale(GuiService.ViewportDisplaySize == Enum.DisplaySize.Small and 0.75 or 1);
    PlayerList:SetDisabled(false);
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
end;

function u1._UpdateTouchControls(p4) -- Line: 44
    -- upvalues: GuiService (copy), Equipment (copy), Pages (copy)
    GuiService.TouchControlsEnabled = not Equipment.IsOpen and not Pages.PageSystem.CurrentPage;
end;

function u1._UpdateChat(p5) -- Line: 48
    -- upvalues: Teleporting (copy), MobileInputs (copy), StarterGui (copy)
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, not Teleporting.Enabled and not MobileInputs.EditorEnabled or false);
end;

function u1._UpdateLoop(p6) -- Line: 54
    -- upvalues: StarterGui (copy)
    while true do
        pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.EmotesMenu, false);
        pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.Health, false);
        task.defer(p6._UpdatePlayerList, p6);
        task.defer(p6._UpdateChat, p6);
        wait(1);
    end;
end;

function u1._Init(u7) -- Line: 64
    -- upvalues: Teleporting (copy), MobileInputs (copy), PlayerList (copy), GuiService (copy), ControlsController (copy), Equipment (copy), Pages (copy)
    Teleporting.EnabledChanged:Connect(function() -- Line: 65
        -- upvalues: u7 (copy)
        u7:_UpdateChat();
    end);
    MobileInputs.EditorEnabledChanged:Connect(function() -- Line: 69
        -- upvalues: u7 (copy)
        u7:_UpdateChat();
    end);
    PlayerList.BaseVisibilityChanged:Connect(function() -- Line: 73
        -- upvalues: u7 (copy)
        u7:_UpdatePlayerList();
    end);
    GuiService:GetPropertyChangedSignal("ViewportDisplaySize"):Connect(function() -- Line: 77
        -- upvalues: u7 (copy)
        u7:_UpdatePlayerList();
    end);
    ControlsController.ControlsChanged:Connect(function() -- Line: 81
        -- upvalues: u7 (copy)
        u7:_UpdatePlayerList();
    end);
    Equipment.Opened:Connect(function() -- Line: 85
        -- upvalues: u7 (copy)
        u7:_UpdateTouchControls();
    end);
    Pages.PageSystem.PagesActivity:Connect(function() -- Line: 89
        -- upvalues: u7 (copy)
        u7:_UpdateTouchControls();
    end);
    task.defer(u7._UpdateLoop, u7);
    task.defer(u7._UpdateChat, u7);
    task.defer(u7._UpdatePlayerList, u7);
    task.defer(u7._UpdateTouchControls, u7);
end;

return u1._new();