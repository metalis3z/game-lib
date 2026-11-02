-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Network);
local v4 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v5 = require(game.ReplicatedStorage.Modules.Statuses);
local _ = require(game.ReplicatedStorage.Modules.AchievementUtil);
local v7 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local v8 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local function v19(v9, v10, v11) --[[ Line: 60 ]] --[[ Name: toggleKnife ]]
    if v9.KnifeToggles then
        v9.KnifeToggles[v10] = v11 or nil;
    end;
    local v12 = 0;
    local l_pairs_0 = pairs;
    local v14 = v9.KnifeToggles or {};
    for _, _ in l_pairs_0(v14) do
        v12 = v12 + 1;
    end;
    if not v11 and v12 > 0 then
        return;
    else
        if v9 and v9.DaggerParts then
            for v17, v18 in pairs(v9.DaggerParts) do
                game.TweenService:Create(v17, TweenInfo.new(0.3), {
                    Transparency = v11 and v18 or 1
                }):Play();
            end;
        end;
        return;
    end;
end;
local function v22(v20) --[[ Line: 81 ]] --[[ Name: updateOverheadProgress ]]
    -- upvalues: v7 (copy)
    if v20.isCompletedWithBlood then
        return;
    else
        if v20.tweenThread then
            task.cancel(v20.tweenThread);
        end;
        local l_OverheadDisplay_0 = v20.OverheadDisplay;
        l_OverheadDisplay_0.Main.Visible = true;
        game.TweenService:Create(l_OverheadDisplay_0.Main.Back.Red, v7, {
            Size = UDim2.fromScale(math.clamp(v20.Blood / v20.Config.BloodRequiredForRespawn, 0, 1), 1)
        }):Play();
        v20.tweenThread = task.delay(v7.Time * 6, function() --[[ Line: 93 ]]
            -- upvalues: l_OverheadDisplay_0 (copy), v20 (copy)
            l_OverheadDisplay_0.Main.Visible = false;
            v20.tweenThread = nil;
        end);
        if v20.Blood >= v20.Config.BloodRequiredForRespawn then
            v20.isCompletedWithBlood = true;
        end;
        return;
    end;
end;
local v32 = {
    CLOSE = function(v23, _) --[[ Line: 106 ]]
        -- upvalues: v5 (copy)
        v5:ApplyStatus(v23.Player, "Speed", {
            Level = 2, 
            Duration = v23.Config.CrouchSpeedCloseTime
        });
        v23.StabAmplification = 1.5;
        task.delay(v23.Config.CrouchStabAmplifyTime, function() --[[ Line: 111 ]]
            -- upvalues: v23 (copy)
            if not v23 then
                return;
            else
                v23.StabAmplification = nil;
                return;
            end;
        end);
    end, 
    DEBUFF_SLOWNESS = function(v25, v26) --[[ Line: 119 ]]
        -- upvalues: v5 (copy)
        local v27 = math.floor((math.clamp(v26, v25.Config.CrouchDistances.DEBUFF_SLOWNESS[1], v25.Config.CrouchSlownessDebuffMax) - v25.Config.CrouchDistances.DEBUFF_SLOWNESS[1]) * 0.2);
        v5:ApplyStatus(v25.Player, "Slowness", {
            Level = 2, 
            Duration = v27
        });
    end, 
    DEBUFF_HIGHLIGHT = function(v28, _) --[[ Line: 125 ]]
        -- upvalues: v2 (copy)
        for _, v31 in (workspace.Players.Killers:GetChildren()) do
            v2:RevealPlayerAuraTo(v31, v28.Player, v28.Config.CrouchRevealTime);
            v2:RevealPlayerAuraTo(v28.Player, v28.Player, v28.Config.CrouchRevealTime);
        end;
    end
};
local function _(v33, v34, v35) --[[ Line: 136 ]] --[[ Name: playSound ]]
    -- upvalues: v1 (copy)
    if v33.CurrentSound then
        v33.CurrentSound:Destroy();
        v33.CurrentSound = nil;
    end;
    v33.CurrentSound = v1:Play(v33.Config.Sounds[v34], v35);
end;
local function v42(v37, v38) --[[ Line: 152 ]] --[[ Name: inflictCrouchEffects ]]
    -- upvalues: v32 (copy)
    for v39, v40 in v37.Config.CrouchDistances do
        local v41 = v40[2] > -1 and v40[2] or 1e999;
        if v40[1] <= v38 and v38 <= v41 then
            v32[v39](v37, v38);
        end;
    end;
