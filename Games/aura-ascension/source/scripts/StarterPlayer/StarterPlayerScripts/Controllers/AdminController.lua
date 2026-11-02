-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_Workspace_0 = game:GetService("Workspace");
local l_TweenService_0 = game:GetService("TweenService");
local l_Lighting_0 = game:GetService("Lighting");
local l_SoundService_0 = game:GetService("SoundService");
local l_Knit_0 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"));
local l_SoundMuteUtil_0 = require(l_ReplicatedStorage_0:WaitForChild("Modules"):WaitForChild("SoundMuteUtil"));
local v9 = l_Knit_0.CreateController({
    Name = "AdminController"
});
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v11 = Random.new();
local v12 = TweenInfo.new(0.32, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
local v13 = TweenInfo.new(0.32, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
local v14 = {
    Cam4 = "Woosh", 
    Cam5 = "Cinema", 
    Cam6 = "Ice Shatter", 
    Cam7 = "Woosh", 
    Cam8 = "Wind"
};
v9.KnitInit = function(v15) --[[ Line: 55 ]] --[[ Name: KnitInit ]]
    v15.LiveEventService = nil;
    v15.ActiveEventId = 0;
    v15.RenderConnection = nil;
    v15.EventRunning = false;
    v15.CurrentPhase = "Idle";
    v15.CurrentPhaseToken = 0;
    v15.ShakeIntensity = 8;
    v15.EndCameraHoldDuration = 2;
    v15.Cam1Name = "Cam1";
    v15.Cam2Name = "Cam2";
    v15.StartCameraData = nil;
    v15.Cam2Data = nil;
    v15.EndCameraData = {};
    v15.PreviousCameraType = nil;
    v15.PreviousCameraSubject = nil;
    v15.DisabledGuis = {};
    v15.PlayerGui = nil;
    v15.TransitionGui = nil;
    v15.TransitionFrame = nil;
    v15.PreviousClockTime = nil;
    v15.ClockTimeForced = false;
    v15.EventAudioMuted = false;
    v15.LiveEventSoundFolder = nil;
    v15.LiveEventSoundTemplates = {};
    v15.ActiveLiveEventSounds = {};
    v15.LiveEventBaseVolumes = {};
    v15.EarthquakeFadeTween = nil;
    v15.ActiveOneShotFadeTweens = {};
end;
v9.KnitStart = function(v16) --[[ Line: 95 ]] --[[ Name: KnitStart ]]
    -- upvalues: l_Knit_0 (copy), l_LocalPlayer_0 (copy)
    v16.LiveEventService = l_Knit_0.GetService("LiveEventService");
    v16.PlayerGui = l_LocalPlayer_0:WaitForChild("PlayerGui");
    v16:_ensureTransitionGui();
    v16:_bindSignals();
end;
v9._bindSignals = function(v17) --[[ Line: 102 ]] --[[ Name: _bindSignals ]]
    if not v17.LiveEventService then
        warn("[AdminController] LiveEventService not found");
        return;
    elseif not v17.LiveEventService.EventStarted then
        warn("[AdminController] LiveEventService.EventStarted missing");
        return;
    elseif not v17.LiveEventService.PhaseChanged then
        warn("[AdminController] LiveEventService.PhaseChanged missing");
        return;
    elseif not v17.LiveEventService.EventEnded then
        warn("[AdminController] LiveEventService.EventEnded missing");
        return;
    else
        v17.LiveEventService.EventStarted:Connect(function(v18) --[[ Line: 123 ]]
            -- upvalues: v17 (copy)
            v17:_onEventStarted(v18);
        end);
        v17.LiveEventService.PhaseChanged:Connect(function(v19, v20) --[[ Line: 127 ]]
            -- upvalues: v17 (copy)
            v17:_onPhaseChanged(v19, v20);
        end);
        v17.LiveEventService.EventEnded:Connect(function() --[[ Line: 131 ]]
            -- upvalues: v17 (copy)
            v17:_onEventEnded();
        end);
        return;
    end;
end;
v9._ensureTransitionGui = function(v21) --[[ Line: 136 ]] --[[ Name: _ensureTransitionGui ]]
    local l_AdminTransitionGui_0 = v21.PlayerGui:FindFirstChild("AdminTransitionGui");
    if not l_AdminTransitionGui_0 then
        l_AdminTransitionGui_0 = Instance.new("ScreenGui");
        l_AdminTransitionGui_0.Name = "AdminTransitionGui";
        l_AdminTransitionGui_0.IgnoreGuiInset = true;
        l_AdminTransitionGui_0.ResetOnSpawn = false;
        l_AdminTransitionGui_0.DisplayOrder = 10000;
        l_AdminTransitionGui_0.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        l_AdminTransitionGui_0.Parent = v21.PlayerGui;
    end;
    local l_TransitionFrame_0 = l_AdminTransitionGui_0:FindFirstChild("TransitionFrame");
    if not l_TransitionFrame_0 then
        l_TransitionFrame_0 = Instance.new("Frame");
        l_TransitionFrame_0.Name = "TransitionFrame";
        l_TransitionFrame_0.BackgroundColor3 = Color3.new(0, 0, 0);
        l_TransitionFrame_0.BorderSizePixel = 0;
        l_TransitionFrame_0.Size = UDim2.fromScale(1, 1);
        l_TransitionFrame_0.Position = UDim2.fromScale(1, 0);
        l_TransitionFrame_0.Visible = false;
        l_TransitionFrame_0.ZIndex = 10000;
        l_TransitionFrame_0.Parent = l_AdminTransitionGui_0;
    end;
    v21.TransitionGui = l_AdminTransitionGui_0;
    v21.TransitionFrame = l_TransitionFrame_0;
end;
v9._playTransition = function(v24, v25) --[[ Line: 165 ]] --[[ Name: _playTransition ]]
    -- upvalues: l_TweenService_0 (copy), v12 (copy), v13 (copy)
    if not v24.TransitionGui or not v24.TransitionFrame then
        if v25 then
            v25();
        end;
        return;
    else
        v24.TransitionGui.Enabled = true;
        local l_TransitionFrame_1 = v24.TransitionFrame;
        l_TransitionFrame_1.Visible = true;
        l_TransitionFrame_1.Position = UDim2.fromScale(1, 0);
        local v27 = l_TweenService_0:Create(l_TransitionFrame_1, v12, {
            Position = UDim2.fromScale(0, 0)
        });
        v27:Play();
        v27.Completed:Wait();
        if v25 then
            v25();
        end;
        local v28 = l_TweenService_0:Create(l_TransitionFrame_1, v13, {
            Position = UDim2.fromScale(-1, 0)
        });
        v28:Play();
        v28.Completed:Wait();
        l_TransitionFrame_1.Visible = false;
        l_TransitionFrame_1.Position = UDim2.fromScale(1, 0);
        return;
    end;
end;
v9._disconnectRender = function(v29) --[[ Line: 199 ]] --[[ Name: _disconnectRender ]]
    if v29.RenderConnection then
        v29.RenderConnection:Disconnect();
        v29.RenderConnection = nil;
    end;
end;
v9._disableAllScreenGuis = function(v30) --[[ Line: 206 ]] --[[ Name: _disableAllScreenGuis ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    local l_PlayerGui_0 = l_LocalPlayer_0:FindFirstChild("PlayerGui");
    if not l_PlayerGui_0 then
        return;
    else
        table.clear(v30.DisabledGuis);
        for _, v33 in ipairs(l_PlayerGui_0:GetChildren()) do
            if v33:IsA("ScreenGui") and v33.Name ~= "AdminTransitionGui" then
                v30.DisabledGuis[v33] = v33.Enabled;
                v33.Enabled = false;
            end;
        end;
        return;
    end;
end;
v9._restoreScreenGuis = function(v34) --[[ Line: 222 ]] --[[ Name: _restoreScreenGuis ]]
    for v35, v36 in pairs(v34.DisabledGuis) do
        if v35 and v35.Parent then
            v35.Enabled = v36;
        end;
    end;
    table.clear(v34.DisabledGuis);
end;
v9._forceClockTime = function(v37) --[[ Line: 232 ]] --[[ Name: _forceClockTime ]]
    -- upvalues: l_Lighting_0 (copy)
    if v37.ClockTimeForced then
        return;
    else
        v37.PreviousClockTime = l_Lighting_0.ClockTime;
        l_Lighting_0.ClockTime = 0;
        v37.ClockTimeForced = true;
        return;
    end;
end;
v9._restoreClockTime = function(v38) --[[ Line: 242 ]] --[[ Name: _restoreClockTime ]]
    -- upvalues: l_Lighting_0 (copy)
    if not v38.ClockTimeForced then
        return;
    else
        if typeof(v38.PreviousClockTime) == "number" then
            l_Lighting_0.ClockTime = v38.PreviousClockTime;
        end;
        v38.PreviousClockTime = nil;
        v38.ClockTimeForced = false;
        return;
    end;
end;
v9._restoreCamera = function(v39) --[[ Line: 255 ]] --[[ Name: _restoreCamera ]]
    -- upvalues: l_Workspace_0 (copy)
    local l_CurrentCamera_0 = l_Workspace_0.CurrentCamera;
    if not l_CurrentCamera_0 then
        return;
    else
        if v39.PreviousCameraType then
            l_CurrentCamera_0.CameraType = v39.PreviousCameraType;
        end;
        if v39.PreviousCameraSubject then
            l_CurrentCamera_0.CameraSubject = v39.PreviousCameraSubject;
        end;
        return;
    end;
end;
v9._resetState = function(v41) --[[ Line: 270 ]] --[[ Name: _resetState ]]
    v41.CurrentPhase = "Idle";
    v41.CurrentPhaseToken = v41.CurrentPhaseToken + 1;
    v41.Cam1Name = "Cam1";
    v41.Cam2Name = "Cam2";
    v41.StartCameraData = nil;
    v41.Cam2Data = nil;
    v41.EndCameraData = {};
    v41.ShakeIntensity = 8;
    v41.EndCameraHoldDuration = 2;
    v41.EventRunning = false;
end;
v9._finalizeLiveEvent = function(v42) --[[ Line: 285 ]] --[[ Name: _finalizeLiveEvent ]]
    v42:_disconnectRender();
    v42:_stopAllLiveEventSounds();
    v42:_restoreMutedSounds();
    v42:_restoreScreenGuis();
    v42:_restoreClockTime();
    v42:_restoreCamera();
    v42:_resetState();
end;
v9._finalizeLiveEventWithTransition = function(v43, v44) --[[ Line: 295 ]] --[[ Name: _finalizeLiveEventWithTransition ]]
    v43:_playTransition(function() --[[ Line: 296 ]]
        -- upvalues: v44 (copy), v43 (copy)
        if v44 ~= v43.ActiveEventId then
            return;
        else
            v43:_stopAllLiveEventSounds();
            v43:_restoreMutedSounds();
            v43:_restoreScreenGuis();
            v43:_restoreClockTime();
            v43:_restoreCamera();
            return;
        end;
    end);
    if v44 ~= v43.ActiveEventId then
        return;
    else
        v43:_resetState();
        return;
    end;
end;
v9._easeInOutSine = function(_, v46) --[[ Line: 315 ]] --[[ Name: _easeInOutSine ]]
    return -(math.cos(3.141592653589793 * math.clamp(v46, 0, 1)) - 1) / 2;
end;
v9._getShakeOffset = function(v47, v48) --[[ Line: 320 ]] --[[ Name: _getShakeOffset ]]
    -- upvalues: v11 (copy)
    local v49 = 1 - math.clamp(v48, 0, 1);
    local l_ShakeIntensity_0 = v47.ShakeIntensity;
    local v51 = v11:NextNumber(-1, 1) * l_ShakeIntensity_0 * 0.06 * v49;
    local v52 = v11:NextNumber(-1, 1) * l_ShakeIntensity_0 * 0.045 * v49;
    local v53 = v11:NextNumber(-1, 1) * l_ShakeIntensity_0 * 0.03 * v49;
    local v54 = math.rad(v11:NextNumber(-1, 1) * l_ShakeIntensity_0 * 0.18 * v49);
    local v55 = math.rad(v11:NextNumber(-1, 1) * l_ShakeIntensity_0 * 0.18 * v49);
    local v56 = math.rad(v11:NextNumber(-1, 1) * l_ShakeIntensity_0 * 0.12 * v49);
    return CFrame.new(v51, v52, v53) * CFrame.Angles(v54, v55, v56);
end;
v9._applyCameraCFrame = function(_, v58, v59) --[[ Line: 337 ]] --[[ Name: _applyCameraCFrame ]]
    v58.CameraType = Enum.CameraType.Scriptable;
    v58.CameraSubject = nil;
    v58.CFrame = v59;
    v58.Focus = v59;
end;
v9._isValidCameraData = function(_, v61) --[[ Line: 344 ]] --[[ Name: _isValidCameraData ]]
    local v62 = false;
    if typeof(v61) == "table" then
        v62 = typeof(v61.CFrame) == "CFrame";
    end;
    return v62;
end;
v9._getCameraFolder = function(_) --[[ Line: 348 ]] --[[ Name: _getCameraFolder ]]
    -- upvalues: l_Workspace_0 (copy)
    local l_CameraParts_0 = l_Workspace_0:FindFirstChild("CameraParts");
    if l_CameraParts_0 and l_CameraParts_0:IsA("Folder") then
        return l_CameraParts_0;
    else
        return nil;
    end;
end;
v9._getCameraPart = function(v65, v66) --[[ Line: 356 ]] --[[ Name: _getCameraPart ]]
    local v67 = v65:_getCameraFolder();
    if not v67 then
        return nil;
    else
        local l_v67_FirstChild_0 = v67:FindFirstChild(v66);
        if l_v67_FirstChild_0 and l_v67_FirstChild_0:IsA("BasePart") then
            return l_v67_FirstChild_0;
        else
            return nil;
        end;
    end;
end;
v9._snapCameraToNamedPart = function(v69, v70) --[[ Line: 370 ]] --[[ Name: _snapCameraToNamedPart ]]
    -- upvalues: l_Workspace_0 (copy)
    local l_CurrentCamera_1 = l_Workspace_0.CurrentCamera;
    if not l_CurrentCamera_1 then
        return;
    else
        local v72 = v69:_getCameraPart(v70);
        if not v72 then
            warn("[AdminController] Missing camera part:", v70);
            return;
        else
            v69:_applyCameraCFrame(l_CurrentCamera_1, v72.CFrame);
            return;
        end;
    end;
end;
v9._getLiveEventSoundTemplateFolder = function(_) --[[ Line: 385 ]] --[[ Name: _getLiveEventSoundTemplateFolder ]]
    -- upvalues: l_ReplicatedStorage_0 (copy)
    local l_LiveEventSounds_0 = l_ReplicatedStorage_0:FindFirstChild("LiveEventSounds");
    if l_LiveEventSounds_0 and l_LiveEventSounds_0:IsA("Folder") then
        return l_LiveEventSounds_0;
    else
        return nil;
    end;
end;
v9._setupLiveEventSounds = function(v75) --[[ Line: 394 ]] --[[ Name: _setupLiveEventSounds ]]
    -- upvalues: l_SoundService_0 (copy)
    v75:_stopAllLiveEventSounds();
    local v76 = v75:_getLiveEventSoundTemplateFolder();
    if not v76 then
        warn("[AdminController] Missing ReplicatedStorage.LiveEventSounds");
        return;
    else
        v75.LiveEventSoundFolder = Instance.new("Folder");
        v75.LiveEventSoundFolder.Name = "LiveEventSounds";
        v75.LiveEventSoundFolder.Parent = l_SoundService_0;
        table.clear(v75.LiveEventSoundTemplates);
        table.clear(v75.ActiveLiveEventSounds);
        table.clear(v75.LiveEventBaseVolumes);
        for _, v78 in ipairs(v76:GetChildren()) do
            if v78:IsA("Sound") then
                v75.LiveEventSoundTemplates[v78.Name] = v78;
                local v79 = v78:Clone();
                v79.Parent = v75.LiveEventSoundFolder;
                v75.ActiveLiveEventSounds[v79.Name] = v79;
                v75.LiveEventBaseVolumes[v79.Name] = v79.Volume;
            end;
        end;
        return;
    end;
end;
v9._muteAllNonEventSounds = function(v80) --[[ Line: 423 ]] --[[ Name: _muteAllNonEventSounds ]]
    -- upvalues: l_SoundMuteUtil_0 (copy)
    if v80.EventAudioMuted then
        return;
    else
        local v81 = {};
        for _, v83 in pairs(v80.ActiveLiveEventSounds) do
            if v83 then
                table.insert(v81, v83);
            end;
        end;
        l_SoundMuteUtil_0.MuteAllExcept(v81);
        v80.EventAudioMuted = true;
        return;
    end;
end;
v9._restoreMutedSounds = function(v84) --[[ Line: 440 ]] --[[ Name: _restoreMutedSounds ]]
    -- upvalues: l_SoundMuteUtil_0 (copy)
    if not v84.EventAudioMuted then
        return;
    else
        l_SoundMuteUtil_0.RestoreAll();
        v84.EventAudioMuted = false;
        return;
    end;
end;
v9._getLiveEventSound = function(v85, v86) --[[ Line: 449 ]] --[[ Name: _getLiveEventSound ]]
    local v87 = v85.ActiveLiveEventSounds[v86];
    if v87 and v87.Parent then
        return v87;
    else
        return nil;
    end;
end;
v9._cancelEarthquakeFade = function(v88) --[[ Line: 458 ]] --[[ Name: _cancelEarthquakeFade ]]
    if v88.EarthquakeFadeTween then
        v88.EarthquakeFadeTween:Cancel();
        v88.EarthquakeFadeTween = nil;
    end;
end;
v9._cancelOneShotFade = function(v89, v90) --[[ Line: 465 ]] --[[ Name: _cancelOneShotFade ]]
    local v91 = v89.ActiveOneShotFadeTweens[v90];
    if v91 then
        v91:Cancel();
        v89.ActiveOneShotFadeTweens[v90] = nil;
    end;
end;
v9._stopEarthquakeSound = function(v92) --[[ Line: 473 ]] --[[ Name: _stopEarthquakeSound ]]
    v92:_cancelEarthquakeFade();
    local v93 = v92:_getLiveEventSound("Earthquake");
    if not v93 then
        return;
    else
        v93:Stop();
        local l_Earthquake_0 = v92.LiveEventBaseVolumes.Earthquake;
        if typeof(l_Earthquake_0) == "number" then
            v93.Volume = l_Earthquake_0;
        end;
        return;
    end;
end;
v9._playEarthquakeForDuration = function(v95, v96) --[[ Line: 489 ]] --[[ Name: _playEarthquakeForDuration ]]
    -- upvalues: l_TweenService_0 (copy)
    local v97 = v95:_getLiveEventSound("Earthquake");
    if not v97 then
        warn("[AdminController] Missing live event sound:", "Earthquake");
        return;
    else
        v95:_cancelEarthquakeFade();
        local l_Earthquake_1 = v95.LiveEventBaseVolumes.Earthquake;
        if typeof(l_Earthquake_1) ~= "number" then
            l_Earthquake_1 = v97.Volume;
            v95.LiveEventBaseVolumes.Earthquake = l_Earthquake_1;
        end;
        v97.Volume = l_Earthquake_1;
        v97.TimePosition = 0;
        v97:Play();
        local v99 = math.clamp(math.min(v96 * 0.35, 1.5), 0.15, v96);
        local v100 = math.max(0, v96 - v99);
        task.delay(v100, function() --[[ Line: 511 ]]
            -- upvalues: v95 (copy), v97 (copy), l_TweenService_0 (ref), v99 (copy), l_Earthquake_1 (ref)
            if not v95.EventRunning then
                return;
            else
                local v101 = v95:_getLiveEventSound("Earthquake");
                if not v101 or v101 ~= v97 or not v101.IsPlaying then
                    return;
                else
                    v95:_cancelEarthquakeFade();
                    v95.EarthquakeFadeTween = l_TweenService_0:Create(v101, TweenInfo.new(v99, Enum.EasingStyle.Linear), {
                        Volume = 0
                    });
                    v95.EarthquakeFadeTween:Play();
                    v95.EarthquakeFadeTween.Completed:Once(function() --[[ Line: 526 ]]
                        -- upvalues: v101 (copy), l_Earthquake_1 (ref), v95 (ref)
                        if v101 and v101.Parent then
                            v101:Stop();
                            v101.Volume = l_Earthquake_1;
                        end;
                        if v95.EarthquakeFadeTween then
                            v95.EarthquakeFadeTween = nil;
                        end;
                    end);
                    return;
                end;
            end;
        end);
        return;
    end;
end;
v9._playTickSound = function(v102) --[[ Line: 539 ]] --[[ Name: _playTickSound ]]
    local v103 = v102:_getLiveEventSound("Tick");
    if not v103 then
        warn("[AdminController] Missing live event sound:", "Tick");
        return;
    else
        v103.TimePosition = 0;
        v103:Play();
        return;
    end;
end;
v9._playOneShotCameraSound = function(v104, v105, v106) --[[ Line: 550 ]] --[[ Name: _playOneShotCameraSound ]]
    -- upvalues: l_TweenService_0 (copy)
    local v107 = v104:_getLiveEventSound(v105);
    if not v107 then
        warn("[AdminController] Missing live event sound:", v105);
        return;
    else
        v104:_cancelOneShotFade(v105);
        local v108 = v104.LiveEventBaseVolumes[v105];
        if typeof(v108) ~= "number" then
            v108 = v107.Volume;
            v104.LiveEventBaseVolumes[v105] = v108;
        end;
        v107.Volume = v108;
        v107.TimePosition = 0;
        v107:Play();
        local v109 = math.clamp(math.min(v106 * 0.45, 0.9), 0.12, v106);
        local v110 = math.max(0, v106 - v109);
        task.delay(v110, function() --[[ Line: 572 ]]
            -- upvalues: v104 (copy), v105 (copy), v107 (copy), l_TweenService_0 (ref), v109 (copy), v108 (ref)
            if not v104.EventRunning then
                return;
            else
                local v111 = v104:_getLiveEventSound(v105);
                if not v111 or v111 ~= v107 or not v111.IsPlaying then
                    return;
                else
                    v104:_cancelOneShotFade(v105);
                    local v112 = l_TweenService_0:Create(v111, TweenInfo.new(v109, Enum.EasingStyle.Linear), {
                        Volume = 0
                    });
                    v104.ActiveOneShotFadeTweens[v105] = v112;
                    v112:Play();
                    v112.Completed:Once(function() --[[ Line: 591 ]]
                        -- upvalues: v104 (ref), v105 (ref), v112 (copy), v111 (copy), v108 (ref)
                        if v104.ActiveOneShotFadeTweens[v105] == v112 then
                            v104.ActiveOneShotFadeTweens[v105] = nil;
                        end;
                        if v111 and v111.Parent then
                            v111:Stop();
                            v111.Volume = v108;
                        end;
                    end);
                    return;
                end;
            end;
        end);
        return;
    end;
end;
v9._stopAllLiveEventSounds = function(v113) --[[ Line: 604 ]] --[[ Name: _stopAllLiveEventSounds ]]
    v113:_cancelEarthquakeFade();
    for v114, v115 in pairs(v113.ActiveOneShotFadeTweens) do
        if v115 then
            v115:Cancel();
        end;
        v113.ActiveOneShotFadeTweens[v114] = nil;
    end;
    for _, v117 in pairs(v113.ActiveLiveEventSounds) do
        if v117 and v117.Parent then
            v117:Stop();
            local v118 = v113.LiveEventBaseVolumes[v117.Name];
            if typeof(v118) == "number" then
                v117.Volume = v118;
            end;
        end;
    end;
    table.clear(v113.ActiveLiveEventSounds);
    table.clear(v113.LiveEventSoundTemplates);
    table.clear(v113.LiveEventBaseVolumes);
    table.clear(v113.ActiveOneShotFadeTweens);
    if v113.LiveEventSoundFolder then
        v113.LiveEventSoundFolder:Destroy();
        v113.LiveEventSoundFolder = nil;
    end;
end;
v9._startHoldOnCameraData = function(v119, v120, v121) --[[ Line: 636 ]] --[[ Name: _startHoldOnCameraData ]]
    -- upvalues: l_Workspace_0 (copy), l_RunService_0 (copy)
    local l_CurrentCamera_2 = l_Workspace_0.CurrentCamera;
    if not l_CurrentCamera_2 or not v119:_isValidCameraData(v120) then
        return;
    else
        local l_CurrentPhaseToken_0 = v119.CurrentPhaseToken;
        local v124 = tick() + v121;
        local l_CFrame_0 = v120.CFrame;
        v119:_disconnectRender();
        v119.RenderConnection = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 647 ]]
            -- upvalues: l_CurrentPhaseToken_0 (copy), v119 (copy), v124 (copy), l_CurrentCamera_2 (copy), l_CFrame_0 (copy)
            if l_CurrentPhaseToken_0 ~= v119.CurrentPhaseToken then
                v119:_disconnectRender();
                return;
            elseif tick() >= v124 then
                v119:_disconnectRender();
                return;
            else
                v119:_applyCameraCFrame(l_CurrentCamera_2, l_CFrame_0);
                return;
            end;
        end);
        return;
    end;
end;
v9._startShakeOnCameraData = function(v126, v127, v128) --[[ Line: 662 ]] --[[ Name: _startShakeOnCameraData ]]
    -- upvalues: l_Workspace_0 (copy), l_RunService_0 (copy)
    local l_CurrentCamera_3 = l_Workspace_0.CurrentCamera;
    if not l_CurrentCamera_3 or not v126:_isValidCameraData(v127) then
        return;
    else
        local l_CurrentPhaseToken_1 = v126.CurrentPhaseToken;
        local v131 = tick();
        local l_CFrame_1 = v127.CFrame;
        v126:_disconnectRender();
        v126.RenderConnection = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 673 ]]
            -- upvalues: l_CurrentPhaseToken_1 (copy), v126 (copy), v131 (copy), v128 (copy), l_CurrentCamera_3 (copy), l_CFrame_1 (copy)
            if l_CurrentPhaseToken_1 ~= v126.CurrentPhaseToken then
                v126:_disconnectRender();
                return;
            else
                local v133 = tick() - v131;
                local v134 = v128 > 0 and v133 / v128 or 1;
                if v134 >= 1 then
                    v126:_applyCameraCFrame(l_CurrentCamera_3, l_CFrame_1);
                    v126:_disconnectRender();
                    return;
                else
                    local v135 = l_CFrame_1 * v126:_getShakeOffset(v134);
                    v126:_applyCameraCFrame(l_CurrentCamera_3, v135);
                    return;
                end;
            end;
        end);
        return;
    end;
