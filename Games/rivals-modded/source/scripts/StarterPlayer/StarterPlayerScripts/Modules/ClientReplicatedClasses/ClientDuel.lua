-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local ReplicatedClass = require(ReplicatedStorage.Modules.ReplicatedClass);
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local Signal = require(ReplicatedStorage.Modules.Signal);
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages);
local DuelInterface = require(script:WaitForChild("DuelInterface"));
local BeginnerDuel = require(script:WaitForChild("BeginnerDuel"));
local ChickenGame = require(script:WaitForChild("ChickenGame"));
local ClientMap = require(script:WaitForChild("ClientMap"));
local Maps = Players.LocalPlayer.PlayerScripts.Modules.Maps;
local u1 = setmetatable({}, ReplicatedClass);
u1.__index = u1;

function u1.new(p2) -- Line: 22
    -- upvalues: ReplicatedClass (copy), u1 (copy), Signal (copy), DuelInterface (copy), SeasonLibrary (copy), ChickenGame (copy), BeginnerDuel (copy)
    local v3 = ReplicatedClass.new(p2);
    local v4 = setmetatable(v3, u1);
    v4.DuelerAdded = Signal.new();
    v4.DuelerRemoved = Signal.new();
    v4.MapAdded = Signal.new();
    v4.SpectateThisPlayer = Signal.new();
    v4.Duelers = {};
    v4.Map = nil;
    v4.DuelInterface = DuelInterface.new(v4);
    v4.LocalDueler = nil;
    v4.IsRanked = SeasonLibrary:IsRankedQueue(v4:Get("QueueName"));
    v4.ChickenGame = ChickenGame.new(v4);
    v4.BeginnerDuel = BeginnerDuel.new(v4);
    v4.Data.IsSpectating = false;
    v4.Data.LastRoundStartingStatus = nil;
    v4.Data.DuelMusic = nil;
    v4._temp_serial = p2;
    v4._connections = {};
    v4._client_fighters = {};
    v4._duelers_by_player = {};
    v4:_Init();

    return v4;
end;

function u1.IsRendered(p5) -- Line: 56
    -- upvalues: CONSTANTS (copy), SpectateController (copy)
    return CONSTANTS.SHOULD_ALWAYS_REPLICATE() or p5.LocalDueler or p5 == SpectateController.CurrentDuelSubject;
end;

function u1.CanLeave(p6) -- Line: 60
    -- upvalues: Pages (copy)
    if Pages.PageSystem.CurrentPage then
        return false;
    end;

    return p6:Get("IsCurrentArcadeDuel") or p6:Get("RoundNum") > 1 and p6:Get("Status") == "RoundFinished" and not p6:Get("CanTrackStatistics") or p6:Get("WasSelfQueued");
end;

function u1.GetDueler(p7, p8) -- Line: 72
    if p7._duelers_by_player[p8] then
        return p7._duelers_by_player[p8];
    end;

    for i, v in pairs(p7.Duelers) do
        if v.Player == p8 or v:Get("ObjectID") == p8 then
            return v, i;
        end;
    end;
end;

function u1.GetFighters(p9) -- Line: 84
    return table.clone(p9._client_fighters);
end;

function u1.CountTeam(p10, p11) -- Line: 88
    local v12 = 0;

    for _, v in pairs(p10.Duelers) do
        v12 = v12 + (v:Get("TeamID") == p11 and 1 or 0);
    end;

    return v12;
end;

function u1.LeaveDuelRequest(p13) -- Line: 98
    -- upvalues: Pages (copy)
    if p13:CanLeave() then
        Pages.PageSystem:OpenPage("LeaveDuel", true);
    end;
end;

