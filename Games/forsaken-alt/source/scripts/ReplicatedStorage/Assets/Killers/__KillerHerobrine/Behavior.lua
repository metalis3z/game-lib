-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
v0.Abilities = {
    SeeYou = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "MainAbility", 
        Cooldown = 2, 
        Callback = function(v5) --[[ Line: 15 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v5.AbilitiesDisabled = true;
                task.delay(0.25, function() --[[ Line: 19 ]]
                    -- upvalues: v1 (ref), v5 (copy)
                    v1:Play(v5.Config.Sounds.Swing, {
                        Parent = v5.Rig.PrimaryPart, 
                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                        Volume = 0.25
                    });
                end);
                task.delay(0.33, function() --[[ Line: 24 ]]
                    -- upvalues: v3 (ref), v5 (copy), v2 (ref), v1 (ref)
                    local _ = v3:CreateHitbox(v5.Player, {
                        Size = Vector3.new(4, 6, 7, 0), 
                        CFrameOffset = CFrame.new(0, 0, -4.25), 
                        Damage = v5.Config.FoundYouDMG, 
                        Time = 0.2, 
                        Knockback = 2, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v6, v7) --[[ Line: 35 ]] --[[ Name: Hit ]]
                                -- upvalues: v2 (ref), v1 (ref), v5 (ref)
                                v2:CreateSpeedMultiplier(v6, 1.5, "HitSpeedBonus", 1.25);
                                if v7 then
                                    v1:Play(v5.Config.Sounds.Hit, {
                                        Parent = v5.Rig.PrimaryPart, 
                                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                        Volume = 0.25
                                    });
                                end;
                            end
                        }
                    });
                end);
                task.delay(0.75, function() --[[ Line: 46 ]]
                    -- upvalues: v5 (copy)
                    v5.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v5.Animations.FoundYou:Play(0.175);
                end;
                return;
            end;
        end
    }, 
    Flick = {
        LayoutOrder = 2, 
        Icon = "rbxassetid://18918122726", 
        KeybindType = "AltAbility1", 
        Cooldown = 0.15, 
        Callback = function(v9) --[[ Line: 63 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy)
            if game["Run Service"]:IsServer() then
                local l_PrimaryPart_0 = v9.Rig.PrimaryPart;
                if l_PrimaryPart_0 then
                    local l_Unit_0 = l_PrimaryPart_0.CFrame.LookVector.Unit;
                    local v12 = l_PrimaryPart_0.Position + l_Unit_0 * v9.Config.Flick;
                    l_PrimaryPart_0.CFrame = CFrame.new(v12, v12 + l_Unit_0);
                    v1:Play(v9.Config.Sounds.Flick, {
                        Parent = v9.Rig.PrimaryPart, 
                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                        Volume = 0.25
                    });
                    v9.Rig.Torso.Smoke.Enabled = true;
                    task.delay(0.2, function() --[[ Line: 82 ]]
                        -- upvalues: v9 (copy)
                        v9.Rig.Torso.Smoke.Enabled = false;
                    end);
                end;
            end;
        end
    }, 
    Stop = {
        LayoutOrder = 3, 
        Icon = "rbxassetid://18918122726", 
        KeybindType = "AltAbility2", 
        Cooldown = 5, 
        Callback = function(v13) --[[ Line: 95 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v1 (copy), v3 (copy), v4 (copy)
            if game["Run Service"]:IsServer() then
                v13.AbilitiesDisabled = true;
                local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v13.Player, 0.25, "HinderedMovement");
                game.TweenService:Create(l_v2_SpeedMultiplier_0, TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                    Value = 1
                }):Play();
                game.Debris:AddItem(l_v2_SpeedMultiplier_0, 1.5);
                task.delay(0.8, function() --[[ Line: 105 ]]
                    -- upvalues: v2 (ref), v13 (copy), v1 (ref), v3 (ref), v4 (ref)
                    local l_v2_PlayerMousePosition_0 = v2:GetPlayerMousePosition(v13.Player);
                    local v16 = CFrame.lookAt(v13.Rig.PrimaryPart.Position, l_v2_PlayerMousePosition_0) * CFrame.new(0, 0, -v13.Config.StopSpeed * 10);
                    local v17 = script.cobble:Clone();
                    v17.CFrame = CFrame.lookAt(v13.Rig.PrimaryPart.Position, l_v2_PlayerMousePosition_0);
                    v17.Parent = workspace.Map.Ingame;
                    game.Debris:AddItem(v17, 10);
                    game.TweenService:Create(v17, TweenInfo.new(10, Enum.EasingStyle.Linear), {
                        Position = v16.Position
                    }):Play();
                    v1:Play(v13.Config.Sounds.Stop, {
                        Parent = v13.Rig.PrimaryPart, 
                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                        Volume = 0.25
                    });
                    v3:CreateHitbox(v13.Player, {
                        Size = Vector3.new(3, 3, 3, 0), 
                        CFrame = function() --[[ Line: 118 ]] --[[ Name: CFrame ]]
                            -- upvalues: v17 (copy)
                            return v17.CFrame;
                        end, 
                        Damage = v13.Config.StopDMG, 
                        Time = 10, 
                        Knockback = 0.5, 
                        HitMultiple = true, 
                        ExecuteOnKill = false, 
                        PredictVelocity = false, 
                        Connections = {
                            Hit = function(v18) --[[ Line: 128 ]] --[[ Name: Hit ]]
                                -- upvalues: v2 (ref), v13 (ref), v4 (ref), v1 (ref)
                                v2:RevealPlayerAuraTo(v13.Player, v18, 10);
                                v4:ApplyStatus(v18, "Slowness", {
                                    Stackable = true, 
                                    Level = 1, 
                                    Duration = 10
                                });
                                v1:Play(v13.Config.Sounds.Hit, {
                                    Parent = v13.Rig.PrimaryPart, 
                                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                    Volume = 0.25
                                });
                            end
                        }
                    });
                end);
                task.delay(2, function() --[[ Line: 139 ]]
                    -- upvalues: v13 (copy)
                    v13.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v13.Animations.Stop:Play(0.025);
                end;
                return;
            end;
        end
    }, 
    summon = {
        LayoutOrder = 4, 
        Icon = "rbxassetid://105652328381208", 
        KeybindType = "AltAbility3", 
        Cooldown = 30, 
        Callback = function(v19) --[[ Line: 156 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v1 (copy), v4 (copy)
            if game["Run Service"]:IsServer() then
                v19.AbilitiesDisabled = true;
                task.delay(0.25, function() --[[ Line: 162 ]]
                    -- upvalues: v19 (copy), v2 (ref), v1 (ref), v4 (ref)
                    for v20 = 1, 2 do
                        local v21 = v19.Config.SteveRig:Clone();
                        v21:SetAttribute("Team", "Killers");
                        v21.PrimaryPart.Anchored = true;
                        local l_Humanoid_0 = v21.Humanoid;
                        l_Humanoid_0.WalkSpeed = v19.Config.PizzaDeliveryGuySpeed;
                        l_Humanoid_0.MaxHealth = v19.Config.PizzaDeliveryGuyHealth;
                        l_Humanoid_0.Health = v19.Config.PizzaDeliveryGuyHealth;
                        l_Humanoid_0.StateChanged:Connect(function(_, _) --[[ Line: 174 ]]
                            -- upvalues: l_Humanoid_0 (copy)
                            l_Humanoid_0.PlatformStand = false;
                            l_Humanoid_0:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false);
                            l_Humanoid_0:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
                            l_Humanoid_0:ChangeState(Enum.HumanoidStateType.GettingUp);
                        end);
                        v21.Parent = workspace.Map.Ingame;
                        local v25 = false;
                        do
                            local l_v25_0 = v25;
                            local _ = function(v27) --[[ Line: 185 ]] --[[ Name: removeRigAfter ]]
                                -- upvalues: l_v25_0 (ref), v21 (copy)
                                task.delay(v27 - 1, function() --[[ Line: 186 ]]
                                    -- upvalues: l_v25_0 (ref), v21 (ref)
                                    if not l_v25_0 then
                                        l_v25_0 = true;
                                        game.Debris:AddItem(v21, 1);
                                        for _, v29 in pairs(v21:GetDescendants()) do
                                            if v29:IsA("BasePart") or v29:IsA("Decal") then
                                                game.TweenService:Create(v29, TweenInfo.new(1), {
                                                    Transparency = 1
                                                }):Play();
                                            end;
                                        end;
                                    end;
                                end);
                            end;
                            local l_PizzaDeliveryGuyLifetime_0 = v19.Config.PizzaDeliveryGuyLifetime;
                            task.delay(l_PizzaDeliveryGuyLifetime_0 - 1, function() --[[ Line: 186 ]]
                                -- upvalues: l_v25_0 (ref), v21 (copy)
                                if not l_v25_0 then
                                    l_v25_0 = true;
                                    game.Debris:AddItem(v21, 1);
                                    for _, v33 in pairs(v21:GetDescendants()) do
                                        if v33:IsA("BasePart") or v33:IsA("Decal") then
                                            game.TweenService:Create(v33, TweenInfo.new(1), {
                                                Transparency = 1
                                            }):Play();
                                        end;
                                    end;
                                end;
                            end);
                            game.Debris:AddItem(v21, v19.Config.PizzaDeliveryGuyLifetime);
                            l_PizzaDeliveryGuyLifetime_0 = {};
                            for v34, v35 in pairs(v19.Config.PizzaDeliveryAnimations) do
                                l_PizzaDeliveryGuyLifetime_0[v34] = v2:LoadAnimationFromID(v21, v35, true);
                            end;
                            l_PizzaDeliveryGuyLifetime_0.Idle:Play();
                            v21:SetPrimaryPartCFrame(v19.Rig.PrimaryPart.CFrame * CFrame.new(v20 % 2 == 0 and 16 or -16, 0, 0));
                            v1:Play(v19.Config.Sounds.Flick, {
                                Parent = v19.Rig.PrimaryPart, 
                                PlaybackSpeed = Random.new():NextNumber(0.975, 1.025)
                            });
                            task.wait(0.2);
                            task.delay(0.15, function() --[[ Line: 218 ]]
                                -- upvalues: v21 (copy), l_PizzaDeliveryGuyLifetime_0 (copy), v2 (ref), v19 (ref), l_v25_0 (ref), v4 (ref), l_Humanoid_0 (copy)
                                if not v21.PrimaryPart then
                                    return;
                                else
                                    v21.PrimaryPart.Anchored = false;
                                    l_PizzaDeliveryGuyLifetime_0.Walk:Play();
                                    local v36 = require(game.ReplicatedStorage.Modules.SimplePath).new(v21);
                                    while task.wait() and v21.Parent and v21.PrimaryPart do
                                        local l_v2_ClosestPlayerFromPosition_0, v38 = v2:GetClosestPlayerFromPosition(v21.PrimaryPart.Position);
                                        local v39 = l_v2_ClosestPlayerFromPosition_0 and l_v2_ClosestPlayerFromPosition_0.PrimaryPart and l_v2_ClosestPlayerFromPosition_0.PrimaryPart.Position;
                                        if v19.Rig.Parent and v38 and v38 < v19.Config.PizzaDeliveryGuyAttackRadius then
                                            task.delay(1, function() --[[ Line: 186 ]]
                                                -- upvalues: l_v25_0 (ref), v21 (ref)
                                                if not l_v25_0 then
                                                    l_v25_0 = true;
                                                    game.Debris:AddItem(v21, 1);
                                                    for _, v41 in pairs(v21:GetDescendants()) do
                                                        if v41:IsA("BasePart") or v41:IsA("Decal") then
                                                            game.TweenService:Create(v41, TweenInfo.new(1), {
                                                                Transparency = 1
                                                            }):Play();
                                                        end;
                                                    end;
                                                end;
                                            end);
                                            l_PizzaDeliveryGuyLifetime_0.Walk:Stop(0);
                                            l_PizzaDeliveryGuyLifetime_0.Hit:Play(0);
                                            v2:ApplyDamage(l_v2_ClosestPlayerFromPosition_0, v19.Config.PizzaDeliveryGuyDamage);
                                            v2:RevealPlayerAuraTo(v19.Player, l_v2_ClosestPlayerFromPosition_0, 7.5);
                                            v4:ApplyStatus(l_v2_ClosestPlayerFromPosition_0, "Slowness", {
                                                Level = 2, 
                                                Duration = 3
                                            });
                                            break;
                                        elseif v19.Rig.Parent and v39 then
                                            v36:Run(v39);
                                        else
                                            task.delay(1, function() --[[ Line: 186 ]]
                                                -- upvalues: l_v25_0 (ref), v21 (ref)
                                                if not l_v25_0 then
                                                    l_v25_0 = true;
                                                    game.Debris:AddItem(v21, 1);
                                                    for _, v43 in pairs(v21:GetDescendants()) do
                                                        if v43:IsA("BasePart") or v43:IsA("Decal") then
                                                            game.TweenService:Create(v43, TweenInfo.new(1), {
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
                                    v36:Destroy();
                                    return;
                                end;
                            end);
                        end;
                    end;
                end);
                task.delay(2, function() --[[ Line: 254 ]]
                    -- upvalues: v19 (copy)
                    v19.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    local l_v2_SpeedMultiplier_1 = v2:CreateSpeedMultiplier(v19.Player, 0, "HinderedMovement");
                    task.delay(1, function() --[[ Line: 264 ]]
                        -- upvalues: l_v2_SpeedMultiplier_1 (copy)
                        game.TweenService:Create(l_v2_SpeedMultiplier_1, TweenInfo.new(0.5), {
                            Value = 1
                        }):Play();
                        game.Debris:AddItem(l_v2_SpeedMultiplier_1, 0.5);
                    end);
                end;
                return;
            end;
        end
    }
};
return v0;