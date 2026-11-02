-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = {};
local v2 = require(game.ReplicatedStorage.Modules.Sounds);
local v3 = require(game.ReplicatedStorage.Modules.Util);
local v4 = require(game.ReplicatedStorage.Modules.Network);
local v5 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v6 = require(game.ReplicatedStorage.Modules.Statuses);
local _ = require(game.ReplicatedStorage.Modules.AchievementUtil);
local _ = require(l_ReplicatedStorage_0.Modules.Sprite);
local v9 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local function v19(v10, v11, v12) --[[ Line: 27 ]] --[[ Name: toggleKnife ]]
    if v10.KnifeToggles then
        v10.KnifeToggles[v11] = v12 or nil;
    end;
    local v13 = 0;
    local v14 = v10.KnifeToggles or {};
    for _, _ in v14 do
        v13 = v13 + 1;
    end;
    if not v12 and v13 > 0 then
        return;
    else
        if v10 and v10.DaggerParts then
            for v17, v18 in pairs(v10.DaggerParts) do
                game.TweenService:Create(v17, TweenInfo.new(0.3), {
                    Transparency = v12 and v18 or 1
                }):Play();
            end;
        end;
        return;
    end;
end;
local v29 = {
    CLOSE = function(v20, _) --[[ Line: 45 ]]
        -- upvalues: v6 (copy)
        v6:ApplyStatus(v20.Player, "Speed", {
            Level = 2, 
            Duration = v20.Config.CrouchSpeedCloseTime
        });
        v20.StabAmplification = 1.5;
        task.delay(v20.Config.CrouchStabAmplifyTime, function() --[[ Line: 50 ]]
            -- upvalues: v20 (copy)
            if not v20 then
                return;
            else
                v20.StabAmplification = nil;
                return;
            end;
        end);
    end, 
    DEBUFF_SLOWNESS = function(v22, v23) --[[ Line: 58 ]]
        -- upvalues: v6 (copy)
        local v24 = math.floor((math.clamp(v23, v22.Config.CrouchDistances.DEBUFF_SLOWNESS[1], v22.Config.CrouchSlownessDebuffMax) - v22.Config.CrouchDistances.DEBUFF_SLOWNESS[1]) * 0.2);
        v6:ApplyStatus(v22.Player, "Slowness", {
            Level = 2, 
            Duration = v24
        });
    end, 
    DEBUFF_HIGHLIGHT = function(v25, _) --[[ Line: 64 ]]
        -- upvalues: v3 (copy)
        for _, v28 in (workspace.Players.Killers:GetChildren()) do
            v3:RevealPlayerAuraTo(v28, v25.Player, v25.Config.CrouchRevealTime);
            v3:RevealPlayerAuraTo(v25.Player, v25.Player, v25.Config.CrouchRevealTime);
        end;
    end
};
local function _(v30, v31, v32) --[[ Line: 75 ]] --[[ Name: playSound ]]
    -- upvalues: v2 (copy)
    if v30.CurrentSound then
        v30.CurrentSound:Destroy();
        v30.CurrentSound = nil;
    end;
    v30.CurrentSound = v2:Play(v30.Config.Sounds[v31], v32);
end;
local function v39(v34, v35) --[[ Line: 91 ]] --[[ Name: inflictCrouchEffects ]]
    -- upvalues: v29 (copy)
    for v36, v37 in v34.Config.CrouchDistances do
        local v38 = v37[2] > -1 and v37[2] or 1e999;
        if v37[1] <= v35 and v35 <= v38 then
            pcall(v29[v36], v34, v35);
        end;
    end;