end;
v0.Abilities = {
    Dagger = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://129077533212750", 
        KeybindType = "AltAbility1", 
        Callback = function(v43, v44) --[[ Line: 168 ]] --[[ Name: Callback ]]
            -- upvalues: v42 (copy), v19 (copy), v5 (copy), v1 (copy), v4 (copy), v3 (copy), v2 (copy), v22 (copy), v7 (copy), v8 (copy)
            if game["Run Service"]:IsServer() then
                local l_Attribute_0 = v43.Rig:GetAttribute("Crouching");
                if l_Attribute_0 then
                    v43.Rig:SetAttribute("Crouching", nil);
                    print((("[TwoTimeRework]: Current distance from nearest killer: %*"):format(v43.CurrentStudsAway)));
                    local l_CurrentStudsAway_0 = v43.CurrentStudsAway;
                    if v43.CurrentCrouchThread and l_CurrentStudsAway_0 ~= nil then
                        task.cancel(v43.CurrentCrouchThread);
                        v43.CurrentStudsAway = nil;
                        v43.CurrentCrouchThread = nil;
                        v42(v43, l_CurrentStudsAway_0);
                    end;
                    local v47 = tick();
                    v43:SetCooldownOf("Crouch", (math.clamp(v43.Config.CrouchCooldown - (v47 - (v43.TimeCrouched or v47)), v43.Config.CrouchMinCooldown, v43.Config.CrouchCooldown)));
                    v43.TimeCrouched = nil;
                    v19(v43, "Crouching", false);
                    v5:RemoveStatus(v43.Player, "Invisibility");
                    v5:RemoveStatus(v43.Player, "Undetectable");
                else
                    v43:SetCooldownOf("Crouch", 0.75);
                end;
                local l_PrimaryPart_0 = v43.Rig.PrimaryPart;
                if l_PrimaryPart_0 then
                    local v49 = ("%*Stab"):format(l_Attribute_0 and "Crouch" or "");
                    local v50 = {
                        Parent = l_PrimaryPart_0
                    };
                    if v43.CurrentSound then
                        v43.CurrentSound:Destroy();
                        v43.CurrentSound = nil;
                    end;
                    v43.CurrentSound = v1:Play(v43.Config.Sounds[v49], v50);
                end;
                v5:ApplyStatus(v43.Player, "Resistance", {
                    Level = v43.Config.DaggerResLevel, 
                    Duration = v43.Config.DaggerResDuration
                });
                v19(v43, "Dagger", true);
                task.delay(l_Attribute_0 and 0.45 or 0, function() --[[ Line: 215 ]]
                    -- upvalues: v4 (ref), v43 (copy), l_Attribute_0 (copy), v3 (ref), v2 (ref), v5 (ref), v1 (ref), l_PrimaryPart_0 (copy), v22 (ref), v7 (ref), v8 (ref)
                    local _ = v4:CreateHitbox(v43.Player, {
                        Size = Vector3.new(4, 6, 6.5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -2.25), 
                        Damage = 0, 
                        Time = l_Attribute_0 and 0.4 or 0.25, 
                        Knockback = 0, 
                        HitMultiple = false, 
                        Connections = {
                            Hit = function(v51) --[[ Line: 226 ]] --[[ Name: Hit ]]
                                -- upvalues: v43 (ref), v3 (ref), v2 (ref), v5 (ref), l_Attribute_0 (ref), v1 (ref), l_PrimaryPart_0 (ref), v22 (ref), v7 (ref), v8 (ref)
                                local l_PrimaryPart_1 = v43.Rig.PrimaryPart;
                                local l_PrimaryPart_2 = v51.PrimaryPart;
                                local v54 = v3:FireClientConnection(v43.Player, ("%*TwoTimePosition"):format((tostring(v43.Player))), "REMOTE_FUNCTION");
                                local v55 = false;
                                if l_PrimaryPart_1 and l_PrimaryPart_2 then
                                    local l_Unit_0 = l_PrimaryPart_2.CFrame.LookVector.Unit;
                                    local l_Unit_1 = (l_PrimaryPart_2.Position - l_PrimaryPart_1.Position).Unit;
                                    local l_Unit_2 = (l_PrimaryPart_2.Position - v54).Unit;
                                    local v59 = l_Unit_1:Dot(l_Unit_0);
                                    local v60 = l_Unit_2:Dot(l_Unit_0);
                                    local v61 = math.deg((math.acos((l_PrimaryPart_1.CFrame.LookVector:Dot(l_PrimaryPart_2.CFrame.LookVector)))));
                                    local v62 = math.rad(v43.Config.DaggerBackstabThreshold) / 1.5707963267948966;
                                    local v63 = false;
                                    if 1 - v59 < v62 then
                                        v63 = v59 > 0;
                                    end;
                                    local v64 = false;
                                    if 1 - v60 < v62 + 0.45 then
                                        v64 = v60 > 0;
                                    end;
                                    local v65 = v61 < v43.Config.DaggerLookDirectionAngle;
                                    v55 = v63 and v64 and v65;
                                    if game["Run Service"]:IsStudio() then
                                        print((("[TwoTimeRework]: Look Direction Angle: %*"):format(v61)));
                                        print((("[TwoTimeRework]: Server Threshold Comparison: %*, %*"):format(v62, v59)));
                                        print((("[TwoTimeRework]: Client Threshold Comparison: %*, %*"):format(v62 + 0.1, v60)));
                                        print((("[TwoTimeRework]: isBackstabbing? %*"):format(v55)));
                                    end;
                                end;
                                if v55 then
                                    v2:ApplyDamage(v51, v43.Config.DaggerBackstabDamage * (v43.StabAmplification or 1));
                                    v5:ApplyStatus(v51, "Stunned", {
                                        Duration = v43.Config.DaggerBackstabStatusTime
                                    });
                                    v43:ChangeExpression("StunnedKiller", 4);
                                else
                                    v2:ApplyDamage(v51, v43.Config.DaggerDamage * (v43.StabAmplification or 1));
                                    v5:ApplyStatus(v51, "Slowness", {
                                        Level = 2, 
                                        Duration = v43.Config.DaggerStatusTime
                                    });
                                    if l_Attribute_0 then
                                        v5:ApplyStatus(v51, "Helpless", {
                                            Level = 1, 
                                            Duration = v43.Config.DaggerStatusTime
                                        });
                                    end;
                                end;
                                local l_v43_0 = v43;
                                l_v43_0.Blood = l_v43_0.Blood + (v55 and v43.Config.BloodFromBack or v43.Config.BloodFromFront);
                                v1:PlayVoiceline(v43, "SlashHit", {
                                    Priority = 1
                                });
                                if l_PrimaryPart_0 then
                                    v1:Play(v43.Config.Sounds.Hit, {
                                        Parent = v43.Rig.GhostFire.GhostfireBlade
                                    });
                                end;
                                v22(v43);
                                l_v43_0 = v43.RespawnLocation;
                                if l_v43_0 and l_v43_0.Decal.Transparency > 0 then
                                    l_v43_0.Size = Vector3.new(5.620999813079834, 0.9259999990463257, 5.620999813079834, 0);
                                    l_v43_0.Decal.Transparency = 0;
                                    game.TweenService:Create(l_v43_0, v7, {
                                        Size = Vector3.new(5.120999813079834, 0.4259999990463257, 5.120999813079834, 0)
                                    }):Play();
                                    game.TweenService:Create(l_v43_0.Decal, v8, {
                                        Transparency = 0.8 - math.clamp(v43.Blood / v43.Config.BloodRequiredForRespawn, 0, 1) * 0.8
                                    }):Play();
                                end;
                                if tostring(v51.Parent) == "Killers" then
                                    require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v43.Player, {
                                        Action = "Stunned Killer as Two Time", 
                                        RewardType = "Offensive"
                                    });
                                end;
                            end
                        }
                    });
                end);
                if l_Attribute_0 then
                    local v68 = v2:ApplyVelocity(v43.Rig.PrimaryPart, v43.Config.DaggerLungeForce);
                    game.TweenService:Create(v68, TweenInfo.new(0.4), {
                        LineVelocity = v68.LineVelocity / 3
                    }):Play();
                    game.Debris:AddItem(v68, 0.4);
                end;
                task.delay(l_Attribute_0 and 1.25 or 0.75, function() --[[ Line: 313 ]]
                    -- upvalues: v19 (ref), v43 (copy)
                    v19(v43, "Dagger", false);
                end);
                return l_Attribute_0;
            else
                v43.Animations[("%*Stab"):format(v44 and "Crouch" or "")]:Play(0);
                v2:ToggleSprinting("TwoTimeStab", false, 1.5);
                local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v43.Rig, 1, "TwoTimeStab", 1);
                game.TweenService:Create(l_v2_SpeedMultiplier_0, TweenInfo.new(0.5), {
                    Value = 0.1
                }):Play();
                task.wait(0.75);
                game.TweenService:Create(l_v2_SpeedMultiplier_0, TweenInfo.new(0.75, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                    Value = 1
                }):Play();
                return;
            end;
        end
    }, 
    Crouch = {
        LayoutOrder = 2, 
        Icon = "rbxassetid://77707049887484", 
        KeybindType = "AltAbility2", 
        Callback = function(v70) --[[ Line: 339 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v42 (copy), v19 (copy), v5 (copy)
            if game["Run Service"]:IsServer() then
                local v71 = tick();
                if v70.Rig:GetAttribute("Crouching") then
                    v70.Rig:SetAttribute("Crouching", nil);
                    local l_PrimaryPart_3 = v70.Rig.PrimaryPart;
                    if l_PrimaryPart_3 then
                        local v73 = {
                            Parent = l_PrimaryPart_3
                        };
                        if v70.CurrentSound then
                            v70.CurrentSound:Destroy();
                            v70.CurrentSound = nil;
                        end;
                        v70.CurrentSound = v1:Play(v70.Config.Sounds.Stand, v73);
                    end;
                    if game["Run Service"]:IsStudio() then
                        print((("[TwoTimeRework]: Current distance from nearest killer: %*"):format(v70.CurrentStudsAway)));
                    end;
                    local l_CurrentStudsAway_1 = v70.CurrentStudsAway;
                    if v70.CurrentCrouchThread and l_CurrentStudsAway_1 ~= nil then
                        task.cancel(v70.CurrentCrouchThread);
                        v70.CurrentStudsAway = nil;
                        v70.CurrentCrouchThread = nil;
                        v42(v70, l_CurrentStudsAway_1);
                    end;
                    v70:SetCooldownOf("Crouch", (math.clamp(v70.Config.CrouchCooldown - (v71 - (v70.TimeCrouched or v71)), v70.Config.CrouchMinCooldown, v70.Config.CrouchCooldown)));
                    v70.TimeCrouched = nil;
                    v19(v70, "Crouching", false);
                    v5:RemoveStatus(v70.Player, "Invisibility");
                    v5:RemoveStatus(v70.Player, "Undetectable");
                    return;
                else
                    v70.Rig:SetAttribute("Crouching", true);
                    local l_PrimaryPart_4 = v70.Rig.PrimaryPart;
                    if l_PrimaryPart_4 then
                        local v76 = {
                            Parent = l_PrimaryPart_4
                        };
                        if v70.CurrentSound then
                            v70.CurrentSound:Destroy();
                            v70.CurrentSound = nil;
                        end;
                        v70.CurrentSound = v1:Play(v70.Config.Sounds.Crouch, v76);
                    end;
                    v70:SetCooldownOf("Crouch", 1);
                    v70.TimeCrouched = v71;
                    if #workspace.Players.Killers:GetChildren() > 0 then
                        v70.CurrentCrouchThread = task.spawn(function() --[[ Line: 395 ]]
                            -- upvalues: v70 (copy)
                            while task.wait(0.025) do
                                for v77, v78 in (workspace.Players.Killers:GetChildren()) do
                                    if v78.PrimaryPart and v70.Rig.PrimaryPart then
                                        local l_Magnitude_0 = (v70.Rig.PrimaryPart.Position - v78.PrimaryPart.Position).Magnitude;
                                        if v77 > 1 then
                                            v70.CurrentStudsAway = v70.CurrentStudsAway < l_Magnitude_0 and v70.CurrentStudsAway or l_Magnitude_0;
                                        else
                                            v70.CurrentStudsAway = l_Magnitude_0;
                                        end;
                                    end;
                                end;
                            end;
                        end);
                    end;
                    v19(v70, "Crouching", true);
                    local v80 = v70.Config.CrouchCooldown - v70.Config.CrouchMinCooldown;
                    v5:ApplyStatus(v70.Player, "Invisibility", {
                        Duration = v80, 
                        Level = v70.Config.CrouchInvisibilityLevel
                    });
                    v5:ApplyStatus(v70.Player, "Undetectable", {
                        Duration = v80, 
                        Level = v70.Config.CrouchUndetectableLevel
                    });
                    task.delay(v80, function() --[[ Line: 421 ]]
                        -- upvalues: v71 (copy), v70 (copy), v19 (ref)
                        if v71 == v70.TimeCrouched then
                            v70.Rig:SetAttribute("Crouching", false);
                            v70:SetCooldownOf("Crouch", v70.Config.CrouchMinCooldown);
                            v70.TimeCrouched = nil;
                            v19(v70, false);
                        end;
                    end);
                end;
            end;
        end
    }, 
    Ritual = {
        LayoutOrder = 3, 
        Icon = "rbxassetid://95580729656404", 
        KeybindType = "AltAbility3", 
        Cooldown = 5, 
        Charges = 1, 
        Callback = function(v81, v82) --[[ Line: 440 ]] --[[ Name: Callback ]]
            -- upvalues: v19 (copy), v7 (copy), v8 (copy), v2 (copy), v1 (copy)
            if game["Run Service"]:IsServer() then
                v19(v81, "Dagger", true);
                local v83 = RaycastParams.new();
                v83.FilterDescendantsInstances = v81.Rig:GetChildren();
                v83.FilterType = Enum.RaycastFilterType.Exclude;
                local l_PrimaryPart_5 = v81.Rig.PrimaryPart;
                local v85 = workspace:Raycast(l_PrimaryPart_5.Position, Vector3.new(0, -100, 0, 0), v83);
                local _ = workspace:Raycast(l_PrimaryPart_5.Position, l_PrimaryPart_5.CFrame.LookVector * 100, v83);
                local v87 = v85.Position + Vector3.new(0, -0.10000000149011612, 0, 0);
                for _, v89 in (workspace.Map.Ingame:GetChildren()) do
                    if (v89.Name:find("RespawnLocation") or v89.Name:find("Builderman")) and (v87 - v89.Position).Magnitude < v81.Config.RespawnLocationDistance then
                        v81:IncrementCharges("Ritual", 1, 1);
                        return {
                            Cancelled = true
                        };
                    end;
                end;
                if math.deg((math.acos((workspace:Raycast(l_PrimaryPart_5.Position, Vector3.new(0, -100, 0, 0), v83).Normal:Dot((Vector3.new(0, 1, 0, 0))))))) > 5 then
                    v81:IncrementCharges("Ritual", 1, 1);
                    return {
                        Cancelled = true
                    };
                else
                    task.delay(1.5, function() --[[ Line: 471 ]]
                        -- upvalues: v81 (copy), v83 (copy), v7 (ref), v8 (ref)
                        local l_graphic_0 = v81.Rig.Life1.Torso:FindFirstChild("graphic");
                        if l_graphic_0 then
                            l_graphic_0:FindFirstChildOfClass("Decal").Transparency = 1;
                        end;
                        local l_PrimaryPart_6 = v81.Rig.PrimaryPart;
                        local v92 = workspace:Raycast(l_PrimaryPart_6.Position, Vector3.new(0, -100, 0, 0), v83);
                        local v93 = workspace:Raycast(l_PrimaryPart_6.Position, l_PrimaryPart_6.CFrame.LookVector * 100, v83);
                        local v94 = v93 and math.clamp(v93.Distance, -1e999, 2.648) or 2.648;
                        local v95 = v81.Config.RespawnLocation:Clone();
                        local l_Size_0 = v95.Size;
                        v95.Name = ("%*RespawnLocation"):format(v81.Player.Name);
                        v95.Size = l_Size_0 + Vector3.new(0.5, 0.5, 0.5, 0);
                        v81.RespawnLocation = v95;
                        if v94 < 2.648 then
                            v94 = v94 - v95.Size.Z / 2;
                        end;
                        local v97 = v92.Position + l_PrimaryPart_6.CFrame.LookVector * v94 + Vector3.new(0, -0.10000000149011612, 0, 0);
                        v95.CFrame = CFrame.lookAt(v97, v97 + l_PrimaryPart_6.CFrame.LookVector);
                        v95.Decal.Transparency = 0;
                        v95.Parent = workspace.Map.Ingame;
                        game.TweenService:Create(v95, v7, {
                            Size = l_Size_0
                        }):Play();
                        game.TweenService:Create(v95.Decal, v8, {
                            Transparency = 0.8 - math.clamp(v81.Blood / v81.Config.BloodRequiredForRespawn, 0, 1) * 0.8
                        }):Play();
                    end);
                    task.delay(3.5, function() --[[ Line: 504 ]]
                        -- upvalues: v19 (ref), v81 (copy)
                        v19(v81, "Dagger", false);
                    end);
                    return;
                end;
            elseif typeof(v82) == "table" and v82.Cancelled then
                v2:CreateWarning("TwoTimeWarning", "Cannot place this down!", v81.Config.WarningTemplate);
                return;
            else
                v81.AbilitiesDisabled = true;
                v81.Animations.Ritual:Play();
                local l_PrimaryPart_7 = v81.Rig.PrimaryPart;
                if l_PrimaryPart_7 then
                    local v99 = {
                        Parent = l_PrimaryPart_7
                    };
                    if v81.CurrentSound then
                        v81.CurrentSound:Destroy();
                        v81.CurrentSound = nil;
                    end;
                    v81.CurrentSound = v1:Play(v81.Config.Sounds.Mark, v99);
                end;
                local l_v2_SpeedMultiplier_1 = v2:CreateSpeedMultiplier(v81.Player, 0, (("%*Ritual"):format((tostring(v81.Player)))));
                task.delay(3.5, function() --[[ Line: 522 ]]
                    -- upvalues: l_v2_SpeedMultiplier_1 (copy)
                    game.TweenService:Create(l_v2_SpeedMultiplier_1, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                        Value = 1
                    }):Play();
                    game.Debris:AddItem(l_v2_SpeedMultiplier_1, 1);
                end);
                return;
            end;
        end
    }
};
v0.AddRig = function(_, v102, v103) --[[ Line: 531 ]] --[[ Name: AddRig ]]
    local v104 = v102.Config.LifeAppearances[v103];
    if v104 then
        for _, v106 in pairs(v102.Rig:GetDescendants()) do
            if (v106:IsA("BasePart") or v106:IsA("Decal")) and v106.Name ~= "Expression" and v106.Name ~= "CollisionHitbox" and v106.Name ~= "QueryHitbox" then
                v106.Transparency = 1;
            end;
        end;
        local v107 = v104:Clone();
        for _, v109 in pairs(v107:GetDescendants()) do
            if v109:IsA("BasePart") then
                v109.CanCollide = false;
                v109.CanQuery = false;
                v109.CanTouch = false;
            end;
        end;
        for _, v111 in (v102.Rig:GetChildren()) do
            if v111:IsA("BasePart") then
                v111.RootPriority = 1;
            end;
        end;
        for _, v113 in pairs(v107:GetChildren()) do
            local l_FirstChild_0 = v102.Rig:FindFirstChild(v113.Name);
            if l_FirstChild_0 then
                if v113:IsA("Humanoid") then
                    v113.EvaluateStateMachine = false;
                end;
                if l_FirstChild_0:IsA("BasePart") then
                    v113.Anchored = false;
                    v113.CanCollide = false;
                    v113.CFrame = l_FirstChild_0.CFrame;
                    local l_WeldConstraint_0 = Instance.new("WeldConstraint");
                    l_WeldConstraint_0.Part1 = v113;
                    l_WeldConstraint_0.Part0 = l_FirstChild_0;
                    l_WeldConstraint_0.Parent = v113;
                end;
            end;
        end;
        v107.Parent = v102.Rig;
        v102.Config.Expressions = v102.Config.ExpressionsTable[v103] or v102.Config.Expressions;
        v102:ChangeExpression("Hurt", 1);
    end;