function u1.ReplicateFromServer(p14, p15, ...) -- Line: 104
    -- upvalues: ReplicatedClass (copy)
    if p15 == "DuelerAdded" then
        p14:_DuelerAdded(...);

        return;
    end;

    if p15 == "DuelerRemoved" then
        p14:_DuelerRemoved(...);

        return;
    end;

    if p15 == "DuelerChanged" then
        p14:_DuelerChanged(...);

        return;
    end;

    if p15 == "MapAdded" then
        p14:_MapAdded(...);

        return;
    end;

    if p15 == "MapChanged" then
        local v16 = ...;
        local v17 = p14:FromEnum(v16) or v16;

        if p14.Map then
            p14.Map:ReplicateFromServer(v17, select(2, ...));
        end;
    else
        if p15 == "RoundStarting" then
            if not p14:IsRendered() then
                return;
            end;

            local v18, v19 = ...;
            local v20 = p14:FromEnum(v19);
            p14:SetReplicate("LastRoundStartingStatus", v20);

            if v20 == "MatchPoint" then
                p14.DuelInterface.MatchPoint:Play(false);
            elseif v20 == "SuddenDeath" then
                p14.DuelInterface.MatchPoint:Play(true);
            end;

            p14.DuelInterface.Timer:Set(v18);

            return;
        end;

        if p15 == "RoundStart" then
            if not p14:IsRendered() then
                return;
            end;

            p14.DuelInterface.Timer:Set(...);

            return;
        end;

        if p15 == "RoundFinish" then
            if not p14:IsRendered() then
                return;
            end;

            local v21, v22 = ...;
            p14.DuelInterface.Timer:Pause(v22);
            p14.DuelInterface.RoundResult:Play(v21);

            return;
        end;

        if p15 == "FinalResults" then
            if not p14:IsRendered() then
                return;
            end;

            p14.DuelInterface.FinalResults:Play(...);

            return;
        end;

        if p15 == "Countdown" then
            if not p14:IsRendered() then
                return;
            end;

            p14.DuelInterface.Timer:Set(...);

            return;
        end;

        if p15 == "ChosenMapEffect" then
            if not p14:IsRendered() then
                return;
            end;

            p14.DuelInterface.Voting:PlayMapChosenEffect(...);

            return;
        end;

        if p15 == "PauseTimer" then
            if not p14:IsRendered() then
                return;
            end;

            p14.DuelInterface.Timer:Pause(...);

            return;
        end;

        if p15 == "RespawnNowAnimation" then
            if not p14:IsRendered() then
                return;
            end;

            local v23, v24 = ...;

            if not p14.LocalDueler or v23 ~= p14.LocalDueler.Player then
                return;
            end;

            p14.DuelInterface.Buttons:RespawnNowAnimation(v24);

            return;
        end;

        if p15 == "ChickenGamesRedLight" then
            if not p14:IsRendered() then
                return;
            end;

            p14.ChickenGame:RedLight(...);

            return;
        end;

        if p15 == "ChickenGamesGreenLight" then
            if not p14:IsRendered() then
                return;
            end;

            p14.ChickenGame:GreenLight(...);

            return;
        end;

        if p15 == "ChickenGamesElimination" then
            if not p14:IsRendered() then
                return;
            end;

            p14.ChickenGame:Elimination(...);

            return;
        end;

        if p15 == "ChickenGamesStop" then
            if not p14:IsRendered() then
                return;
            end;

            p14.ChickenGame:Stop(...);

            return;
        end;

        if p15 == "TimerStopwatchStarted" then
            if not p14:IsRendered() then
                return;
            end;

            p14.DuelInterface.Timer:StopwatchStart(...);

            return;
        end;

        if p15 == "TimerStopwatchFinished" then
            if not p14:IsRendered() then
                return;
            end;

            p14.DuelInterface.Timer:StopwatchFinish(...);

            return;
        end;

        if p15 == "SpectateThisPlayer" then
            if not p14:IsRendered() then
                return;
            end;

            local v25, v26 = ...;

            if not (v25 and v26) then
                return;
            end;

            p14.SpectateThisPlayer:Fire(v25, v26);

            return;
        end;

        ReplicatedClass.ReplicateFromServer(p14, p15, ...);
    end;
end;

