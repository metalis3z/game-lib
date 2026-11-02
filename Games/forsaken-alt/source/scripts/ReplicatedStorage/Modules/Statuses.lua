-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    CurrentStatuses = {}
};
local v1 = require(game.ReplicatedStorage.Modules.Network);
local v2 = require(game.ReplicatedStorage.Modules.Sounds);
local v3 = require(game.ReplicatedStorage.Modules.Util);
local l_StatusEffects_0 = game.ReplicatedStorage.Modules.StatusEffects;
v0.ApplyStatus = function(_, v6, v7, v8) --[[ Line: 13 ]] --[[ Name: ApplyStatus ]]
    -- upvalues: v0 (copy), l_StatusEffects_0 (copy), v3 (copy), v1 (copy), v2 (copy)
    local v9 = v6:IsA("Model") and game.Players:GetPlayerFromCharacter(v6) or v6;
    local v10 = v9:IsA("Model") and v9 or v9.Character;
    if not v0.CurrentStatuses[v9] then
        v0.CurrentStatuses[v9] = {};
    end;
    local l_l_StatusEffects_0_FirstChild_0 = l_StatusEffects_0:FindFirstChild(tostring(v7), true);
    local v12 = l_l_StatusEffects_0_FirstChild_0 and require(l_l_StatusEffects_0_FirstChild_0);
    local v13 = v0.CurrentStatuses[v9][v7] or v12 and v3:CopyTable(v12);
    if v13 and v10 then
        if v13.Level and v8 and v8.Level and v8.Level < v13.Level and not v8.Stackable then
            return;
        elseif v10:GetAttribute((("%*Disabled"):format(v7))) then
            return;
        else
            local l_pairs_0 = pairs;
            local v15 = v8 or {};
            for v16, v17 in l_pairs_0(v15) do
                v13.Data[v16] = v17;
            end;
            if v7 == "Stunned" and tonumber(v13.Data.Duration) then
                v15 = require(game.ReplicatedStorage.Modules.Actors):GetAmountOfLivingActorsOfClass("Sentinel");
                local l_Duration_0 = v13.Data.Duration;
                local v19 = l_Duration_0 * (1 - (v15 / 8) ^ 3.25);
                v13.Data.Duration = math.clamp(v19, 0, l_Duration_0);
                if v13.Data.Duration <= 0.5 then
                    return;
                end;
            end;
            if v0.CurrentStatuses[v9][v7] then
                if v13.Data.TimeStackable == false then
                    return;
                else
                    v13.TimePast = 0;
                    if v13.Data.Stackable then
                        v13.Level = math.clamp(v13.Level + (v8 and v8.Level or 1), 1, v13.Data.MaxLevel or 99);
                    elseif v13.Data.Level and v13.Data.Level > v13.Level then
                        v13.Level = v13.Data.Level;
                    end;
                    if v13.Applied then
                        v13:Applied();
                    end;
                    v1:FireClientConnection(v9, "StatusApplied", "REMOTE_EVENT", v7, v13, v13.Data);
                    return v13;
                end;
            else
                v13.Player = v9;
                v13.Character = v10;
                v13.Level = v13.Data.Level or 1;
                v13.TimeRequired = tonumber(v13.Data.Duration) or 10;
                v13.TimePast = 0;
                v15 = require(game.ReplicatedStorage.Modules.Actors).CurrentActors[v9];
                if v15 then
                    v2:PlayVoiceline(v15, ("%*Status"):format(v7), {
                        Priority = 5
                    });
                end;
                local l_PrimaryPart_0 = v10.PrimaryPart;
                if l_PrimaryPart_0 and l_PrimaryPart_0.Parent then
                    local v21 = v2:Play(v13.Data.SFX, {
                        Parent = l_PrimaryPart_0, 
                        Looped = true, 
                        RollOffMinDistance = 16, 
                        RollOffMaxDistance = 48
                    });
                    if v21 then
                        v21.Name = ("%*StatusSFX"):format(v7);
                        game.Debris:AddItem(v21, 30);
                    end;
                end;
                if v13.Applied then
                    v13:Applied();
                end;
                v1:FireClientConnection(v9, "StatusApplied", "REMOTE_EVENT", v7, v13, v13.Data);
                v13.Connection = game["Run Service"].Heartbeat:Connect(function(v22) --[[ Line: 98 ]]
                    -- upvalues: v13 (copy), v9 (copy), v0 (ref), v7 (copy)
                    local l_v13_0 = v13;
                    l_v13_0.TimePast = l_v13_0.TimePast + v22;
                    if not v9.Parent or not v13.Character.Parent or v13.TimePast >= v13.TimeRequired then
                        v0:RemoveStatus(v9, v7);
                        return;
                    else
                        if v13.Heartbeat then
                            v13:Heartbeat(v22);
                        end;
                        return;
                    end;
                end);
                if not v0.CurrentStatuses[v9] then
                    v0.CurrentStatuses[v9] = {};
                end;
                v0.CurrentStatuses[v9][v7] = v13;
                if v0:GetStatusCount(v9) >= 4 then
                    require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(v9, "LotsaStatuses");
                end;
                return v13;
            end;
        end;
    else
        return;
    end;
