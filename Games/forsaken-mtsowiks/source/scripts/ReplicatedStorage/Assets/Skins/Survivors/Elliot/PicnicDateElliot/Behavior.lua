-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:11:07 2025 ]]
local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
v0.Abilities = {
    ThrowPizza = {
        LayoutOrder = 1, 
        KeybindType = "AltAbility1", 
        Icon = "rbxassetid://93578432067529", 
        Callback = function(v5, _) --[[ Line: 14 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v5:ChangeExpression("SlightlyHappy", 1.75);
                v5.AbilitiesDisabled = true;
                local l_Children_0 = script.Food:GetChildren();
                local v8 = l_Children_0[math.random(1, #l_Children_0)]:Clone();
                local v9 = string.split(tostring(v8:GetAttribute("CFOffset")), ", ") or {};
                local v10 = tonumber(v9[1]);
                local v11 = tonumber(v9[2]);
                v8.Name = "FoodItem";
                v8.CFrame = v5.Rig.Pizza.CFrame * CFrame.new(v10 or 0, 0, -0.1) * CFrame.Angles(math.rad(v11 or 0), 0, 0);
                v8.Parent = v5.Rig.Pizza;
                local l_WeldConstraint_0 = Instance.new("WeldConstraint");
                l_WeldConstraint_0.Part0 = v5.Rig.Pizza;
                l_WeldConstraint_0.Part1 = v8;
                l_WeldConstraint_0.Parent = v8;
                task.delay(0.4, function() --[[ Line: 36 ]]
                    -- upvalues: v1 (ref), v5 (copy), v2 (ref), v8 (copy)
                    v1:Play(v5.Config.Sounds.PizzaThrown, {
                        Parent = v5.Rig.PrimaryPart
                    });
                    local v13 = v5.Rig.Pizza:Clone();
                    v13.PizzaJoint:Destroy();
                    v13.CollisionGroup = "Items";
                    v13.CanCollide = true;
                    local v14 = (v5.Rig.PrimaryPart.CFrame.LookVector + Vector3.new(0, 0.5, 0, 0)) * v5.Config.PizzaThrowForce;
                    v13.Parent = workspace.Map.Ingame;
                    v13.AssemblyLinearVelocity = v14;
                    v13:SetNetworkOwner(v5.Player);
                    local l_v2_ClosestPlayerFromPosition_0 = v2:GetClosestPlayerFromPosition(v5.Rig.PrimaryPart.Position, {
                        MaxDistance = v5.Config.PizzaPingDistance, 
                        ReturnTable = true
                    });
                    for _, v17 in pairs(l_v2_ClosestPlayerFromPosition_0) do
                        local l_Player_0 = v17.Player;
                        local l_PlayerFromCharacter_0 = game.Players:GetPlayerFromCharacter(l_Player_0);
                        if l_PlayerFromCharacter_0 then
                            v2:RevealPlayerAuraTo(l_PlayerFromCharacter_0, v13:FindFirstChild("FoodItem"), v5.Config.PizzaPingDuration, Color3.new(0.75, 1, 0.75));
                        end;
                    end;
                    local v20 = tick();
                    v2:ApplyUnsafeTouched(v13, false, function(v21, v22) --[[ Line: 64 ]]
                        -- upvalues: v13 (copy), v5 (ref), v20 (copy), v1 (ref), v2 (ref)
                        local l_Parent_0 = v22.Parent;
                        local v24 = l_Parent_0 and l_Parent_0:FindFirstChild("Humanoid");
                        local v25 = tostring(l_Parent_0.Parent):find("Killer");
                        if v24 and not v24:GetAttribute("Clanker") and (v24.Health < v24.MaxHealth or v25) and v24.Health > 0 and v13.Parent and l_Parent_0 ~= v5.Rig and l_Parent_0:IsDescendantOf(workspace.Players) then
                            if tostring(l_Parent_0.Parent):find("Killer") then
                                if tick() - v20 < 2 then
                                    require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(v5.Player, "ElliotStupid");
                                end;
                                return;
                            else
                                v21.Disconnect();
                                v13:Destroy();
                                v1:Play(v5.Config.Sounds.PizzaEaten, {
                                    Parent = l_Parent_0.PrimaryPart or v22
                                });
                                if not (l_Parent_0.Name == "Elliot") then
                                    v5:IncrementCharges("RushHour", 1, 1);
                                end;
                                local v26 = require(game.ReplicatedStorage.Modules.AchievementUtil);
                                local v27 = -1;
                                for _, v29 in pairs(workspace.Players.Survivors:GetChildren()) do
                                    if v29.Name == "Elliot" then
                                        v27 = v27 + 1;
                                    end;
                                    if v29 ~= v5.Rig and v29.PrimaryPart and ((v29.PrimaryPart.Position - l_Parent_0.PrimaryPart.Position) * v2.KillerDistanceVector).Magnitude < 23.29 then
                                        local l_Humanoid_0 = v29:FindFirstChild("Humanoid");
                                        if l_Humanoid_0 and l_Humanoid_0.Health / l_Humanoid_0.MaxHealth <= 0.25 and v24.Health / v24.MaxHealth >= 0.7 then
                                            v26:IncrementAchievementProgress(game.Players:GetPlayerFromCharacter(v29), "PizzaSteal");
                                            v26:IncrementAchievementProgress(game.Players:GetPlayerFromCharacter(l_Parent_0), "PizzaSteal");
                                        end;
                                    end;
                                end;
                                if l_Parent_0.Name == "007n7" then
                                    v26:IncrementAchievementProgress(v5.Player, "ElliotHatesThisGuy");
                                end;
                                require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v5.Player, {
                                    Action = "Healed player as Elliot", 
                                    RewardType = "Support"
                                });
                                local v31 = v5.HealingBonus or 0;
                                local v32 = 1 - math.clamp(v27 * v5.Config.HealingPercentDebuffPerElliot / 100, 0, v5.Config.HealingPercentDebuffCap / 100);
                                if v24.Health > 0 then
                                    v2:Heal(v24, v5.Config.PizzaHealingAmount);
                                    local v33 = true;
                                    local l_Health_0 = v24.Health;
                                    local v35 = nil;
                                    v35 = v24.HealthChanged:Connect(function(v36) --[[ Line: 127 ]]
                                        -- upvalues: l_Health_0 (copy), v33 (ref), v35 (ref)
                                        if v36 <= 0 or v36 <= l_Health_0 - 10 then
                                            v33 = false;
                                            v35:Disconnect();
                                            v35 = nil;
                                        end;
                                    end);
                                    local v37 = 0;
                                    while true do
                                        if v5.Rig.Parent then
                                            local v38 = task.wait();
                                            v37 = v37 + v38;
                                            if not v33 then
                                                return;
                                            elseif not v5.Rig.Parent then
                                                return;
                                            elseif v5.Config.PizzaHealingProgressivelyTime <= v37 then
                                                return;
                                            else
                                                v2:Heal(v24, v38 * ((v5.Config.PizzaHealingProgressively + v31) * v32) / v5.Config.PizzaHealingProgressivelyTime);
                                            end;
                                        else
                                            --[[ close >= 11 ]]
                                            break;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end, 10);
                    task.delay(v5.Config.PizzaLifetime, function() --[[ Line: 152 ]]
                        -- upvalues: v13 (copy)
                        v13:Destroy();
                    end);
                    task.delay(v5.Config.PizzaLifetime - 1, function() --[[ Line: 153 ]]
                        -- upvalues: v13 (copy)
                        game.TweenService:Create(v13, TweenInfo.new(1), {
                            Transparency = 1
                        }):Play();
                        for _, v40 in pairs(v13:GetChildren()) do
                            if v40:IsA("BasePart") then
                                game.TweenService:Create(v40, TweenInfo.new(1), {
                                    Transparency = 1
                                }):Play();
                            end;
                        end;
                    end);
                    v8:Destroy();
                end);
                task.delay(2, function() --[[ Line: 167 ]]
                    -- upvalues: v5 (copy)
                    v5.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v5.Animations.ThrowPizza:Play();
                end;
                return;
            end;
        end
    }
};
return v0;