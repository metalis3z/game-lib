-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = {
    InvalidShotArg = "\n\nForsakenCheatKiller 777:\nYou Lose!\n"
};
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local v4 = require(l_ReplicatedStorage_0.Modules.Actors);
local v5 = require(l_ReplicatedStorage_0.Modules.Sounds);
local v6 = require(l_ReplicatedStorage_0.Modules.Util);
local v7 = require(l_ReplicatedStorage_0.Modules.Hitboxes);
local v8 = require(l_ReplicatedStorage_0.Modules.Statuses);
local v9 = require(l_ReplicatedStorage_0.Modules.AchievementUtil);
local v10 = require(l_ReplicatedStorage_0.Modules.Network);
local function _(v11) --[[ Line: 17 ]] --[[ Name: validateVectorUnit ]]
    if v11 ~= v11 then
        return false;
    else
        return v11;
    end;
end;
v0.Created = function(_, v14) --[[ Line: 23 ]] --[[ Name: Created ]]
    -- upvalues: v10 (copy), v1 (copy), v4 (copy)
    if game["Run Service"]:IsServer() then
        v14.Rig.Humanoid.MaxHealth = math.random(70, 90);
        v14.Rig.Humanoid.Health = v14.Rig.Humanoid.MaxHealth;
        v14.ShotBuffer = 0;
        v10:SetConnection(v14.Player.Name .. "ChanceFireShot", "REMOTE_EVENT", function(v15, ...) --[[ Line: 30 ]]
            -- upvalues: v14 (copy), v1 (ref), v4 (ref)
            if v15 ~= v14.Player then
                v15:Kick(v1.InvalidShotArg);
                return;
            else
                local v16 = v4.CurrentActors[v15];
                if v16 and v16.Behavior and v16.Behavior.FireShot then
                    v16.Behavior.FireShot(v16, ...);
                end;
                return;
            end;
        end);
        return;
    else
        if game["Run Service"]:IsClient() then

        end;
        return;
    end;
end;
v0.Destroyed = function(_, v18) --[[ Line: 47 ]] --[[ Name: Destroyed ]]
    -- upvalues: v10 (copy)
    if game["Run Service"]:IsServer() then
        v10:RemoveConnection(v18.Player.Name .. "ChanceFireShot", "REMOTE_EVENT");
    end;
