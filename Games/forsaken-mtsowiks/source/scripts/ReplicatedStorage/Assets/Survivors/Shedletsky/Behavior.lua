-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.AchievementUtil);
local v4 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v5 = require(game.ReplicatedStorage.Modules.Statuses);
local v6 = require(game.ReplicatedStorage.Modules.Network);
local function _(v7, v8, v9) --[[ Line: 11 ]] --[[ Name: pcallMethod ]]
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 12 ]]
        -- upvalues: v9 (copy), v7 (copy)
        if v9.Behavior[v7] then
            v9.Behavior[v7](v9);
        end;
    end);
    if not l_status_0 then
        warn((("[%*]: Failed to call .%*() due to: %*"):format(v8, v7, l_result_0)));
    end;
end;
v0.Abilities = {
    Slash = {
        LayoutOrder = 1, 
        KeybindType = "AltAbility1", 
        Icon = "rbxassetid://85282571177550", 
        Callback = function(v13, _) --[[ Line: 28 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v5 (copy), v4 (copy), v6 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v13.AbilitiesDisabled = true;
                task.delay(v13.Config.SlashWindupTime * 3, function() --[[ Line: 34 ]]
                    -- upvalues: v13 (copy)
                    v13.AbilitiesDisabled = false;
                end);
                v13.Behavior:PreSlash(v13);
                v13:ChangeExpression("Concentrating", v13.Config.SlashWindupTime + 0.5);
                v1:Play(v13.Config.Sounds.Unsheath, {
                    Parent = v13.Rig.Sword
                });
                v5:ApplyStatus(v13.Rig, "Resistance", {
                    Level = 2, 
                    Duration = v13.Config.SlashWindupTime
                });
                if not v13.TotalTimesStunned then
                    v13.TotalTimesStunned = 0;
                end;
                task.delay(v13.Config.SlashWindupTime, function() --[[ Line: 49 ]]
                    -- upvalues: v1 (ref), v13 (copy), v4 (ref), v5 (ref)
                    v1:Play(v13.Config.Sounds.Slash, {
                        Parent = v13.Rig.Sword
                    });
                    local _ = v4:CreateHitbox(v13.Player, {
                        Size = Vector3.new(4, 6, 5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -2.25), 
                        Damage = v13.Config.SlashDamage, 
                        Time = 0.25, 
                        Knockback = 5, 
                        HitMultiple = false, 
                        Connections = {
                            Hit = function(v15) --[[ Line: 61 ]] --[[ Name: Hit ]]
                                -- upvalues: v5 (ref), v13 (ref), v1 (ref)
                                v5:ApplyStatus(v15, "Stunned", {
                                    Duration = v13.Config.SlashStunTime
                                });
                                v1:Play(v13.Config.Sounds.Hit, {
                                    Parent = v13.Rig.Sword
                                });
                                v1:PlayVoiceline(v13, "SlashHit", {
                                    Priority = 1
                                });
                                v13:ChangeExpression("StunnedKiller", 4);
                                local v16 = ("%*/Hit"):format(script.Parent);
                                local l_v13_0 = v13;
                                local l_pcall_0 = pcall;
                                local v19 = "SlashHit";
                                local v20;
                                l_pcall_0, v20 = l_pcall_0(function() --[[ Line: 12 ]]
                                    -- upvalues: l_v13_0 (copy), v19 (copy)
                                    if l_v13_0.Behavior[v19] then
                                        l_v13_0.Behavior[v19](l_v13_0);
                                    end;
                                end);
                                if not l_pcall_0 then
                                    warn((("[%*]: Failed to call .SlashHit() due to: %*"):format(v16, v20)));
                                end;
                                v16 = v13;
                                v16.TotalTimesStunned = v16.TotalTimesStunned + 1;
                                if v13.TotalTimesStunned == 3 then
                                    require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(v13.Player, "ShedletskyStunner");
                                end;
                                if tostring(v15.Parent) == "Killers" then
                                    require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v13.Player, {
                                        Action = "Stunned Killer as Shedletsky", 
                                        RewardType = "Offensive"
                                    });
                                end;
                            end
                        }
                    });
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v13.Animations.Slash:Play(0.1);
                    v6:FireConnection("DisableSprinting", "ShedletskySlash", true);
                    local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v13.Rig, 0.25, "StunningKiller");
                    task.delay(v13.Config.SlashWindupTime + 1, function() --[[ Line: 97 ]]
                        -- upvalues: v6 (ref), l_v2_SpeedMultiplier_0 (copy)
                        v6:FireConnection("DisableSprinting", "ShedletskySlash", false);
                        l_v2_SpeedMultiplier_0:Destroy();
                    end);
                end;
                return;
            end;
        end
    }, 
    FriedChicken = {
        LayoutOrder = 2, 
        KeybindType = "AltAbility2", 
        Icon = "rbxassetid://87451970500470", 
        Charges = 2, 
        Callback = function(v23, _) --[[ Line: 112 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v2 (copy), v6 (copy)
            if game["Run Service"]:IsServer() then
                v23.AbilitiesDisabled = true;
                local function v29(v25, v26) --[[ Line: 118 ]] --[[ Name: showChickenRecursive ]]
                    for _, v28 in pairs(v25:GetDescendants()) do
                        if v28.Name:find("Chicken") and (v28:IsA("BasePart") or v28:IsA("Decal")) and not v28:GetAttribute("Ignored") then
                            v28.Transparency = v26;
                        end;
                    end;
                end;
                v29(v23.Rig, 0);
                if v23.Cache.EatChicken then
                    v23.Cache.EatChicken:Play();
                end;
                v1:Play(v23.Config.Sounds.EatFriedChicken, {
                    Parent = v23.Rig.PrimaryPart
                });
                task.delay(2.4, function() --[[ Line: 134 ]]
                    -- upvalues: v23 (copy), v1 (ref)
                    v23:ChangeExpression("Happy");
                    v1:PlayVoiceline(v23, "FriedChickenYum", {
                        Priority = 1
                    });
                    task.wait(1.5);
                    v23:ChangeExpression("Default");
                end);
                local l_Humanoid_0 = v23.Rig:FindFirstChild("Humanoid");
                if not l_Humanoid_0 then
                    return;
                else
                    local l_Health_0 = l_Humanoid_0.Health;
                    local v32 = nil;
                    v32 = l_Humanoid_0.HealthChanged:Connect(function(v33) --[[ Line: 144 ]]
                        -- upvalues: l_Health_0 (copy), v23 (copy), v3 (ref)
                        if (v33 <= 0 or v33 <= l_Health_0 - 10) and v23.Rig:GetAttribute("RecentAttacker") then
                            v3:IncrementAchievementProgress(v23.Player, "ShedletskyYesPapa");
                        end;
                    end);
                    task.delay(v23.Config.FriedChickenHealDelay, function() --[[ Line: 151 ]]
                        -- upvalues: v32 (ref), v23 (copy), v2 (ref)
                        if v32 then
                            v32:Disconnect();
                        end;
                        local l_Humanoid_1 = v23.Rig:FindFirstChild("Humanoid");
                        if not l_Humanoid_1 then
                            return;
                        else
                            if l_Humanoid_1.Health > 0 then
                                v2:Heal(l_Humanoid_1, v23.Config.FriedChickenHealInitialAmount);
                                local v35 = true;
                                local l_Health_1 = l_Humanoid_1.Health;
                                local v37 = nil;
                                v37 = l_Humanoid_1.HealthChanged:Connect(function(v38) --[[ Line: 161 ]]
                                    -- upvalues: l_Health_1 (ref), v35 (ref), v37 (ref)
                                    if v38 <= 0 or v38 <= l_Health_1 - 10 then
                                        v35 = false;
                                        v37:Disconnect();
                                        v37 = nil;
                                    end;
                                    l_Health_1 = v38;
                                end);
                                local v39 = 0;
                                while true do
                                    if v23.Rig.Parent then
                                        local v40 = task.wait();
                                        v39 = v39 + v40;
                                        if not v35 then
                                            return;
                                        elseif not v23.Rig.Parent then
                                            return;
                                        elseif v23.Config.FriedChickenHealOvertimeDuration <= v39 then
                                            return;
                                        else
                                            v2:Heal(l_Humanoid_1, v40 * v23.Config.FriedChickenHealOvertimeAmount / v23.Config.FriedChickenHealOvertimeDuration);
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
                    task.delay(2.75, function() --[[ Line: 186 ]]
                        -- upvalues: v29 (copy), v23 (copy)
                        v29(v23.Rig, 1);
                    end);
                    task.delay(4, function() --[[ Line: 191 ]]
                        -- upvalues: v23 (copy)
                        v23.AbilitiesDisabled = false;
                    end);
                    return;
                end;
            else
                if game["Run Service"]:IsClient() then
                    v23.Animations.EatChicken:Play(0.1);
                    v6:FireConnection("DisableSprinting", "EatFriedChicken", true);
                    local l_v2_SpeedMultiplier_1 = v2:CreateSpeedMultiplier(v23.Rig, 0.25, "EatFriedChicken");
                    task.delay(v23.Config.FriedChickenHealDelay + 1.25, function() --[[ Line: 204 ]]
                        -- upvalues: v6 (ref), l_v2_SpeedMultiplier_1 (copy)
                        v6:FireConnection("DisableSprinting", "EatFriedChicken", false);
                        l_v2_SpeedMultiplier_1:Destroy();
                    end);
                end;
                return;
            end;
        end
    }
};
v0.PreSlash = function(_, v43) --[[ Line: 214 ]] --[[ Name: PreSlash ]]
    for _, v45 in pairs(v43.Rig:GetChildren()) do
        if v45.Name:find("Sword") and not v45:GetAttribute("Ignored") then
            v45.Transparency = 0;
        end;
    end;
    for _, v47 in pairs(v43.Rig.Sword:GetChildren()) do
        if v47:IsA("ParticleEmitter") or v47:IsA("Light") or v47:IsA("Highlight") then
            v47.Enabled = true;
        end;
    end;
    task.delay(v43.Config.SlashWindupTime + 0.3, function() --[[ Line: 226 ]]
        -- upvalues: v43 (copy)
        for _, v49 in pairs(v43.Rig:GetChildren()) do
            if v49.Name:find("Sword") then
                game.TweenService:Create(v49, TweenInfo.new(0.5), {
                    Transparency = 1
                }):Play();
            end;
        end;
        task.wait(0.3);
        local l_Sword_0 = v43.Rig:FindFirstChild("Sword");
        local l_pairs_0 = pairs;
        local v52 = l_Sword_0 and l_Sword_0:GetChildren() or {};
        for _, v54 in l_pairs_0(v52) do
            if v54:IsA("ParticleEmitter") or v54:IsA("Light") or v54:IsA("Highlight") then
                v54.Enabled = false;
            end;
        end;
    end);
end;
return v0;