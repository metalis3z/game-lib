-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
local v5 = require(game.ReplicatedStorage.Modules.Network);
v0.Abilities = {
    Slash = {
        LayoutOrder = 1, 
        KeybindType = "AltAbility1", 
        Icon = "rbxassetid://85282571177550", 
        Callback = function(v6, _) --[[ Line: 15 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v4 (copy), v3 (copy), v5 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v6.AbilitiesDisabled = true;
                task.delay(v6.Config.SlashWindupTime * 3, function() --[[ Line: 21 ]]
                    -- upvalues: v6 (copy)
                    v6.AbilitiesDisabled = false;
                end);
                for _, v9 in pairs(v6.Rig:GetChildren()) do
                    if v9.Name:find("Sword") and not v9:GetAttribute("Ignored") then
                        v9.Transparency = 0;
                    end;
                end;
                for _, v11 in pairs(v6.Rig.Sword:GetChildren()) do
                    if v11:IsA("ParticleEmitter") or v11:IsA("Light") or v11:IsA("Highlight") then
                        v11.Enabled = true;
                    end;
                end;
                task.delay(v6.Config.SlashWindupTime + 0.3, function() --[[ Line: 36 ]]
                    -- upvalues: v6 (copy)
                    for _, v13 in pairs(v6.Rig:GetChildren()) do
                        if v13.Name:find("Sword") then
                            game.TweenService:Create(v13, TweenInfo.new(0.5), {
                                Transparency = 1
                            }):Play();
                        end;
                    end;
                    task.wait(0.3);
                    for _, v15 in pairs(v6.Rig.Sword:GetChildren()) do
                        if v15:IsA("ParticleEmitter") or v15:IsA("Light") or v15:IsA("Highlight") then
                            v15.Enabled = false;
                        end;
                    end;
                end);
                v1:Play(v6.Config.Sounds.Unsheath, {
                    Parent = v6.Rig.Sword
                });
                v4:ApplyStatus(v6.Rig, "Resistance", {
                    Level = 2, 
                    Duration = v6.Config.SlashWindupTime
                });
                if not v6.TotalTimesStunned then
                    v6.TotalTimesStunned = 0;
                end;
                task.delay(v6.Config.SlashWindupTime, function() --[[ Line: 56 ]]
                    -- upvalues: v1 (ref), v6 (copy), v3 (ref), v4 (ref)
                    v1:Play(v6.Config.Sounds.Slash, {
                        Parent = v6.Rig.Sword
                    });
                    local _ = v3:CreateHitbox(v6.Player, {
                        Size = Vector3.new(4, 6, 5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -2.25), 
                        Damage = v6.Config.SlashDamage, 
                        Time = 0.25, 
                        Knockback = 5, 
                        HitMultiple = false, 
                        Connections = {
                            Hit = function(v16) --[[ Line: 68 ]] --[[ Name: Hit ]]
                                -- upvalues: v4 (ref), v6 (ref), v1 (ref)
                                v4:ApplyStatus(v16, "Stunned", {
                                    Duration = v6.Config.SlashStunTime
                                });
                                v1:Play(v6.Config.Sounds.Hit, {
                                    Parent = v6.Rig.Sword
                                });
                                v1:PlayVoiceline(v6, "SlashHit", {
                                    Priority = 1
                                });
                                v6:ChangeExpression("StunnedKiller", 4);
                                local l_v6_0 = v6;
                                l_v6_0.TotalTimesStunned = l_v6_0.TotalTimesStunned + 1;
                                if v6.TotalTimesStunned == 3 then
                                    require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(v6.Player, "ShedletskyStunner");
                                end;
                                if tostring(v16.Parent) == "Killers" then
                                    require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v6.Player, {
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
                    v6.Animations.Slash:Play(0.1);
                    v5:FireConnection("DisableSprinting", "ShedletskySlash", true);
                    local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v6.Rig, 0.25, "StunningKiller");
                    task.delay(v6.Config.SlashWindupTime + 1, function() --[[ Line: 103 ]]
                        -- upvalues: v5 (ref), l_v2_SpeedMultiplier_0 (copy)
                        v5:FireConnection("DisableSprinting", "ShedletskySlash", false);
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
        Callback = function(v20, _) --[[ Line: 118 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v5 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v20.AbilitiesDisabled = true;
                local function v26(v22, v23) --[[ Line: 124 ]] --[[ Name: showChickenRecursive ]]
                    for _, v25 in pairs(v22:GetDescendants()) do
                        if v25.Name:find("Chicken") and (v25:IsA("BasePart") or v25:IsA("Decal")) and not v25:GetAttribute("Ignored") then
                            v25.Transparency = v23;
                        end;
                    end;
                end;
                v26(v20.Rig, 0);
                if v20.Cache.EatChicken then
                    v20.Cache.EatChicken:Play();
                end;
                v1:Play(v20.Config.Sounds.EatFriedChicken, {
                    Parent = v20.Rig.PrimaryPart
                });
                task.delay(v20.Config.FriedChickenHealDelay, function() --[[ Line: 142 ]]
                    -- upvalues: v20 (copy)
                    local l_Humanoid_0 = v20.Rig:FindFirstChild("Humanoid");
                    if not l_Humanoid_0 then
                        return;
                    else
                        if l_Humanoid_0.Health > 0 then
                            l_Humanoid_0.Health = l_Humanoid_0.Health + v20.Config.FriedChickenHealInitialAmount;
                            local v28 = true;
                            local l_Health_0 = l_Humanoid_0.Health;
                            local v30 = nil;
                            v30 = l_Humanoid_0.HealthChanged:Connect(function(v31) --[[ Line: 150 ]]
                                -- upvalues: l_Health_0 (copy), v28 (ref), v30 (ref)
                                if v31 <= 0 or v31 <= l_Health_0 - 10 then
                                    v28 = false;
                                    v30:Disconnect();
                                    v30 = nil;
                                end;
                            end);
                            local v32 = 0;
                            while true do
                                if v20.Rig.Parent then
                                    local v33 = task.wait();
                                    v32 = v32 + v33;
                                    if not v28 then
                                        return;
                                    elseif not v20.Rig.Parent then
                                        return;
                                    elseif v20.Config.FriedChickenHealOvertimeDuration <= v32 then
                                        return;
                                    else
                                        l_Humanoid_0.Health = l_Humanoid_0.Health + v33 * v20.Config.FriedChickenHealOvertimeAmount / v20.Config.FriedChickenHealOvertimeDuration;
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
                task.delay(2.75, function() --[[ Line: 173 ]]
                    -- upvalues: v26 (copy), v20 (copy)
                    v26(v20.Rig, 1);
                end);
                task.delay(4, function() --[[ Line: 178 ]]
                    -- upvalues: v20 (copy)
                    v20.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v20.Animations.EatChicken:Play(0.1);
                    v5:FireConnection("DisableSprinting", "EatFriedChicken", true);
                    local l_v2_SpeedMultiplier_1 = v2:CreateSpeedMultiplier(v20.Rig, 0.25, "EatFriedChicken");
                    task.delay(v20.Config.FriedChickenHealDelay + 1.25, function() --[[ Line: 191 ]]
                        -- upvalues: v5 (ref), l_v2_SpeedMultiplier_1 (copy)
                        v5:FireConnection("DisableSprinting", "EatFriedChicken", false);
                        l_v2_SpeedMultiplier_1:Destroy();
                    end);
                end;
                return;
            end;
        end
    }
};
return v0;