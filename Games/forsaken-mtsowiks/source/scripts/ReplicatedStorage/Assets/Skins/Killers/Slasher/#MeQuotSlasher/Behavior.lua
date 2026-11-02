-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:08:22 2025 ]]
local _ = require(game.ReplicatedStorage.GlobalTypes);
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local l_Players_0 = game:GetService("Players");
local l_Debris_0 = game:GetService("Debris");
local _ = game:GetService("Lighting");
local v7 = require(l_ReplicatedStorage_0.Modules.Sounds);
local v8 = require(l_ReplicatedStorage_0.Modules.Actors);
local v9 = require(l_ReplicatedStorage_0.Modules.Ragdolls);
local v10 = require(l_ReplicatedStorage_0.Modules.Schematics.Lighting);
local v11 = require(l_ReplicatedStorage_0.Modules.Util);
local v12 = require(l_ReplicatedStorage_0.Systems.Character.Game.Sprinting);
local v13 = require(l_ReplicatedStorage_0.Modules.Hitboxes);
local v14 = require(l_ReplicatedStorage_0.Modules.Misc.Maid);
local v15 = require(l_ReplicatedStorage_0.Modules.Statuses);
local v16 = require(l_ReplicatedStorage_0.Modules.Network);
local v17 = require(l_ReplicatedStorage_0.Modules.AchievementUtil);
local _ = math.random;
local l_insert_0 = table.insert;
local l_sort_0 = table.sort;
local l_wait_0 = task.wait;
local l_spawn_0 = task.spawn;
local l_delay_0 = task.delay;
local l_close_0 = coroutine.close;
local v25 = l_RunService_0:IsClient();
local v26 = l_RunService_0:IsServer();
local v27 = l_RunService_0:IsStudio();
local v28 = TweenInfo.new(1);
local v29 = Random.new();
local v30 = TweenInfo.new(0.2);
local v31 = v25 and l_Players_0.LocalPlayer;
local v32 = v25 and workspace.CurrentCamera;
local function _(v33) --[[ Line: 44 ]] --[[ Name: __displayWarn ]]
    -- upvalues: v27 (copy)
    if v27 then
        warn((("[Slasher]: %*"):format(v33)));
    end;
end;
local function v40(v35, v36, ...) --[[ Line: 58 ]] --[[ Name: __pcallMethod ]]
    -- upvalues: v27 (copy)
    assert(v35, "bad moduleInfo, must be a table");
    local l_status_0, l_result_0 = pcall(function(...) --[[ Line: 61 ]]
        -- upvalues: v35 (copy), v36 (copy)
        if v35[v36] then
            return v35[v36](...);
        else
            return;
        end;
    end, ...);
    if not l_status_0 then
        local v39 = ("Failed to call :%*() due to: %*"):format(v36, l_result_0);
        if v27 then
            warn((("[Slasher]: %*"):format(v39)));
        end;
    end;
    return l_status_0, l_result_0;
end;
local function _(v41, v42, v43) --[[ Line: 74 ]] --[[ Name: __getEnragedStat ]]
    return v41.State.isEnraged and v41.Config[("Enraged%*%*"):format(v42, v43)] or v41.Config[("%*%*"):format(v42, v43)];
end;
local _ = function(v45) --[[ Line: 81 ]] --[[ Name: __getDictionaryIndexes ]]
    -- upvalues: l_insert_0 (copy)
    local v46 = {};
    for v47, _ in pairs(v45) do
        l_insert_0(v46, v47);
    end;
    return v46;
end;
local function v53(v50, v51, v52) --[[ Line: 92 ]] --[[ Name: __playSound ]]
    -- upvalues: v7 (copy), v29 (copy)
    assert(v50.Config.Sounds[v51], "bad soundName, does not exist");
    return v7:Play(v50.Config.Sounds[v51], {
        Parent = v50.Rig.PrimaryPart, 
        PlaybackSpeed = v29:NextNumber(0.975, 1.025), 
        Looped = v52 or false, 
        Volume = 0.25
    });
end;
local function v60(v54) --[[ Line: 106 ]] --[[ Name: __resetEnragedState ]]
    -- upvalues: v26 (copy), v11 (copy), v15 (copy), v7 (copy), v40 (copy), v16 (copy), v25 (copy), l_TweenService_0 (copy), v28 (copy), l_Debris_0 (copy), v12 (copy)
    local l_Rig_0 = v54.Rig;
    if v54.State.isEnraged and l_Rig_0 and l_Rig_0.Parent then
        v54.State.isEnraged = false;
        if v26 then
            v11:RemoveInvincible(l_Rig_0, "Raging");
            v54:ChangeExpression("Default");
            v15:RemoveStatus(v54.Rig, "Invisibility");
            v15:ApplyStatus(v54.Rig, "Slowness", {
                Level = 4, 
                Duration = 1
            });
            v15:ApplyStatus(v54.Rig, "Helpless", {
                Level = 1, 
                Duration = 2
            });
            local l_EnragedSFX_0 = v54.Instances.EnragedSFX;
            if l_EnragedSFX_0 then
                l_EnragedSFX_0:Destroy();
                v54.Instances.EnragedSFX = nil;
            end;
            v7:Play(v54.Config.Sounds.EnragedEnd, {
                Parent = v54.Rig.PrimaryPart
            });
            for _, v58 in v54.Instances.EnragedVisuals do
                v58.Enabled = false;
            end;
            v40(v54.Behavior, "EnragedEnd", v54.Behavior, v54);
            v16:FireClientConnection(v54.Player, ("%*EnrageStateAsync"):format(v54.Player.Name), "REMOTE_EVENT");
            return;
        elseif v25 then
            v54.AnimationType = nil;
            v54.MovementAnimSpeed = nil;
            v16:FireConnection("DisableSprinting", "ENRAGED", false);
            if v54.Meta.TargetedPlayer then
                v11:RevealPlayerAura(v54.TargetedPlayer, v54.Config.EnragedAuraLingerTime);
                v54.Meta.TargetedPlayer = nil;
            end;
            if v54.Instances.SpeedModifier then
                l_TweenService_0:Create(v54.Instances.SpeedModifier, v28, {
                    Value = 1
                }):Play();
                l_Debris_0:AddItem(v54.Instances.SpeedModifier, 1);
            end;
            local l_v11_SpeedMultiplier_0 = v11:CreateSpeedMultiplier(v54.Rig, 0.001, "Pacified");
            l_TweenService_0:Create(l_v11_SpeedMultiplier_0, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Value = 1
            }):Play();
            l_Debris_0:AddItem(l_v11_SpeedMultiplier_0, 1);
            v12.StaminaCap = nil;
        end;
    end;
