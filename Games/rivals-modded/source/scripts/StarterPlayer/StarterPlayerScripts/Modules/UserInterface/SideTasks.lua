-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GuiService = game:GetService("GuiService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local StatisticsLibrary = require(ReplicatedStorage.Modules.StatisticsLibrary);
local ContractsLibrary = require(ReplicatedStorage.Modules.ContractsLibrary);
local TaskLibrary = require(ReplicatedStorage.Modules.TaskLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Spring = require(ReplicatedStorage.Modules.Spring);
local ShootingRangeController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ShootingRangeController"));
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SpectateController"));
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"));
local LobbyController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("LobbyController"));
local TimerController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("TimerController"));
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"));
local MobileInputs = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MobileInputs"));
local Teleporting = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Teleporting"));
local Equipment = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"));
local Queue = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Queue"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local SideContractSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("SideContractSlot");
local SideTaskSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("SideTaskSlot");
local UDim2_new_ret = UDim2.new(-1, -10, 0.5, 0);
local UDim2_new_ret2 = UDim2.new(0, 10, 0.5, 0);
local UDim2_new_ret3 = UDim2.new(0.25, 90, 0.208, 75);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 40
    -- upvalues: u1 (copy), UILibrary (copy)
    local v2 = setmetatable({}, u1);
    v2.Frame = UILibrary:GetTo("MainFrame", "SideTasks");
    v2._local_fighter = nil;
    v2._side_slots = {};
    v2._duel_connections = {};
    v2._teleport_cooldown = 0;
    v2._generate_queued = false;
    v2._center_alert_hash = 0;
    v2._center_alert_connection = nil;
    v2._is_open = false;
    v2:_Init();

    return v2;
end;

function u1._PlayCenterAlertEffect(u3) -- Line: 69
    -- upvalues: Pages (copy), PlayerDataController (copy), TaskLibrary (copy), Spring (copy), RunService (copy), UDim2_new_ret2 (copy), UDim2_new_ret (copy), UDim2_new_ret3 (copy)
    local v4 = u3._local_fighter and (u3._local_fighter:Get("IsInShootingRange") and not Pages.PageSystem.CurrentPage) and PlayerDataController:Get("BeginnerTasksCompleted") < TaskLibrary.NUM_BEGINNER_TASKS;

    if not v4 then
        return;
    end;

    if u3._center_alert_connection then
        u3._center_alert_connection:Disconnect();
        u3._center_alert_connection = nil;
    end;

    u3._center_alert_hash = u3._center_alert_hash + 1;
    local _center_alert_hash = u3._center_alert_hash;
    local u5 = Spring.new(0, 1, 10);
    u3._center_alert_connection = RunService.RenderStepped:Connect(function() -- Line: 86
        -- upvalues: u3 (copy), _center_alert_hash (copy), u5 (copy), UDim2_new_ret2 (ref), UDim2_new_ret (ref)
        if u3._center_alert_hash ~= _center_alert_hash then
            return;
        end;

        local Value = u5.Value;
        local v6 = u3.Frame.Parent.AbsolutePosition + u3.Frame.Parent.AbsoluteSize / 2 - u3.Frame.Container.AbsoluteSize.X * Vector2.new(0.5, 0) - u3.Frame.AbsolutePosition;
        local UDim2_new_ret4 = UDim2.new(0, v6.X, 0, v6.Y);
        local UDim2_new_ret5 = UDim2.new(UDim2_new_ret2.X.Scale + (UDim2_new_ret4.X.Scale - UDim2_new_ret2.X.Scale) * Value, UDim2_new_ret2.X.Offset + (UDim2_new_ret4.X.Offset - UDim2_new_ret2.X.Offset) * Value, UDim2_new_ret2.Y.Scale + (UDim2_new_ret4.Y.Scale - UDim2_new_ret2.Y.Scale) * Value, UDim2_new_ret2.Y.Offset + (UDim2_new_ret4.Y.Offset - UDim2_new_ret2.Y.Offset) * Value);

        if not u3._is_open then
            UDim2_new_ret5 = UDim2_new_ret;
        end;

        u3.Frame.Container:TweenPosition(UDim2_new_ret5, "InOut", "Linear", 0, true);
        u3.Frame.Container.Background.UIGradient.Transparency = NumberSequence.new(0, 1 - Value);
    end);
    u5.Target = 1;
    u3.Frame.Container.Size = UDim2_new_ret3;
    u3.Frame.Container:TweenSize(UDim2.new(UDim2_new_ret3.X.Scale * 1.25, UDim2_new_ret3.X.Offset * 1.25, UDim2_new_ret3.Y.Scale * 1.25, UDim2_new_ret3.Y.Offset * 1.25), "InOut", "Quint", 0.75, true);

    for i = 1, 5 do
        wait(0.06);

        if u3._center_alert_hash ~= _center_alert_hash then
            return;
        end;

        u3.Frame.Container.Visible = true;
        wait(0.12);

        if u3._center_alert_hash ~= _center_alert_hash then
            return;
        end;

        local _ = i;
    end;

    wait(2);

    if u3._center_alert_hash ~= _center_alert_hash then
        return;
    end;

    u5.Target = 0;
    u3.Frame.Container:TweenSize(UDim2_new_ret3, "Out", "Quint", 0.5, true);
    wait(2);

    if u3._center_alert_hash ~= _center_alert_hash then
        return;
    end;

    u3._center_alert_connection:Disconnect();
    u3._center_alert_connection = nil;
    local v7;

    if u3._is_open then
        v7 = UDim2_new_ret2;
    else
        v7 = UDim2_new_ret;
    end;

    u3.Frame.Container.Position = v7;
    u3.Frame.Container.Background.UIGradient.Transparency = NumberSequence.new(0, 1);