end;
v0.OnHit = function(_, v117, v118, v119, v120) --[[ Line: 595 ]] --[[ Name: OnHit ]]
    -- upvalues: v2 (copy), v1 (copy)
    if v120 or v117.Blood >= v117.Config.BloodRequiredForRespawn and v117.LivesUsed < v117.Config.Lives and v117.Rig.Humanoid.Health <= v119 and v117.RespawnLocation then
        if v118 then
            v118.TimePast = 9999;
        end;
        v117.Blood = 0;
        v117.LivesUsed = v117.LivesUsed + 1;
        if v117.Rig.PrimaryPart.Anchored then
            v117.Rig:SetAttribute("Invincible", true);
            local l_MaxHealth_0 = v117.Rig.Humanoid.MaxHealth;
            local l_Health_0 = v117.Rig.Humanoid.Health;
            v117.Rig.Humanoid.MaxHealth = 1;
            v117.Rig.Humanoid.Health = 1;
            repeat
                task.wait();
            until v117.Rig.PrimaryPart.Anchored == false;
            v117.Rig.Humanoid.MaxHealth = l_MaxHealth_0;
            v117.Rig.Humanoid.Health = l_Health_0;
        end;
        v117.TimeSinceLastLife = tick();
        v117.Behavior:AddRig(v117, v117.LivesUsed);
        pcall(function() --[[ Line: 620 ]]
            -- upvalues: v117 (copy)
            v117.Behavior:AddRigSkin(v117, v117.LivesUsed);
        end);
        if v120 then
            v117.Rig.Humanoid.MaxHealth = v117.Config.LastSurvivorMaxHealth;
            local l_Humanoid_0 = v117.Rig.Humanoid;
            l_Humanoid_0.Health = l_Humanoid_0.Health + v117.Config.LastSurvivorHealthBonus;
        else
            local l_Humanoid_1 = v117.Rig.Humanoid;
            l_Humanoid_1.MaxHealth = l_Humanoid_1.MaxHealth / v117.Config.NextLifeHealthDivisor;
            v117.Rig.Humanoid.Health = v117.Rig.Humanoid.MaxHealth;
        end;
        v117.Rig:SetAttribute("Invincible", true);
        task.delay(v117.Config.InvincibilityDuration, function() --[[ Line: 635 ]]
            -- upvalues: v117 (copy)
            v117.Rig:SetAttribute("Invincible", nil);
        end);
        local _, v126 = v117.Rig:GetBoundingBox();
        v117.Rig:PivotTo(v117.RespawnLocation.CFrame + vector.create(0, v126.Y / 2, 0));
        if v117.LivesUsed >= v117.Config.Lives then
            v117.RespawnLocation:Destroy();
            v117.RespawnLocation = nil;
        end;
        for _, v128 in (workspace.Players.Killers:GetChildren()) do
            v2:RevealPlayerAuraTo(v128, v117.Player, 2);
            v2:RevealPlayerAuraTo(v117.Player, v117.Player, 2);
        end;
        local v129 = require(game.ReplicatedStorage.Modules.Statuses);
        v129:RemoveStatuses(v117.Player, true);
        v129:ApplyStatus(v117.Player, "Speed", {
            Level = 2, 
            Duration = 6, 
            Instant = true
        });
        if not v120 then
            v129:ApplyStatus(v117.Player, "Weakness", {
                Level = 5, 
                Duration = 12
            });
        end;
        local l_PrimaryPart_8 = v117.Rig.PrimaryPart;
        if l_PrimaryPart_8 then
            v1:Play(v117.Config.Sounds.Respawn, {
                Parent = l_PrimaryPart_8
            });
        end;
        for _, v132 in pairs(v117.Rig:GetChildren()) do
            if v132:IsA("BasePart") then
                local v133 = v117.Config.LifeChangedFX:Clone();
                v133.Parent = v132;
                v133:Emit(2);
                game.Debris:AddItem(v133, 1);
            end;
        end;
        require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v117.Player, {
            Action = "Respawned as Two Time", 
            RewardType = "Survivalist"
        });
    end;
