-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local ReplicatedClass = require(ReplicatedStorage.Modules.ReplicatedClass);
local ServerOsTime = require(ReplicatedStorage.Modules.ServerOsTime);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, ReplicatedClass);
u1.__index = u1;

function u1.new(...) -- Line: 14
    -- upvalues: ReplicatedClass (copy), u1 (copy)
    local v2 = ReplicatedClass.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.GetActualQueueName(p4) -- Line: 26
    -- upvalues: DuelLibrary (copy)
    return DuelLibrary:GetFirstQueueNameByDuelLogic(p4:Get("QueueName")) or p4:Get("QueueName");
end;

function u1.GetDuelLogics(p5, p6, p7) -- Line: 30
    -- upvalues: DuelLibrary (copy), ServerOsTime (copy), CONSTANTS (copy)
    local v8 = {};

    for _, v in pairs(DuelLibrary.PlaySourceOrder) do
        local v9 = DuelLibrary.PlaySources[v];

        if v9.Type == "MatchmakingQueue" then
            local v10 = DuelLibrary.MatchmakingQueues[v];
            local v11;

            if p7 then
                v11 = v10.DisplayName;
            else
                v11 = v9.DuelLogic or (v10.TitleName or v10.DisplayName);
            end;

            if not table.find(v8, v11) and ServerOsTime:Get() >= v10.TerminalsReleaseTime then
                local v12;

                if v10.NumTeams == p5:Get("NumTeams") then
                    v12 = true;
                elseif v10.NumTeams == 1 then
                    v12 = p5:Get("NumTeams") == 2;
                else
                    v12 = false;
                end;

                if v12 then
                    local v13;

                    if p6 then
                        v13 = p6.HasVerifiedBadge;

                        if not v13 then
                            if #p6.DisplayName >= 2 then
                                v13 = string.sub(p6.DisplayName, 1, 2) == "00";
                            else
                                v13 = false;
                            end;
                        end;
                    else
                        v13 = p6;
                    end;

                    if v9.DuelLogic ~= "Easy Exploits" or (not p6 or (v13 or CONSTANTS.IS_STUDIO)) then
                        table.insert(v8, v11);
                    end;
                end;
            end;
        end;
    end;

    return v8;
end;

function u1.GetMapPools(p14, p15) -- Line: 70
    return p14:GetDuelLogics(p15, true);
end;

function u1.GetSortedMapNames(p16) -- Line: 74
    -- upvalues: DuelLibrary (copy), Utility (copy)
    local Maps = DuelLibrary:GetMaps(p16:Get("PlayersPerTeam") * p16:Get("NumTeams"), p16:Get("NumTeams"), p16:Get("QueueName"), true);
    table.sort(Maps, function(p17, p18) -- Line: 77
        -- upvalues: Utility (ref)
        return Utility:StringLessThan(p17, p18);
    end);

    return Maps;
end;

function u1.GetMatchmakingQueueInfoFromQueueName(p19, p20) -- Line: 84
    -- upvalues: DuelLibrary (copy)
    return DuelLibrary.MatchmakingQueueDuelLogicToQueueName[p20] or DuelLibrary.MatchmakingQueues[p20];
end;

function u1.GetMaxPlayersPerTeam(p21) -- Line: 88
    return 16;
end;

function u1.CountTeam(p22, p23) -- Line: 92
    local v24 = 0;

    for _ in pairs(p22:Get("PlayersWaiting")[p23]) do
        v24 = v24 + 1;
    end;

    return v24;
end;

function u1.IsReady(p25, p26) -- Line: 102
    local v27 = p25:IsInQueue(p26);

    if v27 then
        v27 = p25:Get("PlayersWaiting")[v27][tostring(p26.UserId)];
    end;

    return v27;
end;

function u1.IsInQueue(p28, p29) -- Line: 108
    for i, v in pairs(p28:Get("PlayersWaiting")) do
        if v[tostring(p29.UserId)] ~= nil then
            return i;
        end;
    end;
end;

function u1.IsWithin(p30, p31, p32) -- Line: 116
    -- upvalues: Utility (copy)
    if not p32 then
        for i = 1, p30:Get("NumTeams") do
            if p30:IsWithin(p31, i) then
                return i;
            end;

            local _ = i;
        end;

        return false;
    end;

    local v33 = p30:Get("Model"):WaitForChild("Important"):WaitForChild("Team" .. p32);
    local v34 = p31 and (p31.Character and p31.Character:FindFirstChild("HumanoidRootPart")) and p31.Character.HumanoidRootPart.Position;

    if v33 then
        if v34 then
            v34 = Utility:IsWithinRotatedShape(v34, v33.CFrame, v33.Size, v33.Shape);
        end;
    else
        v34 = v33;
    end;

    return v34;
end;

function u1._Init(p35) -- Line: 137
end;

return u1;