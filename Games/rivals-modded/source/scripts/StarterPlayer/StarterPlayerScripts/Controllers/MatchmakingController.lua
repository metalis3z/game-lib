-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local ReplicatedClass = require(ReplicatedStorage.Modules.ReplicatedClass);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local u1 = { "ServerRegion", "MatchmadeStatus", "MatchmadeExpectedPlayers", "MatchmadeConnectedPlayers", "MatchmadeGameOver", "MatchmadeCountdown", "MatchmadeRematchAvailable", "MatchmadeRematchCount", "MatchmadeRematchGoal", "MatchmadeRematchSuccess" };
local u2 = setmetatable({}, ReplicatedClass);
u2.__index = u2;

function u2._new() -- Line: 18
    -- upvalues: ReplicatedClass (copy), u2 (copy), Signal (copy)
    local v3 = ReplicatedClass.new();
    local v4 = setmetatable(v3, u2);
    v4.MatchmadeDuelEnded = Signal.new();
    v4.RematchDetailsChanged = Signal.new();
    v4:_Init();

    return v4;
end;

function u2.IsMatchmadeDuelOver(p5) -- Line: 33
    -- upvalues: CONSTANTS (copy)
    local v6 = CONSTANTS.IS_MATCHMAKING_SERVER and p5:Get("MatchmadeGameOver");

    return v6;
end;

function u2.IsRematchAvailable(p7) -- Line: 37
    local v8 = p7:Get("MatchmadeRematchSuccess") or p7:Get("MatchmadeRematchCount") and p7:Get("MatchmadeRematchGoal") and p7:Get("MatchmadeRematchAvailable");

    return v8;
end;

function u2.QueueInto(p9, p10) -- Line: 41
    -- upvalues: ReplicatedStorage (copy)
    return ReplicatedStorage.Remotes.Matchmaking.JoinQueue:InvokeServer(p10);
end;

function u2.TryLeaveQueue(p11) -- Line: 45
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.Matchmaking.TryLeaveQueue:FireServer();
end;

function u2._OnboardingQueue(p12) -- Line: 53
    -- upvalues: CONSTANTS (copy), PlayerDataController (copy)
    if CONSTANTS.IS_STUDIO or (CONSTANTS.IS_PRIVATE_HUB_SERVER or PlayerDataController:GetStatistic("StatisticDuelsPlayed") > 0) then
        return;
    end;

    p12:QueueInto(CONSTANTS.BEGINNER_QUEUE_NAME);
end;

function u2._Setup(u13) -- Line: 61
    -- upvalues: u1 (copy)
    for _, v in pairs(u1) do
        local string_find_ret = string.find(v, "Rematch");

        local function update() -- Line: 65
            -- upvalues: u13 (copy), v (copy)
            u13:SetReplicate(v, workspace:GetAttribute(v));
        end;

        workspace:GetAttributeChangedSignal(v):Connect(function() -- Line: 69
            -- upvalues: u13 (copy), v (copy), string_find_ret (copy)
            u13:SetReplicate(v, workspace:GetAttribute(v));

            if string_find_ret then
                u13.RematchDetailsChanged:Fire();
            end;
        end);
        u13:SetReplicate(v, workspace:GetAttribute(v));
    end;
end;

function u2._Init(u14) -- Line: 81
    u14:GetDataChangedSignal("MatchmadeGameOver"):Connect(function() -- Line: 82
        -- upvalues: u14 (copy)
        u14.MatchmadeDuelEnded:Fire();
    end);
    u14:_Setup();
    task.defer(u14._OnboardingQueue, u14);
end;

return u2._new();