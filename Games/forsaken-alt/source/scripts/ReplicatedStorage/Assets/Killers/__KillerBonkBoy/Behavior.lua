-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
local v5 = require(game.ReplicatedStorage.Modules.Network);
local v6 = require(game.ReplicatedStorage.Modules.AchievementUtil);
local function _(v7, v8, v9) --[[ Line: 12 ]] --[[ Name: getEnragedStatValue ]]
    return v7.Enraged and v7.Config[("Enraged%*%*"):format(v8, v9)] or v7.Config[("%*%*"):format(v8, v9)];
end;
local function v15(v11) --[[ Line: 17 ]] --[[ Name: pacify ]]
    -- upvalues: v1 (copy), v5 (copy), v2 (copy)
    if v11 and v11.Enraged and v11.Rig.Parent then
        v11.Enraged = nil;
        if game["Run Service"]:IsServer() then
            v11.Rig:SetAttribute("Invincible", nil);
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
v0.Abilities = {
    Slash = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://96590285148227", 
        KeybindType = "MainAbility", 
        Cooldown = function(v16, v17) --[[ Line: 79 ]] --[[ Name: Cooldown ]]
            return v16.Enraged and v16.Config[("Enraged%*%*"):format(v17, "Cooldown")] or v16.Config[("%*%*"):format(v17, "Cooldown")];
        end, 
        Callback = function(v18) --[[ Line: 80 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v2 (copy), v3 (copy), v15 (copy)
            if game["Run Service"]:IsServer() then
                v18.AbilitiesDisabled = false;
                v1:Play(v18.Config.Sounds.Swing, {
                    Parent = v18.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.25
                });
                task.delay(0.075, function() --[[ Line: 87 ]]
                    -- upvalues: v18 (copy), v2 (ref)
                    if v18.Enraged then
                        local v19 = v2:ApplyVelocity(v18.Rig.PrimaryPart, v18.Config.EnragedSlashLungeForce);
                        game.TweenService:Create(v19, TweenInfo.new(1), {
                            LineVelocity = v19.LineVelocity / 100
                        }):Play();
                        game.Debris:AddItem(v19, 0.6);
                    end;
                end);
                task.delay(0.2, function() --[[ Line: 96 ]]
                    -- upvalues: v3 (ref), v18 (copy), v2 (ref), v1 (ref), v15 (ref)
                    local l_v3_0 = v3;
                    local l_Player_0 = v18.Player;
                    local v22 = {
                        Size = Vector3.new(4.5, 6, 7.5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1.25)
                    };
                    local l_v18_0 = v18;
                    v22.Damage = l_v18_0.Enraged and l_v18_0.Config[("Enraged%*%*"):format("Slash", "Damage")] or l_v18_0.Config[("%*%*"):format("Slash", "Damage")];
                    v22.Time = 0.25;
                    v22.Knockback = 1;
                    v22.HitMultiple = false;
                    v22.ExecuteOnKill = false;
                    v22.Connections = {
                        Hit = function(v24, v25) --[[ Line: 108 ]] --[[ Name: Hit ]]
                            -- upvalues: v2 (ref), v1 (ref), v18 (ref), v15 (ref)
                            v2:CreateSpeedMultiplier(v24, 1.5, "HitSpeedBonus", 1.25);
                            if v25 then
                                v1:Play(v18.Config.Sounds.Hit, {
                                    Parent = v18.Rig.PrimaryPart, 
                                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                    Volume = 0.25
                                });
                                v15(v18);
                            end;
                        end
                    };
                    l_v3_0 = l_v3_0:CreateHitbox(l_Player_0, v22);
                end);
                task.delay(0.5, function() --[[ Line: 120 ]]
                    -- upvalues: v15 (ref), v18 (copy)
                    v15(v18);
                end);
                task.delay(0.85, function() --[[ Line: 125 ]]
                    -- upvalues: v18 (copy)
                    v18.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v18.Animations.Slash:Play(0.025);
                end;
                return;
            end;
        end
    }, 
    RagingPace = {
        LayoutOrder = 3, 
        Icon = "rbxassetid://112952508748158", 
        KeybindType = "AltAbility3", 
        Callback = function(v26) --[[ Line: 141 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v15 (copy), v5 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v26.AbilitiesDisabled = true;
                task.delay(0.233, function() --[[ Line: 147 ]]
                    -- upvalues: v26 (copy), v1 (ref)
                    v26.Enraged = true;
                    v26.Rig:SetAttribute("Invincible", true);
                    v26.EnragedSFX = v1:Play(v26.Config.Sounds.Enraged, {
                        Parent = v26.Rig.PrimaryPart, 
                        Looped = true, 
                        Volume = 0.25
                    });
                    v1:Play(v26.Config.Sounds.EnragedStart, {
                        Parent = v26.Rig.PrimaryPart
                    });
                    if v26.EnragedSFX then
                        game.Debris:AddItem(v26.EnragedSFX, v26.Config.EnragedTime);
                    end;
                    for _, v28 in pairs(v26.Rig:GetDescendants()) do
                        if v28.Name == "RagingPace" then
                            v28.Enabled = true;
                        end;
                    end;
                end);
                task.delay(v26.Config.EnragedTime, function() --[[ Line: 168 ]]
                    -- upvalues: v15 (ref), v26 (copy)
                    v15(v26);
                end);
                task.delay(1, function() --[[ Line: 173 ]]
                    -- upvalues: v26 (copy)
                    v26.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v26.Animations.EnragedStart:Play(0.025);
                    v26.AnimationType = "Enraged";
                    v26.MovementAnimSpeed = 1.425;
                    v26.Enraged = true;
                    v5:FireConnection("DisableSprinting", "ENRAGED", true);
                    v5:SetConnection("PacifyJason", "REMOTE_EVENT", function() --[[ Line: 184 ]]
                        -- upvalues: v15 (ref), v26 (copy)
                        v15(v26);
                    end);
                    v26.SpeedModifier = v2:CreateSpeedMultiplier(v26.Rig, 0.001, "ENRAGED");
                    task.delay(0.75, function() --[[ Line: 190 ]]
                        -- upvalues: v26 (copy)
                        game.TweenService:Create(v26.SpeedModifier, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                            Value = v26.Config.EnragedSpeed / v26.Config.Speed
                        }):Play();
                    end);
                    local l_v2_ClosestPlayerFromPosition_0 = v2:GetClosestPlayerFromPosition(v26.Rig.PrimaryPart.Position);
                    if l_v2_ClosestPlayerFromPosition_0 then
                        v26.TargetedPlayer = l_v2_ClosestPlayerFromPosition_0;
                        v2:RevealPlayerAura(l_v2_ClosestPlayerFromPosition_0, v26.Config.EnragedTime + 2);
                    end;
                    task.delay(1, function() --[[ Line: 202 ]]
                        -- upvalues: v26 (copy)
                        local v30 = tick();
                        while task.wait() and v26.Enraged and v26.Rig.Parent do
                            local v31 = math.clamp((tick() - v30) / v26.Config.EnragedStaminaCapLerpTime, 0, 1);
                            local v32 = v26.Config.MaxStamina + (v26.Config.EnragedStaminaCap - v26.Config.MaxStamina) * v31;
                            require(game.ReplicatedStorage.Systems.Character.Game.Sprinting).StaminaCap = v32;
                            if v31 >= 1 then
                                break;
                            end;
                        end;
                    end);
                end;
                return;
            end;
        end
    }
};
v0.Created = function(_, v34) --[[ Line: 224 ]] --[[ Name: Created ]]
    -- upvalues: v6 (copy), v2 (copy)
    if game["Run Service"]:IsServer() then
        if workspace:GetAttribute("JasonSpecialDay") then
            v6:IncrementAchievementProgress(v34.Player, "JasonSpecialDay");
        end;
        task.spawn(function() --[[ Line: 233 ]]
            -- upvalues: v34 (copy), v2 (ref)
            if not v34.Cache then
                v34.Cache = {};
            end;
            v34.Cache.GashingWoundStart = v2:LoadAnimationFromID(v34.Rig, v34.Config.Animations.GashingWoundStart);
            v34.Cache.GashingWound = v2:LoadAnimationFromID(v34.Rig, v34.Config.Animations.GashingWound.KillerRig);
        end);
    end;
end;
v0.OnIntroduction = function(_, _, v37, v38) --[[ Line: 242 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v2 (copy)
    local v39 = script.IntroWideDoor:Clone();
    v39:SetPrimaryPartCFrame(v37.PrimaryPart.CFrame);
    v39.Parent = v37;
    for _, v41 in pairs(v39.Joints:GetChildren()) do
        v41.Part1 = v39.Parts:FindFirstChild(v41.Name, true);
        v41.Part0 = v37.PrimaryPart;
    end;
    local l_v2_FOVMultiplier_0 = v2:CreateFOVMultiplier(game.Players.LocalPlayer, 0.4, "JasonIntroScene", v38);
    task.delay(0.783, function() --[[ Line: 258 ]]
        -- upvalues: l_v2_FOVMultiplier_0 (copy)
        l_v2_FOVMultiplier_0.Value = 0.35;
        game.TweenService:Create(l_v2_FOVMultiplier_0, TweenInfo.new(2.5, Enum.EasingStyle.Back), {
            Value = 0.45
        }):Play();
    end);
    local v43 = require(game.ReplicatedStorage.Modules.Schematics.Lighting);
    v43:SetCustomLighting(script.IntroLighting);
    task.delay(v38, function() --[[ Line: 268 ]]
        -- upvalues: v43 (copy)
        v43:SetAsCurrentLighting();
    end);
end;
v0.OnVictory = function(_, v45, _, _, _) --[[ Line: 274 ]] --[[ Name: OnVictory ]]
    if v45 == "Start" then
        return;
    else
        if v45 == "End" then

        end;
        return;
    end;
end;
v0.OnExecution = function(_, v50, v51) --[[ Line: 285 ]] --[[ Name: OnExecution ]]
    -- upvalues: v5 (copy)
    local v52 = v50.Rig.PrimaryPart.CFrame.LookVector * 100;
    local v53 = workspace:GetServerTimeNow() + 1.15;
    v5:FireAllClientConnection("Ragdoll", "REMOTE_EVENT", v51, v53, (("%*|%*|%*"):format(v52.X, v52.Y, v52.Z)));
    task.delay(1.125, function() --[[ Line: 294 ]]
        -- upvalues: v51 (copy)
        local l_Humanoid_0 = v51:FindFirstChild("Humanoid");
        if l_Humanoid_0 then
            l_Humanoid_0.BreakJointsOnDeath = false;
            l_Humanoid_0.Health = 0;
        end;
    end);
end;
return v0;