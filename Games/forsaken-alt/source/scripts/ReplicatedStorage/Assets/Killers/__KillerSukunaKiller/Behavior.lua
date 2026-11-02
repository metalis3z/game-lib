-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v5 = {
    Created = function(_, v1) --[[ Line: 4 ]] --[[ Name: Created ]]
        if game["Run Service"]:IsServer() then
            task.spawn(function() --[[ Line: 6 ]]
                -- upvalues: v1 (copy)
                local l_HumanoidDescriptionFromUserId_0 = game.Players:GetHumanoidDescriptionFromUserId(v1.Player.UserId);
                l_HumanoidDescriptionFromUserId_0.Head = 0;
                v1.Rig.Humanoid:ApplyDescription(l_HumanoidDescriptionFromUserId_0);
                for _, v4 in pairs(v1.Rig:GetChildren()) do
                    if v4:IsA("CharacterMesh") and v4.MeshId ~= 48112070 then
                        v4:Destroy();
                    end;
                end;
            end);
        end;
    end
};
local v6 = require(game.ReplicatedStorage.Modules.Sounds);
local v7 = require(game.ReplicatedStorage.Modules.Util);
local v8 = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
local v10 = require(game.ReplicatedStorage.Modules.Schematics.Lighting);
local _ = {};
v5.Abilities = {
    Slash = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "MainAbility", 
        Callback = function(v12) --[[ Line: 34 ]] --[[ Name: Callback ]]
            -- upvalues: v8 (copy), v7 (copy), v6 (copy)
            if game["Run Service"]:IsServer() then
                v12.AbilitiesDisabled = true;
                task.delay(0.325, function() --[[ Line: 41 ]]
                    -- upvalues: v8 (ref), v12 (copy), v7 (ref), v6 (ref)
                    local _ = v8:CreateHitbox(v12.Player, {
                        Size = Vector3.new(5, 6, 7, 0), 
                        CFrameOffset = CFrame.new(0, 0, -4.25), 
                        Damage = v12.Config.SlashDamage, 
                        Time = 0.2, 
                        Knockback = 0, 
                        HitMultiple = true, 
                        ExecuteOnKill = true, 
                        Connections = {
                            Hit = function(v13, v14) --[[ Line: 53 ]] --[[ Name: Hit ]]
                                -- upvalues: v7 (ref), v6 (ref), v12 (ref)
                                v7:CreateSpeedMultiplier(v13, 1.5, "HitSpeedBonus", 1);
                                if v14 then
                                    v6:Play(v12.Config.Sounds.SlashSFX, {
                                        Parent = v12.Rig.PrimaryPart, 
                                        PlaybackSpeed = Random.new():NextNumber(0.9, 1.1), 
                                        Volume = 0.25
                                    });
                                end;
                                local l_Humanoid_0 = v13:FindFirstChildOfClass("Humanoid");
                                if l_Humanoid_0 then
                                    local l_Torso_0 = v13:FindFirstChild("Torso");
                                    if l_Torso_0 then
                                        local l_CutO_0 = script:FindFirstChild("CutO");
                                        if l_CutO_0 then
                                            local v18 = l_CutO_0:Clone();
                                            v18.Parent = l_Torso_0;
                                            v18.Enabled = true;
                                            local l_v18_0 = v18 --[[ copy: 5 -> 8 ]];
                                            task.delay(0.2, function() --[[ Line: 71 ]]
                                                -- upvalues: l_v18_0 (copy)
                                                l_v18_0.Enabled = false;
                                                l_v18_0:Destroy();
                                            end);
                                        end;
                                        local l_Stars_0 = script:FindFirstChild("Stars");
                                        if l_Stars_0 then
                                            local v21 = l_Stars_0:Clone();
                                            v21.Parent = l_Torso_0;
                                            v21.Enabled = true;
                                            local function v22() --[[ Line: 83 ]] --[[ Name: cleanupStars ]]
                                                -- upvalues: v21 (copy)
                                                if v21 and v21.Parent then
                                                    v21.Enabled = false;
                                                    v21:Destroy();
                                                end;
                                            end;
                                            l_Humanoid_0.Died:Connect(v22);
                                            task.delay(0.2, v22);
                                        end;
                                    end;
                                end;
                            end
                        }
                    });
                end);
                task.delay(0.75, function() --[[ Line: 100 ]]
                    -- upvalues: v12 (copy)
                    v12.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v12.Animations.Slash:Play(0.175);
                end;
                return;
            end;
        end
    }, 
    Cleave = {
        LayoutOrder = 2, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "AltAbility1", 
        Cooldown = 10, 
        Callback = function(v24) --[[ Line: 116 ]] --[[ Name: Callback ]]
            -- upvalues: v6 (copy), v8 (copy), v7 (copy)
            if game["Run Service"]:IsServer() then
                v24.AbilitiesDisabled = true;
                v6:Play(v24.Config.Sounds.DismantleSFX, {
                    Parent = v24.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(1.25, 2.5), 
                    Volume = 0.25
                });
                task.delay(0.375, function() --[[ Line: 128 ]]
                    -- upvalues: v8 (ref), v24 (copy), v6 (ref)
                    local _ = v8:CreateHitbox(v24.Player, {
                        Size = Vector3.new(10, 4, 12, 0), 
                        CFrameOffset = CFrame.new(0, 0, -4.5), 
                        Damage = 0, 
                        Time = 0.39, 
                        Knockback = 0.1, 
                        HitMultiple = true, 
                        ExecuteOnKill = false, 
                        Connections = {
                            Hit = function(v25, _) --[[ Line: 139 ]] --[[ Name: Hit ]]
                                -- upvalues: v6 (ref), v24 (ref)
                                local l_Humanoid_1 = v25:FindFirstChildOfClass("Humanoid");
                                if l_Humanoid_1 then
                                    local v28 = v25:FindFirstChild("Torso") or v25:FindFirstChild("UpperTorso") or v25:FindFirstChild("LowerTorso");
                                    if v28 then
                                        local l_CutB_0 = script:FindFirstChild("CutB");
                                        if l_CutB_0 then
                                            local v30 = l_CutB_0:Clone();
                                            v30.Parent = v28;
                                            v30.Enabled = true;
                                            local l_v30_0 = v30 --[[ copy: 5 -> 10 ]];
                                            local function v32() --[[ Line: 153 ]] --[[ Name: cleanupCutB ]]
                                                -- upvalues: l_v30_0 (copy)
                                                if l_v30_0 and l_v30_0.Parent then
                                                    l_v30_0.Enabled = false;
                                                    l_v30_0:Destroy();
                                                end;
                                            end;
                                            l_Humanoid_1.Died:Connect(v32);
                                            task.delay(0.7, v32);
                                        end;
                                        local l_CutA_0 = script:FindFirstChild("CutA");
                                        if l_CutA_0 then
                                            local v34 = l_CutA_0:Clone();
                                            v34.Parent = v28;
                                            v34.Enabled = true;
                                            local l_v34_0 = v34 --[[ copy: 6 -> 9 ]];
                                            local function v36() --[[ Line: 171 ]] --[[ Name: cleanupCutA ]]
                                                -- upvalues: l_v34_0 (copy)
                                                if l_v34_0 and l_v34_0.Parent then
                                                    l_v34_0.Enabled = false;
                                                    l_v34_0:Destroy();
                                                end;
                                            end;
                                            l_Humanoid_1.Died:Connect(v36);
                                            task.delay(0.7, v36);
                                        end;
                                        local l_Stars_1 = script:FindFirstChild("Stars");
                                        if l_Stars_1 then
                                            local v38 = l_Stars_1:Clone();
                                            v38.Parent = v28;
                                            v38.Enabled = true;
                                            local function v39() --[[ Line: 188 ]] --[[ Name: cleanupStars ]]
                                                -- upvalues: v38 (copy)
                                                if v38 and v38.Parent then
                                                    v38.Enabled = false;
                                                    v38:Destroy();
                                                end;
                                            end;
                                            l_Humanoid_1.Died:Connect(v39);
                                            task.delay(0.7, v39);
                                        end;
                                    end;
                                end;
                                for v40 = 1, 15 do
                                    task.delay((v40 - 1) * 0.026000000000000002, function() --[[ Line: 202 ]]
                                        -- upvalues: l_Humanoid_1 (copy), v6 (ref), v24 (ref)
                                        if l_Humanoid_1 and l_Humanoid_1.Health > 0 then
                                            l_Humanoid_1:TakeDamage(5);
                                            v6:Play(v24.Config.Sounds.SlashSFX, {
                                                Parent = v24.Rig.PrimaryPart, 
                                                PlaybackSpeed = Random.new():NextNumber(0.9, 2), 
                                                Volume = 0.25
                                            });
                                        end;
                                    end);
                                end;
                            end
                        }
                    });
                end);
                task.delay(0.2, function() --[[ Line: 214 ]]
                    -- upvalues: v7 (ref), v24 (copy)
                    local v42 = v7:ApplyVelocity(v24.Rig.PrimaryPart, 60);
                    game.TweenService:Create(v42, TweenInfo.new(1), {
                        VectorVelocity = v42.VectorVelocity / 100
                    }):Play();
                    game.Debris:AddItem(v42, 0.2);
                end);
                task.delay(1.25, function() --[[ Line: 221 ]]
                    -- upvalues: v24 (copy)
                    v24.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    local l_v7_FOVMultiplier_0 = v7:CreateFOVMultiplier(v24.Player, 1, "FOVIncrease");
                    game.TweenService:Create(l_v7_FOVMultiplier_0, TweenInfo.new(0.35), {
                        Value = 1.35
                    }):Play();
                    v24.Animations.SDismantle:Play(0.175);
                    game.TweenService:Create(l_v7_FOVMultiplier_0, TweenInfo.new(0.5), {
                        Value = 1
                    }):Play();
                    game.Debris:AddItem(l_v7_FOVMultiplier_0, 0.5);
                end;
                return;
            end;
        end
    }, 
    Dismantle = {
        LayoutOrder = 3, 
        Icon = "rbxassetid://132724488499212", 
        KeybindType = "AltAbility2", 
        Cooldown = 20, 
        Callback = function(v44) --[[ Line: 242 ]] --[[ Name: Callback ]]
            -- upvalues: v6 (copy), v8 (copy)
            if game["Run Service"]:IsServer() then
                v44.AbilitiesDisabled = true;
                v6:Play(v44.Config.Sounds.DismantleSFX, {
                    Parent = v44.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.25
                });
                task.delay(0.6, function() --[[ Line: 256 ]]
                    -- upvalues: v8 (ref), v44 (copy), v6 (ref)
                    local _ = v8:CreateHitbox(v44.Player, {
                        Size = Vector3.new(10, 4, 12, 0), 
                        CFrameOffset = CFrame.new(0, 0, -4.5), 
                        Damage = 0, 
                        Time = 1.19, 
                        Knockback = 0.1, 
                        HitMultiple = true, 
                        ExecuteOnKill = false, 
                        Connections = {
                            Hit = function(v45, _) --[[ Line: 267 ]] --[[ Name: Hit ]]
                                -- upvalues: v6 (ref), v44 (ref)
                                local l_Humanoid_2 = v45:FindFirstChildOfClass("Humanoid");
                                if l_Humanoid_2 then
                                    local v48 = v45:FindFirstChild("Torso") or v45:FindFirstChild("UpperTorso") or v45:FindFirstChild("LowerTorso");
                                    if v48 then
                                        local l_CutB_1 = script:FindFirstChild("CutB");
                                        if l_CutB_1 then
                                            local v50 = l_CutB_1:Clone();
                                            v50.Parent = v48;
                                            v50.Enabled = true;
                                            local l_v50_0 = v50 --[[ copy: 5 -> 10 ]];
                                            local function v52() --[[ Line: 281 ]] --[[ Name: cleanupCutB ]]
                                                -- upvalues: l_v50_0 (copy)
                                                if l_v50_0 and l_v50_0.Parent then
                                                    l_v50_0.Enabled = false;
                                                    l_v50_0:Destroy();
                                                end;
                                            end;
                                            l_Humanoid_2.Died:Connect(v52);
                                            task.delay(1.5, v52);
                                        end;
                                        local l_CutA_1 = script:FindFirstChild("CutA");
                                        if l_CutA_1 then
                                            local v54 = l_CutA_1:Clone();
                                            v54.Parent = v48;
                                            v54.Enabled = true;
                                            local l_v54_0 = v54 --[[ copy: 6 -> 9 ]];
                                            local function v56() --[[ Line: 299 ]] --[[ Name: cleanupCutA ]]
                                                -- upvalues: l_v54_0 (copy)
                                                if l_v54_0 and l_v54_0.Parent then
                                                    l_v54_0.Enabled = false;
                                                    l_v54_0:Destroy();
                                                end;
                                            end;
                                            l_Humanoid_2.Died:Connect(v56);
                                            task.delay(1.5, v56);
                                        end;
                                        local l_Stars_2 = script:FindFirstChild("Stars");
                                        if l_Stars_2 then
                                            local v58 = l_Stars_2:Clone();
                                            v58.Parent = v48;
                                            v58.Enabled = true;
                                            local function v59() --[[ Line: 315 ]] --[[ Name: cleanupStars ]]
                                                -- upvalues: v58 (copy)
                                                if v58 and v58.Parent then
                                                    v58.Enabled = false;
                                                    v58:Destroy();
                                                end;
                                            end;
                                            l_Humanoid_2.Died:Connect(v59);
                                            task.delay(0.7, v59);
                                        end;
                                    end;
                                end;
                                for v60 = 1, 20 do
                                    task.delay((v60 - 1) * 0.0595, function() --[[ Line: 329 ]]
                                        -- upvalues: l_Humanoid_2 (copy), v6 (ref), v44 (ref)
                                        if l_Humanoid_2 and l_Humanoid_2.Health > 0 then
                                            l_Humanoid_2:TakeDamage(5);
                                            v6:Play(v44.Config.Sounds.SlashSFX, {
                                                Parent = v44.Rig.PrimaryPart, 
                                                PlaybackSpeed = Random.new():NextNumber(0.9, 2), 
                                                Volume = 0.25
                                            });
                                        end;
                                    end);
                                end;
                            end
                        }
                    });
                end);
                task.delay(2, function() --[[ Line: 346 ]]
                    -- upvalues: v44 (copy)
                    v44.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v44.Animations.Dismantle:Play(0.175);
                end;
                return;
            end;
        end
    }, 
    MalShrine = {
        LayoutOrder = 5, 
        Icon = "rbxassetid://132724488499212", 
        KeybindType = "AltAbility4", 
        Cooldown = 200, 
        Callback = function(v62) --[[ Line: 361 ]] --[[ Name: Callback ]]
            -- upvalues: v6 (copy), v10 (copy), v8 (copy), v7 (copy)
            if game["Run Service"]:IsServer() then
                v62.AbilitiesDisabled = true;
                local l_MalShrine_0 = v62.Config.Sounds.MalShrine;
                if v62.Player and v62.Player.Name == "AndrewD0tWeb" then
                    l_MalShrine_0 = v62.Config.Sounds.MalShrineAndrew;
                end;
                v62.AbilitiesDisabled = true;
                v6:Play(l_MalShrine_0, {
                    Parent = game.workspace, 
                    PlaybackSpeed = 1, 
                    Volume = 0.5
				});
				
				local l_shrine_0 = script:FindFirstChild('shrine')
				if l_shrine_0 then
					l_shrine_0.Parent = workspace.Misc
                    local l_PrimaryPart_0 = v62.Rig.PrimaryPart;
					local v66 = l_PrimaryPart_0.CFrame.LookVector * -30;
					warn(v66)
                    l_shrine_0.CFrame = CFrame.new(l_PrimaryPart_0.Position + v66);
                    local l_TweenService_0 = game:GetService("TweenService");
                    local v68 = l_shrine_0.CFrame + Vector3.new(0, 5, 0, 0);
                    l_TweenService_0:Create(l_shrine_0, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        CFrame = v68
                    }):Play();
                else
                    warn("no shrine part i think");
				end;
				
                task.delay(20, function() --[[ Line: 391 ]]
                    -- upvalues: l_shrine_0 (copy)
                    if l_shrine_0 and l_shrine_0.Parent then
                        l_shrine_0:Destroy();
                    end;
				end);
				
				v10:SetCustomLighting(v62.Config.IntroLighting);
				
                task.delay(20, function() --[[ Line: 405 ]]
                    v10:SetAsCurrentLighting();
				end);
				
                task.delay(3.3, function() --[[ Line: 410 ]]
                    -- upvalues: v8 (ref), v62 (copy), v6 (ref)
                    local _ = v8:CreateHitbox(v62.Player, {
                        Size = Vector3.new(1000, 400, 1200, 0), 
                        CFrameOffset = CFrame.new(0, 0, 0), 
                        Damage = 0, 
                        Time = 16.72, 
                        Knockback = 0, 
                        HitMultiple = true, 
                        ExecuteOnKill = false, 
                        Connections = {
                            Hit = function(v69, _) --[[ Line: 421 ]] --[[ Name: Hit ]]
                                -- upvalues: v6 (ref), v62 (ref)
                                local l_Humanoid_3 = v69:FindFirstChildOfClass("Humanoid");
                                if l_Humanoid_3 then
                                    local v72 = v69:FindFirstChild("Torso") or v69:FindFirstChild("UpperTorso") or v69:FindFirstChild("LowerTorso");
                                    if v72 then
                                        local l_CutB_2 = script:FindFirstChild("CutB");
                                        if l_CutB_2 then
                                            local v74 = l_CutB_2:Clone();
                                            v74.Parent = v72;
                                            v74.Enabled = true;
                                            local l_v74_0 = v74 --[[ copy: 5 -> 8 ]];
                                            local function v76() --[[ Line: 435 ]] --[[ Name: cleanupCutB ]]
                                                -- upvalues: l_v74_0 (copy)
                                                if l_v74_0 and l_v74_0.Parent then
                                                    l_v74_0.Enabled = false;
                                                    l_v74_0:Destroy();
                                                end;
                                            end;
                                            l_Humanoid_3.Died:Connect(v76);
                                            task.delay(19, v76);
                                        end;
                                        local l_CutA_2 = script:FindFirstChild("CutA");
                                        if l_CutA_2 then
                                            local v78 = l_CutA_2:Clone();
                                            v78.Parent = v72;
                                            v78.Enabled = true;
                                            local function v79() --[[ Line: 453 ]] --[[ Name: cleanupCutA ]]
                                                -- upvalues: v78 (copy)
                                                if v78 and v78.Parent then
                                                    v78.Enabled = false;
                                                    v78:Destroy();
                                                end;
                                            end;
                                            l_Humanoid_3.Died:Connect(v79);
                                            task.delay(19, v79);
                                        end;
                                    end;
                                end;
                                for v80 = 1, 100 do
                                    task.delay((v80 - 1) * 0.1672, function() --[[ Line: 467 ]]
                                        -- upvalues: l_Humanoid_3 (copy), v6 (ref), v62 (ref)
                                        if l_Humanoid_3 and l_Humanoid_3.Health > 0 then
                                            l_Humanoid_3:TakeDamage(0.75);
                                            v6:Play(v62.Config.Sounds.SlashSFX, {
                                                Parent = v62.Rig.PrimaryPart, 
                                                PlaybackSpeed = Random.new():NextNumber(0.9, 2), 
                                                Volume = 0.25
                                            });
                                        end;
                                    end);
                                end;
                            end
                        }
                    });
                end);
                task.delay(20, function() --[[ Line: 480 ]]
                    -- upvalues: v62 (copy)
                    v62.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v62.Animations.MalShrine:Play(0.175);
                    v7:CreateSpeedMultiplier(v62.Player, 0.01, "MalShrine", 20, true);
                end;
                return;
            end;
        end
    }
};
return v5;