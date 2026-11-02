-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Util);
local v2 = require(game.ReplicatedStorage.Modules.Schematics.Achievements);
local function v10(v3, v4) --[[ Line: 9 ]] --[[ Name: awardBadge ]]
    if not v4 then
        return;
    elseif not v3 then
        return;
    else
        local l_BadgeService_0 = game:GetService("BadgeService");
        local l_status_0, l_result_0 = pcall(function() --[[ Line: 16 ]]
            -- upvalues: l_BadgeService_0 (copy), v4 (copy)
            return l_BadgeService_0:GetBadgeInfoAsync(v4);
        end);
        if l_status_0 then
            if l_result_0.IsEnabled then
                local l_status_1, l_result_1 = pcall(function() --[[ Line: 24 ]]
                    -- upvalues: l_BadgeService_0 (copy), v3 (copy), v4 (copy)
                    return l_BadgeService_0:AwardBadge(v3.UserId, v4);
                end);
                if not l_status_1 then
                    warn("Error while awarding badge:", l_result_1);
                    return;
                elseif not l_result_1 then
                    return;
                end;
            end;
        else
            warn("Error while fetching badge info: " .. l_result_0);
        end;
        return;
    end;
end;
v0.GetAchievementDataValue = function(_, v12, v13, v14) --[[ Line: 41 ]] --[[ Name: GetAchievementDataValue ]]
    if not v12 then
        return;
    elseif typeof(v12) ~= "Instance" then
        return;
    elseif not v12:IsA("Player") then
        return;
    else
        local l_PlayerData_0 = v12:FindFirstChild("PlayerData");
        if not l_PlayerData_0 then
            return;
        elseif v14 then
            local l_FirstChild_0 = l_PlayerData_0.Achievements:FindFirstChild((tostring(v13)));
            return l_FirstChild_0 and l_FirstChild_0:FindFirstChild((tostring(v14)));
        elseif v13 then
            return l_PlayerData_0.Achievements and l_PlayerData_0.Achievements:FindFirstChild(tostring(v13), true);
        else
            return;
        end;
    end;
end;
v0.IncrementAchievementProgress = function(_, v18, v19, v20) --[[ Line: 58 ]] --[[ Name: IncrementAchievementProgress ]]
    -- upvalues: v2 (copy), v0 (copy)
    if not v18 then
        return;
    elseif typeof(v18) ~= "Instance" then
        return;
    elseif not v18:IsA("Player") then
        return;
    elseif workspace:GetAttribute("ServerType") == "VIP" then
        return;
    else
        for v21, v22 in pairs(v2) do
            local v23 = v22.Achievements and v22.Achievements[v19];
            if v23 then
                local l_v0_AchievementDataValue_0 = v0:GetAchievementDataValue(v18, v21, v19);
                if not l_v0_AchievementDataValue_0 then
                    return;
                else
                    if v20 then
                        local l_PlayerData_1 = v18:FindFirstChild("PlayerData");
                        if not l_PlayerData_1 then
                            return;
                        else
                            local v26 = ("%*_%*"):format(v19, v20);
                            if l_PlayerData_1.AchievementsData:FindFirstChild(v26) then
                                return;
                            else
                                local l_BoolValue_0 = Instance.new("BoolValue");
                                l_BoolValue_0.Value = true;
                                l_BoolValue_0.Name = v26;
                                l_BoolValue_0.Parent = l_PlayerData_1.AchievementsData;
                            end;
                        end;
                    end;
                    if l_v0_AchievementDataValue_0:IsA("BoolValue") and not l_v0_AchievementDataValue_0.Value then
                        l_v0_AchievementDataValue_0.Value = true;
                        v0:AwardPlayer(v18, v19);
                    elseif l_v0_AchievementDataValue_0:IsA("IntValue") and v23.Requirement then
                        local v28 = typeof(v23.Requirement) == "function" and v23.Requirement(v18) or v23.Requirement;
                        if l_v0_AchievementDataValue_0.Value < v28 then
                            l_v0_AchievementDataValue_0.Value = l_v0_AchievementDataValue_0.Value + 1;
                            if v28 <= l_v0_AchievementDataValue_0.Value then
                                v0:AwardPlayer(v18, v19);
                            end;
                        end;
                    end;
                    return true;
                end;
            end;
        end;
        return;
    end;
