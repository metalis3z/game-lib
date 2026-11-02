-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local RotatingQueueLibrary = require(ReplicatedStorage.Modules.RotatingQueueLibrary);
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local EventLibrary = require(ReplicatedStorage.Modules.EventLibrary);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local LeaderboardController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("LeaderboardController"));
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local ArcadeController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ArcadeController"));
local MatchmakingQueueSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("BaseMatchmakingQueueSlot"):WaitForChild("MatchmakingQueueSlot"));
local BaseMatchmakingQueueSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("BaseMatchmakingQueueSlot"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local PromptSystem = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"));
local RankIcon = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RankIcon"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("MatchmakingQueueSlot");
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 26
    -- upvalues: Page (copy), u1 (copy), PromptSystem (copy), BaseMatchmakingQueueSlot (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.PromptsFrame = v3.PageFrame:WaitForChild("Prompts");
    v3.PageContainer = v3.PageFrame:WaitForChild("Container");
    v3.CloseButton = v3.PageContainer:WaitForChild("Close");
    v3.List = v3.PageContainer:WaitForChild("List");
    v3.Container = v3.List:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.CenterDuelsFrame = v3.Container:WaitForChild("CenterDuels");
    v3.DuelsFrame = v3.Container:WaitForChild("Duels");
    v3.DuelsContainer = v3.DuelsFrame:WaitForChild("Container");
    v3.DuelsContainerCloseButton = v3.DuelsContainer:WaitForChild("Close");
    v3.QueuesFrame = v3.DuelsContainer:WaitForChild("Queues");
    v3.RankedFrame = v3.DuelsContainer:WaitForChild("Ranked");
    v3.RankedButton = v3.RankedFrame:WaitForChild("Button");
    v3.RankedThumbnail = v3.RankedButton:WaitForChild("Thumbnail");
    v3.RankedLockedFrame = v3.RankedButton:WaitForChild("Locked");
    v3.RankedLockedText = v3.RankedLockedFrame:WaitForChild("Description");
    v3.RankedUnlockedFrame = v3.RankedButton:WaitForChild("Unlocked");
    v3.RankedIconContainer = v3.RankedUnlockedFrame:WaitForChild("IconContainer");
    v3.RankedSeasonText = v3.RankedUnlockedFrame:WaitForChild("Season");
    v3.RankedRankText = v3.RankedUnlockedFrame:WaitForChild("Rank");
    v3.RankedELOText = v3.RankedUnlockedFrame:WaitForChild("ELO");
    v3.AprilFoolsFrame = v3.Container:WaitForChild("AprilFools");
    v3.AprilFoolsContainer = v3.AprilFoolsFrame:WaitForChild("Container");
    v3.AprilFoolsSlotsFrame = v3.AprilFoolsContainer:WaitForChild("Slots");
    v3.AprilFoolsSlotsLayout = v3.AprilFoolsSlotsFrame:WaitForChild("Layout");
    v3.ArcadeServersFrame = v3.Container:WaitForChild("ArcadeServers");
    v3.ArcadeServersContainer = v3.ArcadeServersFrame:WaitForChild("Container");
    v3.ArcadeServersHeaderInfoButton = v3.ArcadeServersContainer:WaitForChild("Header"):WaitForChild("Info");
    v3.ArcadeServersHeaderInfoBubble = v3.ArcadeServersHeaderInfoButton:WaitForChild("Bubble");
    v3.ArcadeServersHeaderInfoBubbleTitle = v3.ArcadeServersHeaderInfoBubble:WaitForChild("Title");
    v3.ArcadeServersHeaderInfoBubbleBackground = v3.ArcadeServersHeaderInfoBubble:WaitForChild("Background");
    v3.RotatingFrame = v3.Container:WaitForChild("Rotating");
    v3.RotatingContainer = v3.RotatingFrame:WaitForChild("Container");
    v3.RotatingHeaderFrame = v3.RotatingContainer:WaitForChild("Header");
    v3.RotatingHeaderTitle = v3.RotatingHeaderFrame:WaitForChild("Title");
    v3.RotatingHeaderNewReleaseFrame = v3.RotatingHeaderFrame:WaitForChild("NewRelease");
    v3.RotatingSlotsFrame = v3.RotatingContainer:WaitForChild("Slots");
    v3.RotatingSlotsLayout = v3.RotatingSlotsFrame:WaitForChild("Layout");
    v3.EventFrame = v3.Container:WaitForChild("Event");
    v3.EventContainer = v3.EventFrame:WaitForChild("Container");
    v3.EventHeaderFrame = v3.EventContainer:WaitForChild("Header");
    v3.EventHeaderIcon = v3.EventHeaderFrame:WaitForChild("Icon");
    v3.EventSlotsFrame = v3.EventContainer:WaitForChild("Slots");
    v3.EventSlotsLayout = v3.EventSlotsFrame:WaitForChild("Layout");
    v3.PromptSystem = PromptSystem.new(v3.PromptsFrame);
    v3.RankedSlot = BaseMatchmakingQueueSlot.new(v3.RankedFrame);
    v3._matchmaking_queue_slots = {};
    v3._rotating_matchmaking_queue_slots = {};
    v3._rotating_batch_containers = {};
    v3._rank_icon = nil;
    v3:_Init();

    return v3;
end;

function u1.ScrollTo(u4, p5, p6) -- Line: 91
    -- upvalues: TweenService (copy)
    local u7;

    if p5 == "Arcade" then
        u7 = u4.ArcadeServersFrame;
    elseif p5 == "Rotating" then
        u7 = u4.RotatingFrame;
    else
        u7 = nil;
    end;

    if not u7 then
        return;
    end;

    task.delay(p6 or 0, function() -- Line: 100
        -- upvalues: TweenService (ref), u4 (copy), u7 (copy)
        TweenService:Create(u4.List, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            CanvasPosition = Vector2.new(0, u7.AbsolutePosition.Y - u4.Container.AbsolutePosition.Y)
        }):Play();
    end);
end;

function u1.Open(p8, ...) -- Line: 105
    -- upvalues: Page (copy)
    Page.Open(p8, ...);
    p8.List.CanvasPosition = Vector2.zero;
    task.defer(p8._GenerateRotatingLoop, p8);
end;

function u1._UpdateLayouts(p9) -- Line: 115
    p9.RotatingFrame.Size = UDim2.new(1, 0, 0.1, p9.RotatingSlotsLayout.AbsoluteContentSize.Y);
    p9.EventFrame.Size = UDim2.new(1, 0, 0.1, p9.EventSlotsLayout.AbsoluteContentSize.Y);
    p9.AprilFoolsFrame.Size = UDim2.new(1, 0, 0.1, p9.AprilFoolsSlotsLayout.AbsoluteContentSize.Y);
    p9.ArcadeServersHeaderInfoBubbleBackground.Size = UDim2.new(0.04, p9.ArcadeServersHeaderInfoBubbleTitle.TextBounds.X, 1, 0);
end;

function u1._UpdateArcadeServerHeaderInfo(p10) -- Line: 122
    p10.ArcadeServersHeaderInfoButton.Visible = true;
end;

function u1._UpdateLocked(p11) -- Line: 126
    -- upvalues: PlayerDataController (copy), SeasonLibrary (copy)
    local v12 = PlayerDataController:Get("Level") < SeasonLibrary.CurrentSeason.LevelRequirement;
    p11.RankedLockedFrame.Visible = v12;
    p11.RankedUnlockedFrame.Visible = not v12;
end;

function u1._UpdateELO(p13) -- Line: 133
    -- upvalues: SeasonLibrary (copy), PlayerDataController (copy), Players (copy), Utility (copy), RankIcon (copy)
    if p13._rank_icon then
        p13._rank_icon:Destroy();
        p13._rank_icon = nil;
    end;

    local _ = SeasonLibrary.CurrentSeason.RankProfile;
    local v14 = PlayerDataController:Get("Seasons")[SeasonLibrary.CurrentSeason.Name];

    if v14 then
        v14 = v14.RankedPerformances[SeasonLibrary.UNIVERSAL_ELO_NAME];
    end;

    if not v14 then
        return;
    end;

    local Rank = SeasonLibrary:GetRank(v14.CurrentELO, Players.LocalPlayer.UserId);
    p13.RankedRankText.Text = Rank;
    local RankedELOText = p13.RankedELOText;
    local v15;

    if v14.CurrentELO then
        v15 = Utility:PrettyNumber(v14.CurrentELO) .. " ELO";
    else
        v15 = v14.DuelsPlayed .. " / " .. SeasonLibrary.CurrentSeason.RankProfile.NumPlacementDuels;
    end;

    RankedELOText.Text = v15;

    if v14.CurrentELO then
        p13._rank_icon = RankIcon.new(v14.CurrentELO, Players.LocalPlayer.UserId);
        p13._rank_icon:SetParent(p13.RankedIconContainer);
    end;
end;

function u1._UpdateList(p16) -- Line: 158
    p16.CloseButton.Position = UDim2.new(0.975, 0, 0.0225, p16.PageFrame.AbsoluteSize.Y * 0.125);
    p16.List.Position = UDim2.new(0.5, 9, 0, p16.PageFrame.AbsoluteSize.Y * 0.125);
    p16.List.Size = UDim2.new(0.85, 0, 0, p16.PageFrame.AbsoluteSize.Y * 0.75);
    p16.List.CanvasSize = UDim2.new(0, 0, 0, p16.Layout.AbsoluteContentSize.Y);
end;

function u1._UpdateOnboarding(p17) -- Line: 165
    -- upvalues: PlayerDataController (copy), Utility (copy), DuelLibrary (copy)
    local Statistic = PlayerDataController:GetStatistic("StatisticDuelsPlayed");
    p17.RotatingFrame.Visible = Statistic >= 3;
    p17.ArcadeServersFrame.Visible = Statistic >= 4;
    local AprilFoolsFrame = p17.AprilFoolsFrame;
    local v18;

    if Statistic >= 10 then
        v18 = Utility:IsAprilFoolsGamemodesEnabled() and DuelLibrary.APRIL_FOOLS_QUEUES and #DuelLibrary.APRIL_FOOLS_QUEUES > 0;
    else
        v18 = false;
    end;

    AprilFoolsFrame.Visible = v18;
    p17.CenterDuelsFrame.Visible = Statistic < 3;
    p17.DuelsContainerCloseButton.Visible = p17.CenterDuelsFrame.Visible;
    p17.CloseButton.Visible = not p17.CenterDuelsFrame.Visible;
end;

function u1._UpdateBeginnerQueue(p19) -- Line: 176
    -- upvalues: CONSTANTS (copy), PlayerDataController (copy)
    local v20 = p19._matchmaking_queue_slots[CONSTANTS.BEGINNER_QUEUE_NAME];

    if not v20 then
        p19.RankedFrame.Visible = true;

        return;
    end;

    local v21 = PlayerDataController:GetStatistic("StatisticDuelsWon") < CONSTANTS.BEGINNER_QUEUE_WINS;
    v20.Frame.Visible = v21;
    p19.RankedFrame.Visible = not v21;
    p19.QueuesFrame.Position = not v21 and UDim2.new(0.7, 0, 0.2, 0) or UDim2.new(1, 0, 0.2, 0);
end;

function u1._RespondToQueueStatus(p22, p23) -- Line: 191
    if p23 == "Success" then
        p22.Closed:Fire();

        return;
    end;

    p22.PromptSystem:Open("ErrorMessage", "Whoops!", p23 or "Server failed to respond, please try again");
end;

function u1._GenerateQueues(u24, p25, p26, p27, p28) -- Line: 199
    -- upvalues: MatchmakingQueueSlot (copy)
    if p27 then
        for _, v in pairs(p27) do
            v:Destroy();
        end;

        table.clear(p27);
    end;

    local v29 = p27 or {};

    for i = 1, math.ceil(#p26 / 2) do
        local Frame = Instance.new("Frame");
        Frame.AnchorPoint = Vector2.new(0.5, 0.5);
        Frame.Size = UDim2.new(1, 0, 1, 0);
        Frame.BackgroundTransparency = 1;
        Frame.Parent = p25;
        table.insert(v29, Frame);
        local UIListLayout = Instance.new("UIListLayout");
        UIListLayout.Padding = UDim.new(0.005, 0);
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
        UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
        UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top;
        UIListLayout.Parent = Frame;
        local v30 = p26[(i - 1) * 2 + 1 + 1] and 2 or 1;
        local v31 = i;

        for i2 = 1, v30 do
            local v32 = p26[(v31 - 1) * 2 + i2];
            local Frame2 = Instance.new("Frame");
            Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
            Frame2.Size = UDim2.new(1 / v30 - UIListLayout.Padding.Scale / 2 * (v30 - 1), 0, v31 > 1 and v30 == 1 and 0.75 or 1, 0);
            Frame2.BackgroundTransparency = 1;
            Frame2.Parent = Frame;
            local v33 = MatchmakingQueueSlot.new(v32, Frame2);
            v33.QueueStatus:Connect(function(p34) -- Line: 238
                -- upvalues: u24 (copy)
                u24:_RespondToQueueStatus(p34);
            end);
            u24._matchmaking_queue_slots[v32] = v33;
            local v35;

            if p28 then
                p28(v32, Frame2, v33);
                v35 = i2;
            else
                v35 = i2;
            end;
        end;
    end;
end;

function u1._GenerateRotating(u36) -- Line: 251
    -- upvalues: RotatingQueueLibrary (copy)
    for _, v in pairs(u36._rotating_matchmaking_queue_slots) do
        v.Container:Destroy();
        v.MatchmakingQueueSlot:Destroy();
    end;

    u36:_GenerateQueues(u36.RotatingSlotsFrame, RotatingQueueLibrary:GetCurrent().QueueNames, u36._rotating_batch_containers, function(p37, p38, p39) -- Line: 257, Name: callback
        -- upvalues: u36 (copy)
        u36._rotating_matchmaking_queue_slots[p37] = {
            Container = p38,
            MatchmakingQueueSlot = p39
        };
    end);
end;

function u1._GenerateRotatingLoop(p40) -- Line: 264
    -- upvalues: RotatingQueueLibrary (copy), Utility (copy)
    local v41 = nil;

    while p40._is_open and p40._is_open_hash == p40._is_open_hash do
        local Cycle = RotatingQueueLibrary:GetCycle();

        if Cycle == v41 then
            Cycle = v41;
        else
            p40:_GenerateRotating();
        end;

        local RotatingHeaderTitle = p40.RotatingHeaderTitle;
        local TimeUntilNext = RotatingQueueLibrary:GetTimeUntilNext();
        RotatingHeaderTitle.Text = "New gamemodes in " .. Utility:TimeFormat2((math.ceil(TimeUntilNext)));
        p40.RotatingHeaderNewReleaseFrame.Visible = RotatingQueueLibrary:IsNewRelease();
        wait(1);
        v41 = Cycle;
    end;
end;

function u1._GenerateQueueSlot(u42, p43) -- Line: 283
    -- upvalues: Utility (copy), MatchmakingQueueSlot (copy), CONSTANTS (copy)
    local v44 = Utility:WaitForChildRecursive(u42.Container, p43, 2);

    if not v44 then
        return;
    end;

    local v45 = MatchmakingQueueSlot.new(p43, v44);
    v45.QueueStatus:Connect(function(p46) -- Line: 292
        -- upvalues: u42 (copy)
        u42:_RespondToQueueStatus(p46);
    end);
    u42._matchmaking_queue_slots[p43] = v45;

    if p43 == CONSTANTS.BEGINNER_QUEUE_NAME then
        u42:_UpdateBeginnerQueue();
    end;
end;

function u1._Setup(p47) -- Line: 303
    -- upvalues: SeasonLibrary (copy), EventLibrary (copy), CONSTANTS (copy), DuelLibrary (copy), BaseMatchmakingQueueSlot (copy), ArcadeController (copy)
    p47.RankedLockedText.Text = "Unlocked at\nLevel " .. SeasonLibrary.CurrentSeason.LevelRequirement;
    p47.RankedSeasonText.Text = "Season " .. SeasonLibrary.CurrentSeason.Version;
    p47.RankedThumbnail.Image = SeasonLibrary.CurrentSeason.ThumbnailRankedCoverPhoto;
    p47.EventHeaderIcon.Image = EventLibrary.EVENT_DETAILS and EventLibrary.EVENT_DETAILS.LTM_HEADER_ICON or p47.EventHeaderIcon.Image;
    p47.ArcadeServersHeaderInfoBubbleTitle.Text = string.format("You must be Level %s+ to earn XP from Arcade Servers\nThis includes Career XP, Weapon XP, & Task progress", CONSTANTS.LEVEL_REQUIRED_FOR_REWARDS_FROM_ARCADE_SERVERS);

    for _, v in pairs(DuelLibrary.MatchmakingQueueOrder) do
        task.defer(p47._GenerateQueueSlot, p47, v);
    end;

    if DuelLibrary.APRIL_FOOLS_QUEUES and #DuelLibrary.APRIL_FOOLS_QUEUES > 0 then
        p47:_GenerateQueues(p47.AprilFoolsSlotsFrame, DuelLibrary.APRIL_FOOLS_QUEUES);
    end;

    p47.EventFrame.Visible = EventLibrary.IS_ACTIVE and EventLibrary.LTM_QUEUENAMES and #EventLibrary.LTM_QUEUENAMES > 0;

    if p47.EventFrame.Visible then
        p47:_GenerateQueues(p47.EventSlotsFrame, EventLibrary.LTM_QUEUENAMES);
    end;

    for _, v in pairs(DuelLibrary.ArcadeModeOrder) do
        local v48 = DuelLibrary.ArcadeModes[v];
        local v49 = p47.ArcadeServersContainer:WaitForChild(v);
        v49:WaitForChild("Button"):WaitForChild("Title").Text = v48.DisplayName;
        v49:WaitForChild("Button"):WaitForChild("Description").Text = v48.Description;
        v49:WaitForChild("Button"):WaitForChild("Thumbnail").Image = v48.Thumbnail;
        BaseMatchmakingQueueSlot.new(v49).Clicked:Connect(function() -- Line: 339
            -- upvalues: ArcadeController (ref), v (copy)
            ArcadeController:ToArcadeServer(v);
        end);
    end;
end;

function u1._Init(u50) -- Line: 345
    -- upvalues: PlayerDataController (copy), SeasonLibrary (copy), Utility (copy), LeaderboardController (copy), ButtonEffect (copy)
    u50.CloseButton.MouseButton1Click:Connect(function() -- Line: 346
        -- upvalues: u50 (copy)
        u50:CloseRequest();
    end);
    u50.DuelsContainerCloseButton.MouseButton1Click:Connect(function() -- Line: 350
        -- upvalues: u50 (copy)
        u50:CloseRequest();
    end);
    u50.ArcadeServersHeaderInfoButton.MouseButton1Click:Connect(function() -- Line: 354
        -- upvalues: u50 (copy)
        u50.ArcadeServersHeaderInfoBubble.Visible = not u50.ArcadeServersHeaderInfoBubble.Visible;
    end);
    u50.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 358
        -- upvalues: u50 (copy)
        u50:_UpdateList();
    end);
    u50.PageFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 362
        -- upvalues: u50 (copy)
        u50:_UpdateList();
    end);
    u50.RankedSlot.Clicked:Connect(function() -- Line: 366
        -- upvalues: PlayerDataController (ref), SeasonLibrary (ref), u50 (copy), Utility (ref)
        if PlayerDataController:Get("Level") >= SeasonLibrary.CurrentSeason.LevelRequirement then
            u50.OpenPage:Fire("Ranked");

            return;
        end;

        Utility:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5);
    end);
    u50.RotatingSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 374
        -- upvalues: u50 (copy)
        u50:_UpdateLayouts();
    end);
    u50.EventSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 378
        -- upvalues: u50 (copy)
        u50:_UpdateLayouts();
    end);
    u50.AprilFoolsSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 382
        -- upvalues: u50 (copy)
        u50:_UpdateLayouts();
    end);
    u50.ArcadeServersHeaderInfoBubbleTitle:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 386
        -- upvalues: u50 (copy)
        u50:_UpdateLayouts();
    end);
    PlayerDataController:GetDataChangedSignal("StatisticDuelsPlayed"):Connect(function() -- Line: 390
        -- upvalues: u50 (copy)
        u50:_UpdateOnboarding();
    end);
    PlayerDataController:GetDataChangedSignal("StatisticDuelsWon"):Connect(function() -- Line: 394
        -- upvalues: u50 (copy)
        u50:_UpdateBeginnerQueue();
    end);
    PlayerDataController:GetDataChangedSignal("Level"):Connect(function() -- Line: 398
        -- upvalues: u50 (copy)
        u50:_UpdateLocked();
        u50:_UpdateArcadeServerHeaderInfo();
    end);
    PlayerDataController:GetDataChangedSignal("Seasons"):Connect(function() -- Line: 403
        -- upvalues: u50 (copy)
        u50:_UpdateELO();
    end);
    LeaderboardController:GetLeaderboardRefreshedSignal("Highest ELO"):Connect(function() -- Line: 407
        -- upvalues: u50 (copy)
        u50:_UpdateELO();
    end);
    u50:_Setup();
    u50:_UpdateList();
    u50:_UpdateOnboarding();
    u50:_UpdateELO();
    u50:_UpdateLocked();
    u50:_UpdateLayouts();
    u50:_UpdateArcadeServerHeaderInfo();
    ButtonEffect:Add(u50.CloseButton);
    ButtonEffect:Add(u50.DuelsContainerCloseButton);
    ButtonEffect:Add(u50.ArcadeServersHeaderInfoButton);
end;

return u1._new();