end;
v9._startPanBetweenCameraData = function(v136, v137, v138, v139) --[[ Line: 692 ]] --[[ Name: _startPanBetweenCameraData ]]
    -- upvalues: l_Workspace_0 (copy), l_RunService_0 (copy)
    local l_CurrentCamera_4 = l_Workspace_0.CurrentCamera;
    if not l_CurrentCamera_4 or not v136:_isValidCameraData(v137) or not v136:_isValidCameraData(v138) then
        return;
    else
        local l_CurrentPhaseToken_2 = v136.CurrentPhaseToken;
        local v142 = tick();
        local l_CFrame_2 = v137.CFrame;
        local l_CFrame_3 = v138.CFrame;
        v136:_disconnectRender();
        v136.RenderConnection = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 704 ]]
            -- upvalues: l_CurrentPhaseToken_2 (copy), v136 (copy), v142 (copy), v139 (copy), l_CurrentCamera_4 (copy), l_CFrame_3 (copy), l_CFrame_2 (copy)
            if l_CurrentPhaseToken_2 ~= v136.CurrentPhaseToken then
                v136:_disconnectRender();
                return;
            else
                local v145 = tick() - v142;
                local v146 = v139 > 0 and v145 / v139 or 1;
                if v146 >= 1 then
                    v136:_applyCameraCFrame(l_CurrentCamera_4, l_CFrame_3);
                    v136:_disconnectRender();
                    return;
                else
                    local v147 = v136:_easeInOutSine(v146);
                    local v148 = l_CFrame_2:Lerp(l_CFrame_3, v147);
                    v136:_applyCameraCFrame(l_CurrentCamera_4, v148);
                    return;
                end;
            end;
        end);
        return;
    end;
