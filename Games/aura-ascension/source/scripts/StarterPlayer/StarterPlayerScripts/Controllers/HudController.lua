-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_Knit_0 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"));
local l_Ranked_0 = require(l_ReplicatedStorage_0:WaitForChild("Ranked"));
local v6 = require(l_ReplicatedStorage_0:WaitForChild("Math Utility"));
local l_Monetization_0 = require(l_ReplicatedStorage_0:WaitForChild("Monetization"));
local l_Signals_0 = require(l_ReplicatedStorage_0:WaitForChild("Signals"));
local v9 = l_Knit_0.CreateController({
    Name = "HudController"
});
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v11 = UDim2.fromScale(0.5, 0.09);
local v12 = UDim2.fromScale(0.5, -0.3);
local v13 = TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
local v14 = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
local v15 = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local v16 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local v17 = TweenInfo.new(0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out);
local v18 = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In);
local l_floor_0 = math.floor;
local l_clamp_0 = math.clamp;
local l_clock_0 = os.clock;
v9.KnitInit = function(v22) --[[ Line: 38 ]] --[[ Name: KnitInit ]]
    v22.PlayerService = nil;
    v22.TrainingAreasService = nil;
    v22.CursedZoneService = nil;
    v22.UIManager = nil;
    v22.PlayerGui = nil;
    v22.Hud = nil;
    v22.TopBar = nil;
    v22.CursedZoneTimer = nil;
    v22.RebirthNotification = nil;
    v22.RebirthNotificationGoButton = nil;
    v22.RebirthNotificationCount = nil;
    v22.LeftSide = nil;
    v22.MenuBtns = nil;
    v22.StatsFrame = nil;
    v22.AuraFrame = nil;
    v22.RebirthFrame = nil;
    v22.RankFrame = nil;
    v22.ProgressBar = nil;
    v22.GoalRank = nil;
    v22.GoalRankImage = nil;
    v22.CurrentRank = nil;
    v22.CurrentRankImage = nil;
    v22.ProgressText = nil;
    v22.RebirthMonetizationFrame = nil;
    v22.SmallRebirthBundleTextLabel = nil;
    v22.BigRebirthBundleTextLabel = nil;
    v22.RebirthPad = nil;
    v22.TouchPart = nil;
    v22.PadText = nil;
    v22.TopBarFadeIn = nil;
    v22.TopBarFadeOut = nil;
    v22.LastAuraForAuraUI = -1;
    v22.LastPadTextAuraBucket = -1;
    v22.LastRebirthsForUI = -1;
    v22.LastAura = -1;
    v22.LastIndex = -1;
    v22.LastNextIndex = -1;
    v22.IsRankUpAnimating = false;
    v22.IsProcessingQueue = false;
    v22.RankUpQueue = {};
    v22.LastSmallText = "";
    v22.LastBigText = "";
    v22.SoftUpdateQueued = false;
    v22.LastSoftUpdateAt = 0;
    v22.NotifActive = false;
    v22.IsTeleporting = false;
    v22.LastRebirthNotifTime = 0;
    v22.CursedZoneState = {
        IsActive = false, 
        EndsAt = 0, 
        NextSpawnAt = 0
    };
    v22.MultiplierGradients = {};
    v22.CurrentGradientName = nil;
    v22.FillTween = nil;
    v22.ScaleTween = nil;
    v22.BarFullX = 1;
    v22.BarYScale = 1;
    v22.OriginalBarColor = nil;
    v22.BarGradient = nil;
    v22.OriginalGradientColor = nil;
    v22.MultiTimerLabels = {};
    v22.MultiTimerLoopStarted = false;
end;
v9.KnitStart = function(v23) --[[ Line: 122 ]] --[[ Name: KnitStart ]]
    -- upvalues: l_Knit_0 (copy)
    v23.PlayerService = l_Knit_0.GetService("PlayerService");
    v23.UIManager = l_Knit_0.GetController("UIManager");
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 126 ]]
        -- upvalues: l_Knit_0 (ref)
        return l_Knit_0.GetService("TrainingAreasService");
    end);
    if l_status_0 then
        v23.TrainingAreasService = l_result_0;
    end;
    local l_status_1, l_result_1 = pcall(function() --[[ Line: 133 ]]
        -- upvalues: l_Knit_0 (ref)
        return l_Knit_0.GetService("CursedZoneService");
    end);
    if l_status_1 then
        v23.CursedZoneService = l_result_1;
    end;
    v23:_grabRefs();
    v23:_setupTweens();
    v23:_setupButtonInteractions();
    v23:_bindSignals();
    v23:_rebirthNotificationFade(false);
    v23:_updateAura();
    v23:_updateRebirth();
    v23:_updateRankBar(true);
    v23:_updateRebirthPackTextsSoft();
    v23:_updateCursedZoneTimerLabel();
    v23:_refreshMultiTimerLabels();
    v23:_updateGlobalAuraEventTimerLabels();
    v23:_startCursedZoneTimerLoop();
    v23:_startGlobalAuraEventTimerLoop();
    v23:_requestInitialCursedZoneState();
