-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
local v5 = require(game.ReplicatedStorage.Modules.AchievementUtil);
local function _(v6) --[[ Line: 14 ]] --[[ Name: __displayWarn ]]
    warn((("[Elliot]: %*"):format(v6)));
end;
local function v13(v8, v9, ...) --[[ Line: 26 ]] --[[ Name: __pcallMethod ]]
    assert(v8, "bad moduleInfo, must be a table");
    local l_status_0, l_result_0 = pcall(function(...) --[[ Line: 29 ]]
        -- upvalues: v8 (copy), v9 (copy)
        if v8[v9] then
            return v8[v9](...);
        else
            return;
        end;
    end, ...);
    if not l_status_0 then
        local v12 = ("Failed to call :%*() due to: %*"):format(v9, l_result_0);
        warn((("[Elliot]: %*"):format(v12)));
    end;
    return l_status_0, l_result_0;
end;
v0.Abilities = {
    ThrowPizza = {
        LayoutOrder = 1, 
        KeybindType = "AltAbility1", 
        Icon = "rbxassetid://93578432067529", 
        Callback = function(v14, _) --[[ Line: 44 ]] --[[ Name: Callback ]]
            -- upvalues: v13 (copy), v1 (copy), v2 (copy), v5 (copy)
            if game["Run Service"]:IsServer() then
                v14:ChangeExpression("SlightlyHappy", 1.75);
                v14.AbilitiesDisabled = true;
                v13(v14.Behavior, "OnThrowPizza", v14.Behavior, v14);
                task.delay(0.4, function() --[[ Line: 52 ]]
                    -- upvalues: v1 (ref), v14 (copy), v2 (ref), v5 (ref), v13 (ref)
                    v1:Play(v14.Config.Sounds.PizzaThrown, {
                        Parent = v14.Rig.PrimaryPart
                    });
                    local v16 = v14.Rig.Pizza:Clone();
                    v16.PizzaJoint:Destroy();
                    v16.CollisionGroup = "Items";
                    v16.CanCollide = true;
                    v16.Parent = workspace.Map.Ingame;
                    v16.AssemblyLinearVelocity = (v14:GetPivot().LookVector + Vector3.new(0, 0.5, 0, 0)) * v14.Config.PizzaThrowForce;
                    v16:SetNetworkOwner(nil);
                    local l_v2_ClosestPlayerFromPosition_0 = v2:GetClosestPlayerFromPosition(v14.Rig.PrimaryPart.Position, {
                        MaxDistance = v14.Config.PizzaPingDistance, 
                        ReturnTable = true
                    });
                    for _, v19 in pairs(l_v2_ClosestPlayerFromPosition_0) do
                        local l_Player_0 = v19.Player;
                        local l_PlayerFromCharacter_0 = game.Players:GetPlayerFromCharacter(l_Player_0);
                        if l_PlayerFromCharacter_0 then
                            v2:RevealPlayerAuraTo(l_PlayerFromCharacter_0, v16, v14.Config.PizzaPingDuration, Color3.new(0.75, 1, 0.75), 100);
                        end;
                    end;
                    local v22 = tick();
                    v2:ApplyUnsafeTouched(v16, false, function(v23, v24) --[[ Line: 77 ]]
                        -- upvalues: v16 (copy), v14 (ref), v22 (copy), v5 (ref), v1 (ref), v2 (ref)
                        local l_Parent_0 = v24.Parent;
                        local v26 = l_Parent_0 and l_Parent_0:FindFirstChild("Humanoid");
                        local v27 = tostring(l_Parent_0.Parent):find("Killer");
                        if v26 and (v26.Health < v26.MaxHealth or v27) and v26.Health > 0 and v16.Parent and l_Parent_0 ~= v14.Rig and l_Parent_0:IsDescendantOf(workspace.Players) then
                            if tostring(l_Parent_0.Parent):find("Killer") then
                                if tick() - v22 < 2 then
                                    v5:IncrementAchievementProgress(v14.Player, "ElliotStupid");
                                end;
                                return;
                            else
                                v23.Disconnect();
                                v16:Destroy();
                                v1:Play(v14.Config.Sounds.PizzaEaten, {
                                    Parent = l_Parent_0.PrimaryPart or v24
                                });
                                if not (l_Parent_0.Name == "Elliot") then
                                    v14:IncrementCharges("RushHour", 1, 1);
                                end;
                                local v28 = require(game.ReplicatedStorage.Modules.AchievementUtil);
                                local v29 = -1;
                                for _, v31 in pairs(workspace.Players.Survivors:GetChildren()) do
                                    if v31.Name == "Elliot" then
                                        v29 = v29 + 1;
                                    end;
                                    if v31 ~= v14.Rig and v31.PrimaryPart and ((v31.PrimaryPart.Position - l_Parent_0.PrimaryPart.Position) * v2.KillerDistanceVector).Magnitude < 23.29 then
                                        local l_Humanoid_0 = v31:FindFirstChild("Humanoid");
                                        if l_Humanoid_0 and l_Humanoid_0.Health / l_Humanoid_0.MaxHealth <= 0.25 and v26.Health / v26.MaxHealth >= 0.7 then
                                            v28:IncrementAchievementProgress(game.Players:GetPlayerFromCharacter(v31), "PizzaSteal");
                                            v28:IncrementAchievementProgress(game.Players:GetPlayerFromCharacter(l_Parent_0), "PizzaSteal");
                                        end;
                                    end;
                                end;
                                if l_Parent_0.Name == "007n7" then
                                    v28:IncrementAchievementProgress(v14.Player, "ElliotHatesThisGuy");
                                end;
                                require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v14.Player, {
                                    Action = "Healed player as Elliot", 
                                    RewardType = "Support"
                                });
                                local v33 = 1 + (tonumber(v14.HealingMultiplier) or 0) / 100;
                                local v34 = 1 - math.clamp(v29 * v14.Config.HealingPercentDebuffPerElliot / 100, 0, v14.Config.HealingPercentDebuffCap / 100);
                                if v26.Health > 0 then
                                    v2:Heal(v26, v14.Config.PizzaHealingAmount);
                                    local v35 = true;
                                    local l_Health_0 = v26.Health;
                                    local v37 = nil;
                                    v37 = v26.HealthChanged:Connect(function(v38) --[[ Line: 140 ]]
                                        -- upvalues: l_Health_0 (copy), v35 (ref), v37 (ref)
                                        if v38 <= 0 or v38 <= l_Health_0 - 10 then
                                            v35 = false;
                                            v37:Disconnect();
                                            v37 = nil;
                                        end;
                                    end);
                                    local v39 = 0;
                                    while true do
                                        if v14.Rig.Parent then
                                            local v40 = task.wait();
                                            v39 = v39 + v40;
                                            if not v35 then
                                                return;
                                            elseif not v14.Rig.Parent then
                                                return;
                                            elseif v14.Config.PizzaHealingProgressivelyTime <= v39 then
                                                return;
                                            else
                                                v2:Heal(v26, v40 * (v14.Config.PizzaHealingProgressively * v33 * v34) / v14.Config.PizzaHealingProgressivelyTime);
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
                    task.delay(v14.Config.PizzaLifetime, function() --[[ Line: 164 ]]
                        -- upvalues: v16 (copy)
                        v16:Destroy();
                    end);
                    task.delay(v14.Config.PizzaLifetime - 1, function() --[[ Line: 165 ]]
                        -- upvalues: v16 (copy)
                        game.TweenService:Create(v16, TweenInfo.new(1), {
                            Transparency = 1
                        }):Play();
                        for _, v42 in pairs(v16:GetChildren()) do
                            if v42:IsA("BasePart") then
                                game.TweenService:Create(v42, TweenInfo.new(1), {
                                    Transparency = 1
                                }):Play();
                            end;
                        end;
                    end);
                    v13(v14.Behavior, "OnThrowPizzaEnd", v14.Behavior, v14);
                end);
                task.delay(2, function() --[[ Line: 179 ]]
                    -- upvalues: v14 (copy)
                    v14.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v14.Animations.ThrowPizza:Play();
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
        Callback = function(v43, _) --[[ Line: 194 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v4 (copy)
            if game["Run Service"]:IsServer() then
                v43:ChangeExpression("Happy", v43.Config.RushHourSpeedDuration);
                v43.AbilitiesDisabled = true;
                if v43.Config.Sounds.RushHourStart then
                    v1:Play(v43.Config.Sounds.RushHourStart, {
                        Parent = v43.Rig.PrimaryPart
                    });
                end;
                v4:ApplyStatus(v43.Player, "Speed", {
                    Level = v43.Config.RushHourSpeedLevel, 
                    Duration = v43.Config.RushHourSpeedDuration, 
                    NoStack = {
                        "HitSpeedBonus"
                    }
                });
                task.delay(0.1, function() --[[ Line: 208 ]]
                    -- upvalues: v43 (copy)
                    v43.AbilitiesDisabled = false;
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
v0.OnThrowPizza = function(_, v46) --[[ Line: 219 ]] --[[ Name: OnThrowPizza ]]
    v46.Rig.Pizza.Transparency = v46.Config.PizzaTransparency or 0;
    for _, v48 in pairs(v46.Rig.Pizza:GetChildren()) do
        if v48:IsA("BasePart") then
            v48.Transparency = 0;
        end;
    end;
end;
v0.OnThrowPizzaEnd = function(_, v50) --[[ Line: 228 ]] --[[ Name: OnThrowPizzaEnd ]]
    v50.Rig.Pizza.Transparency = 1;
    for _, v52 in pairs(v50.Rig.Pizza:GetDescendants()) do
        if v52:IsA("BasePart") then
            v52.Transparency = 1;
        elseif v52:IsA("ParticleEmitter") then
            v52.Enabled = false;
        elseif v52:IsA("Sound") then
            v52:Stop();
        end;
    end;
end;
v0.ObjectiveProgressed = function(_, v54, _, _, _) --[[ Line: 241 ]] --[[ Name: ObjectiveProgressed ]]
    if not v54.HealingMultiplier then
        v54.HealingMultiplier = 0;
    end;
    v54.HealingMultiplier = math.clamp(v54.HealingMultiplier + v54.Config.HealingPercentAddedOnObjectiveCompletion, 0, v54.Config.HealingPercentCap);
end;
v0.Created = function(_, v59) --[[ Line: 246 ]] --[[ Name: Created ]]
    -- upvalues: v2 (copy)
    if game["Run Service"]:IsClient() and v59.Rig == game.Players.LocalPlayer.Character then
        local function _(v60) --[[ Line: 249 ]] --[[ Name: addSurvivor ]]
            -- upvalues: v59 (copy), v2 (ref)
            local v61 = v60:WaitForChild("Humanoid", 10);
            if v61 and v60 ~= v59.Rig then
                local l_Health_1 = v61.Health;
                do
                    local l_l_Health_1_0 = l_Health_1;
                    v61.HealthChanged:Connect(function(v64) --[[ Line: 253 ]]
                        -- upvalues: v59 (ref), l_l_Health_1_0 (ref), v2 (ref), v60 (copy)
                        if not v59.Rig.Parent then
                            return;
                        else
                            if v64 < l_l_Health_1_0 - v59.Config.InjuredSurvivorDamageMinimum then
                                v2:RevealPlayerAura(v60, v59.Config.InjuredSurvivorAuraDuration);
                            end;
                            l_l_Health_1_0 = v64;
                            return;
                        end;
                    end);
                end;
            end;
        end;
        for _, v67 in pairs(workspace.Players.Survivors:GetChildren()) do
            local v68 = v67:WaitForChild("Humanoid", 10);
            if v68 and v67 ~= v59.Rig then
                local l_Health_2 = v68.Health;
                do
                    local l_l_Health_2_0 = l_Health_2;
                    v68.HealthChanged:Connect(function(v71) --[[ Line: 253 ]]
                        -- upvalues: v59 (copy), l_l_Health_2_0 (ref), v2 (ref), v67 (copy)
                        if not v59.Rig.Parent then
                            return;
                        else
                            if v71 < l_l_Health_2_0 - v59.Config.InjuredSurvivorDamageMinimum then
                                v2:RevealPlayerAura(v67, v59.Config.InjuredSurvivorAuraDuration);
                            end;
                            l_l_Health_2_0 = v71;
                            return;
                        end;
                    end);
                end;
            end;
        end;
        local v72 = nil;
        do
            local l_v72_0 = v72;
            l_v72_0 = workspace.Players.Survivors.ChildAdded:Connect(function(v74) --[[ Line: 265 ]]
                -- upvalues: v59 (copy), v2 (ref), l_v72_0 (ref)
                if v59.Rig.Parent then
                    local v75 = v74:WaitForChild("Humanoid", 10);
                    if v75 and v74 ~= v59.Rig then
                        local l_Health_3 = v75.Health;
                        v75.HealthChanged:Connect(function(v77) --[[ Line: 253 ]]
                            -- upvalues: v59 (ref), l_Health_3 (ref), v2 (ref), v74 (copy)
                            if not v59.Rig.Parent then
                                return;
                            else
                                if v77 < l_Health_3 - v59.Config.InjuredSurvivorDamageMinimum then
                                    v2:RevealPlayerAura(v74, v59.Config.InjuredSurvivorAuraDuration);
                                end;
                                l_Health_3 = v77;
                                return;
                            end;
                        end);
                        return;
                    end;
                else
                    l_v72_0:Disconnect();
                    l_v72_0 = nil;
                end;
            end);
        end;
    end;
end;
return v0;