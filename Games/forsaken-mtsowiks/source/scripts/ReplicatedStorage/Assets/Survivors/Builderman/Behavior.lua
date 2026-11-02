-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
local _ = require(game.ReplicatedStorage.Modules.Network);
local function v23(v6, v7) --[[ Line: 10 ]] --[[ Name: destroyBuilding ]]
    -- upvalues: v1 (copy)
    if v7:GetAttribute("Destroyed") then
        return;
    else
        v7:SetAttribute("Destroyed", true);
        for _, v9 in pairs(v7:GetDescendants()) do
            if v9:IsA("WeldConstraint") or v9:IsA("JointInstance") then
                v9:Destroy();
            elseif v9:IsA("ParticleEmitter") or v9:IsA("Light") then
                v9.Enabled = false;
            end;
        end;
        for _, v11 in pairs(v7:GetDescendants()) do
            if v11:IsA("Sound") then
                game.TweenService:Create(v11, TweenInfo.new(0.25), {
                    Volume = 0
                }):Play();
            end;
        end;
        if v6 then
            local v12 = string.gsub(v7.Name, "Builderman", "");
            local _ = v1:Play(v6.Config.Sounds[("%*Destroyed"):format(v12)], {
                Parent = v7.PrimaryPart
            });
            local _ = v1:PlayVoiceline(v6, ("%*Destroyed"):format(v12), {
                Priority = 4
            });
        end;
        for _, v16 in pairs(v7:GetChildren()) do
            if v16:IsA("BasePart") and v16.Transparency <= 0.5 then
                local l_Fire_0 = Instance.new("Fire");
                l_Fire_0.Parent = v16;
                l_Fire_0.Heat = v16.Size.Magnitude / 5;
                l_Fire_0.Size = v16.Size.Magnitude;
                v16.CanCollide = true;
                task.delay(math.random(400, 600) / 100, function() --[[ Line: 51 ]]
                    -- upvalues: v16 (copy), l_Fire_0 (copy)
                    game.TweenService:Create(v16, TweenInfo.new(3), {
                        Transparency = 1
                    }):Play();
                    game.TweenService:Create(l_Fire_0, TweenInfo.new(2), {
                        Heat = 0, 
                        Size = 0
                    }):Play();
                    task.wait(1);
                    l_Fire_0.Enabled = false;
                end);
            end;
        end;
        local v18 = {};
        for _, v20 in pairs(workspace.Map.Ingame:GetChildren()) do
            if v20.Name == v7.Name and not v20:GetAttribute("Destroyed") then
                table.insert(v18, v20);
            end;
        end;
        for _, v22 in pairs(v18) do
            v22:SetAttribute("BuildingCount", #v18);
        end;
        game.Debris:AddItem(v7, 10);
        return;
    end;
end;
local function _(v24, v25) --[[ Line: 77 ]] --[[ Name: getBuildingPointFormula ]]
    if v24 == "Sentry" then
        return (math.ceil((math.clamp(v25 ^ 0.5 * 1.2, 0, 20))));
    elseif v24 == "Dispenser" then
        return (math.ceil((math.clamp(v25 ^ 0.95 * 0.35, 0, 20))));
    else
        return;
    end;
end;
local function v85(v27, v28, v29) --[[ Line: 85 ]] --[[ Name: constructBuilding ]]
    -- upvalues: v23 (copy), v2 (copy), v1 (copy)
    v27.AbilitiesDisabled = true;
    local function v44(v30) --[[ Line: 90 ]] --[[ Name: checkPlacement ]]
        -- upvalues: v27 (copy), v28 (copy)
        local l_workspace_PartBoundsInRadius_0 = workspace:GetPartBoundsInRadius(v30.Position, 1);
        for _, v33 in pairs(l_workspace_PartBoundsInRadius_0) do
            if v33.Transparency < 0.9 or v33.Name == "UnplacableArea" then
                return "collision";
            end;
        end;
        for _, v35 in pairs(workspace.Map.Ingame:GetChildren()) do
            if v35.Name:find("Builderman") and not v35:GetAttribute("Destroyed") then
                local v36 = string.gsub(v35.Name, "Builderman", "");
                local v37 = v27.Config[("%*PlacementRadius"):format(v36)] or v27.Config[("%*PlacementRadius"):format(v28)];
                if (v30.Position - v35.PrimaryPart.Position).Magnitude <= v37 / 2 then
                    return "tooClose";
                end;
            end;
        end;
        for _, v39 in pairs(workspace.Players.Survivors:GetChildren()) do
            local l_v39_Attribute_0 = v39:GetAttribute("PlacementRadius");
            local l_PrimaryPart_0 = v39.PrimaryPart;
            if v39 ~= v27.Rig and l_v39_Attribute_0 and l_PrimaryPart_0 and (v30.Position - l_PrimaryPart_0.Position).Magnitude <= l_v39_Attribute_0 / 2 then
                return "tooClose";
            end;
        end;
        local v42 = RaycastParams.new();
        v42.FilterType = Enum.RaycastFilterType.Exclude;
        v42.RespectCanCollide = true;
        v42.CollisionGroup = "Survivors";
        v42.FilterDescendantsInstances = {
            workspace.Players
        };
        local v43 = workspace:Raycast(v30.Position, Vector3.new(0, -4, 0, 0), v42);
        if not v43 then
            return "midair";
        elseif v43 and v43.Instance.Name == "Conveyor" then
            return "collision";
        elseif workspace:Raycast(v27.Rig.PrimaryPart.Position, v27.Rig.PrimaryPart.CFrame.LookVector * v27.Config[("%*PositionOffset"):format(v28)], v42) then
            return "facingWall";
        else
            v27.Rig:SetAttribute("PlacementRadius", v27.Config[("%*PlacementRadius"):format(v28)] or 70);
            return "placed";
        end;
    end;
    local v45 = v27.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -v27.Config[("%*PositionOffset"):format(v28)]);
    local v46 = v44(v45);
    if v46 ~= "placed" then
        v27.AbilitiesDisabled = false;
        return {
            Cancelled = true, 
            Reason = v46
        };
    else
        for _, v48 in pairs(v27.Rig:GetChildren()) do
            if v48.Name:find("Wrench") or v48.Name:find("Hammer") then
                v48.Transparency = 0;
            end;
        end;
        local v49 = v27.Config[("%*Template"):format(v28)]:Clone();
        v49:SetAttribute("OwnerName", (tostring(v27.Player)));
        v49:SetAttribute("Team", "Survivors");
        v49.Humanoid.Health = v27.Config[("%*Health"):format(v28)];
        v49.Name = ("Builderman%*"):format(v28);
        v49.Parent = workspace.Map.Ingame;
        local v50 = v27.Config[("%*Limit"):format(v28)];
        if not v27[("Constructed%*"):format(v28)] then
            v27[("Constructed%*"):format(v28)] = {};
        end;
        if v50 <= #v27[("Constructed%*"):format(v28)] then
            v23(v27, v27[("Constructed%*"):format(v28)][1]);
            table.remove(v27[("Constructed%*"):format(v28)], 1);
        end;
        table.insert(v27[("Constructed%*"):format(v28)], v49);
        local v51 = {};
        for _, v53 in pairs(workspace.Map.Ingame:GetChildren()) do
            if v53.Name == ("Builderman%*"):format(v28) and not v53:GetAttribute("Destroyed") then
                table.insert(v51, v53);
            end;
        end;
        for _, v55 in pairs(v51) do
            v55:SetAttribute("BuildingCount", #v51);
        end;
        for _, v57 in pairs(v49:GetDescendants()) do
            if v57:IsA("BasePart") and v57.Transparency ~= 1 then
                v57:SetAttribute("Hidden", true);
                v57.Transparency = 1;
            end;
        end;
        local v58 = {};
        for v59, v60 in pairs(v27.Config[("%*Animations"):format(v28)]) do
            v58[v59] = v2:LoadAnimationFromID(v49, v60);
        end;
        v27:ChangeExpression("Concentrating");
        local v61 = nil;
        local l_Health_0 = v27.Rig.Humanoid.Health;
        local v63 = nil;
        v63 = v27.Rig.Humanoid.HealthChanged:Connect(function(v64) --[[ Line: 209 ]]
            -- upvalues: l_Health_0 (ref), v61 (ref)
            if v64 < l_Health_0 then
                v61 = "failed";
            end;
            l_Health_0 = v64;
        end);
        local v65 = nil;
        v65 = v49.Humanoid.HealthChanged:Connect(function(_) --[[ Line: 217 ]]
            -- upvalues: v61 (ref)
            v61 = "failed";
        end);
        v1:Play(v27.Config.Sounds[("%*Building"):format(v28)], {
            Parent = v49.PrimaryPart
        });
        v1:PlayVoiceline(v27, ("%*Constructing"):format(v28), {
            Priority = 2
        });
        task.delay(1.25, function() --[[ Line: 226 ]]
            -- upvalues: v61 (ref), v27 (copy), v49 (copy), v58 (copy), v28 (copy), v44 (copy), v45 (copy)
            if v61 then
                return;
            elseif not v27.Rig.PrimaryPart then
                return;
            else
                for _, v68 in pairs(v49:GetDescendants()) do
                    if v68:GetAttribute("Hidden") then
                        game.TweenService:Create(v68, TweenInfo.new(1), {
                            Transparency = 0
                        }):Play();
                    end;
                end;
                v58.Construction:Play(0);
                v58.Construction.Stopped:Connect(function() --[[ Line: 238 ]]
                    -- upvalues: v58 (ref)
                    v58.Idle:Play(0);
                end);
                local v69 = v27.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -v27.Config[("%*PositionOffset"):format(v28)]);
                if not (v44(v69) == "placed") then
                    v69 = v45;
                end;
                local v70 = RaycastParams.new();
                v70.FilterType = Enum.RaycastFilterType.Exclude;
                v70.RespectCanCollide = true;
                v70.CollisionGroup = "Survivors";
                v70.FilterDescendantsInstances = {
                    workspace.Players
                };
                local v71 = workspace:Raycast(v69.Position, Vector3.new(0, -100, 0, 0), v70);
                local v72 = v71 and v71.Position + Vector3.new(0, v49.PrimaryPart.Size.Y / 2, 0) or (v69 - Vector3.new(0, 1.5, 0, 0)).Position;
                v49:SetPrimaryPartCFrame(CFrame.new(v72) * v69.Rotation);
                v27.Rig:SetAttribute("PlacementRadius", nil);
                return;
            end;
        end);
        task.delay(v27.Config[("%*ConstructionDuration"):format(v28)], function() --[[ Line: 265 ]]
            -- upvalues: v61 (ref)
            if not v61 then
                v61 = "constructed";
            end;
        end);
        task.spawn(function() --[[ Line: 272 ]]
            -- upvalues: v61 (ref), v27 (copy), v29 (copy), v49 (copy), v58 (copy), v1 (ref), v28 (copy), v23 (ref), v63 (ref), v65 (ref)
            repeat
                task.wait();
            until v61;
            for _, v74 in pairs(v27.Rig:GetChildren()) do
                if v74.Name:find("Wrench") or v74.Name:find("Hammer") then
                    v74.Transparency = 1;
                end;
            end;
            v27:ChangeExpression("Default");
            v27.Rig:SetAttribute("PlacementRadius", nil);
            if v61 == "constructed" then
                v29(v49, v58);
                v49:SetAttribute("HitboxPriority", 0);
                v1:PlayVoiceline(v27, ("%*Constructed"):format(v28), {
                    Priority = 3
                });
                local v75 = v27.Config.Sounds[("%*BuildingCompleted"):format(v28)];
                if v75 then
                    local v76 = v1:Play(v75, {
                        Parent = v49.PrimaryPart, 
                        Volume = 0.5
                    });
                    if v76 and tostring(v76.Parent) == "Sounds" then
                        v76:Destroy();
                    end;
                end;
                if v49.PrimaryPart then
                    local v77 = v1:Play(v27.Config.Sounds[("%*Idle"):format(v28)], {
                        Parent = v49.PrimaryPart, 
                        Volume = 0, 
                        Looped = true
                    });
                    if v77 then
                        game.TweenService:Create(v77, TweenInfo.new(0.5), {
                            Volume = 0.5
                        }):Play();
                    end;
                    if v77 and tostring(v77.Parent) == "Sounds" then
                        v77:Destroy();
                    end;
                end;
                for _, v79 in pairs(v49:GetDescendants()) do
                    if (v79:IsA("ParticleEmitter") or v79:IsA("Light")) and v79.Name ~= "Shoot" then
                        v79.Enabled = true;
                    end;
                end;
                v49.Humanoid.Died:Once(function() --[[ Line: 315 ]]
                    -- upvalues: v49 (ref), v27 (ref), v28 (ref), v23 (ref)
                    local v80 = v49:GetAttribute("DamageDealt") or v49:GetAttribute("TotalHealed") or 0;
                    local v81 = require(game.ReplicatedStorage.Modules.Actors);
                    v81:IncrementActorStats(v27.Player, {
                        Action = ("%* Destroyed by Killer"):format(v28), 
                        RewardType = "Survivalist"
                    });
                    local l_v28_0 = v28;
                    local v83 = if l_v28_0 == "Sentry" then math.ceil((math.clamp(v80 ^ 0.5 * 1.2, 0, 20))) else if l_v28_0 == "Dispenser" then math.ceil((math.clamp(v80 ^ 0.95 * 0.35, 0, 20))) else nil;
                    if v83 > 0 then
                        v81:IncrementActorStats(v27.Player, {
                            Action = ("%* %* %* with %*"):format(v28 == "Sentry" and "Dealt" or "Healed", tostring((math.ceil(v80))), v28 == "Sentry" and "damage" or "health", v28), 
                            Money = v83, 
                            EXP = math.ceil(v83 * 0.5)
                        });
                    end;
                    v23(v27, v49);
                end);
            else
                v23(v27, v49);
            end;
            v63:Disconnect();
            v63 = nil;
            v65:Disconnect();
            v65 = nil;
            local l_StringValue_0 = Instance.new("StringValue");
            l_StringValue_0.Value = tostring(v61);
            l_StringValue_0.Name = "Result";
            l_StringValue_0.Parent = v27.Rig;
            game.Debris:AddItem(l_StringValue_0, 1);
            task.delay(2, function() --[[ Line: 356 ]]
                -- upvalues: v27 (ref)
                v27.AbilitiesDisabled = false;
            end);
        end);
        return;
    end;
