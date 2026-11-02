-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BaseQueuePad = require(ReplicatedStorage.Modules.ReplicatedClass.BaseQueuePad);
local Signal = require(ReplicatedStorage.Modules.Signal);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local QueuePadTerminal = require(script:WaitForChild("QueuePadTerminal"));
local QueuePadVisuals = require(script:WaitForChild("QueuePadVisuals"));
local u1 = { "Model", "CanSelfQueue", "NumTeams", "PlayersPerTeam", "InfinitePlayersPerTeam", "QueueName", "IsStarting", "IsLocked", "PlayersWaiting" };
local u2 = setmetatable({}, BaseQueuePad);
u2.__index = u2;

function u2.new(p3) -- Line: 16
    -- upvalues: BaseQueuePad (copy), u2 (copy), Signal (copy), QueuePadVisuals (copy), QueuePadTerminal (copy)
    local v4 = BaseQueuePad.new(p3);
    local v5 = setmetatable(v4, u2);
    v5.Activity = Signal.new();
    v5.LocalPlayerActivity = Signal.new();
    v5.Visuals = QueuePadVisuals.new(v5);
    v5.Terminal = QueuePadTerminal.new(v5);
    v5._was_local_player_here = nil;
    v5:_Init();

    return v5;
end;

function u2.GetClientFightersWaiting(p6) -- Line: 36
    -- upvalues: FighterController (copy)
    local v7 = {};

    for i, v in pairs(p6:Get("PlayersWaiting")) do
        local v8 = {};

        for i2, _ in pairs(v) do
            local Fighter = FighterController:GetFighter((tonumber(i2)));

            if Fighter then
                table.insert(v8, Fighter);
            end;
        end;

        v7[i] = v8;
    end;

    return v7;
end;

function u2.GetTeleportPosition(p9) -- Line: 56
    local v10 = {};

    for i = 1, p9:Get("NumTeams") do
        local v11 = { p9:Get("Model"):WaitForChild("Important"):WaitForChild("Team" .. i).Position, (p9:CountTeam(i)) };
        table.insert(v10, v11);
        local _ = i;
    end;

    table.sort(v10, function(p12, p13) -- Line: 66
        return p12[2] < p13[2];
    end);

    return v10[1][1];
end;

function u2.Destroy(p14) -- Line: 73
    -- upvalues: BaseQueuePad (copy)
    p14.Activity:Destroy();
    p14.LocalPlayerActivity:Destroy();
    p14.Visuals:Destroy();
    p14.Terminal:Destroy();
    BaseQueuePad.Destroy(p14);
end;

function u2._DetectLocalPlayerActivity(u15) -- Line: 85
    -- upvalues: Players (copy), u1 (copy)
    local function update(p16) -- Line: 86
        -- upvalues: u15 (copy), Players (ref)
        u15.Activity:Fire(p16);
        local v17 = u15:IsInQueue(Players.LocalPlayer) ~= nil;

        if v17 or u15._was_local_player_here then
            u15.LocalPlayerActivity:Fire(p16);
        end;

        u15._was_local_player_here = v17;
    end;

    for _, v in pairs(u1) do
        u15:GetDataChangedSignal(v):Connect(function() -- Line: 99
            -- upvalues: v (copy), u15 (copy), Players (ref)
            local v18 = v;
            u15.Activity:Fire(v18);
            local v19 = u15:IsInQueue(Players.LocalPlayer) ~= nil;

            if v19 or u15._was_local_player_here then
                u15.LocalPlayerActivity:Fire(v18);
            end;

            u15._was_local_player_here = v19;
        end);
    end;

    u15.Activity:Fire(nil);
    local v20 = u15:IsInQueue(Players.LocalPlayer) ~= nil;

    if v20 or u15._was_local_player_here then
        u15.LocalPlayerActivity:Fire(nil);
    end;

    u15._was_local_player_here = v20;
end;

function u2._Init(p21) -- Line: 107
    p21:_DetectLocalPlayerActivity();
end;

return u2;