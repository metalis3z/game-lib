-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
local v5 = require(game.ReplicatedStorage.Modules.Network);
local _ = require(game.ReplicatedStorage.Modules.AchievementUtil);
local function _(v7, v8, v9) --[[ Line: 11 ]] --[[ Name: getEnragedStatValue ]]
    return v7.Enraged and v7.Config[("Enraged%*%*"):format(v8, v9)] or v7.Config[("%*%*"):format(v8, v9)];
end;
local function v15(v11) --[[ Line: 15 ]] --[[ Name: pacify ]]
    -- upvalues: v1 (copy), v5 (copy), v2 (copy)
    if v11 and v11.Enraged and v11.Rig.Parent then
        v11.Enraged = nil;
        if game["Run Service"]:IsServer() then
            if v11.EnragedSFX then
                v11.EnragedSFX:Destroy();
                v11.EnragedSFX = nil;
            end;
            v1:Play(v11.Config.Sounds.EnragedEnd, {
                Parent = v11.Rig.PrimaryPart
            });
            for _, v13 in pairs(v11.Rig:GetDescendants()) do
                if v13.Name == "RagingPace" then
                    v13.Enabled = false;
                end;
            end;
            v5:FireClientConnection(v11.Player, "PacifyJason", "REMOTE_EVENT");
            return;
        elseif game["Run Service"]:IsClient() then
            v11.AnimationType = nil;
            v11.MovementAnimSpeed = nil;
            v5:FireConnection("DisableSprinting", "ENRAGED", false);
            v5:RemoveConnection("PacifyJason", "REMOTE_EVENT");
            if v11.TargetedPlayer then
                v2:RevealPlayerAura(v11.TargetedPlayer, v11.Config.EnragedAuraLingerTime);
                v11.TargetedPlayer = nil;
            end;
            if v11.SpeedModifier then
                game.TweenService:Create(v11.SpeedModifier, TweenInfo.new(1), {
                    Value = 1
                }):Play();
                game.Debris:AddItem(v11.SpeedModifier, 1);
            end;
            local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v11.Rig, 0.001, "Pacified");
            game.TweenService:Create(l_v2_SpeedMultiplier_0, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Value = 1
            }):Play();
            game.Debris:AddItem(l_v2_SpeedMultiplier_0, 1);
            require(game.ReplicatedStorage.Systems.Character.Game.Sprinting).StaminaCap = nil;
        end;
    end;
end;
v0.CreatedPost = function(_, v17) --[[ Line: 69 ]] --[[ Name: CreatedPost ]]
    if game["Run Service"]:IsServer() then
        local l_Highlight_0 = Instance.new("Highlight");
        l_Highlight_0.DepthMode = Enum.HighlightDepthMode.Occluded;
        l_Highlight_0.FillColor = Color3.fromRGB(74, 74, 74);
        l_Highlight_0.FillTransparency = 15;
        l_Highlight_0.OutlineColor = Color3.fromRGB(74, 74, 74);
        l_Highlight_0.OutlineTransparency = 0.95;
        l_Highlight_0.Parent = v17.Rig;
    end;
