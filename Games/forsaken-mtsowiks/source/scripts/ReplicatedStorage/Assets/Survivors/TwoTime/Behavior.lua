-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = {};
local v2 = require(game.ReplicatedStorage.Modules.Sounds);
local v3 = require(game.ReplicatedStorage.Modules.AchievementUtil);
local v4 = require(game.ReplicatedStorage.Modules.Util);
local v5 = require(game.ReplicatedStorage.Modules.Network);
local v6 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v7 = require(game.ReplicatedStorage.Modules.Statuses);
local _ = require(game.ReplicatedStorage.Modules.AchievementUtil);
local _ = require(l_ReplicatedStorage_0.Modules.Sprite);
local v10 = require(game.ReplicatedStorage.Modules.Actors);
local v11 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local function v21(v12, v13, v14) --[[ Line: 27 ]] --[[ Name: toggleKnife ]]
    if v12.KnifeToggles then
        v12.KnifeToggles[v13] = v14 or nil;
    end;
    local v15 = 0;
    local v16 = v12.KnifeToggles or {};
    for _, _ in v16 do
        v15 = v15 + 1;
    end;
    if not v14 and v15 > 0 then
        return;
    else
        if v12 and v12.DaggerParts then
            for v19, v20 in pairs(v12.DaggerParts) do
                game.TweenService:Create(v19, TweenInfo.new(0.3), {
                    Transparency = v14 and v20 or 1
                }):Play();
            end;
        end;
        return;
    end;
end;
local v31 = {
    CLOSE = function(v22, _) --[[ Line: 45 ]]
        -- upvalues: v7 (copy)
        v7:ApplyStatus(v22.Player, "Speed", {
            Level = 2, 
            Duration = v22.Config.CrouchSpeedCloseTime
        });
        v22.StabAmplification = 1.5;
        task.delay(v22.Config.CrouchStabAmplifyTime, function() --[[ Line: 50 ]]
            -- upvalues: v22 (copy)
            if not v22 then
                return;
            else
                v22.StabAmplification = nil;
                return;
            end;
        end);
    end, 
    DEBUFF_SLOWNESS = function(v24, v25) --[[ Line: 55 ]]
        -- upvalues: v7 (copy)
        local v26 = math.floor((math.clamp(v25, v24.Config.CrouchDistances.DEBUFF_SLOWNESS[1], v24.Config.CrouchSlownessDebuffMax) - v24.Config.CrouchDistances.DEBUFF_SLOWNESS[1]) * 0.2);
        v7:ApplyStatus(v24.Player, "Slowness", {
            Level = 2, 
            Duration = v26
        });
    end, 
    DEBUFF_HIGHLIGHT = function(v27, _) --[[ Line: 61 ]]
        -- upvalues: v4 (copy)
        for _, v30 in (workspace.Players.Killers:GetChildren()) do
            v4:RevealPlayerAuraTo(v30, v27.Player, v27.Config.CrouchRevealTime);
            v4:RevealPlayerAuraTo(v27.Player, v27.Player, v27.Config.CrouchRevealTime);
        end;
    end
};
local function _(v32, v33, v34) --[[ Line: 72 ]] --[[ Name: playSound ]]
    -- upvalues: v2 (copy)
    if v32.CurrentSound then
        v32.CurrentSound:Destroy();
        v32.CurrentSound = nil;
    end;
    v32.CurrentSound = v2:Play(v32.Config.Sounds[v33], v34);
end;
local function v41(v36, v37) --[[ Line: 88 ]] --[[ Name: inflictCrouchEffects ]]
    -- upvalues: v31 (copy)
    for v38, v39 in v36.Config.CrouchDistances do
        local v40 = v39[2] > -1 and v39[2] or 1e999;
        if v39[1] <= v37 and v37 <= v40 then
            pcall(v31[v38], v36, v37);
        end;
    end;
