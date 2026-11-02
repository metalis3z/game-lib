-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
local v5 = require(game.ReplicatedStorage.Modules.Network);
local function _(v6, v7, v8) --[[ Line: 11 ]] --[[ Name: getEnragedStatValue ]]
    return v6.Enraged and v6.Config[("Enraged%*%*"):format(v7, v8)] or v6.Config[("%*%*"):format(v7, v8)];
end;
local function v14(v10) --[[ Line: 16 ]] --[[ Name: pacify ]]
    -- upvalues: v1 (copy), v5 (copy), v2 (copy)
    if v10 and v10.Enraged and v10.Rig.Parent then
        v10.Enraged = nil;
        if game["Run Service"]:IsServer() then
            v10.Rig:SetAttribute("Invincible", nil);
            if v10.EnragedSFX then
                v10.EnragedSFX:Destroy();
                v10.EnragedSFX = nil;
            end;
            v1:Play(v10.Config.Sounds.EnragedEnd, {
                Parent = v10.Rig.PrimaryPart
            });
            for _, v12 in pairs(v10.Rig:GetDescendants()) do
                if v12.Name == "RagingPace" then
                    v12.Enabled = false;
                end;
            end;
            v5:FireClientConnection(v10.Player, "PacifyJason", "REMOTE_EVENT");
            return;
        elseif game["Run Service"]:IsClient() then
            v10.AnimationType = nil;
            v10.MovementAnimSpeed = nil;
            v5:FireConnection("DisableSprinting", "ENRAGED", false);
            v5:RemoveConnection("PacifyJason", "REMOTE_EVENT");
            if v10.TargetedPlayer then
                v2:RevealPlayerAura(v10.TargetedPlayer, v10.Config.EnragedAuraLingerTime);
                v10.TargetedPlayer = nil;
            end;
            if v10.SpeedModifier then
                game.TweenService:Create(v10.SpeedModifier, TweenInfo.new(1), {
                    Value = 1
                }):Play();
                game.Debris:AddItem(v10.SpeedModifier, 1);
            end;
            local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v10.Rig, 0.001, "Pacified");
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
        Cooldown = function(v15, v16) --[[ Line: 78 ]] --[[ Name: Cooldown ]]
            return v15.Enraged and v15.Config[("Enraged%*%*"):format(v16, "Cooldown")] or v15.Config[("%*%*"):format(v16, "Cooldown")];
        end, 
        Callback = function(v17) --[[ Line: 79 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v2 (copy), v3 (copy), v4 (copy), v14 (copy)
            if game["Run Service"]:IsServer() then
                v17.AbilitiesDisabled = true;
                v1:Play(v17.Config.Sounds.Swing, {
                    Parent = v17.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.25
                });
                task.delay(0.075, function() --[[ Line: 86 ]]
                    -- upvalues: v17 (copy), v2 (ref)
                    if v17.Enraged then
                        local v18 = v2:ApplyVelocity(v17.Rig.PrimaryPart, v17.Config.EnragedSlashLungeForce);
                        game.TweenService:Create(v18, TweenInfo.new(1), {
                            LineVelocity = v18.LineVelocity / 100
                        }):Play();
                        game.Debris:AddItem(v18, 0.6);
                    end;
                end);
                task.delay(0.2, function() --[[ Line: 95 ]]
                    -- upvalues: v3 (ref), v17 (copy), v2 (ref), v4 (ref), v1 (ref), v14 (ref)
                    local l_v3_0 = v3;
                    local l_Player_0 = v17.Player;
                    local v21 = {
                        Size = Vector3.new(4.5, 6, 7.5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1.25)
                    };
                    local l_v17_0 = v17;
                    v21.Damage = l_v17_0.Enraged and l_v17_0.Config[("Enraged%*%*"):format("Slash", "Damage")] or l_v17_0.Config[("%*%*"):format("Slash", "Damage")];
                    v21.Time = 0.25;
                    v21.Knockback = 2;
                    v21.HitMultiple = true;
                    v21.ExecuteOnKill = true;
                    v21.Connections = {
                        Hit = function(v23, v24) --[[ Line: 107 ]] --[[ Name: Hit ]]
                            -- upvalues: v2 (ref), v4 (ref), v1 (ref), v17 (ref), v14 (ref)
                            for _, v26 in pairs(v23:GetDescendants()) do
                                if not v26:GetAttribute("Fade") then
                                    if v26:IsA("BasePart") and v26.Name:lower():find("hair") then
                                        v26.Transparency = 1;
                                    elseif v26:IsA("Accessory") and (v26.AccessoryType == Enum.AccessoryType.Hair or v26.Name:lower():find("hair") or v26:FindFirstChild("HairAttachment", true)) then
                                        v26:Destroy();
                                    end;
                                end;
                            end;
                            if math.random(1, 10) == 1 then
                                local l_BarberJasonFade_0 = v23:FindFirstChild("BarberJasonFade");
                                while l_BarberJasonFade_0 do
                                    l_BarberJasonFade_0:Destroy();
                                    l_BarberJasonFade_0 = v23:FindFirstChild("BarberJasonFade");
                                end;
                                local l_Children_0 = script.Hairs:GetChildren();
                                local v29 = l_Children_0[math.random(1, #l_Children_0)];
                                if v29 then
                                    v29 = v29:Clone();
                                    v29.Name = "BarberJasonFade";
                                    v29.Parent = v23;
                                    v29.Handle:SetAttribute("Fade", true);
                                    v29:SetAttribute("Fade", true);
                                end;
                            end;
                            v2:CreateSpeedMultiplier(v23, 1.5, "HitSpeedBonus", 1.25);
                            v4:ApplyStatus(v23, "Bleeding", {
                                Level = 1, 
                                Duration = 5
                            });
                            if v24 then
                                v1:Play(v17.Config.Sounds.Hit, {
                                    Parent = v17.Rig.PrimaryPart, 
                                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                    Volume = 0.25
                                });
                                v14(v17);
                            end;
                        end
                    };
                    l_v3_0 = l_v3_0:CreateHitbox(l_Player_0, v21);
                end);
                task.delay(0.5, function() --[[ Line: 150 ]]
                    -- upvalues: v14 (ref), v17 (copy)
                    v14(v17);
                end);
                task.delay(0.85, function() --[[ Line: 155 ]]
                    -- upvalues: v17 (copy)
                    v17.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v17.Animations.Slash:Play(0.025);
                end;
                return;
            end;
        end
    }
};
return v0;