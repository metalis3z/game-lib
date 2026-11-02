-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("Players");
local l_TweenService_0 = game:GetService("TweenService");
local l_Assets_0 = game:GetService("ReplicatedStorage").Assets;
local v3 = {};
local v4 = require(game.ReplicatedStorage.Modules.Sounds);
local v5 = require(game.ReplicatedStorage.Modules.Util);
local v6 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v7 = require(game.ReplicatedStorage.Modules.Statuses);
v3.Abilities = {
    Punch = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "MainAbility", 
        Cooldown = 2, 
        Callback = function(v8) --[[ Line: 20 ]] --[[ Name: Callback ]]
            -- upvalues: v4 (copy), v6 (copy), v5 (copy)
            if game["Run Service"]:IsServer() then
                v8.AbilitiesDisabled = true;
                v4:Play(v8.Config.Sounds.Swing, {
                    Parent = v8.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.25
                });
                task.delay(0.1, function() --[[ Line: 27 ]]
                    -- upvalues: v6 (ref), v8 (copy), v5 (ref), v4 (ref)
                    local _ = v6:CreateHitbox(v8.Player, {
                        Size = Vector3.new(4.5, 6, 5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1.5), 
                        Damage = v8.Config.AttackDamage, 
                        Time = 0.3, 
                        Knockback = 2, 
                        HitMultiple = false, 
                        ExecuteOnKill = true, 
                        Connections = {
                            Hit = function(v9) --[[ Line: 39 ]] --[[ Name: Hit ]]
                                -- upvalues: v8 (ref), v5 (ref), v4 (ref)
                                if v9.Humanoid.Health <= 0 then
                                    local v10 = v8.Config.Sign:Clone();
                                    v9.Humanoid:AddAccessory(v10);
                                end;
                                v5:CreateSpeedMultiplier(v9, 1.5, "HitSpeedBonus", 1.25);
                                v4:Play(v8.Config.Sounds.Hit, {
                                    Parent = v8.Rig.PrimaryPart, 
                                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                    Volume = 0.25
                                });
                            end
                        }
                    });
                end);
                task.delay(0.75, function() --[[ Line: 52 ]]
                    -- upvalues: v8 (copy)
                    v8.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v8.Animations.Attack:Play(0.025);
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
        Callback = function(v12) --[[ Line: 69 ]] --[[ Name: Callback ]]
            -- upvalues: v4 (copy), v5 (copy), l_Assets_0 (copy), v6 (copy), v7 (copy)
            if game["Run Service"]:IsServer() then
                v12.AbilitiesDisabled = true;
                v4:Play(v12.Config.Sounds.CorruptThrow, {
                    Parent = v12.Rig.PrimaryPart, 
                    Volume = 0.25
                });
                local l_v5_SpeedMultiplier_0 = v5:CreateSpeedMultiplier(v12.Player, 0.01, "HinderedMovement");
                task.delay(0.4, function() --[[ Line: 77 ]]
                    -- upvalues: l_v5_SpeedMultiplier_0 (copy)
                    game.TweenService:Create(l_v5_SpeedMultiplier_0, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                        Value = 1
                    }):Play();
                    game.Debris:AddItem(l_v5_SpeedMultiplier_0, 0.5);
                end);
                task.delay(0.1, function() --[[ Line: 83 ]]
                    -- upvalues: v12 (copy), v5 (ref), l_Assets_0 (ref), v4 (ref), v6 (ref), v7 (ref)
                    local l_Position_0 = (v12.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -20)).Position;
                    l_Position_0 = if v12.Player:GetAttribute("Device") == "Mobile" then v5:GetPlayerMousePosition(v12.Player, true) else v5:GetPlayerMousePosition(v12.Player);
                    local v15 = CFrame.lookAt(v12.Rig.PrimaryPart.Position, l_Position_0) * CFrame.new(0, 0, -500);
                    local v16 = l_Assets_0.Instances.Bunny:Clone();
                    local l_Torso_0 = v16.Torso;
                    v16:PivotTo(v12.Rig.PrimaryPart.CFrame);
                    v16.Parent = workspace.Map.Ingame;
                    v4:Play(v12.Config.Sounds.Bunny, {
                        Parent = v16.Head
                    });
                    game.Debris:AddItem(v16, 10);
                    game.TweenService:Create(l_Torso_0, TweenInfo.new(10, Enum.EasingStyle.Linear), {
                        Position = v15.Position
                    }):Play();
                    local v18 = 0;
                    v6:CreateHitbox(v12.Player, {
                        Size = Vector3.new(3, 3, 3, 0), 
                        CFrame = function() --[[ Line: 108 ]] --[[ Name: CFrame ]]
                            -- upvalues: l_Torso_0 (copy)
                            return l_Torso_0.CFrame;
                        end, 
                        Damage = v12.Config.RootPartDamage, 
                        Time = 10, 
                        Knockback = 0.5, 
                        HitMultiple = true, 
                        PredictVelocity = false, 
                        Connections = {
                            Hit = function(v19) --[[ Line: 117 ]] --[[ Name: Hit ]]
                                -- upvalues: v18 (ref), v12 (ref), v5 (ref), v7 (ref)
                                v18 = v18 + 1;
                                if v18 >= 2 then
                                    require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(v12.Player, "c00lkiddProjectile");
                                end;
                                v5:RevealPlayerAuraTo(v12.Player, v19, 10);
                                v7:ApplyStatus(v19, "Slowness", {
                                    Level = 1, 
                                    Duration = 4
                                });
                                if v19.Humanoid.Health <= 0 then
                                    local v20 = v12.Config.Sign:Clone();
                                    v19.Humanoid:AddAccessory(v20);
                                end;
                                if tostring(v19.Parent) == "Survivors" then
                                    require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v12.Player, {
                                        Action = "Landed Corrupt Nature hit", 
                                        RewardType = "RegularKillerAction"
                                    });
                                end;
                            end
                        }
                    });
                end);
                task.delay(1.2, function() --[[ Line: 145 ]]
                    -- upvalues: v12 (copy)
                    v12.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then

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
        Callback = function(v21) --[[ Line: 161 ]] --[[ Name: Callback ]]
            -- upvalues: v5 (copy), v4 (copy), v6 (copy), v7 (copy)
            local l_WalkspeedOverrideTimeout_0 = v21.Config.WalkspeedOverrideTimeout;
            if game["Run Service"]:IsServer() then
                local v23 = "IDK";
                v21.AbilitiesDisabled = true;
                v21.Rig.firebrand.Transparency = 0;
                v21.Rig.firebrand.Trail.Enabled = true;
                v5:SetSpeedCap(v21.Rig, "C00lkiddWalkspeedOverride", v21.Config.WalkspeedOverrideSpeed);
                task.spawn(function() --[[ Line: 173 ]]
                    -- upvalues: v4 (ref), v21 (copy), v23 (ref)
                    v4:Play(v21.Config.Sounds.SwordUnsheath, {
                        Parent = v21.Rig.firebrand
                    });
                    repeat
                        v4:Play("netSpin", {
                            Parent = v21.Rig:FindFirstChild("firebrand")
                        });
                        task.wait(0.5);
                    until v23 ~= "IDK" or not v21.Rig.PrimaryPart;
                end);
                task.delay(0.125, function() --[[ Line: 184 ]]
                    -- upvalues: v6 (ref), v21 (copy), l_WalkspeedOverrideTimeout_0 (copy), v7 (ref), v5 (ref), v4 (ref), v23 (ref)
                    local v24 = nil;
                    local v25 = nil;
                    local l_v6_Hitbox_1 = v6:CreateHitbox(v21.Player, {
                        Size = Vector3.new(7, 5, 6, 0), 
                        Damage = v21.Config.WalkspeedOverrideDamage, 
                        Time = l_WalkspeedOverrideTimeout_0, 
                        Knockback = 4.5, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v26) --[[ Line: 196 ]] --[[ Name: Hit ]]
                                -- upvalues: v21 (ref), v24 (ref), v7 (ref)
                                if v26.Humanoid.Health <= 0 then
                                    local v27 = v21.Config.Sign:Clone();
                                    v26.Humanoid:AddAccessory(v27);
                                end;
                                v24 = v26;
                                v7:ApplyStatus(v26, "Burning", {
                                    Level = 1, 
                                    Duration = 8
                                });
                                task.spawn(function() --[[ Line: 206 ]]
                                    -- upvalues: v26 (copy)
                                    for _ = 1, math.random(3, 6) do
                                        local v29 = script.Blood:Clone();
                                        v29.CFrame = v26.PrimaryPart.CFrame * CFrame.new(math.random(-3, 3), math.random(-3, 3), math.random(-3, 3));
                                        v29.Parent = workspace;
                                        game.Debris:AddItem(v29, 10);
                                        task.wait(math.random(0.25, 0.75));
                                    end;
                                end);
                                if tostring(v26.Parent) == "Survivors" then
                                    local v30 = require(game.ReplicatedStorage.Modules.Actors);
                                    if v26.Humanoid.Health <= 0 then
                                        v30:IncrementActorStats(v21.Player, {
                                            Action = "Killed a Survivor with Walkspeed Override", 
                                            RewardType = "DifficultKillerAction"
                                        });
                                        return;
                                    else
                                        v30:IncrementActorStats(v21.Player, {
                                            Action = "Landed Walkspeed Override hit", 
                                            RewardType = "RegularKillerAction"
                                        });
                                    end;
                                end;
                            end, 
                            Ended = function() --[[ Line: 236 ]] --[[ Name: Ended ]]
                                -- upvalues: v25 (ref)
                                v25 = true;
                            end
                        }
                    });
                    local v32 = v5:ApplyVelocity(v21.Rig.PrimaryPart, v21.Config.WalkspeedOverrideSpeed);
                    game.Debris:AddItem(v32, l_WalkspeedOverrideTimeout_0 + 3);
                    game.TweenService:Create(v32, TweenInfo.new(l_WalkspeedOverrideTimeout_0 * 1.5), {
                        LineVelocity = v21.Config.WalkspeedOverrideSpeed / 2
                    }):Play();
                    v4:Play(v21.Config.Sounds.WalkspeedOverrideLunge, {
                        Parent = v21.Rig.PrimaryPart
                    });
                    local v33 = false;
                    local v34 = ("%*C00lkiddCollision"):format(v21.Player.Name);
                    local v35 = require(game.ReplicatedStorage.Modules.Network);
                    v35:SetConnection(v34, "REMOTE_EVENT", function(v36) --[[ Line: 254 ]]
                        -- upvalues: v21 (ref), v33 (ref)
                        if v36 == v21.Player then
                            v33 = true;
                        end;
                    end);
                    repeat
                        task.wait();
                    until v24 or v25 or v33;
                    v21.Rig.firebrand.Trail.Enabled = false;
                    task.delay(1.5, function() --[[ Line: 264 ]]
                        -- upvalues: v21 (ref)
                        game.TweenService:Create(v21.Rig.firebrand, TweenInfo.new(0.5), {
                            Transparency = 1
                        }):Play();
                    end);
                    if v24 then
                        v23 = "Hit";
                        v21.Rig:SetAttribute("Invincible", true);
                    elseif v33 then
                        v23 = "Collide";
                    elseif v25 then
                        v23 = "Timeout";
                    end;
                    local l_StringValue_0 = Instance.new("StringValue");
                    l_StringValue_0.Name = "Result";
                    l_StringValue_0.Value = v23;
                    l_StringValue_0.Parent = v21.Rig;
                    game.Debris:AddItem(l_StringValue_0, 1.5);
                    task.delay(1.5, function() --[[ Line: 284 ]]
                        -- upvalues: v21 (ref)
                        v21.AbilitiesDisabled = false;
                        v21.Rig:SetAttribute("Invincible", nil);
                    end);
                    game.TweenService:Create(v32, TweenInfo.new(v23 == "Collide" and 0.25 or 0.5), {
                        LineVelocity = 0
                    }):Play();
                    game.Debris:AddItem(v32, 1.5);
                    v4:PlayVoiceline(v21, ("WalkspeedOverride%*"):format(v23), {
                        Priority = 1.5
                    });
                    v4:Play(v21.Config.Sounds[("WalkspeedOverride%*"):format(v23)], {
                        Parent = v21.Rig.PrimaryPart
                    });
                    v5:SetSpeedCap(v21.Rig, "C00lkiddWalkspeedOverride", nil);
                    v35:RemoveConnection(v34, "REMOTE_EVENT");
                    l_v6_Hitbox_1:Cancel();
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v21.Animations.WalkspeedOverrideLoop:Play();
                    v21.Rig:SetAttribute("FootstepsMuted", true);
                    local l_v5_SpeedMultiplier_1 = v5:CreateSpeedMultiplier(v21.Player, 0, "HinderedMovement");
                    local v39 = nil;
                    do
                        local l_v39_0 = v39;
                        task.spawn(function() --[[ Line: 309 ]]
                            -- upvalues: l_v39_0 (ref), v21 (copy)
                            local v41 = 0;
                            local v42 = false;
                            while true do
                                if not l_v39_0 and v21.Rig.PrimaryPart then
                                    if v41 >= 0.4 and v21.Rig.PrimaryPart.Velocity.Magnitude <= 18 then
                                        if not v42 then
                                            require(game.ReplicatedStorage.Modules.Network):FireServerConnection(("%*C00lkiddCollision"):format(v21.Player.Name), "REMOTE_EVENT");
                                            v42 = true;
                                        end;
                                        return;
                                    else
                                        v41 = v41 + task.wait();
                                    end;
                                else
                                    return;
                                end;
                            end;
                        end);
                        local v43 = v21.Rig:WaitForChild("Result", 6);
                        l_v39_0 = v43 and v43.Value or "IDK BRUH";
                        v21.Rig:SetAttribute("FootstepsMuted", nil);
                        v21.Animations.WalkspeedOverrideLoop:Stop();
                        if l_v39_0 == "Hit" then
                            v21.Animations.WalkspeedOverrideHit:Play(0);
                        else
                            v21.Animations.WalkspeedOverrideMiss:Play(0.05);
                        end;
                        if v43 then
                            repeat
                                task.wait();
                            until not v43.Parent;
                        end;
                        game.TweenService:Create(l_v5_SpeedMultiplier_1, TweenInfo.new(0.5), {
                            Value = 1
                        }):Play();
                        game.Debris:AddItem(l_v5_SpeedMultiplier_1, 0.5);
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
        Callback = function(v44) --[[ Line: 354 ]] --[[ Name: Callback ]]
            -- upvalues: v4 (copy), v5 (copy), v7 (copy)
            if game["Run Service"]:IsServer() then
                v44.AbilitiesDisabled = true;
                v44.Rig.WalkieTalkie.Transparency = 0;
                task.delay(3, function() --[[ Line: 361 ]]
                    -- upvalues: v44 (copy)
                    v44.Rig.WalkieTalkie.Transparency = 1;
                end);
                local v45 = {};
                local v46 = false;
                task.spawn(function() --[[ Line: 368 ]]
                    -- upvalues: v45 (copy), v46 (ref)
                    local v47 = 0;
                    repeat
                        v47 = (v47 + 1) % 360;
                        local v48 = Color3.fromHSV(v47 / 360, 1, 1);
                        for _, v50 in pairs(v45) do
                            v50.Color3 = v48;
                        end;
                        task.wait(0.01);
                    until v46 == true;
                end);
                local l_MafiasoSpawn_0 = v44.Config.Sounds.MafiasoSpawn;
                local v52 = l_MafiasoSpawn_0[math.random(1, #l_MafiasoSpawn_0)];
                v4:Play(v52, {
                    Parent = v44.Rig.PrimaryPart
                });
                task.delay(1, function() --[[ Line: 389 ]]
                    -- upvalues: v4 (ref), v44 (copy), v45 (copy), v5 (ref), v7 (ref)
                    for v53 = 1, 2 do
                        v4:Play(v44.Config.Sounds.PizzaDeliveryGuySpawned, {
                            Parent = v44.Rig.PrimaryPart
                        });
                        local v54 = v44.Config.Mafiasos[math.random(1, 3)]:Clone();
                        v54:SetAttribute("Team", "Killers");
                        v54.PrimaryPart.Anchored = true;
                        local l_Humanoid_0 = v54.Humanoid;
                        l_Humanoid_0.WalkSpeed = v44.Config.PizzaDeliveryGuySpeed;
                        l_Humanoid_0.MaxHealth = v44.Config.PizzaDeliveryGuyHealth;
                        l_Humanoid_0.Health = v44.Config.PizzaDeliveryGuyHealth;
                        l_Humanoid_0.StateChanged:Connect(function(_, _) --[[ Line: 403 ]]
                            -- upvalues: l_Humanoid_0 (copy)
                            l_Humanoid_0.PlatformStand = false;
                            l_Humanoid_0:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false);
                            l_Humanoid_0:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
                            l_Humanoid_0:ChangeState(Enum.HumanoidStateType.GettingUp);
                        end);
                        v54.Parent = workspace.Map.Ingame;
                        for _, v59 in {
                            "Left Arm", 
                            "Right Arm", 
                            "Torso", 
                            "Left Leg", 
                            "Right Leg"
                        } do
                            local l_SelectionBox_0 = Instance.new("SelectionBox");
                            l_SelectionBox_0.Adornee = v54[v59];
                            l_SelectionBox_0.Parent = v54[v59];
                            l_SelectionBox_0.Color3 = Color3.new(0, 0, 0);
                            l_SelectionBox_0.LineThickness = 0.07;
                            table.insert(v45, l_SelectionBox_0);
                        end;
                        local v61 = false;
                        do
                            local l_v61_0 = v61;
                            local _ = function(v63) --[[ Line: 427 ]] --[[ Name: removeRigAfter ]]
                                -- upvalues: l_v61_0 (ref), v54 (copy)
                                task.delay(v63 - 1, function() --[[ Line: 428 ]]
                                    -- upvalues: l_v61_0 (ref), v54 (ref)
                                    if not l_v61_0 then
                                        l_v61_0 = true;
                                        game.Debris:AddItem(v54, 1);
                                        for _, v65 in pairs(v54:GetDescendants()) do
                                            if v65:IsA("BasePart") or v65:IsA("Decal") then
                                                game.TweenService:Create(v65, TweenInfo.new(1), {
                                                    Transparency = 1
                                                }):Play();
                                            end;
                                        end;
                                    end;
                                end);
                            end;
                            local l_PizzaDeliveryGuyLifetime_0 = v44.Config.PizzaDeliveryGuyLifetime;
                            task.delay(l_PizzaDeliveryGuyLifetime_0 - 1, function() --[[ Line: 428 ]]
                                -- upvalues: l_v61_0 (ref), v54 (copy)
                                if not l_v61_0 then
                                    l_v61_0 = true;
                                    game.Debris:AddItem(v54, 1);
                                    for _, v69 in pairs(v54:GetDescendants()) do
                                        if v69:IsA("BasePart") or v69:IsA("Decal") then
                                            game.TweenService:Create(v69, TweenInfo.new(1), {
                                                Transparency = 1
                                            }):Play();
                                        end;
                                    end;
                                end;
                            end);
                            game.Debris:AddItem(v54, v44.Config.PizzaDeliveryGuyLifetime);
                            l_PizzaDeliveryGuyLifetime_0 = {};
                            for v70, v71 in pairs(v44.Config.PizzaDeliveryAnimations) do
                                l_PizzaDeliveryGuyLifetime_0[v70] = v5:LoadAnimationFromID(v54, v71, true);
                            end;
                            l_PizzaDeliveryGuyLifetime_0.Idle:Play(0);
                            v54:SetPrimaryPartCFrame(v44.Rig.PrimaryPart.CFrame * CFrame.new(v53 % 2 == 0 and 6 or -6, 0, 0));
                            task.wait(0.75);
                            task.delay(1.75, function() --[[ Line: 458 ]]
                                -- upvalues: v54 (copy), l_PizzaDeliveryGuyLifetime_0 (copy), v5 (ref), v44 (ref), l_v61_0 (ref), v4 (ref), v7 (ref), l_Humanoid_0 (copy)
                                if not v54.PrimaryPart then
                                    return;
                                else
                                    v54.PrimaryPart.Anchored = false;
                                    l_PizzaDeliveryGuyLifetime_0.Walk:Play();
                                    local v72 = require(game.ReplicatedStorage.Modules.SimplePath).new(v54);
                                    while task.wait() and v54.Parent and v54.PrimaryPart do
                                        local l_v5_ClosestPlayerFromPosition_0, v74 = v5:GetClosestPlayerFromPosition(v54.PrimaryPart.Position);
                                        local v75 = l_v5_ClosestPlayerFromPosition_0 and l_v5_ClosestPlayerFromPosition_0.PrimaryPart and l_v5_ClosestPlayerFromPosition_0.PrimaryPart.Position;
                                        if v44.Rig.Parent and v74 and v74 < v44.Config.PizzaDeliveryGuyAttackRadius then
                                            task.delay(1, function() --[[ Line: 428 ]]
                                                -- upvalues: l_v61_0 (ref), v54 (ref)
                                                if not l_v61_0 then
                                                    l_v61_0 = true;
                                                    game.Debris:AddItem(v54, 1);
                                                    for _, v77 in pairs(v54:GetDescendants()) do
                                                        if v77:IsA("BasePart") or v77:IsA("Decal") then
                                                            game.TweenService:Create(v77, TweenInfo.new(1), {
                                                                Transparency = 1
                                                            }):Play();
                                                        end;
                                                    end;
                                                end;
                                            end);
                                            l_PizzaDeliveryGuyLifetime_0.Walk:Stop(0);
                                            l_PizzaDeliveryGuyLifetime_0.Hit:Play(0);
                                            v4:Play(v44.Config.Sounds.WalkspeedOverrideHit, {
                                                Parent = v54.PrimaryPart
                                            });
                                            v5:ApplyDamage(l_v5_ClosestPlayerFromPosition_0, v44.Config.PizzaDeliveryGuyDamage);
                                            v5:RevealPlayerAuraTo(v44.Player, l_v5_ClosestPlayerFromPosition_0, 7.5);
                                            v7:ApplyStatus(l_v5_ClosestPlayerFromPosition_0, "Burning", {
                                                Level = 1, 
                                                Duration = 3
                                            });
                                            v7:ApplyStatus(l_v5_ClosestPlayerFromPosition_0, "Slowness", {
                                                Level = 2, 
                                                Duration = 3
                                            });
                                            if tostring(l_v5_ClosestPlayerFromPosition_0.Parent) == "Survivors" then
                                                require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v44.Player, {
                                                    Action = "A pizza delivery minion attacked a Survivor", 
                                                    RewardType = "EasyKillerAction"
                                                });
                                            end;
                                            task.spawn(function() --[[ Line: 490 ]]
                                                -- upvalues: l_v5_ClosestPlayerFromPosition_0 (copy)
                                                for _ = 1, math.random(3, 6) do
                                                    local v79 = script.Blood:Clone();
                                                    v79.CFrame = l_v5_ClosestPlayerFromPosition_0.PrimaryPart.CFrame * CFrame.new(math.random(-3, 3), math.random(-3, 3), math.random(-3, 3));
                                                    v79.Parent = workspace;
                                                    game.Debris:AddItem(v79, 10);
                                                    task.wait(math.random(0.25, 0.75));
                                                end;
                                            end);
                                            break;
                                        elseif v44.Rig.Parent and v75 then
                                            v72:Run(v75);
                                        else
                                            task.delay(1, function() --[[ Line: 428 ]]
                                                -- upvalues: l_v61_0 (ref), v54 (ref)
                                                if not l_v61_0 then
                                                    l_v61_0 = true;
                                                    game.Debris:AddItem(v54, 1);
                                                    for _, v81 in pairs(v54:GetDescendants()) do
                                                        if v81:IsA("BasePart") or v81:IsA("Decal") then
                                                            game.TweenService:Create(v81, TweenInfo.new(1), {
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
                                    if v72 then
                                        v72:Destroy();
                                    end;
                                    return;
                                end;
                            end);
                        end;
                    end;
                end);
                task.delay(3, function() --[[ Line: 526 ]]
                    -- upvalues: v44 (copy), v46 (ref), v45 (copy)
                    v44.AbilitiesDisabled = false;
                    v46 = true;
                    for _, v83 in pairs(v45) do
                        v83:Destroy();
                    end;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v44.Animations.SummonPizzaDelivery:Play(0.025);
                    local l_v5_SpeedMultiplier_2 = v5:CreateSpeedMultiplier(v44.Player, 0, "HinderedMovement");
                    task.delay(2.5, function() --[[ Line: 541 ]]
                        -- upvalues: l_v5_SpeedMultiplier_2 (copy)
                        game.TweenService:Create(l_v5_SpeedMultiplier_2, TweenInfo.new(0.5), {
                            Value = 1
                        }):Play();
                        game.Debris:AddItem(l_v5_SpeedMultiplier_2, 0.5);
                    end);
                end;
                return;
            end;
        end
    }
};
v3.OnIntroduction = function(_, v86, _, v88) --[[ Line: 551 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: l_TweenService_0 (copy), v4 (copy)
    (function(v89) --[[ Line: 554 ]] --[[ Name: IntroUI ]]
        -- upvalues: v88 (copy), l_TweenService_0 (ref), v4 (ref), v86 (copy)
        local v90 = false;
        task.delay(v88, function() --[[ Line: 557 ]]
            -- upvalues: v90 (ref)
            v90 = true;
        end);
        local l_ScreenGui_0 = Instance.new("ScreenGui");
        l_ScreenGui_0.DisplayOrder = 999;
        l_ScreenGui_0.IgnoreGuiInset = true;
        l_ScreenGui_0.Name = "MafiasoIntro";
        l_ScreenGui_0.Parent = v89;
        local l_TextLabel_0 = Instance.new("TextLabel");
        l_TextLabel_0.Size = UDim2.fromScale(1, 1);
        l_TextLabel_0.Position = UDim2.fromScale(0.5, 0.5);
        l_TextLabel_0.BackgroundColor3 = Color3.new(0, 0, 0);
        l_TextLabel_0.TextColor3 = Color3.new(1, 1, 1);
        l_TextLabel_0.BackgroundTransparency = 1;
        l_TextLabel_0.TextTransparency = 1;
        l_TextLabel_0.AnchorPoint = Vector2.new(0.5, 0.5);
        l_TextLabel_0.TextSize = 36;
        l_TextLabel_0.Font = Enum.Font.Legacy;
        l_TextLabel_0.Text = "Sleeping";
        l_TextLabel_0.TextXAlignment = Enum.TextXAlignment.Center;
        l_TextLabel_0.TextYAlignment = Enum.TextYAlignment.Center;
        l_TextLabel_0.Parent = l_ScreenGui_0;
        l_TweenService_0:Create(l_TextLabel_0, TweenInfo.new(0.35), {
            BackgroundTransparency = 0, 
            TextTransparency = 0
        }):Play();
        task.delay(0.7, function() --[[ Line: 587 ]]
            -- upvalues: v4 (ref), v86 (ref)
            v4:Play(v86.Config.Sounds.IntroductionSound);
        end);
        task.spawn(function() --[[ Line: 591 ]]
            -- upvalues: l_TextLabel_0 (copy), v90 (ref), l_TweenService_0 (ref), l_ScreenGui_0 (copy)
            local v93 = 4;
            repeat
                if v93 <= 0 then
                    v93 = 4;
                end;
                l_TextLabel_0.Text = ("Sleeping..."):sub(1, 12 - v93);
                task.wait(0.5);
                v93 = v93 - 1;
            until v90;
            local v94 = l_TweenService_0:Create(l_TextLabel_0, TweenInfo.new(1), {
                BackgroundTransparency = 1, 
                TextTransparency = 1
            });
            v94:Play();
            v94.Completed:Once(function() --[[ Line: 609 ]]
                -- upvalues: l_ScreenGui_0 (ref)
                l_ScreenGui_0:Destroy();
            end);
        end);
    end)(game.Players.LocalPlayer.PlayerGui);
end;
v3.OnExecution = function(_, v96, v97) --[[ Line: 618 ]] --[[ Name: OnExecution ]]
    local v98 = (v96.Rig.PrimaryPart.CFrame * CFrame.new(5, 0.5, 1)).LookVector.Unit * 200;
    local v99 = workspace:GetServerTimeNow() + 3.5;
    require(game.ReplicatedStorage.Modules.Network):FireAllClientConnection("Ragdoll", "REMOTE_EVENT", v97, v99, (("%*|%*|%*"):format(v98.X, v98.Y, v98.Z)));
    task.delay(2.1, function() --[[ Line: 628 ]]
        -- upvalues: v97 (copy)
        local l_Humanoid_1 = v97:FindFirstChild("Humanoid");
        if l_Humanoid_1 then
            l_Humanoid_1.BreakJointsOnDeath = false;
            l_Humanoid_1.Health = 0;
        end;
    end);
end;
return v3;