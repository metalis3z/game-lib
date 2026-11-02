-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
local v5 = require(game.ReplicatedStorage.Modules.Network);
local function v13(v6, v7) --[[ Line: 10 ]] --[[ Name: toggleSwords ]]
    if v6 and v6.Parent and v6:FindFirstChild("ExtraModels") then
        for v8, v9 in pairs({
            v6.ExtraModels.HaxxedSwordLeft, 
            v6.ExtraModels.HaxxedSwordRight
        }) do
            local v10 = v8 == 1 and "L" or "R";
            v9.Parts[("HaxxedBlade%*2"):format(v10)].Transparency = v7 and 0 or 1;
            for _, v12 in pairs(v9.Parts[("HaxxedBlade%*"):format(v10)]:GetChildren()) do
                if v12:IsA("Beam") or v12:IsA("ParticleEmitter") then
                    v12.Enabled = v7;
                end;
            end;
        end;
    end;
end;
local function v17(v14, v15) --[[ Line: 24 ]] --[[ Name: zombieCheck ]]
    -- upvalues: v4 (copy)
    if v15.Name == "1x1x1x1Zombie" then
        local _ = v4:PlayerHasStatus(v14.Player, "Speed");
        v4:ApplyStatus(v14.Rig, "Speed", {
            Stackable = true, 
            MaxLevel = 3, 
            Level = v14.Config.ZombieKillSpeedLevel, 
            Duration = v14.Config.ZombieKillSpeedDuration
        });
        return true;
    else
        return;
    end;
