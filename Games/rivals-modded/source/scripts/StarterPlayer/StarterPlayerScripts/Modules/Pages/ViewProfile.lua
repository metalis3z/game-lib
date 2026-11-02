-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local StatisticsLibrary = require(ReplicatedStorage.Modules.StatisticsLibrary);
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
require(ReplicatedStorage.Modules.ItemLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"));
local QueuePadController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("QueuePadController"));
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"));
local SeasonController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SeasonController"));
local PartyController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PartyController"));
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local WeaponSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponSlot"));
local RankIcon = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RankIcon"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 24
    -- upvalues: Page (copy), u1 (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.LoadingFrame = v3.PageFrame:WaitForChild("Loading");
    v3.DotsFrame = v3.LoadingFrame:WaitForChild("Dots");
    v3.ActiveFrame = v3.PageFrame:WaitForChild("Active");
    v3.PlayerFrame = v3.ActiveFrame:WaitForChild("Player");
    v3.MostPlayedWeaponsFrame = v3.PlayerFrame:WaitForChild("MostPlayedWeapons");
    v3.MostPlayedMap = v3.PlayerFrame:WaitForChild("MostPlayedMap");
    v3.DisplayNameText = v3.PlayerFrame:WaitForChild("DisplayName");
    v3.ControlsIcon = v3.DisplayNameText:WaitForChild("Controls");
    v3.UsernameText = v3.PlayerFrame:WaitForChild("Username");
    v3.HeadshotIcon = v3.PlayerFrame:WaitForChild("Headshot");
    v3.BraggingFrame = v3.PlayerFrame:WaitForChild("Bragging");
    v3.LevelImage = v3.BraggingFrame:WaitForChild("Level");
    v3.LevelText = v3.LevelImage:WaitForChild("Value");
    v3.StreakImage = v3.BraggingFrame:WaitForChild("Streak");
    v3.StreakText = v3.StreakImage:WaitForChild("Value");
    v3.RankFrame = v3.BraggingFrame:WaitForChild("Rank");
    v3.RankContainer = v3.RankFrame:WaitForChild("Container");
    v3.RankText = v3.RankFrame:WaitForChild("Title");
    v3.WinsButton = v3.PlayerFrame:WaitForChild("WinsButton");
    v3.WinsButtonCasualBackground = v3.WinsButton:WaitForChild("CasualBackground");
    v3.WinsButtonRankedBackground = v3.WinsButton:WaitForChild("RankedBackground");
    v3.CasualFrame = v3.PlayerFrame:WaitForChild("Casual");
    v3.CasualWinsText = v3.CasualFrame:WaitForChild("Wins");
    v3.CasualWinsTitle = v3.CasualFrame:WaitForChild("Wins");
    v3.CasualWinPercentText = v3.CasualFrame:WaitForChild("WinPercent");
    v3.RankedFrame = v3.PlayerFrame:WaitForChild("Ranked");
    v3.RankedWinsText = v3.RankedFrame:WaitForChild("Wins");
    v3.RankedWinsTitle = v3.RankedWinsText:WaitForChild("Title");
    v3.RankedWinPercentText = v3.RankedFrame:WaitForChild("WinPercent");
    v3.ButtonsFrame = v3.ActiveFrame:WaitForChild("Buttons");
    v3.CloseButton = v3.ButtonsFrame:WaitForChild("Close");
    v3.ChallengeButton = v3.ButtonsFrame:WaitForChild("Challenge");
    v3.ChallengeOnFrame = v3.ChallengeButton:WaitForChild("On");
    v3.ChallengeOffFrame = v3.ChallengeButton:WaitForChild("Off");
    v3.InviteButton = v3.ButtonsFrame:WaitForChild("Invite");
    v3.InviteOnFrame = v3.InviteButton:WaitForChild("On");
    v3.InviteOffFrame = v3.InviteButton:WaitForChild("Off");
    v3._fetch_hash = 0;
    v3._weapon_slots = {};
    v3._last_player_object = nil;
    v3._wins_tab_is_casual = nil;
    v3._wins_tab_hash = 0;
    v3._rank_icon = nil;
    v3:_Init();

    return v3;
end;

function u1.Fetch(p4, p5) -- Line: 81
    -- upvalues: WeaponStatusHandler (copy), ReplicatedStorage (copy), FighterController (copy), SeasonLibrary (copy), DuelLibrary (copy), CONSTANTS (copy), Utility (copy), ComplianceController (copy), StatisticsLibrary (copy), QueuePadController (copy), PartyController (copy), RankIcon (copy), WeaponSlot (copy)
    p4._last_player_object = p5;
    p4._fetch_hash = p4._fetch_hash + 1;
    local _fetch_hash = p4._fetch_hash;
    p4.DotsFrame:AddTag("UILoadingDots");
    p4.LoadingFrame.Visible = true;
    p4.ActiveFrame.Visible = false;

    for _, v in pairs(p4._weapon_slots) do
        v:Destroy();
    end;

    p4._weapon_slots = {};

    if p4._rank_icon then
        p4._rank_icon:Destroy();
        p4._rank_icon = nil;
    end;

    WeaponStatusHandler:ClearStatusElements(p4.DisplayNameText);
    local v6 = ReplicatedStorage.Remotes.Misc.RequestProfile:InvokeServer(p4._last_player_object);
    wait(0.25);

    if _fetch_hash ~= p4._fetch_hash then
        return;
    end;

    if not v6 then
        p4:CloseRequest();

        return;
    end;

    local Fighter = FighterController:GetFighter(p4._last_player_object);
    local HighestELOLeaderboardRanking = SeasonLibrary:GetHighestELOLeaderboardRanking(v6.RankedCurrentELO, p4._last_player_object.UserId);
    local Rank = SeasonLibrary:GetRank(v6.RankedCurrentELO, p4._last_player_object.UserId);
    local Attribute = p4._last_player_object:GetAttribute("StatisticDuelsWinStreak");
    p4.DotsFrame:RemoveTag("UILoadingDots");
    p4.LoadingFrame.Visible = false;
    p4.ActiveFrame.Visible = true;
    p4.MostPlayedMap.Image = v6.FavoriteMap and DuelLibrary.Maps[v6.FavoriteMap] and (DuelLibrary.Maps[v6.FavoriteMap].Image or "") or "";
    p4.UsernameText.Text = "@" .. p4._last_player_object.Name;
    local ControlsIcon = p4.ControlsIcon;
    local CONTROLS_IMAGES = CONSTANTS.CONTROLS_IMAGES;

    if Fighter then
        Fighter = Fighter:Get("Controls");
    end;

    ControlsIcon.Image = CONTROLS_IMAGES[Fighter] or "";
    p4.HeadshotIcon.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, p4._last_player_object.UserId);
    local v7;

    if Attribute then
        v7 = Attribute > 0;
    else
        v7 = Attribute;
    end;

    p4.StreakImage.Visible = v7;
    p4.StreakText.Text = Utility:PrettyNumber(Attribute or 0);
    p4.DisplayNameText.Text = ComplianceController:GetName(p4._last_player_object);

    if HighestELOLeaderboardRanking and HighestELOLeaderboardRanking <= SeasonLibrary.CurrentSeason.TopPlayerLeaderboardRank then
        Rank = "#" .. HighestELOLeaderboardRanking;
    end;

    p4.RankText.Text = Rank;
    p4.CasualWinsTitle.Text = v6.CasualWins and v6.CasualWins ~= 1 and "wins" or "win";
    p4.CasualWinsText.Text = StatisticsLibrary.Info.StatisticDuelsWon.TostringFunction(v6.CasualWins);
    p4.CasualWinPercentText.Text = StatisticsLibrary.Info.StatisticDuelsWinPercent.TostringFunction(v6.CasualWinPercent);
    p4.RankedWinsTitle.Text = v6.RankedWins and v6.RankedWins ~= 1 and "wins" or "win";
    p4.RankedWinsText.Text = StatisticsLibrary.Info.StatisticRankedDuelsWon.TostringFunction(v6.RankedWins);
    p4.RankedWinPercentText.Text = StatisticsLibrary.Info.StatisticRankedDuelsWinPercent.TostringFunction(v6.RankedWinPercent);
    p4.LevelText.Text = Utility:PrettyNumber(v6.Level);
    p4.ChallengeButton.Visible = QueuePadController:CanChallenge(p4._last_player_object);
    p4.InviteButton.Visible = PartyController:CanInvitePlayerToParty(p4._last_player_object);
    WeaponStatusHandler:ApplyItemStatusToText(p4.DisplayNameText, p4._last_player_object:GetAttribute("PlayerStatus"));
    p4._rank_icon = RankIcon.new(v6.RankedCurrentELO, p4._last_player_object.UserId);
    p4._rank_icon:SetParent(p4.RankContainer);

    for i, v in pairs(v6.FavoriteWeapons) do
        local v8 = WeaponSlot.new(v.Name, v);
        v8.Frame.LayoutOrder = i;
        v8.Frame.Parent = p4.MostPlayedWeaponsFrame;
        table.insert(p4._weapon_slots, v8);
        v8:DisableButton();
    end;

    p4:_UpdateCooldowns();
    p4:_UpdateTextBounds();
