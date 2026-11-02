-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

task.wait();
local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_GroupService_0 = game:GetService("GroupService");
local l_Knit_0 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"));
local v5 = require(l_ReplicatedStorage_0.Frameworks.Notifications);
local v6 = require(l_ReplicatedStorage_0["Math Utility"]);
local l_Signals_0 = require(l_ReplicatedStorage_0:WaitForChild("Signals"));
local l_Shared_0 = require(l_ReplicatedStorage_0:WaitForChild("Shared"));
local v9 = l_Knit_0.CreateController({
    Name = "ChestController"
});
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_HeadShot_0 = Enum.ThumbnailType.HeadShot;
local l_Size100x100_0 = Enum.ThumbnailSize.Size100x100;
local function v13(...) --[[ Line: 24 ]] --[[ Name: warnf ]]
    warn("[ChestController]", ...);
end;
local _ = function(v14, v15) --[[ Line: 28 ]] --[[ Name: getChildByNames ]]
    for _, v17 in ipairs(v15) do
        local l_v14_FirstChild_0 = v14:FindFirstChild(v17);
        if l_v14_FirstChild_0 then
            return l_v14_FirstChild_0;
        end;
    end;
    return nil;
end;
v9.KnitInit = function(v20) --[[ Line: 38 ]] --[[ Name: KnitInit ]]
    v20.ChestService = nil;
    v20.PlayerGui = nil;
    v20.Hud = nil;
    v20.ChestTimer = nil;
    v20.ScreenFrames = nil;
    v20.GroupRewardsFrame = nil;
    v20.MainHolder = nil;
    v20.CheckButton = nil;
    v20.ScrollingFrame = nil;
    v20.CloseButton = nil;
    v20.Chest = nil;
    v20.ChestModel = nil;
    v20.Hitbox = nil;
    v20.Billboard = nil;
    v20.TimerFrame = nil;
    v20.ClaimFrame = nil;
    v20.ChestHighlight = nil;
    v20.GroupOnlyLabel = nil;
    v20.TimerLabel = nil;
    v20.ChestHighlightStart = nil;
    v20.ChestHighlightEnd = nil;
    v20.ChestShrink = nil;
    v20.ChestOvershoot = nil;
    v20.ChestSettle = nil;
    v20.TouchDebounce = false;
    v20.OnCooldown = false;
    v20.NextClaimTime = 0;
    v20.InsideChestZone = false;
    v20.InGroup = false;
    v20.IsPromptingGroupJoin = false;
    v20.ReadyNotificationShown = false;
    v20.HasChestState = false;
    v20.SyncPending = true;
end;
v9.KnitStart = function(v21) --[[ Line: 81 ]] --[[ Name: KnitStart ]]
    -- upvalues: l_Knit_0 (copy)
    v21.ChestService = l_Knit_0.GetService("ChestService");
    v21:_grabRefs();
    v21:_setupTweens();
    v21:_hookProfileIcons();
    v21:_bindUi();
    v21:_bindWorld();
    v21:_bindSignals();
    v21:_setChestVisual("locked");
    v21:_requestSync();
