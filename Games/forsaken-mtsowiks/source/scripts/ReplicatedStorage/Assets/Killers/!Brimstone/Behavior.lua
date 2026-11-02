-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_TweenService_0 = game:GetService("TweenService");
local v2 = require(game.ReplicatedStorage.Modules.Sounds);
local v3 = require(game.ReplicatedStorage.Modules.Util);
local v4 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v5 = require(game.ReplicatedStorage.Modules.Statuses);
local _ = require(game.ReplicatedStorage.Modules.Network);
local _ = require(game.ReplicatedStorage.Modules.AchievementUtil);
v0.Abilities = {
    Slash = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://92362553672440", 
        KeybindType = "MainAbility", 
        Cooldown = 0.5, 
        Callback = function(v8) --[[ Line: 19 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v4 (copy), v3 (copy), l_TweenService_0 (copy)
            if game["Run Service"]:IsServer() then
                v8.AbilitiesDisabled = true;
                v2:Play(v8.Config.Sounds.Swing, {
                    Parent = v8.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.35
                });
                task.delay(0.4, function() --[[ Line: 26 ]]
                    -- upvalues: v4 (ref), v8 (copy), v3 (ref), v2 (ref)
                    local _ = v4:CreateHitbox(v8.Player, {
                        Size = Vector3.new(4.5, 6, 7.5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1.25), 
                        Damage = v8.Config.SlashDamage, 
                        Time = 0.25, 
                        Knockback = 2, 
                        HitMultiple = true, 
                        ExecuteOnKill = false, 
                        Connections = {
                            Hit = function(v9, v10) --[[ Line: 39 ]] --[[ Name: Hit ]]
                                -- upvalues: v3 (ref), v2 (ref), v8 (ref)
                                v3:CreateSpeedMultiplier(v9, 1.5, "HitSpeedBonus", 1.25);
                                if v10 then
                                    v2:Play(v8.Config.Sounds.Hit, {
                                        Parent = v8.Rig.PrimaryPart, 
                                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                        Volume = 0.5
                                    });
                                end;
                            end
                        }
                    });
                end);
                task.delay(0.5, function() --[[ Line: 50 ]]
                    -- upvalues: v8 (copy)
                    v8.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v8.Animations.Slash:Play(0.025);
                    local l_v3_SpeedMultiplier_0 = v3:CreateSpeedMultiplier(v8.Rig, 1, "BeheadAbility");
                    l_TweenService_0:Create(l_v3_SpeedMultiplier_0, TweenInfo.new(0.125), {
                        Value = 1.2
                    }):Play();
                    task.delay(0.3, function() --[[ Line: 61 ]]
                        -- upvalues: l_TweenService_0 (ref), l_v3_SpeedMultiplier_0 (copy)
                        l_TweenService_0:Create(l_v3_SpeedMultiplier_0, TweenInfo.new(0.3), {
                            Value = 1
                        }):Play();
                        game.Debris:AddItem(l_v3_SpeedMultiplier_0, 0.3);
                    end);
                end;
                return;
            end;
        end
    }, 
    Dash = {
        LayoutOrder = 2, 
        Icon = "rbxassetid://101955457812737", 
        KeybindType = "AltAbility1", 
        Cooldown = 5, 
        Callback = function(v13) --[[ Line: 74 ]] --[[ Name: Callback ]]
            -- upvalues: v3 (copy), v4 (copy), v5 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v13.Behavior.ActivateFire(v13);
                v13.AbilitiesDisabled = true;
                v3:SetSpeedCap(v13.Rig, "C00lkiddWalkspeedOverride", 90);
                local _ = game:GetService("TweenService");
                task.delay(0.37, function() --[[ Line: 87 ]]
                    -- upvalues: v13 (copy), v4 (ref), v5 (ref), v3 (ref), v2 (ref)
                    v13.Behavior.EnableVoidstar(v13);
                    local v15 = nil;
                    local v16 = nil;
                    local l_v4_Hitbox_1 = v4:CreateHitbox(v13.Player, {
                        Size = Vector3.new(7, 5, 6, 0), 
                        Damage = 20, 
                        CFrameOffset = CFrame.new(0, 0, -1.5), 
                        Time = 1, 
                        Knockback = 10, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v17) --[[ Line: 100 ]] --[[ Name: Hit ]]
                                -- upvalues: v15 (ref), v5 (ref)
                                v15 = v17;
                                local v18 = 1;
                                local v19 = v5:PlayerHasStatus(v15, "Burning");
                                if v19 then
                                    v18 = (v19.Level or 1) + 1;
                                end;
                                v5:ApplyStatus(v15, "Burning", {
                                    Level = v18, 
                                    Duration = 8
                                });
                                v5:ApplyStatus(v17, "Slowness", {
                                    Level = 10, 
                                    Duration = 0.25, 
                                    Hidden = true
                                });
                            end, 
                            Ended = function() --[[ Line: 113 ]] --[[ Name: Ended ]]
                                -- upvalues: v16 (ref)
                                v16 = true;
                            end
                        }
                    });
                    local v21 = require(game.ReplicatedStorage.Modules.Network);
                    local l_LookVector_0 = v13.Rig.PrimaryPart.CFrame.LookVector;
                    local v23 = v3:ApplyVelocity(v13.Rig.PrimaryPart, 90);
                    v23.LineDirection = (l_LookVector_0 * Vector3.new(1, 0, 1, 0)).Unit;
                    game.Debris:AddItem(v23, 4);
                    game.TweenService:Create(v23, TweenInfo.new(1.5), {
                        LineVelocity = 45
                    }):Play();
                    local v24 = false;
                    local v25 = ("%*C00lkiddCollision"):format(v13.Player.Name);
                    v21:SetConnection(v25, "REMOTE_EVENT", function(v26) --[[ Line: 134 ]]
                        -- upvalues: v13 (ref), v24 (ref)
                        if v26 == v13.Player then
                            v24 = true;
                        end;
                    end);
                    repeat
                        task.wait();
                    until v15 or v16 or v24;
                    local v27 = "IDK";
                    if v15 then
                        v27 = "Hit";
                        v13.Rig:SetAttribute("Invincible", true);
                    elseif v24 then
                        v27 = "Collide";
                    elseif v16 then
                        v27 = "Timeout";
                    end;
                    local l_StringValue_0 = Instance.new("StringValue");
                    l_StringValue_0.Name = "Result";
                    l_StringValue_0.Value = v27;
                    l_StringValue_0.Parent = v13.Rig;
                    game.Debris:AddItem(l_StringValue_0, 1.5);
                    task.delay(1.5, function() --[[ Line: 162 ]]
                        -- upvalues: v13 (ref)
                        v13.AbilitiesDisabled = false;
                        v13.Rig:SetAttribute("Invincible", nil);
                    end);
                    game.TweenService:Create(v23, TweenInfo.new(v27 == "Collide" and 0.25 or 0.5), {
                        LineVelocity = 0
                    }):Play();
                    game.Debris:AddItem(v23, 1.5);
                    v2:PlayVoiceline(v13, ("WalkspeedOverride%*"):format(v27), {
                        Priority = 1.5
                    });
                    v2:Play(v13.Config.Sounds[("WalkspeedOverride%*"):format(v27)], {
                        Parent = v13.Rig.PrimaryPart
                    });
                    v3:SetSpeedCap(v13.Rig, "C00lkiddWalkspeedOverride", nil);
                    v21:RemoveConnection(v25, "REMOTE_EVENT");
                    l_v4_Hitbox_1:Cancel();
                end);
                task.delay(0.83, function() --[[ Line: 177 ]]
                    -- upvalues: v13 (copy), v4 (ref), v3 (ref), v5 (ref)
                    v13.Behavior.EnableVoidstar(v13);
                    v4:CreateHitbox(v13.Player, {
                        Size = Vector3.new(9.5, 8, 10, 0), 
                        CFrameOffset = CFrame.new(0, 0, -2), 
                        Damage = 15, 
                        Time = 0.2, 
                        Knockback = 5, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v29, _) --[[ Line: 189 ]] --[[ Name: Hit ]]
                                -- upvalues: v3 (ref), v5 (ref)
                                v3:CreateSpeedMultiplier(v29, 1.5, "HitSpeedBonus", 2.5);
                                local v31 = 1;
                                local v32 = v5:PlayerHasStatus(v29, "Burning");
                                if v32 then
                                    v31 = (v32.Level or 1) + 1;
                                end;
                                v5:ApplyStatus(v29, "Burning", {
                                    Level = v31, 
                                    Duration = 5
                                });
                            end
                        }
                    });
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v13.Animations.Dash:Play();
                    v13.Rig:SetAttribute("FootstepsMuted", true);
                    local l_v3_SpeedMultiplier_1 = v3:CreateSpeedMultiplier(v13.Player, 0, "HinderedMovement");
                    local v34 = nil;
                    do
                        local l_v34_0 = v34;
                        task.spawn(function() --[[ Line: 213 ]]
                            -- upvalues: v13 (copy), l_v34_0 (ref)
                            v13.Rig.PrimaryPart:WaitForChild("LinearVelocity", 2);
                            local v36 = 0;
                            local v37 = false;
                            while true do
                                if not l_v34_0 and v13.Rig.PrimaryPart then
                                    if v36 >= 0.2 and v13.Rig.PrimaryPart.AssemblyLinearVelocity.Magnitude <= 30 then
                                        if not v37 then
                                            require(game.ReplicatedStorage.Modules.Network):FireServerConnection(("%*C00lkiddCollision"):format(v13.Player.Name), "REMOTE_EVENT");
                                            v37 = true;
                                        end;
                                        return;
                                    else
                                        v36 = v36 + game["Run Service"].Heartbeat:Wait();
                                    end;
                                else
                                    return;
                                end;
                            end;
                        end);
                        local v38 = v13.Rig:WaitForChild("Result", 6);
                        l_v34_0 = v38 and v38.Value or "IDK BRUH";
                        v13.Rig:SetAttribute("FootstepsMuted", nil);
                        if v38 then
                            repeat
                                task.wait();
                            until not v38.Parent;
                        end;
                        game.TweenService:Create(l_v3_SpeedMultiplier_1, TweenInfo.new(0.5), {
                            Value = 1
                        }):Play();
                        game.Debris:AddItem(l_v3_SpeedMultiplier_1, 0.5);
                    end;
                end;
                return;
            end;
        end
    }, 
    Fire = {
        LayoutOrder = 3, 
        Icon = "rbxassetid://112065267803856", 
        KeybindType = "AltAbility2", 
        Cooldown = 5, 
        Callback = function(v39) --[[ Line: 253 ]] --[[ Name: Callback ]]
            -- upvalues: v4 (copy), v3 (copy), v5 (copy), l_TweenService_0 (copy)
            if game["Run Service"]:IsServer() then
                v39.AbilitiesDisabled = true;
                v39.Rig:SetAttribute("FootstepsMuted", true);
                v39.Behavior.ActivateFire(v39);
                task.delay(0.48, function() --[[ Line: 260 ]]
                    -- upvalues: v39 (copy), v4 (ref), v3 (ref), v5 (ref)
                    v39.Behavior.EnableVoidstar(v39);
                    v4:CreateHitbox(v39.Player, {
                        Size = Vector3.new(9.5, 4, 10, 0), 
                        CFrameOffset = CFrame.new(0, 0, -2), 
                        Damage = 20, 
                        Time = 0.2, 
                        Knockback = 5, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v40, _) --[[ Line: 272 ]] --[[ Name: Hit ]]
                                -- upvalues: v3 (ref), v5 (ref), v39 (ref)
                                v3:CreateSpeedMultiplier(v40, 1.5, "HitSpeedBonus", 2.5);
                                local v42 = 1;
                                local v43 = v5:PlayerHasStatus(v40, "Burning");
                                v3:RevealPlayerAuraTo(v39.Player, v40, 10);
                                if v43 then
                                    v42 = (v43.Level or 1) + 1;
                                end;
                                v5:ApplyStatus(v40, "Burning", {
                                    Level = v42, 
                                    Duration = 5
                                });
                            end
                        }
                    });
                end);
                task.delay(0.8, function() --[[ Line: 288 ]]
                    -- upvalues: v39 (copy), v4 (ref), v3 (ref), v5 (ref)
                    v39.Behavior.EnableVoidstar(v39);
                    v4:CreateHitbox(v39.Player, {
                        Size = Vector3.new(9.5, 4, 10, 0), 
                        CFrameOffset = CFrame.new(0, 0, -2), 
                        Damage = 5, 
                        Time = 0.2, 
                        Knockback = 5, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v44, _) --[[ Line: 301 ]] --[[ Name: Hit ]]
                                -- upvalues: v3 (ref), v5 (ref)
                                v3:CreateSpeedMultiplier(v44, 1.5, "HitSpeedBonus", 2.5);
                                local v46 = 1;
                                local v47 = v5:PlayerHasStatus(v44, "Burning");
                                if v47 then
                                    v46 = (v47.Level or 1) + 1;
                                end;
                                v5:ApplyStatus(v44, "Burning", {
                                    v46; 
                                    Duration = 8
                                });
                            end
                        }
                    });
                end);
                task.delay(1.28, function() --[[ Line: 315 ]]
                    -- upvalues: v39 (copy), v4 (ref), v3 (ref), v5 (ref)
                    v39.Behavior.EnableVoidstar(v39);
                    v4:CreateHitbox(v39.Player, {
                        Size = Vector3.new(9.5, 4, 10, 0), 
                        CFrameOffset = CFrame.new(0, 0, -2), 
                        Damage = 5, 
                        Time = 0.2, 
                        Knockback = 5, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v48, _) --[[ Line: 328 ]] --[[ Name: Hit ]]
                                -- upvalues: v3 (ref), v5 (ref)
                                v3:CreateSpeedMultiplier(v48, 1.5, "HitSpeedBonus", 2.5);
                                local v50 = 1;
                                local v51 = v5:PlayerHasStatus(v48, "Burning");
                                if v51 then
                                    v50 = (v51.Level or 1) + 1;
                                end;
                                v5:ApplyStatus(v48, "Burning", {
                                    v50; 
                                    Duration = 8
                                });
                            end
                        }
                    });
                end);
                task.delay(2.07, function() --[[ Line: 342 ]]
                    -- upvalues: v39 (copy), v4 (ref), v3 (ref), v5 (ref)
                    v39.Behavior.EnableVoidstar(v39);
                    v4:CreateHitbox(v39.Player, {
                        Size = Vector3.new(9.5, 4, 10, 0), 
                        CFrameOffset = CFrame.new(0, 0, -2), 
                        Damage = 5, 
                        Time = 0.2, 
                        Knockback = 5, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v52, _) --[[ Line: 355 ]] --[[ Name: Hit ]]
                                -- upvalues: v3 (ref), v5 (ref)
                                v3:CreateSpeedMultiplier(v52, 1.5, "HitSpeedBonus", 2.5);
                                local v54 = 1;
                                local v55 = v5:PlayerHasStatus(v52, "Burning");
                                if v55 then
                                    v54 = (v55.Level or 1) + 1;
                                end;
                                v5:ApplyStatus(v52, "Burning", {
                                    v54; 
                                    Duration = 8
                                });
                            end
                        }
                    });
                end);
                task.delay(3.5, function() --[[ Line: 373 ]]
                    -- upvalues: v39 (copy)
                    v39.AbilitiesDisabled = false;
                    v39.Rig:SetAttribute("FootstepsMuted", nil);
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v39.Animations.Fire:Play(0.175, 0.9, nil);
                    local l_v3_SpeedMultiplier_2 = v3:CreateSpeedMultiplier(v39.Rig, 1, "BeheadAbility");
                    task.delay(0.48, function() --[[ Line: 385 ]]
                        -- upvalues: l_TweenService_0 (ref), l_v3_SpeedMultiplier_2 (copy)
                        l_TweenService_0:Create(l_v3_SpeedMultiplier_2, TweenInfo.new(0.125), {
                            Value = 2
                        }):Play();
                        task.delay(0.2, function() --[[ Line: 387 ]]
                            -- upvalues: l_TweenService_0 (ref), l_v3_SpeedMultiplier_2 (ref)
                            l_TweenService_0:Create(l_v3_SpeedMultiplier_2, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                                Value = 0.35
                            }):Play();
                        end);
                    end);
                    task.delay(0.8, function() --[[ Line: 389 ]]
                        -- upvalues: l_TweenService_0 (ref), l_v3_SpeedMultiplier_2 (copy)
                        l_TweenService_0:Create(l_v3_SpeedMultiplier_2, TweenInfo.new(0.125), {
                            Value = 1.2
                        }):Play();
                        task.delay(0.2, function() --[[ Line: 391 ]]
                            -- upvalues: l_TweenService_0 (ref), l_v3_SpeedMultiplier_2 (ref)
                            l_TweenService_0:Create(l_v3_SpeedMultiplier_2, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                                Value = 0.35
                            }):Play();
                        end);
                    end);
                    task.delay(1.28, function() --[[ Line: 393 ]]
                        -- upvalues: l_TweenService_0 (ref), l_v3_SpeedMultiplier_2 (copy)
                        l_TweenService_0:Create(l_v3_SpeedMultiplier_2, TweenInfo.new(0.125), {
                            Value = 1.4
                        }):Play();
                        task.delay(0.2, function() --[[ Line: 395 ]]
                            -- upvalues: l_TweenService_0 (ref), l_v3_SpeedMultiplier_2 (ref)
                            l_TweenService_0:Create(l_v3_SpeedMultiplier_2, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                                Value = 0.35
                            }):Play();
                        end);
                    end);
                    task.delay(2.07, function() --[[ Line: 397 ]]
                        -- upvalues: l_TweenService_0 (ref), l_v3_SpeedMultiplier_2 (copy)
                        l_TweenService_0:Create(l_v3_SpeedMultiplier_2, TweenInfo.new(0.125), {
                            Value = 2
                        }):Play();
                        task.delay(0.2, function() --[[ Line: 399 ]]
                            -- upvalues: l_TweenService_0 (ref), l_v3_SpeedMultiplier_2 (ref)
                            l_TweenService_0:Create(l_v3_SpeedMultiplier_2, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                                Value = 0.35
                            }):Play();
                        end);
                    end);
                    task.delay(2.3, function() --[[ Line: 401 ]]
                        -- upvalues: l_TweenService_0 (ref), l_v3_SpeedMultiplier_2 (copy)
                        l_TweenService_0:Create(l_v3_SpeedMultiplier_2, TweenInfo.new(0.125), {
                            Value = 0.01
                        }):Play();
                    end);
                    task.delay(3, function() --[[ Line: 404 ]]
                        -- upvalues: l_TweenService_0 (ref), l_v3_SpeedMultiplier_2 (copy)
                        l_TweenService_0:Create(l_v3_SpeedMultiplier_2, TweenInfo.new(0.3), {
                            Value = 1
                        }):Play();
                        game.Debris:AddItem(l_v3_SpeedMultiplier_2, 0.4);
                    end);
                end;
                return;
            end;
        end
    }, 
    Ashes = {
        LayoutOrder = 4, 
        Icon = "rbxassetid://112065267803856", 
        KeybindType = "AltAbility3", 
        Callback = function(v57) --[[ Line: 417 ]] --[[ Name: Callback ]]
            -- upvalues: v4 (copy), v3 (copy), v5 (copy)
            if game["Run Service"]:IsServer() then
                v57.AbilitiesDisabled = true;
                task.delay(1, function() --[[ Line: 424 ]]
                    -- upvalues: v57 (copy), v4 (ref), v3 (ref), v5 (ref)
                    if v57.Rig:GetAttribute("Stunned") then
                        return;
                    else
                        local v58 = v57.Config.WindSlashProjectile:Clone();
                        local l_PrimaryPart_0 = v58.PrimaryPart;
                        v58.Parent = workspace.Map.Ingame;
                        v58:SetPrimaryPartCFrame(v57:GetPivot() * CFrame.new(0, 0, 2));
                        local v60 = l_PrimaryPart_0.CFrame * CFrame.new(0, 0, -25000);
                        game.Debris:AddItem(v58, 100);
                        game.TweenService:Create(l_PrimaryPart_0, TweenInfo.new(100, Enum.EasingStyle.Linear), {
                            CFrame = v60
                        }):Play();
                        v57.Behavior.ActivateFire(v57);
                        v4:CreateHitbox(v57.Player, {
                            Size = Vector3.new(8, 5, 6, 0), 
                            CFrame = function() --[[ Line: 438 ]] --[[ Name: CFrame ]]
                                -- upvalues: l_PrimaryPart_0 (copy)
                                return l_PrimaryPart_0.CFrame;
                            end, 
                            Damage = 25, 
                            Time = 100, 
                            Knockback = 0.5, 
                            HitMultiple = true, 
                            PredictVelocity = false, 
                            Connections = {
                                Hit = function(v61) --[[ Line: 447 ]] --[[ Name: Hit ]]
                                    -- upvalues: v3 (ref), v5 (ref), v4 (ref), v57 (ref), l_PrimaryPart_0 (copy)
                                    v3:CreateSpeedMultiplier(v61, 1.5, "HitSpeedBonus", 2.5);
                                    local v62 = 1;
                                    local v63 = v5:PlayerHasStatus(v61, "Burning");
                                    if v63 then
                                        v62 = (v63.Level or 1) + 1;
                                    end;
                                    v5:ApplyStatus(v61, "Burning", {
                                        v62; 
                                        Duration = 8
                                    });
                                    v4:CreateHitbox(v57.Player, {
                                        Size = Vector3.new(10, 10, 10, 0), 
                                        CFrame = function() --[[ Line: 460 ]] --[[ Name: CFrame ]]
                                            -- upvalues: l_PrimaryPart_0 (ref)
                                            return l_PrimaryPart_0.CFrame;
                                        end, 
                                        Damage = 25, 
                                        Time = 0.5, 
                                        Knockback = 10, 
                                        HitMultiple = true, 
                                        PredictVelocity = false, 
                                        Connections = {
                                            Hit = function(v64) --[[ Line: 469 ]] --[[ Name: Hit ]]
                                                -- upvalues: v3 (ref), v5 (ref)
                                                v3:CreateSpeedMultiplier(v64, 1.5, "HitSpeedBonus", 2.5);
                                                local v65 = 1;
                                                local v66 = v5:PlayerHasStatus(v64, "Burning");
                                                if v66 then
                                                    v65 = (v66.Level or 1) + 3;
                                                end;
                                                v5:ApplyStatus(v64, "Burning", {
                                                    v65; 
                                                    Duration = 8
                                                });
                                            end
                                        }
                                    });
                                end
                            }
                        });
                        return;
                    end;
                end);
                task.delay(1.5, function() --[[ Line: 488 ]]
                    -- upvalues: v57 (copy)
                    v57.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v57.Animations.Ashes:Play(0.175, 0.9, nil);
                    v3:CreateSpeedMultiplier(v57.Player, 0.45, "MassInfection", 2, true);
                end;
                return;
            end;
        end
    }, 
    BURN = {
        LayoutOrder = 5, 
        Icon = "rbxassetid://112065267803856", 
        KeybindType = "AltAbility4", 
        Cooldown = 5, 
        Callback = function(v67) --[[ Line: 509 ]] --[[ Name: Callback ]]
            -- upvalues: v4 (copy), v3 (copy), v5 (copy), l_TweenService_0 (copy)
            if game["Run Service"]:IsServer() then
                v67.AbilitiesDisabled = true;
                v67.Rig:SetAttribute("FootstepsMuted", true);
                v67.Behavior.ActivateFire(v67);
                task.delay(1.06, function() --[[ Line: 516 ]]
                    -- upvalues: v67 (copy), v4 (ref), v3 (ref), v5 (ref)
                    v67.Behavior.EnableVoidstar(v67);
                    v4:CreateHitbox(v67.Player, {
                        Size = Vector3.new(6, 6, 7.5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1.25), 
                        Damage = 5, 
                        Time = 0.3, 
                        Knockback = 0.5, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v68, _) --[[ Line: 528 ]] --[[ Name: Hit ]]
                                -- upvalues: v3 (ref), v5 (ref)
                                v3:CreateSpeedMultiplier(v68, 1.5, "HitSpeedBonus", 2.5);
                                local v70 = 1;
                                local v71 = v5:PlayerHasStatus(v68, "Burning");
                                if v71 then
                                    v70 = (v71.Level or 1) + 1;
                                end;
                                v5:ApplyStatus(v68, "Burning", {
                                    Level = v70, 
                                    Duration = 5
                                });
                            end
                        }
                    });
                end);
                task.delay(1.8, function() --[[ Line: 542 ]]
                    -- upvalues: v67 (copy), v4 (ref), v3 (ref), v5 (ref)
                    v67.Behavior.EnableVoidstar(v67);
                    v4:CreateHitbox(v67.Player, {
                        Size = Vector3.new(6, 6, 7.5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1.25), 
                        Damage = 5, 
                        Time = 0.3, 
                        Knockback = 0.5, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v72, _) --[[ Line: 555 ]] --[[ Name: Hit ]]
                                -- upvalues: v3 (ref), v5 (ref)
                                v3:CreateSpeedMultiplier(v72, 1.5, "HitSpeedBonus", 2.5);
                                local v74 = 1;
                                local v75 = v5:PlayerHasStatus(v72, "Burning");
                                if v75 then
                                    v74 = (v75.Level or 1) + 1;
                                end;
                                v5:ApplyStatus(v72, "Burning", {
                                    v74; 
                                    Duration = 8
                                });
                            end
                        }
                    });
                end);
                task.delay(2.4, function() --[[ Line: 569 ]]
                    -- upvalues: v67 (copy), v4 (ref), v3 (ref), v5 (ref)
                    v67.Behavior.EnableVoidstar(v67);
                    v4:CreateHitbox(v67.Player, {
                        Size = Vector3.new(6, 6, 7.5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1.25), 
                        Damage = 5, 
                        Time = 0.3, 
                        Knockback = 0.5, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v76, _) --[[ Line: 582 ]] --[[ Name: Hit ]]
                                -- upvalues: v3 (ref), v5 (ref)
                                v3:CreateSpeedMultiplier(v76, 1.5, "HitSpeedBonus", 2.5);
                                local v78 = 1;
                                local v79 = v5:PlayerHasStatus(v76, "Burning");
                                if v79 then
                                    v78 = (v79.Level or 1) + 1;
                                end;
                                v5:ApplyStatus(v76, "Burning", {
                                    v78; 
                                    Duration = 8
                                });
                            end
                        }
                    });
                end);
                task.delay(3, function() --[[ Line: 596 ]]
                    -- upvalues: v67 (copy), v4 (ref), v3 (ref), v5 (ref)
                    v67.Behavior.EnableVoidstar(v67);
                    v4:CreateHitbox(v67.Player, {
                        Size = Vector3.new(6, 6, 7.5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1.25), 
                        Damage = 5, 
                        Time = 0.3, 
                        Knockback = 0.5, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v80, _) --[[ Line: 610 ]] --[[ Name: Hit ]]
                                -- upvalues: v3 (ref), v5 (ref)
                                v3:CreateSpeedMultiplier(v80, 1.5, "HitSpeedBonus", 2.5);
                                local v82 = 1;
                                local v83 = v5:PlayerHasStatus(v80, "Burning");
                                if v83 then
                                    v82 = (v83.Level or 1) + 1;
                                end;
                                v5:ApplyStatus(v80, "Burning", {
                                    v82; 
                                    Duration = 8
                                });
                            end
                        }
                    });
                end);
                task.delay(5, function() --[[ Line: 624 ]]
                    -- upvalues: v67 (copy), l_TweenService_0 (ref), v4 (ref), v3 (ref), v5 (ref)
                    v67.Behavior.EnableVoidstar(v67);
                    v67.Behavior.ActivateFire(v67);
                    local l_ColorCorrectionEffect_0 = Instance.new("ColorCorrectionEffect");
                    l_ColorCorrectionEffect_0.Parent = game.Lighting;
                    l_ColorCorrectionEffect_0.Name = "BlackFlash";
                    l_ColorCorrectionEffect_0.Brightness = 1;
                    l_ColorCorrectionEffect_0.Contrast = 30;
                    l_ColorCorrectionEffect_0.Saturation = -1;
                    l_ColorCorrectionEffect_0.TintColor = Color3.fromRGB(255, 0, 0);
                    l_ColorCorrectionEffect_0.Enabled = true;
                    l_TweenService_0:Create(l_ColorCorrectionEffect_0, TweenInfo.new(3, Enum.EasingStyle.Quart), {
                        Saturation = 0
                    }):Play();
                    l_TweenService_0:Create(l_ColorCorrectionEffect_0, TweenInfo.new(3, Enum.EasingStyle.Quart), {
                        Contrast = 0
                    }):Play();
                    l_TweenService_0:Create(l_ColorCorrectionEffect_0, TweenInfo.new(3, Enum.EasingStyle.Quart), {
                        Brightness = 0
                    }):Play();
                    l_TweenService_0:Create(l_ColorCorrectionEffect_0, TweenInfo.new(3, Enum.EasingStyle.Quart), {
                        TintColor = Color3.fromRGB(255, 255, 255)
                    }):Play();
                    v4:CreateHitbox(v67.Player, {
                        Size = Vector3.new(50, 8, 50, 0), 
                        CFrameOffset = CFrame.new(0, 3, 0), 
                        Damage = 50, 
                        Time = 0.3, 
                        Knockback = 0.5, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v85, _) --[[ Line: 652 ]] --[[ Name: Hit ]]
                                -- upvalues: v3 (ref), v5 (ref)
                                v3:CreateSpeedMultiplier(v85, 1.5, "HitSpeedBonus", 2.5);
                                local v87 = 1;
                                local v88 = v5:PlayerHasStatus(v85, "Burning");
                                if v88 then
                                    v87 = (v88.Level or 1) + 5;
                                end;
                                v5:ApplyStatus(v85, "Burning", {
                                    v87; 
                                    Duration = 5
                                });
                            end
                        }
                    });
                end);
                task.delay(6.5, function() --[[ Line: 670 ]]
                    -- upvalues: v67 (copy)
                    v67.AbilitiesDisabled = false;
                    v67.Rig:SetAttribute("FootstepsMuted", nil);
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v67.Animations.ForsakenSlash:Play(0.175, 0.9, nil);
                    local l_v3_SpeedMultiplier_3 = v3:CreateSpeedMultiplier(v67.Rig, 1, "BeheadAbility");
                    l_TweenService_0:Create(l_v3_SpeedMultiplier_3, TweenInfo.new(0.125), {
                        Value = 0.75
                    }):Play();
                    task.delay(1.06, function() --[[ Line: 683 ]]
                        -- upvalues: l_TweenService_0 (ref), l_v3_SpeedMultiplier_3 (copy)
                        l_TweenService_0:Create(l_v3_SpeedMultiplier_3, TweenInfo.new(0.125), {
                            Value = 4
                        }):Play();
                        task.delay(0.2, function() --[[ Line: 685 ]]
                            -- upvalues: l_TweenService_0 (ref), l_v3_SpeedMultiplier_3 (ref)
                            l_TweenService_0:Create(l_v3_SpeedMultiplier_3, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
                                Value = 0.25
                            }):Play();
                        end);
                    end);
                    task.delay(1.8, function() --[[ Line: 687 ]]
                        -- upvalues: l_TweenService_0 (ref), l_v3_SpeedMultiplier_3 (copy)
                        l_TweenService_0:Create(l_v3_SpeedMultiplier_3, TweenInfo.new(0.125), {
                            Value = 3
                        }):Play();
                        task.delay(0.2, function() --[[ Line: 689 ]]
                            -- upvalues: l_TweenService_0 (ref), l_v3_SpeedMultiplier_3 (ref)
                            l_TweenService_0:Create(l_v3_SpeedMultiplier_3, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
                                Value = 0.25
                            }):Play();
                        end);
                    end);
                    task.delay(2.4, function() --[[ Line: 691 ]]
                        -- upvalues: l_TweenService_0 (ref), l_v3_SpeedMultiplier_3 (copy)
                        l_TweenService_0:Create(l_v3_SpeedMultiplier_3, TweenInfo.new(0.125), {
                            Value = 2.75
                        }):Play();
                        task.delay(0.2, function() --[[ Line: 693 ]]
                            -- upvalues: l_TweenService_0 (ref), l_v3_SpeedMultiplier_3 (ref)
                            l_TweenService_0:Create(l_v3_SpeedMultiplier_3, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
                                Value = 0.25
                            }):Play();
                        end);
                    end);
                    task.delay(3, function() --[[ Line: 695 ]]
                        -- upvalues: l_TweenService_0 (ref), l_v3_SpeedMultiplier_3 (copy)
                        l_TweenService_0:Create(l_v3_SpeedMultiplier_3, TweenInfo.new(0.125), {
                            Value = 2.5
                        }):Play();
                        task.delay(0.2, function() --[[ Line: 697 ]]
                            -- upvalues: l_TweenService_0 (ref), l_v3_SpeedMultiplier_3 (ref)
                            l_TweenService_0:Create(l_v3_SpeedMultiplier_3, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
                                Value = 0.25
                            }):Play();
                        end);
                        task.delay(0.4, function() --[[ Line: 698 ]]
                            -- upvalues: l_TweenService_0 (ref), l_v3_SpeedMultiplier_3 (ref)
                            l_TweenService_0:Create(l_v3_SpeedMultiplier_3, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
                                Value = 0.175
                            }):Play();
                        end);
                    end);
                    task.delay(5, function() --[[ Line: 700 ]]
                        -- upvalues: l_TweenService_0 (ref), l_v3_SpeedMultiplier_3 (copy)
                        l_TweenService_0:Create(l_v3_SpeedMultiplier_3, TweenInfo.new(0.125), {
                            Value = 0.01
                        }):Play();
                    end);
                    task.delay(6.5, function() --[[ Line: 703 ]]
                        -- upvalues: l_TweenService_0 (ref), l_v3_SpeedMultiplier_3 (copy)
                        l_TweenService_0:Create(l_v3_SpeedMultiplier_3, TweenInfo.new(0.5), {
                            Value = 1
                        }):Play();
                        game.Debris:AddItem(l_v3_SpeedMultiplier_3, 0.75);
                    end);
                end;
                return;
            end;
        end
    }
};
v0.Created = function(_, v91) --[[ Line: 714 ]] --[[ Name: Created ]]
    -- upvalues: v3 (copy), v5 (copy)
    if game["Run Service"]:IsServer() then
        local l_Folder_0 = Instance.new("Folder");
        l_Folder_0.Name = "JohnDoeTrail";
        l_Folder_0.Parent = v91.Rig;
        for _ = 1, math.clamp(math.round(v91.Config.TrailLength / 4), 2, 1e999) do
            local v94 = v91.Config.Trail:Clone();
            v94.Position = v91.Rig.PrimaryPart.Position - Vector3.new(0, 4.5, 0, 0);
            v94.Parent = l_Folder_0;
            v94:SetAttribute("FinishedUpdating", true);
            v3:ApplyOnTouched(v94, false, function(_, v96) --[[ Line: 730 ]]
                -- upvalues: v5 (ref)
                local l_Parent_0 = v96.Parent;
                local l_Humanoid_0 = l_Parent_0:FindFirstChild("Humanoid");
                if l_Humanoid_0 and l_Humanoid_0.Health > 0 and tostring(l_Parent_0.Parent) ~= "Killers" then
                    v5:ApplyStatus(l_Parent_0, "Burning", {
                        Duration = 2, 
                        Level = 1
                    });
                end;
            end);
        end;
        local l_l_Folder_0_Children_0 = l_Folder_0:GetChildren();
        local v100 = 0;
        local v101 = 0;
        local v102 = nil;
        do
            local l_v100_0, l_v101_0, l_v102_0 = v100, v101, v102;
            l_v102_0 = game["Run Service"].Heartbeat:Connect(function(v106) --[[ Line: 745 ]]
                -- upvalues: v91 (copy), l_Folder_0 (copy), l_v102_0 (ref), l_v101_0 (ref), l_l_Folder_0_Children_0 (copy), l_v100_0 (ref)
                if not v91 or not v91.Rig.Parent or not v91.Rig.PrimaryPart then
                    l_Folder_0:Destroy();
                    l_v102_0:Disconnect();
                    l_v102_0 = nil;
                    return;
                elseif l_v101_0 <= 0.05 then
                    l_v101_0 = l_v101_0 + v106;
                    return;
                else
                    l_v101_0 = 0;
                    local v107 = l_l_Folder_0_Children_0[l_v100_0 % #l_l_Folder_0_Children_0 + 1];
                    local v108 = l_l_Folder_0_Children_0[(l_v100_0 - 1) % #l_l_Folder_0_Children_0 + 1];
                    if v107 and v108 then
                        if v107.Size.Z <= 4 or v107:GetAttribute("FinishedUpdating") then
                            if v107:GetAttribute("FinishedUpdating") then
                                v107:SetAttribute("FinishedUpdating", nil);
                            end;
                            local v109 = v91.Rig.PrimaryPart.Position - Vector3.new(0, 3, 0, 0);
                            v107.CFrame = CFrame.new(v108:GetPivot().Position) * CFrame.lookAt(v108:GetPivot().Position, v109).Rotation * CFrame.Angles(0, 0, 0);
                            v107.Size = Vector3.new(v107.Size.X, v107.Size.Y, (v107.Position - v109).Magnitude);
                            v107.PivotOffset = CFrame.new(0, 0, -v107.Size.Z / 2);
                            v107.CFrame = v107.CFrame * v107.PivotOffset;
                            return;
                        else
                            v107:SetAttribute("FinishedUpdating", true);
                            l_v100_0 = l_v100_0 + 1;
                            return;
                        end;
                    else
                        l_v100_0 = l_v100_0 + 1;
                        return;
                    end;
                end;
            end);
        end;
    end;
end;
v0.EnableVoidstar = function(v110) --[[ Line: 786 ]] --[[ Name: EnableVoidstar ]]
    assert(v110, "must pass killerInfo as argument");
    if v110.Behavior.VoidstarEnabled then
        return;
    else
        v110.Behavior.VoidstarEnabled = true;
        local l_AttachmentFreak_0 = v110.Rig.Crescendo.CrescendoSword.AttachmentFreak;
        for _, v113 in ipairs(l_AttachmentFreak_0:GetChildren()) do
            if v113:IsA("Trail") then
                v113.Enabled = true;
            end;
        end;
        task.delay(0.2, function() --[[ Line: 801 ]]
            -- upvalues: l_AttachmentFreak_0 (copy)
            for _, v115 in ipairs(l_AttachmentFreak_0:GetChildren()) do
                if v115:IsA("Trail") then
                    v115.Enabled = false;
                end;
            end;
        end);
        return;
    end;
end;
v0.ActivateFire = function(v116) --[[ Line: 810 ]] --[[ Name: ActivateFire ]]
    assert(v116, "must pass killerInfo as argument");
    local l_Rig_0 = v116.Rig;
    local v118 = l_Rig_0 and l_Rig_0:FindFirstChild("CrescendoSword", true);
    if not v118 then
        return;
    else
        for v119 = 1, 7 do
            local l_v118_FirstChild_0 = v118:FindFirstChild("Ignite" .. v119);
            if l_v118_FirstChild_0 and l_v118_FirstChild_0:IsA("ParticleEmitter") then
                l_v118_FirstChild_0.Enabled = true;
                l_v118_FirstChild_0:Emit(5);
            end;
        end;
        local l_Ignition_0 = v118:FindFirstChild("Ignition");
        if l_Ignition_0 and l_Ignition_0:IsA("ParticleEmitter") then
            l_Ignition_0:Emit(25);
        end;
        task.delay(3, function() --[[ Line: 830 ]]
            -- upvalues: v118 (copy)
            for v122 = 1, 7 do
                local l_v118_FirstChild_1 = v118:FindFirstChild("Ignite" .. v122);
                if l_v118_FirstChild_1 and l_v118_FirstChild_1:IsA("ParticleEmitter") then
                    l_v118_FirstChild_1.Enabled = false;
                    l_v118_FirstChild_1:Emit(5);
                end;
            end;
        end);
        return;
    end;
end;
v0.GetRig = function(_, v125) --[[ Line: 841 ]] --[[ Name: GetRig ]]
    local v126 = v125.Rig:Clone();
    v126.Parent = workspace;
    v126:SetPrimaryPartCFrame(CFrame.new(0, 100000, 0));
    pcall(function() --[[ Line: 847 ]]
        -- upvalues: v125 (copy), v126 (copy)
        local l_HumanoidDescriptionFromUserId_0 = game.Players:GetHumanoidDescriptionFromUserId(v125.Player.UserId);
        l_HumanoidDescriptionFromUserId_0.Head = 0;
        l_HumanoidDescriptionFromUserId_0.Face = 0;
        v126.Humanoid:ApplyDescription(l_HumanoidDescriptionFromUserId_0, Enum.AssetTypeVerification.Always);
        for _, v129 in pairs(v126:GetChildren()) do
            if v129:IsA("CharacterMesh") and v129.MeshId ~= 48112070 then
                v129:Destroy();
            end;
        end;
    end);
    return v126;
end;
return v0;