end;
v9._runEndCameraSequence = function(v149, v150) --[[ Line: 724 ]] --[[ Name: _runEndCameraSequence ]]
    -- upvalues: l_Workspace_0 (copy), v14 (copy), l_RunService_0 (copy)
    local l_CurrentCamera_5 = l_Workspace_0.CurrentCamera;
    if not l_CurrentCamera_5 then
        v149:_finalizeLiveEvent();
        return;
    else
        local l_EndCameraData_0 = v149.EndCameraData;
        if typeof(l_EndCameraData_0) ~= "table" or #l_EndCameraData_0 == 0 then
            v149:_finalizeLiveEventWithTransition(v150);
            return;
        else
            local v153 = tonumber(v149.EndCameraHoldDuration) or 2;
            for _, v155 in ipairs(l_EndCameraData_0) do
                if v150 ~= v149.ActiveEventId then
                    return;
                elseif v149:_isValidCameraData(v155) then
                    v149:_playTickSound();
                    v149:_playTransition(function() --[[ Line: 747 ]]
                        -- upvalues: v150 (copy), v149 (copy), l_CurrentCamera_5 (copy), v155 (copy), v14 (ref), v153 (copy)
                        if v150 ~= v149.ActiveEventId then
                            return;
                        else
                            v149:_applyCameraCFrame(l_CurrentCamera_5, v155.CFrame);
                            local v156 = typeof(v155.Name) == "string" and v155.Name or nil;
                            local v157 = v156 and v14[v156] or nil;
                            if v157 then
                                v149:_playOneShotCameraSound(v157, v153);
                            end;
                            return;
                        end;
                    end);
                    if v150 ~= v149.ActiveEventId then
                        return;
                    else
                        local v158 = tick() + v153;
                        while tick() < v158 do
                            if v150 ~= v149.ActiveEventId then
                                return;
                            else
                                v149:_applyCameraCFrame(l_CurrentCamera_5, v155.CFrame);
                                l_RunService_0.RenderStepped:Wait();
                            end;
                        end;
                    end;
                end;
            end;
            if v150 ~= v149.ActiveEventId then
                return;
            else
                v149:_finalizeLiveEventWithTransition(v150);
                return;
            end;
        end;
    end;
