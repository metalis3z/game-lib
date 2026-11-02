-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 8
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.ClientDuel = p2;
    v3:_Init();

    return v3;
end;

function u1.Destroy(p4) -- Line: 22
end;

function u1._Highlight(p5) -- Line: 30
    -- upvalues: DuelLibrary (copy)
    if not (p5.ClientDuel.LocalDueler and p5.ClientDuel:Get("IsSpectating")) then
        return;
    end;

    local v6 = p5.ClientDuel:Get("QueueName");

    if not (v6 and (DuelLibrary.MatchmakingQueues[v6] and DuelLibrary.MatchmakingQueues[v6].TitleName == "Beginner")) then
        return;
    end;

    for _, v in pairs(p5.ClientDuel.Duelers) do
        if v.ClientFighter and (v.ClientFighter.Entity and (not p5.ClientDuel.LocalDueler:Get("TeamID") or p5.ClientDuel.LocalDueler:Get("TeamID") ~= v:Get("TeamID"))) then
            v.ClientFighter.Entity:SetRedFigureMode(true, true);
        end;
    end;
end;

function u1._Init(u7) -- Line: 50
    u7.ClientDuel:GetDataChangedSignal("IsSpectating"):Connect(function() -- Line: 51
        -- upvalues: u7 (copy)
        u7:_Highlight();
    end);
    u7.ClientDuel:GetDataChangedSignal("Status"):Connect(function() -- Line: 55
        -- upvalues: u7 (copy)
        if u7.ClientDuel:Get("Status") == "RoundStarted" or u7.ClientDuel:Get("Status") == "RoundStarting" then
            u7:_Highlight();
        end;
    end);
    task.defer(u7._Highlight, u7);
end;

return u1;