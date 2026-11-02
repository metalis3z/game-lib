-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local _ = UserSettings():GetService("UserGameSettings");
local l_Knit_0 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"));
local v6 = require(l_ReplicatedStorage_0:WaitForChild("Math Utility"));
local v7 = require(l_ReplicatedStorage_0.Frameworks.Notifications);
local v8 = require(l_ReplicatedStorage_0.Signals);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v10 = l_Knit_0.CreateController({
    Name = "TrainingAreasController"
});
local v11 = {
    ["Fire Bath"] = Color3.fromRGB(255, 140, 0), 
    ["Dark Lava"] = Color3.fromRGB(255, 26, 30), 
    ["Ancient Ruins"] = Color3.fromRGB(100, 255, 100), 
    ["Electra Field"] = Color3.fromRGB(100, 100, 255), 
    ["Divine Realm"] = Color3.fromRGB(255, 255, 127), 
    ["Frost Heaven"] = Color3.fromRGB(0, 255, 255), 
    ["Fallen Star"] = Color3.fromRGB(20, 20, 20)
};
v10.KnitInit = function(v12) --[[ Line: 29 ]] --[[ Name: KnitInit ]]
    v12.TrainingAreasData = {};
    v12.SortedNextAreaNames = {};
    v12.CurrentKOTHUserId = nil;
    v12.CurrentKOTHName = nil;
    v12.CurrentKOTHClaimStartedAt = 0;
    v12.CurrentKOTHClaimed = false;
    v12.ActiveShakeIntensity = 0;
    v12.ActiveShakeEndTime = 0;
    v12.ActiveShakeDuration = 0;
    v12.ShakeStartTime = 0;
    v12.ActiveShakeOrigin = nil;
end;
v10.KnitStart = function(v13) --[[ Line: 45 ]] --[[ Name: KnitStart ]]
    v13:_grabRefs();
    v13:_setupTweens();
    v13:_setKOTHIdleState();
    v13:_bindSignals();
    v13:_startKOTHTimerLoop();
    v13:_startCameraShakeLoop();
    v13:_startLavaAnimation();
    v13:_initNextAreaUI();
end;
v10._grabRefs = function(v14) --[[ Line: 56 ]] --[[ Name: _grabRefs ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    v14.PlayerGui = l_LocalPlayer_0:WaitForChild("PlayerGui");
    v14.Hud = v14.PlayerGui:WaitForChild("Hud");
    v14.TrainingAreas = workspace:WaitForChild("Training Areas");
    v14.KOTHFolder = workspace:WaitForChild("KOTH");
    local l_MainFrame_0 = v14.KOTHFolder:WaitForChild("Crown"):WaitForChild("X"):WaitForChild("Attachment"):WaitForChild("KOTHBillboard"):WaitForChild("MainFrame");
    v14.ClaimLabel = l_MainFrame_0:WaitForChild("ClaimLabel");
    v14.PlayerAvatar = l_MainFrame_0:WaitForChild("PlayerAvatar");
    v14.KOTHTimer = v14.PlayerAvatar:WaitForChild("KOTHTimer");
    v14.PlayerName = v14.PlayerAvatar:WaitForChild("PlayerName");
    v14.AreaNotification = v14.Hud:WaitForChild("AreaNotification");
    v14.NextAreaCanvas = v14.Hud:WaitForChild("NextArea");
    v14.NextAreaText = v14.NextAreaCanvas:WaitForChild("AreaBoost");
end;
v10._setupTweens = function(v16) --[[ Line: 79 ]] --[[ Name: _setupTweens ]]
    -- upvalues: l_TweenService_0 (copy)
    v16.VisiblePosition = UDim2.new(0.5, 0, 0.1, 0);
    v16.HiddenPosition = UDim2.new(0.5, 0, -0.2, 0);
    v16.Dropdown = l_TweenService_0:Create(v16.AreaNotification, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = v16.VisiblePosition
    });
    v16.HideTween = l_TweenService_0:Create(v16.AreaNotification, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = v16.HiddenPosition
    });
    v16.NextAreaShow = l_TweenService_0:Create(v16.NextAreaCanvas, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    });
    v16.NextAreaHide = l_TweenService_0:Create(v16.NextAreaCanvas, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        GroupTransparency = 1
    });
    v16.NextAreaCanvas.Rotation = -1.7;
    l_TweenService_0:Create(v16.NextAreaCanvas, TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        Rotation = 1.7
    }):Play();
