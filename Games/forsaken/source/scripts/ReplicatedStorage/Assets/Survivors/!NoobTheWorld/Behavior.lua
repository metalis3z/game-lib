-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Util);
local v2 = require(game.ReplicatedStorage.Modules.Statuses);
local v3 = require(game.ReplicatedStorage.Modules.Network);
local v4 = require(game.ReplicatedStorage.Modules.Sounds);
local v5 = require(game.ReplicatedStorage.Modules.AchievementUtil);
local function v11(v6, v7, v8, ...) --[[ Line: 10 ]] --[[ Name: pcallMethod ]]
    local v9, v10 = pcall(function(...) --[[ Line: 11 ]]
        -- upvalues: v8 (copy), v6 (copy)
        if v8.Behavior[v6] then
            v8.Behavior[v6](v8.Behavior, v8);
        end;
    end, ...);
    if not v9 then
        warn((("[%*]: Failed to call .%*() due to: %*"):format(v7, v6, v10)));
    end;
end;
v0.Created = function(v12, v13) --[[ Line: 22 ]] --[[ Name: Created ]]
    -- upvalues: v3 (copy)
    if game["Run Service"]:IsClient() then
        v3:SetConnection("THEWORLD", "REMOTE_EVENT", function(v14, v15) --[[ Line: 24 ]]
            if not v15 then
                if game.Lighting:FindFirstChild("TimeStop") then
                    game.TweenService:Create(game.Lighting:FindFirstChild("TimeStop"), TweenInfo.new(2), {
                        Saturation = 0, 
                        Contrast = 0
                    }):Play();
                    game.Debris:AddItem(game.Lighting:FindFirstChild("TimeStop"), 2.2);
                end;
                local v16 = script.World:Clone();
                v16.Parent = workspace;
                v16.CFrame = v14.PrimaryPart.CFrame;
                v16.Size = Vector3.new(0, 0, 0, 0);
                v16.Color = Color3.fromRGB(255, math.random(1, 255), math.random(1, 255));
                v16.Transparency = 0.95;
                game.TweenService:Create(v16, TweenInfo.new(0.75, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Size = Vector3.new(700, 700, 700, 0)
                }):Play();
                delay(0.75, function() --[[ Line: 38 ]]
                    -- upvalues: v16 (copy)
                    game.TweenService:Create(v16, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        Size = Vector3.new(0, 0, 0, 0)
                    }):Play();
                    wait(0.8);
                    v16:Destroy();
                end);
                return;
            else
                spawn(function() --[[ Line: 44 ]]
                    -- upvalues: v14 (copy)
                    for v17 = 1, 3 do
                        local v18 = script.World:Clone();
                        v18.Parent = workspace;
                        v18.CFrame = v14.PrimaryPart.CFrame;
                        v18.Size = Vector3.new(0, 0, 0, 0);
                        v18.Color = Color3.fromRGB(255, math.random(1, 255), math.random(1, 255));
                        v18.Transparency = 0.93 + v17 / 60;
                        game.TweenService:Create(v18, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                            Size = Vector3.new(700, 700, 700, 0)
                        }):Play();
                        delay(0.9, function() --[[ Line: 53 ]]
                            -- upvalues: v18 (copy)
                            game.TweenService:Create(v18, TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                                Size = Vector3.new(0, 0, 0, 0)
                            }):Play();
                            wait(1.5);
                            v18:Destroy();
                        end);
                        task.wait(0.1);
                    end;
                end);
                local v19 = Instance.new("ColorCorrectionEffect", game.Lighting);
                v19.Name = "TimeStop";
                game.TweenService:Create(v19, TweenInfo.new(0.7), {
                    Saturation = -1, 
                    Contrast = 0.25
                }):Play();
                return;
            end;
        end);
    end;
end;
v0.Destroyed = function(v20, v21) --[[ Line: 70 ]] --[[ Name: Destroyed ]]
    -- upvalues: v3 (copy)
    if game["Run Service"]:IsClient() then
        v3:RemoveConnection("THEWORLD", "REMOTE_EVENT");
    end;
