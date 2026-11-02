-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
v0.Abilities = {
    Bite = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://115233777642994", 
        KeybindType = "MainAbility", 
        Cooldown = 2, 
        Callback = function(v5) --[[ Line: 15 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v5.AbilitiesDisabled = true;
                v1:Play(v5.Config.Sounds.Bite, {
                    Parent = v5.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.25
                });
                task.delay(0.1, function() --[[ Line: 22 ]]
                    -- upvalues: v3 (ref), v5 (copy), v2 (ref)
                    local _ = v3:CreateHitbox(v5.Player, {
                        Size = Vector3.new(4.5, 6, 5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1.5), 
                        Damage = v5.Config.AttackDamage, 
                        Time = 0.3, 
                        Knockback = 2, 
                        HitMultiple = false, 
                        ExecuteOnKill = true, 
                        Connections = {
                            Hit = function(v6) --[[ Line: 34 ]] --[[ Name: Hit ]]
                                -- upvalues: v2 (ref)
                                v2:CreateSpeedMultiplier(v6, 1.5, "HitSpeedBonus", 1.25);
                            end
                        }
                    });
                end);
                task.delay(0.75, function() --[[ Line: 42 ]]
                    -- upvalues: v5 (copy)
                    v5.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v5.Animations.Bite:Play(0.025);
                end;
                return;
            end;
        end
    }, 
    GubbyBlast = {
        LayoutOrder = 2, 
        KeybindType = "AltAbility2", 
        Icon = "rbxassetid://71911800582519", 
        Cooldown = 15, 
        Callback = function(v8) --[[ Line: 59 ]] --[[ Name: Callback ]]
            -- upvalues: v3 (copy), v4 (copy), v2 (copy), v1 (copy)
            if game["Run Service"]:IsServer() then
                v8.AbilitiesDisabled = true;
                task.delay(2.25, function() --[[ Line: 65 ]]
                    -- upvalues: v8 (copy)
                    v8.AbilitiesDisabled = false;
                end);
                task.delay(0.1, function() --[[ Line: 70 ]]
                    -- upvalues: v8 (copy)
                    for _, v10 in pairs(v8.Rig:GetChildren()) do
                        if v10.Name:find("gun") then
                            v10.Transparency = 0;
                        end;
                    end;
                end);
                task.delay(1.7, function() --[[ Line: 77 ]]
                    -- upvalues: v8 (copy)
                    for _, v12 in pairs(v8.Rig:GetChildren()) do
                        if v12.Name:find("gun") then
                            v12.Transparency = 1;
                        end;
                    end;
                end);
                local l_PrimaryPart_0 = v8.Rig.PrimaryPart;
                task.delay(0.9, function() --[[ Line: 87 ]]
                    -- upvalues: l_PrimaryPart_0 (copy), v3 (ref), v8 (copy), v4 (ref)
                    if l_PrimaryPart_0.Anchored then
                        return;
                    else
                        local _ = v3:CreateHitbox(v8.Player, {
                            Size = Vector3.new(v8.Config.ShootHitboxSize, v8.Config.ShootHitboxSize, v8.Config.ShootHitboxRange), 
                            CFrameOffset = CFrame.new(0, 0, -v8.Config.ShootHitboxRange / 2), 
                            Damage = 90, 
                            Time = 0.05, 
                            HitMultiple = true, 
                            Connections = {
                                Hit = function(v14) --[[ Line: 100 ]] --[[ Name: Hit ]]
                                    -- upvalues: l_PrimaryPart_0 (ref), v8 (ref), v4 (ref)
                                    local l_PrimaryPart_1 = v14.PrimaryPart;
                                    if l_PrimaryPart_1 then
                                        local v16 = (l_PrimaryPart_0.Position - l_PrimaryPart_1.Position).Magnitude / v8.Config.ShootHitboxRange;
                                        local function _(v17, v18, v19) --[[ Line: 106 ]] --[[ Name: getValue ]]
                                            return v17 + (v18 - v17) * (1 - math.clamp(v19, 0, 1));
                                        end;
                                        local v21 = 5 + 20 * (1 - math.clamp(v16, 0, 1));
                                        local v22 = 1 + 4 * (1 - math.clamp(v16, 0, 1));
                                        l_PrimaryPart_1.Velocity = l_PrimaryPart_0.CFrame.LookVector * v21 * 10;
                                        if v22 > 1 then
                                            v4:ApplyStatus(v14, "Stunned", {
                                                Duration = v22
                                            });
                                        end;
                                    end;
                                end
                            }
                        });
                        return;
                    end;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v8.Animations.GunShoot:Play();
                    v8.Animations.GunShoot:AdjustSpeed(1);
                    local v24 = require(game.ReplicatedStorage.Modules.Network);
                    v24:FireConnection("DisableSprinting", "ShootingGun", true);
                    local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v8.Player, 0.3, "ShootingGun");
                    task.delay(0.9, function() --[[ Line: 136 ]]
                        -- upvalues: v1 (ref), v8 (copy), v2 (ref), v24 (copy), l_v2_SpeedMultiplier_0 (copy)
                        v1:Play(v8.Config.Sounds.GunShoot, {
                            Parent = v8.Rig.PrimaryPart, 
                            PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                            Volume = 0.25
                        });
                        v2:ApplyCameraShake(v8.Config.CameraShakeMagnitude, v8.Config.CameraShakeDuration);
                        task.delay(1.25, function() --[[ Line: 141 ]]
                            -- upvalues: v24 (ref), l_v2_SpeedMultiplier_0 (ref)
                            v24:FireConnection("DisableSprinting", "ShootingGun", nil);
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
    }
};
return v0;