end;
v10._bindSignals = function(v17) --[[ Line: 117 ]] --[[ Name: _bindSignals ]]
    -- upvalues: l_Knit_0 (copy), v7 (copy), l_LocalPlayer_0 (copy), v8 (copy)
    local v18 = l_Knit_0.GetService("TrainingAreasService");
    if v18.TrainingAreasData then
        v18.TrainingAreasData:Connect(function(v19) --[[ Line: 121 ]]
            -- upvalues: v17 (copy)
            v17.TrainingAreasData = v19 or {};
            v17:_rebuildNextAreaOrder();
            v17:_updateNextAreaObjective();
        end);
    end;
    if v18.AreaStatusChanged then
        v18.AreaStatusChanged:Connect(function(v20, v21) --[[ Line: 129 ]]
            -- upvalues: v17 (copy)
            v17:_onAreaStatusChanged(v20, v21);
        end);
    end;
    if v18.KOTHStateChanged then
        v18.KOTHStateChanged:Connect(function(v22) --[[ Line: 135 ]]
            -- upvalues: v17 (copy)
            if v22.IsClaimed and v22.KingUserId and v22.KingName then
                v17:_setKOTHClaimedState(v22.KingUserId, v22.KingName, v22.ClaimStartedAt or os.time());
                return;
            else
                v17:_setKOTHIdleState();
                return;
            end;
        end);
    end;
    if v18.KOTHNotification then
        v18.KOTHNotification:Connect(function(v23, v24) --[[ Line: 145 ]]
            -- upvalues: v7 (ref)
            v7.New(v23 or "KOTH UPDATE", v24 or "SuccessNotification");
        end);
    end;
    if v18.CursedZoneNotification then
        v18.CursedZoneNotification:Connect(function(v25, v26) --[[ Line: 151 ]]
            -- upvalues: v7 (ref)
            v7.New(v25 or "CURSED ZONE HAS SPAWNED", v26 or "SuccessNotification");
        end);
    end;
    if v18.CursedZoneShake then
        v18.CursedZoneShake:Connect(function(v27, v28) --[[ Line: 157 ]]
            -- upvalues: v17 (copy)
            v17:_startCursedZoneShake(v27, v28 or 3);
        end);
    end;
    l_LocalPlayer_0:GetAttributeChangedSignal("Aura"):Connect(function() --[[ Line: 162 ]]
        -- upvalues: v17 (copy)
        v17:_updateNextAreaObjective();
    end);
    v8.RebirthNotificationGotten:Connect(function(v29) --[[ Line: 166 ]]
        -- upvalues: v17 (copy)
        if v29 then
            v17.NextAreaHide:Play();
            return;
        else
            v17.NextAreaShow:Play();
            return;
        end;
    end);
end;
v10._setKOTHIdleState = function(v30) --[[ Line: 175 ]] --[[ Name: _setKOTHIdleState ]]
    v30.CurrentKOTHUserId = nil;
    v30.CurrentKOTHName = nil;
    v30.CurrentKOTHClaimStartedAt = 0;
    v30.CurrentKOTHClaimed = false;
    v30.ClaimLabel.Visible = true;
    v30.ClaimLabel.Text = "Claim";
    v30.PlayerAvatar.Visible = false;
    v30.PlayerAvatar.Image = "";
    v30.PlayerName.Visible = false;
    v30.PlayerName.Text = "";
    v30.KOTHTimer.Visible = false;
    v30.KOTHTimer.Text = "";
end;
v10._setKOTHClaimedState = function(v31, v32, v33, v34) --[[ Line: 194 ]] --[[ Name: _setKOTHClaimedState ]]
    v31.CurrentKOTHUserId = v32;
    v31.CurrentKOTHName = v33;
    v31.CurrentKOTHClaimStartedAt = v34;
    v31.CurrentKOTHClaimed = true;
    v31.ClaimLabel.Visible = false;
    v31.PlayerAvatar.Visible = true;
    v31.PlayerAvatar.Image = ("rbxthumb://type=AvatarHeadShot&id=%d&w=420&h=420"):format(v32);
    v31.PlayerName.Visible = true;
    v31.PlayerName.Text = v33;
    v31.KOTHTimer.Visible = true;
