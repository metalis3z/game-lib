-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v3 = {};
local v4 = require(l_ReplicatedStorage_0.Modules.Sounds);
local v5 = require(l_ReplicatedStorage_0.Modules.Util);
local v6 = require(l_ReplicatedStorage_0.Modules.Hitboxes);
local v7 = require(l_ReplicatedStorage_0.Modules.Projectiles);
local v8 = require(l_ReplicatedStorage_0.Modules.Statuses);
local v9 = require(l_ReplicatedStorage_0.Modules.Network);
local v10 = require(l_ReplicatedStorage_0.Modules.AchievementUtil);
local v11 = require(l_ReplicatedStorage_0.Modules.Schematics.Lighting);
local function v19(v12, v13) --[[ Line: 16 ]] --[[ Name: toggleSwords ]]
    if v12 and v12.Parent and v12:FindFirstChild("ExtraModels") then
        for v14, v15 in pairs({
            v12.ExtraModels.HaxxedSwordLeft, 
            v12.ExtraModels.HaxxedSwordRight
        }) do
            local v16 = v14 == 1 and "L" or "R";
            v15.Parts[("HaxxedBlade%*2"):format(v16)].Transparency = v13 and 0 or 1;
            for _, v18 in pairs(v15.Parts[("HaxxedBlade%*"):format(v16)]:GetChildren()) do
                if v18:IsA("Beam") or v18:IsA("ParticleEmitter") then
                    v18.Enabled = v13;
                end;
            end;
        end;
    end;
end;
local function v25(v20, v21, v22, ...) --[[ Line: 30 ]] --[[ Name: pcallMethod ]]
    local l_status_0, l_result_0 = pcall(function(...) --[[ Line: 31 ]]
        -- upvalues: v22 (copy), v20 (copy)
        if v22.Behavior[v20] then
            return v22.Behavior[v20](v22, ...);
        else
            return;
        end;
    end, ...);
    if not l_status_0 then
        warn((("[%*]: Failed to call .%*() due to: %*"):format(v21, v20, l_result_0)));
    end;
    return l_result_0;
end;
local function v29(v26, v27) --[[ Line: 44 ]] --[[ Name: zombieCheck ]]
    -- upvalues: v8 (copy)
    if v27.Name == "1x1x1x1Zombie" then
        local _ = v8:PlayerHasStatus(v26.Player, "Speed");
        v8:ApplyStatus(v26.Rig, "Speed", {
            Stackable = true, 
            MaxLevel = 1, 
            Level = v26.Config.ZombieKillSpeedLevel, 
            Duration = v26.Config.ZombieKillSpeedDuration
        });
        v26:PlayVoiceline("MinionSpeed", {
            Priority = 3
        });
        return true;
    else
        return;
    end;
