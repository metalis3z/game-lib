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
local function v78(v24, v25, v26) --[[ Line: 77 ]] --[[ Name: constructBuilding ]]
    -- upvalues: v23 (copy), v2 (copy), v1 (copy)
    v24.AbilitiesDisabled = true;
    local function v41(v27) --[[ Line: 82 ]] --[[ Name: checkPlacement ]]
        -- upvalues: v24 (copy), v25 (copy)
        local l_workspace_PartBoundsInRadius_0 = workspace:GetPartBoundsInRadius(v27.Position, 1);
        for _, v30 in pairs(l_workspace_PartBoundsInRadius_0) do
            if v30.Transparency < 0.9 or v30.Name == "UnplacableArea" then
                return "collision";
            end;
        end;
        for _, v32 in pairs(workspace.Map.Ingame:GetChildren()) do
            if v32.Name:find("Builderman") and not v32:GetAttribute("Destroyed") then
                local v33 = string.gsub(v32.Name, "Builderman", "");
                local v34 = v24.Config[("%*PlacementRadius"):format(v33)] or v24.Config[("%*PlacementRadius"):format(v25)];
                if (v27.Position - v32.PrimaryPart.Position).Magnitude <= v34 / 2 then
                    return "tooClose";
                end;
            end;
        end;
        for _, v36 in pairs(workspace.Players.Survivors:GetChildren()) do
            local l_v36_Attribute_0 = v36:GetAttribute("PlacementRadius");
            local l_PrimaryPart_0 = v36.PrimaryPart;
            if v36 ~= v24.Rig and l_v36_Attribute_0 and l_PrimaryPart_0 and v27.Position - l_PrimaryPart_0.Position <= l_v36_Attribute_0 / 2 then
                return "tooClose";
            end;
        end;
        local v39 = RaycastParams.new();
        v39.FilterType = Enum.RaycastFilterType.Exclude;
        v39.FilterDescendantsInstances = {
            workspace.Players
        };
        local v40 = workspace:Raycast(v27.Position, Vector3.new(0, -4, 0, 0), v39);
        if not v40 then
            return "midair";
        elseif v40 and v40.Instance.Name == "Conveyor" then
            return "collision";
        elseif workspace:Raycast(v24.Rig.PrimaryPart.Position, v24.Rig.PrimaryPart.CFrame.LookVector * v24.Config[("%*PositionOffset"):format(v25)], v39) then
            return "facingWall";
        else
            v24.Rig:SetAttribute("PlacementRadius", v24.Config[("%*PlacementRadius"):format(v25)] or 70);
            return "placed";
        end;
    end;
    local v42 = v24.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -v24.Config[("%*PositionOffset"):format(v25)]);
    local v43 = v41(v42);
    if v43 ~= "placed" then
        v24.AbilitiesDisabled = false;
        return {
            Cancelled = true, 
            Reason = v43
        };
    else
        for _, v45 in pairs(v24.Rig:GetChildren()) do
            if v45.Name:find("Wrench") or v45.Name:find("Hammer") then
                v45.Transparency = 0;
            end;
        end;
        local v46 = v24.Config[("%*Template"):format(v25)]:Clone();
        v46:SetAttribute("OwnerName", (tostring(v24.Player)));
        v46:SetAttribute("Team", "Survivors");
        v46.Humanoid.Health = v24.Config[("%*Health"):format(v25)];
        v46.Name = ("Builderman%*"):format(v25);
        v46.Parent = workspace.Map.Ingame;
        local v47 = v24.Config[("%*Limit"):format(v25)];
        if not v24[("Constructed%*"):format(v25)] then
            v24[("Constructed%*"):format(v25)] = {};
        end;
        if v47 <= #v24[("Constructed%*"):format(v25)] then
            v23(v24, v24[("Constructed%*"):format(v25)][1]);
            table.remove(v24[("Constructed%*"):format(v25)], 1);
        end;
        table.insert(v24[("Constructed%*"):format(v25)], v46);
        local v48 = {};
        for _, v50 in pairs(workspace.Map.Ingame:GetChildren()) do
            if v50.Name == ("Builderman%*"):format(v25) and not v50:GetAttribute("Destroyed") then
                table.insert(v48, v50);
            end;
        end;
        for _, v52 in pairs(v48) do
            v52:SetAttribute("BuildingCount", #v48);
        end;
        for _, v54 in pairs(v46:GetDescendants()) do
            if v54:IsA("BasePart") and v54.Transparency ~= 1 then
                v54:SetAttribute("Hidden", true);
                v54.Transparency = 1;
            end;
        end;
        local v55 = {};
        for v56, v57 in pairs(v24.Config[("%*Animations"):format(v25)]) do
            v55[v56] = v2:LoadAnimationFromID(v46, v57);
        end;
        v24:ChangeExpression("Concentrating");
        local v58 = nil;
        local l_Health_0 = v24.Rig.Humanoid.Health;
        local v60 = nil;
        v60 = v24.Rig.Humanoid.HealthChanged:Connect(function(v61) --[[ Line: 198 ]]
            -- upvalues: l_Health_0 (ref), v58 (ref)
            if v61 < l_Health_0 then
                v58 = "failed";
            end;
            l_Health_0 = v61;
        end);
        local v62 = nil;
        v62 = v46.Humanoid.HealthChanged:Connect(function(_) --[[ Line: 206 ]]
            -- upvalues: v58 (ref)
            v58 = "failed";
        end);
        v1:Play(v24.Config.Sounds[("%*Building"):format(v25)], {
            Parent = v46.PrimaryPart
        });
        v1:PlayVoiceline(v24, ("%*Constructing"):format(v25), {
            Priority = 2
        });
        task.delay(1.25, function() --[[ Line: 215 ]]
            -- upvalues: v58 (ref), v24 (copy), v46 (copy), v55 (copy), v25 (copy), v41 (copy), v42 (copy)
            if v58 then
                return;
            elseif not v24.Rig.PrimaryPart then
                return;
            else
                for _, v65 in pairs(v46:GetDescendants()) do
                    if v65:GetAttribute("Hidden") then
                        game.TweenService:Create(v65, TweenInfo.new(1), {
                            Transparency = 0
                        }):Play();
                    end;
                end;
                v55.Construction:Play(0);
                v55.Construction.Stopped:Connect(function() --[[ Line: 227 ]]
                    -- upvalues: v55 (ref)
                    v55.Idle:Play(0);
                end);
                local v66 = v24.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -v24.Config[("%*PositionOffset"):format(v25)]);
                if not (v41(v66) == "placed") then
                    v66 = v42;
                end;
                local v67 = RaycastParams.new();
                v67.FilterType = Enum.RaycastFilterType.Exclude;
                v67.FilterDescendantsInstances = {
                    workspace.Players
                };
                local v68 = workspace:Raycast(v66.Position, Vector3.new(0, -100, 0, 0), v67);
                local v69 = v68 and v68.Position + Vector3.new(0, v46.PrimaryPart.Size.Y / 2, 0) or (v66 - Vector3.new(0, 1.5, 0, 0)).Position;
                v46:SetPrimaryPartCFrame(CFrame.new(v69) * v66.Rotation);
                v24.Rig:SetAttribute("PlacementRadius", nil);
                return;
            end;
        end);
        task.delay(v24.Config[("%*ConstructionDuration"):format(v25)], function() --[[ Line: 251 ]]
            -- upvalues: v58 (ref)
            if not v58 then
                v58 = "constructed";
            end;
        end);
        task.spawn(function() --[[ Line: 258 ]]
            -- upvalues: v58 (ref), v24 (copy), v26 (copy), v46 (copy), v55 (copy), v1 (ref), v25 (copy), v23 (ref), v60 (ref), v62 (ref)
            repeat
                task.wait();
            until v58;
            for _, v71 in pairs(v24.Rig:GetChildren()) do
                if v71.Name:find("Wrench") or v71.Name:find("Hammer") then
                    v71.Transparency = 1;
                end;
            end;
            v24:ChangeExpression("Default");
            v24.Rig:SetAttribute("PlacementRadius", nil);
            if v58 == "constructed" then
                v26(v46, v55);
                v46:SetAttribute("HitboxPriority", 0);
                v1:PlayVoiceline(v24, ("%*Constructed"):format(v25), {
                    Priority = 3
                });
                local v72 = v24.Config.Sounds[("%*BuildingCompleted"):format(v25)];
                if v72 then
                    local v73 = v1:Play(v72, {
                        Parent = v46.PrimaryPart, 
                        Volume = 0.5
                    });
                    if v73 and tostring(v73.Parent) == "Sounds" then
                        v73:Destroy();
                    end;
                end;
                if v46.PrimaryPart then
                    local v74 = v1:Play(v24.Config.Sounds[("%*Idle"):format(v25)], {
                        Parent = v46.PrimaryPart, 
                        Volume = 0, 
                        Looped = true
                    });
                    if v74 then
                        game.TweenService:Create(v74, TweenInfo.new(0.5), {
                            Volume = 0.5
                        }):Play();
                    end;
                    if v74 and tostring(v74.Parent) == "Sounds" then
                        v74:Destroy();
                    end;
                end;
                for _, v76 in pairs(v46:GetDescendants()) do
                    if (v76:IsA("ParticleEmitter") or v76:IsA("Light")) and v76.Name ~= "Shoot" then
                        v76.Enabled = true;
                    end;
                end;
                v46.Humanoid.Died:Connect(function() --[[ Line: 301 ]]
                    -- upvalues: v24 (ref), v25 (ref), v23 (ref), v46 (ref)
                    require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v24.Player, {
                        Action = ("%* Destroyed by Killer"):format(v25), 
                        RewardType = "Survivalist"
                    });
                    v23(v24, v46);
                end);
            else
                v23(v24, v46);
            end;
            v60:Disconnect();
            v60 = nil;
            v62:Disconnect();
            v62 = nil;
            local l_StringValue_0 = Instance.new("StringValue");
            l_StringValue_0.Value = tostring(v58);
            l_StringValue_0.Name = "Result";
            l_StringValue_0.Parent = v24.Rig;
            game.Debris:AddItem(l_StringValue_0, 1);
            task.delay(2, function() --[[ Line: 328 ]]
                -- upvalues: v24 (ref)
                v24.AbilitiesDisabled = false;
            end);
        end);
        return;
    end;
