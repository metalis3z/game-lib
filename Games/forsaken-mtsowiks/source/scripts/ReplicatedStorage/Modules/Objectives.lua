-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local v3 = l_RunService_0:IsClient();
local v4 = l_RunService_0:IsServer();
local v5 = require(game.ReplicatedStorage.Modules.Network);
local v6 = require(game.ReplicatedStorage.Modules.Stats);
local v7 = require(game.ReplicatedStorage.Modules.Actors);
local v8 = require(game.ReplicatedStorage.Modules.Util);
v0.InitializeObjectives = function(_, v10, v11) --[[ Line: 18 ]] --[[ Name: InitializeObjectives ]]
    -- upvalues: v0 (copy)
    local v12 = v10 and v10:GetChildren();
    if v12 then
        table.sort(v12, function(v13, v14) --[[ Line: 22 ]]
            return require(v13).Order < require(v14).Order;
        end);
        task.spawn(function() --[[ Line: 25 ]]
            -- upvalues: v12 (copy), v0 (ref), v11 (copy)
            for _, v16 in pairs(v12) do
                local l_v0_Objective_0 = v0:CreateObjective(v16, v11);
                if l_v0_Objective_0.YieldUntilCompleted then
                    repeat
                        task.wait();
                    until l_v0_Objective_0.Progress >= l_v0_Objective_0.RequiredProgress or not l_v0_Objective_0.ReplicatedValue.Parent;
                end;
                if not l_v0_Objective_0.ReplicatedValue.Parent then
                    return;
                end;
            end;
        end);
    end;