end;
v3.Abilities = {
    Slash = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://120590195585579", 
        KeybindType = "MainAbility", 
        Callback = function(v30) --[[ Line: 60 ]] --[[ Name: Callback ]]
            -- upvalues: v4 (copy), v6 (copy), v29 (copy), v5 (copy), v8 (copy)
            if game["Run Service"]:IsServer() then
                v30.AbilitiesDisabled = true;
                v4:Play(v30.Config.Sounds.Swing, {
                    Parent = v30.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.25
                });
                task.delay(v30.Config.SlashWindup, function() --[[ Line: 67 ]]
                    -- upvalues: v6 (ref), v30 (copy), v29 (ref), v5 (ref), v8 (ref), v4 (ref)
                    local _ = v6:CreateHitbox(v30.Player, {
                        Size = Vector3.new(4.5, 6, 7.5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1.25), 
                        Damage = v30.Config.SlashDamage, 
                        Time = v30.Config.SlashLinger, 
                        Knockback = 2, 
                        HitMultiple = false, 
                        ExecuteOnKill = true, 
                        Connections = {
                            Hit = function(v31, v32) --[[ Line: 79 ]] --[[ Name: Hit ]]
                                -- upvalues: v29 (ref), v30 (ref), v5 (ref), v8 (ref), v4 (ref)
                                v29(v30, v31);
                                v5:CreateSpeedMultiplier(v31, 1.5, "HitSpeedBonus", 1.25);
                                v8:ApplyStatus(v31, "Poisoned", {
                                    Stackable = true, 
                                    Level = v30.Config.SlashPoisonLevel, 
                                    Duration = v30.Config.SlashPoisonDuration
                                });
                                v8:ApplyStatus(v31, "Glitched", {
                                    Stackable = true, 
                                    Level = v30.Config.SlashGlitchLevel, 
                                    Duration = v30.Config.SlashGlitchDuration
                                });
                                if v32 then
                                    v4:Play(v30.Config.Sounds.Hit, {
                                        Parent = v30.Rig.PrimaryPart, 
                                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                        Volume = 0.25
                                    });
                                end;
                            end
                        }
                    });
                end);
                task.delay(1, function() --[[ Line: 93 ]]
                    -- upvalues: v30 (copy)
                    v30.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v30.Animations.Slash:Play(0.175);
                end;
                return;
            end;
        end
    }, 
    MassInfection = {
        LayoutOrder = 2, 
        Icon = "rbxassetid://112065267803856", 
        KeybindType = "AltAbility1", 
        Callback = function(v34) --[[ Line: 110 ]] --[[ Name: Callback ]]
            -- upvalues: v4 (copy), v6 (copy), v29 (copy), v5 (copy), v8 (copy), l_ReplicatedStorage_0 (copy), v7 (copy)
            if game["Run Service"]:IsServer() then
                v34.AbilitiesDisabled = true;
                v4:Play(v34.Config.Sounds.MassInfectionActivate, {
                    Parent = v34.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.75, 
                    RollOffMaxDistance = 50
                });
                task.delay(1.6, function() --[[ Line: 117 ]]
                    -- upvalues: v6 (ref), v34 (copy), v29 (ref), v5 (ref), v8 (ref), v4 (ref), l_ReplicatedStorage_0 (ref)
                    v6:CreateHitbox(v34.Player, {
                        Size = Vector3.new(9.5, 4, 10, 0), 
                        CFrameOffset = CFrame.new(0, 0, -2), 
                        Damage = v34.Config.MassInfectionSlashDamage, 
                        Time = 0.125, 
                        Knockback = 5, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v35, _) --[[ Line: 128 ]] --[[ Name: Hit ]]
                                -- upvalues: v29 (ref), v34 (ref), v5 (ref), v8 (ref), v4 (ref), l_ReplicatedStorage_0 (ref)
                                v29(v34, v35);
                                v5:CreateSpeedMultiplier(v35, 1.5, "HitSpeedBonus", 2.5);
                                v8:ApplyStatus(v35, "Poisoned", {
                                    Stackable = true, 
                                    Level = v34.Config.MassInfectionSlashPoisonLevel, 
                                    Duration = v34.Config.MassInfectionSlashPoisonDuration
                                });
                                v8:ApplyStatus(v35, "Glitched", {
                                    Stackable = true, 
                                    Level = v34.Config.MassInfectionSlashGlitchLevel, 
                                    Duration = v34.Config.MassInfectionSlashGlitchDuration
                                });
                                v4:Play(v34.Config.Sounds.Hit, {
                                    Parent = v35.PrimaryPart, 
                                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                    Volume = 0.3
                                });
                                if tostring(v35.Parent) == "Survivors" then
                                    require(l_ReplicatedStorage_0.Modules.Actors):IncrementActorStats(v34.Player, {
                                        Action = "Landed Mass Infection up close", 
                                        RewardType = "DifficultKillerAction"
                                    });
                                end;
                            end
                        }
                    });
                end);
                task.delay(1.7, function() --[[ Line: 150 ]]
                    -- upvalues: v34 (copy), v4 (ref), v29 (ref), v5 (ref), v8 (ref), l_ReplicatedStorage_0 (ref), v7 (ref)
                    if v34.Rig:GetAttribute("Stunned") then
                        return;
                    else
                        local v37 = v34.Config.ShockwaveTemplate:Clone();
                        v4:Play(v34.Config.Sounds.MassInfectionProjectile, {
                            Parent = v37.PrimaryPart, 
                            PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                            Volume = 0.3, 
                            Looped = true
                        });
                        local v39 = {
                            Size = Vector3.new(8, 5, 6, 0), 
                            Damage = v34.Config.MassInfectionShockwaveDamage, 
                            Time = v34.Config.MassInfectionShockwaveLifetime, 
                            Knockback = 0.5, 
                            HitMultiple = true, 
                            PredictVelocity = false, 
                            Connections = {
                                Hit = function(v38) --[[ Line: 166 ]] --[[ Name: Hit ]]
                                    -- upvalues: v29 (ref), v34 (ref), v5 (ref), v8 (ref), v4 (ref), l_ReplicatedStorage_0 (ref)
                                    v29(v34, v38);
                                    v5:RevealPlayerAuraTo(v34.Player, v38, v34.Config.MassInfectionShockwaveAuraDuration);
                                    v8:ApplyStatus(v38, "Poisoned", {
                                        Stackable = true, 
                                        Level = v34.Config.MassInfectionShockwavePoisonLevel, 
                                        Duration = v34.Config.MassInfectionShockwavePoisonDuration
                                    });
                                    v8:ApplyStatus(v38, "Glitched", {
                                        Stackable = true, 
                                        Level = v34.Config.MassInfectionShockwaveGlitchLevel, 
                                        Duration = v34.Config.MassInfectionShockwaveGlitchDuration
                                    });
                                    v4:Play(v34.Config.Sounds.Hit, {
                                        Parent = v38.PrimaryPart, 
                                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                        Volume = 0.25
                                    });
                                    if tostring(v38.Parent) == "Survivors" then
                                        require(l_ReplicatedStorage_0.Modules.Actors):IncrementActorStats(v34.Player, {
                                            Action = "Landed Mass Infection hit", 
                                            RewardType = "EasyKillerAction"
                                        });
                                    end;
                                end
                            }
                        };
                        local v40 = {
                            Owner = v34.Player, 
                            HitboxConfig = v39, 
                            Lifetime = 10, 
                            InitialCFrame = v34:GetPivot() * CFrame.Angles(0, 0, 0) * CFrame.new(-0.25, -0.25, -6), 
                            InitialVelocity = v34:GetPivot().LookVector * v34.Config.MassInfectionShockwaveSpeed, 
                            Model = v37
                        };
                        v7.new(v40):Launch();
                        return;
                    end;
                end);
                task.delay(2.75, function() --[[ Line: 202 ]]
                    -- upvalues: v34 (copy)
                    v34.AbilitiesDisabled = false;
                end);
                task.delay(0.2, function() --[[ Line: 207 ]]
                    -- upvalues: v34 (copy), v4 (ref)
                    for v41 = 1, 6 do
                        v34.Rig.HumanoidRootPart["Chain" .. v41]["Chain" .. v41].Enabled = true;
                        v34.Rig.HumanoidRootPart["Chain" .. v41]["Orb" .. v41].Enabled = true;
                        v4:Play(v34.Config.Sounds.Chains, {
                            Parent = v34.Rig.PrimaryPart, 
                            PlaybackSpeed = 1, 
                            Volume = 0.1, 
                            RollOffMaxDistance = 400
                        });
                    end;
                end);
                task.delay(1.65, function() --[[ Line: 214 ]]
                    -- upvalues: v34 (copy)
                    v34.Rig.Head.EyesFlare.Big.Enabled = true;
                    v34.Rig.Head.EyesFlare.Flames.Enabled = true;
                    v34.Rig.Head.EyesFlare.Shockwave.Enabled = true;
                    v34.Rig.Head.EyesFlare["Small :D"].Enabled = true;
                    v34.Rig.Head.EyesFlare.SmokeBLACK.Enabled = true;
                    v34.Rig.Head.EyesFlare.SmokeRed.Enabled = true;
                end);
                task.delay(1.8, function() --[[ Line: 222 ]]
                    -- upvalues: v34 (copy)
                    v34.Rig.Head.EyesFlare.Big.Enabled = false;
                    v34.Rig.Head.EyesFlare.Flames.Enabled = false;
                    v34.Rig.Head.EyesFlare.Shockwave.Enabled = false;
                    v34.Rig.Head.EyesFlare["Small :D"].Enabled = false;
                    v34.Rig.Head.EyesFlare.SmokeBLACK.Enabled = false;
                    v34.Rig.Head.EyesFlare.SmokeRed.Enabled = false;
                    for v42 = 1, 6 do
                        v34.Rig.HumanoidRootPart["Chain" .. v42]["Chain" .. v42].Enabled = false;
                        v34.Rig.HumanoidRootPart["Chain" .. v42]["Orb" .. v42].Enabled = false;
                    end;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v34.Animations.MassInfection:Play(0.175, 0.9, nil);
                    v5:CreateSpeedMultiplier(v34.Player, 0.01, "MassInfection", 2.4, true);
                end;
                return;
            end;
        end
    }, 
    Entanglement = {
        LayoutOrder = 3, 
        Icon = "rbxassetid://119069138923680", 
        KeybindType = "AltAbility2", 
        Callback = function(v43) --[[ Line: 251 ]] --[[ Name: Callback ]]
            -- upvalues: v4 (copy), v19 (copy), v29 (copy), v5 (copy), v8 (copy), v9 (copy), l_ReplicatedStorage_0 (copy), v7 (copy)
            if game["Run Service"]:IsServer() then
                v43.AbilitiesDisabled = true;
                v4:Play(v43.Config.Sounds.EntanglementActivate, {
                    Parent = v43.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.5
                });
                task.delay(0.75, function() --[[ Line: 258 ]]
                    -- upvalues: v19 (ref), v43 (copy), v29 (ref), v5 (ref), v8 (ref), v9 (ref), v4 (ref), l_ReplicatedStorage_0 (ref), v7 (ref)
                    v19(v43.Rig, false);
                    local function v45(v44) --[[ Line: 262 ]] --[[ Name: onEntangledHit ]]
                        -- upvalues: v29 (ref), v43 (ref), v5 (ref), v8 (ref), v9 (ref), v4 (ref), l_ReplicatedStorage_0 (ref)
                        if v29(v43, v44) then
                            return;
                        else
                            v5:RevealPlayerAuraTo(v43.Player, v44, v43.Config.EntanglementAuraDuration);
                            v8:ApplyStatus(v43.Player, "Speed", {
                                Level = 2, 
                                Duration = v43.Config.EntanglementKillerSpeedBuffDuration
                            });
                            v44:SetAttribute("Entangled", true);
                            v8:ApplyStatus(v44, "Helpless", {
                                Level = 1, 
                                Duration = v43.Config.EntanglementHelplessDuration
                            });
                            v8:ApplyStatus(v44, "Slowness", {
                                Level = 10, 
                                Duration = 3
                            });
                            v9:FireClientConnection(game.Players:GetPlayerFromCharacter(v44), "Entangled", "REMOTE_EVENT");
                            v4:Play(v43.Config.Sounds.Hit, {
                                Parent = v44.PrimaryPart, 
                                PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                Volume = 0.25
                            });
                            if tostring(v44.Parent) == "Survivors" then
                                require(l_ReplicatedStorage_0.Modules.Actors):IncrementActorStats(v43.Player, {
                                    Action = "Landed Entanglement hit", 
                                    RewardType = "RegularKillerAction"
                                });
                            end;
                            return;
                        end;
                    end;
                    local v46 = {
                        Size = Vector3.new(4.5, 1.75, 5, 0), 
                        Damage = v43.Config.EntanglementDamage, 
                        Time = v43.Config.EntanglementLifetime, 
                        Knockback = 0.5, 
                        HitMultiple = true, 
                        PredictVelocity = false, 
                        Connections = {
                            Hit = v45
                        }
                    };
                    local v47 = v43.Config.SwordsTemplate:Clone();
                    v4:Play(v43.Config.Sounds.EntanglementProjectile, {
                        Parent = v47.PrimaryPart, 
                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                        Volume = 0.25, 
                        Looped = true, 
                        RollOffMaxDistance = 40
                    });
                    local v48 = {
                        Owner = v43.Player, 
                        HitboxConfig = v46, 
                        Lifetime = 10, 
                        InitialCFrame = v43:GetPivot() * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(-0.25, -0.25, 6), 
                        InitialVelocity = v43:GetPivot().LookVector * v43.Config.EntanglementSpeed, 
                        Model = v47
                    };
                    v7.new(v48):Launch();
                end);
                task.delay(1.5, function() --[[ Line: 319 ]]
                    -- upvalues: v43 (copy), v19 (ref)
                    v43.AbilitiesDisabled = false;
                    v19(v43.Rig, true);
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v43.Animations.Entanglement:Play(0.175, 0.9, nil);
                    v5:CreateSpeedMultiplier(v43.Player, 0.01, "Entanglement", 1.3, true);
                end;
                return;
            end;
        end
    }, 
    UnstableEye = {
        LayoutOrder = 4, 
        Icon = "rbxassetid://135373963092918", 
        KeybindType = "AltAbility3", 
        Callback = function(v49) --[[ Line: 340 ]] --[[ Name: Callback ]]
            -- upvalues: v4 (copy), v8 (copy), v5 (copy)
            if game["Run Service"]:IsServer() then
                v49.AbilitiesDisabled = true;
                v4:Play(v49.Config.Sounds.UnstableEyeActivate, {
                    Parent = v49.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.6, 
                    RollOffMaxDistance = 400
                });
                v4:Play(v49.Config.Sounds.UnstableEyeMode, {
                    Parent = v49.Rig.PrimaryPart, 
                    PlaybackSpeed = 1.25, 
                    Volume = 0.25
                });
                task.delay(0.9, function() --[[ Line: 348 ]]
                    -- upvalues: v8 (ref), v49 (copy)
                    v8:ApplyStatus(v49.Player, "Blindness", {
                        Duration = v49.Config.UnstableEyeDebuffDuration, 
                        Level = 3
                    });
                    v8:ApplyStatus(v49.Player, "Speed", {
                        Duration = v49.Config.UnstableEyeBuffDuration, 
                        Level = 1
                    });
                end);
                task.delay(1.5, function() --[[ Line: 354 ]]
                    -- upvalues: v49 (copy)
                    v49.AbilitiesDisabled = false;
                end);
                task.delay(0.9, function() --[[ Line: 359 ]]
                    -- upvalues: v49 (copy)
                    v49.Rig.Head.EyesFlare.Big.Enabled = true;
                    v49.Rig.Head.EyesFlare.Flames.Enabled = true;
                    v49.Rig.Head.EyesFlare.Shockwave.Enabled = true;
                    v49.Rig.Head.EyesFlare["Small :D"].Enabled = true;
                    v49.Rig.Head.EyesFlare.SmokeBLACK.Enabled = true;
                    v49.Rig.Head.EyesFlare.SmokeRed.Enabled = true;
                end);
                task.delay(1.1, function() --[[ Line: 367 ]]
                    -- upvalues: v49 (copy)
                    v49.Rig.Head.EyesFlare.Big.Enabled = false;
                    v49.Rig.Head.EyesFlare.Flames.Enabled = false;
                    v49.Rig.Head.EyesFlare.Shockwave.Enabled = false;
                    v49.Rig.Head.EyesFlare["Small :D"].Enabled = false;
                    v49.Rig.Head.EyesFlare.SmokeBLACK.Enabled = false;
                    v49.Rig.Head.EyesFlare.SmokeRed.Enabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v49.Animations.UnstableEye:Play(0.175);
                    v5:CreateSpeedMultiplier(v49.Player, 0.01, "UnstableEye", 1.75, true);
                    task.delay(0.9, function() --[[ Line: 384 ]]
                        -- upvalues: v5 (ref), v49 (copy)
                        for _, v51 in pairs(workspace.Players.Survivors:GetChildren()) do
                            v5:RevealPlayerAura(v51, v49.Config.UnstableEyeAuraDuration);
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
        Callback = function(v52) --[[ Line: 400 ]] --[[ Name: Callback ]]
            -- upvalues: v4 (copy), v25 (copy), v5 (copy), l_ReplicatedStorage_0 (copy), v10 (copy)
            if game["Run Service"]:IsServer() then
                v52.AbilitiesDisabled = true;
                v4:Play(v52.Config.Sounds.RejuvenateTheRottenActivate, {
                    Parent = v52.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.75
                });
                local v53 = 0;
                task.delay(1, function() --[[ Line: 409 ]]
                    -- upvalues: v52 (copy), v25 (ref), v4 (ref), v5 (ref), l_ReplicatedStorage_0 (ref), v53 (ref), v10 (ref)
                    local l_PrimaryPart_0 = v52.Rig.PrimaryPart;
                    local l_pairs_0 = pairs;
                    local v56 = v52.KilledLocations or {};
                    for _, v58 in l_pairs_0(v56) do
                        task.spawn(function() --[[ Line: 412 ]]
                            -- upvalues: v52 (ref), v25 (ref), v4 (ref), v5 (ref), v58 (copy), l_PrimaryPart_0 (copy), l_ReplicatedStorage_0 (ref), v53 (ref), v10 (ref)
                            local v59 = nil;
                            if v52.Behavior.GetZombie then
                                v59 = v25("GetZombie", ("%*/Abilities/RejuvenateTheRotten"):format(script.Parent), v52);
                            end;
                            if not v59 or not v52.Behavior.GetZombie then
                                v59 = v52.Config.ZombieTemplate:IsA("Model") and v52.Config.ZombieTemplate:Clone() or v52.Config.ZombieTemplate:GetChildren()[math.random(1, #v52.Config.ZombieTemplate:GetChildren())]:Clone();
                            end;
                            v59:SetAttribute("ExecutionsDisabled", true);
                            v59.Name = "1x1x1x1Zombie";
                            v59.PrimaryPart.Anchored = true;
                            v59.Humanoid.Health = v52.Config.ZombieHealth;
                            v59.Humanoid.EvaluateStateMachine = false;
                            v59.Parent = workspace.Map.Ingame;
                            v25("SummonZombie", ("%*/Abilities/RejuvenateTheRotten"):format(script.Parent), v52, v59);
                            local v60 = v4:Play(v52.Config.Sounds.RejuvenateTheRottenMinionIdle, {
                                Parent = v59.PrimaryPart, 
                                Looped = true, 
                                Volume = 0
                            });
                            game.TweenService:Create(v60, TweenInfo.new(2.5), {
                                Volume = 0.5
                            }):Play();
                            v5:FixCharacter(v59, "Killers");
                            v5:AddHitboxes(v59, "Killers");
                            local v61 = {};
                            for v62, v63 in pairs(v52.Config.ZombieAnimations) do
                                v61[v62] = v5:LoadAnimationFromID(v59, v63);
                            end;
                            v61.Summon:Play(0);
                            v61.Idle:Play(0);
                            v59:SetPrimaryPartCFrame(CFrame.lookAt(v58, (Vector3.new(l_PrimaryPart_0.Position.X, v58.Y, l_PrimaryPart_0.Position.Z))));
                            v4:Play(v52.Config.Sounds.RejuvenateTheRottenRevive, {
                                Parent = v59.PrimaryPart, 
                                PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                Volume = 0.5
                            });
                            task.wait(2.5);
                            v5:RevealPlayerAuraTo(v52.Player, v59, 600, Color3.new(0.5, 0.75, 0.5));
                            local v64 = "";
                            v59.Humanoid.Running:Connect(function(v65) --[[ Line: 462 ]]
                                -- upvalues: v59 (ref), v52 (ref), v64 (ref), v61 (copy)
                                if v65 > 0.01 then
                                    if v59.Humanoid.WalkSpeed == v52.Config.ZombieWalkSpeed and v64 ~= "Walk" then
                                        v61.Walk:Play();
                                        v61.Run:Stop();
                                        return;
                                    elseif v59.Humanoid.WalkSpeed == v52.Config.ZombieSprintSpeed and v64 ~= "Run" then
                                        v61.Walk:Stop();
                                        v61.Run:Play();
                                        return;
                                    end;
                                else
                                    v64 = "";
                                    v61.Walk:Stop();
                                    v61.Run:Stop();
                                end;
                            end);
                            task.spawn(function() --[[ Line: 481 ]]
                                -- upvalues: v52 (ref), v59 (ref), v4 (ref)
                                local l_ZombieSounds_0 = v52.Config.ZombieSounds;
                                if l_ZombieSounds_0 then
                                    local v67 = #l_ZombieSounds_0;
                                    while v59.Parent and v59.PrimaryPart do
                                        v4:Play(l_ZombieSounds_0[math.random(1, v67)], {
                                            Parent = v59.PrimaryPart, 
                                            Volume = 0.4, 
                                            PlaybackSpeed = Random.new():NextNumber(0.8, 2)
                                        });
                                        task.wait(math.random(10, 25));
                                    end;
                                end;
                            end);
                            v59.PrimaryPart.Anchored = false;
                            v59.Humanoid.EvaluateStateMachine = true;
                            task.spawn(function() --[[ Line: 497 ]]
                                -- upvalues: l_ReplicatedStorage_0 (ref), v59 (ref), v52 (ref), v61 (copy), v4 (ref), v5 (ref), v53 (ref), v10 (ref), v60 (copy)
                                local v68 = require(l_ReplicatedStorage_0.Modules.Actors);
                                local v69 = 0;
                                local v70 = math.random(6, 12);
                                local v71 = nil;
                                local v72 = nil;
                                local v73 = require(l_ReplicatedStorage_0.Modules.SimplePath).new(v59);
                                v59:AddTag("Ragdoll");
                                while v59.Parent and v59.PrimaryPart and v59.Humanoid.Health > 0 do
                                    if v71 and v71.PrimaryPart and v71.Humanoid.Health > 0 and not v71:GetAttribute("Undetectable") then
                                        local l_Magnitude_0 = (v71.PrimaryPart.Position - v59.PrimaryPart.Position).Magnitude;
                                        if l_Magnitude_0 <= v52.Config.ZombieAttackRange then
                                            v61.Attack:Play();
                                            v4:Play(v52.Config.Sounds.Swing, {
                                                Parent = v59.PrimaryPart, 
                                                PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                                Volume = 0.25
                                            });
                                            local l_Humanoid_0 = v71:FindFirstChild("Humanoid");
                                            if l_Humanoid_0 then
                                                v4:Play(v52.Config.Sounds.RejuvenateTheRottenMinionHit, {
                                                    Parent = v59.PrimaryPart
                                                });
                                                local l_Health_0 = l_Humanoid_0.Health;
                                                v5:ApplyDamage(v71, v52.Config.ZombieAttackDamage);
                                                if l_Health_0 > 0 and l_Humanoid_0.Health <= 0 then
                                                    v53 = v53 + 1;
                                                    if v53 == 3 then
                                                        v10:IncrementAchievementProgress(v52.Player, "TheWildHunt");
                                                    end;
                                                end;
                                            end;
                                            if v72 and v72.Behavior then
                                                v72.Behavior.AILastSeen = nil;
                                            end;
                                            task.wait(v52.Config.ZombieAttackCooldown);
                                            continue;
                                        elseif v52.Config.ZombieLoseFocusRange <= l_Magnitude_0 then
                                            v71 = nil;
                                            v72 = nil;
                                            v73:Stop();
                                        else
                                            if v72 and v72.Behavior then
                                                v72.Behavior.AILastSeen = tick();
                                            end;
                                            v59.Humanoid.WalkSpeed = v52.Config.ZombieSprintSpeed;
                                            v73:Run(v71.PrimaryPart.Position);
                                        end;
                                    else
                                        v71 = nil;
                                        v72 = nil;
                                        v59.Humanoid.WalkSpeed = v52.Config.ZombieWalkSpeed;
                                    end;
                                    local l_v5_ClosestPlayerFromPosition_0 = v5:GetClosestPlayerFromPosition(v59.PrimaryPart.Position, {
                                        PlayerSelection = "Survivors", 
                                        MaxDistance = v52.Config.ZombieTargetRange
                                    });
                                    if l_v5_ClosestPlayerFromPosition_0 then
                                        v71 = l_v5_ClosestPlayerFromPosition_0;
                                        local l_PlayerFromCharacter_0 = game.Players:GetPlayerFromCharacter(l_v5_ClosestPlayerFromPosition_0);
                                        v72 = l_PlayerFromCharacter_0 and v68.CurrentActors[l_PlayerFromCharacter_0];
                                    end;
                                    if v70 <= v69 then
                                        v69 = 0;
                                        v70 = math.random(6, 12);
                                        v59.Humanoid:MoveTo(v59.PrimaryPart.Position + Vector3.new(math.random(-80, 80), 0, math.random(-80, 80)));
                                    end;
                                    v59.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true);
                                    v59.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false);
                                    v59.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
                                    v69 = v69 + game["Run Service"].Heartbeat:Wait();
                                end;
                                if v60 and v60.Parent then
                                    game.TweenService:Create(v60, TweenInfo.new(0.8), {
                                        PlaybackSpeed = 0
                                    }):Play();
                                end;
                                if v73 then
                                    v73:Destroy();
                                end;
                            end);
                        end);
                    end;
                end);
                task.delay(4.25, function() --[[ Line: 604 ]]
                    -- upvalues: v52 (copy)
                    v52.AbilitiesDisabled = false;
                end);
                task.delay(0.98, function() --[[ Line: 609 ]]
                    -- upvalues: v52 (copy), v4 (ref)
                    v52.Rig.Head.EyesFlare.Big.Enabled = true;
                    v52.Rig.Head.EyesFlare.Flames.Enabled = true;
                    v52.Rig.Head.EyesFlare.Shockwave.Enabled = true;
                    v52.Rig.Head.EyesFlare["Small :D"].Enabled = true;
                    v52.Rig.Head.EyesFlare.SmokeBLACK.Enabled = true;
                    v52.Rig.Head.EyesFlare.SmokeRed.Enabled = true;
                    for v79 = 1, 6 do
                        v52.Rig.HumanoidRootPart["Chain" .. v79]["Chain" .. v79].Enabled = true;
                        v4:Play(v52.Config.Sounds.Chains, {
                            Parent = v52.Rig.PrimaryPart, 
                            PlaybackSpeed = 0.75, 
                            Volume = 0.1
                        });
                    end;
                end);
                task.delay(1.35, function() --[[ Line: 623 ]]
                    -- upvalues: v52 (copy)
                    v52.Rig.Torso.Blood.Blood.Enabled = false;
                    v52.Rig.Head.EyesFlare.Big.Enabled = false;
                    v52.Rig.Head.EyesFlare.Flames.Enabled = false;
                    v52.Rig.Head.EyesFlare.Shockwave.Enabled = false;
                    v52.Rig.Head.EyesFlare["Small :D"].Enabled = false;
                    v52.Rig.Head.EyesFlare.SmokeBLACK.Enabled = false;
                    v52.Rig.Head.EyesFlare.SmokeRed.Enabled = false;
                end);
                task.delay(1.98, function() --[[ Line: 633 ]]
                    -- upvalues: v52 (copy)
                    v52.Rig.HumanoidRootPart["Chain" .. 1]["Chain" .. 1].Enabled = false;
                    v52.Rig.HumanoidRootPart["Chain" .. 2]["Chain" .. 2].Enabled = false;
                    v52.Rig.HumanoidRootPart["Chain" .. 3]["Chain" .. 3].Enabled = false;
                    v52.Rig.HumanoidRootPart["Chain" .. 4]["Chain" .. 4].Enabled = false;
                    v52.Rig.HumanoidRootPart["Chain" .. 5]["Chain" .. 5].Enabled = false;
                    v52.Rig.HumanoidRootPart["Chain" .. 6]["Chain" .. 6].Enabled = false;
                end);
                task.delay(2.1, function() --[[ Line: 639 ]]

                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v52.Animations.RejuvenateTheRotten:Play(0.175);
                    v5:CreateSpeedMultiplier(v52.Player, 0.01, "RejuvenateTheRotten", 3.75, true);
                end;
                return;
            end;
        end
    }
};
v3.Created = function(_, v81) --[[ Line: 655 ]] --[[ Name: Created ]]
    -- upvalues: v9 (copy), v8 (copy), l_ReplicatedStorage_0 (copy)
    if game["Run Service"]:IsServer() then
        v9:SetConnection("Entangled", "REMOTE_EVENT", function(v82) --[[ Line: 658 ]]
            -- upvalues: v8 (ref), v81 (copy)
            if v82.Character and v82.Character:GetAttribute("Entangled") then
                v82.Character:SetAttribute("Entangled", false);
                v8:RemoveStatus(v82, "Slowness");
                v8:ApplyStatus(v82.Character, "Speed", {
                    Duration = v81.Config.EntanglementSurvivorSpeedBuffDuration, 
                    Level = 1, 
                    Instant = true
                });
            end;
        end);
        v81.KilledLocations = {};
        local function v86(v83) --[[ Line: 670 ]] --[[ Name: setDeathConnection ]]
            -- upvalues: v81 (copy)
            local l_Humanoid_1 = v83:FindFirstChild("Humanoid");
            local l_PrimaryPart_1 = v83.PrimaryPart;
            if l_Humanoid_1 and l_PrimaryPart_1 then
                l_Humanoid_1.Died:Once(function() --[[ Line: 674 ]]
                    -- upvalues: v81 (ref), l_PrimaryPart_1 (copy)
                    v81:IncrementCharges("RejuvenateTheRotten", 1, 1);
                    table.insert(v81.KilledLocations, l_PrimaryPart_1.Position);
                end);
            end;
        end;
        for _, v88 in pairs(workspace.Players.Survivors:GetChildren()) do
            local l_Humanoid_2 = v88:FindFirstChild("Humanoid");
            local l_PrimaryPart_2 = v88.PrimaryPart;
            if l_Humanoid_2 and l_PrimaryPart_2 then
                l_Humanoid_2.Died:Once(function() --[[ Line: 674 ]]
                    -- upvalues: v81 (copy), l_PrimaryPart_2 (copy)
                    v81:IncrementCharges("RejuvenateTheRotten", 1, 1);
                    table.insert(v81.KilledLocations, l_PrimaryPart_2.Position);
                end);
            end;
        end;
        local v91 = nil;
        v91 = workspace.Players.Survivors.ChildAdded:Connect(v86);
        v81.Rig.AncestryChanged:Connect(function(_, v93) --[[ Line: 688 ]]
            -- upvalues: v91 (ref)
            if not v93 then
                v91:Disconnect();
                v91 = nil;
            end;
        end);
        if not v81.Config.HighlightDisabled then
            local l_Highlight_0 = Instance.new("Highlight");
            l_Highlight_0.DepthMode = Enum.HighlightDepthMode.Occluded;
            l_Highlight_0.Parent = v81.Rig;
            for v95, v96 in pairs(v81.Config.HighlightProperties) do
                l_Highlight_0[v95] = v96;
            end;
        end;
        v81:SetCooldownOf("UnstableEye", v81.Config.UnstableEyeCooldown / 2);
        return;
    else
        if game["Run Service"]:IsClient() then
            v9:SetConnection("Entangled", "REMOTE_EVENT", function() --[[ Line: 707 ]]
                -- upvalues: l_ReplicatedStorage_0 (ref), v81 (copy), v9 (ref)
                task.spawn(function() --[[ Line: 709 ]]
                    -- upvalues: l_ReplicatedStorage_0 (ref)
                    require(l_ReplicatedStorage_0.Systems.Player.Game.SmoothShiftLock):ToggleShiftLock(false);
                end);
                local l_PopupsFolder_0 = v81.Config.PopupsFolder;
                local v98 = {};
                for _ = 1, v81.Config.EntanglementPopupCount do
                    local l_l_PopupsFolder_0_Children_0 = l_PopupsFolder_0:GetChildren();
                    table.insert(v98, l_l_PopupsFolder_0_Children_0[math.random(1, #l_l_PopupsFolder_0_Children_0)]:Clone());
                end;
                for _, v102 in pairs(v98) do
                    local l_TemporaryUI_0 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("TemporaryUI");
                    v102.Name = "1x1x1x1Popup";
                    v102.Selectable = false;
                    v102.Position = UDim2.fromScale(0.5, 0.5) + UDim2.fromScale(math.random(-100, 100) / 500, math.random(-100, 100) / 400);
                    v102.Parent = l_TemporaryUI_0;
                    v102.MouseButton1Click:Connect(function() --[[ Line: 733 ]]
                        -- upvalues: v102 (copy), l_TemporaryUI_0 (copy), v9 (ref)
                        v102.Name = "aaaahhhh";
                        v102:Destroy();
                        local l_pairs_1 = pairs;
                        local v105 = l_TemporaryUI_0 and l_TemporaryUI_0:GetChildren() or {};
                        for _, v107 in l_pairs_1(v105) do
                            if v107.Name == "1x1x1x1Popup" then
                                return;
                            end;
                        end;
                        v9:FireServerConnection("Entangled", "REMOTE_EVENT");
                    end);
                end;
                if require(l_ReplicatedStorage_0.Modules.Device):GetPlayerDevice() == "Console" then
                    local l_TemporaryUI_1 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("TemporaryUI");
                    local v109 = script.ConsoleThing:Clone();
                    v109.Parent = l_TemporaryUI_1;
                    game.TweenService:Create(v109, TweenInfo.new(2.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                        TextTransparency = 1, 
                        TextStrokeTransparency = 1
                    }):Play();
                    game.Debris:AddItem(v109, 2.5);
                    local l_Humanoid_3 = game.Players.LocalPlayer.Character.Humanoid;
                    local v111 = 0;
                    local v112 = nil;
                    do
                        local l_v111_0, l_v112_0 = v111, v112;
                        l_v112_0 = l_Humanoid_3:GetPropertyChangedSignal("Jump"):Connect(function() --[[ Line: 758 ]]
                            -- upvalues: l_v111_0 (ref), l_TemporaryUI_1 (copy), v9 (ref), l_v112_0 (ref)
                            l_v111_0 = l_v111_0 + 1;
                            if l_v111_0 % 3 == 0 then
                                for _, v116 in pairs(l_TemporaryUI_1:GetChildren()) do
                                    if v116.Name == "1x1x1x1Popup" then
                                        v116.Name = "aaaahhhh";
                                        v116:Destroy();
                                        local l_pairs_2 = pairs;
                                        local v118 = l_TemporaryUI_1 and l_TemporaryUI_1:GetChildren() or {};
                                        for _, v120 in l_pairs_2(v118) do
                                            if v120.Name == "1x1x1x1Popup" then
                                                return;
                                            end;
                                        end;
                                        v9:FireServerConnection("Entangled", "REMOTE_EVENT");
                                        l_v112_0:Disconnect();
                                        l_v112_0 = nil;
                                    end;
                                end;
                            end;
                            local v121 = false;
                            for _, v123 in pairs(l_TemporaryUI_1:GetChildren()) do
                                if v123.Name == "1x1x1x1Popup" then
                                    if not v123:GetAttribute("OrigSize") then
                                        v123:SetAttribute("OrigSize", v123.Size);
                                    end;
                                    local l_v123_Attribute_0 = v123:GetAttribute("OrigSize");
                                    v123.Size = l_v123_Attribute_0 + (not v121 and UDim2.fromScale(0.05, 0.05) or UDim2.fromScale(0.015, 0.015));
                                    game.TweenService:Create(v123, TweenInfo.new(0.1), {
                                        Size = l_v123_Attribute_0
                                    }):Play();
                                    v121 = true;
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
v3.OnIntroduction = function(_, v126, v127, v128) --[[ Line: 797 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v11 (copy), v5 (copy)
    v11:SetCustomLighting(v126.Config.IntroLighting);
    local v129 = v126.Config.IntroHeadTemplate:Clone();
    v129:SetPrimaryPartCFrame(v127:WaitForChild("Right Arm").CFrame * CFrame.Angles(0, 0, 3.141592653589793) * CFrame.new(0, 0.9, 0.1));
    v129.ArmWeld.Part0 = v127:WaitForChild("Right Arm");
    v129.Parent = workspace;
    game.Debris:AddItem(v129, 5);
    task.delay(0.92, function() --[[ Line: 807 ]]
        -- upvalues: v129 (copy)
        local l_Root_0 = v129:FindFirstChild("Root");
        local v131 = l_Root_0 and l_Root_0:FindFirstChild("Blood");
        if v131 then
            v131:Emit(30);
        end;
    end);
    task.delay(0.94, function() --[[ Line: 815 ]]
        -- upvalues: v127 (copy)
        v127.Head.EyesFlare.Big.Enabled = true;
        v127.Head.EyesFlare.Flames.Enabled = true;
        v127.Head.EyesFlare.Shockwave.Enabled = true;
        v127.Head.EyesFlare["Small :D"].Enabled = true;
        v127.Head.EyesFlare.SmokeBLACK.Enabled = true;
        v127.Head.EyesFlare.SmokeRed.Enabled = true;
    end);
    task.delay(0.966, function() --[[ Line: 825 ]]
        -- upvalues: v129 (copy)
        v129.Head:Destroy();
        v129.Hair:Destroy();
    end);
    task.delay(1.2, function() --[[ Line: 831 ]]
        -- upvalues: v127 (copy)
        v127.Head.EyesFlare.Big.Enabled = false;
        v127.Head.EyesFlare.Flames.Enabled = false;
        v127.Head.EyesFlare.Shockwave.Enabled = false;
        v127.Head.EyesFlare["Small :D"].Enabled = false;
        v127.Head.EyesFlare.SmokeBLACK.Enabled = false;
        v127.Head.EyesFlare.SmokeRed.Enabled = false;
    end);
    v5:CreateFOVMultiplier(game.Players.LocalPlayer, 0.6, "1x1x1x1IntroScene", v128);
    task.delay(v128, function() --[[ Line: 844 ]]
        -- upvalues: v11 (ref)
        v11:SetAsCurrentLighting();
    end);
end;
v3.OnKill = function(v132, v133) --[[ Line: 849 ]] --[[ Name: OnKill ]]
    -- upvalues: v10 (copy)
    if v133.Name == "Shedletsky" then
        v10:IncrementAchievementProgress(v132.Player, "1x1x1x1Hunt");
    end;
end;
v3.OnExecution = function(_, v135, v136) --[[ Line: 855 ]] --[[ Name: OnExecution ]]
    local l_Sword_0 = v136:FindFirstChild("Sword");
    local l_Humanoid_4 = v136:FindFirstChild("Humanoid");
    local l_Head_0 = v136:FindFirstChild("Head");
    local v140 = require(game.ReplicatedStorage.Modules.Ragdolls);
    if v136.Name == "Shedletsky" then
        l_Sword_0.Transparency = 0;
        local _ = workspace:GetServerTimeNow() + 3.23;
        task.delay(3.23, function() --[[ Line: 865 ]]
            -- upvalues: l_Humanoid_4 (copy), v140 (copy), v136 (copy), l_Head_0 (copy)
            if l_Humanoid_4 then
                v140.AddProfile(v136, {
                    Velocity = Vector3.new(0, 50, 0, 0), 
                    KillEffects = {
                        HeadSquash = true
                    }
                });
                l_Humanoid_4.Health = 0;
                local l_ipairs_0 = ipairs;
                local v143 = v136 and v136:GetChildren() or {};
                for _, v145 in l_ipairs_0(v143) do
                    if v145:IsA("Accessory") then
                        v145:Destroy();
                    end;
                end;
                if l_Head_0 then
                    l_Head_0:Destroy();
                end;
            end;
        end);
        return;
    else
        local _ = workspace:GetServerTimeNow() + 2;
        task.delay(2, function() --[[ Line: 884 ]]
            -- upvalues: v135 (copy), l_Humanoid_4 (copy), v140 (copy), v136 (copy)
            local l_FirstChild_0 = v135.Rig["Left Arm"]:FindFirstChild("Blood", true);
            if l_FirstChild_0 then
                l_FirstChild_0.Enabled = true;
                task.delay(0.2, function() --[[ Line: 888 ]]
                    -- upvalues: l_FirstChild_0 (copy)
                    l_FirstChild_0.Enabled = false;
                end);
            end;
            if l_Humanoid_4 then
                v140.AddProfile(v136, {
                    Velocity = v135.Rig.PrimaryPart.CFrame.LookVector.Unit * 35, 
                    KillEffects = {
                        HeadSquash = true
                    }
                });
                l_Humanoid_4.Health = 0;
            end;
        end);
        return;
    end;
end;
v3.OnVictory = function(_, v149, v150, v151, v152) --[[ Line: 902 ]] --[[ Name: OnVictory ]]
    -- upvalues: v11 (copy), v5 (copy), l_TweenService_0 (copy), l_RunService_0 (copy)
    local l_LocalPlayer_0 = game.Players.LocalPlayer;
    if v149 == "Start" then
        v11:SetCustomLighting(v150.Config.OutroLighting);
        local v154 = tick();
        local l_OutroVFXFolder_0 = v150.Config.OutroVFXFolder;
        local _ = v150.Cache.VictoryKillerTrack;
        local l_VictoryCameraTrack_0 = v150.Cache.VictoryCameraTrack;
        local v158 = {};
        task.spawn(function() --[[ Line: 915 ]]
            -- upvalues: l_OutroVFXFolder_0 (copy), v151 (copy), v158 (copy), l_VictoryCameraTrack_0 (copy), v5 (ref), v154 (copy), l_TweenService_0 (ref)
            local v159 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 5);
            if v159 then
                for _, v161 in ipairs(l_OutroVFXFolder_0:GetChildren()) do
                    if v161:IsA("Attachment") then
                        warn("caching", v161.Name);
                        local l_v161_Attribute_0 = v161:GetAttribute("adornee");
                        local l_v161_Attribute_1 = v161:GetAttribute("dummyName");
                        local v164 = l_v161_Attribute_1 and v159.Dummies[l_v161_Attribute_1] or v151;
                        local v165 = v161:Clone();
                        v165.Parent = v164[l_v161_Attribute_0];
                        v158[v161.Name] = v165;
                    end;
                end;
                l_VictoryCameraTrack_0:GetMarkerReachedSignal("emit"):Connect(function(v166) --[[ Line: 933 ]]
                    -- upvalues: v158 (ref), v5 (ref)
                    assert(v158[v166], (("No attachment called %* in VFX folder."):format(v166)));
                    v5:EmitParticles(v158[v166]);
                end);
                local v167 = tick() - v154;
                local l_Shockwave_0 = v159.Shockwave;
                task.delay(math.max(0.1, 1.1 - v167), function() --[[ Line: 942 ]]
                    -- upvalues: l_TweenService_0 (ref), l_Shockwave_0 (copy), v159 (copy)
                    local v169 = l_TweenService_0:Create(l_Shockwave_0.Root, TweenInfo.new(0.4), {
                        CFrame = v159.ShockwaveHitPoint.CFrame
                    });
                    v169:Play();
                    v169.Completed:Wait();
                    local v170 = 0.02;
                    while l_Shockwave_0 and l_Shockwave_0.Parent do
                        l_Shockwave_0:PivotTo(l_Shockwave_0:GetPivot() * CFrame.new(0, 0, v170 * -70));
                        v170 = task.wait();
                    end;
                end);
            end;
        end);
        task.spawn(function() --[[ Line: 958 ]]
            -- upvalues: l_TweenService_0 (ref)
            local v171 = game.Lighting:WaitForChild("1xCC", 5);
            if v171 then
                l_TweenService_0:Create(v171, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Saturation = 0.125
                }):Play();
                task.wait(2.8);
                l_TweenService_0:Create(v171, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Contrast = 0.2, 
                    Brightness = 0.04, 
                    TintColor = Color3.new(0.666667, 1, 0.717647)
                }):Play();
                task.wait(0.2);
                l_TweenService_0:Create(v171, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Contrast = 0, 
                    Brightness = 0.04, 
                    Saturation = 0.4, 
                    TintColor = Color3.new(1, 0.309804, 0.309804)
                }):Play();
                task.wait(0.2);
                l_TweenService_0:Create(v171, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Contrast = 0, 
                    Brightness = 0, 
                    Saturation = 0, 
                    TintColor = Color3.new(1, 1, 1)
                }):Play();
                task.wait(1.3);
                l_TweenService_0:Create(v171, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Contrast = 0.1, 
                    Brightness = -0.1
                }):Play();
                task.wait(0.3);
                l_TweenService_0:Create(v171, TweenInfo.new(1.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    Contrast = 0.3, 
                    Brightness = 0.2, 
                    Saturation = 0.3, 
                    TintColor = Color3.new(0.721569, 1, 0.752941)
                }):Play();
            end;
        end);
        local l_CurrentCamera_0 = workspace.CurrentCamera;
        l_LocalPlayer_0:SetAttribute("FOVMultipliersDisabled", true);
        l_RunService_0:BindToRenderStep("1x1x1x1Outro", 1, function() --[[ Line: 1003 ]]
            -- upvalues: l_CurrentCamera_0 (copy)
            l_CurrentCamera_0.FieldOfView = 50;
        end);
        v5:PlayDummyCutsceneAnimations(v150, v152, "Victory");
        return;
    else
        l_RunService_0:UnbindFromRenderStep("1x1x1x1Outro");
        l_LocalPlayer_0:SetAttribute("FOVMultipliersDisabled", nil);
        v11:SetAsCurrentLighting();
        return;
    end;
end;
return v3;