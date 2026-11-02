-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    Connections = {}, 
    KillerIntros = {}
};
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local v2 = require(game.ReplicatedStorage.Modules.Network);
local v3 = require(game.ReplicatedStorage.Modules.Actors);
local v4 = require(game.ReplicatedStorage.Modules.Util);
local v5 = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting);
v0.Start = function(_) --[[ Line: 15 ]] --[[ Name: Start ]]
    -- upvalues: v2 (copy), v3 (copy), v4 (copy), v0 (copy), l_LocalPlayer_0 (copy), v5 (copy)
	v2:SetConnection("ActorDestroyed", "REMOTE_EVENT", function(v7) --[[ Line: 19 ]]
		warn(v3, v7)
        -- upvalues: v3 (ref)
        local v8 = v3.CurrentActors[v7];
		if v8 then
			warn(v8)
            for _, v10 in pairs({
                "Destroyed", 
                "DestroyedPost"
            }) do
                if v8.CustomBehavior and v8.CustomBehavior[v10] then
                    v8.CustomBehavior[v10](v8.CustomBehavior, v8);
                elseif v8.Behavior[v10] then
                    v8.Behavior[v10](v8.Behavior, v8);
                end;
            end;
            task.spawn(function() --[[ Line: 34 ]]
                -- upvalues: v8 (copy)
                if v8.ActorType:find("Killer") then
                    local v11 = require(game.ReplicatedStorage.Systems.Character.Game.ChaseThemes);
                    local _ = require(game.ReplicatedStorage.Systems.Character.Game.ChaseThemesKiller);
                    v11:KillerRemoved(v8);
                end;
            end);
            v3.__actorDestroyed:Fire(v8);
        end;
        v3.CurrentActors[v7] = nil;
    end);
    v2:SetConnection("ActorCreated", "REMOTE_EVENT", function(v13) --[[ Line: 53 ]]
        -- upvalues: v3 (ref), v4 (ref), v0 (ref), l_LocalPlayer_0 (ref), v2 (ref), v5 (ref)
        local v14 = v3:ApplySkinDataToActorInfo(v13);
        v13.CustomBehavior = v14 and v14:FindFirstChild("Behavior") and require(v14.Behavior) or {};
        v3.CurrentActors[v13.Player] = v13;
        v4:PreloadAssets(v13.Config);
        task.spawn(function() --[[ Line: 66 ]]
            -- upvalues: v13 (copy)
            if v13.ActorType:find("Killer") then
                local v15 = require(game.ReplicatedStorage.Systems.Character.Game.ChaseThemes);
                local v16 = require(game.ReplicatedStorage.Systems.Character.Game.ChaseThemesKiller);
                v15:KillerAdded(v13);
                v16:KillerAdded(v13);
            end;
        end);
        task.spawn(function() --[[ Line: 76 ]]
            -- upvalues: v13 (copy), v0 (ref), v4 (ref), v3 (ref), l_LocalPlayer_0 (ref)
            for _, v18 in pairs({
                "Created", 
                "CreatedPost"
            }) do
                if v13.CustomBehavior and v13.CustomBehavior[v18] then
                    v13.CustomBehavior[v18](v13.CustomBehavior, v13);
                elseif v13.Behavior[v18] then
                    v13.Behavior[v18](v13.Behavior, v13);
                end;
            end;
            if not v13.ActorType:find("Killer") then
                return;
            elseif v13.Config.IntroductionsDisabled then
                return;
            else
                local l_Introduction_0 = v13.Config.Animations.Introduction;
                if #v0.KillerIntros >= 16 then
                    table.clear(v0.KillerIntros);
                end;
                table.insert(v0.KillerIntros, {
                    PlayerName = tostring(v13.Player), 
                    KillerName = tostring(v13.Config.DisplayName or v13.ActorName)
                });
                if #v0.KillerIntros <= 1 then
                    v4:FadeIn({
                        InstantTween = true
                    });
                    task.delay(7.5, function() --[[ Line: 102 ]]
                        -- upvalues: v0 (ref)
                        table.clear(v0.KillerIntros);
                    end);
                end;
                local v20 = require(game.ReplicatedStorage.Initializer);
                if #v0.KillerIntros > 1 or v20.PlayerSettings and v20.PlayerSettings.SkipIntros and v20.PlayerSettings.SkipIntros.Value or not l_Introduction_0 or not l_Introduction_0.KillerRig or not l_Introduction_0.CameraRig then
                    task.wait(0.5);
                    v4:FadeOut({
                        Time = 0.75
                    });
                    v4:CreateDisplayUI(v0.KillerIntros);
                    return;
                else
                    if #v0.KillerIntros <= 1 then
                        local v21 = 0;
                        if not v13.Rig.Parent or not v13.Rig:FindFirstChild("HumanoidRootPart") then
                            repeat
                                print((("waiting until %* is ready to be accessed"):format((tostring(v13.Rig)))));
                                v21 = v21 + task.wait();
                            until v21 >= 10 or v13.Rig.Parent and v13.Rig:FindFirstChild("HumanoidRootPart");
                        end;
                        if v21 >= 10 then
                            return;
                        else
                            task.wait(0.1);
                            local l_v3_CutsceneActor_0, v23, v24 = v3:CreateCutsceneActor(v13, "Introduction");
                            task.spawn(function() --[[ Line: 130 ]]
                                -- upvalues: v13 (ref)
                                local v25 = require(game.ReplicatedStorage.Modules.Sounds);
                                v25:Play(v13.Config.Sounds.Introduction);
                                v25:PlayVoiceline(v13, "Introduction", {
                                    Priority = 10, 
                                    Parent = workspace:FindFirstChild("Sounds") or workspace.Misc
                                });
                            end);
                            task.spawn(function() --[[ Line: 137 ]]
                                -- upvalues: v13 (ref), l_v3_CutsceneActor_0 (copy), v24 (copy), v0 (ref)
                                if v13.CustomBehavior.OnIntroduction then
                                    v13.CustomBehavior:OnIntroduction(v13, l_v3_CutsceneActor_0, v24, v0.KillerIntros);
                                    return;
                                else
                                    if v13.Behavior.OnIntroduction then
                                        v13.Behavior:OnIntroduction(v13, l_v3_CutsceneActor_0, v24, v0.KillerIntros);
                                    end;
                                    return;
                                end;
                            end);
                            v4:FadeOut({
                                Time = 0.35
                            });
                            l_LocalPlayer_0.PlayerGui.MainUI.Enabled = false;
                            l_LocalPlayer_0.PlayerGui.TemporaryUI.Enabled = false;
                            task.delay(0.75, function() --[[ Line: 153 ]]
                                -- upvalues: v4 (ref), v0 (ref)
                                v4:CreateDisplayUI(v0.KillerIntros);
                            end);
                            task.delay(v24 - 0.5, function() --[[ Line: 158 ]]
                                -- upvalues: v4 (ref)
                                v4:FadeIn({
                                    TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                                });
                            end);
                            task.delay(v24, function() --[[ Line: 163 ]]
                                -- upvalues: v23 (copy), l_v3_CutsceneActor_0 (copy)
                                game:SetAttribute("IntroductionEnded", true);
                                workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
                                v23:Destroy();
                                l_v3_CutsceneActor_0:Destroy();
                                game:SetAttribute("IntroductionEnded", nil);
                            end);
                            task.delay(v24 + 0.25, function() --[[ Line: 173 ]]
                                -- upvalues: l_LocalPlayer_0 (ref), v4 (ref)
                                l_LocalPlayer_0.PlayerGui.MainUI.Enabled = true;
                                l_LocalPlayer_0.PlayerGui.TemporaryUI.Enabled = true;
                                v4:FadeOut({
                                    Time = 0.75
                                });
                            end);
                        end;
                    end;
                    return;
                end;
            end;
        end);
        task.spawn(function() --[[ Line: 183 ]]
            -- upvalues: v13 (copy), l_LocalPlayer_0 (ref), v0 (ref), v4 (ref), v2 (ref), v5 (ref)
            if v13.Player ~= l_LocalPlayer_0 then
                return;
            else
                v0:Destroy();
                v13.Animations = {};
                for v26, v27 in pairs(v13.Config.Animations) do
                    if typeof(v27) == "string" then
                        v13.Animations[v26] = v4:LoadAnimationFromID(v13.Rig, v27);
                    elseif typeof(v27) == "table" then
                        for v28, v29 in pairs(v27) do
                            if typeof(v29) == "string" then
                                if not v13.Animations[v26] then
                                    v13.Animations[v26] = {};
                                end;
                                v13.Animations[v26][v28] = v4:LoadAnimationFromID(v13.Rig, v29);
                            end;
                        end;
                    end;
                end;
                local v30 = {};
                local function v34(v31) --[[ Line: 206 ]] --[[ Name: stopAnims ]]
                    -- upvalues: v30 (copy)
                    for _, v33 in pairs(v30) do
                        v33:Stop(v31);
                    end;
                    table.clear(v30);
                end;
                v13.Animations.Idle.Priority = Enum.AnimationPriority.Core;
                v13.Animations.Walk.Priority = Enum.AnimationPriority.Core;
                v13.Animations.Run.Priority = Enum.AnimationPriority.Core;
                v13.Animations.Idle:Play(0);
                v13.Animations.Idle.Looped = true;
                table.insert(v30, v13.Animations.Idle);
                local v35 = false;
                local v36 = 0;
                for v37, v38 in pairs(v13.Animations) do
                    if v37:find("Walk") or v37:find("Run") then
                        v38.KeyframeReached:Connect(function(v39) --[[ Line: 226 ]]
                            -- upvalues: l_LocalPlayer_0 (ref), v35 (ref), v36 (ref), v2 (ref)
                            if v39 == "Footstep" and l_LocalPlayer_0.Character.Humanoid.FloorMaterial ~= Enum.Material.Air and l_LocalPlayer_0.Character.Humanoid.FloorMaterial ~= Enum.Material.Neon and l_LocalPlayer_0.Character.PrimaryPart.Velocity.Magnitude > 3 and not l_LocalPlayer_0.Character.PrimaryPart.Anchored and not l_LocalPlayer_0.Character:GetAttribute("FootstepsMuted") then
                                if v35 then
                                    v35 = false;
                                    return;
                                else
                                    v36 = v36 + 1;
                                    v2:FireServerConnection("FootstepPlayed", "UREMOTE_EVENT", v36);
                                end;
                            end;
                        end);
                    end;
                end;
                l_LocalPlayer_0.Character:GetAttributeChangedSignal("Ragdolling"):Connect(function() --[[ Line: 237 ]]
                    -- upvalues: l_LocalPlayer_0 (ref), v34 (copy), v13 (ref), v30 (copy)
                    if l_LocalPlayer_0.Character:GetAttribute("Ragdolling") then
                        v34(0.1);
                        return;
                    else
                        local v40 = v13.AnimationType or l_LocalPlayer_0.Character.Humanoid.Health <= l_LocalPlayer_0.Character.Humanoid.MaxHealth / 2 and "Injured" or "";
                        local v41 = v13.Animations[("%*Idle"):format(v40)];
                        if v41 then
                            v41:Play(0.1);
                            table.insert(v30, v41);
                        end;
                        return;
                    end;
                end);
                local v42 = "";
                l_LocalPlayer_0.Character.Humanoid.Running:Connect(function(v43) --[[ Line: 252 ]]
                    -- upvalues: l_LocalPlayer_0 (ref), v13 (ref), v42 (ref), v35 (ref), v5 (ref), v34 (copy), v30 (copy)
                    if l_LocalPlayer_0.Character:GetAttribute("Ragdolling") then
                        return;
                    else
                        local v44 = v13.AnimationType or l_LocalPlayer_0.Character.Humanoid.Health <= l_LocalPlayer_0.Character.Humanoid.MaxHealth / 2 and "Injured" or "";
                        local v45 = v13.Animations[("%*Idle"):format(v44)];
                        local v46 = v13.Animations[("%*Walk"):format(v44)];
                        local v47 = v13.Animations[("%*Run"):format(v44)];
                        local v48 = v13.MovementAnimSpeed or v13.Config.MovementAnimSpeed;
                        if v48 then
                            v46:AdjustSpeed(v48);
                            v47:AdjustSpeed(v48);
                        else
                            v46:AdjustSpeed(v43 / (tonumber(v13.Speed) or 10));
                            v47:AdjustSpeed(v43 / (tonumber(v13.SprintSpeed) or 28));
                        end;
                        if v43 > 0.01 and (v42 ~= v44 or not v13.Moving) then
                            v35 = true;
                            v13.Moving = true;
                            if v5.IsSprinting then
                                v34(0.15);
                                v47:Play(0.15);
                                table.insert(v30, v47);
                            else
                                v34(0.15);
                                v46:Play(0.15);
                                table.insert(v30, v46);
                            end;
                        elseif v43 < 0.01 then
                            v13.Moving = nil;
                            v34(0.1);
                            v45:Play(0.1);
                            table.insert(v30, v45);
                        end;
                        v42 = v44;
                        return;
                    end;
                end);
                task.spawn(function() --[[ Line: 299 ]]
                    -- upvalues: v5 (ref), v13 (ref), l_LocalPlayer_0 (ref), v0 (ref), v4 (ref), v35 (ref), v34 (copy), v30 (copy)
                    local v49 = 0;
                    if v5.Character ~= v13.Rig or not v5.DefaultsSet then
                        repeat
                            v49 = v49 + game["Run Service"].Heartbeat:Wait();
                        until v5.Character == v13.Rig and v5.DefaultsSet or v49 >= 10;
                    end;
                    v5.SprintSpeed = v13.Config.SprintSpeed or v5.SprintSpeed;
                    v5.StaminaLoss = v13.Config.StaminaLoss or v5.StaminaLoss;
                    v5.StaminaGain = v13.Config.StaminaGain or v5.StaminaGain;
                    v5.MaxStamina = v13.Config.MaxStamina or v5.MaxStamina;
                    v5.MinStamina = v13.Config.MinStamina or v5.MinStamina;
                    v5.Stamina = v5.MaxStamina;
                    v5.__staminaChangedEvent:Fire(v5.MaxStamina);
                    if v5.MaxStamina ~= v5.MaxStamina or v5.Stamina ~= v5.Stamina then
                        task.spawn(function() --[[ Line: 319 ]]
                            -- upvalues: l_LocalPlayer_0 (ref)
                            l_LocalPlayer_0:Kick("\n\nSoulBuster 000:\nStamina exceeds max possible cap\n");
                        end);
                        while true do

                        end;
                    end;
                    local v50 = v13.Rig and v13.Rig.PrimaryPart;
                    if v13.ActorType:find("Killer") and v50 then
                        local v51 = 0;
                        do
                            local l_v51_0 = v51;
                            v0.Connections.StaminaDrainConnection = game["Run Service"].RenderStepped:Connect(function(v53) --[[ Line: 329 ]]
                                -- upvalues: l_v51_0 (ref), v4 (ref), v50 (copy), v5 (ref)
                                l_v51_0 = l_v51_0 + v53;
                                if l_v51_0 >= 0.1 then
                                    l_v51_0 = 0;
                                    local l_v4_ClosestPlayerFromPosition_0 = v4:GetClosestPlayerFromPosition(v50.Position, {
                                        MaxDistance = 100, 
                                        PlayerSelection = "Survivors", 
                                        OverrideUndetectable = true
                                    });
                                    if l_v4_ClosestPlayerFromPosition_0 and v5.StaminaLossDisabled then
                                        v5.StaminaLossDisabled = false;
                                        return;
                                    elseif not l_v4_ClosestPlayerFromPosition_0 and not v5.StaminaLossDisabled then
                                        v5.StaminaLossDisabled = true;
                                    end;
                                end;
                            end);
                        end;
                    end;
                    v0.Connections.SprintingConnection = v5.SprintToggled:Connect(function(v55, v56) --[[ Line: 344 ]]
                        -- upvalues: v13 (ref), v35 (ref), l_LocalPlayer_0 (ref), v34 (ref), v30 (ref)
                        if v13.Moving and v55 ~= v56 then
                            v35 = true;
                            local v57 = v13.AnimationType or l_LocalPlayer_0.Character.Humanoid.Health <= l_LocalPlayer_0.Character.Humanoid.MaxHealth / 2 and "Injured" or "";
                            local v58 = v13.Animations[("%*Walk"):format(v57)];
                            local v59 = v13.Animations[("%*Run"):format(v57)];
                            v34(0.3);
                            if v55 then
                                v59:Play(0.3);
                                table.insert(v30, v59);
                                return;
                            else
                                v58:Play(0.3);
                                table.insert(v30, v58);
                            end;
                        end;
                    end);
                    local l_SprintingButton_0 = l_LocalPlayer_0.PlayerGui.MainUI:FindFirstChild("SprintingButton");
                    local l_ShiftLockButton_0 = l_LocalPlayer_0.PlayerGui.MainUI:FindFirstChild("ShiftLockButton");
                    if l_SprintingButton_0 and l_SprintingButton_0.Visible then
                        l_SprintingButton_0.AnchorPoint = Vector2.new(0, 0);
                        l_SprintingButton_0.Size = UDim2.fromOffset(125, 125);
                        l_SprintingButton_0.Position = UDim2.new(1, -160, 1, -170);
                        l_ShiftLockButton_0.Position = UDim2.new(1, -135, 1, -4);
                        local l_AbilityContainer_0 = l_LocalPlayer_0.PlayerGui.MainUI:WaitForChild("AbilityContainer");
                        l_AbilityContainer_0.AnchorPoint = l_SprintingButton_0.AnchorPoint;
                        l_AbilityContainer_0.Position = l_SprintingButton_0.Position;
						l_AbilityContainer_0.Size = l_SprintingButton_0.Size + UDim2.fromScale(0.075, 0.075) -- UDim2.fromScale(0.075, 0.075);
                        Instance.new("UIAspectRatioConstraint").Parent = l_AbilityContainer_0;
                    end;
                end);
                local v63 = game.ReplicatedStorage.Systems.Player.UI.CustomBackpack.Backpack:Clone();
                v63.Name = "AbilityContainer";
                v63.Parent = l_LocalPlayer_0.PlayerGui.MainUI;
                v0.AbilityHotbar = v63;
                local v64 = v13.Behavior.Abilities or {};
                local l_pairs_0 = pairs;
                local v66 = v13.CustomBehavior.Abilities or {};
                for v67, v68 in l_pairs_0(v66) do
                    v64[v67] = v68;
                end;
                v13.Cooldowns = {};
                v0.Connections.CooldownConnection = game["Run Service"].RenderStepped:Connect(function(v69) --[[ Line: 396 ]]
                    -- upvalues: v13 (ref), v64 (copy), v63 (copy)
                    for v70, v71 in pairs(v13.Cooldowns) do
                        local v72 = v64[v70] or {};
                        local l_Duration_0 = v71.Duration;
                        local l_TimePast_0 = v71.TimePast;
                        local v75 = math.clamp(l_TimePast_0 / l_Duration_0, 0, 1);
                        local v76 = l_Duration_0 - l_TimePast_0;
                        if v75 >= 1 then
                            v13.Cooldowns[v70] = nil;
                        end;
                        local v77 = v75 == 0 and 0 or 1 / v75;
                        local l_v63_FirstChild_0 = v63:FindFirstChild(v70);
                        if l_v63_FirstChild_0 and not v72.Disabled then
                            l_v63_FirstChild_0.Clipping.Size = UDim2.fromScale(1, v75);
                            l_v63_FirstChild_0.Clipping.Top.Size = UDim2.fromScale(1, v77);
                            l_v63_FirstChild_0.CooldownTime.Text = v75 >= 1 and "" or ("%*"):format(v76 < 10 and string.format("%.1f", l_Duration_0 - l_TimePast_0) or math.round(v76));
                        end;
                        v71.TimePast = v71.TimePast + v69;
                    end;
                end);
                l_pairs_0 = nil;
                v66 = require(game.ReplicatedStorage.Modules.Device);
                if v66:GetPlayerDevice() == "Mobile" then
                    local l_UIListLayout_0 = v63:FindFirstChild("UIListLayout");
                    if l_UIListLayout_0 then
                        l_UIListLayout_0:Destroy();
                    end;
                    l_pairs_0 = script.ButtonPath:Clone();
                    l_pairs_0.Parent = v63;
                end;
                local v80 = require(game.ReplicatedStorage.Initializer);
                local l_pairs_1 = pairs;
                local v82 = v64 or {};
                for v83, v84 in l_pairs_1(v82) do
                    local function v85() --[[ Line: 437 ]] --[[ Name: useAbility ]]
                        -- upvalues: v2 (ref), v83 (copy)
                        v2:FireServerConnection("UseActorAbility", "REMOTE_EVENT", v83);
                    end;
                    local v86 = game.ReplicatedStorage.Assets.UI.AbilityIcon:Clone();
                    v86.Clipping.Top.Image = v84.Icon or "rbxassetid://114519105023135";
                    v86.Image = v84.Icon or "rbxassetid://114519105023135";
                    v86.LayoutOrder = v84.LayoutOrder;
                    v86.AbilityName.Text = v83:gsub("(%l)(%u)", "%1 %2");
                    v86.Name = v83;
                    v86.Parent = v63;
                    v86.MouseButton1Click:Connect(v85);
                    if v84.Charges then
                        v86.Charges.Text = tostring(v84.Charges);
                        if v84.Charges <= 0 then
                            v4:ToggleLockForAbilityIcon(v83, "NoCharges", true);
                        end;
                    end;
                    if l_pairs_0 then
                        v86.KeybindName.Visible = false;
                        v86.AnchorPoint = Vector2.new(0.5, 0.5);
                        v86.Size = UDim2.fromScale(0.45, 0.45);
                    end;
                    local l_Backpack_0 = l_LocalPlayer_0.PlayerGui.MainUI:FindFirstChild("Backpack");
                    if l_Backpack_0 and not l_pairs_0 then
                        l_Backpack_0.Position = UDim2.new(1, -20, 0.9, -55);
                    end;
                    local v88 = {};
                    local l_KeybindType_0 = v84.KeybindType;
                    if l_KeybindType_0 then
                        for _, v91 in pairs({
                            v80.PlayerSettings[l_KeybindType_0], 
                            v80.PlayerSettings[("%*~Console"):format(l_KeybindType_0)]
                        }) do
                            table.insert(v88, v91.Value);
                        end;
                    end;
                    local v92 = {
                        {
                            "MouseButton1", 
                            "LMB"
                        }, 
                        {
                            "MouseButton2", 
                            "RMB"
                        }, 
                        {
                            "MouseButton3", 
                            "MMB"
                        }, 
                        {
                            "Button", 
                            "", 
                            true
                        }
                    };
                    local function v99() --[[ Line: 491 ]] --[[ Name: updateKeybindTexts ]]
                        -- upvalues: v66 (copy), v80 (copy), l_KeybindType_0 (copy), v86 (copy), v92 (copy)
                        local v93 = v66:GetPlayerDevice() == "PC" and v80.PlayerSettings[l_KeybindType_0] or v66:GetPlayerDevice() == "Console" and v80.PlayerSettings[("%*~Console"):format(l_KeybindType_0)];
                        if not v93 then
                            v86.KeybindName.Text = "";
                            return;
                        else
                            local v94 = tostring(v93.Value);
                            for _, v96 in pairs(v92) do
                                local v97 = v96[1];
                                local v98 = v96[2];
                                if not v96[3] or v66:GetPlayerDevice() == "Console" then
                                    v94 = v94:gsub(v97, v98);
                                end;
                            end;
                            v86.KeybindName.Text = v94:gsub("(%l)(%u)", "%1 %2");
                            return;
                        end;
                    end;
                    v99();
                    v0.Connections[("%*KeybindUpdatedConnection"):format(v83)] = v66.Changed:Connect(v99);
                    v0.Connections[("%*InputConnection"):format(v83)] = game.UserInputService.InputBegan:Connect(function(v100, v101) --[[ Line: 508 ]]
                        -- upvalues: v88 (copy), v2 (ref), v83 (copy)
                        if v101 then
                            return;
                        else
                            if table.find(v88, v100.KeyCode.Name) or table.find(v88, v100.UserInputType.Name) then
                                v2:FireServerConnection("UseActorAbility", "REMOTE_EVENT", v83);
                            end;
                            return;
                        end;
                    end);
                end;
                task.delay(0.25, function() --[[ Line: 517 ]]
					-- upvalues: l_pairs_0 (ref), v63 (copy)
					while l_pairs_0 and l_pairs_0.Parent and v63.Parent do
						local _ = #l_pairs_0:GetControlPoints()
                        local v103 = {};
                        for _, v105 in v63:GetChildren() do
                            if v105:IsA("GuiObject") then
                                table.insert(v103, v105);
                            end;
						end;
						--
                        table.sort(v103, function(v106, v107) --[[ Line: 528 ]]
                            return v106.LayoutOrder < v107.LayoutOrder;
						end);
						--
						for v108, v109 in pairs(v103) do				
							local Catt = v108 / (#v103 + 1)
							v109.Position = l_pairs_0:GetPositionOnCurveArcLength(Catt);
                        end;
                        task.wait(1);
                    end;
                end);
                return;
            end;
        end);
        v3.__actorCreated:Fire(v13);
    end);
    v2:SetConnection("UpdateAbilityCharges", "REMOTE_EVENT", function(v111, v112) --[[ Line: 545 ]]
        -- upvalues: v3 (ref), l_LocalPlayer_0 (ref), v0 (ref), v4 (ref)
        local v113 = v3.CurrentActors[l_LocalPlayer_0];
        if not v113 then
            return;
        else
            local v114 = v113.CustomBehavior.Abilities or {};
            local v115 = v113.Behavior.Abilities or {};
            local v116 = v114[v111] or v115[v111];
            local v117 = v0.AbilityHotbar and v0.AbilityHotbar:FindFirstChild(v111);
            local v118 = v113 and v113.Cooldowns and v113.Cooldowns[v111];
            if v116 and v117 then
                if v112 <= 0 then
                    v116.Disabled = true;
                    v117.Clipping.Size = UDim2.fromScale(1, 0);
                    v117.Clipping.Top.Size = UDim2.fromScale(1, 0);
                    v117.Charges.Text = tostring(v112);
                    v117.CooldownTime.Text = "";
                    v4:ToggleLockForAbilityIcon(v111, "NoCharges", true);
                    return;
                elseif v112 > 0 then
                    v116.Disabled = false;
                    v117.Clipping.Size = v118 and v117.Clipping.Size or UDim2.fromScale(1, 1);
                    v117.Clipping.Top.Size = v118 and v117.Clipping.Top.Size or UDim2.fromScale(1, 1);
                    v117.Charges.Text = tostring(v112);
                    v117.CooldownTime.Text = "";
                    v4:ToggleLockForAbilityIcon(v111, "NoCharges", false);
                end;
            end;
            return;
        end;
    end);
    v2:SetConnection("UpdateAbilityCooldown", "REMOTE_EVENT", function(v119, v120) --[[ Line: 576 ]]
        -- upvalues: v3 (ref), l_LocalPlayer_0 (ref)
        local v121 = v3.CurrentActors[l_LocalPlayer_0];
        if not v121 then
            return;
        else
            local v122 = v121.CustomBehavior.Abilities or {};
            local v123 = v121.Behavior.Abilities or {};
            if (v122[v119] or v123[v119]) and v121.Cooldowns then
                if v120 < 0 then
                    if v121.Cooldowns[v119] then
                        local v124 = v121.Cooldowns[v119];
                        v124.TimePast = v124.TimePast + math.abs(v120);
                        return;
                    end;
                else
                    v121.Cooldowns[v119] = {
                        Duration = v120, 
                        TimePast = 0
                    };
                end;
            end;
            return;
        end;
    end);
    v2:SetConnection("UseActorAbility", "REMOTE_EVENT", function(v125, v126) --[[ Line: 596 ]]
        local v127 = v3.CurrentActors[l_LocalPlayer_0];
        if not v127 then
            return;
        else
            local v128 = v127.CustomBehavior.Abilities or {};
            local v129 = v127.Behavior.Abilities or {};
            local v130 = v128[v125] or v129[v125];
            local v131 = tonumber(v126 and typeof(v126) == "table" and v126.Cooldown or typeof(v130.Cooldown) == "function" and v130.Cooldown(v127, v125) or v130.Cooldown or v127.Config[("%*Cooldown"):format(v125)]);
		  
		    if typeof(v126) == "table" and v126.Cancelled then
                v131 = 0;
			end;
			
            if v126 == "Cancelled" then
                v131 = 0;
			end;
									
            if v131 and v131 > 0 and (not v127.Cooldowns[v125] or v127.Cooldowns[v125].TimePast > 0.025) and not workspace:GetAttribute("CooldownsDisabled") then
                v127.Cooldowns[v125] = {
                    Duration = v131, 
                    TimePast = 0
				};
			end;
			
            v130.Callback(v127, v126);
            return;
        end;
    end);
    l_LocalPlayer_0.CharacterAdded:Connect(function(v132) --[[ Line: 630 ]]
        if v132.Parent == workspace or v132.Parent == workspace.Players.Spectating then
            v0:Destroy();
        end;
    end);
end;

v0.Destroy = function(_) --[[ Line: 638 ]] --[[ Name: Destroy ]]
    -- upvalues: v0 (copy)
    if v0.AbilityHotbar then
        v0.AbilityHotbar:Destroy();
    end;
    for _, v135 in pairs(v0.Connections) do
        v135:Disconnect();
        v135 = nil;
    end;
    table.clear(v0.Connections);
end;

return v0;