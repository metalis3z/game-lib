-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:09:53 2025 ]]
local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
local v5 = require(game.ReplicatedStorage.Modules.Actors);
local v6 = require(game.ReplicatedStorage.Modules.AchievementUtil);
local function _(v7) --[[ Line: 12 ]] --[[ Name: __displayWarn ]]
    warn((("[Taph]: %*"):format(v7)));
end;
local function v14(v9, v10, ...) --[[ Line: 18 ]] --[[ Name: __pcallMethod ]]
    assert(v9, "bad moduleInfo, must be a table");
    local l_status_0, l_result_0 = pcall(function(...) --[[ Line: 21 ]]
        -- upvalues: v9 (copy), v10 (copy)
        if v9[v10] then
            return v9[v10](...);
        else
            return;
        end;
    end, ...);
    if not l_status_0 then
        local v13 = ("Failed to call :%*() due to: %*"):format(v10, l_result_0);
        warn((("[Taph]: %*"):format(v13)));
    end;
    return l_status_0, l_result_0;
end;
local function v28(v15, v16, v17) --[[ Line: 32 ]] --[[ Name: checkPlacement ]]
    local v18 = OverlapParams.new();
    v18.FilterDescendantsInstances = {
        workspace.Players
    };
    v18.FilterType = Enum.RaycastFilterType.Exclude;
    v18.CollisionGroup = "Survivors";
    local l_workspace_PartBoundsInRadius_0 = workspace:GetPartBoundsInRadius(v16.Position, 0.25, v18);
    for _, v21 in pairs(l_workspace_PartBoundsInRadius_0) do
        if v21.CanCollide or v21.Name == "UnplacableArea" then
            return "collision";
        end;
    end;
    for _, v23 in pairs(workspace.Map.Ingame:GetChildren()) do
        if v23.Name:find("TaphTripwire") then
            for _, v25 in pairs(v23:GetChildren()) do
                if v25.Name:find("Hook") and (v15.Rig.PrimaryPart.Position - v25.Position).Magnitude < v15.Config.TripwireDistanceBetweenTripwires then
                    return "tooClose";
                end;
            end;
        end;
    end;
    local v26 = RaycastParams.new();
    v26.FilterType = Enum.RaycastFilterType.Exclude;
    v26.FilterDescendantsInstances = {
        workspace.Players
    };
    if not workspace:Raycast(v16.Position, Vector3.new(0, -2, 0, 0), v26) then
        return "midair";
    elseif workspace:Raycast(v15.Rig.PrimaryPart.Position, v15.Rig.PrimaryPart.CFrame.LookVector * 2, v26) then
        return "facingWall";
    else
        if v17 then
            local l_Magnitude_0 = (v16.Position - v17.Position).Magnitude;
            if workspace:Raycast(v17.Position, CFrame.lookAt(v17.Position, v16.Position).LookVector * l_Magnitude_0, v26) then
                return "intersecting";
            end;
        end;
        return "placed";
    end;
