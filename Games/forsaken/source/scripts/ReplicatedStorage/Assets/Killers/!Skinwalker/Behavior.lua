-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.AchievementUtil);
local v4 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v5 = require(game.ReplicatedStorage.Modules.Statuses);
local v6 = require(game.ReplicatedStorage.Modules.Network);
local v7 = {
    "NessShedletsky", 
    "ModernShedletsky", 
    "BloodedgeShedletsky", 
    "BuffShedletsky", 
    "ChefShedletsky", 
    "MamaletskyShedletsky", 
    "MemoriamShedletsky"
};
local function v13(v8, v9, v10) --[[ Line: 13 ]] --[[ Name: pcallMethod ]]
    local v11, v12 = pcall(function() --[[ Line: 14 ]]
        -- upvalues: v10 (copy), v8 (copy)
        if v10.Behavior[v8] then
            v10.Behavior[v8](v10);
        end;
    end);
    if not v11 then
        warn((("[%*]: Failed to call .%*() due to: %*"):format(v9, v8, v12)));
    end;
end;
local function v21(v14) --[[ Line: 26 ]] --[[ Name: inMemoriam ]]
    if game.Players.LocalPlayer.PlayerGui.TemporaryUI:FindFirstChild("InMemoriam") then
        return;
    else
        v14 = v14 or 4;
        local v15 = script.InMemoriam:Clone();
        v15.Shedletsky.ImageTransparency = 1;
        v15.Parent = game.Players.LocalPlayer.PlayerGui.TemporaryUI;
        game.Debris:AddItem(v15, v14);
        for v16, v17 in pairs(game.SoundService:GetChildren()) do
            if v17:IsA("SoundGroup") and v17.Volume > 0 then
                local v18 = v17.Volume;
                v17.Volume = 0;
                v15.AncestryChanged:Connect(function(v19, v20) --[[ Line: 41 ]]
                    -- upvalues: v17 (copy), v18 (copy)
                    if not v20 then
                        v17.Volume = v18;
                    end;
                end);
            end;
        end;
        task.delay(0.5, function() --[[ Line: 49 ]]
            -- upvalues: v15 (copy)
            game.TweenService:Create(v15.Shedletsky, TweenInfo.new(0.75), {
                ImageTransparency = 0
            }):Play();
        end);
        return;
    end;
end;
v0.Created = function(v22, v23) --[[ Line: 54 ]] --[[ Name: Created ]]
    -- upvalues: v6 (copy), v21 (copy)
    if game["Run Service"]:IsClient() and game.Players.LocalPlayer ~= v23.Player then
        v6:SetConnection("RipBozo", "REMOTE_EVENT", function() --[[ Line: 56 ]]
            -- upvalues: v21 (ref)
            v21(5);
        end);
    end;
