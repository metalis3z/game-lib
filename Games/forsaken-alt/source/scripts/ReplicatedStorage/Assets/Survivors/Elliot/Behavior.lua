-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
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
                v5.Rig.Pizza.Transparency = v5.Config.PizzaTransparency or 0;
                for _, v8 in pairs(v5.Rig.Pizza:GetChildren()) do
                    if v8:IsA("BasePart") then
                        v8.Transparency = 0;
                    end;
                end;
                task.delay(0.4, function() --[[ Line: 23 ]]
                    -- upvalues: v1 (ref), v5 (copy), v2 (ref)
                    v1:Play(v5.Config.Sounds.PizzaThrown, {
                        Parent = v5.Rig.PrimaryPart
                    });
                    local v9 = v5.Rig.Pizza:Clone();
                    v9.PizzaJoint:Destroy();
                    v9.CollisionGroup = "Items";
                    v9.CanCollide = true;
                    v9.Parent = workspace.Map.Ingame;
                    v9.AssemblyLinearVelocity = (v5.Rig.PrimaryPart.CFrame.LookVector + Vector3.new(0, 0.5, 0, 0)) * v5.Config.PizzaThrowForce;
                    v9:SetNetworkOwner(v5.Player);
                    local l_v2_ClosestPlayerFromPosition_0 = v2:GetClosestPlayerFromPosition(v5.Rig.PrimaryPart.Position, {
                        MaxDistance = v5.Config.PizzaPingDistance, 
                        ReturnTable = true
                    });
                    for _, v12 in pairs(l_v2_ClosestPlayerFromPosition_0) do
                        local l_Player_0 = v12.Player;
                        local l_PlayerFromCharacter_0 = game.Players:GetPlayerFromCharacter(l_Player_0);
                        if l_PlayerFromCharacter_0 then
                            v2:RevealPlayerAuraTo(l_PlayerFromCharacter_0, v9, v5.Config.PizzaPingDuration, Color3.new(0.75, 1, 0.75));
                        end;
                    end;
                    v9.Touched:Connect(function(v15) --[[ Line: 47 ]]
                        -- upvalues: v9 (copy), v5 (ref), v1 (ref)
                        local l_Parent_0 = v15.Parent;
                        local v17 = l_Parent_0 and l_Parent_0:FindFirstChild("Humanoid");
                        if v17 and v17.Health < v17.MaxHealth and v9.Parent and not l_Parent_0:GetAttribute("ExecutionsDisabled") and l_Parent_0 ~= v5.Rig and tostring(l_Parent_0.Parent) ~= "Killers" and tostring(l_Parent_0.Parent) ~= "Spectating" then
                            v9:Destroy();
                            v1:Play(v5.Config.Sounds.PizzaEaten, {
                                Parent = l_Parent_0.PrimaryPart or v15
                            });
                            local v18 = l_Parent_0.Name == "Elliot";
                            if not v18 then
                                v5:IncrementCharges("RushHour", 1, 1);
                            end;
                            local v19 = -1;
                            for _, v21 in pairs(workspace.Players.Survivors:GetChildren()) do
                                if v21.Name == "Elliot" then
                                    v19 = v19 + 1;
                                end;
                            end;
                            local v22 = 1 + (tonumber(v5.HealingMultiplier) or 0) / 100;
                            local v23 = 1 - math.clamp(v19 * v5.Config.HealingPercentDebuffPerElliot / 100, 0, v5.Config.HealingPercentDebuffCap / 100);
                            local v24 = v5.Config.PizzaHealingAmount * v22 * v23;
                            v17.Health = v17.Health + (v18 and v24 * 0.7 or v24);
                            if l_Parent_0.Name == "007n7" then
                                require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(v5.Player, "ElliotHatesThisGuy");
                            end;
                            require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v5.Player, {
                                Action = "Healed player as Elliot", 
                                RewardType = "Support"
                            });
                        end;
                    end);
                    task.delay(v5.Config.PizzaLifetime, function() --[[ Line: 91 ]]
                        -- upvalues: v9 (copy)
                        v9:Destroy();
                    end);
                    task.delay(v5.Config.PizzaLifetime - 1, function() --[[ Line: 92 ]]
                        -- upvalues: v9 (copy)
                        game.TweenService:Create(v9, TweenInfo.new(1), {
                            Transparency = 1
                        }):Play();
                        for _, v26 in pairs(v9:GetChildren()) do
                            if v26:IsA("BasePart") then
                                game.TweenService:Create(v26, TweenInfo.new(1), {
                                    Transparency = 1
                                }):Play();
                            end;
                        end;
                    end);
                    v5.Rig.Pizza.Transparency = 1;
                    for _, v28 in pairs(v5.Rig.Pizza:GetChildren()) do
                        if v28:IsA("BasePart") then
                            v28.Transparency = 1;
                        end;
                    end;
                end);
                task.delay(2, function() --[[ Line: 107 ]]
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
    }, 
    RushHour = {
        LayoutOrder = 2, 
        KeybindType = "AltAbility2", 
        Icon = "rbxassetid://128250550180598", 
        Charges = 1, 
        Callback = function(v29, _) --[[ Line: 124 ]] --[[ Name: Callback ]]
            -- upvalues: v4 (copy)
            if game["Run Service"]:IsServer() then
                v29:ChangeExpression("Happy", v29.Config.RushHourSpeedDuration);
                v29.AbilitiesDisabled = true;
                v4:ApplyStatus(v29.Player, "Speed", {
                    Level = v29.Config.RushHourSpeedLevel, 
                    Duration = v29.Config.RushHourSpeedDuration
                });
                task.delay(0.1, function() --[[ Line: 134 ]]
                    -- upvalues: v29 (copy)
                    v29.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then

                end;
                return;
            end;
        end
    }
};
v0.ObjectiveProgressed = function(_, v32, _, _, _) --[[ Line: 146 ]] --[[ Name: ObjectiveProgressed ]]
    if not v32.HealingMultiplier then
        v32.HealingMultiplier = 0;
    end;
    v32.HealingMultiplier = math.clamp(v32.HealingMultiplier + v32.Config.HealingPercentAddedOnObjectiveCompletion, 0, v32.Config.HealingPercentCap);