end;
v9._grabRefs = function(v22) --[[ Line: 95 ]] --[[ Name: _grabRefs ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    local v23 = false;
    local v24 = false;
    v22.PlayerGui = l_LocalPlayer_0:WaitForChild("PlayerGui");
    v22.Hud = v22.PlayerGui:WaitForChild("Hud");
    v22.ChestTimer = v22.Hud:WaitForChild("ChestTimer");
    v22.ScreenFrames = v22.PlayerGui:WaitForChild("ScreenFrames");
    v22.GroupRewardsFrame = v22.ScreenFrames:WaitForChild("GroupRewards");
    v22.MainHolder = v22.GroupRewardsFrame:WaitForChild("MainHolder");
    v22.CheckButton = v22.MainHolder:WaitForChild("CheckButton");
    v22.ScrollingFrame = v22.MainHolder:WaitForChild("ScrollingFrame");
    v22.CloseButton = v22.GroupRewardsFrame:WaitForChild("CloseButton");
    v22.Chest = workspace.Map:WaitForChild("Chest");
    v22.ChestModel = v22.Chest:WaitForChild("Chest");
    v22.Hitbox = v22.Chest:WaitForChild("Hitbox");
    v22.Billboard = v22.ChestModel:WaitForChild("TimeBillboard");
    v22.TimerFrame = v22.Billboard:WaitForChild("Frame");
    v22.ClaimFrame = v22.Billboard:WaitForChild("ClaimFrame");
    v22.ChestHighlight = v22.ChestModel:WaitForChild("Highlight");
    local l_Billboard_0 = v22.Billboard;
    local v26;
    for _, v28 in ipairs({
        "Text", 
        "GroupOnlyLabel", 
        "Label"
    }) do
        local l_l_Billboard_0_FirstChild_0 = l_Billboard_0:FindFirstChild(v28);
        if l_l_Billboard_0_FirstChild_0 then
            v26 = l_l_Billboard_0_FirstChild_0;
            v23 = true;
        end;
        if v23 then
            break;
        end;
    end;
    if not v23 then
        v26 = nil;
    end;
    v23 = false;
    local l_TimerFrame_0 = v22.TimerFrame;
    for _, v32 in ipairs({
        "TimerText", 
        "TextLabel", 
        "Text"
    }) do
        local l_l_TimerFrame_0_FirstChild_0 = l_TimerFrame_0:FindFirstChild(v32);
        if l_l_TimerFrame_0_FirstChild_0 then
            l_Billboard_0 = l_l_TimerFrame_0_FirstChild_0;
            v24 = true;
        end;
        if v24 then
            break;
        end;
    end;
    if not v24 then
        l_Billboard_0 = nil;
    end;
    v24 = false;
    assert(v26 and v26:IsA("TextLabel"), "[ChestController] Missing Billboard group-only TextLabel");
    assert(l_Billboard_0 and l_Billboard_0:IsA("TextLabel"), "[ChestController] Missing Timer TextLabel inside Billboard.Frame");
    v22.GroupOnlyLabel = v26;
    v22.TimerLabel = l_Billboard_0;
    v22.GroupRewardsFrame.Visible = false;
end;
v9._setupTweens = function(v34) --[[ Line: 129 ]] --[[ Name: _setupTweens ]]
    -- upvalues: l_TweenService_0 (copy)
    v34.ChestHighlightStart = l_TweenService_0:Create(v34.ChestHighlight, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        FillTransparency = 0
    });
    v34.ChestHighlightEnd = l_TweenService_0:Create(v34.ChestHighlight, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        FillTransparency = 1
    });
    local l_Size_0 = v34.ChestModel.Size;
    local v36 = l_Size_0 * 0.4;
    local v37 = l_Size_0 * 1.08;
    v34.ChestShrink = l_TweenService_0:Create(v34.ChestModel, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = v36
    });
    v34.ChestOvershoot = l_TweenService_0:Create(v34.ChestModel, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = v37
    });
    v34.ChestSettle = l_TweenService_0:Create(v34.ChestModel, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = l_Size_0
    });
end;
v9._setIconFromUserId = function(_, v39, v40) --[[ Line: 166 ]] --[[ Name: _setIconFromUserId ]]
    -- upvalues: l_Players_0 (copy), l_HeadShot_0 (copy), l_Size100x100_0 (copy), v13 (copy)
    if v40 <= 0 then
        return;
    else
        local l_status_0, l_result_0 = pcall(function() --[[ Line: 171 ]]
            -- upvalues: l_Players_0 (ref), v40 (copy), l_HeadShot_0 (ref), l_Size100x100_0 (ref)
            return l_Players_0:GetUserThumbnailAsync(v40, l_HeadShot_0, l_Size100x100_0);
        end);
        if not l_status_0 then
            v13("Failed to get thumbnail for userId", v40, l_result_0);
            return;
        else
            if l_result_0 and l_result_0 ~= "" then
                v39.Image = l_result_0;
            end;
            return;
        end;
    end;
end;
v9._updateProfileIcon = function(v43, v44) --[[ Line: 185 ]] --[[ Name: _updateProfileIcon ]]
    -- upvalues: v13 (copy)
    if not v44:IsA("ImageLabel") then
        return;
    else
        local l_v44_Attribute_0 = v44:GetAttribute("Id");
        local v46 = tonumber(l_v44_Attribute_0);
        if not v46 then
            v13("Icon missing valid Id attribute:", v44:GetFullName(), "rawId=", l_v44_Attribute_0);
            return;
        else
            v43:_setIconFromUserId(v44, v46);
            return;
        end;
    end;
