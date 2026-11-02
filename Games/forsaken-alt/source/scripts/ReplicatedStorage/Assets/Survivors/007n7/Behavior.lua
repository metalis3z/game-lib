-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
local function v14(v5) --[[ Line: 9 ]] --[[ Name: getFurthestSpawn ]]
    local v6 = nil;
    local l_FirstChild_0 = workspace.Map.Ingame:FindFirstChild("SpawnPoints", true);
    local v8 = l_FirstChild_0 and l_FirstChild_0:FindFirstChild("Survivors");
    if v8 then
        local v9 = nil;
        local v10 = nil;
        for _, v12 in pairs(v8:GetChildren()) do
            local l_Magnitude_0 = (v5.Rig.PrimaryPart.Position - v12.Position).Magnitude;
            if not v9 or v10 and v10 <= l_Magnitude_0 then
                v9 = v12;
                v10 = l_Magnitude_0;
            end;
        end;
        v6 = v9;
    end;
    return v6;
end;
local v31 = {
    {
        Type = "aimless", 
        Callback = function(_, v16, _) --[[ Line: 36 ]] --[[ Name: Callback ]]
            local l_Humanoid_0 = v16:FindFirstChild("Humanoid");
            if not l_Humanoid_0 then
                return;
            else
                task.spawn(function() --[[ Line: 41 ]]
                    -- upvalues: v16 (copy), l_Humanoid_0 (copy)
                    while task.wait(math.random(2, 4)) and v16.Parent and v16.PrimaryPart do
                        l_Humanoid_0:MoveTo(v16.PrimaryPart.Position + Vector3.new(math.random(-100, 100) * 100, 0, math.random(-100, 100) * 100));
                    end;
                end);
                return;
            end;
        end
    }, 
    {
        Type = "pathfind", 
        SpawnRequired = true, 
        Callback = function(_, v20, v21) --[[ Line: 52 ]] --[[ Name: Callback ]]
            local l_Humanoid_1 = v20:FindFirstChild("Humanoid");
            if not l_Humanoid_1 then
                return;
            else
                task.spawn(function() --[[ Line: 57 ]]
                    -- upvalues: v20 (copy), l_Humanoid_1 (copy), v21 (copy)
                    local v23 = require(game.ReplicatedStorage.Modules.SimplePath).new(v20, {
                        AgentRadius = 5
                    });
                    while task.wait() and v20.Parent and v20.PrimaryPart and l_Humanoid_1.Health > 0 do
                        v23:Run(v21.Position);
                    end;
                    v23:Destroy();
                end);
                task.spawn(function() --[[ Line: 66 ]]
                    -- upvalues: v20 (copy), l_Humanoid_1 (copy)
                    local v24 = 0;
                    while v24 <= 1.5 and v20.Parent and v20.PrimaryPart and l_Humanoid_1.Health > 0 do
                        l_Humanoid_1:MoveTo((v20.PrimaryPart.CFrame * CFrame.new(0, 0, -100)).Position);
                        v24 = v24 + task.wait();
                    end;
                end);
                return;
            end;
        end
    }, 
    {
        Type = "cursor", 
        Callback = function(v25, v26, _) --[[ Line: 78 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy)
            local l_Humanoid_2 = v26:FindFirstChild("Humanoid");
            if not l_Humanoid_2 then
                return;
            else
                task.delay(1.5, function() --[[ Line: 83 ]]
                    -- upvalues: v26 (copy), v25 (copy), v2 (ref), l_Humanoid_2 (copy)
                    local v29 = tick();
                    while task.wait() and v26.Parent and v26.PrimaryPart and v25.Player.Parent do
                        local l_v2_PlayerMousePosition_0 = v2:GetPlayerMousePosition(v25.Player);
                        if l_v2_PlayerMousePosition_0 then
                            l_Humanoid_2:MoveTo(l_v2_PlayerMousePosition_0);
                            v29 = tick();
                        end;
                    end;
                end);
                return;
            end;
        end
    }
};
v0.Abilities = {
    Clone = {
        LayoutOrder = 1, 
        KeybindType = "AltAbility1", 
        Icon = "rbxassetid://83534637834767", 
        Callback = function(v32, _) --[[ Line: 103 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v31 (copy), v14 (copy), v1 (copy), v4 (copy)
            if game["Run Service"]:IsServer() then
                v32.AbilitiesDisabled = true;
                for v34 = 1, v32.Config.CloneAmount do
                    local v35 = true;
                    local v36 = v32.Rig:Clone();
                    local l_Humanoid_3 = v36.Humanoid;
                    local l_PrimaryPart_0 = v36.PrimaryPart;
                    v36:SetAttribute("Team", "Survivors");
                    v36.Parent = workspace.Map.Ingame;
                    l_Humanoid_3.WalkSpeed = v32.Config.CloneSpeed;
                    l_Humanoid_3:MoveTo((v36.PrimaryPart.CFrame * CFrame.new(0, 0, -100)).Position);
                    game.Debris:AddItem(v36, v32.Config.CloneLifetime + 1);
                    local v39 = false;
                    do
                        local l_v35_0, l_v39_0 = v35, v39;
                        task.spawn(function() --[[ Line: 124 ]]
                            -- upvalues: l_Humanoid_3 (copy), v32 (copy), v2 (ref), v36 (copy), l_v39_0 (ref)
                            local v42 = l_Humanoid_3.Health <= l_Humanoid_3.MaxHealth / 2 and "Injured" or "";
                            local v43 = {
                                Run = true, 
                                Idle = true
                            };
                            for v44, _ in pairs(v43) do
                                local v46 = v32.Config.Animations[("%*%*"):format(v42, v44)] or v32.Config.Animations[v44];
                                v43[v44] = v2:LoadAnimationFromID(v36, v46);
                                v43[v44].Looped = true;
                            end;
                            l_Humanoid_3.Running:Connect(function(v47) --[[ Line: 133 ]]
                                -- upvalues: l_v39_0 (ref), v43 (copy)
                                if v47 <= 0.05 and l_v39_0 then
                                    l_v39_0 = false;
                                    v43.Run:Stop(0.125);
                                    v43.Idle:Play(0.125);
                                    return;
                                else
                                    if v47 > 0.05 and not l_v39_0 then
                                        l_v39_0 = true;
                                        v43.Run:Play(0.125);
                                        v43.Idle:Stop(0.125);
                                    end;
                                    return;
                                end;
                            end);
                        end);
                        task.spawn(function() --[[ Line: 147 ]]
                            -- upvalues: v31 (ref), v32 (copy), v14 (ref), v36 (copy), l_Humanoid_3 (copy), l_v39_0 (ref), v1 (ref)
                            local v48 = v31[v32.PathfindType] or v31[1];
                            local v49 = v14(v32);
                            if v48.SpawnRequired and not v49 then
                                v48 = v31[1];
                            end;
                            if v48 then
                                v48.Callback(v32, v36, v49);
                            end;
                            task.spawn(function() --[[ Line: 156 ]]
                                -- upvalues: v36 (ref), l_Humanoid_3 (ref), l_v39_0 (ref), v1 (ref)
                                local v50 = 0;
                                local v51 = 0;
                                while v36.Parent and v36.PrimaryPart and l_Humanoid_3.Health > 0 do
                                    if v50 >= 0.35 and l_v39_0 then
                                        local v52 = ("footstep%*"):format(require(game.ServerStorage.ServerSystems.Miscellaneous.FootstepReplication).FootstepRenaming[l_Humanoid_3.FloorMaterial] or "Cement");
                                        if v36.PrimaryPart and v36.PrimaryPart.Parent then
                                            v1:Play(v52, {
                                                Parent = v36.PrimaryPart, 
                                                PlaybackSpeed = Random.new():NextNumber(0.9, 1.1), 
                                                Volume = 0.25
                                            });
                                        end;
                                        v51 = v51 + 1;
                                        v50 = 0;
                                    end;
                                    v50 = v50 + task.wait();
                                end;
                            end);
                        end);
                        task.delay(2, function() --[[ Line: 180 ]]
                            -- upvalues: l_PrimaryPart_0 (copy), v32 (copy), l_v35_0 (ref), l_Humanoid_3 (copy), v4 (ref)
                            if l_PrimaryPart_0 then
                                l_PrimaryPart_0.Touched:Connect(function(v53) --[[ Line: 182 ]]
                                    -- upvalues: v32 (ref), l_v35_0 (ref), l_Humanoid_3 (ref), v4 (ref)
                                    if v53.Parent == v32.Rig then
                                        l_v35_0 = false;
                                        l_Humanoid_3.Health = 0;
                                        v4:ApplyStatus(v32.Player, "Weakness", {
                                            Level = 2, 
                                            Duration = 4
                                        });
                                    end;
                                end);
                            end;
                        end);
                        task.delay(v32.Config.CloneLifetime, function() --[[ Line: 193 ]]
                            -- upvalues: l_v35_0 (ref), l_Humanoid_3 (copy)
                            l_v35_0 = false;
                            l_Humanoid_3.Health = 0;
                        end);
                        local l_Health_0 = l_Humanoid_3.Health;
                        l_Humanoid_3.HealthChanged:Connect(function(v55) --[[ Line: 200 ]]
                            -- upvalues: l_Health_0 (ref), l_v35_0 (ref), v32 (copy)
                            if v55 < l_Health_0 - 10 and l_v35_0 then
                                require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v32.Player, {
                                    Action = "Tricked the Killer", 
                                    RewardType = "Survivalist"
                                });
                            end;
                            l_Health_0 = v55;
                        end);
                        l_Humanoid_3.Died:Connect(function() --[[ Line: 213 ]]
                            -- upvalues: l_v35_0 (ref), v32 (copy)
                            if l_v35_0 then
                                require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(v32.Player, "007n7Clone");
                            end;
                        end);
                        if v34 ~= v32.Config.CloneAmount then
                            task.wait();
                        end;
                    end;
                end;
                v4:ApplyStatus(v32.Rig, "Invisibility", {
                    Level = 4, 
                    Duration = v32.Config.InvisibilityTime
                });
                v4:ApplyStatus(v32.Rig, "Undetectable", {
                    Level = 1, 
                    Duration = v32.Config.InvisibilityTime
                });
                task.delay(v32.Config.InvisibilityTime + 1, function() --[[ Line: 230 ]]
                    -- upvalues: v32 (copy)
                    v32.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then

                end;
                return;
            end;
        end
    }, 
    c00lgui = {
        LayoutOrder = 2, 
        KeybindType = "AltAbility2", 
        Icon = "rbxassetid://89910721511648", 
        Callback = function(v56, _) --[[ Line: 244 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v14 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v56.AbilitiesDisabled = true;
                v56:ChangeExpression("Concentrating");
                local v58 = v56.Config.c00lguiTemplate:Clone();
                local v59 = v58:FindFirstChild("Label", true) or {
                    Text = "idk"
                };
                v58.CFrame = CFrame.lookAt((v56.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -2.125)).Position, v56.Rig.PrimaryPart.Position + Vector3.new(0, 1.125, 0, 0));
                v59.Text = "click 2 h4x!!1!";
                local l_WeldConstraint_0 = Instance.new("WeldConstraint");
                l_WeldConstraint_0.Parent = v58;
                l_WeldConstraint_0.Part1 = v58;
                l_WeldConstraint_0.Part0 = v56.Rig.PrimaryPart;
                local l_Size_0 = v58.Size;
                v58.Anchored = false;
                v58.CanCollide = false;
                v58.Massless = true;
                v58.Size = Vector3.new();
                v58.Parent = v56.Rig;
                game.TweenService:Create(v58, TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
                    Size = l_Size_0
                }):Play();
                local v62 = v1:Play(v56.Config.Sounds.c00lguiActivated, {
                    Parent = v56.Rig.PrimaryPart
                });
                local v63 = nil;
                local l_Health_1 = v56.Rig.Humanoid.Health;
                local v65 = nil;
                v65 = v56.Rig.Humanoid.HealthChanged:Connect(function(v66) --[[ Line: 279 ]]
                    -- upvalues: l_Health_1 (ref), v63 (ref)
                    if v66 < l_Health_1 then
                        v63 = "failed";
                    end;
                    l_Health_1 = v66;
                end);
                local v67 = nil;
                v67 = v56.Rig.PrimaryPart:GetPropertyChangedSignal("Anchored"):Connect(function() --[[ Line: 287 ]]
                    -- upvalues: v63 (ref)
                    v63 = "failed";
                end);
                local v68 = nil;
                local l_SpeedMultipliers_0 = v56.Rig:FindFirstChild("SpeedMultipliers");
                if l_SpeedMultipliers_0 then
                    v68 = l_SpeedMultipliers_0.ChildAdded:Connect(function(v70) --[[ Line: 295 ]]
                        -- upvalues: v63 (ref)
                        if v70.Value <= 0 and v70.Name ~= "Emoting" then
                            v63 = "failed";
                        end;
                    end);
                end;
                task.delay(2.3, function() --[[ Line: 303 ]]
                    -- upvalues: v63 (ref), v59 (copy)
                    if not v63 then
                        v59.Text = "h4xxing in pr0gr3ss...!!1!";
                    end;
                end);
                task.delay(v56.Config.c00lguiWindupTime, function() --[[ Line: 310 ]]
                    -- upvalues: v63 (ref)
                    if not v63 then
                        v63 = "teleported";
                    end;
                end);
                task.spawn(function() --[[ Line: 317 ]]
                    -- upvalues: v63 (ref), v56 (copy), v59 (copy), v62 (copy), v58 (copy), v14 (ref), v65 (ref), v67 (ref), v68 (ref)
                    repeat
                        task.wait();
                    until v63;
                    v56:ChangeExpression("Default");
                    task.spawn(function() --[[ Line: 324 ]]
                        -- upvalues: v63 (ref), v59 (ref), v62 (ref), v58 (ref)
                        if v63 == "teleported" then
                            v59.Text = "H4XX3D!!1!1";
                        else
                            v59.Text = "o noes D:";
                            if v62 then
                                game.Debris:AddItem(v62, 1);
                                game.TweenService:Create(v62, TweenInfo.new(1), {
                                    PlaybackSpeed = 0
                                }):Play();
                            end;
                        end;
                        task.wait(1);
                        game.Debris:AddItem(v58, 0.2);
                        game.TweenService:Create(v58, TweenInfo.new(0.2), {
                            Size = Vector3.new()
                        }):Play();
                    end);
                    if v63 == "teleported" and v56 and v56.Rig and v56.Rig.Parent then
                        local v71 = v14(v56);
                        if v71 then
                            v56.Rig:SetPrimaryPartCFrame(CFrame.new(v71.Position + Vector3.new(0, 2, 0, 0)) * v56.Rig.PrimaryPart.CFrame.Rotation);
                        end;
                    end;
                    v65:Disconnect();
                    v65 = nil;
                    v67:Disconnect();
                    v67 = nil;
                    v68:Disconnect();
                    v68 = nil;
                    local l_StringValue_0 = Instance.new("StringValue");
                    l_StringValue_0.Value = tostring(v63);
                    l_StringValue_0.Name = "Result";
                    l_StringValue_0.Parent = v56.Rig;
                    game.Debris:AddItem(l_StringValue_0, 2);
                    task.delay(2, function() --[[ Line: 363 ]]
                        -- upvalues: v56 (ref)
                        v56.AbilitiesDisabled = false;
                    end);
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    if v56.Animations.c00lguiStart then
                        v56.Animations.c00lguiStart:Play();
                    end;
                    if v56.Animations.c00lguiLoop then
                        v56.Animations.c00lguiLoop:Play();
                    end;
                    local v73 = require(game.ReplicatedStorage.Modules.Network);
                    v73:FireConnection("DisableSprinting", "c00lgui", true);
                    local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v56.Rig, 0.1, "c00lgui");
                    local l_v2_ProgressBar_0 = v2:CreateProgressBar("Using c00lgui", v56.Config.c00lguiWindupTime);
                    local v76 = tick();
                    repeat
                        task.wait();
                    until v56.Rig:FindFirstChild("Result") or tick() >= v76 + v56.Config.c00lguiWindupTime + 1;
                    if v56.Animations.c00lguiStart then
                        v56.Animations.c00lguiStart:Stop();
                    end;
                    if v56.Animations.c00lguiLoop then
                        v56.Animations.c00lguiLoop:Stop();
                    end;
                    if v56.Animations.c00lguiEnd then
                        v56.Animations.c00lguiEnd:Play(0);
                    end;
                    v73:FireConnection("DisableSprinting", "c00lgui", false);
                    l_v2_SpeedMultiplier_0:Destroy();
                    l_v2_ProgressBar_0:Destroy();
                end;
                return;
            end;
        end
    }, 
    Inject = {
        LayoutOrder = 3, 
        KeybindType = "AltAbility3", 
        Icon = "rbxassetid://85844834952266", 
        Callback = function(v77, v78) --[[ Line: 405 ]] --[[ Name: Callback ]]
            -- upvalues: v31 (copy)
            if game["Run Service"]:IsServer() then
                v77.PathfindType = v77.PathfindType % #v31 + 1;
                return v77.PathfindType;
            else
                if game["Run Service"]:IsClient() then
                    local v79 = v31[v78];
                    if v79 then
                        local l_InjectUI_0 = v77.Player.PlayerGui.TemporaryUI:FindFirstChild("InjectUI");
                        if l_InjectUI_0 then
                            l_InjectUI_0:Destroy();
                        end;
                        local v81 = v77.Config.InjectTemplate:Clone();
                        v81.Label.Text = ("clone movement type: %*"):format((tostring(v79.Type)));
                        v81.Name = "InjectUI";
                        v81.Parent = v77.Player.PlayerGui.TemporaryUI;
                        game.Debris:AddItem(v81, 2);
                        game.TweenService:Create(v81, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                            BackgroundTransparency = 1
                        }):Play();
                        game.TweenService:Create(v81.Label, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                            TextTransparency = 1
                        }):Play();
                        game.TweenService:Create(v81.UIStroke, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                            Transparency = 1
                        }):Play();
                    end;
                end;
                return;
            end;
        end
    }
};
v0.Created = function(_, v83) --[[ Line: 431 ]] --[[ Name: Created ]]
    -- upvalues: v14 (copy)
    if game["Run Service"]:IsServer() then
        v83.PathfindType = 1;
        return;
    else
        if game["Run Service"]:IsClient() and v83.Player == game.Players.LocalPlayer then
            task.spawn(function() --[[ Line: 436 ]]
                -- upvalues: v83 (copy), v14 (ref)
                local v84 = v83.Config.DexTemplate:Clone();
                v84.Parent = v83.Player.PlayerGui:FindFirstChild("TemporaryUI");
                v83.Rig.Humanoid.HealthChanged:Connect(function(v85) --[[ Line: 442 ]]
                    -- upvalues: v84 (copy)
                    if v85 <= 0 then
                        v84:Destroy();
                    end;
                end);
                v83.Rig.AncestryChanged:Connect(function(_, v87) --[[ Line: 443 ]]
                    -- upvalues: v84 (copy)
                    if not v87 then
                        v84:Destroy();
                    end;
                end);
                while task.wait(0.1) and v83.Rig.Parent do
                    local v88 = v14(v83);
                    if v88 and v84.Adornee ~= v88 then
                        v84.Adornee = v88;
                    end;
                end;
            end);
        end;
        return;
    end;
end;
return v0;