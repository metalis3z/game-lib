-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
local v5 = require(game.ReplicatedStorage.Modules.Actors);
local function v18(v6, v7, v8) --[[ Line: 11 ]] --[[ Name: checkPlacement ]]
    local l_workspace_PartBoundsInRadius_0 = workspace:GetPartBoundsInRadius(v7.Position, 0.25);
    for _, v11 in pairs(l_workspace_PartBoundsInRadius_0) do
        if v11.Transparency < 0.9 or v11.Name == "UnplacableArea" then
            return "collision";
        end;
    end;
    for _, v13 in pairs(workspace.Map.Ingame:GetChildren()) do
        if v13.Name:find("TaphTripwire") then
            for _, v15 in pairs(v13:GetChildren()) do
                if v15.Name:find("Hook") and (v6.Rig.PrimaryPart.Position - v15.Position).Magnitude < v6.Config.TripwireDistanceBetweenTripwires then
                    return "tooClose";
                end;
            end;
        end;
    end;
    local v16 = RaycastParams.new();
    v16.FilterType = Enum.RaycastFilterType.Exclude;
    v16.FilterDescendantsInstances = {
        workspace.Players
    };
    if not workspace:Raycast(v7.Position, Vector3.new(0, -2, 0, 0), v16) then
        return "midair";
    elseif workspace:Raycast(v6.Rig.PrimaryPart.Position, v6.Rig.PrimaryPart.CFrame.LookVector * 2, v16) then
        return "facingWall";
    else
        if v8 then
            local l_Magnitude_0 = (v7.Position - v8.Position).Magnitude;
            if workspace:Raycast(v8.Position, CFrame.lookAt(v8.Position, v7.Position).LookVector * l_Magnitude_0, v16) then
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
        Callback = function(v19, v20) --[[ Line: 84 ]] --[[ Name: Callback ]]
            -- upvalues: v18 (copy), v4 (copy), v2 (copy), v5 (copy)
            if game["Run Service"]:IsServer() then
                v19.DisabledAbilities = {
                    SubspaceTripmine = true
                };
                local v21 = v19.Rig.PrimaryPart.CFrame * CFrame.new(0, -2, -2);
                local l_Attribute_0 = v19.Rig:GetAttribute("TripwireOrigin");
                if l_Attribute_0 then
                    local v23 = v18(v19, v21, l_Attribute_0);
                    if v23 ~= "placed" then
                        v19.DisabledAbilities = nil;
                        return {
                            Cancelled = true, 
                            Reason = v23
                        };
                    else
                        v19.Rig:SetAttribute("TripwireEnding", v21);
                        v19.Placing = nil;
                    end;
                else
                    local v24 = v18(v19, v21);
                    if v24 ~= "placed" then
                        v19.DisabledAbilities = nil;
                        return {
                            Cancelled = true, 
                            Reason = v24
                        };
                    else
                        v19.Placing = true;
                        v19:SetCooldownOf("Tripwire", v19.Config.TripwireCooldownWhilePlacing);
                        v19.Rig:SetAttribute("PlacingTripwire", true);
                        v19.Rig:SetAttribute("TripwireOrigin", v19.Rig.PrimaryPart.CFrame * CFrame.new(0, -2, -2));
                        local l_Health_0 = v19.Rig.Humanoid.Health;
                        local v26 = nil;
                        v26 = v19.Rig.Humanoid.HealthChanged:Connect(function(v27) --[[ Line: 125 ]]
                            -- upvalues: l_Health_0 (copy), v19 (copy)
                            if v27 + 4.75 < l_Health_0 then
                                v19.Placing = nil;
                            end;
                        end);
                        do
                            local l_v26_0 = v26;
                            task.spawn(function() --[[ Line: 132 ]]
                                -- upvalues: v19 (copy), l_v26_0 (ref), v4 (ref), v2 (ref), v5 (ref)
                                repeat
                                    task.wait();
                                until not v19.Rig.Parent or not v19.Placing;
                                if not v19.Rig.Parent then
                                    return;
                                else
                                    l_v26_0:Disconnect();
                                    v19.AbilitiesDisabled = true;
                                    v19.DisabledAbilities = nil;
                                    task.delay(2, function() --[[ Line: 142 ]]
                                        -- upvalues: v19 (ref)
                                        v19.AbilitiesDisabled = false;
                                    end);
                                    local l_Attribute_1 = v19.Rig:GetAttribute("TripwireOrigin");
                                    local l_Attribute_2 = v19.Rig:GetAttribute("TripwireEnding");
                                    if l_Attribute_1 and l_Attribute_2 then
                                        local l_Model_0 = Instance.new("Model");
                                        l_Model_0.Name = ("%*TaphTripwire"):format((tostring(v19.Player)));
                                        l_Model_0.Parent = workspace.Map.Ingame;
                                        l_Model_0:SetAttribute("HitboxPriority", 0);
                                        local v32 = v19.Config.TripwireTemplate:Clone();
                                        v32.Name = "Hook1";
                                        v32.CanCollide = false;
                                        v32.Parent = l_Model_0;
                                        v32.CFrame = l_Attribute_1 * CFrame.Angles(0, 0, 1.5707963267948966);
                                        local v33 = v19.Config.TripwireTemplate:Clone();
                                        v33.Name = "Hook2";
                                        v33.CanCollide = false;
                                        v33.Parent = l_Model_0;
                                        v33.CFrame = l_Attribute_2 * CFrame.Angles(0, 0, 1.5707963267948966);
                                        local l_Magnitude_1 = (l_Attribute_1.Position - l_Attribute_2.Position).Magnitude;
                                        local v35 = l_Attribute_1.Position:Lerp(l_Attribute_2.Position, 0.5);
                                        local v36 = CFrame.lookAt(v35, l_Attribute_2.Position);
                                        local l_Part_0 = Instance.new("Part");
                                        l_Part_0.Name = "Wire";
                                        l_Part_0.Transparency = 1;
                                        l_Part_0.Anchored = true;
                                        l_Part_0.CanCollide = false;
                                        l_Part_0.CanQuery = true;
                                        l_Part_0.Size = Vector3.new(0.1, 0.1, l_Magnitude_1);
                                        l_Part_0.Position = v35 + Vector3.new(0, 0.20000000298023224, 0, 0);
                                        l_Part_0.CFrame = v36;
                                        l_Part_0.Parent = l_Model_0;
                                        game.TweenService:Create(l_Part_0, TweenInfo.new(1), {
                                            Transparency = 0.75
                                        }):Play();
                                        task.delay(1, function() --[[ Line: 186 ]]
                                            -- upvalues: l_Part_0 (copy)
                                            game.TweenService:Create(l_Part_0, TweenInfo.new(20, Enum.EasingStyle.Linear), {
                                                Transparency = 0.8
                                            }):Play();
                                        end);
                                        local l_Humanoid_0 = Instance.new("Humanoid");
                                        l_Humanoid_0.Parent = l_Model_0;
                                        l_Humanoid_0.MaxHealth = v19.Config.TripwireHealth;
                                        l_Humanoid_0.Health = v19.Config.TripwireHealth;
                                        l_Model_0:SetAttribute("ExecutionsDisabled", true);
                                        l_Model_0:SetAttribute("Team", "Survivors");
                                        l_Model_0.PrimaryPart = l_Part_0;
                                        l_Model_0:SetAttribute("Invincible", true);
                                        task.delay(1, function() --[[ Line: 203 ]]
                                            -- upvalues: l_Model_0 (copy)
                                            l_Model_0:SetAttribute("Invincible", nil);
                                        end);
                                        local v39 = false;
                                        do
                                            local l_v39_0 = v39;
                                            local function v43() --[[ Line: 209 ]] --[[ Name: removeTripwire ]]
                                                -- upvalues: l_v39_0 (ref), l_Part_0 (copy), l_Model_0 (copy)
                                                if not l_v39_0 then
                                                    l_v39_0 = true;
                                                    l_Part_0.Anchored = false;
                                                    l_Part_0:ApplyImpulse((Vector3.new(0, 0.05000000074505806, 0, 0)));
                                                    game.Debris:AddItem(l_Model_0, 1.5);
                                                    for _, v42 in pairs(l_Model_0:GetChildren()) do
                                                        if v42:IsA("BasePart") then
                                                            game.TweenService:Create(v42, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                                                Transparency = 1
                                                            }):Play();
                                                        end;
                                                    end;
                                                end;
                                            end;
                                            if #v19.CurrentTripwires >= v19.Config.TripwireMaxAmount then
                                                table.remove(v19.CurrentTripwires, 1).Remove();
                                            end;
                                            table.insert(v19.CurrentTripwires, {
                                                Model = l_Model_0, 
                                                Remove = v43
                                            });
                                            local v44 = false;
                                            l_Part_0.Touched:Connect(function(v45) --[[ Line: 235 ]]
                                                -- upvalues: v44 (ref), l_v39_0 (ref), v43 (copy), v19 (ref), v4 (ref), v2 (ref), v5 (ref)
                                                local l_v45_FirstAncestorOfClass_0 = v45:FindFirstAncestorOfClass("Model");
                                                if l_v45_FirstAncestorOfClass_0 and tostring(l_v45_FirstAncestorOfClass_0.Parent) == "Killers" and not v44 and not l_v39_0 then
                                                    v44 = true;
                                                    v43();
                                                    if not l_v45_FirstAncestorOfClass_0:GetAttribute("Invincible") then
                                                        local v47 = {
                                                            Duration = v19.Config.TripwireTriggerSlownessData.Duration, 
                                                            Level = math.clamp(v19.Config.TripwireTriggerSlownessData.Level - (#v19 - 1), 1, v19.Config.TripwireTriggerSlownessData.Level)
                                                        };
                                                        v4:ApplyStatus(l_v45_FirstAncestorOfClass_0, "Slowness", v47);
                                                    end;
                                                    local v48 = l_v45_FirstAncestorOfClass_0:GetAttribute("Invincible") and v19.Config.TripwireTriggerAuraRevealInvincibleDuration or v19.Config.TripwireTriggerAuraRevealDuration;
                                                    local l_v2_ClosestPlayerFromPosition_0 = v2:GetClosestPlayerFromPosition(v19.Rig.PrimaryPart.Position, {
                                                        ReturnTable = true, 
                                                        MaxDistance = v19.Config.TripwireTriggerAuraRevealDistance, 
                                                        PlayerSelection = "Survivors"
                                                    });
                                                    for _, v51 in pairs(l_v2_ClosestPlayerFromPosition_0) do
                                                        v2:RevealPlayerAuraTo(v51.Player, l_v45_FirstAncestorOfClass_0, v48);
                                                    end;
                                                    if not l_v45_FirstAncestorOfClass_0:GetAttribute((("TripwireTriggerTime%*"):format((tostring(v19.Player))))) or l_v45_FirstAncestorOfClass_0:GetAttribute((("TripwireTriggerTime%*"):format((tostring(v19.Player))))) <= tick() - v19.Config.TripwireDurationBetweenRewards then
                                                        l_v45_FirstAncestorOfClass_0:SetAttribute(("TripwireTriggerTime%*"):format((tostring(v19.Player))), tick());
                                                        v5:IncrementActorStats(v19.Player, {
                                                            Action = "Killer Triggered Tripwire", 
                                                            RewardType = "Survivalist"
                                                        });
                                                    end;
                                                end;
                                            end);
                                            l_Humanoid_0.HealthChanged:Connect(function(v52) --[[ Line: 269 ]]
                                                -- upvalues: l_v39_0 (ref), v43 (copy), l_Part_0 (copy), v2 (ref), v19 (ref)
                                                print(v52, l_v39_0);
                                                if v52 > 0 or l_v39_0 then
                                                    return;
                                                else
                                                    v43();
                                                    local v53 = OverlapParams.new();
                                                    v53.FilterType = Enum.RaycastFilterType.Include;
                                                    v53.FilterDescendantsInstances = {
                                                        workspace.Players.Killers
                                                    };
                                                    local v54 = {};
                                                    local l_workspace_PartBoundsInBox_0 = workspace:GetPartBoundsInBox(l_Part_0.CFrame, l_Part_0.Size + Vector3.new(7, 7, 7, 0), v53);
                                                    for _, v57 in pairs(l_workspace_PartBoundsInBox_0) do
                                                        local l_v57_FirstAncestor_0 = v57:FindFirstAncestor("Model");
                                                        if l_v57_FirstAncestor_0 and not v54[l_v57_FirstAncestor_0] then
                                                            v54[l_v57_FirstAncestor_0] = true;
                                                            for _, v60 in pairs(workspace.Players.Survivors:GetChildren()) do
                                                                v2:RevealPlayerAuraTo(v60, l_v57_FirstAncestor_0, v19.Config.TripwireDestroyedAuraDuration);
                                                            end;
                                                        end;
                                                    end;
                                                    return;
                                                end;
                                            end);
                                            task.delay(v19.Config.TripwireLifetime - (#v19 - 1) * v19.Config.TripwireLifetimeDecreasePerTaph, v43);
                                        end;
                                    end;
                                    v19:SetCooldownOf("Tripwire", v19.Config.TripwireCooldown);
                                    v19.Rig:SetAttribute("PlacingTripwire", nil);
                                    v19.Rig:SetAttribute("TripwireOrigin", nil);
                                    v19.Rig:SetAttribute("TripwireEnding", nil);
                                    return;
                                end;
                            end);
                        end;
                    end;
                end;
                task.delay(v19.Config.TripwireCooldownWhilePlacing, function() --[[ Line: 304 ]]
                    -- upvalues: v19 (copy)
                    v19.AbilitiesDisabled = false;
                end);
                return v19.Placing;
            else
                if game["Run Service"]:IsClient() then
                    if typeof(v20) == "table" and v20.Cancelled then
                        local v61 = {
                            collision = "Tripwire placement point is obstructed by something. Move back a bit.", 
                            tooClose = "Tripwire placement point is too close to another tripwire.", 
                            midair = "Tripwire placement point is too high above ground. Turn around and try again.", 
                            facingWall = "You're too close to a wall. Turn around and try again.", 
                            intersecting = "Your tripwire's intersecting with a wall. Make sure that there's nothing blocking its origin & end points.", 
                            unknown = "Something went wrong. Try placing the tripwire somewhere else."
                        };
                        local v62 = v61[v20.Reason] or v61.unknown;
                        v2:CreateWarning("BuildermanWarning", v62, v19.Config.WarningTemplate);
                        return;
                    elseif v20 == true then
                        v19.AnimationType = "Tripwire";
                        v19.Animations.TripwireIdle:Play();
                        v19.Animations.TripwirePlaceStart:Play(0.025);
                        v19.MovementAnimSpeed = 1;
                        v2:ToggleSprinting("TaphTripwire", false);
                        local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v19.Rig, 1, "TaphTripwire");
                        game.TweenService:Create(l_v2_SpeedMultiplier_0, TweenInfo.new(0.25), {
                            Value = 0
                        }):Play();
                        local v64 = false;
                        local l_Health_1 = v19.Rig.Humanoid.Health;
                        local v66 = nil;
                        do
                            local l_v64_0, l_v66_0 = v64, v66;
                            l_v66_0 = v19.Rig.Humanoid.HealthChanged:Connect(function(v69) --[[ Line: 347 ]]
                                -- upvalues: l_Health_1 (copy), l_v64_0 (ref)
                                if v69 + 4.75 < l_Health_1 then
                                    l_v64_0 = true;
                                end;
                            end);
                            task.delay(1, function() --[[ Line: 354 ]]
                                -- upvalues: l_v2_SpeedMultiplier_0 (copy), v19 (copy), l_v64_0 (ref), l_v66_0 (ref), v2 (ref)
                                game.TweenService:Create(l_v2_SpeedMultiplier_0, TweenInfo.new(1), {
                                    Value = v19.Config.TripwireSpeedWhilePlacing / v19.Config.Speed
                                }):Play();
                                repeat
                                    task.wait();
                                until not v19.Rig:GetAttribute("PlacingTripwire") or not v19.Rig.Parent or l_v64_0;
                                if not v19.Rig.Parent then
                                    return;
                                else
                                    l_v66_0:Disconnect();
                                    v19.AnimationType = nil;
                                    v19.Animations.TripwireIdle:Stop();
                                    v19.Animations.TripwirePlaceEnd:Play(0);
                                    v19.MovementAnimSpeed = nil;
                                    if l_v64_0 then
                                        l_v2_SpeedMultiplier_0:Destroy();
                                        v2:ToggleSprinting("TaphTripwire", true);
                                        v19.Animations.TripwirePlaceEnd:Stop(0.2);
                                        return;
                                    else
                                        l_v2_SpeedMultiplier_0.Value = 0;
                                        task.delay(0.5, function() --[[ Line: 379 ]]
                                            -- upvalues: v2 (ref), l_v2_SpeedMultiplier_0 (ref)
                                            v2:ToggleSprinting("TaphTripwire", true);
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
        Callback = function(v70, _) --[[ Line: 397 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v2 (copy), v4 (copy), v5 (copy)
            if game["Run Service"]:IsServer() then
                v70.AbilitiesDisabled = true;
                local l_SubspaceTripmine_0 = v70.Rig.SubspaceTripmine;
                for _, v74 in pairs(l_SubspaceTripmine_0:GetChildren()) do
                    v74.Transparency = 0;
                end;
                task.delay(1.98, function() --[[ Line: 405 ]]
                    -- upvalues: v70 (copy), l_SubspaceTripmine_0 (copy), v1 (ref), v2 (ref), v4 (ref), v5 (ref)
                    if not v70.Rig.Parent or not v70.Rig.PrimaryPart or v70.Rig.PrimaryPart.Anchored or v70.Rig.Humanoid.Health <= 0 then
                        for _, v76 in pairs(l_SubspaceTripmine_0:GetChildren()) do
                            v76.Transparency = 1;
                        end;
                        return;
                    else
                        local v77 = l_SubspaceTripmine_0:Clone();
                        v77:SetAttribute("Team", "Survivors");
                        v77:SetAttribute("ExecutionsDisabled", true);
                        v77.Parent = workspace.Map.Ingame;
                        for _, v79 in pairs(v77:GetDescendants()) do
                            if v79:IsA("BasePart") then
                                v79.Transparency = 0;
                                v79.CanCollide = true;
                                v79.CanQuery = true;
                                v79.CollisionGroup = "Ragdolls";
                            end;
                        end;
                        v77:SetAttribute("Invincible", true);
                        task.delay(1, function() --[[ Line: 426 ]]
                            -- upvalues: v77 (copy)
                            v77:SetAttribute("Invincible", nil);
                        end);
                        for _, v81 in pairs(l_SubspaceTripmine_0:GetChildren()) do
                            v81.Transparency = 1;
                        end;
                        v1:Play(v70.Config.Sounds.SubspaceToss, {
                            Parent = v77.PrimaryPart
                        });
                        for _, v83 in pairs(v77:GetDescendants()) do
                            if v83:IsA("BasePart") then
                                v83.CanCollide = true;
                                if v83 ~= v77.PrimaryPart then
                                    local l_WeldConstraint_0 = Instance.new("WeldConstraint");
                                    l_WeldConstraint_0.Parent = v83;
                                    l_WeldConstraint_0.Part1 = v83;
                                    l_WeldConstraint_0.Part0 = v77.PrimaryPart;
                                end;
                                game.TweenService:Create(v83, TweenInfo.new(4, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
                                    Transparency = v70.Config.SubspaceHiddenTransparency
                                }):Play();
                            elseif v83:IsA("Light") then
                                v83.Brightness = 1;
                                v83.Range = v70.Config.SubspaceRange;
                                game.TweenService:Create(v83, TweenInfo.new(4, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
                                    Brightness = 0
                                }):Play();
                            end;
                        end;
                        v77.PrimaryPart.Velocity = CFrame.lookAt(v70.Rig.PrimaryPart.Position, (v70.Rig.PrimaryPart.CFrame * CFrame.new(-1, 5, -10)).Position).LookVector * v70.Config.SubspaceThrowForce;
                        local l_Humanoid_1 = Instance.new("Humanoid");
                        l_Humanoid_1.EvaluateStateMachine = false;
                        l_Humanoid_1.BreakJointsOnDeath = false;
                        l_Humanoid_1.RequiresNeck = false;
                        l_Humanoid_1.Health = 1;
                        l_Humanoid_1.Parent = v77;
                        local v86 = false;
                        l_Humanoid_1.HealthChanged:Connect(function(v87) --[[ Line: 471 ]]
                            -- upvalues: v77 (copy), v70 (ref), v2 (ref), v4 (ref), v5 (ref), v1 (ref)
                            if v87 > 0.1275 then
                                return;
                            else
                                for _, v89 in pairs(v77:GetDescendants()) do
                                    if v89:IsA("BasePart") then
                                        game.TweenService:Create(v89, TweenInfo.new(v70.Config.SubspaceExplosionDelay, Enum.EasingStyle.Linear), {
                                            Transparency = 0, 
                                            Size = v89.Size * 1.3
                                        }):Play();
                                    elseif v89:IsA("Light") then
                                        game.TweenService:Create(v89, TweenInfo.new(v70.Config.SubspaceExplosionDelay * 1.275), {
                                            Brightness = 12
                                        }):Play();
                                    end;
                                end;
                                task.delay(v70.Config.SubspaceExplosionDelay, function() --[[ Line: 486 ]]
                                    -- upvalues: v77 (ref), v2 (ref), v70 (ref), v4 (ref), v5 (ref), v1 (ref)
                                    local l_v77_BoundingBox_0, _ = v77:GetBoundingBox();
                                    local l_v2_ClosestPlayerFromPosition_1 = v2:GetClosestPlayerFromPosition(l_v77_BoundingBox_0.Position, {
                                        ReturnTable = true, 
                                        OverrideUndetectable = true, 
                                        IncludedSelection = {
                                            v70.Rig
                                        }, 
                                        PlayerSelection = "Killers", 
                                        MaxDistance = v70.Config.SubspaceRange
                                    });
                                    local v93 = nil;
                                    local v94 = nil;
                                    for _, v96 in pairs(l_v2_ClosestPlayerFromPosition_1) do
                                        if not v96.Player:GetAttribute("TaphSubspaced") or tick() > v96.Player:GetAttribute("TaphSubspaced") + v70.Config.SubspaceEffectDuration then
                                            if v96.Player == v70.Character then
                                                v93 = true;
                                            end;
                                            if tostring(v96.Player.Parent) == "Killers" then
                                                v94 = true;
                                            end;
                                            local v97 = v77:GetAttribute("RecentAttacker") == tostring(game.Players:GetPlayerFromCharacter(v96.Player));
                                            v4:ApplyStatus(v96.Player, "Subspaced", {
                                                Level = v97 and v70.Config.SubspaceEffectHitLevel or v70.Config.SubspaceEffectLevel, 
                                                Duration = v70.Config.SubspaceEffectDuration
                                            });
                                            if not v96.Player:GetAttribute("Invincible") and not v97 then
                                                v4:ApplyStatus(v96.Player, "Helpless", {
                                                    Level = 1, 
                                                    Duration = v70.Config.SubspaceHelplessDuration
                                                });
                                            end;
                                            v96.Player:SetAttribute("TaphSubspaced", tick());
                                        end;
                                    end;
                                    if v94 then
                                        v70:SetCooldownOf("SubspaceTripmine", -v70.Config.SubspaceCooldownReductionOnSuccess);
                                    end;
                                    if v94 and not v93 then
                                        v5:IncrementActorStats(v70.Player, {
                                            Action = "Killer Triggered Subspace Tripmine", 
                                            RewardType = "Offensive"
                                        });
                                    end;
                                    v1:Play(v70.Config.Sounds.SubspaceDetonate, {
                                        Position = l_v77_BoundingBox_0.Position
                                    });
                                    local v98 = v70.Config.SubspaceExplosionVFX:Clone();
                                    v98:SetPrimaryPartCFrame(l_v77_BoundingBox_0);
                                    v98.Parent = workspace.Map.Ingame;
                                    game.Debris:AddItem(v98, 2);
                                    for _, v100 in pairs(v98:GetDescendants()) do
                                        if v100:IsA("ParticleEmitter") then
                                            v100:Emit(v100:GetAttribute("EmitCount") or 5);
                                        elseif v100:IsA("Light") then
                                            game.TweenService:Create(v100, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                                Brightness = 0
                                            }):Play();
                                        end;
                                    end;
                                    v77:Destroy();
                                end);
                                return;
                            end;
                        end);
                        task.delay(3, function() --[[ Line: 542 ]]
                            -- upvalues: l_Humanoid_1 (copy), v77 (copy), v2 (ref), v70 (ref), v86 (ref), v1 (ref)
                            local v101 = 0;
                            local v102 = tick();
                            while l_Humanoid_1.Health > 0.125 and v77.PrimaryPart do
                                if v2:GetClosestPlayerFromPosition(v77.PrimaryPart.Position, {
                                    PlayerSelection = "Killers", 
                                    MaxDistance = v70.Config.SubspaceRange
                                }) or v70.Config.SubspaceLifetime <= v101 then
                                    v86 = true;
                                    l_Humanoid_1.Health = 0.125;
                                elseif v70.Config.SubspaceHintCount >= 1 and tick() >= v102 + v70.Config.SubspaceLifetime / (math.round(v70.Config.SubspaceHintCount) + 1) then
                                    v102 = tick();
                                    v1:Play(v70.Config.Sounds.SubspaceHint, {
                                        Parent = v77.PrimaryPart
                                    });
                                    for _, v104 in pairs(v77:GetDescendants()) do
                                        if v104:IsA("BasePart") then
                                            game.TweenService:Create(v104, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut, 0, true), {
                                                Transparency = v70.Config.SubspaceHintTransparency
                                            }):Play();
                                        elseif v104:IsA("Light") then
                                            game.TweenService:Create(v104, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut, 0, true), {
                                                Brightness = 0.5
                                            }):Play();
                                        end;
                                    end;
                                end;
                                v101 = v101 + task.wait();
                            end;
                        end);
                        return;
                    end;
                end);
                task.delay(4, function() --[[ Line: 576 ]]
                    -- upvalues: v70 (copy)
                    v70.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v70.Animations.ThrowSubspace:Play(0.05);
                    local l_v2_SpeedMultiplier_1 = v2:CreateSpeedMultiplier(v70.Rig, 0.25, "SubspaceTripmine");
                    local v106 = require(game.ReplicatedStorage.Modules.Network);
                    v106:FireConnection("DisableSprinting", "SubspaceTripmine", true);
                    task.delay(2, function() --[[ Line: 587 ]]
                        -- upvalues: l_v2_SpeedMultiplier_1 (copy), v106 (copy)
                        l_v2_SpeedMultiplier_1:Destroy();
                        v106:FireConnection("DisableSprinting", "SubspaceTripmine", false);
                    end);
                end;
                return;
            end;
        end
    }
};
v0.Created = function(_, v108) --[[ Line: 597 ]] --[[ Name: Created ]]
    -- upvalues: v18 (copy)
    if game["Run Service"]:IsClient() then
        local v109 = false;
        v108.Rig:GetAttributeChangedSignal("TripwireOrigin"):Connect(function() --[[ Line: 600 ]]
            -- upvalues: v108 (copy), v109 (ref), v18 (ref)
            local l_Attribute_3 = v108.Rig:GetAttribute("TripwireOrigin");
            if l_Attribute_3 then
                v109 = true;
                local v111 = v108.Config.TripwireTemplate:Clone();
                v111.Name = "FakeHook";
                v111.Transparency = 1;
                v111.UsePartColor = true;
                v111.CanCollide = false;
                v111.CanQuery = false;
                v111.Material = Enum.Material.Neon;
                v111.Parent = workspace.Map.Ingame;
                v111.CFrame = l_Attribute_3 * CFrame.Angles(0, 0, 1.5707963267948966);
                game.TweenService:Create(v111, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Transparency = 0.65
                }):Play();
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
                local function v118() --[[ Line: 630 ]] --[[ Name: updatePos ]]
                    -- upvalues: v108 (ref), l_Attribute_3 (copy), v18 (ref), l_Part_1 (copy), v111 (copy)
                    local v113 = v108.Rig.PrimaryPart.CFrame * CFrame.new(0, -2, -2) + Vector3.new(0, 0.30000001192092896, 0, 0);
                    local l_Magnitude_2 = (l_Attribute_3.Position - v113.Position).Magnitude;
                    local v115 = l_Attribute_3.Position:Lerp(v113.Position, 0.5);
                    local v116 = CFrame.lookAt(v115, v113.Position);
                    local v117 = v18(v108, v113 - Vector3.new(0, 0.30000001192092896, 0, 0), l_Attribute_3);
                    l_Part_1.Position = v115 + Vector3.new(0, 0.20000000298023224, 0, 0);
                    l_Part_1.CFrame = v116;
                    l_Part_1.Size = Vector3.new(0.1, 0.1, l_Magnitude_2);
                    l_Part_1.Color = v117 == "placed" and Color3.new(0.4, 1, 0.4) or Color3.new(1, 0.25, 0.25);
                    v111.Color = v117 == "placed" and Color3.new(0.4, 1, 0.4) or Color3.new(1, 0.25, 0.25);
                end;
                v118();
                while task.wait() and v109 and v108.Rig.Parent do
                    v118();
                end;
                for _, v120 in pairs({
                    v111, 
                    l_Part_1
                }) do
                    game.TweenService:Create(v120, TweenInfo.new(1), {
                        Transparency = 1
                    }):Play();
                    game.Debris:AddItem(v120, 1);
                end;
                return;
            else
                v109 = false;
                return;
            end;
        end);
        return;
    else
        v108.CurrentTripwires = {};
        return;
    end;
end;
return v0;