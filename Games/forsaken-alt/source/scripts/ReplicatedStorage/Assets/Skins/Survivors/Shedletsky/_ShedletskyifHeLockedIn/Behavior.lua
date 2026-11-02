-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
v0.Abilities = {
    Slash = {
        LayoutOrder = 1, 
        KeybindType = "AltAbility1", 
        Icon = "rbxassetid://9559379722", 
        Callback = function(v5, _) --[[ Line: 14 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v4 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v5.AbilitiesDisabled = true;
                v5.Rig.Sword.Transparency = 0;
                v5.Rig.Sword.Build.Layer1.Enabled = true;
                v5.Rig.Sword.Build.Layer2.Enabled = true;
                v5.Rig.Sword.Build.Layer3.Enabled = true;
                v5.Rig.HumanoidRootPart.Ground.Swish.Enabled = true;
                task.delay(v5.Config.SlashWindupTime + 0.3, function() --[[ Line: 25 ]]
                    -- upvalues: v5 (copy)
                    game.TweenService:Create(v5.Rig.Sword, TweenInfo.new(0.5), {
                        Transparency = 1
                    }):Play();
                end);
                v1:Play(v5.Config.Sounds.Unsheath, {
                    Parent = v5.Rig.Sword, 
                    TimePosition = 0.09
                });
                task.delay(v5.Config.SlashWindupTime, function() --[[ Line: 33 ]]
                    -- upvalues: v5 (copy), v3 (ref), v4 (ref), v1 (ref)
                    v5.Rig.HumanoidRootPart.Impact.Layer1.Enabled = true;
                    v5.Rig.HumanoidRootPart.Impact.Layer2.Enabled = true;
                    v5.Rig.HumanoidRootPart.Impact.Layer3.Enabled = true;
                    v5.Rig.HumanoidRootPart.Impact.Layer3.Enabled = true;
                    task.delay(0.8, function() --[[ Line: 38 ]]
                        -- upvalues: v5 (ref)
                        v5.Rig.HumanoidRootPart.Ground.Swish.Enabled = false;
                        v5.Rig.HumanoidRootPart.Impact.Layer1.Enabled = false;
                        v5.Rig.HumanoidRootPart.Impact.Layer2.Enabled = false;
                        v5.Rig.HumanoidRootPart.Impact.Layer3.Enabled = false;
                        v5.Rig.HumanoidRootPart.Impact.Layer3.Enabled = false;
                        v5.Rig.Sword.Build.Layer1.Enabled = false;
                        v5.Rig.Sword.Build.Layer2.Enabled = false;
                        v5.Rig.Sword.Build.Layer3.Enabled = false;
                    end);
                    local _ = v3:CreateHitbox(v5.Player, {
                        Size = Vector3.new(10, 30, 50, 0), 
                        CFrameOffset = CFrame.new(0, 0, -25), 
                        Damage = v5.Config.SlashDamage, 
                        Time = 0.25, 
                        Knockback = 50, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v7) --[[ Line: 58 ]] --[[ Name: Hit ]]
                                -- upvalues: v4 (ref), v5 (ref), v1 (ref)
                                v4:ApplyStatus(v7, "Stunned", {
                                    Duration = v5.Config.SlashStunTime
                                });
                                v1:Play(v5.Config.Sounds.Hit, {
                                    Parent = v5.Rig.Sword
                                });
                                v5:ChangeExpression("StunnedKiller", 4);
                            end
                        }
                    });
                end);
                task.delay(v5.Config.SlashWindupTime * 3, function() --[[ Line: 68 ]]
                    -- upvalues: v5 (copy)
                    v5.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v5.Animations.Slash:Play(0.1);
                    local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v5.Rig, 0.001, "StunningKiller");
                    game.Debris:AddItem(l_v2_SpeedMultiplier_0, v5.Config.SlashWindupTime + 0.75);
                end;
                return;
            end;
        end
    }
};
return v0;