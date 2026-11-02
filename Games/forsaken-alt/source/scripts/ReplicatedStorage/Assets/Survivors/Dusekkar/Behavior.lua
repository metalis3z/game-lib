-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Util);
local v2 = require(game.ReplicatedStorage.Modules.Sounds);
local v3 = require(game.ReplicatedStorage.Modules.Network);
local v4 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v5 = require(game.ReplicatedStorage.Modules.Statuses);
local _ = require(game.ReplicatedStorage.Modules.AchievementUtil);
local v7 = require(game.ReplicatedStorage.Modules.Device);
local v8 = require(game.ReplicatedStorage.Modules.Actors);
local v9 = require(game.ReplicatedStorage.Modules.Misc.Maid);
local function v14(v10, v11) --[[ Line: 14 ]] --[[ Name: getMousePosRelativeTo ]]
    -- upvalues: v7 (copy)
    if v7:GetPlayerDevice() == "PC" then
        return (game:GetService("UserInputService"):GetMouseLocation());
    elseif v11 then
        local v12 = v10.PrimaryPart and workspace.CurrentCamera:WorldToViewportPoint(v10.PrimaryPart.Position) or Vector3.new();
        return Vector2.new(v12.X, v12.Y);
    else
        local v13 = workspace.CurrentCamera:WorldToViewportPoint((workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -500)).Position);
        return Vector2.new(v13.X, v13.Y);
    end;
end;
local function v22(v15, v16, v17) --[[ Line: 33 ]] --[[ Name: isCharWithinRadius ]]
    -- upvalues: v14 (copy)
    if not v15 or not v15.PrimaryPart then
        return;
    else
        local v18 = v14(v15, v17) + Vector2.new(0, v16 / 100);
        local v19, v20 = workspace.CurrentCamera:WorldToViewportPoint(v15.PrimaryPart.Position);
        if v20 then
            local l_Magnitude_0 = (Vector2.new(v19.X, v19.Y) - v18).Magnitude;
            return l_Magnitude_0 <= v16 / 2, l_Magnitude_0;
        else
            return;
        end;
    end;
end;
local function v30(v23, v24, v25, v26) --[[ Line: 43 ]] --[[ Name: playVFX ]]
    local v27 = v23.Config.VFXTemplate[v25]:Clone();
    v27.Parent = v24;
    if v26 then
        game.Debris:AddItem(v27, v26);
    end;
    for _, v29 in pairs(v27:GetChildren()) do
        if v29:IsA("ParticleEmitter") then
            v29:Emit(v29:GetAttribute("EmitCount") or 1);
        end;
    end;
    return v27;
end;
local function _(v31) --[[ Line: 61 ]] --[[ Name: scaleToOffset ]]
    return workspace.Camera.ViewportSize.Y * v31;