end;

function u1._UpdateBackground(p8) -- Line: 149
    p8.Frame.Container.Background.Size = UDim2.new(1, 0, 0, p8.Frame.Container.Slots.BackgroundEnd.AbsolutePosition.Y - p8.Frame.Container.Slots.AbsolutePosition.Y);
end;

function u1._Generate(u9) -- Line: 153
    -- upvalues: WeaponStatusHandler (copy), PlayerDataController (copy), TaskLibrary (copy), Pages (copy), Equipment (copy), Queue (copy), Teleporting (copy), MobileInputs (copy), GuiService (copy), SpectateController (copy), ContractsLibrary (copy), CONSTANTS (copy), ItemLibrary (copy), SideTaskSlot (copy), UILibrary (copy), RewardSlot (copy), StatisticsLibrary (copy), SideContractSlot (copy), TimerController (copy), UDim2_new_ret2 (copy), UDim2_new_ret (copy)
    for _, v in pairs(u9._side_slots) do
        v:Destroy();
    end;

    u9._side_slots = {};
    WeaponStatusHandler:ClearStatusElements(u9.Frame.Container.Slots.Header.Title);
    u9._generate_cooldown = tick() + 0.2;
    local Statistic = PlayerDataController:GetStatistic("StatisticFavoriteWeapon");
    local v10 = u9._local_fighter and u9._local_fighter.EquippedItem and u9._local_fighter.EquippedItem.Name or ((Statistic == "N/A" or not Statistic) and "Assault Rifle" or Statistic);
    local v11 = PlayerDataController:Get("BeginnerTasksCompleted");
    local v12 = TaskLibrary.NUM_BEGINNER_TASKS <= v11;
    local v13 = u9._local_fighter and not (Pages.PageSystem.CurrentPage or Equipment.IsOpen) and not (Queue:IsVisible() or Teleporting.Enabled or (MobileInputs.EditorEnabled or GuiService.MenuIsOpen));

    if v13 then
        if PlayerDataController:GetSetting("Hide Tasks In Duels") and (SpectateController.CurrentDuelSubject and SpectateController.CurrentDuelSubject:Get("Status") ~= "RoundStarting") then
            v13 = false;
        elseif SpectateController.CurrentDuelSubject then
            v13 = SpectateController.CurrentDuelSubject.LocalDueler;

            if v13 then
                if SpectateController.CurrentDuelSubject:Get("Status") == "GameOver" then
                    v13 = false;
                else
                    v13 = not (SpectateController.CurrentDuelSubject.DuelInterface.Voting:IsOpen() or (SpectateController.CurrentDuelSubject.DuelInterface.Scoreboard:IsOpen() or SpectateController.CurrentDuelSubject:Get("HideMostDuelInterfaceElements")));

                    if v13 then
                        v13 = not PlayerDataController:GetSetting("Hide HUD");

                        if v13 then
                            if PlayerDataController:GetStatistic("StatisticDuelsPlayed") >= 2 then
                                v13 = true;
                            else
                                v13 = u9._local_fighter and u9._local_fighter:Get("IsInShootingRange");
                            end;
                        end;
                    end;
                end;
            end;
        else
            v13 = not PlayerDataController:GetSetting("Hide HUD");

            if v13 then
                if PlayerDataController:GetStatistic("StatisticDuelsPlayed") >= 2 or not v12 then
                    v13 = true;
                else
                    v13 = u9._local_fighter and u9._local_fighter:Get("IsInShootingRange");
                end;
            end;
        end;
    end;

    local v14;

    if v13 then
        v14 = PlayerDataController:Get("TasksInterfaceOverride") ~= nil;
    else
        v14 = v13;
    end;

    local v15 = not v14;

    if v15 then
        if v13 then
            v15 = not PlayerDataController:AreTasksCompleted();
        else
            v15 = v13;
        end;
    end;

    local v16 = not (v14 or v15);

    if v16 then
        if v13 then
            v13 = #ContractsLibrary:GetWeaponContracts(v10) > 0;
        end;
    else
        v13 = v16;
    end;

    u9._is_open = v14 or (v15 or v13);
    local SHOOTING_RANGE_ACTIVE = CONSTANTS.SHOOTING_RANGE_ACTIVE;

    if SHOOTING_RANGE_ACTIVE then
        if v15 then
            SHOOTING_RANGE_ACTIVE = v11 <= TaskLibrary.NUM_BEGINNER_TASKS - 2;
        else
            SHOOTING_RANGE_ACTIVE = v15;
        end;
    end;

    local v17 = CONSTANTS.QUEUES_ACTIVE and (not v14 and not SHOOTING_RANGE_ACTIVE);
    local ToShootingRange = u9.Frame.Container.Slots.ToShootingRange;
    local v18 = SHOOTING_RANGE_ACTIVE and (u9._local_fighter and not u9._local_fighter:Get("IsInShootingRange")) and not SpectateController.CurrentDuelSubject;
    ToShootingRange.Visible = v18;

    if v17 then
        v17 = not SpectateController.CurrentDuelSubject;
    end;

    u9.Frame.Container.Slots.ToDuels.Visible = v17;
    u9.Frame.Container.Slots.ButtonsBuffer.Visible = u9.Frame.Container.Slots.ToShootingRange.Visible or u9.Frame.Container.Slots.ToDuels.Visible;
    u9.Frame.Container.Slots.Header.Title.Text = v14 and "Special Mission" or (v13 and v10 and v10 or (v15 and (v12 and "Daily Tasks" or ("Beginner Tasks   [" .. v11 + 1 .. " / " .. TaskLibrary.NUM_BEGINNER_TASKS .. "]" or "")) or ""));
    u9.Frame.Container.Slots.Header.Title.Icon.Image = v13 and (ItemLibrary.ViewModels[v10].Image or "rbxassetid://17653923757") or "rbxassetid://17653923757";
    u9.Frame.Container.Slots.Header.Title.Icon.Size = v13 and UDim2.new(6, 0, 4.5, 0) or UDim2.new(2, 0, 1.5, 0);

    if not v14 and v13 then
        WeaponStatusHandler:ApplyItemStatusToText(u9.Frame.Container.Slots.Header.Title, ItemLibrary.Items[v10].Status);
    end;

    local function create_task_slot(p19, p20) -- Line: 197
        -- upvalues: TaskLibrary (ref), SideTaskSlot (ref), u9 (copy), UILibrary (ref), RewardSlot (ref)
        local v21 = p20.TaskInfo or TaskLibrary.Info[p20.Name];
        local v22 = p20.Goal or v21.Goal;
        local v23 = v22 <= p20.Progress;
        local v24 = SideTaskSlot:Clone();
        v24.LayoutOrder = p19;
        v24.Container.Progress.Bar.Size = UDim2.new(math.clamp(p20.Progress / v22, 0, 1), 0, 1, 2);
        v24.Container.Progress.Bar.BackgroundColor3 = v23 and Color3.fromRGB(100, 255, 50) or Color3.fromRGB(0, 190, 255);
        v24.Container.TitleContainer.Title.Text = v21.Title;
        v24.Container.Goal.Text = string.format("%s <font size=\"8\">/ %s</font>", p20.Progress, v22);
        v24.Container.Goal.Visible = not v23;
        v24.Container.Icon.Image = v21.Icon;
        v24.Completed.Visible = v23;
        v24.Parent = u9.Frame.Container.Slots;
        table.insert(u9._side_slots, v24);
        UILibrary:ScrollingTextLabel(v24.Container.TitleContainer, v24.Container.TitleContainer.Title, v24.Container.Goal);

        if not v23 then
            for _, v in pairs({ v21.Rewards, p20.BonusRewards or {} }) do
                for _, v2 in pairs(v) do
                    local v25 = RewardSlot.new(v2);
                    v25:SetBubbleAutoCloseDelay(3);
                    v25:SetParent(v24.Reward);
                end;
            end;
        end;
    end;

    if v14 then
        for i, v in pairs(PlayerDataController:Get("TasksInterfaceOverride")) do
            create_task_slot(i, v);
        end;
    end;

    if v15 then
        for i, v in pairs(PlayerDataController:Get("Tasks")) do
            create_task_slot(i, v);
        end;
    end;

    local v26;

    if v13 then
        v26 = true;

        for i, v in pairs(ContractsLibrary:GetWeaponContracts(v10)) do
            local v27 = ContractsLibrary.Contracts[v];
            local v28 = StatisticsLibrary.Info[v27.StatisticName];
            local WeaponStatistic = PlayerDataController:GetWeaponStatistic(v27.Identifier, v27.StatisticName, v27.ExtraStatisticNames);
            local v29 = i;

            for _, v2 in pairs(v27.Milestones) do
                local table_unpack_ret, v30 = table.unpack(v2);

                if table_unpack_ret > WeaponStatistic then
                    v26 = false;
                    local v31 = SideContractSlot:Clone();
                    v31.LayoutOrder = v29;
                    v31.Container.Progress.Bar.Size = UDim2.new(math.clamp(WeaponStatistic / table_unpack_ret, 0, 1), 0, 1, 2);
                    v31.Container.Goal.Text = string.format("%s <font size=\"8\">/ %s</font>", v28.TostringFunction(WeaponStatistic), v28.TostringFunction(table_unpack_ret));
                    v31.Container.TitleContainer.Title.Text = v27.FullDisplayName;
                    v31.Parent = u9.Frame.Container.Slots;
                    table.insert(u9._side_slots, v31);
                    UILibrary:ScrollingTextLabel(v31.Container.TitleContainer, v31.Container.TitleContainer.Title, v31.Container.Goal);

                    if v30 then
                        local v32 = RewardSlot.new(v30);
                        v32:SetBubbleAutoCloseDelay(3);
                        v32.Frame.Parent = v31.Reward;
                    end;

                    break;
                end;
            end;
        end;
    else
        v26 = false;
    end;

    u9.Frame.Container.Slots.ContractsCompleted.Visible = v26;
    u9.Frame.Container.Slots.ContractsCompleted.Title.Text = "Congratulations! You\'ve completed every " .. v10 .. " contract!";
    TimerController:OnStep("LobbyTasks", "TaskRefresh", v15 and (v12 and PlayerDataController:AreTasksCompleted()) and function(p33, p34) -- Line: 284
        -- upvalues: u9 (copy)
        u9.Frame.Container.Slots.Header.Title.Text = "New tasks in " .. p34;
    end or nil);
    local v35;

    if u9._is_open then
        v35 = UDim2_new_ret2;
    else
        v35 = UDim2_new_ret;
    end;

    u9.Frame.Container:TweenPosition(v35, "Out", "Quint", u9._is_open and 0.25 or 1.25, true);
    u9:_UpdateBackground();