end;
v10._startKOTHTimerLoop = function(v35) --[[ Line: 211 ]] --[[ Name: _startKOTHTimerLoop ]]
    -- upvalues: v6 (copy)
    task.spawn(function() --[[ Line: 212 ]]
        -- upvalues: v35 (copy), v6 (ref)
        while true do
            if v35.CurrentKOTHClaimed and v35.CurrentKOTHClaimStartedAt > 0 then
                local v36 = math.max(0, os.time() - v35.CurrentKOTHClaimStartedAt);
                v35.KOTHTimer.Text = v6.FormatSecondsIntoCleanTime(v36);
            end;
            task.wait(1);
        end;
    end);
end;
v10._startCursedZoneShake = function(v37, v38, v39) --[[ Line: 224 ]] --[[ Name: _startCursedZoneShake ]]
    v37.ActiveShakeIntensity = 3.2;
    v37.ActiveShakeDuration = v39;
    v37.ShakeStartTime = os.clock();
    v37.ActiveShakeEndTime = v37.ShakeStartTime + v39;
    v37.ActiveShakeOrigin = v38;
end;
v10._startCameraShakeLoop = function(v40) --[[ Line: 232 ]] --[[ Name: _startCameraShakeLoop ]]
    -- upvalues: l_RunService_0 (copy)
    l_RunService_0:BindToRenderStep("CursedZoneSpawnShake", Enum.RenderPriority.Camera.Value + 50, function() --[[ Line: 233 ]]
        -- upvalues: v40 (copy)
        if v40.ActiveShakeIntensity <= 0 then
            return;
        else
            local l_CurrentCamera_0 = workspace.CurrentCamera;
            if not l_CurrentCamera_0 then
                return;
            else
                local v42 = os.clock();
                if v40.ActiveShakeEndTime <= v42 then
                    v40.ActiveShakeIntensity = 0;
                    v40.ActiveShakeDuration = 0;
                    v40.ShakeStartTime = 0;
                    v40.ActiveShakeOrigin = nil;
                    return;
                else
                    local v43 = v42 - v40.ShakeStartTime;
                    local v44 = v40.ActiveShakeEndTime - v42;
                    local v45 = math.clamp(v43 / 0.05, 0, 1) * math.clamp(v44 / math.max(v40.ActiveShakeDuration, 0.001), 0, 1);
                    local v46 = v40.ActiveShakeIntensity * v45;
                    local v47 = math.sin(v42 * 52) * 0.65 * v46;
                    local v48 = math.cos(v42 * 47) * 0.55 * v46;
                    local v49 = math.sin(v42 * 41) * 0.18 * v46;
                    local v50 = math.rad(math.sin(v42 * 39) * 4.5 * v46);
                    local v51 = math.rad(math.cos(v42 * 35) * 3.2 * v46);
                    local v52 = math.rad(math.sin(v42 * 44) * 5 * v46);
                    l_CurrentCamera_0.CFrame = l_CurrentCamera_0.CFrame * CFrame.new(v47, v48, v49) * CFrame.Angles(v50, v51, v52);
                    return;
                end;
            end;
        end;
    end);
end;
v10._getZoneColorString = function(_, v54) --[[ Line: 276 ]] --[[ Name: _getZoneColorString ]]
    -- upvalues: v11 (copy)
    local v55 = v11[v54] or Color3.fromRGB(255, 255, 0);
    return string.format("rgb(%d, %d, %d)", math.floor(v55.R * 255), math.floor(v55.G * 255), (math.floor(v55.B * 255)));
end;
v10._rebuildNextAreaOrder = function(v56) --[[ Line: 287 ]] --[[ Name: _rebuildNextAreaOrder ]]
    local v57 = {};
    for v58, v59 in pairs(v56.TrainingAreasData) do
        if type(v59) == "table" and type(v59.Requirement) == "number" then
            table.insert(v57, v58);
        end;
    end;
    table.sort(v57, function(v60, v61) --[[ Line: 296 ]]
        -- upvalues: v56 (copy)
        return v56.TrainingAreasData[v60].Requirement < v56.TrainingAreasData[v61].Requirement;
    end);
    v56.SortedNextAreaNames = v57;
