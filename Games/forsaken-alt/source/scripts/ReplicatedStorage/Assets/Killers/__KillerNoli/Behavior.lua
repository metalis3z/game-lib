-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local l_Debris_0 = game:GetService("Debris");
local v5 = {
    placedTrap = false, 
    sprinting = true
};
local v6 = require(game.ReplicatedStorage.Modules.Sounds);
local v7 = require(l_ReplicatedStorage_0.Modules.Network);
local v8 = require(game.ReplicatedStorage.Modules.Util);
local v9 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v10 = require(game.ReplicatedStorage.Modules.Statuses);
local v11 = require(l_ReplicatedStorage_0.Modules.Ragdolls);
local v12 = require(l_ReplicatedStorage_0.Modules.Schematics.Lighting);
local v13 = Color3.fromRGB(186, 66, 255);
local v14 = 0;
local v15 = {
    [0] = {
        Brightness = 0, 
        Contrast = 0, 
        Saturation = 0, 
        TintColor = Color3.fromRGB(255, 255, 255)
    }, 
    [1] = {
        Brightness = -0.05, 
        Contrast = 1, 
        Saturation = -0.2, 
        TintColor = v13
    }, 
    [2] = {
        Brightness = -0.4, 
        Contrast = 1.5, 
        Saturation = -0.5, 
        TintColor = v13
    }, 
    [3] = {
        Brightness = -0.7, 
        Contrast = 2.5, 
        Saturation = -0.9, 
        TintColor = Color3.fromRGB(91, 32, 125)
    }
};
local function _(v16, v17) --[[ Line: 49 ]] --[[ Name: switchDecayLevel ]]
    -- upvalues: v15 (copy), l_TweenService_0 (copy)
    local v18 = v15[v16];
    l_TweenService_0:Create(v17, TweenInfo.new(0.35), v18):Play();
end;
local function v25(v20) --[[ Line: 54 ]] --[[ Name: waitForInput ]]
    -- upvalues: l_UserInputService_0 (copy)
    local v21 = nil;
    local v22 = nil;
    v22 = l_UserInputService_0.InputBegan:Connect(function(v23, v24) --[[ Line: 57 ]]
        -- upvalues: v20 (copy), v21 (ref), v22 (ref)
        if v24 then
            return;
        else
            if v23.KeyCode == v20 or v23.UserInputType == v20 then
                v21 = v23;
                v22:Disconnect();
            end;
            return;
        end;
    end);
    repeat
        task.wait();
    until v21 ~= nil;
end;
v5.Created = function(_, v27) --[[ Line: 73 ]] --[[ Name: Created ]]
    -- upvalues: l_RunService_0 (copy), v8 (copy), l_ReplicatedStorage_0 (copy), v5 (copy), v15 (copy), l_TweenService_0 (copy), v14 (ref)
    if l_RunService_0:IsServer() then
        task.spawn(function() --[[ Line: 76 ]]
            -- upvalues: v27 (copy), v8 (ref)
            if not v27.Cache then
                v27.Cache = {};
            end;
            v27.Cache.ImplantAttackNoli = v8:LoadAnimationFromID(v27.Rig, v27.Config.Animations.ImplantAttackNoli);
            v27.Cache.StardrivenAttackNoli = v8:LoadAnimationFromID(v27.Rig, v27.Config.Animations.StardrivenCharge2HitNoli);
        end);
    end;
    if l_RunService_0:IsClient() and v27.Player == game.Players.LocalPlayer then
        v8:SetSpeedCap(v27.Rig, "NoliWalkSpeed", v27.Config.Speed);
        local v28 = require(l_ReplicatedStorage_0.Systems.Character.Game.Sprinting);
        local v29 = v27.Config.Assets.DecayCC:Clone();
        v29.Parent = game.Lighting;
        task.spawn(function() --[[ Line: 93 ]]
            -- upvalues: v27 (copy), v5 (ref), v28 (copy), v15 (ref), v29 (copy), l_TweenService_0 (ref), v14 (ref)
            while tostring(v27.Rig.Parent) == "Killers" do
                if v5.sprinting or v28.Stamina >= -30 then
                    v28.IsSprinting = true;
                    v28.CanSprint = true;
                else
                    v28.IsSprinting = false;
                    v28.CanSprint = false;
                end;
                if v28.Stamina <= 0 then
                    local v30 = math.abs((math.floor(v28.Stamina / 10)));
                    if v15[v30] then
                        local l_v29_0 = v29;
                        local v32 = v15[v30];
                        l_TweenService_0:Create(l_v29_0, TweenInfo.new(0.35), v32):Play();
                        v14 = v30;
                        if v30 ~= 3 then

                        end;
                    end;
                else
                    if v14 ~= 0 then
                        local l_v29_1 = v29;
                        local v34 = v15[0];
                        l_TweenService_0:Create(l_v29_1, TweenInfo.new(0.35), v34):Play();
                    end;
                    v14 = 0;
                end;
                task.wait();
            end;
        end);
    end;
