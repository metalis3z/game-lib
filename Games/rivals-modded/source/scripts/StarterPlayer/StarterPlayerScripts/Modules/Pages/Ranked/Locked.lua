-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local PlayerDataUtility = require(ReplicatedStorage.Modules.PlayerDataUtility);
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local SeasonController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SeasonController"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 15
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Page = p2;
    v3.UnlockedFrame = v3.Page.PageFrame:WaitForChild("Unlocked");
    v3.LockedFrame = v3.Page.PageFrame:WaitForChild("Locked");
    v3.LockedCloseButton = v3.LockedFrame:WaitForChild("Close");
    v3.LockedLevelFrame = v3.LockedFrame:WaitForChild("Level");
    v3.LockedLevelBar = v3.LockedLevelFrame:WaitForChild("Progress"):WaitForChild("Bar");
    v3.LockedLevelGoalText = v3.LockedLevelFrame:WaitForChild("Goal");
    v3.LockedLevelCompleted = v3.LockedLevelFrame:WaitForChild("Completed");
    v3.LockedLevelText = v3.LockedLevelFrame:WaitForChild("Title");
    v3.LockedWinsFrame = v3.LockedFrame:WaitForChild("Wins");
    v3.LockedWinsBar = v3.LockedWinsFrame:WaitForChild("Progress"):WaitForChild("Bar");
    v3.LockedWinsGoalText = v3.LockedWinsFrame:WaitForChild("Goal");
    v3.LockedWinsCompleted = v3.LockedWinsFrame:WaitForChild("Completed");
    v3.LockedWinsText = v3.LockedWinsFrame:WaitForChild("Title");
    v3.LockedAgeFrame = v3.LockedFrame:WaitForChild("Age");
    v3.LockedAgeBar = v3.LockedAgeFrame:WaitForChild("Progress"):WaitForChild("Bar");
    v3.LockedAgeGoalText = v3.LockedAgeFrame:WaitForChild("Goal");
    v3.LockedAgeCompleted = v3.LockedAgeFrame:WaitForChild("Completed");
    v3.LockedAgeText = v3.LockedAgeFrame:WaitForChild("Title");
    v3.LockedTasksFrame = v3.LockedFrame:WaitForChild("Tasks");
    v3.LockedTasksBar = v3.LockedTasksFrame:WaitForChild("Progress"):WaitForChild("Bar");
    v3.LockedTasksGoalText = v3.LockedTasksFrame:WaitForChild("Goal");
    v3.LockedTasksCompleted = v3.LockedTasksFrame:WaitForChild("Completed");
    v3.LockedTasksText = v3.LockedTasksFrame:WaitForChild("Title");
    v3.LockedTrustedFrame = v3.LockedFrame:WaitForChild("Trusted");
    v3.LockedTrustedBar = v3.LockedTrustedFrame:WaitForChild("Progress"):WaitForChild("Bar");
    v3.LockedTrustedGoalText = v3.LockedTrustedFrame:WaitForChild("Goal");
    v3.LockedTrustedCompleted = v3.LockedTrustedFrame:WaitForChild("Completed");
    v3.LockedTrustedText = v3.LockedTrustedFrame:WaitForChild("Title");
    v3._thread = nil;
    v3:_Init();

    return v3;
end;

function u1.Open(p4) -- Line: 59
    p4:_Update();
end;

function u1.Close(p5) -- Line: 63
end;

