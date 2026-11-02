-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
v0.Abilities = {
    StrongLeft = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "AltAbility1", 
        Cooldown = 5, 
        Callback = function(v5) --[[ Line: 15 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v3 (copy), v1 (copy)
            if game["Run Service"]:IsServer() then
                v5.AbilitiesDisabled = true;
                local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v5.Player, 0.75, "StrongLeft");
                v5.Rig["Left Arm"].LeftGripAttachment.idle.Enabled = true;
                task.delay(0.83, function() --[[ Line: 25 ]]
                    -- upvalues: l_v2_SpeedMultiplier_0 (copy), v3 (ref), v5 (copy), v1 (ref)
                    l_v2_SpeedMultiplier_0.Value = 80;
                    local _ = v3:CreateHitbox(v5.Player, {
                        Size = Vector3.new(7, 6, 7, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1.5), 
                        Damage = v5.Config.StrongAttackDamage, 
                        Time = 0.15, 
                        Knockback = v5.Config.StrongLeftForce, 
                        HitMultiple = true, 
                        RagdollOnHit = true, 
                        Connections = {
                            Hit = function(_) --[[ Line: 38 ]] --[[ Name: Hit ]]
                                -- upvalues: v1 (ref), v5 (ref)
                                v1:Play(v5.Config.Sounds.StrongLeftHit, {
                                    Parent = v5.Rig.PrimaryPart
                                });
                            end, 
                            Ended = function() --[[ Line: 41 ]] --[[ Name: Ended ]]
                                -- upvalues: l_v2_SpeedMultiplier_0 (ref)
                                l_v2_SpeedMultiplier_0.Value = 0.01;
                            end
                        }
                    });
                end);
                task.delay(1.25, function() --[[ Line: 49 ]]
                    -- upvalues: l_v2_SpeedMultiplier_0 (copy), v5 (copy)
                    l_v2_SpeedMultiplier_0:Destroy();
                    v5.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v5.Animations.StrongLeft:Play(0.025);
                    local v9 = tick();
                    local l_Humanoid_0 = v5.Player.Character.Humanoid;
                    local l_PrimaryPart_0 = v5.Player.Character.PrimaryPart;
                    v5.Rig["Left Arm"].LeftGripAttachment.idle.Enabled = false;
                    game["Run Service"]:BindToRenderStep("StrongLeft", Enum.RenderPriority.Character.Value + 1, function() --[[ Line: 63 ]]
                        -- upvalues: v9 (copy), l_Humanoid_0 (copy), l_PrimaryPart_0 (copy)
                        if tick() < v9 + 1.25 and l_Humanoid_0 and l_PrimaryPart_0 then
                            l_Humanoid_0:Move(l_PrimaryPart_0.CFrame.LookVector);
                            return;
                        else
                            game["Run Service"]:UnbindFromRenderStep("StrongLeft");
                            return;
                        end;
                    end);
                end;
                return;
            end;
        end
    }, 
    Stomp = {
        LayoutOrder = 2, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "AltAbility2", 
        Cooldown = 5, 
        Callback = function(v12) --[[ Line: 80 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v3 (copy)
            if game["Run Service"]:IsServer() then
                v12.AbilitiesDisabled = true;
                local l_v2_SpeedMultiplier_1 = v2:CreateSpeedMultiplier(v12.Player, 0.01, "HinderedMovement");
                game.TweenService:Create(l_v2_SpeedMultiplier_1, TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                    Value = 1
                }):Play();
                game.Debris:AddItem(l_v2_SpeedMultiplier_1, 1.5);
                task.delay(0.333, function() --[[ Line: 91 ]]
                    -- upvalues: v2 (ref), v12 (copy), v3 (ref)
                    local l_v2_PlayerMousePosition_0 = v2:GetPlayerMousePosition(v12.Player);
                    local v15 = CFrame.lookAt(v12.Rig.PrimaryPart.Position, l_v2_PlayerMousePosition_0) * CFrame.new(0, 0, -v12.Config.AeroSpearSpeed * 10);
                    local v16 = script.Tornado:Clone();
                    v16.CFrame = CFrame.lookAt(v12.Rig.PrimaryPart.Position, l_v2_PlayerMousePosition_0);
                    v16.Parent = workspace.Map.Ingame;
                    game.Debris:AddItem(v16, 10);
                    game.TweenService:Create(v16, TweenInfo.new(10, Enum.EasingStyle.Linear), {
                        Position = v15.Position
                    }):Play();
                    v3:CreateHitbox(v12.Player, {
                        Size = Vector3.new(3, 3, 3, 0), 
                        CFrame = function() --[[ Line: 103 ]] --[[ Name: CFrame ]]
                            -- upvalues: v16 (copy)
                            return v16.CFrame;
                        end, 
                        Damage = v12.Config.AeroSpearDamage, 
                        Time = 10, 
                        Knockback = 0.5, 
                        HitMultiple = true, 
                        ExecuteOnKill = false, 
                        PredictVelocity = false, 
                        Connections = {
                            Hit = function(v17) --[[ Line: 113 ]] --[[ Name: Hit ]]
                                -- upvalues: v2 (ref), v12 (ref)
                                v2:RevealPlayerAuraTo(v12.Player, v17, 10);
                            end
                        }
                    });
                end);
                task.delay(2, function() --[[ Line: 122 ]]
                    -- upvalues: v12 (copy)
                    v12.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v12.Animations.Stomp:Play(0.025);
                end;
                return;
            end;
        end
    }, 
    AeroSpear = {
        LayoutOrder = 3, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "AltAbility3", 
        Cooldown = 5, 
        Callback = function(v18) --[[ Line: 139 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v3 (copy)
            if game["Run Service"]:IsServer() then
                v18.AbilitiesDisabled = true;
                local l_v2_SpeedMultiplier_2 = v2:CreateSpeedMultiplier(v18.Player, 0.01, "HinderedMovement");
                game.TweenService:Create(l_v2_SpeedMultiplier_2, TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                    Value = 1
                }):Play();
                game.Debris:AddItem(l_v2_SpeedMultiplier_2, 1.5);
                task.delay(0.8, function() --[[ Line: 150 ]]
                    -- upvalues: v2 (ref), v18 (copy), v3 (ref)
                    local l_v2_PlayerMousePosition_1 = v2:GetPlayerMousePosition(v18.Player);
                    local v21 = CFrame.lookAt(v18.Rig.PrimaryPart.Position, l_v2_PlayerMousePosition_1) * CFrame.new(0, 0, -v18.Config.AeroSpearSpeed * 10);
                    local v22 = script.WindSlashProjectile:Clone();
                    v22.CFrame = CFrame.lookAt(v18.Rig.PrimaryPart.Position, l_v2_PlayerMousePosition_1);
                    v22.Parent = workspace.Map.Ingame;
                    game.Debris:AddItem(v22, 10);
                    game.TweenService:Create(v22, TweenInfo.new(10, Enum.EasingStyle.Linear), {
                        Position = v21.Position
                    }):Play();
                    v3:CreateHitbox(v18.Player, {
                        Size = Vector3.new(3, 3, 3, 0), 
                        CFrame = function() --[[ Line: 162 ]] --[[ Name: CFrame ]]
                            -- upvalues: v22 (copy)
                            return v22.CFrame;
                        end, 
                        Damage = v18.Config.AeroSpearDamage, 
                        Time = 10, 
                        Knockback = 0.5, 
                        HitMultiple = true, 
                        ExecuteOnKill = false, 
                        PredictVelocity = false, 
                        Connections = {
                            Hit = function(v23) --[[ Line: 172 ]] --[[ Name: Hit ]]
                                -- upvalues: v2 (ref), v18 (ref)
                                v2:RevealPlayerAuraTo(v18.Player, v23, 10);
                            end
                        }
                    });
                end);
                task.delay(2, function() --[[ Line: 181 ]]
                    -- upvalues: v18 (copy)
                    v18.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v18.Animations.AeroSpear:Play(0.025);
                end;
                return;
            end;
        end
    }, 
    Attack = {
        LayoutOrder = 4, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "MainAbility", 
        Cooldown = 0.5, 
        Callback = function(v24) --[[ Line: 198 ]] --[[ Name: Callback ]]
            -- upvalues: v3 (copy)
            if game["Run Service"]:IsServer() then
                v24.AbilitiesDisabled = true;
                task.delay(0.1, function() --[[ Line: 204 ]]
                    -- upvalues: v3 (ref), v24 (copy)
                    local _ = v3:CreateHitbox(v24.Player, {
                        Size = Vector3.new(4.5, 6, 2.75, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1.5), 
                        Damage = v24.Config.PunchDamage, 
                        Time = 0.3, 
                        Knockback = 2, 
                        HitMultiple = false, 
                        Connections = {
                            Hit = function(_) --[[ Line: 215 ]] --[[ Name: Hit ]]

                            end
                        }
                    });
                end);
                task.delay(0.4, function() --[[ Line: 222 ]]
                    -- upvalues: v24 (copy)
                    v24.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    if not v24.HitIndex then
                        v24.HitIndex = 0;
                    end;
                    v24.HitIndex = v24.HitIndex + 1;
                    v24.Animations.Punch1:Stop(0);
                    v24.Animations.Punch2:Stop(0);
                    v24.Animations[("Punch%*"):format(v24.HitIndex % 2 + 1)]:Play(0.025);
                end;
                return;
            end;
        end
    }
};
v0.OnIntroduction = function(_, _, v29, v30) --[[ Line: 239 ]] --[[ Name: OnIntroduction ]]
    task.spawn(function() --[[ Line: 240 ]]
        -- upvalues: v29 (copy)
        local v31 = v29:WaitForChild("firebrand", 20);
        if v31 then
            v31.Transparency = 0;
        end;
    end);
    local v32 = nil;
    task.delay(0.5, function() --[[ Line: 248 ]]
        -- upvalues: v32 (ref)
        v32 = game.Lighting.ClockTime;
        game.TweenService:Create(game.Lighting, TweenInfo.new(0.75), {
            ClockTime = 0
        }):Play();
    end);
    task.delay(1.5, function() --[[ Line: 253 ]]
        -- upvalues: v32 (ref), v30 (copy)
        local v33 = script.Sky:Clone();
        v33.Parent = game.Lighting;
        game.TweenService:Create(game.Lighting, TweenInfo.new(1.5), {
            ClockTime = v32 or 12
        }):Play();
        game.Debris:AddItem(v33, v30 - 1.5);
    end);
end;
v0.OnVictory = function(_, v35, _, v37, _) --[[ Line: 261 ]] --[[ Name: OnVictory ]]
    if v35 == "Start" then
        game.Lighting.ClockTime = 0;
        task.spawn(function() --[[ Line: 264 ]]
            -- upvalues: v37 (copy)
            local v39 = v37:WaitForChild("firebrand", 20);
            if v39 then
                v39.Transparency = 1;
            end;
        end);
        return;
    else
        if v35 == "End" then
            local v40 = require(game.ReplicatedStorage.Modules.Schematics.Lighting);
            v40:SetCustomLighting(v40.Properties);
        end;
        return;
    end;
end;
v0.OnExecution = function(_, v42, v43) --[[ Line: 276 ]] --[[ Name: OnExecution ]]
    local v44 = (v42.Rig.PrimaryPart.CFrame * CFrame.new(5, 0.5, 1)).LookVector.Unit * 200;
    local v45 = workspace:GetServerTimeNow() + 3.5;
    require(game.ReplicatedStorage.Modules.Network):FireAllClientConnection("Ragdoll", "REMOTE_EVENT", v43, v45, (("%*|%*|%*"):format(v44.X, v44.Y, v44.Z)));
    task.delay(2.25, function() --[[ Line: 286 ]]
        -- upvalues: v43 (copy)
        local l_Humanoid_1 = v43:FindFirstChild("Humanoid");
        if l_Humanoid_1 then
            l_Humanoid_1.BreakJointsOnDeath = false;
            l_Humanoid_1.Health = 0;
        end;
    end);
end;
return v0;