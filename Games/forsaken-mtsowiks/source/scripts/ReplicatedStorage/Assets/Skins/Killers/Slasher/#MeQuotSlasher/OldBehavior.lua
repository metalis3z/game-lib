-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: OldBehavior, time of decompilation: Fri Nov 28 21:08:21 2025 ]]
local l_TweenService_0 = game:GetService("TweenService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v2 = {};
local v3 = require(l_ReplicatedStorage_0.Modules.Sounds);
local v4 = require(l_ReplicatedStorage_0.Modules.Util);
local v5 = require(l_ReplicatedStorage_0.Modules.Hitboxes);
local v6 = require(l_ReplicatedStorage_0.Modules.Statuses);
local v7 = require(l_ReplicatedStorage_0.Modules.Network);
local v8 = require(l_ReplicatedStorage_0.Modules.AchievementUtil);
local _ = game:GetService("Debris");
local v10 = require(l_ReplicatedStorage_0.Modules.Schematics.Lighting);
local function _(v11, v12, v13) --[[ Line: 17 ]] --[[ Name: getEnragedStatValue ]]
    return v11.Enraged and v11.Config[("Enraged%*%*"):format(v12, v13)] or v11.Config[("%*%*"):format(v12, v13)];
end;
local v15 = false;
local function v20(v16) --[[ Line: 23 ]] --[[ Name: pacify ]]
    -- upvalues: v4 (copy), v3 (copy), v7 (copy), v6 (copy), l_TweenService_0 (copy), l_ReplicatedStorage_0 (copy)
    if v16 and v16.Enraged and v16.Rig.Parent then
        v16.Enraged = nil;
        if game["Run Service"]:IsServer() then
            v4:RemoveInvincible(v16.Rig, "Raging");
            if v16.EnragedSFX then
                v16.EnragedSFX:Destroy();
                v16.EnragedSFX = nil;
            end;
            v3:Play(v16.Config.Sounds.EnragedEnd, {
                Parent = v16.Rig.PrimaryPart
            });
            for _, v18 in pairs(v16.Rig:GetDescendants()) do
                if v18.Name == "RagingPace" then
                    v18.Enabled = false;
                end;
            end;
            v7:FireClientConnection(v16.Player, "PacifyJason", "REMOTE_EVENT");
            v6:RemoveStatus(v16.Rig, "Invisibility");
            v6:ApplyStatus(v16.Rig, "Slowness", {
                Level = 4, 
                Duration = 1
            });
            return;
        elseif game["Run Service"]:IsClient() then
            v16.AnimationType = nil;
            v16.MovementAnimSpeed = nil;
            v7:FireConnection("DisableSprinting", "ENRAGED", false);
            v7:RemoveConnection("PacifyJason", "REMOTE_EVENT");
            if v16.TargetedPlayer then
                v4:RevealPlayerAura(v16.TargetedPlayer, v16.Config.EnragedAuraLingerTime);
                v16.TargetedPlayer = nil;
            end;
            if v16.SpeedModifier then
                l_TweenService_0:Create(v16.SpeedModifier, TweenInfo.new(1), {
                    Value = 1
                }):Play();
                game.Debris:AddItem(v16.SpeedModifier, 1);
            end;
            local l_v4_SpeedMultiplier_0 = v4:CreateSpeedMultiplier(v16.Rig, 0.001, "Pacified");
            l_TweenService_0:Create(l_v4_SpeedMultiplier_0, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Value = 1
            }):Play();
            game.Debris:AddItem(l_v4_SpeedMultiplier_0, 1);
            require(l_ReplicatedStorage_0.Systems.Character.Game.Sprinting).StaminaCap = nil;
        end;
    end;
