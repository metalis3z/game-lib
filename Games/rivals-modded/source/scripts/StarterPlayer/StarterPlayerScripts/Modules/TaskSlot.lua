-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local EventLibrary = require(ReplicatedStorage.Modules.EventLibrary);
local TaskLibrary = require(ReplicatedStorage.Modules.TaskLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules.RewardSlot);
local TaskSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("TaskSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 16
    -- upvalues: u1 (copy), TaskLibrary (copy), TaskSlot (copy)
    local v3 = setmetatable({}, u1);
    v3.TaskData = p2;
    v3.Info = TaskLibrary.Info[v3.TaskData.Name];
    v3.Frame = TaskSlot:Clone();
    v3._connections = {};
    v3._reward_slots = {};
    v3._notification_visible = false;
    v3:_Init();

    return v3;
end;

function u1.SetParent(p4, p5) -- Line: 36
    p4.Frame.Parent = p5;
end;

function u1.SetLocked(p6, p7, p8) -- Line: 40
    p6.Frame.Unlocked.Visible = not p7;
    p6.Frame.Locked.Visible = p7;
    p6.Frame.Locked.Icon.Position = UDim2.new(0.5, 0, 0.375, 0);
    p6.Frame.Locked.Title.Visible = false;
end;

function u1.ShowNotification(p9, p10) -- Line: 47
    if p10 then
        p10 = not p9.TaskData.Completed;
    end;

    p9.Frame.Unlocked.Title.Notification.Visible = p10;
end;

function u1.Destroy(p11) -- Line: 51
    for _, v in pairs(p11._connections) do
        v:Disconnect();
    end;

    p11:_ClearRewards();
    p11.Frame:Destroy();
end;

function u1._UpdateNotification(p12) -- Line: 64
    p12.Frame.Unlocked.Title.Notification.Position = UDim2.new(0.5, p12.Frame.Unlocked.Title.TextBounds.X / 2 + p12.Frame.Unlocked.Title.Notification.AbsoluteSize.X / 2, 0.5, 0);
end;

function u1._ClearRewards(p13) -- Line: 68
    for _, v in pairs(p13._reward_slots) do
        v:Destroy();
    end;

    p13._reward_slots = {};
end;

function u1._UpdateRewards(p14) -- Line: 76
    -- upvalues: Utility (copy), PlayerDataController (copy), EventLibrary (copy), RewardSlot (copy)
    p14:_ClearRewards();

    for _, v in pairs({ p14.Info.Rewards, p14.TaskData.BonusRewards or {} }) do
        for _, v2 in pairs(v) do
            local v15 = Utility:CloneTable(v2);

            if v15.Name == "EventCurrency" and (PlayerDataController:Get("EventCurrencyRushProgress") < EventLibrary.CURRENCY_RUSH_DAILY_LIMIT and p14.Info.CanBeMultipliedByEventBoost) then
                v15.Quantity = v15.Quantity * EventLibrary.CURRENCY_RUSH_MULTIPLIER;
            end;

            local v16 = RewardSlot.new(v15);
            v16:SetParent(p14.Frame.Reward);
            table.insert(p14._reward_slots, v16);
        end;
    end;
end;

function u1._UpdateName(p17) -- Line: 96
    -- upvalues: PlayerDataController (copy)
    local v18 = PlayerDataController:Get("TasksCompletedToday")[p17.TaskData.Name] or 0;
    p17.Frame.Unlocked.Title.Text = p17.Info.Title .. ((not p17.Info.MaxCompletionsPerDay or v18 >= p17.Info.MaxCompletionsPerDay) and "" or " [" .. v18 + 1 .. "/" .. p17.Info.MaxCompletionsPerDay .. "]");
end;

function u1._Setup(p19) -- Line: 103
    local v20 = p19.TaskData.Goal or p19.Info.Goal;
    local Completed = p19.TaskData.Completed;
    local v21 = #p19.Info.Title > 20 and 1.5 or 1;
    p19.Frame.Unlocked.Progress.Bar.Size = UDim2.new(math.clamp(p19.TaskData.Progress / v20, 0, 1), 0, 1, 2);
    p19.Frame.Unlocked.Progress.Bar.BackgroundColor3 = Completed and Color3.fromRGB(100, 255, 50) or Color3.fromRGB(0, 190, 255);
    p19.Frame.Unlocked.Progress.Title.Text = p19.TaskData.Progress .. " / " .. v20;
    p19.Frame.Unlocked.Progress.Title.Visible = not Completed;
    p19.Frame.Unlocked.Progress.Completed.Visible = Completed;
    p19.Frame.Unlocked.Title.Size = UDim2.new(0.8, 0, v21 * 0.1, 0);
    p19.Frame.Unlocked.Title.Notification.Size = UDim2.new(1 / v21, 0, 1 / v21, 0);
    p19.Frame.Unlocked.Title.TextColor3 = Completed and Color3.fromRGB(100, 255, 50) or Color3.fromRGB(255, 255, 255);
    p19.Frame.Unlocked.Icon.Image = p19.Info.Icon;
    p19.Frame.Unlocked.Icon.ImageColor3 = Completed and Color3.fromRGB(100, 255, 50) or Color3.fromRGB(255, 255, 255);
    p19.Frame.Background.BackgroundColor3 = Completed and Color3.fromRGB(100, 255, 50) or Color3.fromRGB(255, 255, 255);
    p19.Frame.Background.UIStroke.Color = Completed and Color3.fromRGB(100, 255, 50) or Color3.fromRGB(255, 255, 255);
end;

function u1._Init(u22) -- Line: 122
    -- upvalues: PlayerDataController (copy)
    u22.Frame.Unlocked.Title:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 123
        -- upvalues: u22 (copy)
        u22:_UpdateNotification();
    end);
    u22.Frame.Unlocked.Title:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 127
        -- upvalues: u22 (copy)
        u22:_UpdateNotification();
    end);
    u22.Frame.Unlocked.Title.Notification:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 131
        -- upvalues: u22 (copy)
        u22:_UpdateNotification();
    end);
    local _connections = u22._connections;
    local DataChangedSignal = PlayerDataController:GetDataChangedSignal("EventCurrencyRushProgress");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 135
        -- upvalues: u22 (copy)
        u22:_UpdateRewards();
    end));
    local _connections2 = u22._connections;
    local DataChangedSignal2 = PlayerDataController:GetDataChangedSignal("TasksCompletedToday");
    table.insert(_connections2, DataChangedSignal2:Connect(function() -- Line: 139
        -- upvalues: u22 (copy)
        u22:_UpdateName();
    end));
    u22:_Setup();
    u22:_UpdateName();
    u22:_UpdateRewards();
    u22:_UpdateNotification();
    u22:ShowNotification(false);
    u22:SetLocked(false);
end;

return u1;