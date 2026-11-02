-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local StatisticsLibrary = require(ReplicatedStorage.Modules.StatisticsLibrary);
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local EquipmentMetricCard = require(Players.LocalPlayer.PlayerScripts.Modules.EquipmentMetricCard);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local SecondaryActions = require(script:WaitForChild("SecondaryActions"));
local PrimaryActions = require(script:WaitForChild("PrimaryActions"));
local LockedActions = require(script:WaitForChild("LockedActions"));
local Performance = require(script:WaitForChild("Performance"));
local Overview = require(script:WaitForChild("Overview"));
local Details = require(script:WaitForChild("Details"));
local Level = require(script:WaitForChild("Level"));
local UDim2_new_ret = UDim2.new(1.375, 0, 0.5, 0);
local UDim2_new_ret2 = UDim2.new(1, 0, 0.5, 0);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 25
    -- upvalues: u1 (copy), SecondaryActions (copy), PrimaryActions (copy), LockedActions (copy), Performance (copy), Overview (copy), Details (copy), Level (copy)
    local v3 = setmetatable({}, u1);
    v3.Interface = p2;
    v3.Frame = v3.Interface.Frame:WaitForChild("Right");
    v3.List = v3.Frame:WaitForChild("List");
    v3.Container = v3.List:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.TopBufferFrame = v3.Container:WaitForChild("TopBuffer");
    v3.SecondaryActions = SecondaryActions.new(v3);
    v3.PrimaryActions = PrimaryActions.new(v3);
    v3.LockedActions = LockedActions.new(v3);
    v3.Performance = Performance.new(v3);
    v3.Overview = Overview.new(v3);
    v3.Details = Details.new(v3);
    v3.Level = Level.new(v3);
    v3._is_visible = false;
    v3._last_state = nil;
    v3._metric_cards = {
        Performance = v3.Performance.MetricCard,
        Overview = v3.Overview.MetricCard
    };
    v3:_Init();

    return v3;
end;

function u1.SetVisible(p4, p5) -- Line: 55
    -- upvalues: UDim2_new_ret2 (copy), UDim2_new_ret (copy)
    p4._is_visible = p5;
    p4.Frame:TweenPosition(p4._is_visible and UDim2_new_ret2 or UDim2_new_ret, "Out", "Quint", 0.25, true);
end;

function u1.SetMetricCardVisible(p6, p7, p8) -- Line: 60
    p6._metric_cards[p7]:SetOpened(p8);
    p6.PrimaryActions:SetMetricActionVisible(p7, not p8);
    p6.SecondaryActions:SetMetricActionVisible(p7, not p8);
end;

function u1.ResetMetricCards(p9) -- Line: 66
    for i in pairs(p9._metric_cards) do
        p9:SetMetricCardVisible(i, false);
    end;
end;

function u1.ScrollTo(u10, u11, p12) -- Line: 72
    -- upvalues: UILibrary (copy), TweenService (copy)
    task.delay(p12 or 0, function() -- Line: 73
        -- upvalues: u10 (copy), u11 (copy), UILibrary (ref), TweenService (ref)
        local math_min_ret = math.min(u10.List.AbsoluteCanvasSize.Y, u11.AbsolutePosition.Y + UILibrary.MainGui.AbsolutePosition.Y * 2 - u10.Container.AbsolutePosition.Y);
        TweenService:Create(u10.List, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            CanvasPosition = Vector2.new(0, math_min_ret)
        }):Play();
    end);
end;

function u1.OnStateChanged(p13, ...) -- Line: 79
    p13.SecondaryActions:OnStateChanged(...);
    p13.PrimaryActions:OnStateChanged(...);
    p13.LockedActions:OnStateChanged(...);
    p13.Performance:OnStateChanged(...);
    p13.Overview:OnStateChanged(...);
    p13.Details:OnStateChanged(...);
    p13.Level:OnStateChanged(...);
    p13:_OpenEffect();
end;

function u1.OnOpen(p14, ...) -- Line: 90
    p14.SecondaryActions:OnOpen(...);
    p14.PrimaryActions:OnOpen(...);
    p14.Performance:OnOpen(...);
    p14.Overview:OnOpen(...);
end;

function u1._OpenEffect(p15) -- Line: 101
    -- upvalues: PlayerDataController (copy), UDim2_new_ret (copy)
    local SelectedWeapon = p15.Interface.Equipment:GetSelectedWeapon();
    local WeaponData = PlayerDataController:GetWeaponData(SelectedWeapon);

    if SelectedWeapon then
        SelectedWeapon = not WeaponData;
    end;

    p15.List:TweenSize(SelectedWeapon and UDim2.new(1, 0, 1, 0) or UDim2.new(0.7, 0, 1, 0), "Out", "Quint", 0.25, true);
    local StateID = p15.Interface.Equipment:GetStateID();

    if StateID ~= p15._last_state then
        p15._last_state = StateID;
        p15.Frame.Position = UDim2_new_ret;
        p15:SetVisible(p15._is_visible);
    end;
end;