end;
v9._hookProfileIcon = function(v47, v48) --[[ Line: 201 ]] --[[ Name: _hookProfileIcon ]]
    if not v48:IsA("ImageLabel") or v48.Name ~= "Icn" then
        return;
    else
        v47:_updateProfileIcon(v48);
        v48:GetAttributeChangedSignal("Id"):Connect(function() --[[ Line: 208 ]]
            -- upvalues: v47 (copy), v48 (copy)
            v47:_updateProfileIcon(v48);
        end);
        return;
    end;
end;
v9._hookProfileIcons = function(v49) --[[ Line: 213 ]] --[[ Name: _hookProfileIcons ]]
    for _, v51 in ipairs(v49.ScrollingFrame:GetDescendants()) do
        v49:_hookProfileIcon(v51);
    end;
    v49.ScrollingFrame.DescendantAdded:Connect(function(v52) --[[ Line: 218 ]]
        -- upvalues: v49 (copy)
        v49:_hookProfileIcon(v52);
    end);
end;
v9._setGroupRewardsVisible = function(v53, v54) --[[ Line: 223 ]] --[[ Name: _setGroupRewardsVisible ]]
    v53.GroupRewardsFrame.Visible = v54;
end;
v9._refreshGroupRewardsVisibility = function(v55) --[[ Line: 227 ]] --[[ Name: _refreshGroupRewardsVisibility ]]
    if v55.SyncPending then
        v55:_setGroupRewardsVisible(false);
        return;
    elseif v55.InsideChestZone and not v55.InGroup then
        v55:_setGroupRewardsVisible(true);
        return;
    else
        v55:_setGroupRewardsVisible(false);
        return;
    end;
end;
v9._setChestVisual = function(v56, v57, v58) --[[ Line: 240 ]] --[[ Name: _setChestVisual ]]
    -- upvalues: v5 (copy), v6 (copy)
    if v57 == "locked" then
        v56.GroupOnlyLabel.Visible = true;
        v56.GroupOnlyLabel.Text = "Group Only";
        v56.TimerFrame.Visible = false;
        v56.ClaimFrame.Visible = false;
        v56.ChestTimer.Text = "GROUP ONLY";
        v56.ChestTimer.TextColor3 = Color3.fromRGB(255, 200, 0);
        local l_RainbowGradient_0 = v56.ChestTimer:FindFirstChild("RainbowGradient");
        if l_RainbowGradient_0 and l_RainbowGradient_0:IsA("UIGradient") then
            l_RainbowGradient_0.Enabled = false;
        end;
        local l_UIStroke_0 = v56.ChestTimer:FindFirstChildOfClass("UIStroke");
        if l_UIStroke_0 then
            l_UIStroke_0.Color = Color3.fromRGB(120, 85, 0);
        end;
        v56.ReadyNotificationShown = false;
        return;
    else
        v56.GroupOnlyLabel.Visible = false;
        v56.TimerFrame.Visible = true;
        if v57 == "ready" then
            v56.TimerLabel.Text = "\240\159\142\129 READY!";
            v56.ClaimFrame.Visible = true;
            v56.ChestTimer.Text = "CHEST READY!";
            v56.ChestTimer.TextColor3 = Color3.fromRGB(255, 255, 255);
            local l_RainbowGradient_1 = v56.ChestTimer:FindFirstChild("RainbowGradient");
            if l_RainbowGradient_1 and l_RainbowGradient_1:IsA("UIGradient") then
                l_RainbowGradient_1.Enabled = true;
            end;
            local l_UIStroke_1 = v56.ChestTimer:FindFirstChildOfClass("UIStroke");
            if l_UIStroke_1 then
                l_UIStroke_1.Color = Color3.fromRGB(58, 58, 58);
            end;
            if not v56.ReadyNotificationShown then
                v56.ReadyNotificationShown = true;
                v5.New("CHEST READY TO CLAIM", "Spin");
            end;
            return;
        else
            if v57 == "cooldown" then
                v56.ClaimFrame.Visible = false;
                local v63 = v6.FormatSecondsIntoCleanTime(v58 or 0);
                v56.TimerLabel.Text = v63;
                v56.ChestTimer.Text = "CHEST - " .. v63;
                v56.ChestTimer.TextColor3 = Color3.fromRGB(0, 255, 0);
                local l_RainbowGradient_2 = v56.ChestTimer:FindFirstChild("RainbowGradient");
                if l_RainbowGradient_2 and l_RainbowGradient_2:IsA("UIGradient") then
                    l_RainbowGradient_2.Enabled = false;
                end;
                local l_UIStroke_2 = v56.ChestTimer:FindFirstChildOfClass("UIStroke");
                if l_UIStroke_2 then
                    l_UIStroke_2.Color = Color3.fromRGB(0, 76, 0);
                end;
                v56.ReadyNotificationShown = false;
            end;
            return;
        end;
    end;