end;
v9._onEventStarted = function(v159, v160) --[[ Line: 784 ]] --[[ Name: _onEventStarted ]]
    -- upvalues: l_Workspace_0 (copy)
    if typeof(v160) ~= "table" then
        warn("[AdminController] Invalid EventStarted payload");
        return;
    else
        v159.ActiveEventId = v159.ActiveEventId + 1;
        v159:_disconnectRender();
        v159:_resetState();
        v159.EventRunning = true;
        v159.Cam1Name = typeof(v160.Cam1Name) == "string" and v160.Cam1Name or "Cam1";
        v159.Cam2Name = typeof(v160.Cam2Name) == "string" and v160.Cam2Name or "Cam2";
        v159.StartCameraData = v159:_isValidCameraData(v160.StartCameraData) and v160.StartCameraData or nil;
        v159.Cam2Data = v159:_isValidCameraData(v160.Cam2Data) and v160.Cam2Data or nil;
        v159.EndCameraData = typeof(v160.EndCameraData) == "table" and v160.EndCameraData or {};
        v159.ShakeIntensity = tonumber(v160.ShakeIntensity) or 8;
        v159.EndCameraHoldDuration = tonumber(v160.EndCameraHold) or 2;
        local l_CurrentCamera_6 = l_Workspace_0.CurrentCamera;
        if l_CurrentCamera_6 then
            v159.PreviousCameraType = l_CurrentCamera_6.CameraType;
            v159.PreviousCameraSubject = l_CurrentCamera_6.CameraSubject;
        end;
        v159:_setupLiveEventSounds();
        v159:_muteAllNonEventSounds();
        v159:_disableAllScreenGuis();
        v159:_forceClockTime();
        if v159.StartCameraData then
            v159:_applyCameraCFrame(l_CurrentCamera_6, v159.StartCameraData.CFrame);
            return;
        else
            v159:_snapCameraToNamedPart(v159.Cam1Name);
            return;
        end;
    end;
