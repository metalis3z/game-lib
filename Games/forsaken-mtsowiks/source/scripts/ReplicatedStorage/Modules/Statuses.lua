-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    CurrentStatuses = {}
};
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_RunService_0 = game:GetService("RunService");
local v4 = require(l_ReplicatedStorage_0.Modules.Network);
local v5 = require(l_ReplicatedStorage_0.Modules.Sounds);
local v6 = require(l_ReplicatedStorage_0.Modules.Util);
local l_StatusEffects_0 = l_ReplicatedStorage_0.Modules.StatusEffects;
v0.ApplyStatus = function(_, v9, v10, v11) --[[ Line: 16 ]] --[[ Name: ApplyStatus ]]
    -- upvalues: v0 (copy), l_StatusEffects_0 (copy), v6 (copy), l_ReplicatedStorage_0 (copy), v5 (copy), v4 (copy), l_RunService_0 (copy)
    local v12 = v9:IsA("Model") and game.Players:GetPlayerFromCharacter(v9) or v9;
    local v13 = v12:IsA("Model") and v12 or v12.Character;
    if not v0.CurrentStatuses[v12] then
        v0.CurrentStatuses[v12] = {};
    end;
    local l_l_StatusEffects_0_FirstChild_0 = l_StatusEffects_0:FindFirstChild(tostring(v10), true);
    local v15 = l_l_StatusEffects_0_FirstChild_0 and require(l_l_StatusEffects_0_FirstChild_0);
    local v16 = v0.CurrentStatuses[v12][v10] ~= nil;
    local v17 = v0.CurrentStatuses[v12][v10] or v15 and v6:CopyTable(v15);
    if v17 and v13 then
        local v18 = require(l_ReplicatedStorage_0.Modules.Actors).CurrentActors[v12];
        if v18 and v18.Behavior and v18.Behavior[("On%*Absolute"):format(v10)] then
            v18.Behavior[("On%*Absolute"):format(v10)](v18.Behavior, v18);
        end;
        if v17.Level and v11 and v11.Level and v11.Level < v17.Level and not v11.Stackable then
            return;
        elseif v13:GetAttribute((("%*Disabled"):format(v10))) then
            return;
        else
            local l_pairs_0 = pairs;
            local v20 = v11 or {};
            for v21, v22 in l_pairs_0(v20) do
                v17.Data[v21] = v22;
            end;
            if v18 then
                v5:PlayVoiceline(v18, ("%*Status"):format(v10), {
                    Priority = 5
                });
            end;
            if v10 == "Stunned" and tonumber(v17.Data.Duration) then
                v20 = require(l_ReplicatedStorage_0.Modules.Actors):GetAmountOfLivingActorsOfClass("Sentinel");
                local l_Duration_0 = v17.Data.Duration;
                local v24 = l_Duration_0 * (1 - (v20 / 8) ^ 3.25);
                v17.Data.Duration = math.clamp(v24, 0, l_Duration_0);
                if v17.Data.Duration <= 0.5 then
                    return;
                end;
            end;
            if v16 then
                if v17.Data.TimeStackable == false then
                    return;
                elseif v11.TimeStackable == false then
                    return;
                else
                    v17.TimePast = 0;
                    if v17.Data.Stackable then
                        v17.Level = math.clamp(v17.Level + (v11 and v11.Level or 1), 1, v17.Data.MaxLevel or 99);
                    elseif v17.Data.Level and v17.Data.Level > v17.Level then
                        v17.Level = v17.Data.Level;
                    end;
                    if v17.Applied then
                        v17:Applied();
                    end;
                    v4:FireClientConnection(v12, "StatusApplied", "REMOTE_EVENT", v10, v17, v17.Data);
                    if v18 and v18.Behavior and v18.Behavior[("On%*"):format(v10)] then
                        v18.Behavior[("On%*"):format(v10)](v18.Behavior, v18);
                    end;
                    return v17;
                end;
            else
                v17.Player = v12;
                v17.Character = v13;
                v17.Level = v17.Data.Level or 1;
                v17.TimeRequired = tonumber(v17.Data.Duration) or 10;
                v17.TimePast = 0;
                l_pairs_0 = v13.PrimaryPart;
                if l_pairs_0 and l_pairs_0.Parent then
                    v20 = v5:Play(v17.Data.SFX, {
                        Parent = l_pairs_0, 
                        Looped = true, 
                        RollOffMinDistance = 16, 
                        RollOffMaxDistance = 48
                    });
                    if v20 then
                        v20.Name = ("%*StatusSFX"):format(v10);
                        game.Debris:AddItem(v20, 30);
                    end;
                end;
                if v17.Applied then
                    v17:Applied();
                end;
                v4:FireClientConnection(v12, "StatusApplied", "REMOTE_EVENT", v10, v17, v17.Data);
                v17.Connection = l_RunService_0.Heartbeat:Connect(function(v25) --[[ Line: 117 ]]
                    -- upvalues: v17 (copy), v12 (copy), v0 (ref), v10 (copy)
                    local l_v17_0 = v17;
                    l_v17_0.TimePast = l_v17_0.TimePast + v25;
                    if not v12.Parent or not v17.Character.Parent or v17.TimePast >= v17.TimeRequired then
                        v0:RemoveStatus(v12, v10);
                        return;
                    else
                        if v17.Heartbeat then
                            v17:Heartbeat(v25);
                        end;
                        return;
                    end;
                end);
                if not v0.CurrentStatuses[v12] then
                    v0.CurrentStatuses[v12] = {};
                end;
                v0.CurrentStatuses[v12][v10] = v17;
                if v18 and v18.Behavior and v18.Behavior[("On%*"):format(v10)] then
                    v18.Behavior[("On%*"):format(v10)](v18.Behavior, v18);
                end;
                if v0:GetStatusCount(v12) >= 4 then
                    require(l_ReplicatedStorage_0.Modules.AchievementUtil):IncrementAchievementProgress(v12, "LotsaStatuses");
                end;
                return v17;
            end;
        end;
    else
        return;
    end;
