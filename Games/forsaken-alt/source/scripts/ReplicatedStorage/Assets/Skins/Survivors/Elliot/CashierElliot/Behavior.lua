-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

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
                    v13.Touched:Connect(function(v20) --[[ Line: 63 ]]
                        -- upvalues: v13 (copy), v5 (ref), v1 (ref)
                        local l_Parent_0 = v20.Parent;
                        local v22 = l_Parent_0 and l_Parent_0:FindFirstChild("Humanoid");
                        if v22 and v22.Health < v22.MaxHealth and v13.Parent and not l_Parent_0:GetAttribute("ExecutionsDisabled") and l_Parent_0 ~= v5.Rig and tostring(l_Parent_0.Parent) ~= "Killers" and tostring(l_Parent_0.Parent) ~= "Spectating" then
                            v13:Destroy();
                            v1:Play(v5.Config.Sounds.PizzaEaten, {
                                Parent = l_Parent_0.PrimaryPart or v20
                            });
                            local v23 = l_Parent_0.Name == "Elliot";
                            if not v23 then
                                v5:IncrementCharges("RushHour", 1, 1);
                            end;
                            local v24 = -1;
                            for _, v26 in pairs(workspace.Players.Survivors:GetChildren()) do
                                if v26.Name == "Elliot" then
                                    v24 = v24 + 1;
                                end;
                            end;
                            local v27 = 1 + (tonumber(v5.HealingMultiplier) or 0) / 100;
                            local v28 = 1 - math.clamp(v24 * v5.Config.HealingPercentDebuffPerElliot / 100, 0, v5.Config.HealingPercentDebuffCap / 100);
                            local v29 = v5.Config.PizzaHealingAmount * v27 * v28;
                            v22.Health = v22.Health + (v23 and v29 * 0.7 or v29);
                            if l_Parent_0.Name == "007n7" then
                                require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(v5.Player, "ElliotHatesThisGuy");
                            end;
                            require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v5.Player, {
                                Action = "Healed player as Elliot", 
                                RewardType = "Support"
                            });
                        end;
                    end);
                    task.delay(v5.Config.PizzaLifetime, function() --[[ Line: 107 ]]
                        -- upvalues: v13 (copy)
                        v13:Destroy();
                    end);
                    task.delay(v5.Config.PizzaLifetime - 1, function() --[[ Line: 108 ]]
                        -- upvalues: v13 (copy)
                        game.TweenService:Create(v13, TweenInfo.new(1), {
                            Transparency = 1
                        }):Play();
                        for _, v31 in pairs(v13:GetChildren()) do
                            if v31:IsA("BasePart") then
                                game.TweenService:Create(v31, TweenInfo.new(1), {
                                    Transparency = 1
                                }):Play();
                            end;
                        end;
                    end);
                    v8:Destroy();
                end);
                task.delay(2, function() --[[ Line: 122 ]]
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