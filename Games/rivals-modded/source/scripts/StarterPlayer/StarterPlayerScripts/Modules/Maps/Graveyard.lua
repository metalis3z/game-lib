-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ServerOsTime = require(ReplicatedStorage.Modules.ServerOsTime);
local ClientMap = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientDuel.ClientMap);
local FilmGrain = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("FilmGrain");
local u1 = setmetatable({}, ClientMap);
u1.__index = u1;

function u1.new(...) -- Line: 14
    -- upvalues: ClientMap (copy), u1 (copy), FilmGrain (copy)
    local v2 = ClientMap.new(...);
    local v3 = setmetatable(v2, u1);
    v3._film_grain = FilmGrain:Clone();
    v3._film_grain_loop_active = false;
    v3._last_hour = v3:_GetBellRingHour();
    v3._arcade_status = nil;
    v3:_Init();

    return v3;
end;

function u1.Destroy(p4) -- Line: 31
    -- upvalues: ClientMap (copy)
    p4._film_grain:Destroy();
    ClientMap.Destroy(p4);
end;

function u1._GetBellRingHour(p5) -- Line: 40
    -- upvalues: ServerOsTime (copy)
    local v6 = ServerOsTime:Get() / 60 / 60;

    return math.floor(v6);
end;

function u1._UpdateFilmGrainLoop(p7) -- Line: 44
    if p7._film_grain_loop_active or p7:Get("IsHidden") then
        return;
    end;

    p7._film_grain_loop_active = true;

    while not (p7._destroyed or p7:Get("IsHidden")) do
        p7._film_grain.Position = UDim2.new(math.random(), 0, math.random(), 0);
        local v8 = p7:_GetBellRingHour();

        if p7._last_hour ~= v8 then
            p7._last_hour = v8;
            p7:CreateSound("rbxassetid://125988297033633", 1, 1, script, true, 15);
        end;

        wait(0.06666666666666667);
    end;

    p7._film_grain_loop_active = false;
end;

function u1._UpdateLightingProfile(p9) -- Line: 67
    local v10;

    if p9.ClientDuel:Get("ArcadeMode") then
        v10 = p9._arcade_status;
    else
        v10 = p9.ClientDuel:Get("LastRoundStartingStatus");
    end;

    p9:SetReplicate("LightingProfileOverride", v10 == "SuddenDeath" and "Graveyard - SuddenDeath" or (v10 == "MatchPoint" and "Graveyard - MatchPoint" or "Graveyard"));

    if v10 == "SuddenDeath" and p9.ClientDuel:Get("IsSpectating") then
        p9:CreateSound("rbxassetid://115990126225378", 1, 1, script, true, 15);
    end;

    if v10 == "MatchPoint" then
        local v11;

        if v10 == "MatchPoint" then
            v11 = p9.ClientDuel.DuelInterface.Frame or nil;
        else
            v11 = nil;
        end;

        p9._film_grain.Parent = v11;
    end;
end;

function u1._UpdateLightingProfileFromTimer(p12) -- Line: 81
    local TimeRemaining = p12.ClientDuel.DuelInterface.Timer:GetTimeRemaining();
    local v13;

    if TimeRemaining then
        v13 = p12.ClientDuel:Get("Status") == "RoundStarted" and true or p12.ClientDuel:Get("Status") == "RoundFinished";
    else
        v13 = TimeRemaining;
    end;

    local v14;

    if v13 then
        v14 = TimeRemaining < 10 and "SuddenDeath" or (TimeRemaining < 30 and "MatchPoint" or nil);
    else
        v14 = nil;
    end;

    if v14 == p12._arcade_status then
        return;
    end;

    p12._arcade_status = v14;
    p12:_UpdateLightingProfile();
end;

function u1._Setup(u15) -- Line: 94
    if u15.ClientDuel:Get("ArcadeMode") then
        u15.ClientDuel.DuelInterface.Timer.TimerChanged:Connect(function() -- Line: 102
            -- upvalues: u15 (copy)
            u15:_UpdateLightingProfileFromTimer();
        end);
        u15:_UpdateLightingProfileFromTimer();

        return;
    end;

    u15.ClientDuel:GetDataChangedSignal("LastRoundStartingStatus"):Connect(function() -- Line: 96
        -- upvalues: u15 (copy)
        u15:_UpdateLightingProfile();
    end);
    u15:_UpdateLightingProfile();
end;

function u1._Init(u16) -- Line: 110
    u16.ClientDuel:GetDataChangedSignal("IsHidden"):Connect(function() -- Line: 111
        -- upvalues: u16 (copy)
        u16:_UpdateFilmGrainLoop();
    end);
    u16:_Setup();
    task.defer(u16._UpdateFilmGrainLoop, u16);
end;

return u1;