end;
v0.RemoveStatus = function(_, v28, v29) --[[ Line: 146 ]] --[[ Name: RemoveStatus ]]
    -- upvalues: v0 (copy), v4 (copy), l_ReplicatedStorage_0 (copy)
    if v28 and v28:IsA("Model") then
        v28 = game.Players:GetPlayerFromCharacter(v28) or v28;
    end;
    local v30 = v0.CurrentStatuses[v28] and v0.CurrentStatuses[v28][v29];
    if v30 then
        if v30.Removed then
            v30:Removed();
        end;
        if v30.Connection then
            v30.Connection:Disconnect();
            v30.Connection = nil;
        end;
        v4:FireClientConnection(v28, "StatusRemoved", "REMOTE_EVENT", v29);
        local v31 = v28:IsA("Player") and v28.Character or v28;
        local v32 = v31 and v31:FindFirstChild(("%*StatusSFX"):format(v29), true);
        if v32 then
            game.Debris:AddItem(v32, 0.25);
            game.TweenService:Create(v32, TweenInfo.new(0.25), {
                Volume = 0
            }):Play();
        end;
        local v33 = require(l_ReplicatedStorage_0.Modules.Actors).CurrentActors[v28];
        if v33 and v33.Behavior and v33.Behavior[("%*Ended"):format(v29)] then
            v33.Behavior[("%*Ended"):format(v29)](v33.Behavior, v33);
        end;
        v0.CurrentStatuses[v28][v29] = nil;
    end;
    if v0:GetStatusCount(v28) == 0 then
        table.clear(v0.CurrentStatuses[v28]);
        v0.CurrentStatuses[v28] = nil;
    end;