end;

function u1.SwitchWinsTab(p9, p10) -- Line: 160
    -- upvalues: SeasonController (copy)
    local v11 = SeasonController:IsRankedUnlocked();
    p9.WinsButton.Visible = v11;
    p9.RankFrame.Visible = v11;
    p9._wins_tab_is_casual = p10 or not v11;
    p9.WinsButtonCasualBackground.BackgroundTransparency = p9._wins_tab_is_casual and 0 or 0.75;
    p9.CasualFrame.Visible = p9._wins_tab_is_casual;
    p9.WinsButtonRankedBackground.BackgroundTransparency = p9._wins_tab_is_casual and 0.75 or 0;
    p9.RankedFrame.Visible = not p9._wins_tab_is_casual;
end;

function u1.Open(p12, ...) -- Line: 177
    -- upvalues: Page (copy)
    Page.Open(p12, ...);
    p12:SwitchWinsTab(true);
    task.spawn(p12._SwitchWinsTabLoop, p12);
end;

function u1.Close(p13, ...) -- Line: 183
    -- upvalues: Page (copy)
    p13._wins_tab_hash = p13._wins_tab_hash + 1;
    Page.Close(p13, ...);
end;

function u1._UpdateCooldowns(p14) -- Line: 192
    -- upvalues: QueuePadController (copy), PartyController (copy)
    local _last_player_object = p14._last_player_object;
    local ChallengeOnFrame = p14.ChallengeOnFrame;
    local v15;

    if _last_player_object then
        v15 = not QueuePadController:IsChallengeRequestOnCooldown(_last_player_object);
    else
        v15 = _last_player_object;
    end;

    ChallengeOnFrame.Visible = v15;
    p14.ChallengeOffFrame.Visible = not p14.ChallengeOnFrame.Visible;
    local InviteOnFrame = p14.InviteOnFrame;

    if _last_player_object then
        _last_player_object = not PartyController:IsInviteRequestOnCooldown(_last_player_object);
    end;

    InviteOnFrame.Visible = _last_player_object;
    p14.InviteOffFrame.Visible = not p14.InviteOnFrame.Visible;
