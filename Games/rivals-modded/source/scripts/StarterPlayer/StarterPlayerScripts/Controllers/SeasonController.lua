-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 14
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._last_update = -1;
    v2._time_remaining = nil;
    v2:_Init();

    return v2;
end;

function u1.GetTimeRemaining(p3) -- Line: 29
    if not p3._time_remaining then
        return nil;
    end;

    local v4 = p3._time_remaining - (tick() - p3._last_update);
    local math_ceil_ret = math.ceil(v4);

    return math.max(0, math_ceil_ret);
end;

function u1.GetCountdownText(p5) -- Line: 33
    -- upvalues: Utility (copy), SeasonLibrary (copy)
    local TimeRemaining = p5:GetTimeRemaining();

    if not TimeRemaining then
        return nil;
    end;

    local v6 = TimeRemaining <= 0 and "ANY SECOND NOW" or Utility:TimeFormat2((math.ceil(TimeRemaining)));

    return string.format("Season %s ends %s<font color=\"rgb(255,50,50)\" weight=\"700\">%s</font>", SeasonLibrary.CurrentSeason.Version, TimeRemaining <= 0 and "" or "in ", v6);
end;

function u1.IsRankedUnlocked(p7) -- Line: 46
    -- upvalues: PlayerDataController (copy), Players (copy), CONSTANTS (copy), SeasonLibrary (copy)
    local Statistic = PlayerDataController:GetStatistic("StatisticDuelsWon");
    local v8 = PlayerDataController:Get("Level");
    local AccountAge = Players.LocalPlayer.AccountAge;
    local Statistic2 = PlayerDataController:GetStatistic("StatisticTasksCompleted");
    local v9;

    if CONSTANTS.BEGINNER_QUEUE_WINS <= Statistic and (SeasonLibrary.CurrentSeason.LevelRequirement <= v8 and SeasonLibrary.CurrentSeason.AccountAgeRequirement <= AccountAge) then
        v9 = SeasonLibrary.CurrentSeason.TasksCompletedRequirement <= Statistic2;
    else
        v9 = false;
    end;

    return v9;
end;

function u1._UpdateTimer(p10, p11) -- Line: 62
    p10._last_update = tick();
    p10._time_remaining = p11;
end;

function u1._Fetch(p12) -- Line: 67
    -- upvalues: ReplicatedStorage (copy)
    p12:_UpdateTimer(ReplicatedStorage.Remotes.Misc.RequestSeasonTimer:InvokeServer());
end;

function u1._Init(u13) -- Line: 71
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.Misc.UpdateSeasonTimer.OnClientEvent:Connect(function(p14) -- Line: 72
        -- upvalues: u13 (copy)
        u13:_UpdateTimer(p14);
    end);
    task.defer(u13._Fetch, u13);
end;

return u1._new();