end;
v5.OnIntroduction = function(_, v36, v37, v38) --[[ Line: 126 ]] --[[ Name: OnIntroduction ]]	
	-- upvalues: v12 (copy), v8 (copy)
--[[	v12:SetCustomLighting(v36.Config.IntroLighting);
    v37.FakeCrown.Transparency = 0;
    v37.Voidstar.Transparency = 1;
    v37.VoidstarCrown.Transparency = 1;
    local l_Default_0 = workspace.Misc:FindFirstChild("Default");
    local v40 = true;
    task.spawn(function()
        -- upvalues: v40 (ref), l_Default_0 (copy)
        while v40 do
            for v41, v42 in pairs(l_Default_0.Voidstars:GetChildren()) do
                v42.CFrame = v42.CFrame * CFrame.Angles(0, v41 % 2 == 0 and 0.0225 or -0.0225, 0);
            end;
            task.wait();
        end;
    end);
    task.spawn(function()
        -- upvalues: v40 (ref), l_Default_0 (copy)
        while v40 do
            local l_Skybox_0 = l_Default_0.Skybox;
            l_Skybox_0.CFrame = l_Skybox_0.CFrame * CFrame.Angles(0, 0.004363323129985824, 0);
            task.wait();
        end;
    end);
    local l_v8_FOVMultiplier_0 = v8:CreateFOVMultiplier(game.Players.LocalPlayer, 0.375, "NoliIntroScene", v38);
    task.delay(1.98, function()
        -- upvalues: l_v8_FOVMultiplier_0 (copy)
        l_v8_FOVMultiplier_0.Value = 0.275;
    end);
    task.delay(v38, function()
        -- upvalues: v40 (ref), v37 (copy), v12 (ref)
        v40 = false;
        v37.FakeCrown.Transparency = 1;
        v37.VoidstarCrown.Transparency = 0;
        v37.Voidstar.Transparency = 0;
        v12:SetAsCurrentLighting();
    end);]]
end;
v5.KillerRemoved = function(_) --[[ Line: 167 ]] --[[ Name: KillerRemoved ]]
    local l_Decay_0 = game.Lighting:FindFirstChild("Decay");
    if l_Decay_0 then
        l_Decay_0:Destroy();
    end;
