-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local MonetizationLibrary = require(ReplicatedStorage.Modules.MonetizationLibrary);
local StatisticsLibrary = require(ReplicatedStorage.Modules.StatisticsLibrary);
local ContractsLibrary = require(ReplicatedStorage.Modules.ContractsLibrary);
local EventLibrary = require(ReplicatedStorage.Modules.EventLibrary);
local ServerOsTime = require(ReplicatedStorage.Modules.ServerOsTime);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local TaskLibrary = require(ReplicatedStorage.Modules.TaskLibrary);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ShootingRangeController = require(Players.LocalPlayer.PlayerScripts.Controllers.ShootingRangeController);
local MonetizationController = require(Players.LocalPlayer.PlayerScripts.Controllers.MonetizationController);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local LobbyController = require(Players.LocalPlayer.PlayerScripts.Controllers.LobbyController);
local TimerController = require(Players.LocalPlayer.PlayerScripts.Controllers.TimerController);
local AdventCalendarSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("AdventCalendarSlot"));
local DropdownSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("DropdownSlot"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"));
local TaskSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("TaskSlot"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local DailyTaskStreakMilestoneSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DailyTaskStreakMilestoneSlot");
local TaskContractMilestoneDivider = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("TaskContractMilestoneDivider");
local DailyTaskStreakSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DailyTaskStreakSlot");
local TaskContractMilestoneSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("TaskContractMilestoneSlot");
local TaskContainer = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("TaskContainer");
local u1 = {
    {
        "Tasks",
        "Daily Tasks",
        "rbxassetid://17653923757",
        UDim2.new(2, 0, 1.5, 0)
    },
    { "LimitedTasks", nil, nil, nil },
    {
        "SpecialChallenges",
        "Special Challenge" .. (#(TaskLibrary.SPECIAL_CHALLENGES or {}) == 1 and "" or "s") .. "!",
        "rbxassetid://17860673529",
        UDim2.new(2, 0, 2, 0),
        "Limited time only!"
    },
    {
        "EventTasks",
        "Earn " .. EventLibrary.EVENT_DETAILS.CURRENCY_NAME_PLURAL .. "!",
        EventLibrary.EVENT_DETAILS.CURRENCY_IMAGE,
        UDim2.new(2.25, 0, 2.25, 0),
        "Limited time only!"
    },
    {
        "BonusTasks",
        "Bonus Tasks",
        "rbxassetid://17653923757",
        UDim2.new(2, 0, 1.5, 0)
    }
};
local u2 = setmetatable({}, Page);
u2.__index = u2;

function u2._new() -- Line: 43
    -- upvalues: Page (copy), u2 (copy), AdventCalendarSlot (copy)
    local v3 = Page.new(script.Name);
    local v4 = setmetatable(v3, u2);
    v4.CloseButton = v4.PageFrame:WaitForChild("Close");
    v4.List = v4.PageFrame:WaitForChild("List");
    v4.Container = v4.List:WaitForChild("Container");
    v4.Layout = v4.Container:WaitForChild("Layout");
    v4.TasksCompletedFrame = v4.Container:WaitForChild("TasksCompleted");
    v4.TasksCompletedContainer = v4.TasksCompletedFrame:WaitForChild("Container");
    v4.TasksCompletedTimerText = v4.TasksCompletedContainer:WaitForChild("Timer");
    v4.TasksCompletedContentsFrame = v4.TasksCompletedContainer:WaitForChild("Contents");
    v4.TasksCompletedContentsLayout = v4.TasksCompletedContentsFrame:WaitForChild("Layout");
    v4.TasksCompletedRefreshFrame = v4.TasksCompletedContentsFrame:WaitForChild("Refresh");
    v4.TasksCompletedRefreshRewardsFrame = v4.TasksCompletedRefreshFrame:WaitForChild("Rewards");
    v4.TasksCompletedRefreshButton = v4.TasksCompletedRefreshFrame:WaitForChild("Button");
    v4.TasksCompletedRefreshButtonText = v4.TasksCompletedRefreshButton:WaitForChild("Price");
    v4.ContractsFrame = v4.Container:WaitForChild("Contracts");
    v4.ContractsContainer = v4.ContractsFrame:WaitForChild("Container");
    v4.ContractsFilterButton = v4.ContractsContainer:WaitForChild("Filter");
    v4.ContractsDropdownFrame = v4.ContractsContainer:WaitForChild("Dropdown");
    v4.ContractsDropdownButton = v4.ContractsDropdownFrame:WaitForChild("Button");
    v4.ContractsDropdownTitle = v4.ContractsDropdownButton:WaitForChild("Title");
    v4.ContractsMilestones = v4.ContractsContainer:WaitForChild("Milestones");
    v4.ContractsLayout = v4.ContractsMilestones:WaitForChild("Layout");
    v4.AdventCalendarFrame = v4.Container:WaitForChild("AdventCalendar");
    v4.AdventCalendarSlot = AdventCalendarSlot.new(v4.AdventCalendarFrame);
    v4._to_shooting_range_button = nil;
    v4._to_duels_button = nil;
    v4._task_containers = {};
    v4._task_slots = {};
    v4._contract_slots = {};
    v4._contract_dividers = {};
    v4._daily_task_streak_cleanup = {};
    v4._daily_task_streak_reward_slots = {};
    v4._daily_task_streak_update_callbacks = {};
    v4._percent_contract_goal_enabled = false;
    v4._while_open_callbacks = {};
    v4:_Init();

    return v4;
end;

function u2.ScrollTo(u5, p6, p7) -- Line: 92
    -- upvalues: TweenService (copy)
    local u8 = u5._task_containers[p6];

    if not u8 then
        return;
    end;

    task.delay(p7 or 0, function() -- Line: 99
        -- upvalues: TweenService (ref), u5 (copy), u8 (copy)
        TweenService:Create(u5.List, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            CanvasPosition = Vector2.new(0, u8.AbsolutePosition.Y - u5.Container.AbsolutePosition.Y)
        }):Play();
    end);
end;

function u2.Open(u9, ...) -- Line: 104
    -- upvalues: Page (copy), PlayerDataController (copy), TimerController (copy), TaskLibrary (copy)
    Page.Open(u9, ...);
    u9.AdventCalendarSlot:SetEnabled(true);
    u9.ContractsDropdownFrame.Visible = PlayerDataController:Get("Level") >= 15;
    table.insert(u9._open_threads, task.spawn(function() -- Line: 110
        -- upvalues: u9 (copy)
        while true do
            for _, v in pairs(u9._while_open_callbacks) do
                v();
            end;

            wait(1);
        end;
    end));
    table.insert(u9._open_threads, task.spawn(function() -- Line: 120
        -- upvalues: u9 (copy)
        while true do
            wait(3);

            for _, v in pairs(u9._daily_task_streak_reward_slots) do
                v.Frame:TweenPosition(UDim2.new(0.5, 0, -0.125, 0), "Out", "Quint", 1, true);
            end;

            wait(0.75);

            for _, v in pairs(u9._daily_task_streak_reward_slots) do
                v.Frame:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Bounce", 1, true);
            end;
        end;
    end));
    local _open_connections = u9._open_connections;
    local DataChangedSignal = PlayerDataController:GetDataChangedSignal("StatisticDuelsPlayed");
    table.insert(_open_connections, DataChangedSignal:Connect(function() -- Line: 136
        -- upvalues: u9 (copy)
        u9:_Generate();
    end));
    local _open_connections2 = u9._open_connections;
    local DataChangedSignal2 = PlayerDataController:GetDataChangedSignal("BeginnerTasksCompleted");
    table.insert(_open_connections2, DataChangedSignal2:Connect(function() -- Line: 140
        -- upvalues: u9 (copy)
        u9:_Generate();
    end));
    local _open_connections3 = u9._open_connections;
    local DataChangedSignal3 = PlayerDataController:GetDataChangedSignal("DailyTaskStreak");
    table.insert(_open_connections3, DataChangedSignal3:Connect(function() -- Line: 144
        -- upvalues: u9 (copy)
        u9:_Generate();
    end));
    table.insert(u9._open_connections, TimerController.TimerUpdated:Connect(function() -- Line: 148
        -- upvalues: u9 (copy)
        u9:_Generate();
    end));

    for _, v in pairs(TaskLibrary.TASKS_DATA_NAMES) do
        local _open_connections4 = u9._open_connections;
        local DataChangedSignal4 = PlayerDataController:GetDataChangedSignal(v);
        table.insert(_open_connections4, DataChangedSignal4:Connect(function() -- Line: 153
            -- upvalues: u9 (copy)
            u9:_Generate();
        end));
    end;

    u9:_Generate();
end;

function u2.Close(p10, ...) -- Line: 161
    -- upvalues: TimerController (copy), Page (copy)
    TimerController:OnStep("TaskPage", nil, nil);
    p10.AdventCalendarSlot:SetEnabled(false);
    p10:_StopDropdown();
    Page.Close(p10, ...);
end;

function u2._StopDropdown(p11) -- Line: 172
    if p11._dropdown_slot then
        p11._dropdown_slot:Cancel();
        p11._dropdown_slot = nil;
    end;

    p11.ContractsDropdownButton.Visible = true;
end;

function u2._StartDropdown(u12) -- Line: 181
    -- upvalues: DropdownSlot (copy)
    u12:_StopDropdown();
    u12.ContractsDropdownButton.Visible = false;
    u12._dropdown_slot = DropdownSlot.new(u12.ContractsDropdownFrame, { "Near Completion", "Most Played" });
    u12._dropdown_slot.Selected:Connect(function(p13) -- Line: 188
        -- upvalues: u12 (copy)
        if p13 then
            u12.ContractsDropdownTitle.Text = p13;
            u12:_Generate();
        end;

        u12:_StopDropdown();
    end);
end;

function u2._SetPercentContractGoalEnabled(p14, p15) -- Line: 198
    p14._percent_contract_goal_enabled = p15;

    for _, v in pairs(p14._contract_slots) do
        v.GoalPercent.Visible = p14._percent_contract_goal_enabled;
        v.Goal.Visible = not p14._percent_contract_goal_enabled;
    end;
end;

function u2._CreateDailyTaskStreakSlot(u16, p17) -- Line: 207
    -- upvalues: DailyTaskStreakSlot (copy), PlayerDataController (copy), TaskLibrary (copy), DailyTaskStreakMilestoneSlot (copy), Utility (copy), RewardSlot (copy)
    local u18 = p17 or false;
    local u19 = DailyTaskStreakSlot:Clone();

    local function update(p20, p21) -- Line: 212
        -- upvalues: u19 (copy), u18 (copy), PlayerDataController (ref), TaskLibrary (ref), DailyTaskStreakMilestoneSlot (ref), u16 (copy), Utility (ref), RewardSlot (ref)
        if p20 then
            p20 = u18 == p21;
        end;

        u19.Visible = p20;

        if not u19.Visible then
            return;
        end;

        local v22 = PlayerDataController:Get("DailyTaskStreak");
        local v23 = math.floor(v22 / TaskLibrary.NUM_DAILY_TASK_STREAK_REWARD_MILESTONES) * TaskLibrary.NUM_DAILY_TASK_STREAK_REWARD_MILESTONES + 1;

        for i = v23, v23 + TaskLibrary.NUM_DAILY_TASK_STREAK_REWARD_MILESTONES - 1 do
            local v24 = TaskLibrary.DailyTaskStreakRewards[(i - 1) % TaskLibrary.NUM_DAILY_TASK_STREAK_REWARD_MILESTONES + 1];
            local v25;

            if v24.CanMultiplyRewards then
                local DAILY_TASK_STREAK_REWARD_MAX_MULTIPLIER = TaskLibrary.DAILY_TASK_STREAK_REWARD_MAX_MULTIPLIER;
                local math_ceil_ret = math.ceil(i / TaskLibrary.NUM_DAILY_TASK_STREAK_REWARD_MILESTONES);
                v25 = math.min(DAILY_TASK_STREAK_REWARD_MAX_MULTIPLIER, math_ceil_ret);
            else
                v25 = 1;
            end;

            local v26 = i <= v22;
            local v27 = i == v22 + 1;
            local _ = v22 + 1 < i;
            local v28 = (v27 and not p21 or v26) and 0 or 0.9;
            local v29 = DailyTaskStreakMilestoneSlot:Clone();
            v29.LayoutOrder = i;
            v29.Completed.Visible = v26;
            v29.Date.Visible = not v26;
            v29.Date.Value.Text = i;
            v29.Date.Value.TextTransparency = v28;
            v29.Date.Title.TextTransparency = v28;
            v29.Background.Circle.BackgroundTransparency = v26 and 0 or 1;
            v29.Background.Circle.UIStroke.Transparency = v28;
            v29.Background.Circle.UIStroke.Thickness = v26 and 2 or (v27 and 2 or 1);
            v29.Background.Dash.BackgroundTransparency = v28;
            v29.Background.Dash.Visible = i ~= v23;
            v29.Reward.Visible = not v26;
            v29.Parent = u19.Container.Milestones;
            table.insert(u16._daily_task_streak_cleanup, v29);
            local _ = i;

            for _, v in pairs(v24.Rewards or {}) do
                local v30 = Utility:CloneTable(v);
                v30.Quantity = (v30.Quantity or 1) * v25;
                local v31 = RewardSlot.new(v30);
                v31:SetParent(v29.Reward);
                table.insert(u16._daily_task_streak_cleanup, v31);
                table.insert(u16._daily_task_streak_reward_slots, v31);
            end;
        end;
    end;

    table.insert(u16._daily_task_streak_update_callbacks, update);
    update();

    return u19;
end;

function u2._UpdateDailyTaskStreak(p32, ...) -- Line: 264
    for _, v in pairs(p32._daily_task_streak_cleanup) do
        v:Destroy();
    end;

    p32._daily_task_streak_cleanup = {};
    p32._daily_task_streak_reward_slots = {};

    for _, v in pairs(p32._daily_task_streak_update_callbacks) do
        v(...);
    end;
end;

function u2._Generate(u33) -- Line: 277
    -- upvalues: PlayerDataController (copy), TaskLibrary (copy), EventLibrary (copy), CONSTANTS (copy), TimerController (copy)
    for _, v in pairs(u33._task_slots) do
        v:Destroy();
    end;

    for _, v in pairs(u33._contract_slots) do
        v:Destroy();
    end;

    for _, v in pairs(u33._contract_dividers) do
        v:Destroy();
    end;

    u33._task_slots = {};
    u33._contract_slots = {};
    u33._contract_dividers = {};
    local v34 = PlayerDataController:Get("BeginnerTasksCompleted");
    local v35 = TaskLibrary.NUM_BEGINNER_TASKS <= v34;
    local v36 = PlayerDataController:AreTasksCompleted();
    local v37 = EventLibrary.IS_ACTIVE and PlayerDataController:GetStatistic("StatisticDuelsPlayed") >= EventLibrary.NUM_GAMES_NEEDED_TO_PARTICIPATE;
    local v38 = #(PlayerDataController:Get("LimitedTasks") or {}) > 0;
    u33.TasksCompletedFrame.Visible = v36;
    u33.ContractsFrame.Visible = v35;

    if u33._to_shooting_range_button then
        u33._to_shooting_range_button.Visible = CONSTANTS.SHOOTING_RANGE_ACTIVE and v34 <= TaskLibrary.NUM_BEGINNER_TASKS - 2;
    end;

    if u33._to_duels_button then
        u33._to_duels_button.Visible = CONSTANTS.QUEUES_ACTIVE and TaskLibrary.NUM_BEGINNER_TASKS - 1 <= v34;
    end;

    local SpecialChallenges = u33._task_containers.SpecialChallenges;
    local v39;

    if PlayerDataController:Get("SpecialChallenges") == nil then
        v39 = false;
    else
        v39 = not PlayerDataController:AreTasksCompleted("SpecialChallenges");
    end;

    SpecialChallenges.Visible = v39;
    u33._task_containers.EventTasks.Visible = v36 and v37;
    u33._task_containers.LimitedTasks.Visible = v38;
    u33._task_containers.BonusTasks.Visible = v36;
    u33._task_containers.Tasks.Visible = not v36;
    u33._task_containers.Tasks.Container.Title.Text = v35 and "Daily Tasks" or "Beginner Tasks   [" .. v34 + 1 .. " / " .. TaskLibrary.NUM_BEGINNER_TASKS .. "]";
    TimerController:OnStep("TaskPageTaskRefresh", "TaskRefresh", v36 and function(p40, p41) -- Line: 318
        -- upvalues: u33 (copy)
        u33.TasksCompletedTimerText.Text = "new tasks in " .. p41;
    end or nil);
    u33:_GenerateTasks(v36, v35, v37, v38);

    if v35 then
        u33:_GenerateContracts();
    end;
end;

function u2._GenerateTasks(p42, p43, p44, p45, p46) -- Line: 329
    -- upvalues: TaskLibrary (copy), PlayerDataController (copy), TaskSlot (copy)
    local v47 = p43 and { "BonusTasks" } or { "Tasks" };

    if p43 and p45 then
        table.insert(v47, "EventTasks");
    end;

    if TaskLibrary.SPECIAL_CHALLENGES then
        table.insert(v47, "SpecialChallenges");
    end;

    table.insert(v47, "LimitedTasks");
    local CurrentlyActiveLimitedTasks = TaskLibrary:GetCurrentlyActiveLimitedTasks();

    for _, v in pairs(v47) do
        local v48 = p42._task_containers[v];
        local v49 = PlayerDataController:Get(v);

        if v49 then
            local v50 = v == "SpecialChallenges" and TaskLibrary.SPECIAL_CHALLENGES_MUST_BE_COMPLETED_IN_ORDER;

            if not v50 then
                if v == "LimitedTasks" then
                    if CurrentlyActiveLimitedTasks then
                        v50 = CurrentlyActiveLimitedTasks.RequiresPreviousTaskCompleted;
                    else
                        v50 = CurrentlyActiveLimitedTasks;
                    end;
                else
                    v50 = false;
                end;
            end;

            local v51 = false;

            for i, v2 in pairs(v49) do
                local v52;

                if v50 then
                    if i > 1 then
                        v52 = not v49[i - 1].Completed;
                    else
                        v52 = false;
                    end;
                else
                    v52 = v50;
                end;

                local v53 = TaskSlot.new(v2);
                v53:SetLocked(v52, v51);
                v53:SetParent(v48.Container.Contents.Slots.Container);
                table.insert(p42._task_slots, v53);
                v51 = v52;
            end;
        end;
    end;

    p42:_UpdateDailyTaskStreak(p44, p43);
end;

function u2._GenerateContracts(u54) -- Line: 372
    -- upvalues: ContractsLibrary (copy), StatisticsLibrary (copy), TaskContractMilestoneSlot (copy), ItemLibrary (copy), DuelLibrary (copy), RewardSlot (copy), PlayerDataController (copy), Utility (copy), TaskContractMilestoneDivider (copy)
    local u55 = u54.ContractsDropdownTitle.Text == "Near Completion" and "FilterProgress" or "FilterPlaytime";
    local u56 = 0;

    local function get_layout_order_from_group(p57) -- Line: 376
        return p57 * 99999;
    end;

    local function generate(p58, p59, p60, p61) -- Line: 380
        -- upvalues: ContractsLibrary (ref), StatisticsLibrary (ref), u56 (ref), TaskContractMilestoneSlot (ref), ItemLibrary (ref), DuelLibrary (ref), u54 (copy), RewardSlot (ref)
        local v62 = ContractsLibrary.Contracts[p60];
        local v63 = StatisticsLibrary.Info[v62.StatisticName];
        local v64 = string.find(p60, " Rounds Won") and 6 or (string.find(p60, " Playtime") and 4 or 2);
        local v65 = p58 or (p59 or "???");

        for i, v in pairs(v62.Milestones) do
            local table_unpack_ret, v66 = table.unpack(v);
            local v67 = table_unpack_ret <= p61;

            if not v67 or i >= #v62.Milestones then
                u56 = u56 + 1;
                local v68 = TaskContractMilestoneSlot:Clone();
                v68.Progress.Bar.Size = UDim2.new(math.clamp(p61 / table_unpack_ret, 0, 1), 0, 1, 2);
                v68.Progress.Bar.BackgroundColor3 = v67 and Color3.fromRGB(100, 255, 50) or Color3.fromRGB(0, 190, 255);
                v68.Completed.Visible = v67;
                v68.Goal.Text = v67 and "" or string.format("%s <font size=\"8\">/ %s</font>", v63.TostringFunction(p61), v63.TostringFunction(table_unpack_ret));
                v68.GoalPercent.Text = v67 and "" or string.format("%.1f", p61 / table_unpack_ret * 100) .. "%";
                v68.Title.Text = v65 .. "  •  " .. v63.FullDisplayName;
                v68.Weapon.Image = p58 and ItemLibrary.Items[p58].Image or "";
                v68.Map.Image = p59 and DuelLibrary.Maps[p59].Image or "";
                v68.LayoutOrder = v64 * 99999;
                v68.Parent = u54.ContractsMilestones;
                table.insert(u54._contract_slots, v68);

                if v66 and not v67 then
                    RewardSlot.new(v66):SetParent(v68.Reward);

                    return;
                end;

                break;
            end;
        end;
    end;

    local function get_current_milestone_info(p69, p70) -- Line: 420
        for _, v in pairs(p69.Milestones) do
            local table_unpack_ret, _ = table.unpack(v);

            if table_unpack_ret > p70 then
                return v;
            end;
        end;

        return p69.Milestones[#p69.Milestones];
    end;

    local function get_sorted_contracts(p71, p72, p73) -- Line: 433
        -- upvalues: ContractsLibrary (ref), PlayerDataController (ref), u55 (copy), Utility (ref)
        local v74 = {};

        for _, v in pairs(p71) do
            local v75;

            if p73 then
                v75 = ContractsLibrary:GetWeaponContracts(v);
            else
                v75 = ContractsLibrary:GetMapContracts(v);
            end;

            if v75 then
                v75 = v75[p72];
            end;

            if v75 then
                local v76 = ContractsLibrary.Contracts[v75];
                local v77;

                if p73 then
                    v77 = PlayerDataController:GetWeaponStatistic(v76.Identifier, v76.StatisticName, v76.ExtraStatisticNames);
                else
                    v77 = PlayerDataController:GetMapStatistic(v76.Identifier, v76.StatisticName, v76.ExtraStatisticNames);
                end;

                local v78 = v;
                local v79;

                for _, v2 in pairs(v76.Milestones) do
                    local table_unpack_ret, _ = table.unpack(v2);

                    if table_unpack_ret > v77 then
                        v79 = v2;
                        break;
                    end;
                end;

                v79 = v76.Milestones[#v76.Milestones];
                local v80 = v79[1];
                local v81 = {
                    Name = v78,
                    ContractName = v75,
                    Progress = v77,
                    Goal = v80
                };
                local v82;

                if p73 then
                    v82 = PlayerDataController:GetWeaponStatistic(v78, "StatisticPlaytime");
                else
                    v82 = PlayerDataController:GetMapStatistic(v78, "StatisticPlaytime");
                end;

                v81.FilterPlaytime = v82;
                v81.FilterProgress = -(v80 - v77);
                table.insert(v74, v81);
            end;
        end;

        table.sort(v74, function(p83, p84) -- Line: 460
            -- upvalues: u55 (ref), Utility (ref)
            local v85 = p84.Progress >= p84.Goal;

            if p83.Progress >= p83.Goal ~= v85 then
                return v85;
            end;

            if math.abs(p83[u55] - p84[u55]) > 0.001 then
                return p83[u55] > p84[u55];
            end;

            return Utility:StringLessThan(p83.Name, p84.Name);
        end);

        return v74;
    end;

    for _, v in pairs({ 3, 5 }) do
        local v86 = TaskContractMilestoneDivider:Clone();
        v86.LayoutOrder = v * 99999;
        v86.Parent = u54.ContractsMilestones;
        table.insert(u54._contract_dividers, v86);
    end;

    local function get_sorted_weapons(p87, p88) -- Line: 487
        -- upvalues: PlayerDataController (ref), ItemLibrary (ref), get_sorted_contracts (copy)
        local v89 = {};

        for _, v in pairs(PlayerDataController:Get("WeaponInventory")) do
            local Name = v.Name;

            if ItemLibrary.Classes[ItemLibrary.Items[Name].Class].Slot == p87 then
                table.insert(v89, Name);
            end;
        end;

        return get_sorted_contracts(v89, p88, true);
    end;

    for i = 1, 2 do
        local v90 = i;

        for i2 = 1, 4 do
            local v91 = get_sorted_weapons(i2, v90);
            local v92;

            for _, v in pairs(v91) do
                generate(v.Name, nil, v.ContractName, v.Progress);
                v92 = i2;
                break;
            end;

            v92 = i2;
        end;
    end;

    local v95 = (function(p93) -- Line: 516, Name: get_sorted_maps
        -- upvalues: DuelLibrary (ref), get_sorted_contracts (copy)
        local v94 = {};

        for _, v in pairs(DuelLibrary.MapOrder) do
            table.insert(v94, v);
        end;

        return get_sorted_contracts(v94, p93, false);
    end)(1);

    for i = 1, 4 do
        local v96 = v95[i];
        generate(nil, v96.Name, v96.ContractName, v96.Progress);
        local _ = i;
    end;

    u54:_SetPercentContractGoalEnabled(u54._percent_contract_goal_enabled);
end;

function u2._Setup(u97) -- Line: 539
    -- upvalues: u1 (copy), TaskLibrary (copy), TaskContainer (copy), ShootingRangeController (copy), LobbyController (copy), ButtonEffect (copy), ServerOsTime (copy), Utility (copy), RewardSlot (copy), MonetizationController (copy), MonetizationLibrary (copy)
    u97.ContractsDropdownTitle.Text = "Near Completion";

    for i, v in pairs(u1) do
        local table_unpack_ret, v98, v99, v100, v101 = table.unpack(v);

        if table_unpack_ret == "LimitedTasks" then
            local CurrentlyActiveLimitedTasks = TaskLibrary:GetCurrentlyActiveLimitedTasks();

            if CurrentlyActiveLimitedTasks then
                v98 = CurrentlyActiveLimitedTasks.DisplayName;
                v99 = CurrentlyActiveLimitedTasks.Image;
                v100 = CurrentlyActiveLimitedTasks.ImageSize;
                v101 = CurrentlyActiveLimitedTasks.Description;
            end;
        end;

        local u102 = TaskContainer:Clone();
        u102.Container.Buttons.Visible = table_unpack_ret == "Tasks";
        u102.Container.Title.Text = v98 or "";
        u102.Container.Title.ImageLabel.Image = v99 or "";
        u102.Container.Title.ImageLabel.Size = v100 or UDim2.new(1.5, 0, 1, 0);
        u102.Container.Description.Text = v101 or "";
        u102.LayoutOrder = -999 + i;
        u102.Parent = u97.Container;
        u97._task_containers[table_unpack_ret] = u102;
        u102.Container.Contents.Slots.Container.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 566, Name: update_slots
            -- upvalues: u102 (copy)
            u102.Container.Contents.Slots.Size = UDim2.new(1, 0, 0, u102.Container.Contents.Slots.Container.Layout.AbsoluteContentSize.Y);
        end);
        u102.Container.Contents.Slots.Size = UDim2.new(1, 0, 0, u102.Container.Contents.Slots.Container.Layout.AbsoluteContentSize.Y);

        local function update_frame() -- Line: 573
            -- upvalues: u102 (copy)
            pcall(function() -- Line: 574
                -- upvalues: u102 (ref)
                u102.Size = UDim2.new(1, 0, 0, u102.Container.AbsoluteSize.Y * 0.2 + u102.Container.Contents.Layout.AbsoluteContentSize.Y);
                local v103;

                if u102.Container.Contents.Layout.AbsoluteContentSize.Y > 1 then
                    v103 = #u102.Container.Contents.Slots.Container:GetChildren() > 1;
                else
                    v103 = false;
                end;

                u102.Visible = v103;
            end);
        end;

        u102.Container.Contents.Slots.Container.ChildAdded:Connect(update_frame);
        u102.Container.Contents.Slots.Container.ChildRemoved:Connect(update_frame);
        u102.Container.Contents.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(update_frame);
        u102.Container:GetPropertyChangedSignal("AbsoluteSize"):Connect(update_frame);
        pcall(function() -- Line: 574
            -- upvalues: u102 (copy)
            u102.Size = UDim2.new(1, 0, 0, u102.Container.AbsoluteSize.Y * 0.2 + u102.Container.Contents.Layout.AbsoluteContentSize.Y);
            local v104;

            if u102.Container.Contents.Layout.AbsoluteContentSize.Y > 1 then
                v104 = #u102.Container.Contents.Slots.Container:GetChildren() > 1;
            else
                v104 = false;
            end;

            u102.Visible = v104;
        end);

        if table_unpack_ret == "Tasks" then
            u97:_CreateDailyTaskStreakSlot(false).Parent = u102.Container.Contents;
            u97._to_shooting_range_button = u102.Container.Buttons.ToShootingRange;
            u97._to_duels_button = u102.Container.Buttons.ToDuels;
            u97._to_shooting_range_button.Button.MouseButton1Click:Connect(function() -- Line: 593
                -- upvalues: u97 (copy), ShootingRangeController (ref)
                u97:CloseRequest();
                ShootingRangeController:Enter(true);
            end);
            u97._to_duels_button.Button.MouseButton1Click:Connect(function() -- Line: 598
                -- upvalues: u97 (copy), LobbyController (ref)
                u97:CloseRequest();
                LobbyController:ToDuels();
            end);
            ButtonEffect:Add(u97._to_duels_button.Button, nil, {
                HoverRatio = UDim2.new(0, 10, 0, 10),
                ReleaseRatio = UDim2.new(0, 10, 0, 10)
            });
            ButtonEffect:Add(u97._to_shooting_range_button.Button, nil, {
                HoverRatio = UDim2.new(0, 10, 0, 10),
                ReleaseRatio = UDim2.new(0, 10, 0, 10)
            });
        elseif table_unpack_ret == "LimitedTasks" then
            table.insert(u97._while_open_callbacks, function() -- Line: 606
                -- upvalues: TaskLibrary (ref), ServerOsTime (ref), u102 (copy), Utility (ref)
                local CurrentlyActiveLimitedTasks = TaskLibrary:GetCurrentlyActiveLimitedTasks();

                if CurrentlyActiveLimitedTasks then
                    local v105 = CurrentlyActiveLimitedTasks.FinishTimestamp - ServerOsTime:Get();
                    CurrentlyActiveLimitedTasks = math.floor(v105);
                end;

                u102.Container.Description.Text = CurrentlyActiveLimitedTasks and (CurrentlyActiveLimitedTasks > 0 and Utility:TimeFormat2(CurrentlyActiveLimitedTasks)) or "• • •";
            end);
        end;
    end;

    u97:_CreateDailyTaskStreakSlot(true).Parent = u97.TasksCompletedContentsFrame;
    RewardSlot.new({
        Name = "Key",
        Quantity = TaskLibrary.Info.Core1.Rewards[1].Quantity + TaskLibrary.Info.Core2.Rewards[1].Quantity + TaskLibrary.Info.Core3.Rewards[1].Quantity
    }):SetParent(u97.TasksCompletedRefreshRewardsFrame);
    local v106 = RewardSlot.new({
        Weapon = "IsRandom",
        Name = TaskLibrary.DAILY_TASKS_RARE_REWARD
    });
    v106.CosmeticSlot.Frame.Button.Title.Size = UDim2.new(0.9, 0, 0.4, 0);
    v106.CosmeticSlot.Frame.Button.Title.Text = math.floor(TaskLibrary.DAILY_TASKS_RARE_REWARD_CHANCE * 1000) / 10 .. "%";
    v106:SetParent(u97.TasksCompletedRefreshRewardsFrame);
    local v107 = RewardSlot.new({
        Weapon = "IsRandom",
        Name = TaskLibrary.DAILY_TASKS_LEGENDARY_REWARD
    });
    v107.CosmeticSlot.Frame.Button.Title.Size = UDim2.new(0.9, 0, 0.4, 0);
    v107.CosmeticSlot.Frame.Button.Title.Text = math.floor(TaskLibrary.DAILY_TASKS_LEGENDARY_REWARD_CHANCE * 1000) / 10 .. "%";
    v107:SetParent(u97.TasksCompletedRefreshRewardsFrame);
    MonetizationController:SetRobuxText(u97.TasksCompletedRefreshButtonText, MonetizationLibrary.Products.RefreshTasks.ProductID);
end;

function u2._Init(u108) -- Line: 635
    -- upvalues: MonetizationController (copy), MonetizationLibrary (copy), ButtonEffect (copy)
    u108.CloseButton.MouseButton1Click:Connect(function() -- Line: 636
        -- upvalues: u108 (copy)
        u108:CloseRequest();
    end);
    u108.TasksCompletedRefreshButton.MouseButton1Click:Connect(function() -- Line: 640
        -- upvalues: MonetizationController (ref), MonetizationLibrary (ref)
        MonetizationController:PromptProductPurchase(MonetizationLibrary.Products.RefreshTasks.ProductID);
    end);
    u108.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 644
        -- upvalues: u108 (copy)
        u108.List.CanvasSize = UDim2.new(0, 0, 0, u108.Layout.AbsoluteContentSize.Y);
        u108.List.Active = u108.List.CanvasSize.Y.Offset > u108.List.AbsoluteSize.Y;
        u108.List.Position = u108.List.Active and UDim2.new(0.5, 0, 0, 0) or UDim2.new(0.5, 0, 0.2, 0);
        u108.CloseButton.Position = u108.List.Active and UDim2.new(1.075, 16, 0.0375, 0) or UDim2.new(1.075, 16, 0.2375, 0);
    end);
    u108.TasksCompletedContentsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 651
        -- upvalues: u108 (copy)
        u108.TasksCompletedFrame.Size = UDim2.new(1, 0, 0, u108.TasksCompletedContentsLayout.AbsoluteContentSize.Y);
    end);
    u108.ContractsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 655
        -- upvalues: u108 (copy)
        u108.ContractsFrame.Size = UDim2.new(1, 0, 0, u108.ContractsContainer.AbsoluteSize.Y * 0.15 + u108.ContractsLayout.AbsoluteContentSize.Y);
    end);
    u108.ContractsFilterButton.MouseButton1Click:Connect(function() -- Line: 659
        -- upvalues: u108 (copy)
        u108:_SetPercentContractGoalEnabled(not u108._percent_contract_goal_enabled);
    end);
    u108.ContractsDropdownButton.MouseButton1Click:Connect(function() -- Line: 663
        -- upvalues: u108 (copy)
        u108:_StartDropdown();
    end);
    u108:_Setup();
    ButtonEffect:Add(u108.CloseButton);
    ButtonEffect:Add(u108.ContractsFilterButton);
    ButtonEffect:Add(u108.TasksCompletedRefreshButton, nil, {
        HoverRatio = UDim2.new(0, 8, 0, 8),
        ReleaseRatio = UDim2.new(0, 8, 0, 8)
    });
    ButtonEffect:Add(u108.ContractsDropdownButton, nil, {
        ReleaseRatio = 1.025,
        HoverRatio = 1.025
    });
end;

return u2._new();