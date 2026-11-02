-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local AdventCalendarLibrary = require(ReplicatedStorage.Modules.AdventCalendarLibrary);
local TaskLibrary = require(ReplicatedStorage.Modules.TaskLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local TimerController = require(Players.LocalPlayer.PlayerScripts.Controllers.TimerController);
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules.RewardSlot);
local AdventCalendarSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("AdventCalendarSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 15
    -- upvalues: u1 (copy), AdventCalendarSlot (copy)
    local v3 = setmetatable({}, u1);
    v3.Container = p2;
    v3.Frame = AdventCalendarSlot:Clone();
    v3.TitleText = v3.Frame:WaitForChild("Title");
    v3.Icon = v3.TitleText:WaitForChild("ImageLabel");
    v3.TimerText = v3.Frame:WaitForChild("Timer");
    v3.RewardsFrame = v3.Frame:WaitForChild("Rewards");
    v3._connections = {};
    v3._reward_slots = {};
    v3:_Init();

    return v3;
end;

function u1.SetEnabled(u4, p5) -- Line: 37
    -- upvalues: PlayerDataController (copy), TimerController (copy)
    for _, v in pairs(u4._connections) do
        v:Disconnect();
    end;

    u4._connections = {};

    if not p5 then
        return;
    end;

    local _connections = u4._connections;
    local DataChangedSignal = PlayerDataController:GetDataChangedSignal("Tasks");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 48
        -- upvalues: u4 (copy)
        u4:_Update();
    end));
    local _connections2 = u4._connections;
    local DataChangedSignal2 = PlayerDataController:GetDataChangedSignal("BonusTasks");
    table.insert(_connections2, DataChangedSignal2:Connect(function() -- Line: 52
        -- upvalues: u4 (copy)
        u4:_Update();
    end));
    local _connections3 = u4._connections;
    local DataChangedSignal3 = PlayerDataController:GetDataChangedSignal("StatisticDuelsPlayed");
    table.insert(_connections3, DataChangedSignal3:Connect(function() -- Line: 56
        -- upvalues: u4 (copy)
        u4:_Update();
    end));
    local _connections4 = u4._connections;
    local DataChangedSignal4 = PlayerDataController:GetDataChangedSignal("SpecialChallenges");
    table.insert(_connections4, DataChangedSignal4:Connect(function() -- Line: 60
        -- upvalues: u4 (copy)
        u4:_Update();
    end));
    local _connections5 = u4._connections;
    local DataChangedSignal5 = PlayerDataController:GetDataChangedSignal("BeginnerTasksCompleted");
    table.insert(_connections5, DataChangedSignal5:Connect(function() -- Line: 64
        -- upvalues: u4 (copy)
        u4:_Update();
    end));
    table.insert(u4._connections, TimerController.TimerUpdated:Connect(function() -- Line: 68
        -- upvalues: u4 (copy)
        u4:_Update();
    end));
    u4:_Update();
end;

function u1._Update(u6) -- Line: 79
    -- upvalues: AdventCalendarLibrary (copy), PlayerDataController (copy), TaskLibrary (copy), TimerController (copy), RewardSlot (copy)
    for _, v in pairs(u6._reward_slots) do
        v:Destroy();
    end;

    u6._reward_slots = {};
    local Reward = AdventCalendarLibrary:GetReward();
    local v7 = PlayerDataController:Get("BeginnerTasksCompleted") >= TaskLibrary.NUM_BEGINNER_TASKS;

    if v7 then
        v7 = Reward ~= nil;
    end;

    u6.Container.Visible = v7;

    if not u6.Container.Visible then
        return;
    end;

    local Reward2 = AdventCalendarLibrary:GetReward(1);
    local v8 = PlayerDataController:Get("AdventCalendarLastDayClaimed") >= Reward.Day;
    u6.TitleText.Text = "Advent Calendar - Day " .. Reward.Day;
    u6.Icon.Image = v8 and "rbxassetid://17588806026" or "rbxassetid://71486631710031";
    u6.Icon.ImageColor3 = v8 and Color3.fromRGB(100, 255, 50) or Color3.fromRGB(255, 255, 255);
    u6.TimerText.Text = v8 and (Reward2 and "" or "Advent Calendar completed!") or "Complete your Daily Tasks to claim!";
    TimerController:OnStep("TaskPageAdventCalendar", "AdventCalendar", v8 and (Reward and Reward2) and function(p9, p10) -- Line: 104
        -- upvalues: u6 (copy)
        u6.TimerText.Text = "next reward in " .. p10;
    end or nil);

    for _, v in pairs(Reward.Rewards) do
        local v11 = RewardSlot.new(v);
        v11:SetParent(u6.RewardsFrame);
        table.insert(u6._reward_slots, v11);
    end;
end;

function u1._Setup(p12) -- Line: 115
    p12.Frame.Parent = p12.Container;
end;

function u1._Init(p13) -- Line: 119
    p13:_Setup();
end;

return u1;