end;
v5.Abilities = {
    Stab = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "MainAbility", 
        Callback = function(v47) --[[ Line: 180 ]] --[[ Name: Callback ]]
            -- upvalues: l_RunService_0 (copy), v6 (copy), v9 (copy), v8 (copy)
            if l_RunService_0:IsServer() then
                v47.AbilitiesDisabled = true;
                v6:Play(v47.Config.Sounds.Swing, {
                    Parent = v47.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.25
                });
                task.delay(0.5, function() --[[ Line: 187 ]]
                    -- upvalues: v9 (ref), v47 (copy), v8 (ref), v6 (ref)
                    local _ = v9:CreateHitbox(v47.Player, {
                        Size = Vector3.new(4.5, 6, 9, 0), 
                        CFrameOffset = CFrame.new(0, 0, -2.5), 
                        Damage = v47.Config.StabDamage, 
                        Time = 0.2, 
                        Knockback = 2, 
                        HitMultiple = false, 
                        ExecuteOnKill = true, 
                        Connections = {
                            Hit = function(v48, v49) --[[ Line: 199 ]] --[[ Name: Hit ]]
                                -- upvalues: v8 (ref), v6 (ref), v47 (ref)
                                v8:CreateSpeedMultiplier(v48, 1.5, "HitSpeedBonus", 1.25);
                                if v49 then
                                    v6:Play(v47.Config.Sounds.Hit, {
                                        Parent = v47.Rig.PrimaryPart, 
                                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                        Volume = 0.25
                                    });
                                end;
                            end
                        }
                    });
                end);
                task.delay(1.65, function() --[[ Line: 210 ]]
                    -- upvalues: v47 (copy)
                    v47.AbilitiesDisabled = false;
                end);
                return;
            else
                if l_RunService_0:IsClient() then
                    v47.Animations.Stab:Play(0.175);
                end;
                return;
            end;
        end
    }, 
    Stardriven = {
        LayoutOrder = 2, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "AltAbility1", 
        Callback = function(v51) --[[ Line: 226 ]] --[[ Name: Callback ]]
            -- upvalues: l_RunService_0 (copy), v7 (copy), v8 (copy), v9 (copy), v10 (copy), v5 (copy), v25 (copy)
            local l_Rig_0 = v51.Rig;
            local l_HumanoidRootPart_0 = l_Rig_0.HumanoidRootPart;
            if l_RunService_0:IsServer() then
                v51.DisabledAbilities = {
                    Stab = true, 
                    Stardriven = true, 
                    Hallucination = true, 
                    Implant = true
                };
                local v54 = 1;
                v7:SetConnection("noli_stardriven", "REMOTE_EVENT", function(v55) --[[ Line: 240 ]]
                    -- upvalues: v51 (copy), v54 (ref), v8 (ref), l_HumanoidRootPart_0 (copy), v9 (ref), v10 (ref), l_Rig_0 (copy), v7 (ref)
                    if v55 ~= v51.Player then
                        return;
                    else
                        print("server:", v54);
                        local v56 = v8:ApplyVelocity(l_HumanoidRootPart_0, v51.Config.StardrivenSpeed);
                        local v57 = false;
                        local v58 = false;
                        local _ = v9:CreateHitbox(v51.Player, {
                            Size = Vector3.new(7, 7, 7, 0), 
                            PredictVelocity = true, 
                            CFrameOffset = CFrame.new(0, 0, -2), 
                            Damage = 15, 
                            Time = 2, 
                            Connections = {
                                Hit = function(v59) --[[ Line: 256 ]] --[[ Name: Hit ]]
                                    -- upvalues: v10 (ref), v57 (ref), v54 (ref), l_Rig_0 (ref), v51 (ref), v8 (ref)
                                    v10:ApplyStatus(v59, "Slowness", {
                                        Level = 1
                                    });
                                    v57 = true;
                                    if v54 == 2 then
                                        local l_HumanoidRootPart_1 = v59.HumanoidRootPart;
                                        local l_HumanoidRootPart_2 = l_Rig_0.HumanoidRootPart;
                                        l_Rig_0:SetAttribute("Invincible", true);
                                        l_HumanoidRootPart_2.Anchored = true;
                                        l_HumanoidRootPart_1.Anchored = true;
                                        local l_StardrivenAttackNoli_0 = v51.Cache.StardrivenAttackNoli;
                                        local l_StardrivenCharge2HitVictim_0 = v51.Config.Animations.StardrivenCharge2HitVictim;
                                        l_StardrivenCharge2HitVictim_0 = v8:LoadAnimationFromID(v59, l_StardrivenCharge2HitVictim_0, true);
                                        l_StardrivenAttackNoli_0:Play(0.05);
                                        l_StardrivenCharge2HitVictim_0:Play(0.05);
                                        v59:PivotTo(l_Rig_0:GetPivot() * CFrame.new(0, 0, -6) * CFrame.Angles(0, 3.141592653589793, 0));
                                        task.delay(2.5, function() --[[ Line: 280 ]]
                                            -- upvalues: l_Rig_0 (ref), l_HumanoidRootPart_2 (copy), l_HumanoidRootPart_1 (copy)
                                            l_Rig_0:SetAttribute("Invincible", false);
                                            l_HumanoidRootPart_2.Anchored = false;
                                            l_HumanoidRootPart_1.Anchored = false;
                                        end);
                                    end;
                                end, 
                                Ended = function() --[[ Line: 287 ]] --[[ Name: Ended ]]
                                    -- upvalues: v58 (ref)
                                    v58 = true;
                                end
                            }
                        });
                        repeat
                            task.wait();
                        until v57 or v58;
                        v56:Destroy();
                        if v54 == 2 then
                            task.delay(1, function() --[[ Line: 297 ]]
                                -- upvalues: v51 (ref)
                                v51.DisabledAbilities = nil;
                            end);
                        end;
                        v7:FireClientConnection(v51.Player, "noli_proceed", "REMOTE_EVENT", v57);
                        if not v57 or v58 then
                            v7:RemoveConnection("noli_stardriven", "REMOTE_EVENT");
                            task.delay(1, function() --[[ Line: 306 ]]
                                -- upvalues: v51 (ref)
                                v51.DisabledAbilities = nil;
                            end);
                            print("missed on server");
                        end;
                        v54 = 2;
                        return;
                    end;
                end);
                return;
            else
                if l_RunService_0:IsClient() then
                    v5.sprinting = false;
                    local l_v8_SpeedMultiplier_0 = v8:CreateSpeedMultiplier(v51.Rig, 0.1, "NoliStardriven");
                    local function v67(v66) --[[ Line: 318 ]] --[[ Name: onMiss ]]
                        -- upvalues: v51 (copy), l_v8_SpeedMultiplier_0 (copy), v5 (ref), v7 (ref)
                        print("missed on client");
                        v66:Stop(0);
                        v51.Animations.StardrivenChargeMiss:Play(0.175);
                        task.delay(1, function() --[[ Line: 322 ]]
                            -- upvalues: l_v8_SpeedMultiplier_0 (ref), v5 (ref)
                            l_v8_SpeedMultiplier_0:Destroy();
                            v5.sprinting = true;
                        end);
                        v7:RemoveConnection("noli_proceed", "REMOTE_EVENT");
                    end;
                    local l_StardrivenTendrilStartup_0 = v51.Animations.StardrivenTendrilStartup;
                    l_StardrivenTendrilStartup_0:Play(0.175);
                    task.wait(l_StardrivenTendrilStartup_0.Length);
                    local l_StardrivenTendrilLoop_0 = v51.Animations.StardrivenTendrilLoop;
                    l_StardrivenTendrilLoop_0:Play(0);
                    v25(Enum.UserInputType.MouseButton1);
                    print("client: 1");
                    v7:FireServerConnection("noli_stardriven", "REMOTE_EVENT");
                    l_StardrivenTendrilLoop_0:Stop(0);
                    local l_StardrivenCharge1Start_0 = v51.Animations.StardrivenCharge1Start;
                    l_StardrivenCharge1Start_0:Play(0.175);
                    task.wait(l_StardrivenCharge1Start_0.Length);
                    local l_StardrivenCharge1Loop_0 = v51.Animations.StardrivenCharge1Loop;
                    l_StardrivenCharge1Loop_0:Play(0);
                    local v72 = nil;
                    v7:SetConnection("noli_proceed", "REMOTE_EVENT", function(v73) --[[ Line: 352 ]]
                        -- upvalues: v72 (ref)
                        v72 = v73;
                    end);
                    repeat
                        task.wait();
                    until v72 ~= nil;
                    print("should proceed:", v72);
                    if v72 then
                        v72 = nil;
                        l_StardrivenCharge1Loop_0:Stop(0);
                        local l_StardrivenCharge1Hit_0 = v51.Animations.StardrivenCharge1Hit;
                        l_StardrivenCharge1Hit_0:Play(0);
                        task.wait(l_StardrivenCharge1Hit_0.Length);
                        local l_StardrivenTendrilLoop_1 = v51.Animations.StardrivenTendrilLoop;
                        l_StardrivenTendrilLoop_1:Play(0);
                        v25(Enum.UserInputType.MouseButton1);
                        print("client: 2");
                        v7:FireServerConnection("noli_stardriven", "REMOTE_EVENT");
                        l_StardrivenTendrilLoop_1:Stop(0);
                        local l_StardrivenCharge2Start_0 = v51.Animations.StardrivenCharge2Start;
                        l_StardrivenCharge2Start_0:Play(0.175);
                        task.wait(l_StardrivenCharge2Start_0.Length);
                        local l_StardrivenCharge2Loop_0 = v51.Animations.StardrivenCharge2Loop;
                        l_StardrivenCharge2Loop_0:Play(0);
                        repeat
                            task.wait();
                        until v72 ~= nil;
                        l_StardrivenCharge2Loop_0:Stop(0);
                        l_v8_SpeedMultiplier_0:Destroy();
                        print("new should proceed:", v72);
                        if v72 then
                            return;
                        else
                            v67(l_StardrivenCharge2Loop_0);
                            return;
                        end;
                    else
                        v67(l_StardrivenCharge1Loop_0);
                        --[[ close >= 9 ]]
                    end;
                end;
                return;
            end;
        end
    }, 
    Implant = {
        LayoutOrder = 3, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "AltAbility2", 
        Callback = function(v78, v79) --[[ Line: 412 ]] --[[ Name: Callback ]]
            -- upvalues: l_TweenService_0 (copy), v5 (copy), v9 (copy), v8 (copy), v6 (copy), l_Debris_0 (copy), v11 (copy)
            if game["Run Service"]:IsServer() then
                v78.AbilitiesDisabled = true;
                local l_Rig_1 = v78.Rig;
                local l_HumanoidRootPart_3 = l_Rig_1.HumanoidRootPart;
                local l_Voidstar_0 = l_Rig_1.Voidstar;
                task.delay(1.65, function() --[[ Line: 422 ]]
                    -- upvalues: v78 (copy)
                    v78.AbilitiesDisabled = false;
                end);
                local function v83() --[[ Line: 427 ]] --[[ Name: voidstarAppear ]]
                    -- upvalues: l_TweenService_0 (ref), l_Voidstar_0 (copy)
                    l_TweenService_0:Create(l_Voidstar_0, TweenInfo.new(0.45, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        Size = Vector3.new(1.409999966621399, 1.409999966621399, 1.409999966621399, 0), 
                        Transparency = 0
                    }):Play();
                end;
                local function v84() --[[ Line: 433 ]] --[[ Name: voidstarDisappear ]]
                    -- upvalues: l_TweenService_0 (ref), l_Voidstar_0 (copy)
                    l_TweenService_0:Create(l_Voidstar_0, TweenInfo.new(0.45, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        Size = Vector3.new(0, 0, 0, 0), 
                        Transparency = 1
                    }):Play();
                end;
                local function v86(v85) --[[ Line: 440 ]] --[[ Name: detonate ]]
                    -- upvalues: v5 (ref), v9 (ref), v78 (copy), v8 (ref), v6 (ref), l_Debris_0 (ref)
                    if v5.onCooldown then
                        return;
                    else
                        v5.onCooldown = true;
                        task.delay(0.2, function() --[[ Line: 449 ]]
                            -- upvalues: v5 (ref)
                            v5.onCooldown = false;
                        end);
                        if v5.currentDelay then
                            task.cancel(v5.currentDelay);
                            v5.currentDelay = nil;
                        end;
                        if v5.currentDetection then
                            print("found detection hitbox");
                            v5.currentDetection:Cancel();
                            v5.currentDetection = nil;
                        end;
                        v5.currentTrap = nil;
                        v9:CreateHitbox(v78.Player, {
                            CFrame = v85.CFrame, 
                            Size = Vector3.new(16, 16, 16, 0), 
                            PredictVelocity = false, 
                            Damage = v78.Config.ImplantDamage, 
                            Knockback = v78.Config.ImplantKnockback, 
                            HitMultiple = true, 
                            Time = 0.125
                        });
                       -- v8:EmitParticlesFromAttachment(v85.Explosion);
                        v6:Play(v78.Config.Sounds.Explosion, {
                            Volume = 0.35, 
                            Position = v85.Position
                        });
                        v85.Transparency = 1;
                        l_Debris_0:AddItem(v85, 3);
                        return;
                    end;
                end;
                local l_v8_ClosestPlayerFromPosition_0 = v8:GetClosestPlayerFromPosition(l_HumanoidRootPart_3.Position, {
                    MaxDistance = 7, 
                    PlayerSelection = "Survivors", 
                    OverrideUndetectable = true
                });
                local v88 = l_v8_ClosestPlayerFromPosition_0 and "Player" or "Trap";
                print("type", v88);
                if v88 == "Trap" then
                    v6:Play(v78.Config.Sounds.Implant, {
                        Volume = 0.35, 
                        Parent = l_HumanoidRootPart_3
                    });
                end;
                task.delay(0.7, function() --[[ Line: 510 ]]
                    -- upvalues: v5 (ref), v86 (copy), l_Voidstar_0 (copy), v88 (copy), v84 (copy), v83 (copy), l_TweenService_0 (ref), l_HumanoidRootPart_3 (copy), v9 (ref), v78 (copy), l_v8_ClosestPlayerFromPosition_0 (copy), l_Rig_1 (copy), v8 (ref), v6 (ref), l_Debris_0 (ref), v11 (ref)
                    if v5.currentTrap ~= nil then
                        v86(v5.currentTrap);
                    end;
                    local v89 = l_Voidstar_0:Clone();
                    v89.Transparency = 1;
                    v89.Anchored = true;
                    v89.CanCollide = false;
                    v89.Parent = workspace;
                    v5.currentTrap = v89;
                    if v88 == "Trap" then
                        v89.Transparency = 0;
                        v84();
                        task.delay(1, v83);
                        l_TweenService_0:Create(v89, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 1), {
                            Transparency = 0.7
                        }):Play();
                        v89.CFrame = l_HumanoidRootPart_3.CFrame * CFrame.new(0, -3, -3.25);
                        v5.currentDetection = v9:CreateHitbox(v78.Player, {
                            CFrame = v89.CFrame, 
                            Size = Vector3.new(6, 6, 6, 0), 
                            PredictVelocity = false, 
                            Damage = 0, 
                            Knockback = 0, 
                            Time = v78.Config.ImplantTime, 
                            Connections = {
                                Hit = function() --[[ Line: 547 ]] --[[ Name: Hit ]]
                                    -- upvalues: v86 (ref), v89 (copy)
                                    v86(v89);
                                end, 
                                Ended = function() --[[ Line: 550 ]] --[[ Name: Ended ]]
                                    -- upvalues: v86 (ref), v89 (copy)
                                    v86(v89);
                                end
                            }
                        });
                        return;
                    else
                        v89.Transparency = 1;
                        local l_HumanoidRootPart_4 = l_v8_ClosestPlayerFromPosition_0.HumanoidRootPart;
                        local l_HumanoidRootPart_5 = l_Rig_1.HumanoidRootPart;
                        l_Rig_1:SetAttribute("Invincible", true);
                        l_HumanoidRootPart_5.Anchored = true;
                        l_HumanoidRootPart_4.Anchored = true;
                        l_v8_ClosestPlayerFromPosition_0:PivotTo(l_Rig_1:GetPivot() * CFrame.new(0, 0, -4.5) * CFrame.Angles(0, 3.141592653589793, 0));
                        task.delay(0.1, function() --[[ Line: 564 ]]
                            -- upvalues: l_v8_ClosestPlayerFromPosition_0 (ref), l_Rig_1 (ref)
                            l_v8_ClosestPlayerFromPosition_0:PivotTo(l_Rig_1:GetPivot() * CFrame.new(0, 0, -3.15) * CFrame.Angles(0, 3.141592653589793, 0));
                            task.wait(1);
                            l_v8_ClosestPlayerFromPosition_0:PivotTo(l_Rig_1:GetPivot() * CFrame.new(0, 0, -2.45) * CFrame.Angles(0, 3.141592653589793, 0));
                        end);
                        local l_ImplantAttackNoli_0 = v78.Cache.ImplantAttackNoli;
                        local l_ImplantAttackVictim_0 = v78.Config.Animations.ImplantAttackVictim;
                        l_ImplantAttackVictim_0 = v8:LoadAnimationFromID(l_v8_ClosestPlayerFromPosition_0, l_ImplantAttackVictim_0, true);
                        l_ImplantAttackNoli_0:Play(0.05);
                        l_ImplantAttackVictim_0:Play(0.05);
                        v6:Play(v78.Config.Sounds.ImplantInject, {
                            Volume = 0.75, 
                            Parent = l_HumanoidRootPart_3
                        });
                        task.delay(1.735, function() --[[ Line: 582 ]]
                            -- upvalues: l_HumanoidRootPart_5 (copy), l_HumanoidRootPart_4 (copy), l_v8_ClosestPlayerFromPosition_0 (ref), l_Rig_1 (ref), v8 (ref), v78 (ref), l_Debris_0 (ref), v11 (ref), l_Voidstar_0 (ref), v83 (ref), v89 (copy), v5 (ref), v86 (ref)
                            l_HumanoidRootPart_5.Anchored = false;
                            l_HumanoidRootPart_4.Anchored = false;
                            l_v8_ClosestPlayerFromPosition_0:PivotTo(l_Rig_1:GetPivot() * CFrame.new(0, 0, -7));
                            local v94 = v8:ApplyVelocity(l_HumanoidRootPart_4, v78.Config.ImplantInjectKnockback);
                            l_Debris_0:AddItem(v94, v78.Config.ImplantInjectKnockbackDestroyTime);
                            l_Rig_1:SetAttribute("Invincible", false);
                            task.spawn(function() --[[ Line: 593 ]]
                                -- upvalues: v11 (ref), l_v8_ClosestPlayerFromPosition_0 (ref)
                                v11:Enable(l_v8_ClosestPlayerFromPosition_0);
                                task.wait(0.25);
                                v11:Disable(l_v8_ClosestPlayerFromPosition_0);
                            end);
                            l_Voidstar_0.Size = Vector3.new(0, 0, 0, 0);
                            task.delay(1, v83);
                            v89.CFrame = l_HumanoidRootPart_4.CFrame * CFrame.new(0, 0, -0.25);
                            v89.Transparency = 0;
                            local l_Motor6D_0 = Instance.new("Motor6D");
                            l_Motor6D_0.Part0 = l_HumanoidRootPart_4;
                            l_Motor6D_0.Part1 = v89;
                            l_Motor6D_0.Parent = l_HumanoidRootPart_4;
                            v5.currentDelay = task.delay(v78.Config.ImplantTime, function() --[[ Line: 611 ]]
                                -- upvalues: v89 (ref), l_Motor6D_0 (copy), v86 (ref)
                                if v89 and v89.Parent then
                                    l_Motor6D_0:Destroy();
                                    v86(v89);
                                end;
                            end);
                            v89.Destroying:Once(function() --[[ Line: 618 ]]
                                -- upvalues: l_Motor6D_0 (copy)
                                l_Motor6D_0:Destroy();
                            end);
                        end);
                        return;
                    end;
                end);
                return v88;
            else
                if game["Run Service"]:IsClient() then
                    print((("trap type: %*"):format(v79)));
                    if v79 == "Trap" then
                        v78.Animations.Implant:Play(0.175);
                    end;
                end;
                return;
            end;
        end
    }, 
    Hallucination = {
        LayoutOrder = 4, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "AltAbility3", 
        Callback = function(v96) --[[ Line: 643 ]] --[[ Name: Callback ]]
            -- upvalues: v8 (copy), v6 (copy), v10 (copy)
            if game["Run Service"]:IsServer() then
                v96.AbilitiesDisabled = true;
                local l_HumanoidRootPart_6 = v96.Rig.HumanoidRootPart;
                local l_v8_ClosestPlayerFromPosition_1 = v8:GetClosestPlayerFromPosition(l_HumanoidRootPart_6.Position, {
                    MaxDistance = v96.Config.HallucinationMaxDistance, 
                    PlayerSelection = "Survivors", 
                    OverrideUndetectable = true, 
                    ReturnTable = true
                });
                v6:Play(v96.Config.Sounds.Hallucination, {
                    Volume = 0.35, 
                    Parent = l_HumanoidRootPart_6
				});
				--
				l_HumanoidRootPart_6.Anchored = true
				--
                for _, v100 in pairs(l_v8_ClosestPlayerFromPosition_1) do
                    v8:RevealPlayerAura(v100.Player, v96.Config.HallucinationAuraRevealDuration);
                    v10:ApplyStatus(v100.Player, "Hallucination", {
                        Level = math.random(1, 3), 
                        Duration = v96.Config.HallucinationDuration, 
                        Hidden = true
                    });
                end;
                task.delay(1.65, function() --[[ Line: 672 ]]
                    -- upvalues: v96 (copy)
					v96.AbilitiesDisabled = false;
					l_HumanoidRootPart_6.Anchored = false
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v96.Animations.Hallucination:Play(0.175);
                end;
                return;
            end;
        end
    }
};
return v5;