end;
local function v88(v79, v80, v81) --[[ Line: 334 ]] --[[ Name: constructBuildingOnClient ]]
    -- upvalues: v2 (copy)
    if typeof(v81) == "table" and v81.Cancelled then
        local v82 = {
            collision = "Building area is obstructed by something. Build somewhere else.", 
            tooClose = "Building area is too close to a pre-existing building. Move further away and try again.", 
            midair = "Building area is too high above ground. Turn around and try again.", 
            facingWall = "You're too close to a wall. Turn around and try again.", 
            unknown = "Something went wrong. Try building somewhere else."
        };
        local v83 = v82[v81.Reason] or v82.unknown;
        v2:CreateWarning("BuildermanWarning", v83, v79.Config.WarningTemplate);
        return;
    else
        local v84 = true;
        v79.Animations.ConstructStart:Play();
        task.delay(0.75, function() --[[ Line: 359 ]]
            -- upvalues: v84 (ref), v79 (copy)
            if v84 then
                v79.Animations.ConstructStart:Stop();
                v79.Animations.ConstructLoop:Play();
            end;
        end);
        local l_v2_ProgressBar_0 = v2:CreateProgressBar(("Building %*"):format(v80), v79.Config[("%*ConstructionDuration"):format(v80)]);
        local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v79.Rig, 0, (("%*Construction"):format(v80)));
        local v87 = v79.Rig:WaitForChild("Result", v79.Config[("%*ConstructionDuration"):format(v80)] + 3);
        v87 = v87 and v87.Value or "IDK";
        v84 = false;
        v79.Animations.ConstructStart:Stop();
        v79.Animations.ConstructLoop:Stop();
        l_v2_ProgressBar_0:Destroy();
        v79.Animations.ConstructEnd:Play();
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
        Callback = function(v89, v90) --[[ Line: 392 ]] --[[ Name: Callback ]]
            -- upvalues: v78 (copy), v2 (copy), v1 (copy), v4 (copy), v88 (copy)
            if game["Run Service"]:IsServer() then
                return v78(v89, "Sentry", function(v91, v92) --[[ Line: 398 ]]
                    -- upvalues: v89 (copy), v2 (ref), v1 (ref), v4 (ref)
                    task.spawn(function() --[[ Line: 400 ]]
                        -- upvalues: v91 (copy), v89 (ref), v2 (ref), v1 (ref), v92 (copy), v4 (ref)
                        local v93 = false;
                        local l_C0_0 = v91.Torso.Neck.C0;
                        local v95 = RaycastParams.new();
                        v95.FilterType = Enum.RaycastFilterType.Exclude;
                        v95.FilterDescendantsInstances = {
                            v91
                        };
                        while true do
                            if v91.Parent then
                                local v96 = task.wait(0.2);
                                local _ = v91.PrimaryPart;
                                if not v91.Parent then
                                    return;
                                elseif not v91.PrimaryPart then
                                    return;
                                elseif v91:GetAttribute("Destroyed") then
                                    return;
                                else
                                    local v98 = (v91:GetAttribute("BuildingCount") or 1) - 1;
                                    local v99 = v89.Config.SentryDamageRadius / 2;
                                    local v100 = math.clamp(v99 * (1 - v98 * v89.Config.SentryRangeReductionPercentage / 100), v89.Config.SentryMinimumRange, v99);
                                    if v91:GetAttribute("EffectRadiusSize") ~= v100 then
                                        v91:SetAttribute("EffectRadiusSize", v100);
                                    end;
                                    local l_v2_ClosestPlayerFromPosition_0 = v2:GetClosestPlayerFromPosition(v91.PrimaryPart.Position, {
                                        PlayerSelection = "Killers", 
                                        MaxDistance = v100
                                    });
                                    if l_v2_ClosestPlayerFromPosition_0 and l_v2_ClosestPlayerFromPosition_0.PrimaryPart and l_v2_ClosestPlayerFromPosition_0.Humanoid.Health > 0 then
                                        local l_Position_0 = v91.PrimaryPart.Position;
                                        local l_LookVector_0 = CFrame.lookAt(l_Position_0, l_v2_ClosestPlayerFromPosition_0.PrimaryPart.Position).LookVector;
                                        local v104 = workspace:Raycast(l_Position_0, l_LookVector_0 * v100, v95);
                                        if v104 then
                                            if not v104.Instance:IsDescendantOf(l_v2_ClosestPlayerFromPosition_0) then
                                                v93 = false;
                                            else
                                                if not v93 then
                                                    v93 = true;
                                                    v1:Play(v89.Config.Sounds.SentryTargeted, {
                                                        Parent = v91.PrimaryPart
                                                    });
                                                end;
                                                local function _(v105, v106) --[[ Line: 443 ]] --[[ Name: worldCFrameToC0ObjectSpace ]]
                                                    local l_CFrame_0 = v105.Part1.CFrame;
                                                    local l_C1_0 = v105.C1;
                                                    local l_C0_1 = v105.C0;
                                                    local v110 = l_C0_1 * l_C1_0:Inverse() * l_CFrame_0:Inverse() * v106 * l_C1_0;
                                                    return v110 - v110.Position + l_C0_1.Position;
                                                end;
                                                local v112 = CFrame.lookAt(v91.Head.Position, l_v2_ClosestPlayerFromPosition_0.PrimaryPart.Position, v91.Torso.CFrame.UpVector);
                                                local l_TweenService_0 = game.TweenService;
                                                local l_Neck_0 = v91.Torso.Neck;
                                                local v115 = TweenInfo.new(0.5);
                                                local v116 = {};
                                                local l_Neck_1 = v91.Torso.Neck;
                                                local l_CFrame_1 = l_Neck_1.Part1.CFrame;
                                                local l_C1_1 = l_Neck_1.C1;
                                                local l_C0_2 = l_Neck_1.C0;
                                                local v121 = l_C0_2 * l_C1_1:Inverse() * l_CFrame_1:Inverse() * v112 * l_C1_1;
                                                v116.C0 = (v121 - v121.Position + l_C0_2.Position) * CFrame.Angles(-1.5707963267948966, 0, 0);
                                                l_TweenService_0:Create(l_Neck_0, v115, v116):Play();
                                                if v92.Shoot then
                                                    v92.Shoot:Play(0);
                                                end;
                                                v1:Play(v89.Config.Sounds.SentryShoot, {
                                                    Parent = v91.PrimaryPart
                                                });
                                                for _, v123 in pairs(v91:GetDescendants()) do
                                                    if (v123:IsA("ParticleEmitter") or v123:IsA("Light")) and v123.Name == "Shoot" then
                                                        task.spawn(function() --[[ Line: 467 ]]
                                                            -- upvalues: v123 (copy)
                                                            v123.Enabled = true;
                                                            task.wait(0.05);
                                                            v123.Enabled = false;
                                                        end);
                                                    end;
                                                end;
                                                l_TweenService_0 = l_v2_ClosestPlayerFromPosition_0:FindFirstChild("Humanoid");
                                                if l_TweenService_0 then
                                                    l_TweenService_0.Health = l_TweenService_0.Health - v89.Config.SentryDamagePerSec * v96;
                                                end;
                                                v4:ApplyStatus(l_v2_ClosestPlayerFromPosition_0, "Slowness", {
                                                    Duration = v89.Config.SentrySlownessDuration, 
                                                    Level = v89.Config.SentrySlownessLevel
                                                });
                                            end;
                                        end;
                                    else
                                        v93 = false;
                                        game.TweenService:Create(v91.Torso.Neck, TweenInfo.new(0.5), {
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
                    v88(v89, "Sentry", v90);
                end;
                return;
            end;
        end
    }, 
    Dispenser = {
        LayoutOrder = 2, 
        KeybindType = "AltAbility2", 
        Icon = "rbxassetid://102952736333903", 
        Callback = function(v124, v125) --[[ Line: 503 ]] --[[ Name: Callback ]]
            -- upvalues: v78 (copy), v2 (copy), v88 (copy)
            if game["Run Service"]:IsServer() then
                return v78(v124, "Dispenser", function(v126) --[[ Line: 509 ]]
                    -- upvalues: v124 (copy), v2 (ref)
                    task.spawn(function() --[[ Line: 511 ]]
                        -- upvalues: v126 (copy), v124 (ref), v2 (ref)
                        task.delay(120, function() --[[ Line: 513 ]]
                            -- upvalues: v126 (ref), v124 (ref)
                            if v126.Parent and not v126:GetAttribute("Destroyed") then
                                require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(v124.Player, "BuildermanDispenser");
                            end;
                        end);
                        while true do
                            if v126.Parent then
                                local v127 = game["Run Service"].Heartbeat:Wait();
                                if not v126.Parent then
                                    return;
                                elseif not v126.PrimaryPart then
                                    return;
                                elseif v126:GetAttribute("Destroyed") then
                                    return;
                                else
                                    local v128 = (v126:GetAttribute("BuildingCount") or 1) - 1;
                                    local l_DispenserHealingPerSec_0 = v124.Config.DispenserHealingPerSec;
                                    local _ = math.clamp(l_DispenserHealingPerSec_0 * (1 - v128 * v124.Config.DispenserHealingReductionPercentage / 100), v124.Config.DispenserMinimumHealing, l_DispenserHealingPerSec_0);
                                    local l_v2_ClosestPlayerFromPosition_1 = v2:GetClosestPlayerFromPosition(v126.PrimaryPart.Position, {
                                        PlayerSelection = "Survivors", 
                                        MaxDistance = v124.Config.DispenserHealingRadius / 2, 
                                        ReturnTable = true
                                    });
                                    local l_pairs_0 = pairs;
                                    local v133 = l_v2_ClosestPlayerFromPosition_1 or {};
                                    for _, v135 in l_pairs_0(v133) do
                                        local l_Player_0 = v135.Player;
                                        local v137 = l_Player_0 and l_Player_0:FindFirstChild("Humanoid");
                                        if v137 then
                                            v137.Health = v137.Health + l_DispenserHealingPerSec_0 * v127;
                                        end;
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
                    v88(v124, "Dispenser", v125);
                end;
                return;
            end;
        end
    }
};
v0.Created = function(_, v139) --[[ Line: 655 ]] --[[ Name: Created ]]
    -- upvalues: v23 (copy)
    if game["Run Service"]:IsServer() then
        v139.Rig.Humanoid.Died:Connect(function() --[[ Line: 658 ]]
            -- upvalues: v139 (copy), v23 (ref)
            for _, v141 in pairs(workspace.Map.Ingame:GetChildren()) do
                if v141.Name:find("Builderman") and v141:GetAttribute("OwnerName") == tostring(v139.Player) then
                    v23(v139, v141);
                end;
            end;
        end);
        return;
    else
        if game["Run Service"]:IsClient() and v139.Rig == game.Players.LocalPlayer.Character then
            v139.RadiusStorages = {};
            local function _(v142, v143) --[[ Line: 671 ]] --[[ Name: createRadiusStorage ]]
                -- upvalues: v139 (copy)
                local l_Model_0 = Instance.new("Model");
                l_Model_0.Parent = workspace.Map.Ingame;
                l_Model_0.Name = v142;
                v139.RadiusStorages[v142] = l_Model_0;
                local l_Highlight_0 = Instance.new("Highlight");
                l_Highlight_0.DepthMode = Enum.HighlightDepthMode.Occluded;
                l_Highlight_0.FillTransparency = 0.875;
                l_Highlight_0.OutlineTransparency = 0.6;
                l_Highlight_0.FillColor = v143;
                l_Highlight_0.Parent = l_Model_0;
            end;
            local v147 = Color3.fromRGB(70, 155, 255);
            local l_Model_1 = Instance.new("Model");
            l_Model_1.Parent = workspace.Map.Ingame;
            l_Model_1.Name = "PlacementRange";
            v139.RadiusStorages.PlacementRange = l_Model_1;
            local l_Highlight_1 = Instance.new("Highlight");
            l_Highlight_1.DepthMode = Enum.HighlightDepthMode.Occluded;
            l_Highlight_1.FillTransparency = 0.875;
            l_Highlight_1.OutlineTransparency = 0.6;
            l_Highlight_1.FillColor = v147;
            l_Highlight_1.Parent = l_Model_1;
            v147 = Color3.fromRGB(255, 80, 80);
            l_Model_1 = Instance.new("Model");
            l_Model_1.Parent = workspace.Map.Ingame;
            l_Model_1.Name = "BuildermanSentryEffectRange";
            v139.RadiusStorages.BuildermanSentryEffectRange = l_Model_1;
            l_Highlight_1 = Instance.new("Highlight");
            l_Highlight_1.DepthMode = Enum.HighlightDepthMode.Occluded;
            l_Highlight_1.FillTransparency = 0.875;
            l_Highlight_1.OutlineTransparency = 0.6;
            l_Highlight_1.FillColor = v147;
            l_Highlight_1.Parent = l_Model_1;
            v147 = Color3.fromRGB(80, 255, 80);
            l_Model_1 = Instance.new("Model");
            l_Model_1.Parent = workspace.Map.Ingame;
            l_Model_1.Name = "BuildermanDispenserEffectRange";
            v139.RadiusStorages.BuildermanDispenserEffectRange = l_Model_1;
            l_Highlight_1 = Instance.new("Highlight");
            l_Highlight_1.DepthMode = Enum.HighlightDepthMode.Occluded;
            l_Highlight_1.FillTransparency = 0.875;
            l_Highlight_1.OutlineTransparency = 0.6;
            l_Highlight_1.FillColor = v147;
            l_Highlight_1.Parent = l_Model_1;
            function v147(v150, v151) --[[ Line: 693 ]] --[[ Name: createRadius ]]
                -- upvalues: v139 (copy)
                local v152 = v139.RadiusStorages[v150];
                if not v152 then
                    return;
                elseif not v151 then
                    return;
                else
                    local l_Part_0 = Instance.new("Part");
                    l_Part_0.CanCollide = false;
                    l_Part_0.Anchored = true;
                    l_Part_0.Transparency = 1;
                    l_Part_0.Position = Vector3.new(0, -100, 0, 0);
                    l_Part_0.Orientation = Vector3.new(0, 0, 90, 0);
                    l_Part_0.Size = Vector3.new(0.25, v151, v151);
                    l_Part_0.Material = Enum.Material.Glass;
                    l_Part_0.Shape = Enum.PartType.Cylinder;
                    l_Part_0.Parent = v152;
                    return l_Part_0;
                end;
            end;
            v139.Connection = workspace.Map.Ingame.ChildAdded:Connect(function(v154) --[[ Line: 711 ]]
                -- upvalues: v139 (copy), v147 (copy)
                if v154.Name:find("Builderman") then
                    local v155 = v154:WaitForChild("Humanoid", 10);
                    if not v155 then
                        return;
                    else
                        local v156 = v154:WaitForChild("Root", 10);
                        if not v156 then
                            return;
                        else
                            local v157 = {
                                BuildermanSentryPlacementRange = v139.Config.SentryPlacementRadius, 
                                BuildermanSentryEffectRange = v139.Config.SentryDamageRadius, 
                                BuildermanDispenserPlacementRange = v139.Config.DispenserPlacementRadius, 
                                BuildermanDispenserEffectRange = v139.Config.DispenserHealingRadius
                            };
                            local v158 = ("%*PlacementRange"):format(v154.Name);
                            local v159 = ("%*EffectRange"):format(v154.Name);
                            local v160 = v147("PlacementRange", v157[v158]);
                            local v161 = v147(v159, v157[v159]);
                            v156:GetPropertyChangedSignal("Position"):Connect(function() --[[ Line: 736 ]]
                                -- upvalues: v160 (copy), v156 (copy), v161 (copy)
                                if v160 then
                                    v160.Position = v156.Position - Vector3.new(0, v156.Size.Y / 2 + 0.075, 0);
                                end;
                                if v161 then
                                    v161.Position = v156.Position - Vector3.new(0, v156.Size.Y / 2 + 0, 0);
                                end;
                            end);
                            v154:GetAttributeChangedSignal("EffectRadiusSize"):Connect(function() --[[ Line: 742 ]]
                                -- upvalues: v154 (copy), v161 (copy)
                                local l_v154_Attribute_0 = v154:GetAttribute("EffectRadiusSize");
                                if v161 then
                                    game.TweenService:Create(v161, TweenInfo.new(1), {
                                        Size = Vector3.new(0.25, l_v154_Attribute_0 * 2, l_v154_Attribute_0 * 2)
                                    }):Play();
                                end;
                            end);
                            v155.HealthChanged:Connect(function(v163) --[[ Line: 748 ]]
                                -- upvalues: v160 (copy), v161 (copy)
                                if v163 <= 0 then
                                    if v160 then
                                        v160:Destroy();
                                    end;
                                    if v161 then
                                        v161:Destroy();
                                    end;
                                end;
                            end);
                            v154.AncestryChanged:Connect(function(_, v165) --[[ Line: 755 ]]
                                -- upvalues: v160 (copy), v161 (copy)
                                if not v165 then
                                    if v160 then
                                        v160:Destroy();
                                    end;
                                    if v161 then
                                        v161:Destroy();
                                    end;
                                end;
                            end);
                        end;
                    end;
                end;
            end);
            v139.Rig.AncestryChanged:Connect(function(_, v167) --[[ Line: 765 ]]
                -- upvalues: v139 (copy)
                if not v167 then
                    if v139.Connection then
                        v139.Connection:Disconnect();
                    end;
                    for _, v169 in pairs(v139.RadiusStorages) do
                        v169:Destroy();
                    end;
                end;
            end);
        end;
        return;
    end;
end;
return v0;