end;
v10._updateNextAreaObjective = function(v62) --[[ Line: 303 ]] --[[ Name: _updateNextAreaObjective ]]
    -- upvalues: l_LocalPlayer_0 (copy), v6 (copy)
    if not v62.TrainingAreasData or next(v62.TrainingAreasData) == nil then
        return;
    else
        if not v62.SortedNextAreaNames or #v62.SortedNextAreaNames == 0 then
            v62:_rebuildNextAreaOrder();
        end;
        local v63 = l_LocalPlayer_0:GetAttribute("Aura") or 0;
        for _, v65 in ipairs(v62.SortedNextAreaNames) do
            local v66 = v62.TrainingAreasData[v65];
            local v67 = v66 and v66.Requirement;
            if type(v67) == "number" and v63 < v67 then
                v62.NextAreaText.Text = string.format("<font face=\"Montserrat\" weight=\"900\">~ <font color=\"%s\">%s</font> - <font color=\"rgb(0,255,255)\">%s</font> <font color=\"rgb(190,0,255)\">Aura</font> <font color=\"rgb(255,255,255)\">Required</font> ~</font>", v62:_getZoneColorString(v65), v65, v6.FormatNumberNoDecimals(v67));
                return;
            end;
        end;
        v62.NextAreaText.Text = "<font color=\"rgb(255, 230, 60)\"><b>ALL ZONES UNLOCKED</b></font>";
        return;
    end;
end;
v10._formatNumber = function(_, v69) --[[ Line: 332 ]] --[[ Name: _formatNumber ]]
    local v70, v71, v72 = string.match(v69, "^([^%d]*%d)(%d*)(.-)$");
    return v70 .. v71:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v72;
end;
v10._onAreaStatusChanged = function(v73, v74, v75) --[[ Line: 337 ]] --[[ Name: _onAreaStatusChanged ]]
    if not v74 or not v75 then
        v73.HideTween:Play();
        v73.NextAreaShow:Play();
        return;
    else
        local l_Haptics_0 = workspace:FindFirstChild("Haptics");
        if l_Haptics_0 and l_Haptics_0:FindFirstChild("ZoneEntered") then
            l_Haptics_0.ZoneEntered:Play();
        end;
        local v77 = v73:_getZoneColorString(v74);
        local v78 = v73:_formatNumber((tostring(v75)));
        v73.AreaNotification.MainText.Text = string.format("<font color=\"%s\"><b>%s</b></font><font color=\"rgb(255, 255, 255)\"> - </font><font color=\"rgb(180, 180, 180)\"><b>%s</b></font><font color=\"rgb(180, 180, 180)\">x</font> <font color=\"rgb(190, 0, 255)\"><b>Aura Boost</b></font>", v77, v74, v78);
        v73.Dropdown:Play();
        v73.NextAreaHide:Play();
        task.delay(2, function() --[[ Line: 362 ]]
            -- upvalues: v73 (copy)
            v73.HideTween:Play();
            v73.NextAreaShow:Play();
        end);
        return;
    end;
end;
v10._initNextAreaUI = function(v79) --[[ Line: 368 ]] --[[ Name: _initNextAreaUI ]]
    task.spawn(function() --[[ Line: 369 ]]
        -- upvalues: v79 (copy)
        local v80 = os.clock() + 10;
        while os.clock() < v80 and next(v79.TrainingAreasData) == nil do
            task.wait(0.1);
        end;
        v79:_rebuildNextAreaOrder();
        v79:_updateNextAreaObjective();
    end);
