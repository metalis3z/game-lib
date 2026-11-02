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
        Icon = "rbxassetid://92362553672440", 
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
                        Size = Vector3.new(4.5, 6, 7.5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1.25), 
                        Damage = v7.Config.SlashDamage, 
                        Time = 0.25, 
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
        Icon = "rbxassetid://83849304758564", 
        KeybindType = "AltAbility1", 
        Callback = function(v11) --[[ Line: 62 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v6 (copy), v2 (copy), v4 (copy)
            if game["Run Service"]:IsServer() then
                v11.AbilitiesDisabled = true;
                v1:Play(v11.Config.Sounds.CorruptEnergy, {
                    Parent = v11.Rig.PrimaryPart, 
                    Volume = 0.4, 
                    TimePosition = 0.09, 
                    PlaybackSpeed = 1.2
                });
                local v12 = RaycastParams.new();
                v12.FilterDescendantsInstances = {
                    workspace.Players
                };
                v12.FilterType = Enum.RaycastFilterType.Exclude;
                local v13 = false;
                local v14 = {};
                task.delay(2, function() --[[ Line: 76 ]]
                    -- upvalues: v11 (copy), v13 (ref), v12 (copy), v1 (ref), v3 (ref), v6 (ref), v2 (ref), v4 (ref), v14 (copy)
                    for v15 = 1, v11.Config.SpikeAmount do
                        task.delay(v15 * v11.Config.DelayBetweenSpikeSummons, function() --[[ Line: 78 ]]
                            -- upvalues: v13 (ref), v11 (ref), v15 (copy), v12 (ref), v1 (ref), v3 (ref), v6 (ref), v2 (ref), v4 (ref), v14 (ref)
                            if v13 then
                                return;
                            elseif not v11.Rig.PrimaryPart then
                                return;
                            elseif v11.Rig:GetAttribute("Stunned") then
                                v13 = true;
                                return;
                            else
                                local l_Position_0 = (v11.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -v11.Config.DistanceBetweenSpikes * (v15 + 1))).Position;
                                local v17 = workspace:Raycast(l_Position_0, Vector3.new(0, -100, 0, 0), v12) or workspace:Raycast(l_Position_0, Vector3.new(0, 100, 0, 0), v12);
                                if v17 and v17.Position then
                                    local v18 = v11.Config.Spike:Clone();
                                    local _, v20 = v18:GetBoundingBox();
                                    v18.Parent = workspace.Map.Ingame;
                                    v18:SetPrimaryPartCFrame(CFrame.new(v17.Position) * CFrame.Angles(3.141592653589793, math.rad((math.random(0, 360))), 0) - Vector3.new(0, v20.Y, 0));
                                    game.TweenService:Create(v18.PrimaryPart, TweenInfo.new(0.1), {
                                        CFrame = v18.PrimaryPart.CFrame + Vector3.new(0, v20.Y, 0)
                                    }):Play();
                                    v1:Play(v11.Config.Sounds.CorruptEnergySummon, {
                                        Parent = v18.PrimaryPart, 
                                        PlaybackSpeed = Random.new():NextNumber(0.8, 1.2), 
                                        Volume = 0.25, 
                                        TimePosition = 0.02
                                    });
                                    for _, v22 in pairs(v18:GetDescendants()) do
                                        if v22:IsA("ParticleEmitter") and v22.Name == "Number" then
                                            v22.Color = ColorSequence.new({
                                                ColorSequenceKeypoint.new(0, v11.Config.SpikeNumbersColor), 
                                                ColorSequenceKeypoint.new(1, v11.Config.SpikeNumbersColor)
                                            });
                                        end;
                                    end;
                                    task.delay(v11.Config.SpikeLifetime, function() --[[ Line: 101 ]]
                                        -- upvalues: v18 (copy), v20 (copy), v1 (ref), v11 (ref)
                                        game.Debris:AddItem(v18, 2.5);
                                        if v18.PrimaryPart then
                                            game.TweenService:Create(v18.PrimaryPart, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                                CFrame = v18.PrimaryPart.CFrame - Vector3.new(0, v20.Y * 2, 0)
                                            }):Play();
                                            v1:Play(v11.Config.Sounds.CorruptEnergyDesummon, {
                                                Parent = v18.PrimaryPart, 
                                                PlaybackSpeed = Random.new():NextNumber(0.9, 1.1), 
                                                Volume = 0.1, 
                                                TimePosition = 0.02
                                            });
                                        end;
                                    end);
                                    local _ = v3:CreateHitbox(v11.Player, {
                                        Size = v20, 
                                        CFrame = function() --[[ Line: 112 ]] --[[ Name: CFrame ]]
                                            -- upvalues: v18 (copy), v20 (copy)
                                            return v18.PrimaryPart.CFrame + Vector3.new(0, v20.Y / 2, 0);
                                        end, 
                                        Damage = v11.Config.CorruptEnergyDamage, 
                                        Time = 0.15, 
                                        Knockback = 5, 
                                        HitMultiple = true, 
                                        PredictVelocity = false, 
                                        Connections = {
                                            Hit = function(v23, v24) --[[ Line: 121 ]] --[[ Name: Hit ]]
                                                -- upvalues: v6 (ref), v11 (ref), v2 (ref), v4 (ref), v14 (ref), v1 (ref)
                                                if v23.Humanoid.Health <= 0 then
                                                    v6:IncrementAchievementProgress(v11.Player, "JohnDoeSpikes");
                                                    if tostring(v23.Parent) == "Survivors" then
                                                        require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v11.Player, {
                                                            Action = "Killed a Survivor with Corrupt Energy", 
                                                            RewardType = "DifficultKillerAction"
                                                        });
                                                    end;
                                                else
                                                    v2:CreateSpeedMultiplier(v23, 1.5, "HitSpeedBonus", 1.25);
                                                    v4:ApplyStatus(v11.Rig, "Speed", {
                                                        Duration = 7, 
                                                        Level = 1
                                                    });
                                                    if not v14[v23] then
                                                        v14[v23] = 1;
                                                    else
                                                        local l_v14_0 = v14;
                                                        l_v14_0[v23] = l_v14_0[v23] + 1;
                                                        if v14[v23] >= v11.Config.SpikeHitCap then
                                                            v23:SetAttribute("Invincible", true);
                                                            task.delay(1, function() --[[ Line: 146 ]]
                                                                -- upvalues: v23 (copy)
                                                                v23:SetAttribute("Invincible", false);
                                                            end);
                                                        end;
                                                    end;
                                                    if tostring(v23.Parent) == "Survivors" then
                                                        require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v11.Player, {
                                                            Action = "Damaged a Survivor with Corrupt Energy", 
                                                            RewardType = "EasyKillerAction"
                                                        });
                                                    end;
                                                end;
                                                if v24 then
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
                task.delay(3.5, function() --[[ Line: 175 ]]
                    -- upvalues: v11 (copy)
                    v11.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v11.Animations.CorruptEnergy:Play(0.025);
                    local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v11.Player, 0.001, "CorruptEnergy");
                    game.Debris:AddItem(l_v2_SpeedMultiplier_0, 4);
                    local v28 = {
                        1.067, 
                        1.917
                    };
                    local v29 = 0;
                    local v30 = 0;
                    do
                        local l_v29_0, l_v30_0 = v29, v30;
                        task.spawn(function() --[[ Line: 193 ]]
                            -- upvalues: v11 (copy), v28 (copy), l_v30_0 (ref), l_v29_0 (ref), v2 (ref)
                            while v11 and v11.Rig.Parent and v28[1] do
                                l_v30_0 = l_v30_0 + game["Run Service"].Heartbeat:Wait();
                                for v33 = #v28, 1, -1 do
                                    if v28[v33] and l_v30_0 >= v28[v33] then
                                        table.remove(v28, v33);
                                        l_v29_0 = l_v29_0 + 1;
                                        v2:ApplyCameraShake(l_v29_0 * 0.2, l_v29_0 * 0.35);
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
        Icon = "rbxassetid://83206360003394", 
        KeybindType = "AltAbility2", 
        Callback = function(v34) --[[ Line: 217 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v2 (copy), v4 (copy)
            local v35 = {
                0.317, 
                1.05, 
                2.067
            };
            local v36 = 0;
            local v37 = 0;
            if game["Run Service"]:IsServer() then
                v34.AbilitiesDisabled = true;
                v1:Play(v34.Config.Sounds.DigitalFootprint, {
                    Parent = v34.Rig.PrimaryPart, 
                    Volume = 0.4, 
                    TimePosition = 0.09, 
                    PlaybackSpeed = 1.2
                });
                local function v42(v38) --[[ Line: 229 ]] --[[ Name: removeShadow ]]
                    if v38 and v38.Parent then
                        v38.Name = "okByeBye";
                        game.Debris:AddItem(v38, 5);
                        local l_ShadowAmbience_0 = v38:FindFirstChild("ShadowAmbience");
                        if l_ShadowAmbience_0 then
                            game.TweenService:Create(l_ShadowAmbience_0, TweenInfo.new(2), {
                                Volume = 0
                            }):Play();
                        end;
                        for _, v41 in pairs(v38:GetDescendants()) do
                            if v41:IsA("ParticleEmitter") then
                                v41.Enabled = false;
                            end;
                        end;
                    end;
                end;
                local l_FirstChild_0 = workspace.Map.Ingame:FindFirstChild((("%*Shadows"):format((tostring(v34.Player)))));
                if not l_FirstChild_0 then
                    l_FirstChild_0 = Instance.new("Folder");
                    l_FirstChild_0.Name = ("%*Shadows"):format((tostring(v34.Player)));
                    l_FirstChild_0.Parent = workspace.Map.Ingame;
                end;
                local l_l_FirstChild_0_Children_0 = l_FirstChild_0:GetChildren();
                if #l_l_FirstChild_0_Children_0 == v34.Config.DigitalFootprintLimit then
                    v42(l_l_FirstChild_0_Children_0[1]);
                end;
                local v45 = v34.Config.Shadow:Clone();
                v45.Size = Vector3.new(1, 0, 0, 0);
                v45.Parent = l_FirstChild_0;
                v1:Play(v34.Config.Sounds.DigitalFootprintAmbience, {
                    Parent = v45, 
                    Name = "ShadowAmbience", 
                    RollOffMaxDistance = 30, 
                    Looped = true
                });
                local v46 = RaycastParams.new();
                v46.FilterDescendantsInstances = {
                    workspace.Players, 
                    v45
                };
                v46.FilterType = Enum.RaycastFilterType.Exclude;
                task.delay(v34.Config.DigitalFootprintLifetime, function() --[[ Line: 276 ]]
                    -- upvalues: v42 (copy), v45 (copy)
                    v42(v45);
                end);
                task.delay(tonumber(v35[#v35]) or 2.55, function() --[[ Line: 281 ]]
                    -- upvalues: v45 (copy), v42 (copy), v2 (ref), v34 (copy), v4 (ref)
                    v45.Touched:Connect(function(v47) --[[ Line: 282 ]]
                        -- upvalues: v45 (ref), v42 (ref), v2 (ref), v34 (ref), v4 (ref)
                        local l_Parent_0 = v47.Parent;
                        local l_Humanoid_0 = l_Parent_0:FindFirstChild("Humanoid");
                        if l_Humanoid_0 and l_Humanoid_0.Health > 0 and tostring(l_Parent_0.Parent) ~= "Killers" and v45.Name == "Shadow" and not l_Parent_0:GetAttribute("ExecutionsDisabled") then
                            v42(v45);
                            v2:RevealPlayerAuraTo(v34.Rig, l_Parent_0, 10);
                            v2:RevealPlayerAuraTo(l_Parent_0, v34.Rig, 10);
                            v4:ApplyStatus(v34.Rig, "Speed", {
                                Level = 1, 
                                Duration = 10
                            });
                            v4:ApplyStatus(l_Parent_0, "Slowness", {
                                Level = 2, 
                                Duration = 10
                            });
                            v4:ApplyStatus(l_Parent_0, "Corrupted", {
                                Level = 1, 
                                Duration = 10
                            });
                            if tostring(l_Parent_0.Parent) == "Survivors" then
                                require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v34.Player, {
                                    Action = "Survivor stepped into a Digital Footprint trap", 
                                    RewardType = "RegularKillerAction"
                                });
                            end;
                        end;
                    end);
                end);
                task.spawn(function() --[[ Line: 311 ]]
                    -- upvalues: v36 (ref), v45 (copy), v37 (ref), v35 (copy), v34 (copy), v46 (copy)
                    while v36 ~= 3 and v45.Parent and v45.Name == "Shadow" do
                        v37 = v37 + game["Run Service"].Heartbeat:Wait();
                        for v50 = #v35, 1, -1 do
                            if v35[v50] and v37 >= v35[v50] then
                                table.remove(v35, v50);
                                v36 = v36 + 1;
                                local l_Position_1 = (v34.Rig.PrimaryPart.CFrame * CFrame.new(-1.1, 0, -2)).Position;
                                local v52 = workspace:Raycast(l_Position_1, Vector3.new(0, -100, 0, 0), v46);
                                v45.Position = (v52 and v52.Position or v34.Rig.PrimaryPart.Position - Vector3.new(0, 2.5, 0, 0)) + Vector3.new(0, 0.5, 0, 0);
                                game.TweenService:Create(v45, TweenInfo.new(1), {
                                    Size = Vector3.new(1, v36 * 6, v36 * 6)
                                }):Play();
                                for _, v54 in pairs(v45:GetDescendants()) do
                                    if v54:IsA("ParticleEmitter") then
                                        v54.Enabled = v54.Name == ("ShadowPuddle%*"):format(v36);
                                    end;
                                end;
                            end;
                        end;
                    end;
                end);
                task.delay(4.5, function() --[[ Line: 338 ]]
                    -- upvalues: v34 (copy)
                    v34.AbilitiesDisabled = false;
                end);
            elseif game["Run Service"]:IsClient() then
                v34.Animations.DigitalFootprint:Play(0.025);
                local l_v2_SpeedMultiplier_1 = v2:CreateSpeedMultiplier(v34.Player, 0, "DigitalFootprint");
                game.Debris:AddItem(l_v2_SpeedMultiplier_1, 3);
                task.spawn(function() --[[ Line: 351 ]]
                    -- upvalues: v34 (copy), v35 (copy), v37 (ref), v36 (ref), v2 (ref)
                    while v34 and v34.Rig.Parent and v35[1] do
                        v37 = v37 + game["Run Service"].Heartbeat:Wait();
                        for v56 = #v35, 1, -1 do
                            if v35[v56] and v37 >= v35[v56] then
                                table.remove(v35, v56);
                                v36 = v36 + 1;
                                v2:ApplyCameraShake(v36 * 0.2, v36 * 0.375);
                            end;
                        end;
                    end;
                end);
            end;
        end
    }, 
    ["404Error"] = {
        LayoutOrder = 4, 
        Icon = "rbxassetid://131116145215571", 
        KeybindType = "AltAbility3", 
        Callback = function(v57) --[[ Line: 375 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v2 (copy), v5 (copy)
            if game["Run Service"]:IsServer() then
                v57.AbilitiesDisabled = true;
                v1:Play(v57.Config.Sounds["404Error"], {
                    Parent = v57.Rig.PrimaryPart, 
                    Volume = 0.4, 
                    TimePosition = 0.09, 
                    RollOffMaxDistance = 200, 
                    PlaybackSpeed = 1.15
                });
                task.delay(1.625, function() --[[ Line: 382 ]]
                    -- upvalues: v57 (copy)
                    v57.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    local l_v2_SpeedMultiplier_2 = v2:CreateSpeedMultiplier(v57.Player, 1, "404Error");
                    local l_v2_FOVMultiplier_0 = v2:CreateFOVMultiplier(v57.Player, 1, "404Error");
                    game.TweenService:Create(l_v2_SpeedMultiplier_2, TweenInfo.new(0.5), {
                        Value = 0.25
                    }):Play();
                    game.TweenService:Create(l_v2_FOVMultiplier_0, TweenInfo.new(1.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true), {
                        Value = 0.75
                    }):Play();
                    v5:FireConnection("DisableSprinting", "404Error", true);
                    task.delay(1.2, function() --[[ Line: 397 ]]
                        -- upvalues: v2 (ref), v57 (copy), v1 (ref), v5 (ref), l_v2_SpeedMultiplier_2 (copy), l_v2_FOVMultiplier_0 (copy)
                        for _, v61 in pairs(workspace.Players.Survivors:GetChildren()) do
                            v2:RevealPlayerAura(v61, v57.Config["404ErrorAuraRevealTime"]);
                        end;
                        v1:Play(v57.Config.Sounds["404ErrorError"], {
                            Parent = v57.Rig.PrimaryPart, 
                            Volume = 0.4, 
                            TimePosition = 0.09, 
                            PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
                        });
                        v5:FireConnection("DisableSprinting", "404Error", false);
                        game.TweenService:Create(l_v2_SpeedMultiplier_2, TweenInfo.new(0.6), {
                            Value = 1
                        }):Play();
                        game.Debris:AddItem(l_v2_SpeedMultiplier_2, 0.4);
                        game.Debris:AddItem(l_v2_FOVMultiplier_0, 1);
                    end);
                end;
                return;
            end;
        end
    }
};
v0.Created = function(_, v63) --[[ Line: 420 ]] --[[ Name: Created ]]
    -- upvalues: v6 (copy), v4 (copy)
    if game["Run Service"]:IsServer() then
        if workspace:GetAttribute("JohnDoeSpecialDay") then
            v6:IncrementAchievementProgress(v63.Player, "JohnDoeSpecialDay");
        end;
        local l_Folder_0 = Instance.new("Folder");
        l_Folder_0.Name = "JohnDoeTrail";
        l_Folder_0.Parent = v63.Rig;
        for _ = 1, math.clamp(math.round(v63.Config.TrailLength / 4), 2, 1e999) do
            local v66 = v63.Config.Trail:Clone();
            v66.Position = v63.Rig.PrimaryPart.Position - Vector3.new(0, 4.5, 0, 0);
            v66.Parent = l_Folder_0;
            v66:SetAttribute("FinishedUpdating", true);
            v66.Touched:Connect(function(v67) --[[ Line: 442 ]]
                -- upvalues: v4 (ref)
                local l_Parent_1 = v67.Parent;
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
        local v71 = 0;
        local v72 = 0;
        local v73 = nil;
        do
            local l_v71_0, l_v72_0, l_v73_0 = v71, v72, v73;
            l_v73_0 = game["Run Service"].Heartbeat:Connect(function(v77) --[[ Line: 457 ]]
                -- upvalues: v63 (copy), l_Folder_0 (copy), l_v73_0 (ref), l_v72_0 (ref), l_l_Folder_0_Children_0 (copy), l_v71_0 (ref)
                if not v63 or not v63.Rig.Parent or not v63.Rig.PrimaryPart then
                    l_Folder_0:Destroy();
                    l_v73_0:Disconnect();
                    l_v73_0 = nil;
                    return;
                elseif l_v72_0 <= 0.05 then
                    l_v72_0 = l_v72_0 + v77;
                    return;
                else
                    l_v72_0 = 0;
                    local v78 = l_l_Folder_0_Children_0[l_v71_0 % #l_l_Folder_0_Children_0 + 1];
                    local v79 = l_l_Folder_0_Children_0[(l_v71_0 - 1) % #l_l_Folder_0_Children_0 + 1];
                    if v78 and v79 then
                        if v78.Size.Z <= 4 or v78:GetAttribute("FinishedUpdating") then
                            if v78:GetAttribute("FinishedUpdating") then
                                v78:SetAttribute("FinishedUpdating", nil);
                            end;
                            local v80 = v63.Rig.PrimaryPart.Position - Vector3.new(0, 3, 0, 0);
                            v78.CFrame = CFrame.new(v79:GetPivot().Position) * CFrame.lookAt(v79:GetPivot().Position, v80).Rotation * CFrame.Angles(0, 0, 0);
                            v78.Size = Vector3.new(v78.Size.X, v78.Size.Y, (v78.Position - v80).Magnitude);
                            v78.PivotOffset = CFrame.new(0, 0, -v78.Size.Z / 2);
                            v78.CFrame = v78.CFrame * v78.PivotOffset;
                            return;
                        else
                            v78:SetAttribute("FinishedUpdating", true);
                            l_v71_0 = l_v71_0 + 1;
                            return;
                        end;
                    else
                        l_v71_0 = l_v71_0 + 1;
                        return;
                    end;
                end;
            end);
        end;
    end;
end;
v0.OnIntroduction = function(_, v82, v83, v84) --[[ Line: 499 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v2 (copy)
    local l_Clouds_0 = Instance.new("Clouds");
    l_Clouds_0.Cover = 0.774;
    l_Clouds_0.Density = 1;
    l_Clouds_0.Color = Color3.fromRGB(25, 25, 25);
    l_Clouds_0.Parent = workspace:FindFirstChild("Terrain");
    game.Debris:AddItem(l_Clouds_0, v84);
    local v86 = script.IntroScreen:Clone();
    v86.Main.Title.Text = v82.Config.IntroText:gsub("PLAYERNAME", v82.Player.DisplayName);
    v86.Parent = game.Players.LocalPlayer.PlayerGui;
    game.Debris:AddItem(v86, 1.93333);
    game.TweenService:Create(v86.Main.Title, TweenInfo.new(0.83), {
        TextTransparency = 0
    }):Play();
    task.delay(0.83, function() --[[ Line: 514 ]]
        -- upvalues: v86 (copy)
        game.TweenService:Create(v86.Main.Title, TweenInfo.new(0.583), {
            TextColor3 = Color3.new(1, 0, 0)
        }):Play();
    end);
    task.delay(1, function() --[[ Line: 519 ]]
        -- upvalues: v83 (copy)
        local l_JohnDoeTrail_0 = v83:FindFirstChild("JohnDoeTrail");
        if l_JohnDoeTrail_0 then
            l_JohnDoeTrail_0:Destroy();
        end;
    end);
    local v88 = require(game.ReplicatedStorage.Modules.Schematics.Lighting);
    v88:SetCustomLighting(v82.Config.IntroLighting);
    task.delay(2.717, function() --[[ Line: 529 ]]
        -- upvalues: l_Clouds_0 (copy)
        l_Clouds_0.Color = Color3.fromRGB(25, 0, 0);
        local l_AtmosphereDoe_0 = game.Lighting:FindFirstChild("AtmosphereDoe");
        if l_AtmosphereDoe_0 then
            game.TweenService:Create(l_AtmosphereDoe_0, TweenInfo.new(0.2829, Enum.EasingStyle.Linear), {
                Color = Color3.fromRGB(144, 0, 0), 
                Decay = Color3.fromRGB(255, 0, 0), 
                Density = 1
            }):Play();
        end;
    end);
    local l_v2_FOVMultiplier_1 = v2:CreateFOVMultiplier(game.Players.LocalPlayer, 0.35, "JohnDoeIntroScene");
    task.delay(2.75, function() --[[ Line: 539 ]]
        -- upvalues: l_v2_FOVMultiplier_1 (copy)
        game.TweenService:Create(l_v2_FOVMultiplier_1, TweenInfo.new(0.25), {
            Value = 0.95
        }):Play();
    end);
    task.delay(v84, function() --[[ Line: 544 ]]
        -- upvalues: v88 (copy), l_v2_FOVMultiplier_1 (copy), v86 (copy), l_Clouds_0 (copy)
        v88:SetAsCurrentLighting();
        l_v2_FOVMultiplier_1:Destroy();
        v86:Destroy();
        l_Clouds_0:Destroy();
    end);
end;
v0.OnExecution = function(_, v92, v93) --[[ Line: 552 ]] --[[ Name: OnExecution ]]
    -- upvalues: v5 (copy)
    local v94 = (v92.Rig.PrimaryPart.CFrame.LookVector + Vector3.new(0, 0.5, 0, 0)) * 40;
    local v95 = workspace:GetServerTimeNow() + 2;
    v5:FireAllClientConnection("Ragdoll", "REMOTE_EVENT", v93, v95, (("%*|%*|%*"):format(v94.X, v94.Y, v94.Z)));
    task.delay(0.666, function() --[[ Line: 561 ]]
        -- upvalues: v93 (copy)
        local l_Humanoid_2 = v93:FindFirstChild("Humanoid");
        if l_Humanoid_2 then
            l_Humanoid_2.BreakJointsOnDeath = false;
            l_Humanoid_2.Health = 0;
        end;
    end);
end;
return v0;