end;

function u1._SwitchWinsTabLoop(p16) -- Line: 201
    p16._wins_tab_hash = p16._wins_tab_hash + 1;
    local _wins_tab_hash = p16._wins_tab_hash;

    while true do
        wait(5);

        if _wins_tab_hash ~= p16._wins_tab_hash then
            break;
        end;

        if p16.WinsButton.Visible then
            p16:SwitchWinsTab(not p16._wins_tab_is_casual);
        end;
    end;
end;

function u1._UpdateTextBounds(p17) -- Line: 218
    p17.ControlsIcon.Position = UDim2.new(0, p17.DisplayNameText.TextBounds.X, 0.5, 0);
end;

function u1._Init(u18) -- Line: 222
    -- upvalues: QueuePadController (copy), PartyController (copy), ButtonEffect (copy)
    u18.CloseButton.MouseButton1Click:Connect(function() -- Line: 223
        -- upvalues: u18 (copy)
        u18:CloseRequest();
    end);
    u18.ChallengeButton.MouseButton1Click:Connect(function() -- Line: 227
        -- upvalues: QueuePadController (ref), u18 (copy)
        QueuePadController:SendChallengeRequest(u18._last_player_object);
    end);
    u18.InviteButton.MouseButton1Click:Connect(function() -- Line: 231
        -- upvalues: PartyController (ref), u18 (copy)
        PartyController:SendPartyInvite(u18._last_player_object);
    end);
    u18.DisplayNameText:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 235
        -- upvalues: u18 (copy)
        u18:_UpdateTextBounds();
    end);
    u18.WinsButton.MouseButton1Click:Connect(function() -- Line: 239
        -- upvalues: u18 (copy)
        local v19 = u18;
        v19._wins_tab_hash = v19._wins_tab_hash + 1;
        u18:SwitchWinsTab(not u18._wins_tab_is_casual);
    end);
    QueuePadController.ChallengeRequestCooldownChanged:Connect(function() -- Line: 244
        -- upvalues: u18 (copy)
        u18:_UpdateCooldowns();
    end);
    PartyController.InviteRequestCooldownChanged:Connect(function() -- Line: 248
        -- upvalues: u18 (copy)
        u18:_UpdateCooldowns();
    end);
    u18:_UpdateCooldowns();
    u18:_UpdateTextBounds();
    u18:SwitchWinsTab(true);
    ButtonEffect:Add(u18.CloseButton);
    ButtonEffect:Add(u18.ChallengeButton);
    ButtonEffect:Add(u18.InviteButton);
    ButtonEffect:Add(u18.WinsButton);
end;

return u1._new();