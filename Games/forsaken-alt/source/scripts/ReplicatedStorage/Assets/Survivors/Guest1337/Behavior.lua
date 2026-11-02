-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Util);
local v2 = require(game.ReplicatedStorage.Modules.Statuses);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Network);
local v5 = require(game.ReplicatedStorage.Modules.Sounds);
local v6 = require(game.ReplicatedStorage.Modules.AchievementUtil);
v0.Abilities = {
    Block = {
        LayoutOrder = 1, 
        KeybindType = "AltAbility1", 
        Icon = "rbxassetid://137576632569674", 
        Callback = function(v7, _) --[[ Line: 17 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v1 (copy), v5 (copy)
            if game["Run Service"]:IsServer() then
                v7.DisabledAbilities = {
                    Block = true, 
                    Charge = true
                };
                v2:ApplyStatus(v7.Player, "Resistance", {
                    Level = v7.Config.ResistanceLevel, 
                    Duration = v7.Config.BlockDuration
                });
                local l_v1_SpeedMultiplier_0 = v1:CreateSpeedMultiplier(v7.Rig, 0.4, "GuestBlocking");
                if v7.BlockingSlowness then
                    v7.BlockingSlowness:Destroy();
                end;
                v7.BlockingSlowness = l_v1_SpeedMultiplier_0;
                task.delay(v7.Config.SlownessDuration, function() --[[ Line: 33 ]]
                    -- upvalues: l_v1_SpeedMultiplier_0 (copy)
                    if l_v1_SpeedMultiplier_0 then
                        game.TweenService:Create(l_v1_SpeedMultiplier_0, TweenInfo.new(1), {
                            Value = 1
                        }):Play();
                        game.Debris:AddItem(l_v1_SpeedMultiplier_0, 1);
                    end;
                end);
                local l_BlockCount_0 = v7.BlockCount;
                task.delay(2, function() --[[ Line: 42 ]]
                    -- upvalues: l_BlockCount_0 (copy), v7 (copy)
                    if l_BlockCount_0 == v7.BlockCount then
                        v7.BlockCount = 0;
                    end;
                end);
                if v7.BlockThread then
                    task.cancel(v7.BlockThread);
                end;
                v7.Blocking = true;
                v7.BlockThread = task.delay(v7.Config.BlockDuration, function() --[[ Line: 51 ]]
                    -- upvalues: v7 (copy)
                    v7.Blocking = nil;
                end);
                v5:Play(v7.Config.Sounds.BlockStart, {
                    Parent = v7.Rig.PrimaryPart
                });
                task.delay(v7.Config.SlownessDuration, function() --[[ Line: 59 ]]
                    -- upvalues: v7 (copy)
                    v7.DisabledAbilities = nil;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v7.Animations.Block:Play(0.175);
                end;
                return;
            end;
        end
    }, 
    Charge = {
        LayoutOrder = 2, 
        KeybindType = "AltAbility2", 
        Icon = "rbxassetid://73254549946762", 
        Callback = function(v11, v12) --[[ Line: 75 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v5 (copy), v4 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v11.DisabledAbilities = {
                    Block = true, 
                    Charge = true
                };
                v1:SetSpeedCap(v11.Player, "GuestCharging", v11.Config.ChargingSpeed / v11.Config.Speed);
                local v13 = ("Result%*"):format((tostring(math.random(-10000, 10000))));
                task.delay(0.125, function() --[[ Line: 87 ]]
                    -- upvalues: v11 (copy), v3 (ref), v1 (ref), v5 (ref), v4 (ref), v13 (copy), v2 (ref)
                    local l_PrimaryPart_0 = v11.Rig.PrimaryPart;
                    local v15 = nil;
                    local v16 = nil;
                    local l_v3_Hitbox_0 = v3:CreateHitbox(v11.Player, {
                        Size = Vector3.new(4, 5, 6, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1), 
                        Damage = v11.Config.ChargeDamage, 
                        Time = v11.Config.ChargingDuration, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v17) --[[ Line: 100 ]] --[[ Name: Hit ]]
                                -- upvalues: v15 (ref), v11 (ref), v1 (ref), v5 (ref), l_PrimaryPart_0 (copy)
                                if not workspace:GetAttribute("CooldownsDisabled") then
                                    v15 = v17;
                                end;
                                if v15 then
                                    if not v15:GetAttribute("PreviouslyChargedInto") then
                                        v15:SetAttribute("PreviouslyChargedInto", true);
                                        task.delay(v11.Config.KillerChargeResistanceDuration, function() --[[ Line: 110 ]]
                                            -- upvalues: v15 (ref)
                                            v15:SetAttribute("PreviouslyChargedInto", nil);
                                        end);
                                    else
                                        v1:ApplyDamage(v11.Rig, v11.Config.KillerChargeResistanceDamage);
                                        v5:Play(v11.Config.Sounds.ChargingHit, {
                                            Parent = l_PrimaryPart_0
                                        });
                                        return;
                                    end;
                                end;
                                task.spawn(function() --[[ Line: 120 ]]
                                    -- upvalues: v17 (copy)
                                    local v18 = require(game.ReplicatedStorage.Modules.Actors).CurrentActors[game.Players:GetPlayerFromCharacter(v17)];
                                    if v18 then
                                        v18:DisableAbilities("Guest1337Charge", true, 1.25);
                                    end;
                                end);
                                v1:CreateSpeedMultiplier(v17, 0.3, "Guest1337ChargedInto", 0.35);
                                v5:Play(v11.Config.Sounds.ChargingHit, {
                                    Parent = l_PrimaryPart_0
                                });
                                local v19 = l_PrimaryPart_0.CFrame.LookVector * v11.Config.ChargeKnockback * 10;
                                local l_PrimaryPart_1 = v17.PrimaryPart;
                                if l_PrimaryPart_1 then
                                    l_PrimaryPart_1.Velocity = v19;
                                end;
                            end, 
                            Ended = function() --[[ Line: 142 ]] --[[ Name: Ended ]]
                                -- upvalues: v16 (ref)
                                v16 = true;
                            end
                        }
                    });
                    local v22 = v5:Play(v11.Config.Sounds.ChargingStart, {
                        Parent = l_PrimaryPart_0
                    });
                    local v23 = false;
                    local v24 = ("%*Guest1337Collision"):format(v11.Player.Name);
                    v4:SetConnection(v24, "REMOTE_EVENT", function(v25) --[[ Line: 152 ]]
                        -- upvalues: v11 (ref), v23 (ref)
                        if v25 == v11.Player then
                            v23 = true;
                        end;
                    end);
                    repeat
                        task.wait();
                    until v15 or v16 or v23;
                    local v26 = "IDK";
                    if v15 then
                        v26 = "Hit";
                    elseif v23 then
                        v26 = "Collide";
                    elseif v16 then
                        v26 = "Timeout";
                    end;
                    v5:PlayVoiceline(v11, ("Charge%*"):format(v26), {
                        Priority = 1
                    });
                    local l_StringValue_0 = Instance.new("StringValue");
                    l_StringValue_0.Name = v13;
                    l_StringValue_0.Value = v26;
                    l_StringValue_0.Parent = v11.Rig;
                    game.Debris:AddItem(l_StringValue_0, 1);
                    if v26 == "Hit" then
                        v2:ApplyStatus(v11.Player, "Resistance", {
                            Level = 5, 
                            Duration = 1.25
                        });
                    else
                        local _, v29 = v1:GetClosestPlayerFromPosition(l_PrimaryPart_0.Position, {
                            PlayerSelection = "Killers"
                        });
                        if not v29 then
                            v29 = 999;
                        end;
                        local v30 = math.clamp(math.floor(v29 / v11.Config.ChargePunishmentDistanceInterval) * v11.Config.ChargePunishmentSlownessDurationMultiplier, 0, v11.Config.ChargePunishmentSlownessMaxDuration);
                        if v30 > 0 then
                            v2:ApplyStatus(v11.Player, "Slowness", {
                                Duration = v30, 
                                Level = v11.Config.ChargePunishmentSlownessLevel
                            });
                        end;
                    end;
                    task.delay(0.25, function() --[[ Line: 196 ]]
                        -- upvalues: v11 (ref)
                        v11.DisabledAbilities = nil;
                    end);
                    if v22 then
                        game.TweenService:Create(v22, TweenInfo.new(0.2), {
                            Volume = 0
                        }):Play();
                    end;
                    if v26 ~= "Hit" then
                        v5:Play(v11.Config.Sounds[("Charging%*"):format(v26)], {
                            Parent = l_PrimaryPart_0
                        });
                    end;
                    v4:RemoveConnection(v24, "REMOTE_EVENT");
                    l_v3_Hitbox_0:Cancel();
                    v1:SetSpeedCap(v11.Player, "GuestCharging", nil);
                end);
                return v13;
            else
                if game["Run Service"]:IsClient() then
                    v11.Animations.Charge:Play();
                    v11.MovementAnimSpeed = 2.25;
                    v4:FireConnection("DisableSprinting", "GuestCharge", true);
                    local v31 = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting);
                    v31.StaminaCap = tonumber(v31.Stamina) or 100;
                    local l_v1_FOVMultiplier_0 = v1:CreateFOVMultiplier(v11.Player, 1, "Guest1337Charge");
                    game.TweenService:Create(l_v1_FOVMultiplier_0, TweenInfo.new(0.8), {
                        Value = 0.75
                    }):Play();
                    local l_v1_SpeedMultiplier_1 = v1:CreateSpeedMultiplier(v11.Rig, v11.Config.ChargingSpeed / v11.Config.Speed, "Guest1337Charge");
                    local l_LookVector_0 = workspace.CurrentCamera.CFrame.LookVector;
                    local l_Unit_0 = Vector3.new(l_LookVector_0.X, 0, l_LookVector_0.Z).Unit;
                    local v36 = Vector3.new(0, 0, 0, 0);
                    local v37 = 0;
                    local v38 = false;
                    do
                        local l_l_Unit_0_0, l_v36_0, l_v37_0, l_v38_0 = l_Unit_0, v36, v37, v38;
                        game["Run Service"]:BindToRenderStep("GuestCharging", Enum.RenderPriority.Character.Value + 1, function(v43) --[[ Line: 237 ]]
                            -- upvalues: v11 (copy), l_v37_0 (ref), l_v38_0 (ref), v4 (ref), l_v36_0 (ref), l_l_Unit_0_0 (ref)
                            if not v11.Rig.Parent or not v11.Rig.PrimaryPart then
                                game["Run Service"]:UnbindFromRenderStep("GuestCharging");
                                return;
                            else
                                l_v37_0 = l_v37_0 + v43;
                                if l_v37_0 >= 0.3 and v11.Rig.PrimaryPart.Velocity.Magnitude <= v11.Config.ChargingSpeed / 2 then
                                    if not l_v38_0 then
                                        l_v38_0 = true;
                                        v4:FireServerConnection(("%*Guest1337Collision"):format(v11.Player.Name), "REMOTE_EVENT");
                                    end;
                                    return;
                                else
                                    local l_LookVector_1 = workspace.CurrentCamera.CFrame.LookVector;
                                    l_v36_0 = Vector3.new(l_LookVector_1.X, 0, l_LookVector_1.Z).Unit;
                                    local v45 = l_v36_0 - l_l_Unit_0_0;
                                    local l_Magnitude_0 = v45.Magnitude;
                                    if l_Magnitude_0 > 0 then
                                        local v47 = v11.Config.ChargingTurnSpeed * v43;
                                        if l_Magnitude_0 <= v47 then
                                            l_l_Unit_0_0 = l_v36_0;
                                        else
                                            l_l_Unit_0_0 = l_l_Unit_0_0 + v45.Unit * v47;
                                        end;
                                        l_l_Unit_0_0 = l_l_Unit_0_0.Unit;
                                    end;
                                    v11.Rig.Humanoid:Move(l_l_Unit_0_0);
                                    return;
                                end;
                            end;
                        end);
                        local v48 = v11.Rig:WaitForChild(v12, v11.Config.ChargingDuration + 0.5);
                        local v49 = v48 and v48.Value;
                        if v48 then
                            v48:Destroy();
                        end;
                        if v49 == "Hit" or v49 == "Collide" then
                            local l_v1_SpeedMultiplier_2 = v1:CreateSpeedMultiplier(v11.Rig, 0.2, "GuestChargeEnded");
                            game.TweenService:Create(l_v1_SpeedMultiplier_2, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                Value = 1
                            }):Play();
                            game.Debris:AddItem(l_v1_SpeedMultiplier_2, 1);
                        end;
                        game["Run Service"]:UnbindFromRenderStep("GuestCharging");
                        v4:FireConnection("DisableSprinting", "GuestCharge", false);
                        v11.Animations.Charge:Stop();
                        v11.MovementAnimSpeed = nil;
                        v31.StaminaCap = nil;
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
        Callback = function(v51, v52) --[[ Line: 307 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v5 (copy), v1 (copy), v3 (copy), v6 (copy), v4 (copy)
            local v53 = v51.Blocked or v52;
            local v54 = v53 and "Parry" or "Punch";
            local function _(v55) --[[ Line: 311 ]] --[[ Name: getConfig ]]
                -- upvalues: v51 (copy), v54 (copy)
                return v51.Config[("%*%*"):format(v54, v55)];
            end;
            if game["Run Service"]:IsServer() then
                v51.AbilitiesDisabled = true;
                task.delay(2, function() --[[ Line: 318 ]]
                    -- upvalues: v51 (copy)
                    v51.AbilitiesDisabled = false;
                end);
                if v54 == "Parry" then
                    v2:ApplyStatus(v51.Rig, "Resistance", {
                        Level = 3, 
                        Duration = v51.Config.ParryWindupTime
                    });
                elseif v54 == "Punch" then
                    v2:ApplyStatus(v51.Rig, "Resistance", {
                        Level = 2, 
                        Duration = v51.Config.PunchWindupTime
                    });
                end;
                v5:Play(v51.Config.Sounds.PunchWindup, {
                    Parent = v51.Rig.PrimaryPart
                });
                v5:PlayVoiceline(v51, ("%*Windup"):format(v54), {
                    Priority = 1
                });
                task.delay(v51.Config[("%*%*"):format(v54, "WindupTime")] - 0.1, function() --[[ Line: 334 ]]
                    -- upvalues: v1 (ref), v51 (copy), v54 (copy), v3 (ref), v5 (ref), v2 (ref), v53 (copy), v6 (ref)
                    local v57 = v1:ApplyVelocity(v51.Rig.PrimaryPart, v51.Config[("%*%*"):format(v54, "DashForce")]);
                    game.Debris:AddItem(v57, 0.1);
                    local _ = v3:CreateHitbox(v51.Player, {
                        Size = Vector3.new(4.5, 6, 7.5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1), 
                        Damage = v51.Config[("%*%*"):format(v54, "Damage")], 
                        Time = 0.25, 
                        Knockback = v51.Config[("%*%*"):format(v54, "Knockback")], 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v58) --[[ Line: 351 ]] --[[ Name: Hit ]]
                                -- upvalues: v5 (ref), v51 (ref), v54 (ref), v2 (ref), v53 (ref), v6 (ref)
                                v5:Play(v51.Config.Sounds[v54], {
                                    Parent = v58.PrimaryPart or v51.Rig.PrimaryPart
                                });
                                v5:PlayVoiceline(v51, ("%*Hit"):format(v54), {
                                    Priority = 1
                                });
                                v2:ApplyStatus(v58, "Stunned", {
                                    Level = 1, 
                                    Duration = v51.Config[("%*%*"):format(v54, "StunTime")]
                                });
                                if v53 then
                                    v6:IncrementAchievementProgress(v51.Player, "GuestParry");
                                end;
                                local v59 = v53 and "Parried" or "Punched";
                                v51.Rig:SetAttribute(v59, true);
                                task.delay(0.25, function() --[[ Line: 362 ]]
                                    -- upvalues: v51 (ref), v59 (copy)
                                    v51.Rig:SetAttribute(v59, nil);
                                end);
                                local v60 = require(game.ReplicatedStorage.Modules.Actors);
                                if v53 then
                                    v60:IncrementActorStats(v51.Player, {
                                        Action = "Parried Killer as Guest 1337", 
                                        RewardType = "Offensive"
                                    });
                                    return;
                                else
                                    v60:IncrementActorStats(v51.Player, {
                                        Action = "Punched Killer as Guest 1337", 
                                        RewardType = "Offensive"
                                    });
                                    return;
                                end;
                            end
                        }
                    });
                end);
                return v53;
            else
                if game["Run Service"]:IsClient() then
                    local v62 = v51.Animations[v53 and "ParryPunch" or "Punch"];
                    if v62 then
                        v62:Play();
                        v62:AdjustSpeed((v62.Length - 0.55) / v51.Config[("%*%*"):format(v54, "WindupTime")]);
                    end;
                    v4:FireConnection("DisableSprinting", "GuestPunch", true);
                    local l_v1_SpeedMultiplier_3 = v1:CreateSpeedMultiplier(v51.Rig, 1, "PunchAbility");
                    game.TweenService:Create(l_v1_SpeedMultiplier_3, TweenInfo.new(0.25), {
                        Value = 0.25
                    }):Play();
                    task.wait(v53 and v51.Config.ParryWindupTime or v51.Config.PunchWindupTime);
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
v0.OnHit = function(_, v65, v66) --[[ Line: 416 ]] --[[ Name: OnHit ]]
    -- upvalues: v5 (copy), v1 (copy), v2 (copy), v6 (copy)
    if not v66.IsProjectile and v66.Creator and v65.Blocking then
        v65.Blocking = nil;
        v65:IncrementCharges("Punch", 1, 1);
        v5:Play(v65.Config.Sounds.BlockSuccess, {
            Parent = v65.Rig.PrimaryPart
        });
        v1:ApplyDamage(v65.Rig, v66.Damage or 0);
        v2:RemoveStatus(v65.Player, "Resistance");
        v2:ApplyStatus(v65.Player, "Speed", {
            Level = v65.Config.SpeedLevel, 
            Duration = v65.Config.SpeedDuration, 
            Instant = true
        });
        if v65.BlockingSlowness then
            game.TweenService:Create(v65.BlockingSlowness, TweenInfo.new(1), {
                Value = 1
            }):Play();
            game.Debris:AddItem(v65.BlockingSlowness, 1);
            v65.BlockingSlowness = nil;
        end;
        if v65.BlockedThread then
            task.cancel(v65.BlockedThread);
        end;
        v65.Blocked = true;
        v65.BlockedThread = task.delay(v65.Config.BlockDuration, function() --[[ Line: 441 ]]
            -- upvalues: v65 (copy)
            v65.Blocked = nil;
        end);
        require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v65.Player, {
            Action = "Successfully blocked an attack", 
            RewardType = "Survivalist"
        });
        if not v65.BlockCount then
            v65.BlockCount = 0;
        end;
        v65.BlockCount = v65.BlockCount + 1;
        if v65.BlockCount >= 3 then
            v6:IncrementAchievementProgress(v65.Player, "GuestBlock");
        end;
        return "Ignored";
    else
        return;
    end;
end;
v0.Created = function(_, v68) --[[ Line: 463 ]] --[[ Name: Created ]]
    if game["Run Service"]:IsServer() then
        v68.Rig:SetAttribute("HitboxPriority", 2);
    end;
end;
return v0;