end;
v2.Abilities = {
    Slash = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://97183429269286", 
        KeybindType = "MainAbility", 
        Cooldown = function(v21, v22) --[[ Line: 87 ]] --[[ Name: Cooldown ]]
            return v21.Enraged and v21.Config[("Enraged%*Cooldown"):format(v22)] or v21.Config[("%*Cooldown"):format(v22)];
        end, 
        Callback = function(v23) --[[ Line: 88 ]] --[[ Name: Callback ]]
            -- upvalues: v3 (copy), v4 (copy), l_TweenService_0 (copy), v5 (copy), v20 (copy)
            if game["Run Service"]:IsServer() then
                v23.AbilitiesDisabled = true;
                v3:Play(v23.Config.Sounds.Swing, {
                    Parent = v23.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.25
                });
                task.delay(0.075, function() --[[ Line: 95 ]]
                    -- upvalues: v23 (copy), v4 (ref), l_TweenService_0 (ref)
                    if v23.Enraged then
                        local v24 = v4:ApplyVelocity(v23.Rig.PrimaryPart, v23.Config.EnragedSlashLungeForce);
                        l_TweenService_0:Create(v24, TweenInfo.new(1), {
                            LineVelocity = v24.LineVelocity / 100
                        }):Play();
                        game.Debris:AddItem(v24, 0.6);
                    end;
                end);
                task.delay(v23.Config.SlashWindup, function() --[[ Line: 104 ]]
                    -- upvalues: v5 (ref), v23 (copy), v4 (ref), v3 (ref), v20 (ref)
                    local l_v5_0 = v5;
                    local l_Player_0 = v23.Player;
                    local v27 = {
                        Size = Vector3.new(4.5, 6, 7.5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1.25)
                    };
                    local l_v23_0 = v23;
                    v27.Damage = l_v23_0.Enraged and l_v23_0.Config.EnragedSlashDamage or l_v23_0.Config.SlashDamage;
                    v27.Time = v23.Config.SlashLinger;
                    v27.Knockback = 2;
                    v27.HitMultiple = true;
                    v27.ExecuteOnKill = true;
                    v27.Connections = {
                        Hit = function(v29, v30) --[[ Line: 116 ]] --[[ Name: Hit ]]
                            -- upvalues: v4 (ref), v3 (ref), v23 (ref), v20 (ref)
                            v4:CreateSpeedMultiplier(v29, 1.5, "HitSpeedBonus", 1.25);
                            if v30 then
                                v3:Play(v23.Config.Sounds.Hit, {
                                    Parent = v23.Rig.PrimaryPart, 
                                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                    Volume = 0.25
                                });
                                v20(v23);
                            end;
                        end
                    };
                    l_v5_0 = l_v5_0:CreateHitbox(l_Player_0, v27);
                end);
                task.delay(0.5, function() --[[ Line: 128 ]]
                    -- upvalues: v20 (ref), v23 (copy)
                    v20(v23);
                end);
                task.delay(0.85, function() --[[ Line: 133 ]]
                    -- upvalues: v23 (copy)
                    v23.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v23.Animations.Slash:Play(0.025);
                end;
                return;
            end;
        end
    }, 
    Behead = {
        LayoutOrder = 2, 
        Icon = "rbxassetid://115283980500353", 
        KeybindType = "AltAbility1", 
        Cooldown = function(v31, v32) --[[ Line: 149 ]] --[[ Name: Cooldown ]]
            return v31.Enraged and v31.Config[("Enraged%*Cooldown"):format(v32)] or v31.Config[("%*Cooldown"):format(v32)];
        end, 
        Callback = function(v33) --[[ Line: 150 ]] --[[ Name: Callback ]]
            -- upvalues: v3 (copy), v5 (copy), v8 (copy), l_ReplicatedStorage_0 (copy), v4 (copy), v6 (copy), v20 (copy), l_TweenService_0 (copy)
            if game["Run Service"]:IsServer() then
                v33.AbilitiesDisabled = true;
                v3:Play(v33.Config.Sounds.Swing, {
                    Parent = v33.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.25
                });
                for _, v35 in pairs(v33.Rig:GetChildren()) do
                    if v35.Name:find("Machete") and not v35:GetAttribute("Ignored") then
                        v35.Transparency = 0;
                    end;
                end;
                for _, v37 in pairs(v33.Rig.Machete:GetChildren()) do
                    if v37:IsA("ParticleEmitter") or v37:IsA("Light") or v37:IsA("Highlight") then
                        v37.Enabled = true;
                    end;
                end;
                for _, v39 in pairs(v33.Rig:GetChildren()) do
                    if v39.Name:find("BackDagger") and not v39:GetAttribute("Ignored") then
                        v39.Transparency = 1;
                    end;
                end;
                for _, v41 in pairs(v33.Rig.BackDagger:GetChildren()) do
                    if v41:IsA("ParticleEmitter") or v41:IsA("Light") or v41:IsA("Highlight") then
                        v41.Enabled = false;
                    end;
                end;
                task.delay(2, function() --[[ Line: 179 ]]
                    -- upvalues: v33 (copy)
                    for _, v43 in pairs(v33.Rig:GetChildren()) do
                        if v43.Name:find("Machete") and not v43:GetAttribute("Ignored") then
                            v43.Transparency = 1;
                        end;
                    end;
                    for _, v45 in pairs(v33.Rig.Machete:GetChildren()) do
                        if v45:IsA("ParticleEmitter") or v45:IsA("Light") or v45:IsA("Highlight") then
                            v45.Enabled = false;
                        end;
                    end;
                    for _, v47 in pairs(v33.Rig:GetChildren()) do
                        if v47.Name:find("BackDagger") and not v47:GetAttribute("Ignored") then
                            v47.Transparency = 0;
                        end;
                    end;
                    for _, v49 in pairs(v33.Rig.BackDagger:GetChildren()) do
                        if v49:IsA("ParticleEmitter") or v49:IsA("Light") or v49:IsA("Highlight") then
                            v49.Enabled = true;
                        end;
                    end;
                end);
                task.delay(0.45, function() --[[ Line: 206 ]]
                    -- upvalues: v5 (ref), v33 (copy), v8 (ref), l_ReplicatedStorage_0 (ref), v4 (ref), v6 (ref), v3 (ref), v20 (ref)
                    local l_v5_1 = v5;
                    local l_Player_1 = v33.Player;
                    local v52 = {
                        Size = Vector3.new(8, 2, 7, 0), 
                        CFrameOffset = CFrame.new(0, 0, -2)
                    };
                    local l_v33_0 = v33;
                    v52.Damage = l_v33_0.Enraged and l_v33_0.Config.EnragedBeheadDamage or l_v33_0.Config.BeheadDamage;
                    v52.Time = 0.15;
                    v52.Knockback = 2;
                    v52.HitMultiple = true;
                    v52.Connections = {
                        Hit = function(v54, v55) --[[ Line: 217 ]] --[[ Name: Hit ]]
                            -- upvalues: v8 (ref), v33 (ref), l_ReplicatedStorage_0 (ref), v4 (ref), v6 (ref), v3 (ref), v20 (ref)
                            if v54.Humanoid.Health <= 0 then
                                local l_Head_0 = v54:FindFirstChild("Head");
                                if l_Head_0 then
                                    l_Head_0:Destroy();
                                end;
                                v8:IncrementAchievementProgress(v33.Player, "JasonBrutality");
                                if tostring(v54.Parent) == "Survivors" then
                                    require(l_ReplicatedStorage_0.Modules.Actors):IncrementActorStats(v33.Player, {
                                        Action = "Killed a Survivor with Behead", 
                                        RewardType = "DifficultKillerAction"
                                    });
                                end;
                            else
                                v4:CreateSpeedMultiplier(v54, 1.5, "HitSpeedBonus", 0.9);
                                v6:ApplyStatus(v54, "Helpless", {
                                    Level = 1, 
                                    Duration = 12
                                });
                                v6:ApplyStatus(v54, "Bleeding", {
                                    Level = 1, 
                                    Duration = 5
                                });
                                if tostring(v54.Parent) == "Survivors" then
                                    require(l_ReplicatedStorage_0.Modules.Actors):IncrementActorStats(v33.Player, {
                                        Action = "Landed Behead hit", 
                                        RewardType = "EasyKillerAction"
                                    });
                                end;
                            end;
                            if v55 then
                                v3:Play(v33.Config.Sounds.Hit, {
                                    Parent = v33.Rig.PrimaryPart, 
                                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                    Volume = 0.25
                                });
                                v20(v33);
                            end;
                        end
                    };
                    l_v5_1 = l_v5_1:CreateHitbox(l_Player_1, v52);
                end);
                task.delay(0.5, function() --[[ Line: 256 ]]
                    -- upvalues: v20 (ref), v33 (copy)
                    v20(v33);
                end);
                task.delay(0.55, function() --[[ Line: 261 ]]
                    -- upvalues: v6 (ref), v33 (copy)
                    v6:ApplyStatus(v33.Rig, "Slowness", {
                        Level = 5, 
                        Duration = 2
                    });
                end);
                task.delay(0.8, function() --[[ Line: 266 ]]
                    -- upvalues: v33 (copy)
                    v33.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v33.Animations.Behead:Play(0.025);
                    local l_v4_SpeedMultiplier_1 = v4:CreateSpeedMultiplier(v33.Rig, 1, "BeheadAbility");
                    l_TweenService_0:Create(l_v4_SpeedMultiplier_1, TweenInfo.new(0.125), {
                        Value = v33.Enraged and v33.Config.EnragedBeheadLunge or v33.Config.BeheadLunge
                    }):Play();
                    task.delay(0.6, function() --[[ Line: 279 ]]
                        -- upvalues: l_TweenService_0 (ref), l_v4_SpeedMultiplier_1 (copy)
                        l_TweenService_0:Create(l_v4_SpeedMultiplier_1, TweenInfo.new(0.3), {
                            Value = 0.2
                        }):Play();
                    end);
                    task.delay(1, function() --[[ Line: 284 ]]
                        -- upvalues: l_TweenService_0 (ref), l_v4_SpeedMultiplier_1 (copy)
                        l_TweenService_0:Create(l_v4_SpeedMultiplier_1, TweenInfo.new(0.3), {
                            Value = 1
                        }):Play();
                        game.Debris:AddItem(l_v4_SpeedMultiplier_1, 0.3);
                    end);
                end;
                return;
            end;
        end
    }, 
    GashingWound = {
        LayoutOrder = 3, 
        Icon = "rbxassetid://96900331272883", 
        KeybindType = "AltAbility2", 
        Cooldown = function(v58, v59) --[[ Line: 296 ]] --[[ Name: Cooldown ]]
            return v58.Enraged and v58.Config[("Enraged%*Cooldown"):format(v59)] or v58.Config[("%*Cooldown"):format(v59)];
        end, 
        Callback = function(v60) --[[ Line: 297 ]] --[[ Name: Callback ]]
            -- upvalues: v15 (ref), v3 (copy), v5 (copy), v4 (copy), v8 (copy), l_ReplicatedStorage_0 (copy), v20 (copy), l_TweenService_0 (copy)
            if game["Run Service"]:IsServer() then
                v60.AbilitiesDisabled = true;
                v60.Cache.GashingWoundStart:Play(0.05);
                v15 = true;
                v3:Play(v60.Config.Sounds.GashingWoundSwing, {
                    Parent = v60.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.25
                });
                local v61 = v60.Enraged and v60.Config.EnragedGashingWoundDamage or v60.Config.GashingWoundDamage;
                local v62 = {
                    [0.333] = {
                        Damage = v61 / 5, 
                        Time = 0.15, 
                        DoLunge = true
                    }, 
                    [0.75] = {
                        Damage = v61 / 5, 
                        Time = 0.15, 
                        DoLunge = true
                    }, 
                    [1.533] = {
                        Damage = v61 / 5, 
                        Time = 0.15, 
                        DoLunge = true
                    }, 
                    [1.966] = {
                        Damage = v61 / 10, 
                        Time = 0.15, 
                        DoLunge = true
                    }, 
                    [2.333] = {
                        Damage = v61 / 10, 
                        Time = 0.15
                    }, 
                    [2.983] = {
                        Damage = v61 / 5, 
                        Time = 0.15, 
                        DoLunge = true
                    }
                };
                local _ = tick();
                local v64 = nil;
                local v65 = nil;
                local _ = nil;
                for v67, v68 in pairs(v62) do
                    task.delay(v67, function() --[[ Line: 343 ]]
                        -- upvalues: v67 (copy), v64 (ref), v5 (ref), v60 (copy), v68 (copy), v3 (ref), v4 (ref), v65 (ref), v8 (ref), l_ReplicatedStorage_0 (ref)
                        if v67 >= 0.5 and not v64 then
                            return;
                        else
                            local _ = v5:CreateHitbox(v60.Player, {
                                Size = Vector3.new(8, 4, 8, 0), 
                                CFrameOffset = CFrame.new(0, 0, -2.25), 
                                Damage = v68.Damage, 
                                Time = v68.Time, 
                                Knockback = 0, 
                                HitMultiple = true, 
                                Connections = {
                                    Hit = function(v69, v70) --[[ Line: 357 ]] --[[ Name: Hit ]]
                                        -- upvalues: v3 (ref), v60 (ref), v67 (ref), v64 (ref), v4 (ref), v65 (ref), v8 (ref), l_ReplicatedStorage_0 (ref)
                                        if v70 then
                                            v3:Play(v60.Config.Sounds.Hit, {
                                                Parent = v60.Rig.PrimaryPart, 
                                                PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                                Volume = 0.25
                                            });
                                        end;
                                        if v67 <= 0.5 and not v64 then
                                            v64 = v69;
                                            v4:SetUpCutscene(v60.Rig, v64);
                                            v4:GiveInvincible(v60.Rig, "Gashing");
                                            local l_GashingWound_0 = v60.Cache.GashingWound;
                                            l_GashingWound_0:Play(0);
                                            l_GashingWound_0.TimePosition = v60.Cache.GashingWoundStart.TimePosition;
                                            v65 = v4:LoadAnimationFromID(v64, v60.Config.Animations.GashingWound.PlayerRig, true);
                                            v65:Play(0.05);
                                            v65.TimePosition = v60.Cache.GashingWoundStart.TimePosition;
                                            v60.Cache.GashingWoundStart:Stop(0);
                                            v3:PlayVoiceline(v60, "GashingWoundHit", {
                                                Priority = 2
                                            });
                                            if v69.Humanoid.Health <= 0 then
                                                for _, v73 in ipairs(workspace:GetDescendants()) do
                                                    if v73:IsA("Model") and (v73.Name == "SubspaceTripmine" or string.match(v73.Name, "TaphTripmine$")) then
                                                        local v74 = v73.PrimaryPart or v73:FindFirstChildWhichIsA("BasePart");
                                                        if v74 and (v74.Position - v69.HumanoidRootPart.Position).Magnitude <= 20 then
                                                            v8:IncrementAchievementProgress(v60.Player, "JasonFool");
                                                            break;
                                                        end;
                                                    end;
                                                end;
                                            end;
                                            if tostring(v69.Parent) == "Survivors" then
                                                require(l_ReplicatedStorage_0.Modules.Actors):IncrementActorStats(v60.Player, {
                                                    Action = "Landed Gashing Wound hit", 
                                                    RewardType = "RegularKillerAction"
                                                });
                                            end;
                                        end;
                                    end
                                }
                            });
                            return;
                        end;
                    end);
                end;
                task.delay(0.5, function() --[[ Line: 409 ]]
                    -- upvalues: v64 (ref), v3 (ref), v60 (copy), v4 (ref), v65 (ref), v20 (ref), v15 (ref)
                    local v76 = v64 and 4.25 or 0.5;
                    if not v64 then
                        v3:Play(v60.Config.Sounds.GashingWoundMiss, {
                            Parent = v60.Rig.PrimaryPart
                        });
                        v4:RemoveInvincible(v60.Rig, "Gashing");
                    else
                        v3:Play(v60.Config.Sounds.GashingWoundHit, {
                            Parent = v60.Rig.PrimaryPart
                        });
                    end;
                    local l_StringValue_0 = Instance.new("StringValue");
                    l_StringValue_0.Name = "Result";
                    l_StringValue_0.Value = v64 and "HitPlayer" or "HitNothing";
                    l_StringValue_0.Parent = v60.Rig;
                    game.Debris:AddItem(l_StringValue_0, 5);
                    task.delay(v76 - 1.85, function() --[[ Line: 429 ]]
                        -- upvalues: v65 (ref), v64 (ref), v60 (ref)
                        if v65 then
                            v65:Stop(0);
                        end;
                        if v64 and v64.PrimaryPart then
                            local v78 = RaycastParams.new();
                            v78.FilterDescendantsInstances = workspace.Players:GetDescendants();
                            v78.FilterType = Enum.RaycastFilterType.Exclude;
                            local v79 = workspace:Raycast(v60.Rig.PrimaryPart.Position, v60.Rig.PrimaryPart.CFrame.LookVector * 100, v78);
                            local v80 = v79 and math.clamp(v79.Distance, -1e999, 3) or 3;
                            if v80 < 3 then
                                v80 = -(v64.PrimaryPart.Size.Z / 2) - (3 - v80) * 2;
                            end;
                            v64:SetPrimaryPartCFrame(v60.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -v80));
                            v64.PrimaryPart.Anchored = false;
                            v64.PrimaryPart.Velocity = v60.Rig.PrimaryPart.CFrame.LookVector * (75 * (v80 / 3));
                            local v81 = v60.Rig.PrimaryPart.CFrame.LookVector * (75 * (v80 / 3));
                            v64.PrimaryPart.Velocity = v81;
                            local v82 = require(game.ReplicatedStorage.Modules.Ragdolls);
                            v82.AddProfile(v64, {
                                Velocity = v81
                            });
                            v82.EnableRagdoll(v64, 1.25);
                        end;
                    end);
                    task.delay(v76 + 0.25, function() --[[ Line: 457 ]]
                        -- upvalues: v20 (ref), v60 (ref)
                        v20(v60);
                    end);
                    task.delay(v76 + 0.75, function() --[[ Line: 462 ]]
                        -- upvalues: v60 (ref)
                        v60.Rig.PrimaryPart.Anchored = false;
                    end);
                    task.delay(v76 + 1.25, function() --[[ Line: 467 ]]
                        -- upvalues: v60 (ref)
                        v60.AbilitiesDisabled = false;
                    end);
                    task.delay(v76 + 1.5, function() --[[ Line: 472 ]]
                        -- upvalues: v15 (ref), v4 (ref), v60 (ref)
                        v15 = false;
                        v4:RemoveInvincible(v60.Rig, "Gashing");
                    end);
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    local l_v4_SpeedMultiplier_2 = v4:CreateSpeedMultiplier(v60.Rig, 1, "BeheadAbility");
                    l_TweenService_0:Create(l_v4_SpeedMultiplier_2, TweenInfo.new(0.2), {
                        Value = 0.001
                    }):Play();
                    local v84 = v60.Rig:WaitForChild("Result", 5);
                    if (v84 and v84.Value or "IDK") == "HitPlayer" then
                        task.delay(4.75, function() --[[ Line: 488 ]]
                            -- upvalues: l_TweenService_0 (ref), l_v4_SpeedMultiplier_2 (copy)
                            l_TweenService_0:Create(l_v4_SpeedMultiplier_2, TweenInfo.new(0.2), {
                                Value = 1
                            }):Play();
                            game.Debris:AddItem(l_v4_SpeedMultiplier_2, 0.2);
                        end);
                        return;
                    else
                        task.delay(1, function() --[[ Line: 493 ]]
                            -- upvalues: l_TweenService_0 (ref), l_v4_SpeedMultiplier_2 (copy)
                            l_TweenService_0:Create(l_v4_SpeedMultiplier_2, TweenInfo.new(0.2), {
                                Value = 1
                            }):Play();
                            game.Debris:AddItem(l_v4_SpeedMultiplier_2, 0.2);
                        end);
                    end;
                end;
                return;
            end;
        end
    }, 
    RagingPace = {
        LayoutOrder = 3, 
        Icon = "rbxassetid://86530225037587", 
        KeybindType = "AltAbility3", 
        Callback = function(v85) --[[ Line: 507 ]] --[[ Name: Callback ]]
            -- upvalues: v3 (copy), v4 (copy), v6 (copy), v20 (copy), v7 (copy), l_TweenService_0 (copy), l_ReplicatedStorage_0 (copy)
            if game["Run Service"]:IsServer() then
                v85.AbilitiesDisabled = true;
                task.delay(0.5, function() --[[ Line: 512 ]]
                    -- upvalues: v85 (copy), v3 (ref)
                    v85.EnragedSFX = v3:Play(v85.Config.Sounds.Enraged, {
                        Parent = v85.Rig.PrimaryPart, 
                        Looped = true, 
                        Volume = 0.25
                    });
                    v3:Play(v85.Config.Sounds.EnragedStart, {
                        Parent = v85.Rig.PrimaryPart
                    });
                end);
                task.delay(1.5, function() --[[ Line: 517 ]]
                    -- upvalues: v85 (copy), v4 (ref), v6 (ref)
                    v85.Enraged = true;
                    v4:GiveInvincible(v85.Rig, "Raging");
                    v6:ApplyStatus(v85.Rig, "Invisibility", {
                        Level = 10, 
                        Duration = 7
                    });
                    if v85.EnragedSFX then
                        game.Debris:AddItem(v85.EnragedSFX, v85.Config.EnragedTime);
                    end;
                    for _, v87 in pairs(v85.Rig:GetDescendants()) do
                        if v87.Name == "RagingPace" then
                            v87.Enabled = true;
                        end;
                    end;
                end);
                task.delay(v85.Config.EnragedTime, function() --[[ Line: 535 ]]
                    -- upvalues: v6 (ref), v85 (copy), v20 (ref)
                    v6:RemoveStatus(v85.Rig, "Invisibility");
                    v20(v85);
                end);
                task.delay(1, function() --[[ Line: 541 ]]
                    -- upvalues: v85 (copy)
                    v85.AbilitiesDisabled = true;
                    task.delay(7, function() --[[ Line: 543 ]]
                        -- upvalues: v85 (ref)
                        v85.AbilitiesDisabled = false;
                    end);
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v85.Animations.EnragedStart:Play(0.025);
                    v85.AnimationType = "Enraged";
                    v85.MovementAnimSpeed = 1.425;
                    v85.Enraged = true;
                    v7:FireConnection("DisableSprinting", "ENRAGED", true);
                    v7:SetConnection("PacifyJason", "REMOTE_EVENT", function() --[[ Line: 555 ]]
                        -- upvalues: v20 (ref), v85 (copy)
                        v20(v85);
                    end);
                    v85.SpeedModifier = v4:CreateSpeedMultiplier(v85.Rig, 0.001, "ENRAGED");
                    task.delay(0.75, function() --[[ Line: 561 ]]
                        -- upvalues: l_TweenService_0 (ref), v85 (copy)
                        l_TweenService_0:Create(v85.SpeedModifier, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                            Value = v85.Config.EnragedSpeed / v85.Config.Speed
                        }):Play();
                    end);
                    local l_v4_ClosestPlayerFromPosition_0 = v4:GetClosestPlayerFromPosition(v85.Rig.PrimaryPart.Position);
                    if l_v4_ClosestPlayerFromPosition_0 then
                        v85.TargetedPlayer = l_v4_ClosestPlayerFromPosition_0;
                        v4:RevealPlayerAura(l_v4_ClosestPlayerFromPosition_0, v85.Config.EnragedTime + 2);
                    end;
                    task.delay(1, function() --[[ Line: 573 ]]
                        -- upvalues: v85 (copy), l_ReplicatedStorage_0 (ref)
                        local v89 = tick();
                        while task.wait() and v85.Enraged and v85.Rig.Parent do
                            local v90 = math.clamp((tick() - v89) / v85.Config.EnragedStaminaCapLerpTime, 0, 1);
                            local v91 = v85.Config.MaxStamina + (v85.Config.EnragedStaminaCap - v85.Config.MaxStamina) * v90;
                            require(l_ReplicatedStorage_0.Systems.Character.Game.Sprinting).StaminaCap = v91;
                            if v90 >= 1 then
                                break;
                            end;
                        end;
                    end);
                end;
                return;
            end;
        end
    }
};
v2.Created = function(_, v93) --[[ Line: 595 ]] --[[ Name: Created ]]
    -- upvalues: v8 (copy), v4 (copy)
    if game["Run Service"]:IsServer() then
        if workspace:GetAttribute("JasonSpecialDay") then
            v8:IncrementAchievementProgress(v93.Player, "JasonSpecialDay");
        end;
        task.spawn(function() --[[ Line: 604 ]]
            -- upvalues: v93 (copy), v4 (ref)
            if not v93.Cache then
                v93.Cache = {};
            end;
            v93.Cache.GashingWoundStart = v4:LoadAnimationFromID(v93.Rig, v93.Config.Animations.GashingWoundStart);
            v93.Cache.GashingWound = v4:LoadAnimationFromID(v93.Rig, v93.Config.Animations.GashingWound.KillerRig);
        end);
    end;
end;
v2.CreatedPost = function(_, v95) --[[ Line: 612 ]] --[[ Name: CreatedPost ]]
    local l_Humanoid_0 = v95.Rig.Humanoid;
    task.spawn(function() --[[ Line: 614 ]]
        -- upvalues: l_Humanoid_0 (copy), v95 (copy)
        while l_Humanoid_0 and l_Humanoid_0.Parent and l_Humanoid_0.Health > 0 do
            v95.Rig.HumanoidRootPart.SprintAttatchment.SParticle.Enabled = (v95.Rig.PrimaryPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1, 0)).Magnitude > (l_Humanoid_0:GetAttribute("BaseSpeed") or 18) + 10;
            task.wait();
        end;
    end);
