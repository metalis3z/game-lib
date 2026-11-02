-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
local v5 = require(game.ReplicatedStorage.Modules.Network);
local v6 = require(game.ReplicatedStorage.Modules.AchievementUtil);
v0.Abilities = {
    Slash = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "MainAbility", 
        Callback = function(v7) --[[ Line: 16 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v7.AbilitiesDisabled = true;
                v1:Play(v7.Config.Sounds.Swing, {
                    Parent = v7.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.35
                });
                task.delay(0.4, function() --[[ Line: 23 ]]
                    -- upvalues: v3 (ref), v7 (copy), v2 (ref), v1 (ref)
                    local _ = v3:CreateHitbox(v7.Player, {
                        Size = Vector3.new(4.5, 6, 16, 0), 
                        CFrameOffset = CFrame.new(0, 0, -6), 
                        Damage = v7.Config.SlashDamage, 
                        Time = 0.2, 
                        Knockback = 2, 
                        HitMultiple = false, 
                        ExecuteOnKill = true, 
                        Connections = {
                            Hit = function(v8, v9) --[[ Line: 35 ]] --[[ Name: Hit ]]
                                -- upvalues: v2 (ref), v1 (ref), v7 (ref)
                                v2:CreateSpeedMultiplier(v8, 1.5, "HitSpeedBonus", 1.25);
                                if v9 then
                                    v1:Play(v7.Config.Sounds.Hit, {
                                        Parent = v7.Rig.PrimaryPart, 
                                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                        Volume = 0.5
                                    });
                                end;
                            end
                        }
                    });
                end);
                task.delay(0.75, function() --[[ Line: 46 ]]
                    -- upvalues: v7 (copy)
                    v7.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v7.Animations.Slash:Play(0.025);
                end;
                return;
            end;
        end
    }, 
    CorruptEnergy = {
        LayoutOrder = 2, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "AltAbility1", 
        Callback = function(v11) --[[ Line: 62 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v6 (copy), v2 (copy), v4 (copy)
            if game["Run Service"]:IsServer() then
                v11.AbilitiesDisabled = true;
                v1:Play(v11.Config.Sounds.CorruptEnergy, {
                    Parent = v11.Rig.PrimaryPart, 
                    Volume = 0.4, 
                    TimePosition = 0.09
                });
                local v12 = RaycastParams.new();
                v12.FilterDescendantsInstances = {
                    workspace.Players
                };
                v12.FilterType = Enum.RaycastFilterType.Exclude;
                task.delay(2.366, function() --[[ Line: 74 ]]
                    -- upvalues: v11 (copy), v12 (copy), v1 (ref), v3 (ref), v6 (ref), v2 (ref), v4 (ref)
                    for v13 = 0, v11.Config.SpikeAmount do
                        task.delay(v13 * v11.Config.DelayBetweenSpikeSummons, function() --[[ Line: 76 ]]
                            -- upvalues: v11 (ref), v13 (copy), v12 (ref), v1 (ref), v3 (ref), v6 (ref), v2 (ref), v4 (ref)
                            if not v11.Rig.PrimaryPart then
                                return;
                            else
                                local l_Position_0 = (v11.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -v11.Config.DistanceBetweenSpikes * (v13 + 1))).Position;
                                local v15 = workspace:Raycast(l_Position_0, Vector3.new(0, -100, 0, 0), v12) or workspace:Raycast(l_Position_0, Vector3.new(0, 100, 0, 0), v12);
                                if v15 and v15.Position then
                                    local v16 = v11.Config.Spike:Clone();
                                    local _, v18 = v16:GetBoundingBox();
                                    v16.Parent = workspace.Map.Ingame;
                                    v16:SetPrimaryPartCFrame(CFrame.new(v15.Position) * CFrame.Angles(3.141592653589793, math.rad((math.random(0, 360))), 0) - Vector3.new(0, v18.Y, 0));
                                    game.TweenService:Create(v16.PrimaryPart, TweenInfo.new(0.1), {
                                        CFrame = v16.PrimaryPart.CFrame + Vector3.new(0, v18.Y, 0)
                                    }):Play();
                                    v1:Play(v11.Config.Sounds.CorruptEnergySummon, {
                                        Parent = v16.PrimaryPart, 
                                        PlaybackSpeed = Random.new():NextNumber(0.8, 1.2), 
                                        Volume = 0.25, 
                                        TimePosition = 0.02
                                    });
                                    for _, v20 in pairs(v16:GetDescendants()) do
                                        if v20:IsA("ParticleEmitter") and v20.Name == "Number" then
                                            v20.Color = ColorSequence.new({
                                                ColorSequenceKeypoint.new(0, v11.Config.SpikeNumbersColor), 
                                                ColorSequenceKeypoint.new(1, v11.Config.SpikeNumbersColor)
                                            });
                                        end;
                                    end;
                                    task.delay(v11.Config.SpikeLifetime, function() --[[ Line: 97 ]]
                                        -- upvalues: v16 (copy), v18 (copy), v1 (ref), v11 (ref)
                                        game.Debris:AddItem(v16, 2.5);
                                        if v16.PrimaryPart then
                                            game.TweenService:Create(v16.PrimaryPart, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                                CFrame = v16.PrimaryPart.CFrame - Vector3.new(0, v18.Y * 2, 0)
                                            }):Play();
                                            v1:Play(v11.Config.Sounds.CorruptEnergyDesummon, {
                                                Parent = v16.PrimaryPart, 
                                                PlaybackSpeed = Random.new():NextNumber(0.9, 1.1), 
                                                Volume = 0.1, 
                                                TimePosition = 0.02
                                            });
                                        end;
                                    end);
                                    local _ = v3:CreateHitbox(v11.Player, {
                                        Size = v18, 
                                        CFrame = function() --[[ Line: 108 ]] --[[ Name: CFrame ]]
                                            -- upvalues: v16 (copy), v18 (copy)
                                            return v16.PrimaryPart.CFrame + Vector3.new(0, v18.Y / 2, 0);
                                        end, 
                                        Damage = v11.Config.CorruptEnergyDamage, 
                                        Time = 0.15, 
                                        Knockback = 5, 
                                        HitMultiple = true, 
                                        PredictVelocity = false, 
                                        Connections = {
                                            Hit = function(v21, v22) --[[ Line: 117 ]] --[[ Name: Hit ]]
                                                -- upvalues: v6 (ref), v11 (ref), v2 (ref), v4 (ref), v1 (ref)
                                                if v21.Humanoid.Health <= 0 then
                                                    v6:IncrementAchievementProgress(v11.Player, "JohnDoeSpikes");
                                                else
                                                    v2:CreateSpeedMultiplier(v21, 1.5, "HitSpeedBonus", 1.25);
                                                    v4:ApplyStatus(v11.Rig, "Speed", {
                                                        Duration = 5, 
                                                        Level = 1
                                                    });
                                                end;
                                                if v22 then
                                                    v1:Play(v11.Config.Sounds.Hit, {
                                                        Parent = v11.Rig.PrimaryPart, 
                                                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                                        Volume = 0.25
                                                    });
                                                end;
                                            end
                                        }
                                    });
                                end;
                                return;
                            end;
                        end);
                    end;
                end);
                task.delay(4.5, function() --[[ Line: 136 ]]
                    -- upvalues: v11 (copy)
                    v11.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v11.Animations.CorruptEnergy:Play(0.025);
                    local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v11.Player, 0.001, "DigitalFootprint");
                    game.Debris:AddItem(l_v2_SpeedMultiplier_0, 4);
                    local v25 = {
                        1.283, 
                        2.366
                    };
                    local v26 = 0;
                    local v27 = 0;
                    do
                        local l_v26_0, l_v27_0 = v26, v27;
                        task.spawn(function() --[[ Line: 154 ]]
                            -- upvalues: v11 (copy), v25 (copy), l_v27_0 (ref), l_v26_0 (ref), v2 (ref)
                            while v11 and v11.Rig.Parent and v25[1] do
                                l_v27_0 = l_v27_0 + game["Run Service"].Heartbeat:Wait();
                                for v30 = #v25, 1, -1 do
                                    if v25[v30] and l_v27_0 >= v25[v30] then
                                        table.remove(v25, v30);
                                        l_v26_0 = l_v26_0 + 1;
                                        v2:ApplyCameraShake(l_v26_0 * 0.2, l_v26_0 * 0.35);
                                    end;
                                end;
                            end;
                        end);
                    end;
                end;
                return;
            end;
        end
    }, 
    DigitalFootprint = {
        LayoutOrder = 3, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "AltAbility2", 
        Callback = function(v31) --[[ Line: 178 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v2 (copy), v4 (copy)
            local v32 = {
                0.416, 
                1.466, 
                2.833
            };
            local v33 = 0;
            local v34 = 0;
            if game["Run Service"]:IsServer() then
                v31.AbilitiesDisabled = true;
                v1:Play(v31.Config.Sounds.DigitalFootprint, {
                    Parent = v31.Rig.PrimaryPart, 
                    Volume = 0.4, 
                    TimePosition = 0.09
                });
                local function v38(v35) --[[ Line: 190 ]] --[[ Name: removeShadow ]]
                    if v35 and v35.Parent then
                        v35.Name = "okByeBye";
                        game.Debris:AddItem(v35, 5);
                        for _, v37 in pairs(v35:GetDescendants()) do
                            if v37:IsA("ParticleEmitter") then
                                v37.Enabled = false;
                            end;
                        end;
                    end;
                end;
                local l_FirstChild_0 = workspace.Map.Ingame:FindFirstChild((("%*Shadows"):format((tostring(v31.Player)))));
                if not l_FirstChild_0 then
                    l_FirstChild_0 = Instance.new("Folder");
                    l_FirstChild_0.Name = ("%*Shadows"):format((tostring(v31.Player)));
                    l_FirstChild_0.Parent = workspace.Map.Ingame;
                end;
                local l_l_FirstChild_0_Children_0 = l_FirstChild_0:GetChildren();
                if #l_l_FirstChild_0_Children_0 == 2 then
                    v38(l_l_FirstChild_0_Children_0[1]);
                end;
                local v41 = v31.Config.Shadow:Clone();
                v41.Size = Vector3.new(1, 0, 0, 0);
                v41.Parent = l_FirstChild_0;
                v1:Play(v31.Config.Sounds.DigitalFootprintAmbience, {
                    Parent = v41, 
                    RollOffMaxDistance = 30
                });
                local v42 = RaycastParams.new();
                v42.FilterDescendantsInstances = {
                    workspace.Players, 
                    v41
                };
                v42.FilterType = Enum.RaycastFilterType.Exclude;
                task.delay(v31.Config.DigitalFootprintLifetime, function() --[[ Line: 233 ]]
                    -- upvalues: v38 (copy), v41 (copy)
                    v38(v41);
                end);
                v41.Touched:Connect(function(v43) --[[ Line: 238 ]]
                    -- upvalues: v41 (copy), v38 (copy), v2 (ref), v31 (copy), v4 (ref)
                    local l_Parent_0 = v43.Parent;
                    local l_Humanoid_0 = l_Parent_0:FindFirstChild("Humanoid");
                    if l_Humanoid_0 and l_Humanoid_0.Health > 0 and tostring(l_Parent_0.Parent) ~= "Killers" and v41.Name == "Shadow" then
                        v38(v41);
                        v2:RevealPlayerAuraTo(v31.Rig, l_Parent_0, 15);
                        v2:RevealPlayerAuraTo(l_Parent_0, v31.Rig, 15);
                        v4:ApplyStatus(v31.Rig, "Speed", {
                            Level = 2, 
                            Duration = 15
                        });
                        v4:ApplyStatus(l_Parent_0, "Slowness", {
                            Level = 1, 
                            Duration = 15
                        });
                    end;
                end);
                task.spawn(function() --[[ Line: 256 ]]
                    -- upvalues: v33 (ref), v41 (copy), v34 (ref), v32 (copy), v31 (copy), v42 (copy)
                    while v33 ~= 3 and v41.Parent and v41.Name == "Shadow" do
                        v34 = v34 + game["Run Service"].Heartbeat:Wait();
                        for v46 = #v32, 1, -1 do
                            if v32[v46] and v34 >= v32[v46] then
                                table.remove(v32, v46);
                                v33 = v33 + 1;
                                local l_Position_1 = (v31.Rig.PrimaryPart.CFrame * CFrame.new(-1.5, 0, -2)).Position;
                                local v48 = workspace:Raycast(l_Position_1, Vector3.new(0, -100, 0, 0), v42);
                                v41.Position = (v48 and v48.Position or v31.Rig.PrimaryPart.Position - Vector3.new(0, 2.5, 0, 0)) + Vector3.new(0, 0.5, 0, 0);
                                game.TweenService:Create(v41, TweenInfo.new(1), {
                                    Size = Vector3.new(1, v33 * 6, v33 * 6)
                                }):Play();
                                for _, v50 in pairs(v41:GetDescendants()) do
                                    if v50:IsA("ParticleEmitter") then
                                        v50.Enabled = v50.Name == ("ShadowPuddle%*"):format(v33);
                                    end;
                                end;
                            end;
                        end;
                    end;
                end);
                task.delay(5, function() --[[ Line: 283 ]]
                    -- upvalues: v31 (copy)
                    v31.AbilitiesDisabled = false;
                end);
            elseif game["Run Service"]:IsClient() then
                v31.Animations.DigitalFootprint:Play(0.025);
                local l_v2_SpeedMultiplier_1 = v2:CreateSpeedMultiplier(v31.Player, 0, "DigitalFootprint");
                game.Debris:AddItem(l_v2_SpeedMultiplier_1, 4.5);
                task.spawn(function() --[[ Line: 296 ]]
                    -- upvalues: v31 (copy), v32 (copy), v34 (ref), v33 (ref), v2 (ref)
                    while v31 and v31.Rig.Parent and v32[1] do
                        v34 = v34 + game["Run Service"].Heartbeat:Wait();
                        for v52 = #v32, 1, -1 do
                            if v32[v52] and v34 >= v32[v52] then
                                table.remove(v32, v52);
                                v33 = v33 + 1;
                                v2:ApplyCameraShake(v33 * 0.2, v33 * 0.375);
                            end;
                        end;
                    end;
                end);
            end;
        end
    }, 
    ["404Error"] = {
        LayoutOrder = 4, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "AltAbility3", 
        Callback = function(v53) --[[ Line: 320 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v2 (copy), v5 (copy)
            if game["Run Service"]:IsServer() then
                v53.AbilitiesDisabled = true;
                v1:Play(v53.Config.Sounds["404Error"], {
                    Parent = v53.Rig.PrimaryPart, 
                    Volume = 0.4, 
                    TimePosition = 0.09
                });
                task.delay(2, function() --[[ Line: 327 ]]
                    -- upvalues: v53 (copy)
                    v53.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    local l_v2_SpeedMultiplier_2 = v2:CreateSpeedMultiplier(v53.Player, 1, "404Error");
                    local l_v2_FOVMultiplier_0 = v2:CreateFOVMultiplier(v53.Player, 1, "404Error");
                    game.TweenService:Create(l_v2_SpeedMultiplier_2, TweenInfo.new(0.5), {
                        Value = 0.25
                    }):Play();
                    game.TweenService:Create(l_v2_FOVMultiplier_0, TweenInfo.new(1.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true), {
                        Value = 0.75
                    }):Play();
                    v5:FireConnection("DisableSprinting", "404Error", true);
                    task.delay(1.5, function() --[[ Line: 342 ]]
                        -- upvalues: v2 (ref), v53 (copy), v1 (ref), v5 (ref), l_v2_SpeedMultiplier_2 (copy), l_v2_FOVMultiplier_0 (copy)
                        for _, v57 in pairs(workspace.Players.Survivors:GetChildren()) do
                            v2:RevealPlayerAura(v57, v53.Config["404ErrorAuraRevealTime"]);
                        end;
                        v1:Play(v53.Config.Sounds["404ErrorError"], {
                            Parent = v53.Rig.PrimaryPart, 
                            Volume = 0.4, 
                            TimePosition = 0.09, 
                            PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
                        });
                        v5:FireConnection("DisableSprinting", "404Error", false);
                        game.TweenService:Create(l_v2_SpeedMultiplier_2, TweenInfo.new(0.6), {
                            Value = 1
                        }):Play();
                        game.Debris:AddItem(l_v2_SpeedMultiplier_2, 0.6);
                        game.Debris:AddItem(l_v2_FOVMultiplier_0, 1.2);
                    end);
                end;
                return;
            end;
        end
    }
};
v0.Created = function(_, v59) --[[ Line: 365 ]] --[[ Name: Created ]]
    -- upvalues: v6 (copy), v4 (copy)
    if game["Run Service"]:IsServer() then
        if workspace:GetAttribute("JohnDoeSpecialDay") then
            v6:IncrementAchievementProgress(v59.Player, "JohnDoeSpecialDay");
        end;
        local l_Folder_0 = Instance.new("Folder");
        l_Folder_0.Name = "JohnDoeTrail";
        l_Folder_0.Parent = v59.Rig;
        for _ = 1, math.clamp(math.round(v59.Config.TrailLength / 4), 2, 1e999) do
            local v62 = v59.Config.Trail:Clone();
            v62.Position = v59.Rig.PrimaryPart.Position - Vector3.new(0, 4.5, 0, 0);
            v62.Parent = l_Folder_0;
            v62:SetAttribute("FinishedUpdating", true);
            v62.Touched:Connect(function(v63) --[[ Line: 387 ]]
                -- upvalues: v4 (ref)
                local l_Parent_1 = v63.Parent;
                local l_Humanoid_1 = l_Parent_1:FindFirstChild("Humanoid");
                if l_Humanoid_1 and l_Humanoid_1.Health > 0 and tostring(l_Parent_1.Parent) ~= "Killers" then
                    v4:ApplyStatus(l_Parent_1, "Corrupted", {
                        Duration = 3, 
                        Level = 2
                    });
                end;
            end);
        end;
        local l_l_Folder_0_Children_0 = l_Folder_0:GetChildren();
        local v67 = 0;
        local v68 = 0;
        local v69 = nil;
        do
            local l_v67_0, l_v68_0, l_v69_0 = v67, v68, v69;
            l_v69_0 = game["Run Service"].Heartbeat:Connect(function(v73) --[[ Line: 402 ]]
                -- upvalues: v59 (copy), l_Folder_0 (copy), l_v69_0 (ref), l_v68_0 (ref), l_l_Folder_0_Children_0 (copy), l_v67_0 (ref)
                if not v59 or not v59.Rig.Parent or not v59.Rig.PrimaryPart then
                    l_Folder_0:Destroy();
                    l_v69_0:Disconnect();
                    l_v69_0 = nil;
                    return;
                elseif l_v68_0 <= 0.05 then
                    l_v68_0 = l_v68_0 + v73;
                    return;
                else
                    l_v68_0 = 0;
                    local v74 = l_l_Folder_0_Children_0[l_v67_0 % #l_l_Folder_0_Children_0 + 1];
                    local v75 = l_l_Folder_0_Children_0[(l_v67_0 - 1) % #l_l_Folder_0_Children_0 + 1];
                    if v74 and v75 then
                        if v74.Size.Z <= 4 or v74:GetAttribute("FinishedUpdating") then
                            if v74:GetAttribute("FinishedUpdating") then
                                v74:SetAttribute("FinishedUpdating", nil);
                            end;
                            local v76 = v59.Rig.PrimaryPart.Position - Vector3.new(0, 3, 0, 0);
                            v74.CFrame = CFrame.new(v75:GetPivot().Position) * CFrame.lookAt(v75:GetPivot().Position, v76).Rotation * CFrame.Angles(0, 0, 0);
                            v74.Size = Vector3.new(v74.Size.X, v74.Size.Y, (v74.Position - v76).Magnitude);
                            v74.PivotOffset = CFrame.new(0, 0, -v74.Size.Z / 2);
                            v74.CFrame = v74.CFrame * v74.PivotOffset;
                            return;
                        else
                            v74:SetAttribute("FinishedUpdating", true);
                            l_v67_0 = l_v67_0 + 1;
                            return;
                        end;
                    else
                        l_v67_0 = l_v67_0 + 1;
                        return;
                    end;
                end;
            end);
        end;
    end;
end;
v0.OnExecution = function(_, v78, v79) --[[ Line: 443 ]] --[[ Name: OnExecution ]]
    -- upvalues: v5 (copy)
    local v80 = (v78.Rig.PrimaryPart.CFrame.LookVector + Vector3.new(0, 0.5, 0, 0)) * 40;
    local v81 = workspace:GetServerTimeNow() + 2;
    v5:FireAllClientConnection("Ragdoll", "REMOTE_EVENT", v79, v81, (("%*|%*|%*"):format(v80.X, v80.Y, v80.Z)));
    task.delay(0.666, function() --[[ Line: 452 ]]
        -- upvalues: v79 (copy)
        local l_Humanoid_2 = v79:FindFirstChild("Humanoid");
        if l_Humanoid_2 then
            l_Humanoid_2.BreakJointsOnDeath = false;
            l_Humanoid_2.Health = 0;
        end;
    end);
end;
return v0;