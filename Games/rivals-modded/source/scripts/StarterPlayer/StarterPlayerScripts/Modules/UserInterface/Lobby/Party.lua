-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local MatchmakingController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MatchmakingController"));
local Matchmaking = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Lobby"):WaitForChild("Matchmaking"));
local MobileInputs = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MobileInputs"));
local Teleporting = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Teleporting"));
local Equipment = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"));
local Queue = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Queue"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"));
local PartyDisplay = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PartyDisplay"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 18
    -- upvalues: u1 (copy), UILibrary (copy), PartyDisplay (copy)
    local v2 = setmetatable({}, u1);
    v2.IsVisible = false;
    v2.Frame = UILibrary:GetTo("MainFrame", "Lobby", "Party");
    v2.BottomDisplayFrame = v2.Frame:WaitForChild("BottomDisplay");
    v2.BottomDisplayContainer = v2.BottomDisplayFrame:WaitForChild("Container");
    v2.BottomDisplayLayout = v2.BottomDisplayContainer:WaitForChild("Layout");
    v2.BottomPartyDisplay = PartyDisplay.new(v2.BottomDisplayContainer);
    v2._last_tween = nil;
    v2:_Init();

    return v2;
end;

function u1._UpdateVisibility(p3) -- Line: 46
    -- upvalues: Pages (copy), Equipment (copy), Queue (copy), Teleporting (copy), MobileInputs (copy), GuiService (copy), Matchmaking (copy), MatchmakingController (copy), TweenService (copy)
    if p3._last_tween then
        p3._last_tween:Pause();
        p3._last_tween = nil;
    end;

    local v4 = not (Pages.PageSystem.CurrentPage or (Equipment.IsOpen or Queue:IsVisible() or (Teleporting.Enabled or MobileInputs.EditorEnabled))) and not GuiService.MenuIsOpen;
    local v5 = Matchmaking:IsVisible();
    local v6 = MatchmakingController:IsRematchAvailable();
    local v7;

    if v5 then
        v7 = Enum.HorizontalAlignment.Center;
    else
        v7 = Enum.HorizontalAlignment.Left;
    end;

    local v8;

    if v5 then
        v8 = Vector2.new(0.5, 0.5);
    else
        v8 = Vector2.new(0, 0);
    end;

    local v9;

    if v5 and v4 then
        v9 = UDim2.new(0.5, 0, 0.5, 0);
    elseif v5 and not v4 then
        v9 = UDim2.new(0.5, 0, 7, 0);
    elseif v4 and v6 then
        v9 = UDim2.new(2.75, 0, -1.25, 0);
    elseif v4 then
        v9 = UDim2.new(2.75, 0, 0, 0);
    else
        v9 = UDim2.new(2.75, 0, 7, 0);
    end;

    p3.IsVisible = v4;
    p3.BottomDisplayLayout.HorizontalAlignment = v7;
    p3._last_tween = TweenService:Create(p3.BottomDisplayContainer, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Position = v9,
        AnchorPoint = v8
    });
    p3._last_tween:Play();
end;

function u1._Init(u10) -- Line: 70
    -- upvalues: Equipment (copy), Pages (copy), Queue (copy), Matchmaking (copy), Teleporting (copy), MobileInputs (copy), MatchmakingController (copy), GuiService (copy)
    Equipment.Opened:Connect(function() -- Line: 71
        -- upvalues: u10 (copy)
        u10:_UpdateVisibility();
    end);
    Pages.PageSystem.PageOpened:Connect(function() -- Line: 75
        -- upvalues: u10 (copy)
        u10:_UpdateVisibility();
    end);
    Pages.PageSystem.PageClosed:Connect(function() -- Line: 79
        -- upvalues: u10 (copy)
        u10:_UpdateVisibility();
    end);
    Queue.VisibilityChanged:Connect(function() -- Line: 83
        -- upvalues: u10 (copy)
        u10:_UpdateVisibility();
    end);
    Matchmaking.VisibilityChanged:Connect(function() -- Line: 87
        -- upvalues: u10 (copy)
        u10:_UpdateVisibility();
    end);
    Teleporting.EnabledChanged:Connect(function() -- Line: 91
        -- upvalues: u10 (copy)
        u10:_UpdateVisibility();
    end);
    MobileInputs.EditorEnabledChanged:Connect(function() -- Line: 95
        -- upvalues: u10 (copy)
        u10:_UpdateVisibility();
    end);
    MatchmakingController.RematchDetailsChanged:Connect(function() -- Line: 99
        -- upvalues: u10 (copy)
        u10:_UpdateVisibility();
    end);
    GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(function() -- Line: 103
        -- upvalues: u10 (copy)
        u10:_UpdateVisibility();
    end);
    u10:_UpdateVisibility();
end;

return u1._new();