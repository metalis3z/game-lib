-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
v0.Abilities = {
    Slash = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "MainAbility", 
        Cooldown = function(v5) --[[ Line: 14 ]] --[[ Name: Cooldown ]]
            return v5.Crouching and v5.Config.CrouchSlashCooldown or v5.Config.SlashCooldown;
        end, 
        Callback = function(v6) --[[ Line: 15 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v6.AbilitiesDisabled = true;
                v1:Play(v6.Config.Sounds.Swing, {
                    Parent = v6.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.25
                });
                task.delay(0.2, function() --[[ Line: 22 ]]
                    -- upvalues: v3 (ref), v6 (copy), v2 (ref), v1 (ref)
                    local _ = v3:CreateHitbox(v6.Player, {
                        Size = Vector3.new(3, 6, 4.5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1.75), 
                        Damage = v6.Crouching and v6.Config.CrouchSlashDamage or v6.Config.SlashDamage, 
                        Time = 0.2, 
                        Knockback = 2, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v7, v8) --[[ Line: 33 ]] --[[ Name: Hit ]]
                                -- upvalues: v2 (ref), v1 (ref), v6 (ref)
                                v2:CreateSpeedMultiplier(v7, 1.5, "HitSpeedBonus", 1.25);
                                if v8 then
                                    v1:Play(v6.Config.Sounds.Hit, {
                                        Parent = v6.Rig.PrimaryPart, 
                                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                        Volume = 0.25
                                    });
                                end;
                            end
                        }
                    });
                end);
                task.delay(v6.Crouching and 0.6 or 0.8, function() --[[ Line: 44 ]]
                    -- upvalues: v6 (copy)
                    v6.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v6.Animations[("%*Slash"):format(v6.AnimationType or "")]:Play(0.025);
                end;
                return;
            end;
        end
    }, 
    SweetDreams = {
        LayoutOrder = 2, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "AltAbility1", 
        Cooldown = function(v10) --[[ Line: 59 ]] --[[ Name: Cooldown ]]
            return v10.Crouching and v10.Config.CrouchSweetDreamsCooldown or v10.Config.SweetDreamsCooldown;
        end, 
        Callback = function(v11, v12) --[[ Line: 60 ]] --[[ Name: Callback ]]
            -- upvalues: v4 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v11.AbilitiesDisabled = true;
                v11.Crouching = not v11.Crouching;
                task.spawn(function() --[[ Line: 67 ]]
                    -- upvalues: v11 (copy), v4 (ref)
                    while task.wait(0.4) and v11 and v11.Rig and v11.Rig.Parent and v11.Player and v11.Player.Parent and v11.Crouching do
                        v4:ApplyStatus(v11.Player, "Undetectable", {
                            Duration = 1
                        });
                    end;
                end);
                task.delay(1.25, function() --[[ Line: 74 ]]
                    -- upvalues: v11 (copy)
                    v11.AbilitiesDisabled = false;
                end);
                return v11.Crouching;
            else
                if game["Run Service"]:IsClient() then
                    require(game.ReplicatedStorage.Modules.Network):FireConnection("DisableSprinting", "Crouching", v12);
                    v11.Crouching = v12;
                    local l_Humanoid_0 = v11.Rig:FindFirstChild("Humanoid");
                    if l_Humanoid_0 then
                        game.TweenService:Create(l_Humanoid_0, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                            CameraOffset = Vector3.new(0, v12 and 0 or 1, 0)
                        }):Play();
                    end;
                    if v12 then
                        v11.Animations.CrouchStart:Play(0);
                        v11.Animations.CrouchIdle:Play(0);
                        v11.AnimationType = "Crouch";
                        v11.MovementAnimSpeed = 1;
                        v11.CrouchSlowness = v2:CreateSpeedMultiplier(v11.Player, 1, "Crouching");
                        game.TweenService:Create(v11.CrouchSlowness, TweenInfo.new(0.1), {
                            Value = 0.01
                        }):Play();
                        task.delay(0.8, function() --[[ Line: 109 ]]
                            -- upvalues: v11 (copy)
                            game.TweenService:Create(v11.CrouchSlowness, TweenInfo.new(0.2), {
                                Value = v11.Config.CrouchSpeed / v11.Config.Speed
                            }):Play();
                        end);
                        return;
                    else
                        v11.Animations.CrouchIdle:Stop(0.1);
                        v11.AnimationType = nil;
                        v11.MovementAnimSpeed = nil;
                        if v11.CrouchSlowness then
                            game.TweenService:Create(v11.CrouchSlowness, TweenInfo.new(0.2), {
                                Value = 1
                            }):Play();
                            game.Debris:AddItem(v11.CrouchSlowness, 0.2);
                            v11.CrouchSlowness = nil;
                        end;
                    end;
                end;
                return;
            end;
        end
    }
};
v0.Created = function(_, v15) --[[ Line: 131 ]] --[[ Name: Created ]]
    local v16 = game["Run Service"]:IsClient() and game.Players.LocalPlayer;
    if v16 and v16 == v15.Player then
        local v17 = v15.Rig:WaitForChild("Humanoid", 30);
        if v17 then
            v17.CameraOffset = Vector3.new(0, 1, 0, 0);
        end;
    end;
end;
return v0;