end;
v2.OnIntroduction = function(_, _, v99, v100) --[[ Line: 623 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v4 (copy), l_TweenService_0 (copy)
    local v101 = script.IntroWideDoor:Clone();
    v101:SetPrimaryPartCFrame(v99.PrimaryPart.CFrame);
    v101.Parent = v99;
    for _, v103 in pairs(v101.Joints:GetChildren()) do
        v103.Part1 = v101.Parts:FindFirstChild(v103.Name, true);
        v103.Part0 = v99.PrimaryPart;
    end;
    local l_v4_FOVMultiplier_0 = v4:CreateFOVMultiplier(game.Players.LocalPlayer, 0.4, "JasonIntroScene", v100);
    task.delay(0.783, function() --[[ Line: 639 ]]
        -- upvalues: l_v4_FOVMultiplier_0 (copy), l_TweenService_0 (ref)
        l_v4_FOVMultiplier_0.Value = 0.35;
        l_TweenService_0:Create(l_v4_FOVMultiplier_0, TweenInfo.new(2.5, Enum.EasingStyle.Back), {
            Value = 0.45
        }):Play();
    end);
end;
v2.OnVictory = function(_, v106, _, _, _) --[[ Line: 646 ]] --[[ Name: OnVictory ]]
    -- upvalues: l_TweenService_0 (copy), v10 (copy)
    if v106 == "Start" then
        local l_PlayerGui_0 = game.Players.LocalPlayer.PlayerGui;
        local l_ScreenGui_0 = Instance.new("ScreenGui");
        l_ScreenGui_0.Name = "JasonOutroOverlay";
        l_ScreenGui_0.ResetOnSpawn = false;
        l_ScreenGui_0.IgnoreGuiInset = true;
        l_ScreenGui_0.Parent = l_PlayerGui_0;
        local function _() --[[ Line: 656 ]] --[[ Name: check ]]
            -- upvalues: l_ScreenGui_0 (copy)
            if l_ScreenGui_0 and l_ScreenGui_0.Parent then
                return true;
            else
                return false;
            end;
        end;
        task.spawn(function() --[[ Line: 660 ]]
            -- upvalues: l_ScreenGui_0 (copy), l_TweenService_0 (ref)
            local l_CurrentCamera_0 = workspace.CurrentCamera;
            l_CurrentCamera_0.FieldOfView = 35;
            game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true);
            task.wait(1.53);
            if not (l_ScreenGui_0 and l_ScreenGui_0.Parent and true or false) then
                return;
            else
                local l_ColorCorrectionEffect_0 = Instance.new("ColorCorrectionEffect");
                l_ColorCorrectionEffect_0.Name = "JasonOutroCCEffect";
                l_ColorCorrectionEffect_0.Parent = game.Lighting;
                local l_BlurEffect_0 = Instance.new("BlurEffect");
                l_BlurEffect_0.Name = "JasonOutroBlurEffect";
                l_BlurEffect_0.Parent = game.Lighting;
                l_TweenService_0:Create(l_BlurEffect_0, TweenInfo.new(0.125), {
                    Size = 2
                }):Play();
                l_TweenService_0:Create(l_CurrentCamera_0, TweenInfo.new(0.42), {
                    FieldOfView = 46
                }):Play();
                task.wait(0.42);
                if not (l_ScreenGui_0 and l_ScreenGui_0.Parent and true or false) then
                    return;
                else
                    l_TweenService_0:Create(l_ColorCorrectionEffect_0, TweenInfo.new(0.125, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                        TintColor = Color3.fromRGB(190, 0, 3), 
                        Brightness = 0.4, 
                        Contrast = 0.2, 
                        Saturation = 0.5
                    }):Play();
                    l_TweenService_0:Create(l_BlurEffect_0, TweenInfo.new(0.125, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                        Size = 30
                    }):Play();
                    l_TweenService_0:Create(l_CurrentCamera_0, TweenInfo.new(0.15), {
                        FieldOfView = 32
                    }):Play();
                    task.wait(0.17);
                    if not (l_ScreenGui_0 and l_ScreenGui_0.Parent and true or false) then
                        return;
                    else
                        l_TweenService_0:Create(l_BlurEffect_0, TweenInfo.new(0.125), {
                            Size = 2
                        }):Play();
                        l_TweenService_0:Create(l_CurrentCamera_0, TweenInfo.new(0.15), {
                            FieldOfView = 35
                        }):Play();
                        task.wait(0.35);
                        if not (l_ScreenGui_0 and l_ScreenGui_0.Parent and true or false) then
                            return;
                        else
                            l_TweenService_0:Create(l_ColorCorrectionEffect_0, TweenInfo.new(0.125), {
                                TintColor = Color3.fromRGB(255, 105, 105), 
                                Brightness = 0, 
                                Contrast = 0, 
                                Saturation = 0
                            }):Play();
                            task.wait(0.61);
                            if not (l_ScreenGui_0 and l_ScreenGui_0.Parent and true or false) then
                                return;
                            else
                                l_TweenService_0:Create(l_ColorCorrectionEffect_0, TweenInfo.new(0.125), {
                                    TintColor = Color3.fromRGB(255, 226, 226)
                                }):Play();
                                l_TweenService_0:Create(l_CurrentCamera_0, TweenInfo.new(0.15), {
                                    FieldOfView = 32
                                }):Play();
                                task.wait(0.29);
                                if not (l_ScreenGui_0 and l_ScreenGui_0.Parent and true or false) then
                                    return;
                                else
                                    l_TweenService_0:Create(l_BlurEffect_0, TweenInfo.new(0.125), {
                                        Size = 1
                                    }):Play();
                                    l_TweenService_0:Create(l_ColorCorrectionEffect_0, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                                        TintColor = Color3.fromRGB(255, 255, 255)
                                    }):Play();
                                    l_TweenService_0:Create(l_CurrentCamera_0, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                        FieldOfView = 55
                                    }):Play();
                                    return;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end);
        return;
    else
        if v106 == "End" then
            if game.Players.LocalPlayer.PlayerGui:FindFirstChild("JasonOutroOverlay") then
                game.Players.LocalPlayer.PlayerGui.JasonOutroOverlay:Destroy();
            end;
            game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil);
            v10:SetAsCurrentLighting();
        end;
        return;
    end;
end;
v2.OnExecution = function(_, v117, v118) --[[ Line: 711 ]] --[[ Name: OnExecution ]]
    -- upvalues: v7 (copy)
    local v119 = v117.Rig.PrimaryPart.CFrame.LookVector * 100;
    local v120 = workspace:GetServerTimeNow() + 1.15;
    v7:FireAllClientConnection("Ragdoll", "REMOTE_EVENT", v118, v120, (("%*|%*|%*"):format(v119.X, v119.Y, v119.Z)));
    task.delay(1.125, function() --[[ Line: 720 ]]
        -- upvalues: v118 (copy)
        local l_Humanoid_1 = v118:FindFirstChild("Humanoid");
        if l_Humanoid_1 then
            l_Humanoid_1.BreakJointsOnDeath = false;
            l_Humanoid_1.Health = 0;
        end;
    end);
end;
return v2;