-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Wed May 14 21:43:58 2025 ]]
local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
local v3 = require(game.ReplicatedStorage.Modules.Sounds);
local _ = require(game.ReplicatedStorage.Modules.Ragdolls);
local _ = require(game.ReplicatedStorage.Modules.Network);
local v6 = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Device);
v0.Abilities = {
    Stab = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "MainAbility", 
        Callback = function(v8) --[[ Line: 16 ]] --[[ Name: Callback ]]
            -- upvalues: v3 (copy), v1 (copy), v6 (copy)
            if game["Run Service"]:IsServer() then
                v8.AbilitiesDisabled = true;
                v3:Play(v8.Config.Sounds.Swing, {
                    Parent = v8.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.25
                });
                task.delay(0.5, function() --[[ Line: 23 ]]
                    -- upvalues: v1 (ref), v8 (copy), v6 (ref), v3 (ref)
                    local _ = v1:CreateHitbox(v8.Player, {
                        Size = Vector3.new(4.5, 6, 9, 0), 
                        CFrameOffset = CFrame.new(0, 0, -2.5), 
                        Damage = v8.Config.StabDamage, 
                        Time = 0.2, 
                        Knockback = 2, 
                        HitMultiple = false, 
                        ExecuteOnKill = true, 
                        Connections = {
                            Hit = function(v9, v10) --[[ Line: 35 ]] --[[ Name: Hit ]]
                                -- upvalues: v6 (ref), v3 (ref), v8 (ref)
                                v6:CreateSpeedMultiplier(v9, 1.5, "HitSpeedBonus", 1.25);
                                if v10 then
                                    v3:Play(v8.Config.Sounds.Hit, {
                                        Parent = v8.Rig.PrimaryPart, 
                                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                        Volume = 0.25
                                    });
                                end;
                            end
                        }
                    });
                end);
                task.delay(1.65, function() --[[ Line: 46 ]]
                    -- upvalues: v8 (copy)
                    v8.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v8.Animations.Stab:Play(0.175);
                end;
                return;
            end;
        end
    }, 
    Stardriven = {
        LayoutOrder = 2, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "AltAbility1", 
        Callback = function(v12, v13) --[[ Line: 62 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy)
            if game["Run Service"]:IsServer() then
                if not v12.Charging then
                    v12.Charging = 1;
                    v12.DisabledAbilities = {
                        Stab = true, 
                        Implant = true, 
                        Hallucination = true
                    };
                    v12:SetCooldownOf("Stardriven", v12.Config.StardrivenChargeTime);
                    return "Charging";
                elseif v12.Charging == 1 then
                    v12.Charging = 2;
                    v12:SetCooldownOf("Stardriven", v12.Config.StardrivenChargeTime);
                    task.delay(0.1, function() --[[ Line: 77 ]]
                        -- upvalues: v1 (ref), v12 (copy)
                        local _ = v1:CreateHitbox(v12.Player, {
                            Size = Vector3.new(4.5, 6, 5, 0), 
                            CFrameOffset = CFrame.new(0, 0, -1.5), 
                            Damage = 40, 
                            Time = 0.3, 
                            Knockback = 2, 
                            HitMultiple = false, 
                            ExecuteOnKill = true, 
                            Connections = {
                                Hit = function(_) --[[ Line: 89 ]] --[[ Name: Hit ]]

                                end
                            }
                        });
                    end);
                    return "Dash1";
                end;
            elseif game["Run Service"]:IsClient() then
                if v13 == "Charging" then
                    v12.Animations.StardrivenTendrilStart:Play(0);
                    v12.Animations.StardrivenTendrilLoop:Play(0);
                    return;
                elseif v13 == "Dash1" then
                    v12.Animations.StardrivenTendrilStart:Stop(0);
                    v12.Animations.StardrivenTendrilLoop:Stop(0);
                    v12.Animations.StardrivenCharge1Start:Play(0);
                    v12.Animations.StardrivenCharge1Loop:Play(0);
                end;
            end;
        end
    }, 
    Implant = {
        LayoutOrder = 3, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "AltAbility2", 
        Callback = function(_) --[[ Line: 123 ]] --[[ Name: Callback ]]
            if game["Run Service"]:IsServer() then
                return;
            else
                if game["Run Service"]:IsClient() then

                end;
                return;
            end;
        end
    }, 
    Hallucination = {
        LayoutOrder = 4, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "AltAbility3", 
        Callback = function(_) --[[ Line: 140 ]] --[[ Name: Callback ]]
            if game["Run Service"]:IsServer() then
                return;
            else
                if game["Run Service"]:IsClient() then

                end;
                return;
            end;
        end
    }
};
v0.Created = function(_, v19) --[[ Line: 154 ]] --[[ Name: Created ]]
    if game["Run Service"]:IsServer() then
        v19.Rig:GetAttributeChangedSignal("CurrentAnimation"):Connect(function() --[[ Line: 157 ]]
            -- upvalues: v19 (copy)
            v19.Rig:SetAttribute("CurrentAnimation", nil);
        end);
        return;
    else
        if game["Run Service"]:IsClient() then
            v19.Rig:GetAttributeChangedSignal("CurrentAnimation"):Connect(function() --[[ Line: 163 ]]
                -- upvalues: v19 (copy)
                local l_Attribute_0 = v19.Rig:GetAttribute("CurrentAnimation");
                if v19.Animations[l_Attribute_0] then
                    v19.Animations[l_Attribute_0]:Play(0);
                end;
            end);
        end;
        return;
    end;
end;
v0.OnIntroduction = function(_, _, v23, v24) --[[ Line: 173 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v6 (copy)
    v23.FakeCrown.Transparency = 0;
    v23.Voidstar.Transparency = 1;
    v23.VoidstarCrown.Transparency = 1;
    local l_KillerCutsceneBackground_0 = workspace.Misc:FindFirstChild("KillerCutsceneBackground");
    local v26 = true;
    task.spawn(function() --[[ Line: 182 ]]
        -- upvalues: v26 (ref), l_KillerCutsceneBackground_0 (copy)
        while v26 do
            for v27, v28 in pairs(l_KillerCutsceneBackground_0.Voidstars:GetChildren()) do
                v28.CFrame = v28.CFrame * CFrame.Angles(0, v27 % 2 == 0 and 0.0225 or -0.0225, 0);
            end;
            task.wait();
        end;
    end);
    task.spawn(function() --[[ Line: 191 ]]
        -- upvalues: v26 (ref), l_KillerCutsceneBackground_0 (copy)
        while v26 do
            local l_Skybox_0 = l_KillerCutsceneBackground_0.Skybox;
            l_Skybox_0.CFrame = l_Skybox_0.CFrame * CFrame.Angles(0, 0.004363323129985824, 0);
            task.wait();
        end;
    end);
    local l_v6_FOVMultiplier_0 = v6:CreateFOVMultiplier(game.Players.LocalPlayer, 0.375, "NoliIntroScene", v24);
    task.delay(1.98, function() --[[ Line: 200 ]]
        -- upvalues: l_v6_FOVMultiplier_0 (copy)
        l_v6_FOVMultiplier_0.Value = 0.275;
    end);
    task.delay(v24, function() --[[ Line: 204 ]]
        -- upvalues: v26 (ref), v23 (copy)
        v26 = false;
        v23.FakeCrown.Transparency = 1;
        v23.VoidstarCrown.Transparency = 0;
        v23.Voidstar.Transparency = 0;
    end);
end;
return v0;