end;
v1.Abilities = {
    Dagger = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://129077533212750", 
        KeybindType = "AltAbility1", 
        Callback = function(v40, v41) --[[ Line: 107 ]] --[[ Name: Callback ]]
            -- upvalues: v39 (copy), v19 (copy), v6 (copy), v2 (copy), v5 (copy), v4 (copy), v3 (copy)
            if game["Run Service"]:IsServer() then
                v40.AbilitiesDisabled = true;
                local l_Attribute_0 = v40.Rig:GetAttribute("Crouching");
                if l_Attribute_0 then
                    v40.Rig:SetAttribute("Crouching", nil);
                    if game["Run Service"]:IsStudio() then
                        print((("[TwoTimeRework]: Current distance from nearest killer: %*"):format(v40.CurrentStudsAway)));
                    end;
                    local l_CurrentStudsAway_0 = v40.CurrentStudsAway;
                    if v40.CurrentCrouchThread and l_CurrentStudsAway_0 ~= nil then
                        task.cancel(v40.CurrentCrouchThread);
                        v40.CurrentCrouchThread = nil;
                        v40.CurrentStudsAway = nil;
                        v39(v40, l_CurrentStudsAway_0);
                    end;
                    local v44 = tick();
                    v40:SetCooldownOf("Crouch", (math.clamp(v40.Config.CrouchCooldown - (v44 - (v40.TimeCrouched or v44)), v40.Config.CrouchMinCooldown, v40.Config.CrouchCooldown)));
                    v40.TimeCrouched = nil;
                    v19(v40, "Crouching", false);
                    v6:RemoveStatus(v40.Player, "Invisibility");
                    v6:RemoveStatus(v40.Player, "Undetectable");
                end;
                local l_PrimaryPart_0 = v40.Rig.PrimaryPart;
                if l_PrimaryPart_0 then
                    local v46 = ("%*Stab"):format(l_Attribute_0 and "Crouch" or "");
                    local v47 = {
                        Parent = l_PrimaryPart_0
                    };
                    if v40.CurrentSound then
                        v40.CurrentSound:Destroy();
                        v40.CurrentSound = nil;
                    end;
                    v40.CurrentSound = v2:Play(v40.Config.Sounds[v46], v47);
                end;
                v6:ApplyStatus(v40.Player, "Resistance", {
                    Level = v40.Config.DaggerResLevel, 
                    Duration = v40.Config.DaggerResDuration
                });
                v19(v40, "Dagger", true);
                task.delay(l_Attribute_0 and 0.3 or 0.05, function() --[[ Line: 155 ]]
                    -- upvalues: l_Attribute_0 (copy), v5 (ref), v40 (copy), v4 (ref), v3 (ref), v6 (ref), v2 (ref), l_PrimaryPart_0 (copy), v19 (ref)
                    local v48 = nil;
                    local v49 = l_Attribute_0 and 0.415 or 0.25;
                    task.spawn(function() --[[ Line: 159 ]]
                        -- upvalues: v5 (ref), v40 (ref), v49 (copy), v4 (ref), v48 (ref), v3 (ref), v6 (ref), v2 (ref), l_PrimaryPart_0 (ref)
                        local _ = v5:CreateHitbox(v40.Player, {
                            Size = Vector3.new(4, 6, 6.5, 0), 
                            CFrameOffset = CFrame.new(0, 0, -2.25), 
                            Damage = 0, 
                            Time = v49, 
                            Knockback = 0, 
                            HitMultiple = false, 
                            Connections = {
                                Hit = function(v50) --[[ Line: 170 ]] --[[ Name: Hit ]]
                                    -- upvalues: v40 (ref), v4 (ref), v48 (ref), v3 (ref), v6 (ref), v2 (ref), l_PrimaryPart_0 (ref)
                                    local l_PrimaryPart_1 = v40.Rig.PrimaryPart;
                                    local l_PrimaryPart_2 = v50.PrimaryPart;
                                    local v53 = v4:FireClientConnection(v40.Player, ("%*TwoTimePosition"):format((tostring(v40.Player))), "REMOTE_FUNCTION");
                                    local v54 = false;
                                    if l_PrimaryPart_1 and l_PrimaryPart_2 then
                                        v48 = v50;
                                        local l_Unit_0 = l_PrimaryPart_2.CFrame.LookVector.Unit;
                                        local l_Unit_1 = (l_PrimaryPart_2.Position - l_PrimaryPart_1.Position).Unit;
                                        local l_Unit_2 = (l_PrimaryPart_2.Position - v53).Unit;
                                        local v58 = l_Unit_1:Dot(l_Unit_0);
                                        local v59 = l_Unit_2:Dot(l_Unit_0);
                                        local v60 = math.deg((math.acos((l_PrimaryPart_1.CFrame.LookVector:Dot(l_PrimaryPart_2.CFrame.LookVector)))));
                                        local v61 = math.rad(v40.Config.DaggerBackstabThreshold) / 1.5707963267948966;
                                        local v62 = false;
                                        if 1 - v58 < v61 then
                                            v62 = v58 > 0;
                                        end;
                                        local v63 = false;
                                        if 1 - v59 < v61 + 0.45 then
                                            v63 = v59 > 0;
                                        end;
                                        local v64 = v60 < v40.Config.DaggerLookDirectionAngle;
                                        v54 = v62 and v63 and v64;
                                        if game["Run Service"]:IsStudio() then
                                            print((("[TwoTimeRework]: Look Direction Angle: %*"):format(v60)));
                                            print((("[TwoTimeRework]: Server Threshold Comparison: %*, %*"):format(v61, v58)));
                                            print((("[TwoTimeRework]: Client Threshold Comparison: %*, %*"):format(v61 + 0.1, v59)));
                                            print((("[TwoTimeRework]: isBackstabbing? %*"):format(v54)));
                                        end;
                                    end;
                                    if v54 then
                                        v3:ApplyDamage(v50, v40.Config.DaggerBackstabDamage * (v40.StabAmplification or 1));
                                        v6:ApplyStatus(v50, "Stunned", {
                                            Duration = v40.Config.DaggerBackstabStatusTime
                                        });
                                        v40:ChangeExpression("StunnedKiller", 4);
                                    else
                                        v3:ApplyDamage(v50, v40.Config.DaggerDamage * (v40.StabAmplification or 1));
                                        v6:ApplyStatus(v50, "Slowness", {
                                            Level = 2, 
                                            Duration = v40.Config.DaggerStatusTime
                                        });
                                        v6:ApplyStatus(v50, "Helpless", {
                                            Level = 1, 
                                            Duration = v40.Config.DaggerStatusTime
                                        });
                                    end;
                                    local l_Humanoid_0 = v40.Rig:FindFirstChild("Humanoid");
                                    if l_Humanoid_0 then
                                        l_Humanoid_0.Health = l_Humanoid_0.Health + (v54 and v40.Config.DaggerLifestealFromBack or v40.Config.DaggerLifestealFromFront);
                                    end;
                                    local l_v40_0 = v40;
                                    l_v40_0.Blood = l_v40_0.Blood + (v54 and v40.Config.BloodFromBack or v40.Config.BloodFromFront);
                                    v2:PlayVoiceline(v40, "SlashHit", {
                                        Priority = 1
                                    });
                                    if l_PrimaryPart_0 then
                                        v2:Play(v40.Config.Sounds.Hit, {
                                            Parent = v40.Rig.GhostFire.GhostfireBlade
                                        });
                                    end;
                                    v4:FireClientConnection(v40.Player, ("%*ReplicateNewBlood"):format((tostring(v40.Player))), "REMOTE_EVENT", v40.Blood);
                                    if v40.RespawnLocation then
                                        l_v40_0 = v40.RespawnLocation:FindFirstChild("EnabledFloor");
                                        if l_v40_0 then
                                            local v67 = math.clamp(v40.Blood / v40.Config.BloodRequiredForRespawn, 0, 1) * 8 + 2;
                                            l_v40_0.Transparent.Brightness = v67;
                                            for _, v69 in {
                                                l_v40_0.Specs, 
                                                l_v40_0.Specs2
                                            } do
                                                v69:Emit(v69:GetAttribute("EmitCount"));
                                            end;
                                            if v67 >= 9 then
                                                local l_FullShader_0 = v40.RespawnLocation.EnabledFloor.FullShader;
                                                if l_FullShader_0 then
                                                    l_FullShader_0.Enabled = true;
                                                end;
                                            end;
                                        end;
                                    end;
                                    if tostring(v50.Parent) == "Killers" then
                                        require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v40.Player, {
                                            Action = ("%* Killer as Two Time"):format(v54 and "Backstabbed" or "Stabbed"), 
                                            RewardType = "Offensive"
                                        });
                                    end;
                                end
                            }
                        });
                    end);
                    task.delay(v49, function() --[[ Line: 259 ]]
                        -- upvalues: v48 (ref)
                        if v48 == nil then
                            v48 = false;
                        end;
                    end);
                    local v72 = v3:ApplyVelocity(v40.Rig.PrimaryPart, l_Attribute_0 and v40.Config.DaggerLungeForce or v40.Config.DaggerUncrouchedLungeForce);
                    game.TweenService:Create(v72, TweenInfo.new(l_Attribute_0 and 0.4 or 0.15), {
                        LineVelocity = v72.LineVelocity / 3
                    }):Play();
                    game.Debris:AddItem(v72, l_Attribute_0 and 0.4 or 0.15);
                    task.spawn(function() --[[ Line: 270 ]]
                        -- upvalues: v48 (ref), v40 (ref), v4 (ref), v72 (copy), v19 (ref)
                        repeat
                            task.wait();
                        until v48 ~= nil;
                        v40.AbilitiesDisabled = false;
                        if game["Run Service"]:IsStudio() then
                            print("[TwoTimeRework]: Calling to turn off lunging.");
                        end;
                        v4:FireClientConnection(v40.Player, ("%*TTCollision"):format(v40.Player.Name), "REMOTE_EVENT");
                        if v72 then
                            game.TweenService:Create(v72, TweenInfo.new(typeof(v48) == "Instance" and 0.05 or 0.15), {
                                LineVelocity = 0
                            }):Play();
                            game.Debris:AddItem(v72, 0.15);
                        end;
                        task.delay(0.15, function() --[[ Line: 287 ]]
                            -- upvalues: v19 (ref), v40 (ref)
                            v19(v40, "Dagger", false);
                        end);
                    end);
                end);
                return l_Attribute_0;
            else
                if v41 then
                    local v73 = true;
                    local v74 = false;
                    do
                        local l_v73_0, l_v74_0 = v73, v74;
                        v4:SetConnection(("%*TTCollision"):format(v40.Player.Name), "REMOTE_EVENT", function() --[[ Line: 299 ]]
                            -- upvalues: l_v73_0 (ref)
                            if game["Run Service"]:IsStudio() then
                                print("[TwoTimeRework]: Recieved call to turn lunging off.");
                            end;
                            l_v73_0 = false;
                        end);
                        v40.Animations.LungeStart:Play(0);
                        task.delay(v40.Animations.LungeStart.Length, function() --[[ Line: 307 ]]
                            -- upvalues: v40 (copy), l_v73_0 (ref), l_v74_0 (ref), v4 (ref)
                            v40.Animations.LungeLoop:Play(0);
                            task.delay(0.6, function() --[[ Line: 311 ]]
                                -- upvalues: l_v73_0 (ref), l_v74_0 (ref)
                                if l_v73_0 then
                                    if game["Run Service"]:IsStudio() then
                                        print("[TwoTimeRework]: The time has passed! Getting out of lunge status.");
                                    end;
                                    l_v74_0 = true;
                                end;
                            end);
                            repeat
                                task.wait();
                            until l_v73_0 == false or l_v74_0;
                            if game["Run Service"]:IsStudio() then
                                print((("[TwoTimeRework]: Returned final result: isLunged: %*, isTimePast: %*."):format(l_v73_0, l_v74_0)));
                            end;
                            v4:RemoveConnection(("%*TTCollision"):format(v40.Player.Name), "REMOTE_EVENT");
                            v40.Animations.LungeStart:Stop(0);
                            v40.Animations.LungeLoop:Stop(0);
                            if not l_v74_0 then
                                v40.Animations.LungeEnd:Play(0);
                            end;
                        end);
                    end;
                else
                    v40.Animations.Stab:Play(0);
                end;
                v3:ToggleSprinting("TwoTimeStab", false, v41 and 1.5 or 0.3);
                local l_v3_SpeedMultiplier_0 = v3:CreateSpeedMultiplier(v40.Rig, 1, "TwoTimeStab", 1);
                game.TweenService:Create(l_v3_SpeedMultiplier_0, TweenInfo.new(0.35), {
                    Value = 0.1
                }):Play();
                task.wait(0.45);
                game.TweenService:Create(l_v3_SpeedMultiplier_0, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
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
        Callback = function(v78) --[[ Line: 352 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v39 (copy), v19 (copy), v6 (copy)
            if game["Run Service"]:IsServer() then
                local v79 = tick();
                if v78.Rig:GetAttribute("Crouching") then
                    v78.Rig:SetAttribute("Crouching", nil);
                    local l_PrimaryPart_3 = v78.Rig.PrimaryPart;
                    if l_PrimaryPart_3 then
                        local v81 = {
                            Parent = l_PrimaryPart_3
                        };
                        if v78.CurrentSound then
                            v78.CurrentSound:Destroy();
                            v78.CurrentSound = nil;
                        end;
                        v78.CurrentSound = v2:Play(v78.Config.Sounds.Stand, v81);
                    end;
                    if game["Run Service"]:IsStudio() then
                        print((("[TwoTimeRework]: Current distance from nearest killer: %*"):format(v78.CurrentStudsAway)));
                    end;
                    local l_CurrentStudsAway_1 = v78.CurrentStudsAway;
                    if v78.CurrentCrouchThread and l_CurrentStudsAway_1 ~= nil then
                        task.cancel(v78.CurrentCrouchThread);
                        v78.CurrentStudsAway = nil;
                        v78.CurrentCrouchThread = nil;
                        v39(v78, l_CurrentStudsAway_1);
                    end;
                    v78:SetCooldownOf("Crouch", (math.clamp(v78.Config.CrouchCooldown - (v79 - (v78.TimeCrouched or v79)), v78.Config.CrouchMinCooldown, v78.Config.CrouchCooldown)));
                    v78.TimeCrouched = nil;
                    v19(v78, "Crouching", false);
                    v6:RemoveStatus(v78.Player, "Invisibility");
                    v6:RemoveStatus(v78.Player, "Undetectable");
                    return;
                else
                    v78.AbilitiesDisabled = true;
                    v78.Rig:SetAttribute("Crouching", true);
                    local l_PrimaryPart_4 = v78.Rig.PrimaryPart;
                    if l_PrimaryPart_4 then
                        local v84 = {
                            Parent = l_PrimaryPart_4
                        };
                        if v78.CurrentSound then
                            v78.CurrentSound:Destroy();
                            v78.CurrentSound = nil;
                        end;
                        v78.CurrentSound = v2:Play(v78.Config.Sounds.Crouch, v84);
                    end;
                    task.delay(0.05, function() --[[ Line: 407 ]]
                        -- upvalues: v78 (copy)
                        v78.AbilitiesDisabled = false;
                    end);
                    v78:SetCooldownOf("Crouch", 1);
                    v78.TimeCrouched = v79;
                    if #workspace.Players.Killers:GetChildren() > 0 then
                        v78.CurrentCrouchThread = task.spawn(function() --[[ Line: 413 ]]
                            -- upvalues: v78 (copy)
                            while task.wait(0.025) do
                                for v85, v86 in (workspace.Players.Killers:GetChildren()) do
                                    if v86.PrimaryPart and v78.Rig.PrimaryPart then
                                        local l_Magnitude_0 = (v78.Rig.PrimaryPart.Position - v86.PrimaryPart.Position).Magnitude;
                                        if v85 > 1 then
                                            v78.CurrentStudsAway = v78.CurrentStudsAway < l_Magnitude_0 and v78.CurrentStudsAway or l_Magnitude_0;
                                        else
                                            v78.CurrentStudsAway = l_Magnitude_0;
                                        end;
                                    end;
                                end;
                            end;
                        end);
                    end;
                    v19(v78, "Crouching", true);
                    local v88 = v78.Config.CrouchCooldown - v78.Config.CrouchMinCooldown;
                    v6:ApplyStatus(v78.Player, "Invisibility", {
                        Duration = v88, 
                        Level = v78.Config.CrouchInvisibilityLevel
                    });
                    v6:ApplyStatus(v78.Player, "Undetectable", {
                        Duration = v88, 
                        Level = v78.Config.CrouchUndetectableLevel
                    });
                    task.delay(v88, function() --[[ Line: 439 ]]
                        -- upvalues: v79 (copy), v78 (copy), v19 (ref)
                        if v79 == v78.TimeCrouched then
                            v78.Rig:SetAttribute("Crouching", false);
                            v78:SetCooldownOf("Crouch", v78.Config.CrouchMinCooldown);
                            v78.TimeCrouched = nil;
                            v19(v78, false);
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
        Callback = function(v89, v90) --[[ Line: 458 ]] --[[ Name: Callback ]]
            -- upvalues: v19 (copy), v9 (copy), v3 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                local v91 = RaycastParams.new();
                v91.FilterDescendantsInstances = v89.Rig:GetChildren();
                v91.FilterType = Enum.RaycastFilterType.Exclude;
                local l_PrimaryPart_5 = v89.Rig.PrimaryPart;
                local v93 = workspace:Raycast(l_PrimaryPart_5.Position, Vector3.new(0, -100, 0, 0), v91);
                local _ = workspace:Raycast(l_PrimaryPart_5.Position, l_PrimaryPart_5.CFrame.LookVector * 100, v91);
                local v95 = v93.Position + Vector3.new(0, -0.10000000149011612, 0, 0);
                for _, v97 in (workspace.Map.Ingame:GetChildren()) do
                    if v97.Name:find("RespawnLocation") or v97.Name:find("Builderman") then
                        if v97:IsA("Model") then
                            v97 = v97.PrimaryPart;
                        end;
                        if (v95 - v97.Position).Magnitude < v89.Config.RespawnLocationDistance then
                            v89:IncrementCharges("Ritual", 1, 1);
                            return {
                                Cancelled = true
                            };
                        end;
                    end;
                end;
                if math.deg((math.acos((workspace:Raycast(l_PrimaryPart_5.Position, Vector3.new(0, -100, 0, 0), v91).Normal:Dot((Vector3.new(0, 1, 0, 0))))))) > 5 then
                    v89.AbilitiesDisabled = nil;
                    v89:IncrementCharges("Ritual", 1, 1);
                    return {
                        Cancelled = true
                    };
                else
                    v89.AbilitiesDisabled = true;
                    v19(v89, "Dagger", true);
                    local v98 = v89.Config.VFX.Ritual:Clone();
                    task.delay(1.5, function() --[[ Line: 498 ]]
                        -- upvalues: v89 (copy), v91 (copy), v98 (copy), v9 (ref)
                        local l_FirstChild_0 = v89.Rig:FindFirstChild("graphic", true);
                        local v100 = l_FirstChild_0 and l_FirstChild_0:FindFirstChildOfClass("Decal");
                        if v100 then
                            v100.Transparency = 1;
                        end;
                        local l_PrimaryPart_6 = v89.Rig.PrimaryPart;
                        local v102 = workspace:Raycast(l_PrimaryPart_6.Position, Vector3.new(0, -100, 0, 0), v91);
                        local v103 = workspace:Raycast(l_PrimaryPart_6.Position, l_PrimaryPart_6.CFrame.LookVector * 100, v91);
                        local v104 = v103 and math.clamp(v103.Distance, -1e999, 2.648) or 2.648;
                        local v105 = v89.Config.RespawnLocation:Clone();
                        local l_Size_0 = v105.Size;
                        v105.Name = ("%*RespawnLocation"):format(v89.Player.Name);
                        v105.Size = l_Size_0 + Vector3.new(0.5, 0.5, 0.5, 0);
                        v89.RespawnLocation = v105;
                        local l_v98_0 = v98;
                        l_v98_0.CFrame = l_v98_0.CFrame + Vector3.new(0, 0.15000000596046448, 0, 0);
                        v98.Parent = v105;
                        task.delay(0.05, function() --[[ Line: 523 ]]
                            -- upvalues: v98 (ref), v89 (ref), v105 (copy)
                            for _, v109 in (v98:GetChildren()) do
                                if v109:IsA("ParticleEmitter") then
                                    v109:Emit(v109:GetAttribute("EmitCount"));
                                end;
                            end;
                            local v110 = v89.Config.VFX.EnabledFloor:Clone();
                            v110.CFrame = v110.CFrame + Vector3.new(0, 0.15000000596046448, 0, 0);
                            v110.Parent = v105;
                            for _, v112 in {
                                v110.Shader, 
                                v110.Transparent
                            } do
                                v112.Enabled = true;
                            end;
                        end);
                        game.Debris:AddItem(v98, 1.5);
                        if v104 < 2.648 then
                            v104 = v104 - v105.Size.Z / 2;
                        end;
                        l_v98_0 = v102.Position + l_PrimaryPart_6.CFrame.LookVector * v104 + Vector3.new(0, -0.10000000149011612, 0, 0);
                        v105.CFrame = CFrame.lookAt(l_v98_0, l_v98_0 + l_PrimaryPart_6.CFrame.LookVector);
                        v105.Parent = workspace.Map.Ingame;
                        game.TweenService:Create(v105, v9, {
                            Size = l_Size_0
                        }):Play();
                    end);
                    task.delay(3.5, function() --[[ Line: 554 ]]
                        -- upvalues: v89 (copy), v19 (ref)
                        v89.AbilitiesDisabled = false;
                        v19(v89, "Dagger", false);
                    end);
                    return;
                end;
            elseif typeof(v90) == "table" and v90.Cancelled then
                v3:CreateWarning("TwoTimeWarning", "Cannot place this down!", v89.Config.WarningTemplate);
                return;
            else
                v89.Animations.Ritual:Play();
                local l_PrimaryPart_7 = v89.Rig.PrimaryPart;
                if l_PrimaryPart_7 then
                    local v114 = {
                        Parent = l_PrimaryPart_7
                    };
                    if v89.CurrentSound then
                        v89.CurrentSound:Destroy();
                        v89.CurrentSound = nil;
                    end;
                    v89.CurrentSound = v2:Play(v89.Config.Sounds.Mark, v114);
                end;
                local l_v3_SpeedMultiplier_1 = v3:CreateSpeedMultiplier(v89.Player, 0, (("%*Ritual"):format((tostring(v89.Player)))));
                task.delay(3.5, function() --[[ Line: 572 ]]
                    -- upvalues: l_v3_SpeedMultiplier_1 (copy)
                    game.TweenService:Create(l_v3_SpeedMultiplier_1, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                        Value = 1
                    }):Play();
                    game.Debris:AddItem(l_v3_SpeedMultiplier_1, 1);
                end);
                return;
            end;
        end
    }
};
v1.AddRig = function(_, v117, v118) --[[ Line: 581 ]] --[[ Name: AddRig ]]
    local v119 = v117.Config.LifeAppearances[v118];
    if v119 then
        for _, v121 in pairs(v117.Rig:GetDescendants()) do
            if (v121:IsA("BasePart") or v121:IsA("Decal")) and v121.Name ~= "Expression" and v121.Name ~= "CollisionHitbox" and v121.Name ~= "QueryHitbox" then
                v121.Transparency = 1;
            end;
        end;
        local v122 = v119:Clone();
        for _, v124 in pairs(v122:GetDescendants()) do
            if v124:IsA("BasePart") then
                v124.CollisionGroup = "Survivors";
                v124.CanCollide = false;
                v124.CanTouch = false;
                v124.CanQuery = false;
                v124.Massless = true;
            end;
        end;
        for _, v126 in (v117.Rig:GetChildren()) do
            if v126:IsA("BasePart") then
                v126.RootPriority = 1;
            end;
        end;
        for _, v128 in pairs(v122:GetChildren()) do
            local l_FirstChild_1 = v117.Rig:FindFirstChild(v128.Name);
            if l_FirstChild_1 then
                if v128:IsA("Humanoid") then
                    v128.EvaluateStateMachine = false;
                end;
                if l_FirstChild_1:IsA("BasePart") then
                    v128.Anchored = false;
                    v128.CanCollide = false;
                    v128.CFrame = l_FirstChild_1.CFrame;
                    local l_WeldConstraint_0 = Instance.new("WeldConstraint");
                    l_WeldConstraint_0.Part1 = v128;
                    l_WeldConstraint_0.Part0 = l_FirstChild_1;
                    l_WeldConstraint_0.Parent = v128;
                end;
            end;
        end;
        v122.Parent = v117.Rig;
        v117.Config.Expressions = v117.Config.ExpressionsTable[v118] or v117.Config.Expressions;
        v117:ChangeExpression("Hurt", 1);
    end;
end;
v1.OnHit = function(_, v132, v133, v134, v135) --[[ Line: 645 ]] --[[ Name: OnHit ]]
    -- upvalues: v4 (copy), v2 (copy), v3 (copy)
    if v135 or v132.Blood >= v132.Config.BloodRequiredForRespawn and v132.LivesUsed < v132.Config.Lives and v132.Rig.Humanoid.Health <= v134 and v132.RespawnLocation and #workspace.Players.Survivors:GetChildren() > 1 then
        if v133 then
            v133.TimePast = 9999;
        end;
        v132.Blood = 0;
        v132.LivesUsed = v132.LivesUsed + 1;
        if v132.Rig.PrimaryPart.Anchored then
            v132.Rig:SetAttribute("Invincible", true);
            local l_MaxHealth_0 = v132.Rig.Humanoid.MaxHealth;
            local l_Health_0 = v132.Rig.Humanoid.Health;
            v132.Rig.Humanoid.Health = 1;
            repeat
                task.wait();
            until v132.Rig.PrimaryPart.Anchored == false;
            v132.Rig.Humanoid.MaxHealth = l_MaxHealth_0;
            v132.Rig.Humanoid.Health = l_Health_0;
            v132.Rig:SetAttribute("Invincible", nil);
        end;
        v132.TimeSinceLastLife = tick();
        v132.Behavior:AddRig(v132, v132.LivesUsed);
        pcall(function() --[[ Line: 670 ]]
            -- upvalues: v132 (copy)
            v132.Behavior:AddRigSkin(v132, v132.LivesUsed);
        end);
        v132:IncrementCharges("Ritual", 0, 0);
        v4:FireClientConnection(v132.Player, ("%*TwoTimeBar"):format((tostring(v132.Player))), "REMOTE_EVENT", "DESTROY");
        if v132.RespawnLocation then
            local l_EnabledFloor_0 = v132.RespawnLocation:FindFirstChild("EnabledFloor");
            if l_EnabledFloor_0 then
                l_EnabledFloor_0:Destroy();
            end;
        end;
        local v139 = v132.Config.VFX.Respawned:Clone();
        v139.CFrame = v139.CFrame + Vector3.new(0, 0.15000000596046448, 0, 0);
        v139.Parent = v132.RespawnLocation;
        task.delay(0.05, function() --[[ Line: 693 ]]
            -- upvalues: v139 (copy)
            for _, v141 in (v139:GetChildren()) do
                if v141:IsA("ParticleEmitter") then
                    v141:Emit(v141:GetAttribute("EmitCount"));
                end;
            end;
        end);
        if v135 then
            v132.Rig.Humanoid.MaxHealth = v132.Config.LastSurvivorMaxHealth;
            local l_Humanoid_1 = v132.Rig.Humanoid;
            l_Humanoid_1.Health = l_Humanoid_1.Health + v132.Config.LastSurvivorHealthBonus;
        else
            local l_Humanoid_2 = v132.Rig.Humanoid;
            l_Humanoid_2.MaxHealth = l_Humanoid_2.MaxHealth / v132.Config.NextLifeHealthDivisor;
            v132.Rig.Humanoid.Health = v132.Rig.Humanoid.MaxHealth;
        end;
        local l_PrimaryPart_8 = v132.Rig.PrimaryPart;
        if l_PrimaryPart_8 then
            v2:Play(v132.Config.Sounds.Respawn, {
                Parent = l_PrimaryPart_8
            });
        end;
        v4:FireAllClientConnection(("%*TwoTimeReplicateAudio"):format(v132.Player), "REMOTE_EVENT", v132.Rig.PrimaryPart.Position);
        local _, v146 = v132.Rig:GetBoundingBox();
        if v132.RespawnLocation then
            v132.Rig:PivotTo(v132.RespawnLocation.CFrame + vector.create(0, v146.Y / 2, 0));
            if v132.LivesUsed >= v132.Config.Lives then
                game.Debris:AddItem(v132.RespawnLocation, 2);
                v132.RespawnLocation = nil;
            end;
        end;
        for _, v148 in (workspace.Players.Killers:GetChildren()) do
            v3:RevealPlayerAuraTo(v148, v132.Player, 2);
            v3:RevealPlayerAuraTo(v132.Player, v132.Player, 2);
        end;
        local v149 = require(game.ReplicatedStorage.Modules.Statuses);
        v149:RemoveStatuses(v132.Player, true);
        v149:ApplyStatus(v132.Player, "Speed", {
            Level = 2, 
            Duration = 6, 
            Instant = true
        });
        if not v135 then
            v149:ApplyStatus(v132.Player, "Weakness", {
                Level = 5, 
                Duration = 12
            });
        end;
        require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v132.Player, {
            Action = "Respawned as Two Time", 
            RewardType = "Survivalist"
        });
    end;
