-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Signal = require(ReplicatedStorage.Modules.Signal);
local MatchmakingController = require(Players.LocalPlayer.PlayerScripts.Controllers.MatchmakingController);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local DuelController = require(Players.LocalPlayer.PlayerScripts.Controllers.DuelController);
local MatchmakingCountdown = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.MatchmakingCountdown);
local ReplicatedController = require(Players.LocalPlayer.PlayerScripts.Modules.ReplicatedController);
local u1 = setmetatable({}, ReplicatedController);
u1.__index = u1;

function u1._new() -- Line: 18
    -- upvalues: ReplicatedController (copy), u1 (copy), Signal (copy)
    local QueuePad = ReplicatedController.new("QueuePad");
    local v2 = setmetatable(QueuePad, u1);
    v2.LocalPlayerActivity = Signal.new();
    v2.ChallengeRequestCooldownChanged = Signal.new();
    v2._local_fighter = nil;
    v2._update_loop_active = false;
    v2._challenge_cooldowns = {};
    v2._actively_on_queue_pad = false;
    v2:_Init();

    return v2;
end;

function u1.IsChallengeRequestOnCooldown(p3, p4) -- Line: 38
    return tick() < (p3._challenge_cooldowns[p4] or 0);
end;

function u1.GetQueuePad(p5, p6) -- Line: 42
    for _, v in pairs(p5.Objects) do
        local v7 = v:IsInQueue(p6);

        if v7 then
            return v, v7;
        end;
    end;
end;

function u1.CanChallenge(p8, p9) -- Line: 52
    -- upvalues: Players (copy), CONSTANTS (copy), DuelController (copy)
    local v10 = p9 and ((p9 ~= Players.LocalPlayer or CONSTANTS.IS_STUDIO) and CONSTANTS.QUEUES_ACTIVE) and not DuelController:GetDuel(p9);

    return v10;
end;

function u1.SendChallengeRequest(p11, p12) -- Line: 59
    -- upvalues: ReplicatedStorage (copy)
    if not p11:CanChallenge(p12) or p11:IsChallengeRequestOnCooldown(p12) then
        return;
    end;

    p11._challenge_cooldowns[p12] = tick() + 15;
    p11.ChallengeRequestCooldownChanged:Fire();
    task.delay(15, p11.ChallengeRequestCooldownChanged.Fire, p11.ChallengeRequestCooldownChanged);
    ReplicatedStorage.Remotes.Misc.SendChallengeRequest:FireServer(p12);
end;

function u1._QueueLeave(p13) -- Line: 75
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.Misc.QueueLeave:InvokeServer();
    p13._actively_on_queue_pad = false;
end;

function u1._QueueJoin(p14, p15, p16) -- Line: 80
    -- upvalues: ReplicatedStorage (copy)
    p14._actively_on_queue_pad = true;
    ReplicatedStorage.Remotes.Misc.QueueJoin:InvokeServer(p15:Get("ObjectID"), p16);
end;

function u1._CheckQueueStatus(p17) -- Line: 85
    -- upvalues: Players (copy), MatchmakingCountdown (copy), MatchmakingController (copy)
    local v18 = p17._local_fighter:IsAlive() and p17._local_fighter.Player;
    local QueuePad, v19 = p17:GetQueuePad(Players.LocalPlayer);
    local v20 = MatchmakingCountdown:IsVisible();

    if QueuePad then
        if not v18 or (p17._local_fighter:Get("IsInDuel") or (p17._local_fighter:Get("IsInShootingRange") or (not QueuePad:IsWithin(v18, v19) or v20))) then
            p17:_QueueLeave();
        end;
    elseif v18 then
        for _, v in pairs(p17.Objects) do
            local v21 = v:IsWithin(v18);

            if v21 then
                if v20 then
                    MatchmakingController:TryLeaveQueue();
                else
                    p17:_QueueJoin(v, v21);
                end;
            end;
        end;
    end;
end;

function u1._UpdateLoop(p22) -- Line: 111
    -- upvalues: CONSTANTS (copy)
    if p22._update_loop_active then
        return;
    end;

    p22._update_loop_active = true;

    while true do
        wait(0.1);

        if CONSTANTS.IS_STUDIO then
            p22:_CheckQueueStatus();
        else
            local success, result = pcall(p22._CheckQueueStatus, p22);

            if not success then
                warn("Failed to check queue status, error:", result);
            end;
        end;

        if not p22._actively_on_queue_pad and (p22._local_fighter:Get("IsInDuel") or p22._local_fighter:Get("IsInShootingRange")) then
            p22:_QueueLeave();
            p22._update_loop_active = false;

            return;
        end;
    end;
end;

function u1._HookLocalFighter(u23) -- Line: 142
    -- upvalues: FighterController (copy)
    u23._local_fighter = FighterController:WaitForLocalFighter();
    u23._local_fighter:GetDataChangedSignal("IsInDuel"):Connect(function() -- Line: 145
        -- upvalues: u23 (copy)
        u23:_UpdateLoop();
    end);
    u23._local_fighter:GetDataChangedSignal("IsInShootingRange"):Connect(function() -- Line: 149
        -- upvalues: u23 (copy)
        u23:_UpdateLoop();
    end);
    u23:_UpdateLoop();
end;

function u1._Init(u24) -- Line: 156
    u24.ObjectAdded:Connect(function(p25) -- Line: 157
        -- upvalues: u24 (copy)
        p25.LocalPlayerActivity:Connect(function() -- Line: 158
            -- upvalues: u24 (ref)
            u24.LocalPlayerActivity:Fire();
        end);
    end);
    task.defer(u24._HookLocalFighter, u24);
end;

return u1._new();