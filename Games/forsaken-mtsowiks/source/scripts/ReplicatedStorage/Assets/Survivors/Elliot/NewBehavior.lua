-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = require(game.ReplicatedStorage.GlobalTypes);
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local l_Players_0 = game:GetService("Players");
local v5 = require(l_ReplicatedStorage_0.Modules.Sounds);
local v6 = require(l_ReplicatedStorage_0.Modules.Actors);
local v7 = require(l_ReplicatedStorage_0.Modules.Util);
local _ = require(l_ReplicatedStorage_0.Modules.Hitboxes);
local v9 = require(l_ReplicatedStorage_0.Modules.Statuses);
local v10 = require(l_ReplicatedStorage_0.Modules.AchievementUtil);
local v11 = require(l_ReplicatedStorage_0.Modules.Network);
local v12 = require(l_ReplicatedStorage_0.Modules.Misc.Maid);
local v13 = l_RunService_0:IsStudio();
local v14 = l_RunService_0:IsClient();
local v15 = l_RunService_0:IsServer();
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_Survivors_0 = workspace:WaitForChild("Players").Survivors;
local v18 = TweenInfo.new(1);
local l_defer_0 = task.defer;
local l_delay_0 = task.delay;
local l_wait_0 = task.wait;
local l_insert_0 = table.insert;
local l_clamp_0 = math.clamp;
local l_clock_0 = os.clock;
local function _(v25) --[[ Line: 37 ]] --[[ Name: __displayWarn ]]
    -- upvalues: v13 (copy)
    if v13 then
        warn((("[Elliot]: %*"):format(v25)));
    end;
end;
local function v32(v27, v28, ...) --[[ Line: 51 ]] --[[ Name: __pcallMethod ]]
    -- upvalues: v13 (copy)
    assert(v27, "bad moduleInfo, must be a table");
    local l_status_0, l_result_0 = pcall(function(...) --[[ Line: 54 ]]
        -- upvalues: v27 (copy), v28 (copy)
        if v27[v28] then
            return v27[v28](...);
        else
            return;
        end;
    end, ...);
    if not l_status_0 then
        local v31 = ("Failed to call :%*() due to: %*"):format(v28, l_result_0);
        if v13 then
            warn((("[Elliot]: %*"):format(v31)));
        end;
    end;
    return l_status_0, l_result_0;
end;
local function _(v33, v34) --[[ Line: 69 ]] --[[ Name: __playSoundOnSurvivor ]]
    -- upvalues: v5 (copy)
    local v35 = v33.Config.Sounds[v34];
    if v33.Rig and v33.Rig.Parent and v35 then
        v5:Play(v35, {
            Parent = v33.Rig.PrimaryPart
        });
    end;