end;

function u1._GenerateThrottled(u36) -- Line: 292
    if tick() > u36._generate_cooldown then
        u36:_Generate();

        return;
    end;

    if u36._generate_queued then
        return;
    end;

    u36._generate_queued = true;
    task.delay(u36._generate_cooldown - tick(), function() -- Line: 304
        -- upvalues: u36 (copy)
        u36._generate_queued = false;
        u36:_Generate();
    end);
end;

function u1._UpdateCurrentDuelSubject(u37) -- Line: 310
    -- upvalues: SpectateController (copy)
    for _, v in pairs(u37._duel_connections) do
        v:Disconnect();
    end;

    u37._duel_connections = {};

    if not SpectateController.CurrentDuelSubject then
        u37:_Generate();

        return;
    end;

    local _duel_connections = u37._duel_connections;
    local DataChangedSignal = SpectateController.CurrentDuelSubject:GetDataChangedSignal("Status");
    table.insert(_duel_connections, DataChangedSignal:Connect(function() -- Line: 322
        -- upvalues: u37 (copy)
        u37:_Generate();
    end));
    local _duel_connections2 = u37._duel_connections;
    local DataChangedSignal2 = SpectateController.CurrentDuelSubject:GetDataChangedSignal("HideMostDuelInterfaceElements");
    table.insert(_duel_connections2, DataChangedSignal2:Connect(function() -- Line: 326
        -- upvalues: u37 (copy)
        u37:_Generate();
    end));
    table.insert(u37._duel_connections, SpectateController.CurrentDuelSubject.DuelInterface.Voting.VisibilityChanged:Connect(function() -- Line: 330
        -- upvalues: u37 (copy)
        u37:_Generate();
    end));
    table.insert(u37._duel_connections, SpectateController.CurrentDuelSubject.DuelInterface.Scoreboard.VisibilityChanged:Connect(function() -- Line: 334
        -- upvalues: u37 (copy)
        u37:_Generate();
    end));
    u37:_Generate();
