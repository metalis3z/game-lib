-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:09:02 2025 ]]
local _ = game:GetService("ServerStorage");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("UserInputService");
local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("Players");
local _ = game:GetService("Debris");
local _ = game:GetService("CollectionService");
local _ = require(script.Classes.VoidRushUI);
local v9 = {};
local _ = require(l_ReplicatedStorage_0.Modules.Schematics.Lighting);
local v11 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v12 = require(game.ReplicatedStorage.Modules.Statuses);
local v13 = require(game.ReplicatedStorage.Modules.Sounds);
local _ = require(l_ReplicatedStorage_0.Modules.Ragdolls);
local v15 = require(l_ReplicatedStorage_0.Modules.Network);
local v16 = require(game.ReplicatedStorage.Modules.Util);
local _ = require(l_ReplicatedStorage_0.Modules.Device);
local _ = require(l_ReplicatedStorage_0.Modules.Items);
local _ = require(l_ReplicatedStorage_0.Modules.Misc.RadialImage);
local v20 = require(game.ReplicatedStorage.Modules.Actors);
if l_RunService_0:IsServer() then
    local _ = require(game.ServerScriptService.Server.Systems.Core.ActorHandler);
end;
local _ = l_ReplicatedStorage_0.Assets.UI.StunProtectionVFX;
local function _(v23, v24, v25) --[[ Line: 32 ]] --[[ Name: reward ]]
    -- upvalues: v20 (copy)
    v20:IncrementActorStats(v23.Player, {
        Action = v25, 
        RewardType = v24 .. "KillerAction"
    });
