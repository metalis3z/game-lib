-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.CONSTANTS);
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"));
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"));
local MatchmakingCountdown = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MatchmakingCountdown"));
local Teleporting = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Teleporting"));
local Equipment = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"));
local Shutdown = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Shutdown"));
require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"));
local MobileEditorBar = require(script:WaitForChild("MobileEditorBar"));
local ContextBar = require(script:WaitForChild("ContextBar"));
local MainBar = require(script:WaitForChild("MainBar"));
local Details = require(script:WaitForChild("Details"));
local InsetGui = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("InsetGui");
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 30
    -- upvalues: u1 (copy), InsetGui (copy), Details (copy), MobileEditorBar (copy), ContextBar (copy), MainBar (copy)
    local v2 = setmetatable({}, u1);
    v2.InsetGui = InsetGui;
    v2.MainFrame = v2.InsetGui:WaitForChild("MainFrame");
    v2.Container = v2.MainFrame:WaitForChild("Container");
    v2.LeftButtonsFrame = v2.Container:WaitForChild("LeftButtons");
    v2.RightButtonsFrame = v2.Container:WaitForChild("RightButtons");
    v2.Details = Details.new(v2);
    v2.MobileEditorBar = MobileEditorBar.new(v2);
    v2.ContextBar = ContextBar.new(v2);
    v2.MainBar = MainBar.new(v2);
    v2._local_fighter = nil;
    v2:_Init();

    return v2;
end;

function u1.IsWithinAnyBar(p3, p4, p5) -- Line: 55
    return p3.MobileEditorBar.Bar:IsWithin(p4, p5) or (p3.ContextBar.Bar:IsWithin(p4, p5) or p3.MainBar.Bar:IsWithin(p4, p5));
end;

function u1._UpdateMirrored(p6) -- Line: 63
    -- upvalues: ControlsController (copy)
    local v7;

    if ControlsController.CurrentControls == "Touch" then
        v7 = p6._local_fighter and (p6._local_fighter:Get("IsInDuel") or (p6._local_fighter:Get("IsInShootingRange") or #p6._local_fighter.Items > 0));
    else
        v7 = false;
    end;

    local v8 = not v7;
    local v9;

    if v7 then
        v9 = p6.LeftButtonsFrame;
    else
        v9 = p6.RightButtonsFrame;
    end;

    p6.MainBar.Bar:SetMirrored(v8);
    p6.MainBar.Bar.Frame.Parent = v9;
    p6.ContextBar.Bar:SetMirrored(v8);
    p6.ContextBar.Bar.Frame.Parent = v9;
    local v10 = v8 and 1 or -1;
    p6.ContextBar.Bar.Frame.LayoutOrder = v10 * 1;
    p6.MainBar.Bar.Frame.LayoutOrder = v10 * 2;
end;

function u1._UpdateVisibility(p11) -- Line: 79
    -- upvalues: Pages (copy), Teleporting (copy), MatchmakingCountdown (copy), GuiService (copy), Shutdown (copy)
    local v12 = not (Pages.PageSystem.CurrentPage or Teleporting.Enabled or (MatchmakingCountdown:IsVisible() or GuiService.MenuIsOpen)) and not Shutdown.Enabled;
    p11.Details:SetVisible(v12);
    local v13;

    if v12 then
        v13 = not p11.MobileEditorBar.Bar.Frame.Visible;
    else
        v13 = v12;
    end;

    p11.MainBar:SetVisible(v13);
    local v14;

    if v12 then
        v14 = not p11.MobileEditorBar.Bar.Frame.Visible;
    else
        v14 = v12;
    end;

    p11.ContextBar:SetVisible(v14);

    if v12 then
        v12 = not p11.MainBar.Bar.Frame.Visible;
    end;

    p11.MobileEditorBar:SetVisible(v12);
end;

function u1._CheckBigInset(p15) -- Line: 89
    -- upvalues: GuiService (copy)
    p15.LeftButtonsFrame.Size = UDim2.new(1, 0, 1, -12);
    p15.LeftButtonsFrame.Position = UDim2.new(0, 12, 1, 0);
    p15.LeftButtonsFrame.AnchorPoint = Vector2.new(0, 1);
    local v16 = p15.MainFrame.AbsoluteSize.Y > 100;
    p15.Container.Size = v16 and UDim2.new(0, GuiService.TopbarInset.Width, 0, 58) or UDim2.new(1, 0, 1, 0);
    p15.Container.Position = v16 and UDim2.new(0, GuiService.TopbarInset.Min.X, 0, 0) or UDim2.new(0, 0, 0, 0);
    p15.RightButtonsFrame.Size = p15.LeftButtonsFrame.Size;
    p15.RightButtonsFrame.Position = UDim2.new(-p15.LeftButtonsFrame.Position.X.Scale, -p15.LeftButtonsFrame.Position.X.Offset, p15.LeftButtonsFrame.Position.Y.Scale, p15.LeftButtonsFrame.Position.Y.Offset);
    p15.RightButtonsFrame.AnchorPoint = p15.LeftButtonsFrame.AnchorPoint;
end;

function u1._HookLocalFighter(u17) -- Line: 114
    -- upvalues: FighterController (copy)
    u17._local_fighter = FighterController:WaitForLocalFighter();
    u17._local_fighter:GetDataChangedSignal("IsInDuel"):Connect(function() -- Line: 117
        -- upvalues: u17 (copy)
        u17:_UpdateMirrored();
    end);
    u17._local_fighter:GetDataChangedSignal("IsInShootingRange"):Connect(function() -- Line: 121
        -- upvalues: u17 (copy)
        u17:_UpdateMirrored();
    end);
    u17._local_fighter.ItemAdded:Connect(function() -- Line: 125
        -- upvalues: u17 (copy)
        u17:_UpdateMirrored();
    end);
    u17._local_fighter.ItemRemoved:Connect(function() -- Line: 129
        -- upvalues: u17 (copy)
        u17:_UpdateMirrored();
    end);
    u17:_UpdateMirrored();
end;

function u1._Setup(p18) -- Line: 136
    -- upvalues: Players (copy)
    p18.MainFrame.Size = UDim2.new(1, 0, 1, 0);
    p18.InsetGui.Parent = Players.LocalPlayer.PlayerGui;
end;

function u1._Init(u19) -- Line: 141
    -- upvalues: ControlsController (copy), Equipment (copy), Teleporting (copy), Shutdown (copy), Pages (copy), MatchmakingCountdown (copy), GuiService (copy)
    u19.MainFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 142
        -- upvalues: u19 (copy)
        u19:_CheckBigInset();
    end);
    u19.MainBar.Bar.Frame:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 146
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    u19.MobileEditorBar.Bar.Frame:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 150
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    ControlsController.ControlsChanged:Connect(function() -- Line: 154
        -- upvalues: u19 (copy)
        u19:_UpdateMirrored();
    end);
    Equipment.Opened:Connect(function() -- Line: 158
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    Teleporting.EnabledChanged:Connect(function() -- Line: 162
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    Shutdown.EnabledChanged:Connect(function() -- Line: 166
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    Pages.PageSystem.PagesActivity:Connect(function() -- Line: 170
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
        task.defer(u19._UpdateVisibility, u19);
    end);
    MatchmakingCountdown.VisibilityChanged:Connect(function() -- Line: 175
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(function() -- Line: 179
        -- upvalues: u19 (copy)
        u19:_CheckBigInset();
    end);
    GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(function() -- Line: 183
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    u19:_Setup();
    u19:_CheckBigInset();
    u19:_UpdateVisibility();
    task.defer(u19._HookLocalFighter, u19);
end;

return u1._new();