end;
v0.RemoveStatus = function(_, v25, v26) --[[ Line: 122 ]] --[[ Name: RemoveStatus ]]
    -- upvalues: v0 (copy), v1 (copy)
    if v25 and v25:IsA("Model") then
        v25 = game.Players:GetPlayerFromCharacter(v25) or v25;
    end;
    local v27 = v0.CurrentStatuses[v25] and v0.CurrentStatuses[v25][v26];
    if v27 then
        if v27.Removed then
            v27:Removed();
        end;
        if v27.Connection then
            v27.Connection:Disconnect();
            v27.Connection = nil;
        end;
        v1:FireClientConnection(v25, "StatusRemoved", "REMOTE_EVENT", v26);
        local v28 = v25:IsA("Player") and v25.Character or v25;
        local v29 = v28 and v28:FindFirstChild(("%*StatusSFX"):format(v26), true);
        if v29 then
            game.Debris:AddItem(v29, 0.25);
            game.TweenService:Create(v29, TweenInfo.new(0.25), {
                Volume = 0
            }):Play();
        end;
        v0.CurrentStatuses[v25][v26] = nil;
    end;
    if v0:GetStatusCount(v25) == 0 then
        table.clear(v0.CurrentStatuses[v25]);
        v0.CurrentStatuses[v25] = nil;
    end;
end;
v0.RemoveStatuses = function(_, v31, _) --[[ Line: 158 ]] --[[ Name: RemoveStatuses ]]
    -- upvalues: v0 (copy)
    if v31 and v31:IsA("Model") then
        v31 = game.Players:GetPlayerFromCharacter(v31) or v31;
    end;
    local l_pairs_1 = pairs;
    local v34 = v0.CurrentStatuses[v31] or {};
    for v35, _ in l_pairs_1(v34) do
        v0:RemoveStatus(v31, v35);
    end;
    v0.CurrentStatuses[v31] = nil;
end;
v0.GetStatusCount = function(_, v38) --[[ Line: 173 ]] --[[ Name: GetStatusCount ]]
    -- upvalues: v0 (copy)
    local v39 = 0;
    local v40 = v0.CurrentStatuses[v38];
    local l_pairs_2 = pairs;
    local v42 = v40 or {};
    for _, _ in l_pairs_2(v42) do
        v39 = v39 + 1;
    end;
    return v40 and v39 or -1;
end;
v0.PlayerHasStatus = function(_, v46, v47) --[[ Line: 181 ]] --[[ Name: PlayerHasStatus ]]
    -- upvalues: v0 (copy)
    local v48 = v46:IsA("Model") and game.Players:GetPlayerFromCharacter(v46) or v46;
    return v0.CurrentStatuses[v48] and v0.CurrentStatuses[v48][v47];
