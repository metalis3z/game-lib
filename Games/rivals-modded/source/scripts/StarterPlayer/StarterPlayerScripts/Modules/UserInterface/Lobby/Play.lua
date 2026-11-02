-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
require(ReplicatedStorage.Modules.InputLibrary);
local MatchmakingController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MatchmakingController"));
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"));
local ArcadeController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ArcadeController"));
local PartyController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PartyController"));
local Matchmaking = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Lobby"):WaitForChild("Matchmaking"));
local MobileInputs = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MobileInputs"));
local Teleporting = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Teleporting"));
local Equipment = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"));
local Queue = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Queue"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 24
    -- upvalues: u1 (copy), UILibrary (copy)
    local v2 = setmetatable({}, u1);
    v2.Frame = UILibrary:GetTo("MainFrame", "Lobby", "Play");
    v2.HubButton = v2.Frame:WaitForChild("Hub");
    v2.PlayButton = v2.Frame:WaitForChild("Play");
    v2.PlayButtonOffFrame = v2.PlayButton:WaitForChild("Off");
    v2.PlayButtonOffJoinText = v2.PlayButtonOffFrame:WaitForChild("Title");
    v2.PlayButtonJoinFrame = v2.PlayButton:WaitForChild("Join");
    v2.PlayButtonJoinText = v2.PlayButtonJoinFrame:WaitForChild("Title");
    v2.PlayButtonJoinBubble = v2.PlayButtonJoinFrame:WaitForChild("Bubble");
    v2.PlayButtonJoinBubbleText = v2.PlayButtonJoinBubble:WaitForChild("Title");
    v2.PlayButtonJoinBubbleBackground = v2.PlayButtonJoinBubble:WaitForChild("Background");
    v2.RematchButton = v2.Frame:WaitForChild("Rematch");
    v2.RematchCountText = v2.RematchButton:WaitForChild("Count");
    v2.IsHubVisible = false;
    v2.IsPlayVisible = false;
    v2.IsRematchVisible = false;
    v2._bubble_effect = 0;
    v2:_Init();

    return v2;
end;

function u1.GoBackToHub(p3) -- Line: 55
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.Matchmaking.BackToHub:FireServer();
end;

function u1.RematchRequest(p4) -- Line: 59
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.Duels.Rematch:FireServer();
end;

function u1.OpenPlayPage(p5) -- Line: 63
    -- upvalues: CONSTANTS (copy), ArcadeController (copy), PlayerDataController (copy), PartyController (copy), MatchmakingController (copy), Pages (copy)
    if CONSTANTS.IS_ARCADE_SERVER or ArcadeController.CurrentDuel then
        ArcadeController:Join();

        return;
    end;

    if PlayerDataController:GetStatistic("StatisticDuelsPlayed") <= 1 and (PlayerDataController:GetStatistic("StatisticDuelsWon") < CONSTANTS.BEGINNER_QUEUE_WINS and not PartyController.CurrentParty) then
        MatchmakingController:QueueInto(CONSTANTS.BEGINNER_QUEUE_NAME);

        return;
    end;

    Pages.PageSystem:OpenPage("Matchmaking", true);
end;

function u1._UpdateLayouts(p6) -- Line: 80
    p6.PlayButtonJoinBubbleBackground.Size = UDim2.new(0, p6.PlayButtonJoinBubbleText.TextBounds.X + p6.PlayButtonJoinBubble.AbsoluteSize.Y, 1, 0);
end;

function u1._UpdateRematchButton(p7) -- Line: 84
    -- upvalues: MatchmakingController (copy)
    local v8 = MatchmakingController:Get("MatchmadeRematchSuccess");
    local v9 = MatchmakingController:Get("MatchmadeRematchCount");
    local v10 = MatchmakingController:Get("MatchmadeRematchGoal");
    local v11 = MatchmakingController:IsRematchAvailable();
    p7.RematchCountText.Text = v8 and "• • •" or (v11 and v9 .. " / " .. v10 or "Unavailable");
