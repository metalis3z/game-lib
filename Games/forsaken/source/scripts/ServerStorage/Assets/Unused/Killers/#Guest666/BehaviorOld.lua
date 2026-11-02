-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
v0.Abilities = {
    ["Carving Slash"] = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "MainAbility", 
        Cooldown = 2, 
        Callback = function(v5) --[[ Line: 15 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v5.AbilitiesDisabled = true;
                task.delay(0.4, function() --[[ Line: 19 ]]
                    -- upvalues: v1 (ref), v5 (copy)
                    v1:Play(v5.Config.Sounds.Swing, {
                        Parent = v5.Rig.PrimaryPart, 
                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                        Volume = 0.25
                    });
                end);
                task.delay(0.35, function() --[[ Line: 23 ]]
                    -- upvalues: v3 (ref), v5 (copy), v2 (ref), v1 (ref)
                    local _ = v3:CreateHitbox(v5.Player, {
                        Size = Vector3.new(6, 10, 10, 0), 
                        CFrameOffset = CFrame.new(0, 0, -8.25), 
                        Damage = v5.Config.SlashDamage, 
                        Time = 0.4, 
                        Knockback = 2, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v6, v7) --[[ Line: 34 ]] --[[ Name: Hit ]]
                                -- upvalues: v2 (ref), v1 (ref), v5 (ref)
                                v2:CreateSpeedMultiplier(v6, 1.5, "HitSpeedBonus", 1.25);
                                if v7 then
                                    v1:Play(v5.Config.Sounds.Hit, {
                                        Parent = v5.Rig.PrimaryPart, 
                                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                        Volume = 0.25
                                    });
                                end;
                            end
                        }
                    });
                end);
                task.delay(0.75, function() --[[ Line: 45 ]]
                    -- upvalues: v5 (copy)
                    v5.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v5.Animations.Slash:Play(0.175);
                end;
                return;
            end;
        end
    }
};
return v0;