end;
v0.Abilities = {
    Slash = {
        LayoutOrder = 1, 
        KeybindType = "MainAbility", 
        Icon = "rbxassetid://85282571177550", 
        Callback = function(v24, v25) --[[ Line: 67 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v5 (copy), v4 (copy), v6 (copy)
            if game["Run Service"]:IsServer() then
                v24.AbilitiesDisabled = true;
                task.delay(v24.Config.SlashWindupTime, function() --[[ Line: 73 ]]
                    -- upvalues: v24 (copy)
                    v24.AbilitiesDisabled = false;
                end);
                v24.Behavior:PreSlash(v24);
                v24:ChangeExpression("Concentrating", v24.Config.SlashWindupTime + 0.5);
                v1:Play(v24.Config.Sounds.Unsheath, {
                    Parent = v24.Rig.Sword
                });
                v5:ApplyStatus(v24.Rig, "Resistance", {
                    Level = 2, 
                    Duration = v24.Config.SlashWindupTime
                });
                if not v24.TotalTimesStunned then
                    v24.TotalTimesStunned = 0;
                end;
                task.delay(v24.Config.SlashWindupTime, function() --[[ Line: 88 ]]
                    -- upvalues: v1 (ref), v24 (copy), v4 (ref), v5 (ref), v6 (ref)
                    v1:Play(v24.Config.Sounds.Slash, {
                        Parent = v24.Rig.Sword
                    });
                    local v32 = v4:CreateHitbox(v24.Player, {
                        Size = Vector3.new(4, 6, 5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -2.25), 
                        Damage = v24.Config.SlashDamage, 
                        Time = 0.25, 
                        Knockback = 15, 
                        RagdollOnHit = true, 
                        HitMultiple = false, 
                        Connections = {
                            Hit = function(v26) --[[ Line: 101 ]] --[[ Name: Hit ]]
                                -- upvalues: v5 (ref), v24 (ref), v1 (ref), v6 (ref)
                                v5:ApplyStatus(v26, "Stunned", {
                                    Duration = v24.Config.SlashStunTime
                                });
                                v1:Play(v24.Config.Sounds.Hit, {
                                    Parent = v24.Rig.Sword
                                });
                                v1:PlayVoiceline(v24, "SlashHit", {
                                    Priority = 1
                                });
                                v24:ChangeExpression("StunnedKiller", 4);
                                local v27 = ("%*/Hit"):format(script.Parent);
                                local v28 = v24;
                                local v29 = pcall;
                                local v30 = "SlashHit";
                                local v31;
                                v29, v31 = v29(function() --[[ Line: 14 ]]
                                    -- upvalues: v28 (copy), v30 (copy)
                                    if v28.Behavior[v30] then
                                        v28.Behavior[v30](v28);
                                    end;
                                end);
                                if not v29 then
                                    warn((("[%*]: Failed to call .SlashHit() due to: %*"):format(v27, v31)));
                                end;
                                v27 = v24;
                                v27.TotalTimesStunned = v27.TotalTimesStunned + 1;
                                if v24.TotalTimesStunned == 3 then
                                    require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(v24.Player, "ShedletskyStunner");
                                end;
                                if tostring(v26.Parent) == "Killers" then
                                    require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v24.Player, {
                                        Action = "Stunned Killer as Shedletsky", 
                                        RewardType = "Offensive"
                                    });
                                end;
                                v6:FireClientConnection(game.Players:GetPlayerFromCharacter(v26), "RipBozo", "REMOTE_EVENT");
                            end
                        }
                    });
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v24.Animations.Slash:Play(0.1);
                end;
                return;
            end;
        end
    }, 
    FriedChicken = {
        LayoutOrder = 2, 
        KeybindType = "AltAbility1", 
        Icon = "rbxassetid://87451970500470", 
        Charges = 56, 
        Callback = function(v33, v34) --[[ Line: 153 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v2 (copy), v6 (copy)
            if game["Run Service"]:IsServer() then
                v33.AbilitiesDisabled = true;
                local function v39(v35, v36) --[[ Line: 159 ]] --[[ Name: showChickenRecursive ]]
                    for v37, v38 in pairs(v35:GetDescendants()) do
                        if v38.Name:find("Chicken") and (v38:IsA("BasePart") or v38:IsA("Decal")) and not v38:GetAttribute("Ignored") then
                            v38.Transparency = v36;
                        end;
                    end;
                end;
                v39(v33.Rig, 0);
                if v33.Cache.EatChicken then
                    v33.Cache.EatChicken:Play();
                end;
                v1:Play(v33.Config.Sounds.EatFriedChicken, {
                    Parent = v33.Rig.PrimaryPart
                });
                task.delay(2.4, function() --[[ Line: 175 ]]
                    -- upvalues: v33 (copy), v1 (ref)
                    v33:ChangeExpression("Happy");
                    v1:PlayVoiceline(v33, "FriedChickenYum", {
                        Priority = 1
                    });
                    task.wait(1.5);
                    v33:ChangeExpression("Default");
                end);
                local v40 = v33.Rig:FindFirstChild("Humanoid");
                if not v40 then
                    return;
                else
                    local v41 = v40.Health;
                    local v42 = nil;
                    v42 = v40.HealthChanged:Connect(function(v43) --[[ Line: 185 ]]
                        -- upvalues: v41 (copy), v33 (copy), v3 (ref)
                        if (v43 <= 0 or v43 <= v41 - 10) and v33.Rig:GetAttribute("RecentAttacker") then
                            v3:IncrementAchievementProgress(v33.Player, "ShedletskyYesPapa");
                        end;
                    end);
                    task.delay(v33.Config.FriedChickenHealDelay, function() --[[ Line: 192 ]]
                        -- upvalues: v42 (ref), v33 (copy), v2 (ref)
                        if v42 then
                            v42:Disconnect();
                        end;
                        local v44 = v33.Rig:FindFirstChild("Humanoid");
                        if not v44 then
                            return;
                        else
                            if v44.Health > 0 then
                                v2:Heal(v44, v33.Config.FriedChickenHealInitialAmount);
                                local v45 = true;
                                local v46 = v44.Health;
                                local v47 = nil;
                                v47 = v44.HealthChanged:Connect(function(v48) --[[ Line: 202 ]]
                                    -- upvalues: v46 (ref), v45 (ref), v47 (ref)
                                    if v48 <= 0 or v48 <= v46 - 10 then
                                        v45 = false;
                                        v47:Disconnect();
                                        v47 = nil;
                                    end;
                                    v46 = v48;
                                end);
                                local v49 = 0;
                                while true do
                                    if v33.Rig.Parent then
                                        local v50 = task.wait();
                                        v49 = v49 + v50;
                                        if not v45 then
                                            return;
                                        elseif not v33.Rig.Parent then
                                            return;
                                        elseif v33.Config.FriedChickenHealOvertimeDuration <= v49 then
                                            return;
                                        else
                                            v2:Heal(v44, v50 * v33.Config.FriedChickenHealOvertimeAmount / v33.Config.FriedChickenHealOvertimeDuration);
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
                    task.delay(2.75, function() --[[ Line: 227 ]]
                        -- upvalues: v39 (copy), v33 (copy)
                        v39(v33.Rig, 1);
                    end);
                    task.delay(4, function() --[[ Line: 232 ]]
                        -- upvalues: v33 (copy)
                        v33.AbilitiesDisabled = false;
                    end);
                    return;
                end;
            else
                if game["Run Service"]:IsClient() then
                    v33.Animations.EatChicken:Play(0.1);
                    v6:FireConnection("DisableSprinting", "EatFriedChicken", true);
                    local v51 = v2:CreateSpeedMultiplier(v33.Rig, 0.25, "EatFriedChicken");
                    task.delay(v33.Config.FriedChickenHealDelay + 1.25, function() --[[ Line: 245 ]]
                        -- upvalues: v6 (ref), v51 (copy)
                        v6:FireConnection("DisableSprinting", "EatFriedChicken", false);
                        v51:Destroy();
                    end);
                end;
                return;
            end;
        end
    }, 
    Vanish = {
        LayoutOrder = 3, 
        KeybindType = "AltAbility2", 
        Icon = "rbxassetid://87451970500470", 
        Callback = function(v52, v53) --[[ Line: 258 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v7 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                if v52.Invis then
                    v52.Invis = nil;
                    v1:Play(v52.Config.Sounds.Appear, {
                        Parent = v52.Rig.PrimaryPart
                    });
                    for v54, v55 in ipairs(v52.Rig:GetDescendants()) do
                        if v55:IsA("BasePart") or v55:IsA("Decal") then
                            v55.Transparency = v55:GetAttribute("OGT");
                        elseif v55:IsA("CharacterMesh") or v55:IsA("Hat") or v55:IsA("Shirt") or v55:IsA("Pants") or v55:IsA("Accessory") then
                            v55:Destroy();
                        end;
                    end;
                    local v56 = require(game.ReplicatedStorage.Assets.Skins.Survivors.Shedletsky[v7[math.random(1, #v7)]].Config).Rig;
                    for v57, v58 in ipairs(v56:GetChildren()) do
                        if v58:IsA("CharacterMesh") or v58:IsA("Hat") or v58:IsA("Shirt") or v58:IsA("Pants") or v58:IsA("Accessory") then
                            v58:Clone().Parent = v52.Rig;
                        end;
                    end;
                    v2:CreateSpeedMultiplier(v52.Rig, 1, "Disappear");
                    v52.DisabledAbilities = {};
                    return;
                else
                    v1:Play(v52.Config.Sounds.Disappear, {
                        Parent = v52.Rig.PrimaryPart
                    });
                    v2:CreateSpeedMultiplier(v52.Rig, 3, "Disappear");
                    v52.Invis = true;
                    for v59, v60 in ipairs(v52.Rig:GetDescendants()) do
                        if v60:IsA("BasePart") or v60:IsA("Decal") then
                            v60:SetAttribute("OGT", v60.Transparency);
                            v60.Transparency = 1;
                        end;
                    end;
                    v52.DisabledAbilities = {
                        Slash = true, 
                        FriedChicken = true
                    };
                end;
            end;
        end
    }
};
v0.PreSlash = function(v61, v62) --[[ Line: 298 ]] --[[ Name: PreSlash ]]
    for v63, v64 in pairs(v62.Rig:GetChildren()) do
        if v64.Name:find("Sword") and not v64:GetAttribute("Ignored") then
            v64.Transparency = 0;
        end;
    end;
    for v65, v66 in pairs(v62.Rig.Sword:GetChildren()) do
        if v66:IsA("ParticleEmitter") or v66:IsA("Light") or v66:IsA("Highlight") then
            v66.Enabled = true;
        end;
    end;
    task.delay(v62.Config.SlashWindupTime + 0.3, function() --[[ Line: 310 ]]
        -- upvalues: v62 (copy)
        for v67, v68 in pairs(v62.Rig:GetChildren()) do
            if v68.Name:find("Sword") then
                game.TweenService:Create(v68, TweenInfo.new(0.5), {
                    Transparency = 1
                }):Play();
            end;
        end;
        task.wait(0.3);
        local v69 = v62.Rig:FindFirstChild("Sword");
        local v70 = pairs;
        local v71 = v69 and v69:GetChildren() or {};
        for v72, v73 in v70(v71) do
            if v73:IsA("ParticleEmitter") or v73:IsA("Light") or v73:IsA("Highlight") then
                v73.Enabled = false;
            end;
        end;
    end);
end;
return v0;