end;
v0.Abilities = {
    BloxyCola = {
        LayoutOrder = 1, 
        KeybindType = "AltAbility1", 
        Icon = "rbxassetid://133994175153795", 
        Callback = function(v22, v23) --[[ Line: 81 ]] --[[ Name: Callback ]]
            -- upvalues: v11 (copy), v5 (copy), v4 (copy), v2 (copy), v3 (copy), v1 (copy)
            if game["Run Service"]:IsServer() then
                local v24 = require(game.ReplicatedStorage.Assets.Items.BloxyCola.Config).StackingThreshold;
                v22.AbilitiesDisabled = true;
                v11("OnBloxyBegin", ("%*/OnBloxyBegin"):format(script.Parent), v22);
                task.delay(1.6, function() --[[ Line: 90 ]]
                    -- upvalues: v22 (copy)
                    v22:ChangeExpression("Drinking", 0.85);
                end);
                task.delay(2.45, function() --[[ Line: 95 ]]
                    -- upvalues: v22 (copy), v11 (ref), v5 (ref), v4 (ref), v2 (ref)
                    if not v22.Rig.Parent then
                        return;
                    else
                        v11("OnBloxyConsumed", ("%*/OnBloxyConsumed"):format(script.Parent), v22);
                        if v22.Rig:GetAttribute("SpeedDisabled") then
                            v5:IncrementAchievementProgress(v22.Player, "NoobDumb");
                            v4:Play("rbxassetid://8090403894", {
                                Parent = v22.Rig.PrimaryPart
                            });
                            return;
                        else
                            v2:ApplyStatus(v22.Player, "Speed", {
                                Level = 1, 
                                Duration = v22.Config.BloxyColaSpeedTime
                            });
                            v2:RemoveStatus(v22.Player, "Slowness");
                            return;
                        end;
                    end;
                end);
                task.delay(5, function() --[[ Line: 108 ]]
                    -- upvalues: v22 (copy)
                    v22.AbilitiesDisabled = false;
                end);
                task.spawn(function() --[[ Line: 113 ]]
                    -- upvalues: v22 (copy), v5 (ref), v24 (copy)
                    local v25 = tick();
                    local v26 = 0;
                    local v27 = v22.Rig.PrimaryPart.Position;
                    while tick() - v25 <= v22.Config.BloxyColaSpeedTime do
                        local v28 = game["Run Service"].Heartbeat:Wait();
                        v26 = v26 + (v22.Rig.PrimaryPart.Velocity * Vector3.new(1, 0, 1, 0) * v28).Magnitude;
                    end;
                    local v29 = v22.Config.BloxyColaAwardThreshold or 140;
                    if (v22.Rig.PrimaryPart.Position - v27).Magnitude > 220 then
                        v5:IncrementAchievementProgress(v22.Player, "NoobQuick");
                    end;
                    if v29 < v26 then
                        require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v22.Player, {
                            Action = ("Ran more than %* studs with Bloxy Cola"):format(v29), 
                            RewardType = "Survivalist"
                        });
                    end;
                    if v22.LastDrankCola and tick() - v22.LastDrankCola <= v24 then
                        v5:IncrementAchievementProgress(v22.Player, "NoobCola");
                    end;
                    v22.LastDrankCola = tick();
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v22.Animations.Drinking1:Play();
                    v3:FireConnection("DisableSprinting", "NoobDrinking", true);
                    local v30 = v1:CreateSpeedMultiplier(v22.Player, 1, "DrinkingCola");
                    game.TweenService:Create(v30, TweenInfo.new(0.2), {
                        Value = v22.Config.DrinkingColaSpeedMultiplier
                    }):Play();
                    task.delay(2.45, function() --[[ Line: 155 ]]
                        -- upvalues: v3 (ref), v30 (copy)
                        v3:FireConnection("DisableSprinting", "NoobDrinking", false);
                        game.Debris:AddItem(v30, 0.2);
                        game.TweenService:Create(v30, TweenInfo.new(0.2), {
                            Value = 1
                        }):Play();
                    end);
                end;
                return;
            end;
        end
    }, 
    SlateskinPotion = {
        LayoutOrder = 2, 
        KeybindType = "AltAbility2", 
        Icon = "rbxassetid://133354880475554", 
        Callback = function(v31, v32) --[[ Line: 169 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v11 (copy), v3 (copy), v1 (copy)
            if game["Run Service"]:IsServer() then
                if v31.SlateskinEffect then
                    v2:RemoveStatus(v31.Player, "Slateskin");
                    v31.SlateskinEffect = nil;
                    v2:ApplyStatus(v31.Player, "Speed", {
                        Level = 1, 
                        Duration = v31.Config.SlateskinSpeedDuration
                    });
                    return "Cancel";
                else
                    v31.AbilitiesDisabled = true;
                    v11("OnSlateBegin", ("%*/OnSlateBegin"):format(script.Parent), v31);
                    v31:SetCooldownOf("SlateskinPotion", 2.5);
                    task.delay(0.8, function() --[[ Line: 189 ]]
                        -- upvalues: v31 (copy)
                        v31:ChangeExpression("Drinking", 0.85);
                    end);
                    task.delay(1.2, function() --[[ Line: 194 ]]
                        -- upvalues: v31 (copy), v11 (ref), v2 (ref)
                        if not v31.Rig.Parent then
                            return;
                        else
                            v11("OnSlateConsumed", ("%*/OnSlateConsumed"):format(script.Parent), v31);
                            v31.SlateskinEffect = v2:ApplyStatus(v31.Player, "Slateskin", {
                                Level = v31.Config.SlateskinLevel, 
                                Duration = v31.Config.SlateskinEffectDuration
                            });
                            task.delay(v31.Config.SlateskinEffectDuration, function() --[[ Line: 199 ]]
                                -- upvalues: v31 (ref), v2 (ref)
                                if v31.SlateskinEffect then
                                    if not v31.SlateskinEffect.Cancelled then
                                        v2:ApplyStatus(v31.Player, "Speed", {
                                            Level = 2, 
                                            Duration = v31.Config.SlateskinSpeedDuration
                                        });
                                        require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v31.Player, {
                                            Action = "Slateskin effect ended naturally", 
                                            RewardType = "Survivalist"
                                        });
                                    end;
                                    v31.SlateskinEffect = nil;
                                    v31:SetCooldownOf("SlateskinPotion", v31.Config.SlateskinPotionCooldown);
                                end;
                            end);
                            return;
                        end;
                    end);
                    task.delay(2.5, function() --[[ Line: 221 ]]
                        -- upvalues: v31 (copy)
                        v31.AbilitiesDisabled = false;
                    end);
                    return "Drink";
                end;
            else
                if game["Run Service"]:IsClient() and v32 == "Drink" then
                    v31.Animations.Drinking2:Play();
                    v3:FireConnection("DisableSprinting", "NoobDrinkingSlateskin", true);
                    local v33 = v1:CreateSpeedMultiplier(v31.Player, 1, "DrinkingSlateskin");
                    game.TweenService:Create(v33, TweenInfo.new(0.2), {
                        Value = v31.Config.DrinkingSlateskinSpeedMultiplier
                    }):Play();
                    task.delay(1.2, function() --[[ Line: 238 ]]
                        -- upvalues: v3 (ref), v33 (copy)
                        v3:FireConnection("DisableSprinting", "NoobDrinkingSlateskin", false);
                        game.Debris:AddItem(v33, 0.2);
                        game.TweenService:Create(v33, TweenInfo.new(0.2), {
                            Value = 1
                        }):Play();
                    end);
                end;
                return;
            end;
        end
    }, 
    Ghostburger = {
        LayoutOrder = 3, 
        KeybindType = "AltAbility3", 
        Icon = "rbxassetid://112547374697556", 
        Callback = function(v34, v35) --[[ Line: 252 ]] --[[ Name: Callback ]]
            -- upvalues: v11 (copy), v4 (copy), v2 (copy), v0 (copy), v5 (copy), v3 (copy), v1 (copy)
            if game["Run Service"]:IsServer() then
                v34.AbilitiesDisabled = true;
                v11("OnGhostBegin", ("%*/OnGhostBegin"):format(script.Parent), v34);
                task.delay(0.5, function() --[[ Line: 261 ]]
                    -- upvalues: v34 (copy)
                    v34:ChangeExpression("EatStart");
                    task.wait(0.3);
                    v34:ChangeExpression("Eating");
                    task.wait(0.4);
                    v34:ChangeExpression("EatStart");
                    task.wait(0.3);
                    v34:ChangeExpression("Eating");
                    task.wait(0.3);
                    task.wait(0.2);
                    v34:ChangeExpression("Eating", 1);
                end);
                task.delay(1.6, function() --[[ Line: 276 ]]
                    -- upvalues: v34 (copy), v4 (ref)
                    local v36 = v34.Rig.PrimaryPart;
                    if v36 then
                        v4:Play(v34.Config.Sounds.GhostburgerEffect, {
                            Parent = v36, 
                            Position = v36.Position
                        });
                    end;
                end);
                task.delay(2, function() --[[ Line: 284 ]]
                    -- upvalues: v34 (copy), v11 (ref), v2 (ref), v0 (ref), v5 (ref)
                    if not v34.Rig.Parent then
                        return;
                    else
                        v11("OnGhostConsumed", ("%*/OnGhostConsumed"):format(script.Parent), v34);
                        v2:ApplyStatus(v34.Player, "Undetectable", {
                            Level = 1, 
                            Duration = v34.Config.GhostburgerUndetectableTime
                        });
                        v2:ApplyStatus(v34.Player, "Invisibility", {
                            Level = 4, 
                            Duration = v34.Config.GhostburgerInvisibilityTime
                        });
                        if v0:NeedsToHide(v34) then
                            require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v34.Player, {
                                Action = "Hid with Ghostburger", 
                                RewardType = "Survivalist"
                            });
                            v5:IncrementAchievementProgress(v34.Player, "NoobGenius");
                        end;
                        return;
                    end;
                end);
                task.delay(5, function() --[[ Line: 308 ]]
                    -- upvalues: v34 (copy)
                    v34.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v34.Animations.Eating:Play();
                    v3:FireConnection("DisableSprinting", "NoobGhostBurger", true);
                    local v37 = v1:CreateSpeedMultiplier(v34.Player, 1, "EatingGhostburger");
                    game.TweenService:Create(v37, TweenInfo.new(0.2), {
                        Value = v34.Config.EatingSpeedMultiplier
                    }):Play();
                    task.delay(2, function() --[[ Line: 322 ]]
                        -- upvalues: v3 (ref), v37 (copy)
                        v3:FireConnection("DisableSprinting", "NoobGhostBurger", false);
                        game.Debris:AddItem(v37, 0.2);
                        game.TweenService:Create(v37, TweenInfo.new(0.2), {
                            Value = 1
                        }):Play();
                    end);
                end;
                return;
            end;
        end
    }, 
    Timestop = {
        LayoutOrder = 4, 
        KeybindType = "AltAbility4", 
        Icon = "rbxassetid://112547374697556", 
        Callback = function(v38, v39) --[[ Line: 336 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v4 (copy), v3 (copy)
            if game["Run Service"]:IsServer() then
                v38.AbilitiesDisabled = true;
                v1:CreateSpeedMultiplier(v38.Rig, 0, "Timestop", 1.6166666666666667);
                v4:Play(v38.Config.Sounds.TimestopWindup, {
                    Parent = v38.Rig.PrimaryPart
                });
                task.delay(0.8333333333333334, function() --[[ Line: 343 ]]
                    -- upvalues: v3 (ref), v38 (copy), v4 (ref), v1 (ref)
                    v3:FireAllClientConnection("THEWORLD", "REMOTE_EVENT", v38.Rig, true);
                    v4:Play(v38.Config.Sounds.Timestop, {
                        Volume = 3
                    });
                    v1:GiveStackableAttribute(workspace, "BloodHuntActive", "zawarudo");
                    local v40 = {};
                    local function v46(v41) --[[ Line: 350 ]] --[[ Name: freezePeople ]]
                        -- upvalues: v38 (ref), v40 (copy)
                        for v42, v43 in ipairs(v41:GetChildren()) do
                            if v43 ~= v38.Rig and v43:IsA("Model") then
                                for v44, v45 in ipairs(v43:GetDescendants()) do
                                    if v45:IsA("BasePart") then
                                        v40[v45] = v45.Anchored;
                                        v45.Anchored = true;
                                    end;
                                end;
                            end;
                        end;
                    end;
                    v46(workspace.Players.Survivors);
                    v46(workspace.Players.Killers);
                    for v47, v48 in ipairs(require(game.ReplicatedStorage.Modules.Actors).CurrentActors) do
                        if v48 ~= v38 then
                            v48:DisableAbilities("Timestop", true);
                        end;
                    end;
                    task.delay(8, function() --[[ Line: 372 ]]
                        -- upvalues: v4 (ref), v38 (ref), v3 (ref), v40 (copy), v1 (ref)
                        v4:Play(v38.Config.Sounds.Resume, {
                            Volume = 1.5
                        });
                        v3:FireAllClientConnection("THEWORLD", "REMOTE_EVENT", v38.Rig, false);
                        wait(1.2);
                        for v49, v50 in pairs(v40) do
                            v49.Anchored = v50;
                        end;
                        v1:RemoveStackableAttribute(workspace, "BloodHuntActive", "zawarudo");
                        for v51, v52 in ipairs(require(game.ReplicatedStorage.Modules.Actors).CurrentActors) do
                            if v52 ~= v38 then
                                v52:DisableAbilities("Timestop", false);
                            end;
                        end;
                    end);
                end);
                task.delay(5, function() --[[ Line: 389 ]]
                    -- upvalues: v38 (copy)
                    v38.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v38.Animations.Timestop:Play();
                end;
                return;
            end;
        end
    }
};
v0.OnGhostBegin = function(v53, v54) --[[ Line: 401 ]] --[[ Name: OnGhostBegin ]]
    if v54.Rig and v54.Rig.Parent then
        v54.Rig.Ghostburger.Transparency = 0.1;
    end;
end;
v0.OnGhostConsumed = function(v55, v56) --[[ Line: 407 ]] --[[ Name: OnGhostConsumed ]]
    if v56.Rig and v56.Rig.Parent then
        v56.Rig.Ghostburger.Transparency = 1;
    end;
end;
v0.OnBloxyBegin = function(v57, v58) --[[ Line: 413 ]] --[[ Name: OnBloxyBegin ]]
    if v58.Rig and v58.Rig.Parent then
        v58.Rig.BloxyCola.Transparency = 0;
    end;
end;
v0.OnBloxyConsumed = function(v59, v60) --[[ Line: 419 ]] --[[ Name: OnBloxyConsumed ]]
    if v60.Rig and v60.Rig.Parent then
        v60.Rig.BloxyCola.Transparency = 1;
    end;
end;
v0.OnSlateBegin = function(v61, v62) --[[ Line: 425 ]] --[[ Name: OnSlateBegin ]]
    if v62.Rig and v62.Rig.Parent then
        v62.Rig.Slateskin.Transparency = 0.011;
    end;
end;
v0.OnSlateConsumed = function(v63, v64) --[[ Line: 431 ]] --[[ Name: OnSlateConsumed ]]
    if v64.Rig and v64.Rig.Parent then
        v64.Rig.Slateskin.Transparency = 1;
    end;
end;
v0.NeedsToHide = function(v65, v66) --[[ Line: 438 ]] --[[ Name: NeedsToHide ]]
    local v67 = v66.Behavior;
    local v68 = v67.LastAuraApplied and v67.CurrentAuraLength - (tick() - v67.LastAuraApplied) or -1;
    local v69 = v67.LastAuraApplied and v67.CurrentAuraLength and v68 > 0;
    local v70 = v67.AILastSeen and tick() - v67.AILastSeen < 2;
    return v69 or v70;
end;
v0.OnAuraRevealed = function(v71, v72, v73, v74) --[[ Line: 448 ]] --[[ Name: OnAuraRevealed ]]
    local v75 = v72.Behavior;
    local v76 = require(game.ReplicatedStorage.Modules.Actors).CurrentActors[v73];
    local v77 = v75.LastAuraApplied and v75.CurrentAuraLength - (tick() - v75.LastAuraApplied) or -1;
    if v76 and v76.Rig.Parent.Name == "Killers" and v77 < v74 then
        v75.LastAuraApplied = tick();
        v75.CurrentAuraLength = v74;
    end;
end;
return v0;