end;
v0.Abilities = {
    Tripwire = {
        LayoutOrder = 1, 
        KeybindType = "AltAbility1", 
        Icon = "rbxassetid://135707604176757", 
        Callback = function(v29, v30) --[[ Line: 110 ]] --[[ Name: Callback ]]
            -- upvalues: v28 (copy), v2 (copy), v4 (copy), v5 (copy)
            if game["Run Service"]:IsServer() then
                v29.DisabledAbilities = {
                    SubspaceTripmine = true
                };
                local v31 = v29.Rig.PrimaryPart.CFrame * CFrame.new(0, -1, -2);
                local l_Attribute_0 = v29.Rig:GetAttribute("TripwireOrigin");
                if l_Attribute_0 then
                    local v33 = v28(v29, v31, l_Attribute_0);
                    if v33 ~= "placed" then
                        v29.DisabledAbilities = nil;
                        return {
                            Cancelled = true, 
                            Reason = v33
                        };
                    else
                        v29.Rig:SetAttribute("TripwireEnding", v31);
                        v29.Placing = nil;
                    end;
                else
                    local v34 = v28(v29, v31);
                    if v34 ~= "placed" then
                        v29.DisabledAbilities = nil;
                        return {
                            Cancelled = true, 
                            Reason = v34
                        };
                    else
                        v29.Placing = true;
                        v29:SetCooldownOf("Tripwire", v29.Config.TripwireCooldownWhilePlacing);
                        v29.Rig:SetAttribute("PlacingTripwire", true);
                        v29.Rig:SetAttribute("TripwireOrigin", v29.Rig.PrimaryPart.CFrame * CFrame.new(0, -1, -2));
                        local l_Health_0 = v29.Rig.Humanoid.Health;
                        local v36 = nil;
                        v36 = v29.Rig.Humanoid.HealthChanged:Connect(function(v37) --[[ Line: 151 ]]
                            -- upvalues: l_Health_0 (copy), v29 (copy)
                            if v37 + 4.75 < l_Health_0 then
                                v29.Placing = nil;
                            end;
                        end);
                        do
                            local l_v36_0 = v36;
                            task.spawn(function() --[[ Line: 158 ]]
                                -- upvalues: v29 (copy), l_v36_0 (ref), v2 (ref), v4 (ref), v5 (ref)
                                repeat
                                    task.wait();
                                until not v29.Rig.Parent or not v29.Placing;
                                if not v29.Rig.Parent then
                                    return;
                                else
                                    l_v36_0:Disconnect();
                                    v29.AbilitiesDisabled = true;
                                    v29.DisabledAbilities = nil;
                                    task.delay(2, function() --[[ Line: 168 ]]
                                        -- upvalues: v29 (ref)
                                        v29.AbilitiesDisabled = false;
                                    end);
                                    local l_Attribute_1 = v29.Rig:GetAttribute("TripwireOrigin");
                                    local l_Attribute_2 = v29.Rig:GetAttribute("TripwireEnding");
                                    if l_Attribute_1 and l_Attribute_2 then
                                        local l_Model_0 = Instance.new("Model");
                                        l_Model_0.Name = ("%*TaphTripwire"):format((tostring(v29.Player)));
                                        l_Model_0.Parent = workspace.Map.Ingame;
                                        l_Model_0:SetAttribute("HitboxPriority", 0);
                                        local _, _ = v29.Behavior:CreateTripwireHooks(v29, l_Model_0);
                                        local l_Magnitude_1 = (l_Attribute_1.Position - l_Attribute_2.Position).Magnitude;
                                        local v45 = l_Attribute_1.Position:Lerp(l_Attribute_2.Position, 0.5);
                                        local v46 = CFrame.lookAt(v45, l_Attribute_2.Position);
                                        local l_Part_0 = Instance.new("Part");
                                        l_Part_0.Name = "Wire";
                                        l_Part_0.Transparency = 1;
                                        l_Part_0.Anchored = true;
                                        l_Part_0.CanCollide = false;
                                        l_Part_0.CanQuery = true;
                                        l_Part_0.Size = Vector3.new(0.1, 0.1, l_Magnitude_1);
                                        l_Part_0.Position = v45 + Vector3.new(0, 0.20000000298023224, 0, 0);
                                        l_Part_0.CFrame = v46;
                                        l_Part_0.Parent = l_Model_0;
                                        game.TweenService:Create(l_Part_0, TweenInfo.new(1), {
                                            Transparency = 0.75
                                        }):Play();
                                        task.delay(1, function() --[[ Line: 202 ]]
                                            -- upvalues: l_Part_0 (copy)
                                            game.TweenService:Create(l_Part_0, TweenInfo.new(20, Enum.EasingStyle.Linear), {
                                                Transparency = 0.8
                                            }):Play();
                                        end);
                                        local l_Humanoid_0 = Instance.new("Humanoid");
                                        l_Humanoid_0.Parent = l_Model_0;
                                        l_Humanoid_0.MaxHealth = v29.Config.TripwireHealth;
                                        l_Humanoid_0.Health = v29.Config.TripwireHealth;
                                        l_Model_0:SetAttribute("ExecutionsDisabled", true);
                                        l_Model_0:SetAttribute("Team", "Survivors");
                                        l_Model_0.PrimaryPart = l_Part_0;
                                        local l_v2_ClosestPlayerFromPosition_0 = v2:GetClosestPlayerFromPosition(v29.Rig.PrimaryPart.Position, {
                                            MaxDistance = v29.Config.TripwirePingDistance, 
                                            ReturnTable = true
                                        });
                                        for _, v51 in pairs(l_v2_ClosestPlayerFromPosition_0) do
                                            local l_Player_0 = v51.Player;
                                            local l_PlayerFromCharacter_0 = game.Players:GetPlayerFromCharacter(l_Player_0);
                                            if l_PlayerFromCharacter_0 then
                                                v2:RevealPlayerAuraTo(l_PlayerFromCharacter_0, l_Model_0, v29.Config.TripwirePingDuration, Color3.new(0.75, 1, 0.75), 100);
                                            end;
                                        end;
                                        l_Model_0:SetAttribute("Invincible", true);
                                        task.delay(1, function() --[[ Line: 228 ]]
                                            -- upvalues: l_Model_0 (copy)
                                            l_Model_0:SetAttribute("Invincible", nil);
                                        end);
                                        local v54 = false;
                                        do
                                            local l_v54_0 = v54;
                                            local function v58() --[[ Line: 234 ]] --[[ Name: removeTripwire ]]
                                                -- upvalues: l_v54_0 (ref), l_Part_0 (copy), l_Model_0 (copy)
                                                if not l_v54_0 then
                                                    l_v54_0 = true;
                                                    l_Part_0.Anchored = false;
                                                    l_Part_0:ApplyImpulse((Vector3.new(0, 0.05000000074505806, 0, 0)));
                                                    game.Debris:AddItem(l_Model_0, 1.5);
                                                    for _, v57 in pairs(l_Model_0:GetChildren()) do
                                                        if v57:IsA("BasePart") then
                                                            game.TweenService:Create(v57, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                                                Transparency = 1
                                                            }):Play();
                                                        end;
                                                    end;
                                                end;
                                            end;
                                            if #v29.CurrentTripwires >= v29.Config.TripwireMaxAmount then
                                                table.remove(v29.CurrentTripwires, 1).Remove();
                                            end;
                                            table.insert(v29.CurrentTripwires, {
                                                Model = l_Model_0, 
                                                Remove = v58
                                            });
                                            local v59 = nil;
                                            v59 = l_Part_0.Touched:Connect(function(v60) --[[ Line: 260 ]]
                                                -- upvalues: v29 (ref), l_v54_0 (ref), v59 (ref), v58 (copy), v4 (ref), v2 (ref), v5 (ref)
                                                local l_v60_FirstAncestorOfClass_0 = v60:FindFirstAncestorOfClass("Model");
                                                local v62 = v29.Rig and v29.Rig.PrimaryPart;
                                                if l_v60_FirstAncestorOfClass_0 and tostring(l_v60_FirstAncestorOfClass_0.Parent) == "Killers" and not l_v54_0 and v62 then
                                                    v59:Disconnect();
                                                    v58();
                                                    local v63 = (#v29 - 1) * v29.Config.TripwireStackPenalty;
                                                    if not l_v60_FirstAncestorOfClass_0:GetAttribute("Invincible") then
                                                        local v64 = {
                                                            Duration = math.max(0, v29.Config.TripwireTriggerSlownessData.Duration - v63), 
                                                            Level = math.clamp(v29.Config.TripwireTriggerSlownessData.Level - (#v29 - 1), 1, v29.Config.TripwireTriggerSlownessData.Level)
                                                        };
                                                        v4:ApplyStatus(l_v60_FirstAncestorOfClass_0, "Slowness", v64);
                                                    end;
                                                    local v65 = l_v60_FirstAncestorOfClass_0:GetAttribute("Invincible") and v29.Config.TripwireTriggerAuraRevealInvincibleDuration or v29.Config.TripwireTriggerAuraRevealDuration;
                                                    local l_v2_ClosestPlayerFromPosition_1 = v2:GetClosestPlayerFromPosition(v29.Rig.PrimaryPart.Position, {
                                                        ReturnTable = true, 
                                                        MaxDistance = v29.Config.TripwireTriggerAuraRevealDistance, 
                                                        PlayerSelection = "Survivors"
                                                    });
                                                    for _, v68 in pairs(l_v2_ClosestPlayerFromPosition_1) do
                                                        v2:RevealPlayerAuraTo(v68.Player, l_v60_FirstAncestorOfClass_0, (math.max(0, v65 - v63)));
                                                    end;
                                                    if not l_v60_FirstAncestorOfClass_0:GetAttribute((("TripwireTriggerTime%*"):format((tostring(v29.Player))))) or l_v60_FirstAncestorOfClass_0:GetAttribute((("TripwireTriggerTime%*"):format((tostring(v29.Player))))) <= tick() - v29.Config.TripwireDurationBetweenRewards then
                                                        l_v60_FirstAncestorOfClass_0:SetAttribute(("TripwireTriggerTime%*"):format((tostring(v29.Player))), tick());
                                                        v5:IncrementActorStats(v29.Player, {
                                                            Action = "Killer Triggered Tripwire", 
                                                            RewardType = "Survivalist"
                                                        });
                                                    end;
                                                end;
                                            end);
                                            l_Humanoid_0.HealthChanged:Connect(function(v69) --[[ Line: 297 ]]
                                                -- upvalues: l_v54_0 (ref), v58 (copy), l_Part_0 (copy), v2 (ref), v29 (ref)
                                                if v69 > 0 or l_v54_0 then
                                                    return;
                                                else
                                                    v58();
                                                    local v70 = OverlapParams.new();
                                                    v70.FilterType = Enum.RaycastFilterType.Include;
                                                    v70.FilterDescendantsInstances = {
                                                        workspace.Players.Killers
                                                    };
                                                    local v71 = {};
                                                    local l_workspace_PartBoundsInBox_0 = workspace:GetPartBoundsInBox(l_Part_0.CFrame, l_Part_0.Size + Vector3.new(7, 7, 7, 0), v70);
                                                    for _, v74 in pairs(l_workspace_PartBoundsInBox_0) do
                                                        local l_v74_FirstAncestor_0 = v74:FindFirstAncestor("Model");
                                                        if l_v74_FirstAncestor_0 and not v71[l_v74_FirstAncestor_0] then
                                                            v71[l_v74_FirstAncestor_0] = true;
                                                            for _, v77 in pairs(workspace.Players.Survivors:GetChildren()) do
                                                                v2:RevealPlayerAuraTo(v77, l_v74_FirstAncestor_0, v29.Config.TripwireDestroyedAuraDuration);
                                                            end;
                                                        end;
                                                    end;
                                                    return;
                                                end;
                                            end);
                                            task.delay(v29.Config.TripwireLifetime - (#v29 - 1) * v29.Config.TripwireLifetimeDecreasePerTaph, v58);
                                        end;
                                    end;
                                    v29:SetCooldownOf("Tripwire", v29.Config.TripwireCooldown);
                                    v29.Rig:SetAttribute("PlacingTripwire", nil);
                                    v29.Rig:SetAttribute("TripwireOrigin", nil);
                                    v29.Rig:SetAttribute("TripwireEnding", nil);
                                    return;
                                end;
                            end);
                        end;
                    end;
                end;
                task.delay(v29.Config.TripwireCooldownWhilePlacing, function() --[[ Line: 331 ]]
                    -- upvalues: v29 (copy)
                    v29.AbilitiesDisabled = false;
                end);
                return v29.Placing;
            else
                if game["Run Service"]:IsClient() then
                    if typeof(v30) == "table" and v30.Cancelled then
                        local v78 = {
                            collision = "Tripwire placement point is obstructed by something. Move back a bit.", 
                            noBuild = math.random(1, 2500) == 3 and "CAMO!!!!" or "You can't build here.", 
                            tooClose = "Tripwire placement point is too close to another tripwire.", 
                            midair = "Tripwire placement point is too high above ground. Turn around and try again.", 
                            facingWall = "You're too close to a wall. Turn around and try again.", 
                            intersecting = "Your tripwire's intersecting with a wall. Make sure that there's nothing blocking its origin & end points.", 
                            unknown = "Something went wrong. Try placing the tripwire somewhere else."
                        };
                        local v79 = v78[v30.Reason] or v78.unknown;
                        v2:CreateWarning("BuildermanWarning", v79, v29.Config.WarningTemplate);
                        return;
                    elseif v30 == true then
                        v29.AnimationType = "Tripwire";
                        v29.Animations.TripwireIdle:Play();
                        v29.Animations.TripwirePlaceStart:Play(0.025);
                        v29.MovementAnimSpeed = 1;
                        local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v29.Rig, 1, "TaphTripwire");
                        game.TweenService:Create(l_v2_SpeedMultiplier_0, TweenInfo.new(0.25), {
                            Value = 0
                        }):Play();
                        local v81 = false;
                        local l_Health_1 = v29.Rig.Humanoid.Health;
                        local v83 = nil;
                        do
                            local l_v81_0, l_v83_0 = v81, v83;
                            l_v83_0 = v29.Rig.Humanoid.HealthChanged:Connect(function(v86) --[[ Line: 375 ]]
                                -- upvalues: l_Health_1 (copy), l_v81_0 (ref)
                                if v86 + 4.75 < l_Health_1 then
                                    l_v81_0 = true;
                                end;
                            end);
                            task.delay(1, function() --[[ Line: 382 ]]
                                -- upvalues: l_v2_SpeedMultiplier_0 (copy), v29 (copy), l_v81_0 (ref), l_v83_0 (ref)
                                game.TweenService:Create(l_v2_SpeedMultiplier_0, TweenInfo.new(1), {
                                    Value = v29.Config.TripwireSpeedWhilePlacing / v29.Config.Speed
                                }):Play();
                                repeat
                                    task.wait();
                                until not v29.Rig:GetAttribute("PlacingTripwire") or not v29.Rig.Parent or l_v81_0;
                                if not v29.Rig.Parent then
                                    return;
                                else
                                    l_v83_0:Disconnect();
                                    v29.AnimationType = nil;
                                    v29.Animations.TripwireIdle:Stop();
                                    v29.Animations.TripwirePlaceEnd:Play(0);
                                    v29.MovementAnimSpeed = nil;
                                    if l_v81_0 then
                                        l_v2_SpeedMultiplier_0:Destroy();
                                        v29.Animations.TripwirePlaceEnd:Stop(0.2);
                                        return;
                                    else
                                        l_v2_SpeedMultiplier_0.Value = 0;
                                        task.delay(0.5, function() --[[ Line: 407 ]]
                                            -- upvalues: l_v2_SpeedMultiplier_0 (ref)
                                            game.TweenService:Create(l_v2_SpeedMultiplier_0, TweenInfo.new(0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                                                Value = 1
                                            }):Play();
                                            game.Debris:AddItem(l_v2_SpeedMultiplier_0, 0.75);
                                        end);
                                        return;
                                    end;
                                end;
                            end);
                        end;
                    end;
                end;
                return;
            end;
        end
    }, 
    SubspaceTripmine = {
        LayoutOrder = 2, 
        KeybindType = "AltAbility2", 
        Icon = "rbxassetid://89334370123950", 
        Callback = function(v87, _) --[[ Line: 424 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v14 (copy), v2 (copy), v4 (copy), v5 (copy)
            if game["Run Service"]:IsServer() then
                v87.AbilitiesDisabled = true;
                local l_SubspaceTripmine_0 = v87.Rig.SubspaceTripmine;
                for _, v91 in pairs(l_SubspaceTripmine_0:GetDescendants()) do
                    if v91:IsA("BasePart") then
                        v91.Transparency = 0;
                    elseif v91:IsA("ParticleEmitter") then
                        v91.Enabled = true;
                    end;
                end;
                v1:Play(v87.Config.Sounds.SubspaceUse, {
                    Parent = v87.Rig.PrimaryPart
                });
                v14(v87.Behavior, "SubspaceBegin", v87);
                task.delay(1.98, function() --[[ Line: 440 ]]
                    -- upvalues: v87 (copy), l_SubspaceTripmine_0 (copy), v2 (ref), v1 (ref), v4 (ref), v5 (ref)
                    if not v87.Rig.Parent or not v87.Rig.PrimaryPart or v87.Rig.PrimaryPart.Anchored or v87.Rig.Humanoid.Health <= 0 then
                        for _, v93 in pairs(l_SubspaceTripmine_0:GetDescendants()) do
                            if v93:IsA("BasePart") then
                                v93.Transparency = 1;
                            elseif v93:IsA("ParticleEmitter") then
                                v93.Enabled = false;
                            end;
                        end;
                        return;
                    else
                        local v94 = l_SubspaceTripmine_0:Clone();
                        v94:SetAttribute("Team", "Survivors");
                        v94:SetAttribute("ExecutionsDisabled", true);
                        v94.Parent = workspace.Map.Ingame;
                        for _, v96 in pairs(v94:GetDescendants()) do
                            if v96:IsA("BasePart") then
                                v96.Transparency = 0;
                                v96:SetNetworkOwner(nil);
                                v96.CanCollide = true;
                                v96.CanQuery = true;
                                v96.CollisionGroup = "Ragdolls";
                            elseif v96:IsA("ParticleEmitter") then
                                v96.Enabled = true;
                            end;
                        end;
                        local l_v2_ClosestPlayerFromPosition_2 = v2:GetClosestPlayerFromPosition(v87.Rig.PrimaryPart.Position, {
                            MaxDistance = v87.Config.SubspacePingDistance, 
                            ReturnTable = true
                        });
                        for _, v99 in pairs(l_v2_ClosestPlayerFromPosition_2) do
                            local l_Player_1 = v99.Player;
                            local l_PlayerFromCharacter_1 = game.Players:GetPlayerFromCharacter(l_Player_1);
                            if l_PlayerFromCharacter_1 then
                                v2:RevealPlayerAuraTo(l_PlayerFromCharacter_1, v94, v87.Config.SubspacePingDuration, Color3.new(0.75, 1, 0.75), 100);
                            end;
                        end;
                        v94:SetAttribute("Invincible", true);
                        task.delay(1, function() --[[ Line: 483 ]]
                            -- upvalues: v94 (copy)
                            if not v94 then
                                return;
                            else
                                v94:SetAttribute("Invincible", nil);
                                return;
                            end;
                        end);
                        for _, v103 in pairs(l_SubspaceTripmine_0:GetDescendants()) do
                            if v103:IsA("BasePart") then
                                v103.Transparency = 1;
                            elseif v103:IsA("ParticleEmitter") then
                                v103.Enabled = false;
                            end;
                        end;
                        v1:Play(v87.Config.Sounds.SubspaceToss, {
                            Parent = v94.PrimaryPart
                        });
                        for _, v105 in pairs(v94:GetDescendants()) do
                            if v105:IsA("BasePart") then
                                v105.CanCollide = true;
                                if v105 ~= v94.PrimaryPart then
                                    local l_WeldConstraint_0 = Instance.new("WeldConstraint");
                                    l_WeldConstraint_0.Parent = v105;
                                    l_WeldConstraint_0.Part1 = v105;
                                    l_WeldConstraint_0.Part0 = v94.PrimaryPart;
                                end;
                                game.TweenService:Create(v105, TweenInfo.new(4, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
                                    Transparency = v87.Config.SubspaceHiddenTransparency
                                }):Play();
                            elseif v105:IsA("Light") then
                                v105.Brightness = 1;
                                v105.Range = v87.Config.SubspaceRange;
                                game.TweenService:Create(v105, TweenInfo.new(4, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
                                    Brightness = 0
                                }):Play();
                            elseif v105:IsA("ParticleEmitter") then
                                task.delay(4, function() --[[ Line: 516 ]]
                                    -- upvalues: v105 (copy)
                                    v105.Enabled = false;
                                end);
                            end;
                        end;
                        v94.PrimaryPart.Velocity = CFrame.lookAt(v87.Rig.PrimaryPart.Position, (v87.Rig.PrimaryPart.CFrame * CFrame.new(-1, 5, -10)).Position).LookVector * v87.Config.SubspaceThrowForce;
                        local l_Humanoid_1 = Instance.new("Humanoid");
                        l_Humanoid_1.EvaluateStateMachine = false;
                        l_Humanoid_1.BreakJointsOnDeath = false;
                        l_Humanoid_1.RequiresNeck = false;
                        l_Humanoid_1.Health = 1;
                        l_Humanoid_1.Parent = v94;
                        local v108 = false;
                        l_Humanoid_1.HealthChanged:Connect(function(v109) --[[ Line: 539 ]]
                            -- upvalues: v94 (copy), v87 (ref), v2 (ref), v4 (ref), v5 (ref)
                            if v109 > 0.1275 then
                                return;
                            else
                                for _, v111 in pairs(v94:GetDescendants()) do
                                    if v111:IsA("BasePart") then
                                        game.TweenService:Create(v111, TweenInfo.new(v87.Config.SubspaceExplosionDelay, Enum.EasingStyle.Linear), {
                                            Transparency = 0, 
                                            Size = v111.Size * 1.3
                                        }):Play();
                                    elseif v111:IsA("Light") then
                                        game.TweenService:Create(v111, TweenInfo.new(v87.Config.SubspaceExplosionDelay * 1.275), {
                                            Brightness = 12
                                        }):Play();
                                    elseif v111:IsA("ParticleEmitter") then
                                        v111.Enabled = true;
                                    end;
                                end;
                                task.delay(v87.Config.SubspaceExplosionDelay, function() --[[ Line: 556 ]]
                                    -- upvalues: v87 (ref), v94 (ref), v2 (ref), v4 (ref), v5 (ref)
                                    local v112 = (#v87 - 1) * v87.Config.SubspaceStackPenalty;
                                    local l_v94_BoundingBox_0, _ = v94:GetBoundingBox();
                                    local l_v2_ClosestPlayerFromPosition_3 = v2:GetClosestPlayerFromPosition(l_v94_BoundingBox_0.Position, {
                                        ReturnTable = true, 
                                        OverrideUndetectable = true, 
                                        IncludedSelection = {
                                            v87.Rig
                                        }, 
                                        PlayerSelection = "Killers", 
                                        MaxDistance = v87.Config.SubspaceRange
                                    });
                                    local v116 = nil;
                                    local v117 = nil;
                                    for _, v119 in pairs(l_v2_ClosestPlayerFromPosition_3) do
                                        if not v119.Player:GetAttribute("TaphSubspaced") or tick() > v119.Player:GetAttribute("TaphSubspaced") + v87.Config.SubspaceEffectDuration then
                                            if v119.Player == v87.Character then
                                                v116 = true;
                                            end;
                                            if tostring(v119.Player.Parent) == "Killers" then
                                                v117 = true;
                                            end;
                                            local v120 = v94:GetAttribute("RecentAttacker") == tostring(game.Players:GetPlayerFromCharacter(v119.Player));
                                            v4:ApplyStatus(v119.Player, "Subspaced", {
                                                Level = v120 and v87.Config.SubspaceEffectHitLevel or v87.Config.SubspaceEffectLevel, 
                                                Duration = v87.Config.SubspaceEffectDuration - v112
                                            });
                                            if not v119.Player:GetAttribute("Invincible") and not v120 then
                                                v4:ApplyStatus(v119.Player, "Helpless", {
                                                    Level = 1, 
                                                    Duration = v87.Config.SubspaceHelplessDuration - v112, 
                                                    TimeStackable = false
                                                });
                                            end;
                                            v119.Player:SetAttribute("TaphSubspaced", tick());
                                        end;
                                    end;
                                    if v117 then
                                        v87:SetCooldownOf("SubspaceTripmine", -v87.Config.SubspaceCooldownReductionOnSuccess);
                                    end;
                                    if v117 and not v116 then
                                        v5:IncrementActorStats(v87.Player, {
                                            Action = "Killer Triggered Subspace Tripmine", 
                                            RewardType = "Offensive"
                                        });
                                    end;
                                    require(game.ReplicatedStorage.Modules.Network):FireAllClientConnection("TaphAudioReplication", "REMOTE_EVENT", l_v94_BoundingBox_0);
                                    local v121 = v87.Config.SubspaceExplosionVFX:Clone();
                                    v121:SetPrimaryPartCFrame(CFrame.new(l_v94_BoundingBox_0.Position));
                                    v121.Name = "TaphTripmineVFX";
                                    v121.Parent = workspace.Map.Ingame;
                                    game.Debris:AddItem(v121, 2);
                                    for _, v123 in pairs(v121:GetDescendants()) do
                                        if v123:IsA("ParticleEmitter") then
                                            v123:Emit(v123:GetAttribute("EmitCount") or 5);
                                        elseif v123:IsA("Light") then
                                            game.TweenService:Create(v123, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                                Brightness = 0
                                            }):Play();
                                        end;
                                    end;
                                    v94:Destroy();
                                end);
                                return;
                            end;
                        end);
                        task.delay(3, function() --[[ Line: 616 ]]
                            -- upvalues: l_Humanoid_1 (copy), v94 (copy), v2 (ref), v87 (ref), v108 (ref), v1 (ref)
                            local v124 = 0;
                            local v125 = tick();
                            while l_Humanoid_1.Health > 0.125 and v94.PrimaryPart do
                                if v2:GetClosestPlayerFromPosition(v94.PrimaryPart.Position, {
                                    PlayerSelection = "Killers", 
                                    MaxDistance = v87.Config.SubspaceRange
                                }) or v87.Config.SubspaceLifetime <= v124 then
                                    v108 = true;
                                    l_Humanoid_1.Health = 0.125;
                                elseif v87.Config.SubspaceHintCount >= 1 and tick() >= v125 + v87.Config.SubspaceLifetime / (math.round(v87.Config.SubspaceHintCount) + 1) then
                                    v125 = tick();
                                    v1:Play(v87.Config.Sounds.SubspaceHint, {
                                        Parent = v94.PrimaryPart
                                    });
                                    for _, v127 in pairs(v94:GetDescendants()) do
                                        if v127:IsA("BasePart") then
                                            game.TweenService:Create(v127, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut, 0, true), {
                                                Transparency = v87.Config.SubspaceHintTransparency
                                            }):Play();
                                        elseif v127:IsA("Light") then
                                            game.TweenService:Create(v127, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut, 0, true), {
                                                Brightness = 0.5
                                            }):Play();
                                        end;
                                    end;
                                end;
                                v124 = v124 + task.wait();
                            end;
                        end);
                        return;
                    end;
                end);
                task.delay(4, function() --[[ Line: 650 ]]
                    -- upvalues: v87 (copy)
                    v87.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v87.Animations.ThrowSubspace:Play(0.05);
                    local l_v2_SpeedMultiplier_1 = v2:CreateSpeedMultiplier(v87.Rig, 0.6, "SubspaceTripmine");
                    task.delay(2, function() --[[ Line: 658 ]]
                        -- upvalues: l_v2_SpeedMultiplier_1 (copy)
                        l_v2_SpeedMultiplier_1:Destroy();
                    end);
                end;
                return;
            end;
        end
    }
};
v0.Created = function(_, v130) --[[ Line: 667 ]] --[[ Name: Created ]]
    -- upvalues: v2 (copy), v28 (copy), v1 (copy)
    if game["Run Service"]:IsClient() then
        local v131 = nil;
        v131 = workspace.Map.Ingame.ChildAdded:Connect(function(v132) --[[ Line: 670 ]]
            -- upvalues: v130 (copy), v131 (ref), v2 (ref)
            if not v130.Rig.Parent then
                v131:Disconnect();
                v131 = nil;
                return;
            else
                if v132.Name == "TaphTripmineVFX" and v2:GetSettingValue("EpilepsyMode") then
                    v132:Destroy();
                end;
                return;
            end;
        end);
        local v133 = false;
        v130.Rig:GetAttributeChangedSignal("TripwireOrigin"):Connect(function() --[[ Line: 680 ]]
            -- upvalues: v130 (copy), v133 (ref), v28 (ref)
            local l_Attribute_3 = v130.Rig:GetAttribute("TripwireOrigin");
            if l_Attribute_3 then
                v133 = true;
                local v135 = v130.Config.TripwireTemplate:Clone();
                v135.Name = "FakeHook";
                v135.Transparency = 1;
                v135.CanCollide = false;
                v135.CanQuery = false;
                v135.Material = Enum.Material.Neon;
                v135.Parent = workspace.Map.Ingame;
                v135.CFrame = l_Attribute_3 * v130.Config.TripwireCFrameOffset;
                game.TweenService:Create(v135, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Transparency = 0.65
                }):Play();
                if v135:IsA("UnionOperation") then
                    v135.UsePartColor = true;
                end;
                local l_Part_1 = Instance.new("Part");
                l_Part_1.Name = "FakeWire";
                l_Part_1.Transparency = 1;
                l_Part_1.Anchored = true;
                l_Part_1.CanCollide = false;
                l_Part_1.CanQuery = false;
                l_Part_1.Material = Enum.Material.Neon;
                l_Part_1.Parent = workspace.Map.Ingame;
                game.TweenService:Create(l_Part_1, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Transparency = 0.65
                }):Play();
                local function v142() --[[ Line: 713 ]] --[[ Name: updatePos ]]
                    -- upvalues: v130 (ref), l_Attribute_3 (copy), v28 (ref), l_Part_1 (copy), v135 (copy)
                    local v137 = v130.Rig.PrimaryPart.CFrame * CFrame.new(0, -2, -2) + Vector3.new(0, 0.30000001192092896, 0, 0);
                    local l_Magnitude_2 = (l_Attribute_3.Position - v137.Position).Magnitude;
                    local v139 = l_Attribute_3.Position:Lerp(v137.Position, 0.5);
                    local v140 = CFrame.lookAt(v139, v137.Position);
                    local v141 = v28(v130, v137 - Vector3.new(0, 0.30000001192092896, 0, 0), l_Attribute_3);
                    l_Part_1.Position = v139 + Vector3.new(0, 0.20000000298023224, 0, 0);
                    l_Part_1.CFrame = v140;
                    l_Part_1.Size = Vector3.new(0.1, 0.1, l_Magnitude_2);
                    l_Part_1.Color = v141 == "placed" and Color3.new(0.4, 1, 0.4) or Color3.new(1, 0.25, 0.25);
                    v135.Color = v141 == "placed" and Color3.new(0.4, 1, 0.4) or Color3.new(1, 0.25, 0.25);
                    if v130.Config.TripwireLookAt then
                        v135.CFrame = CFrame.new(v135.Position, v137.Position) * v130.Config.TripwireCFrameOffset;
                    end;
                end;
                v142();
                while task.wait() and v133 and v130.Rig.Parent do
                    v142();
                end;
                for _, v144 in pairs({
                    v135, 
                    l_Part_1
                }) do
                    game.TweenService:Create(v144, TweenInfo.new(1), {
                        Transparency = 1
                    }):Play();
                    game.Debris:AddItem(v144, 1);
                end;
                return;
            else
                v133 = false;
                return;
            end;
        end);
        require(game.ReplicatedStorage.Modules.Network):SetConnection("TaphAudioReplication", "REMOTE_EVENT", function(v145) --[[ Line: 749 ]]
            -- upvalues: v1 (ref), v2 (ref), v130 (copy)
            v1:Play(v2:GetSettingValue("SensitiveSFXMode") and v130.Config.Sounds.SubspaceDetonateSensitive or v130.Config.Sounds.SubspaceDetonate, {
                Position = v145.Position
            });
        end);
        return;
    else
        v130.CurrentTripwires = {};
        return;
    end;
end;
v0.Destroyed = function(_, _) --[[ Line: 758 ]] --[[ Name: Destroyed ]]
    require(game.ReplicatedStorage.Modules.Network):RemoveConnection("TaphAudioReplication", "REMOTE_EVENT");
end;
v0.LastManStanding = function(_, v149, _) --[[ Line: 763 ]] --[[ Name: LastManStanding ]]
    -- upvalues: v6 (copy)
    if not game["Run Service"]:IsServer() then
        return;
    else
        if v149.Player then
            local l_status_1, l_result_1 = pcall(function() --[[ Line: 768 ]]
                -- upvalues: v6 (ref), v149 (copy)
                v6:IncrementAchievementProgress(v149.Player, "TaphGetLastManStanding");
            end);
            if not l_status_1 then
                warn((("[%*/LastManStanding]: Failed to award %* the achievement: TaphGetLastManStanding due to: %*"):format(script.Parent, v149.Player, l_result_1)));
            end;
        end;
        return;
    end;
end;
v0.CreateTripwireHooks = function(_, v154, v155) --[[ Line: 778 ]] --[[ Name: CreateTripwireHooks ]]
    local l_Attribute_4 = v154.Rig:GetAttribute("TripwireOrigin");
    local l_Attribute_5 = v154.Rig:GetAttribute("TripwireEnding");
    local v158 = v154.Config.TripwireTemplate:Clone();
    v158.Name = "Hook1";
    v158.Parent = v155;
    v158.CFrame = l_Attribute_4 * v154.Config.TripwireCFrameOffset;
    local v159 = v154.Config.TripwireTemplate:Clone();
    v159.Name = "Hook2";
    v159.Parent = v155;
    v159.CFrame = l_Attribute_5 * v154.Config.TripwireCFrameOffset;
    return v158, v159;
end;
return v0;