end;

function u1._HookLocalFighter(u38) -- Line: 341
    -- upvalues: FighterController (copy)
    u38._local_fighter = FighterController:WaitForLocalFighter();
    u38._local_fighter:GetDataChangedSignal("IsInShootingRange"):Connect(function() -- Line: 344
        -- upvalues: u38 (copy)
        u38:_Generate();
        u38:_PlayCenterAlertEffect();
    end);
    u38._local_fighter:GetDataChangedSignal("IsInDuel"):Connect(function() -- Line: 349
        -- upvalues: u38 (copy)
        u38:_Generate();
    end);
    u38._local_fighter.EquippedItemChanged:Connect(function() -- Line: 353
        -- upvalues: u38 (copy)
        u38:_GenerateThrottled();
    end);
    u38:_Generate();
    u38:_PlayCenterAlertEffect();
end;

function u1._Init(u39) -- Line: 361
    -- upvalues: ShootingRangeController (copy), LobbyController (copy), PlayerDataController (copy), Equipment (copy), Pages (copy), Queue (copy), Teleporting (copy), MobileInputs (copy), SpectateController (copy), GuiService (copy), ButtonEffect (copy)
    u39.Frame.Container.Slots.ToShootingRange.Button.MouseButton1Click:Connect(function() -- Line: 362
        -- upvalues: u39 (copy), ShootingRangeController (ref)
        if tick() < u39._teleport_cooldown then
            return;
        end;

        u39._teleport_cooldown = tick() + 1;
        ShootingRangeController:Enter(true);
    end);
    u39.Frame.Container.Slots.ToDuels.Button.MouseButton1Click:Connect(function() -- Line: 371
        -- upvalues: u39 (copy), LobbyController (ref)
        if tick() < u39._teleport_cooldown then
            return;
        end;

        u39._teleport_cooldown = tick() + 1;
        LobbyController:ToDuels();
    end);
    u39.Frame.Container.Slots:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 380
        -- upvalues: u39 (copy)
        u39:_UpdateBackground();
    end);
    u39.Frame.Container.Slots.BackgroundEnd:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 384
        -- upvalues: u39 (copy)
        u39:_UpdateBackground();
    end);
    PlayerDataController:GetDataChangedSignal("BeginnerTasksCompleted"):Connect(function() -- Line: 388
        -- upvalues: u39 (copy)
        u39:_Generate();
        u39:_PlayCenterAlertEffect();
    end);
    PlayerDataController:GetDataChangedSignal("Tasks"):Connect(function() -- Line: 393
        -- upvalues: u39 (copy)
        u39:_Generate();
    end);
    PlayerDataController:GetSettingChangedSignal("Hide Tasks In Duels"):Connect(function() -- Line: 397
        -- upvalues: u39 (copy)
        u39:_Generate();
    end);
    PlayerDataController:GetSettingChangedSignal("Hide HUD"):Connect(function() -- Line: 401
        -- upvalues: u39 (copy)
        u39:_Generate();
    end);
    PlayerDataController:GetDataChangedSignal("StatisticDuelsPlayed"):Connect(function() -- Line: 405
        -- upvalues: u39 (copy)
        u39:_Generate();
    end);
    PlayerDataController:GetDataChangedSignal("TasksInterfaceOverride"):Connect(function() -- Line: 409
        -- upvalues: u39 (copy)
        u39:_Generate();
    end);
    PlayerDataController.StatisticsUpdated:Connect(function() -- Line: 413
        -- upvalues: u39 (copy)
        u39:_Generate();
    end);
    Equipment.Opened:Connect(function() -- Line: 417
        -- upvalues: u39 (copy)
        u39:_Generate();
    end);
    Pages.PageSystem.PagesActivity:Connect(function() -- Line: 421
        -- upvalues: u39 (copy)
        u39:_Generate();
        u39:_PlayCenterAlertEffect();
    end);
    Queue.VisibilityChanged:Connect(function() -- Line: 426
        -- upvalues: u39 (copy)
        u39:_Generate();
    end);
    Teleporting.EnabledChanged:Connect(function() -- Line: 430
        -- upvalues: u39 (copy)
        u39:_Generate();
    end);
    MobileInputs.EditorEnabledChanged:Connect(function() -- Line: 434
        -- upvalues: u39 (copy)
        u39:_Generate();
    end);
    SpectateController.DuelSubjectChanged:Connect(function() -- Line: 438
        -- upvalues: u39 (copy)
        u39:_UpdateCurrentDuelSubject();
    end);
    GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(function() -- Line: 442
        -- upvalues: u39 (copy)
        u39:_Generate();
    end);
    u39:_Generate();
    u39:_UpdateCurrentDuelSubject();
    u39:_UpdateBackground();
    task.spawn(u39._HookLocalFighter, u39);
    ButtonEffect:Add(u39.Frame.Container.Slots.ToDuels.Button);
    ButtonEffect:Add(u39.Frame.Container.Slots.ToShootingRange.Button);
end;

return u1._new();