function u1._Update(p6) -- Line: 71
    -- upvalues: CONSTANTS (copy), PlayerDataController (copy), SeasonLibrary (copy), Players (copy), PlayerDataUtility (copy), Utility (copy), SeasonController (copy)
    local BEGINNER_QUEUE_WINS = CONSTANTS.BEGINNER_QUEUE_WINS;
    local Statistic = PlayerDataController:GetStatistic("StatisticDuelsWon");
    local LevelRequirement = SeasonLibrary.CurrentSeason.LevelRequirement;
    local v7 = PlayerDataController:Get("Level");
    local AccountAgeRequirement = SeasonLibrary.CurrentSeason.AccountAgeRequirement;
    local AccountAge = Players.LocalPlayer.AccountAge;
    local TasksCompletedRequirement = SeasonLibrary.CurrentSeason.TasksCompletedRequirement;
    local Statistic2 = PlayerDataController:GetStatistic("StatisticTasksCompleted");
    local BypassTrustworthySpendRequirement = SeasonLibrary.CurrentSeason.BypassTrustworthySpendRequirement;
    local v8;

    if Players.LocalPlayer:GetAttribute("IsTrustworthy") then
        v8 = BypassTrustworthySpendRequirement;
    else
        v8 = PlayerDataUtility:GetRobuxSpent(PlayerDataController:Get("Receipts"), PlayerDataController:Get("Gamepasses"), PlayerDataController:Get("CompressedReceipts"));
    end;

    for _, v in pairs({
        {
            p6.LockedWinsBar,
            p6.LockedWinsGoalText,
            p6.LockedWinsCompleted,
            Statistic,
            BEGINNER_QUEUE_WINS
        },
        {
            p6.LockedLevelBar,
            p6.LockedLevelGoalText,
            p6.LockedLevelCompleted,
            v7,
            LevelRequirement
        },
        {
            p6.LockedAgeBar,
            p6.LockedAgeGoalText,
            p6.LockedAgeCompleted,
            AccountAge,
            AccountAgeRequirement
        },
        {
            p6.LockedTasksBar,
            p6.LockedTasksGoalText,
            p6.LockedTasksCompleted,
            Statistic2,
            TasksCompletedRequirement
        },
        {
            p6.LockedTrustedBar,
            p6.LockedTrustedGoalText,
            p6.LockedTrustedCompleted,
            v8,
            BypassTrustworthySpendRequirement
        }
    }) do
        local table_unpack_ret, v9, v10, v11, v12 = table.unpack(v);
        local math_clamp_ret = math.clamp(v11 / v12, 0, 1);
        table_unpack_ret.Size = UDim2.new(math_clamp_ret, 0, 1, 2);
        table_unpack_ret.BackgroundColor3 = math_clamp_ret >= 1 and Color3.fromRGB(100, 255, 50) or Color3.fromRGB(255, 255, 255);
        v9.Text = Utility:PrettyNumber(v11) .. " / " .. Utility:PrettyNumber(v12);
        v9.Visible = math_clamp_ret < 1;
        v10.Visible = math_clamp_ret >= 1;
    end;

    p6.UnlockedFrame.Visible = SeasonController:IsRankedUnlocked();
    p6.LockedFrame.Visible = not p6.UnlockedFrame.Visible;
end;

function u1._Setup(p13) -- Line: 106
    -- upvalues: CONSTANTS (copy), SeasonLibrary (copy), Utility (copy)
    p13.LockedWinsText.Text = "Win " .. CONSTANTS.BEGINNER_QUEUE_WINS .. " duels";
    p13.LockedLevelText.Text = "Reach Level " .. SeasonLibrary.CurrentSeason.LevelRequirement;
    p13.LockedAgeText.Text = "Have a " .. SeasonLibrary.CurrentSeason.AccountAgeRequirement .. " day old Roblox account";
    p13.LockedTasksText.Text = "Complete " .. SeasonLibrary.CurrentSeason.TasksCompletedRequirement .. " tasks";
    p13.LockedTrustedText.Text = "Spend " .. utf8.char(57346) .. Utility:PrettyNumber(SeasonLibrary.CurrentSeason.BypassTrustworthySpendRequirement) .. " or verify your Roblox account\'s email, phone, ID, etc";
end;

function u1._Init(u14) -- Line: 114
    -- upvalues: ButtonEffect (copy)
    u14.LockedCloseButton.MouseButton1Click:Connect(function() -- Line: 115
        -- upvalues: u14 (copy)
        u14.Page:CloseRequest();
    end);
    u14:_Setup();
    u14:_Update();
    ButtonEffect:Add(u14.LockedCloseButton);
end;

return u1;