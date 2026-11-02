-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ForwardData_0 = l_ReplicatedStorage_0:WaitForChild("Communication"):WaitForChild("ForwardData");
local v3 = require(l_ReplicatedStorage_0.Frameworks.SystemMessage);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v5 = {
    SELF_DEBOUNCE = 0, 
    FRIEND_DEBOUNCE = 4, 
    STRANGER_DEBOUNCE = 12, 
    SAME_PLAYER_COOLDOWN = 15, 
    PRESTIGE_BYPASS_TIER = 7, 
    GLOBAL_MIN_GAP = 2
};
local v6 = 0;
local v7 = {};
local v8 = 0;
local v9 = 0;
local v10 = {};
local v11 = {
    Overlord = 7, 
    Dominator = 7, 
    ["Final Boss"] = 8, 
    Paragon = 8, 
    Imperator = 8, 
    Supreme = 9, 
    Archeox = 9, 
    Emperor = 9, 
    Celestial = 9, 
    ArchWarrior = 10, 
    Divine = 10, 
    Cosmic = 10, 
    APEX = 10, 
    Heptagon = 10, 
    Transcendent = 10, 
    ["God of Aura"] = 10, 
    Omniscient = 11, 
    Absolute = 11, 
    Metaversal = 11, 
    Powerious = 11, 
    ["I N F I N I T E"] = 11, 
    ["S I N G U L A R I T Y"] = 12, 
    ["L I M I T L E S S"] = 12, 
    ["B O U N D L E S S"] = 12, 
    ["F A L L E N   A N G E L"] = 12
};
local function _(v12) --[[ Line: 37 ]] --[[ Name: getRankTier ]]
    -- upvalues: v11 (copy)
    return v11[v12] or 1;
end;
local _ = function(v14) --[[ Line: 41 ]] --[[ Name: isFriend ]]
    -- upvalues: l_Players_0 (copy), l_LocalPlayer_0 (copy)
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 42 ]]
        -- upvalues: l_Players_0 (ref), v14 (copy), l_LocalPlayer_0 (ref)
        for _, v16 in ipairs(l_Players_0:GetPlayers()) do
            if v16.DisplayName == v14 then
                return l_LocalPlayer_0:IsFriendsWith(v16.UserId);
            end;
        end;
        return false;
    end);
    return l_status_0 and l_result_0 or false;
end;
local function _(v20) --[[ Line: 53 ]] --[[ Name: isSelf ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    return v20 == l_LocalPlayer_0.DisplayName;
end;
local function v30(v22, v23) --[[ Line: 57 ]] --[[ Name: shouldShow ]]
    -- upvalues: v11 (copy), l_LocalPlayer_0 (copy), v10 (copy), v6 (ref), v5 (copy), v7 (copy), l_Players_0 (copy), v9 (ref), v8 (ref)
    local v24 = os.clock();
    local v25 = v11[v23] or 1;
    if v22 == l_LocalPlayer_0.DisplayName then
        if v10[v23] then
            return false;
        else
            return true;
        end;
    elseif v24 - v6 < v5.GLOBAL_MIN_GAP then
        return false;
    elseif v24 - (v7[v22] or 0) < v5.SAME_PLAYER_COOLDOWN then
        return false;
    elseif v5.PRESTIGE_BYPASS_TIER <= v25 then
        return true;
    else
        local l_status_1, l_result_1 = pcall(function() --[[ Line: 42 ]]
            -- upvalues: l_Players_0 (ref), v22 (copy), l_LocalPlayer_0 (ref)
            for _, v27 in ipairs(l_Players_0:GetPlayers()) do
                if v27.DisplayName == v22 then
                    return l_LocalPlayer_0:IsFriendsWith(v27.UserId);
                end;
            end;
            return false;
        end);
        if l_status_1 and l_result_1 or false then
            if v24 < v9 then
                return false;
            else
                return true;
            end;
        elseif v24 < v8 then
            return false;
        else
            return true;
        end;
    end;
end;
local function v38(v31, v32) --[[ Line: 89 ]] --[[ Name: recordShown ]]
    -- upvalues: v6 (ref), v7 (copy), l_LocalPlayer_0 (copy), v10 (copy), l_Players_0 (copy), v9 (ref), v5 (copy), v11 (copy), v8 (ref)
    local v33 = os.clock();
    v6 = v33;
    v7[v31] = v33;
    if v31 == l_LocalPlayer_0.DisplayName then
        v10[v32] = true;
        return;
    else
        local l_status_2, l_result_2 = pcall(function() --[[ Line: 42 ]]
            -- upvalues: l_Players_0 (ref), v31 (copy), l_LocalPlayer_0 (ref)
            for _, v35 in ipairs(l_Players_0:GetPlayers()) do
                if v35.DisplayName == v31 then
                    return l_LocalPlayer_0:IsFriendsWith(v35.UserId);
                end;
            end;
            return false;
        end);
        if l_status_2 and l_result_2 or false then
            v9 = v33 + v5.FRIEND_DEBOUNCE;
            return;
        else
            v8 = v33 + ((v11[v32] or 1) >= v5.PRESTIGE_BYPASS_TIER and v5.FRIEND_DEBOUNCE or v5.STRANGER_DEBOUNCE);
            return;
        end;
    end;
end;
v3.Clear();
l_ForwardData_0.OnClientEvent:Connect(function(v39) --[[ Line: 113 ]]
    -- upvalues: v30 (copy), v3 (copy), v38 (copy)
    local l_Type_0 = v39.Type;
    if l_Type_0 == "SetTrainingAreasData" then
        _G.TrainingAreasData = v39.Data;
        return;
    else
        if l_Type_0 == "SystemMessage" and v39.MessageType == "RankUp" then
            local v41 = v39.PlayerName or "Unknown";
            local v42 = v39.RankName or "Unknown";
            if v30(v41, v42) and v3.AnnounceRankUp(v41, v42) then
                v38(v41, v42);
            end;
        end;
        return;
    end;
end);