end;
v0.RemoveStatuses = function(_, v35, _) --[[ Line: 189 ]] --[[ Name: RemoveStatuses ]]
    -- upvalues: v0 (copy)
    if v35 and v35:IsA("Model") then
        v35 = game.Players:GetPlayerFromCharacter(v35) or v35;
    end;
    local l_pairs_1 = pairs;
    local v38 = v0.CurrentStatuses[v35] or {};
    for v39, _ in l_pairs_1(v38) do
        v0:RemoveStatus(v35, v39);
    end;
    v0.CurrentStatuses[v35] = nil;
end;
v0.GetStatusCount = function(_, v42) --[[ Line: 204 ]] --[[ Name: GetStatusCount ]]
    -- upvalues: v0 (copy)
    local v43 = 0;
    local v44 = v0.CurrentStatuses[v42];
    local l_pairs_2 = pairs;
    local v46 = v44 or {};
    for _, _ in l_pairs_2(v46) do
        v43 = v43 + 1;
    end;
    return v44 and v43 or -1;
end;
v0.PlayerHasStatus = function(_, v50, v51) --[[ Line: 212 ]] --[[ Name: PlayerHasStatus ]]
    -- upvalues: v0 (copy)
    local v52 = v50:IsA("Model") and game.Players:GetPlayerFromCharacter(v50) or v50;
    return v0.CurrentStatuses[v52] and v0.CurrentStatuses[v52][v51];
