-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
local v5 = require(game.ReplicatedStorage.Modules.Network);
local v6 = require(game.ReplicatedStorage.Modules.AchievementUtil);
local function _(v7, v8, v9) --[[ Line: 12 ]] --[[ Name: getEnragedStatValue ]]
    return v7.Enraged and v7.Config[("Enraged%*%*"):format(v8, v9)] or v7.Config[("%*%*"):format(v8, v9)];
end;
local function v15(v11) --[[ Line: 17 ]] --[[ Name: pacify ]]
    -- upvalues: v1 (copy), v5 (copy), v2 (copy)
    if v11 and v11.Enraged and v11.Rig.Parent then
        v11.Enraged = nil;
        if game["Run Service"]:IsServer() then
            v11.Rig:SetAttribute("Invincible", nil);
            if v11.EnragedSFX then
                v11.EnragedSFX:Destroy();
                v11.EnragedSFX = nil;
            end;
            v1:Play(v11.Config.Sounds.EnragedEnd, {
                Parent = v11.Rig.PrimaryPart
            });
            for _, v13 in pairs(v11.Rig:GetDescendants()) do
                if v13.Name == "RagingPace" then
                    v13.Enabled = false;
                end;
            end;
            v5:FireClientConnection(v11.Player, "PacifyJason", "REMOTE_EVENT");
            return;
        elseif game["Run Service"]:IsClient() then
            v11.AnimationType = nil;
            v11.MovementAnimSpeed = nil;
            v5:FireConnection("DisableSprinting", "ENRAGED", false);
            v5:RemoveConnection("PacifyJason", "REMOTE_EVENT");
            if v11.TargetedPlayer then
                v2:RevealPlayerAura(v11.TargetedPlayer, v11.Config.EnragedAuraLingerTime);
                v11.TargetedPlayer = nil;
            end;
            if v11.SpeedModifier then
                game.TweenService:Create(v11.SpeedModifier, TweenInfo.new(1), {
                    Value = 1
                }):Play();
                game.Debris:AddItem(v11.SpeedModifier, 1);
            end;
            local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v11.Rig, 0.001, "Pacified");
            game.TweenService:Create(l_v2_SpeedMultiplier_0, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Value = 1
            }):Play();
            game.Debris:AddItem(l_v2_SpeedMultiplier_0, 1);
            require(game.ReplicatedStorage.Systems.Character.Game.Sprinting).StaminaCap = nil;
        end;
    end;