end;
v9._grabRefs = function(v28) --[[ Line: 161 ]] --[[ Name: _grabRefs ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    v28.PlayerGui = l_LocalPlayer_0:WaitForChild("PlayerGui");
    v28.Hud = v28.PlayerGui:WaitForChild("Hud");
    v28.TopBar = v28.Hud:WaitForChild("TopBar");
    v28.CursedZoneTimer = v28.Hud:WaitForChild("CursedZoneTimer");
    v28.RebirthNotification = v28.TopBar:WaitForChild("RebirthNotification");
    v28.RebirthNotificationGoButton = v28.RebirthNotification:WaitForChild("Button");
    v28.RebirthNotificationCount = v28.RebirthNotificationGoButton:WaitForChild("TextLabel");
    v28.LeftSide = v28.Hud:WaitForChild("LeftSide");
    v28.MenuBtns = v28.LeftSide:WaitForChild("MenuBtns");
    v28.StatsFrame = v28.LeftSide:WaitForChild("Stats");
    v28.AuraFrame = v28.StatsFrame:WaitForChild("Aura");
    v28.RebirthFrame = v28.StatsFrame:WaitForChild("Rebirths");
    v28.RankFrame = v28.Hud:WaitForChild("RankBar");
    v28.ProgressBar = v28.RankFrame:WaitForChild("Bar");
    v28.GoalRank = v28.RankFrame:WaitForChild("Goal");
    v28.GoalRankImage = v28.RankFrame:FindFirstChild("GoalImage");
    v28.CurrentRank = v28.RankFrame:WaitForChild("CurrentRank");
    v28.CurrentRankImage = v28.RankFrame:FindFirstChild("CurrentRankImage");
    v28.ProgressText = v28.RankFrame:WaitForChild("Progress");
    v28.RebirthMonetizationFrame = v28.RankFrame:WaitForChild("Monetization");
    v28.SmallRebirthBundleTextLabel = v28.RebirthMonetizationFrame:WaitForChild("Small"):WaitForChild("TextLabel");
    v28.BigRebirthBundleTextLabel = v28.RebirthMonetizationFrame:WaitForChild("Big"):WaitForChild("TextLabel");
    v28.RebirthPad = workspace:WaitForChild("RebirthPad");
    v28.TouchPart = v28.RebirthPad:WaitForChild("TouchPart");
    v28.PadText = v28.TouchPart.Template.BillboardGui.TickTemplate.Count;
    v28.BarGradient = v28.ProgressBar:FindFirstChildOfClass("UIGradient");
    v28.OriginalGradientColor = v28.BarGradient and v28.BarGradient.Color or nil;
    v28.OriginalBarColor = v28.ProgressBar.BackgroundColor3;
    v28.BarFullX = v28.ProgressBar.Size.X.Scale;
    v28.BarYScale = v28.ProgressBar.Size.Y.Scale;
    local l_Multiplier_0 = v28.RankFrame:FindFirstChild("Multiplier");
    if l_Multiplier_0 then
        for _, v31 in ipairs(l_Multiplier_0:GetChildren()) do
            if v31:IsA("UIGradient") then
                v28.MultiplierGradients[v31.Name] = v31;
            end;
        end;
    end;
end;
v9._setupTweens = function(v32) --[[ Line: 210 ]] --[[ Name: _setupTweens ]]
    -- upvalues: l_TweenService_0 (copy), v13 (copy), v11 (copy), v12 (copy)
    v32.TopBarFadeIn = l_TweenService_0:Create(v32.TopBar, v13, {
        Position = v11
    });
    v32.TopBarFadeOut = l_TweenService_0:Create(v32.TopBar, v13, {
        Position = v12
    });
    v32.RebirthNotificationGoButton.Rotation = -4;
    l_TweenService_0:Create(v32.RebirthNotificationGoButton, TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        Rotation = 4
    }):Play();
end;
v9._setupButtonInteractions = function(v33) --[[ Line: 232 ]] --[[ Name: _setupButtonInteractions ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_Signals_0 (copy)
    if v33.UIManager then
        v33.UIManager:BindButton(v33.RebirthNotificationGoButton);
        v33.UIManager:WatchRoot(v33.MenuBtns);
    end;
    v33.RebirthNotificationGoButton.MouseButton1Up:Connect(function() --[[ Line: 238 ]]
        -- upvalues: v33 (copy), l_LocalPlayer_0 (ref), l_Signals_0 (ref)
        if v33.IsTeleporting then
            return;
        else
            v33.IsTeleporting = true;
            local l_Character_0 = l_LocalPlayer_0.Character;
            if l_Character_0 then
                local l_HumanoidRootPart_0 = l_Character_0:FindFirstChild("HumanoidRootPart");
                if l_HumanoidRootPart_0 then
                    l_HumanoidRootPart_0.CFrame = v33.TouchPart.CFrame + Vector3.new(0, 3, 0, 0);
                    v33:_rebirthNotificationFade(false);
                    if l_Signals_0.CameraShake then
                        l_Signals_0.CameraShake:Fire(0.3, 0.2);
                    end;
                end;
            end;
            v33.IsTeleporting = false;
            return;
        end;
    end);
    if v33.TitlesBtn then
        v33.TitlesBtn.MouseButton1Click:Connect(function() --[[ Line: 262 ]]
            -- upvalues: v33 (copy)
            if v33.UIManager then
                v33.UIManager:OpenScreenFrame("TitlesFrame");
            end;
        end);
    end;
end;
v9._bindSignals = function(v36) --[[ Line: 270 ]] --[[ Name: _bindSignals ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_Signals_0 (copy)
    l_LocalPlayer_0:GetAttributeChangedSignal("Aura_Display"):Connect(function() --[[ Line: 271 ]]
        -- upvalues: v36 (copy)
        v36:_updateAura();
        v36:_updateRankBar(false);
    end);
    l_LocalPlayer_0:GetAttributeChangedSignal("Aura_Sci"):Connect(function() --[[ Line: 276 ]]
        -- upvalues: v36 (copy)
        v36:_updateAura();
        v36:_updateRankBar(false);
    end);
    l_LocalPlayer_0:GetAttributeChangedSignal("Rebirths_Display"):Connect(function() --[[ Line: 281 ]]
        -- upvalues: v36 (copy)
        v36:_updateRebirth();
    end);
    l_LocalPlayer_0:GetAttributeChangedSignal("Rebirths_Sci"):Connect(function() --[[ Line: 285 ]]
        -- upvalues: v36 (copy)
        v36:_updateRebirth();
        v36:_updateRebirthPackTextsSoft();
    end);
    l_LocalPlayer_0:GetAttributeChangedSignal("GlobalAuraEventMultiplier"):Connect(function() --[[ Line: 290 ]]
        -- upvalues: v36 (copy)
        v36:_updateGlobalAuraEventTimerLabels();
    end);
    l_LocalPlayer_0:GetAttributeChangedSignal("GlobalAuraEventEndsAtUnix"):Connect(function() --[[ Line: 294 ]]
        -- upvalues: v36 (copy)
        v36:_updateGlobalAuraEventTimerLabels();
    end);
    l_Signals_0.RebirthNotificationGotten:Connect(function(v37) --[[ Line: 298 ]]
        -- upvalues: v36 (copy)
        v36.NotifActive = v37 == true;
    end);
    if v36.CursedZoneService then
        v36.CursedZoneService.TimerStateChanged:Connect(function(v38) --[[ Line: 303 ]]
            -- upvalues: v36 (copy)
            v36:_applyCursedZoneTimerState(v38);
        end);
    end;
    if v36.PlayerService and v36.PlayerService.RebirthPerformed then
        v36.PlayerService.RebirthPerformed:Connect(function(_, _) --[[ Line: 309 ]]
            -- upvalues: v36 (copy)
            v36:_hideRebirthNotification();
            v36:_updateRebirth();
            v36:_updateAura();
            v36:_updateRankBar(false);
        end);
    end;
end;
v9._requestInitialCursedZoneState = function(v41) --[[ Line: 318 ]] --[[ Name: _requestInitialCursedZoneState ]]
    if not v41.CursedZoneService then
        return;
    else
        local l_status_2, l_result_2 = pcall(function() --[[ Line: 323 ]]
            -- upvalues: v41 (copy)
            return v41.CursedZoneService:GetTimerState();
        end);
        if l_status_2 and typeof(l_result_2) == "table" then
            v41:_applyCursedZoneTimerState(l_result_2);
        end;
        return;
    end;
end;
v9._applyCursedZoneTimerState = function(v44, v45) --[[ Line: 332 ]] --[[ Name: _applyCursedZoneTimerState ]]
    if typeof(v45) ~= "table" then
        return;
    else
        v44.CursedZoneState.IsActive = v45.IsActive == true;
        v44.CursedZoneState.EndsAt = tonumber(v45.EndsAt) or 0;
        v44.CursedZoneState.NextSpawnAt = tonumber(v45.NextSpawnAt) or 0;
        v44:_updateCursedZoneTimerLabel();
        return;
    end;
end;
v9._startCursedZoneTimerLoop = function(v46) --[[ Line: 344 ]] --[[ Name: _startCursedZoneTimerLoop ]]
    task.spawn(function() --[[ Line: 345 ]]
        -- upvalues: v46 (copy)
        while true do
            v46:_updateCursedZoneTimerLabel();
            task.wait(1);
        end;
    end);
end;
v9._refreshMultiTimerLabels = function(v47) --[[ Line: 353 ]] --[[ Name: _refreshMultiTimerLabels ]]
    -- upvalues: l_CollectionService_0 (copy)
    table.clear(v47.MultiTimerLabels);
    for _, v49 in ipairs(l_CollectionService_0:GetTagged("MultiTimer")) do
        if v49:IsA("TextLabel") then
            table.insert(v47.MultiTimerLabels, v49);
        end;
    end;
end;
v9._formatEventTimeLong = function(_, v51) --[[ Line: 363 ]] --[[ Name: _formatEventTimeLong ]]
    v51 = math.max(0, (math.floor(v51)));
    local v52 = math.floor(v51 / 604800);
    v51 = v51 % 604800;
    local v53 = math.floor(v51 / 86400);
    v51 = v51 % 86400;
    local v54 = math.floor(v51 / 3600);
    v51 = v51 % 3600;
    local v55 = math.floor(v51 / 60);
    local v56 = v51 % 60;
    if v52 > 0 then
        return string.format("%dw %dd %dh %ds", v52, v53, v54, v56);
    elseif v53 > 0 then
        return string.format("%dd %dh %dm %ds", v53, v54, v55, v56);
    elseif v54 > 0 then
        return string.format("%dh %dm %ds", v54, v55, v56);
    elseif v55 > 0 then
        return string.format("%dm %ds", v55, v56);
    else
        return string.format("%ds", v56);
    end;
end;
v9._updateGlobalAuraEventTimerLabels = function(v57) --[[ Line: 391 ]] --[[ Name: _updateGlobalAuraEventTimerLabels ]]
    -- upvalues: l_LocalPlayer_0 (copy), v6 (copy)
    if #v57.MultiTimerLabels == 0 then
        return;
    else
        local v58 = l_LocalPlayer_0:GetAttribute("GlobalAuraEventMultiplier") or 1;
        local v59 = l_LocalPlayer_0:GetAttribute("GlobalAuraEventEndsAtUnix") or 0;
        local v60 = "2x Aura ended";
        if typeof(v58) == "number" and v58 > 1 and typeof(v59) == "number" and v59 > 0 then
            local v61 = v59 - os.time();
            if v61 > 0 then
                v60 = string.format("%sx Aura ends in: %s", v6.FormatNumber(v58), v57:_formatEventTimeLong(v61));
            end;
        end;
        for _, v63 in ipairs(v57.MultiTimerLabels) do
            if v63 and v63.Parent then
                v63.Text = v60;
            end;
        end;
        return;
    end;
end;
v9._startGlobalAuraEventTimerLoop = function(v64) --[[ Line: 424 ]] --[[ Name: _startGlobalAuraEventTimerLoop ]]
    if v64.MultiTimerLoopStarted then
        return;
    else
        v64.MultiTimerLoopStarted = true;
        task.spawn(function() --[[ Line: 431 ]]
            -- upvalues: v64 (copy)
            while true do
                v64:_refreshMultiTimerLabels();
                v64:_updateGlobalAuraEventTimerLabels();
                task.wait(1);
            end;
        end);
        return;
    end;
end;
v9._formatClockTime = function(_, v66) --[[ Line: 440 ]] --[[ Name: _formatClockTime ]]
    v66 = math.max(0, (math.floor(v66)));
    local v67 = math.floor(v66 / 60);
    local v68 = v66 % 60;
    return string.format("%02d:%02d", v67, v68);
end;
v9._updateCursedZoneTimerLabel = function(v69) --[[ Line: 449 ]] --[[ Name: _updateCursedZoneTimerLabel ]]
    if not v69.CursedZoneTimer then
        return;
    else
        local v70 = os.time();
        local v71 = tonumber(v69.CursedZoneState.EndsAt) or 0;
        local v72 = tonumber(v69.CursedZoneState.NextSpawnAt) or 0;
        local v73 = true;
        if v69.CursedZoneState.IsActive ~= true then
            v73 = v70 < v71;
        end;
        if v73 then
            local v74 = math.max(0, v71 - v70);
            v69.CursedZoneTimer.Text = "Cursed Zone Leaves In: " .. v69:_formatClockTime(v74);
            return;
        else
            local v75 = math.max(0, v72 - v70);
            v69.CursedZoneTimer.Text = "Cursed Zone Spawns In: " .. v69:_formatClockTime(v75);
            return;
        end;
    end;
end;
v9._getAuraBig = function(_) --[[ Line: 469 ]] --[[ Name: _getAuraBig ]]
    -- upvalues: l_LocalPlayer_0 (copy), v6 (copy)
    local l_l_LocalPlayer_0_Attribute_0 = l_LocalPlayer_0:GetAttribute("Aura_Sci");
    if typeof(l_l_LocalPlayer_0_Attribute_0) == "string" and l_l_LocalPlayer_0_Attribute_0 ~= "" then
        local v78 = v6.Normalize(l_l_LocalPlayer_0_Attribute_0);
        if v78 then
            return v78;
        end;
    end;
    local l_l_LocalPlayer_0_Attribute_1 = l_LocalPlayer_0:GetAttribute("Aura");
    return v6.Normalize(l_l_LocalPlayer_0_Attribute_1) or v6.Zero();
end;
v9._getRebirthsBig = function(_) --[[ Line: 483 ]] --[[ Name: _getRebirthsBig ]]
    -- upvalues: l_LocalPlayer_0 (copy), v6 (copy)
    local l_l_LocalPlayer_0_Attribute_2 = l_LocalPlayer_0:GetAttribute("Rebirths_Sci");
    if typeof(l_l_LocalPlayer_0_Attribute_2) == "string" and l_l_LocalPlayer_0_Attribute_2 ~= "" then
        local v82 = v6.Normalize(l_l_LocalPlayer_0_Attribute_2);
        if v82 then
            return v82;
        end;
    end;
    local l_l_LocalPlayer_0_Attribute_3 = l_LocalPlayer_0:GetAttribute("Rebirths");
    return v6.Normalize(l_l_LocalPlayer_0_Attribute_3) or v6.Zero();
end;
v9._getPeakAuraBig = function(_) --[[ Line: 497 ]] --[[ Name: _getPeakAuraBig ]]
    -- upvalues: l_LocalPlayer_0 (copy), v6 (copy)
    local l_l_LocalPlayer_0_Attribute_4 = l_LocalPlayer_0:GetAttribute("PeakAura_Sci");
    if typeof(l_l_LocalPlayer_0_Attribute_4) == "string" and l_l_LocalPlayer_0_Attribute_4 ~= "" then
        local v86 = v6.Normalize(l_l_LocalPlayer_0_Attribute_4);
        if v86 then
            return v86;
        end;
    end;
    local l_l_LocalPlayer_0_Attribute_5 = l_LocalPlayer_0:GetAttribute("PeakAura");
    return v6.Normalize(l_l_LocalPlayer_0_Attribute_5) or v6.Zero();
end;
v9._getAuraDisplay = function(_) --[[ Line: 511 ]] --[[ Name: _getAuraDisplay ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    return l_LocalPlayer_0:GetAttribute("Aura_Display") or "0";
end;
v9._getRebirthsDisplay = function(_) --[[ Line: 515 ]] --[[ Name: _getRebirthsDisplay ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    return l_LocalPlayer_0:GetAttribute("Rebirths_Display") or "0";
end;
v9._rebirthNotificationFade = function(v90, v91) --[[ Line: 519 ]] --[[ Name: _rebirthNotificationFade ]]
    -- upvalues: l_Signals_0 (copy)
    if v91 then
        v90.TopBarFadeIn:Play();
        l_Signals_0.RebirthNotificationGotten:Fire(true);
        return;
    else
        v90.TopBarFadeOut:Play();
        l_Signals_0.RebirthNotificationGotten:Fire(false);
        return;
    end;
end;
v9._hideRebirthNotification = function(v92) --[[ Line: 529 ]] --[[ Name: _hideRebirthNotification ]]
    if not v92.NotifActive then
        return;
    else
        v92.NotifActive = false;
        v92:_rebirthNotificationFade(false);
        return;
    end;
end;
v9._showRebirthNotification = function(v93) --[[ Line: 538 ]] --[[ Name: _showRebirthNotification ]]
    v93.NotifActive = true;
    v93:_rebirthNotificationFade(true);
end;
v9._triggerRebirthNotification = function(v94) --[[ Line: 543 ]] --[[ Name: _triggerRebirthNotification ]]
    -- upvalues: l_clock_0 (copy)
    local v95 = l_clock_0();
    if v95 - v94.LastRebirthNotifTime < 120 then
        return;
    else
        v94.LastRebirthNotifTime = v95;
        v94:_showRebirthNotification();
        task.delay(11, function() --[[ Line: 553 ]]
            -- upvalues: v94 (copy), v95 (copy)
            if v94.LastRebirthNotifTime == v95 then
                v94:_hideRebirthNotification();
            end;
        end);
        return;
    end;
end;
v9._shouldSuggestRebirth = function(v96, v97, v98) --[[ Line: 560 ]] --[[ Name: _shouldSuggestRebirth ]]
    -- upvalues: v6 (copy), l_Ranked_0 (copy)
    if not v98 or v6.LessThan(v98, 1) then
        return false;
    else
        local v99 = v96:_getRebirthsBig();
        if v6.IsZero(v99) then
            return true;
        elseif v6.LessThanOrEqual(v99, 0) then
            return l_Ranked_0.GetProgress(v97).alpha >= 0.85;
        else
            local v100 = v6.Multiply(v99, 5);
            if v100 and v6.LessThan(v98, v100) then
                return false;
            else
                return l_Ranked_0.GetProgress(v97).alpha >= 0.85;
            end;
        end;
    end;
end;
v9._softSetText = function(_, v102, v103) --[[ Line: 585 ]] --[[ Name: _softSetText ]]
    -- upvalues: l_TweenService_0 (copy)
    if v102.Text == v103 then
        return;
    else
        v102.Text = v103;
        local l_TextTransparency_0 = v102.TextTransparency;
        v102.TextTransparency = math.max(l_TextTransparency_0, 0.55);
        l_TweenService_0:Create(v102, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = l_TextTransparency_0
        }):Play();
        return;
    end;
end;
v9._getPreviewRebirthPackAdd = function(_, v106, v107) --[[ Line: 600 ]] --[[ Name: _getPreviewRebirthPackAdd ]]
    -- upvalues: l_Monetization_0 (copy), l_LocalPlayer_0 (copy), v6 (copy)
    local l_status_3, l_result_3 = pcall(function() --[[ Line: 601 ]]
        -- upvalues: l_Monetization_0 (ref), v106 (copy), v107 (copy), l_LocalPlayer_0 (ref)
        return l_Monetization_0.GetRebirthPackAdd(v106, v107, l_LocalPlayer_0);
    end);
    if l_status_3 and l_result_3 then
        return l_result_3;
    else
        warn("[HudController] Failed to preview rebirth pack amount for pack index:", v106);
        return v6.Zero();
    end;
end;
v9._updateRebirthPackTextsSoft = function(v110) --[[ Line: 613 ]] --[[ Name: _updateRebirthPackTextsSoft ]]
    -- upvalues: l_clock_0 (copy), v6 (copy)
    local v111 = l_clock_0();
    if v111 - v110.LastSoftUpdateAt < 0.15 then
        if v110.SoftUpdateQueued then
            return;
        else
            v110.SoftUpdateQueued = true;
            task.delay(0.15, function() --[[ Line: 621 ]]
                -- upvalues: v110 (copy)
                v110.SoftUpdateQueued = false;
                v110:_updateRebirthPackTextsSoft();
            end);
            return;
        end;
    else
        v110.LastSoftUpdateAt = v111;
        local v112 = v110:_getRebirthsBig();
        local v113 = v110:_getPreviewRebirthPackAdd(1, v112);
        local v114 = v110:_getPreviewRebirthPackAdd(2, v112);
        local v115 = "+" .. v6.FormatNumber(v113);
        local v116 = "+" .. v6.FormatNumber(v114);
        if v115 ~= v110.LastSmallText then
            v110.LastSmallText = v115;
            v110:_softSetText(v110.SmallRebirthBundleTextLabel, v115);
        end;
        if v116 ~= v110.LastBigText then
            v110.LastBigText = v116;
            v110:_softSetText(v110.BigRebirthBundleTextLabel, v116);
        end;
        return;
    end;
end;
v9._updateAura = function(v117) --[[ Line: 648 ]] --[[ Name: _updateAura ]]
    -- upvalues: l_LocalPlayer_0 (copy), v6 (copy)
    local v118 = v117:_getAuraBig();
    local v119 = v117:_getAuraDisplay();
    local v120 = l_LocalPlayer_0:GetAttribute("Aura_Sci") or "0";
    if v120 == v117.LastAuraForAuraUI then
        return;
    else
        v117.LastAuraForAuraUI = v120;
        v117.AuraFrame.Count.Text = v119;
        if v6.LessThan(v118, 1000) then
            if v117.LastPadTextAuraBucket ~= 0 then
                v117.LastPadTextAuraBucket = 0;
                v117.PadText.Text = "Need More Aura";
                v117.RebirthNotificationCount.Text = "Need More Aura";
                return;
            end;
        else
            local v121 = v6.Floor(v6.Divide(v118, 1000));
            local v122 = v121 and v6.FormatScientific(v121) or "0";
            if v122 ~= v117.LastPadTextAuraBucket then
                local v123 = false;
                if v117.LastPadTextAuraBucket ~= -1 then
                    v123 = v117.LastPadTextAuraBucket ~= v122;
                end;
                v117.LastPadTextAuraBucket = v122;
                local v124 = "+" .. v6.FormatNumber(v121 or 0);
                v117.PadText.Text = v124;
                v117.RebirthNotificationCount.Text = v124;
                if v123 and v117:_shouldSuggestRebirth(v118, v121 or v6.Zero()) then
                    v117:_triggerRebirthNotification();
                end;
            end;
        end;
        return;
    end;
end;
v9._updateRebirth = function(v125) --[[ Line: 685 ]] --[[ Name: _updateRebirth ]]
    -- upvalues: l_LocalPlayer_0 (copy), v6 (copy)
    local v126 = v125:_getRebirthsBig();
    local v127 = v125:_getRebirthsDisplay();
    local v128 = l_LocalPlayer_0:GetAttribute("Rebirths_Sci") or "0";
    if v128 == v125.LastRebirthsForUI then
        return;
    else
        if v125.LastRebirthsForUI ~= -1 then
            local v129 = v6.Normalize(v125.LastRebirthsForUI);
            if v129 and v6.GreaterThan(v126, v129) then
                v125:_hideRebirthNotification();
            end;
        end;
        v125.LastRebirthsForUI = v128;
        v125.RebirthFrame.Count.Text = v127;
        v125:_updateRebirthPackTextsSoft();
        return;
    end;
end;
v9._warpAlpha = function(_, v131) --[[ Line: 706 ]] --[[ Name: _warpAlpha ]]
    -- upvalues: l_clamp_0 (copy)
    return l_clamp_0(v131, 0, 1) ^ 0.35;
end;
v9._formatProgress = function(_, v133, v134, v135) --[[ Line: 711 ]] --[[ Name: _formatProgress ]]
    -- upvalues: v6 (copy), l_floor_0 (copy)
    local v136 = v6.FormatNumber(v133);
    local v137 = v6.FormatNumber(v134);
    if v135 >= 0.85 and v6.GreaterThan(v134, 0) then
        return string.format("%s / %s  (%d%%)", v136, v137, (l_floor_0(v135 * 100 + 0.5)));
    else
        return string.format("%s / %s", v136, v137);
    end;
end;
v9._getMultiplierGradientIndex = function(_, v139) --[[ Line: 722 ]] --[[ Name: _getMultiplierGradientIndex ]]
    -- upvalues: l_Ranked_0 (copy)
    local v140 = v139 / l_Ranked_0.GetCount();
    if v140 < 0.06 then
        return "1";
    elseif v140 < 0.12 then
        return "2";
    elseif v140 < 0.2 then
        return "3";
    elseif v140 < 0.3 then
        return "4";
    elseif v140 < 0.45 then
        return "5";
    elseif v140 < 0.6 then
        return "6";
    elseif v140 < 0.75 then
        return "7";
    elseif v140 < 0.9 then
        return "8";
    else
        return "9";
    end;
end;
v9._applyMultiplierGradient = function(v141, v142) --[[ Line: 745 ]] --[[ Name: _applyMultiplierGradient ]]
    local v143 = v141:_getMultiplierGradientIndex(v142);
    if v141.CurrentGradientName == v143 then
        return;
    else
        if v141.CurrentGradientName then
            local v144 = v141.MultiplierGradients[v141.CurrentGradientName];
            if v144 then
                v144.Enabled = false;
            end;
        end;
        local v145 = v141.MultiplierGradients[v143];
        if v145 then
            v145.Enabled = true;
        end;
        v141.CurrentGradientName = v143;
        return;
    end;
end;
v9._applyRankDisplay = function(_, v147, v148, v149) --[[ Line: 766 ]] --[[ Name: _applyRankDisplay ]]
    -- upvalues: l_Ranked_0 (copy)
    l_Ranked_0.ApplyRankDisplay(v147, v148, v149);
end;
v9._playRankDisplayFlash = function(v150, v151, v152, v153) --[[ Line: 770 ]] --[[ Name: _playRankDisplayFlash ]]
    -- upvalues: l_TweenService_0 (copy)
    if v150:_applyRankDisplay(v153, v151, v152) == "Image" and v152 then
        local l_ImageTransparency_0 = v152.ImageTransparency;
        v152.ImageTransparency = math.max(l_ImageTransparency_0, 0.55);
        l_TweenService_0:Create(v152, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            ImageTransparency = l_ImageTransparency_0
        }):Play();
        return;
    else
        if v151 then
            local l_TextTransparency_1 = v151.TextTransparency;
            v151.TextTransparency = math.max(l_TextTransparency_1, 0.55);
            l_TweenService_0:Create(v151, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = l_TextTransparency_1
            }):Play();
        end;
        return;
    end;
end;
v9._showPlainTextDisplay = function(_, v157, v158, v159) --[[ Line: 790 ]] --[[ Name: _showPlainTextDisplay ]]
    if v157 then
        v157.Visible = true;
        v157.Text = v159;
    end;
    if v158 then
        v158.Visible = false;
    end;
end;
v9._getScale = function(_, v161) --[[ Line: 801 ]] --[[ Name: _getScale ]]
    local l_UIScale_0 = v161:FindFirstChildOfClass("UIScale");
    if not l_UIScale_0 then
        l_UIScale_0 = Instance.new("UIScale");
        l_UIScale_0.Name = "AutoUIScale";
        l_UIScale_0.Parent = v161;
    end;
    return l_UIScale_0;
end;
v9._punchRankContainer = function(v163, v164) --[[ Line: 811 ]] --[[ Name: _punchRankContainer ]]
    -- upvalues: l_TweenService_0 (copy), v15 (copy), v16 (copy)
    local v165 = v163:_getScale(v163.RankFrame);
    if v163.ScaleTween then
        v163.ScaleTween:Cancel();
    end;
    local v166 = l_TweenService_0:Create(v165, v15, {
        Scale = v164 + 1
    });
    v166:Play();
    v166.Completed:Once(function() --[[ Line: 820 ]]
        -- upvalues: v163 (copy), l_TweenService_0 (ref), v165 (copy), v16 (ref)
        v163.ScaleTween = l_TweenService_0:Create(v165, v16, {
            Scale = 1
        });
        v163.ScaleTween:Play();
    end);
end;
v9._applyFill = function(v167, v168, v169) --[[ Line: 826 ]] --[[ Name: _applyFill ]]
    -- upvalues: l_TweenService_0 (copy), v14 (copy)
    if v167.IsRankUpAnimating then
        return;
    else
        local v170 = UDim2.new(v167.BarFullX * v168, 0, v167.BarYScale, 0);
        if v167.FillTween then
            v167.FillTween:Cancel();
        end;
        if v169 then
            v167.ProgressBar.Size = v170;
            if v167.OriginalBarColor then
                v167.ProgressBar.BackgroundColor3 = v167.OriginalBarColor;
                return;
            end;
        else
            v167.FillTween = l_TweenService_0:Create(v167.ProgressBar, v14, {
                Size = v170
            });
            v167.FillTween:Play();
        end;
        return;
    end;
end;
v9._playRankUpSequence = function(v171, v172) --[[ Line: 848 ]] --[[ Name: _playRankUpSequence ]]
    -- upvalues: l_TweenService_0 (copy), v16 (copy), v18 (copy), v6 (copy), l_Signals_0 (copy), l_Ranked_0 (copy), v17 (copy)
    v171.IsRankUpAnimating = true;
    local v173 = v171:_getScale(v171.RankFrame);
    if v171.FillTween then
        v171.FillTween:Cancel();
    end;
    local v174 = l_TweenService_0:Create(v171.ProgressBar, v16, {
        Size = UDim2.new(v171.BarFullX * 1.05, 0, v171.BarYScale, 0), 
        BackgroundColor3 = Color3.new(1, 1, 1)
    });
    local v175 = l_TweenService_0:Create(v173, v16, {
        Scale = 1.15
    });
    v174:Play();
    v175:Play();
    task.wait(0.35);
    local v176 = l_TweenService_0:Create(v171.ProgressBar, v18, {
        Size = UDim2.new(0, 0, v171.BarYScale, 0)
    });
    local v177 = l_TweenService_0:Create(v173, v18, {
        Scale = 1
    });
    v176:Play();
    v177:Play();
    task.wait(0.1);
    v171:_playRankDisplayFlash(v171.CurrentRank, v171.CurrentRankImage, v172.name);
    v171:_playRankDisplayFlash(v171.GoalRank, v171.GoalRankImage, v172.nextName);
    v171.RankFrame.Multiplier.Text = string.format("x%s", v6.FormatNumber(v172.multiplier));
    v171:_applyMultiplierGradient(v172.index);
    v171.ProgressText.Text = v171:_formatProgress(v172.aura, v172.nextReq, v172.alpha);
    v171:_updateRebirthPackTextsSoft();
    if l_Signals_0.RankUpFX then
        l_Signals_0.RankUpFX:Fire(v172.name, v172.index);
    end;
    task.wait(0.1);
    if v171.OriginalBarColor then
        l_TweenService_0:Create(v171.ProgressBar, TweenInfo.new(0.3), {
            BackgroundColor3 = v171.OriginalBarColor
        }):Play();
    end;
    v171:_punchRankContainer(0.1);
    task.wait(0.1);
    v171.IsRankUpAnimating = false;
    local v178 = l_Ranked_0.GetProgress(v171:_getAuraBig());
    v171.FillTween = l_TweenService_0:Create(v171.ProgressBar, v17, {
        Size = UDim2.new(v171.BarFullX * v171:_warpAlpha(v178.alpha), 0, v171.BarYScale, 0)
    });
    v171.FillTween:Play();
end;
v9._processRankUpQueue = function(v179) --[[ Line: 917 ]] --[[ Name: _processRankUpQueue ]]
    if v179.IsProcessingQueue then
        return;
    elseif #v179.RankUpQueue == 0 then
        return;
    else
        v179.IsProcessingQueue = true;
        while #v179.RankUpQueue > 0 do
            local v180 = table.remove(v179.RankUpQueue, 1);
            if #v179.RankUpQueue > 0 then
                v179:_applyRankDisplay(v180.name, v179.CurrentRank, v179.CurrentRankImage);
            else
                v179:_playRankUpSequence(v180);
                repeat
                    task.wait(0.05);
                until not v179.IsRankUpAnimating;
            end;
        end;
        v179.IsProcessingQueue = false;
        return;
    end;
end;
v9._updateRankBar = function(v181, v182) --[[ Line: 946 ]] --[[ Name: _updateRankBar ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_Ranked_0 (copy), v6 (copy)
    local v183 = v181:_getAuraBig();
    local v184 = l_LocalPlayer_0:GetAttribute("Aura_Sci") or "0";
    if v184 == v181.LastAura and not v182 and not v181.IsRankUpAnimating then
        return;
    else
        local v185 = l_Ranked_0.GetProgress(v183);
        v181:_applyMultiplierGradient(v185.index);
        if v185.nextIndex == v185.index then
            if v185.index ~= v181.LastIndex then
                v181:_applyRankDisplay(v185.name, v181.CurrentRank, v181.CurrentRankImage);
                v181.LastIndex = v185.index;
            end;
            v181:_showPlainTextDisplay(v181.GoalRank, v181.GoalRankImage, "MAX");
            v181.ProgressText.Text = "MAX RANK ACHIEVED";
            v181.RankFrame.Multiplier.Text = string.format("x%s", v6.FormatNumber(v185.multiplier));
            v181:_applyFill(1, v182);
            v181.LastAura = v184;
            v181.LastNextIndex = v185.nextIndex;
            return;
        else
            local v186 = v181:_warpAlpha(v185.alpha);
            if not v182 and v181.LastIndex ~= -1 and v185.index > v181.LastIndex then
                table.insert(v181.RankUpQueue, v185);
                v181.LastIndex = v185.index;
                v181.LastNextIndex = v185.nextIndex;
                v181.LastAura = v184;
                task.spawn(function() --[[ Line: 982 ]]
                    -- upvalues: v181 (copy)
                    v181:_processRankUpQueue();
                end);
                return;
            else
                if v185.index ~= v181.LastIndex then
                    v181:_applyRankDisplay(v185.name, v181.CurrentRank, v181.CurrentRankImage);
                    v181.LastIndex = v185.index;
                end;
                if v185.nextIndex ~= v181.LastNextIndex then
                    v181:_applyRankDisplay(v185.nextName, v181.GoalRank, v181.GoalRankImage);
                    v181.LastNextIndex = v185.nextIndex;
                end;
                v181.ProgressText.Text = v181:_formatProgress(v183, v185.nextReq, v185.alpha);
                v181.RankFrame.Multiplier.Text = string.format("x%s", v6.FormatNumber(v185.multiplier));
                v181:_applyFill(v186, v182);
                v181.LastAura = v184;
                return;
            end;
        end;
    end;
end;
return v9;