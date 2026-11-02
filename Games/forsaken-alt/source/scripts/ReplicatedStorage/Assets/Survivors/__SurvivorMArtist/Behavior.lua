-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
local v5 = require(game.ReplicatedStorage.Modules.Network);
local _ = require(game.ReplicatedStorage.Modules.AchievementUtil);
v0.Abilities = {
    Combo = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://132724488499212", 
        KeybindType = "AltAbility2", 
        Cooldown = 5, 
        Callback = function(v7) --[[ Line: 17 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v7.AbilitiesDisabled = true;
                v7.Cache.GashingWoundStart:Play(0.05);
                task.delay(0.2, function() --[[ Line: 22 ]]
                    -- upvalues: v1 (ref), v7 (copy)
                    v1:Play(v7.Config.Sounds.GashingWoundSwing, {
                        Parent = v7.Rig.PrimaryPart, 
                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                        Volume = 0.25
                    });
                end);
                local v8 = {
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
                local v10 = nil;
                local v11 = nil;
                local _ = nil;
                for v13, v14 in pairs(v8) do
                    task.delay(v13, function() --[[ Line: 48 ]]
                        -- upvalues: v13 (copy), v10 (ref), v14 (copy), v3 (ref), v7 (copy), v11 (ref), v2 (ref), v1 (ref)
                        if v13 >= 0.4 and not v10 then
                            return;
                        else
                            if not v14.DoLunge or not v10 then

                            end;
                            local _ = v3:CreateHitbox(v7.Player, {
                                Size = Vector3.new(8, 4, 8, 0), 
                                CFrameOffset = CFrame.new(0, 0, -2.25), 
                                Damage = v14.Damage, 
                                Time = v14.Time, 
                                Knockback = 0, 
                                HitMultiple = true, 
                                Connections = {
                                    Hit = function(v15, _) --[[ Line: 64 ]] --[[ Name: Hit ]]
                                        -- upvalues: v13 (ref), v10 (ref), v7 (ref), v11 (ref), v2 (ref), v1 (ref)
                                        if v13 <= 0.39 and not v10 then
                                            v10 = v15;
                                            v10:SetPrimaryPartCFrame(v7.Rig.PrimaryPart.CFrame);
                                            v10.PrimaryPart.Anchored = true;
                                            v7.Rig.PrimaryPart.Anchored = true;
                                            local l_GashingWound_0 = v7.Cache.GashingWound;
                                            l_GashingWound_0:Play(0);
                                            l_GashingWound_0.TimePosition = v7.Cache.GashingWoundStart.TimePosition;
                                            v11 = v2:LoadAnimationFromID(v10, v7.Config.Animations.GashingWound.PlayerRig, true);
                                            v11:Play(0.05);
                                            v11.TimePosition = v7.Cache.GashingWoundStart.TimePosition;
                                            v7.Cache.GashingWoundStart:Stop(0);
                                            v1:Play(v7.Config.Sounds.GashingWoundHit1, {
                                                Parent = v7.Rig.PrimaryPart
                                            });
                                            task.delay(0.7, function() --[[ Line: 83 ]]
                                                -- upvalues: v1 (ref), v7 (ref)
                                                v1:Play(v7.Config.Sounds.GashingWoundHit2, {
                                                    Parent = v7.Rig.PrimaryPart
                                                });
                                            end);
                                            task.delay(1.334, function() --[[ Line: 86 ]]
                                                -- upvalues: v1 (ref), v7 (ref)
                                                v1:Play(v7.Config.Sounds.GashingWoundHit3, {
                                                    Parent = v7.Rig.PrimaryPart
                                                });
                                                v1:Play(v7.Config.Sounds.GashingWoundHit4, {
                                                    Parent = v7.Rig.PrimaryPart, 
                                                    Volume = 0.25
                                                });
                                            end);
                                            task.spawn(function() --[[ Line: 91 ]]
                                                -- upvalues: v15 (copy)
                                                local v18 = require(game.ReplicatedStorage.Modules.Actors).CurrentActors[game.Players:GetPlayerFromCharacter(v15)];
                                                if v18 then
                                                    v18:DisableAbilities("Combo", true, 1.25);
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
                    -- upvalues: v10 (ref), v1 (ref), v7 (copy), v11 (ref)
                    local v20 = v10 and 1.82 or 0.39;
                    if not v10 then
                        v1:Play(v7.Config.Sounds.GashingWoundMiss, {
                            Parent = v7.Rig.PrimaryPart
                        });
                    end;
                    local l_StringValue_0 = Instance.new("StringValue");
                    l_StringValue_0.Name = "Result";
                    l_StringValue_0.Value = v10 and "HitPlayer" or "HitNothing";
                    l_StringValue_0.Parent = v7.Rig;
                    game.Debris:AddItem(l_StringValue_0, 5);
                    task.delay(v20 - 1.75, function() --[[ Line: 124 ]]
                        -- upvalues: v11 (ref), v10 (ref), v7 (ref), v20 (copy)
                        if v11 then
                            v11:Stop(0);
                        end;
                        if v10 and v10.PrimaryPart then
                            v10:SetPrimaryPartCFrame(v7.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -3));
                            v10.PrimaryPart.Anchored = false;
                            task.delay(0.02, function() --[[ Line: 130 ]]
                                -- upvalues: v10 (ref), v7 (ref)
                                v10.PrimaryPart.Velocity = v7.Rig.PrimaryPart.CFrame.LookVector * 200;
                            end);
                            local v22 = require(game.ReplicatedStorage.Modules.Ragdolls);
                            if v10.Humanoid.Health <= 0 then
                                local v23 = v7.Rig.PrimaryPart.CFrame.LookVector * 250;
                                local _ = workspace:GetServerTimeNow() + (v20 - 1.75);
                                require(game.ReplicatedStorage.Modules.Network):FireAllClientConnection("Ragdoll", "REMOTE_EVENT", v10, nil, (("%*|%*|%*"):format(v23.X, v23.Y, v23.Z)));
                                return;
                            else
                                v22:Enable(v10);
                                task.wait(1.25);
                                v22:Disable(v10);
                                v11:Stop();
                            end;
                        end;
                    end);
                    task.delay(v20 - 1, function() --[[ Line: 175 ]]
                        -- upvalues: v7 (ref)
                        v7.Rig.PrimaryPart.Anchored = false;
                    end);
                    task.delay(v20, function() --[[ Line: 180 ]]
                        -- upvalues: v7 (ref)
                        v7.AbilitiesDisabled = false;
                    end);
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v7.Rig, 1, "Combo");
                    game.TweenService:Create(l_v2_SpeedMultiplier_0, TweenInfo.new(0.2), {
                        Value = 0.001
                    }):Play();
                    local v26 = v7.Rig:WaitForChild("Result", 5);
                    if (v26 and v26.Value or "IDK") == "HitPlayer" then
                        task.delay(0.25, function() --[[ Line: 195 ]]
                            -- upvalues: l_v2_SpeedMultiplier_0 (copy)
                            game.TweenService:Create(l_v2_SpeedMultiplier_0, TweenInfo.new(0.2), {
                                Value = 1
                            }):Play();
                            game.Debris:AddItem(l_v2_SpeedMultiplier_0, 0.2);
                        end);
                        return;
                    else
                        task.delay(0.4, function() --[[ Line: 200 ]]
                            -- upvalues: l_v2_SpeedMultiplier_0 (copy)
                            game.TweenService:Create(l_v2_SpeedMultiplier_0, TweenInfo.new(0.2), {
                                Value = 1
                            }):Play();
                            game.Debris:AddItem(l_v2_SpeedMultiplier_0, 0.2);
                        end);
                    end;
                end;
                return;
            end;
        end
    }, 
    QuickAttack = {
        LayoutOrder = 1, 
        KeybindType = "AltAbility1", 
        Cooldown = 5, 
        Icon = "rbxassetid://85282571177550", 
        Callback = function(v27, _) --[[ Line: 215 ]] --[[ Name: Callback ]]
            -- upvalues: v4 (copy), v1 (copy), v2 (copy), v3 (copy), v5 (copy)
            if game["Run Service"]:IsServer() then
                v27.AbilitiesDisabled = true;
                task.delay(0.75, function() --[[ Line: 221 ]]
                    -- upvalues: v27 (copy)
                    v27.AbilitiesDisabled = false;
                end);
                v4:ApplyStatus(v27.Rig, "Resistance", {
                    Level = 2, 
                    Duration = 0.7
                });
                task.delay(0.667, function() --[[ Line: 231 ]]
                    -- upvalues: v1 (ref), v27 (copy), v2 (ref), v3 (ref), v4 (ref)
                    v1:Play(v27.Config.Sounds.Slash, {
                        Parent = v27.Rig.PrimaryPart
                    });
                    local v29 = v2:ApplyVelocity(v27.Rig.PrimaryPart, 120);
                    game.TweenService:Create(v29, TweenInfo.new(1), {
                        VectorVelocity = v29.VectorVelocity / 100
                    }):Play();
                    game.Debris:AddItem(v29, 0.2);
                    local _ = v3:CreateHitbox(v27.Player, {
                        Size = Vector3.new(4, 6, 20, 0), 
                        CFrameOffset = CFrame.new(0, 0, -15.25), 
                        Damage = 100, 
                        Time = 0.25, 
                        Knockback = 25, 
                        HitMultiple = false, 
                        Connections = {
                            Hit = function(v30) --[[ Line: 249 ]] --[[ Name: Hit ]]
                                -- upvalues: v4 (ref), v27 (ref), v1 (ref)
                                v4:ApplyStatus(v30, "Stunned", {
                                    Duration = v27.Config.SlashStunTime
                                });
                                v1:Play(v27.Config.Sounds.GashingWoundHit3, {
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
                    v5:FireConnection("DisableSprinting", "QuickAttack", true);
                    local l_v2_SpeedMultiplier_1 = v2:CreateSpeedMultiplier(v27.Rig, 0.01, "StunningKiller");
                    task.delay(0.7, function() --[[ Line: 266 ]]
                        -- upvalues: v5 (ref), l_v2_SpeedMultiplier_1 (copy)
                        v5:FireConnection("DisableSprinting", "QuickAttack", false);
                        l_v2_SpeedMultiplier_1:Destroy();
                    end);
                end;
                return;
            end;
        end
    }
};
v0.Created = function(_, v34) --[[ Line: 276 ]] --[[ Name: Created ]]
    -- upvalues: v2 (copy)
    if game["Run Service"]:IsServer() then
        task.spawn(function() --[[ Line: 279 ]]
            -- upvalues: v34 (copy), v2 (ref)
            if not v34.Cache then
                v34.Cache = {};
            end;
            v34.Cache.GashingWoundStart = v2:LoadAnimationFromID(v34.Rig, v34.Config.Animations.GashingWoundStart);
            v34.Cache.GashingWound = v2:LoadAnimationFromID(v34.Rig, v34.Config.Animations.GashingWound.KillerRig);
        end);
    end;
end;
return v0;