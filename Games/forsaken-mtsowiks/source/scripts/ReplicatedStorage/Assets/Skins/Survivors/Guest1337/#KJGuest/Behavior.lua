-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:09:19 2025 ]]
local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
local _ = require(game.ReplicatedStorage.Modules.Network);
local l_TweenService_0 = game:GetService("TweenService");
v0.Abilities = {
    Punch = {
        LayoutOrder = 3, 
        KeybindType = "AltAbility3", 
        Charges = 0, 
        Icon = "rbxassetid://86535502112498", 
        Callback = function(v7) --[[ Line: 19 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v4 (copy), v2 (copy), l_TweenService_0 (copy)
            if game["Run Service"]:IsServer() then
                v7.Cache.Anims.RavageStart:Play();
                v1:PlayVoiceline(v7, "PunchWindup");
                task.delay(0.55, function() --[[ Line: 25 ]]
                    -- upvalues: v3 (ref), v7 (copy), v4 (ref), v2 (ref), l_TweenService_0 (ref), v1 (ref)
                    local v8 = nil;
                    local v9 = nil;
                    local _ = v3:CreateHitbox(v7.Player, {
                        Damage = 1, 
                        Time = 0.25, 
                        Size = Vector3.new(6, 6, 6, 0), 
                        CFrameOffset = CFrame.new(0, 0, -2.25), 
                        Connections = {
                            Hit = function(v10, v11) --[[ Line: 36 ]] --[[ Name: Hit ]]
                                -- upvalues: v8 (ref), v7 (ref), v4 (ref), v2 (ref), v9 (ref), l_TweenService_0 (ref), v1 (ref)
                                if v11 then
                                    v8 = v10;
                                    v7.Rig:SetAttribute("Invincible", true);
                                    v7.Rig:SetAttribute("NoCamFollow", true);
                                    v4:ApplyStatus(v8, "Stunned", {
                                        Level = 1, 
                                        Duration = 10
                                    });
                                    v2:SetUpCutscene(v7.Rig, v8, CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 5));
                                    v9 = v2:LoadAnimationFromID(v10, v7.Config.Animations.Ravage_Victim, true);
                                    v7.Cache.Anims.RavageStart:Stop();
                                    v7.Cache.Anims.Ravage:Play(0.05);
                                    v9.Priority = Enum.AnimationPriority.Action4;
                                    v9:Play();
                                    v9.TimePosition = v7.Cache.Anims.Ravage.TimePosition;
                                    local v12 = {};
                                    local v13 = script.RavageVFX:Clone();
                                    v13.Parent = workspace;
                                    v13.PrimaryPart.CFrame = v7.Rig.PrimaryPart.CFrame;
                                    local v24 = v7.Cache.Anims.Ravage:GetMarkerReachedSignal("EmitParticle"):Connect(function(v14) --[[ Line: 63 ]]
                                        -- upvalues: v13 (copy), v12 (copy), l_TweenService_0 (ref), v1 (ref), v7 (ref)
                                        local l_v13_FirstChild_0 = v13:FindFirstChild(v14);
                                        if l_v13_FirstChild_0 then
                                            for _, v17 in ipairs(l_v13_FirstChild_0:GetDescendants()) do
                                                if v17:IsA("ParticleEmitter") then
                                                    local l_v17_Attribute_0 = v17:GetAttribute("EmitCount");
                                                    local l_v17_Attribute_1 = v17:GetAttribute("EmitDelay");
                                                    local _ = {};
                                                    local function v22(_) --[[ Line: 73 ]] --[[ Name: smelly ]]
                                                        -- upvalues: l_v13_FirstChild_0 (copy), v17 (copy), l_v17_Attribute_0 (copy)
                                                        if l_v13_FirstChild_0:GetAttribute("Toggle") then
                                                            v17.Enabled = not v17.Enabled;
                                                            return;
                                                        else
                                                            v17:Emit(l_v17_Attribute_0);
                                                            return;
                                                        end;
                                                    end;
                                                    if l_v17_Attribute_1 and l_v17_Attribute_1 > 0 then
                                                        task.delay(l_v17_Attribute_1, v22);
                                                    elseif l_v13_FirstChild_0:GetAttribute("Toggle") then
                                                        v17.Enabled = not v17.Enabled;
                                                    else
                                                        v17:Emit(l_v17_Attribute_0);
                                                    end;
                                                end;
                                            end;
                                            if v12[v14] and l_v13_FirstChild_0:GetAttribute("Toggle") then
                                                local v23 = v12[v14];
                                                v12[v14] = nil;
                                                l_TweenService_0:Create(v23, TweenInfo.new(0.2), {
                                                    Volume = 0
                                                }):Play();
                                                game.Debris:AddItem(v23, 0.2);
                                                return;
                                            else
                                                v12[v14] = v1:Play(v7.Config.Sounds[v14], {
                                                    Parent = v7.Rig.PrimaryPart, 
                                                    RollOffMaxDistance = 75
                                                });
                                            end;
                                        end;
                                    end);
                                    wait(4.416666666666667);
                                    task.delay(2, function() --[[ Line: 102 ]]
                                        -- upvalues: v13 (copy), v24 (copy)
                                        v13:Destroy();
                                        v24:Disconnect();
                                    end);
                                    v7.Rig:SetAttribute("NoCamFollow", nil);
                                    if v9 then
                                        v9:Stop(0);
                                    end;
                                    if v8 and v8.PrimaryPart then
                                        local v25 = RaycastParams.new();
                                        v25.FilterDescendantsInstances = workspace.Players:GetDescendants();
                                        v25.FilterType = Enum.RaycastFilterType.Exclude;
                                        local v26 = workspace:Raycast(v7.Rig.PrimaryPart.Position, v7.Rig.PrimaryPart.CFrame.LookVector * 100, v25);
                                        local v27 = v26 and math.clamp(v26.Distance, -1e999, 3) or 3;
                                        if v27 < 3 then
                                            v27 = -(v8.PrimaryPart.Size.Z / 2) - (3 - v27) * 2;
                                        end;
                                        v8:SetPrimaryPartCFrame(v7.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, 3.141592653589793, 0));
                                        v8.PrimaryPart.Anchored = false;
                                        v8.PrimaryPart.Velocity = (v7.Rig.PrimaryPart.CFrame.LookVector + Vector3.new(0, 0.5, 0, 0)) * (750 * (v27 / 3));
                                        local v28 = v1:Play(v7.Config.Sounds.RavageScream, {
                                            Parent = v8.PrimaryPart
                                        });
                                        l_TweenService_0:Create(v28, TweenInfo.new(1.5), {
                                            Volume = 0
                                        }):Play();
                                        local v29 = (v7.Rig.PrimaryPart.CFrame.LookVector + Vector3.new(0, 0.5, 0, 0)) * (750 * (v27 / 3));
                                        task.delay(0.02, function() --[[ Line: 129 ]]
                                            -- upvalues: v8 (ref), v29 (copy)
                                            v8.PrimaryPart.Velocity = v29;
                                        end);
                                        local v30 = require(game.ReplicatedStorage.Modules.Ragdolls);
                                        v30.AddProfile(v8, {
                                            Velocity = v29
                                        });
                                        v30.EnableRagdoll(v8, 1.25);
                                    end;
                                end;
                            end
                        }
                    });
                    wait(0.4);
                    if not v8 then
                        local v32 = Instance.new("IntValue", v7.Rig);
                        v32.Name = "IMissed";
                        game.Debris:AddItem(v32, 2);
                        v7.Rig.PrimaryPart.Anchored = false;
                    else
                        wait(5);
                        v7.Rig.PrimaryPart.Anchored = false;
                        v7.Rig:SetAttribute("Invincible", false);
                    end;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    local _ = tick();
                    local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v7.Player, 1, "Cutscene", 5.5);
                    l_TweenService_0:Create(l_v2_SpeedMultiplier_0, TweenInfo.new(0.3), {
                        Value = 0.001
                    }):Play();
                    v7.Rig:WaitForChild("IMissed", 5.5);
                    l_TweenService_0:Create(l_v2_SpeedMultiplier_0, TweenInfo.new(0.3), {
                        Value = 1
                    }):Play();
                end;
                return;
            end;
        end
    }
};
v0.Created = function(_, v36) --[[ Line: 175 ]] --[[ Name: Created ]]
    -- upvalues: v2 (copy)
    if game["Run Service"]:IsServer() then
        v36.Rig:SetAttribute("HitboxPriority", 2);
        task.spawn(function() --[[ Line: 180 ]]
            -- upvalues: v36 (copy), v2 (ref)
            if not v36.Cache then
                v36.Cache = {};
            end;
            v36.Cache.Anims = {};
            v36.Cache.Anims.RavageStart = v2:LoadAnimationFromID(v36.Rig, v36.Config.Animations.Parry);
            v36.Cache.Anims.Ravage = v2:LoadAnimationFromID(v36.Rig, v36.Config.Animations.Ravage);
            v36.Cache.Anims.RavageStart.Looped = false;
            v36.Cache.Anims.Ravage.Looped = false;
        end);
    end;