end;
v0.Abilities = {
    Slash = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "MainAbility", 
        Callback = function(v19) --[[ Line: 86 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v2 (copy), v3 (copy), v4 (copy), v15 (copy)
            if game["Run Service"]:IsServer() then
                v19.AbilitiesDisabled = true;
                v1:Play(v19.Config.Sounds.Swing, {
                    Parent = v19.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.25
                });
                task.delay(0.075, function() --[[ Line: 93 ]]
                    -- upvalues: v19 (copy), v2 (ref)
                    if v19.Enraged then
                        local v20 = v2:ApplyVelocity(v19.Rig.PrimaryPart, v19.Config.EnragedSlashLungeForce);
                        game.TweenService:Create(v20, TweenInfo.new(1), {
                            VectorVelocity = v20.VectorVelocity / 100
                        }):Play();
                        game.Debris:AddItem(v20, 0.6);
                    end;
                end);
                task.delay(0.18, function() --[[ Line: 101 ]]
                    -- upvalues: v3 (ref), v19 (copy), v2 (ref), v4 (ref), v1 (ref), v15 (ref)
                    local l_v3_0 = v3;
                    local l_Player_0 = v19.Player;
                    local v23 = {
                        Size = Vector3.new(4.5, 6, 9, 0), 
                        CFrameOffset = CFrame.new(0, 0, -2.5)
                    };
                    local l_v19_0 = v19;
                    v23.Damage = l_v19_0.Enraged and l_v19_0.Config[("Enraged%*%*"):format("Slash", "Damage")] or l_v19_0.Config[("%*%*"):format("Slash", "Damage")];
                    v23.Time = 0.2;
                    v23.Knockback = 2;
                    v23.HitMultiple = false;
                    v23.ExecuteOnKill = true;
                    v23.Connections = {
                        Hit = function(v25, v26) --[[ Line: 113 ]] --[[ Name: Hit ]]
                            -- upvalues: v2 (ref), v4 (ref), v1 (ref), v19 (ref), v15 (ref)
                            v2:CreateSpeedMultiplier(v25, 1.5, "HitSpeedBonus", 1.25);
                            v4:ApplyStatus(v25, "Bleeding", {
                                Level = 1, 
                                Duration = 5
                            });
                            if v26 then
                                v1:Play(v19.Config.Sounds.Hit, {
                                    Parent = v19.Rig.PrimaryPart, 
                                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                    Volume = 0.25
                                });
                                v15(v19);
                            end;
                        end
                    };
                    l_v3_0 = l_v3_0:CreateHitbox(l_Player_0, v23);
                end);
                task.delay(0.5, function() --[[ Line: 125 ]]
                    -- upvalues: v15 (ref), v19 (copy)
                    v15(v19);
                end);
                task.delay(0.6, function() --[[ Line: 130 ]]
                    -- upvalues: v19 (copy)
                    v19.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    if v19.Enraged then
                        v19.Animations.Stab1:Play(0.175);
                        return;
                    else
                        v19.Animations.Stab2:Play(0.175);
                    end;
                end;
                return;
            end;
        end
    }, 
    Rage = {
        LayoutOrder = 3, 
        Icon = "rbxassetid://112952508748158", 
        KeybindType = "AltAbility3", 
        Callback = function(v27) --[[ Line: 150 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v15 (copy), v5 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v27.AbilitiesDisabled = true;
                task.delay(0.233, function() --[[ Line: 156 ]]
                    -- upvalues: v27 (copy), v1 (ref)
                    v27.Enraged = true;
                    v27.EnragedSFX = v1:Play(v27.Config.Sounds.Enraged, {
                        Parent = v27.Rig.PrimaryPart, 
                        Looped = true, 
                        Volume = 0.25
                    });
                    v1:Play(v27.Config.Sounds.EnragedStart, {
                        Parent = v27.Rig.PrimaryPart
                    });
                    if v27.EnragedSFX then
                        game.Debris:AddItem(v27.EnragedSFX, v27.Config.EnragedTime);
                    end;
                    for _, v29 in pairs(v27.Rig:GetDescendants()) do
                        if v29.Name == "Rage" then
                            v29.Enabled = true;
                        end;
                    end;
                end);
                task.delay(v27.Config.EnragedTime, function() --[[ Line: 176 ]]
                    -- upvalues: v15 (ref), v27 (copy)
                    v15(v27);
                end);
                task.delay(1, function() --[[ Line: 181 ]]
                    -- upvalues: v27 (copy)
                    v27.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v27.Animations.Rage:Play(0.025);
                    v27.AnimationType = "Enraged";
                    v27.MovementAnimSpeed = 1.425;
                    v27.Enraged = true;
                    v5:FireConnection("DisableSprinting", "ENRAGED", true);
                    v5:SetConnection("PacifyJason", "REMOTE_EVENT", function() --[[ Line: 192 ]]
                        -- upvalues: v15 (ref), v27 (copy)
                        v15(v27);
                    end);
                    v27.SpeedModifier = v2:CreateSpeedMultiplier(v27.Rig, 0.001, "ENRAGED");
                    task.delay(0.75, function() --[[ Line: 198 ]]
                        -- upvalues: v27 (copy)
                        game.TweenService:Create(v27.SpeedModifier, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                            Value = 20
                        }):Play();
                    end);
                    local l_v2_ClosestPlayerFromPosition_0 = v2:GetClosestPlayerFromPosition(v27.Rig.PrimaryPart.Position);
                    if l_v2_ClosestPlayerFromPosition_0 then
                        v27.TargetedPlayer = l_v2_ClosestPlayerFromPosition_0;
                        v2:RevealPlayerAura(l_v2_ClosestPlayerFromPosition_0, 10);
                    end;
                    task.delay(1, function() --[[ Line: 210 ]]
                        -- upvalues: v27 (copy)
                        local v31 = tick();
                        while task.wait() and v27.Enraged and v27.Rig.Parent do
                            local v32 = math.clamp((tick() - v31) / v27.Config.EnragedStaminaCapLerpTime, 0, 1);
                            local v33 = v27.Config.MaxStamina + (v27.Config.EnragedStaminaCap - v27.Config.MaxStamina) * v32;
                            require(game.ReplicatedStorage.Systems.Character.Game.Sprinting).StaminaCap = v33;
                            if v32 >= 1 then
                                break;
                            end;
                        end;
                    end);
                end;
                return;
            end;
        end
    }, 
    Scream = {
        LayoutOrder = 2, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "AltAbility1", 
        Callback = function(v34) --[[ Line: 234 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v2 (copy), v4 (copy)
            if game["Run Service"]:IsServer() then
                v34.AbilitiesDisabled = true;
                task.delay(0.5, function() --[[ Line: 238 ]]
                    -- upvalues: v1 (ref), v34 (copy)
                    v1:Play(v34.Config.Sounds.EnragedStart, {
                        Parent = v34.Rig.PrimaryPart, 
                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                        Volume = 0.25
                    });
                end);
                task.delay(0.5, function() --[[ Line: 242 ]]
                    -- upvalues: v3 (ref), v34 (copy), v2 (ref), v4 (ref)
                    local _ = v3:CreateHitbox(v34.Player, {
                        Size = Vector3.new(20, 6, 20, 0), 
                        CFrameOffset = CFrame.new(0, 0, -10.5), 
                        Damage = 15, 
                        Time = 0.25, 
                        Knockback = 0, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v35, v36) --[[ Line: 253 ]] --[[ Name: Hit ]]
                                -- upvalues: v2 (ref), v4 (ref)
                                v2:CreateSpeedMultiplier(v35, 1.5, "HitSpeedBonus", 1.25);
                                if v36 then
                                    v4:ApplyStatus(v35, "Blindness", {
                                        Level = 1, 
                                        Duration = 5
                                    });
                                end;
                            end
                        }
                    });
                end);
                task.delay(1.65, function() --[[ Line: 264 ]]
                    -- upvalues: v34 (copy)
                    v34.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v34.Animations.Scream:Play(0.175);
                    v2:CreateSpeedMultiplier(v34.Player, 0.01, "MassInfection", 1.2, true);
                end;
                return;
            end;
        end
    }
};
return v0;