end;
v1.Created = function(_, v151) --[[ Line: 754 ]] --[[ Name: Created ]]
    -- upvalues: v1 (copy), v4 (copy), v9 (copy), v3 (copy), v2 (copy)
    if game["Run Service"]:IsServer() then
        v151.LivesUsed = 1;
        v151.Blood = 0;
        v151.Behavior:AddRig(v151, v151.LivesUsed);
        pcall(function() --[[ Line: 761 ]]
            -- upvalues: v151 (copy)
            v151.Behavior:AddRigSkin(v151, v151.LivesUsed);
        end);
        v151.Rig.Humanoid.Died:Connect(function() --[[ Line: 766 ]]
            -- upvalues: v151 (copy)
            if v151.TimeSinceLastLife and tick() - v151.TimeSinceLastLife <= 10 then
                require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(v151.Player, "TwoTimeDeath");
            end;
        end);
        local function v153() --[[ Line: 774 ]] --[[ Name: check ]]
            -- upvalues: v151 (copy), v1 (ref)
            local v152 = v151.Rig and v151.Rig:FindFirstChild("Humanoid");
            if v152 and v152.Health > 0 and v151.LivesUsed <= 1 and #workspace.Players.Survivors:GetChildren() <= 1 then
                v1:OnHit(v151, {}, 0, true);
            end;
        end;
        task.delay(0.5, v153);
        local v154 = nil;
        v154 = workspace.Players.Survivors.ChildRemoved:Connect(function() --[[ Line: 783 ]]
            -- upvalues: v151 (copy), v153 (copy), v154 (ref)
            if v151.Rig.Parent then
                v153();
                return;
            else
                v154:Disconnect();
                v154 = nil;
                return;
            end;
        end);
        local v155 = v151.Config.DaggerTemplate:Clone();
        local l_Motor6D_0 = v155:FindFirstChildOfClass("Motor6D");
        if l_Motor6D_0 then
            l_Motor6D_0.Part0 = v151.Rig.PrimaryPart;
            v155.Parent = v151.Rig;
        else
            v155:Destroy();
        end;
        v151.KnifeToggles = {};
        v151.DaggerParts = {};
        for _, v158 in pairs(v155:GetDescendants()) do
            local v159 = v158:IsA("BasePart");
            local v160 = v158:IsA("Decal");
            if v159 or v160 then
                v151.DaggerParts[v158] = v158.Transparency;
                v158.Transparency = 1;
                if v159 then
                    v158.CanCollide = false;
                end;
            end;
        end;
        return;
    elseif game["Run Service"]:IsClient() and v151.Rig == game.Players.LocalPlayer.Character then
        v151.Rig:WaitForChild("Humanoid"):GetPropertyChangedSignal("MaxHealth"):Connect(function() --[[ Line: 815 ]]
            -- upvalues: v151 (copy)
            if v151.Rig.Humanoid.MaxHealth <= 70 then
                local v161 = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting);
                v161.Stamina = math.clamp(v161.Stamina + 40, 0, v161.MaxStamina or 100);
            end;
        end);
        local v162 = v151.Config.HealthBar:Clone();
        v162.Bar.Inner.Size = UDim2.fromScale(1, 0);
        v162.Parent = v151.Player.PlayerGui.MainUI;
        v151.HealthbarDisplay = v162;
        local _ = function(v163, v164) --[[ Line: 829 ]] --[[ Name: animate ]]
            task.spawn(function() --[[ Line: 830 ]]
                -- upvalues: v163 (copy), v164 (copy)
                while v163.Visible do
                    for _, v166 in pairs(v164) do
                        local v167 = v166[1];
                        local v168 = v166[2];
                        local v169 = v166[3];
                        local v170 = v166[4];
                        v163.ImageRectOffset = Vector2.new(v167, v168);
                        v163.ImageRectSize = Vector2.new(v169, v170);
                        task.wait(0.03125);
                    end;
                    task.wait();
                end;
            end);
        end;
        local l_Display_0 = v162.Display;
        local v173 = require(v162.Display.Idle);
        local l_l_Display_0_0 = l_Display_0 --[[ copy: 4 -> 13 ]];
        local l_v173_0 = v173 --[[ copy: 5 -> 14 ]];
        task.spawn(function() --[[ Line: 830 ]]
            -- upvalues: l_l_Display_0_0 (copy), l_v173_0 (copy)
            while l_l_Display_0_0.Visible do
                for _, v177 in pairs(l_v173_0) do
                    local v178 = v177[1];
                    local v179 = v177[2];
                    local v180 = v177[3];
                    local v181 = v177[4];
                    l_l_Display_0_0.ImageRectOffset = Vector2.new(v178, v179);
                    l_l_Display_0_0.ImageRectSize = Vector2.new(v180, v181);
                    task.wait(0.03125);
                end;
                task.wait();
            end;
        end);
        l_Display_0 = v162.Full;
        v173 = require(v162.Full.Full);
        local l_l_Display_0_1 = l_Display_0 --[[ copy: 4 -> 15 ]];
        local l_v173_1 = v173 --[[ copy: 5 -> 16 ]];
        task.spawn(function() --[[ Line: 830 ]]
            -- upvalues: l_l_Display_0_1 (copy), l_v173_1 (copy)
            while l_l_Display_0_1.Visible do
                for _, v185 in pairs(l_v173_1) do
                    local v186 = v185[1];
                    local v187 = v185[2];
                    local v188 = v185[3];
                    local v189 = v185[4];
                    l_l_Display_0_1.ImageRectOffset = Vector2.new(v186, v187);
                    l_l_Display_0_1.ImageRectSize = Vector2.new(v188, v189);
                    task.wait(0.03125);
                end;
                task.wait();
            end;
        end);
        l_Display_0 = v162.Full.Vines;
        v173 = require(v162.Full.Vines.Sprite);
        local l_l_Display_0_2 = l_Display_0 --[[ copy: 4 -> 17 ]];
        local l_v173_2 = v173 --[[ copy: 5 -> 18 ]];
        task.spawn(function() --[[ Line: 830 ]]
            -- upvalues: l_l_Display_0_2 (copy), l_v173_2 (copy)
            while l_l_Display_0_2.Visible do
                for _, v193 in pairs(l_v173_2) do
                    local v194 = v193[1];
                    local v195 = v193[2];
                    local v196 = v193[3];
                    local v197 = v193[4];
                    l_l_Display_0_2.ImageRectOffset = Vector2.new(v194, v195);
                    l_l_Display_0_2.ImageRectSize = Vector2.new(v196, v197);
                    task.wait(0.03125);
                end;
                task.wait();
            end;
        end);
        l_Display_0 = v162.Full.Wings;
        v173 = require(v162.Full.Wings.Sprite);
        task.spawn(function() --[[ Line: 830 ]]
            -- upvalues: l_Display_0 (copy), v173 (copy)
            while l_Display_0.Visible do
                for _, v199 in pairs(v173) do
                    local v200 = v199[1];
                    local v201 = v199[2];
                    local v202 = v199[3];
                    local v203 = v199[4];
                    l_Display_0.ImageRectOffset = Vector2.new(v200, v201);
                    l_Display_0.ImageRectSize = Vector2.new(v202, v203);
                    task.wait(0.03125);
                end;
                task.wait();
            end;
        end);
        v4:SetConnection(("%*ReplicateNewBlood"):format((tostring(v151.Player))), "REMOTE_EVENT", function(v204) --[[ Line: 848 ]]
            -- upvalues: v151 (copy), v9 (ref), v162 (copy)
            if v151.isCompletedWithBlood then
                return;
            else
                if v151.tweenThread then
                    task.cancel(v151.tweenThread);
                end;
                local l_HealthbarDisplay_0 = v151.HealthbarDisplay;
                if l_HealthbarDisplay_0 then
                    local v206 = TweenInfo.new(0.65, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
                    local function v208(v207) --[[ Line: 855 ]] --[[ Name: tweenBarVisibility ]]
                        -- upvalues: l_HealthbarDisplay_0 (copy), v206 (copy)
                        game.TweenService:Create(l_HealthbarDisplay_0, v206, {
                            Position = UDim2.fromScale(v207 and 1.025 or 1.175, 0.5), 
                            Size = UDim2.fromScale(1, v207 and 0.532 or 0.4)
                        }):Play();
                    end;
                    v208(true);
                    game.TweenService:Create(l_HealthbarDisplay_0.Bar.Inner, v9, {
                        Size = UDim2.fromScale(1, (math.clamp(v204 / v151.Config.BloodRequiredForRespawn, 0, 1)))
                    }):Play();
                    v151.tweenThread = task.delay(v9.Time * 20, function() --[[ Line: 866 ]]
                        -- upvalues: v208 (copy), v151 (ref)
                        v208(false);
                        v151.tweenThread = nil;
                    end);
                    if v151.Config.BloodRequiredForRespawn <= v204 then
                        v162.Display.Visible = false;
                        v162.Full.Visible = true;
                        game.TweenService:Create(l_HealthbarDisplay_0, v206, {
                            Position = UDim2.fromScale(1, 0.5)
                        }):Play();
                        v151.isCompletedWithBlood = true;
                    end;
                end;
                return;
            end;
        end);
        v4:SetConnection(("%*TwoTimePosition"):format((tostring(v151.Player))), "REMOTE_FUNCTION", function() --[[ Line: 881 ]]
            -- upvalues: v151 (copy)
            return v151.Rig.PrimaryPart.Position;
        end);
        v4:SetConnection(("%*TwoTimeBar"):format((tostring(v151.Player))), "REMOTE_EVENT", function(v209) --[[ Line: 885 ]]
            -- upvalues: v151 (copy)
            if v209 == "DESTROY" then
                local l_HealthbarDisplay_1 = v151.HealthbarDisplay;
                if l_HealthbarDisplay_1 then
                    l_HealthbarDisplay_1:Destroy();
                    v151.HealthbarDisplay = nil;
                end;
            end;
        end);
        v151.Rig:GetAttributeChangedSignal("Crouching"):Connect(function() --[[ Line: 896 ]]
            -- upvalues: v151 (copy), v3 (ref)
            local _ = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting);
            local v212 = v151.Config.CrouchSpeed / v151.Config.Speed;
            if v151.Rig:GetAttribute("Crouching") then
                v151.Animations.CrouchStart:Play();
                v151.AnimationType = "Crouch";
                v151.MovementAnimSpeed = 1;
                task.delay(v151.Animations.CrouchStart.Length, function() --[[ Line: 907 ]]
                    -- upvalues: v151 (ref)
                    if not v151.AnimationType then
                        return;
                    else
                        if not v151.Animations.CrouchIdle.IsPlaying then
                            v151.Animations.CrouchIdle:Play();
                        end;
                        return;
                    end;
                end);
                local l_v3_SpeedMultiplier_2 = v3:CreateSpeedMultiplier(v151.Rig, 1, "TwoTimeCrouching");
                game.TweenService:Create(l_v3_SpeedMultiplier_2, TweenInfo.new(0.75, Enum.EasingStyle.Quint), {
                    Value = 0.15
                }):Play();
                task.wait(0.75);
                game.TweenService:Create(l_v3_SpeedMultiplier_2, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Value = v212
                }):Play();
                return;
            else
                v151.Animations.CrouchIdle:Stop(0.4);
                v151.AnimationType = nil;
                v151.MovementAnimSpeed = nil;
                local l_v3_SpeedMultiplier_3 = v3:CreateSpeedMultiplier(v151.Rig, v212, "TwoTimeCrouching");
                game.TweenService:Create(l_v3_SpeedMultiplier_3, TweenInfo.new(0.75, Enum.EasingStyle.Quint), {
                    Value = 1
                }):Play();
                game.Debris:AddItem(l_v3_SpeedMultiplier_3, 0.75);
                return;
            end;
        end);
        return;
    else
        v4:SetConnection(("%*TwoTimeReplicateAudio"):format(v151.Player), "REMOTE_EVENT", function(v215) --[[ Line: 937 ]]
            -- upvalues: v151 (copy), v2 (ref)
            if v151.Rig == game.Players.LocalPlayer.Character then
                return;
            else
                local v216 = v151.Config.AudioReplication:Clone();
                v216.Position = v215;
                v2:Play(v151.Config.Sounds.Respawn, {
                    Parent = v216
                });
                game.Debris:AddItem(v216, v151.Config.Sounds.Respawn.TimeLength);
                return;
            end;
        end);
        return;
    end;
end;
v1.Destroyed = function(_, v218) --[[ Line: 949 ]] --[[ Name: Destroyed ]]
    -- upvalues: v4 (copy)
    if game["Run Service"]:IsClient() then
        v4:RemoveConnection((("%*TwoTimePosition"):format((tostring(v218.Player)))));
        v4:RemoveConnection((("%*ReplicateNewBlood"):format((tostring(v218.Player)))));
        v4:RemoveConnection((("%*TwoTimeReplicateAudio"):format(v218.Player)));
        v4:RemoveConnection((("%*TTCollision"):format(v218.Player.Name)));
        v4:RemoveConnection((("%*TwoTimeBar"):format((tostring(v218.Player)))));
        v218.isCompletedWithBlood = false;
        if v218.HealthbarDisplay then
            v218.HealthbarDisplay:Destroy();
            v218.HealthbarDisplay = nil;
            return;
        end;
    elseif v218.RespawnLocation then
        v218.RespawnLocation:Destroy();
        v218.RespawnLocation = nil;
    end;
end;
return v1;