end;
v0.CreateObjective = function(_, v19, v20) --[[ Line: 42 ]] --[[ Name: CreateObjective ]]
    -- upvalues: v8 (copy), v6 (copy), v7 (copy), v5 (copy), l_RunService_0 (copy), l_TweenService_0 (copy)
    local v21 = require(v19);
    if v21.CommonObjective then
        local l_FirstChild_0 = game.ReplicatedStorage.Modules.CommonObjectives:FindFirstChild(v21.CommonObjective);
        if l_FirstChild_0 then
            local v23 = require(l_FirstChild_0);
            v21 = v8:MergeTables(v8:CopyTable(v23), v8:CopyTable(v21));
            v21.__index = v21;
        end;
    end;
    local v24 = setmetatable(v20 or {}, v21);
    if not v24.Progress then
        v24.Progress = 0;
    end;
    v24.ReplicatedValue = Instance.new("IntValue");
    v24.ReplicatedValue.Name = ("%*_%*"):format(v24.Name or v19.Name, (math.random(-100000, 100000)));
    v24.ReplicatedValue.Value = 0;
    v24.ReplicatedValue:SetAttribute("Title", v24.Title);
    v24.ReplicatedValue:SetAttribute("Description", v24.Description);
    v24.ReplicatedValue:SetAttribute("RequiredProgress", v24.RequiredProgress);
    v24.ReplicatedValue.Parent = game.ReplicatedStorage:FindFirstChild("ObjectiveStorage");
    v24.__completionEvent = Instance.new("BindableEvent");
    v24.__completionEvent.Parent = v24.ReplicatedValue;
    v24.Completed = v24.__completionEvent.Event;
    v24.__progressionEvent = Instance.new("BindableEvent");
    v24.__progressionEvent.Parent = v24.ReplicatedValue;
    v24.__progressionEvent.Event:Connect(function() --[[ Line: 76 ]]
        -- upvalues: v24 (copy)
        v24.Progress = math.clamp(v24.Progress + 1, 0, v24.RequiredProgress);
        v24.ReplicatedValue.Value = v24.Progress;
        if v24.Progress >= v24.RequiredProgress then
            v24.__completionEvent:Fire();
            if v24.OnCompletion then
                v24:OnCompletion();
                return;
            end;
        elseif v24.OnProgression then
            v24:OnProgression();
        end;
    end);
    v24.AddProgress = function(_, v26) --[[ Line: 94 ]] --[[ Name: AddProgress ]]
        -- upvalues: v6 (ref), v24 (copy), v8 (ref), v7 (ref)
        v6:UpdatePlayerStat(v26, "Objectives Completed", "Add", 1);
        local _ = require(game.ServerScriptService.Server.Systems.Core.RoundManager.Configuration);
        if not v24.NoStatsAdded then
            v8:AddToPlayerStat(v26, "KillerChance", 1);
            v7:IncrementActorStats(v26, {
                Action = "Doing an Objective", 
                Money = v24.CurrencyGain or 15, 
                EXP = v24.EXPGain or 40
            });
        end;
        for _, v29 in pairs(v7.CurrentActors) do
            if v29.Behavior and v29.Behavior.ObjectiveProgressed then
                v29.Behavior:ObjectiveProgressed(v29, v26, v24.Progress + 1, v24.RequiredProgress);
            end;
        end;
        v24.__progressionEvent:Fire();
    end;
    v24.RemoveTime = function(_, v31, v32) --[[ Line: 120 ]] --[[ Name: RemoveTime ]]
        -- upvalues: v5 (ref), l_RunService_0 (ref), l_TweenService_0 (ref)
        v32 = v32 or false;
        local v33 = require(game.ServerScriptService.Server.Systems.Core.RoundManager);
        if v33.CurrentSession and v33.CurrentSession.TimePast and not v33.CurrentSession.LastSurvivorAlive then
            if v32 then
                local v34 = nil;
                local v35 = tonumber(v31);
                local v36 = 0;
                local v37 = 0;
                v5:FireAllClientConnection("EnlargeRoundTimerAsync", "REMOTE_EVENT", v35);
                v34 = l_RunService_0.Heartbeat:Connect(function(v38) --[[ Line: 133 ]]
                    -- upvalues: v33 (copy), v34 (ref), v36 (ref), v35 (copy), l_TweenService_0 (ref), v37 (ref)
                    if not v33.CurrentSession then
                        v34:Disconnect();
                        return;
                    else
                        v36 = v36 + v38;
                        local v39 = math.clamp(v36 / (v35 * 0.5), 0, 1);
                        local l_l_TweenService_0_Value_0 = l_TweenService_0:GetValue(v39, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
                        local v41 = v35 * l_l_TweenService_0_Value_0;
                        local v42 = v41 - v37;
                        v37 = v41;
                        local l_CurrentSession_0 = v33.CurrentSession;
                        l_CurrentSession_0.TimePast = l_CurrentSession_0.TimePast + v42;
                        if v39 >= 1 then
                            v34:Disconnect();
                        end;
                        return;
                    end;
                end);
                return;
            else
                local l_CurrentSession_1 = v33.CurrentSession;
                l_CurrentSession_1.TimePast = l_CurrentSession_1.TimePast + (tonumber(v31) or 0);
            end;
        end;
    end;
    v24.Destroy = function(_) --[[ Line: 159 ]] --[[ Name: Destroy ]]
        -- upvalues: v24 (copy)
        v24.__progressionEvent:Destroy();
        v24.ReplicatedValue:Destroy();
    end;
    if v24.OnCreation then
        v24:OnCreation();
    end;
    return v24;
end;
v0.Start = function(_) --[[ Line: 172 ]] --[[ Name: Start ]]
    -- upvalues: v4 (copy), v3 (copy), v8 (copy)
    if v4 then
        local l_Folder_0 = Instance.new("Folder");
        l_Folder_0.Name = "ObjectiveStorage";
        l_Folder_0.Parent = game.ReplicatedStorage;
        return;
    else
        if v3 then
            local l_ObjectiveStorage_0 = game.ReplicatedStorage:WaitForChild("ObjectiveStorage");
            local l_LocalPlayer_0 = game.Players.LocalPlayer;
            local v50 = script.Objectives:Clone();
            v50.Parent = l_LocalPlayer_0.PlayerGui.MainUI;
            v8.OnPlayingStateChanged(function(v51) --[[ Line: 191 ]]
                -- upvalues: v50 (copy)
                v50.Visible = v51 ~= "Killers";
            end);
            v50:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function() --[[ Line: 196 ]]
                -- upvalues: v50 (copy)
                game.TweenService:Create(v50, TweenInfo.new(1), {
                    CanvasPosition = v50.AbsoluteCanvasSize
                }):Play();
            end);
            local function v60(v52) --[[ Line: 201 ]] --[[ Name: addObjectiveUI ]]
                -- upvalues: v50 (copy)
                local v53 = tick();
                repeat
                    task.wait();
                until v52:GetAttribute("Title") and v52:GetAttribute("Description") and v52:GetAttribute("RequiredProgress") or tick() >= v53 + 5;
                if tick() >= v53 + 5 then
                    return;
                else
                    local v54 = script.Objective:Clone();
                    v54.Name = v52.Name;
                    v54.Parent = v50;
                    v54.Size = UDim2.fromScale(1, 0);
                    v54.Title.TextTransparency = 1;
                    v54.Title.TextStrokeTransparency = 1;
                    v54.Description.TextTransparency = 1;
                    v54.Description.TextStrokeTransparency = 1;
                    game.TweenService:Create(v54, TweenInfo.new(1), {
                        Size = UDim2.fromScale(1, 0.475)
                    }):Play();
                    game.TweenService:Create(v54.Title, TweenInfo.new(1), {
                        TextTransparency = 0, 
                        TextStrokeTransparency = 0
                    }):Play();
                    game.TweenService:Create(v54.Description, TweenInfo.new(1), {
                        TextTransparency = 0, 
                        TextStrokeTransparency = 0
                    }):Play();
                    local function v59() --[[ Line: 223 ]] --[[ Name: updateObjective ]]
                        -- upvalues: v52 (copy), v54 (copy)
                        local _ = v52:GetAttribute("Title");
                        local l_v52_Attribute_1 = v52:GetAttribute("Description");
                        local l_v52_Attribute_2 = v52:GetAttribute("RequiredProgress");
                        local l_Value_0 = v52.Value;
                        v54.Title.Text = v52:GetAttribute("Title");
                        v54.Description.Text = l_v52_Attribute_1:gsub("<PROGRESS>", l_Value_0):gsub("<REQUIREMENT>", l_v52_Attribute_2);
                        if l_v52_Attribute_2 <= l_Value_0 then
                            game.TweenService:Create(v54.Title, TweenInfo.new(1), {
                                TextTransparency = 0.45, 
                                TextStrokeTransparency = 0.45
                            }):Play();
                            game.TweenService:Create(v54.Description, TweenInfo.new(1), {
                                TextTransparency = 0.45, 
                                TextStrokeTransparency = 0.45
                            }):Play();
                            game.TweenService:Create(v54, TweenInfo.new(1), {
                                Size = UDim2.fromScale(1, 0.225)
                            }):Play();
                        end;
                    end;
                    v59();
                    v52:GetPropertyChangedSignal("Value"):Connect(v59);
                    return;
                end;
            end;
            for _, v62 in pairs(l_ObjectiveStorage_0:GetChildren()) do
                v60(v62);
            end;
            l_ObjectiveStorage_0.ChildAdded:Connect(v60);
            l_ObjectiveStorage_0.ChildRemoved:Connect(function(v63) --[[ Line: 249 ]]
                -- upvalues: v50 (copy)
                local l_v50_FirstChild_0 = v50:FindFirstChild(v63.Name);
                if l_v50_FirstChild_0 then
                    game.Debris:AddItem(l_v50_FirstChild_0, 1);
                    game.TweenService:Create(l_v50_FirstChild_0, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        Size = UDim2.fromScale(1, 0)
                    }):Play();
                    game.TweenService:Create(l_v50_FirstChild_0.Title, TweenInfo.new(0.75), {
                        TextTransparency = 1, 
                        TextStrokeTransparency = 1
                    }):Play();
                    game.TweenService:Create(l_v50_FirstChild_0.Description, TweenInfo.new(0.75), {
                        TextTransparency = 1, 
                        TextStrokeTransparency = 1
                    }):Play();
                end;
            end);
        end;
        return;
    end;
end;
return v0;