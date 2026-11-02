-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.AchievementUtil);
local v5 = require(game.ReplicatedStorage.Modules.Statuses);
local function v17(v6) --[[ Line: 10 ]] --[[ Name: getFurthestSpawn ]]
    local _ = nil;
    local l_FirstChild_0 = workspace.Map.Ingame:FindFirstChild("SpawnPoints", true);
    if not l_FirstChild_0 then
        return;
    else
        local v9 = nil;
        local v10 = nil;
        for _, v12 in pairs({
            "Survivors", 
            "Killers"
        }) do
            local l_l_FirstChild_0_FirstChild_0 = l_FirstChild_0:FindFirstChild(v12);
            if l_l_FirstChild_0_FirstChild_0 then
                for _, v15 in ipairs(l_l_FirstChild_0_FirstChild_0:GetChildren()) do
                    if v15:IsA("BasePart") then
                        local l_Magnitude_0 = (v6.Rig.PrimaryPart.Position - v15.Position).Magnitude;
                        if not v9 or v10 and v10 <= l_Magnitude_0 then
                            v9 = v15;
                            v10 = l_Magnitude_0;
                        end;
                    end;
                end;
            end;
        end;
        return v9;
    end;
end;
local v34 = {
    {
        Type = "aimless", 
        Callback = function(_, v19, _) --[[ Line: 44 ]] --[[ Name: Callback ]]
            local l_Humanoid_0 = v19:FindFirstChild("Humanoid");
            if not l_Humanoid_0 then
                return;
            else
                task.spawn(function() --[[ Line: 49 ]]
                    -- upvalues: v19 (copy), l_Humanoid_0 (copy)
                    while task.wait(math.random(2, 4)) and v19.Parent and v19.PrimaryPart do
                        l_Humanoid_0:MoveTo(v19.PrimaryPart.Position + Vector3.new(math.random(-100, 100) * 100, 0, math.random(-100, 100) * 100));
                    end;
                end);
                return;
            end;
        end
    }, 
    {
        Type = "pathfind", 
        SpawnRequired = true, 
        Callback = function(v22, v23, v24) --[[ Line: 60 ]] --[[ Name: Callback ]]
            local l_Humanoid_1 = v23:FindFirstChild("Humanoid");
            if not l_Humanoid_1 then
                return;
            else
                task.spawn(function() --[[ Line: 65 ]]
                    -- upvalues: v23 (copy), l_Humanoid_1 (copy), v24 (copy)
                    local v26 = require(game.ReplicatedStorage.Modules.SimplePath).new(v23, {
                        AgentRadius = 5
                    });
                    while v23.Parent and v23.PrimaryPart and l_Humanoid_1.Health > 0 do
                        v26:Run(v24.Position);
                        task.wait(0.12);
                    end;
                    v26:Destroy();
                end);
                task.spawn(function() --[[ Line: 75 ]]
                    -- upvalues: v22 (copy), v23 (copy), l_Humanoid_1 (copy)
                    local v27 = 0;
                    while v27 <= v22.Config.CloneControlWindup and v23.Parent and v23.PrimaryPart and l_Humanoid_1.Health > 0 do
                        l_Humanoid_1:MoveTo((v23.PrimaryPart.CFrame * CFrame.new(0, 0, -100)).Position);
                        v27 = v27 + task.wait();
                    end;
                end);
                return;
            end;
        end
    }, 
    {
        Type = "cursor", 
        Callback = function(v28, v29, _) --[[ Line: 87 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy)
            local l_Humanoid_2 = v29:FindFirstChild("Humanoid");
            if not l_Humanoid_2 then
                return;
            else
                task.delay(v28.Config.CloneControlWindup, function() --[[ Line: 92 ]]
                    -- upvalues: v29 (copy), v28 (copy), v2 (ref), l_Humanoid_2 (copy)
                    local v32 = tick();
                    while task.wait() and v29.Parent and v29.PrimaryPart and v28.Player.Parent do
                        local l_v2_PlayerMousePosition_0 = v2:GetPlayerMousePosition(v28.Player);
                        if l_v2_PlayerMousePosition_0 then
                            l_Humanoid_2:MoveTo(l_v2_PlayerMousePosition_0);
                            v32 = tick();
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
        Callback = function(v35, _) --[[ Line: 112 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v34 (copy), v17 (copy), v1 (copy), v4 (copy), v5 (copy)
            if game["Run Service"]:IsServer() then
                v35.AbilitiesDisabled = true;
                for v37 = 1, v35.Config.CloneAmount do
                    local v38 = true;
                    local v39 = v35.Rig:Clone();
                    v2:AddHitboxes(v39, "Survivors");
                    local l_Humanoid_3 = v39.Humanoid;
                    local _ = v39.PrimaryPart;
                    v39:SetAttribute("Team", "Survivors");
                    v39:AddTag("SimulateSurvivor");
                    v39.Parent = workspace.Map.Ingame;
                    l_Humanoid_3.WalkSpeed = v35.Config.CloneSpeed;
                    l_Humanoid_3:MoveTo((v39.PrimaryPart.CFrame * CFrame.new(0, 0, -100)).Position);
                    game.Debris:AddItem(v39, v35.Config.CloneLifetime + 1);
                    l_Humanoid_3:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false);
                    l_Humanoid_3:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
                    l_Humanoid_3:SetStateEnabled(Enum.HumanoidStateType.Physics, false);
                    local v42 = false;
                    do
                        local l_v38_0, l_v42_0 = v38, v42;
                        task.spawn(function() --[[ Line: 140 ]]
                            -- upvalues: l_Humanoid_3 (copy), v35 (copy), v2 (ref), v39 (copy), l_v42_0 (ref)
                            local v45 = l_Humanoid_3.Health <= l_Humanoid_3.MaxHealth / 2 and "Injured" or "";
                            local v46 = {
                                Run = true, 
                                Idle = true
                            };
                            for v47, _ in pairs(v46) do
                                local v49 = v35.Config.Animations[("%*%*"):format(v45, v47)] or v35.Config.Animations[v47];
                                v46[v47] = v2:LoadAnimationFromID(v39, v49);
                                v46[v47].Looped = true;
                            end;
                            l_Humanoid_3.Running:Connect(function(v50) --[[ Line: 149 ]]
                                -- upvalues: l_v42_0 (ref), v46 (copy)
                                if v50 <= 0.05 and l_v42_0 then
                                    l_v42_0 = false;
                                    v46.Run:Stop(0.01);
                                    v46.Idle:Play(0.01);
                                    return;
                                else
                                    if v50 > 0.05 and not l_v42_0 then
                                        l_v42_0 = true;
                                        v46.Run:Play(0.01);
                                        v46.Idle:Stop(0.01);
                                    end;
                                    return;
                                end;
                            end);
                        end);
                        task.spawn(function() --[[ Line: 163 ]]
                            -- upvalues: v34 (ref), v35 (copy), v2 (ref), v39 (copy), v17 (ref), l_Humanoid_3 (copy), l_v42_0 (ref), v1 (ref)
                            local v51 = v34[v35.PathfindType] or v34[1];
                            local l_v2_ClosestPlayerFromPosition_0 = v2:GetClosestPlayerFromPosition(v35:GetPivot().Position, {
                                MaxDistance = 100, 
                                PlayerSelection = "Killers", 
                                OverrideUndetectable = true
                            });
                            local v53 = l_v2_ClosestPlayerFromPosition_0 and game.Players:GetPlayerFromCharacter(l_v2_ClosestPlayerFromPosition_0);
                            for _, v55 in ipairs(v39:GetDescendants()) do
                                if v55:IsA("BasePart") and v55:CanSetNetworkOwnership() then
                                    v55:SetNetworkOwner(v53);
                                end;
                            end;
                            local v56 = v17(v35);
                            if v51.SpawnRequired and not v56 then
                                v51 = v34[1];
                            end;
                            if v51 then
                                v51.Callback(v35, v39, v56);
                            end;
                            task.spawn(function() --[[ Line: 185 ]]
                                -- upvalues: v39 (ref), l_Humanoid_3 (ref), l_v42_0 (ref), v1 (ref)
                                local v57 = 0;
                                local v58 = 0;
                                while v39.Parent and v39.PrimaryPart and l_Humanoid_3.Health > 0 do
                                    if v57 >= 0.35 and l_v42_0 then
                                        local v59 = ("footstep%*"):format(require(game.ServerScriptService.Server.Miscellaneous.FootstepReplication).FootstepRenaming[l_Humanoid_3.FloorMaterial] or "Cement");
                                        if v39.PrimaryPart and v39.PrimaryPart.Parent then
                                            v1:Play(v59, {
                                                Parent = v39.PrimaryPart, 
                                                PlaybackSpeed = Random.new():NextNumber(0.9, 1.1), 
                                                Volume = 0.25
                                            });
                                        end;
                                        v58 = v58 + 1;
                                        v57 = 0;
                                    end;
                                    v57 = v57 + task.wait();
                                end;
                            end);
                        end);
                        v2:FixCharacter(v39, "Survivors");
                        v2:RevealPlayerAuraTo(v35.Player, v39, 600, Color3.new(1, 1, 1));
                        task.delay(v35.Config.CloneLifetime, function() --[[ Line: 227 ]]
                            -- upvalues: l_v38_0 (ref), l_Humanoid_3 (copy)
                            l_v38_0 = false;
                            l_Humanoid_3.Health = 0;
                        end);
                        local l_Health_0 = l_Humanoid_3.Health;
                        l_Humanoid_3.HealthChanged:Connect(function(v61) --[[ Line: 234 ]]
                            -- upvalues: l_Health_0 (ref), l_v38_0 (ref), v35 (copy)
                            if v61 < l_Health_0 - 10 and l_v38_0 then
                                require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v35.Player, {
                                    Action = "Tricked the Killer", 
                                    RewardType = "Survivalist"
                                });
                            end;
                            l_Health_0 = v61;
                        end);
                        l_Humanoid_3.Died:Once(function() --[[ Line: 247 ]]
                            -- upvalues: l_v38_0 (ref), v4 (ref), v35 (copy)
                            if l_v38_0 then
                                v4:IncrementAchievementProgress(v35.Player, "007n7Clone");
                            end;
                        end);
                        if v37 ~= v35.Config.CloneAmount then
                            task.wait();
                        end;
                    end;
                end;
                v5:ApplyStatus(v35.Rig, "Invisibility", {
                    Level = v35.Config.InvisibilityLevel or 4, 
                    Duration = v35.Config.InvisibilityTime
                });
                v5:ApplyStatus(v35.Rig, "Undetectable", {
                    Level = 1, 
                    Duration = v35.Config.InvisibilityTime
                });
                task.delay(v35.Config.InvisibilityTime + 1, function() --[[ Line: 263 ]]
                    -- upvalues: v35 (copy)
                    v35.AbilitiesDisabled = false;
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
        Callback = function(v62, _) --[[ Line: 277 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v17 (copy), v2 (copy), v4 (copy)
            if game["Run Service"]:IsServer() then
                v62.AbilitiesDisabled = true;
                v62:ChangeExpression("Concentrating");
                local v64 = v62.Config.c00lguiTemplate:Clone();
                local v65 = v64:FindFirstChild("Label", true) or {
                    Text = "idk"
                };
                v64.CFrame = CFrame.lookAt((v62.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -2.125)).Position, v62.Rig.PrimaryPart.Position + Vector3.new(0, 1.125, 0, 0));
                v65.Text = "click 2 h4x!!1!";
                local l_WeldConstraint_0 = Instance.new("WeldConstraint");
                l_WeldConstraint_0.Parent = v64;
                l_WeldConstraint_0.Part1 = v64;
                l_WeldConstraint_0.Part0 = v62.Rig.PrimaryPart;
                local l_Size_0 = v64.Size;
                v64.Anchored = false;
                v64.CanCollide = false;
                v64.Massless = true;
                v64.Size = Vector3.new();
                v64.Parent = v62.Rig;
                if v62.Behavior.ToggleGUI then
                    v62.Behavior:ToggleGUI(v64, true);
                else
                    game.TweenService:Create(v64, TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
                        Size = l_Size_0
                    }):Play();
                end;
                local v68 = v1:Play(v62.Config.Sounds.c00lguiActivated, {
                    Parent = v62.Rig.PrimaryPart
                });
                local v69 = nil;
                local l_Health_1 = v62.Rig.Humanoid.Health;
                local v71 = nil;
                v71 = v62.Rig.Humanoid.HealthChanged:Connect(function(v72) --[[ Line: 317 ]]
                    -- upvalues: l_Health_1 (ref), v69 (ref)
                    if v72 < l_Health_1 then
                        v69 = "failed";
                    end;
                    l_Health_1 = v72;
                end);
                local v73 = nil;
                v73 = v62.Rig.PrimaryPart:GetPropertyChangedSignal("Anchored"):Connect(function() --[[ Line: 325 ]]
                    -- upvalues: v69 (ref)
                    v69 = "failed";
                end);
                local v74 = nil;
                local l_SpeedMultipliers_0 = v62.Rig:FindFirstChild("SpeedMultipliers");
                if l_SpeedMultipliers_0 then
                    v74 = l_SpeedMultipliers_0.ChildAdded:Connect(function(v76) --[[ Line: 333 ]]
                        -- upvalues: v69 (ref)
                        if v76.Value <= 0 and v76.Name ~= "Emoting" then
                            v69 = "failed";
                        end;
                    end);
                end;
                task.delay(2.3, function() --[[ Line: 341 ]]
                    -- upvalues: v69 (ref), v65 (copy)
                    if not v69 then
                        v65.Text = "h4xxing in pr0gr3ss...!!1!";
                    end;
                end);
                task.delay(v62.Config.c00lguiWindupTime, function() --[[ Line: 348 ]]
                    -- upvalues: v69 (ref)
                    if not v69 then
                        v69 = "teleported";
                    end;
                end);
                task.spawn(function() --[[ Line: 355 ]]
                    -- upvalues: v69 (ref), v62 (copy), v65 (copy), v68 (copy), v64 (copy), v17 (ref), v2 (ref), v4 (ref), v71 (ref), v73 (ref), v74 (ref)
                    repeat
                        task.wait();
                    until v69;
                    v62:ChangeExpression("Default");
                    task.spawn(function() --[[ Line: 362 ]]
                        -- upvalues: v69 (ref), v65 (ref), v68 (ref), v62 (ref), v64 (ref)
                        if v69 == "teleported" then
                            v65.Text = "H4XX3D!!1!1";
                        else
                            v65.Text = "o noes D:";
                            if v68 then
                                game.Debris:AddItem(v68, 1);
                                game.TweenService:Create(v68, TweenInfo.new(1), {
                                    PlaybackSpeed = 0
                                }):Play();
                            end;
                        end;
                        task.wait(1);
                        if v62.Behavior.ToggleGUI then
                            v62.Behavior:ToggleGUI(v64, false);
                            return;
                        else
                            game.Debris:AddItem(v64, 0.2);
                            game.TweenService:Create(v64, TweenInfo.new(0.2), {
                                Size = Vector3.new()
                            }):Play();
                            return;
                        end;
                    end);
                    if v69 == "teleported" and v62 and v62.Rig and v62.Rig.Parent then
                        local v77 = v17(v62);
                        if v77 then
                            local v78 = CFrame.new(v77.Position + Vector3.new(0, 2, 0, 0)) * v62.Rig.PrimaryPart.CFrame.Rotation;
                            for _, v80 in ipairs(workspace.Players.Killers:GetChildren()) do
                                if v2:IsAlive(v80) then
                                    local l_Magnitude_1 = (v80.PrimaryPart.Position - v78.Position).Magnitude;
                                    if (v80.PrimaryPart.Position - v62.Rig.PrimaryPart.Position).Magnitude < 12 then
                                        v4:IncrementAchievementProgress(v62.Player, "007n7Close");
                                    end;
                                    if l_Magnitude_1 < 8 then
                                        v4:IncrementAchievementProgress(v62.Player, "007n7Oops");
                                    end;
                                end;
                            end;
                            v62:PivotTo(v78);
                        end;
                    end;
                    v71:Disconnect();
                    v71 = nil;
                    v73:Disconnect();
                    v73 = nil;
                    v74:Disconnect();
                    v74 = nil;
                    local l_StringValue_0 = Instance.new("StringValue");
                    l_StringValue_0.Value = tostring(v69);
                    l_StringValue_0.Name = "Result";
                    l_StringValue_0.Parent = v62.Rig;
                    game.Debris:AddItem(l_StringValue_0, 2);
                    task.delay(2, function() --[[ Line: 423 ]]
                        -- upvalues: v62 (ref)
                        v62.AbilitiesDisabled = false;
                    end);
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    if v62.Animations.c00lguiStart then
                        v62.Animations.c00lguiStart:Play();
                    end;
                    if v62.Animations.c00lguiLoop then
                        v62.Animations.c00lguiLoop:Play();
                    end;
                    local v83 = require(game.ReplicatedStorage.Modules.Network);
                    v83:FireConnection("DisableSprinting", "c00lgui", true);
                    local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v62.Rig, 0.1, "c00lgui");
                    local l_v2_ProgressBar_0 = v2:CreateProgressBar("Using c00lgui", v62.Config.c00lguiWindupTime);
                    local v86 = tick();
                    repeat
                        task.wait();
                    until v62.Rig:FindFirstChild("Result") or tick() >= v86 + v62.Config.c00lguiWindupTime + 1;
                    if v62.Animations.c00lguiStart then
                        v62.Animations.c00lguiStart:Stop();
                    end;
                    if v62.Animations.c00lguiLoop then
                        v62.Animations.c00lguiLoop:Stop();
                    end;
                    if v62.Animations.c00lguiEnd then
                        v62.Animations.c00lguiEnd:Play(0);
                    end;
                    v83:FireConnection("DisableSprinting", "c00lgui", false);
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
        Callback = function(v87, v88) --[[ Line: 465 ]] --[[ Name: Callback ]]
            -- upvalues: v34 (copy)
            if game["Run Service"]:IsServer() then
                v87.PathfindType = v87.PathfindType % #v34 + 1;
                return v87.PathfindType;
            else
                if game["Run Service"]:IsClient() then
                    local v89 = v34[v88];
                    if v89 then
                        local l_InjectUI_0 = v87.Player.PlayerGui.TemporaryUI:FindFirstChild("InjectUI");
                        if l_InjectUI_0 then
                            l_InjectUI_0:Destroy();
                        end;
                        local v91 = v87.Config.InjectTemplate:Clone();
                        v91.Label.Text = ("clone movement type: %*"):format((tostring(v89.Type)));
                        v91.Name = "InjectUI";
                        v91.Parent = v87.Player.PlayerGui.TemporaryUI;
                        game.Debris:AddItem(v91, 2);
                        game.TweenService:Create(v91, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                            BackgroundTransparency = 1
                        }):Play();
                        game.TweenService:Create(v91.Label, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                            TextTransparency = 1
                        }):Play();
                        game.TweenService:Create(v91.UIStroke, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                            Transparency = 1
                        }):Play();
                    end;
                end;
                return;
            end;
        end
    }
};
v0.Created = function(_, v93) --[[ Line: 491 ]] --[[ Name: Created ]]
    -- upvalues: v17 (copy)
    if game["Run Service"]:IsServer() then
        v93.PathfindType = 1;
        return;
    else
        if game["Run Service"]:IsClient() and v93.Player == game.Players.LocalPlayer then
            task.spawn(function() --[[ Line: 496 ]]
                -- upvalues: v93 (copy), v17 (ref)
                local v94 = v93.Config.DexTemplate:Clone();
                v94.Parent = v93.Player.PlayerGui:FindFirstChild("TemporaryUI");
                v93.Rig.Humanoid.HealthChanged:Connect(function(v95) --[[ Line: 502 ]]
                    -- upvalues: v94 (copy)
                    if v95 <= 0 then
                        v94:Destroy();
                    end;
                end);
                v93.Rig.AncestryChanged:Connect(function(_, v97) --[[ Line: 503 ]]
                    -- upvalues: v94 (copy)
                    if not v97 then
                        v94:Destroy();
                    end;
                end);
                while task.wait(0.1) and v93.Rig.Parent do
                    local v98 = v17(v93);
                    if v98 and v94.Adornee ~= v98 then
                        v94.Adornee = v98;
                    end;
                end;
            end);
        end;
        return;
    end;
end;
return v0;