-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
v0.Abilities = {
    Godspeed = {
        LayoutOrder = 2, 
        Icon = "rbxassetid://122958613367274", 
        KeybindType = "AltAbility1", 
        Cooldown = 40, 
        Callback = function(v5) --[[ Line: 15 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v3 (copy), v4 (copy), v1 (copy)
            local l_GodspeedTimeout_0 = v5.Config.GodspeedTimeout;
            if game["Run Service"]:IsServer() then
                task.delay(0.125, function() --[[ Line: 19 ]]
                    -- upvalues: v5 (copy), v2 (ref), v3 (ref), l_GodspeedTimeout_0 (copy), v4 (ref), v1 (ref)
                    v5.AbilitiesDisabled = true;
                    v2:SetSpeedCap(v5.Player, "ExeGodspeed", v5.Config.GodspeedSpeedMultiplier);
                    local v7 = nil;
                    local v8 = nil;
                    local l_v3_Hitbox_0 = v3:CreateHitbox(v5.Player, {
                        Size = Vector3.new(5, 5, 5, 0), 
                        Damage = v5.Config.WalkspeedOverrideDamage, 
                        Time = l_GodspeedTimeout_0, 
                        Knockback = 4.5, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v9) --[[ Line: 37 ]] --[[ Name: Hit ]]
                                -- upvalues: v7 (ref), v4 (ref)
                                v7 = v9;
                                v4:ApplyStatus(v9, "Slowness", {
                                    Level = 2, 
                                    Duration = 2, 
                                    Instant = true
                                });
                            end, 
                            Ended = function() --[[ Line: 41 ]] --[[ Name: Ended ]]
                                -- upvalues: v8 (ref)
                                v8 = true;
                            end
                        }
                    });
                    local v11 = v1:Play(v5.Config.Sounds.GodspeedLoop, {
                        Parent = v5.Rig.PrimaryPart
                    });
                    repeat
                        task.wait();
                    until v7 or v8 or l_v3_Hitbox_0.TimePast > 0.35 and v5.Rig.PrimaryPart.Velocity.Magnitude <= 6;
                    local v12 = "IDK";
                    if v7 then
                        v12 = "Hit";
                        v1:Play(v5.Config.Sounds.Hit, {
                            Parent = v5.Rig.PrimaryPart
                        });
                    elseif v5.Rig.PrimaryPart.Velocity.Magnitude <= 6 then
                        v12 = "Collide";
                    elseif v8 then
                        v12 = "Timeout";
                    end;
                    v11:Destroy();
                    l_v3_Hitbox_0:Cancel();
                    v2:SetSpeedCap(v5.Player, "ExeGodspeed", nil);
                    local l_StringValue_0 = Instance.new("StringValue");
                    l_StringValue_0.Name = "Result";
                    l_StringValue_0.Value = v12;
                    l_StringValue_0.Parent = v5.Rig;
                    game.Debris:AddItem(l_StringValue_0, 1.5);
                    task.delay(1.5, function() --[[ Line: 77 ]]
                        -- upvalues: v5 (ref)
                        v5.AbilitiesDisabled = false;
                    end);
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v5.Animations.Fly:Play(0.3);
                    v5.Rig:SetAttribute("FootstepsMuted", true);
                    local v14 = require(game.ReplicatedStorage.Modules.Network);
                    v14:FireConnection("DisableSprinting", "Godspeed", true);
                    local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v5.Player, 1, "FasterMovement");
                    local l_v2_FOVMultiplier_0 = v2:CreateFOVMultiplier(v5.Player, 1, "FOVIncrease");
                    game.TweenService:Create(l_v2_SpeedMultiplier_0, TweenInfo.new(0.35), {
                        Value = v5.Config.GodspeedSpeedMultiplier
                    }):Play();
                    game.TweenService:Create(l_v2_FOVMultiplier_0, TweenInfo.new(0.35), {
                        Value = 1.35
                    }):Play();
                    local l_PrimaryPart_0 = v5.Rig.PrimaryPart;
                    local l_Humanoid_0 = v5.Rig:FindFirstChild("Humanoid");
                    game["Run Service"]:BindToRenderStep("moveForwards", Enum.RenderPriority.Character.Value + 1, function() --[[ Line: 100 ]]
                        -- upvalues: l_PrimaryPart_0 (copy), l_Humanoid_0 (copy)
                        if not l_PrimaryPart_0 or not l_PrimaryPart_0.Parent or not l_Humanoid_0 or not l_Humanoid_0.Parent then
                            game["Run Service"]:UnbindFromRenderStep("moveForwards");
                            return;
                        else
                            l_Humanoid_0:Move(l_PrimaryPart_0.CFrame.LookVector);
                            return;
                        end;
                    end);
                    local v19 = v5.Rig:WaitForChild("Result", l_GodspeedTimeout_0);
                    local v20 = v19 and v19.Value or "IDK BRUH";
                    game.TweenService:Create(l_v2_SpeedMultiplier_0, TweenInfo.new(0.5), {
                        Value = 1
                    }):Play();
                    game.Debris:AddItem(l_v2_SpeedMultiplier_0, 0.5);
                    game.TweenService:Create(l_v2_FOVMultiplier_0, TweenInfo.new(0.5), {
                        Value = 1
                    }):Play();
                    game.Debris:AddItem(l_v2_FOVMultiplier_0, 0.5);
                    v5.Animations.Fly:Stop(0.1);
                    v5.Rig:SetAttribute("FootstepsMuted", false);
                    game["Run Service"]:UnbindFromRenderStep("moveForwards");
                    if v20 ~= "Hit" then

                    end;
                    if v19 then
                        repeat
                            task.wait();
                        until not v19.Parent;
                    end;
                    v14:FireConnection("DisableSprinting", "Godspeed", false);
                end;
                return;
            end;
        end
    }, 
    FoundYou = {
        LayoutOrder = 3, 
        Icon = "rbxassetid://103346224281360", 
        KeybindType = "AltAbility2", 
        Cooldown = 45, 
        Callback = function(v21) --[[ Line: 143 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy)
            if game["Run Service"]:IsServer() then
                v21.AbilitiesDisabled = true;
                local l_SpeedMultiplier_0 = require(game.ReplicatedStorage.Modules.Util):CreateSpeedMultiplier(v21.Player, 0.01, "HinderedMovement");
                game.Debris:AddItem(l_SpeedMultiplier_0, 3);
                local v23 = {};
                for _, v25 in pairs(workspace.Players.Survivors:GetChildren()) do
                    local l_Humanoid_1 = v25:FindFirstChild("Humanoid");
                    if l_Humanoid_1 and l_Humanoid_1.Health > 0 then
                        table.insert(v23, v25);
                    end;
                end;
                local v27 = v23[math.random(1, (math.clamp(#v23, 1, 1e999)))];
                local v28 = v27 and v27.PrimaryPart;
                local l_PlayerFromCharacter_0 = game.Players:GetPlayerFromCharacter(v27);
                if l_PlayerFromCharacter_0 then
                    require(game.ReplicatedStorage.Modules.Network):FireClientConnection(l_PlayerFromCharacter_0, "ExeJumpscare", "UREMOTE_EVENT");
                end;
                if v28 then
                    v21.Rig:SetPrimaryPartCFrame(v28.CFrame);
                end;
                v1:Play(v21.Config.Sounds.FoundYou, {
                    Parent = v21.Rig.PrimaryPart
                });
                task.delay(1.5, function() --[[ Line: 183 ]]
                    -- upvalues: l_SpeedMultiplier_0 (copy)
                    game.TweenService:Create(l_SpeedMultiplier_0, TweenInfo.new(1.75), {
                        Value = 1
                    }):Play();
                end);
                task.delay(3, function() --[[ Line: 188 ]]
                    -- upvalues: v21 (copy)
                    v21.AbilitiesDisabled = nil;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v21.Animations.FoundYou:Play(0);
                    local l_static_0 = game.Players.LocalPlayer.PlayerGui.TemporaryUI:FindFirstChild("static");
                    if l_static_0 then
                        l_static_0.ImageTransparency = 0;
                        game.TweenService:Create(l_static_0, TweenInfo.new(0.5), {
                            ImageTransparency = 1
                        }):Play();
                    end;
                end;
                return;
            end;
        end
    }, 
    Attack = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://120560249303986", 
        KeybindType = "MainAbility", 
        Cooldown = 1.3, 
        Callback = function(v31) --[[ Line: 213 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v31.AbilitiesDisabled = true;
                v1:Play(v31.Config.Sounds.Swing, {
                    Parent = v31.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.25
                });
                task.delay(0.1, function() --[[ Line: 220 ]]
                    -- upvalues: v3 (ref), v31 (copy), v2 (ref), v1 (ref)
                    local _ = v3:CreateHitbox(v31.Player, {
                        Size = Vector3.new(4.5, 6, 7.5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1), 
                        Damage = v31.Config.AttackDamage, 
                        Time = 0.3, 
                        Knockback = 2, 
                        HitMultiple = false, 
                        ExecuteOnKill = true, 
                        Connections = {
                            Hit = function(v32) --[[ Line: 232 ]] --[[ Name: Hit ]]
                                -- upvalues: v2 (ref), v1 (ref), v31 (ref)
                                v2:CreateSpeedMultiplier(v32, 1.5, "HitSpeedBonus", 1.25);
                                v1:Play(v31.Config.Sounds.Hit, {
                                    Parent = v31.Rig.PrimaryPart, 
                                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                    Volume = 0.25
                                });
                                local l_HandBlood_0 = v31.Rig:FindFirstChild("HandBlood");
                                if l_HandBlood_0 then
                                    if l_HandBlood_0.LeftBlood.Transparency == 1 then
                                        l_HandBlood_0.LeftBlood.Transparency = 0;
                                        return;
                                    elseif l_HandBlood_0.RightBlood.Transparency == 1 then
                                        l_HandBlood_0.RightBlood.Transparency = 0;
                                    end;
                                end;
                            end
                        }
                    });
                end);
                task.delay(0.75, function() --[[ Line: 249 ]]
                    -- upvalues: v31 (copy)
                    v31.AbilitiesDisabled = nil;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v31.Animations.Attack:Play(0.2);
                end;
                return;
            end;
        end
    }
};
v0.Created = function(_, v36) --[[ Line: 263 ]] --[[ Name: Created ]]
    local v37 = require(game.ReplicatedStorage.Initializer);
    for _, v39 in pairs(script.Systems:GetChildren()) do
        if v39:IsA("ModuleScript") then
            local v40 = require(v39);
            if v40.Type == "Server" and game["Run Service"]:IsServer() or v40.Type == "Client" and game["Run Service"]:IsClient() then
                v40.__index = v40;
                v37.RoundSystems[v39.Name] = setmetatable({}, v40);
                if v37.RoundSystems[v39.Name].Start then
                    v37.RoundSystems[v39.Name]:Start(v36);
                end;
            end;
        end;
    end;
end;
v0.OnIntroduction = function(_, _, v43, v44) --[[ Line: 286 ]] --[[ Name: OnIntroduction ]]
    local v45 = script.Instances.Background:Clone();
    v45:SetPrimaryPartCFrame(CFrame.new(0, 10000, 0));
    v45.Parent = workspace;
    game.Debris:AddItem(v45, v44);
    local l_HandBlood_1 = v43:WaitForChild("HandBlood");
    l_HandBlood_1:WaitForChild("RightBlood").Transparency = 0;
    l_HandBlood_1:WaitForChild("LeftBlood").Transparency = 0;
    local l_v2_FOVMultiplier_1 = v2:CreateFOVMultiplier(game.Players.LocalPlayer, 1, "IntroCutscene");
    game.TweenService:Create(l_v2_FOVMultiplier_1, TweenInfo.new(1), {
        Value = 0.4
    }):Play();
    game.Debris:AddItem(l_v2_FOVMultiplier_1, v44 - 0.5);
    task.delay(2.8, function()
        local v48 = script.Instances.Intro2011X:Clone();
        v48.Parent = game.Players.LocalPlayer.PlayerGui;
        game.Debris:AddItem(v48.Title, 3);
        game.Debris:AddItem(v48, 6);
        local v49 = require(game.ReplicatedStorage.Modules.Sounds);
        local _ = v49:Play(script.SFX.appear);
        task.wait(2.75);
        local _ = v49:Play(script.SFX.laugh);
    end);
end;
v0.OnExecution = function(_, v53, v54) --[[ Line: 319 ]] --[[ Name: OnExecution ]]
    task.delay(2.3, function() --[[ Line: 320 ]]
        -- upvalues: v53 (copy)
        local l_Position_0 = (v53.Rig.HumanoidRootPart.CFrame * CFrame.new(-0.575, 0, -5.2)).Position;
        local v56 = l_Position_0 - Vector3.new(math.random(-100, 100) / 80, 10, math.random(-100, 100) / 80);
        local v57 = script.Instances.Spike:Clone();
        v57.Parent = workspace.Map.Ingame;
        v57.CFrame = CFrame.new(v56, l_Position_0) * CFrame.Angles(-1.5707963267948966, 0, 0);
        game.TweenService:Create(v57, TweenInfo.new(0.3), {
            CFrame = v57.CFrame * CFrame.new(0, (v56 - l_Position_0).Magnitude - 4, 0)
        }):Play();
    end);
    task.delay(4, function() --[[ Line: 333 ]]
        -- upvalues: v54 (copy)
        local v58 = {
            "NeckAttachment", 
            "FaceFrontAttachment", 
            "FaceCenterAttachment", 
            "FaceFrontAttachment", 
            "HairAttachment", 
            "HatAttachment"
        };
        local l_Model_0 = Instance.new("Model");
        l_Model_0.Name = ("%*Head"):format((tostring(v54)));
        l_Model_0.Parent = workspace.Map.Ingame;
        local l_Head_0 = v54:FindFirstChild("Head");
        if l_Head_0 then
            local v61 = l_Head_0:Clone();
            v61.Anchored = true;
            v61.Parent = l_Model_0;
            l_Head_0.Transparency = 1;
            l_Head_0.CanCollide = false;
        end;
        for _, v63 in v54:GetChildren() do
            if v63:IsA("Accessory") then
                local l_Handle_0 = v63:FindFirstChild("Handle");
                if l_Handle_0 then
                    local v65 = false;
                    for _, v67 in v58 do
                        if l_Handle_0:FindFirstChild(v67) then
                            v65 = true;
                            break;
                        end;
                    end;
                    if v65 then
                        local v68 = v63:Clone();
                        v68.Handle.Anchored = true;
                        v68.Parent = l_Model_0;
                        v63:Destroy();
                    end;
                end;
            end;
        end;
    end);
end;
v0.OnChase = function(_, v70, v71) --[[ Line: 386 ]] --[[ Name: OnChase ]]
    if v70 == "Started" then
        local l_LocalPlayer_0 = game.Players.LocalPlayer;
        local l_Character_0 = l_LocalPlayer_0.Character;
        local v74 = l_Character_0 and l_Character_0:FindFirstChild("Humanoid");
        local v75 = l_Character_0 and l_Character_0:FindFirstChild("HumanoidRootPart");
        local _ = l_LocalPlayer_0.PlayerGui.TemporaryUI:FindFirstChild("static");
        local _ = v71.Rig:FindFirstChild("HumanoidRootPart");
        if v74 and v75 then
            v71.Cache.Chasing = true;
            task.spawn(function() --[[ Line: 399 ]]
                -- upvalues: v74 (copy), v71 (copy), l_LocalPlayer_0 (copy), v75 (copy), l_Character_0 (copy)
                while v74.Parent and v74.Health > 0 and v71.Cache.Chasing do
                    local l_ViewportFrame_0 = Instance.new("ViewportFrame");
                    l_ViewportFrame_0.BackgroundTransparency = 1;
                    l_ViewportFrame_0.BackgroundColor3 = Color3.new();
                    l_ViewportFrame_0.ImageTransparency = 1;
                    l_ViewportFrame_0.Size = UDim2.fromScale(1, 1);
                    l_ViewportFrame_0.CurrentCamera = workspace.CurrentCamera;
                    l_ViewportFrame_0.Parent = l_LocalPlayer_0.PlayerGui.TemporaryUI;
                    game.Debris:AddItem(l_ViewportFrame_0, 16);
                    local l_WorldModel_0 = Instance.new("WorldModel");
                    l_WorldModel_0.Parent = l_ViewportFrame_0;
                    local v80 = math.random(25, 75);
                    v80 = math.random(1, 2) == 1 and v80 or -v80;
                    local v81 = math.random(25, 75);
                    v81 = math.random(1, 2) == 1 and v81 or -v81;
                    local v82 = v71.Rig:Clone();
                    v82.PrimaryPart.Anchored = true;
                    v82:SetPrimaryPartCFrame(CFrame.lookAt((v75.CFrame + Vector3.new(v80, 0.425, v81)).Position, v75.Position + Vector3.new(0, 0.42500001192092896, 0, 0)));
                    v82.Parent = l_WorldModel_0;
                    local v83 = require(game.ReplicatedStorage.Modules.Util);
                    local l_Hallucinations_0 = v71.Config.Animations.Hallucinations;
                    local v85 = v83:LoadAnimationFromID(v82, l_Hallucinations_0[math.random(1, #l_Hallucinations_0)]);
                    v85.Priority = Enum.AnimationPriority.Action4;
                    v85.Looped = true;
                    v85:Play(0);
                    local l_Part_0 = Instance.new("Part");
                    l_Part_0.Transparency = 1;
                    l_Part_0.Anchored = true;
                    l_Part_0.CanCollide = false;
                    l_Part_0.Size = Vector3.new(16, 16, 16, 0);
                    l_Part_0.CFrame = v82.PrimaryPart.CFrame;
                    l_Part_0.Parent = workspace.Map.Ingame;
                    if not require(game.ReplicatedStorage.Initializer).PlayerSettings.EpilepsyMode.Value then
                        game.TweenService:Create(l_ViewportFrame_0, TweenInfo.new(0.2), {
                            ImageTransparency = 0.1
                        }):Play();
                        game.TweenService:Create(l_ViewportFrame_0, TweenInfo.new(math.random(25, 50) / 150, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {
                            ImageColor3 = Color3.new(0.5, 0.5, 0.5)
                        }):Play();
                        task.wait(0.2);
                        game.TweenService:Create(l_ViewportFrame_0, TweenInfo.new(math.random(25, 50) / 150, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {
                            ImageTransparency = 0.5
                        }):Play();
                    end;
                    local v87 = false;
                    do
                        local l_v87_0 = v87;
                        l_Part_0.Touched:Connect(function(v89) --[[ Line: 452 ]]
                            -- upvalues: l_Character_0 (ref), l_v87_0 (ref), l_ViewportFrame_0 (copy)
                            if v89.Parent == l_Character_0 and not l_v87_0 then
                                require(game.ReplicatedStorage.Modules.Network):FireServerConnection("RevealPlayerLocation", "UREMOTE_EVENT");
                                game.TweenService:Create(l_ViewportFrame_0, TweenInfo.new(0.25), {
                                    ImageTransparency = 1
                                }):Play();
                                l_v87_0 = true;
                            end;
                        end);
                        task.wait(math.random(20, 65) / 10);
                    end;
                end;
            end);
            return;
        end;
    elseif v70 == "Ended" then
        v71.Cache.Chasing = false;
        local l_static_2 = game.Players.LocalPlayer.PlayerGui.TemporaryUI:FindFirstChild("static");
        if l_static_2 then
            l_static_2.ImageTransparency = 0;
            game.TweenService:Create(l_static_2, TweenInfo.new(0.5), {
                ImageTransparency = 1
            }):Play();
        end;
    end;
end;
return v0;