end;
v0.OnHit = function(_, v38, v39) --[[ Line: 191 ]] --[[ Name: OnHit ]]
    -- upvalues: v1 (copy), v2 (copy), v4 (copy), v0 (copy)
    if not v39.IsProjectile and v39.Creator and v38.Blocking then
        v38.Blocking = nil;
        v38:IncrementCharges("Punch", 1, 1);
        v1:Play(v38.Config.Sounds.BlockSuccess, {
            Parent = v38.Rig.PrimaryPart
        });
        v2:ApplyDamage(v38.Rig, v39.Damage or 0);
        local l_v2_SpeedMultiplier_1 = v2:CreateSpeedMultiplier(v39.Creator, 1 * v38.Config.KillerSlownessPercent / 100);
        if l_v2_SpeedMultiplier_1 then
            game.Debris:AddItem(l_v2_SpeedMultiplier_1, v38.Config.KillerSlownessDuration);
        end;
        v4:ApplyStatus(v38.Player, "Speed", {
            Level = 1, 
            Duration = 2
        });
        v4:RemoveStatus(v38.Player, "Resistance");
        if v38.BlockingSlowness then
            game.TweenService:Create(v38.BlockingSlowness, TweenInfo.new(1), {
                Value = 1
            }):Play();
            game.Debris:AddItem(v38.BlockingSlowness, 1);
            v38.BlockingSlowness = nil;
        end;
        if v38.BlockedThread then
            task.cancel(v38.BlockedThread);
        end;
        v38.Blocked = true;
        v38.BlockedThread = task.delay(v38.Config.BlockDuration, function() --[[ Line: 223 ]]
            -- upvalues: v38 (copy)
            v38.Blocked = nil;
        end);
        local l_QueryHitbox_0 = v38.Rig:FindFirstChild("QueryHitbox");
        if l_QueryHitbox_0 and v0.DefaultHitboxSize then
            l_QueryHitbox_0.Size = v0.DefaultHitboxSize;
        end;
        require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v38.Player, {
            Action = "Successfully blocked an attack", 
            RewardType = "Survivalist"
        });
        if not v38.BlockCount then
            v38.BlockCount = 0;
        end;
        v38.BlockCount = v38.BlockCount + 1;
        if v38.BlockCount >= 3 then
            require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(v38.Player, "GuestBlock");
        end;
        return "Ignored";
    else
        return;
    end;
end;
return v0;