-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
v0.Abilities = {
    Attack = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "MainAbility", 
        Cooldown = 2, 
        Callback = function(v5) --[[ Line: 15 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v5.AbilitiesDisabled = true;
                v1:Play(v5.Config.Sounds.Swing, {
                    Parent = v5.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.25
                });
                task.delay(0.1, function() --[[ Line: 22 ]]
                    -- upvalues: v3 (ref), v5 (copy), v2 (ref), v1 (ref)
                    local _ = v3:CreateHitbox(v5.Player, {
                        Size = Vector3.new(4.5, 6, 3.5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1.5), 
                        Damage = v5.Config.AttackDamage, 
                        Time = 0.3, 
                        Knockback = 2, 
                        HitMultiple = false, 
                        Connections = {
                            Hit = function(v6) --[[ Line: 33 ]] --[[ Name: Hit ]]
                                -- upvalues: v2 (ref), v1 (ref), v5 (ref)
                                v2:CreateSpeedMultiplier(v6, 1.5, "HitSpeedBonus", 1.25);
                                v1:Play(v5.Config.Sounds.Hit, {
                                    Parent = v5.Rig.PrimaryPart, 
                                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                    Volume = 0.25
                                });
                            end
                        }
                    });
                end);
                task.delay(0.75, function() --[[ Line: 42 ]]
                    -- upvalues: v5 (copy)
                    v5.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v5.Animations.Attack:Play(0.025);
                end;
                return;
            end;
        end
    }, 
    EaglePunch = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "AltAbility3", 
        Cooldown = 5, 
        Callback = function(v8) --[[ Line: 59 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v1 (copy), v3 (copy)
            if game["Run Service"]:IsServer() then
                v8.AbilitiesDisabled = true;
                local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v8.Player, 0.01, "StrongLeft");
                v1:Play(v8.Rig.Attacks.FalconPunch.Pling, {
                    Parent = v8.Rig.PrimaryPart
                });
                v8.Rig["xtra stuff"].g2.PUNCh.PUNCHWARNING.Enabled = true;
                task.delay(0.15, function() --[[ Line: 70 ]]
                    -- upvalues: l_v2_SpeedMultiplier_0 (copy), v3 (ref), v8 (copy), v1 (ref)
                    l_v2_SpeedMultiplier_0.Value = 90000;
                    local _ = v3:CreateHitbox(v8.Player, {
                        Size = Vector3.new(7, 6, 7, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1.5), 
                        Damage = v8.Config.StrongAttackDamage, 
                        Time = 0.4, 
                        Knockback = v8.Config.StrongLeftForce, 
                        HitMultiple = true, 
                        RagdollOnHit = true, 
                        Connections = {
                            Hit = function(_) --[[ Line: 83 ]] --[[ Name: Hit ]]
                                -- upvalues: v1 (ref), v8 (ref)
                                v1:Play(v8.Rig.Attacks.FalconPunch.Hit, {
                                    Parent = v8.Rig.PrimaryPart
                                });
                                v1:Play(v8.Rig.Attacks.FalconPunch.Eagle, {
                                    Parent = v8.Rig.PrimaryPart
                                });
                                v1:Play(v8.Rig.Attacks.FalconPunch.Rock, {
                                    Parent = v8.Rig.PrimaryPart
                                });
                            end, 
                            Ended = function() --[[ Line: 88 ]] --[[ Name: Ended ]]
                                -- upvalues: l_v2_SpeedMultiplier_0 (ref)
                                l_v2_SpeedMultiplier_0.Value = 0.01;
                            end
                        }
                    });
                end);
                task.delay(1.25, function() --[[ Line: 96 ]]
                    -- upvalues: l_v2_SpeedMultiplier_0 (copy), v8 (copy)
                    l_v2_SpeedMultiplier_0:Destroy();
                    v8.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v8.Animations.StrongLeft:Play(0.025);
                    local v12 = tick();
                    local l_Humanoid_0 = v8.Player.Character.Humanoid;
                    v8.Rig["xtra stuff"].g2.PUNCh.PUNCHWARNING.Enabled = false;
                    local l_PrimaryPart_0 = v8.Player.Character.PrimaryPart;
                    v1:Play(v8.Rig.Attacks.FalconPunch.Swoop, {
                        Parent = v8.Rig.PrimaryPart
                    });
                    game["Run Service"]:BindToRenderStep("StrongLeft", Enum.RenderPriority.Character.Value + 1, function() --[[ Line: 111 ]]
                        -- upvalues: v12 (copy), l_Humanoid_0 (copy), l_PrimaryPart_0 (copy)
                        if tick() < v12 + 1.25 and l_Humanoid_0 and l_PrimaryPart_0 then
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
    }
};
v0.OnVictory = function(_, v16, _, v18, _) --[[ Line: 124 ]] --[[ Name: OnVictory ]]
    if v16 == "Start" then
        game.Lighting.ClockTime = 0;
        task.spawn(function() --[[ Line: 127 ]]
            -- upvalues: v18 (copy)
            local v20 = v18:WaitForChild("firebrand", 20);
            if v20 then
                v20.Transparency = 1;
            end;
        end);
        return;
    else
        if v16 == "End" then
            local v21 = require(game.ReplicatedStorage.Modules.Schematics.Lighting);
            v21:SetCustomLighting(v21.Properties);
        end;
        return;
    end;
end;
v0.OnExecution = function(_, v23, v24) --[[ Line: 139 ]] --[[ Name: OnExecution ]]
    local v25 = (v23.Rig.PrimaryPart.CFrame * CFrame.new(5, 0.5, 1)).LookVector.Unit * 200;
    local v26 = workspace:GetServerTimeNow() + 3.5;
    require(game.ReplicatedStorage.Modules.Network):FireAllClientConnection("Ragdoll", "REMOTE_EVENT", v24, v26, (("%*|%*|%*"):format(v25.X, v25.Y, v25.Z)));
    task.delay(2.25, function() --[[ Line: 149 ]]
        -- upvalues: v24 (copy)
        local l_Humanoid_1 = v24:FindFirstChild("Humanoid");
        if l_Humanoid_1 then
            l_Humanoid_1.BreakJointsOnDeath = false;
            l_Humanoid_1.Health = 0;
        end;
    end);
end;
return v0;