end;
v10._startLavaAnimation = function(v81) --[[ Line: 380 ]] --[[ Name: _startLavaAnimation ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_RunService_0 (copy)
    task.spawn(function() --[[ Line: 381 ]]
        -- upvalues: v81 (copy), l_LocalPlayer_0 (ref), l_RunService_0 (ref)
        v81.TrainingAreas:WaitForChild("Fire Bath"):WaitForChild("FirePart");
        task.wait(3);
        local v82 = v81.TrainingAreas:WaitForChild("Dark Lava");
        local l_LavaPart2_0 = v82:WaitForChild("LavaPart2");
        local l_LavaPart1_0 = v82:WaitForChild("LavaPart1");
        local l_sin_0 = math.sin;
        local l_cos_0 = math.cos;
        local l_random_0 = math.random;
        local v88 = (l_LavaPart1_0.Position + l_LavaPart2_0.Position) * 0.5;
        local v89 = {};
        local v90 = {};
        local v91 = {};
        local v92 = {};
        local v93 = {};
        local v94 = {};
        local v95 = {};
        local v96 = {};
        local v97 = {};
        local v98 = {};
        local v99 = 0;
        local v100 = 0;
        local v101 = 0;
        local v102 = true;
        local v103 = false;
        local function v109(v104, v105, v106, v107) --[[ Line: 423 ]] --[[ Name: addTexture ]]
            -- upvalues: v99 (ref), l_random_0 (copy), v89 (copy), v90 (copy), v91 (copy), v92 (copy), v93 (copy), v94 (copy), v95 (copy), v96 (copy), v97 (copy), v98 (copy)
            v99 = v99 + 1;
            local v108 = l_random_0() * 9999;
            v89[v99] = v104;
            v90[v99] = v108;
            v91[v99] = v108 * 1.37;
            v92[v99] = (0.8 + l_random_0() * 0.4) * v105;
            v93[v99] = (0.8 + l_random_0() * 0.4) * v106;
            v94[v99] = v107;
            v95[v99] = v107 * 1.25;
            v96[v99] = v107 * 1.1;
            v97[v99] = v104.OffsetStudsU;
            v98[v99] = v104.OffsetStudsV;
        end;
        local function v117(v110, v111, v112, v113, v114) --[[ Line: 439 ]] --[[ Name: tryInitFromChildren ]]
            -- upvalues: v109 (copy), v100 (ref), v101 (ref)
            for _, v116 in ipairs(v110:GetChildren()) do
                if v116:IsA("Texture") then
                    v109(v116, v111, v112, v113);
                    if v114 == "part1" then
                        v100 = v100 + 1;
                    else
                        v101 = v101 + 1;
                    end;
                end;
            end;
        end;
        local function _() --[[ Line: 452 ]] --[[ Name: getCharacterPosition ]]
            -- upvalues: l_LocalPlayer_0 (ref)
            local l_Character_0 = l_LocalPlayer_0.Character;
            if not l_Character_0 then
                return nil;
            else
                local l_HumanoidRootPart_0 = l_Character_0:FindFirstChild("HumanoidRootPart");
                if l_HumanoidRootPart_0 and l_HumanoidRootPart_0:IsA("BasePart") then
                    return l_HumanoidRootPart_0.Position;
                else
                    local l_PrimaryPart_0 = l_Character_0.PrimaryPart;
                    if l_PrimaryPart_0 then
                        return l_PrimaryPart_0.Position;
                    else
                        local l_BasePart_0 = l_Character_0:FindFirstChildWhichIsA("BasePart");
                        return l_BasePart_0 and l_BasePart_0.Position or nil;
                    end;
                end;
            end;
        end;
        local function _() --[[ Line: 472 ]] --[[ Name: updateAnimateFlag ]]
            -- upvalues: l_LocalPlayer_0 (ref), v88 (copy), v102 (ref)
            local l_Character_1 = l_LocalPlayer_0.Character;
            local v124;
            if not l_Character_1 then
                v124 = nil;
            else
                local l_HumanoidRootPart_1 = l_Character_1:FindFirstChild("HumanoidRootPart");
                if l_HumanoidRootPart_1 and l_HumanoidRootPart_1:IsA("BasePart") then
                    v124 = l_HumanoidRootPart_1.Position;
                else
                    local l_PrimaryPart_1 = l_Character_1.PrimaryPart;
                    if l_PrimaryPart_1 then
                        v124 = l_PrimaryPart_1.Position;
                    else
                        local l_BasePart_1 = l_Character_1:FindFirstChildWhichIsA("BasePart");
                        v124 = l_BasePart_1 and l_BasePart_1.Position or nil;
                    end;
                end;
            end;
            if not v124 then
                return;
            else
                l_Character_1 = v124 - v88;
                local v128 = l_Character_1.X * l_Character_1.X + l_Character_1.Y * l_Character_1.Y + l_Character_1.Z * l_Character_1.Z;
                if v102 then
                    if v128 > 7225 then
                        v102 = false;
                        return;
                    end;
                elseif v128 < 2500 then
                    v102 = true;
                end;
                return;
            end;
        end;
        v117(l_LavaPart2_0, 1, 1, 0.2, "part2");
        v117(l_LavaPart1_0, -1, 0.8, 0.35, "part1");
        local v130 = nil;
        local v131 = nil;
        local function v149() --[[ Line: 498 ]] --[[ Name: startIfReady ]]
            -- upvalues: v103 (ref), v100 (ref), v101 (ref), v130 (ref), v131 (ref), l_LocalPlayer_0 (ref), v88 (copy), v102 (ref), l_RunService_0 (ref), v99 (ref), v95 (copy), v90 (copy), l_sin_0 (copy), v96 (copy), v91 (copy), l_cos_0 (copy), v92 (copy), v94 (copy), v93 (copy), v97 (copy), v98 (copy), v89 (copy)
            if v103 then
                return;
            elseif v100 < 6 or v101 < 6 then
                return;
            else
                v103 = true;
                if v130 then
                    v130:Disconnect();
                end;
                if v131 then
                    v131:Disconnect();
                end;
                task.spawn(function() --[[ Line: 512 ]]
                    -- upvalues: l_LocalPlayer_0 (ref), v88 (ref), v102 (ref)
                    while true do
                        local l_Character_2 = l_LocalPlayer_0.Character;
                        local v133;
                        if not l_Character_2 then
                            v133 = nil;
                        else
                            local l_HumanoidRootPart_2 = l_Character_2:FindFirstChild("HumanoidRootPart");
                            if l_HumanoidRootPart_2 and l_HumanoidRootPart_2:IsA("BasePart") then
                                v133 = l_HumanoidRootPart_2.Position;
                            else
                                local l_PrimaryPart_2 = l_Character_2.PrimaryPart;
                                if l_PrimaryPart_2 then
                                    v133 = l_PrimaryPart_2.Position;
                                else
                                    local l_BasePart_2 = l_Character_2:FindFirstChildWhichIsA("BasePart");
                                    v133 = l_BasePart_2 and l_BasePart_2.Position or nil;
                                end;
                            end;
                        end;
                        if v133 then
                            l_Character_2 = v133 - v88;
                            local v137 = l_Character_2.X * l_Character_2.X + l_Character_2.Y * l_Character_2.Y + l_Character_2.Z * l_Character_2.Z;
                            if v102 then
                                if v137 > 7225 then
                                    v102 = false;
                                end;
                            elseif v137 < 2500 then
                                v102 = true;
                            end;
                        end;
                        task.wait(1);
                    end;
                end);
                local v138 = 0;
                local v139 = 0;
                l_RunService_0.RenderStepped:Connect(function(v140) --[[ Line: 522 ]]
                    -- upvalues: v102 (ref), v138 (ref), v139 (ref), v99 (ref), v95 (ref), v90 (ref), l_sin_0 (ref), v96 (ref), v91 (ref), l_cos_0 (ref), v92 (ref), v94 (ref), v93 (ref), v97 (ref), v98 (ref), v89 (ref)
                    if not v102 then
                        return;
                    else
                        v138 = v138 + v140;
                        if v138 < 0.03333333333333333 then
                            return;
                        else
                            while v138 >= 0.03333333333333333 do
                                v138 = v138 - 0.03333333333333333;
                                v139 = v139 + 0.03333333333333333;
                            end;
                            for v141 = 1, v99 do
                                local v142 = l_sin_0(v139 * v95[v141] + v90[v141]);
                                local v143 = l_cos_0(v139 * v96[v141] + v91[v141]);
                                local v144 = 0.35 * v92[v141] + v142 * v94[v141];
                                local v145 = 0.16 * v93[v141] + v143 * v94[v141];
                                local v146 = v97[v141] + v144 * 0.03333333333333333;
                                local v147 = v98[v141] + v145 * 0.03333333333333333;
                                if v146 >= 1000 then
                                    v146 = v146 - 1000;
                                elseif v146 < 0 then
                                    v146 = v146 + 1000;
                                end;
                                if v147 >= 1000 then
                                    v147 = v147 - 1000;
                                elseif v147 < 0 then
                                    v147 = v147 + 1000;
                                end;
                                v97[v141] = v146;
                                v98[v141] = v147;
                                local v148 = v89[v141];
                                v148.OffsetStudsU = v146;
                                v148.OffsetStudsV = v147;
                            end;
                            return;
                        end;
                    end;
                end);
                return;
            end;
        end;
        if v100 < 6 then
            v130 = l_LavaPart1_0.ChildAdded:Connect(function(v150) --[[ Line: 570 ]]
                -- upvalues: v109 (copy), v100 (ref), v149 (copy)
                if v150:IsA("Texture") then
                    v109(v150, -1, 0.8, 0.35);
                    v100 = v100 + 1;
                    v149();
                end;
            end);
        end;
        if v101 < 6 then
            v131 = l_LavaPart2_0.ChildAdded:Connect(function(v151) --[[ Line: 580 ]]
                -- upvalues: v109 (copy), v101 (ref), v149 (copy)
                if v151:IsA("Texture") then
                    v109(v151, 1, 1, 0.2);
                    v101 = v101 + 1;
                    v149();
                end;
            end);
        end;
        v149();
    end);
end;
return v10;