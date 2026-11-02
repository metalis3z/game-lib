-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
v0.Abilities = {
    Punch = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "MainAbility", 
        Cooldown = 2, 
        Callback = function(v5) --[[ Line: 15 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v5.AbilitiesDisabled = true;
                v1:Play(v5.Config.Sounds.Swing, {
                    Parent = v5.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.25
                });
                task.delay(0.1, function() --[[ Line: 22 ]]
                    -- upvalues: v3 (ref), v5 (copy), v2 (ref), v1 (ref)
                    local _ = v3:CreateHitbox(v5.Player, {
                        Size = Vector3.new(4.5, 6, 5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1.5), 
                        Damage = v5.Config.AttackDamage, 
                        Time = 0.3, 
                        Knockback = 2, 
                        HitMultiple = false, 
                        ExecuteOnKill = true, 
                        Connections = {
                            Hit = function(v6) --[[ Line: 34 ]] --[[ Name: Hit ]]
                                -- upvalues: v2 (ref), v1 (ref), v5 (ref)
                                v2:CreateSpeedMultiplier(v6, 1.5, "HitSpeedBonus", 1.25);
                                v1:Play(v5.Config.Sounds.Hit, {
                                    Parent = v5.Rig.PrimaryPart, 
                                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                    Volume = 0.25
                                });
                            end
                        }
                    });
                end);
                task.delay(0.75, function() --[[ Line: 43 ]]
                    -- upvalues: v5 (copy)
                    v5.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v5.Animations.Attack:Play(0.025);
                end;
                return;
            end;
        end
    }, 
    CorruptNature = {
        LayoutOrder = 2, 
        Icon = "rbxassetid://81200466982776", 
        KeybindType = "AltAbility1", 
        Cooldown = 12, 
        Callback = function(v8) --[[ Line: 60 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v2 (copy), v3 (copy)
            if game["Run Service"]:IsServer() then
                v8.AbilitiesDisabled = true;
                v1:Play(v8.Config.Sounds.CorruptThrow, {
                    Parent = v8.Rig.PrimaryPart
                });
                local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v8.Player, 0.01, "HinderedMovement");
                game.TweenService:Create(l_v2_SpeedMultiplier_0, TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                    Value = 1
                }):Play();
                game.Debris:AddItem(l_v2_SpeedMultiplier_0, 1.5);
                task.delay(0.1, function() --[[ Line: 72 ]]
                    -- upvalues: v8 (copy), v2 (ref), v1 (ref), v3 (ref)
                    local v10 = Vector3.new();
                    print(v8.Player);
                    if v8.Player:GetAttribute("Device") == "Mobile" then
                        local l_v2_ClosestPlayerFromPosition_0, v12 = v2:GetClosestPlayerFromPosition(v8.Rig.PrimaryPart.Position, {
                            PlayerSelection = "Survivors"
                        });
                        local l_Position_0 = l_v2_ClosestPlayerFromPosition_0.PrimaryPart.Position;
                        local l_AssemblyLinearVelocity_0 = l_v2_ClosestPlayerFromPosition_0.PrimaryPart.AssemblyLinearVelocity;
                        local l_Magnitude_0 = l_AssemblyLinearVelocity_0.Magnitude;
                        v10 = if l_Magnitude_0 == 0 then l_Position_0 else l_Position_0 + l_AssemblyLinearVelocity_0 * (v12 / l_Magnitude_0);
                    else
                        v10 = v2:GetPlayerMousePosition(v8.Player);
                    end;
                    local v16 = CFrame.lookAt(v8.Rig.PrimaryPart.Position, v10) * CFrame.new(0, 0, -500);
                    local l_Part_0 = Instance.new("Part");
                    l_Part_0.Name = "HumanoidRootProjectile";
                    l_Part_0.Anchored = true;
                    l_Part_0.CanCollide = false;
                    l_Part_0.Size = Vector3.new(1, 2, 2, 0);
                    l_Part_0.CFrame = v8.Rig.PrimaryPart.CFrame;
                    l_Part_0.Parent = workspace.Map.Ingame;
                    game.Debris:AddItem(l_Part_0, 10);
                    game.TweenService:Create(l_Part_0, TweenInfo.new(10, Enum.EasingStyle.Linear), {
                        Position = v16.Position
                    }):Play();
                    v1:Play(v8.Config.Sounds.CorruptAmbience, {
                        Parent = l_Part_0, 
                        Looped = true
                    });
                    task.spawn(function() --[[ Line: 105 ]]
                        -- upvalues: l_Part_0 (copy)
                        while task.wait() and l_Part_0.Parent do
                            l_Part_0.Orientation = Vector3.new(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360));
                        end;
                    end);
                    local v18 = 0;
                    v3:CreateHitbox(v8.Player, {
                        Size = Vector3.new(3, 3, 3, 0), 
                        CFrame = function() --[[ Line: 115 ]] --[[ Name: CFrame ]]
                            -- upvalues: l_Part_0 (copy)
                            return l_Part_0.CFrame;
                        end, 
                        Damage = v8.Config.RootPartDamage, 
                        Time = 10, 
                        Knockback = 0.5, 
                        HitMultiple = true, 
                        PredictVelocity = false, 
                        Connections = {
                            Hit = function(v19) --[[ Line: 124 ]] --[[ Name: Hit ]]
                                -- upvalues: v18 (ref), v8 (ref), v2 (ref), v1 (ref)
                                v18 = v18 + 1;
                                if v18 >= 2 then
                                    require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(v8.Player, "c00lkiddProjectile");
                                end;
                                v2:RevealPlayerAuraTo(v8.Player, v19, 10);
                                v1:Play(v8.Config.Sounds.CorruptHit, {
                                    Parent = v19.PrimaryPart, 
                                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                    Volume = 0.4
                                });
                            end
                        }
                    });
                end);
                task.delay(2, function() --[[ Line: 139 ]]
                    -- upvalues: v8 (copy)
                    v8.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v8.Animations.CorruptNature:Play(0.025);
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
        Callback = function(v20) --[[ Line: 156 ]] --[[ Name: Callback ]]
            -- upvalues: v3 (copy), v4 (copy), v1 (copy), v2 (copy)
            local l_WalkspeedOverrideTimeout_0 = v20.Config.WalkspeedOverrideTimeout;
            if game["Run Service"]:IsServer() then
                v20.AbilitiesDisabled = true;
                task.delay(0.125, function() --[[ Line: 164 ]]
                    -- upvalues: v3 (ref), v20 (copy), l_WalkspeedOverrideTimeout_0 (copy), v4 (ref), v1 (ref)
                    local v22 = nil;
                    local v23 = nil;
                    local l_v3_Hitbox_1 = v3:CreateHitbox(v20.Player, {
                        Size = Vector3.new(5, 5, 5, 0), 
                        Damage = v20.Config.WalkspeedOverrideDamage, 
                        Time = l_WalkspeedOverrideTimeout_0, 
                        Knockback = 4.5, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v24) --[[ Line: 176 ]] --[[ Name: Hit ]]
                                -- upvalues: v22 (ref), v4 (ref), v20 (ref)
                                v22 = v24;
                                v4:ApplyStatus(v24, "Burning", {
                                    Level = 1, 
                                    Duration = 8
                                });
                                v4:ApplyStatus(v24, "Slowness", {
                                    Level = 3, 
                                    Duration = 1, 
                                    Hidden = true
                                });
                                v20.Rig.firebrand.Transparency = 0;
                                task.delay(1.5, function() --[[ Line: 181 ]]
                                    -- upvalues: v20 (ref)
                                    game.TweenService:Create(v20.Rig.firebrand, TweenInfo.new(0.5), {
                                        Transparency = 1
                                    }):Play();
                                end);
                            end, 
                            Ended = function() --[[ Line: 183 ]] --[[ Name: Ended ]]
                                -- upvalues: v23 (ref)
                                v23 = true;
                            end
                        }
                    });
                    local v26 = v20.Rig.PrimaryPart.AssemblyMass * 1000;
                    local l_LinearVelocity_0 = Instance.new("LinearVelocity");
                    l_LinearVelocity_0.RelativeTo = Enum.ActuatorRelativeTo.World;
                    l_LinearVelocity_0.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
                    l_LinearVelocity_0.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector;
                    l_LinearVelocity_0.MaxAxesForce = Vector3.new(v26, 0, v26);
                    l_LinearVelocity_0.VectorVelocity = v20.Rig.PrimaryPart.CFrame.LookVector * v20.Config.WalkspeedOverrideSpeed;
                    l_LinearVelocity_0.Attachment0 = v20.Rig.PrimaryPart:FindFirstChild("RootAttachment");
                    l_LinearVelocity_0.Parent = v20.Rig.PrimaryPart;
                    game.Debris:AddItem(l_LinearVelocity_0, l_WalkspeedOverrideTimeout_0 + 3);
                    game.TweenService:Create(l_LinearVelocity_0, TweenInfo.new(l_WalkspeedOverrideTimeout_0 * 1.5), {
                        VectorVelocity = l_LinearVelocity_0.VectorVelocity / 2
                    }):Play();
                    v1:Play(v20.Config.Sounds.WalkspeedOverrideLunge, {
                        Parent = v20.Rig.PrimaryPart
                    });
                    local v28 = false;
                    local v29 = ("%*C00lkiddCollision"):format(v20.Player.Name);
                    local v30 = require(game.ReplicatedStorage.Modules.Network);
                    v30:SetConnection(v29, "REMOTE_EVENT", function(v31) --[[ Line: 209 ]]
                        -- upvalues: v20 (ref), v28 (ref)
                        if v31 == v20.Player then
                            v28 = true;
                        end;
                    end);
                    repeat
                        task.wait();
                    until v22 or v23 or v28;
                    local v32 = "IDK";
                    if v22 then
                        v32 = "Hit";
                    elseif v28 then
                        v32 = "Collide";
                    elseif v23 then
                        v32 = "Timeout";
                    end;
                    local l_StringValue_0 = Instance.new("StringValue");
                    l_StringValue_0.Name = "Result";
                    l_StringValue_0.Value = v32;
                    l_StringValue_0.Parent = v20.Rig;
                    game.Debris:AddItem(l_StringValue_0, 1.5);
                    task.delay(1.5, function() --[[ Line: 236 ]]
                        -- upvalues: v20 (ref)
                        v20.AbilitiesDisabled = false;
                    end);
                    game.TweenService:Create(l_LinearVelocity_0, TweenInfo.new(0.5), {
                        VectorVelocity = Vector3.new()
                    }):Play();
                    game.Debris:AddItem(l_LinearVelocity_0, 1.5);
                    v1:PlayVoiceline(v20, (("WalkspeedOverride%*"):format(v32)));
                    v1:Play(v20.Config.Sounds[("WalkspeedOverride%*"):format(v32)], {
                        Parent = v20.Rig.PrimaryPart
                    });
                    v30:RemoveConnection(v29, "REMOTE_EVENT");
                    l_v3_Hitbox_1:Cancel();
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v20.Animations.WalkspeedOverrideStart:Play(0.025);
                    v20.Animations.WalkspeedOverrideLoop:Play();
                    v20.Rig:SetAttribute("FootstepsMuted", true);
                    local l_v2_SpeedMultiplier_1 = v2:CreateSpeedMultiplier(v20.Player, 0, "HinderedMovement");
                    local v35 = nil;
                    do
                        local l_v35_0 = v35;
                        task.spawn(function() --[[ Line: 260 ]]
                            -- upvalues: l_v35_0 (ref), v20 (copy)
                            local v37 = 0;
                            local v38 = false;
                            while true do
                                if not l_v35_0 and v20.Rig.PrimaryPart then
                                    if v37 >= 0.3 and v20.Rig.PrimaryPart.Velocity.Magnitude <= 6 then
                                        if not v38 then
                                            require(game.ReplicatedStorage.Modules.Network):FireServerConnection(("%*C00lkiddCollision"):format(v20.Player.Name), "REMOTE_EVENT");
                                            v38 = true;
                                        end;
                                        return;
                                    else
                                        v37 = v37 + task.wait();
                                    end;
                                else
                                    return;
                                end;
                            end;
                        end);
                        local v39 = v20.Rig:WaitForChild("Result", 6);
                        l_v35_0 = v39 and v39.Value or "IDK BRUH";
                        v20.Rig:SetAttribute("FootstepsMuted", nil);
                        v20.Animations.WalkspeedOverrideLoop:Stop();
                        if l_v35_0 == "Hit" then
                            v20.Animations.WalkspeedOverrideHit:Play(0);
                        else
                            v20.Animations.WalkspeedOverrideMiss:Play(0.05);
                        end;
                        if v39 then
                            repeat
                                task.wait();
                            until not v39.Parent;
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
        Callback = function(v40) --[[ Line: 305 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v2 (copy), v4 (copy)
            if game["Run Service"]:IsServer() then
                v40.AbilitiesDisabled = true;
                v1:Play(v40.Config.Sounds.PizzaDeliveryPunchGround, {
                    Parent = v40.Rig.PrimaryPart
                });
                task.delay(1, function() --[[ Line: 312 ]]
                    -- upvalues: v40 (copy), v2 (ref), v1 (ref), v4 (ref)
                    for v41 = 1, 2 do
                        local v42 = v40.Config.PizzaDeliveryRig:Clone();
                        v42:SetAttribute("Team", "Killers");
                        v42.PrimaryPart.Anchored = true;
                        local l_Humanoid_0 = v42.Humanoid;
                        l_Humanoid_0.WalkSpeed = v40.Config.PizzaDeliveryGuySpeed;
                        l_Humanoid_0.MaxHealth = v40.Config.PizzaDeliveryGuyHealth;
                        l_Humanoid_0.Health = v40.Config.PizzaDeliveryGuyHealth;
                        l_Humanoid_0.StateChanged:Connect(function(_, _) --[[ Line: 324 ]]
                            -- upvalues: l_Humanoid_0 (copy)
                            l_Humanoid_0.PlatformStand = false;
                            l_Humanoid_0:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false);
                            l_Humanoid_0:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
                            l_Humanoid_0:ChangeState(Enum.HumanoidStateType.GettingUp);
                        end);
                        v42.Parent = workspace.Map.Ingame;
                        local v46 = false;
                        do
                            local l_v46_0 = v46;
                            local _ = function(v48) --[[ Line: 335 ]] --[[ Name: removeRigAfter ]]
                                -- upvalues: l_v46_0 (ref), v42 (copy)
                                task.delay(v48 - 1, function() --[[ Line: 336 ]]
                                    -- upvalues: l_v46_0 (ref), v42 (ref)
                                    if not l_v46_0 then
                                        l_v46_0 = true;
                                        game.Debris:AddItem(v42, 1);
                                        for _, v50 in pairs(v42:GetDescendants()) do
                                            if v50:IsA("BasePart") or v50:IsA("Decal") then
                                                game.TweenService:Create(v50, TweenInfo.new(1), {
                                                    Transparency = 1
                                                }):Play();
                                            end;
                                        end;
                                    end;
                                end);
                            end;
                            local l_PizzaDeliveryGuyLifetime_0 = v40.Config.PizzaDeliveryGuyLifetime;
                            task.delay(l_PizzaDeliveryGuyLifetime_0 - 1, function() --[[ Line: 336 ]]
                                -- upvalues: l_v46_0 (ref), v42 (copy)
                                if not l_v46_0 then
                                    l_v46_0 = true;
                                    game.Debris:AddItem(v42, 1);
                                    for _, v54 in pairs(v42:GetDescendants()) do
                                        if v54:IsA("BasePart") or v54:IsA("Decal") then
                                            game.TweenService:Create(v54, TweenInfo.new(1), {
                                                Transparency = 1
                                            }):Play();
                                        end;
                                    end;
                                end;
                            end);
                            game.Debris:AddItem(v42, v40.Config.PizzaDeliveryGuyLifetime);
                            l_PizzaDeliveryGuyLifetime_0 = {};
                            for v55, v56 in pairs(v40.Config.PizzaDeliveryAnimations) do
                                l_PizzaDeliveryGuyLifetime_0[v55] = v2:LoadAnimationFromID(v42, v56, true);
                            end;
                            l_PizzaDeliveryGuyLifetime_0.Idle:Play();
                            l_PizzaDeliveryGuyLifetime_0.Summoned:Play(0);
                            v42:SetPrimaryPartCFrame(v40.Rig.PrimaryPart.CFrame * CFrame.new(v41 % 2 == 0 and 6 or -6, 0, 0));
                            v1:Play(v40.Config.Sounds.PizzaDeliveryGuySpawned, {
                                Parent = v40.Rig.PrimaryPart
                            });
                            task.wait(0.75);
                            task.delay(1.75, function() --[[ Line: 369 ]]
                                -- upvalues: v42 (copy), l_PizzaDeliveryGuyLifetime_0 (copy), v2 (ref), v40 (ref), l_v46_0 (ref), v4 (ref), v1 (ref), l_Humanoid_0 (copy)
                                if not v42.PrimaryPart then
                                    return;
                                else
                                    v42.PrimaryPart.Anchored = false;
                                    l_PizzaDeliveryGuyLifetime_0.Walk:Play();
                                    local v57 = require(game.ReplicatedStorage.Modules.SimplePath).new(v42, {
                                        AgentRadius = 3, 
                                        AgentCanJump = false
                                    });
                                    while task.wait() and v42.Parent and v42.PrimaryPart do
                                        local l_v2_ClosestPlayerFromPosition_1, v59 = v2:GetClosestPlayerFromPosition(v42.PrimaryPart.Position);
                                        local v60 = l_v2_ClosestPlayerFromPosition_1 and l_v2_ClosestPlayerFromPosition_1.PrimaryPart and l_v2_ClosestPlayerFromPosition_1.PrimaryPart.Position;
                                        if v40.Rig.Parent and v59 and v59 < v40.Config.PizzaDeliveryGuyAttackRadius then
                                            task.delay(1, function() --[[ Line: 336 ]]
                                                -- upvalues: l_v46_0 (ref), v42 (ref)
                                                if not l_v46_0 then
                                                    l_v46_0 = true;
                                                    game.Debris:AddItem(v42, 1);
                                                    for _, v62 in pairs(v42:GetDescendants()) do
                                                        if v62:IsA("BasePart") or v62:IsA("Decal") then
                                                            game.TweenService:Create(v62, TweenInfo.new(1), {
                                                                Transparency = 1
                                                            }):Play();
                                                        end;
                                                    end;
                                                end;
                                            end);
                                            l_PizzaDeliveryGuyLifetime_0.Walk:Stop(0);
                                            l_PizzaDeliveryGuyLifetime_0.Hit:Play(0);
                                            v2:ApplyDamage(l_v2_ClosestPlayerFromPosition_1, v40.Config.PizzaDeliveryGuyDamage);
                                            v2:RevealPlayerAuraTo(v40.Player, l_v2_ClosestPlayerFromPosition_1, 7.5);
                                            v4:ApplyStatus(l_v2_ClosestPlayerFromPosition_1, "Burning");
                                            v4:ApplyStatus(l_v2_ClosestPlayerFromPosition_1, "Slowness", {
                                                Level = 2, 
                                                Duration = 3
                                            });
                                            v1:PlayVoiceline(v40, "PizzaDeliveryHit", {
                                                Priority = 0, 
                                                Chance = 1
                                            });
                                            break;
                                        elseif v40.Rig.Parent and v60 then
                                            v57:Run(v60);
                                        else
                                            task.delay(1, function() --[[ Line: 336 ]]
                                                -- upvalues: l_v46_0 (ref), v42 (ref)
                                                if not l_v46_0 then
                                                    l_v46_0 = true;
                                                    game.Debris:AddItem(v42, 1);
                                                    for _, v64 in pairs(v42:GetDescendants()) do
                                                        if v64:IsA("BasePart") or v64:IsA("Decal") then
                                                            game.TweenService:Create(v64, TweenInfo.new(1), {
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
                                    v57:Destroy();
                                    return;
                                end;
                            end);
                        end;
                    end;
                end);
                task.delay(3, function() --[[ Line: 407 ]]
                    -- upvalues: v40 (copy)
                    v40.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v40.Animations.SummonPizzaDelivery:Play(0.025);
                    local l_v2_SpeedMultiplier_2 = v2:CreateSpeedMultiplier(v40.Player, 0, "HinderedMovement");
                    task.delay(2.5, function() --[[ Line: 418 ]]
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
v0.OnIntroduction = function(_, _, v68, v69) --[[ Line: 428 ]] --[[ Name: OnIntroduction ]]
    task.spawn(function() --[[ Line: 429 ]]
        -- upvalues: v68 (copy)
        local v70 = v68:WaitForChild("firebrand", 20);
        if v70 then
            v70.Transparency = 0;
        end;
    end);
    local v71 = nil;
    task.delay(0.5, function() --[[ Line: 437 ]]
        -- upvalues: v71 (ref)
        v71 = game.Lighting.ClockTime;
        game.TweenService:Create(game.Lighting, TweenInfo.new(0.75), {
            ClockTime = 0
        }):Play();
    end);
    task.delay(1.5, function() --[[ Line: 442 ]]
        -- upvalues: v71 (ref), v69 (copy)
        local v72 = script.Sky:Clone();
        v72.Parent = game.Lighting;
        game.TweenService:Create(game.Lighting, TweenInfo.new(1.5), {
            ClockTime = v71 or 12
        }):Play();
        game.Debris:AddItem(v72, v69 - 1.5);
    end);
end;
v0.OnVictory = function(_, v74, _, v76, _) --[[ Line: 450 ]] --[[ Name: OnVictory ]]
    if v74 == "Start" then
        game.Lighting.ClockTime = 0;
        task.spawn(function() --[[ Line: 453 ]]
            -- upvalues: v76 (copy)
            local v78 = v76:WaitForChild("firebrand", 20);
            if v78 then
                v78.Transparency = 1;
            end;
        end);
        return;
    else
        if v74 == "End" then
            local v79 = require(game.ReplicatedStorage.Modules.Schematics.Lighting);
            v79:SetCustomLighting(v79.Properties);
        end;
        return;
    end;
end;
v0.OnExecution = function(_, v81, v82) --[[ Line: 465 ]] --[[ Name: OnExecution ]]
    local v83 = (v81.Rig.PrimaryPart.CFrame * CFrame.new(5, 0.5, 1)).LookVector.Unit * 200;
    local v84 = workspace:GetServerTimeNow() + 3.5;
    require(game.ReplicatedStorage.Modules.Network):FireAllClientConnection("Ragdoll", "REMOTE_EVENT", v82, v84, (("%*|%*|%*"):format(v83.X, v83.Y, v83.Z)));
    task.delay(2.1, function() --[[ Line: 475 ]]
        -- upvalues: v82 (copy)
        local l_Humanoid_1 = v82:FindFirstChild("Humanoid");
        if l_Humanoid_1 then
            l_Humanoid_1.BreakJointsOnDeath = false;
            l_Humanoid_1.Health = 0;
        end;
    end);
end;
return v0;