end;

function u1._BubbleEffect(p12) -- Line: 93
    -- upvalues: Players (copy)
    p12._bubble_effect = p12._bubble_effect + 1;
    local _bubble_effect = p12._bubble_effect;

    if not (p12.Frame.Visible and (p12.PlayButtonJoinFrame.Visible and p12.PlayButtonJoinBubble.Visible)) then
        return;
    end;

    while _bubble_effect == p12._bubble_effect do
        if p12.PlayButtonJoinBubble:IsDescendantOf(Players) then
            p12.PlayButtonJoinBubble:TweenPosition(UDim2.new(0.5, 0, -0.5, 0), "Out", "Sine", 0.5, true);
        end;

        wait(0.5);

        if _bubble_effect ~= p12._bubble_effect then
            return;
        end;

        if p12.PlayButtonJoinBubble:IsDescendantOf(Players) then
            p12.PlayButtonJoinBubble:TweenPosition(UDim2.new(0.5, 0, -0.2, 0), "In", "Sine", 0.5, true);
        end;

        wait(0.5);
    end;
end;

function u1._UpdatePlayButton(p13) -- Line: 124
    -- upvalues: CONSTANTS (copy), ArcadeController (copy), PlayerDataController (copy)
    if CONSTANTS.IS_ARCADE_SERVER or ArcadeController.CurrentDuel then
        local JoinCooldown = ArcadeController:GetJoinCooldown();
        local CurrentDuel = ArcadeController.CurrentDuel;

        if CurrentDuel then
            if ArcadeController.CurrentDuel:Get("Status") == "GameOver" then
                CurrentDuel = false;
            else
                CurrentDuel = JoinCooldown <= 0;
            end;
        end;

        p13.PlayButtonJoinBubble.Visible = false;
        p13.PlayButtonOffJoinText.Text = JoinCooldown > 0 and JoinCooldown and JoinCooldown or "Join";
        p13.PlayButtonJoinFrame.Visible = CurrentDuel;
        p13.PlayButtonOffFrame.Visible = not CurrentDuel;
    else
        local v14 = next(PlayerDataController:Get("FreeWeaponTrialsRemaining"));
        p13.PlayButtonJoinBubble.Visible = v14 or PlayerDataController:GetStatistic("StatisticDuelsPlayed") <= 3;
        p13.PlayButtonJoinBubbleText.Text = v14 and "Your free weapon trial is ready!" or "Join the queue to start playing!";
        p13.PlayButtonJoinText.Text = "Play";
        p13.PlayButtonJoinFrame.Visible = true;
        p13.PlayButtonOffFrame.Visible = false;
    end;

    task.spawn(p13._BubbleEffect, p13);
end;

function u1._UpdateVisibility(p15) -- Line: 146
    -- upvalues: Pages (copy), Equipment (copy), Queue (copy), Matchmaking (copy), Teleporting (copy), MobileInputs (copy), GuiService (copy), CONSTANTS (copy), MatchmakingController (copy), PartyController (copy), ArcadeController (copy)
    local v16 = not (Pages.PageSystem.CurrentPage or Equipment.IsOpen or (Queue:IsVisible() or Matchmaking:IsVisible() or (Teleporting.Enabled or MobileInputs.EditorEnabled))) and not GuiService.MenuIsOpen;
    local v17 = v16 and (CONSTANTS.IS_ARCADE_SERVER or MatchmakingController:IsMatchmadeDuelOver()) and PartyController:IsPartyLeader();
    p15.IsHubVisible = v17;
    local v18;

    if v16 then
        v18 = CONSTANTS.QUEUES_ACTIVE or CONSTANTS.IS_ARCADE_SERVER or (ArcadeController.CurrentDuel or MatchmakingController:IsMatchmadeDuelOver());
    else
        v18 = v16;
    end;

    p15.IsPlayVisible = v18;

    if v16 then
        v16 = MatchmakingController:IsRematchAvailable();
    end;

    p15.IsRematchVisible = v16;
    p15.HubButton:TweenPosition(p15.IsHubVisible and UDim2.new(-3.5, 0, 0.5, 0) or UDim2.new(-3.5, 0, 7, 0), "Out", "Quint", 0.25, true);
    p15.PlayButton:TweenPosition(p15.IsPlayVisible and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0.5, 0, 7, 0), "Out", "Quint", 0.25, true);
    p15.RematchButton:TweenPosition(p15.IsRematchVisible and UDim2.new(4.5, 0, 0.5, 0) or UDim2.new(4.5, 0, 7, 0), "Out", "Quint", 0.25, true);
