-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
v0.Abilities = {
    FireIShall = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://135559874576100", 
        KeybindType = "MainAbility", 
        Cooldown = 0.25, 
        Callback = function(v5, v6) --[[ Line: 15 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v5.AbilitiesDisabled = true;
                if not v5.HitIndex then
                    v5.HitIndex = 0;
                end;
                v5.HitIndex = v5.HitIndex + 1;
                if v5.HitIndex % 2 == 1 then
                    v1:Play(v5.Config.Sounds.Solemn, {
                        Parent = v5.Rig.PrimaryPart, 
                        Volume = 0.25
                    });
                    for v7 = 1, 6 do
                        v5.Rig.Solemn.SolemnGun.Solemn["Solemn" .. v7].Enabled = true;
                    end;
                    task.delay(0.075, function() --[[ Line: 29 ]]
                        -- upvalues: v5 (copy)
                        for v8 = 1, 6 do
                            v5.Rig.Solemn.SolemnGun.Solemn["Solemn" .. v8].Enabled = false;
                        end;
                    end);
                else
                    v1:Play(v5.Config.Sounds.Lament, {
                        Parent = v5.Rig.PrimaryPart, 
                        Volume = 0.25
                    });
                    for v9 = 1, 6 do
                        v5.Rig.Lament.LamentGun.Lament["Lament" .. v9].Enabled = true;
                    end;
                    task.delay(0.075, function() --[[ Line: 40 ]]
                        -- upvalues: v5 (copy)
                        for v10 = 1, 6 do
                            v5.Rig.Lament.LamentGun.Lament["Lament" .. v10].Enabled = false;
                        end;
                    end);
                end;
                task.delay(0.125, function() --[[ Line: 48 ]]
                    -- upvalues: v3 (ref), v5 (copy), v2 (ref)
                    local _ = v3:CreateHitbox(v5.Player, {
                        Size = Vector3.new(4, 6, 20, 0), 
                        CFrameOffset = CFrame.new(0, 0, -14.25), 
                        Damage = v5.Config.SlashDamage, 
                        Time = 0.01, 
                        Knockback = 0.01, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v11, _) --[[ Line: 59 ]] --[[ Name: Hit ]]
                                -- upvalues: v2 (ref)
                                v2:CreateSpeedMultiplier(v11, 1.5, "HitSpeedBonus", 1.25);
                            end
                        }
                    });
                end);
                task.delay(0.3, function() --[[ Line: 67 ]]
                    -- upvalues: v5 (copy)
                    v5.AbilitiesDisabled = false;
                end);
                return v5.HitIndex;
            else
                if game["Run Service"]:IsClient() then
                    v5.Animations.Fire1:Stop(0);
                    v5.Animations.Fire2:Stop(0);
                    v5.Animations[("Fire%*"):format(v6 % 2 + 1)]:Play(0.025);
                end;
                return;
            end;
        end
    }, 
    Lockin = {
        LayoutOrder = 2, 
        Icon = "rbxassetid://135559874576100", 
        KeybindType = "AltAbility1", 
        Cooldown = 0, 
        Callback = function(v14, v15) --[[ Line: 88 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                if not v14.HitIndex then
                    v14.HitIndex = 0;
                end;
                v14.HitIndex = v14.HitIndex + 1;
                if v14.HitIndex % 2 == 1 then
                    v1:Play(v14.Config.Sounds.Solemn, {
                        Parent = v14.Rig.PrimaryPart, 
                        Volume = 0.25
                    });
                    for v16 = 1, 6 do
                        v14.Rig.Solemn.SolemnGun.Solemn["Solemn" .. v16].Enabled = true;
                    end;
                    task.delay(0.075, function() --[[ Line: 99 ]]
                        -- upvalues: v14 (copy)
                        for v17 = 1, 6 do
                            v14.Rig.Solemn.SolemnGun.Solemn["Solemn" .. v17].Enabled = false;
                        end;
                    end);
                else
                    v1:Play(v14.Config.Sounds.Lament, {
                        Parent = v14.Rig.PrimaryPart, 
                        Volume = 0.25
                    });
                    for v18 = 1, 6 do
                        v14.Rig.Lament.LamentGun.Lament["Lament" .. v18].Enabled = true;
                    end;
                    task.delay(0.075, function() --[[ Line: 110 ]]
                        -- upvalues: v14 (copy)
                        for v19 = 1, 6 do
                            v14.Rig.Lament.LamentGun.Lament["Lament" .. v19].Enabled = false;
                        end;
                    end);
                end;
                task.delay(0.125, function() --[[ Line: 118 ]]
                    -- upvalues: v3 (ref), v14 (copy), v2 (ref)
                    local _ = v3:CreateHitbox(v14.Player, {
                        Size = Vector3.new(4, 6, 20, 0), 
                        CFrameOffset = CFrame.new(0, 0, -14.25), 
                        Damage = v14.Config.SlashDamage, 
                        Time = 0.01, 
                        Knockback = 0.01, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v20, _) --[[ Line: 129 ]] --[[ Name: Hit ]]
                                -- upvalues: v2 (ref)
                                v2:CreateSpeedMultiplier(v20, 1.5, "HitSpeedBonus", 1.25);
                            end
                        }
                    });
                end);
                return v14.HitIndex;
            else
                if game["Run Service"]:IsClient() then
                    v14.Animations.Fire1:Stop(0);
                    v14.Animations.Fire2:Stop(0);
                    v14.Animations[("Fire%*"):format(v15 % 2 + 1)]:Play(0.025);
                end;
                return;
            end;
        end
    }
};
v0.Created = function(_, v24) --[[ Line: 149 ]] --[[ Name: Created ]]
    if game["Run Service"]:IsServer() then
        task.spawn(function() --[[ Line: 151 ]]
            -- upvalues: v24 (copy)
            local l_HumanoidDescriptionFromUserId_0 = game.Players:GetHumanoidDescriptionFromUserId(v24.Player.UserId);
            l_HumanoidDescriptionFromUserId_0.Head = 0;
            v24.Rig.Humanoid:ApplyDescription(l_HumanoidDescriptionFromUserId_0);
            for _, v27 in pairs(v24.Rig:GetChildren()) do
                if v27:IsA("CharacterMesh") and v27.MeshId ~= 48112070 then
                    v27:Destroy();
                end;
            end;
        end);
    end;
end;
return v0;