end;
return {
    Abilities = {
        ThrowPizza = {
            LayoutOrder = 1, 
            KeybindType = "AltAbility1", 
            Icon = "rbxassetid://93578432067529", 
            Callback = function(v37) --[[ Line: 85 ]] --[[ Name: Callback ]]
                -- upvalues: v15 (copy), v13 (copy), v32 (copy), l_delay_0 (copy), v5 (copy), l_insert_0 (copy), v7 (copy), l_Players_0 (copy), l_clock_0 (copy), v10 (copy), l_Survivors_0 (copy), v6 (copy), l_clamp_0 (copy), l_RunService_0 (copy), l_TweenService_0 (copy), v18 (copy), l_wait_0 (copy), v14 (copy)
                if v15 then
                    if not v37.Rig.Pizza then
                        local _ = v37.Rig;
                        if v13 then
                            warn("[Elliot]: No pizza instance found for");
                        end;
                    end;
                    v37:ChangeExpression("Slightly", 1.75);
                    v37.AbilitiesDisabled = true;
                    v32(v37.Behavior, "OnThrowPizza", v37.Behavior, v37);
                    l_delay_0(0.4, function() --[[ Line: 96 ]]
                        -- upvalues: v37 (copy), v5 (ref), l_insert_0 (ref), v7 (ref), l_Players_0 (ref), l_clock_0 (ref), v10 (ref), l_Survivors_0 (ref), v6 (ref), l_clamp_0 (ref), l_RunService_0 (ref), l_delay_0 (ref), l_TweenService_0 (ref), v18 (ref), l_wait_0 (ref), v32 (ref)
                        local l_v37_0 = v37;
                        local l_PizzaThrown_0 = l_v37_0.Config.Sounds.PizzaThrown;
                        if l_v37_0.Rig and l_v37_0.Rig.Parent and l_PizzaThrown_0 then
                            v5:Play(l_PizzaThrown_0, {
                                Parent = l_v37_0.Rig.PrimaryPart
                            });
                        end;
                        l_v37_0 = v37.Rig.Pizza:Clone();
                        l_v37_0.CanCollide = true;
                        l_v37_0.CollisionGroup = "Items";
                        l_v37_0.PizzaJoint:Destroy();
                        l_v37_0.Parent = workspace.Map.Ingame;
                        l_v37_0:SetNetworkOwner(nil);
                        l_v37_0.AssemblyLinearVelocity = (v37:GetPivot().LookVector + Vector3.new(0, 0.5, 0, 0)) * v37.Config.PizzaThrowForce;
                        l_insert_0(v37.Instances, l_v37_0);
                        for _, v42 in (v7:GetClosestPlayerFromPosition(v37.Rig.PrimaryPart.Position, {
                            MaxDistance = v37.Config.PizzaPingDistance, 
                            ReturnTable = true
                        })) do
                            local l_l_Players_0_PlayerFromCharacter_0 = l_Players_0:GetPlayerFromCharacter(v42.Player);
                            if l_l_Players_0_PlayerFromCharacter_0 then
                                v7:RevealPlayerAuraTo(l_l_Players_0_PlayerFromCharacter_0, l_v37_0, v37.Config.PizzaPingDuration, Color3.new(0.75, 1, 0.75), 100);
                            end;
                        end;
                        local v44 = l_clock_0();
                        v7:ApplyUnsafeTouched(l_v37_0, false, function(v45, v46) --[[ Line: 119 ]]
                            -- upvalues: l_Players_0 (ref), l_v37_0 (copy), v37 (ref), l_clock_0 (ref), v44 (copy), v10 (ref), v5 (ref), l_Survivors_0 (ref), v7 (ref), v6 (ref), l_clamp_0 (ref), l_RunService_0 (ref)
                            local l_Parent_0 = v46.Parent;
                            local v48 = l_Parent_0 and l_Parent_0:FindFirstChild("Humanoid");
                            local l_l_Players_0_PlayerFromCharacter_1 = l_Players_0:GetPlayerFromCharacter(l_Parent_0);
                            local v50 = tostring(l_Parent_0.Parent):find("Killer");
                            local v51 = tostring(l_Parent_0.Parent):find("Spectating");
                            if v48 and (v48.Health < v48.MaxHealth or v50) and v48.Health > 0 and l_v37_0.Parent and not v48:GetAttribute("Clanker") and l_Parent_0 ~= v37.Rig and l_Parent_0:IsDescendantOf(workspace.Players) then
                                if v51 then
                                    l_l_Players_0_PlayerFromCharacter_1:Kick("im sorry man, im just doing my job");
                                    return;
                                elseif v50 then
                                    if l_clock_0() - v44 < 2 then
                                        v10:IncrementAchievementProgress(v37.Player, "ElliotStupid");
                                    end;
                                    return;
                                else
                                    v45.Disconnect();
                                    l_v37_0:Destroy();
                                    if v37.Config.Sounds.PizzaEaten then
                                        v5:Play(v37.Config.Sounds.PizzaEaten, {
                                            Parent = l_Parent_0.PrimaryPart or v46
                                        });
                                    end;
                                    if not (l_Parent_0.Name == "Elliot") then
                                        v37:IncrementCharges("RushHour", 1, 1);
                                    end;
                                    local v52 = -1;
                                    for _, v54 in (l_Survivors_0:GetChildren()) do
                                        if v54.Name == "Elliot" then
                                            v52 = v52 + 1;
                                        end;
                                        if v54 ~= v37.Rig and (v54.PrimaryPart and (v54.PrimaryPart.Position - l_Parent_0.PrimaryPart.Position) * v7.KillerDistanceVector).Magnitude < 23.29 then
                                            local l_Humanoid_0 = v54:FindFirstChild("Humanoid");
                                            if (l_Humanoid_0 and l_Humanoid_0.Health / l_Humanoid_0.MaxHealth) <= 0.25 and l_Humanoid_0.Health / l_Humanoid_0.MaxHealth >= 0.7 then
                                                v10:IncrementAchievementProgress(l_Players_0:GetPlayerFromCharacter(v54), "PizzaSteal");
                                                v10:IncrementAchievementProgress(l_Players_0:GetPlayerFromCharacter(l_Parent_0), "PizzaSteal");
                                            end;
                                        end;
                                    end;
                                    if l_Parent_0.Name == "007n7" then
                                        v10:IncrementAchievementProgress(v37.Player, "ElliotHatesThisGuy");
                                    end;
                                    v6:IncrementActorStats(v37.Player, {
                                        Action = "Healed player as Elliot", 
                                        RewardType = "Support"
                                    });
                                    local v56 = 1 + (tonumber(v37.HealingMultiplier) or 0) / 100;
                                    local v57 = 1 - l_clamp_0(v52 * v37.Config.HealingPercentDebuffPerElliot / 100, 0, v37.Config.HealingPercentDebuffCap / 100);
                                    if v48.Health > 0 then
                                        v7:Heal(v48, v37.Config.PizzaHealingAmount);
                                        local v58 = true;
                                        local l_Health_0 = v48.Health;
                                        local v60 = nil;
                                        do
                                            local l_v58_0, l_v60_0 = v58, v60;
                                            l_v60_0 = v48.HealthChanged:Connect(function(v63) --[[ Line: 195 ]]
                                                -- upvalues: l_Health_0 (copy), l_v58_0 (ref), l_v60_0 (ref)
                                                if v63 <= 0 or v63 <= l_Health_0 - 10 then
                                                    l_v58_0 = false;
                                                    l_v60_0:Disconnect();
                                                end;
                                            end);
                                            v37.Maid:Add(l_v60_0);
                                            local v64 = 0;
                                            local v65 = nil;
                                            v65 = l_RunService_0.Heartbeat:Connect(function(v66) --[[ Line: 204 ]]
                                                -- upvalues: v64 (ref), l_v58_0 (ref), v37 (ref), v65 (ref), v7 (ref), v48 (copy), v56 (copy), v57 (copy)
                                                v64 = v64 + v66;
                                                if not l_v58_0 or not v37.Rig and not v37.Rig.Parent or v64 >= v37.Config.PizzaHealingProgressivelyTime then
                                                    v65:Disconnect();
                                                end;
                                                v7:Heal(v48, v66 * (v37.Config.PizzaHealingProgressively * v56 * v57) / v37.Config.PizzaHealingProgressivelyTime);
                                            end);
                                            v37.Maid:Add(v65);
                                        end;
                                    end;
                                end;
                            end;
                        end, 10);
                        if l_v37_0 then
                            l_delay_0(v37.Config.PizzaLifetime - 1, function() --[[ Line: 219 ]]
                                -- upvalues: l_TweenService_0 (ref), l_v37_0 (copy), v18 (ref), l_wait_0 (ref)
                                l_TweenService_0:Create(l_v37_0, v18, {
                                    Transparency = 1
                                }):Play();
                                for _, v68 in (l_v37_0:GetChildren()) do
                                    if v68:IsA("BasePart") then
                                        l_TweenService_0:Create(v68, v18, {
                                            Transparency = 1
                                        }):Play();
                                    end;
                                end;
                                l_wait_0(1);
                                l_v37_0:Destroy();
                            end);
                        end;
                        v32(v37.Behavior, "OnThrowPizzaEnd", v37.Behavior, v37);
                    end);
                    l_delay_0(2, function() --[[ Line: 246 ]]
                        -- upvalues: v37 (copy)
                        v37.AbilitiesDisabled = false;
                    end);
                    return;
                else
                    if v14 then
                        v37.Animations.ThrowPizza:Play();
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
            Callback = function(v69) --[[ Line: 260 ]] --[[ Name: Callback ]]
                -- upvalues: v15 (copy), v32 (copy), v5 (copy), v9 (copy), l_delay_0 (copy)
                if v15 then
                    v69:ChangeExpression("Happy", v69.Config.RushHourSpeedDuration);
                    v69.AbilitiesDisabled = true;
                    v32(v69.Behavior, "OnRushHour", v69.Behavior, v69);
                    local l_RushHourStart_0 = v69.Config.Sounds.RushHourStart;
                    if v69.Rig and v69.Rig.Parent and l_RushHourStart_0 then
                        v5:Play(l_RushHourStart_0, {
                            Parent = v69.Rig.PrimaryPart
                        });
                    end;
                    v9:ApplyStatus(v69.Player, "Speed", {
                        Level = v69.Config.RushHourSpeedLevel, 
                        Duration = v69.Config.RushHourSpeedDuration, 
                        NoStack = {
                            "HitSpeedBonus"
                        }
                    });
                    l_delay_0(0.1, function() --[[ Line: 276 ]]
                        -- upvalues: v69 (copy)
                        v69.AbilitiesDisabled = false;
                    end);
                end;
            end
        }
    }, 
    OnThrowPizza = function(_, v72) --[[ Line: 287 ]] --[[ Name: OnThrowPizza ]]
        local l_Pizza_0 = v72.Rig.Pizza;
        if not l_Pizza_0 then
            return;
        else
            l_Pizza_0.Transparency = v72.Config.PizzaTransparency or 0;
            for _, v75 in (l_Pizza_0:GetDescendants()) do
                if v75:IsA("BasePart") then
                    v75.Transparency = 0;
                end;
            end;
            return;
        end;
    end, 
    OnThrowPizzaEnd = function(_, v77) --[[ Line: 302 ]] --[[ Name: OnThrowPizzaEnd ]]
        local l_Pizza_1 = v77.Rig.Pizza;
        if not l_Pizza_1 then
            return;
        else
            l_Pizza_1.Transparency = 1;
            for _, v80 in (l_Pizza_1:GetDescendants()) do
                if v80:IsA("BasePart") then
                    v80.Transparency = 1;
                elseif v80:IsA("ParticleEmitter") then
                    v80.Enabled = false;
                elseif v80:IsA("Sound") then
                    v80:Stop();
                end;
            end;
            return;
        end;
    end, 
    ObjectiveProgressed = function(_, v82) --[[ Line: 318 ]] --[[ Name: ObjectiveProgressed ]]
        -- upvalues: l_clamp_0 (copy)
        v82.HealingMultiplier = l_clamp_0(v82.HealingMultiplier or 0 + v82.Config.HealingPercentAddedOnObjectiveCompletion, 0, v82.Config.HealingPercentCap);
    end, 
    Created = function(_, v84) --[[ Line: 322 ]] --[[ Name: Created ]]
        -- upvalues: v12 (copy), v14 (copy), l_LocalPlayer_0 (copy), v13 (copy), v7 (copy), l_Survivors_0 (copy), l_defer_0 (copy)
        v84.Maid = v12.new();
        v84.Meta = {};
        v84.Instances = {};
        v84.State = {};
        v84.NetworkConnections = {};
        v84.ConnectionDictionary = {};
        if v14 and v84.Player == l_LocalPlayer_0 then
            local function v90(v85) --[[ Line: 335 ]] --[[ Name: __onSurvivorAdded ]]
                -- upvalues: v84 (copy), v13 (ref), v7 (ref)
                if v85 == v84.Rig then
                    return;
                else
                    if v13 then
                        warn("[Elliot]: Currently added new survivor to check for highlights!");
                    end;
                    local l_Humanoid_1 = v85:FindFirstChildOfClass("Humanoid");
                    if l_Humanoid_1 then
                        local l_Health_1 = l_Humanoid_1.Health;
                        do
                            local l_l_Health_1_0 = l_Health_1;
                            v84.Maid:Add(l_Humanoid_1.HealthChanged:Connect(function(v89) --[[ Line: 342 ]]
                                -- upvalues: v84 (ref), l_l_Health_1_0 (ref), v7 (ref), v85 (copy)
                                if not v84.Rig or not v84.Rig.Parent then
                                    return;
                                else
                                    if v89 < l_l_Health_1_0 - v84.Config.InjuredSurvivorDamageMinimum then
                                        v7:RevealPlayerAura(v85, v84.Config.InjuredSurvivorAuraDuration);
                                    end;
                                    l_l_Health_1_0 = v89;
                                    return;
                                end;
                            end));
                        end;
                    end;
                    return;
                end;
            end;
            for _, v92 in (l_Survivors_0:GetChildren()) do
                l_defer_0(v90, v92);
            end;
            v84.Maid:Add(l_Survivors_0.ChildAdded:Connect(function(v93) --[[ Line: 355 ]]
                -- upvalues: v84 (copy), l_defer_0 (ref), v90 (copy)
                if v84.Rig and v84.Rig.Parent then
                    l_defer_0(v90, v93);
                end;
            end));
        end;
    end, 
    Destroyed = function(_, v95) --[[ Line: 363 ]] --[[ Name: Destroyed ]]
        -- upvalues: v15 (copy), v13 (copy), v11 (copy)
        v95.Maid:Destroy();
        local v96 = ("%* | Destroyed Maid!"):format(v15 and "SERVER" or "CLIENT");
        if v13 then
            warn((("[Elliot]: %*"):format(v96)));
        end;
        for v97, v98 in v95.ConnectionDictionary do
            local v99 = ("%* | Disconnected connection: %*"):format(v15 and "SERVER" or "CLIENT", v98);
            if v13 then
                warn((("[Elliot]: %*"):format(v99)));
            end;
            v98:Disconnect();
            v95.ConnectionDictionary[v97] = nil;
        end;
        for v100, v101 in v95.NetworkConnections do
            local v102 = ("%* | Disconnected network connection: %*/%*"):format(v15 and "SERVER" or "CLIENT", v101[2], v101[1]);
            if v13 then
                warn((("[Elliot]: %*"):format(v102)));
            end;
            v11:RemoveConnection(v101[1], v101[2]);
            v95.NetworkConnections[v100] = nil;
        end;
        for _, v104 in v95.Instances do
            if typeof(v104) == "table" then
                for _, v106 in v104 do
                    if v106 and v106.Parent then
                        local v107 = ("%* | Removed instance reference: %*"):format(v15 and "SERVER" or "CLIENT", v106);
                        if v13 then
                            warn((("[Elliot]: %*"):format(v107)));
                        end;
                        v106:Destroy();
                    end;
                end;
            else
                v104:Destroy();
            end;
        end;
    end
};