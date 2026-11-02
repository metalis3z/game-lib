-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
require(ReplicatedStorage.Modules.Utility);
local u1 = {
    REFRESH_TIME = 60,
    Info = {},
    Order = {},
    DisplayInfo = {}
};

local function add_leaderboard(p2, p3, p4, p5, p6, p7, p8) -- Line: 18
    -- upvalues: CONSTANTS (copy), u1 (copy)
    if p7 and CONSTANTS.IS_CLIENT then
        return;
    end;

    local v9 = {
        Name = p2,
        DataStoreKey = p3,
        NumPlayers = p4,
        IsAscending = p5,
        UpdateCycle = p6,
        HiddenFromClient = p7,
        IsReadOnly = p8
    };
    u1.Info[v9.Name] = v9;
    table.insert(u1.Order, v9.Name);
end;

local v10 = {
    Name = "Highest ELO",
    NumPlayers = 250,
    IsAscending = false,
    UpdateCycle = nil,
    HiddenFromClient = nil,
    IsReadOnly = nil,
    DataStoreKey = "HighestELO3_" .. SeasonLibrary.CurrentSeason.Version
};
u1.Info[v10.Name] = v10;
table.insert(u1.Order, v10.Name);
local v11 = "HighestELO3_" .. SeasonLibrary.CurrentSeason.Version - 1;

if not CONSTANTS.IS_CLIENT then
    local v12 = {
        Name = "Highest ELO Last Season",
        NumPlayers = 250,
        IsAscending = false,
        UpdateCycle = nil,
        HiddenFromClient = true,
        IsReadOnly = true,
        DataStoreKey = v11
    };
    u1.Info[v12.Name] = v12;
    table.insert(u1.Order, v12.Name);
end;

if not CONSTANTS.IS_CLIENT then
    local v13 = {
        Name = "Top Players Before Season 0 Reset",
        DataStoreKey = "HighestELO_0",
        NumPlayers = 100,
        IsAscending = false,
        UpdateCycle = nil,
        HiddenFromClient = true,
        IsReadOnly = true
    };
    u1.Info[v13.Name] = v13;
    table.insert(u1.Order, v13.Name);
end;

local v14 = {
    Name = "Current Highest Win Streak",
    DataStoreKey = "WinStreakCurrent_1",
    NumPlayers = 100,
    IsAscending = false,
    UpdateCycle = 86400,
    HiddenFromClient = nil,
    IsReadOnly = nil
};
u1.Info[v14.Name] = v14;
table.insert(u1.Order, v14.Name);
local v15 = {
    Name = "Most Eliminations",
    DataStoreKey = "Eliminations_1",
    NumPlayers = 100,
    IsAscending = false,
    UpdateCycle = nil,
    HiddenFromClient = nil,
    IsReadOnly = nil
};
u1.Info[v15.Name] = v15;
table.insert(u1.Order, v15.Name);
local v16 = {
    Name = "Most Wins",
    DataStoreKey = "Wins_1",
    NumPlayers = 100,
    IsAscending = false,
    UpdateCycle = nil,
    HiddenFromClient = nil,
    IsReadOnly = nil
};
u1.Info[v16.Name] = v16;
table.insert(u1.Order, v16.Name);
local v17 = {
    Name = "Highest Level",
    DataStoreKey = "Level_1",
    NumPlayers = 100,
    IsAscending = false,
    UpdateCycle = nil,
    HiddenFromClient = nil,
    IsReadOnly = nil
};
u1.Info[v17.Name] = v17;
table.insert(u1.Order, v17.Name);

if not CONSTANTS.IS_CLIENT then
    local v18 = {
        Name = "Highest Win Streak Ever",
        DataStoreKey = "WinStreakHighest_1",
        NumPlayers = 100,
        IsAscending = false,
        UpdateCycle = nil,
        HiddenFromClient = true,
        IsReadOnly = nil
    };
    u1.Info[v18.Name] = v18;
    table.insert(u1.Order, v18.Name);
end;

if not CONSTANTS.IS_CLIENT then
    local v19 = {
        Name = "Current Highest True Streak",
        DataStoreKey = "TrueStreakCurrent_1",
        NumPlayers = 100,
        IsAscending = false,
        UpdateCycle = nil,
        HiddenFromClient = true,
        IsReadOnly = nil
    };
    u1.Info[v19.Name] = v19;
    table.insert(u1.Order, v19.Name);
end;