end;

function u1._Init(u19) -- Line: 164
    -- upvalues: PartyController (copy), MatchmakingController (copy), Equipment (copy), Pages (copy), Queue (copy), Matchmaking (copy), Teleporting (copy), MobileInputs (copy), PlayerDataController (copy), ArcadeController (copy), GuiService (copy), ButtonEffect (copy)
    u19.PlayButton.MouseButton1Click:Connect(function() -- Line: 165
        -- upvalues: u19 (copy)
        u19:OpenPlayPage();
    end);
    u19.HubButton.MouseButton1Click:Connect(function() -- Line: 169
        -- upvalues: u19 (copy)
        u19:GoBackToHub();
    end);
    u19.RematchButton.MouseButton1Click:Connect(function() -- Line: 173
        -- upvalues: u19 (copy)
        u19:RematchRequest();
    end);
    u19.Frame:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 177
        -- upvalues: u19 (copy)
        u19:_UpdatePlayButton();
    end);
    u19.PlayButtonJoinBubbleText:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 181
        -- upvalues: u19 (copy)
        u19:_UpdateLayouts();
    end);
    u19.PlayButtonJoinBubble:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 185
        -- upvalues: u19 (copy)
        u19:_UpdateLayouts();
    end);
    PartyController.PartyChanged:Connect(function() -- Line: 189
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    MatchmakingController.MatchmadeDuelEnded:Connect(function() -- Line: 193
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    MatchmakingController.RematchDetailsChanged:Connect(function() -- Line: 197
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
        u19:_UpdateRematchButton();
    end);
    Equipment.Opened:Connect(function() -- Line: 202
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    Pages.PageSystem.PageOpened:Connect(function() -- Line: 206
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    Pages.PageSystem.PageClosed:Connect(function() -- Line: 210
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    Queue.VisibilityChanged:Connect(function() -- Line: 214
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    Matchmaking.VisibilityChanged:Connect(function() -- Line: 218
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    Teleporting.EnabledChanged:Connect(function() -- Line: 222
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    MobileInputs.EditorEnabledChanged:Connect(function() -- Line: 226
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    PlayerDataController:GetDataChangedSignal("StatisticDuelsPlayed"):Connect(function() -- Line: 230
        -- upvalues: u19 (copy)
        u19:_UpdatePlayButton();
    end);
    PlayerDataController:GetDataChangedSignal("FreeWeaponTrialsRemaining"):Connect(function() -- Line: 234
        -- upvalues: u19 (copy)
        u19:_UpdatePlayButton();
    end);
    ArcadeController.DuelSet:Connect(function(p20) -- Line: 238
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
        u19:_UpdatePlayButton();
    end);
    ArcadeController.UpdateJoinCooldown:Connect(function() -- Line: 243
        -- upvalues: u19 (copy)
        u19:_UpdatePlayButton();
    end);
    GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(function() -- Line: 247
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);

    if ArcadeController.CurrentDuel then
        task.defer(u19._ArcadeDuelAdded, u19, ArcadeController.CurrentDuel);
    end;

    u19:_UpdateLayouts();
    u19:_UpdatePlayButton();
    u19:_UpdateVisibility();
    ButtonEffect:Add(u19.HubButton);
    ButtonEffect:Add(u19.PlayButton);
    ButtonEffect:Add(u19.RematchButton);
end;

return u1._new();