end;
v9._syncCooldown = function(v66, v67) --[[ Line: 316 ]] --[[ Name: _syncCooldown ]]
    -- upvalues: v13 (copy)
    if typeof(v67) ~= "table" then
        v13("syncCooldown got invalid payload, ignoring:", v67);
        return;
    else
        local v68 = tonumber(v67.Remaining) or 0;
        local v69 = v67.InGroup == true;
        v66.HasChestState = true;
        v66.SyncPending = false;
        v66.InGroup = v69;
        if not v66.InGroup then
            v66.OnCooldown = false;
            v66.NextClaimTime = 0;
            v66:_setChestVisual("locked");
        elseif v68 > 0 then
            v66.OnCooldown = true;
            v66.NextClaimTime = time() + v68;
            v66:_setChestVisual("cooldown", v68);
        else
            v66.OnCooldown = false;
            v66.NextClaimTime = 0;
            v66:_setChestVisual("ready");
        end;
        v66:_refreshGroupRewardsVisibility();
        return;
    end;
end;
v9._isInsideHitbox = function(v70) --[[ Line: 347 ]] --[[ Name: _isInsideHitbox ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    local l_Character_0 = l_LocalPlayer_0.Character;
    if not l_Character_0 then
        return false;
    else
        local l_HumanoidRootPart_0 = l_Character_0:FindFirstChild("HumanoidRootPart");
        if not l_HumanoidRootPart_0 or not l_HumanoidRootPart_0:IsA("BasePart") then
            return false;
        else
            return (l_HumanoidRootPart_0.Position - v70.Hitbox.Position).Magnitude <= 25;
        end;
    end;
end;
v9._isLocalCharacterFromPart = function(_, v74) --[[ Line: 362 ]] --[[ Name: _isLocalCharacterFromPart ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    local l_v74_FirstAncestorOfClass_0 = v74:FindFirstAncestorOfClass("Model");
    local v76 = false;
    if l_v74_FirstAncestorOfClass_0 ~= nil then
        v76 = l_v74_FirstAncestorOfClass_0 == l_LocalPlayer_0.Character;
    end;
    return v76;
end;
v9._playChestClaimSequence = function(v77) --[[ Line: 367 ]] --[[ Name: _playChestClaimSequence ]]
    -- upvalues: l_Signals_0 (copy), l_ReplicatedStorage_0 (copy)
    v77.ChestHighlight.FillTransparency = 1;
    v77.ChestHighlight.Enabled = true;
    v77.ChestHighlightStart:Play();
    task.spawn(function() --[[ Line: 372 ]]
        -- upvalues: l_Signals_0 (ref)
        l_Signals_0.PlayConfetti:Fire();
    end);
    local l_Assets_0 = l_ReplicatedStorage_0:FindFirstChild("Assets");
    if l_Assets_0 and l_Assets_0:FindFirstChild("Sounds") then
        local l_Sounds_0 = l_Assets_0.Sounds;
        if l_Sounds_0:FindFirstChild("PurchaseSound") then
            l_Sounds_0.PurchaseSound:Play();
        end;
        if l_Sounds_0:FindFirstChild("Gadget") then
            l_Sounds_0.Gadget:Play();
        end;
        task.delay(0.5, function() --[[ Line: 388 ]]
            -- upvalues: l_Sounds_0 (copy)
            if l_Sounds_0:FindFirstChild("XP") then
                l_Sounds_0.XP:Play();
            end;
        end);
    end;
    v77.ChestShrink:Play();
    v77.ChestShrink.Completed:Once(function() --[[ Line: 396 ]]
        -- upvalues: v77 (copy)
        v77.ChestOvershoot:Play();
        v77.ChestOvershoot.Completed:Once(function() --[[ Line: 398 ]]
            -- upvalues: v77 (ref)
            v77.ChestSettle:Play();
        end);
    end);
    task.delay(0.5, function() --[[ Line: 403 ]]
        -- upvalues: v77 (copy)
        v77.ChestHighlightEnd:Play();
    end);
end;
v9._tryClaimChest = function(v80) --[[ Line: 408 ]] --[[ Name: _tryClaimChest ]]
    if v80.TouchDebounce then
        return;
    elseif v80.SyncPending or not v80.HasChestState then
        return;
    elseif not v80.InGroup then
        v80:_refreshGroupRewardsVisibility();
        return;
    elseif v80.OnCooldown then
        return;
    else
        v80.TouchDebounce = true;
        task.spawn(function() --[[ Line: 428 ]]
            -- upvalues: v80 (copy)
            local v81, v82, v83 = pcall(function() --[[ Line: 429 ]]
                -- upvalues: v80 (ref)
                return v80.ChestService:RequestClaim();
            end);
            if v81 then
                if v82 then
                    v80:_syncCooldown({
                        Remaining = v83 and v83.Cooldown or 300, 
                        InGroup = true
                    });
                    v80:_playChestClaimSequence();
                    return;
                elseif typeof(v83) == "table" then
                    if v83.Reason == "Cooldown" and v83.Remaining then
                        v80:_syncCooldown({
                            Remaining = v83.Remaining, 
                            InGroup = v80.InGroup
                        });
                        return;
                    elseif v83.Reason == "NotInGroup" then
                        v80.InGroup = false;
                        v80.OnCooldown = false;
                        v80.NextClaimTime = 0;
                        v80.SyncPending = false;
                        v80:_setChestVisual("locked");
                        v80:_refreshGroupRewardsVisibility();
                    end;
                end;
            end;
        end);
        task.delay(0.75, function() --[[ Line: 458 ]]
            -- upvalues: v80 (copy)
            v80.TouchDebounce = false;
        end);
        return;
    end;
end;
v9._requestSync = function(v84) --[[ Line: 463 ]] --[[ Name: _requestSync ]]
    -- upvalues: v13 (copy)
    local l_status_1, l_result_1 = pcall(function() --[[ Line: 464 ]]
        -- upvalues: v84 (copy)
        return v84.ChestService:RequestSync();
    end);
    if not l_status_1 then
        v13("requestSync failed:", l_result_1);
        return;
    elseif typeof(l_result_1) == "table" then
        v84:_syncCooldown(l_result_1);
        return;
    elseif l_result_1 and type(l_result_1.andThen) == "function" then
        l_result_1:andThen(function(v87) --[[ Line: 479 ]]
            -- upvalues: v84 (copy), v13 (ref)
            if typeof(v87) == "table" then
                v84:_syncCooldown(v87);
                return;
            else
                v13("requestSync promise resolved with invalid payload:", v87);
                return;
            end;
        end):catch(function(v88) --[[ Line: 485 ]]
            -- upvalues: v13 (ref)
            v13("requestSync promise rejected:", v88);
        end);
        return;
    else
        if l_result_1 ~= nil then
            v13("requestSync returned unexpected value:", l_result_1);
        end;
        return;
    end;
end;
v9._bindSignals = function(v89) --[[ Line: 497 ]] --[[ Name: _bindSignals ]]
    v89.ChestService.CooldownSynced:Connect(function(v90) --[[ Line: 498 ]]
        -- upvalues: v89 (copy)
        v89:_syncCooldown(v90);
    end);
end;
v9._bindUi = function(v91) --[[ Line: 503 ]] --[[ Name: _bindUi ]]
    -- upvalues: l_GroupService_0 (copy), l_Shared_0 (copy), v13 (copy)
    v91.CheckButton.Activated:Connect(function() --[[ Line: 504 ]]
        -- upvalues: v91 (copy), l_GroupService_0 (ref), l_Shared_0 (ref), v13 (ref)
        if v91.IsPromptingGroupJoin then
            return;
        elseif v91.InGroup then
            v91:_setGroupRewardsVisible(false);
            return;
        else
            v91.IsPromptingGroupJoin = true;
            local l_status_2, l_result_2 = pcall(function() --[[ Line: 516 ]]
                -- upvalues: l_GroupService_0 (ref), l_Shared_0 (ref)
                return l_GroupService_0:PromptJoinAsync(l_Shared_0.GroupId);
            end);
            if not l_status_2 then
                v13("PromptJoinAsync failed:", l_result_2);
            end;
            task.delay(2, function() --[[ Line: 524 ]]
                -- upvalues: v91 (ref)
                v91:_requestSync();
            end);
            task.delay(5, function() --[[ Line: 528 ]]
                -- upvalues: v91 (ref)
                v91.IsPromptingGroupJoin = false;
                v91:_requestSync();
                v91:_refreshGroupRewardsVisibility();
            end);
            return;
        end;
    end);
    v91.CloseButton.Activated:Connect(function() --[[ Line: 535 ]]
        -- upvalues: v91 (copy)
        v91:_setGroupRewardsVisible(false);
    end);
end;
v9._bindWorld = function(v94) --[[ Line: 540 ]] --[[ Name: _bindWorld ]]
    -- upvalues: v6 (copy), l_LocalPlayer_0 (copy)
    task.spawn(function() --[[ Line: 541 ]]
        -- upvalues: v94 (copy), v6 (ref)
        while true do
            if v94.OnCooldown then
                local v95 = math.max(0, (math.ceil(v94.NextClaimTime - time())));
                if v95 <= 0 then
                    v94.OnCooldown = false;
                    v94.NextClaimTime = 0;
                    if v94.InGroup and v94.HasChestState and not v94.SyncPending then
                        v94:_setChestVisual("ready");
                    else
                        v94:_setChestVisual("locked");
                    end;
                else
                    local v96 = v6.FormatSecondsIntoCleanTime(v95);
                    v94.TimerLabel.Text = v96;
                    v94.ChestTimer.Text = "CHEST - " .. v96;
                end;
            end;
            task.wait(1);
        end;
    end);
    task.spawn(function() --[[ Line: 566 ]]
        -- upvalues: v94 (copy)
        while true do
            local v97 = v94:_isInsideHitbox();
            if v97 ~= v94.InsideChestZone then
                v94.InsideChestZone = v97;
                v94:_refreshGroupRewardsVisibility();
            end;
            task.wait(0.2);
        end;
    end);
    v94.Hitbox.Touched:Connect(function(v98) --[[ Line: 579 ]]
        -- upvalues: v94 (copy), l_LocalPlayer_0 (ref)
        if not v98 then
            return;
        elseif not v94:_isLocalCharacterFromPart(v98) then
            return;
        else
            local l_Character_1 = l_LocalPlayer_0.Character;
            if not l_Character_1 then
                return;
            else
                local l_Humanoid_0 = l_Character_1:FindFirstChildOfClass("Humanoid");
                if not l_Humanoid_0 or l_Humanoid_0.Health <= 0 then
                    return;
                elseif v94.SyncPending then
                    return;
                else
                    v94.InsideChestZone = true;
                    v94:_refreshGroupRewardsVisibility();
                    v94:_tryClaimChest();
                    return;
                end;
            end;
        end;
    end);
    l_LocalPlayer_0.CharacterAdded:Connect(function() --[[ Line: 607 ]]
        -- upvalues: v94 (copy), l_LocalPlayer_0 (ref)
        v94.SyncPending = true;
        v94.TouchDebounce = false;
        if v94.OnCooldown and v94.NextClaimTime > time() then
            local v101 = math.max(0, (math.ceil(v94.NextClaimTime - time())));
            v94:_setChestVisual("cooldown", v101);
        else
            v94:_setChestVisual("locked");
        end;
        v94:_refreshGroupRewardsVisibility();
        task.defer(function() --[[ Line: 620 ]]
            -- upvalues: l_LocalPlayer_0 (ref), v94 (ref)
            if l_LocalPlayer_0.Parent then
                v94:_requestSync();
            end;
        end);
        task.delay(1, function() --[[ Line: 626 ]]
            -- upvalues: l_LocalPlayer_0 (ref), v94 (ref)
            if l_LocalPlayer_0.Parent then
                v94:_requestSync();
            end;
        end);
    end);
end;
return v9;