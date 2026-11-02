-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_Lighting_0 = game:GetService("Lighting");
local l_SocialService_0 = game:GetService("SocialService");
local v6 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit")).CreateController({
    Name = "UIManager"
});
local v7 = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local v8 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local v9 = TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
local v10 = TweenInfo.new(0.22, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
local v11 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
local v12 = TweenInfo.new(0.18, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local v13 = TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.In);
local v14 = TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local v15 = UDim2.new(-0.5, 0, 0.5, 0);
local v16 = UDim2.new(0.5, 0, 1.2, 0);
local v17 = UDim2.new(1.2, 0, 0.511, 0);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
v6.KnitInit = function(v19) --[[ Line: 47 ]] --[[ Name: KnitInit ]]
    v19.PlayerGui = nil;
    v19.UISounds = nil;
    v19.Hud = nil;
    v19.InventoryHud = nil;
    v19.LeftSide = nil;
    v19.RankBar = nil;
    v19.AuraBoost = nil;
    v19.ScreenFrames = nil;
    v19.PosesVenderFrame = nil;
    v19.TitlesFrame = nil;
    v19.ShopFrame = nil;
    v19.SettingsFrame = nil;
    v19.ProfileFrame = nil;
    v19.MenuBtns = nil;
    v19.ShopBtn = nil;
    v19.SettingsBtn = nil;
    v19.StatsBtn = nil;
    v19.InviteBtn = nil;
    v19.LeftSideOriginalPos = nil;
    v19.RankBarOriginalPos = nil;
    v19.AuraBoostOriginalPos = nil;
    v19.Camera = nil;
    v19.Blur = nil;
    v19.OverlayGui = nil;
    v19.OverlayFrame = nil;
    v19.BoundButtons = {};
    v19.WatchedRoots = {};
    v19.RootConnections = {};
    v19.PosesVendorConnections = {};
    v19.LastPosesVendorTouchAt = 0;
    v19.PosesVendorTouchCooldown = 0.75;
    v19.ScreenFrameConnections = {};
    v19.ScreenFramesChildAddedConnection = nil;
    v19.ScreenFramesChildRemovedConnection = nil;
    v19.CloseButtonConnections = {};
    v19.MenuButtonConnections = {};
    v19.IsHudHidden = false;
    v19.IsInventoryHudOpen = false;
end;
v6.KnitStart = function(v20) --[[ Line: 98 ]] --[[ Name: KnitStart ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_ReplicatedStorage_0 (copy)
    v20.PlayerGui = l_LocalPlayer_0:WaitForChild("PlayerGui");
    v20.Camera = workspace.CurrentCamera;
    local l_Assets_0 = l_ReplicatedStorage_0:FindFirstChild("Assets");
    if l_Assets_0 then
        local l_Sounds_0 = l_Assets_0:FindFirstChild("Sounds");
        if l_Sounds_0 then
            v20.UISounds = l_Sounds_0:FindFirstChild("UI");
        end;
    end;
    v20:_grabUiRefs();
    v20:_setupVisualEffects();
    v20:_setupScreenFrameVisibilityTracking();
    v20:_setupScreenFrameCloseButtons();
    v20:_setupPosesVendorTouch();
    v20:_setupMenuButtonBindings();
    if v20.Hud then
        v20:WatchRoot(v20.Hud);
    end;
    if v20.ScreenFrames then
        v20:WatchRoot(v20.ScreenFrames);
    end;
    if v20.InventoryHud then
        v20:WatchRoot(v20.InventoryHud);
    end;
    v20:_updatePresentationForScreenFrames();
end;
v6._grabUiRefs = function(v23) --[[ Line: 132 ]] --[[ Name: _grabUiRefs ]]
    v23.Hud = v23.PlayerGui:FindFirstChild("Hud");
    v23.InventoryHud = v23.PlayerGui:FindFirstChild("InventoryHud");
    if v23.Hud then
        v23.LeftSide = v23.Hud:FindFirstChild("LeftSide");
        v23.RankBar = v23.Hud:FindFirstChild("RankBar");
        v23.AuraBoost = v23.Hud:FindFirstChild("AuraBoost", true);
        v23.LeftSideOriginalPos = v23.LeftSide and v23.LeftSide.Position or nil;
        v23.RankBarOriginalPos = v23.RankBar and v23.RankBar.Position or nil;
        v23.AuraBoostOriginalPos = v23.AuraBoost and v23.AuraBoost.Position or nil;
        v23.MenuBtns = v23.LeftSide and v23.LeftSide:FindFirstChild("MenuBtns") or nil;
        v23.ShopBtn = v23.MenuBtns and v23.MenuBtns:FindFirstChild("ShopBtn") or nil;
        v23.SettingsBtn = v23.MenuBtns and v23.MenuBtns:FindFirstChild("SettingsBtn") or nil;
        v23.StatsBtn = v23.MenuBtns and v23.MenuBtns:FindFirstChild("StatsBtn") or nil;
        v23.InviteBtn = v23.MenuBtns and v23.MenuBtns:FindFirstChild("InviteBtn") or nil;
        if v23.Hud:IsA("ScreenGui") then
            v23.Hud.DisplayOrder = 1;
            v23.Hud.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        end;
    end;
    if v23.InventoryHud and v23.InventoryHud:IsA("ScreenGui") then
        v23.InventoryHud.DisplayOrder = 20;
        v23.InventoryHud.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        v23.InventoryHud.Enabled = false;
    end;
    v23.ScreenFrames = v23.PlayerGui:FindFirstChild("ScreenFrames");
    if v23.ScreenFrames then
        if v23.ScreenFrames:IsA("ScreenGui") then
            v23.ScreenFrames.DisplayOrder = 10;
            v23.ScreenFrames.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        end;
        v23.PosesVenderFrame = v23.ScreenFrames:FindFirstChild("PosesVenderFrame");
        v23.TitlesFrame = v23.ScreenFrames:FindFirstChild("TitlesFrame");
        v23.ShopFrame = v23.ScreenFrames:FindFirstChild("ShopFrame");
        v23.SettingsFrame = v23.ScreenFrames:FindFirstChild("SettingsFrame");
        v23.ProfileFrame = v23.ScreenFrames:FindFirstChild("ProfileFrame");
    end;
end;
v6._setupVisualEffects = function(v24) --[[ Line: 178 ]] --[[ Name: _setupVisualEffects ]]
    -- upvalues: l_Lighting_0 (copy)
    local l_UIBlur_0 = l_Lighting_0:FindFirstChild("UIBlur");
    if not l_UIBlur_0 then
        l_UIBlur_0 = Instance.new("BlurEffect");
        l_UIBlur_0.Name = "UIBlur";
        l_UIBlur_0.Size = 0;
        l_UIBlur_0.Parent = l_Lighting_0;
    end;
    v24.Blur = l_UIBlur_0;
    local l_UIOverlay_0 = v24.PlayerGui:FindFirstChild("UIOverlay");
    if not l_UIOverlay_0 then
        l_UIOverlay_0 = Instance.new("ScreenGui");
        l_UIOverlay_0.Name = "UIOverlay";
        l_UIOverlay_0.IgnoreGuiInset = true;
        l_UIOverlay_0.ResetOnSpawn = false;
        l_UIOverlay_0.Parent = v24.PlayerGui;
    end;
    l_UIOverlay_0.DisplayOrder = 5;
    l_UIOverlay_0.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    v24.OverlayGui = l_UIOverlay_0;
    local l_OverlayFrame_0 = l_UIOverlay_0:FindFirstChild("OverlayFrame");
    if not l_OverlayFrame_0 then
        l_OverlayFrame_0 = Instance.new("Frame");
        l_OverlayFrame_0.Name = "OverlayFrame";
        l_OverlayFrame_0.Parent = l_UIOverlay_0;
    end;
    l_OverlayFrame_0.Size = UDim2.new(1, 0, 1, 0);
    l_OverlayFrame_0.Position = UDim2.new(0, 0, 0, 0);
    l_OverlayFrame_0.BackgroundColor3 = Color3.new(0, 0, 0);
    l_OverlayFrame_0.BackgroundTransparency = 1;
    l_OverlayFrame_0.BorderSizePixel = 0;
    l_OverlayFrame_0.ZIndex = 1;
    l_OverlayFrame_0.Active = false;
    v24.OverlayFrame = l_OverlayFrame_0;
    if v24.Hud and v24.Hud:IsA("ScreenGui") then
        v24.Hud.DisplayOrder = 1;
        v24.Hud.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    end;
    if v24.ScreenFrames and v24.ScreenFrames:IsA("ScreenGui") then
        v24.ScreenFrames.DisplayOrder = 10;
        v24.ScreenFrames.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    end;
end;
v6._playHoverSound = function(v28) --[[ Line: 228 ]] --[[ Name: _playHoverSound ]]
    if v28.UISounds and v28.UISounds:FindFirstChild("UI Hover") then
        v28.UISounds["UI Hover"]:Play();
    end;
end;
v6._playClickSound = function(v29) --[[ Line: 234 ]] --[[ Name: _playClickSound ]]
    if v29.UISounds and v29.UISounds:FindFirstChild("UI Click") then
        v29.UISounds["UI Click"]:Play();
    end;
end;
v6._makeScaledSize = function(_, v31, v32) --[[ Line: 240 ]] --[[ Name: _makeScaledSize ]]
    return UDim2.fromScale(v31.X.Scale * v32, v31.Y.Scale * v32);
end;
v6._isBindableButton = function(_, v34) --[[ Line: 247 ]] --[[ Name: _isBindableButton ]]
    return v34:IsA("TextButton") or v34:IsA("ImageButton");
end;
v6._shouldSkipButton = function(_, v36) --[[ Line: 251 ]] --[[ Name: _shouldSkipButton ]]
    return v36:GetAttribute("NoUniversalUIButtonEffects") == true;
end;
v6._hasTag = function(_, v38, v39) --[[ Line: 255 ]] --[[ Name: _hasTag ]]
    -- upvalues: l_CollectionService_0 (copy)
    return l_CollectionService_0:HasTag(v38, v39);
end;
v6.BindButton = function(v40, v41, v42) --[[ Line: 259 ]] --[[ Name: BindButton ]]
    -- upvalues: l_TweenService_0 (copy), v7 (copy), v8 (copy)
    if not v41 or not v41:IsA("GuiButton") then
        return;
    elseif v40:_shouldSkipButton(v41) then
        return;
    elseif v40.BoundButtons[v41] then
        return;
    else
        v42 = v42 or {};
        local v43 = v40:_hasTag(v41, "NoHoverTween");
        local v44 = v40:_hasTag(v41, "NoSFX");
        local v45 = v42.HoverScale or 1.15;
        local v46 = v42.ClickScale or 0.9;
        local v47 = false;
        if v42.PlayHoverSound ~= false then
            v47 = not v44;
        end;
        local v48 = false;
        if v42.PlayClickSound ~= false then
            v48 = not v44;
        end;
        local l_Size_0 = v41.Size;
        local v50 = v40:_makeScaledSize(l_Size_0, v45);
        local v51 = v40:_makeScaledSize(l_Size_0, v46);
        local v52 = {
            IsHovering = false, 
            DisableHoverTween = v43
        };
        if v43 then

        end;
        v52.Tweens = {
            hoverIn = l_TweenService_0:Create(v41, v7, {
                Size = v50
            }), 
            hoverOut = l_TweenService_0:Create(v41, v7, {
                Size = l_Size_0
            }), 
            clickDown = l_TweenService_0:Create(v41, v8, {
                Size = v51
            })
        };
        v52.Connections = {};
        v40.BoundButtons[v41] = v52;
        table.insert(v52.Connections, v41.MouseEnter:Connect(function() --[[ Line: 299 ]]
            -- upvalues: v52 (copy), v47 (copy), v40 (copy)
            v52.IsHovering = true;
            if v47 then
                v40:_playHoverSound();
            end;
            if not v52.DisableHoverTween and v52.Tweens then
                v52.Tweens.hoverIn:Play();
            end;
        end));
        table.insert(v52.Connections, v41.MouseLeave:Connect(function() --[[ Line: 311 ]]
            -- upvalues: v52 (copy)
            v52.IsHovering = false;
            if not v52.DisableHoverTween and v52.Tweens then
                v52.Tweens.hoverOut:Play();
            end;
        end));
        table.insert(v52.Connections, v41.MouseButton1Down:Connect(function() --[[ Line: 319 ]]
            -- upvalues: v48 (copy), v40 (copy), v52 (copy)
            if v48 then
                v40:_playClickSound();
            end;
            if not v52.DisableHoverTween and v52.Tweens then
                v52.Tweens.clickDown:Play();
            end;
        end));
        table.insert(v52.Connections, v41.MouseButton1Up:Connect(function() --[[ Line: 329 ]]
            -- upvalues: v52 (copy)
            if not v52.DisableHoverTween and v52.Tweens then
                if v52.IsHovering then
                    v52.Tweens.hoverIn:Play();
                    return;
                else
                    v52.Tweens.hoverOut:Play();
                end;
            end;
        end));
        table.insert(v52.Connections, v41.Destroying:Connect(function() --[[ Line: 339 ]]
            -- upvalues: v40 (copy), v41 (copy)
            v40:UnbindButton(v41);
        end));
        return;
    end;
end;
v6.UnbindButton = function(v53, v54) --[[ Line: 344 ]] --[[ Name: UnbindButton ]]
    local v55 = v53.BoundButtons[v54];
    if not v55 then
        return;
    else
        for _, v57 in ipairs(v55.Connections) do
            v57:Disconnect();
        end;
        v53.BoundButtons[v54] = nil;
        return;
    end;
end;
v6.BindButtonsIn = function(v58, v59, v60) --[[ Line: 357 ]] --[[ Name: BindButtonsIn ]]
    if not v59 then
        return;
    else
        if v58:_isBindableButton(v59) then
            v58:BindButton(v59, v60);
        end;
        for _, v62 in ipairs(v59:GetDescendants()) do
            if v58:_isBindableButton(v62) then
                v58:BindButton(v62, v60);
            end;
        end;
        return;
    end;
end;
v6.WatchRoot = function(v63, v64, v65) --[[ Line: 373 ]] --[[ Name: WatchRoot ]]
    if not v64 then
        return;
    elseif v63.WatchedRoots[v64] then
        return;
    else
        v63.WatchedRoots[v64] = {
            Options = v65 or {}
        };
        v63:BindButtonsIn(v64, v65);
        v63.RootConnections[v64] = {
            v64.DescendantAdded:Connect(function(v66) --[[ Line: 389 ]]
                -- upvalues: v63 (copy), v65 (copy)
                if v63:_isBindableButton(v66) then
                    v63:BindButton(v66, v65);
                end;
            end), 
            v64.Destroying:Connect(function() --[[ Line: 395 ]]
                -- upvalues: v63 (copy), v64 (copy)
                v63:UnwatchRoot(v64);
            end)
        };
        return;
    end;
end;
v6.UnwatchRoot = function(v67, v68) --[[ Line: 401 ]] --[[ Name: UnwatchRoot ]]
    if not v67.WatchedRoots[v68] then
        return;
    else
        local v69 = v67.RootConnections[v68];
        if v69 then
            for _, v71 in ipairs(v69) do
                v71:Disconnect();
            end;
        end;
        v67.WatchedRoots[v68] = nil;
        v67.RootConnections[v68] = nil;
        return;
    end;
end;
v6.WatchPlayerGui = function(v72, v73) --[[ Line: 417 ]] --[[ Name: WatchPlayerGui ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    if not v72.PlayerGui then
        v72.PlayerGui = l_LocalPlayer_0:WaitForChild("PlayerGui");
    end;
    v72:WatchRoot(v72.PlayerGui, v73);
end;
v6._getFrameScaleObject = function(_, v75) --[[ Line: 425 ]] --[[ Name: _getFrameScaleObject ]]
    local l_UIScale_0 = v75:FindFirstChildOfClass("UIScale");
    if l_UIScale_0 and l_UIScale_0:IsA("UIScale") then
        return l_UIScale_0;
    else
        return nil;
    end;
end;
v6._animateFrameOpen = function(v77, v78) --[[ Line: 433 ]] --[[ Name: _animateFrameOpen ]]
    -- upvalues: l_TweenService_0 (copy), v14 (copy)
    local v79 = v77:_getFrameScaleObject(v78);
    if not v79 then
        v78.Visible = true;
        return;
    else
        v79.Scale = 0;
        v78.Visible = true;
        l_TweenService_0:Create(v79, v14, {
            Scale = 1
        }):Play();
        return;
    end;
end;
v6._animateFrameClose = function(v80, v81) --[[ Line: 447 ]] --[[ Name: _animateFrameClose ]]
    -- upvalues: l_TweenService_0 (copy), v13 (copy)
    local v82 = v80:_getFrameScaleObject(v81);
    if not v82 then
        v81.Visible = false;
        return;
    else
        local v83 = l_TweenService_0:Create(v82, v13, {
            Scale = 0
        });
        v83:Play();
        v83.Completed:Once(function() --[[ Line: 459 ]]
            -- upvalues: v81 (copy), v82 (copy)
            if v81.Parent then
                v81.Visible = false;
                v82.Scale = 1;
            end;
        end);
        return;
    end;
end;
v6._getScreenFrameByName = function(v84, v85) --[[ Line: 467 ]] --[[ Name: _getScreenFrameByName ]]
    if not v84.ScreenFrames or type(v85) ~= "string" or v85 == "" then
        return nil;
    else
        local l_FirstChild_0 = v84.ScreenFrames:FindFirstChild(v85);
        if l_FirstChild_0 and l_FirstChild_0:IsA("GuiObject") then
            return l_FirstChild_0;
        else
            return nil;
        end;
    end;
end;
v6.OpenScreenFrame = function(v87, v88) --[[ Line: 480 ]] --[[ Name: OpenScreenFrame ]]
    local v89 = v87:_getScreenFrameByName(v88);
    if not v89 then
        return false;
    else
        v87:_animateFrameOpen(v89);
        v87:_updatePresentationForScreenFrames();
        return true;
    end;
end;
v6.CloseScreenFrame = function(v90, v91) --[[ Line: 491 ]] --[[ Name: CloseScreenFrame ]]
    local v92 = v90:_getScreenFrameByName(v91);
    if not v92 then
        return false;
    else
        v90:_animateFrameClose(v92);
        return true;
    end;
end;
v6._bindCloseButton = function(v93, v94) --[[ Line: 501 ]] --[[ Name: _bindCloseButton ]]
    if not v94 or not v94:IsA("GuiButton") then
        return;
    elseif v93.CloseButtonConnections[v94] then
        return;
    else
        v93.CloseButtonConnections[v94] = {
            v94.MouseButton1Click:Connect(function() --[[ Line: 511 ]]
                -- upvalues: v94 (copy), v93 (copy)
                local l_v94_Attribute_0 = v94:GetAttribute("CloseFrame");
                if type(l_v94_Attribute_0) ~= "string" or l_v94_Attribute_0 == "" then
                    return;
                else
                    v93:CloseScreenFrame(l_v94_Attribute_0);
                    return;
                end;
            end), 
            v94.Destroying:Connect(function() --[[ Line: 520 ]]
                -- upvalues: v93 (copy), v94 (copy)
                v93:_unbindCloseButton(v94);
            end)
        };
        return;
    end;
end;
v6._unbindCloseButton = function(v96, v97) --[[ Line: 526 ]] --[[ Name: _unbindCloseButton ]]
    local v98 = v96.CloseButtonConnections[v97];
    if not v98 then
        return;
    else
        for _, v100 in ipairs(v98) do
            v100:Disconnect();
        end;
        v96.CloseButtonConnections[v97] = nil;
        return;
    end;
end;
v6._setupScreenFrameCloseButtons = function(v101) --[[ Line: 539 ]] --[[ Name: _setupScreenFrameCloseButtons ]]
    -- upvalues: l_CollectionService_0 (copy)
    for _, v103 in ipairs(l_CollectionService_0:GetTagged("ScreenFrameCloseBtn")) do
        v101:_bindCloseButton(v103);
    end;
    l_CollectionService_0:GetInstanceAddedSignal("ScreenFrameCloseBtn"):Connect(function(v104) --[[ Line: 544 ]]
        -- upvalues: v101 (copy)
        v101:_bindCloseButton(v104);
    end);
    l_CollectionService_0:GetInstanceRemovedSignal("ScreenFrameCloseBtn"):Connect(function(v105) --[[ Line: 548 ]]
        -- upvalues: v101 (copy)
        v101:_unbindCloseButton(v105);
    end);
end;
v6._disconnectMenuButtonConnections = function(v106) --[[ Line: 553 ]] --[[ Name: _disconnectMenuButtonConnections ]]
    for _, v108 in ipairs(v106.MenuButtonConnections) do
        v108:Disconnect();
    end;
    table.clear(v106.MenuButtonConnections);
end;
v6._promptInviteFlow = function(_) --[[ Line: 561 ]] --[[ Name: _promptInviteFlow ]]
    -- upvalues: l_SocialService_0 (copy), l_LocalPlayer_0 (copy)
    local v110 = false;
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 563 ]]
        -- upvalues: l_SocialService_0 (ref), l_LocalPlayer_0 (ref)
        return l_SocialService_0:CanSendGameInviteAsync(l_LocalPlayer_0);
    end);
    if l_status_0 then
        v110 = l_result_0 == true;
    end;
    if not v110 then
        return;
    else
        pcall(function() --[[ Line: 575 ]]
            -- upvalues: l_SocialService_0 (ref), l_LocalPlayer_0 (ref)
            l_SocialService_0:PromptGameInvite(l_LocalPlayer_0);
        end);
        return;
    end;
end;
v6._setupMenuButtonBindings = function(v113) --[[ Line: 580 ]] --[[ Name: _setupMenuButtonBindings ]]
    v113:_disconnectMenuButtonConnections();
    v113:_grabUiRefs();
    if v113.ShopBtn and v113.ShopBtn:IsA("GuiButton") then
        table.insert(v113.MenuButtonConnections, v113.ShopBtn.MouseButton1Click:Connect(function() --[[ Line: 585 ]]
            -- upvalues: v113 (copy)
            v113:OpenShopFrame();
        end));
    end;
    if v113.SettingsBtn and v113.SettingsBtn:IsA("GuiButton") then
        table.insert(v113.MenuButtonConnections, v113.SettingsBtn.MouseButton1Click:Connect(function() --[[ Line: 591 ]]
            -- upvalues: v113 (copy)
            v113:OpenSettingsFrame();
        end));
    end;
    if v113.StatsBtn and v113.StatsBtn:IsA("GuiButton") then
        table.insert(v113.MenuButtonConnections, v113.StatsBtn.MouseButton1Click:Connect(function() --[[ Line: 597 ]]
            -- upvalues: v113 (copy)
            v113:OpenProfileFrame();
        end));
    end;
    if v113.InviteBtn and v113.InviteBtn:IsA("GuiButton") then
        table.insert(v113.MenuButtonConnections, v113.InviteBtn.MouseButton1Click:Connect(function() --[[ Line: 603 ]]
            -- upvalues: v113 (copy)
            v113:_promptInviteFlow();
        end));
    end;
end;
v6.OpenPosesVendor = function(v114) --[[ Line: 609 ]] --[[ Name: OpenPosesVendor ]]
    if not v114.PosesVenderFrame then
        v114:_grabUiRefs();
    end;
    if v114.PosesVenderFrame then
        v114:_animateFrameOpen(v114.PosesVenderFrame);
        v114:_updatePresentationForScreenFrames();
    end;
end;
v6.ClosePosesVendor = function(v115) --[[ Line: 620 ]] --[[ Name: ClosePosesVendor ]]
    if v115.PosesVenderFrame then
        v115:_animateFrameClose(v115.PosesVenderFrame);
    end;
end;
v6.OpenTitlesFrame = function(v116) --[[ Line: 626 ]] --[[ Name: OpenTitlesFrame ]]
    if not v116.TitlesFrame then
        v116:_grabUiRefs();
    end;
    if v116.TitlesFrame then
        v116:_animateFrameOpen(v116.TitlesFrame);
        v116:_updatePresentationForScreenFrames();
    end;
end;
v6.CloseTitlesFrame = function(v117) --[[ Line: 637 ]] --[[ Name: CloseTitlesFrame ]]
    if v117.TitlesFrame then
        v117:_animateFrameClose(v117.TitlesFrame);
    end;
end;
v6.OpenShopFrame = function(v118) --[[ Line: 643 ]] --[[ Name: OpenShopFrame ]]
    if not v118.ShopFrame then
        v118:_grabUiRefs();
    end;
    if v118.ShopFrame then
        v118:_animateFrameOpen(v118.ShopFrame);
        v118:_updatePresentationForScreenFrames();
    end;
end;
v6.CloseShopFrame = function(v119) --[[ Line: 654 ]] --[[ Name: CloseShopFrame ]]
    if v119.ShopFrame then
        v119:_animateFrameClose(v119.ShopFrame);
    end;
end;
v6.OpenSettingsFrame = function(v120) --[[ Line: 660 ]] --[[ Name: OpenSettingsFrame ]]
    if not v120.SettingsFrame then
        v120:_grabUiRefs();
    end;
    if v120.SettingsFrame then
        v120:_animateFrameOpen(v120.SettingsFrame);
        v120:_updatePresentationForScreenFrames();
    end;
end;
v6.CloseSettingsFrame = function(v121) --[[ Line: 671 ]] --[[ Name: CloseSettingsFrame ]]
    if v121.SettingsFrame then
        v121:_animateFrameClose(v121.SettingsFrame);
    end;
end;
v6.OpenProfileFrame = function(v122) --[[ Line: 677 ]] --[[ Name: OpenProfileFrame ]]
    if not v122.ProfileFrame then
        v122:_grabUiRefs();
    end;
    if v122.ProfileFrame then
        v122:_animateFrameOpen(v122.ProfileFrame);
        v122:_updatePresentationForScreenFrames();
    end;
end;
v6.CloseProfileFrame = function(v123) --[[ Line: 688 ]] --[[ Name: CloseProfileFrame ]]
    if v123.ProfileFrame then
        v123:_animateFrameClose(v123.ProfileFrame);
    end;
end;
v6.EnterInventoryHud = function(v124) --[[ Line: 694 ]] --[[ Name: EnterInventoryHud ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    if not v124.PlayerGui then
        v124.PlayerGui = l_LocalPlayer_0:WaitForChild("PlayerGui");
    end;
    v124:_grabUiRefs();
    v124.IsInventoryHudOpen = true;
    if v124.Hud and v124.Hud:IsA("ScreenGui") then
        v124.Hud.Enabled = false;
    end;
    if v124.ScreenFrames and v124.ScreenFrames:IsA("ScreenGui") then
        v124.ScreenFrames.Enabled = false;
    end;
    if v124.InventoryHud and v124.InventoryHud:IsA("ScreenGui") then
        v124.InventoryHud.Enabled = true;
    end;
    if v124.OverlayFrame then
        v124.OverlayFrame.BackgroundTransparency = 1;
    end;
    if v124.Blur then
        v124.Blur.Size = 0;
    end;
end;
v6.ExitInventoryHud = function(v125) --[[ Line: 724 ]] --[[ Name: ExitInventoryHud ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    if not v125.PlayerGui then
        v125.PlayerGui = l_LocalPlayer_0:WaitForChild("PlayerGui");
    end;
    v125:_grabUiRefs();
    v125.IsInventoryHudOpen = false;
    if v125.Hud and v125.Hud:IsA("ScreenGui") then
        v125.Hud.Enabled = true;
    end;
    if v125.ScreenFrames and v125.ScreenFrames:IsA("ScreenGui") then
        v125.ScreenFrames.Enabled = true;
    end;
    if v125.InventoryHud and v125.InventoryHud:IsA("ScreenGui") then
        v125.InventoryHud.Enabled = false;
    end;
end;
v6._isLocalCharacterTouch = function(_, v127) --[[ Line: 746 ]] --[[ Name: _isLocalCharacterTouch ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    local l_Character_0 = l_LocalPlayer_0.Character;
    if not l_Character_0 or not v127 then
        return false;
    else
        return v127:IsDescendantOf(l_Character_0);
    end;
end;
v6._canOpenPosesVendor = function(v129) --[[ Line: 755 ]] --[[ Name: _canOpenPosesVendor ]]
    local v130 = os.clock();
    if v130 - v129.LastPosesVendorTouchAt < v129.PosesVendorTouchCooldown then
        return false;
    else
        v129.LastPosesVendorTouchAt = v130;
        return true;
    end;
end;
v6._bindPosesVendorPart = function(v131, v132) --[[ Line: 765 ]] --[[ Name: _bindPosesVendorPart ]]
    if not v132 or not v132:IsA("BasePart") then
        return;
    elseif v131.PosesVendorConnections[v132] then
        return;
    else
        v131.PosesVendorConnections[v132] = {
            v132.Touched:Connect(function(v133) --[[ Line: 775 ]]
                -- upvalues: v131 (copy)
                if not v131:_isLocalCharacterTouch(v133) then
                    return;
                elseif not v131:_canOpenPosesVendor() then
                    return;
                else
                    v131:OpenPosesVendor();
                    return;
                end;
            end), 
            v132.Destroying:Connect(function() --[[ Line: 787 ]]
                -- upvalues: v131 (copy), v132 (copy)
                v131:_unbindPosesVendorPart(v132);
            end)
        };
        return;
    end;
end;
v6._unbindPosesVendorPart = function(v134, v135) --[[ Line: 793 ]] --[[ Name: _unbindPosesVendorPart ]]
    local v136 = v134.PosesVendorConnections[v135];
    if not v136 then
        return;
    else
        for _, v138 in ipairs(v136) do
            v138:Disconnect();
        end;
        v134.PosesVendorConnections[v135] = nil;
        return;
    end;
end;
v6._setupPosesVendorTouch = function(v139) --[[ Line: 806 ]] --[[ Name: _setupPosesVendorTouch ]]
    -- upvalues: l_CollectionService_0 (copy)
    for _, v141 in ipairs(l_CollectionService_0:GetTagged("PosesVendor")) do
        v139:_bindPosesVendorPart(v141);
    end;
    l_CollectionService_0:GetInstanceAddedSignal("PosesVendor"):Connect(function(v142) --[[ Line: 811 ]]
        -- upvalues: v139 (copy)
        v139:_bindPosesVendorPart(v142);
    end);
    l_CollectionService_0:GetInstanceRemovedSignal("PosesVendor"):Connect(function(v143) --[[ Line: 815 ]]
        -- upvalues: v139 (copy)
        v139:_unbindPosesVendorPart(v143);
    end);
end;
v6._hideHud = function(v144) --[[ Line: 820 ]] --[[ Name: _hideHud ]]
    -- upvalues: l_TweenService_0 (copy), v9 (copy), v15 (copy), v16 (copy), v17 (copy)
    if v144.IsHudHidden then
        return;
    else
        v144.IsHudHidden = true;
        if v144.LeftSide then
            l_TweenService_0:Create(v144.LeftSide, v9, {
                Position = v15
            }):Play();
        end;
        if v144.RankBar then
            l_TweenService_0:Create(v144.RankBar, v9, {
                Position = v16
            }):Play();
        end;
        if v144.AuraBoost then
            l_TweenService_0:Create(v144.AuraBoost, v9, {
                Position = v17
            }):Play();
        end;
        return;
    end;
end;
v6._showHud = function(v145) --[[ Line: 846 ]] --[[ Name: _showHud ]]
    -- upvalues: l_TweenService_0 (copy), v10 (copy)
    if not v145.IsHudHidden then
        return;
    else
        v145.IsHudHidden = false;
        if v145.LeftSide and v145.LeftSideOriginalPos then
            l_TweenService_0:Create(v145.LeftSide, v10, {
                Position = v145.LeftSideOriginalPos
            }):Play();
        end;
        if v145.RankBar and v145.RankBarOriginalPos then
            l_TweenService_0:Create(v145.RankBar, v10, {
                Position = v145.RankBarOriginalPos
            }):Play();
        end;
        if v145.AuraBoost and v145.AuraBoostOriginalPos then
            l_TweenService_0:Create(v145.AuraBoost, v10, {
                Position = v145.AuraBoostOriginalPos
            }):Play();
        end;
        return;
    end;
end;
v6._applyOpenEffects = function(v146) --[[ Line: 872 ]] --[[ Name: _applyOpenEffects ]]
    -- upvalues: l_TweenService_0 (copy), v11 (copy)
    if v146.Camera then
        l_TweenService_0:Create(v146.Camera, v11, {
            FieldOfView = 55
        }):Play();
    end;
    if v146.Blur then
        l_TweenService_0:Create(v146.Blur, v11, {
            Size = 12
        }):Play();
    end;
    if v146.OverlayFrame then
        l_TweenService_0:Create(v146.OverlayFrame, v11, {
            BackgroundTransparency = 0.6
        }):Play();
    end;
    v146:_hideHud();
end;
v6._applyCloseEffects = function(v147) --[[ Line: 894 ]] --[[ Name: _applyCloseEffects ]]
    -- upvalues: l_TweenService_0 (copy), v12 (copy)
    if v147.Camera then
        l_TweenService_0:Create(v147.Camera, v12, {
            FieldOfView = 70
        }):Play();
    end;
    if v147.Blur then
        l_TweenService_0:Create(v147.Blur, v12, {
            Size = 0
        }):Play();
    end;
    if v147.OverlayFrame then
        l_TweenService_0:Create(v147.OverlayFrame, v12, {
            BackgroundTransparency = 1
        }):Play();
    end;
    v147:_showHud();
end;
v6._isTrackedScreenFrame = function(v148, v149) --[[ Line: 916 ]] --[[ Name: _isTrackedScreenFrame ]]
    return v149:IsA("GuiObject") and v149.Parent == v148.ScreenFrames;
end;
v6._anyScreenFrameVisible = function(v150) --[[ Line: 920 ]] --[[ Name: _anyScreenFrameVisible ]]
    if not v150.ScreenFrames then
        return false;
    else
        for _, v152 in ipairs(v150.ScreenFrames:GetChildren()) do
            if v152:IsA("GuiObject") and v152.Visible then
                return true;
            end;
        end;
        return false;
    end;
end;
v6._updatePresentationForScreenFrames = function(v153) --[[ Line: 934 ]] --[[ Name: _updatePresentationForScreenFrames ]]
    if v153.IsInventoryHudOpen then
        return;
    elseif v153:_anyScreenFrameVisible() then
        v153:_applyOpenEffects();
        return;
    else
        v153:_applyCloseEffects();
        return;
    end;
end;
v6._trackScreenFrame = function(v154, v155) --[[ Line: 946 ]] --[[ Name: _trackScreenFrame ]]
    if not v155 or v154.ScreenFrameConnections[v155] then
        return;
    else
        v154.ScreenFrameConnections[v155] = {
            v155:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 952 ]]
                -- upvalues: v154 (copy)
                v154:_updatePresentationForScreenFrames();
            end), 
            v155.Destroying:Connect(function() --[[ Line: 956 ]]
                -- upvalues: v154 (copy), v155 (copy)
                v154:_untrackScreenFrame(v155);
                v154:_updatePresentationForScreenFrames();
            end)
        };
        return;
    end;
end;
v6._untrackScreenFrame = function(v156, v157) --[[ Line: 963 ]] --[[ Name: _untrackScreenFrame ]]
    local v158 = v156.ScreenFrameConnections[v157];
    if not v158 then
        return;
    else
        for _, v160 in ipairs(v158) do
            v160:Disconnect();
        end;
        v156.ScreenFrameConnections[v157] = nil;
        return;
    end;
end;
v6._setupScreenFrameVisibilityTracking = function(v161) --[[ Line: 976 ]] --[[ Name: _setupScreenFrameVisibilityTracking ]]
    if not v161.ScreenFrames then
        return;
    else
        for _, v163 in ipairs(v161.ScreenFrames:GetChildren()) do
            if v163:IsA("GuiObject") then
                v161:_trackScreenFrame(v163);
            end;
        end;
        v161.ScreenFramesChildAddedConnection = v161.ScreenFrames.ChildAdded:Connect(function(v164) --[[ Line: 987 ]]
            -- upvalues: v161 (copy)
            if v164:IsA("GuiObject") then
                v161:_trackScreenFrame(v164);
                v161:_updatePresentationForScreenFrames();
            end;
        end);
        v161.ScreenFramesChildRemovedConnection = v161.ScreenFrames.ChildRemoved:Connect(function(v165) --[[ Line: 994 ]]
            -- upvalues: v161 (copy)
            if v165:IsA("GuiObject") then
                v161:_untrackScreenFrame(v165);
                v161:_updatePresentationForScreenFrames();
            end;
        end);
        return;
    end;
end;
return v6;