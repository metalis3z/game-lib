-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
local l_RunService_0 = game:GetService("RunService");
local v6 = require(game.ReplicatedStorage.Modules.Schematics.Lighting);
local v7 = require(game.ReplicatedStorage.Modules.Projectiles);
local v8 = require(game.ReplicatedStorage.Modules.AchievementUtil);
local function _(v9, v10, v11) --[[ Line: 14 ]] --[[ Name: pcallMethod ]]
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 15 ]]
        -- upvalues: v11 (copy), v9 (copy)
        if v11.Behavior[v9] then
            v11.Behavior[v9](v11);
        end;
    end);
    if not l_status_0 then
        warn((("[%*]: Failed to call .%*() due to: %*"):format(v10, v9, l_result_0)));
    end;
end;
v0.Abilities = {
    Punch = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "MainAbility", 
        Cooldown = 2, 
        Callback = function(v15) --[[ Line: 41 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v15.AbilitiesDisabled = true;
                v1:Play(v15.Config.Sounds.Swing, {
                    Parent = v15.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.25
                });
                task.delay(v15.Config.PunchWindup, function() --[[ Line: 48 ]]
                    -- upvalues: v3 (ref), v15 (copy), v2 (ref), v1 (ref)
                    local _ = v3:CreateHitbox(v15.Player, {
                        Size = Vector3.new(4.5, 6, 5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1.5), 
                        Damage = v15.Config.AttackDamage, 
                        Time = v15.Config.PunchLinger, 
                        Knockback = 2, 
                        HitMultiple = false, 
                        ExecuteOnKill = true, 
                        Connections = {
                            Hit = function(v16) --[[ Line: 60 ]] --[[ Name: Hit ]]
                                -- upvalues: v2 (ref), v1 (ref), v15 (ref)
                                v2:CreateSpeedMultiplier(v16, 1.5, "HitSpeedBonus", 1.25);
                                v1:Play(v15.Config.Sounds.Hit, {
                                    Parent = v15.Rig.PrimaryPart, 
                                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                    Volume = 0.25
                                });
                            end
                        }
                    });
                end);
                task.delay(0.75, function() --[[ Line: 69 ]]
                    -- upvalues: v15 (copy)
                    v15.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v15.Animations.Attack:Play(0.025);
                end;
                return;
            end;
        end
    }, 
    CorruptNature = {
        LayoutOrder = 2, 
        Icon = "rbxassetid://81200466982776", 
        KeybindType = "AltAbility1", 
        Cooldown = 16, 
        Callback = function(v18) --[[ Line: 86 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v2 (copy), v4 (copy), v7 (copy)
            if game["Run Service"]:IsServer() then
                v18.AbilitiesDisabled = true;
                v1:Play(v18.Config.Sounds.CorruptThrow, {
                    Parent = v18.Rig.PrimaryPart
                });
                local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v18.Player, 0.01, "HinderedMovement");
                task.delay(0.4, function() --[[ Line: 94 ]]
                    -- upvalues: l_v2_SpeedMultiplier_0 (copy)
                    game.TweenService:Create(l_v2_SpeedMultiplier_0, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                        Value = 1
                    }):Play();
                    game.Debris:AddItem(l_v2_SpeedMultiplier_0, 0.5);
                end);
                task.delay(0.1, function() --[[ Line: 100 ]]
                    -- upvalues: v18 (copy), v2 (ref), v1 (ref), v4 (ref), v7 (ref)
                    local l_Position_0 = (v18.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -20)).Position;
                    l_Position_0 = if v18.Player:GetAttribute("Device") == "Mobile" then v2:GetPlayerMousePosition(v18.Player, true) else v2:GetPlayerMousePosition(v18.Player);
                    local v21 = CFrame.lookAt(v18.Rig.PrimaryPart.Position, l_Position_0) * CFrame.new(0, 0, -500);
                    local l_PrimaryPart_0 = v18.Rig.PrimaryPart;
                    local v23 = v18.Config.Projectile and v18.Config.Projectile:Clone() or Instance.new("Part");
                    v23.Name = "HumanoidRootProjectile";
                    v23.Anchored = true;
                    v23.CanCollide = false;
                    v23.CanQuery = false;
                    v23.CanTouch = false;
                    if not v18.Config.NoProjectileResize then
                        v23.Size = Vector3.new(1, 2, 2, 0);
                    end;
                    local v24 = l_PrimaryPart_0.CFrame + Vector3.new(0, (v18.Rig.Humanoid.HipHeight + l_PrimaryPart_0.Size.Y / 2) / 2, 0);
                    local v25 = (v21.Position - v24.Position) / 10;
                    v1:Play(v18.Config.Sounds.CorruptAmbience, {
                        Parent = v23, 
                        Looped = true
                    });
                    local v26 = 0;
                    local v28 = {
                        Size = Vector3.new(3, 3, 3, 0), 
                        Damage = v18.Config.RootPartDamage, 
                        Time = 10, 
                        Knockback = 0.5, 
                        HitMultiple = true, 
                        PredictVelocity = false, 
                        Connections = {
                            Hit = function(v27) --[[ Line: 138 ]] --[[ Name: Hit ]]
                                -- upvalues: v26 (ref), v18 (ref), v2 (ref), v4 (ref), v1 (ref)
                                v26 = v26 + 1;
                                if v26 >= 2 then
                                    require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(v18.Player, "c00lkiddProjectile");
                                end;
                                v2:RevealPlayerAuraTo(v18.Player, v27, 10);
                                v4:ApplyStatus(v27, "Slowness", {
                                    Level = 1, 
                                    Duration = 4
                                });
                                v1:Play(v18.Config.Sounds.CorruptHit, {
                                    Parent = v27.PrimaryPart, 
                                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                    Volume = 0.4
                                });
                                if tostring(v27.Parent) == "Survivors" then
                                    require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v18.Player, {
                                        Action = "Landed Corrupt Nature hit", 
                                        RewardType = "RegularKillerAction"
                                    });
                                end;
                            end
                        }
                    };
                    local v29 = vector.create(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360));
                    local v30 = {
                        Owner = v18.Player, 
                        HitboxConfig = v28, 
                        Lifetime = 10, 
                        InitialCFrame = v24, 
                        InitialVelocity = v25, 
                        Model = v23, 
                        ClientCallbackData = v18.Config.NoProjectileJitter and {} or {
                            OnHeartbeat = {
                                Rotation = {
                                    rotation = v29
                                }
                            }
                        }
                    };
                    v7.new(v30):Launch();
                end);
                task.delay(1.2, function() --[[ Line: 185 ]]
                    -- upvalues: v18 (copy)
                    v18.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v18.Animations.CorruptNature:Play(0.025);
                end;
                return;
            end;
        end
    }, 
    WalkspeedOverride = {
        LayoutOrder = 3, 
        Icon = "rbxassetid://101955457812737", 
        KeybindType = "AltAbility2", 
        Cooldown = 20, 
        Callback = function(v31) --[[ Line: 202 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v1 (copy), v3 (copy), v4 (copy)
            local l_WalkspeedOverrideDuration_0 = v31.Config.WalkspeedOverrideDuration;
            if game["Run Service"]:IsServer() then
                v31.AbilitiesDisabled = true;
                v2:SetSpeedCap(v31.Rig, "C00lkiddWalkspeedOverride", v31.Config.WalkspeedOverrideSpeed);
                local l_TweenService_0 = game:GetService("TweenService");
                local v34 = v31.Config.c00lguiTemplate:Clone();
                local l_JointInstance_0 = v34:FindFirstChildWhichIsA("JointInstance");
                if l_JointInstance_0 and v34:IsA("BasePart") then
                    local l_Size_0 = v34.Size;
                    local v37 = l_TweenService_0:Create(v34, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = l_Size_0
                    });
                    local v38 = l_TweenService_0:Create(v34, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                        Size = Vector3.new(0, 0, 0, 0)
                    });
                    v34.Parent = v31.Rig;
                    v34.Anchored = false;
                    v34.Size = Vector3.new(0, 0, 0, 0);
                    l_JointInstance_0.Part0 = v31.Rig.PrimaryPart;
                    v37:Play();
                    task.delay(0.25, v38.Play, v38);
                end;
                game.Debris:AddItem(v34, 1);
                local v39 = ("%*/WalkspeedStart"):format(script.Parent);
                local l_pcall_0 = pcall;
                local v41 = "WalkspeedStart";
                local v42;
                l_pcall_0, v42 = l_pcall_0(function() --[[ Line: 15 ]]
                    -- upvalues: v31 (copy), v41 (copy)
                    if v31.Behavior[v41] then
                        v31.Behavior[v41](v31);
                    end;
                end);
                if not l_pcall_0 then
                    warn((("[%*]: Failed to call .WalkspeedStart() due to: %*"):format(v39, v42)));
                end;
                task.delay(v31.Config.WalkspeedOverrideWindup, function() --[[ Line: 232 ]]
                    -- upvalues: v1 (ref), v31 (copy), v3 (ref), l_WalkspeedOverrideDuration_0 (copy), v4 (ref), v2 (ref)
                    local v43 = v1:Play(v31.Config.Sounds.WalkspeedOverrideLoop, {
                        Parent = v31.Rig.PrimaryPart, 
                        Looped = true
                    });
                    local v44 = nil;
                    local v45 = nil;
                    local l_v3_Hitbox_1 = v3:CreateHitbox(v31.Player, {
                        Size = Vector3.new(7, 5, 6, 0), 
                        Damage = v31.Config.WalkspeedOverrideDamage, 
                        CFrameOffset = CFrame.new(0, 0, -1.5), 
                        Time = l_WalkspeedOverrideDuration_0, 
                        Knockback = v31.Config.WalkspeedOverrideKnockback, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v46) --[[ Line: 245 ]] --[[ Name: Hit ]]
                                -- upvalues: v44 (ref), v4 (ref), v31 (ref)
                                v44 = v46;
                                v4:ApplyStatus(v46, "Burning", {
                                    Level = 1, 
                                    Duration = 8
                                });
                                v4:ApplyStatus(v46, "Slowness", {
                                    Level = 10, 
                                    Duration = 0.25, 
                                    Hidden = true
                                });
                                v31.Rig.firebrand.Transparency = 0;
                                task.delay(1.5, function() --[[ Line: 250 ]]
                                    -- upvalues: v31 (ref)
                                    game.TweenService:Create(v31.Rig.firebrand, TweenInfo.new(0.5), {
                                        Transparency = 1
                                    }):Play();
                                end);
                                local v47 = ("%*/Start"):format(script.Parent);
                                local l_v31_0 = v31;
                                local l_pcall_1 = pcall;
                                local v50 = "WalkspeedHit";
                                local v51;
                                l_pcall_1, v51 = l_pcall_1(function() --[[ Line: 15 ]]
                                    -- upvalues: l_v31_0 (copy), v50 (copy)
                                    if l_v31_0.Behavior[v50] then
                                        l_v31_0.Behavior[v50](l_v31_0);
                                    end;
                                end);
                                if not l_pcall_1 then
                                    warn((("[%*]: Failed to call .WalkspeedHit() due to: %*"):format(v47, v51)));
                                end;
                                if tostring(v46.Parent) == "Survivors" then
                                    v47 = require(game.ReplicatedStorage.Modules.Actors);
                                    if v46.Humanoid.Health <= 0 then
                                        v47:IncrementActorStats(v31.Player, {
                                            Action = "Killed a Survivor with Walkspeed Override", 
                                            RewardType = "DifficultKillerAction"
                                        });
                                        return;
                                    else
                                        v47:IncrementActorStats(v31.Player, {
                                            Action = "Landed Walkspeed Override hit", 
                                            RewardType = "RegularKillerAction"
                                        });
                                    end;
                                end;
                            end, 
                            Ended = function() --[[ Line: 269 ]] --[[ Name: Ended ]]
                                -- upvalues: v43 (copy), v45 (ref)
                                game.TweenService:Create(v43, TweenInfo.new(0.5), {
                                    PlaybackSpeed = 0
                                });
                                game.Debris:AddItem(v43, 1);
                                v45 = true;
                            end
                        }
                    });
                    local v53 = require(game.ReplicatedStorage.Modules.Network);
                    local l_LookVector_0 = v31:GetPivot().LookVector;
                    local v55 = v2:ApplyVelocity(v31.Rig.PrimaryPart, v31.Config.WalkspeedOverrideSpeed);
                    v55.LineDirection = (l_LookVector_0 * Vector3.new(1, 0, 1, 0)).Unit;
                    game.Debris:AddItem(v55, l_WalkspeedOverrideDuration_0 + 3);
                    game.TweenService:Create(v55, TweenInfo.new(l_WalkspeedOverrideDuration_0 * 1.5), {
                        LineVelocity = v31.Config.WalkspeedOverrideSpeed / 2
                    }):Play();
                    v1:Play(v31.Config.Sounds.WalkspeedOverrideLunge, {
                        Parent = v31.Rig.PrimaryPart
                    });
                    local v56 = false;
                    local v57 = ("%*C00lkiddCollision"):format(v31.Player.Name);
                    v53:SetConnection(v57, "REMOTE_EVENT", function(v58) --[[ Line: 293 ]]
                        -- upvalues: v31 (ref), v56 (ref)
                        if v58 ~= v31.Player then
                            v58:Kick("not slick at all");
                            return;
                        else
                            v56 = true;
                            return;
                        end;
                    end);
                    repeat
                        task.wait();
                    until v44 or v45 or v56;
                    local v59 = "IDK";
                    if v44 then
                        v59 = "Hit";
                        v2:GiveInvincible(v31.Rig, "Walkspeed");
                    elseif v56 then
                        v59 = "Collide";
                    elseif v45 then
                        v59 = "Timeout";
                    end;
                    local l_StringValue_0 = Instance.new("StringValue");
                    l_StringValue_0.Name = "Result";
                    l_StringValue_0.Value = v59;
                    l_StringValue_0.Parent = v31.Rig;
                    game.Debris:AddItem(l_StringValue_0, 1.5);
                    task.delay(1.5, function() --[[ Line: 324 ]]
                        -- upvalues: v31 (ref), v2 (ref)
                        v31.AbilitiesDisabled = false;
                        v2:RemoveInvincible(v31.Rig, "Walkspeed");
                    end);
                    game.TweenService:Create(v55, TweenInfo.new(v59 == "Collide" and 0.25 or 0.5), {
                        LineVelocity = 0
                    }):Play();
                    game.Debris:AddItem(v55, 1.5);
                    v1:PlayVoiceline(v31, ("WalkspeedOverride%*"):format(v59), {
                        Priority = 1.5
                    });
                    v1:Play(v31.Config.Sounds[("WalkspeedOverride%*"):format(v59)], {
                        Parent = v31.Rig.PrimaryPart
                    });
                    v2:SetSpeedCap(v31.Rig, "C00lkiddWalkspeedOverride", nil);
                    v53:RemoveConnection(v57, "REMOTE_EVENT");
                    l_v3_Hitbox_1:Cancel();
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v31.Animations.WalkspeedOverrideStart:Play();
                    task.delay(v31.Config.WalkspeedOverrideWindup, function() --[[ Line: 342 ]]
                        -- upvalues: v31 (copy)
                        v31.Animations.WalkspeedOverrideLoop.Looped = true;
                        v31.Animations.WalkspeedOverrideLoop:Play();
                    end);
                    v31.Rig:SetAttribute("FootstepsMuted", true);
                    local l_v2_SpeedMultiplier_1 = v2:CreateSpeedMultiplier(v31.Player, 0, "HinderedMovement");
                    local v62 = nil;
                    do
                        local l_v62_0 = v62;
                        task.spawn(function() --[[ Line: 354 ]]
                            -- upvalues: v31 (copy), l_v62_0 (ref)
                            v31.Rig.PrimaryPart:WaitForChild("LinearVelocity", 2);
                            local v64 = 0;
                            local v65 = false;
                            while true do
                                if not l_v62_0 and v31.Rig.PrimaryPart then
                                    if v64 >= 0.2 and v31.Rig.PrimaryPart.AssemblyLinearVelocity.Magnitude <= v31.Config.WalkspeedOverrideSpeed / 3 then
                                        if not v65 then
                                            require(game.ReplicatedStorage.Modules.Network):FireServerConnection(("%*C00lkiddCollision"):format(v31.Player.Name), "REMOTE_EVENT");
                                            v65 = true;
                                        end;
                                        return;
                                    else
                                        v64 = v64 + game["Run Service"].Heartbeat:Wait();
                                    end;
                                else
                                    return;
                                end;
                            end;
                        end);
                        local v66 = v31.Rig:WaitForChild("Result", 6);
                        l_v62_0 = v66 and v66.Value or "IDK BRUH";
                        v31.Rig:SetAttribute("FootstepsMuted", nil);
                        v31.Animations.WalkspeedOverrideStart:Stop();
                        v31.Animations.WalkspeedOverrideLoop:Stop();
                        if l_v62_0 == "Hit" then
                            v31.Animations.WalkspeedOverrideHit:Play(0);
                        elseif not v31.Animations.WalkspeedOverrideDuration and not v31.Animations.WalkspeedOverrideCollide then
                            v31.Animations.WalkspeedOverrideMiss:Play(0.05);
                        elseif l_v62_0 == "Timeout" and v31.Animations.WalkspeedOverrideDuration then
                            v31.Animations.WalkspeedOverrideDuration:Play(0.05);
                        elseif l_v62_0 == "Collide" and v31.Animations.WalkspeedOverrideCollide then
                            v31.Animations.WalkspeedOverrideCollide:Play(0.05);
                        end;
                        if v66 then
                            repeat
                                task.wait();
                            until not v66.Parent;
                        end;
                        game.TweenService:Create(l_v2_SpeedMultiplier_1, TweenInfo.new(0.5), {
                            Value = 1
                        }):Play();
                        game.Debris:AddItem(l_v2_SpeedMultiplier_1, 0.5);
                    end;
                end;
                return;
            end;
        end
    }, 
    PizzaDelivery = {
        LayoutOrder = 4, 
        Icon = "rbxassetid://105652328381208", 
        KeybindType = "AltAbility3", 
        Cooldown = 50, 
        Callback = function(v67) --[[ Line: 413 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v2 (copy), v8 (copy), v4 (copy)
            if game["Run Service"]:IsServer() then
                v67.AbilitiesDisabled = true;
                v1:Play(v67.Config.Sounds.PizzaDeliveryPunchGround, {
                    Parent = v67.Rig.PrimaryPart
                });
                local v68 = ("%*/Summon"):format(script.Parent);
                local l_pcall_2 = pcall;
                local v70 = "MinionSummon";
                local v71;
                l_pcall_2, v71 = l_pcall_2(function() --[[ Line: 15 ]]
                    -- upvalues: v67 (copy), v70 (copy)
                    if v67.Behavior[v70] then
                        v67.Behavior[v70](v67);
                    end;
                end);
                if not l_pcall_2 then
                    warn((("[%*]: Failed to call .MinionSummon() due to: %*"):format(v68, v71)));
                end;
                task.delay(1, function() --[[ Line: 420 ]]
                    -- upvalues: v67 (copy), v2 (ref), v1 (ref), v8 (ref), v4 (ref)
                    for v72 = 1, 2 do
                        local l_PizzaDeliveryRig_0 = v67.Config.PizzaDeliveryRig;
                        local v74 = (l_PizzaDeliveryRig_0:IsA("Folder") and l_PizzaDeliveryRig_0:GetChildren()[math.random(1, #l_PizzaDeliveryRig_0:GetChildren())] or l_PizzaDeliveryRig_0):Clone();
                        v74:SetAttribute("Team", "Killers");
                        v74.PrimaryPart.Anchored = true;
                        v2:FixCharacter(v74, "Killers");
                        v2:AddHitboxes(v74, "Killers");
                        local l_Humanoid_0 = v74.Humanoid;
                        l_Humanoid_0.WalkSpeed = v67.Config.PizzaDeliveryGuySpeed;
                        l_Humanoid_0.MaxHealth = v67.Config.PizzaDeliveryGuyHealth;
                        l_Humanoid_0.Health = v67.Config.PizzaDeliveryGuyHealth;
                        l_Humanoid_0.StateChanged:Connect(function(_, _) --[[ Line: 437 ]]
                            -- upvalues: l_Humanoid_0 (copy)
                            l_Humanoid_0.PlatformStand = false;
                            l_Humanoid_0:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false);
                            l_Humanoid_0:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
                            l_Humanoid_0:ChangeState(Enum.HumanoidStateType.GettingUp);
                        end);
                        local v78 = v1:Play(v67.Config.Sounds.PizzaDeliveryMinionIdle, {
                            Parent = v74.PrimaryPart, 
                            Looped = true, 
                            Volume = 0
                        });
                        game.TweenService:Create(v78, TweenInfo.new(1.75), {
                            Volume = 0.5
                        }):Play();
                        local v79 = false;
                        do
                            local l_v79_0 = v79;
                            local _ = function(v81) --[[ Line: 450 ]] --[[ Name: removeRigAfter ]]
                                -- upvalues: l_v79_0 (ref), v78 (copy), v74 (copy)
                                task.delay(v81 - 1, function() --[[ Line: 451 ]]
                                    -- upvalues: l_v79_0 (ref), v78 (ref), v74 (ref)
                                    if not l_v79_0 then
                                        l_v79_0 = true;
                                        if v78 and v78.Parent then
                                            game.TweenService:Create(v78, TweenInfo.new(0.8), {
                                                PlaybackSpeed = 0
                                            }):Play();
                                        end;
                                        game.Debris:AddItem(v74, 1);
                                        for _, v83 in pairs(v74:GetDescendants()) do
                                            if v83:IsA("BasePart") or v83:IsA("Decal") then
                                                game.TweenService:Create(v83, TweenInfo.new(1), {
                                                    Transparency = 1
                                                }):Play();
                                            end;
                                        end;
                                    end;
                                end);
                            end;
                            local l_PizzaDeliveryGuyLifetime_0 = v67.Config.PizzaDeliveryGuyLifetime;
                            task.delay(l_PizzaDeliveryGuyLifetime_0 - 1, function() --[[ Line: 451 ]]
                                -- upvalues: l_v79_0 (ref), v78 (copy), v74 (copy)
                                if not l_v79_0 then
                                    l_v79_0 = true;
                                    if v78 and v78.Parent then
                                        game.TweenService:Create(v78, TweenInfo.new(0.8), {
                                            PlaybackSpeed = 0
                                        }):Play();
                                    end;
                                    game.Debris:AddItem(v74, 1);
                                    for _, v87 in pairs(v74:GetDescendants()) do
                                        if v87:IsA("BasePart") or v87:IsA("Decal") then
                                            game.TweenService:Create(v87, TweenInfo.new(1), {
                                                Transparency = 1
                                            }):Play();
                                        end;
                                    end;
                                end;
                            end);
                            game.Debris:AddItem(v74, v67.Config.PizzaDeliveryGuyLifetime);
                            v74.Parent = workspace.Map.Ingame;
                            l_PizzaDeliveryGuyLifetime_0 = {};
                            for v88, v89 in pairs(v67.Config.PizzaDeliveryAnimations) do
                                l_PizzaDeliveryGuyLifetime_0[v88] = v2:LoadAnimationFromID(v74, v89, true);
                            end;
                            l_PizzaDeliveryGuyLifetime_0.Idle:Play();
                            l_PizzaDeliveryGuyLifetime_0.Summoned:Play(0);
                            v74:SetPrimaryPartCFrame(v67.Rig.PrimaryPart.CFrame * CFrame.new(v72 % 2 == 0 and 6 or -6, 0, 0));
                            v74.Humanoid.Died:Once(function() --[[ Line: 485 ]]
                                -- upvalues: v78 (copy), v1 (ref), v67 (ref), v74 (copy)
                                v78:Destroy();
                                v1:Play(v67.Config.Sounds.PizzaDeliveryMinionDeath, {
                                    Parent = v74.PrimaryPart, 
                                    PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
                                });
                            end);
                            v1:Play(v67.Config.Sounds.PizzaDeliveryGuySpawned, {
                                Parent = v67.Rig.PrimaryPart
                            });
                            v74:AddTag("Ragdoll");
                            v2:RevealPlayerAuraTo(v67.Player, v74, 600, Color3.new(0.666667, 0, 0));
                            task.wait(0.75);
                            task.delay(1.75, function() --[[ Line: 498 ]]
                                -- upvalues: v74 (copy), l_PizzaDeliveryGuyLifetime_0 (copy), l_Humanoid_0 (copy), v2 (ref), v67 (ref), v1 (ref), l_v79_0 (ref), v78 (copy), v8 (ref), v4 (ref)
                                if not v74.PrimaryPart then
                                    return;
                                else
                                    v74.PrimaryPart.Anchored = false;
                                    l_PizzaDeliveryGuyLifetime_0.Walk:Play();
                                    local v90 = require(game.ReplicatedStorage.Modules.Actors);
                                    local v91 = require(game.ReplicatedStorage.Modules.SimplePath).new(v74);
                                    while task.wait() and v74.Parent and v74.PrimaryPart and l_Humanoid_0.Health > 0 do
                                        local l_v2_ClosestPlayerFromPosition_0, v93 = v2:GetClosestPlayerFromPosition(v74.PrimaryPart.Position);
                                        local v94 = l_v2_ClosestPlayerFromPosition_0 and l_v2_ClosestPlayerFromPosition_0.PrimaryPart and l_v2_ClosestPlayerFromPosition_0.PrimaryPart.Position;
                                        local v95 = l_v2_ClosestPlayerFromPosition_0 and game.Players:GetPlayerFromCharacter(l_v2_ClosestPlayerFromPosition_0);
                                        local v96 = v95 and v90.CurrentActors[v95];
                                        if v67.Rig.Parent and v93 and v93 < v67.Config.PizzaDeliveryGuyAttackRadius then
                                            require(game.ReplicatedStorage.Modules.Ragdolls).AddProfile(l_v2_ClosestPlayerFromPosition_0, {
                                                Velocity = (l_v2_ClosestPlayerFromPosition_0.PrimaryPart.Position - v74.PrimaryPart.Position).Unit * 30
                                            });
                                            v1:Play(v67.Config.Sounds.PizzaDeliveryMinionHit, {
                                                Parent = v74.PrimaryPart
                                            });
                                            task.delay(1, function() --[[ Line: 451 ]]
                                                -- upvalues: l_v79_0 (ref), v78 (ref), v74 (ref)
                                                if not l_v79_0 then
                                                    l_v79_0 = true;
                                                    if v78 and v78.Parent then
                                                        game.TweenService:Create(v78, TweenInfo.new(0.8), {
                                                            PlaybackSpeed = 0
                                                        }):Play();
                                                    end;
                                                    game.Debris:AddItem(v74, 1);
                                                    for _, v98 in pairs(v74:GetDescendants()) do
                                                        if v98:IsA("BasePart") or v98:IsA("Decal") then
                                                            game.TweenService:Create(v98, TweenInfo.new(1), {
                                                                Transparency = 1
                                                            }):Play();
                                                        end;
                                                    end;
                                                end;
                                            end);
                                            l_PizzaDeliveryGuyLifetime_0.Walk:Stop(0);
                                            l_PizzaDeliveryGuyLifetime_0.Hit:Play(0);
                                            v2:ApplyDamage(l_v2_ClosestPlayerFromPosition_0, v67.Config.PizzaDeliveryGuyDamage);
                                            if l_v2_ClosestPlayerFromPosition_0.Name == "Elliot" and not v2:IsAlive(l_v2_ClosestPlayerFromPosition_0) then
                                                v8:IncrementAchievementProgress(v67.Player, "c00lkiddPizzaMinion");
                                            end;
                                            v2:RevealPlayerAuraTo(v67.Player, l_v2_ClosestPlayerFromPosition_0, 7.5);
                                            local v99 = ("%*/MinionHit"):format(script.Parent);
                                            local l_v67_0 = v67;
                                            local l_pcall_3 = pcall;
                                            local v102 = "MinionHit";
                                            local v103;
                                            l_pcall_3, v103 = l_pcall_3(function() --[[ Line: 15 ]]
                                                -- upvalues: l_v67_0 (copy), v102 (copy)
                                                if l_v67_0.Behavior[v102] then
                                                    l_v67_0.Behavior[v102](l_v67_0);
                                                end;
                                            end);
                                            if not l_pcall_3 then
                                                warn((("[%*]: Failed to call .MinionHit() due to: %*"):format(v99, v103)));
                                            end;
                                            v4:ApplyStatus(l_v2_ClosestPlayerFromPosition_0, "Burning", {
                                                Level = 1, 
                                                Duration = 3
                                            });
                                            v4:ApplyStatus(l_v2_ClosestPlayerFromPosition_0, "Slowness", {
                                                Level = 2, 
                                                Duration = 3
                                            });
                                            v1:PlayVoiceline(v67, "PizzaDeliveryHit", {
                                                Priority = 0, 
                                                Chance = 1
                                            });
                                            if tostring(l_v2_ClosestPlayerFromPosition_0.Parent) == "Survivors" then
                                                require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v67.Player, {
                                                    Action = "A pizza delivery minion attacked a Survivor", 
                                                    RewardType = "EasyKillerAction"
                                                });
                                            end;
                                            if v96 and v96.Behavior then
                                                v96.Behavior.AILastSeen = nil;
                                                break;
                                            else
                                                break;
                                            end;
                                        elseif v67.Rig.Parent and v94 then
                                            if v96 and v96.Behavior then
                                                v96.Behavior.AILastSeen = tick();
                                            end;
                                            v91:Run(v94);
                                        else
                                            task.delay(1, function() --[[ Line: 451 ]]
                                                -- upvalues: l_v79_0 (ref), v78 (ref), v74 (ref)
                                                if not l_v79_0 then
                                                    l_v79_0 = true;
                                                    if v78 and v78.Parent then
                                                        game.TweenService:Create(v78, TweenInfo.new(0.8), {
                                                            PlaybackSpeed = 0
                                                        }):Play();
                                                    end;
                                                    game.Debris:AddItem(v74, 1);
                                                    for _, v105 in pairs(v74:GetDescendants()) do
                                                        if v105:IsA("BasePart") or v105:IsA("Decal") then
                                                            game.TweenService:Create(v105, TweenInfo.new(1), {
                                                                Transparency = 1
                                                            }):Play();
                                                        end;
                                                    end;
                                                end;
                                            end);
                                            l_Humanoid_0.WalkSpeed = 0;
                                            l_PizzaDeliveryGuyLifetime_0.Walk:Stop(0);
                                            break;
                                        end;
                                    end;
                                    if v91 and v91.Destroy then
                                        v91:Destroy();
                                    end;
                                    return;
                                end;
                            end);
                        end;
                    end;
                end);
                task.delay(3, function() --[[ Line: 576 ]]
                    -- upvalues: v67 (copy)
                    v67.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v67.Animations.SummonPizzaDelivery:Play(0.025);
                    local l_v2_SpeedMultiplier_2 = v2:CreateSpeedMultiplier(v67.Player, 0, "HinderedMovement");
                    task.delay(2.5, function() --[[ Line: 587 ]]
                        -- upvalues: l_v2_SpeedMultiplier_2 (copy)
                        game.TweenService:Create(l_v2_SpeedMultiplier_2, TweenInfo.new(0.5), {
                            Value = 1
                        }):Play();
                        game.Debris:AddItem(l_v2_SpeedMultiplier_2, 0.5);
                    end);
                end;
                return;
            end;
        end
    }
};
v0.OnIntroduction = function(_, v108, v109, v110) --[[ Line: 597 ]] --[[ Name: OnIntroduction ]]
    task.spawn(function() --[[ Line: 598 ]]
        -- upvalues: v109 (copy)
        local v111 = v109:WaitForChild("firebrand", 20);
        if v111 then
            v111.Transparency = 0;
        end;
    end);
    local v112 = nil;
    task.delay(0.5, function() --[[ Line: 606 ]]
        -- upvalues: v112 (ref)
        v112 = game.Lighting.ClockTime;
        game.TweenService:Create(game.Lighting, TweenInfo.new(0.75), {
            ClockTime = 0
        }):Play();
    end);
    task.delay(1.5, function() --[[ Line: 611 ]]
        -- upvalues: v108 (copy), v112 (ref), v110 (copy)
        local v113 = v108.Config.IntroSky:Clone();
        v113.Parent = game.Lighting;
        game.TweenService:Create(game.Lighting, TweenInfo.new(1.5), {
            ClockTime = v112 or 12
        }):Play();
        game.Debris:AddItem(v113, v110 - 1.5);
    end);
end;
v0.OnVictory = function(_, v115, v116, _, v118) --[[ Line: 619 ]] --[[ Name: OnVictory ]]
    -- upvalues: v6 (copy), l_RunService_0 (copy)
    if v115 == "Start" then
        v6:SetCustomLighting(v116.Config.OutroLighting);
        local _ = tick();
        game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true);
        local v120 = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 628 ]]
            workspace.CurrentCamera.FieldOfView = 25;
        end);
        task.delay(v118, function() --[[ Line: 632 ]]
            -- upvalues: v120 (copy)
            v120:Disconnect();
        end);
        task.spawn(function() --[[ Line: 637 ]]
            -- upvalues: v116 (copy), v118 (copy), l_RunService_0 (ref)
            local v121 = v116.Config.IntroSky:Clone();
            v121.Parent = game.Lighting;
            game.Debris:AddItem(v121, v118 - 1.5);
            local v122 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 3);
            if v122 then
                local v123 = nil;
                do
                    local l_v123_0 = v123;
                    l_v123_0 = l_RunService_0.RenderStepped:Connect(function(v125) --[[ Line: 645 ]]
                        -- upvalues: v122 (copy), l_v123_0 (ref)
                        if not v122 or not v122.Parent or not v122:FindFirstChild("People") then
                            l_v123_0:Disconnect();
                            return;
                        else
                            for v126, v127 in pairs(v122.People:GetChildren()) do
                                local l_PrimaryPart_1 = v127.PrimaryPart;
                                l_PrimaryPart_1.CFrame = l_PrimaryPart_1.CFrame * CFrame.Angles(0, v125 * (v126 % 2 == 0 and 2.25 or -2.25), 0);
                            end;
                            task.wait();
                            return;
                        end;
                    end);
                    task.delay(v118, l_v123_0.Disconnect, l_v123_0);
                end;
            end;
        end);
        return;
    else
        if v115 == "End" then
            game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", false);
            game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil);
            v6:SetAsCurrentLighting();
        end;
        return;
    end;