end;
v0.Created = function(_, v37) --[[ Line: 151 ]] --[[ Name: Created ]]
    -- upvalues: v2 (copy)
    if game["Run Service"]:IsClient() and v37.Rig == game.Players.LocalPlayer.Character then
        local function _(v38) --[[ Line: 154 ]] --[[ Name: addSurvivor ]]
            -- upvalues: v37 (copy), v2 (ref)
            local v39 = v38:WaitForChild("Humanoid", 10);
            if v39 and v38 ~= v37.Rig then
                local l_Health_0 = v39.Health;
                do
                    local l_l_Health_0_0 = l_Health_0;
                    v39.HealthChanged:Connect(function(v42) --[[ Line: 158 ]]
                        -- upvalues: v37 (ref), l_l_Health_0_0 (ref), v2 (ref), v38 (copy)
                        if not v37.Rig.Parent then
                            return;
                        else
                            if v42 < l_l_Health_0_0 - v37.Config.InjuredSurvivorDamageMinimum then
                                v2:RevealPlayerAura(v38, v37.Config.InjuredSurvivorAuraDuration);
                            end;
                            l_l_Health_0_0 = v42;
                            return;
                        end;
                    end);
                end;
            end;
        end;
        for _, v45 in pairs(workspace.Players.Survivors:GetChildren()) do
            local v46 = v45:WaitForChild("Humanoid", 10);
            if v46 and v45 ~= v37.Rig then
                local l_Health_1 = v46.Health;
                do
                    local l_l_Health_1_0 = l_Health_1;
                    v46.HealthChanged:Connect(function(v49) --[[ Line: 158 ]]
                        -- upvalues: v37 (copy), l_l_Health_1_0 (ref), v2 (ref), v45 (copy)
                        if not v37.Rig.Parent then
                            return;
                        else
                            if v49 < l_l_Health_1_0 - v37.Config.InjuredSurvivorDamageMinimum then
                                v2:RevealPlayerAura(v45, v37.Config.InjuredSurvivorAuraDuration);
                            end;
                            l_l_Health_1_0 = v49;
                            return;
                        end;
                    end);
                end;
            end;
        end;
        local v50 = nil;
        do
            local l_v50_0 = v50;
            l_v50_0 = workspace.Players.Survivors.ChildAdded:Connect(function(v52) --[[ Line: 169 ]]
                -- upvalues: v37 (copy), v2 (ref), l_v50_0 (ref)
                if v37.Rig.Parent then
                    local v53 = v52:WaitForChild("Humanoid", 10);
                    if v53 and v52 ~= v37.Rig then
                        local l_Health_2 = v53.Health;
                        v53.HealthChanged:Connect(function(v55) --[[ Line: 158 ]]
                            -- upvalues: v37 (ref), l_Health_2 (ref), v2 (ref), v52 (copy)
                            if not v37.Rig.Parent then
                                return;
                            else
                                if v55 < l_Health_2 - v37.Config.InjuredSurvivorDamageMinimum then
                                    v2:RevealPlayerAura(v52, v37.Config.InjuredSurvivorAuraDuration);
                                end;
                                l_Health_2 = v55;
                                return;
                            end;
                        end);
                        return;
                    end;
                else
                    l_v50_0:Disconnect();
                    l_v50_0 = nil;
                end;
            end);
        end;
    end;
end;
return v0;