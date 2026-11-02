-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
local v5 = require(game.ReplicatedStorage.Modules.Actors);
v0.Abilities = {
    Slash = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "MainAbility", 
        Callback = function(v6) --[[ Line: 15 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v5 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v6.AbilitiesDisabled = true;
                v1:Play(v6.Config.Sounds.Swing, {
                    Parent = v6.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.25
                });
                task.delay(0.1, function() --[[ Line: 22 ]]
                    -- upvalues: v3 (ref), v6 (copy), v5 (ref), v2 (ref), v1 (ref)
                    local _ = v3:CreateHitbox(v6.Player, {
                        Size = Vector3.new(12, 16, 12, 0), 
                        CFrameOffset = CFrame.new(0, -6, -3), 
                        Damage = 0, 
                        Time = 0.3, 
                        Knockback = 2, 
                        HitMultiple = false, 
                        Connections = {
                            Hit = function(v7) --[[ Line: 33 ]] --[[ Name: Hit ]]
                                -- upvalues: v6 (ref), v5 (ref), v2 (ref), v1 (ref)
                                if not v7:GetAttribute("Transforming") then
                                    local l_PlayerFromCharacter_0 = game.Players:GetPlayerFromCharacter(v7);
                                    if v7.Humanoid.Health - v6.Config.SlashDamage <= 0 and l_PlayerFromCharacter_0 then
                                        v7:SetAttribute("Transforming", true);
                                        v5:CleanupActorFromPlayer(l_PlayerFromCharacter_0);
                                        v5:CreateActor(l_PlayerFromCharacter_0, "Killer", "ZombieKing_Zombie");
                                        return;
                                    else
                                        local l_Humanoid_0 = v7.Humanoid;
                                        l_Humanoid_0.Health = l_Humanoid_0.Health - v6.Config.SlashDamage;
                                        v2:CreateSpeedMultiplier(v7, 2, "HitSpeedBonus", 1.25);
                                        v1:Play(v6.Config.Sounds.Hit, {
                                            Parent = v6.Rig.PrimaryPart, 
                                            PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                            Volume = 0.25
                                        });
                                    end;
                                end;
                            end
                        }
                    });
                end);
                task.delay(0.75, function() --[[ Line: 56 ]]
                    -- upvalues: v6 (copy)
                    v6.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v6.Animations.Slash:Play(0.025);
                end;
                return;
            end;
        end
    }
};
return v0;