end;
v0.AwardPlayer = function(_, v30, v31) --[[ Line: 109 ]] --[[ Name: AwardPlayer ]]
    -- upvalues: v2 (copy), v0 (copy), v10 (copy), v1 (copy)
    if not v30 then
        return;
    elseif typeof(v30) ~= "Instance" then
        return;
    elseif not v30:IsA("Player") then
        return;
    elseif workspace:GetAttribute("ServerType") == "VIP" then
        return;
    else
        for v32, v33 in pairs(v2) do
            local v34 = v33.Achievements and v33.Achievements[v31];
            if v34 then
                if not v0:GetAchievementDataValue(v30, v32, v31) then
                    return;
                elseif not v30:FindFirstChild("PlayerData") then
                    return;
                else
                    local l_PlayerData_2 = v30:FindFirstChild("PlayerData");
                    if not l_PlayerData_2 then
                        return;
                    else
                        v10(v30, v34.BadgeID);
                        local v36 = ("%*_%*"):format(tostring(v31), (tostring(v34.RewardType)));
                        if l_PlayerData_2.AchievementsData:FindFirstChild(v36) then
                            return;
                        else
                            local l_BoolValue_1 = Instance.new("BoolValue");
                            l_BoolValue_1.Value = true;
                            l_BoolValue_1.Name = v36;
                            l_BoolValue_1.Parent = l_PlayerData_2.AchievementsData;
                            require(game.ReplicatedStorage.Modules.Network):FireClientConnection(v30, "AchievementCompleted", "REMOTE_EVENT", v31);
                            if v34.RewardType == "Currency" then
                                local v38 = tonumber(v34.Amount);
                                if not v38 then
                                    warn((("%* has no RewardAmount!!! fix asap pls"):format(v31)));
                                    return;
                                else
                                    v1:AddToPlayerStat(v30, "Money", v38);
                                    return true;
                                end;
                            elseif v34.RewardType == "Emote" or v34.RewardType == "Skin" then
                                local v39 = v34.Skins or v34.Emotes or {};
                                table.insert(v39, v34.Skin);
                                table.insert(v39, v34.Emote);
                                for _, v41 in pairs(v39) do
                                    local v42 = l_PlayerData_2:FindFirstChild("Purchased") and l_PlayerData_2.Purchased:FindFirstChild((("%*s"):format(v34.RewardType)));
                                    local l_IntValue_0 = Instance.new("IntValue");
                                    l_IntValue_0.Value = 0;
                                    l_IntValue_0.Name = v41;
                                    l_IntValue_0.Parent = v42;
                                end;
                                return true;
                            end;
                        end;
                    end;
                end;
            end;
        end;
        return;
    end;
end;
v0.Start = function(_) --[[ Line: 177 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy)
    if game["Run Service"]:IsClient() then
        return;
    else
        local v45 = require(game.ReplicatedStorage.Modules.Util);
        local v46 = require(game.ReplicatedStorage.Modules.Schematics.Achievements);
        v45.OnPlayerAdded(function(v47) --[[ Line: 183 ]]
            -- upvalues: v46 (copy), v0 (ref)
            local v48 = v47:WaitForChild("PlayerData", 30);
            if not v48 then
                return;
            else
                local l_Achievements_0 = v48.Achievements;
                for _, v51 in pairs(l_Achievements_0:GetChildren()) do
                    for _, v53 in pairs(v51:GetChildren()) do
                        local function v56() --[[ Line: 192 ]] --[[ Name: onUpdated ]]
                            -- upvalues: v46 (ref), v51 (copy), v53 (copy), v47 (copy), v0 (ref)
                            local v54 = v46[v51.Name] and v46[v51.Name].Achievements and v46[v51.Name].Achievements[v53.Name];
                            if v54 then
                                local v55 = typeof(v54.Requirement) == "function" and v54.Requirement(v47) or v54.Requirement;
                                if v53:IsA("IntValue") and v55 and v55 <= v53.Value or v53:IsA("BoolValue") and v53.Value then
                                    v0:AwardPlayer(v47, v53.Name);
                                end;
                            end;
                        end;
                        v53:GetPropertyChangedSignal("Value"):Connect(v56);
                        v56();
                    end;
                end;
                return;
            end;
        end);
        require(game.ReplicatedStorage.Modules.Network):SetConnection("UnlockAchievement", "REMOTE_EVENT", function(v57, v58) --[[ Line: 218 ]]
            -- upvalues: v46 (copy), v0 (ref)
            for _, v60 in pairs(v46) do
                local v61 = v60.Achievements and v60.Achievements[v58];
                if v61 and v61.Clientsided then
                    v0:IncrementAchievementProgress(v57, v58);
                end;
            end;
        end);
        return;
    end;
end;
return v0;