-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
local l_RunService_0 = game:GetService("RunService");
local v2 = l_RunService_0:IsClient();
local v3 = l_RunService_0:IsServer();
local _ = require(game.ReplicatedStorage.Modules.Network);
local v5 = require(game.ReplicatedStorage.Modules.Stats);
local v6 = require(game.ReplicatedStorage.Modules.Actors);
local v7 = require(game.ReplicatedStorage.Modules.Util);
v0.InitializeObjectives = function(_, v9, v10) --[[ Line: 17 ]] --[[ Name: InitializeObjectives ]]
	warn(v9, v10)
    -- upvalues: v0 (copy)
    local v11 = v9 and v9:GetChildren();
	if v11 then
		warn(v11)
        table.sort(v11, function(v12, v13) --[[ Line: 21 ]]
            return require(v12).Order < require(v13).Order;
        end);
        task.spawn(function() --[[ Line: 24 ]]
            -- upvalues: v11 (copy), v0 (ref), v10 (copy)
			for _, v15 in pairs(v11) do
				warn(v15)
                local l_v0_Objective_0 = v0:CreateObjective(v15, v10);
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
v0.CreateObjective = function(_, v18, v19) --[[ Line: 41 ]] --[[ Name: CreateObjective ]]
    -- upvalues: v7 (copy), v5 (copy), v6 (copy)
    local v20 = require(v18);
    if v20.CommonObjective then
        local l_FirstChild_0 = game.ReplicatedStorage.Modules.CommonObjectives:FindFirstChild(v20.CommonObjective);
        if l_FirstChild_0 then
            local v22 = require(l_FirstChild_0);
            v20 = v7:MergeTables(v7:CopyTable(v22), v7:CopyTable(v20));
            v20.__index = v20;
        end;
    end;
    local v23 = setmetatable(v19 or {}, v20);
    if not v23.Progress then
        v23.Progress = 0;
    end;
    v23.ReplicatedValue = Instance.new("IntValue");
    v23.ReplicatedValue.Name = ("%*_%*"):format(v23.Name or v18.Name, (math.random(-100000, 100000)));
    v23.ReplicatedValue.Value = 0;
    v23.ReplicatedValue:SetAttribute("Title", v23.Title);
    v23.ReplicatedValue:SetAttribute("Description", v23.Description);
    v23.ReplicatedValue:SetAttribute("RequiredProgress", v23.RequiredProgress);
    v23.ReplicatedValue.Parent = game.ReplicatedStorage:FindFirstChild("ObjectiveStorage");
    v23.__completionEvent = Instance.new("BindableEvent");
    v23.__completionEvent.Parent = v23.ReplicatedValue;
    v23.Completed = v23.__completionEvent.Event;
    v23.__progressionEvent = Instance.new("BindableEvent");
    v23.__progressionEvent.Parent = v23.ReplicatedValue;
    v23.__progressionEvent.Event:Connect(function() --[[ Line: 75 ]]
        -- upvalues: v23 (copy)
        v23.Progress = math.clamp(v23.Progress + 1, 0, v23.RequiredProgress);
        v23.ReplicatedValue.Value = v23.Progress;
        if v23.Progress >= v23.RequiredProgress then
            v23.__completionEvent:Fire();
            if v23.OnCompletion then
                v23:OnCompletion();
                return;
            end;
        elseif v23.OnProgression then
            v23:OnProgression();
        end;
    end);
    v23.AddProgress = function(_, v25) --[[ Line: 93 ]] --[[ Name: AddProgress ]]
        -- upvalues: v5 (ref), v23 (copy), v7 (ref), v6 (ref)
        v5:UpdatePlayerStat(v25, "Objectives Completed", "Add", 1);
        local _ = require(game.ServerStorage.ServerSystems.RoundManager.Configuration);
        if not v23.NoStatsAdded then
            v7:AddToPlayerStat(v25, "KillerChance", 1);
            v6:IncrementActorStats(v25, {
                Action = "Doing an Objective", 
                Money = v23.CurrencyGain or 15, 
                EXP = v23.EXPGain or 40
            });
        end;
        for _, v28 in pairs(v6.CurrentActors) do
            if v28.Behavior and v28.Behavior.ObjectiveProgressed then
                v28.Behavior:ObjectiveProgressed(v28, v25, v23.Progress + 1, v23.RequiredProgress);
            end;
        end;
        v23.__progressionEvent:Fire();
    end;
    v23.RemoveTime = function(_, v30) --[[ Line: 119 ]] --[[ Name: RemoveTime ]]
        local v31 = require(game.ServerStorage.ServerSystems.RoundManager);
        if v31.CurrentSession and v31.CurrentSession.TimePast and not v31.CurrentSession.LastSurvivorAlive then
            local l_CurrentSession_0 = v31.CurrentSession;
            l_CurrentSession_0.TimePast = l_CurrentSession_0.TimePast + (tonumber(v30) or 0);
        end;
    end;
    v23.Destroy = function(_) --[[ Line: 125 ]] --[[ Name: Destroy ]]
        -- upvalues: v23 (copy)
        v23.__progressionEvent:Destroy();
        v23.ReplicatedValue:Destroy();
    end;
    if v23.OnCreation then
        v23:OnCreation();
    end;
    return v23;
end;
v0.Start = function(_) --[[ Line: 138 ]] --[[ Name: Start ]]
    -- upvalues: v3 (copy), v2 (copy), v7 (copy)
    if v3 then
        local l_Folder_0 = Instance.new("Folder");
        l_Folder_0.Name = "ObjectiveStorage";
        l_Folder_0.Parent = game.ReplicatedStorage;
        return;
    else
        if v2 then
            local l_ObjectiveStorage_0 = game.ReplicatedStorage:WaitForChild("ObjectiveStorage");
            local l_LocalPlayer_0 = game.Players.LocalPlayer;
            local v38 = script.Objectives:Clone();
            v38.Parent = l_LocalPlayer_0.PlayerGui.MainUI;
            v7.OnPlayingStateChanged(function(v39) --[[ Line: 157 ]]
                -- upvalues: v38 (copy)
                v38.Visible = v39 ~= "Killers";
            end);
            v38:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function() --[[ Line: 162 ]]
                -- upvalues: v38 (copy)
                game.TweenService:Create(v38, TweenInfo.new(1), {
                    CanvasPosition = v38.AbsoluteCanvasSize
                }):Play();
            end);
            local function v48(v40) --[[ Line: 167 ]] --[[ Name: addObjectiveUI ]]
                -- upvalues: v38 (copy)
                local v41 = tick();
                repeat
                    task.wait();
                until v40:GetAttribute("Title") and v40:GetAttribute("Description") and v40:GetAttribute("RequiredProgress") or tick() >= v41 + 5;
                if tick() >= v41 + 5 then
                    return;
                else
                    local v42 = script.Objective:Clone();
                    v42.Name = v40.Name;
                    v42.Parent = v38;
                    v42.Size = UDim2.fromScale(1, 0);
                    v42.Title.TextTransparency = 1;
                    v42.Title.TextStrokeTransparency = 1;
                    v42.Description.TextTransparency = 1;
                    v42.Description.TextStrokeTransparency = 1;
                    game.TweenService:Create(v42, TweenInfo.new(1), {
                        Size = UDim2.fromScale(1, 0.475)
                    }):Play();
                    game.TweenService:Create(v42.Title, TweenInfo.new(1), {
                        TextTransparency = 0, 
                        TextStrokeTransparency = 0
                    }):Play();
                    game.TweenService:Create(v42.Description, TweenInfo.new(1), {
                        TextTransparency = 0, 
                        TextStrokeTransparency = 0
                    }):Play();
                    local function v47() --[[ Line: 189 ]] --[[ Name: updateObjective ]]
                        -- upvalues: v40 (copy), v42 (copy)
                        local _ = v40:GetAttribute("Title");
                        local l_v40_Attribute_1 = v40:GetAttribute("Description");
                        local l_v40_Attribute_2 = v40:GetAttribute("RequiredProgress");
                        local l_Value_0 = v40.Value;
                        v42.Title.Text = v40:GetAttribute("Title");
                        v42.Description.Text = l_v40_Attribute_1:gsub("<PROGRESS>", l_Value_0):gsub("<REQUIREMENT>", l_v40_Attribute_2);
                        if l_v40_Attribute_2 <= l_Value_0 then
                            game.TweenService:Create(v42.Title, TweenInfo.new(1), {
                                TextTransparency = 0.45, 
                                TextStrokeTransparency = 0.45
                            }):Play();
                            game.TweenService:Create(v42.Description, TweenInfo.new(1), {
                                TextTransparency = 0.45, 
                                TextStrokeTransparency = 0.45
                            }):Play();
                            game.TweenService:Create(v42, TweenInfo.new(1), {
                                Size = UDim2.fromScale(1, 0.225)
                            }):Play();
                        end;
                    end;
                    v47();
                    v40:GetPropertyChangedSignal("Value"):Connect(v47);
                    return;
                end;
            end;
            for _, v50 in pairs(l_ObjectiveStorage_0:GetChildren()) do
                v48(v50);
            end;
            l_ObjectiveStorage_0.ChildAdded:Connect(v48);
            l_ObjectiveStorage_0.ChildRemoved:Connect(function(v51) --[[ Line: 215 ]]
                -- upvalues: v38 (copy)
                local l_v38_FirstChild_0 = v38:FindFirstChild(v51.Name);
                if l_v38_FirstChild_0 then
                    game.Debris:AddItem(l_v38_FirstChild_0, 1);
                    game.TweenService:Create(l_v38_FirstChild_0, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        Size = UDim2.fromScale(1, 0)
                    }):Play();
                    game.TweenService:Create(l_v38_FirstChild_0.Title, TweenInfo.new(0.75), {
                        TextTransparency = 1, 
                        TextStrokeTransparency = 1
                    }):Play();
                    game.TweenService:Create(l_v38_FirstChild_0.Description, TweenInfo.new(0.75), {
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