-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_TweenService_0 = game:GetService("TweenService");
local l_Players_0 = game:GetService("Players");
local v3 = require(game.ReplicatedStorage.Modules.Sounds);
local v4 = require(game.ReplicatedStorage.Modules.Util);
local v5 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v6 = require(game.ReplicatedStorage.Modules.Statuses);
local v7 = require(game.ReplicatedStorage.Modules.Network);
local v8 = require(game.ReplicatedStorage.Modules.AchievementUtil);
local function v14(v9, v10, v11, ...) --[[ Line: 14 ]] --[[ Name: pcallMethod ]]
    local l_status_0, l_result_0 = pcall(function(...) --[[ Line: 15 ]]
        -- upvalues: v11 (copy), v9 (copy)
        if v11.Behavior[v9] then
            return v11.Behavior[v9](v11, ...);
        else
            return;
        end;
    end, ...);
    if not l_status_0 then
        warn((("[%*]: Failed to call .%*() due to: %*"):format(v10, v9, l_result_0)));
    end;
    return l_result_0;
end;
v0.Abilities = {
    Slash = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://92362553672440", 
        KeybindType = "MainAbility", 
        Callback = function(v15) --[[ Line: 33 ]] --[[ Name: Callback ]]
            -- upvalues: v3 (copy), v5 (copy), v4 (copy)
            if game["Run Service"]:IsServer() then
                v15.AbilitiesDisabled = true;
                v3:Play(v15.Config.Sounds.Swing, {
                    Parent = v15.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.35
                });
                task.delay(v15.Config.SlashWindup, function() --[[ Line: 40 ]]
                    -- upvalues: v5 (ref), v15 (copy), v4 (ref), v3 (ref)
                    local _ = v5:CreateHitbox(v15.Player, {
                        Size = Vector3.new(4.5, 6, 7.5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1.25), 
                        Damage = v15.Config.SlashDamage, 
                        Time = v15.Config.SlashLinger, 
                        Knockback = 2, 
                        HitMultiple = false, 
                        ExecuteOnKill = true, 
                        Connections = {
                            Hit = function(v16, v17) --[[ Line: 52 ]] --[[ Name: Hit ]]
                                -- upvalues: v4 (ref), v3 (ref), v15 (ref)
                                v4:CreateSpeedMultiplier(v16, 1.5, "HitSpeedBonus", 1.25);
                                if v17 then
                                    v3:Play(v15.Config.Sounds.Hit, {
                                        Parent = v15.Rig.PrimaryPart, 
                                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                        Volume = 0.5
                                    });
                                end;
                            end
                        }
                    });
                end);
                task.delay(0.75, function() --[[ Line: 63 ]]
                    -- upvalues: v15 (copy)
                    v15.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    if v15.Animations.Slash1 then
                        v15.Animations[("Slash%*"):format((tostring(math.random(1, 2))))]:Play(0.025);
                        return;
                    else
                        v15.Animations.Slash:Play(0.025);
                    end;
                end;
                return;
            end;
        end
    }, 
    CorruptEnergy = {
        LayoutOrder = 2, 
        Icon = "rbxassetid://83849304758564", 
        KeybindType = "AltAbility1", 
        Callback = function(v19) --[[ Line: 82 ]] --[[ Name: Callback ]]
            -- upvalues: v3 (copy), v14 (copy), v5 (copy), v8 (copy), v4 (copy), v6 (copy)
            if game["Run Service"]:IsServer() then
                v19.AbilitiesDisabled = true;
                v3:Play(v19.Config.Sounds.CorruptEnergy, {
                    Parent = v19.Rig.PrimaryPart, 
                    Volume = 0.4, 
                    TimePosition = 0.09, 
                    PlaybackSpeed = 1.2
                });
                v14("CEStart", ("%*/CES"):format(script.Parent), v19);
                v19.Config.StunDuration = v19.Config.UnstoppableDuration;
                local v20 = RaycastParams.new();
                v20.FilterDescendantsInstances = {
                    workspace.Players
                };
                v20.FilterType = Enum.RaycastFilterType.Exclude;
                local v21 = false;
                local v22 = nil;
                v22 = v19.Rig:GetAttributeChangedSignal("Stunned"):Once(function() --[[ Line: 100 ]]
                    -- upvalues: v21 (ref)
                    v21 = true;
                end);
                local v23 = {};
                task.delay(2, function() --[[ Line: 106 ]]
                    -- upvalues: v19 (copy), v21 (ref), v20 (copy), v3 (ref), v5 (ref), v8 (ref), v4 (ref), v6 (ref), v23 (copy)
                    for v24 = 1, v19.Config.SpikeAmount do
                        task.delay(v24 * v19.Config.DelayBetweenSpikeSummons, function() --[[ Line: 109 ]]
                            -- upvalues: v21 (ref), v19 (ref), v24 (copy), v20 (ref), v3 (ref), v5 (ref), v8 (ref), v4 (ref), v6 (ref), v23 (ref)
                            if v21 then
                                return;
                            elseif not v19.Rig.PrimaryPart then
                                return;
                            elseif v19.Rig:GetAttribute("Stunned") then
                                v21 = true;
                                return;
                            else
                                local l_Position_0 = (v19:GetPivot() * CFrame.new(0, 0, -v19.Config.DistanceBetweenSpikes * v24)).Position;
                                local v26 = workspace:Raycast(l_Position_0, Vector3.new(0, -100, 0, 0), v20) or workspace:Raycast(l_Position_0, Vector3.new(0, 100, 0, 0), v20);
                                if v26 and v26.Position then
                                    local v27 = v19.Config.Spike:Clone();
                                    local _ = v27:GetPivot();
                                    local v29 = v19.Config.SpikeHitboxSize * 0.8;
                                    local l_Part_0 = Instance.new("Part");
                                    l_Part_0.Size = v29;
                                    l_Part_0.CFrame = v27.PrimaryPart.CFrame + vector.create(0, v29.Y / 2, 0);
                                    l_Part_0.CanTouch = false;
                                    l_Part_0.Transparency = 1;
                                    l_Part_0.Name = "BOX_COLLISION";
                                    l_Part_0.Parent = v27;
                                    local l_WeldConstraint_0 = Instance.new("WeldConstraint");
                                    l_WeldConstraint_0.Part0 = v27.PrimaryPart;
                                    l_WeldConstraint_0.Part1 = l_Part_0;
                                    l_WeldConstraint_0.Parent = v27.PrimaryPart;
                                    v27.Parent = workspace.Map.Ingame;
                                    v27:SetPrimaryPartCFrame(CFrame.new(v26.Position) * CFrame.Angles(3.141592653589793, math.rad((math.random(0, 360))), 0) - Vector3.new(0, v29.Y, 0));
                                    local l_v27_Children_0 = v27:GetChildren();
                                    table.insert(l_v27_Children_0, v27);
                                    for _, v34 in ipairs(l_v27_Children_0) do
                                        if v34:IsA("BasePart") and v34.CanCollide and v34.Name ~= "BOX_COLLISION" then
                                            v34.CanQuery = false;
                                            v34.CanTouch = false;
                                            v34.CustomPhysicalProperties = v19.Config.SpikeProperties;
                                        end;
                                    end;
                                    game.TweenService:Create(v27.PrimaryPart, TweenInfo.new(0.1), {
                                        CFrame = v27.PrimaryPart.CFrame + Vector3.new(0, v29.Y, 0)
                                    }):Play();
                                    v3:Play(v19.Config.Sounds.CorruptEnergySummon, {
                                        Parent = v27.PrimaryPart, 
                                        PlaybackSpeed = Random.new():NextNumber(0.8, 1.2), 
                                        Volume = 0.25, 
                                        TimePosition = 0.02
                                    });
                                    task.delay(0.1, function() --[[ Line: 151 ]]
                                        -- upvalues: v19 (ref), v27 (copy)
                                        table.insert(v19.CurrentSpikes or {}, v27);
                                    end);
                                    for _, v36 in pairs(v27:GetDescendants()) do
                                        if v36:IsA("ParticleEmitter") and v36.Name == "Number" then
                                            v36.Color = ColorSequence.new({
                                                ColorSequenceKeypoint.new(0, v19.Config.SpikeNumbersColor), 
                                                ColorSequenceKeypoint.new(1, v19.Config.SpikeNumbersColor)
                                            });
                                        end;
                                    end;
                                    task.delay(v19.Config.SpikeLifetime, function() --[[ Line: 163 ]]
                                        -- upvalues: v27 (copy), v29 (copy), v3 (ref), v19 (ref)
                                        game.Debris:AddItem(v27, 2.5);
                                        if v27.PrimaryPart then
                                            game.TweenService:Create(v27.PrimaryPart, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                                CFrame = v27.PrimaryPart.CFrame - Vector3.new(0, v29.Y * 2, 0)
                                            }):Play();
                                            v3:Play(v19.Config.Sounds.CorruptEnergyDesummon, {
                                                Parent = v27.PrimaryPart, 
                                                PlaybackSpeed = Random.new():NextNumber(0.9, 1.1), 
                                                Volume = 0.1, 
                                                TimePosition = 0.02
                                            });
                                            task.delay(1, function() --[[ Line: 169 ]]
                                                -- upvalues: v19 (ref), v27 (ref)
                                                local v37 = table.find(v19.CurrentSpikes or {}, v27);
                                                if v37 then
                                                    table.remove(v19.CurrentSpikes or {}, v37);
                                                end;
                                            end);
                                        end;
                                    end);
                                    local _ = v5:CreateHitbox(v19.Player, {
                                        Size = v29, 
                                        CFrame = function() --[[ Line: 181 ]] --[[ Name: CFrame ]]
                                            -- upvalues: v27 (copy), v29 (copy)
                                            return v27.PrimaryPart.CFrame + Vector3.new(0, v29.Y / 2, 0);
                                        end, 
                                        Damage = v19.Config.CorruptEnergyDamage, 
                                        Time = 0.15, 
                                        Knockback = 5, 
                                        HitMultiple = true, 
                                        PredictVelocity = false, 
                                        Connections = {
                                            Hit = function(v38, v39) --[[ Line: 190 ]] --[[ Name: Hit ]]
                                                -- upvalues: v8 (ref), v19 (ref), v4 (ref), v6 (ref), v23 (ref), v3 (ref)
                                                if v38.Humanoid.Health <= 0 then
                                                    v8:IncrementAchievementProgress(v19.Player, "JohnDoeSpikes");
                                                    if tostring(v38.Parent) == "Survivors" then
                                                        require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v19.Player, {
                                                            Action = "Killed a Survivor with Corrupt Energy", 
                                                            RewardType = "DifficultKillerAction"
                                                        });
                                                    end;
                                                else
                                                    v4:CreateSpeedMultiplier(v38, 1.5, "HitSpeedBonus", 1.25);
                                                    v6:ApplyStatus(v19.Rig, "Speed", {
                                                        Duration = 7, 
                                                        Level = 1
                                                    });
                                                    v4:RevealPlayerAuraTo(v19.Player, v38, 2.5);
                                                    if not v23[v38] then
                                                        v23[v38] = 1;
                                                    else
                                                        local l_v23_0 = v23;
                                                        l_v23_0[v38] = l_v23_0[v38] + 1;
                                                        if v23[v38] >= v19.Config.SpikeHitCap then
                                                            v4:GiveInvincible(v38, "SpikeLimit", 1);
                                                        end;
                                                    end;
                                                    if tostring(v38.Parent) == "Survivors" then
                                                        require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v19.Player, {
                                                            Action = "Damaged a Survivor with Corrupt Energy", 
                                                            RewardType = "EasyKillerAction"
                                                        });
                                                    end;
                                                end;
                                                if v39 then
                                                    v3:Play(v19.Config.Sounds.Hit, {
                                                        Parent = v19.Rig.PrimaryPart, 
                                                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                                        Volume = 0.25
                                                    });
                                                end;
                                            end
                                        }
                                    });
                                end;
                                return;
                            end;
                        end);
                    end;
                    task.wait(v19.Config.SpikeAmount * v19.Config.DelayBetweenSpikeSummons);
                    v19.Config.StunDuration = nil;
                end);
                task.delay(3.5, function() --[[ Line: 248 ]]
                    -- upvalues: v22 (ref), v19 (copy)
                    pcall(function() --[[ Line: 249 ]]
                        -- upvalues: v22 (ref)
                        v22:Disconnect();
                    end);
                    v19.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v19.Animations.CorruptEnergy:Play(0.025);
                    local v42 = false;
                    local l_v4_SpeedMultiplier_0 = v4:CreateSpeedMultiplier(v19.Player, 0.001, "CorruptEnergy");
                    game.Debris:AddItem(l_v4_SpeedMultiplier_0, 3.5);
                    local v44 = nil;
                    do
                        local l_v42_0 = v42;
                        v44 = v19.Rig:GetAttributeChangedSignal("Stunned"):Once(function() --[[ Line: 263 ]]
                            -- upvalues: l_v4_SpeedMultiplier_0 (copy), v19 (copy), l_v42_0 (ref)
                            l_v4_SpeedMultiplier_0:Destroy();
                            v19.Animations.CorruptEnergy:Stop();
                            l_v42_0 = true;
                        end);
                        task.delay(3.6, v44.Disconnect, v44);
                        local v46 = {
                            1.067, 
                            1.917
                        };
                        local v47 = 0;
                        local v48 = 0;
                        task.spawn(function() --[[ Line: 276 ]]
                            -- upvalues: v19 (copy), v46 (copy), l_v42_0 (ref), v48 (ref), v47 (ref), v4 (ref)
                            while v19 and v19.Rig.Parent and v46[1] and not l_v42_0 do
                                v48 = v48 + game["Run Service"].Heartbeat:Wait();
                                for v49 = #v46, 1, -1 do
                                    if v46[v49] and v48 >= v46[v49] then
                                        table.remove(v46, v49);
                                        v47 = v47 + 1;
                                        v4:ApplyCameraShake(v47 * 0.2, v47 * 0.35);
                                    end;
                                end;
                            end;
                        end);
                    end;
                end;
                return;
            end;
        end
    }, 
    DigitalFootprint = {
        LayoutOrder = 3, 
        Icon = "rbxassetid://83206360003394", 
        KeybindType = "AltAbility2", 
        Callback = function(v50) --[[ Line: 300 ]] --[[ Name: Callback ]]
            -- upvalues: v3 (copy), v14 (copy), v4 (copy), v6 (copy), v7 (copy), l_Players_0 (copy)
            local v51 = {
                0.317, 
                1.05, 
                2.067
            };
            local v52 = 0;
            local v53 = 0;
            if game["Run Service"]:IsServer() then
                v50.AbilitiesDisabled = true;
                v3:Play(v50.Config.Sounds.DigitalFootprint, {
                    Parent = v50.Rig.PrimaryPart, 
                    Volume = 0.4, 
                    TimePosition = 0.09, 
                    PlaybackSpeed = 1.2
                });
                v14("DFStart", ("%*/DFS"):format(script.Parent), v50);
                local function v58(v54) --[[ Line: 312 ]] --[[ Name: removeShadow ]]
                    if v54 and v54.Parent then
                        v54.Name = "okByeBye";
                        game.Debris:AddItem(v54, 5);
                        local l_ShadowAmbience_0 = v54:FindFirstChild("ShadowAmbience");
                        if l_ShadowAmbience_0 then
                            game.TweenService:Create(l_ShadowAmbience_0, TweenInfo.new(2), {
                                Volume = 0
                            }):Play();
                        end;
                        for _, v57 in pairs(v54:GetDescendants()) do
                            if v57:IsA("ParticleEmitter") then
                                v57.Enabled = false;
                            end;
                        end;
                    end;
                end;
                local l_FirstChild_0 = workspace.Map.Ingame:FindFirstChild((("%*Shadows"):format((tostring(v50.Player)))));
                if not l_FirstChild_0 then
                    l_FirstChild_0 = Instance.new("Folder");
                    l_FirstChild_0.Name = ("%*Shadows"):format((tostring(v50.Player)));
                    l_FirstChild_0.Parent = workspace.Map.Ingame;
                end;
                local l_l_FirstChild_0_Children_0 = l_FirstChild_0:GetChildren();
                if #l_l_FirstChild_0_Children_0 == v50.Config.DigitalFootprintLimit then
                    v58(l_l_FirstChild_0_Children_0[1]);
                end;
                local v61 = v50.Config.Shadow:Clone();
                v61.Size = Vector3.new(1, 0, 0, 0);
                v61.Parent = l_FirstChild_0;
                v3:Play(v50.Config.Sounds.DigitalFootprintAmbience, {
                    Parent = v61, 
                    Name = "ShadowAmbience", 
                    RollOffMaxDistance = 30, 
                    Looped = true
                });
                local v62 = RaycastParams.new();
                v62.FilterDescendantsInstances = {
                    workspace.Players, 
                    v61
                };
                v62.FilterType = Enum.RaycastFilterType.Exclude;
                task.delay(v50.Config.DigitalFootprintLifetime, function() --[[ Line: 359 ]]
                    -- upvalues: v58 (copy), v61 (copy)
                    v58(v61);
                end);
                task.delay(tonumber(v51[#v51]) or 2.55, function() --[[ Line: 364 ]]
                    -- upvalues: v4 (ref), v61 (copy), v50 (copy), v58 (copy), v6 (ref), v7 (ref), l_Players_0 (ref)
                    v4:ApplyUnsafeTouched(v61, false, function(_, v64) --[[ Line: 365 ]]
                        -- upvalues: v4 (ref), v50 (ref), v61 (ref), v58 (ref), v6 (ref), v7 (ref), l_Players_0 (ref)
                        local l_Parent_0 = v64.Parent;
                        local v66 = l_Parent_0 and l_Parent_0:FindFirstChild("Humanoid");
                        if v66 and v4:GetEntityType(l_Parent_0) and l_Parent_0 ~= v50.Rig and v66.Health > 0 and v61.Name == "Shadow" and not l_Parent_0:GetAttribute("ExecutionsDisabled") then
                            v58(v61);
                            v4:RevealPlayerAuraTo(v50.Rig, l_Parent_0, 10);
                            v4:RevealPlayerAuraTo(l_Parent_0, v50.Rig, 10);
                            v6:ApplyStatus(v50.Rig, "Speed", {
                                Level = 1, 
                                Duration = 10
                            });
                            v6:ApplyStatus(l_Parent_0, "Slowness", {
                                Level = 2, 
                                Duration = 10
                            });
                            v6:ApplyStatus(l_Parent_0, "Corrupted", {
                                Level = 1, 
                                Duration = 10
                            });
                            require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v50.Player, {
                                Action = "Survivor stepped into a Digital Footprint trap", 
                                RewardType = "RegularKillerAction"
                            });
                            v7:FireClientConnection(l_Players_0:GetPlayerFromCharacter(l_Parent_0), ("%*JDPuddleEffect"):format(v50.Player.Name), "REMOTE_EVENT");
                        end;
                    end, 14);
                end);
                task.spawn(function() --[[ Line: 395 ]]
                    -- upvalues: v52 (ref), v61 (copy), v53 (ref), v51 (copy), v50 (copy), v62 (copy)
                    while v52 ~= 3 and v61.Parent and v61.Name == "Shadow" do
                        v53 = v53 + game["Run Service"].Heartbeat:Wait();
                        for v67 = #v51, 1, -1 do
                            if v51[v67] and v53 >= v51[v67] then
                                table.remove(v51, v67);
                                v52 = v52 + 1;
                                local l_Position_1 = (v50.Rig.PrimaryPart.CFrame * CFrame.new(-1.1, 0, -2)).Position;
                                local v69 = workspace:Raycast(l_Position_1, Vector3.new(0, -100, 0, 0), v62);
                                v61.Position = (v69 and v69.Position or v50.Rig.PrimaryPart.Position - Vector3.new(0, 2.5, 0, 0)) + Vector3.new(0, 0.5, 0, 0);
                                game.TweenService:Create(v61, TweenInfo.new(1), {
                                    Size = Vector3.new(1, v52 * 6, v52 * 6)
                                }):Play();
                                for _, v71 in pairs(v61:GetDescendants()) do
                                    if v71:IsA("ParticleEmitter") and v71.Name:find("ShadowPuddle") then
                                        v71.Enabled = v71.Name == ("ShadowPuddle%*"):format(v52);
                                    end;
                                end;
                            end;
                        end;
                    end;
                end);
                task.delay(3, function() --[[ Line: 422 ]]
                    -- upvalues: v50 (copy)
                    v50.AbilitiesDisabled = false;
                end);
            elseif game["Run Service"]:IsClient() then
                v50.Animations.DigitalFootprint:Play(0.025);
                local l_v4_SpeedMultiplier_1 = v4:CreateSpeedMultiplier(v50.Player, 0, "DigitalFootprint");
                game.Debris:AddItem(l_v4_SpeedMultiplier_1, 3);
                task.spawn(function() --[[ Line: 435 ]]
                    -- upvalues: v50 (copy), v51 (copy), v53 (ref), v52 (ref), v4 (ref)
                    while v50 and v50.Rig.Parent and v51[1] do
                        v53 = v53 + game["Run Service"].Heartbeat:Wait();
                        for v73 = #v51, 1, -1 do
                            if v51[v73] and v53 >= v51[v73] then
                                table.remove(v51, v73);
                                v52 = v52 + 1;
                                v4:ApplyCameraShake(v52 * 0.2, v52 * 0.375);
                            end;
                        end;
                    end;
                end);
            end;
        end
    }, 
    ["404Error"] = {
        Name = "404 Error", 
        LayoutOrder = 4, 
        Icon = "rbxassetid://131116145215571", 
        KeybindType = "AltAbility3", 
        Callback = function(v74) --[[ Line: 460 ]] --[[ Name: Callback ]]
            -- upvalues: v14 (copy), v3 (copy), v4 (copy), v7 (copy)
            if game["Run Service"]:IsServer() then
                v14("404Start", ("%*/404S"):format(script.Parent), v74);
                v74.Config.StunDuration = v74.Config.UnstoppableDuration;
                v74.AbilitiesDisabled = true;
                v3:Play(v74.Config.Sounds["404Error"], {
                    Parent = v74.Rig.PrimaryPart, 
                    Volume = 0.4, 
                    TimePosition = 0.09, 
                    RollOffMaxDistance = 200, 
                    PlaybackSpeed = 1.15
                });
                task.delay(1.625, function() --[[ Line: 471 ]]
                    -- upvalues: v74 (copy)
                    v74.Config.StunDuration = nil;
                    v74.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    local l_v4_SpeedMultiplier_2 = v4:CreateSpeedMultiplier(v74.Player, 1, "404Error");
                    local l_v4_FOVMultiplier_0 = v4:CreateFOVMultiplier(v74.Player, 1, "404Error");
                    game.TweenService:Create(l_v4_SpeedMultiplier_2, TweenInfo.new(0.5), {
                        Value = 0.25
                    }):Play();
                    game.TweenService:Create(l_v4_FOVMultiplier_0, TweenInfo.new(1.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true), {
                        Value = 0.75
                    }):Play();
                    v7:FireConnection("DisableSprinting", "404Error", true);
                    task.delay(1.2, function() --[[ Line: 488 ]]
                        -- upvalues: v3 (ref), v74 (copy), v7 (ref), l_v4_SpeedMultiplier_2 (copy), l_v4_FOVMultiplier_0 (copy), v4 (ref)
                        v3:Play(v74.Config.Sounds["404ErrorError"], {
                            Parent = v74.Rig.PrimaryPart, 
                            Volume = 0.4, 
                            TimePosition = 0.09, 
                            PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
                        });
                        v7:FireConnection("DisableSprinting", "404Error", false);
                        game.TweenService:Create(l_v4_SpeedMultiplier_2, TweenInfo.new(0.6), {
                            Value = 1
                        }):Play();
                        game.TweenService:Create(l_v4_FOVMultiplier_0, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                            Value = 1
                        }):Play();
                        game.Debris:AddItem(l_v4_SpeedMultiplier_2, 0.4);
                        game.Debris:AddItem(l_v4_FOVMultiplier_0, 1);
                        for _, v78 in pairs(workspace.Players.Survivors:GetChildren()) do
                            v4:RevealPlayerAura(v78, v74.Config["404ErrorAuraRevealTime"]);
                        end;
                    end);
                end;
                return;
            end;
        end
    }
};
v0.Created = function(_, v80) --[[ Line: 512 ]] --[[ Name: Created ]]
    -- upvalues: v8 (copy), v4 (copy), v6 (copy), l_Players_0 (copy), v7 (copy), v3 (copy)
    if game["Run Service"]:IsServer() then
        if workspace:GetAttribute("JohnDoeSpecialDay") then
            v8:IncrementAchievementProgress(v80.Player, "JohnDoeSpecialDay");
        end;
        local l_Folder_0 = Instance.new("Folder");
        l_Folder_0.Name = "JohnDoeTrail";
        l_Folder_0.Parent = v80.Rig;
        for _ = 1, math.clamp(math.round(v80.Config.TrailLength / 4), 2, 1e999) do
            local v83 = v80.Config.Trail:Clone();
            v83.Position = v80.Rig.PrimaryPart.Position - Vector3.new(0, 4.5, 0, 0);
            v83.Parent = l_Folder_0;
            v83:SetAttribute("FinishedUpdating", true);
            v4:ApplyOnTouched(v83, false, function(_, v85) --[[ Line: 534 ]]
                -- upvalues: v6 (ref)
                local l_Parent_1 = v85.Parent;
                local l_Humanoid_0 = l_Parent_1:FindFirstChild("Humanoid");
                if l_Humanoid_0 and l_Humanoid_0.Health > 0 and l_Parent_1:IsDescendantOf(workspace.Players) and tostring(l_Parent_1.Parent) ~= "Killers" then
                    v6:ApplyStatus(l_Parent_1, "Corrupted", {
                        Duration = 3, 
                        Level = 2
                    });
                end;
            end);
        end;
        v80.CurrentSpikes = {};
        local l_l_Folder_0_Children_0 = l_Folder_0:GetChildren();
        local v89 = 0;
        local v90 = 0;
        local v91 = 0;
        local v92 = nil;
        v92 = game["Run Service"].Heartbeat:Connect(function(v93) --[[ Line: 552 ]]
            -- upvalues: v80 (copy), l_Folder_0 (copy), v92 (ref), v91 (ref), l_Players_0 (ref), v6 (ref), v90 (ref), l_l_Folder_0_Children_0 (copy), v89 (ref)
            if not v80 or not v80.Rig.Parent or not v80.Rig.PrimaryPart then
                l_Folder_0:Destroy();
                v92:Disconnect();
                v92 = nil;
                return;
            else
                if v91 > 1 and #v80.CurrentSpikes > 0 then
                    v91 = 0;
                    local v94 = RaycastParams.new();
                    v94.FilterDescendantsInstances = v80.CurrentSpikes;
                    v94.FilterType = Enum.RaycastFilterType.Include;
                    for _, v96 in (l_Players_0:GetPlayers()) do
                        local l_Character_0 = v96.Character;
                        if l_Character_0 and l_Character_0.Parent then
                            local l_Humanoid_1 = l_Character_0:FindFirstChildOfClass("Humanoid");
                            if l_Humanoid_1 or l_Humanoid_1.Health <= 0 then
                                local l_PrimaryPart_0 = l_Character_0.PrimaryPart;
                                if workspace:Raycast(l_PrimaryPart_0.Position, Vector3.new(0, -5, 0, 0), v94) then
                                    v6:ApplyStatus(v96, "Corrupted", {
                                        Level = 2, 
                                        Duration = 5
                                    });
                                end;
                            end;
                        end;
                    end;
                end;
                v91 = v91 + v93;
                if v90 <= 0.05 then
                    v90 = v90 + v93;
                    return;
                else
                    v90 = 0;
                    local v100 = l_l_Folder_0_Children_0[v89 % #l_l_Folder_0_Children_0 + 1];
                    local v101 = l_l_Folder_0_Children_0[(v89 - 1) % #l_l_Folder_0_Children_0 + 1];
                    if v100 and v101 then
                        if v100.Size.Z <= 4 or v100:GetAttribute("FinishedUpdating") then
                            if v100:GetAttribute("FinishedUpdating") then
                                v100:SetAttribute("FinishedUpdating", nil);
                            end;
                            local v102 = v80:GetPivot().Position - Vector3.new(0, 3, 0, 0);
                            v100.CFrame = CFrame.new(v101:GetPivot().Position) * CFrame.lookAt(v101:GetPivot().Position, v102).Rotation * CFrame.Angles(0, 0, 0);
                            v100.Size = Vector3.new(v100.Size.X, v100.Size.Y, (v100.Position - v102).Magnitude);
                            v100.PivotOffset = CFrame.new(0, 0, -v100.Size.Z / 2);
                            v100.CFrame = v100.CFrame * v100.PivotOffset;
                            return;
                        else
                            v100:SetAttribute("FinishedUpdating", true);
                            v89 = v89 + 1;
                            return;
                        end;
                    else
                        v89 = v89 + 1;
                        return;
                    end;
                end;
            end;
        end);
        return;
    else
        if game["Run Service"]:IsClient() then
            v7:SetConnection(("%*JDPuddleEffect"):format(v80.Player.Name), "REMOTE_EVENT", function() --[[ Line: 617 ]]
                -- upvalues: v3 (ref), v80 (copy)
                v3:Play(v80.Config.Sounds.PuddleStepped);
            end);
        end;
        return;
    end;
end;
v0.Destroyed = function(_, v104) --[[ Line: 651 ]] --[[ Name: Destroyed ]]
    -- upvalues: v7 (copy)
    if game["Run Service"]:IsServer() then
        for _, v106 in v104.CurrentSpikes do
            v106:Destroy();
        end;
        return;
    else
        if game["Run Service"]:IsClient() then
            v7:RemoveConnection(("%*JDPuddleEffect"):format(v104.Player.Name), "REMOTE_EVENT");
            if v104.SilencedConnection then
                v104.SilencedConnection:Disconnect();
                local l_ipairs_0 = ipairs;
                local v108 = v104.Silencers or {};
                for _, v110 in l_ipairs_0(v108) do
                    v110:Destroy();
                end;
            end;
        end;
        return;
    end;
end;
v0.OnIntroduction = function(_, v112, v113, v114) --[[ Line: 670 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v4 (copy)
    local v115 = nil;
    if v112.Config.useClouds == true then
        v115 = Instance.new("Clouds");
        v115.Cover = 0.774;
        v115.Density = 1;
        v115.Color = Color3.fromRGB(25, 25, 25);
        v115.Parent = workspace:FindFirstChild("Terrain");
        game.Debris:AddItem(v115, v114);
    end;
    local v116 = script.IntroScreen:Clone();
    v116.Main.Title.Text = v112.Config.IntroText:gsub("PLAYERNAME", v112.Player.DisplayName);
    v116.Parent = game.Players.LocalPlayer.PlayerGui;
    game.Debris:AddItem(v116, 1.93333);
    game.TweenService:Create(v116.Main.Title, TweenInfo.new(0.83), {
        TextTransparency = 0
    }):Play();
    task.delay(0.83, function() --[[ Line: 695 ]]
        -- upvalues: v116 (copy), v112 (copy)
        game.TweenService:Create(v116.Main.Title, TweenInfo.new(0.583), {
            TextColor3 = v112.Config.IntroTextColor or Color3.new(1, 0, 0)
        }):Play();
    end);
    task.delay(1, function() --[[ Line: 700 ]]
        -- upvalues: v113 (copy)
        local l_JohnDoeTrail_0 = v113:FindFirstChild("JohnDoeTrail");
        if l_JohnDoeTrail_0 then
            l_JohnDoeTrail_0:Destroy();
        end;
    end);
    local v118 = require(game.ReplicatedStorage.Modules.Schematics.Lighting);
    v118:SetCustomLighting(v112.Config.IntroLighting);
    task.delay(2.717, function() --[[ Line: 710 ]]
        -- upvalues: v115 (ref), v112 (copy)
        if v115 then
            v115.Color = Color3.fromRGB(25, 0, 0);
        end;
        local l_AtmosphereDoe_0 = game.Lighting:FindFirstChild("AtmosphereDoe");
        if l_AtmosphereDoe_0 then
            game.TweenService:Create(l_AtmosphereDoe_0, TweenInfo.new(0.2829, Enum.EasingStyle.Linear), {
                Color = v112.Config.AtmosphereColor or Color3.fromRGB(144, 0, 0), 
                Decay = v112.Config.AtmosphereDecay or Color3.fromRGB(255, 0, 0), 
                Density = 1
            }):Play();
        end;
    end);
    local l_v4_FOVMultiplier_1 = v4:CreateFOVMultiplier(game.Players.LocalPlayer, 0.35, "JohnDoeIntroScene");
    task.delay(2.75, function() --[[ Line: 726 ]]
        -- upvalues: l_v4_FOVMultiplier_1 (copy)
        game.TweenService:Create(l_v4_FOVMultiplier_1, TweenInfo.new(0.25), {
            Value = 0.95
        }):Play();
    end);
    task.delay(v114, function() --[[ Line: 731 ]]
        -- upvalues: v118 (copy), l_v4_FOVMultiplier_1 (copy), v116 (copy), v115 (ref)
        v118:SetAsCurrentLighting();
        l_v4_FOVMultiplier_1:Destroy();
        v116:Destroy();
        if v115 then
            v115:Destroy();
        end;
    end);
end;
v0.OnVictory = function(_, v122, v123, _, _) --[[ Line: 741 ]] --[[ Name: OnVictory ]]
    -- upvalues: v4 (copy), l_TweenService_0 (copy)
    local v126 = require(game.ReplicatedStorage.Modules.Schematics.Lighting);
    if v122 == "Start" then
        v126:SetCustomLighting(v123.Config.IntroLighting);
        local l_v4_FOVMultiplier_2 = v4:CreateFOVMultiplier(game.Players.LocalPlayer, 1.1325, "JohnDoeOutroScene");
        game.Debris:AddItem(l_v4_FOVMultiplier_2, 30);
        task.spawn(function() --[[ Line: 752 ]]
            -- upvalues: v123 (copy), v4 (ref)
            local v128 = tick();
            local v129 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 5);
            if v129 and v129.PrimaryPart then
                local v130 = v123.Config.OutroDummy:Clone();
                v130.Name = "OutroVictim";
                v130.PrimaryPart.Anchored = true;
                v130:SetPrimaryPartCFrame(v129.PrimaryPart.CFrame);
                v130.Parent = v129;
                local v131 = v4:LoadAnimationFromID(v130, "rbxassetid://124322476386275", true);
                v131:Play(0);
                v131.TimePosition = tick() - v128;
                v131.Stopped:Once(function() --[[ Line: 767 ]]
                    -- upvalues: v130 (copy)
                    for _, v133 in ipairs(v130:GetDescendants()) do
                        if v133:IsA("BasePart") then
                            v133.Anchored = true;
                        end;
                    end;
                end);
                local v134 = false;
                for _, v136 in ipairs({
                    "Shirt", 
                    "Pants", 
                    "Accessory", 
                    "Hat"
                }) do
                    if v130:FindFirstChildOfClass(v136) then
                        v134 = true;
                        break;
                    end;
                end;
                if not v134 then
                    pcall(function() --[[ Line: 780 ]]
                        -- upvalues: v123 (ref), v130 (copy)
                        local l_HumanoidDescriptionFromUserId_0 = game.Players:GetHumanoidDescriptionFromUserId(v123.Player.UserId);
                        v130.Humanoid:ApplyDescription(l_HumanoidDescriptionFromUserId_0, Enum.AssetTypeVerification.Always);
                    end);
                end;
            end;
        end);
        task.delay(2.4, function() --[[ Line: 789 ]]
            -- upvalues: l_TweenService_0 (ref), v123 (copy)
            local v138 = Instance.new("ColorCorrectionEffect", game.Lighting);
            v138.Name = "JohnDoeStabCC";
            local v139 = l_TweenService_0:Create(v138, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                Contrast = 0.4, 
                Brightness = 0.1
            });
            v139:Play();
            task.wait(0.4);
            v139:Pause();
            v138.Brightness = 0.8;
            v138.Contrast = 0.3;
            v138.TintColor = v123.Config.OutroTintColor or Color3.new(0.631373, 0.0784314, 0.0901961);
            l_TweenService_0:Create(v138, TweenInfo.new(2.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                TintColor = Color3.new(0.196078, 0.196078, 0.196078), 
                Brightness = -1, 
                Contrast = -0.5, 
                Saturation = -1
            }):Play();
        end);
        return;
    else
        if v122 == "End" then
            v126:SetAsCurrentLighting();
            local l_v4_FOVMultiplier_3 = v4:CreateFOVMultiplier(game.Players.LocalPlayer, 1, "JohnDoeOutroScene");
            game.Debris:AddItem(l_v4_FOVMultiplier_3, 1);
            local v141 = game.Lighting:WaitForChild("JohnDoeStabCC", 8);
            if v141 then
                v141:Destroy();
            end;
        end;
        return;
    end;
end;
v0.OnExecution = function(_, v143, v144) --[[ Line: 829 ]] --[[ Name: OnExecution ]]
    local v145 = require(game.ReplicatedStorage.Modules.Ragdolls);
    local v146 = if v144.Name == "JaneDoe" then Vector3.new(0, -2, 0, 0) else (v143.Rig.PrimaryPart.CFrame.LookVector + Vector3.new(0, 0.5, 0, 0)) * 40;
    task.delay(0.666, function() --[[ Line: 838 ]]
        -- upvalues: v145 (copy), v144 (copy), v146 (copy)
        v145.AddProfile(v144, {
            AnchorDelay = true, 
            Applied = os.clock() + 5, 
            Velocity = v146
        });
        local l_Humanoid_2 = v144:FindFirstChild("Humanoid");
        if l_Humanoid_2 then
            l_Humanoid_2.BreakJointsOnDeath = false;
            l_Humanoid_2.Health = 0;
        end;
    end);
    task.delay(1.9, function() --[[ Line: 847 ]]
        -- upvalues: v144 (copy)
        if v144 and v144.PrimaryPart then
            v144.PrimaryPart.Anchored = false;
        end;
    end);
end;
return v0;