end;
v9._onPhaseChanged = function(v162, v163, v164) --[[ Line: 824 ]] --[[ Name: _onPhaseChanged ]]
    if not v162.EventRunning then
        return;
    else
        v164 = v164 or {};
        v162.CurrentPhase = v163;
        v162.CurrentPhaseToken = v162.CurrentPhaseToken + 1;
        if v163 == "AreaRiseDelay" then
            v162:_startHoldOnCameraData(v162:_isValidCameraData(v164.CameraData) and v164.CameraData or v162.StartCameraData, tonumber(v164.Duration) or 2);
            return;
        elseif v163 == "AreaRise" then
            local v165 = tonumber(v164.Duration) or 8;
            v162.ShakeIntensity = tonumber(v164.ShakeIntensity) or v162.ShakeIntensity;
            v162:_playEarthquakeForDuration(v165);
            v162:_startShakeOnCameraData(v162:_isValidCameraData(v164.CameraData) and v164.CameraData or v162.StartCameraData, v165);
            return;
        elseif v163 == "AreaPostRiseHold" then
            v162:_stopEarthquakeSound();
            v162:_startHoldOnCameraData(v162:_isValidCameraData(v164.CameraData) and v164.CameraData or v162.StartCameraData, tonumber(v164.Duration) or 2);
            return;
        elseif v163 == "PanToCam2" then
            v162:_stopEarthquakeSound();
            v162:_startPanBetweenCameraData(v162:_isValidCameraData(v164.FromCameraData) and v164.FromCameraData or v162.StartCameraData, v162:_isValidCameraData(v164.ToCameraData) and v164.ToCameraData or v162.Cam2Data, tonumber(v164.Duration) or 4);
            return;
        elseif v163 == "ShardsRise" then
            local v166 = tonumber(v164.Duration) or 8;
            v162.ShakeIntensity = tonumber(v164.ShakeIntensity) or v162.ShakeIntensity;
            v162:_playEarthquakeForDuration(v166);
            v162:_startShakeOnCameraData(v162:_isValidCameraData(v164.CameraData) and v164.CameraData or v162.Cam2Data, v166);
            return;
        elseif v163 == "ShardsPostRiseHold" then
            v162:_stopEarthquakeSound();
            v162:_startHoldOnCameraData(v162:_isValidCameraData(v164.CameraData) and v164.CameraData or v162.Cam2Data, tonumber(v164.Duration) or 2);
            return;
        elseif v163 == "Area2Rise" then
            local v167 = tonumber(v164.Duration) or 8;
            v162.ShakeIntensity = tonumber(v164.ShakeIntensity) or v162.ShakeIntensity;
            v162:_playEarthquakeForDuration(v167);
            v162:_startShakeOnCameraData(v162:_isValidCameraData(v164.CameraData) and v164.CameraData or v162.Cam2Data, v167);
            return;
        elseif v163 == "Area2PostRiseHold" then
            v162:_stopEarthquakeSound();
            v162:_startHoldOnCameraData(v162:_isValidCameraData(v164.CameraData) and v164.CameraData or v162.Cam2Data, tonumber(v164.Duration) or 2);
            return;
        elseif v163 == "EndCameraSequence" then
            v162:_stopEarthquakeSound();
            v162.EndCameraHoldDuration = tonumber(v164.HoldDuration) or v162.EndCameraHoldDuration or 2;
            if typeof(v164.Cameras) == "table" then
                v162.EndCameraData = v164.Cameras;
            end;
            v162:_disconnectRender();
            task.spawn(function() --[[ Line: 915 ]]
                -- upvalues: v162 (copy)
                v162:_runEndCameraSequence(v162.ActiveEventId);
            end);
            return;
        else
            return;
        end;
    end;
end;
v9._onEventEnded = function(v168) --[[ Line: 922 ]] --[[ Name: _onEventEnded ]]
    if not v168.EventRunning then
        return;
    else
        v168.EventRunning = false;
        v168:_disconnectRender();
        v168:_stopEarthquakeSound();
        return;
    end;
end;
return v9;