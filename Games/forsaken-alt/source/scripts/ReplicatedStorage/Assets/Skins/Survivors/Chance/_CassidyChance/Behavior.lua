-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
local v5 = require(game.ReplicatedStorage.Modules.AchievementUtil);
v0.Abilities = {
    CoinFlip = {
        LayoutOrder = 1, 
        KeybindType = "AltAbility1", 
        Icon = "rbxassetid://91225744028483", 
        Callback = function(v6, v7) --[[ Line: 15 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v5 (copy), v4 (copy)
            if game["Run Service"]:IsServer() then
                v6.AbilitiesDisabled = true;
                v6:ChangeExpression("Gambling");
                task.delay(1.375, function() --[[ Line: 22 ]]
                    -- upvalues: v6 (copy)
                    v6.AbilitiesDisabled = false;
                end);
                task.delay(0.1, function() --[[ Line: 27 ]]
                    -- upvalues: v6 (copy)
                    if not v6.Rig.Parent then
                        return;
                    else
                        v6.Rig.Coin.Transparency = 0;
                        return;
                    end;
                end);
                task.delay(1.375, function() --[[ Line: 33 ]]
                    -- upvalues: v6 (copy)
                    if not v6.Rig.Parent then
                        return;
                    else
                        v6.Rig.Coin.Transparency = 1;
                        return;
                    end;
                end);
                local v8 = math.random(1, 2) == 1;
                if not v6.Charges then
                    v6.Charges = 0;
                end;
                if not v6.WeaknessLevel then
                    v6.WeaknessLevel = 0;
                end;
                if not v6.HeadsInARow then
                    v6.HeadsInARow = 0;
                end;
                local l_PrimaryPart_0 = v6.Rig.PrimaryPart;
                v1:Play(v6.Config.Sounds.FlipCoinSFX, {
                    Parent = l_PrimaryPart_0
                });
                task.delay(1.15, function() --[[ Line: 49 ]]
                    -- upvalues: v8 (copy), v6 (copy), v1 (ref), l_PrimaryPart_0 (copy), v5 (ref), v4 (ref)
                    if v8 then
                        v6.TimeSinceLastHeads = tick();
                        local l_v6_0 = v6;
                        l_v6_0.HeadsInARow = l_v6_0.HeadsInARow + 1;
                        v6.Charges = math.clamp(v6.Charges + 1, 0, 3);
                        v6:ChangeExpression("Happy", 1.5);
                        v6:IncrementCharges("Reroll", 1, 3);
                        v1:Play(v6.Config.Sounds.FlipCoinHeadsSFX, {
                            Parent = l_PrimaryPart_0
                        });
                        if v6.Charges >= 3 then
                            v6:IncrementCharges("HatFix", 1, 1);
                        end;
                        if not v6.GunDisabled then
                            v6:IncrementCharges("Shoot", 1, 3);
                        end;
                        if v6.HeadsInARow >= 5 then
                            v5:IncrementAchievementProgress(v6.Player, "ChanceTime");
                            return;
                        end;
                    else
                        v6.HeadsInARow = 0;
                        local l_v6_1 = v6;
                        l_v6_1.WeaknessLevel = l_v6_1.WeaknessLevel + 1;
                        v6:ChangeExpression("Sad", 1.5);
                        v4:ApplyStatus(v6.Player, "Weakness", {
                            Level = v6.WeaknessLevel, 
                            Duration = v6.Config.CoinFlipWeaknessDuration
                        });
                        v1:Play(v6.Config.Sounds.FlipCoinTailsSFX, {
                            Parent = l_PrimaryPart_0
                        });
                        if v6.WeaknessLevel >= 50 then
                            v5:IncrementAchievementProgress(v6.Player, "ChanceWeakness");
                        end;
                    end;
                end);
                return v8;
            else
                if game["Run Service"]:IsClient() then
                    if v7 == "SUPERLUCKY" then
                        v6.Animations.FlipCoinHeads:Play(0.05);
                        return;
                    elseif v7 then
                        v6.Animations.FlipCoinHeads:Play(0.05);
                        return;
                    else
                        v6.Animations.FlipCoinTails:Play(0.05);
                    end;
                end;
                return;
            end;
        end
    }, 
    Shoot = {
        LayoutOrder = 2, 
        KeybindType = "AltAbility2", 
        Icon = "rbxassetid://78498256535383", 
        Charges = 0, 
        Callback = function(v12, v13) --[[ Line: 95 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v2 (copy), v5 (copy), v3 (copy), v4 (copy)
            if game["Run Service"]:IsServer() then
                v12.AbilitiesDisabled = true;
                v12:ChangeExpression("Gambling");
                task.delay(3.5, function() --[[ Line: 102 ]]
                    -- upvalues: v12 (copy)
                    v12.AbilitiesDisabled = false;
                end);
                task.delay(3.9, function() --[[ Line: 107 ]]
                    -- upvalues: v12 (copy)
                    for _, v15 in pairs(v12.Rig:GetChildren()) do
                        if v15.Name:find("Flintlock") then
                            v15.Transparency = 0;
                        end;
                    end;
                end);
                task.delay(v12.Config.FlintlockHideTime or 1.7, function() --[[ Line: 114 ]]
                    -- upvalues: v12 (copy)
                    for _, v17 in pairs(v12.Rig:GetChildren()) do
                        if v17.Name:find("Flintlock") then
                            v17.Transparency = 1;
                        end;
                    end;
                end);
                local v18 = {
                    explode = 0, 
                    nothing = 0, 
                    shoot = 100
                };
                for _ = 2, tonumber(v12.Charges) or 0 do
                    v18.explode = math.clamp(v18.explode - v12.Config.ShootLessFailureChancePerCharge, 0, 100);
                    v18.nothing = math.clamp(v18.nothing - v12.Config.ShootLessFailureChancePerCharge, 0, 100);
                    v18.shoot = math.clamp(v18.shoot + v12.Config.ShootSuccessChancePerCharge, 0, 100);
                end;
                local v20 = 0;
                for _, v22 in pairs(v18) do
                    v20 = v20 + v22;
                end;
                local v23 = "explode";
                local v24 = 0;
                local v25 = Random.new():NextNumber(0, v20);
                for v26, v27 in pairs(v18) do
                    v24 = v24 + v27;
                    if v25 <= v24 then
                        v23 = v26;
                        break;
                    end;
                end;
                v12.Charges = 0;
                v12:IncrementCharges("Reroll", 0, 0);
                v12:IncrementCharges("Shoot", 0, 0);
                v12:IncrementCharges("HatFix", 0, 0);
                local l_PrimaryPart_1 = v12.Rig.PrimaryPart;
                v1:Play(v12.Config.Sounds.GunWindUpSFX, {
                    Parent = l_PrimaryPart_1, 
                    Volume = 0.25
                });
                task.delay(0.9, function() --[[ Line: 180 ]]
                    -- upvalues: l_PrimaryPart_1 (copy), v23 (ref), v12 (copy), v1 (ref), v2 (ref), v5 (ref), v3 (ref), v4 (ref)
                    if l_PrimaryPart_1.Anchored then
                        return;
                    else
                        if v23 == "explode" then
                            v12:ChangeExpression("Uhoh", 0.4);
                            task.wait(0.4);
                            if l_PrimaryPart_1.Anchored then
                                return;
                            else
                                v1:Play(v12.Config.Sounds.GunExplodeSFX, {
                                    Parent = l_PrimaryPart_1, 
                                    Volume = 0.35
                                });
                                v2:ApplyDamage(v12.Rig, v12.Config.ShootSelfDamage);
                                v12.GunDisabled = true;
                                for _, v30 in pairs(v12.Rig:GetChildren()) do
                                    if v30.Name:find("Flintlock") then
                                        v30.Transparency = 1;
                                    end;
                                end;
                                if v12.Rig.Humanoid.Health <= 0 then
                                    v5:IncrementAchievementProgress(v12.Player, "ChanceDead");
                                end;
                            end;
                        elseif v23 == "nothing" then
                            v12:ChangeExpression("Sad", 1.5);
                        elseif v23 == "shoot" then
                            task.wait(3);
                            v12:ChangeExpression("Happy", 1.5);
                            v1:Play(v12.Config.Sounds.GunFireSuccessSFX, {
                                Parent = l_PrimaryPart_1, 
                                Volume = 0.4
                            });
                            local _ = v3:CreateHitbox(v12.Player, {
                                Size = Vector3.new(v12.Config.ShootHitboxSize, v12.Config.ShootHitboxSize, v12.Config.ShootHitboxRange), 
                                CFrameOffset = CFrame.new(0, 0, -v12.Config.ShootHitboxRange / 2), 
                                Damage = v12.Config.ShootDamage, 
                                Time = 1.0E-4, 
                                HitMultiple = true, 
                                Connections = {
                                    Hit = function(v31) --[[ Line: 225 ]] --[[ Name: Hit ]]
                                        -- upvalues: l_PrimaryPart_1 (ref), v12 (ref), v4 (ref), v1 (ref), v5 (ref)
                                        local l_PrimaryPart_2 = v31.PrimaryPart;
                                        if l_PrimaryPart_2 then
                                            local v33 = (l_PrimaryPart_1.Position - l_PrimaryPart_2.Position).Magnitude / v12.Config.ShootHitboxRange;
                                            local function _(v34, v35, v36) --[[ Line: 231 ]] --[[ Name: getValue ]]
                                                return v34 + (v35 - v34) * (1 - math.clamp(v36, 0, 1));
                                            end;
                                            local l_ShootMinKnockback_0 = v12.Config.ShootMinKnockback;
                                            local v39 = l_ShootMinKnockback_0 + (v12.Config.ShootMaxKnockback - l_ShootMinKnockback_0) * (1 - math.clamp(v33, 0, 1));
                                            local l_ShootMinStunDuration_0 = v12.Config.ShootMinStunDuration;
                                            l_ShootMinKnockback_0 = l_ShootMinStunDuration_0 + (v12.Config.ShootMaxStunDuration - l_ShootMinStunDuration_0) * (1 - math.clamp(v33, 0, 1));
                                            l_PrimaryPart_2.Velocity = l_PrimaryPart_1.CFrame.LookVector * v39 * 10;
                                            if l_ShootMinKnockback_0 > 1 then
                                                v4:ApplyStatus(v31, "Stunned", {
                                                    Duration = l_ShootMinKnockback_0
                                                });
                                            end;
                                            v1:Play(v12.Config.Sounds.GunHitSFX, {
                                                Parent = l_PrimaryPart_1, 
                                                Volume = 0.1
                                            });
                                            if tostring(v31.Parent) == "Killers" then
                                                require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v12.Player, {
                                                    Action = "Shot the Killer", 
                                                    RewardType = "Offensive"
                                                });
                                            end;
                                            if v12.TimeSinceLastHeads and tick() <= v12.TimeSinceLastHeads + 10 then
                                                v5:IncrementAchievementProgress(v12.Player, "ChanceReference");
                                            end;
                                        end;
                                    end
                                }
                            });
                        end;
                        if v23 ~= "nothing" then
                            for _, v43 in pairs(v12.Rig:GetDescendants()) do
                                if (v43:IsA("Light") or v43:IsA("ParticleEmitter")) and v43.Parent.Name == "Muzzle" then
                                    task.spawn(function() --[[ Line: 276 ]]
                                        -- upvalues: v43 (copy)
                                        v43.Enabled = true;
                                        task.wait(0.1);
                                        v43.Enabled = false;
                                    end);
                                end;
                            end;
                        end;
                        return;
                    end;
                end);
                return v23;
            else
                if game["Run Service"]:IsClient() then
                    v12.Animations.AimGun:Play();
                    v12.Animations.AimGun:AdjustSpeed(0.4);
                    for _, v45 in pairs(v12.Rig:GetDescendants()) do
                        if v45.Name == "RagingPace" then
                            v45.Enabled = true;
                        end;
                    end;
                end;
                local v46 = require(game.ReplicatedStorage.Modules.Network);
                v46:FireConnection("DisableSprinting", "ShootingGun", true);
                local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v12.Player, 0, "ShootingGun");
                task.delay(0.9, function() --[[ Line: 309 ]]
                    -- upvalues: v13 (copy), v12 (copy), v2 (ref), v46 (copy), l_v2_SpeedMultiplier_0 (copy)
                    if v13 == "explode" then
                        v12.Animations.AimGun:AdjustSpeed(0);
                        task.wait(0.4);
                        v12.Animations.GunExplode:Play(0);
                        v12.Animations.AimGun:Stop(0);
                        v2:ApplyCameraShake(v12.Config.CameraShakeMagnitude, v12.Config.CameraShakeDuration);
                    elseif v13 == "nothing" then
                        v12.Animations.GunFail:Play(0);
                    elseif v13 == "shoot" then
                        task.wait(3);
                        v12.Animations.GunFire:Play(0);
                        v12.Animations.AimGun:Stop(0);
                        v2:ApplyCameraShake(v12.Config.CameraShakeMagnitude, v12.Config.CameraShakeDuration);
                    end;
                    for _, v49 in pairs(v12.Rig:GetDescendants()) do
                        if v49.Name == "RagingPace" then
                            v49.Enabled = false;
                        end;
                    end;
                    task.delay(1.2, function() --[[ Line: 334 ]]
                        -- upvalues: v46 (ref), l_v2_SpeedMultiplier_0 (ref)
                        v46:FireConnection("DisableSprinting", "ShootingGun", nil);
                        game.TweenService:Create(l_v2_SpeedMultiplier_0, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                            Value = 1
                        }):Play();
                        game.Debris:AddItem(l_v2_SpeedMultiplier_0, 1);
                    end);
                end);
                return;
            end;
        end
    }, 
    Reroll = {
        LayoutOrder = 3, 
        KeybindType = "AltAbility3", 
        Icon = "rbxassetid://80029151869083", 
        Charges = 0, 
        Callback = function(v50, _) --[[ Line: 349 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy)
            if game["Run Service"]:IsServer() then
                v50.AbilitiesDisabled = true;
                task.delay(0.1, function() --[[ Line: 355 ]]
                    -- upvalues: v50 (copy)
                    v50.AbilitiesDisabled = false;
                end);
                local v52 = 1 + v50.Charges * v50.Config.RandomnessDifferencePerCharge / 100;
                local v53 = math.round((math.random(v50.Config.HealthMin / v52, v50.Config.HealthMax * v52)));
                local l_PrimaryPart_3 = v50.Rig.PrimaryPart;
                v1:Play(v50.Config.Sounds.StatRerollSFX, {
                    Parent = l_PrimaryPart_3, 
                    Volume = 0.25
                });
                v50.Charges = 0;
                v50:IncrementCharges("Reroll", 0, 0);
                v50:IncrementCharges("Shoot", 0, 0);
                v50:IncrementCharges("HatFix", 0, 0);
                v50:ChangeExpression("Gambling", 1.5);
                local v55 = v50.Rig.Humanoid.Health / v50.Rig.Humanoid.MaxHealth;
                v50.Rig.Humanoid.MaxHealth = v53;
                v50.Rig.Humanoid.Health = v53 * v55;
                return v52;
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
        Callback = function(v56, _) --[[ Line: 397 ]] --[[ Name: Callback ]]
            -- upvalues: v4 (copy)
            if game["Run Service"]:IsServer() then
                v56.AbilitiesDisabled = true;
                task.delay(2, function() --[[ Line: 403 ]]
                    -- upvalues: v56 (copy)
                    v56.AbilitiesDisabled = false;
                end);
                task.delay(1, function() --[[ Line: 408 ]]
                    -- upvalues: v56 (copy), v4 (ref)
                    v56.Charges = 0;
                    v56.WeaknessLevel = 0;
                    v56.GunDisabled = nil;
                    v56:IncrementCharges("Reroll", 0, 0);
                    v56:IncrementCharges("Shoot", 0, 0);
                    v56:IncrementCharges("HatFix", 0, 0);
                    v56:ChangeExpression("Gambling", 1.5);
                    v4:RemoveStatus(v56.Player, "Weakness");
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v56.Animations.HatFix:Play();
                end;
                return;
            end;
        end
    }
};
v0.Created = function(_, v59) --[[ Line: 428 ]] --[[ Name: Created ]]
    if game["Run Service"]:IsServer() then
        v59.Rig.Humanoid.MaxHealth = math.random(70, 90);
        v59.Rig.Humanoid.Health = v59.Rig.Humanoid.MaxHealth;
        return;
    else
        if game["Run Service"]:IsClient() then

        end;
        return;
    end;
end;
return v0;