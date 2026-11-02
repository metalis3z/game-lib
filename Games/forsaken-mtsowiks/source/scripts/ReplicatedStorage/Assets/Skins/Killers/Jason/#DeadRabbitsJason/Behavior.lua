-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:07:46 2025 ]]
local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
local v5 = require(game.ReplicatedStorage.Modules.Network);
local _ = require(game.ReplicatedStorage.Modules.AchievementUtil);
local function _(v7, v8, v9) --[[ Line: 12 ]] --[[ Name: getEnragedStatValue ]]
    return v7.Enraged and v7.Config[("Enraged%*%*"):format(v8, v9)] or v7.Config[("%*%*"):format(v8, v9)];
end;
local function v15(v11) --[[ Line: 17 ]] --[[ Name: pacify ]]
    -- upvalues: v2 (copy), v1 (copy), v5 (copy)
    if v11 and v11.Enraged and v11.Rig.Parent then
        v11.Enraged = nil;
        if game["Run Service"]:IsServer() then
            v2:RemoveInvincible(v11.Rig, "Raging");
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
    GashingWound = {
        LayoutOrder = 3, 
        Icon = "rbxassetid://132724488499212", 
        KeybindType = "AltAbility2", 
        Cooldown = function(v16, v17) --[[ Line: 79 ]] --[[ Name: Cooldown ]]
            return v16.Enraged and v16.Config[("Enraged%*Cooldown"):format(v17)] or v16.Config[("%*Cooldown"):format(v17)];
        end, 
        Callback = function(v18) --[[ Line: 80 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v2 (copy), v15 (copy)
            if game["Run Service"]:IsServer() then
                v18.AbilitiesDisabled = true;
                v18.Cache.GashingWoundStart:Play(0.05);
                v1:Play(v18.Config.Sounds.GashingWoundSwing, {
                    Parent = v18.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.25
                });
                local v19 = v18.Enraged and v18.Config.EnragedGashingWoundDamage or v18.Config.GashingWoundDamage;
                local v20 = {
                    [0.333] = {
                        Damage = v19 / 5, 
                        Time = 0.15, 
                        DoLunge = true
                    }, 
                    [0.717] = {
                        Damage = v19 / 5, 
                        Time = 0.15, 
                        DoLunge = true
                    }, 
                    [1.117] = {
                        Damage = v19 / 5, 
                        Time = 0.15, 
                        DoLunge = true
                    }, 
                    [1.733] = {
                        Damage = v19 / 10, 
                        Time = 0.15, 
                        DoLunge = true
                    }, 
                    [2.233] = {
                        Damage = v19 / 10, 
                        Time = 0.15
                    }, 
                    [2.7] = {
                        Damage = v19 / 5, 
                        Time = 0.15, 
                        DoLunge = true
                    }
                };
                local _ = tick();
                local v22 = nil;
                local v23 = nil;
                local _ = nil;
                for v25, v26 in pairs(v20) do
                    task.delay(v25, function() --[[ Line: 125 ]]
                        -- upvalues: v25 (copy), v22 (ref), v3 (ref), v18 (copy), v26 (copy), v1 (ref), v2 (ref), v23 (ref)
                        if v25 >= 0.5 and not v22 then
                            return;
                        else
                            local _ = v3:CreateHitbox(v18.Player, {
                                Size = Vector3.new(8, 4, 8, 0), 
                                CFrameOffset = CFrame.new(0, 0, -2.25), 
                                Damage = v26.Damage, 
                                Time = v26.Time, 
                                Knockback = 0, 
                                HitMultiple = true, 
                                Connections = {
                                    Hit = function(v27, v28) --[[ Line: 139 ]] --[[ Name: Hit ]]
                                        -- upvalues: v1 (ref), v18 (ref), v25 (ref), v22 (ref), v2 (ref), v23 (ref)
                                        if v28 then
                                            v1:Play(v18.Config.Sounds.Hit, {
                                                Parent = v18.Rig.PrimaryPart, 
                                                PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                                Volume = 0.25
                                            });
                                        end;
                                        if v25 <= 0.5 and not v22 then
                                            v22 = v27;
                                            v22:SetPrimaryPartCFrame(v18.Rig.PrimaryPart.CFrame);
                                            v22.PrimaryPart.Anchored = true;
                                            v18.Rig.PrimaryPart.Anchored = true;
                                            v2:GiveInvincible(v18.Rig, "Gashing");
                                            local l_GashingWound_0 = v18.Cache.GashingWound;
                                            l_GashingWound_0:Play(0);
                                            l_GashingWound_0.TimePosition = v18.Cache.GashingWoundStart.TimePosition;
                                            v23 = v2:LoadAnimationFromID(v22, v18.Config.Animations.GashingWound.PlayerRig, true);
                                            v23:Play(0.05);
                                            v23.TimePosition = v18.Cache.GashingWoundStart.TimePosition;
                                            v18.Cache.GashingWoundStart:Stop(0);
                                            v1:PlayVoiceline(v18, "GashingWoundHit", {
                                                Priority = 2
                                            });
                                            if tostring(v27.Parent) == "Survivors" then
                                                require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v18.Player, {
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
                task.delay(0.5, function() --[[ Line: 178 ]]
                    -- upvalues: v22 (ref), v1 (ref), v18 (copy), v2 (ref), v23 (ref), v15 (ref)
                    local v31 = v22 and 4.25 or 0.5;
                    if not v22 then
                        v1:Play(v18.Config.Sounds.GashingWoundMiss, {
                            Parent = v18.Rig.PrimaryPart
                        });
                        v2:RemoveInvincible(v18.Rig, "Gashing");
                    else
                        v1:Play(v18.Config.Sounds.GashingWoundHit, {
                            Parent = v18.Rig.PrimaryPart
                        });
                    end;
                    local l_StringValue_0 = Instance.new("StringValue");
                    l_StringValue_0.Name = "Result";
                    l_StringValue_0.Value = v22 and "HitPlayer" or "HitNothing";
                    l_StringValue_0.Parent = v18.Rig;
                    game.Debris:AddItem(l_StringValue_0, 5);
                    task.delay(v31 - 1.7, function() --[[ Line: 198 ]]
                        -- upvalues: v23 (ref), v22 (ref), v18 (ref)
                        if v23 then
                            v23:Stop(0);
                        end;
                        if v22 and v22.PrimaryPart then
                            v22:SetPrimaryPartCFrame(v18.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -3));
                            v22.PrimaryPart.Anchored = false;
                            v22.PrimaryPart.Velocity = v18.Rig.PrimaryPart.CFrame.LookVector * 75;
                            local v33 = v18.Rig.PrimaryPart.CFrame.LookVector * 75;
                            v22.PrimaryPart.Velocity = v33;
                            local v34 = require(game.ReplicatedStorage.Modules.Ragdolls);
                            v34.AddProfile(v22, {
                                Velocity = v33
                            });
                            v34.EnableRagdoll(v22, 1.25);
                        end;
                    end);
                    task.delay(v31 + 0.25, function() --[[ Line: 215 ]]
                        -- upvalues: v15 (ref), v18 (ref)
                        v15(v18);
                    end);
                    task.delay(v31 + 0.75, function() --[[ Line: 220 ]]
                        -- upvalues: v18 (ref)
                        v18.Rig.PrimaryPart.Anchored = false;
                    end);
                    task.delay(v31 + 1.25, function() --[[ Line: 225 ]]
                        -- upvalues: v18 (ref)
                        v18.AbilitiesDisabled = false;
                    end);
                    task.delay(v31 + 1.5, function() --[[ Line: 230 ]]
                        -- upvalues: v2 (ref), v18 (ref)
                        v2:RemoveInvincible(v18.Rig, "Gashing");
                    end);
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    local l_v2_SpeedMultiplier_1 = v2:CreateSpeedMultiplier(v18.Rig, 1, "BeheadAbility");
                    game.TweenService:Create(l_v2_SpeedMultiplier_1, TweenInfo.new(0.2), {
                        Value = 0.001
                    }):Play();
                    local v36 = v18.Rig:WaitForChild("Result", 5);
                    if (v36 and v36.Value or "IDK") == "HitPlayer" then
                        task.delay(4.75, function() --[[ Line: 245 ]]
                            -- upvalues: l_v2_SpeedMultiplier_1 (copy)
                            game.TweenService:Create(l_v2_SpeedMultiplier_1, TweenInfo.new(0.2), {
                                Value = 1
                            }):Play();
                            game.Debris:AddItem(l_v2_SpeedMultiplier_1, 0.2);
                        end);
                        return;
                    else
                        task.delay(1, function() --[[ Line: 250 ]]
                            -- upvalues: l_v2_SpeedMultiplier_1 (copy)
                            game.TweenService:Create(l_v2_SpeedMultiplier_1, TweenInfo.new(0.2), {
                                Value = 1
                            }):Play();
                            game.Debris:AddItem(l_v2_SpeedMultiplier_1, 0.2);
                        end);
                    end;
                end;
                return;
            end;
        end
    }
};
v0.OnExecution = function(_, v38, v39) --[[ Line: 262 ]] --[[ Name: OnExecution ]]
    -- upvalues: v5 (copy)
    local v40 = v38.Rig.PrimaryPart.CFrame.LookVector * 250;
    local v41 = workspace:GetServerTimeNow() + 1.6;
    v5:FireAllClientConnection("Ragdoll", "REMOTE_EVENT", v39, v41, (("%*|%*|%*"):format(v40.X, v40.Y, v40.Z)));
    task.delay(1.65, function() --[[ Line: 271 ]]
        -- upvalues: v39 (copy)
        local l_Humanoid_0 = v39:FindFirstChild("Humanoid");
        if l_Humanoid_0 then
            l_Humanoid_0.BreakJointsOnDeath = false;
            l_Humanoid_0.Health = 0;
        end;
    end);
end;
return v0;