end;
v0.FireShot = function(v19, v20) --[[ Line: 54 ]] --[[ Name: FireShot ]]
    -- upvalues: l_RunService_0 (copy), v1 (copy), v7 (copy), v8 (copy), v5 (copy), l_ReplicatedStorage_0 (copy), v9 (copy)
    assert(l_RunService_0:IsServer() and v19 and v19.Player, "what are you doing");
    local _ = v20 * Vector3.new(1, 0, 1, 0);
    local l_Player_0 = v19.Player;
    if v19 and v19.ShotBuffer and v19.ShotBuffer > 0 and v20 then
        local l_Unit_0 = v20.Unit;
        if l_Unit_0 == l_Unit_0 and l_Unit_0 then
            v19.ShotBuffer = v19.ShotBuffer - 1;
            local l_PrimaryPart_0 = v19.Rig.PrimaryPart;
            l_Unit_0 = 0;
            local _ = v7:CreateHitbox(v19.Player, {
                Size = Vector3.new(v19.Config.ShootHitboxSize, v19.Config.ShootHitboxSize, v19.Config.ShootHitboxRange), 
                CFrameOffset = CFrame.new(0, 0, -v19.Config.ShootHitboxRange / 2), 
                Damage = v19.Config.ShootDamage, 
                Time = 0.005, 
                HitMultiple = true, 
                Connections = {
                    Hit = function(v25) --[[ Line: 83 ]] --[[ Name: Hit ]]
                        -- upvalues: l_PrimaryPart_0 (copy), v19 (copy), v8 (ref), v5 (ref), l_ReplicatedStorage_0 (ref), v9 (ref), l_Unit_0 (ref)
                        local l_PrimaryPart_1 = v25.PrimaryPart;
                        if l_PrimaryPart_1 then
                            local v27 = (l_PrimaryPart_0.Position - l_PrimaryPart_1.Position).Magnitude / v19.Config.ShootHitboxRange;
                            local function _(v28, v29, v30) --[[ Line: 89 ]] --[[ Name: getValue ]]
                                return v28 + (v29 - v28) * (1 - math.clamp(v30, 0, 1));
                            end;
                            local l_ShootMinKnockback_0 = v19.Config.ShootMinKnockback;
                            local v33 = l_ShootMinKnockback_0 + (v19.Config.ShootMaxKnockback - l_ShootMinKnockback_0) * (1 - math.clamp(v27, 0, 1));
                            local l_ShootMinStunDuration_0 = v19.Config.ShootMinStunDuration;
                            l_ShootMinKnockback_0 = l_ShootMinStunDuration_0 + (v19.Config.ShootMaxStunDuration - l_ShootMinStunDuration_0) * (1 - math.clamp(v27, 0, 1));
                            l_PrimaryPart_1.Velocity = l_PrimaryPart_0.CFrame.LookVector * v33 * 10;
                            if l_ShootMinKnockback_0 > 1 then
                                v8:ApplyStatus(v25, "Stunned", {
                                    Duration = l_ShootMinKnockback_0
                                });
                            end;
                            v5:Play(v19.Config.Sounds.GunHitSFX, {
                                Parent = l_PrimaryPart_1, 
                                Volume = 0.3
                            });
                            if tostring(v25.Parent) == "Killers" then
                                require(l_ReplicatedStorage_0.Modules.Actors):IncrementActorStats(v19.Player, {
                                    Action = "Shot the Killer", 
                                    RewardType = "Offensive"
                                });
                            end;
                            if v19.TimeSinceLastHeads and tick() <= v19.TimeSinceLastHeads + 10 then
                                v9:IncrementAchievementProgress(v19.Player, "ChanceReference");
                            end;
                            l_Unit_0 = l_Unit_0 + 1;
                            if l_Unit_0 >= 3 then
                                v9:IncrementAchievementProgress(v19.Player, "ChanceMomGetTheCamera");
                            end;
                        end;
                    end
                }
            });
            return;
        end;
    end;
    l_Player_0:Kick(v1.InvalidShotArg);
