-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("Players");
local _ = game:GetService("TweenService");
local _ = game:GetService("ReplicatedStorage").Assets;
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
                                    local l_Head_0 = v9:FindFirstChild("Head");
                                    if l_Head_0 then
                                        local l_FaceFrontAttachment_0 = l_Head_0:FindFirstChild("FaceFrontAttachment");
                                        if l_FaceFrontAttachment_0 then
                                            local v12 = v8.Config.BlackOut:Clone();
                                            if v12 and v12:IsA("ParticleEmitter") then
                                                v12.Parent = l_FaceFrontAttachment_0;
                                            end;
                                        end;
                                    end;
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
                task.delay(0.75, function() --[[ Line: 61 ]]
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
    WalkspeedOverride = {
        LayoutOrder = 3, 
        Icon = "rbxassetid://101955457812737", 
        KeybindType = "AltAbility2", 
        Cooldown = 20, 
        Callback = function(v14) --[[ Line: 78 ]] --[[ Name: Callback ]]
            -- upvalues: v5 (copy), v4 (copy), v6 (copy), v7 (copy)
            local l_WalkspeedOverrideTimeout_0 = v14.Config.WalkspeedOverrideTimeout;
            if game["Run Service"]:IsServer() then
                local v16 = "IDK";
                v14.AbilitiesDisabled = true;
                v14.Rig.firebrand.Transparency = 0;
                v14.Rig.firebrand.Trail.Enabled = true;
                v5:SetSpeedCap(v14.Rig, "C00lkiddWalkspeedOverride", v14.Config.WalkspeedOverrideSpeed);
                task.spawn(function() --[[ Line: 90 ]]
                    -- upvalues: v4 (ref), v14 (copy), v16 (ref)
                    v4:Play(v14.Config.Sounds.SwordUnsheath, {
                        Parent = v14.Rig.firebrand
                    });
                    repeat
                        v4:Play("netSpin", {
                            Parent = v14.Rig:FindFirstChild("firebrand")
                        });
                        task.wait(0.5);
                    until v16 ~= "IDK" or not v14.Rig.PrimaryPart;
                end);
                task.delay(0.125, function() --[[ Line: 101 ]]
                    -- upvalues: v6 (ref), v14 (copy), l_WalkspeedOverrideTimeout_0 (copy), v7 (ref), v5 (ref), v4 (ref), v16 (ref)
                    local v17 = nil;
                    local v18 = nil;
                    local l_v6_Hitbox_1 = v6:CreateHitbox(v14.Player, {
                        Size = Vector3.new(7, 5, 6, 0), 
                        Damage = v14.Config.WalkspeedOverrideDamage, 
                        Time = l_WalkspeedOverrideTimeout_0, 
                        Knockback = 4.5, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v19) --[[ Line: 113 ]] --[[ Name: Hit ]]
                                -- upvalues: v14 (ref), v17 (ref), v7 (ref)
                                if v19.Humanoid.Health <= 0 then
                                    local l_Head_1 = v19:FindFirstChild("Head");
                                    if l_Head_1 then
                                        local l_FaceFrontAttachment_1 = l_Head_1:FindFirstChild("FaceFrontAttachment");
                                        if l_FaceFrontAttachment_1 then
                                            local v22 = v14.Config.BlackOut:Clone();
                                            if v22 and v22:IsA("ParticleEmitter") then
                                                v22.Parent = l_FaceFrontAttachment_1;
                                            end;
                                        end;
                                    end;
                                end;
                                v17 = v19;
                                v7:ApplyStatus(v19, "Burning", {
                                    Level = 1, 
                                    Duration = 8
                                });
                                task.spawn(function() --[[ Line: 131 ]]
                                    -- upvalues: v19 (copy)
                                    for _ = 1, math.random(3, 6) do
                                        local v24 = script.Blood:Clone();
                                        v24.CFrame = v19.PrimaryPart.CFrame * CFrame.new(math.random(-3, 3), math.random(-3, 3), math.random(-3, 3));
                                        v24.Parent = workspace;
                                        game.Debris:AddItem(v24, 10);
                                        task.wait(math.random(0.25, 0.75));
                                    end;
                                end);
                                if tostring(v19.Parent) == "Survivors" then
                                    local v25 = require(game.ReplicatedStorage.Modules.Actors);
                                    if v19.Humanoid.Health <= 0 then
                                        v25:IncrementActorStats(v14.Player, {
                                            Action = "Killed a Survivor with Walkspeed Override", 
                                            RewardType = "DifficultKillerAction"
                                        });
                                        return;
                                    else
                                        v25:IncrementActorStats(v14.Player, {
                                            Action = "Landed Walkspeed Override hit", 
                                            RewardType = "RegularKillerAction"
                                        });
                                    end;
                                end;
                            end, 
                            Ended = function() --[[ Line: 161 ]] --[[ Name: Ended ]]
                                -- upvalues: v18 (ref)
                                v18 = true;
                            end
                        }
                    });
					local v27 = v5:ApplyVelocity(v14.Rig.PrimaryPart, v14.Config.WalkspeedOverrideSpeed);
					v27.Attachment0 = v14.Rig:FindFirstChild('Torso').BodyFrontAttachment
                    game.Debris:AddItem(v27, l_WalkspeedOverrideTimeout_0 + 3);
                    game.TweenService:Create(v27, TweenInfo.new(l_WalkspeedOverrideTimeout_0 * 1.5), {
                        LineVelocity = v14.Config.WalkspeedOverrideSpeed / 2
                    }):Play();
                    v4:Play(v14.Config.Sounds.WalkspeedOverrideLunge, {
                        Parent = v14.Rig.PrimaryPart
                    });
                    local v28 = false;
                    local v29 = ("%*C00lkiddCollision"):format(v14.Player.Name);
                    local v30 = require(game.ReplicatedStorage.Modules.Network);
                    v30:SetConnection(v29, "REMOTE_EVENT", function(v31) --[[ Line: 179 ]]
                        if v31 == v14.Player then
                            v28 = true;
                        end;
                    end);
                    repeat
                        task.wait();
                    until v17 or v18 or v28;
                    v14.Rig.firebrand.Trail.Enabled = false;
                    task.delay(1.5, function() --[[ Line: 189 ]]
                        -- upvalues: v14 (ref)
                        game.TweenService:Create(v14.Rig.firebrand, TweenInfo.new(0.5), {
                            Transparency = 1
                        }):Play();
                    end);
                    if v17 then
                        v16 = "Hit";
                        v14.Rig:SetAttribute("Invincible", true);
                    elseif v28 then
                        v16 = "Collide";
                    elseif v18 then
                        v16 = "Timeout";
                    end;
                    local l_StringValue_0 = Instance.new("StringValue");
                    l_StringValue_0.Name = "Result";
                    l_StringValue_0.Value = v16;
                    l_StringValue_0.Parent = v14.Rig;
                    game.Debris:AddItem(l_StringValue_0, 1.5);
                    task.delay(1.5, function() --[[ Line: 209 ]]
                        -- upvalues: v14 (ref)
                        v14.AbilitiesDisabled = false;
                        v14.Rig:SetAttribute("Invincible", nil);
                    end);
                    game.TweenService:Create(v27, TweenInfo.new(v16 == "Collide" and 0.25 or 0.5), {
                        LineVelocity = 0
                    }):Play();
                    game.Debris:AddItem(v27, 1.5);
                    v4:PlayVoiceline(v14, ("WalkspeedOverride%*"):format(v16), {
                        Priority = 1.5
                    });
                    v4:Play(v14.Config.Sounds[("WalkspeedOverride%*"):format(v16)], {
                        Parent = v14.Rig.PrimaryPart
                    });
                    v5:SetSpeedCap(v14.Rig, "C00lkiddWalkspeedOverride", nil);
                    v30:RemoveConnection(v29, "REMOTE_EVENT");
                    l_v6_Hitbox_1:Cancel();
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v14.Animations.WalkspeedOverrideStart:Play(0.025);
                    v14.Animations.WalkspeedOverrideLoop:Play(0.025);
                    v14.Rig:SetAttribute("FootstepsMuted", true);
                    local l_v5_SpeedMultiplier_0 = v5:CreateSpeedMultiplier(v14.Player, 0, "HinderedMovement");
                    local v34 = nil;
                    do
                        local l_v34_0 = v34;
                        task.spawn(function() --[[ Line: 235 ]]
                            -- upvalues: l_v34_0 (ref), v14 (copy)
                            local v36 = 0;
                            local v37 = false;
                            while true do
                                if not l_v34_0 and v14.Rig.PrimaryPart then
                                    if v36 >= 0.4 and v14.Rig.PrimaryPart.Velocity.Magnitude <= 18 then
                                        if not v37 then
                                            require(game.ReplicatedStorage.Modules.Network):FireServerConnection(("%*C00lkiddCollision"):format(v14.Player.Name), "REMOTE_EVENT");
                                            v37 = true;
                                        end;
                                        return;
                                    else
                                        v36 = v36 + task.wait();
                                    end;
                                else
                                    return;
                                end;
                            end;
                        end);
                        local v38 = v14.Rig:WaitForChild("Result", 6);
                        l_v34_0 = v38 and v38.Value or "IDK BRUH";
                        v14.Rig:SetAttribute("FootstepsMuted", nil);
                        v14.Animations.WalkspeedOverrideStart:Stop();
                        v14.Animations.WalkspeedOverrideLoop:Stop();
                        if l_v34_0 == "Hit" then
                            v14.Animations.WalkspeedOverrideHit:Play(0.025);
                        else
                            v14.Animations.WalkspeedOverrideMiss:Play(0.05);
                        end;
                        if v38 then
                            repeat
                                task.wait();
                            until not v38.Parent;
                        end;
                        game.TweenService:Create(l_v5_SpeedMultiplier_0, TweenInfo.new(0.5), {
                            Value = 1
                        }):Play();
                        game.Debris:AddItem(l_v5_SpeedMultiplier_0, 0.5);
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
        Callback = function(v39) --[[ Line: 281 ]] --[[ Name: Callback ]]
            -- upvalues: v4 (copy), v5 (copy), v7 (copy)
            if game["Run Service"]:IsServer() then
                v39.AbilitiesDisabled = true;
				v39.Rig.WalkieTalkie.Transparency = 0;
                task.delay(2.2, function() --[[ Line: 289 ]]
                    -- upvalues: v39 (copy)
					v39.Rig.WalkieTalkie.Transparency = 1;
                end);
                local v40 = {};
                local v41 = false;
                task.spawn(function() --[[ Line: 297 ]]
                    -- upvalues: v40 (copy), v41 (ref)
                    local v42 = 0;
                    repeat
                        v42 = (v42 + 1) % 360;
                        local v43 = Color3.fromHSV(v42 / 360, 1, 1);
                        for _, v45 in pairs(v40) do
                            v45.Color3 = v43;
                        end;
                        task.wait(0.01);
                    until v41 == true;
                end);
                local l_MafiasoSpawn_0 = v39.Config.Sounds.MafiasoSpawn;
                local v47 = l_MafiasoSpawn_0[math.random(1, #l_MafiasoSpawn_0)];
                v4:Play(v47, {
                    Parent = v39.Rig.PrimaryPart
                });
                task.delay(1, function() --[[ Line: 318 ]]
                    -- upvalues: v4 (ref), v39 (copy), v40 (copy), v5 (ref), v7 (ref)
                    for v48 = 1, 2 do
                        v4:Play(v39.Config.Sounds.PizzaDeliveryGuySpawned, {
                            Parent = v39.Rig.PrimaryPart
                        });
                        local v49 = v39.Config.Mafiasos[math.random(1, 4)]:Clone();
                        v49:SetAttribute("Team", "Killers");
                        v49.PrimaryPart.Anchored = true;
                        local l_Humanoid_0 = v49.Humanoid;
                        l_Humanoid_0.WalkSpeed = v39.Config.PizzaDeliveryGuySpeed;
                        l_Humanoid_0.MaxHealth = v39.Config.PizzaDeliveryGuyHealth;
                        l_Humanoid_0.Health = v39.Config.PizzaDeliveryGuyHealth;
                        l_Humanoid_0.StateChanged:Connect(function(_, _) --[[ Line: 332 ]]
                            -- upvalues: l_Humanoid_0 (copy)
                            l_Humanoid_0.PlatformStand = false;
                            l_Humanoid_0:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false);
                            l_Humanoid_0:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
                            l_Humanoid_0:ChangeState(Enum.HumanoidStateType.GettingUp);
                        end);
                        v49.Parent = workspace.Map.Ingame;
                        for _, v54 in {
                            "Left Arm", 
                            "Right Arm", 
                            "Torso", 
                            "Left Leg", 
                            "Right Leg"
                        } do
                            local l_SelectionBox_0 = Instance.new("SelectionBox");
                            l_SelectionBox_0.Adornee = v49[v54];
                            l_SelectionBox_0.Parent = v49[v54];
                            l_SelectionBox_0.Color3 = Color3.new(0, 0, 0);
                            l_SelectionBox_0.LineThickness = 0.07;
                            table.insert(v40, l_SelectionBox_0);
                        end;
                        local v56 = false;
                        do
                            local l_v56_0 = v56;
                            local _ = function(v58) --[[ Line: 356 ]] --[[ Name: removeRigAfter ]]
                                -- upvalues: l_v56_0 (ref), v49 (copy)
                                task.delay(v58 - 1, function() --[[ Line: 357 ]]
                                    -- upvalues: l_v56_0 (ref), v49 (ref)
                                    if not l_v56_0 then
                                        l_v56_0 = true;
                                        game.Debris:AddItem(v49, 1);
                                        for _, v60 in pairs(v49:GetDescendants()) do
                                            if v60:IsA("BasePart") or v60:IsA("Decal") then
                                                game.TweenService:Create(v60, TweenInfo.new(1), {
                                                    Transparency = 1
                                                }):Play();
                                            end;
                                        end;
                                    end;
                                end);
                            end;
                            local l_PizzaDeliveryGuyLifetime_0 = v39.Config.PizzaDeliveryGuyLifetime;
                            task.delay(l_PizzaDeliveryGuyLifetime_0 - 1, function() --[[ Line: 357 ]]
                                -- upvalues: l_v56_0 (ref), v49 (copy)
                                if not l_v56_0 then
                                    l_v56_0 = true;
                                    game.Debris:AddItem(v49, 1);
                                    for _, v64 in pairs(v49:GetDescendants()) do
                                        if v64:IsA("BasePart") or v64:IsA("Decal") then
                                            game.TweenService:Create(v64, TweenInfo.new(1), {
                                                Transparency = 1
                                            }):Play();
                                        end;
                                    end;
                                end;
                            end);
                            game.Debris:AddItem(v49, v39.Config.PizzaDeliveryGuyLifetime);
                            l_PizzaDeliveryGuyLifetime_0 = {};
                            for v65, v66 in pairs(v39.Config.PizzaDeliveryAnimations) do
                                l_PizzaDeliveryGuyLifetime_0[v65] = v5:LoadAnimationFromID(v49, v66, true);
                            end;
                            l_PizzaDeliveryGuyLifetime_0.Idle:Play(0);
                            l_PizzaDeliveryGuyLifetime_0.Summoned:Play(0);
                            v49:SetPrimaryPartCFrame(v39.Rig.PrimaryPart.CFrame * CFrame.new(v48 % 2 == 0 and 6 or -6, 0, 0));
                            task.wait(0.75);
                            task.delay(1.75, function() --[[ Line: 388 ]]
                                -- upvalues: v49 (copy), l_PizzaDeliveryGuyLifetime_0 (copy), v5 (ref), v39 (ref), l_v56_0 (ref), v4 (ref), v7 (ref), l_Humanoid_0 (copy)
                                if not v49.PrimaryPart then
                                    return;
                                else
                                    v49.PrimaryPart.Anchored = false;
                                    l_PizzaDeliveryGuyLifetime_0.Walk:Play();
                                    local v67 = require(game.ReplicatedStorage.Modules.SimplePath).new(v49);
                                    while task.wait() and v49.Parent and v49.PrimaryPart do
                                        local l_v5_ClosestPlayerFromPosition_0, v69 = v5:GetClosestPlayerFromPosition(v49.PrimaryPart.Position);
                                        local v70 = l_v5_ClosestPlayerFromPosition_0 and l_v5_ClosestPlayerFromPosition_0.PrimaryPart and l_v5_ClosestPlayerFromPosition_0.PrimaryPart.Position;
                                        if v39.Rig.Parent and v69 and v69 < v39.Config.PizzaDeliveryGuyAttackRadius then
                                            task.delay(1, function() --[[ Line: 357 ]]
                                                -- upvalues: l_v56_0 (ref), v49 (ref)
                                                if not l_v56_0 then
                                                    l_v56_0 = true;
                                                    game.Debris:AddItem(v49, 1);
                                                    for _, v72 in pairs(v49:GetDescendants()) do
                                                        if v72:IsA("BasePart") or v72:IsA("Decal") then
                                                            game.TweenService:Create(v72, TweenInfo.new(1), {
                                                                Transparency = 1
                                                            }):Play();
                                                        end;
                                                    end;
                                                end;
                                            end);
                                            l_PizzaDeliveryGuyLifetime_0.Walk:Stop(0);
                                            l_PizzaDeliveryGuyLifetime_0.Hit:Play(0);
                                            v4:Play(v39.Config.Sounds.WalkspeedOverrideHit, {
                                                Parent = v49.PrimaryPart
                                            });
                                            v5:ApplyDamage(l_v5_ClosestPlayerFromPosition_0, v39.Config.PizzaDeliveryGuyDamage);
                                            v5:RevealPlayerAuraTo(v39.Player, l_v5_ClosestPlayerFromPosition_0, 7.5);
                                            v7:ApplyStatus(l_v5_ClosestPlayerFromPosition_0, "Burning", {
                                                Level = 1, 
                                                Duration = 3
                                            });
                                            v7:ApplyStatus(l_v5_ClosestPlayerFromPosition_0, "Slowness", {
                                                Level = 2, 
                                                Duration = 3
                                            });
                                            if tostring(l_v5_ClosestPlayerFromPosition_0.Parent) == "Survivors" then
                                                require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v39.Player, {
                                                    Action = "A pizza delivery minion attacked a Survivor", 
                                                    RewardType = "EasyKillerAction"
                                                });
                                            end;
                                            task.spawn(function() --[[ Line: 420 ]]
                                                -- upvalues: l_v5_ClosestPlayerFromPosition_0 (copy)
                                                for _ = 1, math.random(3, 6) do
                                                    local v74 = script.Blood:Clone();
                                                    v74.CFrame = l_v5_ClosestPlayerFromPosition_0.PrimaryPart.CFrame * CFrame.new(math.random(-3, 3), math.random(-3, 3), math.random(-3, 3));
                                                    v74.Parent = workspace;
                                                    game.Debris:AddItem(v74, 10);
                                                    task.wait(math.random(0.25, 0.75));
                                                end;
                                            end);
                                            break;
                                        elseif v39.Rig.Parent and v70 then
                                            v67:Run(v70);
                                        else
                                            task.delay(1, function() --[[ Line: 357 ]]
                                                -- upvalues: l_v56_0 (ref), v49 (ref)
                                                if not l_v56_0 then
                                                    l_v56_0 = true;
                                                    game.Debris:AddItem(v49, 1);
                                                    for _, v76 in pairs(v49:GetDescendants()) do
                                                        if v76:IsA("BasePart") or v76:IsA("Decal") then
                                                            game.TweenService:Create(v76, TweenInfo.new(1), {
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
                                    if v67 then
                                        v67:Destroy();
                                    end;
                                    return;
                                end;
                            end);
                        end;
                    end;
                end);
                task.delay(3, function() --[[ Line: 456 ]]
                    -- upvalues: v39 (copy), v41 (ref), v40 (copy)
                    v39.AbilitiesDisabled = false;
                    v41 = true;
                    for _, v78 in pairs(v40) do
                        v78:Destroy();
                    end;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v39.Animations.SummonPizzaDelivery:Play(0.025);
                    local l_v5_SpeedMultiplier_1 = v5:CreateSpeedMultiplier(v39.Player, 0, "HinderedMovement");
                    task.delay(2.5, function() --[[ Line: 471 ]]
                        -- upvalues: l_v5_SpeedMultiplier_1 (copy)
                        game.TweenService:Create(l_v5_SpeedMultiplier_1, TweenInfo.new(0.5), {
                            Value = 1
                        }):Play();
                        game.Debris:AddItem(l_v5_SpeedMultiplier_1, 0.5);
                    end);
                end;
                return;
            end;
        end
    }
};
v3.OnExecution = function(_, v81, v82) --[[ Line: 483 ]] --[[ Name: OnExecution ]]
    local v83 = workspace:GetServerTimeNow() + 1.833;
    local v84 = v81.Rig.PrimaryPart.CFrame.LookVector.Unit * 200;
    require(game.ReplicatedStorage.Modules.Network):FireAllClientConnection("Ragdoll", "REMOTE_EVENT", v82, v83, (("%*|%*|%*"):format(v84.X, v84.Y, v84.Z)));
    task.delay(1.833, function() --[[ Line: 493 ]]
        -- upvalues: v82 (copy)
        local l_Humanoid_1 = v82:FindFirstChild("Humanoid");
        local l_Head_2 = v82:FindFirstChild("Head");
        if l_Humanoid_1 then
            l_Humanoid_1.BreakJointsOnDeath = false;
            l_Humanoid_1.Health = 0;
        end;
        task.spawn(function() --[[ Line: 501 ]]
            -- upvalues: l_Head_2 (copy)
            for _ = 1, math.random(3, 6) do
                local v88 = script.Blood:Clone();
                v88.CFrame = l_Head_2.CFrame * CFrame.new(math.random(-3, 3), math.random(2, 6), math.random(-3, 3));
                v88.Parent = workspace;
                game.Debris:AddItem(v88, 10);
                task.wait(math.random(0.25, 0.75));
            end;
        end);
    end);
end;
return v3;