end;
v0.OnExecution = function(_, v130, v131) --[[ Line: 667 ]] --[[ Name: OnExecution ]]
    local v132 = false;
    if v131.Name == "007n7" then
        v132 = v130.Rig.PrimaryPart.CFrame * CFrame.new(3, -2.75, 2.25) * CFrame.Angles(1.5707963267948966, 0, -0.3490658503988659);
    end;
    local v133 = v131.Name == "007n7" and Vector3.new() or (v130.Rig.PrimaryPart.CFrame * CFrame.new(5, 0.5, 1)).LookVector.Unit * 200;
    local v134 = v131.Name == "007n7" and 3.6 or 3.5;
    local v135 = require(game.ReplicatedStorage.Modules.Ragdolls);
    task.delay(2.1, function() --[[ Line: 677 ]]
        -- upvalues: v135 (copy), v131 (copy), v133 (copy)
        v135.AddProfile(v131, {
            AnchorDelay = true, 
            Applied = os.clock() + 5, 
            Velocity = v133
        });
        local l_Humanoid_1 = v131:FindFirstChild("Humanoid");
        if l_Humanoid_1 then
            l_Humanoid_1.BreakJointsOnDeath = false;
            l_Humanoid_1.Health = 0;
        end;
    end);
    task.delay(v134, function() --[[ Line: 686 ]]
        -- upvalues: v131 (copy)
        if v131 and v131.PrimaryPart then
            v131.PrimaryPart.Anchored = false;
        end;
    end);
end;
return v0;