end;
v0.Abilities = {
    Slash = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://96590285148227", 
        KeybindType = "MainAbility", 
		Cooldown = function(v16, v17) --[[ Line: 79 ]] --[[ Name: Cooldown ]]
            return v16.Enraged and v16.Config[("Enraged%*%*"):format(v17, "Cooldown")] or v16.Config[("%*%*"):format(v17, "Cooldown")];
        end, 
        Callback = function(v18) --[[ Line: 80 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v2 (copy), v3 (copy), v4 (copy), v15 (copy)
            if game["Run Service"]:IsServer() then
                v18.AbilitiesDisabled = true;
                v1:Play(v18.Config.Sounds.Swing, {
                    Parent = v18.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.25
                });
                task.delay(0.075, function() --[[ Line: 87 ]]
                    -- upvalues: v18 (copy), v2 (ref)
                    if v18.Enraged then
                        local v19 = v2:ApplyVelocity(v18.Rig.PrimaryPart, v18.Config.EnragedSlashLungeForce);
                        game.TweenService:Create(v19, TweenInfo.new(1), {
                            LineVelocity = v19.LineVelocity / 100
                        }):Play();
                        game.Debris:AddItem(v19, 0.6);
                    end;
                end);
                task.delay(0.2, function() --[[ Line: 96 ]]
                    -- upvalues: v3 (ref), v18 (copy), v2 (ref), v4 (ref), v1 (ref), v15 (ref)
                    local l_v3_0 = v3;
                    local l_Player_0 = v18.Player;
                    local v22 = {
                        Size = Vector3.new(4.5, 6, 7.5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1.25)
                    };
                    local l_v18_0 = v18;
                    v22.Damage = l_v18_0.Enraged and l_v18_0.Config[("Enraged%*%*"):format("Slash", "Damage")] or l_v18_0.Config[("%*%*"):format("Slash", "Damage")];
                    v22.Time = 0.25;
                    v22.Knockback = 2;
                    v22.HitMultiple = true;
                    v22.ExecuteOnKill = true;
                    v22.Connections = {
                        Hit = function(v24, v25) --[[ Line: 108 ]] --[[ Name: Hit ]]
                            -- upvalues: v2 (ref), v4 (ref), v1 (ref), v18 (ref), v15 (ref)
                            v2:CreateSpeedMultiplier(v24, 1.5, "HitSpeedBonus", 1.25);
                            v4:ApplyStatus(v24, "Bleeding", {
                                Level = 1, 
                                Duration = 5
                            });
                            if v25 then
                                v1:Play(v18.Config.Sounds.Hit, {
                                    Parent = v18.Rig.PrimaryPart, 
                                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                    Volume = 0.25
                                });
                                v15(v18);
                            end;
                        end
                    };
                    l_v3_0 = l_v3_0:CreateHitbox(l_Player_0, v22);
                end);
                task.delay(0.5, function() --[[ Line: 121 ]]
                    -- upvalues: v15 (ref), v18 (copy)
                    v15(v18);
                end);
                task.delay(0.85, function() --[[ Line: 126 ]]
                    -- upvalues: v18 (copy)
                    v18.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v18.Animations.Slash:Play(0.025);
                end;
                return;
            end;
        end
    }, 
    Behead = {
        LayoutOrder = 2, 
        Icon = "rbxassetid://83553911625628", 
        KeybindType = "AltAbility1", 
        Cooldown = function(v26, v27) --[[ Line: 142 ]] --[[ Name: Cooldown ]]
            return v26.Enraged and v26.Config[("Enraged%*%*"):format(v27, "Cooldown")] or v26.Config[("%*%*"):format(v27, "Cooldown")];
        end, 
        Callback = function(v28) --[[ Line: 143 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v6 (copy), v2 (copy), v4 (copy), v15 (copy)
            if game["Run Service"]:IsServer() then
                v28.AbilitiesDisabled = true;
                v1:Play(v28.Config.Sounds.Swing, {
                    Parent = v28.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.25
                });
                task.delay(0.45, function() --[[ Line: 150 ]]
                    -- upvalues: v3 (ref), v28 (copy), v6 (ref), v2 (ref), v4 (ref), v1 (ref), v15 (ref)
                    local l_v3_1 = v3;
                    local l_Player_1 = v28.Player;
                    local v31 = {
                        Size = Vector3.new(8, 2, 7, 0), 
                        CFrameOffset = CFrame.new(0, 0, -2)
                    };
                    local l_v28_0 = v28;
                    v31.Damage = l_v28_0.Enraged and l_v28_0.Config[("Enraged%*%*"):format("Behead", "Damage")] or l_v28_0.Config[("%*%*"):format("Behead", "Damage")];
                    v31.Time = 0.15;
                    v31.Knockback = 2;
                    v31.HitMultiple = true;
                    v31.Connections = {
                        Hit = function(v33, v34) --[[ Line: 161 ]] --[[ Name: Hit ]]
                            -- upvalues: v6 (ref), v28 (ref), v2 (ref), v4 (ref), v1 (ref), v15 (ref)
                            if v33.Humanoid.Health <= 0 then
                                local l_Head_0 = v33:FindFirstChild("Head");
                                if l_Head_0 then
                                    l_Head_0:Destroy();
                                end;
                                v6:IncrementAchievementProgress(v28.Player, "JasonBrutality");
                                if tostring(v33.Parent) == "Survivors" then
                                    require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v28.Player, {
                                        Action = "Killed a Survivor with Behead", 
                                        RewardType = "DifficultKillerAction"
                                    });
                                end;
                            else
                                v2:CreateSpeedMultiplier(v33, 1.5, "HitSpeedBonus", 1.25);
                                v4:ApplyStatus(v33, "Helpless", {
                                    Level = 1, 
                                    Duration = 12
                                });
                                if tostring(v33.Parent) == "Survivors" then
                                    require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v28.Player, {
                                        Action = "Landed Behead hit", 
                                        RewardType = "EasyKillerAction"
                                    });
                                end;
                            end;
                            if v34 then
                                v1:Play(v28.Config.Sounds.Hit, {
                                    Parent = v28.Rig.PrimaryPart, 
                                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                    Volume = 0.25
                                });
                                v15(v28);
                            end;
                        end
                    };
                    l_v3_1 = l_v3_1:CreateHitbox(l_Player_1, v31);
                end);
                task.delay(0.5, function() --[[ Line: 199 ]]
                    -- upvalues: v15 (ref), v28 (copy)
                    v15(v28);
                end);
                task.delay(0.55, function() --[[ Line: 204 ]]
                    -- upvalues: v4 (ref), v28 (copy)
                    v4:ApplyStatus(v28.Rig, "Slowness", {
                        Level = 1, 
                        Duration = 2
                    });
                end);
                task.delay(1.65, function() --[[ Line: 209 ]]
                    -- upvalues: v28 (copy)
                    v28.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v28.Animations.Behead:Play(0.025);
                    local l_v2_SpeedMultiplier_1 = v2:CreateSpeedMultiplier(v28.Rig, 1, "BeheadAbility");
                    game.TweenService:Create(l_v2_SpeedMultiplier_1, TweenInfo.new(0.125), {
                        Value = v28.Enraged and v28.Config[("Enraged%*%*"):format("Behead", "Lunge")] or v28.Config[("%*%*"):format("Behead", "Lunge")]
                    }):Play();
                    task.delay(0.4, function() --[[ Line: 222 ]]
                        -- upvalues: l_v2_SpeedMultiplier_1 (copy)
                        game.TweenService:Create(l_v2_SpeedMultiplier_1, TweenInfo.new(0.3), {
                            Value = 0.2
                        }):Play();
                    end);
                    task.delay(1, function() --[[ Line: 227 ]]
                        -- upvalues: l_v2_SpeedMultiplier_1 (copy)
                        game.TweenService:Create(l_v2_SpeedMultiplier_1, TweenInfo.new(0.3), {
                            Value = 1
                        }):Play();
                        game.Debris:AddItem(l_v2_SpeedMultiplier_1, 0.3);
                    end);
                end;
                return;
            end;
        end
    }, 
    GashingWound = {
        LayoutOrder = 3, 
        Icon = "rbxassetid://132724488499212", 
        KeybindType = "AltAbility2", 
        Cooldown = function(v37, v38) --[[ Line: 240 ]] --[[ Name: Cooldown ]]
            return v37.Enraged and v37.Config[("Enraged%*%*"):format(v38, "Cooldown")] or v37.Config[("%*%*"):format(v38, "Cooldown")];
        end, 
        Callback = function(v39) --[[ Line: 241 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v2 (copy), v15 (copy)
            if game["Run Service"]:IsServer() then
                v39.AbilitiesDisabled = true;
                v39.Cache.GashingWoundStart:Play(0.05);
                v1:Play(v39.Config.Sounds.GashingWoundSwing, {
                    Parent = v39.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.25
                });
                local v40 = v39.Enraged and v39.Config[("Enraged%*%*"):format("GashingWound", "Damage")] or v39.Config[("%*%*"):format("GashingWound", "Damage")];
                local v41 = {
                    [0.333] = {
                        Damage = v40 / 5, 
                        Time = 0.15, 
                        DoLunge = true
                    }, 
                    [0.75] = {
                        Damage = v40 / 5, 
                        Time = 0.15, 
                        DoLunge = true
                    }, 
                    [1.533] = {
                        Damage = v40 / 5, 
                        Time = 0.15, 
                        DoLunge = true
                    }, 
                    [1.966] = {
                        Damage = v40 / 10, 
                        Time = 0.15, 
                        DoLunge = true
                    }, 
                    [2.333] = {
                        Damage = v40 / 10, 
                        Time = 0.15
                    }, 
                    [2.983] = {
                        Damage = v40 / 5, 
                        Time = 0.15, 
                        DoLunge = true
                    }
                };
                local _ = tick();
                local v43 = nil;
                local v44 = nil;
                local _ = nil;
                for v46, v47 in pairs(v41) do
                    task.delay(v46, function() --[[ Line: 286 ]]
                        -- upvalues: v46 (copy), v43 (ref), v3 (ref), v39 (copy), v47 (copy), v1 (ref), v44 (ref), v2 (ref)
                        if v46 >= 0.5 and not v43 then
                            return;
                        else
                            local _ = v3:CreateHitbox(v39.Player, {
                                Size = Vector3.new(8, 4, 8, 0), 
                                CFrameOffset = CFrame.new(0, 0, -2.25), 
                                Damage = v47.Damage, 
                                Time = v47.Time, 
                                Knockback = 0, 
                                HitMultiple = true, 
                                Connections = {
                                    Hit = function(v48, v49) --[[ Line: 300 ]] --[[ Name: Hit ]]
                                        -- upvalues: v1 (ref), v39 (ref), v46 (ref), v43 (ref), v44 (ref), v2 (ref)
                                        if v49 then
                                            v1:Play(v39.Config.Sounds.Hit, {
                                                Parent = v39.Rig.PrimaryPart, 
                                                PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                                Volume = 0.25
                                            });
                                        end;
                                        if v46 <= 0.5 and not v43 then
                                            v43 = v48;
                                            v43:SetPrimaryPartCFrame(v39.Rig.PrimaryPart.CFrame);
                                            v43.PrimaryPart.Anchored = true;
                                            v39.Rig.PrimaryPart.Anchored = true;
                                            v39.Rig:SetAttribute("Invincible", true);
                                            local l_GashingWound_0 = v39.Cache.GashingWound;
                                            l_GashingWound_0:Play(0);
                                            l_GashingWound_0.TimePosition = v39.Cache.GashingWoundStart.TimePosition;
                                            v44 = v2:LoadAnimationFromID(v43, v39.Config.Animations.GashingWound.PlayerRig, true);
                                            v44:Play(0.05);
                                            v44.TimePosition = v39.Cache.GashingWoundStart.TimePosition;
                                            v39.Cache.GashingWoundStart:Stop(0);
                                            v1:PlayVoiceline(v39, "GashingWoundHit", {
                                                Priority = 2
                                            });
                                            if tostring(v48.Parent) == "Survivors" then
                                                require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v39.Player, {
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
                task.delay(0.5, function() --[[ Line: 339 ]]
                    -- upvalues: v43 (ref), v1 (ref), v39 (copy), v44 (ref), v15 (ref)
                    local v52 = v43 and 4.25 or 0.5;
                    if not v43 then
                        v1:Play(v39.Config.Sounds.GashingWoundMiss, {
                            Parent = v39.Rig.PrimaryPart
                        });
                        v39.Rig:SetAttribute("Invincible", nil);
                    else
                        v1:Play(v39.Config.Sounds.GashingWoundHit, {
                            Parent = v39.Rig.PrimaryPart
                        });
                    end;
                    local l_StringValue_0 = Instance.new("StringValue");
                    l_StringValue_0.Name = "Result";
                    l_StringValue_0.Value = v43 and "HitPlayer" or "HitNothing";
                    l_StringValue_0.Parent = v39.Rig;
                    game.Debris:AddItem(l_StringValue_0, 5);
                    task.delay(v52 - 1.85, function() --[[ Line: 359 ]]
                        -- upvalues: v44 (ref), v43 (ref), v39 (ref), v52 (copy)
                        if v44 then
                            v44:Stop(0);
                        end;
                        if v43 and v43.PrimaryPart then
                            local v54 = RaycastParams.new();
                            v54.FilterDescendantsInstances = workspace.Players:GetDescendants();
                            v54.FilterType = Enum.RaycastFilterType.Exclude;
                            local v55 = workspace:Raycast(v39.Rig.PrimaryPart.Position, v39.Rig.PrimaryPart.CFrame.LookVector * 100, v54);
                            local v56 = v55 and math.clamp(v55.Distance, -1e999, 3) or 3;
                            if v56 < 3 then
                                v56 = -(v43.PrimaryPart.Size.Z / 2) - (3 - v56) * 2;
                            end;
                            v43:SetPrimaryPartCFrame(v39.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -v56));
                            v43.PrimaryPart.Anchored = false;
                            v43.PrimaryPart.Velocity = v39.Rig.PrimaryPart.CFrame.LookVector * (75 * (v56 / 3));
                            local v57 = require(game.ReplicatedStorage.Modules.Ragdolls);
                            if v43.Humanoid.Health <= 0 then
                                local v58 = v39.Rig.PrimaryPart.CFrame.LookVector * (75 * (v56 / 3));
                                local v59 = workspace:GetServerTimeNow() + (v52 - 1.85);
                                require(game.ReplicatedStorage.Modules.Network):FireAllClientConnection("Ragdoll", "REMOTE_EVENT", v43, v59, (("%*|%*|%*"):format(v58.X, v58.Y, v58.Z)));
                                return;
                            else
                                v57:Enable(v43);
                                task.wait(1.25);
                                v57:Disable(v43);
                            end;
                        end;
                    end);
                    task.delay(v52 + 0.25, function() --[[ Line: 414 ]]
                        -- upvalues: v15 (ref), v39 (ref)
                        v15(v39);
                    end);
                    task.delay(v52 + 0.75, function() --[[ Line: 419 ]]
                        -- upvalues: v39 (ref)
                        v39.Rig.PrimaryPart.Anchored = false;
                    end);
                    task.delay(v52 + 1.25, function() --[[ Line: 424 ]]
                        -- upvalues: v39 (ref)
                        v39.AbilitiesDisabled = false;
                    end);
                    task.delay(v52 + 1.5, function() --[[ Line: 429 ]]
                        -- upvalues: v39 (ref)
                        v39.Rig:SetAttribute("Invincible", nil);
                    end);
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    local l_v2_SpeedMultiplier_2 = v2:CreateSpeedMultiplier(v39.Rig, 1, "BeheadAbility");
                    game.TweenService:Create(l_v2_SpeedMultiplier_2, TweenInfo.new(0.2), {
                        Value = 0.001
                    }):Play();
                    local v61 = v39.Rig:WaitForChild("Result", 5);
                    if (v61 and v61.Value or "IDK") == "HitPlayer" then
                        task.delay(4.75, function() --[[ Line: 444 ]]
                            -- upvalues: l_v2_SpeedMultiplier_2 (copy)
                            game.TweenService:Create(l_v2_SpeedMultiplier_2, TweenInfo.new(0.2), {
                                Value = 1
                            }):Play();
                            game.Debris:AddItem(l_v2_SpeedMultiplier_2, 0.2);
                        end);
                        return;
                    else
                        task.delay(1, function() --[[ Line: 449 ]]
                            -- upvalues: l_v2_SpeedMultiplier_2 (copy)
                            game.TweenService:Create(l_v2_SpeedMultiplier_2, TweenInfo.new(0.2), {
                                Value = 1
                            }):Play();
                            game.Debris:AddItem(l_v2_SpeedMultiplier_2, 0.2);
                        end);
                    end;
                end;
                return;
            end;
        end
    }, 
    RagingPace = {
        LayoutOrder = 3, 
        Icon = "rbxassetid://112952508748158", 
        KeybindType = "AltAbility3", 
        Callback = function(v62) --[[ Line: 463 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v15 (copy), v5 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v62.AbilitiesDisabled = true;
                task.delay(0.233, function() --[[ Line: 469 ]]
                    -- upvalues: v62 (copy), v1 (ref)
                    v62.Enraged = true;
                    v62.Rig:SetAttribute("Invincible", true);
                    v62.EnragedSFX = v1:Play(v62.Config.Sounds.Enraged, {
                        Parent = v62.Rig.PrimaryPart, 
                        Looped = true, 
                        Volume = 0.25
                    });
                    v1:Play(v62.Config.Sounds.EnragedStart, {
                        Parent = v62.Rig.PrimaryPart
                    });
                    if v62.EnragedSFX then
                        game.Debris:AddItem(v62.EnragedSFX, v62.Config.EnragedTime);
                    end;
                    for _, v64 in pairs(v62.Rig:GetDescendants()) do
                        if v64.Name == "RagingPace" then
                            v64.Enabled = true;
                        end;
                    end;
                end);
                task.delay(v62.Config.EnragedTime, function() --[[ Line: 490 ]]
                    -- upvalues: v15 (ref), v62 (copy)
                    v15(v62);
                end);
                task.delay(1, function() --[[ Line: 495 ]]
                    -- upvalues: v62 (copy)
                    v62.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v62.Animations.EnragedStart:Play(0.025);
                    v62.AnimationType = "Enraged";
                    v62.MovementAnimSpeed = 1.425;
                    v62.Enraged = true;
                    v5:FireConnection("DisableSprinting", "ENRAGED", true);
                    v5:SetConnection("PacifyJason", "REMOTE_EVENT", function() --[[ Line: 506 ]]
                        -- upvalues: v15 (ref), v62 (copy)
                        v15(v62);
                    end);
                    v62.SpeedModifier = v2:CreateSpeedMultiplier(v62.Rig, 0.001, "ENRAGED");
                    task.delay(0.75, function() --[[ Line: 512 ]]
                        -- upvalues: v62 (copy)
                        game.TweenService:Create(v62.SpeedModifier, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                            Value = v62.Config.EnragedSpeed / v62.Config.Speed
                        }):Play();
                    end);
                    local l_v2_ClosestPlayerFromPosition_0 = v2:GetClosestPlayerFromPosition(v62.Rig.PrimaryPart.Position);
                    if l_v2_ClosestPlayerFromPosition_0 then
                        v62.TargetedPlayer = l_v2_ClosestPlayerFromPosition_0;
                        v2:RevealPlayerAura(l_v2_ClosestPlayerFromPosition_0, v62.Config.EnragedTime + 2);
                    end;
                    task.delay(1, function() --[[ Line: 524 ]]
                        -- upvalues: v62 (copy)
                        local v66 = tick();
                        while task.wait() and v62.Enraged and v62.Rig.Parent do
                            local v67 = math.clamp((tick() - v66) / v62.Config.EnragedStaminaCapLerpTime, 0, 1);
                            local v68 = v62.Config.MaxStamina + (v62.Config.EnragedStaminaCap - v62.Config.MaxStamina) * v67;
                            require(game.ReplicatedStorage.Systems.Character.Game.Sprinting).StaminaCap = v68;
                            if v67 >= 1 then
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
v0.Created = function(_, v70) --[[ Line: 546 ]] --[[ Name: Created ]]
    -- upvalues: v6 (copy), v2 (copy)
    if game["Run Service"]:IsServer() then
        if workspace:GetAttribute("JasonSpecialDay") then
            v6:IncrementAchievementProgress(v70.Player, "JasonSpecialDay");
        end;
        task.spawn(function() --[[ Line: 555 ]]
            -- upvalues: v70 (copy), v2 (ref)
            if not v70.Cache then
                v70.Cache = {};
            end;
            v70.Cache.GashingWoundStart = v2:LoadAnimationFromID(v70.Rig, v70.Config.Animations.GashingWoundStart);
            v70.Cache.GashingWound = v2:LoadAnimationFromID(v70.Rig, v70.Config.Animations.GashingWound.KillerRig);
        end);
    end;
end;
v0.OnIntroduction = function(_, _, v73, v74) --[[ Line: 564 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v2 (copy)
    local v75 = script.IntroWideDoor:Clone();
    v75:SetPrimaryPartCFrame(v73.PrimaryPart.CFrame);
    v75.Parent = v73;
    for _, v77 in pairs(v75.Joints:GetChildren()) do
        v77.Part1 = v75.Parts:FindFirstChild(v77.Name, true);
        v77.Part0 = v73.PrimaryPart;
    end;
    local l_v2_FOVMultiplier_0 = v2:CreateFOVMultiplier(game.Players.LocalPlayer, 0.4, "JasonIntroScene", v74);
    task.delay(0.783, function() --[[ Line: 580 ]]
        -- upvalues: l_v2_FOVMultiplier_0 (copy)
        l_v2_FOVMultiplier_0.Value = 0.35;
        game.TweenService:Create(l_v2_FOVMultiplier_0, TweenInfo.new(2.5, Enum.EasingStyle.Back), {
            Value = 0.45
        }):Play();
    end);
    local v79 = require(game.ReplicatedStorage.Modules.Schematics.Lighting);
    v79:SetCustomLighting(script.IntroLighting);
    task.delay(v74, function() --[[ Line: 590 ]]
        -- upvalues: v79 (copy)
        v79:SetAsCurrentLighting();
    end);
end;
v0.OnExecution = function(_, v81, v82) --[[ Line: 641 ]] --[[ Name: OnExecution ]]
    -- upvalues: v5 (copy)
    local v83 = v81.Rig.PrimaryPart.CFrame.LookVector * 100;
    local v84 = workspace:GetServerTimeNow() + 1.15;
    v5:FireAllClientConnection("Ragdoll", "REMOTE_EVENT", v82, v84, (("%*|%*|%*"):format(v83.X, v83.Y, v83.Z)));
    task.delay(1.125, function() --[[ Line: 650 ]]
        -- upvalues: v82 (copy)
        local l_Humanoid_0 = v82:FindFirstChild("Humanoid");
        if l_Humanoid_0 then
            l_Humanoid_0.BreakJointsOnDeath = false;
            l_Humanoid_0.Health = 0;
        end;
    end);
end;
return v0;