end;
v1.Abilities = {
    Dagger = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://129077533212750", 
        KeybindType = "AltAbility1", 
        Callback = function(v42, v43) --[[ Line: 104 ]] --[[ Name: Callback ]]
            -- upvalues: v41 (copy), v21 (copy), v7 (copy), v2 (copy), v6 (copy), v10 (copy), l_ReplicatedStorage_0 (copy), v4 (copy), v5 (copy)
            if game["Run Service"]:IsServer() then
                v42.AbilitiesDisabled = true;
                local l_Attribute_0 = v42.Rig:GetAttribute("Crouching");
                if l_Attribute_0 then
                    v42.Rig:SetAttribute("Crouching", nil);
                    if game["Run Service"]:IsStudio() then
                        print((("[TwoTimeRework]: Current distance from nearest killer: %*"):format(v42.CurrentStudsAway)));
                    end;
                    local l_CurrentStudsAway_0 = v42.CurrentStudsAway;
                    if v42.CurrentCrouchThread and l_CurrentStudsAway_0 ~= nil then
                        task.cancel(v42.CurrentCrouchThread);
                        v42.CurrentCrouchThread = nil;
                        v42.CurrentStudsAway = nil;
                        v41(v42, l_CurrentStudsAway_0);
                    end;
                    local v46 = tick();
                    v42:SetCooldownOf("Crouch", (math.clamp(v42.Config.CrouchCooldown - (v46 - (v42.TimeCrouched or v46)), v42.Config.CrouchMinCooldown, v42.Config.CrouchCooldown)));
                    v42.TimeCrouched = nil;
                    v21(v42, "Crouching", false);
                    v7:RemoveStatus(v42.Player, "Invisibility");
                    v7:RemoveStatus(v42.Player, "Undetectable");
                end;
                local l_PrimaryPart_0 = v42.Rig.PrimaryPart;
                if l_PrimaryPart_0 then
                    local v48 = ("%*Stab"):format(l_Attribute_0 and "Crouch" or "");
                    local v49 = {
                        Parent = l_PrimaryPart_0
                    };
                    if v42.CurrentSound then
                        v42.CurrentSound:Destroy();
                        v42.CurrentSound = nil;
                    end;
                    v42.CurrentSound = v2:Play(v42.Config.Sounds[v48], v49);
                end;
                v7:ApplyStatus(v42.Player, "Resistance", {
                    Level = v42.Config.DaggerResLevel, 
                    Duration = v42.Config.DaggerResDuration
                });
                v21(v42, "Dagger", true);
                task.delay(l_Attribute_0 and 0.3 or 0.1, function() --[[ Line: 152 ]]
                    -- upvalues: l_Attribute_0 (copy), v6 (ref), v42 (copy), v10 (ref), l_ReplicatedStorage_0 (ref), l_PrimaryPart_0 (copy), v2 (ref), v4 (ref), v7 (ref), v5 (ref), v21 (ref)
                    local v50 = nil;
                    local v51 = l_Attribute_0 and 0.415 or 0.25;
                    task.spawn(function() --[[ Line: 156 ]]
                        -- upvalues: v6 (ref), v42 (ref), v51 (copy), v50 (ref), v10 (ref), l_ReplicatedStorage_0 (ref), l_PrimaryPart_0 (ref), v2 (ref), v4 (ref), v7 (ref), v5 (ref)
                        local _ = v6:CreateHitbox(v42.Player, {
                            Size = Vector3.new(4, 6, 6.5, 0), 
                            CFrameOffset = CFrame.new(0, 0, -5), 
                            Damage = 0, 
                            Time = v51, 
                            Knockback = 0, 
                            HitMultiple = false, 
                            Connections = {
                                Hit = function(v52) --[[ Line: 167 ]] --[[ Name: Hit ]]
                                    -- upvalues: v42 (ref), v50 (ref), v10 (ref), l_ReplicatedStorage_0 (ref), l_PrimaryPart_0 (ref), v2 (ref), v4 (ref), v7 (ref), v5 (ref)
                                    local v53 = v52:GetAttribute("Stunned") or v52:GetAttribute("StunnedDisabled");
                                    local l_PrimaryPart_1 = v42.Rig.PrimaryPart;
                                    local l_PrimaryPart_2 = v52.PrimaryPart;
                                    local v56 = false;
                                    if l_PrimaryPart_1 and l_PrimaryPart_2 then
                                        v50 = v52;
                                        local v57 = v10.CurrentActors[game.Players:GetPlayerFromCharacter(v52)];
                                        local v58 = v57 and v57:GetPivot() or l_PrimaryPart_2.CFrame;
                                        local l_Unit_0 = v58.LookVector.Unit;
                                        local l_v42_Pivot_0 = v42:GetPivot();
                                        l_v42_Pivot_0 = CFrame.new(l_v42_Pivot_0.Position * Vector3.new(1, 0, 1, 0) + Vector3.new(0, v58.Position.Y, 0)) * l_v42_Pivot_0.Rotation;
                                        local v61 = math.deg((math.acos(((v58.Position - l_v42_Pivot_0.Position).Unit:Dot(l_Unit_0)))));
                                        local v62 = math.deg((math.acos((l_v42_Pivot_0.LookVector:Dot(l_Unit_0)))));
                                        local v63 = v62 < v42.Config.DaggerLookDirectionAngle;
                                        local v64 = v61 < v42.Config.DaggerBackstabThreshold;
                                        v56 = v63 and v64;
                                        if game["Run Service"]:IsStudio() then
                                            print((("[TwoTimeRework]: Look Direction Angle: %*"):format(v62)));
                                            print((("[TwoTimeRework]: Backstab Angle: %*"):format(v61)));
                                            print((("[TwoTimeRework]: isBackstabbing? %*"):format(v56)));
                                            for v65, v66 in ipairs({
                                                v58, 
                                                l_v42_Pivot_0
                                            }) do
                                                local v67 = l_ReplicatedStorage_0.Assets.Instances.Nothingburger:Clone();
                                                v67.Transparency = 0.5;
                                                v67.Size = Vector3.new(1, 1, 3, 0);
                                                v67.CFrame = v66 * CFrame.new(0, 0, -2);
                                                v67.Parent = workspace.Misc;
                                                local l_new_0 = Color3.new;
                                                local v69 = false;
                                                if v65 == 1 then
                                                    v69 = 1;
                                                end;
                                                local v70 = false;
                                                if v65 == 2 then
                                                    v70 = 1;
                                                end;
                                                v67.Color = l_new_0(v69, v70, 0);
                                                game.Debris:AddItem(v67, 3);
                                            end;
                                        end;
                                    end;
                                    if l_PrimaryPart_0 then
                                        v2:PlayVoiceline(v42, "SlashHit", {
                                            Priority = 1
                                        });
                                        v2:Play(v42.Config.Sounds.Hit, {
                                            Parent = v42.Rig.GhostFire.GhostfireBlade
                                        });
                                    end;
                                    if v56 then
                                        v4:ApplyDamage(v52, v42.Config.DaggerBackstabDamage * (v42.StabAmplification or 1));
                                        if not v53 then
                                            v7:ApplyStatus(v52, "Stunned", {
                                                Duration = v42.Config.DaggerBackstabStatusTime
                                            });
                                            v42:ChangeExpression("StunnedKiller", 4);
                                        end;
                                    else
                                        v4:ApplyDamage(v52, v42.Config.DaggerDamage * (v42.StabAmplification or 1));
                                        if not v53 then
                                            v7:ApplyStatus(v52, "Slowness", {
                                                Level = 2, 
                                                Duration = v42.Config.DaggerStatusTime - (#v42 - 1) * 0.25
                                            });
                                            v7:ApplyStatus(v52, "Helpless", {
                                                Level = 1, 
                                                Duration = v42.Config.DaggerStatusTime - (#v42 - 1) * 0.25, 
                                                TimeStackable = false
                                            });
                                        end;
                                    end;
                                    if v53 then
                                        return;
                                    else
                                        if tostring(v52.Parent) == "Killers" or tostring(v52.Parent) == "Survivors" then
                                            local l_Humanoid_0 = v42.Rig:FindFirstChild("Humanoid");
                                            if l_Humanoid_0 then
                                                v4:Heal(l_Humanoid_0, v56 and v42.Config.DaggerLifestealFromBack or v42.Config.DaggerLifestealFromFront);
                                            end;
                                            local l_v42_0 = v42;
                                            l_v42_0.Blood = l_v42_0.Blood + (v56 and v42.Config.BloodFromBack or v42.Config.BloodFromFront);
                                        end;
                                        v5:FireClientConnection(v42.Player, ("%*ReplicateNewBlood"):format((tostring(v42.Player))), "REMOTE_EVENT", v42.Blood);
                                        if v42.RespawnLocation then
                                            local l_EnabledFloor_0 = v42.RespawnLocation:FindFirstChild("EnabledFloor");
                                            if l_EnabledFloor_0 then
                                                local v74 = math.clamp(v42.Blood / v42.Config.BloodRequiredForRespawn, 0, 1) * 8 + 2;
                                                l_EnabledFloor_0.Transparent.Brightness = v74;
                                                for _, v76 in {
                                                    l_EnabledFloor_0.Specs, 
                                                    l_EnabledFloor_0.Specs2
                                                } do
                                                    v76:Emit(v76:GetAttribute("EmitCount"));
                                                end;
                                                if v74 >= 9 then
                                                    local l_FullShader_0 = v42.RespawnLocation.EnabledFloor.FullShader;
                                                    if l_FullShader_0 then
                                                        l_FullShader_0.Enabled = true;
                                                    end;
                                                end;
                                            end;
                                        end;
                                        if tostring(v52.Parent) == "Killers" then
                                            v10:IncrementActorStats(v42.Player, {
                                                Action = ("%* Killer as Two Time"):format(v56 and "Backstabbed" or "Stabbed"), 
                                                RewardType = "Offensive"
                                            });
                                        end;
                                        return;
                                    end;
                                end
                            }
                        });
                    end);
                    task.delay(v51, function() --[[ Line: 279 ]]
                        -- upvalues: v50 (ref)
                        if v50 == nil then
                            v50 = false;
                        end;
                    end);
                    local v79 = v4:ApplyVelocity(v42.Rig.PrimaryPart, l_Attribute_0 and v42.Config.DaggerLungeForce or v42.Config.DaggerUncrouchedLungeForce);
                    game.TweenService:Create(v79, TweenInfo.new(l_Attribute_0 and 0.4 or 0.2), {
                        LineVelocity = v79.LineVelocity / 3
                    }):Play();
                    game.Debris:AddItem(v79, l_Attribute_0 and 0.4 or 0.2);
                    task.spawn(function() --[[ Line: 290 ]]
                        -- upvalues: v50 (ref), v42 (ref), v5 (ref), v79 (copy), v21 (ref)
                        repeat
                            task.wait();
                        until v50 ~= nil;
                        v42.AbilitiesDisabled = false;
                        if game["Run Service"]:IsStudio() then
                            print("[TwoTimeRework]: Calling to turn off lunging.");
                        end;
                        v5:FireClientConnection(v42.Player, ("%*TTCollision"):format(v42.Player.Name), "REMOTE_EVENT");
                        if v79 then
                            game.TweenService:Create(v79, TweenInfo.new(typeof(v50) == "Instance" and 0.05 or 0.15), {
                                LineVelocity = 0
                            }):Play();
                            game.Debris:AddItem(v79, 0.15);
                        end;
                        task.delay(0.15, function() --[[ Line: 307 ]]
                            -- upvalues: v21 (ref), v42 (ref)
                            v21(v42, "Dagger", false);
                        end);
                    end);
                end);
                return l_Attribute_0;
            else
                if v43 then
                    local v80 = true;
                    local v81 = false;
                    do
                        local l_v80_0, l_v81_0 = v80, v81;
                        v5:SetConnection(("%*TTCollision"):format(v42.Player.Name), "REMOTE_EVENT", function() --[[ Line: 319 ]]
                            -- upvalues: l_v80_0 (ref)
                            if game["Run Service"]:IsStudio() then
                                print("[TwoTimeRework]: Recieved call to turn lunging off.");
                            end;
                            l_v80_0 = false;
                        end);
                        v42.Animations.LungeStart:Play(0);
                        task.delay(v42.Animations.LungeStart.Length, function() --[[ Line: 327 ]]
                            -- upvalues: v42 (copy), l_v80_0 (ref), l_v81_0 (ref), v5 (ref)
                            v42.Animations.LungeLoop:Play(0);
                            task.delay(0.6, function() --[[ Line: 331 ]]
                                -- upvalues: l_v80_0 (ref), l_v81_0 (ref)
                                if l_v80_0 then
                                    if game["Run Service"]:IsStudio() then
                                        print("[TwoTimeRework]: The time has passed! Getting out of lunge status.");
                                    end;
                                    l_v81_0 = true;
                                end;
                            end);
                            repeat
                                task.wait();
                            until l_v80_0 == false or l_v81_0;
                            if game["Run Service"]:IsStudio() then
                                print((("[TwoTimeRework]: Returned final result: isLunged: %*, isTimePast: %*."):format(l_v80_0, l_v81_0)));
                            end;
                            v5:RemoveConnection(("%*TTCollision"):format(v42.Player.Name), "REMOTE_EVENT");
                            v42.Animations.LungeStart:Stop(0);
                            v42.Animations.LungeLoop:Stop(0);
                            if not l_v81_0 then
                                v42.Animations.LungeEnd:Play(0);
                            end;
                        end);
                    end;
                else
                    v42.Animations.Stab:Play(0);
                end;
                v4:ToggleSprinting("TwoTimeStab", false, v43 and 2 or 1);
                local l_v4_SpeedMultiplier_0 = v4:CreateSpeedMultiplier(v42.Rig, 1, "TwoTimeStab", 1);
                game.TweenService:Create(l_v4_SpeedMultiplier_0, TweenInfo.new(0.35), {
                    Value = 0.1
                }):Play();
                task.wait(0.45);
                game.TweenService:Create(l_v4_SpeedMultiplier_0, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
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
        Callback = function(v85) --[[ Line: 372 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v41 (copy), v21 (copy), v7 (copy)
            if game["Run Service"]:IsServer() then
                local v86 = tick();
                if v85.Rig:GetAttribute("Crouching") then
                    v85.Rig:SetAttribute("Crouching", nil);
                    local l_PrimaryPart_3 = v85.Rig.PrimaryPart;
                    if l_PrimaryPart_3 then
                        local v88 = {
                            Parent = l_PrimaryPart_3
                        };
                        if v85.CurrentSound then
                            v85.CurrentSound:Destroy();
                            v85.CurrentSound = nil;
                        end;
                        v85.CurrentSound = v2:Play(v85.Config.Sounds.Stand, v88);
                    end;
                    if game["Run Service"]:IsStudio() then
                        print((("[TwoTimeRework]: Current distance from nearest killer: %*"):format(v85.CurrentStudsAway)));
                    end;
                    local l_CurrentStudsAway_1 = v85.CurrentStudsAway;
                    if v85.CurrentCrouchThread and l_CurrentStudsAway_1 ~= nil then
                        task.cancel(v85.CurrentCrouchThread);
                        v85.CurrentStudsAway = nil;
                        v85.CurrentCrouchThread = nil;
                        v41(v85, l_CurrentStudsAway_1);
                    end;
                    v85:SetCooldownOf("Crouch", (math.clamp(v85.Config.CrouchCooldown - (v86 - (v85.TimeCrouched or v86)), v85.Config.CrouchMinCooldown, v85.Config.CrouchCooldown)));
                    v85.TimeCrouched = nil;
                    v21(v85, "Crouching", false);
                    v7:RemoveStatus(v85.Player, "Invisibility");
                    v7:RemoveStatus(v85.Player, "Undetectable");
                    return;
                else
                    v85.AbilitiesDisabled = true;
                    v85.Rig:SetAttribute("Crouching", true);
                    local l_PrimaryPart_4 = v85.Rig.PrimaryPart;
                    if l_PrimaryPart_4 then
                        local v91 = {
                            Parent = l_PrimaryPart_4
                        };
                        if v85.CurrentSound then
                            v85.CurrentSound:Destroy();
                            v85.CurrentSound = nil;
                        end;
                        v85.CurrentSound = v2:Play(v85.Config.Sounds.Crouch, v91);
                    end;
                    task.delay(0.05, function() --[[ Line: 427 ]]
                        -- upvalues: v85 (copy)
                        v85.AbilitiesDisabled = false;
                    end);
                    v85:SetCooldownOf("Crouch", 1);
                    v85.TimeCrouched = v86;
                    if #workspace.Players.Killers:GetChildren() > 0 then
                        v85.CurrentCrouchThread = task.spawn(function() --[[ Line: 433 ]]
                            -- upvalues: v85 (copy)
                            while task.wait(0.025) do
                                for v92, v93 in (workspace.Players.Killers:GetChildren()) do
                                    if v93.PrimaryPart and v85.Rig.PrimaryPart then
                                        local l_Magnitude_0 = (v85.Rig.PrimaryPart.Position - v93.PrimaryPart.Position).Magnitude;
                                        if v92 > 1 then
                                            v85.CurrentStudsAway = v85.CurrentStudsAway < l_Magnitude_0 and v85.CurrentStudsAway or l_Magnitude_0;
                                        else
                                            v85.CurrentStudsAway = l_Magnitude_0;
                                        end;
                                    end;
                                end;
                            end;
                        end);
                    end;
                    v21(v85, "Crouching", true);
                    local v95 = v85.Config.CrouchCooldown - v85.Config.CrouchMinCooldown;
                    v7:ApplyStatus(v85.Player, "Invisibility", {
                        Duration = v95, 
                        Level = v85.Config.CrouchInvisibilityLevel
                    });
                    v7:ApplyStatus(v85.Player, "Undetectable", {
                        Duration = v95, 
                        Level = v85.Config.CrouchUndetectableLevel
                    });
                    task.delay(v95, function() --[[ Line: 459 ]]
                        -- upvalues: v86 (copy), v85 (copy), v21 (ref)
                        if v86 == v85.TimeCrouched then
                            v85.Rig:SetAttribute("Crouching", false);
                            v85:SetCooldownOf("Crouch", v85.Config.CrouchMinCooldown);
                            v85.TimeCrouched = nil;
                            v21(v85, false);
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
        Callback = function(v96, v97) --[[ Line: 478 ]] --[[ Name: Callback ]]
            -- upvalues: v21 (copy), v11 (copy), v4 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                local v98 = RaycastParams.new();
                v98.FilterDescendantsInstances = v96.Rig:GetChildren();
                v98.FilterType = Enum.RaycastFilterType.Exclude;
                local l_PrimaryPart_5 = v96.Rig.PrimaryPart;
                local v100 = workspace:Raycast(l_PrimaryPart_5.Position, Vector3.new(0, -100, 0, 0), v98);
                local _ = workspace:Raycast(l_PrimaryPart_5.Position, l_PrimaryPart_5.CFrame.LookVector * 100, v98);
                local v102 = v100.Position + Vector3.new(0, -0.10000000149011612, 0, 0);
                for _, v104 in (workspace.Map.Ingame:GetChildren()) do
                    if v104.Name:find("RespawnLocation") or v104.Name:find("Builderman") then
                        if v104:IsA("Model") then
                            v104 = v104.PrimaryPart;
                        end;
                        if (v102 - v104.Position).Magnitude < v96.Config.RespawnLocationDistance then
                            v96:IncrementCharges("Ritual", 1, 1);
                            return {
                                Cancelled = true
                            };
                        end;
                    end;
                end;
                if math.deg((math.acos((workspace:Raycast(l_PrimaryPart_5.Position, Vector3.new(0, -100, 0, 0), v98).Normal:Dot((Vector3.new(0, 1, 0, 0))))))) > 5 then
                    v96.AbilitiesDisabled = nil;
                    v96:IncrementCharges("Ritual", 1, 1);
                    return {
                        Cancelled = true
                    };
                else
                    v96.AbilitiesDisabled = true;
                    v21(v96, "Dagger", true);
                    local v105 = v96.Config.VFX.Ritual:Clone();
                    task.delay(1.5, function() --[[ Line: 518 ]]
                        -- upvalues: v96 (copy), v98 (copy), v105 (copy), v11 (ref)
                        local l_FirstChild_0 = v96.Rig:FindFirstChild("graphic", true);
                        local v107 = l_FirstChild_0 and l_FirstChild_0:FindFirstChildOfClass("Decal");
                        if v107 then
                            v107.Transparency = 1;
                        end;
                        local l_PrimaryPart_6 = v96.Rig.PrimaryPart;
                        local v109 = workspace:Raycast(l_PrimaryPart_6.Position, Vector3.new(0, -100, 0, 0), v98);
                        local v110 = workspace:Raycast(l_PrimaryPart_6.Position, l_PrimaryPart_6.CFrame.LookVector * 100, v98);
                        local v111 = v110 and math.clamp(v110.Distance, -1e999, 2.648) or 2.648;
                        local v112 = v96.Config.RespawnLocation:Clone();
                        local l_Size_0 = v112.Size;
                        v112.Name = ("%*RespawnLocation"):format(v96.Player.Name);
                        v112.Size = l_Size_0 + Vector3.new(0.5, 0.5, 0.5, 0);
                        v96.RespawnLocation = v112;
                        local l_v105_0 = v105;
                        l_v105_0.CFrame = l_v105_0.CFrame + Vector3.new(0, 0.15000000596046448, 0, 0);
                        v105.Parent = v112;
                        task.delay(0.05, function() --[[ Line: 543 ]]
                            -- upvalues: v105 (ref), v96 (ref), v112 (copy)
                            for _, v116 in (v105:GetChildren()) do
                                if v116:IsA("ParticleEmitter") then
                                    v116:Emit(v116:GetAttribute("EmitCount"));
                                end;
                            end;
                            local v117 = v96.Config.VFX.EnabledFloor:Clone();
                            v117.CFrame = v117.CFrame + Vector3.new(0, 0.15000000596046448, 0, 0);
                            v117.Parent = v112;
                            for _, v119 in {
                                v117.Shader, 
                                v117.Transparent
                            } do
                                v119.Enabled = true;
                            end;
                        end);
                        game.Debris:AddItem(v105, 1.5);
                        if v111 < 2.648 then
                            v111 = v111 - v112.Size.Z / 2;
                        end;
                        l_v105_0 = v109.Position + l_PrimaryPart_6.CFrame.LookVector * v111 + Vector3.new(0, -0.10000000149011612, 0, 0);
                        v112.CFrame = CFrame.lookAt(l_v105_0, l_v105_0 + l_PrimaryPart_6.CFrame.LookVector);
                        v112.Parent = workspace.Map.Ingame;
                        game.TweenService:Create(v112, v11, {
                            Size = l_Size_0
                        }):Play();
                    end);
                    task.delay(3.5, function() --[[ Line: 574 ]]
                        -- upvalues: v96 (copy), v21 (ref)
                        v96.AbilitiesDisabled = false;
                        v21(v96, "Dagger", false);
                    end);
                    return;
                end;
            elseif typeof(v97) == "table" and v97.Cancelled then
                v4:CreateWarning("TwoTimeWarning", "Cannot place this down!", v96.Config.WarningTemplate);
                return;
            else
                v96.Animations.Ritual:Play();
                local l_PrimaryPart_7 = v96.Rig.PrimaryPart;
                if l_PrimaryPart_7 then
                    local v121 = {
                        Parent = l_PrimaryPart_7
                    };
                    if v96.CurrentSound then
                        v96.CurrentSound:Destroy();
                        v96.CurrentSound = nil;
                    end;
                    v96.CurrentSound = v2:Play(v96.Config.Sounds.Mark, v121);
                end;
                local l_v4_SpeedMultiplier_1 = v4:CreateSpeedMultiplier(v96.Player, 0, (("%*Ritual"):format((tostring(v96.Player)))));
                task.delay(3.5, function() --[[ Line: 592 ]]
                    -- upvalues: l_v4_SpeedMultiplier_1 (copy)
                    game.TweenService:Create(l_v4_SpeedMultiplier_1, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                        Value = 1
                    }):Play();
                    game.Debris:AddItem(l_v4_SpeedMultiplier_1, 1);
                end);
                return;
            end;
        end
    }
};
v1.AddRig = function(_, v124, v125) --[[ Line: 601 ]] --[[ Name: AddRig ]]
    -- upvalues: v4 (copy)
    local v126 = v124.Config.LifeAppearances[v125];
    if v126 then
        if v126:IsA("Folder") then
            v126 = v126:GetChildren()[math.random(#v126:GetChildren())];
        end;
        for _, v128 in pairs(v124.Rig:GetDescendants()) do
            if (v128:IsA("BasePart") or v128:IsA("Decal")) and v128.Name ~= "Expression" and v128.Name ~= "CollisionHitbox" and v128.Name ~= "QueryHitbox" then
                v128.Transparency = 1;
            end;
        end;
        if v124.LastRig then
            v124.LastRig:Destroy();
            v124.LastRig = nil;
        end;
        local v129 = v126:Clone();
        for _, v131 in pairs(v129:GetDescendants()) do
            if v131:IsA("BasePart") then
                v131.CollisionGroup = "Survivors";
                v131.CanCollide = false;
                v131.CanTouch = false;
                v131.CanQuery = false;
                v131.Massless = true;
            end;
        end;
        for _, v133 in (v124.Rig:GetChildren()) do
            if v133:IsA("BasePart") then
                v133.RootPriority = 1;
            end;
        end;
        for _, v135 in pairs(v129:GetChildren()) do
            local l_FirstChild_1 = v124.Rig:FindFirstChild(v135.Name);
            if l_FirstChild_1 then
                if v135:IsA("Humanoid") then
                    v135.EvaluateStateMachine = false;
                end;
                if l_FirstChild_1:IsA("BasePart") then
                    v135.Anchored = false;
                    v135.CanCollide = false;
                    v135.CFrame = l_FirstChild_1.CFrame;
                    local l_WeldConstraint_0 = Instance.new("WeldConstraint");
                    l_WeldConstraint_0.Part1 = v135;
                    l_WeldConstraint_0.Part0 = l_FirstChild_1;
                    l_WeldConstraint_0.Parent = v135;
                end;
            end;
        end;
        v129.Parent = v124.Rig;
        v124.LastRig = v129;
        v124.Config.Expressions = v124.Config.ExpressionsTable[v125] or v124.Config.Expressions;
        v124:ChangeExpression("Hurt", 1);
        v4:FixCharacter(v124.Rig);
    end;
end;
v1.OnHelpless = function(_, v139) --[[ Line: 678 ]] --[[ Name: OnHelpless ]]
    -- upvalues: v21 (copy), v7 (copy)
    if v139.Rig:GetAttribute("Crouching") then
        v139.Rig:SetAttribute("Crouching", nil);
        local v140 = tick();
        v139:SetCooldownOf("Crouch", (math.clamp(v139.Config.CrouchCooldown - (v140 - (v139.TimeCrouched or v140)), v139.Config.CrouchMinCooldown, v139.Config.CrouchCooldown)));
        v139.TimeCrouched = nil;
        v21(v139, "Crouching", false);
        v7:RemoveStatus(v139.Player, "Invisibility");
        v7:RemoveStatus(v139.Player, "Undetectable");
    end;
end;
v1.OnHit = function(_, v142, v143, v144, v145) --[[ Line: 700 ]] --[[ Name: OnHit ]]
    -- upvalues: v4 (copy), v5 (copy), v2 (copy), v3 (copy)
    if v145 or v142.Blood >= v142.Config.BloodRequiredForRespawn and v142.LivesUsed < v142.Config.Lives and v142.Rig.Humanoid.Health <= v144 and v142.RespawnLocation and #workspace.Players.Survivors:GetChildren() > 1 then
        if v143 then
            v143.TimePast = 9999;
        end;
        v142.Blood = 0;
        v142.LivesUsed = v142.LivesUsed + 1;
        v142.TimeAddMultiplier = 0.5;
        local l_RoundManager_0 = game.ServerScriptService.Server.Systems.Core.RoundManager;
        require(l_RoundManager_0):AddTime(nil, 0.5);
        if v142.Rig.PrimaryPart.Anchored then
            v4:GiveInvincible(v142.Rig, "TTRevive");
            local l_MaxHealth_0 = v142.Rig.Humanoid.MaxHealth;
            local l_Health_0 = v142.Rig.Humanoid.Health;
            v142.Rig.Humanoid.Health = 1;
            repeat
                task.wait();
            until v142.Rig.PrimaryPart.Anchored == false;
            v142.Rig.Humanoid.MaxHealth = l_MaxHealth_0;
            v142.Rig.Humanoid.Health = l_Health_0;
        end;
        v4:GiveInvincible(v142.Rig, "TTRevive", 2);
        v142.TimeSinceLastLife = tick();
        v142.Behavior:AddRig(v142, v142.LivesUsed);
        pcall(function() --[[ Line: 731 ]]
            -- upvalues: v142 (copy)
            v142.Behavior:AddRigSkin(v142, v142.LivesUsed);
        end);
        v142:IncrementCharges("Ritual", 0, 0);
        v5:FireClientConnection(v142.Player, ("%*TwoTimeBar"):format((tostring(v142.Player))), "REMOTE_EVENT", "DESTROY");
        if v142.RespawnLocation then
            local l_EnabledFloor_1 = v142.RespawnLocation:FindFirstChild("EnabledFloor");
            if l_EnabledFloor_1 then
                l_EnabledFloor_1:Destroy();
            end;
        end;
        local v150 = v142.Config.VFX.Respawned:Clone();
        v150.CFrame = v150.CFrame + Vector3.new(0, 0.15000000596046448, 0, 0);
        v150.Parent = v142.RespawnLocation;
        task.delay(0.05, function() --[[ Line: 754 ]]
            -- upvalues: v150 (copy)
            for _, v152 in (v150:GetChildren()) do
                if v152:IsA("ParticleEmitter") then
                    v152:Emit(v152:GetAttribute("EmitCount"));
                end;
            end;
        end);
        if v145 then
            v142.Rig.Humanoid.MaxHealth = v142.Config.LastSurvivorMaxHealth;
            local l_Humanoid_1 = v142.Rig.Humanoid;
            l_Humanoid_1.Health = l_Humanoid_1.Health + v142.Config.LastSurvivorHealthBonus;
        else
            local l_Humanoid_2 = v142.Rig.Humanoid;
            l_Humanoid_2.MaxHealth = l_Humanoid_2.MaxHealth / v142.Config.NextLifeHealthDivisor;
            v142.Rig.Humanoid.Health = v142.Rig.Humanoid.MaxHealth;
        end;
        local l_PrimaryPart_8 = v142.Rig.PrimaryPart;
        if l_PrimaryPart_8 then
            v2:Play(v142.Config.Sounds.Respawn, {
                Parent = l_PrimaryPart_8
            });
        end;
        v5:FireAllClientConnection(("%*TwoTimeReplicateAudio"):format(v142.Player), "REMOTE_EVENT", v142.Rig.PrimaryPart.Position);
        if v142.RespawnLocation and (v142.Rig.PrimaryPart.Position - v142.RespawnLocation.Position).Magnitude < 16 then
            v3:IncrementAchievementProgress(v142.Player, "TwoTimeDeadRinger");
        end;
        local _, v157 = v142.Rig:GetBoundingBox();
        if v142.RespawnLocation then
            v142:PivotTo(v142.RespawnLocation.CFrame + vector.create(0, v157.Y / 2, 0));
            if v142.LivesUsed >= v142.Config.Lives then
                game.Debris:AddItem(v142.RespawnLocation, 2);
                v142.RespawnLocation = nil;
            end;
        end;
        for _, v159 in (workspace.Players.Killers:GetChildren()) do
            v4:RevealPlayerAuraTo(v159, v142.Player, 2);
            v4:RevealPlayerAuraTo(v142.Player, v142.Player, 2);
        end;
        local v160 = require(game.ReplicatedStorage.Modules.Statuses);
        v160:RemoveStatuses(v142.Player, true);
        v160:ApplyStatus(v142.Player, "Speed", {
            Level = 2, 
            Duration = 6, 
            Instant = true
        });
        if not v145 then
            v160:ApplyStatus(v142.Player, "Weakness", {
                Level = 5, 
                Duration = 12
            });
        end;
    end;
end;
v1.Created = function(_, v162) --[[ Line: 814 ]] --[[ Name: Created ]]
    -- upvalues: v1 (copy), v5 (copy), v11 (copy), v4 (copy), v2 (copy)
    if game["Run Service"]:IsServer() then
        v162.LivesUsed = 1;
        v162.Blood = 0;
        v162.Behavior:AddRig(v162, v162.LivesUsed);
        pcall(function() --[[ Line: 821 ]]
            -- upvalues: v162 (copy)
            v162.Behavior:AddRigSkin(v162, v162.LivesUsed);
        end);
        v162.Rig.Humanoid.Died:Once(function() --[[ Line: 826 ]]
            -- upvalues: v162 (copy)
            if v162.TimeSinceLastLife and tick() - v162.TimeSinceLastLife <= 10 then
                require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(v162.Player, "TwoTimeDeath");
            end;
        end);
        local function v164() --[[ Line: 834 ]] --[[ Name: check ]]
            -- upvalues: v162 (copy), v1 (ref)
            local v163 = v162.Rig and v162.Rig:FindFirstChild("Humanoid");
            if v163 and v163.Health > 0 and v162.LivesUsed <= 1 and #workspace.Players.Survivors:GetChildren() <= 1 then
                v1:OnHit(v162, {}, 0, true);
            end;
        end;
        task.delay(0.5, v164);
        local v165 = nil;
        v165 = workspace.Players.Survivors.ChildRemoved:Connect(function() --[[ Line: 843 ]]
            -- upvalues: v162 (copy), v164 (copy), v165 (ref)
            if v162.Rig.Parent then
                v164();
                return;
            else
                v165:Disconnect();
                v165 = nil;
                return;
            end;
        end);
        local v166 = v162.Config.DaggerTemplate:Clone();
        local l_Motor6D_0 = v166:FindFirstChildOfClass("Motor6D");
        if l_Motor6D_0 then
            l_Motor6D_0.Part0 = v162.Rig.PrimaryPart;
            v166.Parent = v162.Rig;
        else
            v166:Destroy();
        end;
        v162.KnifeToggles = {};
        v162.DaggerParts = {};
        for _, v169 in pairs(v166:GetDescendants()) do
            local v170 = v169:IsA("BasePart");
            local v171 = v169:IsA("Decal");
            if v170 or v171 then
                v162.DaggerParts[v169] = v169.Transparency;
                v169.Transparency = 1;
                if v170 then
                    v169.CanCollide = false;
                end;
            end;
        end;
        return;
    elseif game["Run Service"]:IsClient() and v162.Rig == game.Players.LocalPlayer.Character then
        v162.Rig:WaitForChild("Humanoid"):GetPropertyChangedSignal("MaxHealth"):Connect(function() --[[ Line: 875 ]]
            -- upvalues: v162 (copy)
            if v162.Rig.Humanoid.MaxHealth <= 70 then
                local v172 = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting);
                v172.Stamina = math.clamp(v172.Stamina + 40, 0, v172.MaxStamina or 100);
            end;
        end);
        pcall(function() --[[ Line: 882 ]]
            -- upvalues: v162 (copy)
            v162.Behavior:AddClientRigSkin(v162);
        end);
        local v173 = v162.Config.HealthBar:Clone();
        v173.Bar.Inner.Size = UDim2.fromScale(1, 0);
        v173.Parent = v162.Player.PlayerGui.MainUI;
        v162.HealthbarDisplay = v173;
        local _ = function(v174, v175) --[[ Line: 893 ]] --[[ Name: animate ]]
            task.spawn(function() --[[ Line: 894 ]]
                -- upvalues: v174 (copy), v175 (copy)
                while v174.Visible do
                    for _, v177 in pairs(v175) do
                        local v178 = v177[1];
                        local v179 = v177[2];
                        local v180 = v177[3];
                        local v181 = v177[4];
                        v174.ImageRectOffset = Vector2.new(v178, v179);
                        v174.ImageRectSize = Vector2.new(v180, v181);
                        task.wait(0.03125);
                    end;
                    task.wait();
                end;
            end);
        end;
        local l_Display_0 = v173.Display;
        local v184 = require(v173.Display.Idle);
        local l_l_Display_0_0 = l_Display_0 --[[ copy: 4 -> 13 ]];
        local l_v184_0 = v184 --[[ copy: 5 -> 14 ]];
        task.spawn(function() --[[ Line: 894 ]]
            -- upvalues: l_l_Display_0_0 (copy), l_v184_0 (copy)
            while l_l_Display_0_0.Visible do
                for _, v188 in pairs(l_v184_0) do
                    local v189 = v188[1];
                    local v190 = v188[2];
                    local v191 = v188[3];
                    local v192 = v188[4];
                    l_l_Display_0_0.ImageRectOffset = Vector2.new(v189, v190);
                    l_l_Display_0_0.ImageRectSize = Vector2.new(v191, v192);
                    task.wait(0.03125);
                end;
                task.wait();
            end;
        end);
        l_Display_0 = v173.Full;
        v184 = require(v173.Full.Full);
        local l_l_Display_0_1 = l_Display_0 --[[ copy: 4 -> 15 ]];
        local l_v184_1 = v184 --[[ copy: 5 -> 16 ]];
        task.spawn(function() --[[ Line: 894 ]]
            -- upvalues: l_l_Display_0_1 (copy), l_v184_1 (copy)
            while l_l_Display_0_1.Visible do
                for _, v196 in pairs(l_v184_1) do
                    local v197 = v196[1];
                    local v198 = v196[2];
                    local v199 = v196[3];
                    local v200 = v196[4];
                    l_l_Display_0_1.ImageRectOffset = Vector2.new(v197, v198);
                    l_l_Display_0_1.ImageRectSize = Vector2.new(v199, v200);
                    task.wait(0.03125);
                end;
                task.wait();
            end;
        end);
        l_Display_0 = v173.Full.Vines;
        v184 = require(v173.Full.Vines.Sprite);
        local l_l_Display_0_2 = l_Display_0 --[[ copy: 4 -> 17 ]];
        local l_v184_2 = v184 --[[ copy: 5 -> 18 ]];
        task.spawn(function() --[[ Line: 894 ]]
            -- upvalues: l_l_Display_0_2 (copy), l_v184_2 (copy)
            while l_l_Display_0_2.Visible do
                for _, v204 in pairs(l_v184_2) do
                    local v205 = v204[1];
                    local v206 = v204[2];
                    local v207 = v204[3];
                    local v208 = v204[4];
                    l_l_Display_0_2.ImageRectOffset = Vector2.new(v205, v206);
                    l_l_Display_0_2.ImageRectSize = Vector2.new(v207, v208);
                    task.wait(0.03125);
                end;
                task.wait();
            end;
        end);
        l_Display_0 = v173.Full.Wings;
        v184 = require(v173.Full.Wings.Sprite);
        task.spawn(function() --[[ Line: 894 ]]
            -- upvalues: l_Display_0 (copy), v184 (copy)
            while l_Display_0.Visible do
                for _, v210 in pairs(v184) do
                    local v211 = v210[1];
                    local v212 = v210[2];
                    local v213 = v210[3];
                    local v214 = v210[4];
                    l_Display_0.ImageRectOffset = Vector2.new(v211, v212);
                    l_Display_0.ImageRectSize = Vector2.new(v213, v214);
                    task.wait(0.03125);
                end;
                task.wait();
            end;
        end);
        v5:SetConnection(("%*ReplicateNewBlood"):format((tostring(v162.Player))), "REMOTE_EVENT", function(v215) --[[ Line: 912 ]]
            -- upvalues: v162 (copy), v11 (ref), v173 (copy)
            if v162.isCompletedWithBlood then
                return;
            else
                if v162.tweenThread then
                    task.cancel(v162.tweenThread);
                end;
                local l_HealthbarDisplay_0 = v162.HealthbarDisplay;
                if l_HealthbarDisplay_0 then
                    local v217 = TweenInfo.new(0.65, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
                    local function v219(v218) --[[ Line: 919 ]] --[[ Name: tweenBarVisibility ]]
                        -- upvalues: l_HealthbarDisplay_0 (copy), v217 (copy)
                        game.TweenService:Create(l_HealthbarDisplay_0, v217, {
                            Position = UDim2.fromScale(v218 and 1.025 or 1.175, 0.5), 
                            Size = UDim2.fromScale(1, v218 and 0.532 or 0.4)
                        }):Play();
                    end;
                    v219(true);
                    game.TweenService:Create(l_HealthbarDisplay_0.Bar.Inner, v11, {
                        Size = UDim2.fromScale(1, (math.clamp(v215 / v162.Config.BloodRequiredForRespawn, 0, 1)))
                    }):Play();
                    v162.tweenThread = task.delay(v11.Time * 20, function() --[[ Line: 930 ]]
                        -- upvalues: v219 (copy), v162 (ref)
                        v219(false);
                        v162.tweenThread = nil;
                    end);
                    if v162.Config.BloodRequiredForRespawn <= v215 then
                        v173.Display.Visible = false;
                        v173.Full.Visible = true;
                        game.TweenService:Create(l_HealthbarDisplay_0, v217, {
                            Position = UDim2.fromScale(1, 0.5)
                        }):Play();
                        v162.isCompletedWithBlood = true;
                        require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v162.Player, {
                            Action = "Hit Max Oblation as Two Time", 
                            RewardType = "Survivalist"
                        });
                    end;
                end;
                return;
            end;
        end);
        v5:SetConnection(("%*TwoTimeBar"):format((tostring(v162.Player))), "REMOTE_EVENT", function(v220) --[[ Line: 951 ]]
            -- upvalues: v162 (copy)
            if v220 == "DESTROY" then
                local l_HealthbarDisplay_1 = v162.HealthbarDisplay;
                if l_HealthbarDisplay_1 then
                    l_HealthbarDisplay_1:Destroy();
                    v162.HealthbarDisplay = nil;
                end;
            end;
        end);
        v162.Rig:GetAttributeChangedSignal("Crouching"):Connect(function() --[[ Line: 962 ]]
            -- upvalues: v162 (copy), v4 (ref)
            local _ = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting);
            local v223 = v162.Config.CrouchSpeed / v162.Config.Speed;
            if v162.Rig:GetAttribute("Crouching") then
                v162.Animations.CrouchStart:Play();
                v162.AnimationType = "Crouch";
                v162.MovementAnimSpeed = 1;
                task.delay(v162.Animations.CrouchStart.Length, function() --[[ Line: 973 ]]
                    -- upvalues: v162 (ref)
                    if not v162.AnimationType then
                        return;
                    else
                        if not v162.Animations.CrouchIdle.IsPlaying then
                            v162.Animations.CrouchIdle:Play();
                        end;
                        return;
                    end;
                end);
                local l_v4_SpeedMultiplier_2 = v4:CreateSpeedMultiplier(v162.Rig, 1, "TwoTimeCrouching");
                game.TweenService:Create(l_v4_SpeedMultiplier_2, TweenInfo.new(0.75, Enum.EasingStyle.Quint), {
                    Value = 0.15
                }):Play();
                task.wait(0.75);
                game.TweenService:Create(l_v4_SpeedMultiplier_2, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Value = v223
                }):Play();
                return;
            else
                v162.Animations.CrouchIdle:Stop(0.4);
                v162.AnimationType = nil;
                v162.MovementAnimSpeed = nil;
                local l_v4_SpeedMultiplier_3 = v4:CreateSpeedMultiplier(v162.Rig, v223, "TwoTimeCrouching");
                game.TweenService:Create(l_v4_SpeedMultiplier_3, TweenInfo.new(0.75, Enum.EasingStyle.Quint), {
                    Value = 1
                }):Play();
                game.Debris:AddItem(l_v4_SpeedMultiplier_3, 0.75);
                return;
            end;
        end);
        return;
    else
        v5:SetConnection(("%*TwoTimeReplicateAudio"):format(v162.Player), "REMOTE_EVENT", function(v226) --[[ Line: 1003 ]]
            -- upvalues: v162 (copy), v2 (ref)
            if v162.Rig == game.Players.LocalPlayer.Character then
                return;
            else
                local v227 = v162.Config.AudioReplication:Clone();
                v227.Position = v226;
                v2:Play(v162.Config.Sounds.Respawn, {
                    Parent = v227
                });
                game.Debris:AddItem(v227, v162.Config.Sounds.Respawn.TimeLength);
                return;
            end;
        end);
        return;
    end;
end;
v1.Destroyed = function(_, v229) --[[ Line: 1015 ]] --[[ Name: Destroyed ]]
    -- upvalues: v5 (copy)
    if game["Run Service"]:IsClient() then
        v5:RemoveConnection((("%*ReplicateNewBlood"):format((tostring(v229.Player)))));
        v5:RemoveConnection((("%*TwoTimeReplicateAudio"):format(v229.Player)));
        v5:RemoveConnection((("%*TTCollision"):format(v229.Player.Name)));
        v5:RemoveConnection((("%*TwoTimeBar"):format((tostring(v229.Player)))));
        v229.isCompletedWithBlood = false;
        if v229.HealthbarDisplay then
            v229.HealthbarDisplay:Destroy();
            v229.HealthbarDisplay = nil;
            return;
        end;
    elseif v229.RespawnLocation then
        v229.RespawnLocation:Destroy();
        v229.RespawnLocation = nil;
    end;
end;
return v1;