end;
v0.Start = function(_) --[[ Line: 186 ]] --[[ Name: Start ]]
    -- upvalues: v3 (copy), v0 (copy), v1 (copy), l_StatusEffects_0 (copy)
    if game["Run Service"]:IsServer() then
        v3.OnCharacterAdded(function(_, v51) --[[ Line: 190 ]]
            -- upvalues: v0 (ref)
            v0:RemoveStatuses(v51);
        end);
        game.Players.PlayerRemoving:Connect(function(v52) --[[ Line: 195 ]]
            -- upvalues: v0 (ref)
            v0:RemoveStatuses(v52);
        end);
        return;
    else
        if game["Run Service"]:IsClient() then
            local l_LocalPlayer_0 = game.Players.LocalPlayer;
            local v54 = script.StatusContainer:Clone();
            v54.Parent = l_LocalPlayer_0.PlayerGui.MainUI;
            v0.CurrentStatuses[l_LocalPlayer_0] = {};
            local v55 = v0.CurrentStatuses[l_LocalPlayer_0];
            v1:SetConnection("StatusApplied", "REMOTE_EVENT", function(v56, v57, v58) --[[ Line: 211 ]]
                -- upvalues: v55 (copy), l_LocalPlayer_0 (copy), l_StatusEffects_0 (ref), v3 (ref), v54 (copy)
                local l_Level_0 = v57.Level;
                local l_Duration_1 = v58.Duration;
                local l_Icon_0 = v58.Icon;
                local l_Hidden_0 = v58.Hidden;
                if v55[v56] then
                    local v63 = v55[v56];
                    v63.TimePast = 0;
                    v63.TimeRequired = l_Duration_1;
                    v63.Level = l_Level_0;
                    v63.CurrentTimeDisplay = 123456789;
                    if v63.Info.Applied then
                        v63.Info:Applied();
                        return;
                    end;
                else
                    local v64 = {
                        TimePast = 0, 
                        TimeRequired = l_Duration_1, 
                        Level = l_Level_0, 
                        Player = l_LocalPlayer_0, 
                        Character = l_LocalPlayer_0.Character, 
                        Data = v58
                    };
                    local l_l_StatusEffects_0_FirstChild_1 = l_StatusEffects_0:FindFirstChild(v56, true);
                    local v66 = v3:CopyTable(require(l_l_StatusEffects_0_FirstChild_1));
                    v66.__index = v66;
                    v64.Info = setmetatable(v64, v66);
                    if v64.Info.Applied then
                        v64.Info:Applied();
                    end;
                    v64.UI = script.StatusDisplay:Clone();
                    v64.UI.Name = v56;
                    v64.UI.Timer.Text = v3:FormatTime(math.round(v64.TimeRequired - v64.TimePast), "Clock");
                    v64.UI.Title.Text = ("%* %*"):format(v56, (v3:IntToRoman(v64.Level)));
                    v64.UI.IconHolder.Icon.Image = l_Icon_0 or "";
                    v64.UI.Parent = v54;
                    v64.UI.Visible = not l_Hidden_0;
                    v55[v56] = v64;
                end;
            end);
            v1:SetConnection("StatusRemoved", "REMOTE_EVENT", function(v67) --[[ Line: 256 ]]
                -- upvalues: v55 (copy)
                local v68 = v55[v67];
                if v68 then
                    if v68.Info.Removed then
                        v68.Info:Removed();
                    end;
                    v68.UI:Destroy();
                    v55[v67] = nil;
                end;
            end);
            l_LocalPlayer_0.CharacterAdded:Connect(function() --[[ Line: 266 ]]
                -- upvalues: v55 (copy)
                for v69, v70 in pairs(v55) do
                    if v70.Info.Removed then
                        v70.Info:Removed();
                    end;
                    v70.UI:Destroy();
                    v55[v69] = nil;
                end;
            end);
            game["Run Service"].Heartbeat:Connect(function(v71) --[[ Line: 275 ]]
                -- upvalues: v55 (copy), v3 (ref)
                for v72, v73 in pairs(v55) do
                    v73.TimePast = v73.TimePast + v71;
                    if v73.Info.Heartbeat then
                        v73.Info:Heartbeat(v71);
                    end;
                    local v74 = math.ceil(v73.TimeRequired - v73.TimePast);
                    if v73.CurrentTimeDisplay ~= v74 then
                        v73.CurrentTimeDisplay = v74;
                        v73.UI.Timer.Text = v3:FormatTime(v73.CurrentTimeDisplay, "Clock");
                        v73.UI.Title.Text = ("%* %*"):format(v72, (v3:IntToRoman(v73.Level)));
                    end;
                    if v73.TimePast >= v73.TimeRequired then
                        if v73.Info.Removed then
                            v73.Info:Removed();
                        end;
                        v73.UI:Destroy();
                        v55[v72] = nil;
                    end;
                end;
            end);
        end;
        return;
    end;
end;
return v0;