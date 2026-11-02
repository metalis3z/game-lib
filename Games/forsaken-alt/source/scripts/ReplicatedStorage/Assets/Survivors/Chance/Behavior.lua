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
                task.delay(1.75, function() --[[ Line: 22 ]]
                    -- upvalues: v6 (copy)
                    v6.AbilitiesDisabled = false;
                end);
                task.delay(0.1, function() --[[ Line: 27 ]]
                    -- upvalues: v6 (copy)
                    if not v6.Rig.Parent then
                        return;
                    else
                        v6.Rig.Coin.Transparency = 0;
                        for _, v9 in (v6.Rig.Coin:GetChildren()) do
                            if v9:IsA("Decal") then
                                v9.Transparency = 0;
                            end;
                        end;
                        return;
                    end;
                end);
                task.delay(1.375, function() --[[ Line: 43 ]]
                    -- upvalues: v6 (copy)
                    if not v6.Rig.Parent then
                        return;
                    else
                        v6.Rig.Coin.Transparency = 1;
                        for _, v11 in (v6.Rig.Coin:GetChildren()) do
                            if v11:IsA("Decal") then
                                v11.Transparency = 1;
                            end;
                        end;
                        return;
                    end;
                end);
                local v12 = math.random(1, 2) == 1;
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
                task.delay(1.15, function() --[[ Line: 69 ]]
                    -- upvalues: v12 (copy), v6 (copy), v1 (ref), l_PrimaryPart_0 (copy), v5 (ref), v4 (ref)
                    if v12 then
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
                return v12;
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
        Callback = function(v16, v17) --[[ Line: 115 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v2 (copy), v5 (copy), v3 (copy), v4 (copy)
            if game["Run Service"]:IsServer() then
                v16.AbilitiesDisabled = true;
                v16:ChangeExpression("Gambling");
                task.delay(2.25, function() --[[ Line: 122 ]]
                    -- upvalues: v16 (copy)
                    v16.AbilitiesDisabled = false;
                end);
                task.delay(0.1, function() --[[ Line: 127 ]]
                    -- upvalues: v16 (copy)
                    for _, v19 in pairs(v16.Rig:GetChildren()) do
                        if v19.Name:find("Flintlock") then
                            v19.Transparency = 0;
                        end;
                    end;
                end);
                task.delay(v16.Config.FlintlockHideTime or 1.7, function() --[[ Line: 134 ]]
                    -- upvalues: v16 (copy)
                    for _, v21 in pairs(v16.Rig:GetChildren()) do
                        if v21.Name:find("Flintlock") then
                            v21.Transparency = 1;
                        end;
                    end;
                end);
                local v22 = {
                    explode = 25, 
                    nothing = 25, 
                    shoot = 50
                };
                for _ = 2, tonumber(v16.Charges) or 0 do
                    v22.explode = math.clamp(v22.explode - v16.Config.ShootLessFailureChancePerCharge, 0, 100);
                    v22.nothing = math.clamp(v22.nothing - v16.Config.ShootLessFailureChancePerCharge, 0, 100);
                    v22.shoot = math.clamp(v22.shoot + v16.Config.ShootSuccessChancePerCharge, 0, 100);
                end;
                local v24 = 0;
                for _, v26 in pairs(v22) do
                    v24 = v24 + v26;
                end;
                local v27 = "explode";
                local v28 = 0;
                local v29 = Random.new():NextNumber(0, v24);
                for v30, v31 in pairs(v22) do
                    v28 = v28 + v31;
                    if v29 <= v28 then
                        v27 = v30;
                        break;
                    end;
                end;
                v16.Charges = 0;
                v16:IncrementCharges("Reroll", 0, 0);
                v16:IncrementCharges("Shoot", 0, 0);
                v16:IncrementCharges("HatFix", 0, 0);
                local l_PrimaryPart_1 = v16.Rig.PrimaryPart;
                v1:Play(v16.Config.Sounds.GunWindUpSFX, {
                    Parent = l_PrimaryPart_1, 
                    Volume = 0.1
                });
                task.delay(0.9, function() --[[ Line: 200 ]]
                    -- upvalues: l_PrimaryPart_1 (copy), v27 (ref), v16 (copy), v1 (ref), v2 (ref), v5 (ref), v3 (ref), v4 (ref)
                    if l_PrimaryPart_1.Anchored then
                        return;
                    else
                        if v27 == "explode" then
                            v16:ChangeExpression("Uhoh", 0.4);
                            task.wait(0.4);
                            if l_PrimaryPart_1.Anchored then
                                return;
                            else
                                v1:Play(v16.Config.Sounds.GunExplodeSFX, {
                                    Parent = l_PrimaryPart_1, 
                                    Volume = 0.3
                                });
                                v2:ApplyDamage(v16.Rig, v16.Config.ShootSelfDamage);
                                v16.GunDisabled = true;
                                for _, v34 in pairs(v16.Rig:GetChildren()) do
                                    if v34.Name:find("Flintlock") then
                                        v34.Transparency = 1;
                                    end;
                                end;
                                if v16.Rig.Humanoid.Health <= 0 then
                                    v5:IncrementAchievementProgress(v16.Player, "ChanceDead");
                                end;
                            end;
                        elseif v27 == "nothing" then
                            v16:ChangeExpression("Sad", 1.5);
                        elseif v27 == "shoot" then
                            v16:ChangeExpression("Happy", 1.5);
                            v1:Play(v16.Config.Sounds.GunFireSuccessSFX, {
                                Parent = l_PrimaryPart_1, 
                                Volume = 0.3
                            });
                            local _ = v3:CreateHitbox(v16.Player, {
                                Size = Vector3.new(v16.Config.ShootHitboxSize, v16.Config.ShootHitboxSize, v16.Config.ShootHitboxRange), 
                                CFrameOffset = CFrame.new(0, 0, -v16.Config.ShootHitboxRange / 2), 
                                Damage = v16.Config.ShootDamage, 
                                Time = 0.05, 
                                HitMultiple = true, 
                                Connections = {
                                    Hit = function(v35) --[[ Line: 244 ]] --[[ Name: Hit ]]
                                        -- upvalues: l_PrimaryPart_1 (ref), v16 (ref), v4 (ref), v1 (ref), v5 (ref)
                                        local l_PrimaryPart_2 = v35.PrimaryPart;
                                        if l_PrimaryPart_2 then
                                            local v37 = (l_PrimaryPart_1.Position - l_PrimaryPart_2.Position).Magnitude / v16.Config.ShootHitboxRange;
                                            local function _(v38, v39, v40) --[[ Line: 250 ]] --[[ Name: getValue ]]
                                                return v38 + (v39 - v38) * (1 - math.clamp(v40, 0, 1));
                                            end;
                                            local l_ShootMinKnockback_0 = v16.Config.ShootMinKnockback;
                                            local v43 = l_ShootMinKnockback_0 + (v16.Config.ShootMaxKnockback - l_ShootMinKnockback_0) * (1 - math.clamp(v37, 0, 1));
                                            local l_ShootMinStunDuration_0 = v16.Config.ShootMinStunDuration;
                                            l_ShootMinKnockback_0 = l_ShootMinStunDuration_0 + (v16.Config.ShootMaxStunDuration - l_ShootMinStunDuration_0) * (1 - math.clamp(v37, 0, 1));
                                            l_PrimaryPart_2.Velocity = l_PrimaryPart_1.CFrame.LookVector * v43 * 10;
                                            if l_ShootMinKnockback_0 > 1 then
                                                v4:ApplyStatus(v35, "Stunned", {
                                                    Duration = l_ShootMinKnockback_0
                                                });
                                            end;
                                            v1:Play(v16.Config.Sounds.GunHitSFX, {
                                                Parent = l_PrimaryPart_1, 
                                                Volume = 0.3
                                            });
                                            if tostring(v35.Parent) == "Killers" then
                                                require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v16.Player, {
                                                    Action = "Shot the Killer", 
                                                    RewardType = "Offensive"
                                                });
                                            end;
                                            if v16.TimeSinceLastHeads and tick() <= v16.TimeSinceLastHeads + 10 then
                                                v5:IncrementAchievementProgress(v16.Player, "ChanceReference");
                                            end;
                                        end;
                                    end
                                }
                            });
                        end;
                        if v27 ~= "nothing" then
                            for _, v47 in pairs(v16.Rig:GetDescendants()) do
                                if (v47:IsA("Light") or v47:IsA("ParticleEmitter")) and v47.Parent.Name == "Muzzle" then
                                    task.spawn(function() --[[ Line: 295 ]]
                                        -- upvalues: v47 (copy)
                                        v47.Enabled = true;
                                        task.wait(0.1);
                                        v47.Enabled = false;
                                    end);
                                end;
                            end;
                        end;
                        return;
                    end;
                end);
                return v27;
            else
                if game["Run Service"]:IsClient() then
                    v16.Animations.AimGun:Play();
                    v16.Animations.AimGun:AdjustSpeed(1);
                    local v48 = require(game.ReplicatedStorage.Modules.Network);
                    v48:FireConnection("DisableSprinting", "ShootingGun", true);
                    local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v16.Player, 0.3, "ShootingGun");
                    task.delay(0.9, function() --[[ Line: 321 ]]
                        -- upvalues: v17 (copy), v16 (copy), v2 (ref), v48 (copy), l_v2_SpeedMultiplier_0 (copy)
                        if v17 == "explode" then
                            v16.Animations.AimGun:AdjustSpeed(0);
                            task.wait(0.4);
                            v16.Animations.GunExplode:Play(0);
                            v16.Animations.AimGun:Stop(0);
                            v2:ApplyCameraShake(v16.Config.CameraShakeMagnitude, v16.Config.CameraShakeDuration);
                        elseif v17 == "nothing" then
                            v16.Animations.GunFail:Play(0);
                        elseif v17 == "shoot" then
                            v16.Animations.GunFire:Play(0);
                            v16.Animations.AimGun:Stop(0);
                            v2:ApplyCameraShake(v16.Config.CameraShakeMagnitude, v16.Config.CameraShakeDuration);
                        end;
                        task.delay(1.2, function() --[[ Line: 339 ]]
                            -- upvalues: v48 (ref), l_v2_SpeedMultiplier_0 (ref)
                            v48:FireConnection("DisableSprinting", "ShootingGun", nil);
                            game.TweenService:Create(l_v2_SpeedMultiplier_0, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                Value = 1
                            }):Play();
                            game.Debris:AddItem(l_v2_SpeedMultiplier_0, 1);
                        end);
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
        Callback = function(v50, _) --[[ Line: 356 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy)
            if game["Run Service"]:IsServer() then
                v50.AbilitiesDisabled = true;
                task.delay(2, function() --[[ Line: 362 ]]
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
        Callback = function(v56, _) --[[ Line: 404 ]] --[[ Name: Callback ]]
            -- upvalues: v4 (copy)
            if game["Run Service"]:IsServer() then
                v56.AbilitiesDisabled = true;
                task.delay(2, function() --[[ Line: 410 ]]
                    -- upvalues: v56 (copy)
                    v56.AbilitiesDisabled = false;
                end);
                task.delay(1, function() --[[ Line: 415 ]]
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
v0.Created = function(_, v59) --[[ Line: 435 ]] --[[ Name: Created ]]
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