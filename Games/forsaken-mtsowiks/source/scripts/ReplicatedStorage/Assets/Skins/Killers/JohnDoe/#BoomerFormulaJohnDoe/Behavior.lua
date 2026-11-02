-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:07:58 2025 ]]
local v0 = {};
local l_TweenService_0 = game:GetService("TweenService");
local l_Players_0 = game:GetService("Players");
local v3 = require(game.ReplicatedStorage.Modules.Sounds);
local v4 = require(game.ReplicatedStorage.Modules.Util);
local v5 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v6 = require(game.ReplicatedStorage.Modules.Statuses);
local v7 = require(game.ReplicatedStorage.Modules.Network);
local v8 = require(game.ReplicatedStorage.Modules.AchievementUtil);
v0.Abilities = {
    Slash = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "MainAbility", 
        Callback = function(v9) --[[ Line: 19 ]] --[[ Name: Callback ]]
            -- upvalues: v3 (copy), v5 (copy), v4 (copy)
            if game["Run Service"]:IsServer() then
                v9.AbilitiesDisabled = true;
                v3:Play(v9.Config.Sounds.Swing, {
                    Parent = v9.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.35
                });
                task.delay(0.4, function() --[[ Line: 26 ]]
                    -- upvalues: v5 (ref), v9 (copy), v4 (ref), v3 (ref)
                    local _ = v5:CreateHitbox(v9.Player, {
                        Size = Vector3.new(4.5, 6, 7.5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1.25), 
                        Damage = v9.Config.SlashDamage, 
                        Time = 0.2, 
                        Knockback = 2, 
                        HitMultiple = false, 
                        ExecuteOnKill = true, 
                        Connections = {
                            Hit = function(v10, v11) --[[ Line: 38 ]] --[[ Name: Hit ]]
                                -- upvalues: v4 (ref), v3 (ref), v9 (ref)
                                v4:CreateSpeedMultiplier(v10, 1.5, "HitSpeedBonus", 1.25);
                                if v11 then
                                    v3:Play(v9.Config.Sounds.Hit, {
                                        Parent = v9.Rig.PrimaryPart, 
                                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                        Volume = 0.5
                                    });
                                end;
                            end
                        }
                    });
                end);
                task.delay(0.75, function() --[[ Line: 49 ]]
                    -- upvalues: v9 (copy)
                    v9.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v9.Animations.Slash:Play(0.025);
                end;
                return;
            end;
        end
    }, 
    CorruptEnergy = {
        LayoutOrder = 2, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "AltAbility1", 
        Callback = function(v13) --[[ Line: 65 ]] --[[ Name: Callback ]]
            -- upvalues: v3 (copy), v5 (copy), v8 (copy), v4 (copy), v6 (copy)
            if game["Run Service"]:IsServer() then
                v13.AbilitiesDisabled = true;
                v3:Play(v13.Config.Sounds.CorruptEnergy, {
                    Parent = v13.Rig.PrimaryPart, 
                    Volume = 0.4, 
                    TimePosition = 0.09
                });
                local v14 = RaycastParams.new();
                v14.FilterDescendantsInstances = {
                    workspace.Players
                };
                v14.FilterType = Enum.RaycastFilterType.Exclude;
                local v15 = false;
                task.delay(2.366, function() --[[ Line: 78 ]]
                    -- upvalues: v13 (copy), v15 (ref), v14 (copy), v3 (ref), v5 (ref), v8 (ref), v4 (ref), v6 (ref)
                    for v16 = 0, v13.Config.SpikeAmount do
                        task.delay(v16 * v13.Config.DelayBetweenSpikeSummons, function() --[[ Line: 80 ]]
                            -- upvalues: v15 (ref), v13 (ref), v16 (copy), v14 (ref), v3 (ref), v5 (ref), v8 (ref), v4 (ref), v6 (ref)
                            if v15 then
                                return;
                            elseif not v13.Rig.PrimaryPart then
                                return;
                            elseif v13.Rig:GetAttribute("Stunned") then
                                v15 = true;
                                return;
                            else
                                local l_Position_0 = (v13.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -v13.Config.DistanceBetweenSpikes * (v16 + 1))).Position;
                                local v18 = workspace:Raycast(l_Position_0, Vector3.new(0, -100, 0, 0), v14) or workspace:Raycast(l_Position_0, Vector3.new(0, 100, 0, 0), v14);
                                if v18 and v18.Position then
                                    local v19 = v13.Config.Spike:Clone();
                                    local _, v21 = v19:GetBoundingBox();
                                    v19.Parent = workspace.Map.Ingame;
                                    v19:SetPrimaryPartCFrame(CFrame.new(v18.Position) * CFrame.Angles(3.141592653589793, math.rad((math.random(0, 360))), 0) - Vector3.new(0, v21.Y, 0));
                                    game.TweenService:Create(v19.PrimaryPart, TweenInfo.new(0.1), {
                                        CFrame = v19.PrimaryPart.CFrame + Vector3.new(0, v21.Y, 0)
                                    }):Play();
                                    v3:Play(v13.Config.Sounds.CorruptEnergySummon, {
                                        Parent = v19.PrimaryPart, 
                                        PlaybackSpeed = Random.new():NextNumber(0.8, 1.2), 
                                        Volume = 0.25, 
                                        TimePosition = 0.02
                                    });
                                    for _, v23 in pairs(v19:GetDescendants()) do
                                        if v23:IsA("ParticleEmitter") and v23.Name == "Number" then
                                            v23.Color = ColorSequence.new({
                                                ColorSequenceKeypoint.new(0, v13.Config.SpikeNumbersColor), 
                                                ColorSequenceKeypoint.new(1, v13.Config.SpikeNumbersColor)
                                            });
                                        end;
                                    end;
                                    task.delay(v13.Config.SpikeLifetime, function() --[[ Line: 103 ]]
                                        -- upvalues: v19 (copy), v21 (copy), v3 (ref), v13 (ref)
                                        game.Debris:AddItem(v19, 2.5);
                                        if v19.PrimaryPart then
                                            game.TweenService:Create(v19.PrimaryPart, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                                CFrame = v19.PrimaryPart.CFrame - Vector3.new(0, v21.Y * 2, 0)
                                            }):Play();
                                            v3:Play(v13.Config.Sounds.CorruptEnergyDesummon, {
                                                Parent = v19.PrimaryPart, 
                                                PlaybackSpeed = Random.new():NextNumber(0.9, 1.1), 
                                                Volume = 0.1, 
                                                TimePosition = 0.02
                                            });
                                        end;
                                    end);
                                    local _ = v5:CreateHitbox(v13.Player, {
                                        Size = v21, 
                                        CFrame = function() --[[ Line: 114 ]] --[[ Name: CFrame ]]
                                            -- upvalues: v19 (copy), v21 (copy)
                                            return v19.PrimaryPart.CFrame + Vector3.new(0, v21.Y / 2, 0);
                                        end, 
                                        Damage = v13.Config.CorruptEnergyDamage, 
                                        Time = 0.15, 
                                        Knockback = 5, 
                                        HitMultiple = true, 
                                        PredictVelocity = false, 
                                        Connections = {
                                            Hit = function(v24, v25) --[[ Line: 123 ]] --[[ Name: Hit ]]
                                                -- upvalues: v8 (ref), v13 (ref), v4 (ref), v6 (ref), v3 (ref)
                                                if v24.Humanoid.Health <= 0 then
                                                    v8:IncrementAchievementProgress(v13.Player, "JohnDoeSpikes");
                                                else
                                                    v4:CreateSpeedMultiplier(v24, 1.5, "HitSpeedBonus", 1.25);
                                                    v6:ApplyStatus(v13.Rig, "Speed", {
                                                        Duration = 7, 
                                                        Level = 1
                                                    });
                                                end;
                                                if v25 then
                                                    v3:Play(v13.Config.Sounds.Hit, {
                                                        Parent = v13.Rig.PrimaryPart, 
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
                task.delay(4.5, function() --[[ Line: 142 ]]
                    -- upvalues: v13 (copy)
                    v13.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v13.Animations.CorruptEnergy:Play(0.025);
                    local l_v4_SpeedMultiplier_0 = v4:CreateSpeedMultiplier(v13.Player, 0.001, "CorruptEnergy");
                    game.Debris:AddItem(l_v4_SpeedMultiplier_0, 4);
                    local v28 = {
                        1.283, 
                        2.366
                    };
                    local v29 = 0;
                    local v30 = 0;
                    do
                        local l_v29_0, l_v30_0 = v29, v30;
                        task.spawn(function() --[[ Line: 160 ]]
                            -- upvalues: v13 (copy), v28 (copy), l_v30_0 (ref), l_v29_0 (ref), v4 (ref)
                            while v13 and v13.Rig.Parent and v28[1] do
                                l_v30_0 = l_v30_0 + game["Run Service"].Heartbeat:Wait();
                                for v33 = #v28, 1, -1 do
                                    if v28[v33] and l_v30_0 >= v28[v33] then
                                        table.remove(v28, v33);
                                        l_v29_0 = l_v29_0 + 1;
                                        v4:ApplyCameraShake(l_v29_0 * 0.2, l_v29_0 * 0.35);
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
        Callback = function(v34) --[[ Line: 184 ]] --[[ Name: Callback ]]
            -- upvalues: v3 (copy), v4 (copy), v6 (copy)
            local v35 = {
                0.383, 
                1.316, 
                2.55
            };
            local v36 = 0;
            local v37 = 0;
            if game["Run Service"]:IsServer() then
                v34.AbilitiesDisabled = true;
                v3:Play(v34.Config.Sounds.DigitalFootprint, {
                    Parent = v34.Rig.PrimaryPart, 
                    Volume = 0.4, 
                    TimePosition = 0.09
                });
                local function v42(v38) --[[ Line: 196 ]] --[[ Name: removeShadow ]]
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
                v3:Play(v34.Config.Sounds.DigitalFootprintAmbience, {
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
                task.delay(v34.Config.DigitalFootprintLifetime, function() --[[ Line: 243 ]]
                    -- upvalues: v42 (copy), v45 (copy)
                    v42(v45);
                end);
                v45.Touched:Connect(function(v47) --[[ Line: 248 ]]
                    -- upvalues: v45 (copy), v42 (copy), v4 (ref), v34 (copy), v6 (ref)
                    local l_Parent_0 = v47.Parent;
                    local l_Humanoid_0 = l_Parent_0:FindFirstChild("Humanoid");
                    if l_Humanoid_0 and l_Humanoid_0.Health > 0 and tostring(l_Parent_0.Parent) ~= "Killers" and v45.Name == "Shadow" and not l_Parent_0:GetAttribute("ExecutionsDisabled") then
                        v42(v45);
                        v4:RevealPlayerAuraTo(v34.Rig, l_Parent_0, 15);
                        v4:RevealPlayerAuraTo(l_Parent_0, v34.Rig, 15);
                        v6:ApplyStatus(v34.Rig, "Speed", {
                            Level = 2, 
                            Duration = 15
                        });
                        v6:ApplyStatus(l_Parent_0, "Slowness", {
                            Level = 1, 
                            Duration = 15
                        });
                    end;
                end);
                task.spawn(function() --[[ Line: 266 ]]
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
                task.delay(5, function() --[[ Line: 293 ]]
                    -- upvalues: v34 (copy)
                    v34.AbilitiesDisabled = false;
                end);
            elseif game["Run Service"]:IsClient() then
                v34.Animations.DigitalFootprint:Play(0.025);
                local l_v4_SpeedMultiplier_1 = v4:CreateSpeedMultiplier(v34.Player, 0, "DigitalFootprint");
                game.Debris:AddItem(l_v4_SpeedMultiplier_1, 3.5);
                task.spawn(function() --[[ Line: 306 ]]
                    -- upvalues: v34 (copy), v35 (copy), v37 (ref), v36 (ref), v4 (ref)
                    while v34 and v34.Rig.Parent and v35[1] do
                        v37 = v37 + game["Run Service"].Heartbeat:Wait();
                        for v56 = #v35, 1, -1 do
                            if v35[v56] and v37 >= v35[v56] then
                                table.remove(v35, v56);
                                v36 = v36 + 1;
                                v4:ApplyCameraShake(v36 * 0.2, v36 * 0.375);
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
        Callback = function(v57) --[[ Line: 330 ]] --[[ Name: Callback ]]
            -- upvalues: v3 (copy), v4 (copy), v7 (copy)
            if game["Run Service"]:IsServer() then
                v57.AbilitiesDisabled = true;
                v3:Play(v57.Config.Sounds["404Error"], {
                    Parent = v57.Rig.PrimaryPart, 
                    Volume = 0.4, 
                    TimePosition = 0.09
                });
                task.delay(2, function() --[[ Line: 337 ]]
                    -- upvalues: v57 (copy)
                    v57.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    local l_v4_SpeedMultiplier_2 = v4:CreateSpeedMultiplier(v57.Player, 1, "404Error");
                    local l_v4_FOVMultiplier_0 = v4:CreateFOVMultiplier(v57.Player, 1, "404Error");
                    game.TweenService:Create(l_v4_SpeedMultiplier_2, TweenInfo.new(0.5), {
                        Value = 0.25
                    }):Play();
                    game.TweenService:Create(l_v4_FOVMultiplier_0, TweenInfo.new(1.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true), {
                        Value = 0.75
                    }):Play();
                    v7:FireConnection("DisableSprinting", "404Error", true);
                    task.delay(1.5, function() --[[ Line: 352 ]]
                        -- upvalues: v4 (ref), v57 (copy), v3 (ref), v7 (ref), l_v4_SpeedMultiplier_2 (copy), l_v4_FOVMultiplier_0 (copy)
                        for _, v61 in pairs(workspace.Players.Survivors:GetChildren()) do
                            v4:RevealPlayerAura(v61, v57.Config["404ErrorAuraRevealTime"]);
                        end;
                        v3:Play(v57.Config.Sounds["404ErrorError"], {
                            Parent = v57.Rig.PrimaryPart, 
                            Volume = 0.4, 
                            TimePosition = 0.09, 
                            PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
                        });
                        v7:FireConnection("DisableSprinting", "404Error", false);
                        game.TweenService:Create(l_v4_SpeedMultiplier_2, TweenInfo.new(0.6), {
                            Value = 1
                        }):Play();
                        game.Debris:AddItem(l_v4_SpeedMultiplier_2, 0.6);
                        game.Debris:AddItem(l_v4_FOVMultiplier_0, 1.2);
                    end);
                end;
                return;
            end;
        end
    }
};
v0.Created = function(_, v63) --[[ Line: 375 ]] --[[ Name: Created ]]
    -- upvalues: v8 (copy), v4 (copy), v6 (copy), l_Players_0 (copy), v7 (copy), v3 (copy)
    if game["Run Service"]:IsServer() then
        if workspace:GetAttribute("JohnDoeSpecialDay") then
            v8:IncrementAchievementProgress(v63.Player, "JohnDoeSpecialDay");
        end;
        local l_Folder_0 = Instance.new("Folder");
        l_Folder_0.Name = "JohnDoeTrail";
        l_Folder_0.Parent = v63.Rig;
        for _ = 1, math.clamp(math.round(v63.Config.TrailLength / 4), 2, 1e999) do
            local v66 = v63.Config.Trail:Clone();
            v66.Position = v63.Rig.PrimaryPart.Position - Vector3.new(0, 4.5, 0, 0);
            v66.Parent = l_Folder_0;
            v66:SetAttribute("FinishedUpdating", true);
            v4:ApplyOnTouched(v66, false, function(_, v68) --[[ Line: 397 ]]
                -- upvalues: v6 (ref)
                local l_Parent_1 = v68.Parent;
                local l_Humanoid_1 = l_Parent_1:FindFirstChild("Humanoid");
                if l_Humanoid_1 and l_Humanoid_1.Health > 0 and l_Parent_1:IsDescendantOf(workspace.Players) and tostring(l_Parent_1.Parent) ~= "Killers" then
                    v6:ApplyStatus(l_Parent_1, "Corrupted", {
                        Duration = 3, 
                        Level = 2
                    });
                end;
            end);
        end;
        v63.CurrentSpikes = {};
        local l_l_Folder_0_Children_0 = l_Folder_0:GetChildren();
        local v72 = 0;
        local v73 = 0;
        local v74 = 0;
        local v75 = nil;
        v75 = game["Run Service"].Heartbeat:Connect(function(v76) --[[ Line: 415 ]]
            -- upvalues: v63 (copy), l_Folder_0 (copy), v75 (ref), v74 (ref), l_Players_0 (ref), v6 (ref), v73 (ref), l_l_Folder_0_Children_0 (copy), v72 (ref)
            if not v63 or not v63.Rig.Parent or not v63.Rig.PrimaryPart then
                l_Folder_0:Destroy();
                v75:Disconnect();
                v75 = nil;
                return;
            else
                if v74 > 1 and #v63.CurrentSpikes > 0 then
                    v74 = 0;
                    local v77 = RaycastParams.new();
                    v77.FilterDescendantsInstances = v63.CurrentSpikes;
                    v77.FilterType = Enum.RaycastFilterType.Include;
                    for _, v79 in (l_Players_0:GetPlayers()) do
                        local l_Character_0 = v79.Character;
                        if l_Character_0 and l_Character_0.Parent then
                            local l_Humanoid_2 = l_Character_0:FindFirstChildOfClass("Humanoid");
                            if l_Humanoid_2 or l_Humanoid_2.Health <= 0 then
                                local l_PrimaryPart_0 = l_Character_0.PrimaryPart;
                                if workspace:Raycast(l_PrimaryPart_0.Position, Vector3.new(0, -5, 0, 0), v77) then
                                    v6:ApplyStatus(v79, "Corrupted", {
                                        Level = 2, 
                                        Duration = 5
                                    });
                                end;
                            end;
                        end;
                    end;
                end;
                v74 = v74 + v76;
                if v73 <= 0.05 then
                    v73 = v73 + v76;
                    return;
                else
                    v73 = 0;
                    local v83 = l_l_Folder_0_Children_0[v72 % #l_l_Folder_0_Children_0 + 1];
                    local v84 = l_l_Folder_0_Children_0[(v72 - 1) % #l_l_Folder_0_Children_0 + 1];
                    if v83 and v84 then
                        if v83.Size.Z <= 4 or v83:GetAttribute("FinishedUpdating") then
                            if v83:GetAttribute("FinishedUpdating") then
                                v83:SetAttribute("FinishedUpdating", nil);
                            end;
                            local v85 = v63:GetPivot().Position - Vector3.new(0, 3, 0, 0);
                            local l_Position_2 = v84:GetPivot().Position;
                            local l_Rotation_0 = CFrame.lookAt(l_Position_2, v85).Rotation;
                            if l_Rotation_0 ~= l_Rotation_0 then
                                warn("currentTrailRotation is NaN, setting rotation to root rotation as fallback");
                                l_Rotation_0 = v63.Rig.PrimaryPart.CFrame.Rotation;
                            end;
                            v83.CFrame = CFrame.new(v84:GetPivot().Position) * l_Rotation_0 * CFrame.Angles(0, 0, 0);
                            v83.Size = Vector3.new(v83.Size.X, v83.Size.Y, (v83.Position - v85).Magnitude);
                            v83.PivotOffset = CFrame.new(0, 0, -v83.Size.Z / 2);
                            v83.CFrame = v83.CFrame * v83.PivotOffset;
                            return;
                        else
                            v83:SetAttribute("FinishedUpdating", true);
                            v72 = v72 + 1;
                            return;
                        end;
                    else
                        v72 = v72 + 1;
                        return;
                    end;
                end;
            end;
        end);
        return;
    else
        if game["Run Service"]:IsClient() then
            v7:SetConnection(("%*JDPuddleEffect"):format(v63.Player.Name), "REMOTE_EVENT", function() --[[ Line: 487 ]]
                -- upvalues: v3 (ref), v63 (copy)
                v3:Play(v63.Config.Sounds.PuddleStepped);
            end);
        end;
        return;
    end;
end;
v0.OnIntroduction = function(_, v89, v90, v91) --[[ Line: 522 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v4 (copy)
    local v92 = nil;
    if v89.Config.useClouds == true then
        v92 = Instance.new("Clouds");
        v92.Cover = 0.774;
        v92.Density = 1;
        v92.Color = Color3.fromRGB(25, 25, 25);
        v92.Parent = workspace:FindFirstChild("Terrain");
        game.Debris:AddItem(v92, v91);
    end;
    local v93 = script.IntroScreen:Clone();
    v93.Main.Title.Text = v89.Config.IntroText:gsub("PLAYERNAME", v89.Player.DisplayName);
    v93.Parent = game.Players.LocalPlayer.PlayerGui;
    game.Debris:AddItem(v93, 1.93333);
    game.TweenService:Create(v93.Main.Title, TweenInfo.new(0.83), {
        TextTransparency = 0
    }):Play();
    task.delay(0.83, function() --[[ Line: 547 ]]
        -- upvalues: v93 (copy), v89 (copy)
        game.TweenService:Create(v93.Main.Title, TweenInfo.new(0.583), {
            TextColor3 = v89.Config.IntroTextColor or Color3.new(1, 0, 0)
        }):Play();
    end);
    task.delay(1, function() --[[ Line: 552 ]]
        -- upvalues: v90 (copy)
        local l_JohnDoeTrail_0 = v90:FindFirstChild("JohnDoeTrail");
        if l_JohnDoeTrail_0 then
            l_JohnDoeTrail_0:Destroy();
        end;
    end);
    local v95 = require(game.ReplicatedStorage.Modules.Schematics.Lighting);
    v95:SetCustomLighting(v89.Config.IntroLighting);
    task.delay(2.717, function() --[[ Line: 562 ]]
        -- upvalues: v92 (ref), v89 (copy)
        if v92 then
            v92.Color = Color3.fromRGB(25, 0, 0);
        end;
        local l_AtmosphereDoe_0 = game.Lighting:FindFirstChild("AtmosphereDoe");
        if l_AtmosphereDoe_0 then
            game.TweenService:Create(l_AtmosphereDoe_0, TweenInfo.new(0.2829, Enum.EasingStyle.Linear), {
                Color = v89.Config.AtmosphereColor or Color3.fromRGB(144, 0, 0), 
                Decay = v89.Config.AtmosphereDecay or Color3.fromRGB(255, 0, 0), 
                Density = 1
            }):Play();
        end;
    end);
    local l_v4_FOVMultiplier_1 = v4:CreateFOVMultiplier(game.Players.LocalPlayer, 0.35, "JohnDoeIntroScene");
    task.delay(2.75, function() --[[ Line: 578 ]]
        -- upvalues: l_v4_FOVMultiplier_1 (copy)
        game.TweenService:Create(l_v4_FOVMultiplier_1, TweenInfo.new(0.25), {
            Value = 0.95
        }):Play();
    end);
    task.delay(v91, function() --[[ Line: 583 ]]
        -- upvalues: v95 (copy), l_v4_FOVMultiplier_1 (copy), v93 (copy), v92 (ref)
        v95:SetAsCurrentLighting();
        l_v4_FOVMultiplier_1:Destroy();
        v93:Destroy();
        if v92 then
            v92:Destroy();
        end;
    end);
end;
v0.OnVictory = function(_, v99, v100, _, _) --[[ Line: 593 ]] --[[ Name: OnVictory ]]
    -- upvalues: v4 (copy), l_TweenService_0 (copy)
    local v103 = require(game.ReplicatedStorage.Modules.Schematics.Lighting);
    if v99 == "Start" then
        v103:SetCustomLighting(v100.Config.IntroLighting);
        local l_v4_FOVMultiplier_2 = v4:CreateFOVMultiplier(game.Players.LocalPlayer, 1.1325, "JohnDoeOutroScene");
        game.Debris:AddItem(l_v4_FOVMultiplier_2, 30);
        task.spawn(function() --[[ Line: 604 ]]
            -- upvalues: v100 (copy), v4 (ref)
            local v105 = tick();
            local v106 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 5);
            if v106 and v106.PrimaryPart then
                local v107 = v100.Config.OutroDummy:Clone();
                v107.Name = "OutroVictim";
                v107.PrimaryPart.Anchored = true;
                v107:SetPrimaryPartCFrame(v106.PrimaryPart.CFrame);
                v107.Parent = v106;
                local v108 = v4:LoadAnimationFromID(v107, "rbxassetid://125975816678255", true);
                v108:Play(0);
                v108.TimePosition = tick() - v105;
                v108.Stopped:Once(function() --[[ Line: 619 ]]
                    -- upvalues: v107 (copy)
                    for _, v110 in ipairs(v107:GetDescendants()) do
                        if v110:IsA("BasePart") then
                            v110.Anchored = true;
                        end;
                    end;
                end);
                local v111 = false;
                for _, v113 in ipairs({
                    "Shirt", 
                    "Pants", 
                    "Accessory", 
                    "Hat"
                }) do
                    if v107:FindFirstChildOfClass(v113) then
                        v111 = true;
                        break;
                    end;
                end;
                if not v111 then
                    pcall(function() --[[ Line: 632 ]]
                        -- upvalues: v100 (ref), v107 (copy)
                        local l_HumanoidDescriptionFromUserId_0 = game.Players:GetHumanoidDescriptionFromUserId(v100.Player.UserId);
                        v107.Humanoid:ApplyDescription(l_HumanoidDescriptionFromUserId_0, Enum.AssetTypeVerification.Always);
                    end);
                end;
            end;
        end);
        task.delay(2.4, function() --[[ Line: 641 ]]
            -- upvalues: l_TweenService_0 (ref), v100 (copy)
            local v115 = Instance.new("ColorCorrectionEffect", game.Lighting);
            v115.Name = "JohnDoeStabCC";
            local v116 = l_TweenService_0:Create(v115, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                Contrast = 0.4, 
                Brightness = 0.1
            });
            v116:Play();
            task.wait(0.4);
            v116:Pause();
            v115.Brightness = 0.8;
            v115.Contrast = 0.3;
            v115.TintColor = v100.Config.OutroTintColor or Color3.new(0.631373, 0.0784314, 0.0901961);
            l_TweenService_0:Create(v115, TweenInfo.new(2.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                TintColor = Color3.new(0.196078, 0.196078, 0.196078), 
                Brightness = -1, 
                Contrast = -0.5, 
                Saturation = -1
            }):Play();
        end);
        return;
    else
        if v99 == "End" then
            v103:SetAsCurrentLighting();
            local l_v4_FOVMultiplier_3 = v4:CreateFOVMultiplier(game.Players.LocalPlayer, 1, "JohnDoeOutroScene");
            game.Debris:AddItem(l_v4_FOVMultiplier_3, 1);
            local v118 = game.Lighting:WaitForChild("JohnDoeStabCC", 8);
            if v118 then
                v118:Destroy();
            end;
        end;
        return;
    end;
end;
v0.Destroyed = function(_, v120) --[[ Line: 681 ]] --[[ Name: Destroyed ]]
    -- upvalues: v7 (copy)
    if game["Run Service"]:IsServer() then
        for _, v122 in v120.CurrentSpikes do
            v122:Destroy();
        end;
        return;
    else
        if game["Run Service"]:IsClient() then
            v7:RemoveConnection(("%*JDPuddleEffect"):format(v120.Player.Name), "REMOTE_EVENT");
            if v120.SilencedConnection then
                v120.SilencedConnection:Disconnect();
                local l_ipairs_0 = ipairs;
                local v124 = v120.Silencers or {};
                for _, v126 in l_ipairs_0(v124) do
                    v126:Destroy();
                end;
            end;
        end;
        return;
    end;
end;
return v0;