end;
v0.Abilities = {
    CoinFlip = {
        LayoutOrder = 1, 
        KeybindType = "AltAbility1", 
        Icon = "rbxassetid://91225744028483", 
        Callback = function(v36, v37) --[[ Line: 139 ]] --[[ Name: Callback ]]
            -- upvalues: v5 (copy), v9 (copy), v8 (copy)
            if game["Run Service"]:IsServer() then
                v36.AbilitiesDisabled = true;
                v36:ChangeExpression("Gambling");
                task.delay(1.75, function() --[[ Line: 146 ]]
                    -- upvalues: v36 (copy)
                    v36.AbilitiesDisabled = false;
                end);
                task.delay(0.1, function() --[[ Line: 151 ]]
                    -- upvalues: v36 (copy)
                    if not v36.Rig.Parent then
                        return;
                    else
                        v36.Rig.Coin.Transparency = 0;
                        for _, v39 in (v36.Rig.Coin:GetChildren()) do
                            if v39:IsA("Decal") then
                                v39.Transparency = 0;
                            end;
                        end;
                        return;
                    end;
                end);
                task.delay(1.375, function() --[[ Line: 167 ]]
                    -- upvalues: v36 (copy)
                    if not v36.Rig.Parent then
                        return;
                    else
                        v36.Rig.Coin.Transparency = 1;
                        for _, v41 in (v36.Rig.Coin:GetChildren()) do
                            if v41:IsA("Decal") then
                                v41.Transparency = 1;
                            end;
                        end;
                        return;
                    end;
                end);
                local v42 = math.random(1, 2) == 1;
                if not v36.Charges then
                    v36.Charges = 0;
                end;
                if not v36.WeaknessLevel then
                    v36.WeaknessLevel = 0;
                end;
                if not v36.HeadsInARow then
                    v36.HeadsInARow = 0;
                end;
                local l_PrimaryPart_2 = v36.Rig.PrimaryPart;
                v5:Play(v36.Config.Sounds.FlipCoinSFX, {
                    Parent = l_PrimaryPart_2
                });
                task.delay(1.15, function() --[[ Line: 193 ]]
                    -- upvalues: v42 (copy), v36 (copy), v5 (ref), l_PrimaryPart_2 (copy), v9 (ref), v8 (ref)
                    if v42 then
                        v36.TimeSinceLastHeads = tick();
                        local l_v36_0 = v36;
                        l_v36_0.HeadsInARow = l_v36_0.HeadsInARow + 1;
                        v36.Charges = math.clamp(v36.Charges + 1, 0, 3);
                        v36:ChangeExpression("Happy", 1.5);
                        v36:IncrementCharges("Reroll", 1, 3);
                        v5:Play(v36.Config.Sounds.FlipCoinHeadsSFX, {
                            Parent = l_PrimaryPart_2
                        });
                        if v36.Charges >= 3 then
                            v36:IncrementCharges("HatFix", 1, 1);
                        end;
                        if not v36.GunDisabled then
                            v36:IncrementCharges("Shoot", 1, 3);
                        end;
                        if v36.HeadsInARow >= 5 then
                            v9:IncrementAchievementProgress(v36.Player, "ChanceTime");
                            return;
                        end;
                    else
                        v36.HeadsInARow = 0;
                        local l_v36_1 = v36;
                        l_v36_1.WeaknessLevel = l_v36_1.WeaknessLevel + 1;
                        v36:ChangeExpression("Sad", 1.5);
                        v8:ApplyStatus(v36.Player, "Weakness", {
                            Level = v36.WeaknessLevel, 
                            Duration = v36.Config.CoinFlipWeaknessDuration
                        });
                        v5:Play(v36.Config.Sounds.FlipCoinTailsSFX, {
                            Parent = l_PrimaryPart_2
                        });
                        if v36.WeaknessLevel >= 50 then
                            v9:IncrementAchievementProgress(v36.Player, "ChanceWeakness");
                        end;
                    end;
                end);
                return v42;
            else
                if game["Run Service"]:IsClient() then
                    if v37 == "SUPERLUCKY" then
                        v36.Animations.FlipCoinHeads:Play(0.05);
                        return;
                    elseif v37 then
                        v36.Animations.FlipCoinHeads:Play(0.05);
                        return;
                    else
                        v36.Animations.FlipCoinTails:Play(0.05);
                    end;
                end;
                return;
            end;
        end
    }, 
    Shoot = {
        Name = "One Shot", 
        LayoutOrder = 2, 
        KeybindType = "AltAbility2", 
        Icon = "rbxassetid://78498256535383", 
        Charges = 0, 
        Callback = function(v46, v47) --[[ Line: 240 ]] --[[ Name: Callback ]]
            -- upvalues: v5 (copy), v6 (copy), v9 (copy), v10 (copy)
            if game["Run Service"]:IsServer() then
                v46.AbilitiesDisabled = true;
                v46:ChangeExpression("Gambling");
                task.delay(2.25, function() --[[ Line: 247 ]]
                    -- upvalues: v46 (copy)
                    v46.AbilitiesDisabled = false;
                end);
                task.delay(0.1, function() --[[ Line: 252 ]]
                    -- upvalues: v46 (copy)
                    for _, v49 in pairs(v46.Rig:GetDescendants()) do
                        if v49:IsA("BasePart") and v49.Name:find("Flintlock") then
                            v49.Transparency = 0;
                        end;
                    end;
                end);
                task.delay(v46.Config.FlintlockHideTime or 1.7, function() --[[ Line: 261 ]]
                    -- upvalues: v46 (copy)
                    for _, v51 in pairs(v46.Rig:GetDescendants()) do
                        if v51:IsA("BasePart") and v51.Name:find("Flintlock") then
                            v51.Transparency = 1;
                        end;
                    end;
                end);
                local v52 = {
                    explode = 25, 
                    nothing = 25, 
                    shoot = 50
                };
                for _ = 2, tonumber(v46.Charges) or 0 do
                    v52.explode = math.clamp(v52.explode - v46.Config.ShootLessFailureChancePerCharge, 0, 100);
                    v52.nothing = math.clamp(v52.nothing - v46.Config.ShootLessFailureChancePerCharge, 0, 100);
                    v52.shoot = math.clamp(v52.shoot + v46.Config.ShootSuccessChancePerCharge, 0, 100);
                end;
                local v54 = 0;
                for _, v56 in pairs(v52) do
                    v54 = v54 + v56;
                end;
                local v57 = "explode";
                local v58 = 0;
                local v59 = Random.new():NextNumber(0, v54);
                for v60, v61 in pairs(v52) do
                    v58 = v58 + v61;
                    if v59 <= v58 then
                        v57 = v60;
                        break;
                    end;
                end;
                v46.Charges = 0;
                v46:IncrementCharges("Reroll", 0, 0);
                v46:IncrementCharges("Shoot", 0, 0);
                v46:IncrementCharges("HatFix", 0, 0);
                local l_PrimaryPart_3 = v46.Rig.PrimaryPart;
                v5:Play(v46.Config.Sounds.GunWindUpSFX, {
                    Parent = l_PrimaryPart_3, 
                    Volume = 0.1
                });
                if v57 == "shoot" then
                    v46.ShotBuffer = v46.ShotBuffer + 1;
                end;
                task.delay(0.9, function() --[[ Line: 333 ]]
                    -- upvalues: l_PrimaryPart_3 (copy), v57 (ref), v46 (copy), v5 (ref), v6 (ref), v9 (ref)
                    if l_PrimaryPart_3.Anchored then
                        return;
                    else
                        if v57 == "explode" then
                            v46:ChangeExpression("Uhoh", 0.4);
                            task.wait(0.4);
                            if l_PrimaryPart_3.Anchored then
                                return;
                            else
                                v5:Play(v46.Config.Sounds.GunExplodeSFX, {
                                    Parent = l_PrimaryPart_3, 
                                    Volume = 0.3
                                });
                                v6:ApplyDamage(v46.Rig, v46.Config.ShootSelfDamage);
                                v46.GunDisabled = true;
                                for _, v64 in pairs(v46.Rig:GetDescendants()) do
                                    if v64:IsA("BasePart") and v64.Name:find("Flintlock") then
                                        v64.Transparency = 1;
                                    end;
                                end;
                                if v46.Rig.Humanoid.Health <= 0 then
                                    v9:IncrementAchievementProgress(v46.Player, "ChanceDead");
                                end;
                            end;
                        elseif v57 == "nothing" then
                            v46:ChangeExpression("Sad", 1.5);
                        elseif v57 == "shoot" then
                            v46:ChangeExpression("Happy", 1.5);
                            v5:Play(v46.Config.Sounds.GunFireSuccessSFX, {
                                Parent = l_PrimaryPart_3, 
                                Volume = 0.3
                            });
                        end;
                        if v57 ~= "nothing" then
                            for _, v66 in pairs(v46.Rig:GetDescendants()) do
                                if (v66:IsA("Light") or v66:IsA("ParticleEmitter")) and v66.Parent.Name == "Muzzle" then
                                    task.spawn(function() --[[ Line: 374 ]]
                                        -- upvalues: v66 (copy)
                                        v66.Enabled = true;
                                        task.wait(0.1);
                                        v66.Enabled = false;
                                    end);
                                end;
                            end;
                        end;
                        return;
                    end;
                end);
                return {
                    Outcome = v57
                };
            else
                if game["Run Service"]:IsClient() then
                    local l_Outcome_0 = v47.Outcome;
                    local _ = v47.Sent;
                    v46.Animations.AimGun:Play();
                    v46.Animations.AimGun:AdjustSpeed(1);
                    v10:FireConnection("DisableSprinting", "ShootingGun", true);
                    local l_v6_SpeedMultiplier_0 = v6:CreateSpeedMultiplier(v46.Player, 0.3, "ShootingGun");
                    task.delay(0.9, function() --[[ Line: 402 ]]
                        -- upvalues: v10 (ref), l_v6_SpeedMultiplier_0 (copy), l_Outcome_0 (copy), v46 (copy), v6 (ref)
                        task.delay(1.2, function() --[[ Line: 404 ]]
                            -- upvalues: v10 (ref), l_v6_SpeedMultiplier_0 (ref)
                            v10:FireConnection("DisableSprinting", "ShootingGun", nil);
                            game.TweenService:Create(l_v6_SpeedMultiplier_0, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                Value = 1
                            }):Play();
                            game.Debris:AddItem(l_v6_SpeedMultiplier_0, 1);
                        end);
                        if l_Outcome_0 == "explode" then
                            v46.Animations.AimGun:AdjustSpeed(0);
                            task.wait(0.4);
                            v46.Animations.GunExplode:Play(0);
                            v46.Animations.AimGun:Stop(0);
                            v6:ApplyCameraShake(v46.Config.CameraShakeMagnitude, v46.Config.CameraShakeDuration);
                            return;
                        elseif l_Outcome_0 == "nothing" then
                            v46.Animations.GunFail:Play(0);
                            return;
                        else
                            if l_Outcome_0 == "shoot" then
                                v46.Animations.GunFire:Play(0);
                                v46.Animations.AimGun:Stop(0);
                                v6:ApplyCameraShake(v46.Config.CameraShakeMagnitude, v46.Config.CameraShakeDuration);
                                v10:FireServerConnection(v46.Player.Name .. "ChanceFireShot", "REMOTE_EVENT", v46.Rig.PrimaryPart.CFrame.LookVector);
                            end;
                            return;
                        end;
                    end);
                end;
                return;
            end;
        end
    }, 
    Reroll = {
        LayoutOrder = 3, 
        KeybindType = "AltAbility3", 
        Icon = "rbxassetid://80029151869083", 
        Charges = 0, 
        Callback = function(v70, _) --[[ Line: 439 ]] --[[ Name: Callback ]]
            -- upvalues: v5 (copy)
            if game["Run Service"]:IsServer() then
                v70.AbilitiesDisabled = true;
                task.delay(2, function() --[[ Line: 445 ]]
                    -- upvalues: v70 (copy)
                    v70.AbilitiesDisabled = false;
                end);
                local v72 = 1 + v70.Charges * v70.Config.RandomnessDifferencePerCharge / 100;
                local v73 = math.round((math.random(v70.Config.HealthMin / v72, v70.Config.HealthMax * v72)));
                local l_PrimaryPart_4 = v70.Rig.PrimaryPart;
                v5:Play(v70.Config.Sounds.StatRerollSFX, {
                    Parent = l_PrimaryPart_4, 
                    Volume = 0.25
                });
                v70.Charges = 0;
                v70:IncrementCharges("Reroll", 0, 0);
                v70:IncrementCharges("Shoot", 0, 0);
                v70:IncrementCharges("HatFix", 0, 0);
                v70:ChangeExpression("Gambling", 1.5);
                local v75 = v70.Rig.Humanoid.Health / v70.Rig.Humanoid.MaxHealth;
                v70.Rig.Humanoid.MaxHealth = v73;
                v70.Rig.Humanoid.Health = v73 * v75;
                return v72;
            else
                if game["Run Service"]:IsClient() then

                end;
                return;
            end;
        end
    }, 
    HatFix = {
        LayoutOrder = 4, 
        KeybindType = "AltAbility4", 
        Icon = "rbxassetid://93434599531478", 
        Charges = 0, 
        Callback = function(v76, _) --[[ Line: 487 ]] --[[ Name: Callback ]]
            -- upvalues: v8 (copy)
            if game["Run Service"]:IsServer() then
                v76.AbilitiesDisabled = true;
                task.delay(2, function() --[[ Line: 493 ]]
                    -- upvalues: v76 (copy)
                    v76.AbilitiesDisabled = false;
                end);
                task.delay(1, function() --[[ Line: 498 ]]
                    -- upvalues: v76 (copy), v8 (ref)
                    v76.Charges = 0;
                    v76.WeaknessLevel = 0;
                    v76.GunDisabled = nil;
                    v76:IncrementCharges("Reroll", 0, 0);
                    v76:IncrementCharges("Shoot", 0, 0);
                    v76:IncrementCharges("HatFix", 0, 0);
                    v76:ChangeExpression("Gambling", 1.5);
                    v8:RemoveStatus(v76.Player, "Weakness");
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v76.Animations.HatFix:Play();
                end;
                return;
            end;
        end
    }
};
return v0;