if not CONSTANTS.IS_CLIENT then
    local v20 = {
        Name = "Most Robux Spent",
        DataStoreKey = "RobuxSpent_1",
        NumPlayers = 100,
        IsAscending = false,
        UpdateCycle = nil,
        HiddenFromClient = true,
        IsReadOnly = nil
    };
    u1.Info[v20.Name] = v20;
    table.insert(u1.Order, v20.Name);
end;

local v21 = "RankedWins_" .. SeasonLibrary.CurrentSeason.Version;

if not CONSTANTS.IS_CLIENT then
    local v22 = {
        Name = "Most Ranked Wins",
        NumPlayers = 100,
        IsAscending = false,
        UpdateCycle = nil,
        HiddenFromClient = true,
        IsReadOnly = nil,
        DataStoreKey = v21
    };
    u1.Info[v22.Name] = v22;
    table.insert(u1.Order, v22.Name);
end;

local v23 = "RankedWinPercent_" .. SeasonLibrary.CurrentSeason.Version;

if not CONSTANTS.IS_CLIENT then
    local v24 = {
        Name = "Highest Ranked Win Percent",
        NumPlayers = 100,
        IsAscending = false,
        UpdateCycle = nil,
        HiddenFromClient = true,
        IsReadOnly = nil,
        DataStoreKey = v23
    };
    u1.Info[v24.Name] = v24;
    table.insert(u1.Order, v24.Name);
end;

if not CONSTANTS.IS_CLIENT then
    local v25 = {
        Name = "Largest Data Size",
        DataStoreKey = "DataSize_1",
        NumPlayers = 100,
        IsAscending = false,
        UpdateCycle = nil,
        HiddenFromClient = true,
        IsReadOnly = nil
    };
    u1.Info[v25.Name] = v25;
    table.insert(u1.Order, v25.Name);
end;

local function add_leaderboard_display(p26, p27, p28, p29, p30, p31, p32, p33, p34) -- Line: 56
    -- upvalues: u1 (copy)
    local v35 = {
        DarkColorSequence = nil,
        Name = p26,
        DisplayID = p27,
        DisplayName = p28,
        Icon = p29,
        IconFilled = p30,
        SanitizeUsernames = p31,
        LiveDisplayEnabled = p32,
        TextPosition = p33 or UDim2.new(0.5, 0, 0.5, 0),
        ColorSequence = p34 or ColorSequence.new(Color3.fromRGB(255, 255, 255))
    };
    u1.DisplayInfo[p26] = v35;
    local v36 = {};

    for _, v in pairs(v35.ColorSequence.Keypoints) do
        table.insert(v36, ColorSequenceKeypoint.new(v.Time, Color3.new(v.Value.R * 0.75, v.Value.G * 0.75, v.Value.B * 0.75)));
    end;

    v35.DarkColorSequence = ColorSequence.new(v36);
end;

add_leaderboard_display("Current Highest Win Streak", nil, "Win Streaks                   ", "rbxassetid://17175092502", "rbxassetid://17175117593", nil, true, UDim2.new(0.5, 0, 0.65, 0), ColorSequence.new(Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 157, 0)));
add_leaderboard_display("Most Eliminations", nil, "Most Eliminations", "rbxassetid://17736782213", "rbxassetid://17736752966", nil, nil, UDim2.new(0.5, 0, 0.5, 0), ColorSequence.new(Color3.fromRGB(106, 22, 22), Color3.fromRGB(255, 51, 51)));
add_leaderboard_display("Most Wins", nil, "Most Wins", "rbxassetid://17175095665", "rbxassetid://17175117401", nil, nil, UDim2.new(0.5, 0, 0.4, 0), ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)),
    ColorSequenceKeypoint.new(0.542, Color3.fromRGB(255, 209, 27)),
    ColorSequenceKeypoint.new(0.856, Color3.fromRGB(255, 229, 131)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
}));
add_leaderboard_display("Highest Level", nil, "Highest Level", "rbxassetid://81461991645938", "rbxassetid://72402714013244", nil, nil, UDim2.new(0.5, 0, 0.5, 0), ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 89, 255)), ColorSequenceKeypoint.new(0.342, Color3.fromRGB(2, 173, 253)), ColorSequenceKeypoint.new(1, Color3.fromRGB(151, 250, 255)) }));
add_leaderboard_display("Highest Win Streak Ever", nil, "Best Win Streaks", "rbxassetid://17175092502", "rbxassetid://17175117593", nil, nil, UDim2.new(0.5, 0, 0.65, 0), ColorSequence.new(Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 157, 0)));
add_leaderboard_display(
    "Highest ELO",
    "RankedLB",
    "Ranked                             ",
    "rbxassetid://117835427046796",
    "rbxassetid://89838302386905",
    true,
    true
);

return u1;