end;
return {
    Abilities = {
        Slash = {
            LayoutOrder = 1, 
            Icon = "rbxassetid://97183429269286", 
            KeybindType = "MainAbility", 
            Cooldown = function(v61, v62) --[[ Line: 179 ]] --[[ Name: Cooldown ]]
                return v61.State.isEnraged and v61.Config[("Enraged%*Cooldown"):format(v62)] or v61.Config[("%*Cooldown"):format(v62)];
            end, 
            Callback = function(v63) --[[ Line: 180 ]] --[[ Name: Callback ]]
                -- upvalues: v26 (copy), v53 (copy), l_delay_0 (copy), v11 (copy), l_TweenService_0 (copy), v28 (copy), l_Debris_0 (copy), l_wait_0 (copy), v60 (copy), v13 (copy), v15 (copy), v40 (copy), v25 (copy)
                if v26 then
                    local l_Rig_1 = v63.Rig;
                    v63.AbilitiesDisabled = true;
                    v53(v63, "Swing");
                    local _ = v63.State.isEnraged;
                    if not v63.State.isEnraged or not v63.Config.EnragedSlashDamage then
                        local _ = v63.Config.SlashDamage;
                    end;
                    l_delay_0(0.075, function() --[[ Line: 192 ]]
                        -- upvalues: v63 (copy), v11 (ref), l_Rig_1 (copy), l_TweenService_0 (ref), v28 (ref), l_Debris_0 (ref), l_wait_0 (ref), v60 (ref)
                        if v63.State.isEnraged then
                            local v67 = v11:ApplyVelocity(l_Rig_1.PrimaryPart, v63.Config.EnragedSlashLungeForce);
                            l_TweenService_0:Create(v67, v28, {
                                LineVelocity = v67.LineVelocity / 100
                            }):Play();
                            l_Debris_0:AddItem(v67, 0.6);
                        end;
                        l_wait_0(0.5);
                        v60(v63);
                        l_wait_0(0.275);
                        v63.AbilitiesDisabled = false;
                    end);
                    l_delay_0(v63.Config.SlashWindup, function() --[[ Line: 210 ]]
                        -- upvalues: v13 (ref), v63 (copy), v11 (ref), v15 (ref), v40 (ref), v53 (ref)
                        local l_v13_0 = v13;
                        local l_Player_0 = v63.Player;
                        local v70 = {
                            Size = Vector3.new(4.5, 6, 7.5, 0), 
                            CFrameOffset = CFrame.new(0, 0, -1.25)
                        };
                        local l_v63_0 = v63;
                        v70.Damage = l_v63_0.State.isEnraged and l_v63_0.Config.EnragedSlashDamage or l_v63_0.Config.SlashDamage;
                        v70.Time = v63.Config.SlashLinger;
                        v70.Knockback = 2;
                        v70.HitMultiple = true;
                        v70.ExecuteOnKill = true;
                        v70.Connections = {
                            Hit = function(v72, v73) --[[ Line: 222 ]] --[[ Name: Hit ]]
                                -- upvalues: v11 (ref), v15 (ref), v40 (ref), v63 (ref), v53 (ref)
                                v11:CreateSpeedMultiplier(v72, 1.5, "HitSpeedBonus", 1.25);
                                v15:ApplyStatus(v72, "Bleeding", {
                                    Level = 1, 
                                    Duration = 5
                                });
                                if v73 then
                                    v40(v63.Behavior, "OnSlashHit", v63.Behavior, v72);
                                    v53(v63, "Hit");
                                end;
                            end
                        };
                        l_v13_0 = l_v13_0:CreateHitbox(l_Player_0, v70);
                    end);
                    return;
                else
                    if v25 then
                        v63.Animations.Slash:Play(0.025);
                    end;
                    return;
                end;
            end
        }, 
        Behead = {
            LayoutOrder = 2, 
            Icon = "rbxassetid://115283980500353", 
            KeybindType = "AltAbility1", 
            Cooldown = function(v74, v75) --[[ Line: 244 ]] --[[ Name: Cooldown ]]
                return v74.State.isEnraged and v74.Config[("Enraged%*Cooldown"):format(v75)] or v74.Config[("%*Cooldown"):format(v75)];
            end, 
            Callback = function(v76) --[[ Line: 245 ]] --[[ Name: Callback ]]
                -- upvalues: v26 (copy), v53 (copy), l_delay_0 (copy), v13 (copy), v17 (copy), v8 (copy), v11 (copy), v15 (copy), v60 (copy), l_wait_0 (copy), v25 (copy), l_TweenService_0 (copy), l_Debris_0 (copy)
                if v26 then
                    local l_Rig_2 = v76.Rig;
                    v76.AbilitiesDisabled = true;
                    v53(v76, "Swing");
                    for _, v79 in pairs(v76.Rig:GetChildren()) do
                        if v79.Name:find("Machete") and not v79:GetAttribute("Ignored") then
                            v79.Transparency = 0;
                        end;
                    end;
                    for _, v81 in pairs(v76.Rig.Machete:GetChildren()) do
                        if v81:IsA("ParticleEmitter") or v81:IsA("Light") or v81:IsA("Highlight") then
                            v81.Enabled = true;
                        end;
                    end;
                    for _, v83 in pairs(v76.Rig:GetChildren()) do
                        if v83.Name:find("BackDagger") and not v83:GetAttribute("Ignored") then
                            v83.Transparency = 1;
                        end;
                    end;
                    for _, v85 in pairs(v76.Rig.BackDagger:GetChildren()) do
                        if v85:IsA("ParticleEmitter") or v85:IsA("Light") or v85:IsA("Highlight") then
                            v85.Enabled = false;
                        end;
                    end;
                    task.delay(2, function() --[[ Line: 277 ]]
                        -- upvalues: v76 (copy)
                        for _, v87 in pairs(v76.Rig:GetChildren()) do
                            if v87.Name:find("Machete") and not v87:GetAttribute("Ignored") then
                                v87.Transparency = 1;
                            end;
                        end;
                        for _, v89 in pairs(v76.Rig.Machete:GetChildren()) do
                            if v89:IsA("ParticleEmitter") or v89:IsA("Light") or v89:IsA("Highlight") then
                                v89.Enabled = false;
                            end;
                        end;
                        for _, v91 in pairs(v76.Rig:GetChildren()) do
                            if v91.Name:find("BackDagger") and not v91:GetAttribute("Ignored") then
                                v91.Transparency = 0;
                            end;
                        end;
                        for _, v93 in pairs(v76.Rig.BackDagger:GetChildren()) do
                            if v93:IsA("ParticleEmitter") or v93:IsA("Light") or v93:IsA("Highlight") then
                                v93.Enabled = true;
                            end;
                        end;
                    end);
                    l_delay_0(v76.Config.BeheadWindup, function() --[[ Line: 304 ]]
                        -- upvalues: v13 (ref), v76 (copy), v17 (ref), v8 (ref), v11 (ref), v15 (ref), v53 (ref), v60 (ref), l_wait_0 (ref), l_Rig_2 (copy)
                        local l_v13_1 = v13;
                        local l_Player_1 = v76.Player;
                        local v96 = {
                            Size = Vector3.new(8, 2, 7, 0), 
                            CFrameOffset = CFrame.new(0, 0, -2)
                        };
                        local l_v76_0 = v76;
                        v96.Damage = l_v76_0.State.isEnraged and l_v76_0.Config.EnragedBeheadDamage or l_v76_0.Config.BeheadDamage;
                        v96.Time = v76.Config.BeheadLinger;
                        v96.Knockback = 2;
                        v96.HitMultiple = true;
                        v96.DeathProfile = {
                            KillEffects = {
                                Decapitate = true
                            }
                        };
                        v96.Connections = {
                            Hit = function(v98, v99) --[[ Line: 316 ]] --[[ Name: Hit ]]
                                -- upvalues: v17 (ref), v76 (ref), v8 (ref), v11 (ref), v15 (ref), v53 (ref), v60 (ref)
                                local l_Humanoid_0 = v98:FindFirstChildOfClass("Humanoid");
                                if l_Humanoid_0 and l_Humanoid_0.Health <= 0 then
                                    v17:IncrementAchievementProgress(v76.Player, "JasonBrutality");
                                    if v98.Parent.Name == "Survivors" then
                                        v8:IncrementActorStats(v76.Player, {
                                            Action = "Killed a Survivor with Behead", 
                                            RewardType = "DifficultKillerAction"
                                        });
                                    end;
                                else
                                    v11:CreateSpeedMultiplier(v98, 1.5, "HitSpeedBonus", 0.9);
                                    v15:ApplyStatus(v98, "Helpless", {
                                        Level = 1, 
                                        Duration = 8
                                    });
                                    v15:ApplyStatus(v98, "Bleeding", {
                                        Level = 1, 
                                        Duration = 8
                                    });
                                    if v98.Parent.Name == "Survivors" then
                                        v8:IncrementActorStats(v76.Player, {
                                            Action = "Landed Behead hit", 
                                            RewardType = "EasyKillerAction"
                                        });
                                    end;
                                end;
                                if v99 then
                                    v53(v76, "Hit");
                                    v60(v76);
                                end;
                            end
                        };
                        l_v13_1:CreateHitbox(l_Player_1, v96);
                        l_wait_0(0.2);
                        v60(v76);
                        v15:ApplyStatus(l_Rig_2, "Slowness", {
                            Level = 5, 
                            Duration = 2
                        });
                        l_wait_0(1.1);
                        v76.AbilitiesDisabled = false;
                    end);
                    return;
                else
                    if v25 then
                        v76.Animations.Behead:Play(0.025);
                        local l_v11_SpeedMultiplier_1 = v11:CreateSpeedMultiplier(v76.Rig, 1.5, "BeheadAbility");
                        l_TweenService_0:Create(l_v11_SpeedMultiplier_1, TweenInfo.new(0.5), {
                            Value = v76.State.isEnraged and v76.Config.EnragedBeheadLunge or v76.Config.BeheadLunge
                        }):Play();
                        l_delay_0(0.5, function() --[[ Line: 379 ]]
                            -- upvalues: l_TweenService_0 (ref), l_v11_SpeedMultiplier_1 (copy), l_wait_0 (ref), l_Debris_0 (ref)
                            l_TweenService_0:Create(l_v11_SpeedMultiplier_1, TweenInfo.new(0.3), {
                                Value = 0.2
                            }):Play();
                            l_wait_0(0.6);
                            l_TweenService_0:Create(l_v11_SpeedMultiplier_1, TweenInfo.new(0.3), {
                                Value = 1
                            }):Play();
                            l_Debris_0:AddItem(l_v11_SpeedMultiplier_1, 0.3);
                        end);
                    end;
                    return;
                end;
            end
        }, 
        GashingWound = {
            LayoutOrder = 3, 
            Icon = "rbxassetid://96900331272883", 
            KeybindType = "AltAbility2", 
            Cooldown = function(v102, v103) --[[ Line: 395 ]] --[[ Name: Cooldown ]]
                return v102.State.isEnraged and v102.Config[("Enraged%*Cooldown"):format(v103)] or v102.Config[("%*Cooldown"):format(v103)];
            end, 
            Callback = function(v104) --[[ Line: 396 ]] --[[ Name: Callback ]]
                -- upvalues: v26 (copy), v53 (copy), l_insert_0 (copy), l_sort_0 (copy), l_delay_0 (copy), v13 (copy), v11 (copy), v9 (copy), v40 (copy), v7 (copy), v17 (copy), v8 (copy), v16 (copy), l_wait_0 (copy), v60 (copy), l_TweenService_0 (copy), v30 (copy)
                if v26 then
                    v104.AbilitiesDisabled = true;
                    v104.Cache.GashingWoundStart:Play(0.05);
                    v53(v104, "GashingWoundSwing");
                    local v105 = v104.State.isEnraged and v104.Config.EnragedGashingWoundDamage or v104.Config.GashingWoundDamage;
                    local v106 = v104.Config.GashingWoundHitData();
                    local v107 = {};
                    for v108, _ in pairs(v106) do
                        l_insert_0(v107, v108);
                    end;
                    local l_v107_0 = v107;
                    l_sort_0(l_v107_0);
                    v107 = l_v107_0[1] + 0.166;
                    local _ = os.clock();
                    local v112 = nil;
                    local v113 = nil;
                    for v114, v115 in v106 do
                        l_delay_0(v114, function() --[[ Line: 413 ]]
                            -- upvalues: v114 (copy), v107 (copy), v112 (ref), v13 (ref), v104 (copy), v105 (copy), v115 (copy), v53 (ref), v11 (ref), v9 (ref), v40 (ref), v113 (ref), v7 (ref), v17 (ref), v8 (ref)
                            if v107 <= v114 and not v112 then
                                return;
                            else
                                v13:CreateHitbox(v104.Player, {
                                    Size = Vector3.new(8, 4, 8, 0), 
                                    CFrameOffset = CFrame.new(0, 0, -2.25), 
                                    Damage = v105 / v115.DamageDivisor, 
                                    Time = v115.Time, 
                                    Knockback = 0, 
                                    HitMultiple = true, 
                                    Connections = {
                                        Hit = function(v116, v117) --[[ Line: 426 ]] --[[ Name: Hit ]]
                                            -- upvalues: v53 (ref), v104 (ref), v114 (ref), v112 (ref), v11 (ref), v9 (ref), v40 (ref), v113 (ref), v7 (ref), v17 (ref), v8 (ref)
                                            if v117 then
                                                v53(v104, "Hit");
                                            end;
                                            if v114 <= 0.5 and not v112 then
                                                local l_v11_EntityType_0, _ = v11:GetEntityType(v116);
                                                if not l_v11_EntityType_0 then
                                                    return;
                                                else
                                                    v9.AddProfile(v116, {
                                                        AnchorDelay = true, 
                                                        Applied = os.clock() + 10
                                                    });
                                                    v112 = v116;
                                                    for _, v121 in pairs(v104.Rig:GetChildren()) do
                                                        if v121.Name:find("Machete") and not v121:GetAttribute("Ignored") then
                                                            v121.Transparency = 0;
                                                        end;
                                                    end;
                                                    for _, v123 in pairs(v104.Rig.Machete:GetChildren()) do
                                                        if v123:IsA("ParticleEmitter") or v123:IsA("Light") or v123:IsA("Highlight") then
                                                            v123.Enabled = true;
                                                        end;
                                                    end;
                                                    for _, v125 in pairs(v104.Rig:GetChildren()) do
                                                        if v125.Name:find("BackDagger") and not v125:GetAttribute("Ignored") then
                                                            v125.Transparency = 1;
                                                        end;
                                                    end;
                                                    for _, v127 in pairs(v104.Rig.BackDagger:GetChildren()) do
                                                        if v127:IsA("ParticleEmitter") or v127:IsA("Light") or v127:IsA("Highlight") then
                                                            v127.Enabled = false;
                                                        end;
                                                    end;
                                                    task.delay(4, function() --[[ Line: 462 ]]
                                                        -- upvalues: v104 (ref)
                                                        for _, v129 in pairs(v104.Rig:GetChildren()) do
                                                            if v129.Name:find("Machete") and not v129:GetAttribute("Ignored") then
                                                                v129.Transparency = 1;
                                                            end;
                                                        end;
                                                        for _, v131 in pairs(v104.Rig.Machete:GetChildren()) do
                                                            if v131:IsA("ParticleEmitter") or v131:IsA("Light") or v131:IsA("Highlight") then
                                                                v131.Enabled = false;
                                                            end;
                                                        end;
                                                        for _, v133 in pairs(v104.Rig:GetChildren()) do
                                                            if v133.Name:find("BackDagger") and not v133:GetAttribute("Ignored") then
                                                                v133.Transparency = 0;
                                                            end;
                                                        end;
                                                        for _, v135 in pairs(v104.Rig.BackDagger:GetChildren()) do
                                                            if v135:IsA("ParticleEmitter") or v135:IsA("Light") or v135:IsA("Highlight") then
                                                                v135.Enabled = true;
                                                            end;
                                                        end;
                                                    end);
                                                    v40(v104.Behavior, "GashingWoundStart", v104.Behavior, v104);
                                                    v11:SetUpCutscene(v104.Rig, v116, v104.Config.GashingWoundCutsceneOffset or CFrame.identity, "Gashing");
                                                    v11:GiveInvincible(v104.Rig, "Gashing");
                                                    local l_GashingWound_0 = v104.Cache.GashingWound;
                                                    l_GashingWound_0:Play(0);
                                                    l_GashingWound_0.TimePosition = v104.Cache.GashingWoundStart.TimePosition;
                                                    v113 = v11:LoadAnimationFromID(v116, v104.Config.Animations.GashingWound.PlayerRig, true);
                                                    v113:Play(0.05);
                                                    v113.TimePosition = v104.Cache.GashingWoundStart.TimePosition;
                                                    v104.Cache.GashingWoundStart:Stop(0);
                                                    v7:PlayVoiceline(v104, "GashingWoundHit", {
                                                        Priority = 2
                                                    });
                                                    if v116.Humanoid.Health <= 0 then
                                                        for _, v138 in (workspace.Map.Ingame:GetChildren()) do
                                                            if v138:IsA("Model") and (v138.Name == "SubspaceTripmine" or string.match(v138.Name, "TaphTripmine")) then
                                                                local v139 = v138.PrimaryPart or v138:FindFirstChildWhichIsA("BasePart");
                                                                if v139 and (v139.Position - v116.HumanoidRootPart.Position).Magnitude <= 20 then
                                                                    v17:IncrementAchievementProgress(v104.Player, "JasonFool");
                                                                    break;
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                    if v116.Parent.Name == "Survivors" then
                                                        v8:IncrementActorStats(v104.Player, {
                                                            Action = "Landed Gashing Wound hit", 
                                                            RewardType = "RegularKillerAction"
                                                        });
                                                    end;
                                                end;
                                            end;
                                        end
                                    }
                                });
                                return;
                            end;
                        end);
                    end;
                    l_delay_0(v107, function() --[[ Line: 535 ]]
                        -- upvalues: v112 (ref), v53 (ref), v104 (copy), v11 (ref), v16 (ref), l_wait_0 (ref), v113 (ref), v9 (ref), v60 (ref), v40 (ref)
                        local v140 = v112 and 4.25 or 0.5;
                        if v112 then
                            v53(v104, "GashingWoundHit");
                        else
                            v11:RemoveInvincible(v104.Rig, "Gashing");
                            v53(v104, "GashingWoundMiss");
                        end;
                        v16:FireClientConnection(v104.Player, ("%*GashingWoundStateAsync"):format(v104.Player.Name), "REMOTE_EVENT", v112 and "HIT" or "NONE");
                        l_wait_0(v140 - 1.75);
                        if v113 then
                            v113:Stop(0);
                        end;
                        if v112 and v112.PrimaryPart then
                            local v141 = RaycastParams.new();
                            v141.FilterDescendantsInstances = workspace.Players:GetDescendants();
                            v141.FilterType = Enum.RaycastFilterType.Exclude;
                            local v142 = workspace:Raycast(v104.Rig.PrimaryPart.Position, v104.Rig.PrimaryPart.CFrame.LookVector * 100, v141);
                            local v143 = v142 and math.clamp(v142.Distance, -1e999, 3) or 3;
                            if v143 < 3 then
                                v143 = -(v112.PrimaryPart.Size.Z / 2) - (3 - v143) * 2;
                            end;
                            local v144 = v104.Rig.PrimaryPart.CFrame.LookVector * (v143 / 3 * 75);
                            v112:PivotTo(v104.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, 1));
                            v11:ToggleAnchored(v112, "Gashing", false);
                            v112.PrimaryPart.Velocity = v144;
                            v9.AddProfile(v112, {
                                AnchorDelay = true, 
                                Velocity = v144
                            });
                            v9.EnableRagdoll(v112, 1.25);
                        end;
                        l_wait_0(1);
                        v60(v104);
                        v40(v104.Behavior, "GashingWoundEnd", v104.Behavior, v104);
                        if v104.Rig and v104.Rig.PrimaryPart then
                            v11:ToggleAnchored(v104.Rig, "Gashing", false);
                        end;
                        l_wait_0(0.5);
                        v104.AbilitiesDisabled = false;
                        l_wait_0(1.5);
                        v11:RemoveInvincible(v104.Rig, "Gashing");
                    end);
                    return;
                else
                    local l_v11_SpeedMultiplier_2 = v11:CreateSpeedMultiplier(v104.Rig, 1, "BeheadAbility");
                    l_TweenService_0:Create(l_v11_SpeedMultiplier_2, v30, {
                        Value = 0.001
                    }):Play();
                    v104.Instances.GashingWoundSlowness = l_v11_SpeedMultiplier_2;
                    return;
                end;
            end
        }, 
        RagingPace = {
            LayoutOrder = 3, 
            Icon = "rbxassetid://86530225037587", 
            KeybindType = "AltAbility3", 
            Callback = function(v146) --[[ Line: 602 ]] --[[ Name: Callback ]]
                -- upvalues: v26 (copy), v53 (copy), l_delay_0 (copy), v11 (copy), v15 (copy), v40 (copy), l_Debris_0 (copy), l_wait_0 (copy), v60 (copy), v16 (copy), l_TweenService_0 (copy), l_RunService_0 (copy), v12 (copy)
                if v26 then
                    v146.AbilitiesDisabled = true;
                    v146.Instances.EnragedSFX = v53(v146, "EnragedStart", false);
                    l_delay_0(v146.Config.EnragedStartup, function() --[[ Line: 608 ]]
                        -- upvalues: v146 (copy), v11 (ref), v15 (ref), v40 (ref), l_Debris_0 (ref), l_wait_0 (ref), v60 (ref)
                        v146:ChangeExpression("Enraged");
                        v146.State.isEnraged = true;
                        v11:GiveInvincible(v146.Rig, "Raging");
                        v15:ApplyStatus(v146.Rig, "Invisibility", {
                            Level = 10, 
                            Duration = 10
                        });
                        v40(v146.Behavior, "EnragedReveal", v146.Behavior, v146);
                        l_Debris_0:AddItem(v146.Instances.EnragedSFX, v146.Config.EnragedTime);
                        for _, v148 in v146.Instances.EnragedVisuals do
                            v148.Enabled = true;
                        end;
                        l_wait_0(v146.Config.EnragedTime - v146.Config.EnragedStartup);
                        v60(v146);
                    end);
                    task.delay(1, function() --[[ Line: 627 ]]
                        -- upvalues: v146 (copy)
                        v146.AbilitiesDisabled = true;
                        task.delay(10, function() --[[ Line: 630 ]]
                            -- upvalues: v146 (ref)
                            v146.AbilitiesDisabled = false;
                        end);
                    end);
                    return;
                else
                    v146.Animations.EnragedStart:Play(0.025);
                    v146.AnimationType = "Enraged";
                    v146.MovementAnimSpeed = 1.425;
                    v146.State.isEnraged = true;
                    v16:FireConnection("DisableSprinting", "ENRAGED", true);
                    local l_v11_FOVMultiplier_0 = v11:CreateFOVMultiplier(v146.Player, 1, "RagingZoom");
                    l_TweenService_0:Create(l_v11_FOVMultiplier_0, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0), {
                        Value = 0.925
                    }):Play();
                    v146.Instances.SpeedModifier = v11:CreateSpeedMultiplier(v146.Rig, 1, "ENRAGED");
                    l_TweenService_0:Create(v146.Instances.SpeedModifier, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        Value = 0.1
                    }):Play();
                    l_delay_0(0.5, function() --[[ Line: 648 ]]
                        -- upvalues: l_TweenService_0 (ref), v146 (copy)
                        l_TweenService_0:Create(v146.Instances.SpeedModifier, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                            Value = v146.Config.EnragedSpeed / v146.Config.Speed
                        }):Play();
                    end);
                    for _, v151 in pairs(workspace.Players.Survivors:GetChildren()) do
                        v11:RevealPlayerAura(v151, v146.Config.UnstableEyeAuraDuration);
                    end;
                    if not v11:GetSettingValue("EpilepsyMode") then
                        local l_ColorCorrectionEffect_0 = Instance.new("ColorCorrectionEffect");
                        l_ColorCorrectionEffect_0.Parent = game.Lighting;
                        l_ColorCorrectionEffect_0.Name = "SlasherEvil";
                        l_ColorCorrectionEffect_0.Brightness = 0;
                        l_ColorCorrectionEffect_0.Contrast = 0;
                        l_ColorCorrectionEffect_0.Saturation = 0;
                        l_ColorCorrectionEffect_0.TintColor = Color3.fromRGB(255, 255, 255);
                        l_ColorCorrectionEffect_0.Enabled = true;
                        l_Debris_0:AddItem(l_ColorCorrectionEffect_0, 4);
                        task.delay(1.45, function() --[[ Line: 675 ]]
                            -- upvalues: l_TweenService_0 (ref), l_ColorCorrectionEffect_0 (copy)
                            l_TweenService_0:Create(l_ColorCorrectionEffect_0, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                TintColor = Color3.new(1, 0.894118, 0.894118)
                            }):Play();
                            l_TweenService_0:Create(l_ColorCorrectionEffect_0, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                Contrast = 0.05
                            }):Play();
                            l_TweenService_0:Create(l_ColorCorrectionEffect_0, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                Saturation = 0.1
                            }):Play();
                        end);
                        task.delay(1.55, function() --[[ Line: 681 ]]
                            -- upvalues: l_TweenService_0 (ref), l_ColorCorrectionEffect_0 (copy)
                            l_TweenService_0:Create(l_ColorCorrectionEffect_0, TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                                TintColor = Color3.new(1, 0.6, 0.6)
                            }):Play();
                            l_TweenService_0:Create(l_ColorCorrectionEffect_0, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                Contrast = 0.25
                            }):Play();
                            l_TweenService_0:Create(l_ColorCorrectionEffect_0, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                Saturation = 0.5
                            }):Play();
                        end);
                        task.delay(1.65, function() --[[ Line: 688 ]]
                            -- upvalues: l_TweenService_0 (ref), l_ColorCorrectionEffect_0 (copy)
                            l_TweenService_0:Create(l_ColorCorrectionEffect_0, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                Contrast = 0
                            }):Play();
                            l_TweenService_0:Create(l_ColorCorrectionEffect_0, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                Saturation = 0
                            }):Play();
                            l_TweenService_0:Create(l_ColorCorrectionEffect_0, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                TintColor = Color3.new(1, 1, 1)
                            }):Play();
                        end);
                    end;
                    l_delay_0(1.25, function() --[[ Line: 696 ]]
                        -- upvalues: l_TweenService_0 (ref), l_v11_FOVMultiplier_0 (copy)
                        l_TweenService_0:Create(l_v11_FOVMultiplier_0, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0), {
                            Value = 1
                        }):Play();
                    end);
                    l_delay_0(1, function() --[[ Line: 699 ]]
                        -- upvalues: l_Debris_0 (ref), l_v11_FOVMultiplier_0 (copy), l_RunService_0 (ref), v146 (copy), v12 (ref)
                        l_Debris_0:AddItem(l_v11_FOVMultiplier_0, 1);
                        local v153 = os.clock();
                        local v154 = nil;
                        v154 = l_RunService_0.Heartbeat:Connect(function(_) --[[ Line: 703 ]]
                            -- upvalues: v153 (copy), v146 (ref), v12 (ref), v154 (ref)
                            local v156 = math.clamp((os.clock() - v153) / v146.Config.EnragedStaminaCapLerpTime, 0, 1);
                            v12.StaminaCap = v146.Config.MaxStamina + (v146.Config.EnragedStaminaCap - v146.Config.MaxStamina) * v156;
                            if not v146.State.isEnraged then
                                v154:Disconnect();
                                v154 = nil;
                                v12.StaminaCap = v146.Config.MaxStamina;
                            end;
                        end);
                        v146.Maid:Add(v154);
                    end);
                    return;
                end;
            end
        }
    }, 
    CreatedPost = function(_, v158) --[[ Line: 721 ]] --[[ Name: CreatedPost ]]
        local l_Humanoid_1 = v158.Rig.Humanoid;
        task.spawn(function() --[[ Line: 723 ]]
            -- upvalues: l_Humanoid_1 (copy), v158 (copy)
            while l_Humanoid_1 and l_Humanoid_1.Parent and l_Humanoid_1.Health > 0 do
                local l_SParticle_0 = v158.Rig.HumanoidRootPart.SprintAttatchment.SParticle;
                local v161 = false;
                if v158.AnimationType ~= "Enraged" then
                    v161 = (v158.Rig.PrimaryPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1, 0)).Magnitude > (l_Humanoid_1:GetAttribute("BaseSpeed") or 18) + 10;
                end;
                l_SParticle_0.Enabled = v161;
                task.wait();
            end;
        end);
    end, 
    Created = function(_, v163) --[[ Line: 735 ]] --[[ Name: Created ]]
        -- upvalues: v14 (copy), l_insert_0 (copy), v26 (copy), v17 (copy), l_spawn_0 (copy), v11 (copy), v16 (copy), v27 (copy), v60 (copy), l_delay_0 (copy), l_TweenService_0 (copy), v30 (copy), l_Debris_0 (copy)
        v163.Maid = v14.new();
        v163.Meta = {};
        v163.Instances = {};
        v163.State = {};
        v163.NetworkConnections = {};
        v163.ConnectionDictionary = {};
        v163.State.isEnraged = false;
        local v164 = {};
        for _, v166 in (v163.Rig:GetDescendants()) do
            if v166.Name == "RagingPace" then
                l_insert_0(v164, v166);
            end;
        end;
        v163.Instances.EnragedVisuals = v164;
        if v26 then
            if workspace:GetAttribute("JasonSpecialDay") then
                v17:IncrementAchievementProgress(v163.Player, "JasonSpecialDay");
            end;
            l_spawn_0(function() --[[ Line: 765 ]]
                -- upvalues: v163 (copy), v11 (ref)
                v163.Cache.GashingWoundStart = v11:LoadAnimationFromID(v163.Rig, v163.Config.Animations.GashingWoundStart);
                v163.Cache.GashingWound = v11:LoadAnimationFromID(v163.Rig, v163.Config.Animations.GashingWound.KillerRig);
            end);
            return;
        else
            l_insert_0(v163.NetworkConnections, {
                ("%*EnrageStateAsync"):format(v163.Player.Name), 
                "REMOTE_EVENT"
            });
            v16:SetConnection(("%*EnrageStateAsync"):format(v163.Player.Name), "REMOTE_EVENT", function() --[[ Line: 773 ]]
                -- upvalues: v27 (ref), v60 (ref), v163 (copy)
                if v27 then
                    warn("[Slasher]: EnrageStateAsync was called, resetting enraged state!");
                end;
                v60(v163);
            end);
            l_insert_0(v163.NetworkConnections, {
                ("%*GashingWoundStateAsync"):format(v163.Player.Name), 
                "REMOTE_EVENT"
            });
            v16:SetConnection(("%*GashingWoundStateAsync"):format(v163.Player.Name), "REMOTE_EVENT", function(v167) --[[ Line: 779 ]]
                -- upvalues: v27 (ref), v163 (copy), l_delay_0 (ref), l_TweenService_0 (ref), v30 (ref), l_Debris_0 (ref)
                local v168 = ("GashingWoundStateAsync was called, new state: %*"):format(v167);
                if v27 then
                    warn((("[Slasher]: %*"):format(v168)));
                end;
                v168 = v163.Instances.GashingWoundSlowness;
                l_delay_0(v167 == "HIT" and 4.75 or 1, function() --[[ Line: 783 ]]
                    -- upvalues: l_TweenService_0 (ref), v168 (copy), v30 (ref), l_Debris_0 (ref)
                    l_TweenService_0:Create(v168, v30, {
                        Value = 1
                    }):Play();
                    l_Debris_0:AddItem(v168, 0.2);
                end);
            end);
            return;
        end;
    end, 
    Destroyed = function(_, v170) --[[ Line: 791 ]] --[[ Name: Destroyed ]]
        -- upvalues: v26 (copy), v27 (copy), v16 (copy)
        v170.Maid:Destroy();
        local v171 = ("%* | Destroyed Maid!"):format(v26 and "SERVER" or "CLIENT");
        if v27 then
            warn((("[Slasher]: %*"):format(v171)));
        end;
        for v172, v173 in v170.ConnectionDictionary do
            local v174 = ("%* | Disconnected connection: %*"):format(v26 and "SERVER" or "CLIENT", v173);
            if v27 then
                warn((("[Slasher]: %*"):format(v174)));
            end;
            v173:Disconnect();
            v170.ConnectionDictionary[v172] = nil;
        end;
        for v175, v176 in v170.NetworkConnections do
            local v177 = ("%* | Disconnected network connection: %*/%*"):format(v26 and "SERVER" or "CLIENT", v176[2], v176[1]);
            if v27 then
                warn((("[Slasher]: %*"):format(v177)));
            end;
            v16:RemoveConnection(v176[1], v176[2]);
            v170.NetworkConnections[v175] = nil;
        end;
        for _, v179 in v170.Instances do
            if typeof(v179) == "table" then
                for _, v181 in v179 do
                    if v181 and v181.Parent then
                        local v182 = ("%* | Removed instance reference: %*"):format(v26 and "SERVER" or "CLIENT", v181);
                        if v27 then
                            warn((("[Slasher]: %*"):format(v182)));
                        end;
                        v181:Destroy();
                    end;
                end;
            else
                v179:Destroy();
            end;
        end;
    end, 
    OnIntroduction = function(_, _, v185, v186) --[[ Line: 821 ]] --[[ Name: OnIntroduction ]]
        -- upvalues: v11 (copy), v31 (copy), l_delay_0 (copy), l_TweenService_0 (copy)
        local v187 = script.IntroWideDoor:Clone();
        v187:PivotTo(v185.PrimaryPart.CFrame);
        v187.Parent = v185;
        for _, v189 in (v187.Joints:GetChildren()) do
            v189.Part1 = v187.Parts:FindFirstChild(v189.Name, true);
            v189.Part0 = v185.PrimaryPart;
        end;
        local l_v11_FOVMultiplier_1 = v11:CreateFOVMultiplier(v31, 0.4, "JasonIntroScene", v186);
        l_delay_0(0.78, function() --[[ Line: 832 ]]
            -- upvalues: l_v11_FOVMultiplier_1 (copy), l_TweenService_0 (ref)
            l_v11_FOVMultiplier_1.Value = 0.35;
            l_TweenService_0:Create(l_v11_FOVMultiplier_1, TweenInfo.new(2.5, Enum.EasingStyle.Back), {
                Value = 0.45
            }):Play();
        end);
    end, 
    OnVictory = function(_, v192, v193, _, _) --[[ Line: 838 ]] --[[ Name: OnVictory ]]
        -- upvalues: v31 (copy), l_spawn_0 (copy), v32 (copy), l_wait_0 (copy), l_TweenService_0 (copy), l_close_0 (copy), v10 (copy)
        if v192 == "Start" then
            local l_PlayerGui_0 = v31.PlayerGui;
            local l_ScreenGui_0 = Instance.new("ScreenGui");
            l_ScreenGui_0.Name = "JasonOutroOverlay";
            l_ScreenGui_0.ResetOnSpawn = false;
            l_ScreenGui_0.IgnoreGuiInset = true;
            l_ScreenGui_0.Parent = l_PlayerGui_0;
            v193.Meta.StartThread = l_spawn_0(function() --[[ Line: 848 ]]
                -- upvalues: v32 (ref), v31 (ref), l_wait_0 (ref), l_TweenService_0 (ref)
                v32.FieldOfView = 35;
                v31:SetAttribute("FOVMultipliersDisabled", true);
                l_wait_0(1.53);
                local l_ColorCorrectionEffect_1 = Instance.new("ColorCorrectionEffect");
                l_ColorCorrectionEffect_1.Name = "JasonOutroCCEffect";
                l_ColorCorrectionEffect_1.Parent = game.Lighting;
                local l_BlurEffect_0 = Instance.new("BlurEffect");
                l_BlurEffect_0.Name = "JasonOutroBlurEffect";
                l_BlurEffect_0.Parent = game.Lighting;
                l_TweenService_0:Create(l_BlurEffect_0, TweenInfo.new(0.125), {
                    Size = 2
                }):Play();
                l_TweenService_0:Create(v32, TweenInfo.new(0.42), {
                    FieldOfView = 46
                }):Play();
                l_wait_0(0.42);
                l_TweenService_0:Create(l_ColorCorrectionEffect_1, TweenInfo.new(0.125, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                    TintColor = Color3.fromRGB(190, 0, 3), 
                    Brightness = 0.4, 
                    Contrast = 0.2, 
                    Saturation = 0.5
                }):Play();
                l_TweenService_0:Create(l_BlurEffect_0, TweenInfo.new(0.125, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                    Size = 30
                }):Play();
                l_TweenService_0:Create(v32, TweenInfo.new(0.15), {
                    FieldOfView = 32
                }):Play();
                l_wait_0(0.17);
                l_TweenService_0:Create(l_BlurEffect_0, TweenInfo.new(0.125), {
                    Size = 2
                }):Play();
                l_TweenService_0:Create(v32, TweenInfo.new(0.15), {
                    FieldOfView = 35
                }):Play();
                l_wait_0(0.35);
                l_TweenService_0:Create(l_ColorCorrectionEffect_1, TweenInfo.new(0.125), {
                    TintColor = Color3.fromRGB(255, 105, 105), 
                    Brightness = 0, 
                    Contrast = 0, 
                    Saturation = 0
                }):Play();
                l_wait_0(0.61);
                l_TweenService_0:Create(l_ColorCorrectionEffect_1, TweenInfo.new(0.125), {
                    TintColor = Color3.fromRGB(255, 226, 226)
                }):Play();
                l_TweenService_0:Create(v32, TweenInfo.new(0.15), {
                    FieldOfView = 32
                }):Play();
                l_wait_0(0.29);
                l_TweenService_0:Create(l_BlurEffect_0, TweenInfo.new(0.125), {
                    Size = 1
                }):Play();
                l_TweenService_0:Create(l_ColorCorrectionEffect_1, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
                l_TweenService_0:Create(v32, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    FieldOfView = 55
                }):Play();
            end);
            return;
        else
            if v192 == "End" then
                local l_JasonOutroOverlay_0 = v31.PlayerGui:FindFirstChild("JasonOutroOverlay");
                if l_JasonOutroOverlay_0 then
                    l_JasonOutroOverlay_0:Destroy();
                end;
                v31:SetAttribute("FOVMultipliersDisabled", nil);
                if v193 and v193.Meta.StartThread then
                    l_close_0(v193.Meta.StartThread);
                end;
                v10:SetAsCurrentLighting();
            end;
            return;
        end;
    end, 
    OnExecution = function(_, v202, v203) --[[ Line: 902 ]] --[[ Name: OnExecution ]]
        -- upvalues: l_delay_0 (copy), v9 (copy)
        if not v202.Rig then
            return;
        else
            local v204 = v203.Name == "Guest1337";
            local v205 = (v204 and -v202.Rig.PrimaryPart.CFrame.RightVector or v202.Rig.PrimaryPart.CFrame.LookVector) * 100;
            local v206 = v204 and 4.6 or 1.125;
            l_delay_0(v206, function() --[[ Line: 912 ]]
                -- upvalues: v9 (ref), v203 (copy), v205 (copy), v204 (copy)
                v9.AddProfile(v203, {
                    Velocity = v205, 
                    KillEffects = if v204 then {
                        Decapitate = true
                    } else nil
                });
                local l_Humanoid_2 = v203:FindFirstChildOfClass("Humanoid");
                if l_Humanoid_2 then
                    l_Humanoid_2.BreakJointsOnDeath = false;
                    l_Humanoid_2.Health = 0;
                end;
            end);
            return;
        end;
    end
};