end;
v0.Created = function(_, v135) --[[ Line: 685 ]] --[[ Name: Created ]]
    -- upvalues: v0 (copy), v3 (copy), v2 (copy)
    if game["Run Service"]:IsServer() then
        v135.LivesUsed = 1;
        v135.Blood = 0;
        v135.Behavior:AddRig(v135, v135.LivesUsed);
        pcall(function() --[[ Line: 692 ]]
            -- upvalues: v135 (copy)
            v135.Behavior:AddRigSkin(v135, v135.LivesUsed);
        end);
        v135.Rig.Humanoid.Died:Connect(function() --[[ Line: 697 ]]
            -- upvalues: v135 (copy)
            if v135.TimeSinceLastLife and tick() - v135.TimeSinceLastLife <= 10 then
                require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(v135.Player, "TwoTimeDeath");
            end;
        end);
        local v136 = v135.Config.HealthOverhead:Clone();
        v136.Main.Back.Red.Size = UDim2.fromScale(0, 1);
        v136.Parent = v135.Rig.Head;
        v135.OverheadDisplay = v136;
        local function v138() --[[ Line: 711 ]] --[[ Name: check ]]
            -- upvalues: v135 (copy), v0 (ref)
            local v137 = v135.Rig and v135.Rig:FindFirstChild("Humanoid");
            if v137 and v137.Health > 0 and v135.LivesUsed <= 1 and #workspace.Players.Survivors:GetChildren() <= 1 then
                v0:OnHit(v135, {}, 0, true);
            end;
        end;
        task.delay(0.5, v138);
        local v139 = nil;
        v139 = workspace.Players.Survivors.ChildRemoved:Connect(function() --[[ Line: 720 ]]
            -- upvalues: v135 (copy), v138 (copy), v139 (ref)
            if v135.Rig.Parent then
                v138();
                return;
            else
                v139:Disconnect();
                v139 = nil;
                return;
            end;
        end);
        local v140 = v135.Config.DaggerTemplate:Clone();
        local l_Motor6D_0 = v140:FindFirstChildOfClass("Motor6D");
        if l_Motor6D_0 then
            l_Motor6D_0.Part0 = v135.Rig.PrimaryPart;
            v140.Parent = v135.Rig;
        else
            v140:Destroy();
        end;
        v135.KnifeToggles = {};
        v135.DaggerParts = {};
        for _, v143 in pairs(v140:GetChildren()) do
            if v143:IsA("BasePart") or v143:IsA("Decal") then
                v135.DaggerParts[v143] = v143.Transparency;
                v143.Transparency = 1;
            end;
        end;
        return;
    else
        if game["Run Service"]:IsClient() and v135.Rig == game.Players.LocalPlayer.Character then
            v135.Rig:WaitForChild("Humanoid"):GetPropertyChangedSignal("MaxHealth"):Connect(function() --[[ Line: 750 ]]
                -- upvalues: v135 (copy)
                if v135.Rig.Humanoid.MaxHealth <= 70 then
                    local v144 = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting);
                    v144.Stamina = math.clamp(v144.Stamina + 40, 0, v144.MaxStamina or 100);
                end;
            end);
            v3:SetConnection(("%*TwoTimePosition"):format((tostring(v135.Player))), "REMOTE_FUNCTION", function() --[[ Line: 757 ]]
                -- upvalues: v135 (copy)
                return v135.Rig.PrimaryPart.Position;
            end);
            v135.Rig:GetAttributeChangedSignal("Crouching"):Connect(function() --[[ Line: 762 ]]
                -- upvalues: v135 (copy), v2 (ref)
                local _ = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting);
                local v146 = v135.Config.CrouchSpeed / v135.Config.Speed;
                if v135.Rig:GetAttribute("Crouching") then
                    v135.Animations.CrouchStart:Play();
                    v135.AnimationType = "Crouch";
                    v135.MovementAnimSpeed = 1;
                    task.delay(v135.Animations.CrouchStart.Length, function() --[[ Line: 773 ]]
                        -- upvalues: v135 (ref)
                        if not v135.AnimationType then
                            return;
                        else
                            if not v135.Animations.CrouchIdle.IsPlaying then
                                v135.Animations.CrouchIdle:Play();
                            end;
                            return;
                        end;
                    end);
                    local l_v2_SpeedMultiplier_2 = v2:CreateSpeedMultiplier(v135.Rig, 1, "TwoTimeCrouching");
                    game.TweenService:Create(l_v2_SpeedMultiplier_2, TweenInfo.new(0.75, Enum.EasingStyle.Quint), {
                        Value = 0.15
                    }):Play();
                    task.wait(0.75);
                    game.TweenService:Create(l_v2_SpeedMultiplier_2, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        Value = v146
                    }):Play();
                    return;
                else
                    v135.Animations.CrouchIdle:Stop(0.4);
                    v135.AnimationType = nil;
                    v135.MovementAnimSpeed = nil;
                    local l_v2_SpeedMultiplier_3 = v2:CreateSpeedMultiplier(v135.Rig, v146, "TwoTimeCrouching");
                    game.TweenService:Create(l_v2_SpeedMultiplier_3, TweenInfo.new(0.75, Enum.EasingStyle.Quint), {
                        Value = 1
                    }):Play();
                    game.Debris:AddItem(l_v2_SpeedMultiplier_3, 0.75);
                    return;
                end;
            end);
        end;
        return;
    end;
end;
v0.Destroyed = function(_, v150) --[[ Line: 804 ]] --[[ Name: Destroyed ]]
    -- upvalues: v3 (copy)
    if game["Run Service"]:IsClient() then
        v3:RemoveConnection((("%*TwoTimePosition"):format((tostring(v150.Player)))));
        return;
    else
        v150.isCompletedWithBlood = false;
        if v150.RespawnLocation then
            v150.RespawnLocation:Destroy();
            v150.RespawnLocation = nil;
        end;
        return;
    end;
end;
return v0;