function u1.Destroy(p27) -- Line: 241
    -- upvalues: ReplicatedClass (copy)
    for _, v in pairs(p27._connections) do
        v:Disconnect();
    end;

    for _, v in pairs(p27.Duelers) do
        v:Destroy();
    end;

    p27._client_fighters = {};
    p27._duelers_by_player = {};

    if p27.Map then
        p27.Map:Destroy();
    end;

    p27.DuelInterface:Destroy();
    p27.ChickenGame:Destroy();
    p27.BeginnerDuel:Destroy();
    p27.DuelerAdded:Destroy();
    p27.DuelerRemoved:Destroy();
    p27.MapAdded:Destroy();
    p27.SpectateThisPlayer:Destroy();
    ReplicatedClass.Destroy(p27);
end;

function u1._UpdateAllies(p28) -- Line: 273
    -- upvalues: Players (copy)
    local Dueler = p28:GetDueler(Players.LocalPlayer);
    local v29;

    if Dueler then
        v29 = Dueler:Get("TeamID");
    else
        v29 = Dueler;
    end;

    for _, v in pairs(p28.Duelers) do
        local v30;

        if v29 then
            if v == Dueler then
                v30 = false;
            else
                v30 = v29 == v:Get("TeamID");
            end;
        else
            v30 = v29;
        end;

        v:SetAlly(v30);
    end;
end;

function u1._DuelerChanged(p31, p32, p33, ...) -- Line: 282
    local Dueler = p31:GetDueler(p32);

    if not Dueler then
        return;
    end;

    Dueler:ReplicateFromServer(p31:FromEnum(p33) or p33, ...);
end;

function u1._DuelerAdded(p34, p35) -- Line: 294
    -- upvalues: FighterController (copy), ReplicatedClass (copy)
    if p34:GetDueler(p35[p34:ToEnum("Data")][p34:ToEnum("ObjectID")]) then
        return;
    end;

    local v36 = p35[p34:ToEnum("ClientReplicatedClassType")];
    local v37 = FighterController:WaitForFighter(p35[p34:ToEnum("Player")]);
    local v38 = ReplicatedClass:GetReplicatedClass(p34:FromEnum(v36) or v36).new(p35, v37, p34);
    table.insert(p34.Duelers, v38);
    table.insert(p34._client_fighters, v37);
    p34._duelers_by_player[v38.Player] = v38;
    local v39;

    if v37.IsLocalPlayer then
        v39 = v38;
    else
        v39 = p34.LocalDueler;
    end;

    p34.LocalDueler = v39;
    p34.DuelerAdded:Fire(v38);
end;

function u1._DuelerRemoved(p40, p41) -- Line: 311
    local Dueler, v42 = p40:GetDueler(p41);

    if not v42 then
        return;
    end;

    if Dueler == p40.LocalDueler then
        p40.LocalDueler = nil;
    end;

    local v43 = Dueler.ClientFighter and table.find(p40._client_fighters, Dueler.ClientFighter);

    if v43 then
        table.remove(p40._client_fighters, v43);
    end;

    table.remove(p40.Duelers, v42);
    p40._duelers_by_player[Dueler.Player] = nil;
    p40.DuelerRemoved:Fire(Dueler);
    Dueler:Destroy();
end;

function u1._MapAdded(p44, p45) -- Line: 336
    -- upvalues: Maps (copy), ClientMap (copy)
    local v46 = p45[p44:ToEnum("Name")];
    p44.Map = (Maps:FindFirstChild(v46) and require(Maps[v46]) or ClientMap).new(p45, p44);
    p44.MapAdded:Fire(p44.Map);
end;

function u1._Setup(p47) -- Line: 343
    for _, v in pairs(p47._temp_serial.Duelers) do
        task.spawn(p47._DuelerAdded, p47, v);
    end;

    if p47._temp_serial.Map then
        task.spawn(p47._MapAdded, p47, p47._temp_serial.Map);
    end;

    p47._temp_serial = nil;
end;

function u1._Init(u48) -- Line: 355
    u48.DuelerAdded:Connect(function() -- Line: 356
        -- upvalues: u48 (copy)
        u48:_UpdateAllies();
    end);
    u48:_Setup();
    u48:_UpdateAllies();
end;

return u1;