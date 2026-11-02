-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:11:02 2025 ]]
local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.AchievementUtil);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
v0.Abilities = {
    ThrowPizza = {
        LayoutOrder = 1, 
        KeybindType = "AltAbility1", 
        Icon = "rbxassetid://93578432067529", 
        Callback = function(v6, _) --[[ Line: 15 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v2 (copy), v3 (copy)
            if game["Run Service"]:IsServer() then
                v6:ChangeExpression("SlightlyHappy", 1.75);
                v6.AbilitiesDisabled = true;
                local l_Children_0 = script.Food:GetChildren();
                local v9 = l_Children_0[math.random(1, #l_Children_0)]:Clone();
                local v10 = string.split(tostring(v9:GetAttribute("CFOffset")), ", ") or {};
                local v11 = tonumber(v10[1]);
                local v12 = tonumber(v10[2]);
                v9.Name = "FoodItem";
                v9.CFrame = v6.Rig.Pizza.CFrame * CFrame.new(v11 or 0, 0, -0.1) * CFrame.Angles(math.rad(v12 or 0), 0, 0);
                v9.Parent = v6.Rig.Pizza;
                local l_WeldConstraint_0 = Instance.new("WeldConstraint");
                l_WeldConstraint_0.Part0 = v6.Rig.Pizza;
                l_WeldConstraint_0.Part1 = v9;
                l_WeldConstraint_0.Parent = v9;
                task.delay(0.4, function() --[[ Line: 37 ]]
                    -- upvalues: v1 (ref), v6 (copy), v2 (ref), v3 (ref), v9 (copy)
                    v1:Play(v6.Config.Sounds.PizzaThrown, {
                        Parent = v6.Rig.PrimaryPart
                    });
                    local v14 = v6.Rig.Pizza:Clone();
                    v14.PizzaJoint:Destroy();
                    v14.CollisionGroup = "Items";
                    v14.CanCollide = true;
                    local v15 = (v6.Rig.PrimaryPart.CFrame.LookVector + Vector3.new(0, 0.5, 0, 0)) * v6.Config.PizzaThrowForce;
                    v14.Parent = workspace.Map.Ingame;
                    v14.AssemblyLinearVelocity = v15;
                    v14:SetNetworkOwner(v6.Player);
                    local l_v2_ClosestPlayerFromPosition_0 = v2:GetClosestPlayerFromPosition(v6.Rig.PrimaryPart.Position, {
                        MaxDistance = v6.Config.PizzaPingDistance, 
                        ReturnTable = true
                    });
                    for _, v18 in pairs(l_v2_ClosestPlayerFromPosition_0) do
                        local l_Player_0 = v18.Player;
                        local l_PlayerFromCharacter_0 = game.Players:GetPlayerFromCharacter(l_Player_0);
                        if l_PlayerFromCharacter_0 then
                            v2:RevealPlayerAuraTo(l_PlayerFromCharacter_0, v14:FindFirstChild("FoodItem"), v6.Config.PizzaPingDuration, Color3.new(0.75, 1, 0.75));
                        end;
                    end;
                    local v21 = tick();
                    v2:ApplyUnsafeTouched(v14, false, function(v22, v23) --[[ Line: 65 ]]
                        -- upvalues: v14 (copy), v6 (ref), v21 (copy), v3 (ref), v1 (ref), v2 (ref)
                        local l_Parent_0 = v23.Parent;
                        local v25 = l_Parent_0 and l_Parent_0:FindFirstChild("Humanoid");
                        local v26 = tostring(l_Parent_0.Parent):find("Killer");
                        if v25 and (v25.Health < v25.MaxHealth or v26) and v25.Health > 0 and not v25:GetAttribute("Clanker") and v14.Parent and l_Parent_0 ~= v6.Rig and l_Parent_0:IsDescendantOf(workspace.Players) then
                            if tostring(l_Parent_0.Parent):find("Killer") then
                                if tick() - v21 < 2 then
                                    v3:IncrementAchievementProgress(v6.Player, "ElliotStupid");
                                end;
                                return;
                            else
                                v22.Disconnect();
                                v14:Destroy();
                                v1:Play(v6.Config.Sounds.PizzaEaten, {
                                    Parent = l_Parent_0.PrimaryPart or v23
                                });
                                if not (l_Parent_0.Name == "Elliot") then
                                    v6:IncrementCharges("RushHour", 1, 1);
                                end;
                                local v27 = require(game.ReplicatedStorage.Modules.AchievementUtil);
                                local v28 = -1;
                                for _, v30 in pairs(workspace.Players.Survivors:GetChildren()) do
                                    if v30.Name == "Elliot" then
                                        v28 = v28 + 1;
                                    end;
                                    if v30 ~= v6.Rig and v30.PrimaryPart and ((v30.PrimaryPart.Position - l_Parent_0.PrimaryPart.Position) * v2.KillerDistanceVector).Magnitude < 23.29 then
                                        local l_Humanoid_0 = v30:FindFirstChild("Humanoid");
                                        if l_Humanoid_0 and l_Humanoid_0.Health / l_Humanoid_0.MaxHealth <= 0.25 and v25.Health / v25.MaxHealth >= 0.7 then
                                            v27:IncrementAchievementProgress(game.Players:GetPlayerFromCharacter(v30), "PizzaSteal");
                                            v27:IncrementAchievementProgress(game.Players:GetPlayerFromCharacter(l_Parent_0), "PizzaSteal");
                                        end;
                                    end;
                                end;
                                if l_Parent_0.Name == "007n7" then
                                    v27:IncrementAchievementProgress(v6.Player, "ElliotHatesThisGuy");
                                end;
                                require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v6.Player, {
                                    Action = "Healed player as Elliot", 
                                    RewardType = "Support"
                                });
                                local v32 = v6.HealingBonus or 0;
                                local v33 = 1 - math.clamp(v28 * v6.Config.HealingPercentDebuffPerElliot / 100, 0, v6.Config.HealingPercentDebuffCap / 100);
                                if v25.Health > 0 then
                                    v2:Heal(v25, v6.Config.PizzaHealingAmount);
                                    local v34 = true;
                                    local l_Health_0 = v25.Health;
                                    local v36 = nil;
                                    v36 = v25.HealthChanged:Connect(function(v37) --[[ Line: 128 ]]
                                        -- upvalues: l_Health_0 (copy), v34 (ref), v36 (ref)
                                        if v37 <= 0 or v37 <= l_Health_0 - 10 then
                                            v34 = false;
                                            v36:Disconnect();
                                            v36 = nil;
                                        end;
                                    end);
                                    local v38 = 0;
                                    while true do
                                        if v6.Rig.Parent then
                                            local v39 = task.wait();
                                            v38 = v38 + v39;
                                            if not v34 then
                                                return;
                                            elseif not v6.Rig.Parent then
                                                return;
                                            elseif v6.Config.PizzaHealingProgressivelyTime <= v38 then
                                                return;
                                            else
                                                v2:Heal(v25, v39 * ((v6.Config.PizzaHealingProgressively + v32) * v33) / v6.Config.PizzaHealingProgressivelyTime);
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
                    task.delay(v6.Config.PizzaLifetime, function() --[[ Line: 153 ]]
                        -- upvalues: v14 (copy)
                        v14:Destroy();
                    end);
                    task.delay(v6.Config.PizzaLifetime - 1, function() --[[ Line: 154 ]]
                        -- upvalues: v14 (copy)
                        game.TweenService:Create(v14, TweenInfo.new(1), {
                            Transparency = 1
                        }):Play();
                        for _, v41 in pairs(v14:GetChildren()) do
                            if v41:IsA("BasePart") then
                                game.TweenService:Create(v41, TweenInfo.new(1), {
                                    Transparency = 1
                                }):Play();
                            end;
                        end;
                    end);
                    v9:Destroy();
                end);
                task.delay(2, function() --[[ Line: 168 ]]
                    -- upvalues: v6 (copy)
                    v6.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v6.Animations.ThrowPizza:Play();
                end;
                return;
            end;
        end
    }
};
return v0;