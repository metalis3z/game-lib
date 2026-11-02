-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
local v1 = {};
local v2 = require(game.ReplicatedStorage.Modules.Sounds);
local v3 = require(game.ReplicatedStorage.Modules.Util);
local v4 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v5 = require(game.ReplicatedStorage.Modules.Statuses);
local v6 = require(game.ReplicatedStorage.Modules.Network);
local _ = require(game.ReplicatedStorage.Modules.AchievementUtil);
v1.Abilities = {
    Combo = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://132724488499212", 
        KeybindType = "AltAbility1", 
        Cooldown = 5, 
        Callback = function(v8) --[[ Line: 17 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v4 (copy), v3 (copy)
            if game["Run Service"]:IsServer() then
                v8.AbilitiesDisabled = true;
                v8.Cache.GashingWoundStart:Play(0.05);
                task.delay(0.2, function() --[[ Line: 22 ]]
                    -- upvalues: v2 (ref), v8 (copy)
                    v2:Play(v8.Config.Sounds.GashingWoundSwing, {
                        Parent = v8.Rig.PrimaryPart, 
                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                        Volume = 0.25
                    });
                end);
                local v9 = {
                    [0.383] = {
                        Damage = 10, 
                        Time = 0.15, 
                        DoLunge = true
                    }, 
                    [1.083] = {
                        Damage = 35, 
                        Time = 0.15, 
                        DoLunge = true
                    }, 
                    [1.717] = {
                        Damage = 55, 
                        Time = 0.15, 
                        DoLunge = true
                    }
                };
                local _ = tick();
                local v11 = nil;
                local v12 = nil;
                local _ = nil;
                for v14, v15 in pairs(v9) do
                    task.delay(v14, function() --[[ Line: 48 ]]
                        -- upvalues: v14 (copy), v11 (ref), v15 (copy), v4 (ref), v8 (copy), v12 (ref), v3 (ref), v2 (ref)
                        if v14 >= 0.4 and not v11 then
                            return;
                        else
                            if not v15.DoLunge or not v11 then

                            end;
                            local _ = v4:CreateHitbox(v8.Player, {
                                Size = Vector3.new(8, 4, 8, 0), 
                                CFrameOffset = CFrame.new(0, 0, -2.25), 
                                Damage = v15.Damage, 
                                Time = v15.Time, 
                                Knockback = 0, 
                                HitMultiple = true, 
                                Connections = {
                                    Hit = function(v16, _) --[[ Line: 64 ]] --[[ Name: Hit ]]
                                        -- upvalues: v14 (ref), v11 (ref), v8 (ref), v12 (ref), v3 (ref), v2 (ref)
                                        if v14 <= 0.39 and not v11 then
                                            v11 = v16;
                                            v11:SetPrimaryPartCFrame(v8.Rig.PrimaryPart.CFrame);
                                            v11.PrimaryPart.Anchored = true;
                                            v8.Rig.PrimaryPart.Anchored = true;
                                            local l_GashingWound_0 = v8.Cache.GashingWound;
                                            l_GashingWound_0:Play(0);
                                            l_GashingWound_0.TimePosition = v8.Cache.GashingWoundStart.TimePosition;
                                            v12 = v3:LoadAnimationFromID(v11, v8.Config.Animations.GashingWound.PlayerRig, true);
                                            v12:Play(0.05);
                                            v12.TimePosition = v8.Cache.GashingWoundStart.TimePosition;
                                            v8.Cache.GashingWoundStart:Stop(0);
                                            v2:Play(v8.Config.Sounds.GashingWoundHit1, {
                                                Parent = v8.Rig.PrimaryPart
                                            });
                                            task.delay(0.7, function() --[[ Line: 83 ]]
                                                -- upvalues: v2 (ref), v8 (ref)
                                                v2:Play(v8.Config.Sounds.GashingWoundHit2, {
                                                    Parent = v8.Rig.PrimaryPart
                                                });
                                            end);
                                            task.delay(1.334, function() --[[ Line: 86 ]]
                                                -- upvalues: v2 (ref), v8 (ref)
                                                v2:Play(v8.Config.Sounds.GashingWoundHit3, {
                                                    Parent = v8.Rig.PrimaryPart
                                                });
                                                v2:Play(v8.Config.Sounds.GashingWoundHit4, {
                                                    Parent = v8.Rig.PrimaryPart, 
                                                    Volume = 0.25
                                                });
                                            end);
                                            task.spawn(function() --[[ Line: 91 ]]
                                                -- upvalues: v16 (copy)
                                                local v19 = require(game.ReplicatedStorage.Modules.Actors).CurrentActors[game.Players:GetPlayerFromCharacter(v16)];
                                                if v19 then
                                                    v19:DisableAbilities("Combo", true, 1.25);
                                                end;
                                            end);
                                        end;
                                    end
                                }
                            });
                            return;
                        end;
                    end);
                end;
                task.delay(1.82, function() --[[ Line: 106 ]]
                    -- upvalues: v11 (ref), v2 (ref), v8 (copy), v12 (ref)
                    local v21 = v11 and 1.82 or 0.39;
                    if not v11 then
                        v2:Play(v8.Config.Sounds.GashingWoundMiss, {
                            Parent = v8.Rig.PrimaryPart
                        });
                    end;
                    local l_StringValue_0 = Instance.new("StringValue");
                    l_StringValue_0.Name = "Result";
                    l_StringValue_0.Value = v11 and "HitPlayer" or "HitNothing";
                    l_StringValue_0.Parent = v8.Rig;
                    game.Debris:AddItem(l_StringValue_0, 5);
                    task.delay(v21 - 1.75, function() --[[ Line: 124 ]]
                        -- upvalues: v12 (ref), v11 (ref), v8 (ref)
                        if v12 then
                            v12:Stop(0);
                        end;
                        if v11 and v11.PrimaryPart then
                            v11:SetPrimaryPartCFrame(v8.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -3));
                            v11.PrimaryPart.Anchored = false;
                            local v23 = v8.Rig.PrimaryPart.CFrame.LookVector * 200;
                            task.delay(0.02, function() --[[ Line: 131 ]]
                                -- upvalues: v11 (ref), v23 (copy)
                                v11.PrimaryPart.Velocity = v23;
                            end);
                            local v24 = require(game.ReplicatedStorage.Modules.Ragdolls);
                            v24.AddProfile(v11, {
                                Velocity = v23
                            });
                            v24.EnableRagdoll(v11, 1.25);
                        end;
                    end);
                    task.delay(v21 - 1, function() --[[ Line: 145 ]]
                        -- upvalues: v8 (ref)
                        v8.Rig.PrimaryPart.Anchored = false;
                    end);
                    task.delay(v21, function() --[[ Line: 150 ]]
                        -- upvalues: v8 (ref)
                        v8.AbilitiesDisabled = false;
                    end);
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    local l_v3_SpeedMultiplier_0 = v3:CreateSpeedMultiplier(v8.Rig, 1, "Combo");
                    game.TweenService:Create(l_v3_SpeedMultiplier_0, TweenInfo.new(0.2), {
                        Value = 0.001
                    }):Play();
                    local v26 = v8.Rig:WaitForChild("Result", 5);
                    if (v26 and v26.Value or "IDK") == "HitPlayer" then
                        task.delay(0.25, function() --[[ Line: 165 ]]
                            -- upvalues: l_v3_SpeedMultiplier_0 (copy)
                            game.TweenService:Create(l_v3_SpeedMultiplier_0, TweenInfo.new(0.2), {
                                Value = 1
                            }):Play();
                            game.Debris:AddItem(l_v3_SpeedMultiplier_0, 0.2);
                        end);
                        return;
                    else
                        task.delay(0.4, function() --[[ Line: 170 ]]
                            -- upvalues: l_v3_SpeedMultiplier_0 (copy)
                            game.TweenService:Create(l_v3_SpeedMultiplier_0, TweenInfo.new(0.2), {
                                Value = 1
                            }):Play();
                            game.Debris:AddItem(l_v3_SpeedMultiplier_0, 0.2);
                        end);
                    end;
                end;
                return;
            end;
        end
    }, 
    QuickAttack = {
        LayoutOrder = 2, 
        KeybindType = "AltAbility2", 
        Cooldown = 5, 
        Icon = "rbxassetid://85282571177550", 
        Callback = function(v27, _) --[[ Line: 185 ]] --[[ Name: Callback ]]
            -- upvalues: v5 (copy), v2 (copy), v3 (copy), v4 (copy), v6 (copy)
            if game["Run Service"]:IsServer() then
                v27.AbilitiesDisabled = true;
                task.delay(0.75, function() --[[ Line: 191 ]]
                    -- upvalues: v27 (copy)
                    v27.AbilitiesDisabled = false;
                end);
                v5:ApplyStatus(v27.Rig, "Resistance", {
                    Level = 2, 
                    Duration = 0.7
                });
                task.delay(0.667, function() --[[ Line: 201 ]]
                    -- upvalues: v2 (ref), v27 (copy), v3 (ref), v4 (ref), v5 (ref)
                    v2:Play(v27.Config.Sounds.Slash, {
                        Parent = v27.Rig.PrimaryPart
                    });
                    local v29 = v3:ApplyVelocity(v27.Rig.PrimaryPart, 120);
                    game.TweenService:Create(v29, TweenInfo.new(1), {
                        VectorVelocity = v29.VectorVelocity / 100
                    }):Play();
                    game.Debris:AddItem(v29, 0.2);
                    local _ = v4:CreateHitbox(v27.Player, {
                        Size = Vector3.new(4, 6, 20, 0), 
                        CFrameOffset = CFrame.new(0, 0, -15.25), 
                        Damage = 100, 
                        Time = 0.25, 
                        Knockback = 25, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v30) --[[ Line: 219 ]] --[[ Name: Hit ]]
                                -- upvalues: v5 (ref), v27 (ref), v2 (ref)
                                v5:ApplyStatus(v30, "Stunned", {
                                    Duration = v27.Config.SlashStunTime
                                });
                                v2:Play(v27.Config.Sounds.GashingWoundHit3, {
                                    Parent = v27.Rig.PrimaryPart
                                });
                            end
                        }
                    });
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v27.Animations.QuickAttack:Play(0.1);
                    v6:FireConnection("DisableSprinting", "QuickAttack", true);
                    local l_v3_SpeedMultiplier_1 = v3:CreateSpeedMultiplier(v27.Rig, 0.01, "StunningKiller");
                    task.delay(0.7, function() --[[ Line: 236 ]]
                        -- upvalues: v6 (ref), l_v3_SpeedMultiplier_1 (copy)
                        v6:FireConnection("DisableSprinting", "QuickAttack", false);
                        l_v3_SpeedMultiplier_1:Destroy();
                    end);
                end;
                return;
            end;
        end
    }, 
    SuperDeathKillCombo = {
        LayoutOrder = 3, 
        Icon = "rbxassetid://132724488499212", 
        KeybindType = "AltAbility3", 
        Cooldown = 15, 
        Callback = function(v33) --[[ Line: 250 ]] --[[ Name: Callback ]]
            -- upvalues: v3 (copy), l_TweenService_0 (copy), v2 (copy), v4 (copy)
            if game["Run Service"]:IsServer() then
                v33.AbilitiesDisabled = true;
                v33.Cache.ComboStart:Play(0.05);
                task.delay(0.34, function() --[[ Line: 257 ]]
                    -- upvalues: v3 (ref), v33 (copy), l_TweenService_0 (ref), v2 (ref)
                    local v34 = v3:ApplyVelocity(v33.Rig.PrimaryPart, v33.Config.EnragedSlashLungeForce);
                    l_TweenService_0:Create(v34, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        LineVelocity = v34.LineVelocity / 100
                    }):Play();
                    game.Debris:AddItem(v34, 0.5);
                    v2:Play(v33.Config.Sounds.GashingWoundSwing, {
                        Parent = v33.Rig.PrimaryPart, 
                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                        Volume = 0.25
                    });
                end);
                local v35 = {
                    [0.79] = {
                        Damage = 35, 
                        Time = 0.15, 
                        DoLunge = true
                    }, 
                    [1.4] = {
                        Damage = 35, 
                        Time = 0.15, 
                        DoLunge = true
                    }, 
                    [2.4] = {
                        Damage = 15, 
                        Time = 0.15, 
                        DoLunge = true
                    }, 
                    [2.53] = {
                        Damage = 15, 
                        Time = 0.15, 
                        DoLunge = true
                    }, 
                    [2.7] = {
                        Damage = 15, 
                        Time = 0.15, 
                        DoLunge = true
                    }, 
                    [2.87] = {
                        Damage = 15, 
                        Time = 0.15, 
                        DoLunge = true
                    }, 
                    [3] = {
                        Damage = 15, 
                        Time = 0.15, 
                        DoLunge = true
                    }, 
                    [3.13] = {
                        Damage = 15, 
                        Time = 0.15, 
                        DoLunge = true
                    }, 
                    [3.46] = {
                        Damage = 100, 
                        Time = 0.15, 
                        DoLunge = true
                    }
                };
                local _ = tick();
                local v37 = nil;
                local v38 = nil;
                local _ = nil;
                for v40, v41 in pairs(v35) do
                    task.delay(v40, function() --[[ Line: 316 ]]
                        -- upvalues: v40 (copy), v37 (ref), v41 (copy), v4 (ref), v33 (copy), v38 (ref), v3 (ref), v2 (ref)
                        if v40 >= 0.8 and not v37 then
                            return;
                        else
                            if not v41.DoLunge or not v37 then

                            end;
                            local _ = v4:CreateHitbox(v33.Player, {
                                Size = Vector3.new(8, 1000, 8, 0), 
                                CFrameOffset = CFrame.new(0, 0, -2.25), 
                                Damage = v41.Damage, 
                                Time = v41.Time, 
                                Knockback = 0, 
                                HitMultiple = true, 
                                Connections = {
                                    Hit = function(v42, _) --[[ Line: 332 ]] --[[ Name: Hit ]]
                                        -- upvalues: v40 (ref), v37 (ref), v33 (ref), v38 (ref), v3 (ref), v2 (ref)
                                        if v40 <= 0.79 and not v37 then
                                            v37 = v42;
                                            v37:SetPrimaryPartCFrame(v33.Rig.PrimaryPart.CFrame);
                                            v37.PrimaryPart.Anchored = true;
                                            v33.Rig.PrimaryPart.Anchored = true;
                                            local l_Comboing_0 = v33.Cache.Comboing;
                                            l_Comboing_0:Play(0);
                                            l_Comboing_0.TimePosition = v33.Cache.ComboStart.TimePosition;
                                            v38 = v3:LoadAnimationFromID(v37, v33.Config.Animations.Comboing.PlayerRig, true);
                                            v38:Play(0.05);
                                            v38.TimePosition = v33.Cache.ComboStart.TimePosition;
                                            v33.Cache.ComboStart:Stop(0);
                                            v2:Play(v33.Config.Sounds.GashingWoundHit1, {
                                                Parent = v33.Rig.PrimaryPart
                                            });
                                            task.delay(0.61, function() --[[ Line: 351 ]]
                                                -- upvalues: v2 (ref), v33 (ref)
                                                v2:Play(v33.Config.Sounds.GashingWoundHit2, {
                                                    Parent = v33.Rig.PrimaryPart, 
                                                    PlaybackSpeed = Random.new():NextNumber(0.7, 1.3)
                                                });
                                            end);
                                            task.delay(1.61, function() --[[ Line: 355 ]]
                                                -- upvalues: v2 (ref), v33 (ref)
                                                v2:Play(v33.Config.Sounds.GashingWoundHit2, {
                                                    Parent = v33.Rig.PrimaryPart, 
                                                    PlaybackSpeed = Random.new():NextNumber(0.7, 1.3)
                                                });
                                            end);
                                            task.delay(1.74, function() --[[ Line: 359 ]]
                                                -- upvalues: v2 (ref), v33 (ref)
                                                v2:Play(v33.Config.Sounds.GashingWoundHit2, {
                                                    Parent = v33.Rig.PrimaryPart, 
                                                    PlaybackSpeed = Random.new():NextNumber(0.7, 1.3)
                                                });
                                            end);
                                            task.delay(1.91, function() --[[ Line: 363 ]]
                                                -- upvalues: v2 (ref), v33 (ref)
                                                v2:Play(v33.Config.Sounds.GashingWoundHit2, {
                                                    Parent = v33.Rig.PrimaryPart, 
                                                    PlaybackSpeed = Random.new():NextNumber(0.7, 1.3)
                                                });
                                            end);
                                            task.delay(2.08, function() --[[ Line: 367 ]]
                                                -- upvalues: v2 (ref), v33 (ref)
                                                v2:Play(v33.Config.Sounds.GashingWoundHit2, {
                                                    Parent = v33.Rig.PrimaryPart, 
                                                    PlaybackSpeed = Random.new():NextNumber(0.7, 1.3)
                                                });
                                            end);
                                            task.delay(2.21, function() --[[ Line: 371 ]]
                                                -- upvalues: v2 (ref), v33 (ref)
                                                v2:Play(v33.Config.Sounds.GashingWoundHit2, {
                                                    Parent = v33.Rig.PrimaryPart, 
                                                    PlaybackSpeed = Random.new():NextNumber(0.7, 1.3)
                                                });
                                            end);
                                            task.delay(2.34, function() --[[ Line: 375 ]]
                                                -- upvalues: v2 (ref), v33 (ref)
                                                v2:Play(v33.Config.Sounds.GashingWoundHit2, {
                                                    Parent = v33.Rig.PrimaryPart, 
                                                    PlaybackSpeed = Random.new():NextNumber(0.7, 1.3)
                                                });
                                            end);
                                            task.delay(2.67, function() --[[ Line: 378 ]]
                                                -- upvalues: v2 (ref), v33 (ref)
                                                v2:Play(v33.Config.Sounds.GashingWoundHit3, {
                                                    Parent = v33.Rig.PrimaryPart
                                                });
                                                v2:Play(v33.Config.Sounds.GashingWoundHit4, {
                                                    Parent = v33.Rig.PrimaryPart, 
                                                    Volume = 0.25
                                                });
                                                v2:Play(v33.Config.Sounds.GashingWoundHit2, {
                                                    Parent = v33.Rig.PrimaryPart, 
                                                    PlaybackSpeed = Random.new():NextNumber(0.7, 1.3)
                                                });
                                            end);
                                            task.spawn(function() --[[ Line: 384 ]]
                                                -- upvalues: v42 (copy)
                                                local v45 = require(game.ReplicatedStorage.Modules.Actors).CurrentActors[game.Players:GetPlayerFromCharacter(v42)];
                                                if v45 then
                                                    v45:DisableAbilities("Combo", true, 1.25);
                                                end;
                                            end);
                                        end;
                                    end
                                }
                            });
                            return;
                        end;
                    end);
                end;
                task.delay(0.79, function() --[[ Line: 399 ]]
                    -- upvalues: v37 (ref), v2 (ref), v33 (copy), v38 (ref)
                    local v47 = v37 and 5.25 or 0.79;
                    if not v37 then
                        v2:Play(v33.Config.Sounds.GashingWoundMiss, {
                            Parent = v33.Rig.PrimaryPart
                        });
                    end;
                    local l_StringValue_1 = Instance.new("StringValue");
                    l_StringValue_1.Name = "Result";
                    l_StringValue_1.Value = v37 and "HitPlayer" or "HitNothing";
                    l_StringValue_1.Parent = v33.Rig;
                    game.Debris:AddItem(l_StringValue_1, 6);
                    task.delay(v47 - 1.73, function() --[[ Line: 417 ]]
                        -- upvalues: v38 (ref), v37 (ref), v33 (ref)
                        if v38 then
                            v38:Stop(0);
                        end;
                        if v37 and v37.PrimaryPart then
                            v37:SetPrimaryPartCFrame(v33.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -3));
                            v37.PrimaryPart.Anchored = false;
                            local v49 = v33.Rig.PrimaryPart.CFrame.LookVector * 700;
                            task.delay(0.02, function() --[[ Line: 424 ]]
                                -- upvalues: v37 (ref), v49 (copy)
                                v37.PrimaryPart.Velocity = v49;
                            end);
                            local v50 = require(game.ReplicatedStorage.Modules.Ragdolls);
                            v50.AddProfile(v37, {
                                Velocity = v49
                            });
                            v50.EnableRagdoll(v37, 1.25);
                        end;
                    end);
                    task.delay(v47 - 1, function() --[[ Line: 438 ]]
                        -- upvalues: v33 (ref)
                        v33.Rig.PrimaryPart.Anchored = false;
                    end);
                    task.delay(v47, function() --[[ Line: 443 ]]
                        -- upvalues: v33 (ref)
                        v33.AbilitiesDisabled = false;
                    end);
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    local l_v3_SpeedMultiplier_2 = v3:CreateSpeedMultiplier(v33.Rig, 1, "Combo");
                    game.TweenService:Create(l_v3_SpeedMultiplier_2, TweenInfo.new(0.2), {
                        Value = 0.001
                    }):Play();
                    local v52 = v33.Rig:WaitForChild("Result", 5);
                    if (v52 and v52.Value or "IDK") == "HitPlayer" then
                        task.delay(0.25, function() --[[ Line: 458 ]]
                            -- upvalues: l_v3_SpeedMultiplier_2 (copy)
                            game.TweenService:Create(l_v3_SpeedMultiplier_2, TweenInfo.new(0.2), {
                                Value = 1
                            }):Play();
                            game.Debris:AddItem(l_v3_SpeedMultiplier_2, 0.2);
                        end);
                        return;
                    else
                        task.delay(0.4, function() --[[ Line: 463 ]]
                            -- upvalues: l_v3_SpeedMultiplier_2 (copy)
                            game.TweenService:Create(l_v3_SpeedMultiplier_2, TweenInfo.new(0.2), {
                                Value = 1
                            }):Play();
                            game.Debris:AddItem(l_v3_SpeedMultiplier_2, 0.2);
                        end);
                    end;
                end;
                return;
            end;
        end
    }
};
v1.Created = function(_, v54) --[[ Line: 474 ]] --[[ Name: Created ]]
    -- upvalues: v3 (copy)
    if game["Run Service"]:IsServer() then
        task.spawn(function() --[[ Line: 477 ]]
            -- upvalues: v54 (copy), v3 (ref)
            if not v54.Cache then
                v54.Cache = {};
            end;
            v54.Cache.GashingWoundStart = v3:LoadAnimationFromID(v54.Rig, v54.Config.Animations.GashingWoundStart);
            v54.Cache.GashingWound = v3:LoadAnimationFromID(v54.Rig, v54.Config.Animations.GashingWound.KillerRig);
            v54.Cache.ComboStart = v3:LoadAnimationFromID(v54.Rig, v54.Config.Animations.ComboStart);
            v54.Cache.Comboing = v3:LoadAnimationFromID(v54.Rig, v54.Config.Animations.Comboing.KillerRig);
        end);
    end;
end;
return v1;