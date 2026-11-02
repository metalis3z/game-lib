-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
v0.Abilities = {
    Block = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "AltAbility1", 
        Cooldown = 20, 
        Callback = function(v5) --[[ Line: 15 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v5.AbilitiesDisabled = true;
                if math.random(1, 20) == 1 then
                    v1:Play(v5.Config.Sounds.BlackFlashSong, {
                        Parent = v5.Rig.PrimaryPart, 
                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                        Volume = 0.25
                    });
                else
                    v1:Play(v5.Config.Sounds.BlackFlash, {
                        Parent = v5.Rig.PrimaryPart, 
                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                        Volume = 0.25
                    });
                end;
                v5.Rig["Right Arm"].BF.Cursed1.Enabled = true;
                task.delay(0.8, function() --[[ Line: 28 ]]
                    -- upvalues: v5 (copy), v3 (ref), v2 (ref)
                    v5.Rig["Right Arm"].BF.Cursed1.Enabled = false;
                    local _ = v3:CreateHitbox(v5.Player, {
                        Size = Vector3.new(6, 10, 10, 0), 
                        CFrameOffset = CFrame.new(0, 0, -8.25), 
                        Damage = v5.Config.SlashDamage, 
                        Time = 0.875, 
                        Knockback = 20, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v6, v7) --[[ Line: 40 ]] --[[ Name: Hit ]]
                                -- upvalues: v2 (ref), v5 (ref)
                                v2:CreateSpeedMultiplier(v6, 1.5, "HitSpeedBonus", 1.25);
                                if v7 then
                                    for v8 = 1, 4 do
                                        v5.Rig["Right Arm"].BF["BF" .. v8].Enabled = true;
                                        task.delay(0.2, function() --[[ Line: 45 ]]
                                            -- upvalues: v5 (ref), v8 (copy)
                                            v5.Rig["Right Arm"].BF["BF" .. v8].Enabled = false;
                                        end);
                                    end;
                                end;
                            end
                        }
                    });
                end);
                task.delay(0.5, function() --[[ Line: 55 ]]
                    -- upvalues: v2 (ref), v5 (copy)
                    local v10 = v2:ApplyVelocity(v5.Rig.PrimaryPart, v5.Config.EnragedSlashLungeForce);
                    game.TweenService:Create(v10, TweenInfo.new(1), {
                        VectorVelocity = v10.VectorVelocity / 100
                    }):Play();
                    game.Debris:AddItem(v10, 0.3);
                end);
                task.delay(0.75, function() --[[ Line: 62 ]]
                    -- upvalues: v5 (copy)
                    v5.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v5.Animations.Block:Play(0.175);
                end;
                return;
            end;
        end
    }
};
return v0;