end;
v0.Abilities = {
    Slash = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://120590195585579", 
        KeybindType = "MainAbility", 
        Callback = function(v18) --[[ Line: 39 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v17 (copy), v2 (copy), v4 (copy)
            if game["Run Service"]:IsServer() then
                v18.AbilitiesDisabled = true;
                v1:Play(v18.Config.Sounds.Swing, {
                    Parent = v18.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.25
                });
                task.delay(0.4, function() --[[ Line: 46 ]]
                    -- upvalues: v3 (ref), v18 (copy), v17 (ref), v2 (ref), v4 (ref), v1 (ref)
                    local _ = v3:CreateHitbox(v18.Player, {
                        Size = Vector3.new(4.5, 6, 7.5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1.25), 
                        Damage = v18.Config.SlashDamage, 
                        Time = 0.25, 
                        Knockback = 2, 
                        HitMultiple = false, 
                        ExecuteOnKill = true, 
                        Connections = {
                            Hit = function(v19, v20) --[[ Line: 58 ]] --[[ Name: Hit ]]
                                -- upvalues: v17 (ref), v18 (ref), v2 (ref), v4 (ref), v1 (ref)
                                v17(v18, v19);
                                v2:CreateSpeedMultiplier(v19, 1.5, "HitSpeedBonus", 1.25);
                                v4:ApplyStatus(v19, "Poisoned", {
                                    Stackable = true, 
                                    Level = v18.Config.SlashPoisonLevel, 
                                    Duration = v18.Config.SlashPoisonDuration
                                });
                                v4:ApplyStatus(v19, "Glitched", {
                                    Stackable = true, 
                                    Level = v18.Config.SlashGlitchLevel, 
                                    Duration = v18.Config.SlashGlitchDuration
                                });
                                if v20 then
                                    v1:Play(v18.Config.Sounds.Hit, {
                                        Parent = v18.Rig.PrimaryPart, 
                                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                        Volume = 0.25
                                    });
                                end;
                            end
                        }
                    });
                end);
                task.delay(1, function() --[[ Line: 72 ]]
                    -- upvalues: v18 (copy)
                    v18.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v18.Animations.Slash:Play(0.175);
                end;
                return;
            end;
        end
    }, 
    MassInfection = {
        LayoutOrder = 2, 
        Icon = "rbxassetid://112065267803856", 
        KeybindType = "AltAbility1", 
        Callback = function(v22) --[[ Line: 89 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v17 (copy), v2 (copy), v4 (copy)
            if game["Run Service"]:IsServer() then
                v22.AbilitiesDisabled = true;
                v1:Play(v22.Config.Sounds.MassInfectionActivate, {
                    Parent = v22.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.75
                });
                task.delay(1.6, function() --[[ Line: 96 ]]
                    -- upvalues: v3 (ref), v22 (copy), v17 (ref), v2 (ref), v4 (ref)
                    v3:CreateHitbox(v22.Player, {
                        Size = Vector3.new(9.5, 4, 10, 0), 
                        CFrameOffset = CFrame.new(0, 0, -2), 
                        Damage = v22.Config.MassInfectionSlashDamage, 
                        Time = 0.125, 
                        Knockback = 5, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v23, _) --[[ Line: 107 ]] --[[ Name: Hit ]]
                                -- upvalues: v17 (ref), v22 (ref), v2 (ref), v4 (ref)
                                v17(v22, v23);
                                v2:CreateSpeedMultiplier(v23, 1.5, "HitSpeedBonus", 2.5);
                                v4:ApplyStatus(v23, "Poisoned", {
                                    Stackable = true, 
                                    Level = v22.Config.MassInfectionSlashPoisonLevel, 
                                    Duration = v22.Config.MassInfectionSlashPoisonDuration
                                });
                                v4:ApplyStatus(v23, "Glitched", {
                                    Stackable = true, 
                                    Level = v22.Config.MassInfectionSlashGlitchLevel, 
                                    Duration = v22.Config.MassInfectionSlashGlitchDuration
                                });
                                if tostring(v23.Parent) == "Survivors" then
                                    require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v22.Player, {
                                        Action = "Landed Mass Infection up close", 
                                        RewardType = "DifficultKillerAction"
                                    });
                                end;
                            end
                        }
                    });
                end);
                task.delay(1.7, function() --[[ Line: 127 ]]
                    -- upvalues: v22 (copy), v3 (ref), v17 (ref), v2 (ref), v4 (ref)
                    if v22.Rig:GetAttribute("Stunned") then
                        return;
                    else
                        local v25 = v22.Config.ShockwaveTemplate:Clone();
                        local l_PrimaryPart_0 = v25.PrimaryPart;
                        v25.Parent = workspace.Map.Ingame;
                        v25:SetPrimaryPartCFrame(v22.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, 2));
                        local v27 = l_PrimaryPart_0.CFrame * CFrame.new(0, 0, -v22.Config.MassInfectionShockwaveSpeed * v22.Config.MassInfectionShockwaveLifetime);
                        game.Debris:AddItem(v25, v22.Config.MassInfectionShockwaveLifetime);
                        game.TweenService:Create(l_PrimaryPart_0, TweenInfo.new(v22.Config.MassInfectionShockwaveLifetime, Enum.EasingStyle.Linear), {
                            CFrame = v27
                        }):Play();
                        v3:CreateHitbox(v22.Player, {
                            Size = Vector3.new(8, 5, 6, 0), 
                            CFrame = function() --[[ Line: 141 ]] --[[ Name: CFrame ]]
                                -- upvalues: l_PrimaryPart_0 (copy)
                                return l_PrimaryPart_0.CFrame;
                            end, 
                            Damage = v22.Config.MassInfectionShockwaveDamage, 
                            Time = v22.Config.MassInfectionShockwaveLifetime, 
                            Knockback = 0.5, 
                            HitMultiple = true, 
                            PredictVelocity = false, 
                            Connections = {
                                Hit = function(v28) --[[ Line: 150 ]] --[[ Name: Hit ]]
                                    -- upvalues: v17 (ref), v22 (ref), v2 (ref), v4 (ref)
                                    v17(v22, v28);
                                    v2:RevealPlayerAuraTo(v22.Player, v28, v22.Config.MassInfectionShockwaveAuraDuration);
                                    v4:ApplyStatus(v28, "Poisoned", {
                                        Stackable = true, 
                                        Level = v22.Config.MassInfectionShockwavePoisonLevel, 
                                        Duration = v22.Config.MassInfectionShockwavePoisonDuration
                                    });
                                    v4:ApplyStatus(v28, "Glitched", {
                                        Stackable = true, 
                                        Level = v22.Config.MassInfectionShockwaveGlitchLevel, 
                                        Duration = v22.Config.MassInfectionShockwaveGlitchDuration
                                    });
                                    if tostring(v28.Parent) == "Survivors" then
                                        require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v22.Player, {
                                            Action = "Landed Mass Infection hit", 
                                            RewardType = "EasyKillerAction"
                                        });
                                    end;
                                end
                            }
                        });
                        return;
                    end;
                end);
                task.delay(3, function() --[[ Line: 170 ]]
                    -- upvalues: v22 (copy)
                    v22.AbilitiesDisabled = false;
                end);
                task.delay(0.5, function() --[[ Line: 175 ]]
                    -- upvalues: v22 (copy), v1 (ref)
                    for v29 = 1, 6 do
                        v22.Rig.HumanoidRootPart["Chain" .. v29]["Chain" .. v29].Enabled = true;
                        v22.Rig.HumanoidRootPart["Chain" .. v29]["Orb" .. v29].Enabled = true;
                        v1:Play(v22.Config.Sounds.Chains, {
                            Parent = v22.Rig.PrimaryPart, 
                            PlaybackSpeed = 2, 
                            Volume = 0.1, 
                            RollOffMaxDistance = 400
                        });
                    end;
                end);
                task.delay(1.65, function() --[[ Line: 182 ]]
                    -- upvalues: v22 (copy)
                    v22.Rig.Head.EyesFlare.Big.Enabled = true;
                    v22.Rig.Head.EyesFlare.Flames.Enabled = true;
                    v22.Rig.Head.EyesFlare.Shockwave.Enabled = true;
                    v22.Rig.Head.EyesFlare["Small :D"].Enabled = true;
                    v22.Rig.Head.EyesFlare.SmokeBLACK.Enabled = true;
                    v22.Rig.Head.EyesFlare.SmokeRed.Enabled = true;
                end);
                task.delay(1.8, function() --[[ Line: 190 ]]
                    -- upvalues: v22 (copy)
                    v22.Rig.Head.EyesFlare.Big.Enabled = false;
                    v22.Rig.Head.EyesFlare.Flames.Enabled = false;
                    v22.Rig.Head.EyesFlare.Shockwave.Enabled = false;
                    v22.Rig.Head.EyesFlare["Small :D"].Enabled = false;
                    v22.Rig.Head.EyesFlare.SmokeBLACK.Enabled = false;
                    v22.Rig.Head.EyesFlare.SmokeRed.Enabled = false;
                    for v30 = 1, 6 do
                        v22.Rig.HumanoidRootPart["Chain" .. v30]["Chain" .. v30].Enabled = false;
                        v22.Rig.HumanoidRootPart["Chain" .. v30]["Orb" .. v30].Enabled = false;
                    end;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v22.Animations.MassInfection:Play(0.175);
                    v2:CreateSpeedMultiplier(v22.Player, 0.01, "MassInfection", 2.65, true);
                end;
                return;
            end;
        end
    }, 
    Entanglement = {
        LayoutOrder = 3, 
        Icon = "rbxassetid://119069138923680", 
        KeybindType = "AltAbility2", 
        Callback = function(v31) --[[ Line: 219 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v13 (copy), v3 (copy), v17 (copy), v2 (copy), v4 (copy), v5 (copy)
            if game["Run Service"]:IsServer() then
                v31.AbilitiesDisabled = true;
                v1:Play(v31.Config.Sounds.EntanglementActivate, {
                    Parent = v31.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.5
                });
                task.delay(0.75, function() --[[ Line: 226 ]]
                    -- upvalues: v13 (ref), v31 (copy), v3 (ref), v17 (ref), v2 (ref), v4 (ref), v5 (ref)
                    v13(v31.Rig, false);
                    local v32 = v31.Config.SwordsTemplate:Clone();
                    local l_PrimaryPart_1 = v32.PrimaryPart;
                    v32.Parent = workspace.Map.Ingame;
                    v32:SetPrimaryPartCFrame(v31.Rig.PrimaryPart.CFrame * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(-0.25, -0.25, 6));
                    local v34 = l_PrimaryPart_1.CFrame * CFrame.new(0, 0, v31.Config.EntanglementSpeed * v31.Config.EntanglementLifetime);
                    game.Debris:AddItem(v32, v31.Config.EntanglementLifetime);
                    game.TweenService:Create(l_PrimaryPart_1, TweenInfo.new(v31.Config.EntanglementLifetime, Enum.EasingStyle.Linear), {
                        CFrame = v34
                    }):Play();
                    v3:CreateHitbox(v31.Player, {
                        Size = Vector3.new(4.5, 1.75, 5, 0), 
                        CFrame = function() --[[ Line: 241 ]] --[[ Name: CFrame ]]
                            -- upvalues: l_PrimaryPart_1 (copy)
                            return l_PrimaryPart_1.CFrame;
                        end, 
                        Damage = v31.Config.EntanglementDamage, 
                        Time = v31.Config.EntanglementLifetime, 
                        Knockback = 0.5, 
                        HitMultiple = true, 
                        PredictVelocity = false, 
                        Connections = {
                            Hit = function(v35) --[[ Line: 250 ]] --[[ Name: Hit ]]
                                -- upvalues: v17 (ref), v31 (ref), v2 (ref), v4 (ref), v5 (ref)
                                if v17(v31, v35) then
                                    return;
                                else
                                    v2:RevealPlayerAuraTo(v31.Player, v35, v31.Config.EntanglementAuraDuration);
                                    v4:ApplyStatus(v31.Player, "Speed", {
                                        Level = 2, 
                                        Duration = v31.Config.EntanglementKillerSpeedBuffDuration
                                    });
                                    v35:SetAttribute("Entangled", true);
                                    v4:ApplyStatus(v35, "Helpless", {
                                        Level = 1, 
                                        Duration = v31.Config.EntanglementHelplessDuration
                                    });
                                    v4:ApplyStatus(v35, "Slowness", {
                                        Level = 10, 
                                        Duration = 30
                                    });
                                    v5:FireClientConnection(game.Players:GetPlayerFromCharacter(v35), "Entangled", "REMOTE_EVENT");
                                    if tostring(v35.Parent) == "Survivors" then
                                        require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v31.Player, {
                                            Action = "Landed Entanglement hit", 
                                            RewardType = "RegularKillerAction"
                                        });
                                    end;
                                    return;
                                end;
                            end
                        }
                    });
                end);
                task.delay(1.75, function() --[[ Line: 276 ]]
                    -- upvalues: v31 (copy), v13 (ref)
                    v31.AbilitiesDisabled = false;
                    v13(v31.Rig, true);
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v31.Animations.Entanglement:Play(0.175);
                    v2:CreateSpeedMultiplier(v31.Player, 0.01, "Entanglement", 1.5, true);
                end;
                return;
            end;
        end
    }, 
    UnstableEye = {
        LayoutOrder = 4, 
        Icon = "rbxassetid://135373963092918", 
        KeybindType = "AltAbility3", 
        Callback = function(v36) --[[ Line: 297 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v4 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v36.AbilitiesDisabled = true;
                v1:Play(v36.Config.Sounds.UnstableEyeActivate, {
                    Parent = v36.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.6, 
                    RollOffMaxDistance = 400
                });
                v1:Play(v36.Config.Sounds.UnstableEyeMode, {
                    Parent = v36.Rig.PrimaryPart, 
                    PlaybackSpeed = 1.25, 
                    Volume = 0.25
                });
                task.delay(0.9, function() --[[ Line: 305 ]]
                    -- upvalues: v4 (ref), v36 (copy)
                    v4:ApplyStatus(v36.Player, "Blindness", {
                        Duration = v36.Config.UnstableEyeDebuffDuration, 
                        Level = 3
                    });
                    v4:ApplyStatus(v36.Player, "Speed", {
                        Duration = v36.Config.UnstableEyeBuffDuration, 
                        Level = 1
                    });
                end);
                task.delay(1.5, function() --[[ Line: 311 ]]
                    -- upvalues: v36 (copy)
                    v36.AbilitiesDisabled = false;
                end);
                task.delay(0.9, function() --[[ Line: 316 ]]
                    -- upvalues: v36 (copy)
                    v36.Rig.Head.EyesFlare.Big.Enabled = true;
                    v36.Rig.Head.EyesFlare.Flames.Enabled = true;
                    v36.Rig.Head.EyesFlare.Shockwave.Enabled = true;
                    v36.Rig.Head.EyesFlare["Small :D"].Enabled = true;
                    v36.Rig.Head.EyesFlare.SmokeBLACK.Enabled = true;
                    v36.Rig.Head.EyesFlare.SmokeRed.Enabled = true;
                end);
                task.delay(1.1, function() --[[ Line: 324 ]]
                    -- upvalues: v36 (copy)
                    v36.Rig.Head.EyesFlare.Big.Enabled = false;
                    v36.Rig.Head.EyesFlare.Flames.Enabled = false;
                    v36.Rig.Head.EyesFlare.Shockwave.Enabled = false;
                    v36.Rig.Head.EyesFlare["Small :D"].Enabled = false;
                    v36.Rig.Head.EyesFlare.SmokeBLACK.Enabled = false;
                    v36.Rig.Head.EyesFlare.SmokeRed.Enabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v36.Animations.UnstableEye:Play(0.175);
                    v2:CreateSpeedMultiplier(v36.Player, 0.01, "UnstableEye", 1.75, true);
                    task.delay(0.9, function() --[[ Line: 341 ]]
                        -- upvalues: v2 (ref), v36 (copy)
                        for _, v38 in pairs(workspace.Players.Survivors:GetChildren()) do
                            v2:RevealPlayerAura(v38, v36.Config.UnstableEyeAuraDuration);
                        end;
                    end);
                end;
                return;
            end;
        end
    }, 
    RejuvenateTheRotten = {
        LayoutOrder = 5, 
        Icon = "rbxassetid://102037518703784", 
        KeybindType = "AltAbility4", 
        Charges = 0, 
        Callback = function(v39) --[[ Line: 357 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v39.AbilitiesDisabled = true;
                v1:Play(v39.Config.Sounds.RejuvenateTheRottenActivate, {
                    Parent = v39.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.75
                });
                task.delay(1, function() --[[ Line: 364 ]]
                    -- upvalues: v39 (copy), v2 (ref), v1 (ref)
                    local l_PrimaryPart_2 = v39.Rig.PrimaryPart;
                    local l_pairs_0 = pairs;
                    local v42 = v39.KilledLocations or {};
                    for _, v44 in l_pairs_0(v42) do
                        task.spawn(function() --[[ Line: 367 ]]
                            -- upvalues: v39 (ref), v2 (ref), v44 (copy), l_PrimaryPart_2 (copy), v1 (ref)
                            local v45 = v39.Config.ZombieTemplate:IsA("Model") and v39.Config.ZombieTemplate:Clone() or v39.Config.ZombieTemplate:GetChildren()[math.random(1, #v39.Config.ZombieTemplate:GetChildren())]:Clone();
                            v45:SetAttribute("ExecutionsDisabled", true);
                            v45.Name = "1x1x1x1Zombie";
                            v45.PrimaryPart.Anchored = true;
                            v45.Humanoid.Health = v39.Config.ZombieHealth;
                            v45.Humanoid.EvaluateStateMachine = false;
                            v45.Parent = workspace.Map.Ingame;
                            for _, v47 in pairs(v45:GetDescendants()) do
                                if v47:IsA("BasePart") then
                                    v47.Massless = true;
                                    v47.CanQuery = true;
                                end;
                            end;
                            local v48 = {};
                            for v49, v50 in pairs(v39.Config.ZombieAnimations) do
                                v48[v49] = v2:LoadAnimationFromID(v45, v50);
                            end;
                            v48.Summon:Play(0);
                            v48.Idle:Play(0);
                            v45:SetPrimaryPartCFrame(CFrame.lookAt(v44, (Vector3.new(l_PrimaryPart_2.Position.X, v44.Y, l_PrimaryPart_2.Position.Z))));
                            task.wait(2.5);
                            v2:RevealPlayerAuraTo(v39.Player, v45, 600, Color3.new(0.5, 0.75, 0.5));
                            local v51 = "";
                            v45.Humanoid.Running:Connect(function(v52) --[[ Line: 407 ]]
                                -- upvalues: v45 (copy), v39 (ref), v51 (ref), v48 (copy)
                                if v52 > 0.01 then
                                    if v45.Humanoid.WalkSpeed == v39.Config.ZombieWalkSpeed and v51 ~= "Walk" then
                                        v48.Walk:Play();
                                        v48.Run:Stop();
                                        return;
                                    elseif v45.Humanoid.WalkSpeed == v39.Config.ZombieSprintSpeed and v51 ~= "Run" then
                                        v48.Walk:Stop();
                                        v48.Run:Play();
                                        return;
                                    end;
                                else
                                    v51 = "";
                                    v48.Walk:Stop();
                                    v48.Run:Stop();
                                end;
                            end);
                            task.spawn(function() --[[ Line: 426 ]]
                                -- upvalues: v39 (ref), v45 (copy), v1 (ref)
                                local l_ZombieSounds_0 = v39.Config.ZombieSounds;
                                if l_ZombieSounds_0 then
                                    local v54 = #l_ZombieSounds_0;
                                    while v45.Parent and v45.PrimaryPart do
                                        v1:Play(l_ZombieSounds_0[math.random(1, v54)], {
                                            Parent = v45.PrimaryPart, 
                                            Volume = 0.4, 
                                            PlaybackSpeed = Random.new():NextNumber(0.8, 2)
                                        });
                                        task.wait(math.random(10, 25));
                                    end;
                                end;
                            end);
                            v45.PrimaryPart.Anchored = false;
                            v45.Humanoid.EvaluateStateMachine = true;
                            task.spawn(function() --[[ Line: 442 ]]
                                -- upvalues: v45 (copy), v39 (ref), v48 (copy), v1 (ref), v2 (ref)
                                local v55 = 0;
                                local v56 = math.random(6, 12);
                                local v57 = nil;
                                local v58 = require(game.ReplicatedStorage.Modules.SimplePath).new(v45);
                                while v45.Parent and v45.PrimaryPart and v45.Humanoid.Health > 0 do
                                    if v57 and v57.PrimaryPart and v57.Humanoid.Health > 0 and not v57:GetAttribute("Undetectable") then
                                        local l_Magnitude_0 = (v57.PrimaryPart.Position - v45.PrimaryPart.Position).Magnitude;
                                        if l_Magnitude_0 <= v39.Config.ZombieAttackRange then
                                            v48.Attack:Play();
                                            v1:Play(v39.Config.Sounds.Swing, {
                                                Parent = v45.PrimaryPart, 
                                                PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                                Volume = 0.25
                                            });
                                            v2:ApplyDamage(v57, v39.Config.ZombieAttackDamage);
                                            task.wait(v39.Config.ZombieAttackCooldown);
                                            continue;
                                        elseif v39.Config.ZombieLoseFocusRange <= l_Magnitude_0 then
                                            v57 = nil;
                                            v58:Stop();
                                        else
                                            v45.Humanoid.WalkSpeed = v39.Config.ZombieSprintSpeed;
                                            v58:Run(v57.PrimaryPart.Position);
                                        end;
                                    else
                                        v57 = nil;
                                        v45.Humanoid.WalkSpeed = v39.Config.ZombieWalkSpeed;
                                    end;
                                    local l_v2_ClosestPlayerFromPosition_0 = v2:GetClosestPlayerFromPosition(v45.PrimaryPart.Position, {
                                        PlayerSelection = "Survivors", 
                                        MaxDistance = v39.Config.ZombieTargetRange
                                    });
                                    if l_v2_ClosestPlayerFromPosition_0 then
                                        v57 = l_v2_ClosestPlayerFromPosition_0;
                                    end;
                                    if v56 <= v55 then
                                        v55 = 0;
                                        v56 = math.random(6, 12);
                                        v45.Humanoid:MoveTo(v45.PrimaryPart.Position + Vector3.new(math.random(-80, 80), 0, math.random(-80, 80)));
                                    end;
                                    v45.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true);
                                    v45.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false);
                                    v45.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
                                    v55 = v55 + game["Run Service"].Heartbeat:Wait();
                                end;
                                if v58 then
                                    v58:Destroy();
                                end;
                            end);
                        end);
                    end;
                end);
                task.delay(4.25, function() --[[ Line: 508 ]]
                    -- upvalues: v39 (copy)
                    v39.AbilitiesDisabled = false;
                end);
                task.delay(0.98, function() --[[ Line: 513 ]]
                    -- upvalues: v39 (copy), v1 (ref)
                    v39.Rig.Head.EyesFlare.Big.Enabled = true;
                    v39.Rig.Head.EyesFlare.Flames.Enabled = true;
                    v39.Rig.Head.EyesFlare.Shockwave.Enabled = true;
                    v39.Rig.Head.EyesFlare["Small :D"].Enabled = true;
                    v39.Rig.Head.EyesFlare.SmokeBLACK.Enabled = true;
                    v39.Rig.Head.EyesFlare.SmokeRed.Enabled = true;
                    for v61 = 1, 6 do
                        v39.Rig.HumanoidRootPart["Chain" .. v61]["Chain" .. v61].Enabled = true;
                        v1:Play(v39.Config.Sounds.Chains, {
                            Parent = v39.Rig.PrimaryPart, 
                            PlaybackSpeed = 1.5, 
                            Volume = 0.1
                        });
                    end;
                end);
                task.delay(1.35, function() --[[ Line: 527 ]]
                    -- upvalues: v39 (copy)
                    v39.Rig.Torso.Blood.Blood.Enabled = false;
                    v39.Rig.Head.EyesFlare.Big.Enabled = false;
                    v39.Rig.Head.EyesFlare.Flames.Enabled = false;
                    v39.Rig.Head.EyesFlare.Shockwave.Enabled = false;
                    v39.Rig.Head.EyesFlare["Small :D"].Enabled = false;
                    v39.Rig.Head.EyesFlare.SmokeBLACK.Enabled = false;
                    v39.Rig.Head.EyesFlare.SmokeRed.Enabled = false;
                end);
                task.delay(1.98, function() --[[ Line: 537 ]]
                    -- upvalues: v39 (copy)
                    v39.Rig.HumanoidRootPart["Chain" .. 1]["Chain" .. 1].Enabled = false;
                    v39.Rig.HumanoidRootPart["Chain" .. 2]["Chain" .. 2].Enabled = false;
                    v39.Rig.HumanoidRootPart["Chain" .. 3]["Chain" .. 3].Enabled = false;
                    v39.Rig.HumanoidRootPart["Chain" .. 4]["Chain" .. 4].Enabled = false;
                    v39.Rig.HumanoidRootPart["Chain" .. 5]["Chain" .. 5].Enabled = false;
                    v39.Rig.HumanoidRootPart["Chain" .. 6]["Chain" .. 6].Enabled = false;
                end);
                task.delay(2.1, function() --[[ Line: 543 ]]

                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v39.Animations.RejuvenateTheRotten:Play(0.175);
                    v2:CreateSpeedMultiplier(v39.Player, 0.01, "RejuvenateTheRotten", 3.75, true);
                end;
                return;
            end;
        end
    }
};
v0.Created = function(_, v63) --[[ Line: 559 ]] --[[ Name: Created ]]
    -- upvalues: v5 (copy), v4 (copy)
    if game["Run Service"]:IsServer() then
        v5:SetConnection("Entangled", "REMOTE_EVENT", function(v64) --[[ Line: 562 ]]
            -- upvalues: v4 (ref), v63 (copy)
            if v64.Character and v64.Character:GetAttribute("Entangled") then
                v64.Character:SetAttribute("Entangled", false);
                v4:RemoveStatus(v64, "Slowness");
                v4:ApplyStatus(v64.Character, "Speed", {
                    Duration = v63.Config.EntanglementSurvivorSpeedBuffDuration, 
                    Level = 1, 
                    Instant = true
                });
            end;
        end);
        v63.KilledLocations = {};
        local function v68(v65) --[[ Line: 574 ]] --[[ Name: setDeathConnection ]]
            -- upvalues: v63 (copy)
            local l_Humanoid_0 = v65:FindFirstChild("Humanoid");
            local l_PrimaryPart_3 = v65.PrimaryPart;
            if l_Humanoid_0 and l_PrimaryPart_3 then
                l_Humanoid_0.Died:Connect(function() --[[ Line: 578 ]]
                    -- upvalues: v63 (ref), l_PrimaryPart_3 (copy)
                    v63:IncrementCharges("RejuvenateTheRotten", 1, 1);
                    table.insert(v63.KilledLocations, l_PrimaryPart_3.Position);
                end);
            end;
        end;
        for _, v70 in pairs(workspace.Players.Survivors:GetChildren()) do
            local l_Humanoid_1 = v70:FindFirstChild("Humanoid");
            local l_PrimaryPart_4 = v70.PrimaryPart;
            if l_Humanoid_1 and l_PrimaryPart_4 then
                l_Humanoid_1.Died:Connect(function() --[[ Line: 578 ]]
                    -- upvalues: v63 (copy), l_PrimaryPart_4 (copy)
                    v63:IncrementCharges("RejuvenateTheRotten", 1, 1);
                    table.insert(v63.KilledLocations, l_PrimaryPart_4.Position);
                end);
            end;
        end;
        local v73 = nil;
        v73 = workspace.Players.Survivors.ChildAdded:Connect(v68);
        v63.Rig.AncestryChanged:Connect(function(_, v75) --[[ Line: 592 ]]
            -- upvalues: v73 (ref)
            if not v75 then
                v73:Disconnect();
                v73 = nil;
            end;
        end);
        if not v63.Config.HighlightDisabled then
            local l_Highlight_0 = Instance.new("Highlight");
            l_Highlight_0.DepthMode = Enum.HighlightDepthMode.Occluded;
            l_Highlight_0.Parent = v63.Rig;
            for v77, v78 in pairs(v63.Config.HighlightProperties) do
                l_Highlight_0[v77] = v78;
            end;
        end;
        return;
    else
        if game["Run Service"]:IsClient() then
            v5:SetConnection("Entangled", "REMOTE_EVENT", function() --[[ Line: 610 ]]
                -- upvalues: v63 (copy), v5 (ref)
                task.spawn(function() --[[ Line: 612 ]]
                    require(game.ReplicatedStorage.Systems.Player.Game.SmoothShiftLock):ToggleShiftLock(false);
                end);
                local l_PopupsFolder_0 = v63.Config.PopupsFolder;
                local v80 = {};
                for _ = 1, v63.Config.EntanglementPopupCount do
                    local l_l_PopupsFolder_0_Children_0 = l_PopupsFolder_0:GetChildren();
                    table.insert(v80, l_l_PopupsFolder_0_Children_0[math.random(1, #l_l_PopupsFolder_0_Children_0)]:Clone());
                end;
                for _, v84 in pairs(v80) do
                    local l_TemporaryUI_0 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("TemporaryUI");
                    v84.Name = "1x1x1x1Popup";
                    v84.Selectable = false;
                    v84.Position = UDim2.fromScale(0.5, 0.5) + UDim2.fromScale(math.random(-100, 100) / 500, math.random(-100, 100) / 400);
                    v84.Parent = l_TemporaryUI_0;
                    v84.MouseButton1Click:Connect(function() --[[ Line: 636 ]]
                        -- upvalues: v84 (copy), l_TemporaryUI_0 (copy), v5 (ref)
                        v84.Name = "aaaahhhh";
                        v84:Destroy();
                        local l_pairs_1 = pairs;
                        local v87 = l_TemporaryUI_0 and l_TemporaryUI_0:GetChildren() or {};
                        for _, v89 in l_pairs_1(v87) do
                            if v89.Name == "1x1x1x1Popup" then
                                return;
                            end;
                        end;
                        v5:FireServerConnection("Entangled", "REMOTE_EVENT");
                    end);
                end;
                if require(game.ReplicatedStorage.Modules.Device):GetPlayerDevice() == "Console" then
                    local l_TemporaryUI_1 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("TemporaryUI");
                    local v91 = script.ConsoleThing:Clone();
                    v91.Parent = l_TemporaryUI_1;
                    game.TweenService:Create(v91, TweenInfo.new(2.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                        TextTransparency = 1, 
                        TextStrokeTransparency = 1
                    }):Play();
                    game.Debris:AddItem(v91, 2.5);
                    local l_Humanoid_2 = game.Players.LocalPlayer.Character.Humanoid;
                    local v93 = 0;
                    local v94 = nil;
                    do
                        local l_v93_0, l_v94_0 = v93, v94;
                        l_v94_0 = l_Humanoid_2:GetPropertyChangedSignal("Jump"):Connect(function() --[[ Line: 661 ]]
                            -- upvalues: l_v93_0 (ref), l_TemporaryUI_1 (copy), v5 (ref), l_v94_0 (ref)
                            l_v93_0 = l_v93_0 + 1;
                            if l_v93_0 % 3 == 0 then
                                for _, v98 in pairs(l_TemporaryUI_1:GetChildren()) do
                                    if v98.Name == "1x1x1x1Popup" then
                                        v98.Name = "aaaahhhh";
                                        v98:Destroy();
                                        local l_pairs_2 = pairs;
                                        local v100 = l_TemporaryUI_1 and l_TemporaryUI_1:GetChildren() or {};
                                        for _, v102 in l_pairs_2(v100) do
                                            if v102.Name == "1x1x1x1Popup" then
                                                return;
                                            end;
                                        end;
                                        v5:FireServerConnection("Entangled", "REMOTE_EVENT");
                                        l_v94_0:Disconnect();
                                        l_v94_0 = nil;
                                    end;
                                end;
                            end;
                            local v103 = false;
                            for _, v105 in pairs(l_TemporaryUI_1:GetChildren()) do
                                if v105.Name == "1x1x1x1Popup" then
                                    if not v105:GetAttribute("OrigSize") then
                                        v105:SetAttribute("OrigSize", v105.Size);
                                    end;
                                    local l_v105_Attribute_0 = v105:GetAttribute("OrigSize");
                                    v105.Size = l_v105_Attribute_0 + (not v103 and UDim2.fromScale(0.05, 0.05) or UDim2.fromScale(0.015, 0.015));
                                    game.TweenService:Create(v105, TweenInfo.new(0.1), {
                                        Size = l_v105_Attribute_0
                                    }):Play();
                                    v103 = true;
                                end;
                            end;
                        end);
                    end;
                end;
            end);
        end;
        return;
    end;
end;
v0.OnIntroduction = function(_, v108, v109, v110) --[[ Line: 700 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v2 (copy)
    local v111 = v108.Config.IntroHeadTemplate:Clone();
    v111:SetPrimaryPartCFrame(v109:WaitForChild("Right Arm").CFrame * CFrame.Angles(0, 0, 3.141592653589793) * CFrame.new(0, 0.9, 0.1));
    v111.ArmWeld.Part0 = v109:WaitForChild("Right Arm");
    v111.Parent = workspace;
    game.Debris:AddItem(v111, 5);
    task.delay(0.92, function() --[[ Line: 708 ]]
        -- upvalues: v111 (copy)
        local l_Root_0 = v111:FindFirstChild("Root");
        local v113 = l_Root_0 and l_Root_0:FindFirstChild("Blood");
        if v113 then
            v113:Emit(30);
        end;
    end);
    task.delay(0.94, function() --[[ Line: 716 ]]
        -- upvalues: v109 (copy)
        v109.Head.EyesFlare.Big.Enabled = true;
        v109.Head.EyesFlare.Flames.Enabled = true;
        v109.Head.EyesFlare.Shockwave.Enabled = true;
        v109.Head.EyesFlare["Small :D"].Enabled = true;
        v109.Head.EyesFlare.SmokeBLACK.Enabled = true;
        v109.Head.EyesFlare.SmokeRed.Enabled = true;
    end);
    task.delay(0.966, function() --[[ Line: 726 ]]
        -- upvalues: v111 (copy)
        v111.Head:Destroy();
        v111.Hair:Destroy();
    end);
    task.delay(1.2, function() --[[ Line: 732 ]]
        -- upvalues: v109 (copy)
        v109.Head.EyesFlare.Big.Enabled = false;
        v109.Head.EyesFlare.Flames.Enabled = false;
        v109.Head.EyesFlare.Shockwave.Enabled = false;
        v109.Head.EyesFlare["Small :D"].Enabled = false;
        v109.Head.EyesFlare.SmokeBLACK.Enabled = false;
        v109.Head.EyesFlare.SmokeRed.Enabled = false;
    end);
    v2:CreateFOVMultiplier(game.Players.LocalPlayer, 0.6, "1x1x1x1IntroScene", v110);
    local v114 = require(game.ReplicatedStorage.Modules.Schematics.Lighting);
    v114:SetCustomLighting(v108.Config.IntroLighting);
    task.delay(v110, function() --[[ Line: 749 ]]
        -- upvalues: v114 (copy)
        v114:SetAsCurrentLighting();
    end);
end;
v0.OnExecution = function(_, v116, v117) --[[ Line: 754 ]] --[[ Name: OnExecution ]]
    -- upvalues: v5 (copy)
    local l_Humanoid_3 = v117:FindFirstChild("Humanoid");
    local l_Head_0 = v117:FindFirstChild("Head");
    task.delay(2, function() --[[ Line: 760 ]]
        -- upvalues: v116 (copy), l_Humanoid_3 (copy), v117 (copy), l_Head_0 (copy), v5 (ref)
        local l_FirstChild_0 = v116.Rig["Left Arm"]:FindFirstChild("Blood", true);
        if l_FirstChild_0 then
            l_FirstChild_0.Enabled = true;
            task.delay(0.2, function() --[[ Line: 764 ]]
                -- upvalues: l_FirstChild_0 (copy)
                l_FirstChild_0.Enabled = false;
            end);
        end;
        if l_Humanoid_3 then
            l_Humanoid_3.BreakJointsOnDeath = false;
            l_Humanoid_3.Health = 0;
            local l_ipairs_0 = ipairs;
            local v122 = v117 and v117:GetChildren() or {};
            for _, v124 in l_ipairs_0(v122) do
                if v124:IsA("Accessory") then
                    v124:Destroy();
                end;
            end;
            if l_Head_0 then
                l_Head_0:Destroy();
            end;
            l_ipairs_0 = v116.Rig.PrimaryPart.CFrame.LookVector.Unit * 35;
            v5:FireAllClientConnection("Ragdoll", "REMOTE_EVENT", v117, 0, (("%*|%*|%*"):format(l_ipairs_0.X, l_ipairs_0.Y, l_ipairs_0.Z)));
        end;
    end);
end;
return v0;