function u1._Update(p16) -- Line: 117
    p16.TopBufferFrame.Size = UDim2.new(1, 0, 0, (math.max(p16.List.AbsoluteSize.Y * 0.375, p16.List.AbsoluteSize.Y - (p16.Layout.AbsoluteContentSize.Y - p16.TopBufferFrame.AbsoluteSize.Y))));
    p16.List.CanvasSize = UDim2.new(0, 0, 0, p16.Layout.AbsoluteContentSize.Y);
end;

function u1._SetupPreviousSeasons(u17) -- Line: 122
    -- upvalues: PlayerDataController (copy), SeasonLibrary (copy), EquipmentMetricCard (copy), StatisticsLibrary (copy)
    local v18 = PlayerDataController:Get("Seasons");
    local v19 = {};

    for i in pairs(SeasonLibrary.Seasons) do
        if v18[i] then
            table.insert(v19, i);
        end;
    end;

    table.sort(v19, function(p20, p21) -- Line: 132
        -- upvalues: SeasonLibrary (ref)
        return SeasonLibrary.Seasons[p20].Version < SeasonLibrary.Seasons[p21].Version;
    end);

    for _, v in pairs(v19) do
        local v22 = v18[v] and v18[v].RankedPerformances and v18[v].RankedPerformances[SeasonLibrary.UNIVERSAL_ELO_NAME];

        if v22 and (v22.DuelsPlayed or 0) > 0 then
            local v23 = SeasonLibrary.Seasons[v];
            local u24 = "season_" .. v;
            local v25 = "Season " .. v23.Version;
            local v26 = "The " .. v23.Name .. " Season";
            local u27 = EquipmentMetricCard.new(v25, "rbxassetid://117835427046796");
            u27:SetParent(u17.Container);
            u17._metric_cards[u24] = u27;
            u27.Opened:Connect(function() -- Line: 153
                -- upvalues: u17 (copy), u27 (copy)
                u17:ScrollTo(u27:GetScrollToElement());
            end);
            u27.Clicked:Connect(function() -- Line: 157
                -- upvalues: u17 (copy), u24 (copy)
                u17:SetMetricCardVisible(u24, false);
            end);

            if v22.DuelsPlayed then
                u27:Add("Duels Played", StatisticsLibrary.Info.StatisticRankedDuelsPlayed.TostringFunction(v22.DuelsPlayed));
            end;

            if v22.DuelsWon then
                u27:Add("Duels Won", StatisticsLibrary.Info.StatisticRankedDuelsWon.TostringFunction(v22.DuelsWon));
            end;

            if v22.DuelsLost then
                u27:Add("Duels Lost", StatisticsLibrary.Info.StatisticRankedDuelsLost.TostringFunction(v22.DuelsLost));
            end;

            if v22.DuelsWinPercent then
                u27:Add("Duels Win %", StatisticsLibrary.Info.StatisticRankedDuelsWinPercent.TostringFunction(v22.DuelsWinPercent));
            end;

            if v22.CurrentELO then
                u27:Add("Final ELO", StatisticsLibrary.Info.StatisticRankedDuelsPlayed.TostringFunction(v22.CurrentELO));
            end;

            if v22.HighestELO then
                u27:Add("Highest ELO", StatisticsLibrary.Info.StatisticRankedDuelsPlayed.TostringFunction(v22.HighestELO));
            end;

            if v22.LowestELO then
                u27:Add("Lowest ELO", StatisticsLibrary.Info.StatisticRankedDuelsPlayed.TostringFunction(v22.LowestELO));
            end;

            if v22.EndOfSeasonRewardsClaimed then
                u27:AddSeasonRewards(v22.EndOfSeasonRewardsClaimed);
            end;

            u17.SecondaryActions:CreateMetricAction(u24, "rbxassetid://117835427046796", v25, v26);
        end;
    end;
end;

function u1._Setup(p28) -- Line: 197
    p28.Visible = true;
end;

function u1._Init(u29) -- Line: 201
    -- upvalues: PlayerDataController (copy)
    u29.List:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 202
        -- upvalues: u29 (copy)
        u29:_Update();
    end);
    u29.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 206
        -- upvalues: u29 (copy)
        u29:_Update();
    end);
    u29.TopBufferFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 210
        -- upvalues: u29 (copy)
        u29:_Update();
    end);
    u29.Performance.MetricCard.Opened:Connect(function() -- Line: 214
        -- upvalues: u29 (copy)
        u29:ScrollTo(u29.Performance.MetricCard:GetScrollToElement());
    end);
    u29.Overview.MetricCard.Opened:Connect(function() -- Line: 218
        -- upvalues: u29 (copy)
        u29:ScrollTo(u29.Overview.MetricCard:GetScrollToElement());
    end);
    PlayerDataController:GetDataChangedSignal("WeaponInventory"):Connect(function() -- Line: 222
        -- upvalues: u29 (copy)
        u29:_OpenEffect();
    end);
    u29:_Setup();
    u29:_SetupPreviousSeasons();
    u29:_Update();
end;

return u1;