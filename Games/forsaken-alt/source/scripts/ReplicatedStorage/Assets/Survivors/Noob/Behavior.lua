-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Util);
local v2 = require(game.ReplicatedStorage.Modules.Statuses);
local v3 = require(game.ReplicatedStorage.Modules.Network);
local v4 = require(game.ReplicatedStorage.Modules.Sounds);
local v5 = require(game.ReplicatedStorage.Modules.AchievementUtil);
v0.Abilities = {
    BloxyCola = {
        LayoutOrder = 1, 
        KeybindType = "AltAbility1", 
        Icon = "rbxassetid://133994175153795", 
        Charges = 2, 
        Callback = function(v6, _) --[[ Line: 16 ]] --[[ Name: Callback ]]
            -- upvalues: v5 (copy), v4 (copy), v2 (copy), v3 (copy), v1 (copy)
            if game["Run Service"]:IsServer() then
                v6.AbilitiesDisabled = true;
                v6.Rig.BloxyCola.Transparency = 0;
                task.delay(1.6, function() --[[ Line: 23 ]]
                    -- upvalues: v6 (copy)
                    v6:ChangeExpression("Drinking", 0.85);
                end);
                task.delay(2.45, function() --[[ Line: 28 ]]
                    -- upvalues: v6 (copy), v5 (ref), v4 (ref), v2 (ref)
                    if not v6.Rig.Parent then
                        return;
                    else
                        v6.Rig.BloxyCola.Transparency = 1;
                        if v6.Rig:GetAttribute("SpeedDisabled") then
                            v5:IncrementAchievementProgress(v6.Player, "NoobDumb");
                            v4:Play("rbxassetid://8090403894", {
                                Parent = v6.Rig.PrimaryPart
                            });
                            return;
                        else
                            v2:ApplyStatus(v6.Player, "Speed", {
                                Level = 1, 
                                Duration = v6.Config.BloxyColaSpeedTime
                            });
                            v2:RemoveStatus(v6.Player, "Slowness");
                            return;
                        end;
                    end;
                end);
                task.delay(5, function() --[[ Line: 41 ]]
                    -- upvalues: v6 (copy)
                    v6.AbilitiesDisabled = false;
                end);
                if not v6.TimeSinceFirstDrank then
                    v6.TimeSinceFirstDrank = tick();
                end;
                if tick() - v6.TimeSinceFirstDrank <= 20 and v6.Behavior.Abilities.BloxyCola.CurrentCharges <= 0 then
                    v5:IncrementAchievementProgress(v6.Player, "NoobCola");
                    return;
                end;
            elseif game["Run Service"]:IsClient() then
                v6.Animations.Drinking1:Play();
                v3:FireConnection("DisableSprinting", "NoobDrinking", true);
                local l_v1_SpeedMultiplier_0 = v1:CreateSpeedMultiplier(v6.Player, 1, "DrinkingCola");
                game.TweenService:Create(l_v1_SpeedMultiplier_0, TweenInfo.new(0.2), {
                    Value = v6.Config.DrinkingColaSpeedMultiplier
                }):Play();
                task.delay(2.45, function() --[[ Line: 61 ]]
                    -- upvalues: v3 (ref), l_v1_SpeedMultiplier_0 (copy)
                    v3:FireConnection("DisableSprinting", "NoobDrinking", false);
                    game.Debris:AddItem(l_v1_SpeedMultiplier_0, 0.2);
                    game.TweenService:Create(l_v1_SpeedMultiplier_0, TweenInfo.new(0.2), {
                        Value = 1
                    }):Play();
                end);
            end;
        end
    }, 
    SlateskinPotion = {
        LayoutOrder = 2, 
        KeybindType = "AltAbility2", 
        Icon = "rbxassetid://133354880475554", 
        Charges = 2, 
        Callback = function(v9, _) --[[ Line: 76 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v3 (copy), v1 (copy)
            if game["Run Service"]:IsServer() then
                v9.AbilitiesDisabled = true;
                v9.Rig.Slateskin.Transparency = 0.011;
                task.delay(0.8, function() --[[ Line: 83 ]]
                    -- upvalues: v9 (copy)
                    v9:ChangeExpression("Drinking", 0.85);
                end);
                task.delay(1.2, function() --[[ Line: 88 ]]
                    -- upvalues: v9 (copy), v2 (ref)
                    if not v9.Rig.Parent then
                        return;
                    else
                        v9.Rig.Slateskin.Transparency = 1;
                        local v11 = v2:ApplyStatus(v9.Player, "Slateskin", {
                            Level = v9.Config.SlateskinLevel, 
                            Duration = v9.Config.SlateskinEffectDuration
                        });
                        task.delay(v9.Config.SlateskinEffectDuration, function() --[[ Line: 93 ]]
                            -- upvalues: v11 (copy), v2 (ref), v9 (ref)
                            if v11 and not v11.Cancelled then
                                v2:ApplyStatus(v9.Player, "Speed", {
                                    Level = 2, 
                                    Duration = v9.Config.SlateskinSpeedDuration
                                });
                                require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v9.Player, {
                                    Action = "Slateskin effect ended naturally", 
                                    RewardType = "Survivalist"
                                });
                            end;
                        end);
                        return;
                    end;
                end);
                task.delay(2.5, function() --[[ Line: 108 ]]
                    -- upvalues: v9 (copy)
                    v9.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v9.Animations.Drinking2:Play();
                    v3:FireConnection("DisableSprinting", "NoobDrinkingSlateskin", true);
                    local l_v1_SpeedMultiplier_1 = v1:CreateSpeedMultiplier(v9.Player, 1, "DrinkingSlateskin");
                    game.TweenService:Create(l_v1_SpeedMultiplier_1, TweenInfo.new(0.2), {
                        Value = v9.Config.DrinkingSlateskinSpeedMultiplier
                    }):Play();
                    task.delay(1.2, function() --[[ Line: 122 ]]
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
        Callback = function(v13, _) --[[ Line: 136 ]] --[[ Name: Callback ]]
            -- upvalues: v4 (copy), v2 (copy), v3 (copy), v1 (copy)
            if game["Run Service"]:IsServer() then
                v13.AbilitiesDisabled = true;
                v13.Rig.Ghostburger.Transparency = 0.1;
                task.delay(0.5, function() --[[ Line: 145 ]]
                    -- upvalues: v13 (copy)
                    v13:ChangeExpression("EatStart");
                    task.wait(0.3);
                    v13:ChangeExpression("Eating");
                    task.wait(0.4);
                    v13:ChangeExpression("EatStart");
                    task.wait(0.3);
                    v13:ChangeExpression("Eating");
                    task.wait(0.3);
                    task.wait(0.2);
                    v13:ChangeExpression("Eating", 1);
                end);
                task.delay(1.6, function() --[[ Line: 160 ]]
                    -- upvalues: v4 (ref), v13 (copy)
                    v4:Play(v13.Config.Sounds.GhostburgerEffect, {
                        Parent = v13.Rig.PrimaryPart
                    });
                end);
                task.delay(2, function() --[[ Line: 165 ]]
                    -- upvalues: v13 (copy), v2 (ref)
                    if not v13.Rig.Parent then
                        return;
                    else
                        v13.Rig.Ghostburger.Transparency = 1;
                        v2:ApplyStatus(v13.Player, "Undetectable", {
                            Level = 1, 
                            Duration = v13.Config.GhostburgerUndetectableTime
                        });
                        v2:ApplyStatus(v13.Player, "Invisibility", {
                            Level = 3, 
                            Duration = v13.Config.GhostburgerInvisibilityTime
                        });
                        return;
                    end;
                end);
                task.delay(5, function() --[[ Line: 178 ]]
                    -- upvalues: v13 (copy)
                    v13.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v13.Animations.Eating:Play();
                    v3:FireConnection("DisableSprinting", "NoobGhostBurger", true);
                    local l_v1_SpeedMultiplier_2 = v1:CreateSpeedMultiplier(v13.Player, 1, "EatingGhostburger");
                    game.TweenService:Create(l_v1_SpeedMultiplier_2, TweenInfo.new(0.2), {
                        Value = v13.Config.EatingSpeedMultiplier
                    }):Play();
                    task.delay(2, function() --[[ Line: 192 ]]
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
return v0;