end;
local function v95(v86, v87, v88) --[[ Line: 362 ]] --[[ Name: constructBuildingOnClient ]]
    -- upvalues: v2 (copy)
    if typeof(v88) == "table" and v88.Cancelled then
        local v89 = {
            collision = "Building area is obstructed by something. Build somewhere else.", 
            tooClose = "Building area is too close to a pre-existing building. Move further away and try again.", 
            midair = "Building area is too high above ground. Turn around and try again.", 
            facingWall = "You're too close to a wall. Turn around and try again.", 
            unknown = "Something went wrong. Try building somewhere else."
        };
        local v90 = v89[v88.Reason] or v89.unknown;
        v2:CreateWarning("BuildermanWarning", v90, v86.Config.WarningTemplate);
        return;
    else
        local v91 = true;
        v86.Animations.ConstructStart:Play();
        task.delay(0.75, function() --[[ Line: 387 ]]
            -- upvalues: v91 (ref), v86 (copy)
            if v91 then
                v86.Animations.ConstructStart:Stop();
                v86.Animations.ConstructLoop:Play();
            end;
        end);
        local l_v2_ProgressBar_0 = v2:CreateProgressBar(("Building %*"):format(v87), v86.Config[("%*ConstructionDuration"):format(v87)]);
        local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v86.Rig, 0, (("%*Construction"):format(v87)));
        local v94 = v86.Rig:WaitForChild("Result", v86.Config[("%*ConstructionDuration"):format(v87)] + 3);
        v94 = v94 and v94.Value or "IDK";
        v91 = false;
        v86.Animations.ConstructStart:Stop();
        v86.Animations.ConstructLoop:Stop();
        l_v2_ProgressBar_0:Destroy();
        v86.Animations.ConstructEnd:Play();
        game.TweenService:Create(l_v2_SpeedMultiplier_0, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
            Value = 1
        }):Play();
        game.Debris:AddItem(l_v2_SpeedMultiplier_0, 1);
        return;
    end;
