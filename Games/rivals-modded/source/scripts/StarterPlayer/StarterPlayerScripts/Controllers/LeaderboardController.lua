-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Signal = require(ReplicatedStorage.Modules.Signal);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 12
    -- upvalues: u1 (copy), Signal (copy)
    local v2 = setmetatable({}, u1);
    v2.Refreshed = Signal.new();
    v2.LeaderboardSerials = {};
    v2._leaderboard_refreshed_signals = {};
    v2._leaderboard_refresh_requests = {};
    v2._local_fighter = nil;
    v2._next_request = 0;
    v2:_Init();

    return v2;
end;

function u1.GetLeaderboardRefreshedSignal(p3, p4) -- Line: 33
    -- upvalues: Signal (copy)
    if not p3._leaderboard_refreshed_signals[p4] then
        p3._leaderboard_refreshed_signals[p4] = Signal.new();
    end;

    return p3._leaderboard_refreshed_signals[p4];
end;

function u1.GetRankingByUserID(p5, p6, p7) -- Line: 41
    local v8 = p5.LeaderboardSerials[p6];

    if not v8 then
        return;
    end;

    local v9 = tostring(p7);

    for i, v in pairs(v8.Players) do
        if v9 == v.key then
            return i;
        end;
    end;
end;

function u1.GetRankingByValue(p10, p11, p12) -- Line: 57
    local v13 = p10.LeaderboardSerials[p11];

    if not v13 then
        return;
    end;

    for i, v in pairs(v13.Players) do
        if v.value <= p12 then
            return i;
        end;
    end;
end;

function u1._FetchLeaderboards(p14) -- Line: 75
    -- upvalues: ReplicatedStorage (copy)
    if #p14._leaderboard_refresh_requests == 0 then
        return;
    end;

    if p14._local_fighter and (p14._local_fighter:Get("IsInDuel") or p14._local_fighter:Get("IsInShootingRange")) then
        return;
    end;

    if tick() < p14._next_request then
        task.delay(p14._next_request - tick(), p14._FetchLeaderboards, p14);

        return;
    end;

    p14._next_request = tick() + 2;
    ReplicatedStorage.Remotes.Misc.RequestLeaderboards:FireServer(p14._leaderboard_refresh_requests);
    p14._leaderboard_refresh_requests = {};
end;

function u1._HookFighter(u15) -- Line: 94
    -- upvalues: FighterController (copy)
    u15._local_fighter = FighterController:WaitForLocalFighter();
    u15._local_fighter:GetDataChangedSignal("IsInDuel"):Connect(function() -- Line: 97
        -- upvalues: u15 (copy)
        u15:_FetchLeaderboards();
    end);
    u15._local_fighter:GetDataChangedSignal("IsInShootingRange"):Connect(function() -- Line: 101
        -- upvalues: u15 (copy)
        u15:_FetchLeaderboards();
    end);
    u15:_FetchLeaderboards();
end;

function u1._Setup(p16) -- Line: 108
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.Misc.RequestLeaderboards:FireServer();
end;

function u1._Init(u17) -- Line: 112
    -- upvalues: ReplicatedStorage (copy)
    u17.Refreshed:Connect(function(p18) -- Line: 113
        -- upvalues: u17 (copy)
        if u17._leaderboard_refreshed_signals[p18] then
            u17._leaderboard_refreshed_signals[p18]:Fire();
        end;
    end);
    ReplicatedStorage.Remotes.Misc.LeaderboardRefreshed.OnClientEvent:Connect(function(p19) -- Line: 119
        -- upvalues: u17 (copy)
        if not table.find(u17._leaderboard_refresh_requests, p19) then
            table.insert(u17._leaderboard_refresh_requests, p19);
        end;

        u17:_FetchLeaderboards();
    end);
    ReplicatedStorage.Remotes.Misc.UpdateLeaderboard.OnClientEvent:Connect(function(p20) -- Line: 127
        -- upvalues: u17 (copy)
        u17.LeaderboardSerials[p20.Name] = p20;
        u17.Refreshed:Fire(p20.Name);
    end);
    u17:_Setup();
    task.defer(u17._HookFighter, u17);
end;

return u1._new();