end;
v9.Abilities = {
    VoidRush = {
        LayoutOrder = 2, 
        Icon = "rbxassetid://110747688363796", 
        KeybindType = "AltAbility1", 
        FlavorText = "[Hold]", 
        Toggle = true, 
        Callback = function(v27, v28) --[[ Line: 46 ]] --[[ Name: Callback ]]
            -- upvalues: v13 (copy), l_RunService_0 (copy), v16 (copy), v15 (copy), v11 (copy), l_TweenService_0 (copy), v12 (copy), v20 (copy), l_ReplicatedStorage_0 (copy)
            local l_Behavior_0 = v27.Behavior;
            local v30 = ("%*VoidRushCollision"):format(v27.Player.Name);
            local v31 = ("%*VoidRushCancel"):format(v27.Player.Name);
            local v32 = ("%*VoidRushUpdateUI"):format(v27.Player.Name);
            local function v37(v33) --[[ Line: 54 ]] --[[ Name: playSound ]]
                -- upvalues: v27 (copy), v13 (ref)
                local l_Sounds_0 = v27.Config.Sounds;
                local v35 = l_Sounds_0[("VoidRush%*"):format(v33)] or l_Sounds_0[v33];
                if v35 then
                    local v36 = {
                        Parent = v27.Rig.PrimaryPart, 
                        RollOffMaxDistance = 120
                    };
                    if typeof(v35) == "table" then
                        v36 = {
                            Parent = v27.Rig.PrimaryPart, 
                            PlaybackSpeed = 1, 
                            RollOffMaxDistance = 80, 
                            Volume = 0.77
                        };
                    end;
                    return v13:Play(v35, v36);
                else
                    return;
                end;
            end;
            if l_RunService_0:IsServer() then
                local function v40(v38, v39) --[[ Line: 71 ]] --[[ Name: giveEndlag ]]
                    -- upvalues: v27 (copy), v16 (ref)
                    v27.AbilitiesDisabled = true;
                    v16:CreateSpeedMultiplier(v27.Rig, 0.6, "VoidRushEndlag", v38 + (v39 and v27.Config.VoidRushComboWindow or 0), true);
                    if not v39 then
                        task.delay(v38, function() --[[ Line: 76 ]]
                            -- upvalues: v27 (ref)
                            v27.AbilitiesDisabled = false;
                        end);
                    end;
                end;
                local function _(v41) --[[ Line: 82 ]] --[[ Name: updateLocalUI ]]
                    -- upvalues: v15 (ref), v27 (copy), v32 (copy)
                    v15:FireClientConnection(v27.Player, v32, "REMOTE_EVENT", v41);
                end;
                local l_VoidRush_0 = v27.Cache.Animations.VoidRush;
                v27.AbilitiesDisabled = true;
                v27.Behavior.DisableVoidstar(v27);
                v27.Behavior.ToggleTendril(v27, true);
                for _, v45 in ipairs(v27.Rig.CarRightAfterABeer:GetDescendants()) do
                    if v45:IsA("BasePart") then
                        v45.Transparency = 0;
                    end;
                end;
                task.spawn(function() --[[ Line: 99 ]]
                    -- upvalues: l_Behavior_0 (copy), v15 (ref), v27 (copy), v32 (copy), l_VoidRush_0 (copy), v37 (copy), v16 (ref), v31 (copy), l_RunService_0 (ref), v13 (ref), v11 (ref), v30 (copy), l_TweenService_0 (ref), v12 (ref), v20 (ref), v40 (copy)
                    if not l_Behavior_0.Endlag then
                        l_Behavior_0.Endlag = nil;
                        v15:FireClientConnection(v27.Player, v32, "REMOTE_EVENT", "Create");
                        local v46 = 0;
                        local v47 = false;
                        l_VoidRush_0.StartCharge:Play(0.15);
                        l_VoidRush_0.LoopCharge:Play(0.2);
                        v27.StartSound = v37("Start");
                        v37("Loop");
                        v27:PlayVoiceline("VoidRushStart", {
                            Priority = 2
                        });
                        local l_v16_SpeedMultiplier_0 = v16:CreateSpeedMultiplier(v27.Rig, v27.Config.VoidRushChargingSpeed, "VoidRushCharging", v27.Config.VoidRushChargeLength);
                        v27.Rig:SetAttribute("VoidRushState", "Charging");
                        v15:SetConnection(v31, "REMOTE_EVENT", function() --[[ Line: 123 ]]
                            -- upvalues: v47 (ref)
                            v47 = true;
                        end);
                        v27.Behavior.VoidRushCombo = 0;
                        repeat
                            v46 = v46 + l_RunService_0.Heartbeat:Wait();
                            if v27.Rig:GetAttribute("Stunned") then
                                v47 = true;
                            end;
                        until v27.Config.VoidRushChargeLength <= v46 or v47;
                        v15:RemoveConnection(v31);
                        l_VoidRush_0.StartCharge:Stop();
                        l_VoidRush_0.LoopCharge:Stop();
                        l_v16_SpeedMultiplier_0:Destroy();
                        if v47 then
                            v27:SetCooldownOf("VoidRush", v27.Config.VoidRushC00ldown / 16);
                            v27.Rig:SetAttribute("VoidRushState", "ChargingCancelled");
                            l_VoidRush_0.CancelCharge:Play(0.15);
                            v27:PlayVoiceline("VoidRushCancel", {
                                Priority = 3
                            });
                            v37("Cancel");
                            v15:FireClientConnection(v27.Player, v32, "REMOTE_EVENT", "ChargeFail");
                            task.delay(0.2, function() --[[ Line: 153 ]]
                                -- upvalues: v27 (ref)
                                v27.Behavior.EnableVoidstar(v27);
                                v27.Behavior.ToggleTendril(v27, false);
                                v27.AbilitiesDisabled = false;
                                v27.DisabledAbilities = nil;
                                v27.Rig:SetAttribute("VoidRushState", nil);
                            end);
                            if v27.StartSound then
                                v27.StartSound:Destroy();
                            end;
                            for _, v50 in ipairs(v27.Rig.CarRightAfterABeer:GetDescendants()) do
                                if v50:IsA("BasePart") then
                                    v50.Transparency = 1;
                                end;
                            end;
                            return;
                        else
                            --[[ close >= 1 ]]
                        end;
                    end;
                    if v27.StartSound then
                        v27.StartSound:Destroy();
                    end;
                    if v27.WindowSound then
                        v27.WindowSound:Destroy();
                    end;
                    v27.VoidRushChargingSound = v13:Play(v27.Config.Sounds.VoidRushDashLoop, {
                        Parent = v27.Rig.PrimaryPart, 
                        Looped = true, 
                        RollOffMaxDistance = 50, 
                        Volume = 0.75
                    });
                    v27:PlayVoiceline("VoidRushDash", {
                        Priority = 3
                    });
                    local l_VoidRushDashSpeed_0 = v27.Config.VoidRushDashSpeed;
                    local v52 = l_Behavior_0.Endlag and "Combo" or "Init";
                    local l_VoidRushDashLength_0 = v27.Config.VoidRushDashLength;
                    local l_VoidRushHallucinationLevel_0 = v27.Config.VoidRushHallucinationLevel;
                    local l_v16_SpeedMultiplier_1 = v16:CreateSpeedMultiplier(v27.Rig, l_VoidRushDashSpeed_0 / v27.Config.Speed, "VoidRushDash");
                    local function v58() --[[ Line: 189 ]] --[[ Name: stopDashAnimations ]]
                        -- upvalues: l_VoidRush_0 (ref)
                        for _, v57 in ipairs({
                            "StartDashInit", 
                            "LoopDashCombo", 
                            "LoopDashInit", 
                            "StartDashCombo"
                        }) do
                            if l_VoidRush_0[v57] then
                                l_VoidRush_0[v57]:Stop();
                            end;
                        end;
                    end;
                    v58();
                    l_VoidRush_0[("StartDash%*"):format(v52)]:Play(0.05);
                    l_VoidRush_0[("LoopDash%*"):format(v52)]:Play(0.05);
                    v37("Dash" .. tostring(l_Behavior_0.Endlag and 2 or 1));
                    if l_Behavior_0.EndlagComboThread then
                        task.cancel(l_Behavior_0.EndlagComboThread);
                        l_Behavior_0.EndlagComboThread = nil;
                    end;
                    local l_Behavior_1 = v27.Behavior;
                    l_Behavior_1.VoidRushCombo = l_Behavior_1.VoidRushCombo + 1;
                    l_Behavior_0.Endlag = nil;
                    l_Behavior_1 = false;
                    local v60 = nil;
                    local v61 = nil;
                    local v62 = nil;
                    local v63 = nil;
                    local v64 = nil;
                    local v65 = nil;
                    local v66 = nil;
                    v66 = v27.Rig:GetAttributeChangedSignal("Stunned"):Once(function() --[[ Line: 212 ]]
                        -- upvalues: v63 (ref)
                        v63 = true;
                    end);
                    local v67 = nil;
                    v67 = v11:CreateHitbox(v27.Player, {
                        Size = Vector3.new(6, 6, 4, 0), 
                        Damage = v27.Config.VoidRushBaseDamage, 
                        CFrameOffset = CFrame.new(0, 0, -2), 
                        Time = l_VoidRushDashLength_0, 
                        Knockback = 6, 
                        HitMultiple = true, 
                        ExecuteOnKill = false, 
                        Connections = {
                            Hit = function(v68) --[[ Line: 223 ]] --[[ Name: Hit ]]
                                -- upvalues: l_Behavior_1 (ref), v60 (ref), v67 (ref), v65 (ref)
                                if l_Behavior_1 then
                                    return;
                                else
                                    if v68:IsDescendantOf(workspace.Players) or v68:HasTag("SimulateSurvivor") then
                                        l_Behavior_1 = true;
                                        v60 = v68;
                                        if v67 then
                                            v67:Cancel();
                                            return;
                                        end;
                                    elseif v68:GetAttribute("OwnerName") then
                                        l_Behavior_1 = true;
                                        v65 = v68;
                                        if v67 then
                                            v67:Cancel();
                                        end;
                                    end;
                                    return;
                                end;
                            end, 
                            Ended = function() --[[ Line: 248 ]] --[[ Name: Ended ]]
                                -- upvalues: v61 (ref)
                                v61 = true;
                            end
                        }
                    });
                    local v69 = require(game.ReplicatedStorage.Modules.Network);
                    local _ = v69:SetConnection(v30, "REMOTE_EVENT", function(_, v71) --[[ Line: 256 ]]
                        -- upvalues: v62 (ref), v64 (ref)
                        v62 = v71;
                        v64 = true;
                    end);
                    v16:CreateSpeedMultiplier(v27.Rig, 1, "VoidRushEndlag", 0);
                    v16:CreateSpeedMultiplier(v27.Rig, 1, "VoidRushCharging", 0);
                    v27.Rig:SetAttribute("VoidRushState", "Dashing");
                    v15:FireClientConnection(v27.Player, v32, "REMOTE_EVENT", "Dash");
                    task.spawn(function() --[[ Line: 272 ]]
                        -- upvalues: v60 (ref), v61 (ref), v63 (ref), v62 (ref), v64 (ref), v65 (ref), v27 (ref), l_v16_SpeedMultiplier_1 (copy), v69 (copy), v30 (ref), v67 (ref), l_TweenService_0 (ref), v12 (ref), l_VoidRushHallucinationLevel_0 (copy), v20 (ref), v16 (ref), v37 (ref), l_VoidRush_0 (ref), v15 (ref), v32 (ref), v11 (ref), l_Behavior_0 (ref), v40 (ref), v58 (copy)
                        repeat
                            task.wait();
                        until v60 or v61 or v63 or v62 or v64 or v65 or not v27.Rig.PrimaryPart;
                        local v73 = v61 and "Timeout" or v63 and "Stunned" or v62 and "Crashed" or v65 and "NonChar" or "Cancelled";
                        l_v16_SpeedMultiplier_1:Destroy();
                        v69:RemoveConnection(v30, "REMOTE_EVENT");
                        v67:Cancel();
                        if v27.VoidRushChargingSound then
                            local l_VoidRushChargingSound_0 = v27.VoidRushChargingSound;
                            v27.VoidRushChargingSound = nil;
                            l_TweenService_0:Create(l_VoidRushChargingSound_0, TweenInfo.new(0.4), {
                                PlaybackSpeed = 0, 
                                Volume = l_VoidRushChargingSound_0.Volume / 5
                            }):Play();
                            game.Debris:AddItem(l_VoidRushChargingSound_0, 0.5);
                        end;
                        if v60 then
                            local v75 = v12:PlayerHasStatus(v60, "Hallucination");
                            if v75 and v75.Data and v75.Data.Level >= l_VoidRushHallucinationLevel_0 then
                                v12:RemoveStatus(v60, "Hallucination");
                                v27:SetCooldownOf("VoidRush", v27.Config.VoidRushC00ldown);
                                v20:IncrementActorStats(v27.Player, {
                                    Action = "Slammed Survivor with Void Rush", 
                                    RewardType = "RegularKillerAction"
                                });
                                v16:SetUpCutscene(v27.Rig, v60, CFrame.new(0, 0.01, 0));
                                v37("Cutscene");
                                v27.Rig:SetAttribute("Invincible", true);
                                local l_CutsceneKillerRig_0 = l_VoidRush_0.CutsceneKillerRig;
                                l_CutsceneKillerRig_0:Play(0);
                                l_CutsceneKillerRig_0.TimePosition = 0;
                                local v77 = v16:LoadAnimationFromID(v60, v27.Config.Animations.VoidRushVictimRig, true);
                                v77:Play(0.05);
                                v77.TimePosition = l_CutsceneKillerRig_0.TimePosition;
                                v27.Rig:SetAttribute("VoidRushState", "HitLarge");
                                v15:FireClientConnection(v27.Player, v32, "REMOTE_EVENT", "Miss_HitLarge");
                                task.spawn(function() --[[ Line: 328 ]]
                                    -- upvalues: v60 (ref), v27 (ref), v11 (ref)
                                    v60.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0, 0);
                                    task.wait(0.5);
                                    v27:PlayVoiceline("Slam", {
                                        Priority = 4
                                    });
                                    if v60 then
                                        local _ = v11:CreateHitbox(v27.Player, {
                                            Size = Vector3.new(4, 4, 4, 0), 
                                            CFrame = v60.PrimaryPart.CFrame, 
                                            Damage = v27.Config.VoidRushSlamDamage, 
                                            Time = 0.1, 
                                            Knockback = 0, 
                                            HitMultiple = true, 
                                            PredictVelocity = false, 
                                            ExecuteOnKill = false, 
                                            Connections = {}
                                        });
                                        local v79 = RaycastParams.new();
                                        v79.FilterDescendantsInstances = workspace.Players:GetDescendants();
                                        v79.FilterType = Enum.RaycastFilterType.Exclude;
                                        local l_Position_0 = v27.Rig.PrimaryPart.Position;
                                        local v81 = v27.Rig.PrimaryPart.CFrame.LookVector * 2;
                                        local v82 = workspace:Raycast(l_Position_0, v81, v79);
                                        v60:SetPrimaryPartCFrame(v60.PrimaryPart.CFrame + v81 * (v82 and v82.Distance or v81.Magnitude) / 2);
                                        v60.PrimaryPart.Anchored = false;
                                        v60.PrimaryPart.Velocity = Vector3.new(0, -1, 0, 0);
                                        local v83 = require(game.ReplicatedStorage.Modules.Ragdolls);
                                        v83.AddProfile(v60, {
                                            Velocity = Vector3.new(0, -1, 0, 0)
                                        });
                                        v83.EnableRagdoll(v60, 1.25);
                                    end;
                                    v27.Behavior.EnableVoidstar(v27);
                                    v27.Behavior.ToggleTendril(v27, false);
                                    task.wait(v27.Config.VoidRushCutsceneLength);
                                    v27.Rig:SetAttribute("VoidRushState", nil);
                                    v27.Rig.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0, 0);
                                    v27.Rig.PrimaryPart.Anchored = false;
                                    task.delay(0.5, function() --[[ Line: 374 ]]
                                        -- upvalues: v27 (ref)
                                        v27.Rig:SetAttribute("Invincible", nil);
                                        v27.AbilitiesDisabled = false;
                                        v27.DisabledAbilities = nil;
                                    end);
                                end);
                                if l_Behavior_0.Endlag then
                                    v27:SetCooldownOf("VoidRush", v27.Config.VoidRushC00ldown);
                                end;
                                for _, v85 in ipairs(v27.Rig.CarRightAfterABeer:GetDescendants()) do
                                    if v85:IsA("BasePart") then
                                        v85.Transparency = 1;
                                    end;
                                end;
                            else
                                local l_VoidRushHitEndlag_0 = v27.Config.VoidRushHitEndlag;
                                local l_VoidRushComboWindow_0 = v27.Config.VoidRushComboWindow;
                                v20:IncrementActorStats(v27.Player, {
                                    Action = "Hit player with Void Rush", 
                                    RewardType = "EasyKillerAction"
                                });
                                v27.Rig:SetAttribute("VoidRushState", "Hit");
                                v15:FireClientConnection(v27.Player, v32, "REMOTE_EVENT", "Hit");
                                v27:SetCooldownOf("VoidRush", l_VoidRushHitEndlag_0);
                                v12:ApplyStatus(v60, "Hallucination", {
                                    Duration = v27.Config.VoidRushHallucinationDuration, 
                                    Level = l_VoidRushHallucinationLevel_0, 
                                    Killer = v27
                                });
                                v16:CreateSpeedMultiplier(v60, 1.5, "HitSpeedBonus", 1.25);
                                v40(l_VoidRushHitEndlag_0, true);
                                l_Behavior_0.Endlag = true;
                                v27.WindowSound = v37("Window");
                                l_VoidRush_0.WeakHit:Play(0);
                                v27:PlayVoiceline("VoidRushWeakHit", {
                                    Priority = 4
                                });
                                v37("WeakHit" .. tostring((math.clamp(v27.Behavior.VoidRushCombo, 1, 5))));
                                v27.AbilitiesDisabled = false;
                                v27.DisabledAbilities = {
                                    Stab = true, 
                                    Nova = true, 
                                    Observant = true
                                };
                                l_Behavior_0.EndlagComboThread = task.delay(l_VoidRushHitEndlag_0 + l_VoidRushComboWindow_0, function() --[[ Line: 428 ]]
                                    -- upvalues: l_Behavior_0 (ref), v27 (ref), v15 (ref), v32 (ref)
                                    l_Behavior_0.Endlag = nil;
                                    v27.AbilitiesDisabled = false;
                                    v27:SetCooldownOf("VoidRush", v27.Config.VoidRushC00ldown);
                                    v27.Behavior.EnableVoidstar(v27);
                                    v27.Behavior.ToggleTendril(v27, false);
                                    v27.DisabledAbilities = nil;
                                    v27.Rig:SetAttribute("VoidRushState", nil);
                                    v15:FireClientConnection(v27.Player, v32, "REMOTE_EVENT", "WindowMiss");
                                    for _, v89 in ipairs(v27.Rig.CarRightAfterABeer:GetDescendants()) do
                                        if v89:IsA("BasePart") then
                                            v89.Transparency = 1;
                                        end;
                                    end;
                                end);
                            end;
                        elseif v61 or v63 or v62 or v64 or v65 then
                            v40(v27.Config.VoidRushMissEndlag);
                            task.delay(v27.Config.VoidRushMissEndlag, function() --[[ Line: 451 ]]
                                -- upvalues: v27 (ref)
                                v27.Behavior.EnableVoidstar(v27);
                                v27.Behavior.ToggleTendril(v27, false);
                            end);
                            v27:SetCooldownOf("VoidRush", v27.Config.VoidRushC00ldown);
                            v27.DisabledAbilities = nil;
                            v27.Rig:SetAttribute("VoidRushState", v73);
                            local v90 = "Miss_" .. v73;
                            v15:FireClientConnection(v27.Player, v32, "REMOTE_EVENT", v90);
                            if l_VoidRush_0["EndDash" .. v73] then
                                l_VoidRush_0["EndDash" .. v73]:Play();
                            else
                                l_VoidRush_0.EndDash:Play();
                            end;
                            v37("Miss" .. v73);
                            v27:PlayVoiceline("VoidRushMiss" .. v73, {
                                Priority = 3
                            });
                            for _, v92 in ipairs(v27.Rig.CarRightAfterABeer:GetDescendants()) do
                                if v92:IsA("BasePart") then
                                    v92.Transparency = 1;
                                end;
                            end;
                        end;
                        v58();
                    end);
                end);
                return {
                    SentTick = not l_Behavior_0.Endlag and tick()
                };
            else
                if l_RunService_0:IsClient() then
                    local v93 = require(l_ReplicatedStorage_0.Systems.Character.Game.Sprinting);
                    local v94 = v28 and v28.SentTick;
                    local function _() --[[ Line: 491 ]] --[[ Name: getState ]]
                        -- upvalues: v27 (copy)
                        return v27.Rig:GetAttribute("VoidRushState");
                    end;
                    v15:FireConnection("DisableSprinting", "VoidRushCharging", true);
                    if v94 then
                        local v96 = false;
                        v93.StaminaCap = v93.Stamina + 1;
                        while l_RunService_0.Heartbeat:Wait() do
                            if not v27.HeldAbilities.VoidRush and not v96 then
                                v96 = true;
                                v15:FireServerConnection(v31, "REMOTE_EVENT");
                            elseif v27.Rig:GetAttribute("VoidRushState") ~= "Charging" then
                                break;
                            end;
                        end;
                    end;
                    if v27.Rig:GetAttribute("VoidRushState") == "ChargingCancelled" then
                        v15:FireConnection("DisableSprinting", "VoidRushCharging", false);
                        v93.StaminaCap = nil;
                        v27.HeldAbilities.VoidRush = nil;
                        return;
                    else
                        local v97 = 0;
                        local v98 = false;
                        local l_LookVector_0 = workspace.CurrentCamera.CFrame.LookVector;
                        local l_Unit_0 = Vector3.new(l_LookVector_0.X, 0, l_LookVector_0.Z).Unit;
                        local v101 = Vector3.new(0, 0, 0, 0);
                        v15:FireConnection("DisableSprinting", "VoidRushCharging", true);
                        v93.StaminaCap = v93.Stamina + 1;
                        do
                            local l_v97_0, l_v98_0, l_l_Unit_0_0, l_v101_0 = v97, v98, l_Unit_0, v101;
                            l_RunService_0:BindToRenderStep("VoidRushCharging", Enum.RenderPriority.Character.Value + 1, function(v106) --[[ Line: 543 ]]
                                -- upvalues: l_v97_0 (ref), v27 (copy), l_v98_0 (ref), v15 (ref), v30 (copy), l_v101_0 (ref), l_l_Unit_0_0 (ref), l_TweenService_0 (ref)
                                l_v97_0 = l_v97_0 + v106;
                                if l_v97_0 >= 0.3 and v27.Rig.PrimaryPart.Velocity.Magnitude <= v27.Config.VoidRushDashSpeed / 2 then
                                    if not l_v98_0 then
                                        l_v98_0 = true;
                                        v15:FireServerConnection(v30, "REMOTE_EVENT", v27.HeldAbilities.VoidRush);
                                    end;
                                    return;
                                else
                                    local l_SpeedMultipliers_0 = v27.Rig:FindFirstChild("SpeedMultipliers");
                                    local v108 = l_SpeedMultipliers_0 and l_SpeedMultipliers_0:FindFirstChild("VoidRushDash");
                                    if v108 then
                                        local v109 = v27.Config.VoidRushDashSpeed / v27.Config.Speed;
                                        local v110 = v106 * (v27.HeldAbilities.VoidRush and 1 or -3) * 2 * v109;
                                        v108.Value = math.clamp(v108.Value + v110, 0, v109);
                                    end;
                                    local l_LookVector_1 = workspace.CurrentCamera.CFrame.LookVector;
                                    l_v101_0 = Vector3.new(l_LookVector_1.X, 0, l_LookVector_1.Z).Unit;
                                    local v112 = l_v101_0 - l_l_Unit_0_0;
                                    local l_Magnitude_0 = v112.Magnitude;
                                    if l_Magnitude_0 > 0 then
                                        local l_VoidRushInitialTurnDuration_0 = v27.Config.VoidRushInitialTurnDuration;
                                        local v115 = v27.Config.VoidRushInitialTurnMult * l_TweenService_0:GetValue((l_VoidRushInitialTurnDuration_0 - l_v97_0) / l_VoidRushInitialTurnDuration_0, Enum.EasingStyle.Sine, Enum.EasingDirection.In) + 1;
                                        local v116 = v27.Config.VoidRushTurnSpeed * v106 * v115;
                                        if l_Magnitude_0 <= v116 then
                                            l_l_Unit_0_0 = l_v101_0;
                                        else
                                            l_l_Unit_0_0 = l_l_Unit_0_0 + v112.Unit * v116;
                                        end;
                                        l_l_Unit_0_0 = l_l_Unit_0_0.Unit;
                                    end;
                                    v27.Rig.Humanoid:Move(l_l_Unit_0_0);
                                    return;
                                end;
                            end);
                            while v27 and v27.Rig and v27.Rig:GetAttribute("VoidRushState") == "Dashing" do
                                l_RunService_0.Heartbeat:Wait();
                            end;
                            v27.HeldAbilities.VoidRush = nil;
                            v93.StaminaCap = nil;
                            v15:FireConnection("DisableSprinting", "VoidRushCharging", false);
                            l_RunService_0:UnbindFromRenderStep("VoidRushCharging");
                        end;
                    end;
                end;
                return;
            end;
        end
    }
};
return v9;