-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:10:28 2025 ]]
local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.AchievementUtil);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
local v6 = require(game.ReplicatedStorage.Modules.Network);
v0.Abilities = {
    FriedChicken = {
        LayoutOrder = 2, 
        KeybindType = "AltAbility2", 
        Icon = "rbxassetid://87451970500470", 
        Charges = 2, 
        Callback = function(v7, _) --[[ Line: 15 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v2 (copy), v6 (copy)
            if game["Run Service"]:IsServer() then
                v7.AbilitiesDisabled = true;
                local function v13(v9, v10) --[[ Line: 21 ]] --[[ Name: showChickenRecursive ]]
                    for _, v12 in pairs(v9:GetDescendants()) do
                        if (v12.Name:find("Chicken") or v12.Name:find("Epicsauce")) and (v12:IsA("BasePart") or v12:IsA("Decal")) and not v12:GetAttribute("Ignored") then
                            v12.Transparency = v10;
                        end;
                    end;
                end;
                v13(v7.Rig, 0);
                if v7.Cache.EatChicken then
                    v7.Cache.EatChicken:Play();
                end;
                v1:Play(v7.Config.Sounds.EatFriedChicken, {
                    Parent = v7.Rig.PrimaryPart
                });
                task.delay(2.4, function() --[[ Line: 39 ]]
                    -- upvalues: v7 (copy)
                    v7:ChangeExpression("Happy");
                    task.wait(1.5);
                    v7:ChangeExpression("Default");
                end);
                local l_Humanoid_0 = v7.Rig:FindFirstChild("Humanoid");
                if not l_Humanoid_0 then
                    return;
                else
                    local l_Health_0 = l_Humanoid_0.Health;
                    local v16 = nil;
                    v16 = l_Humanoid_0.HealthChanged:Connect(function(v17) --[[ Line: 48 ]]
                        -- upvalues: l_Health_0 (copy), v7 (copy), v3 (ref)
                        if (v17 <= 0 or v17 <= l_Health_0 - 10) and v7.Rig:GetAttribute("RecentAttacker") then
                            v3:IncrementAchievementProgress(v7.Player, "ShedletskyYesPapa");
                        end;
                    end);
                    task.delay(v7.Config.FriedChickenHealDelay, function() --[[ Line: 55 ]]
                        -- upvalues: v16 (ref), v7 (copy), v2 (ref)
                        if v16 then
                            v16:Disconnect();
                        end;
                        local l_Humanoid_1 = v7.Rig:FindFirstChild("Humanoid");
                        if not l_Humanoid_1 then
                            return;
                        else
                            if l_Humanoid_1.Health > 0 then
                                v2:Heal(l_Humanoid_1, v7.Config.FriedChickenHealInitialAmount);
                                local v19 = true;
                                local l_Health_1 = l_Humanoid_1.Health;
                                local v21 = nil;
                                v21 = l_Humanoid_1.HealthChanged:Connect(function(v22) --[[ Line: 65 ]]
                                    -- upvalues: l_Health_1 (copy), v19 (ref), v21 (ref)
                                    if v22 <= 0 or v22 <= l_Health_1 - 10 then
                                        v19 = false;
                                        v21:Disconnect();
                                        v21 = nil;
                                    end;
                                end);
                                local v23 = 0;
                                while true do
                                    if v7.Rig.Parent then
                                        local v24 = task.wait();
                                        v23 = v23 + v24;
                                        if not v19 then
                                            return;
                                        elseif not v7.Rig.Parent then
                                            return;
                                        elseif v7.Config.FriedChickenHealOvertimeDuration <= v23 then
                                            return;
                                        else
                                            v2:Heal(l_Humanoid_1, v24 * v7.Config.FriedChickenHealOvertimeAmount / v7.Config.FriedChickenHealOvertimeDuration);
                                        end;
                                    else
                                        --[[ close >= 1 ]]
                                        break;
                                    end;
                                end;
                            end;
                            return;
                        end;
                    end);
                    task.delay(1.75, function() --[[ Line: 88 ]]
                        -- upvalues: v13 (copy), v7 (copy)
                        v13(v7.Rig, 1);
                    end);
                    task.delay(4, function() --[[ Line: 93 ]]
                        -- upvalues: v7 (copy)
                        v7.AbilitiesDisabled = false;
                    end);
                    return;
                end;
            else
                if game["Run Service"]:IsClient() then
                    v7.Animations.EatChicken:Play(0.1);
                    v6:FireConnection("DisableSprinting", "EatFriedChicken", true);
                    local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v7.Rig, 0.25, "EatFriedChicken");
                    task.delay(v7.Config.FriedChickenHealDelay + 1.25, function() --[[ Line: 106 ]]
                        -- upvalues: v6 (ref), l_v2_SpeedMultiplier_0 (copy)
                        v6:FireConnection("DisableSprinting", "EatFriedChicken", false);
                        l_v2_SpeedMultiplier_0:Destroy();
                    end);
                end;
                return;
            end;
        end
    }
};
return v0;