end;
v0.Abilities = {
    Sentry = {
        LayoutOrder = 1, 
        KeybindType = "AltAbility1", 
        Icon = "rbxassetid://104441527277654", 
        Callback = function(v96, v97) --[[ Line: 420 ]] --[[ Name: Callback ]]
            -- upvalues: v85 (copy), v2 (copy), v1 (copy), v4 (copy), v95 (copy)
            if game["Run Service"]:IsServer() then
                return v85(v96, "Sentry", function(v98, v99) --[[ Line: 426 ]]
                    -- upvalues: v96 (copy), v2 (ref), v1 (ref), v4 (ref)
                    task.spawn(function() --[[ Line: 428 ]]
                        -- upvalues: v98 (copy), v96 (ref), v2 (ref), v1 (ref), v99 (copy), v4 (ref)
                        local v100 = 0;
                        local v101 = false;
                        local v102 = false;
                        local l_C0_0 = v98.Torso.Neck.C0;
                        local v104 = RaycastParams.new();
                        v104.FilterType = Enum.RaycastFilterType.Exclude;
                        v104.FilterDescendantsInstances = {
                            v98
                        };
                        while true do
                            if v98.Parent then
                                local v105 = task.wait(0.2);
                                local _ = v98.PrimaryPart;
                                if not v98.Parent then
                                    return;
                                elseif not v98.PrimaryPart then
                                    return;
                                elseif v98:GetAttribute("Destroyed") then
                                    return;
                                else
                                    local v107 = (v98:GetAttribute("BuildingCount") or 1) - 1;
                                    local v108 = v96.Config.SentryDamageRadius / 2;
                                    local v109 = math.clamp(v108 * (1 - v107 * v96.Config.SentryRangeReductionPercentage / 100), v96.Config.SentryMinimumRange, v108);
                                    if v98:GetAttribute("EffectRadiusSize") ~= v109 then
                                        v98:SetAttribute("EffectRadiusSize", v109);
                                    end;
                                    if not v102 then
                                        v102 = true;
                                        local l_v2_ClosestPlayerFromPosition_0 = v2:GetClosestPlayerFromPosition(v96.Rig.PrimaryPart.Position, {
                                            MaxDistance = v96.Config.SentryPingDistance, 
                                            ReturnTable = true
                                        });
                                        for _, v112 in pairs(l_v2_ClosestPlayerFromPosition_0) do
                                            local l_Player_0 = v112.Player;
                                            local l_PlayerFromCharacter_0 = game.Players:GetPlayerFromCharacter(l_Player_0);
                                            if l_PlayerFromCharacter_0 then
                                                v2:RevealPlayerAuraTo(l_PlayerFromCharacter_0, v98, v96.Config.SentryPingDuration, Color3.new(0.75, 1, 0.75));
                                            end;
                                        end;
                                    end;
                                    local l_v2_ClosestPlayerFromPosition_1 = v2:GetClosestPlayerFromPosition(v98.PrimaryPart.Position, {
                                        PlayerSelection = "Killers", 
                                        MaxDistance = v109
                                    });
                                    if l_v2_ClosestPlayerFromPosition_1 and l_v2_ClosestPlayerFromPosition_1.PrimaryPart and l_v2_ClosestPlayerFromPosition_1.Humanoid.Health > 0 then
                                        local l_Position_0 = v98.PrimaryPart.Position;
                                        local l_LookVector_0 = CFrame.lookAt(l_Position_0, l_v2_ClosestPlayerFromPosition_1.PrimaryPart.Position).LookVector;
                                        local v118 = workspace:Raycast(l_Position_0, l_LookVector_0 * v109, v104);
                                        if v118 then
                                            if not v118.Instance:IsDescendantOf(l_v2_ClosestPlayerFromPosition_1) then
                                                v101 = false;
                                            else
                                                if not v101 then
                                                    v101 = true;
                                                    v1:Play(v96.Config.Sounds.SentryTargeted, {
                                                        Parent = v98.PrimaryPart
                                                    });
                                                end;
                                                local function _(v119, v120) --[[ Line: 487 ]] --[[ Name: worldCFrameToC0ObjectSpace ]]
                                                    local l_CFrame_0 = v119.Part1.CFrame;
                                                    local l_C1_0 = v119.C1;
                                                    local l_C0_1 = v119.C0;
                                                    local v124 = l_C0_1 * l_C1_0:Inverse() * l_CFrame_0:Inverse() * v120 * l_C1_0;
                                                    return v124 - v124.Position + l_C0_1.Position;
                                                end;
                                                local v126 = CFrame.lookAt(v98.Head.Position, l_v2_ClosestPlayerFromPosition_1.PrimaryPart.Position, v98.Torso.CFrame.UpVector);
                                                local l_TweenService_0 = game.TweenService;
                                                local l_Neck_0 = v98.Torso.Neck;
                                                local v129 = TweenInfo.new(0.5);
                                                local v130 = {};
                                                local l_Neck_1 = v98.Torso.Neck;
                                                local l_CFrame_1 = l_Neck_1.Part1.CFrame;
                                                local l_C1_1 = l_Neck_1.C1;
                                                local l_C0_2 = l_Neck_1.C0;
                                                local v135 = l_C0_2 * l_C1_1:Inverse() * l_CFrame_1:Inverse() * v126 * l_C1_1;
                                                v130.C0 = (v135 - v135.Position + l_C0_2.Position) * CFrame.Angles(-1.5707963267948966, 0, 0);
                                                l_TweenService_0:Create(l_Neck_0, v129, v130):Play();
                                                if v99.Shoot then
                                                    v99.Shoot:Play(0);
                                                end;
                                                v1:Play(v96.Config.Sounds.SentryShoot, {
                                                    Parent = v98.PrimaryPart
                                                });
                                                for _, v137 in pairs(v98:GetDescendants()) do
                                                    if (v137:IsA("ParticleEmitter") or v137:IsA("Light")) and v137.Name == "Shoot" then
                                                        task.spawn(function() --[[ Line: 511 ]]
                                                            -- upvalues: v137 (copy)
                                                            v137.Enabled = true;
                                                            task.wait(0.05);
                                                            v137.Enabled = false;
                                                        end);
                                                    end;
                                                end;
                                                l_TweenService_0 = l_v2_ClosestPlayerFromPosition_1:FindFirstChild("Humanoid");
                                                if l_TweenService_0 then
                                                    local v138 = v96.Config.SentryDamagePerSec * v105;
                                                    l_TweenService_0.Health = l_TweenService_0.Health - v138;
                                                    v100 = v100 + v138;
                                                end;
                                                v98:SetAttribute("DamageDealt", v100);
                                                v4:ApplyStatus(l_v2_ClosestPlayerFromPosition_1, "Slowness", {
                                                    Duration = v96.Config.SentrySlownessDuration, 
                                                    Level = v96.Config.SentrySlownessLevel
                                                });
                                            end;
                                        end;
                                    else
                                        v101 = false;
                                        game.TweenService:Create(v98.Torso.Neck, TweenInfo.new(0.5), {
                                            C0 = l_C0_0
                                        }):Play();
                                    end;
                                end;
                            else
                                return;
                            end;
                        end;
                    end);
                end);
            else
                if game["Run Service"]:IsClient() then
                    v95(v96, "Sentry", v97);
                end;
                return;
            end;
        end
    }, 
    Dispenser = {
        LayoutOrder = 2, 
        KeybindType = "AltAbility2", 
        Icon = "rbxassetid://102952736333903", 
        Callback = function(v139, v140) --[[ Line: 551 ]] --[[ Name: Callback ]]
            -- upvalues: v85 (copy), v2 (copy), v95 (copy)
            if game["Run Service"]:IsServer() then
                return v85(v139, "Dispenser", function(v141) --[[ Line: 557 ]]
                    -- upvalues: v139 (copy), v2 (ref)
                    task.spawn(function() --[[ Line: 559 ]]
                        -- upvalues: v141 (copy), v139 (ref), v2 (ref)
                        task.delay(120, function() --[[ Line: 561 ]]
                            -- upvalues: v141 (ref), v139 (ref)
                            if v141.Parent and not v141:GetAttribute("Destroyed") then
                                require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(v139.Player, "BuildermanDispenser");
                            end;
                        end);
                        local v142 = 0;
                        local v143 = false;
                        while true do
                            if v141.Parent then
                                local v144 = game["Run Service"].Heartbeat:Wait();
                                if not v141.Parent then
                                    return;
                                elseif not v141.PrimaryPart then
                                    return;
                                elseif v141:GetAttribute("Destroyed") then
                                    return;
                                else
                                    if not v143 then
                                        v143 = true;
                                        local l_v2_ClosestPlayerFromPosition_2 = v2:GetClosestPlayerFromPosition(v139.Rig.PrimaryPart.Position, {
                                            MaxDistance = v139.Config.DispenserPingDistance, 
                                            OverrideUndetectable = true, 
                                            ReturnTable = true
                                        });
                                        for _, v147 in pairs(l_v2_ClosestPlayerFromPosition_2) do
                                            local l_Player_1 = v147.Player;
                                            local l_PlayerFromCharacter_1 = game.Players:GetPlayerFromCharacter(l_Player_1);
                                            if l_PlayerFromCharacter_1 then
                                                v2:RevealPlayerAuraTo(l_PlayerFromCharacter_1, v141, v139.Config.DispenserPingDuration, Color3.new(0.75, 1, 0.75));
                                            end;
                                        end;
                                    end;
                                    local v150 = (v141:GetAttribute("BuildingCount") or 1) - 1;
                                    local l_DispenserHealingPerSec_0 = v139.Config.DispenserHealingPerSec;
                                    local _ = math.clamp(l_DispenserHealingPerSec_0 * (1 - v150 * v139.Config.DispenserHealingReductionPercentage / 100), v139.Config.DispenserMinimumHealing, l_DispenserHealingPerSec_0);
                                    local l_v2_ClosestPlayerFromPosition_3 = v2:GetClosestPlayerFromPosition(v141.PrimaryPart.Position, {
                                        PlayerSelection = "Survivors", 
                                        MaxDistance = v139.Config.DispenserHealingRadius / 2, 
                                        ReturnTable = true
                                    });
                                    local l_pairs_0 = pairs;
                                    local v155 = l_v2_ClosestPlayerFromPosition_3 or {};
                                    for _, v157 in l_pairs_0(v155) do
                                        local l_Player_2 = v157.Player;
                                        local v159 = l_Player_2 and l_Player_2:FindFirstChild("Humanoid");
                                        if v159 and not v159:GetAttribute("Clanker") then
                                            local v160 = v159.MaxHealth - v159.Health;
                                            v2:Heal(v159, l_DispenserHealingPerSec_0 * v144);
                                            v142 = v142 + math.min(v160, l_DispenserHealingPerSec_0 * v144);
                                        end;
                                    end;
                                    v141:SetAttribute("TotalHealed", v142);
                                end;
                            else
                                return;
                            end;
                        end;
                    end);
                end);
            else
                if game["Run Service"]:IsClient() then
                    v95(v139, "Dispenser", v140);
                end;
                return;
            end;
        end
    }
};
v0.Created = function(_, v162) --[[ Line: 729 ]] --[[ Name: Created ]]
    -- upvalues: v23 (copy)
    if game["Run Service"]:IsServer() then
        v162.Rig.Humanoid.Died:Once(function() --[[ Line: 732 ]]
            -- upvalues: v162 (copy), v23 (ref)
            for _, v164 in pairs(workspace.Map.Ingame:GetChildren()) do
                if v164.Name:find("Builderman") and v164:GetAttribute("OwnerName") == tostring(v162.Player) then
                    v23(v162, v164);
                end;
            end;
        end);
        return;
    else
        if game["Run Service"]:IsClient() and v162.Rig == game.Players.LocalPlayer.Character then
            v162.RadiusStorages = {};
            local function _(v165, v166) --[[ Line: 745 ]] --[[ Name: createRadiusStorage ]]
                -- upvalues: v162 (copy)
                local l_Model_0 = Instance.new("Model");
                l_Model_0.Parent = workspace.Map.Ingame;
                l_Model_0.Name = v165;
                v162.RadiusStorages[v165] = l_Model_0;
                local l_Highlight_0 = Instance.new("Highlight");
                l_Highlight_0.DepthMode = Enum.HighlightDepthMode.Occluded;
                l_Highlight_0.FillTransparency = 0.875;
                l_Highlight_0.OutlineTransparency = 0.6;
                l_Highlight_0.FillColor = v166;
                l_Highlight_0.Parent = l_Model_0;
            end;
            local v170 = Color3.fromRGB(70, 155, 255);
            local l_Model_1 = Instance.new("Model");
            l_Model_1.Parent = workspace.Map.Ingame;
            l_Model_1.Name = "PlacementRange";
            v162.RadiusStorages.PlacementRange = l_Model_1;
            local l_Highlight_1 = Instance.new("Highlight");
            l_Highlight_1.DepthMode = Enum.HighlightDepthMode.Occluded;
            l_Highlight_1.FillTransparency = 0.875;
            l_Highlight_1.OutlineTransparency = 0.6;
            l_Highlight_1.FillColor = v170;
            l_Highlight_1.Parent = l_Model_1;
            v170 = Color3.fromRGB(255, 80, 80);
            l_Model_1 = Instance.new("Model");
            l_Model_1.Parent = workspace.Map.Ingame;
            l_Model_1.Name = "BuildermanSentryEffectRange";
            v162.RadiusStorages.BuildermanSentryEffectRange = l_Model_1;
            l_Highlight_1 = Instance.new("Highlight");
            l_Highlight_1.DepthMode = Enum.HighlightDepthMode.Occluded;
            l_Highlight_1.FillTransparency = 0.875;
            l_Highlight_1.OutlineTransparency = 0.6;
            l_Highlight_1.FillColor = v170;
            l_Highlight_1.Parent = l_Model_1;
            v170 = Color3.fromRGB(80, 255, 80);
            l_Model_1 = Instance.new("Model");
            l_Model_1.Parent = workspace.Map.Ingame;
            l_Model_1.Name = "BuildermanDispenserEffectRange";
            v162.RadiusStorages.BuildermanDispenserEffectRange = l_Model_1;
            l_Highlight_1 = Instance.new("Highlight");
            l_Highlight_1.DepthMode = Enum.HighlightDepthMode.Occluded;
            l_Highlight_1.FillTransparency = 0.875;
            l_Highlight_1.OutlineTransparency = 0.6;
            l_Highlight_1.FillColor = v170;
            l_Highlight_1.Parent = l_Model_1;
            v170 = function(v173, v174) --[[ Line: 767 ]] --[[ Name: createRadius ]]
                -- upvalues: v162 (copy)
                local v175 = v162.RadiusStorages[v173];
                if not v175 then
                    return;
                elseif not v174 then
                    return;
                else
                    local l_Part_0 = Instance.new("Part");
                    l_Part_0.CanCollide = false;
                    l_Part_0.Anchored = true;
                    l_Part_0.Transparency = 1;
                    l_Part_0.Position = Vector3.new(0, -100, 0, 0);
                    l_Part_0.Orientation = Vector3.new(0, 0, 90, 0);
                    l_Part_0.Size = Vector3.new(0.25, v174, v174);
                    l_Part_0.Material = Enum.Material.Glass;
                    l_Part_0.Shape = Enum.PartType.Cylinder;
                    l_Part_0.Parent = v175;
                    return l_Part_0;
                end;
            end;
            v162.Connection = workspace.Map.Ingame.ChildAdded:Connect(function(v177) --[[ Line: 785 ]]
                -- upvalues: v162 (copy), v170 (copy)
                if v177.Name:find("Builderman") then
                    local v178 = v177:WaitForChild("Humanoid", 10);
                    if not v178 then
                        return;
                    else
                        local v179 = v177:WaitForChild("Root", 10);
                        if not v179 then
                            return;
                        else
                            local v180 = {
                                BuildermanSentryPlacementRange = v162.Config.SentryPlacementRadius, 
                                BuildermanSentryEffectRange = v162.Config.SentryDamageRadius, 
                                BuildermanDispenserPlacementRange = v162.Config.DispenserPlacementRadius, 
                                BuildermanDispenserEffectRange = v162.Config.DispenserHealingRadius
                            };
                            local v181 = ("%*PlacementRange"):format(v177.Name);
                            local v182 = ("%*EffectRange"):format(v177.Name);
                            local v183 = v170("PlacementRange", v180[v181]);
                            local v184 = v170(v182, v180[v182]);
                            v179:GetPropertyChangedSignal("Position"):Connect(function() --[[ Line: 810 ]]
                                -- upvalues: v183 (copy), v179 (copy), v184 (copy)
                                if v183 then
                                    v183.Position = v179.Position - Vector3.new(0, v179.Size.Y / 2 + 0.075, 0);
                                end;
                                if v184 then
                                    v184.Position = v179.Position - Vector3.new(0, v179.Size.Y / 2 + 0, 0);
                                end;
                            end);
                            v177:GetAttributeChangedSignal("EffectRadiusSize"):Connect(function() --[[ Line: 816 ]]
                                -- upvalues: v177 (copy), v184 (copy)
                                local l_v177_Attribute_0 = v177:GetAttribute("EffectRadiusSize");
                                if v184 then
                                    game.TweenService:Create(v184, TweenInfo.new(1), {
                                        Size = Vector3.new(0.25, l_v177_Attribute_0 * 2, l_v177_Attribute_0 * 2)
                                    }):Play();
                                end;
                            end);
                            v178.HealthChanged:Connect(function(v186) --[[ Line: 822 ]]
                                -- upvalues: v183 (copy), v184 (copy)
                                if v186 <= 0 then
                                    if v183 then
                                        v183:Destroy();
                                    end;
                                    if v184 then
                                        v184:Destroy();
                                    end;
                                end;
                            end);
                            v177.AncestryChanged:Connect(function(_, v188) --[[ Line: 829 ]]
                                -- upvalues: v183 (copy), v184 (copy)
                                if not v188 then
                                    if v183 then
                                        v183:Destroy();
                                    end;
                                    if v184 then
                                        v184:Destroy();
                                    end;
                                end;
                            end);
                        end;
                    end;
                end;
            end);
            v162.Rig.AncestryChanged:Connect(function(_, v190) --[[ Line: 839 ]]
                -- upvalues: v162 (copy)
                if not v190 then
                    if v162.Connection then
                        v162.Connection:Disconnect();
                    end;
                    for _, v192 in pairs(v162.RadiusStorages) do
                        v192:Destroy();
                    end;
                end;
            end);
        end;
        return;
    end;
end;
return v0;