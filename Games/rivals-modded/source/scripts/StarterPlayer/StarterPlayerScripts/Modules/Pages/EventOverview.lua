-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local EventLibrary = require(ReplicatedStorage.Modules.EventLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local EventController = require(Players.LocalPlayer.PlayerScripts.Controllers.EventController);
local ShopController = require(Players.LocalPlayer.PlayerScripts.Controllers.ShopController);
local MatchmakingQueueSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("BaseMatchmakingQueueSlot"):WaitForChild("MatchmakingQueueSlot"));
local ShopSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("BaseShopSlot"):WaitForChild("ShopSlot"));
local AdventCalendarSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("AdventCalendarSlot"));
local PromptSystem = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"));
local TaskSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("TaskSlot"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 21
    -- upvalues: Page (copy), u1 (copy), PromptSystem (copy), AdventCalendarSlot (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.CloseButton = v3.PageFrame:WaitForChild("Close");
    v3.PromptsFrame = v3.PageFrame:WaitForChild("Prompts");
    v3.LockedFrame = v3.PageFrame:WaitForChild("Locked");
    v3.LockedDescriptionText = v3.LockedFrame:WaitForChild("Description");
    v3.List = v3.PageFrame:WaitForChild("List");
    v3.Container = v3.List:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.HeaderFrame = v3.Container:WaitForChild("Header");
    v3.HeaderPicture = v3.HeaderFrame:WaitForChild("Picture");
    v3.HeaderTitleText = v3.HeaderFrame:WaitForChild("Title");
    v3.HeaderCountdownText = v3.HeaderFrame:WaitForChild("Countdown");
    v3.EventTasksFrame = v3.Container:WaitForChild("EventTasks");
    v3.EventTasksLockedFrame = v3.EventTasksFrame:WaitForChild("Locked");
    v3.EventTasksLockedDescription = v3.EventTasksLockedFrame:WaitForChild("Description");
    v3.EventTasksUnlockedFrame = v3.EventTasksFrame:WaitForChild("Unlocked");
    v3.EventTasksContainer = v3.EventTasksUnlockedFrame:WaitForChild("Container");
    v3.EventTasksTitleText = v3.EventTasksContainer:WaitForChild("Title");
    v3.EventTasksSlotsFrame = v3.EventTasksContainer:WaitForChild("Slots");
    v3.EventTasksSlotsLayout = v3.EventTasksSlotsFrame:WaitForChild("Layout");
    v3.RushFrame = v3.EventTasksUnlockedFrame:WaitForChild("Rush");
    v3.RushTitleText = v3.RushFrame:WaitForChild("Title");
    v3.RushProgressFrame = v3.RushFrame:WaitForChild("Progress");
    v3.RushProgressBar = v3.RushProgressFrame:WaitForChild("Bar");
    v3.RushProgressCompleted = v3.RushProgressFrame:WaitForChild("Completed");
    v3.RushProgressText = v3.RushProgressFrame:WaitForChild("Title");
    v3.ShopEntriesFrame = v3.Container:WaitForChild("ShopEntries");
    v3.ShopEntriesContainer = v3.ShopEntriesFrame:WaitForChild("Container");
    v3.ShopEntriesTitleText = v3.ShopEntriesContainer:WaitForChild("Title");
    v3.ShopEntriesSlotsFrame = v3.ShopEntriesContainer:WaitForChild("Slots");
    v3.ShopEntriesSlotsLayout = v3.ShopEntriesSlotsFrame:WaitForChild("Layout");
    v3.AdventCalendarFrame = v3.Container:WaitForChild("AdventCalendar");
    v3.PromptSystem = PromptSystem.new(v3.PromptsFrame);
    v3.AdventCalendarSlot = AdventCalendarSlot.new(v3.AdventCalendarFrame);
    v3._open_connections = {};
    v3._task_slots = {};
    v3._shop_slots = {};
    v3:_Init();

    return v3;
end;

function u1.Open(u4, ...) -- Line: 72
    -- upvalues: Page (copy), PlayerDataController (copy)
    Page.Open(u4, ...);
    u4.AdventCalendarSlot:SetEnabled(true);
    local _open_connections = u4._open_connections;
    local DataChangedSignal = PlayerDataController:GetDataChangedSignal("Tasks");
    table.insert(_open_connections, DataChangedSignal:Connect(function() -- Line: 77
        -- upvalues: u4 (copy)
        u4:_GenerateTasks();
    end));
    local _open_connections2 = u4._open_connections;
    local DataChangedSignal2 = PlayerDataController:GetDataChangedSignal("EventTasks");
    table.insert(_open_connections2, DataChangedSignal2:Connect(function() -- Line: 81
        -- upvalues: u4 (copy)
        u4:_GenerateTasks();
    end));
    local _open_connections3 = u4._open_connections;
    local DataChangedSignal3 = PlayerDataController:GetDataChangedSignal("CosmeticInventory");
    table.insert(_open_connections3, DataChangedSignal3:Connect(function() -- Line: 85
        -- upvalues: u4 (copy)
        u4:_GenerateShopEntries();
    end));
    local _open_connections4 = u4._open_connections;
    local DataChangedSignal4 = PlayerDataController:GetDataChangedSignal("WeaponInventory");
    table.insert(_open_connections4, DataChangedSignal4:Connect(function() -- Line: 89
        -- upvalues: u4 (copy)
        u4:_GenerateShopEntries();
    end));
    local _open_connections5 = u4._open_connections;
    local DataChangedSignal5 = PlayerDataController:GetDataChangedSignal("EventCurrencyRushProgress");
    table.insert(_open_connections5, DataChangedSignal5:Connect(function() -- Line: 93
        -- upvalues: u4 (copy)
        u4:_UpdateRush();
    end));
    local _open_connections6 = u4._open_connections;
    local DataChangedSignal6 = PlayerDataController:GetDataChangedSignal("StatisticDuelsPlayed");
    table.insert(_open_connections6, DataChangedSignal6:Connect(function() -- Line: 97
        -- upvalues: u4 (copy)
        u4:_UpdateLocked();
    end));
    task.spawn(function() -- Line: 101
        -- upvalues: u4 (copy)
        while u4._is_open_hash == u4._is_open_hash do
            u4:_UpdateCountdown();
            wait(1);
        end;
    end);
    u4:_UpdateRush();
    u4:_UpdateCountdown();
    u4:_UpdateLocked();
    u4:_GenerateTasks();
    u4:_GenerateShopEntries();
end;

function u1.Close(p5, ...) -- Line: 117
    -- upvalues: Page (copy)
    p5.AdventCalendarSlot:SetEnabled(false);
    Page.Close(p5, ...);
end;

function u1._UpdateLocked(p6) -- Line: 126
    -- upvalues: EventLibrary (copy), PlayerDataController (copy)
    local v7 = EventLibrary.NUM_GAMES_NEEDED_TO_PARTICIPATE - PlayerDataController:GetStatistic("StatisticDuelsPlayed");
    p6.List.Visible = v7 <= 0;
    p6.LockedFrame.Visible = v7 > 0;
    p6.LockedDescriptionText.Text = "Play " .. v7 .. " more duels to gain access!";
end;

function u1._UpdateCountdown(p8) -- Line: 134
    -- upvalues: EventController (copy), Utility (copy)
    local TimeRemaining = EventController:GetTimeRemaining();
    p8.HeaderCountdownText.Text = TimeRemaining and TimeRemaining == 0 and "Ending any minute now!" or (TimeRemaining and (TimeRemaining > 0 and "Ending in " .. Utility:TimeFormat2(TimeRemaining)) or "Here for a limited time only!");
end;

function u1._UpdateRush(p9) -- Line: 142
    -- upvalues: PlayerDataController (copy), EventLibrary (copy)
    local v10 = PlayerDataController:Get("EventCurrencyRushProgress");
    local math_clamp_ret = math.clamp(v10 / EventLibrary.CURRENCY_RUSH_DAILY_LIMIT, 0, 1);
    p9.RushProgressText.Text = math_clamp_ret < 1 and v10 .. " / " .. EventLibrary.CURRENCY_RUSH_DAILY_LIMIT or "";
    p9.RushProgressCompleted.Visible = math_clamp_ret >= 1;
    p9.RushProgressBar.Size = UDim2.new(math_clamp_ret, 0, 1, 2);
    p9.RushProgressBar.BackgroundColor3 = math_clamp_ret < 1 and EventLibrary.EVENT_DETAILS.CURRENCY_COLOR or Color3.fromRGB(100, 255, 50);
end;

function u1._GenerateTasks(p11, p12) -- Line: 152
    -- upvalues: PlayerDataController (copy), TaskSlot (copy)
    for _, v in pairs(p11._task_slots) do
        v:Destroy();
    end;

    p11._task_slots = {};
    p11.EventTasksLockedFrame.Visible = not PlayerDataController:AreTasksCompleted();
    p11.EventTasksUnlockedFrame.Visible = not p11.EventTasksLockedFrame.Visible;
    local v13 = PlayerDataController:Get("EventTasks");

    for _, v in pairs(v13 or {}) do
        local v14 = TaskSlot.new(v);
        v14:SetParent(p11.EventTasksSlotsFrame);
        table.insert(p11._task_slots, v14);
    end;
end;

function u1._GenerateShopEntries(u15) -- Line: 171
    -- upvalues: EventLibrary (copy), ShopSlot (copy), ShopController (copy)
    for _, v in pairs(u15._shop_slots) do
        v:Destroy();
    end;

    u15._shop_slots = {};

    for _, v in pairs(EventLibrary.IS_ACTIVE and EventLibrary.SHOP_ENTRIES_OVERVIEW or {}) do
        local u16 = ShopSlot.new(ShopController:GetShopEntry(v));
        u16.Frame.Parent = u15.ShopEntriesSlotsFrame;
        table.insert(u15._shop_slots, u16);
        u16.RewardSlot:OnClick(function() -- Line: 183
            -- upvalues: u16 (copy), u15 (copy)
            if u16.IsLocked or u16.IsOwned then
                return;
            end;

            u15.PromptSystem:Open("InspectShopEntry", u16.ShopEntry.EntryName);
        end);
    end;
end;

function u1._Setup(u17) -- Line: 193
    -- upvalues: EventLibrary (copy), MatchmakingQueueSlot (copy), ShopController (copy)
    u17.HeaderPicture.Image = EventLibrary.EVENT_DETAILS.OVERVIEW_BANNER_IMAGE;
    u17.HeaderTitleText.Text = string.upper(EventLibrary.EVENT_NAME or "???") .. " EVENT";
    u17.EventTasksTitleText.Text = "Earn " .. EventLibrary.EVENT_DETAILS.CURRENCY_NAME_PLURAL .. "!";
    u17.ShopEntriesTitleText.Text = "Spend " .. EventLibrary.EVENT_DETAILS.CURRENCY_NAME_PLURAL .. "!";
    u17.RushTitleText.Text = string.upper(EventLibrary.EVENT_DETAILS.CURRENCY_NAME) .. " RUSH — Earn ×" .. EventLibrary.CURRENCY_RUSH_MULTIPLIER .. " " .. EventLibrary.EVENT_DETAILS.CURRENCY_NAME_PLURAL .. " every day!";
    u17.EventTasksLockedDescription.Text = "Complete your Daily Tasks to start earning " .. EventLibrary.EVENT_DETAILS.CURRENCY_NAME_PLURAL .. "!";

    for i, v in pairs(EventLibrary.LTM_QUEUENAMES or {}) do
        local Frame = Instance.new("Frame");
        Frame.Name = v;
        Frame.AnchorPoint = Vector2.new(0.5, 0.5);
        Frame.Size = UDim2.new(0.995, 0, 0.2, 0);
        Frame.BackgroundTransparency = 1;
        Frame.LayoutOrder = 10 + i;
        Frame.Parent = u17.Container;
        MatchmakingQueueSlot.new(v, Frame).QueueStatus:Connect(function(p18) -- Line: 212
            -- upvalues: u17 (copy)
            if p18 == "Success" then
                u17:CloseRequest();

                return;
            end;

            u17.PromptSystem:Open("ErrorMessage", "Whoops!", p18 or "Server failed to respond, please try again");
        end);
    end;

    ShopController:GetDailyShop();
end;

function u1._Init(u19) -- Line: 224
    -- upvalues: Pages (copy), ButtonEffect (copy)
    u19.CloseButton.MouseButton1Click:Connect(function() -- Line: 225
        -- upvalues: u19 (copy)
        u19:CloseRequest();
    end);
    u19.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 229
        -- upvalues: u19 (copy)
        u19.List.CanvasSize = UDim2.new(0, 0, 0, u19.Layout.AbsoluteContentSize.Y);
    end);
    u19.EventTasksSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 233
        -- upvalues: u19 (copy)
        u19.EventTasksFrame.Size = UDim2.new(1, 0, 0, u19.EventTasksContainer.AbsoluteSize.Y * 0.2 + u19.EventTasksSlotsLayout.AbsoluteContentSize.Y + u19.RushFrame.AbsoluteSize.Y);
    end);
    u19.ShopEntriesSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 237
        -- upvalues: u19 (copy)
        u19.ShopEntriesFrame.Size = UDim2.new(1, 0, 0, u19.ShopEntriesContainer.AbsoluteSize.Y * 0.3 + u19.ShopEntriesSlotsLayout.AbsoluteContentSize.Y);
    end);
    u19.PromptSystem.PromptAdded:Connect(function(p20) -- Line: 241
        -- upvalues: u19 (copy), Pages (ref)
        u19.List.CanvasPosition = Vector2.new(0, 0);

        if p20.InspectCurrencyPage then
            p20.InspectCurrencyPage:Connect(function() -- Line: 245
                -- upvalues: Pages (ref)
                Pages.PageSystem:OpenPage("Shop");
                Pages.PageSystem:WaitForPage("Shop"):SetPage("Currency");
            end);
        end;
    end);
    u19:_Setup();
    u19:_UpdateRush();
    u19:_UpdateCountdown();
    u19:_UpdateLocked();
    u19:_GenerateTasks();
    u19:_GenerateShopEntries();
    ButtonEffect:Add(u19.CloseButton);
end;

return u1._new();