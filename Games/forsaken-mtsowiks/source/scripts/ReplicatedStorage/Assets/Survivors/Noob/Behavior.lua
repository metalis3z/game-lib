-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Util);
local v2 = require(game.ReplicatedStorage.Modules.Statuses);
local v3 = require(game.ReplicatedStorage.Modules.Network);
local v4 = require(game.ReplicatedStorage.Modules.Sounds);
local v5 = require(game.ReplicatedStorage.Modules.AchievementUtil);
local function v11(v6, v7, v8, ...) --[[ Line: 10 ]] --[[ Name: pcallMethod ]]
    local l_status_0, l_result_0 = pcall(function(...) --[[ Line: 11 ]]
        -- upvalues: v8 (copy), v6 (copy)
        if v8.Behavior[v6] then
            v8.Behavior[v6](v8.Behavior, v8);
        end;
    end, ...);
    if not l_status_0 then
        warn((("[%*]: Failed to call .%*() due to: %*"):format(v7, v6, l_result_0)));
    end;
end;
v0.Abilities = {
    BloxyCola = {
        LayoutOrder = 1, 
        KeybindType = "AltAbility1", 
        Icon = "rbxassetid://133994175153795", 
        Callback = function(v12, _) --[[ Line: 27 ]] --[[ Name: Callback ]]
            -- upvalues: v11 (copy), v5 (copy), v4 (copy), v2 (copy), v3 (copy), v1 (copy)
            if game["Run Service"]:IsServer() then
                local l_StackingThreshold_0 = require(game.ReplicatedStorage.Assets.Items.BloxyCola.Config).StackingThreshold;
                v12.AbilitiesDisabled = true;
                v11("OnBloxyBegin", ("%*/OnBloxyBegin"):format(script.Parent), v12);
                task.delay(1.6, function() --[[ Line: 36 ]]
                    -- upvalues: v12 (copy)
                    v12:ChangeExpression("Drinking", 0.85);
                end);
                task.delay(2.45, function() --[[ Line: 41 ]]
                    -- upvalues: v12 (copy), v11 (ref), v5 (ref), v4 (ref), v2 (ref)
                    if not v12.Rig.Parent then
                        return;
                    else
                        v11("OnBloxyConsumed", ("%*/OnBloxyConsumed"):format(script.Parent), v12);
                        if v12.Rig:GetAttribute("SpeedDisabled") then
                            v5:IncrementAchievementProgress(v12.Player, "NoobDumb");
                            v4:Play("rbxassetid://8090403894", {
                                Parent = v12.Rig.PrimaryPart
                            });
                            return;
                        else
                            v2:ApplyStatus(v12.Player, "Speed", {
                                Level = 1, 
                                Duration = v12.Config.BloxyColaSpeedTime
                            });
                            v2:RemoveStatus(v12.Player, "Slowness");
                            return;
                        end;
                    end;
                end);
                task.delay(5, function() --[[ Line: 54 ]]
                    -- upvalues: v12 (copy)
                    v12.AbilitiesDisabled = false;
                end);
                task.spawn(function() --[[ Line: 59 ]]
                    -- upvalues: v12 (copy), v5 (ref), l_StackingThreshold_0 (copy)
                    local v15 = tick();
                    local v16 = 0;
                    local l_Position_0 = v12.Rig.PrimaryPart.Position;
                    while tick() - v15 <= v12.Config.BloxyColaSpeedTime do
                        local v18 = game["Run Service"].Heartbeat:Wait();
                        v16 = v16 + (v12.Rig.PrimaryPart.Velocity * Vector3.new(1, 0, 1, 0) * v18).Magnitude;
                    end;
                    local v19 = v12.Config.BloxyColaAwardThreshold or 140;
                    if (v12.Rig.PrimaryPart.Position - l_Position_0).Magnitude > 220 then
                        v5:IncrementAchievementProgress(v12.Player, "NoobQuick");
                    end;
                    if v19 < v16 then
                        require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v12.Player, {
                            Action = ("Ran more than %* studs with Bloxy Cola"):format(v19), 
                            RewardType = "Survivalist"
                        });
                    end;
                    if v12.LastDrankCola and tick() - v12.LastDrankCola <= l_StackingThreshold_0 then
                        v5:IncrementAchievementProgress(v12.Player, "NoobCola");
                    end;
                    v12.LastDrankCola = tick();
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v12.Animations.Drinking1:Play();
                    v3:FireConnection("DisableSprinting", "NoobDrinking", true);
                    local l_v1_SpeedMultiplier_0 = v1:CreateSpeedMultiplier(v12.Player, 1, "DrinkingCola");
                    game.TweenService:Create(l_v1_SpeedMultiplier_0, TweenInfo.new(0.2), {
                        Value = v12.Config.DrinkingColaSpeedMultiplier
                    }):Play();
                    task.delay(2.45, function() --[[ Line: 101 ]]
                        -- upvalues: v3 (ref), l_v1_SpeedMultiplier_0 (copy)
                        v3:FireConnection("DisableSprinting", "NoobDrinking", false);
                        game.Debris:AddItem(l_v1_SpeedMultiplier_0, 0.2);
                        game.TweenService:Create(l_v1_SpeedMultiplier_0, TweenInfo.new(0.2), {
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
        Callback = function(v21, v22) --[[ Line: 115 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v11 (copy), v3 (copy), v1 (copy)
            if game["Run Service"]:IsServer() then
                if v21.SlateskinEffect then
                    v2:RemoveStatus(v21.Player, "Slateskin");
                    v21.SlateskinEffect = nil;
                    v2:ApplyStatus(v21.Player, "Speed", {
                        Level = 1, 
                        Duration = v21.Config.SlateskinSpeedDuration
                    });
                    return "Cancel";
                else
                    v21.AbilitiesDisabled = true;
                    v11("OnSlateBegin", ("%*/OnSlateBegin"):format(script.Parent), v21);
                    v21:SetCooldownOf("SlateskinPotion", 2.5);
                    task.delay(0.8, function() --[[ Line: 135 ]]
                        -- upvalues: v21 (copy)
                        v21:ChangeExpression("Drinking", 0.85);
                    end);
                    task.delay(1.2, function() --[[ Line: 140 ]]
                        -- upvalues: v21 (copy), v11 (ref), v2 (ref)
                        if not v21.Rig.Parent then
                            return;
                        else
                            v11("OnSlateConsumed", ("%*/OnSlateConsumed"):format(script.Parent), v21);
                            v21.SlateskinEffect = v2:ApplyStatus(v21.Player, "Slateskin", {
                                Level = v21.Config.SlateskinLevel, 
                                Duration = v21.Config.SlateskinEffectDuration
                            });
                            task.delay(v21.Config.SlateskinEffectDuration, function() --[[ Line: 145 ]]
                                -- upvalues: v21 (ref), v2 (ref)
                                if v21.SlateskinEffect then
                                    if not v21.SlateskinEffect.Cancelled then
                                        v2:ApplyStatus(v21.Player, "Speed", {
                                            Level = 2, 
                                            Duration = v21.Config.SlateskinSpeedDuration
                                        });
                                        require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v21.Player, {
                                            Action = "Slateskin effect ended naturally", 
                                            RewardType = "Survivalist"
                                        });
                                    end;
                                    v21.SlateskinEffect = nil;
                                    v21:SetCooldownOf("SlateskinPotion", v21.Config.SlateskinPotionCooldown);
                                end;
                            end);
                            return;
                        end;
                    end);
                    task.delay(2.5, function() --[[ Line: 167 ]]
                        -- upvalues: v21 (copy)
                        v21.AbilitiesDisabled = false;
                    end);
                    return "Drink";
                end;
            else
                if game["Run Service"]:IsClient() and v22 == "Drink" then
                    v21.Animations.Drinking2:Play();
                    v3:FireConnection("DisableSprinting", "NoobDrinkingSlateskin", true);
                    local l_v1_SpeedMultiplier_1 = v1:CreateSpeedMultiplier(v21.Player, 1, "DrinkingSlateskin");
                    game.TweenService:Create(l_v1_SpeedMultiplier_1, TweenInfo.new(0.2), {
                        Value = v21.Config.DrinkingSlateskinSpeedMultiplier
                    }):Play();
                    task.delay(1.2, function() --[[ Line: 184 ]]
                        -- upvalues: v3 (ref), l_v1_SpeedMultiplier_1 (copy)
                        v3:FireConnection("DisableSprinting", "NoobDrinkingSlateskin", false);
                        game.Debris:AddItem(l_v1_SpeedMultiplier_1, 0.2);
                        game.TweenService:Create(l_v1_SpeedMultiplier_1, TweenInfo.new(0.2), {
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
        Callback = function(v24, _) --[[ Line: 198 ]] --[[ Name: Callback ]]
            -- upvalues: v11 (copy), v4 (copy), v2 (copy), v0 (copy), v5 (copy), v3 (copy), v1 (copy)
            if game["Run Service"]:IsServer() then
                v24.AbilitiesDisabled = true;
                v11("OnGhostBegin", ("%*/OnGhostBegin"):format(script.Parent), v24);
                task.delay(0.5, function() --[[ Line: 207 ]]
                    -- upvalues: v24 (copy)
                    v24:ChangeExpression("EatStart");
                    task.wait(0.3);
                    v24:ChangeExpression("Eating");
                    task.wait(0.4);
                    v24:ChangeExpression("EatStart");
                    task.wait(0.3);
                    v24:ChangeExpression("Eating");
                    task.wait(0.3);
                    task.wait(0.2);
                    v24:ChangeExpression("Eating", 1);
                end);
                task.delay(1.6, function() --[[ Line: 222 ]]
                    -- upvalues: v24 (copy), v4 (ref)
                    local l_PrimaryPart_0 = v24.Rig.PrimaryPart;
                    if l_PrimaryPart_0 then
                        v4:Play(v24.Config.Sounds.GhostburgerEffect, {
                            Parent = l_PrimaryPart_0, 
                            Position = l_PrimaryPart_0.Position
                        });
                    end;
                end);
                task.delay(2, function() --[[ Line: 230 ]]
                    -- upvalues: v24 (copy), v11 (ref), v2 (ref), v0 (ref), v5 (ref)
                    if not v24.Rig.Parent then
                        return;
                    else
                        v11("OnGhostConsumed", ("%*/OnGhostConsumed"):format(script.Parent), v24);
                        v2:ApplyStatus(v24.Player, "Undetectable", {
                            Level = 1, 
                            Duration = v24.Config.GhostburgerUndetectableTime
                        });
                        v2:ApplyStatus(v24.Player, "Invisibility", {
                            Level = 4, 
                            Duration = v24.Config.GhostburgerInvisibilityTime
                        });
                        if v0:NeedsToHide(v24) then
                            require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v24.Player, {
                                Action = "Hid with Ghostburger", 
                                RewardType = "Survivalist"
                            });
                            v5:IncrementAchievementProgress(v24.Player, "NoobGenius");
                        end;
                        return;
                    end;
                end);
                task.delay(5, function() --[[ Line: 254 ]]
                    -- upvalues: v24 (copy)
                    v24.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v24.Animations.Eating:Play();
                    v3:FireConnection("DisableSprinting", "NoobGhostBurger", true);
                    local l_v1_SpeedMultiplier_2 = v1:CreateSpeedMultiplier(v24.Player, 1, "EatingGhostburger");
                    game.TweenService:Create(l_v1_SpeedMultiplier_2, TweenInfo.new(0.2), {
                        Value = v24.Config.EatingSpeedMultiplier
                    }):Play();
                    task.delay(2, function() --[[ Line: 268 ]]
                        -- upvalues: v3 (ref), l_v1_SpeedMultiplier_2 (copy)
                        v3:FireConnection("DisableSprinting", "NoobGhostBurger", false);
                        game.Debris:AddItem(l_v1_SpeedMultiplier_2, 0.2);
                        game.TweenService:Create(l_v1_SpeedMultiplier_2, TweenInfo.new(0.2), {
                            Value = 1
                        }):Play();
                    end);
                end;
                return;
            end;
        end
    }
};
v0.OnGhostBegin = function(_, v29) --[[ Line: 279 ]] --[[ Name: OnGhostBegin ]]
    if v29.Rig and v29.Rig.Parent then
        v29.Rig.Ghostburger.Transparency = 0.1;
    end;
end;
v0.OnGhostConsumed = function(_, v31) --[[ Line: 285 ]] --[[ Name: OnGhostConsumed ]]
    if v31.Rig and v31.Rig.Parent then
        v31.Rig.Ghostburger.Transparency = 1;
    end;
end;
v0.OnBloxyBegin = function(_, v33) --[[ Line: 291 ]] --[[ Name: OnBloxyBegin ]]
    if v33.Rig and v33.Rig.Parent then
        v33.Rig.BloxyCola.Transparency = 0;
    end;
end;
v0.OnBloxyConsumed = function(_, v35) --[[ Line: 297 ]] --[[ Name: OnBloxyConsumed ]]
    if v35.Rig and v35.Rig.Parent then
        v35.Rig.BloxyCola.Transparency = 1;
    end;
end;
v0.OnSlateBegin = function(_, v37) --[[ Line: 303 ]] --[[ Name: OnSlateBegin ]]
    if v37.Rig and v37.Rig.Parent then
        v37.Rig.Slateskin.Transparency = 0.011;
    end;
end;
v0.OnSlateConsumed = function(_, v39) --[[ Line: 309 ]] --[[ Name: OnSlateConsumed ]]
    if v39.Rig and v39.Rig.Parent then
        v39.Rig.Slateskin.Transparency = 1;
    end;
end;
v0.NeedsToHide = function(_, v41) --[[ Line: 316 ]] --[[ Name: NeedsToHide ]]
    local l_Behavior_0 = v41.Behavior;
    local v43 = l_Behavior_0.LastAuraApplied and l_Behavior_0.CurrentAuraLength - (tick() - l_Behavior_0.LastAuraApplied) or -1;
    local v44 = l_Behavior_0.LastAuraApplied and l_Behavior_0.CurrentAuraLength and v43 > 0;
    local v45 = l_Behavior_0.AILastSeen and tick() - l_Behavior_0.AILastSeen < 2;
    return v44 or v45;
end;
v0.OnAuraRevealed = function(_, v47, v48, v49) --[[ Line: 326 ]] --[[ Name: OnAuraRevealed ]]
    local l_Behavior_1 = v47.Behavior;
    local v51 = require(game.ReplicatedStorage.Modules.Actors).CurrentActors[v48];
    local v52 = l_Behavior_1.LastAuraApplied and l_Behavior_1.CurrentAuraLength - (tick() - l_Behavior_1.LastAuraApplied) or -1;
    if v51 and v51.Rig.Parent.Name == "Killers" and v52 < v49 then
        l_Behavior_1.LastAuraApplied = tick();
        l_Behavior_1.CurrentAuraLength = v49;
    end;
end;
return v0;