end;
v0.Start = function(_) --[[ Line: 217 ]] --[[ Name: Start ]]
    -- upvalues: l_RunService_0 (copy), v6 (copy), v0 (copy), l_StatusEffects_0 (copy), v4 (copy), l_CollectionService_0 (copy)
    if l_RunService_0:IsServer() then
        v6.OnCharacterAdded(function(_, v55) --[[ Line: 221 ]]
            -- upvalues: v0 (ref)
            v0:RemoveStatuses(v55);
        end);
        game.Players.PlayerRemoving:Connect(function(v56) --[[ Line: 226 ]]
            -- upvalues: v0 (ref)
            v0:RemoveStatuses(v56);
        end);
        return;
    else
        if l_RunService_0:IsClient() then
            local l_LocalPlayer_0 = game.Players.LocalPlayer;
            local v58 = script.StatusContainer:Clone();
            v58.Parent = l_LocalPlayer_0.PlayerGui.MainUI;
            v0.CurrentStatuses[l_LocalPlayer_0] = {};
            local v59 = v0.CurrentStatuses[l_LocalPlayer_0];
            local function v71(v60, v61, v62) --[[ Line: 246 ]] --[[ Name: onStatusApplied ]]
                -- upvalues: v59 (copy), l_LocalPlayer_0 (copy), l_StatusEffects_0 (ref), v6 (ref), v58 (copy)
                local l_Level_0 = v61.Level;
                local l_Duration_1 = v62.Duration;
                local l_Icon_0 = v62.Icon;
                local l_Hidden_0 = v62.Hidden;
                if v59[v60] then
                    local v67 = v59[v60];
                    v67.TimePast = 0;
                    v67.TimeRequired = l_Duration_1;
                    v67.Level = l_Level_0;
                    v67.CurrentTimeDisplay = 123456789;
                    if v67.Info.Applied then
                        v67.Info:Applied();
                        return;
                    end;
                else
                    local v68 = {
                        TimePast = 0, 
                        TimeRequired = l_Duration_1, 
                        Level = l_Level_0, 
                        Player = l_LocalPlayer_0, 
                        Character = l_LocalPlayer_0.Character, 
                        Data = v62
                    };
                    local l_l_StatusEffects_0_FirstChild_1 = l_StatusEffects_0:FindFirstChild(v60, true);
                    local v70 = v6:CopyTable(require(l_l_StatusEffects_0_FirstChild_1));
                    v70.__index = v70;
                    v68.Info = setmetatable(v68, v70);
                    if v68.Info.Applied then
                        v68.Info:Applied();
                    end;
                    v68.UI = script.StatusDisplay:Clone();
                    v68.UI.Name = v60;
                    v68.UI.Timer.Text = v6:FormatTime(math.round(v68.TimeRequired - v68.TimePast), "Clock");
                    v68.UI.Title.Text = ("%* %*"):format(v60, (v6:IntToRoman(v68.Level)));
                    v68.UI.IconHolder.Icon.Image = l_Icon_0 or "";
                    v68.UI.Visible = not l_Hidden_0;
                    v68.UI.Parent = v58;
                    v59[v60] = v68;
                end;
            end;
            local function v74(v72) --[[ Line: 292 ]] --[[ Name: onStatusRemoved ]]
                -- upvalues: v59 (copy)
                local v73 = v59[v72];
                if v73 then
                    if v73.Info.Removed then
                        v73.Info:Removed();
                    end;
                    v73.UI:Destroy();
                    v59[v72] = nil;
                end;
            end;
            local function v79(v75) --[[ Line: 302 ]] --[[ Name: update ]]
                -- upvalues: v59 (copy), v6 (ref)
                for v76, v77 in pairs(v59) do
                    v77.TimePast = v77.TimePast + v75;
                    if v77.Info.Heartbeat then
                        v77.Info:Heartbeat(v75);
                    end;
                    local v78 = math.ceil(v77.TimeRequired - v77.TimePast);
                    if v77.CurrentTimeDisplay ~= v78 then
                        v77.CurrentTimeDisplay = v78;
                        v77.UI.Timer.Text = v6:FormatTime(v77.CurrentTimeDisplay, "Clock");
                        v77.UI.Title.Text = ("%* %*"):format(v76, (v6:IntToRoman(v77.Level)));
                    end;
                    if v77.TimePast >= v77.TimeRequired then
                        if v77.Info.Removed then
                            v77.Info:Removed();
                        end;
                        v77.UI:Destroy();
                        v59[v76] = nil;
                    end;
                end;
            end;
            local function v83() --[[ Line: 326 ]] --[[ Name: reset ]]
                -- upvalues: v59 (copy)
                for v80, _ in pairs(v59) do
                    local v82 = v59[v80];
                    if v82 then
                        if v82.Info.Removed then
                            v82.Info:Removed();
                        end;
                        v82.UI:Destroy();
                        v59[v80] = nil;
                    end;
                end;
            end;
            local function v86(v84) --[[ Line: 333 ]] --[[ Name: hemmorhageRegisterPrompt ]]
                -- upvalues: l_LocalPlayer_0 (copy)
                local l_Character_0 = l_LocalPlayer_0.Character;
                if not l_Character_0 or not l_Character_0.Parent then
                    return;
                else
                    if l_Character_0 and tostring(l_Character_0.Parent):find("Killer") or v84:IsDescendantOf(l_Character_0) then
                        v84.MaxActivationDistance = 0;
                    end;
                    return;
                end;
            end;
            v4:SetConnection("StatusApplied", "REMOTE_EVENT", v71);
            v4:SetConnection("StatusRemoved", "REMOTE_EVENT", v74);
            l_RunService_0.Heartbeat:Connect(v79);
            l_LocalPlayer_0.CharacterAdded:Connect(v83);
            l_CollectionService_0:GetInstanceAddedSignal("666HemmorhagePrompt"):Connect(v86);
            for _, v88 in ipairs(l_CollectionService_0:GetTagged("666HemmorhagePrompt")) do
                local l_Character_1 = l_LocalPlayer_0.Character;
                if l_Character_1 and l_Character_1.Parent and (l_Character_1 and tostring(l_Character_1.Parent):find("Killer") or v88:IsDescendantOf(l_Character_1)) then
                    v88.MaxActivationDistance = 0;
                end;
            end;
        end;
        return;
    end;
end;
return v0;