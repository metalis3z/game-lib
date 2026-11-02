local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Util);
local v2 = require(game.ReplicatedStorage.Modules.Statuses);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Network);
local v5 = require(game.ReplicatedStorage.Modules.Sounds);
local v6 = require(game.ReplicatedStorage.Modules.AchievementUtil);
local function _(v7, v8, v9) --[[ Line: 14 ]] --[[ Name: pcallMethod ]]
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 15 ]]
        -- upvalues: v9 (copy), v7 (copy)
        if v9.Behavior[v7] then
            v9.Behavior[v7](v9);
        end;
    end);
    if not l_status_0 then
        warn((("[%*]: Failed to call .%*() due to: %*"):format(v8, v7, l_result_0)));
    end;
end;
v0.Abilities = {
    Block = {
        LayoutOrder = 1, 
        KeybindType = "AltAbility1", 
        Icon = "rbxassetid://137576632569674", 
        Callback = function(v13, _) --[[ Line: 31 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v0 (copy), v1 (copy), v5 (copy)
            if game["Run Service"]:IsServer() then
                v13.DisabledAbilities = {
                    Block = true, 
                    Charge = true
                };
                v2:ApplyStatus(v13.Player, "Resistance", {
                    Level = v13.Config.ResistanceLevel, 
                    Duration = v13.Config.BlockDuration
                });
                local l_QueryHitbox_0 = v13.Rig.QueryHitbox;
                if not v0.DefaultHitboxSize then
                    v0.DefaultHitboxSize = v13.Rig.QueryHitbox.Size;
                end;
                l_QueryHitbox_0.Size = v0.DefaultHitboxSize * Vector3.new(2.0999999046325684, 1.2000000476837158, 2.0999999046325684, 0);
                local l_v1_SpeedMultiplier_0 = v1:CreateSpeedMultiplier(v13.Rig, 0.4, "GuestBlocking");
                if v13.BlockingSlowness then
                    v13.BlockingSlowness:Destroy();
                end;
                v13.BlockingSlowness = l_v1_SpeedMultiplier_0;
                task.delay(v13.Config.SlownessDuration, function() --[[ Line: 56 ]]
                    -- upvalues: l_v1_SpeedMultiplier_0 (copy)
                    if l_v1_SpeedMultiplier_0 then
                        game.TweenService:Create(l_v1_SpeedMultiplier_0, TweenInfo.new(1), {
                            Value = 1
                        }):Play();
                        game.Debris:AddItem(l_v1_SpeedMultiplier_0, 1);
                    end;
                end);
                local l_BlockCount_0 = v13.BlockCount;
                task.delay(2, function() --[[ Line: 65 ]]
                    -- upvalues: l_BlockCount_0 (copy), v13 (copy)
                    if l_BlockCount_0 == v13.BlockCount then
                        v13.BlockCount = 0;
                    end;
                end);
                if v13.BlockThread then
                    task.cancel(v13.BlockThread);
                end;
                v13.Blocking = true;
                v13.BlockThread = task.delay(v13.Config.BlockDuration, function() --[[ Line: 74 ]]
                    -- upvalues: v13 (copy), l_QueryHitbox_0 (copy), v0 (ref)
                    v13.Blocking = nil;
                    if not v13.Blocked then
                        l_QueryHitbox_0.Size = v0.DefaultHitboxSize;
                    end;
                end);
                v5:Play(v13.Config.Sounds.BlockStart, {
                    Parent = v13.Rig.PrimaryPart
                });
                task.delay(v13.Config.SlownessDuration, function() --[[ Line: 85 ]]
                    -- upvalues: v13 (copy)
                    v13.DisabledAbilities = nil;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v13.Animations.Block:Play(0.175);
                end;
                return;
            end;
        end
    }, 
    Charge = {
        LayoutOrder = 2, 
        KeybindType = "AltAbility2", 
        Icon = "rbxassetid://73254549946762", 
        Callback = function(v18, v19) --[[ Line: 101 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v5 (copy), v6 (copy), v4 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v18.DisabledAbilities = {
                    Block = true, 
                    Charge = true
                };
                v1:SetSpeedCap(v18.Player, "GuestCharging", v18.Config.ChargingSpeed / v18.Config.Speed);
                local v20 = ("%*/ChargeStart"):format(script.Parent);
                local l_pcall_0 = pcall;
                local v22 = "ChargeStart";
                local v23;
                l_pcall_0, v23 = l_pcall_0(function() --[[ Line: 15 ]]
                    -- upvalues: v18 (copy), v22 (copy)
                    if v18.Behavior[v22] then
                        v18.Behavior[v22](v18);
                    end;
                end);
                if not l_pcall_0 then
                    warn((("[%*]: Failed to call .%*() due to: %*"):format(v20, "ChargeStart", v23)));
                end;
                v18.Rig:SetAttribute("GuestCharging", true);
                v20 = ("Result%*"):format((tostring(math.random(-10000, 10000))));
                task.delay(0.125, function() --[[ Line: 115 ]]
                    -- upvalues: v18 (copy), v3 (ref), v1 (ref), v5 (ref), v6 (ref), v4 (ref), v20 (copy), v2 (ref)
                    local l_PrimaryPart_0 = v18.Rig.PrimaryPart;
                    local v25 = nil;
                    local v26 = nil;
                    local l_v3_Hitbox_0 = v3:CreateHitbox(v18.Player, {
                        Size = Vector3.new(4, 5, 6, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1), 
                        Damage = v18.Config.ChargeDamage, 
                        Time = v18.Config.ChargingDuration, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v27) --[[ Line: 128 ]] --[[ Name: Hit ]]
                                -- upvalues: v25 (ref), v18 (ref), v1 (ref), v5 (ref), l_PrimaryPart_0 (copy), v6 (ref)
                                if not workspace:GetAttribute("CooldownsDisabled") then
                                    v25 = v27;
                                end;
                                if v25 then
                                    if not v25:GetAttribute("PreviouslyChargedInto") then
                                        v25:SetAttribute("PreviouslyChargedInto", true);
                                        task.delay(v18.Config.KillerChargeResistanceDuration, function() --[[ Line: 138 ]]
                                            -- upvalues: v25 (ref)
                                            v25:SetAttribute("PreviouslyChargedInto", nil);
                                        end);
                                        if v25:GetAttribute("VoidRushState") == "Dashing" then
                                            v6:IncrementAchievementProgress(v18.Player, "NoliCar");
                                            v6:IncrementAchievementProgress(game.Players:GetPlayerFromCharacter(v25), "NoliCar");
                                        end;
                                    else
                                        v1:ApplyDamage(v18.Rig, v18.Config.KillerChargeResistanceDamage);
                                        v5:Play(v18.Config.Sounds.ChargingHit, {
                                            Parent = l_PrimaryPart_0
                                        });
                                        return;
                                    end;
                                end;
                                task.spawn(function() --[[ Line: 153 ]]
                                    -- upvalues: v27 (copy)
                                    local v28 = require(game.ReplicatedStorage.Modules.Actors).CurrentActors[game.Players:GetPlayerFromCharacter(v27)];
                                    if v28 then
                                        v28:DisableAbilities("Guest1337Charge", true, 1.25);
                                    end;
                                end);
                                v1:CreateSpeedMultiplier(v27, 0.3, "Guest1337ChargedInto", 0.35);
                                v5:Play(v18.Config.Sounds.ChargingHit, {
                                    Parent = l_PrimaryPart_0
                                });
                                local v29 = l_PrimaryPart_0.CFrame.LookVector * v18.Config.ChargeKnockback * 10;
                                local l_PrimaryPart_1 = v27.PrimaryPart;
                                if l_PrimaryPart_1 then
                                    l_PrimaryPart_1.Velocity = v29;
                                end;
                            end, 
                            Ended = function() --[[ Line: 175 ]] --[[ Name: Ended ]]
                                -- upvalues: v26 (ref)
                                v26 = true;
                            end
                        }
                    });
                    local v32 = v5:Play(v18.Config.Sounds.ChargingStart, {
                        Parent = l_PrimaryPart_0
                    });
                    local v33 = false;
                    local v34 = ("%*Guest1337Collision"):format(v18.Player.Name);
                    v4:SetConnection(v34, "REMOTE_EVENT", function(v35) --[[ Line: 185 ]]
                        -- upvalues: v18 (ref), v33 (ref)
                        if v35 == v18.Player then
                            v33 = true;
                        end;
                    end);
                    repeat
                        task.wait();
                    until v25 or v26 or v33;
                    local v36 = ("%*/ChargeEnd"):format(script.Parent);
                    local l_v18_0 = v18;
                    local l_pcall_1 = pcall;
                    local v39 = "ChargeEnd";
                    local l_l_v18_0_0 = l_v18_0 --[[ copy: 8 -> 12 ]];
                    local l_v39_0 = v39 --[[ copy: 11 -> 13 ]];
                    local v42;
                    l_pcall_1, v42 = l_pcall_1(function() --[[ Line: 15 ]]
                        -- upvalues: l_l_v18_0_0 (copy), l_v39_0 (copy)
                        if l_l_v18_0_0.Behavior[l_v39_0] then
                            l_l_v18_0_0.Behavior[l_v39_0](l_l_v18_0_0);
                        end;
                    end);
                    if not l_pcall_1 then
                        warn((("[%*]: Failed to call .%*() due to: %*"):format(v36, "ChargeEnd", v42)));
                    end;
                    v18.Rig:SetAttribute("GuestCharging", nil);
                    v36 = "IDK";
                    if v25 then
                        v36 = "Hit";
                    elseif v33 then
                        v36 = "Collide";
                    elseif v26 then
                        v36 = "Timeout";
                    end;
                    v5:PlayVoiceline(v18, ("Charge%*"):format(v36), {
                        Priority = 1
                    });
                    l_v18_0 = Instance.new("StringValue");
                    l_v18_0.Name = v20;
                    l_v18_0.Value = v36;
                    l_v18_0.Parent = v18.Rig;
                    game.Debris:AddItem(l_v18_0, 1);
                    if v36 == "Hit" then
                        v2:ApplyStatus(v18.Player, "Resistance", {
                            Level = 5, 
                            Duration = 1.25
                        });
                    else
                        l_pcall_1, v42 = v1:GetClosestPlayerFromPosition(l_PrimaryPart_0.Position, {
                            PlayerSelection = "Killers"
                        });
                        if not v42 then
                            v42 = 999;
                        end;
                        v39 = math.clamp(math.floor(v42 / v18.Config.ChargePunishmentDistanceInterval) * v18.Config.ChargePunishmentSlownessDurationMultiplier, 0, v18.Config.ChargePunishmentSlownessMaxDuration);
                        if v39 > 0 then
                            v2:ApplyStatus(v18.Player, "Slowness", {
                                Duration = v39, 
                                Level = v18.Config.ChargePunishmentSlownessLevel
                            });
                        end;
                    end;
                    task.delay(0.25, function() --[[ Line: 232 ]]
                        -- upvalues: v18 (ref)
                        v18.DisabledAbilities = nil;
                    end);
                    if v32 then
                        game.TweenService:Create(v32, TweenInfo.new(0.2), {
                            Volume = 0
                        }):Play();
                    end;
                    if v36 ~= "Hit" then
                        v5:Play(v18.Config.Sounds[("Charging%*"):format(v36)], {
                            Parent = l_PrimaryPart_0
                        });
                    end;
                    v4:RemoveConnection(v34, "REMOTE_EVENT");
                    l_v3_Hitbox_0:Cancel();
                    v1:SetSpeedCap(v18.Player, "GuestCharging", nil);
                end);
                return v20;
            else
                if game["Run Service"]:IsClient() then
                    v18.Animations.Charge:Play();
                    v18.MovementAnimSpeed = 2.25;
                    v4:FireConnection("DisableSprinting", "GuestCharge", true);
                    local v43 = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting);
                    v43.StaminaCap = tonumber(v43.Stamina) or 100;
                    local l_v1_FOVMultiplier_0 = v1:CreateFOVMultiplier(v18.Player, 1, "Guest1337Charge");
                    game.TweenService:Create(l_v1_FOVMultiplier_0, TweenInfo.new(0.8), {
                        Value = 0.75
                    }):Play();
                    local l_v1_SpeedMultiplier_1 = v1:CreateSpeedMultiplier(v18.Rig, v18.Config.ChargingSpeed / v18.Config.Speed, "Guest1337Charge");
                    local l_LookVector_0 = workspace.CurrentCamera.CFrame.LookVector;
                    local l_Unit_0 = Vector3.new(l_LookVector_0.X, 0, l_LookVector_0.Z).Unit;
                    local v48 = Vector3.new(0, 0, 0, 0);
                    local v49 = 0;
                    local v50 = false;
                    pcall(function() --[[ Line: 273 ]]
                        game["Run Service"]:UnbindFromRenderStep("GuestCharging");
                    end);
                    do
                        local l_l_Unit_0_0, l_v48_0, l_v49_0, l_v50_0 = l_Unit_0, v48, v49, v50;
                        game["Run Service"]:BindToRenderStep("GuestCharging", Enum.RenderPriority.Character.Value + 1, function(v55) --[[ Line: 274 ]]
                            -- upvalues: v18 (copy), l_v49_0 (ref), l_v50_0 (ref), v4 (ref), l_v48_0 (ref), l_l_Unit_0_0 (ref)
                            if not v18.Rig.Parent or not v18.Rig.PrimaryPart then
                                game["Run Service"]:UnbindFromRenderStep("GuestCharging");
                                return;
                            else
                                l_v49_0 = l_v49_0 + v55;
                                if l_v49_0 >= 0.3 and v18.Rig.PrimaryPart.Velocity.Magnitude <= v18.Config.ChargingSpeed / 2 then
                                    if not l_v50_0 then
                                        l_v50_0 = true;
                                        v4:FireServerConnection(("%*Guest1337Collision"):format(v18.Player.Name), "REMOTE_EVENT");
                                    end;
                                    return;
                                else
                                    local l_LookVector_1 = workspace.CurrentCamera.CFrame.LookVector;
                                    l_v48_0 = Vector3.new(l_LookVector_1.X, 0, l_LookVector_1.Z).Unit;
                                    local v57 = l_v48_0 - l_l_Unit_0_0;
                                    local l_Magnitude_0 = v57.Magnitude;
                                    if l_Magnitude_0 > 0 then
                                        local v59 = v18.Config.ChargingTurnSpeed * v55;
                                        if l_Magnitude_0 <= v59 then
                                            l_l_Unit_0_0 = l_v48_0;
                                        else
                                            l_l_Unit_0_0 = l_l_Unit_0_0 + v57.Unit * v59;
                                        end;
                                        l_l_Unit_0_0 = l_l_Unit_0_0.Unit;
                                    end;
                                    v18.Rig.Humanoid:Move(l_l_Unit_0_0);
                                    return;
                                end;
                            end;
                        end);
                        local v60 = v18.Rig:WaitForChild(v19, v18.Config.ChargingDuration + 0.5);
                        local v61 = v60 and v60.Value;
                        if v60 then
                            v60:Destroy();
                        end;
                        if v61 == "Hit" or v61 == "Collide" then
                            local l_v1_SpeedMultiplier_2 = v1:CreateSpeedMultiplier(v18.Rig, 0.2, "GuestChargeEnded");
                            game.TweenService:Create(l_v1_SpeedMultiplier_2, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                Value = 1
                            }):Play();
                            game.Debris:AddItem(l_v1_SpeedMultiplier_2, 1);
                        end;
                        game["Run Service"]:UnbindFromRenderStep("GuestCharging");
                        v4:FireConnection("DisableSprinting", "GuestCharge", false);
                        v18.Animations.Charge:Stop();
                        v18.MovementAnimSpeed = nil;
                        v43.StaminaCap = nil;
                        game.TweenService:Create(l_v1_FOVMultiplier_0, TweenInfo.new(0.4), {
                            Value = 1
                        }):Play();
                        game.Debris:AddItem(l_v1_FOVMultiplier_0, 0.4);
                        l_v1_SpeedMultiplier_1:Destroy();
                    end;
                end;
                return;
            end;
        end
    }, 
    Punch = {
        LayoutOrder = 3, 
        KeybindType = "AltAbility3", 
        Charges = 0, 
        Icon = "rbxassetid://86535502112498", 
        Callback = function(v63, v64) --[[ Line: 344 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v5 (copy), v1 (copy), v3 (copy), v6 (copy), v4 (copy)
            local v65 = v63.Blocked or v64;
            local v66 = v65 and "Parry" or "Punch";
            local function _(v67) --[[ Line: 348 ]] --[[ Name: getConfig ]]
                -- upvalues: v63 (copy), v66 (copy)
                return v63.Config[("%*%*"):format(v66, v67)];
            end;
            if game["Run Service"]:IsServer() then
                v63.AbilitiesDisabled = true;
                task.delay(2, function() --[[ Line: 355 ]]
                    -- upvalues: v63 (copy)
                    v63.AbilitiesDisabled = false;
                end);
                if v66 == "Parry" then
                    v2:ApplyStatus(v63.Rig, "Resistance", {
                        Level = 3, 
                        Duration = v63.Config.ParryWindupTime
                    });
                    local v69 = ("%*/Start"):format(script.Parent);
                    local l_pcall_2 = pcall;
                    local v71 = "ParryStart";
                    local v72;
                    l_pcall_2, v72 = l_pcall_2(function() --[[ Line: 15 ]]
                        -- upvalues: v63 (copy), v71 (copy)
                        if v63.Behavior[v71] then
                            v63.Behavior[v71](v63);
                        end;
                    end);
                    if not l_pcall_2 then
                        warn((("[%*]: Failed to call .%*() due to: %*"):format(v69, "ParryStart", v72)));
                    end;
                elseif v66 == "Punch" then
                    v2:ApplyStatus(v63.Rig, "Resistance", {
                        Level = 2, 
                        Duration = v63.Config.PunchWindupTime
                    });
                end;
                v5:Play(v63.Config.Sounds.PunchWindup, {
                    Parent = v63.Rig.PrimaryPart
                });
                v5:PlayVoiceline(v63, ("%*Windup"):format(v66), {
                    Priority = 1
                });
                task.delay(v63.Config[("%*%*"):format(v66, "WindupTime")] - 0.1, function() --[[ Line: 372 ]]
                    -- upvalues: v1 (ref), v63 (copy), v66 (copy), v3 (ref), v5 (ref), v2 (ref), v65 (copy), v6 (ref)
                    local v73 = v1:ApplyVelocity(v63.Rig.PrimaryPart, v63.Config[("%*%*"):format(v66, "DashForce")]);
                    game.Debris:AddItem(v73, 0.1);
                    local _ = v3:CreateHitbox(v63.Player, {
                        Size = Vector3.new(4.5, 6, 7.5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1), 
                        Damage = v63.Config[("%*%*"):format(v66, "Damage")], 
                        Time = 0.25, 
                        Knockback = v63.Config[("%*%*"):format(v66, "Knockback")], 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v74) --[[ Line: 389 ]] --[[ Name: Hit ]]
                                -- upvalues: v5 (ref), v63 (ref), v66 (ref), v2 (ref), v65 (ref), v6 (ref)
                                v5:Play(v63.Config.Sounds[v66], {
                                    Parent = v74.PrimaryPart or v63.Rig.PrimaryPart
                                });
                                v5:PlayVoiceline(v63, ("%*Hit"):format(v66), {
                                    Priority = 1
                                });
                                v2:ApplyStatus(v74, "Stunned", {
                                    Level = 1, 
                                    Duration = v63.Config[("%*%*"):format(v66, "StunTime")]
                                });
                                if v65 then
                                    v6:IncrementAchievementProgress(v63.Player, "GuestParry");
                                    local v75 = ("%*/Hit"):format(script.Parent);
                                    local l_v63_0 = v63;
                                    local l_pcall_3 = pcall;
                                    local v78 = "ParryHit";
                                    local l_l_v63_0_0 = l_v63_0 --[[ copy: 2 -> 6 ]];
                                    local v80;
                                    l_pcall_3, v80 = l_pcall_3(function() --[[ Line: 15 ]]
                                        -- upvalues: l_l_v63_0_0 (copy), v78 (copy)
                                        if l_l_v63_0_0.Behavior[v78] then
                                            l_l_v63_0_0.Behavior[v78](l_l_v63_0_0);
                                        end;
                                    end);
                                    if not l_pcall_3 then
                                        warn((("[%*]: Failed to call .%*() due to: %*"):format(v75, "ParryHit", v80)));
                                    end;
                                end;
                                if v63.Rig.PrimaryPart.AssemblyLinearVelocity.Y < -8 then
                                    v5:Play(v63.Config.Sounds.CriticalPunch, {
                                        Parent = v74.PrimaryPart or v63.Rig.PrimaryPart
                                    });
                                    v6:IncrementAchievementProgress(v63.Player, "GuestAlpha");
                                end;
                                local v81 = v65 and "Parried" or "Punched";
                                v63.Rig:SetAttribute(v81, true);
                                task.delay(0.25, function() --[[ Line: 407 ]]
                                    -- upvalues: v63 (ref), v81 (copy)
                                    v63.Rig:SetAttribute(v81, nil);
                                end);
                                local v82 = require(game.ReplicatedStorage.Modules.Actors);
                                if v65 then
                                    v82:IncrementActorStats(v63.Player, {
                                        Action = "Parried Killer as Guest 1337", 
                                        RewardType = "Offensive"
                                    });
                                    return;
                                else
                                    v82:IncrementActorStats(v63.Player, {
                                        Action = "Punched Killer as Guest 1337", 
                                        RewardType = "Offensive"
                                    });
                                    return;
                                end;
                            end
                        }
                    });
                end);
                return v65;
            else
                if game["Run Service"]:IsClient() then
                    local v84 = v63.Animations[v65 and "ParryPunch" or "Punch"];
                    if v84 then
                        v84:Play();
                        v84:AdjustSpeed((v84.Length - 0.55) / v63.Config[("%*%*"):format(v66, "WindupTime")]);
                    end;
                    v4:FireConnection("DisableSprinting", "GuestPunch", true);
                    local l_v1_SpeedMultiplier_3 = v1:CreateSpeedMultiplier(v63.Rig, 1, "PunchAbility");
                    game.TweenService:Create(l_v1_SpeedMultiplier_3, TweenInfo.new(0.25), {
                        Value = 0.25
                    }):Play();
                    task.wait(v65 and v63.Config.ParryWindupTime or v63.Config.PunchWindupTime);
                    task.wait(0.8);
                    v4:FireConnection("DisableSprinting", "GuestPunch", false);
                    game.TweenService:Create(l_v1_SpeedMultiplier_3, TweenInfo.new(0.15), {
                        Value = 1
                    }):Play();
                    game.Debris:AddItem(l_v1_SpeedMultiplier_3, 0.15);
                end;
                return;
            end;
        end
    }
};
v0.OnHit = function(_, v87, v88) --[[ Line: 461 ]] --[[ Name: OnHit ]]
    -- upvalues: v5 (copy), v1 (copy), v2 (copy), v0 (copy), v6 (copy)
    if not v88.IsProjectile and v88.Creator and v87.Blocking then
        v87.Blocking = nil;
        v87:IncrementCharges("Punch", 1, 1);
        v5:Play(v87.Config.Sounds.BlockSuccess, {
            Parent = v87.Rig.PrimaryPart
        });
        local v89 = v88.Damage or 0;
        local l_Health_0 = v87.Rig.Humanoid.Health;
        v1:ApplyDamage(v87.Rig, v89);
        local l_v1_SpeedMultiplier_4 = v1:CreateSpeedMultiplier(v88.Creator, 1 * v87.Config.KillerSlownessPercent / 100);
        if l_v1_SpeedMultiplier_4 then
            game.Debris:AddItem(l_v1_SpeedMultiplier_4, v87.Config.KillerSlownessDuration);
        end;
        v2:ApplyStatus(v87.Player, "Speed", {
            Level = v87.Config.BlockSpeedLevel, 
            Duration = v87.Config.BlockSpeedDuration
        });
        v2:RemoveStatus(v87.Player, "Resistance");
        if v87.BlockingSlowness then
            game.TweenService:Create(v87.BlockingSlowness, TweenInfo.new(1), {
                Value = 1
            }):Play();
            game.Debris:AddItem(v87.BlockingSlowness, 1);
            v87.BlockingSlowness = nil;
        end;
        if v87.BlockedThread then
            task.cancel(v87.BlockedThread);
        end;
        v87.Blocked = true;
        v87.BlockedThread = task.delay(v87.Config.BlockDuration, function() --[[ Line: 495 ]]
            -- upvalues: v87 (copy)
            v87.Blocked = nil;
        end);
        local l_QueryHitbox_1 = v87.Rig:FindFirstChild("QueryHitbox");
        if l_QueryHitbox_1 and v0.DefaultHitboxSize then
            l_QueryHitbox_1.Size = v0.DefaultHitboxSize;
        end;
        require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v87.Player, {
            Action = "Successfully blocked an attack", 
            RewardType = "Survivalist"
        });
        if not v87.BlockCount then
            v87.BlockCount = 0;
        end;
        v87.BlockCount = v87.BlockCount + 1;
        if v87.BlockCount >= 3 then
            v6:IncrementAchievementProgress(v87.Player, "GuestBlock");
        end;
        local v93 = l_Health_0 < v89;
        local v94 = require(game.ServerScriptService.Server.Systems.Core.RoundManager);
        if v93 and v94.CurrentSession and v94.CurrentSession.LastSurvivorAlive then
            v87.Daigo = true;
        end;
        return "Ignored";
    else
        return;
    end;
end;
v0.Created = function(_, v96) --[[ Line: 529 ]] --[[ Name: Created ]]
    if game["Run Service"]:IsServer() then
        v96.Rig:SetAttribute("HitboxPriority", 2);
    end;
end;
return v0;