end;
v0.Abilities = {
    SpawnProtection = {
        LayoutOrder = 1, 
        KeybindType = "AltAbility1", 
        Icon = "rbxassetid://136501603087283", 
        Callback = function(v33, v34) --[[ Line: 71 ]] --[[ Name: Callback ]]
            -- upvalues: v3 (copy), v2 (copy), v5 (copy), v1 (copy), v30 (copy), v8 (copy), v7 (copy), v22 (copy)
            if game["Run Service"]:IsServer() then
                local v35 = v3:FireClientConnection(v33.Player, ("%*DusekkarGet"):format((tostring(v33.Player))), "REMOTE_FUNCTION");
                local v36 = false;
                if typeof(v35) == "Instance" then
                    v36 = false;
                    if v35.Parent == workspace.Players.Survivors then
                        v36 = v35;
                    end;
                end;
                v35 = v36;
                v36 = not v35 and "NoTarget" or v33.Rig:GetAttribute("Protecting") and "Protecting" or v35:GetAttribute("Protected") and "TargetProtected" or v35:GetAttribute("Protecting") and "TargetProtecting" or v35.PrimaryPart.Anchored and "TargetAnchored" or tick() - (tonumber(v35:GetAttribute("LastProtection")) or 0) <= v33.Config.SpawnProtectionTimeUntilProtectableAgain and (tonumber(v35:GetAttribute("LastProtection")) or 0) + v33.Config.SpawnProtectionTimeUntilProtectableAgain - tick();
                if not v36 then
                    v33.AbilitiesDisabled = true;
                    v33.Rig:SetAttribute("Protecting", true);
                    v35:SetAttribute("Protected", true);
                    v2:Play(v33.Config.Sounds.SpawnProtectionActivate, {
                        Parent = v33.Rig.PrimaryPart
                    });
                    local l_Humanoid_0 = v35.Humanoid;
                    local l_Humanoid_1 = v33.Rig.Humanoid;
                    local function v42() --[[ Line: 97 ]] --[[ Name: getCurrentProtectors ]]
                        local v39 = {};
                        for _, v41 in pairs(workspace.Players.Survivors:GetChildren()) do
                            if v41:GetAttribute("Protecting") then
                                table.insert(v39, v41);
                            end;
                        end;
                        return v39;
                    end;
                    local v43 = v42();
                    if v33.Config.SpawnProtectionMaxPlayers - #v43 <= 0 then
                        for _, v45 in pairs(v43) do
                            v45:SetAttribute("Protecting", nil);
                            v5:ApplyStatus(v45, "Blindness", {
                                Level = 3, 
                                Duration = v33.Config.SpawnProtectionOverflowDebuffDuration
                            });
                            v5:ApplyStatus(v45, "Slowness", {
                                Level = 3, 
                                Duration = v33.Config.SpawnProtectionOverflowDebuffDuration
                            });
                        end;
                        v35:SetAttribute("Protected", nil);
                        v33.AbilitiesDisabled = false;
                        return;
                    else
                        local l_v1_SpeedMultiplier_0 = v1:CreateSpeedMultiplier(v33.Player, 1 - v33.Config.SpawnProtectionSpeedReductionWhileInUse / 100, "SpawnProtection");
                        v5:ApplyStatus(v33.Player, "Slowness", v33.Config.SpawnProtectionSlownessData);
                        task.delay(0.3, function() --[[ Line: 128 ]]
                            -- upvalues: v2 (ref), v33 (copy), v30 (ref), v35 (ref), l_Humanoid_1 (copy), l_Humanoid_0 (copy), v5 (ref), v42 (copy), v8 (ref), l_v1_SpeedMultiplier_0 (copy)
                            local v47 = tick();
                            local v48 = v2:Play(v33.Config.Sounds.SpawnProtectionLoop, {
                                Parent = v33.Rig.PrimaryPart
                            });
                            v30(v33, v35.PrimaryPart, "Start", 10);
                            local v49 = v30(v33, v33.Rig.StaffDetector, "StaffBeam");
                            for _, v51 in pairs(v49:GetChildren()) do
                                v51.Attachment1 = v35.PrimaryPart and v35.PrimaryPart:FindFirstChildOfClass("Attachment");
                            end;
                            local v52 = v30(v33, v33.Rig.StaffDetector, "StaffMagic");
                            for _, v54 in pairs(v52:GetChildren()) do
                                if v54:IsA("ParticleEmitter") then
                                    v54:Emit(v54:GetAttribute("EmitCount") or 1);
                                end;
                                v54.Enabled = true;
                            end;
                            local v55 = v33.Config.VFXTemplate.Hold:Clone();
                            v55.Parent = v35.PrimaryPart;
                            for _, v57 in pairs(v55:GetChildren()) do
                                if v57:IsA("ParticleEmitter") then
                                    v57:Emit(v57:GetAttribute("EmitCount") or 1);
                                end;
                                v57.Enabled = true;
                            end;
                            local v58 = false;
                            local _ = task.delay(v33.Config.SpawnProtectionMaxDuration, function() --[[ Line: 163 ]]
                                -- upvalues: v58 (ref), v33 (ref)
                                if not v58 then
                                    v33.Rig:SetAttribute("Protecting", nil);
                                end;
                            end);
                            while v33.Rig.Parent and v33.Rig:GetAttribute("Protecting") and l_Humanoid_1.Health > 0 and l_Humanoid_0.Health > 0 do
                                v5:ApplyStatus(v35, "Resistance", {
                                    Level = 5 - #v42(), 
                                    Duration = 1
                                });
                                task.wait(0.2);
                            end;
                            if tick() - v47 >= 8 then
                                v8:IncrementActorStats(v33.Player, {
                                    Action = "Protected a Survivor for at least 8 seconds", 
                                    Money = 4, 
                                    EXP = 12
                                });
                            end;
                            v35:SetAttribute("LastProtection", tick());
                            if v35.Parent and v35.PrimaryPart then
                                game.TweenService:Create(v48, TweenInfo.new(0.3), {
                                    PlaybackSpeed = 0
                                }):Play();
                                v2:Play(v33.Config.Sounds.SpawnProtectionShieldBreak, {
                                    Parent = v35.PrimaryPart
                                });
                                task.delay(0.1, function() --[[ Line: 195 ]]
                                    -- upvalues: v30 (ref), v33 (ref), v35 (ref)
                                    v30(v33, v35.PrimaryPart, "Shatter", 10);
                                end);
                            end;
                            v49:Destroy();
                            for v60, v61 in pairs({
                                v55, 
                                v52
                            }) do
                                game.Debris:AddItem(v61, v60 == 1 and 0.25 or 4);
                                for _, v63 in pairs(v61:GetChildren()) do
                                    if v63:IsA("ParticleEmitter") then
                                        v63.Enabled = false;
                                    elseif v63:IsA("Light") then
                                        game.TweenService:Create(v63, TweenInfo.new(0.25), {
                                            Brightness = 0
                                        }):Play();
                                    end;
                                end;
                            end;
                            v35:SetAttribute("Protected", nil);
                            v58 = true;
                            game.TweenService:Create(l_v1_SpeedMultiplier_0, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                                Value = 1
                            }):Play();
                            game.Debris:AddItem(l_v1_SpeedMultiplier_0, 1);
                            task.delay(2, function() --[[ Line: 224 ]]
                                -- upvalues: v33 (ref)
                                v33.AbilitiesDisabled = false;
                            end);
                        end);
                        return {
                            Target = v35
                        };
                    end;
                else
                    return {
                        Target = v35, 
                        Cancelled = true, 
                        Reason = v36
                    };
                end;
            else
                if game["Run Service"]:IsClient() and typeof(v34) == "table" then
                    if v34.Cancelled then
                        local v64 = {
                            NoTarget = {
                                PC = "Cursor not close enough to a Survivor.", 
                                Console = "Survivor not detected on screen.", 
                                Mobile = "Survivor not detected on screen."
                            }, 
                            Protecting = "You're already protecting a Survivor. Dummy.", 
                            TargetProtecting = "That Dusekkar's already protecting another Survivor.", 
                            TargetProtected = "That Survivor's already being protected by another Dusekkar.", 
                            TargetAnchored = "That Survivor's occupied with something."
                        };
                        local l_PlayerDevice_0 = require(game.ReplicatedStorage.Modules.Device):GetPlayerDevice();
                        local v66 = v64[v34.Reason] or typeof(v34.Reason) == "number" and ("That Survivor can't be protected for another %* seconds."):format((math.round(v34.Reason))) or "Protectable Survivor not detected.";
                        if typeof(v66) == "table" then
                            v66 = v66[l_PlayerDevice_0] or "Survivor not detected on screen.";
                        end;
                        v1:CreateWarning("DusekkarWarning", v66, v33.Config.WarningTemplate);
                        return;
                    elseif v34.Target then
                        v33.Animations.StaffStartup:Play();
                        v33.Animations.StaffLoop:Play();
                        v1:ToggleSprinting("DusekkarProtect", false);
                        local l_Mouse_0 = v33.Player:GetMouse();
                        local l_SpawnProtectionScaleRadius_0 = v33.Config.SpawnProtectionScaleRadius;
                        local v69 = workspace.Camera.ViewportSize.Y * l_SpawnProtectionScaleRadius_0;
                        l_SpawnProtectionScaleRadius_0 = v33.Config.SpawnProtectionIndicatorTemplate:Clone();
                        l_SpawnProtectionScaleRadius_0.Parent = v33.Player.PlayerGui.TemporaryUI;
                        l_SpawnProtectionScaleRadius_0.ImageTransparency = 1;
                        game.TweenService:Create(l_SpawnProtectionScaleRadius_0, TweenInfo.new(0.3), {
                            ImageTransparency = 0
                        }):Play();
                        game.TweenService:Create(l_SpawnProtectionScaleRadius_0, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false), {
                            Rotation = 360
                        }):Play();
                        local v70 = v33.Config.SpawnProtectionRadiusTemplate:Clone();
                        v70.Parent = v33.Player.PlayerGui.TemporaryUI;
                        v70.ImageTransparency = 1;
                        v70.Size = UDim2.fromOffset(v69, v69);
                        v70.Rotation = v70.Rotation - 90;
                        game.TweenService:Create(v70, TweenInfo.new(0.3), {
                            ImageTransparency = 0, 
                            Rotation = v70.Rotation + 90
                        }):Play();
                        task.spawn(function() --[[ Line: 290 ]]
                            -- upvalues: v3 (ref), v33 (copy), v1 (ref), l_SpawnProtectionScaleRadius_0 (copy), v70 (copy), v34 (copy), v7 (ref), l_Mouse_0 (copy), v22 (ref), v69 (copy)
                            local v71 = 0;
                            local v72 = 0;
                            local v73 = nil;
                            local function v74() --[[ Line: 297 ]] --[[ Name: breakOut ]]
                                -- upvalues: v73 (ref), v3 (ref), v33 (ref), v1 (ref), l_SpawnProtectionScaleRadius_0 (ref), v70 (ref)
                                if not v73 then
                                    v73 = true;
                                    v3:FireServerConnection(("%*DusekkarCancel"):format((tostring(v33.Player))), "REMOTE_EVENT");
                                    v1:ToggleSprinting("DusekkarProtect", true);
                                    v33.Animations.StaffLoop:Stop();
                                    game.TweenService:Create(l_SpawnProtectionScaleRadius_0, TweenInfo.new(0.3), {
                                        ImageTransparency = 1
                                    }):Play();
                                    game.Debris:AddItem(l_SpawnProtectionScaleRadius_0, 0.3);
                                    game.TweenService:Create(v70, TweenInfo.new(0.3), {
                                        ImageTransparency = 1, 
                                        Rotation = v70.Rotation + 90
                                    }):Play();
                                    game.Debris:AddItem(v70, 0.3);
                                    game.TweenService:Create(l_SpawnProtectionScaleRadius_0.Warning, TweenInfo.new(0.3), {
                                        TextTransparency = 1, 
                                        TextStrokeTransparency = 1
                                    }):Play();
                                end;
                            end;
                            while v33.Rig.Parent and v70.Parent do
                                local v75 = workspace.CurrentCamera:WorldToViewportPoint(v34.Target.PrimaryPart.Position);
                                l_SpawnProtectionScaleRadius_0.Position = UDim2.fromOffset(v75.X, v75.Y);
                                l_SpawnProtectionScaleRadius_0.Warning.Rotation = -l_SpawnProtectionScaleRadius_0.Rotation;
                                v70.Position = v7:GetPlayerDevice() == "PC" and UDim2.fromOffset(l_Mouse_0.X, l_Mouse_0.Y + game.GuiService:GetGuiInset().Y) or l_SpawnProtectionScaleRadius_0.Position;
                                if not v33.Rig.Parent then
                                    v74();
                                end;
                                if not v33.Rig:GetAttribute("Protecting") then
                                    v74();
                                end;
                                if not v34.Target.Parent then
                                    v74();
                                end;
                                if v71 >= 0.05 then
                                    if not v22(v34.Target, v69, true) or v33.Config.SpawnProtectionTimeUntilBrokenByWallInterference <= v72 then
                                        v74();
                                        l_SpawnProtectionScaleRadius_0.Warning.Text = "CANCELLED\n\n\n\n:(";
                                    elseif not v1:IsOnScreen(v34.Target) then
                                        v72 = v72 + v71;
                                        local v76 = v33.Config.SpawnProtectionTimeUntilBrokenByWallInterference - v72;
                                        if v76 > 0 then
                                            l_SpawnProtectionScaleRadius_0.Warning.Text = ("TARGET IS BLOCKED\n\n\n\nCANCELLING IN %*S"):format(math.round(v76 * 10) / 10);
                                            l_SpawnProtectionScaleRadius_0.Warning.Visible = true;
                                        end;
                                    elseif l_SpawnProtectionScaleRadius_0.Warning.Visible then
                                        l_SpawnProtectionScaleRadius_0.Warning.Visible = false;
                                        v72 = 0;
                                    end;
                                    v71 = 0;
                                end;
                                v71 = v71 + task.wait();
                            end;
                        end);
                    end;
                end;
                return;
            end;
        end
    }, 
    PlasmaBeam = {
        LayoutOrder = 2, 
        KeybindType = "AltAbility2", 
        Icon = "rbxassetid://83030778673034", 
        Callback = function(v77, _) --[[ Line: 363 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v2 (copy), v3 (copy), v4 (copy), v5 (copy), v8 (copy), v30 (copy)
            if game["Run Service"]:IsServer() then
                v77.AbilitiesDisabled = true;
                task.delay(2, function() --[[ Line: 366 ]]
                    -- upvalues: v77 (copy)
                    v77.AbilitiesDisabled = false;
                end);
                local l_v1_SpeedMultiplier_1 = v1:CreateSpeedMultiplier(v77.Player, 1 - v77.Config.PlasmaBeamSpeedReductionWhileInUse / 100, "PlasmaBeam");
                v2:Play(v77.Config.Sounds.PlasmaBeamShoot, {
                    Parent = v77.Rig.PrimaryPart
                });
                task.delay(1.5, function() --[[ Line: 376 ]]
                    -- upvalues: v3 (ref), v77 (copy), v4 (ref), v5 (ref), v8 (ref), v30 (ref), l_v1_SpeedMultiplier_1 (copy)
                    local v80 = nil;
                    local v81 = nil;
                    local v82 = v3:FireClientConnection(v77.Player, "GetMousePosition", "REMOTE_FUNCTION");
                    local l_Position_0 = (v77.Rig.PrimaryPart.CFrame * CFrame.new(1.25, 1.5, -3.5)).Position;
                    local _ = v4:CreateHitbox(v77.Player, {
                        Size = Vector3.new(v77.Config.PlasmaBeamHitboxSize, v77.Config.PlasmaBeamHitboxSize, v77.Config.PlasmaBeamHitboxRange), 
                        CFrame = CFrame.lookAt(l_Position_0, v82) * CFrame.new(0, 0, -v77.Config.PlasmaBeamHitboxRange / 2), 
                        Time = 0.05, 
                        Damage = 0, 
                        FriendlyFire = true, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v84) --[[ Line: 390 ]] --[[ Name: Hit ]]
                                -- upvalues: v77 (ref), v80 (ref), v5 (ref), v8 (ref), v30 (ref), v81 (ref)
                                local l_PrimaryPart_0 = v84.PrimaryPart;
                                if l_PrimaryPart_0 then
                                    v77:ChangeExpression("HitTarget", 2);
                                    if tostring(v84.Parent) == "Survivors" and not v80 then
                                        v80 = true;
                                        v5:ApplyStatus(v84, "Speed", v77.Config.PlasmaBeamSpeedData);
                                        v8:IncrementActorStats(v77.Player, {
                                            Action = "Zapped a Survivor", 
                                            Money = 2, 
                                            EXP = 6
                                        });
                                        v30(v77, l_PrimaryPart_0, "Zap", 5);
                                        return;
                                    elseif tostring(v84.Parent) == "Killers" then
                                        local v86 = {};
                                        for v87, v88 in pairs(v77.Config.PlasmaBeamSlownessData) do
                                            v86[v87] = v88;
                                        end;
                                        v86.Duration = math.clamp(v86.Duration - (#v77 - 1) * 0.5, 0.5, v86.Duration);
                                        if v86.Duration > 0.5 and not v81 then
                                            v81 = true;
                                            v5:ApplyStatus(v84, "Slowness", v86);
                                            v8:IncrementActorStats(v77.Player, {
                                                Action = "Zapped a Killer", 
                                                Money = 3, 
                                                EXP = 9
                                            });
                                            v30(v77, l_PrimaryPart_0, "Zap", 5);
                                        end;
                                    end;
                                end;
                            end
                        }
                    });
                    v3:FireAllClientConnection(("%*DusekkarReplZap"):format((tostring(v77.Player))), "REMOTE_EVENT", v82, v77.Rig.StaffDetector);
                    task.wait(0.25);
                    game.TweenService:Create(l_v1_SpeedMultiplier_1, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                        Value = 1
                    }):Play();
                    game.Debris:AddItem(l_v1_SpeedMultiplier_1, 0.5);
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v77.Animations.StaffShot:Play();
                    v1:ToggleSprinting("DusekkarBeam", false, 1.6);
                end;
                return;
            end;
        end
    }
};
v0.Created = function(_, v91) --[[ Line: 439 ]] --[[ Name: Created ]]
    -- upvalues: v3 (copy), v1 (copy), v22 (copy), v9 (copy)
    if game["Run Service"]:IsServer() then
        v3:SetConnection(("%*DusekkarCancel"):format((tostring(v91.Player))), "REMOTE_EVENT", function(v92) --[[ Line: 442 ]]
            -- upvalues: v91 (copy)
            if v91.Player == v92 and v91.Rig:GetAttribute("Protecting") then
                v91.Rig:SetAttribute("Protecting", nil);
            end;
        end);
        return;
    else
        if game["Run Service"]:IsClient() then
            if v91.Player == game.Players.LocalPlayer then
                v3:SetConnection(("%*DusekkarGet"):format((tostring(v91.Player))), "REMOTE_FUNCTION", function() --[[ Line: 451 ]]
                    -- upvalues: v1 (ref), v91 (copy), v22 (ref)
                    local v93 = nil;
                    local v94 = nil;
                    local l_v1_ClosestPlayerFromPosition_0 = v1:GetClosestPlayerFromPosition(v91.Rig.PrimaryPart.Position, {
                        ReturnTable = true, 
                        MaxDistance = v91.Config.SpawnProtectionPlayerMinRadius, 
                        PlayerSelection = "Survivors"
                    });
                    for _, v97 in pairs(l_v1_ClosestPlayerFromPosition_0) do
                        local l_Player_0 = v97.Player;
                        local l_SpawnProtectionScaleRadius_1 = v91.Config.SpawnProtectionScaleRadius;
                        local v100 = workspace.Camera.ViewportSize.Y * l_SpawnProtectionScaleRadius_1;
                        local v101;
                        l_SpawnProtectionScaleRadius_1, v101 = v22(l_Player_0, v100);
                        if v1:IsOnScreen(l_Player_0) and l_SpawnProtectionScaleRadius_1 and l_Player_0 ~= v91.Rig and (not v93 or v101 <= v94) then
                            v93 = l_Player_0;
                            v94 = v101;
                        end;
                    end;
                    return v93;
                end);
            end;
            v3:SetConnection(("%*DusekkarReplZap"):format((tostring(v91.Player))), "REMOTE_EVENT", function(v102, v103) --[[ Line: 470 ]]
                -- upvalues: v9 (ref), v91 (copy)
                local v104 = v9.new();
                v91.BoltMaid = v104;
                local v105 = Instance.new("Attachment", v103);
                v105.WorldPosition = v103.Position;
                v104:Add(v105);
                local l_Part_0 = Instance.new("Part");
                v104:Add(l_Part_0);
                l_Part_0.Size = Vector3.new(1, 1, 1, 0);
                l_Part_0.Position = v102;
                l_Part_0.Transparency = 1;
                l_Part_0.Anchored = true;
                l_Part_0.CanCollide = false;
                l_Part_0.Name = "HitPart";
                l_Part_0.Parent = game.Workspace.Misc;
                local v107 = Instance.new("Attachment", l_Part_0);
                v107.WorldPosition = v102;
                v104:Add(v107);
                local v108 = require(game.ReplicatedStorage.Modules.Misc.LightningBolt);
                local l_PlasmaBeamColor1_0 = v91.Config.PlasmaBeamColor1;
                local l_PlasmaBeamColor2_0 = v91.Config.PlasmaBeamColor2;
                local v111 = v108.new(v105, v107, 10);
                v104:Add(v111);
                v111.PulseSpeed = 15;
                v111.MinRadius = 2.5;
                v111.MaxRadius = 3;
                v111.Frequency = 4;
                v111.FadeLength = 0.05;
                v111.AnimationSpeed = 5;
                v111.Color = l_PlasmaBeamColor1_0:Lerp(l_PlasmaBeamColor2_0, math.random(0, 1000) / 1000);
                v104:Add((require(game.ReplicatedStorage.Modules.Misc.LightningBolt.LightningSparks).new(v111)));
                local v112 = require(game.ReplicatedStorage.Modules.Misc.Shake);
                local v113 = v112.new();
                v113.Amplitude = 5;
                v113.Frequency = 0.05;
                v113.FadeInTime = 0.05;
                v113.FadeOutTime = 1;
                v113.Sustain = false;
                v113.RotationInfluence = Vector3.new(1, 1, 1, 0);
                v113.PositionInfluence = Vector3.new(1, 1, 1, 0);
                v104:Add(v113);
                v113:Start();
                v113:BindToRenderStep("ExplosionShake", Enum.RenderPriority.Last.Value, function(v114, v115, _) --[[ Line: 520 ]]
                    -- upvalues: v103 (copy), v112 (copy)
                    local l_Magnitude_1 = (game.Workspace.CurrentCamera.CFrame.Position - v103.Position).Magnitude;
                    v114 = v112.InverseSquare(v114, l_Magnitude_1);
                    v115 = v112.InverseSquare(v115, l_Magnitude_1);
                    local l_CurrentCamera_0 = game.Workspace.CurrentCamera;
                    l_CurrentCamera_0.CFrame = l_CurrentCamera_0.CFrame * (CFrame.new(v114) * CFrame.Angles(v115.X, v115.Y, v115.Z));
                end);
                task.spawn(function() --[[ Line: 527 ]]
                    -- upvalues: v111 (copy), v104 (copy)
                    for _ = 1, 90 do
                        local l_v111_0 = v111;
                        l_v111_0.MinRadius = l_v111_0.MinRadius * 0.8;
                        l_v111_0 = v111;
                        l_v111_0.MaxRadius = l_v111_0.MaxRadius * 0.8;
                        l_v111_0 = v111;
                        l_v111_0.Frequency = l_v111_0.Frequency * 0.8;
                        l_v111_0 = v111;
                        l_v111_0.MinThicknessMultiplier = l_v111_0.MinThicknessMultiplier * 0.8;
                        l_v111_0 = v111;
                        l_v111_0.MaxThicknessMultiplier = l_v111_0.MaxThicknessMultiplier * 0.8;
                        if v111.MaxRadius >= 0.15 then
                            task.wait();
                        else
                            break;
                        end;
                    end;
                    v104:Destroy();
                end);
            end);
        end;
        return;
    end;
end;
v0.Destroyed = function(_, v122) --[[ Line: 545 ]] --[[ Name: Destroyed ]]
    -- upvalues: v3 (copy)
    if game["Run Service"]:IsServer() then
        v3:RemoveConnection(("%*DusekkarCancel"):format((tostring(v122.Player))), "REMOTE_EVENT");
        return;
    else
        for _, v124 in {
            "RunMaid", 
            "BoltMaid"
        } do
            if v122[v124] then
                v122[v124]:Destroy();
                v122[v124] = nil;
            end;
        end;
        v3:RemoveConnection(("%*DusekkarReplZap"):format((tostring(v122.Player))), "REMOTE_EVENT");
        v3:RemoveConnection(("%*DusekkarGet"):format((tostring(v122.Player))), "REMOTE_FUNCTION");
        return;
    end;
end;
return v0;