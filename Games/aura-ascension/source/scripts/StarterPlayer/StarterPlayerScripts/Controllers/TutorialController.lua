-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local l_Knit_0 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"));
local l_Signals_0 = require(l_ReplicatedStorage_0:WaitForChild("Signals"));
local l_Notifications_0 = require(l_ReplicatedStorage_0.Frameworks:WaitForChild("Notifications"));
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v8 = l_Knit_0.CreateController({
    Name = "TutorialController"
});
v8.KnitInit = function(v9) --[[ Line: 34 ]] --[[ Name: KnitInit ]]
    v9.PlayerService = nil;
    v9.TrainingAreasService = nil;
    v9.TrainingAreaReqOrdered = {};
    v9.SeenAreaUnlockNotifications = {};
    v9.AreaUnlockNotifierStarted = false;
    v9.AreaUnlockNotifierConnection = nil;
    v9.TutorialGui = nil;
    v9.Canvas = nil;
    v9.Arrow = nil;
    v9.BeamTemplate = nil;
    v9.ChestAttachment = nil;
    v9.RebirthPadAttachment = nil;
    v9.TrainingAreasFolder = nil;
    v9.RebirthCostInAura = 1000;
    v9.chestStageRunning = false;
end;
v8.KnitStart = function(v10) --[[ Line: 55 ]] --[[ Name: KnitStart ]]
    -- upvalues: l_Knit_0 (copy)
    v10.PlayerService = l_Knit_0.GetService("PlayerService");
    v10.TrainingAreasService = l_Knit_0.GetService("TrainingAreasService");
    v10:_grabRefs();
    task.spawn(function() --[[ Line: 61 ]]
        -- upvalues: v10 (copy)
        local l_status_0, l_result_0 = pcall(function() --[[ Line: 62 ]]
            -- upvalues: v10 (ref)
            v10:_bootstrapAndRun();
        end);
        if not l_status_0 then
            warn("[Tutorial] crashed:", l_result_0);
            if v10.TutorialGui then
                v10.TutorialGui.Enabled = false;
            end;
            v10:_stopArrow();
        end;
    end);
end;
v8._grabRefs = function(v13) --[[ Line: 76 ]] --[[ Name: _grabRefs ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    v13.TutorialGui = l_LocalPlayer_0:WaitForChild("PlayerGui", 20):WaitForChild("Tutorial", 20);
    v13.Canvas = v13.TutorialGui:WaitForChild("Canvas", 20);
    v13.Arrow = v13.TutorialGui:WaitForChild("Arrow", 20);
    v13.BeamTemplate = script:WaitForChild("Beam");
    v13.ChestAttachment = workspace.Map:WaitForChild("Chest", 20):WaitForChild("Hitbox", 20):WaitForChild("Attachment", 20);
    v13.RebirthPadAttachment = workspace:WaitForChild("RebirthPad", 1e999):WaitForChild("TouchPart", 1e999):WaitForChild("Attachment", 1e999);
    v13.TrainingAreasFolder = workspace:WaitForChild("Training Areas", 1e999);
end;
v8._bootstrapAndRun = function(v14) --[[ Line: 95 ]] --[[ Name: _bootstrapAndRun ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    task.wait(11);
    while l_LocalPlayer_0:GetAttribute("Aura") == nil do
        task.wait(0.2);
    end;
    v14:_buildTrainingAreaOrder((v14:_getTrainingAreasData()));
    v14:_runTutorial();
end;
v8._getTrainingAreasData = function(v15) --[[ Line: 108 ]] --[[ Name: _getTrainingAreasData ]]
    local l_status_1, l_result_1 = pcall(function() --[[ Line: 109 ]]
        -- upvalues: v15 (copy)
        return v15.TrainingAreasService:GetTrainingAreasData();
    end);
    if l_status_1 and type(l_result_1) == "table" then
        return l_result_1;
    else
        warn("[Tutorial] Failed to get TrainingAreasData from TrainingAreasService");
        return {};
    end;
end;
v8._buildTrainingAreaOrder = function(v18, v19) --[[ Line: 121 ]] --[[ Name: _buildTrainingAreaOrder ]]
    local v20 = {};
    for v21, v22 in pairs(v19) do
        if type(v22) == "table" and type(v22.Requirement) == "number" then
            table.insert(v20, {
                name = v21, 
                req = v22.Requirement
            });
        end;
    end;
    table.sort(v20, function(v23, v24) --[[ Line: 133 ]]
        return v23.req < v24.req;
    end);
    v18.TrainingAreaReqOrdered = v20;
end;
v8._getTutorialData = function(v25) --[[ Line: 140 ]] --[[ Name: _getTutorialData ]]
    local l_status_2, l_result_2 = pcall(function() --[[ Line: 141 ]]
        -- upvalues: v25 (copy)
        return v25.PlayerService:GetTutorialData();
    end);
    if l_status_2 and type(l_result_2) == "table" then
        return l_result_2;
    else
        return {
            GotRebirth = false, 
            ClaimedFirstChest = false, 
            Zones = {
                FireBath = false, 
                DarkLava = false, 
                AncientRuins = false, 
                ElectraField = false, 
                DivineRealm = false, 
                FrostHeaven = false, 
                FallenStar = false
            }
        };
    end;
end;
v8._getZoneAttachment = function(v28, v29) --[[ Line: 164 ]] --[[ Name: _getZoneAttachment ]]
    return (v28.TrainingAreasFolder:WaitForChild(v29, 1e999):WaitForChild("AreaHitbox", 1e999):WaitForChild("Attachment", 1e999));
end;
v8._getAura = function(_) --[[ Line: 171 ]] --[[ Name: _getAura ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    return l_LocalPlayer_0:GetAttribute("Aura") or 0;
end;
v8._waitForAuraAtLeast = function(v31, v32, v33) --[[ Line: 175 ]] --[[ Name: _waitForAuraAtLeast ]]
    while v31:_getAura() < v32 do
        if v33 then
            v33();
        end;
        task.wait(0.25);
    end;
end;
v8._fadeCanvas = function(v34, v35, v36) --[[ Line: 184 ]] --[[ Name: _fadeCanvas ]]
    -- upvalues: l_TweenService_0 (copy)
    local v37 = l_TweenService_0:Create(v34.Canvas, TweenInfo.new(v36, Enum.EasingStyle.Quad), {
        GroupTransparency = v35
    });
    v37:Play();
    v37.Completed:Wait();
end;
v8._waitForAttributeTrue = function(_, v39) --[[ Line: 192 ]] --[[ Name: _waitForAttributeTrue ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    while not l_LocalPlayer_0:GetAttribute(v39) do
        task.wait(0.1);
    end;
end;
v8._isChestReady = function(_) --[[ Line: 198 ]] --[[ Name: _isChestReady ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    local l_l_LocalPlayer_0_Attribute_0 = l_LocalPlayer_0:GetAttribute("Chest_FirstClaimReadyAt");
    if typeof(l_l_LocalPlayer_0_Attribute_0) ~= "number" then
        return false;
    else
        return l_l_LocalPlayer_0_Attribute_0 <= workspace:GetServerTimeNow();
    end;
end;
v8._hasClaimedFirstChest = function(_) --[[ Line: 207 ]] --[[ Name: _hasClaimedFirstChest ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    return l_LocalPlayer_0:GetAttribute("Tutorial_ClaimedFirstChest") == true;
end;
v8._notifyAreaUnlocked = function(_, v44) --[[ Line: 211 ]] --[[ Name: _notifyAreaUnlocked ]]
    -- upvalues: l_Notifications_0 (copy)
    l_Notifications_0.New(string.upper(v44) .. " UNLOCKED", "SuccessNotification");
end;
v8._startAreaUnlockNotifier = function(v45, v46) --[[ Line: 215 ]] --[[ Name: _startAreaUnlockNotifier ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    if v45.AreaUnlockNotifierStarted then
        return;
    else
        v45.AreaUnlockNotifierStarted = true;
        local v47 = v46 or {};
        local v48 = v45:_getAura();
        local function v53(v49) --[[ Line: 225 ]] --[[ Name: checkAuraCrossing ]]
            -- upvalues: v45 (copy), v47 (copy), v48 (ref)
            for _, v51 in ipairs(v45.TrainingAreaReqOrdered) do
                local v52 = v51.name:gsub("%s+", "");
                if v47[v52] and not v45.SeenAreaUnlockNotifications[v52] and v48 < v51.req and v51.req <= v49 then
                    v45.SeenAreaUnlockNotifications[v52] = true;
                    v45:_notifyAreaUnlocked(v51.name);
                end;
            end;
            v48 = v49;
        end;
        v45.AreaUnlockNotifierConnection = l_LocalPlayer_0:GetAttributeChangedSignal("Aura"):Connect(function() --[[ Line: 240 ]]
            -- upvalues: v45 (copy), v53 (copy)
            local v54 = v45:_getAura();
            v53(v54);
        end);
        return;
    end;
end;
v8._stopArrow = function(v55) --[[ Line: 246 ]] --[[ Name: _stopArrow ]]
    if v55.arrowConnection then
        v55.arrowConnection:Disconnect();
        v55.arrowConnection = nil;
    end;
    v55.Arrow.Visible = false;
end;
v8._createBeamController = function(v56, v57) --[[ Line: 255 ]] --[[ Name: _createBeamController ]]
    -- upvalues: l_RunService_0 (copy), l_LocalPlayer_0 (copy)
    local v58 = v56.BeamTemplate:Clone();
    v58.Attachment1 = v57;
    v58.Enabled = true;
    v58.Parent = workspace;
    local v63 = {
        beam = v58, 
        targetAttachment = v57, 
        alive = true, 
        _scaleConn = nil, 
        _charConn = nil, 
        _hrpAttachment = nil, 
        AttachToCharacter = function(v59, v60) --[[ Line: 269 ]] --[[ Name: AttachToCharacter ]]
            if not v59.alive then
                return;
            else
                local l_Torso_0 = v60:FindFirstChild("Torso");
                if not l_Torso_0 or not l_Torso_0:IsA("BasePart") then
                    l_Torso_0 = v60:WaitForChild("HumanoidRootPart", 10);
                end;
                if not l_Torso_0 then
                    return;
                else
                    if v59._hrpAttachment and v59._hrpAttachment.Parent then
                        v59._hrpAttachment:Destroy();
                    end;
                    local l_Attachment_0 = Instance.new("Attachment");
                    l_Attachment_0.Name = "TutorialBeamAttachment";
                    l_Attachment_0.Parent = l_Torso_0;
                    v59._hrpAttachment = l_Attachment_0;
                    v59.beam.Attachment0 = l_Attachment_0;
                    return;
                end;
            end;
        end
    };
    v63._scaleConn = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 297 ]]
        -- upvalues: v63 (copy)
        if not v63.alive then
            return;
        elseif not v63.beam.Parent then
            return;
        else
            local l_Attachment0_0 = v63.beam.Attachment0;
            local l_Attachment1_0 = v63.beam.Attachment1;
            if not l_Attachment0_0 or not l_Attachment1_0 then
                return;
            else
                local l_Magnitude_0 = (l_Attachment1_0.WorldPosition - l_Attachment0_0.WorldPosition).Magnitude;
                v63.beam.TextureLength = l_Magnitude_0 * 0.4;
                return;
            end;
        end;
    end);
    v63._charConn = l_LocalPlayer_0.CharacterAdded:Connect(function(v67) --[[ Line: 317 ]]
        -- upvalues: v63 (copy)
        v63:AttachToCharacter(v67);
    end);
    if l_LocalPlayer_0.Character then
        v63:AttachToCharacter(l_LocalPlayer_0.Character);
    else
        v63:AttachToCharacter(l_LocalPlayer_0.CharacterAdded:Wait());
    end;
    v63.Destroy = function(v68) --[[ Line: 327 ]] --[[ Name: Destroy ]]
        if not v68.alive then
            return;
        else
            v68.alive = false;
            if v68._scaleConn then
                v68._scaleConn:Disconnect();
                v68._scaleConn = nil;
            end;
            if v68._charConn then
                v68._charConn:Disconnect();
                v68._charConn = nil;
            end;
            if v68._hrpAttachment and v68._hrpAttachment.Parent then
                v68._hrpAttachment:Destroy();
                v68._hrpAttachment = nil;
            end;
            if v68.beam then
                v68.beam.Enabled = false;
                v68.beam.Attachment0 = nil;
                v68.beam.Attachment1 = nil;
                v68.beam:Destroy();
            end;
            return;
        end;
    end;
    return v63;
end;
v8._zoneUnlocked = function(_) --[[ Line: 360 ]] --[[ Name: _zoneUnlocked ]]
    -- upvalues: l_Signals_0 (copy)
    l_Signals_0.PlayRewardFX:Fire();
end;
v8._stageRebirth = function(v70) --[[ Line: 364 ]] --[[ Name: _stageRebirth ]]
    v70:_waitForAuraAtLeast(v70.RebirthCostInAura);
    local v71 = v70:_createBeamController(v70.RebirthPadAttachment);
    v70:_zoneUnlocked();
    v70:_waitForAttributeTrue("Tutorial_GotRebirth");
    v71:Destroy();
end;
v8._stageFirstChestClaim = function(v72) --[[ Line: 375 ]] --[[ Name: _stageFirstChestClaim ]]
    if v72:_hasClaimedFirstChest() then
        return;
    else
        local v73 = v72:_createBeamController(v72.ChestAttachment);
        v72:_zoneUnlocked();
        local v74 = os.clock();
        while not v72:_hasClaimedFirstChest() do
            if os.clock() - v74 > 6 then
                local v75 = v72:_getTutorialData();
                if not v75 or not v75.ClaimedFirstChest then
                    v74 = os.clock();
                else
                    break;
                end;
            end;
            task.wait(0.1);
        end;
        v73:Destroy();
        return;
    end;
end;
v8._stageEnterZone = function(v76, v77) --[[ Line: 401 ]] --[[ Name: _stageEnterZone ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    local v78 = v77:gsub("%s+", "");
    local v79 = "Tutorial_EnteredZone_" .. v78;
    if l_LocalPlayer_0:GetAttribute(v79) then
        return;
    else
        local v80 = v76:_createBeamController((v76:_getZoneAttachment(v77)));
        v76:_zoneUnlocked();
        local v81 = os.clock();
        while not l_LocalPlayer_0:GetAttribute(v79) do
            if os.clock() - v81 > 6 then
                local v82 = v76:_getTutorialData();
                local v83 = v82 and v82.Zones;
                if not v83 or not v83[v78] then
                    v81 = os.clock();
                else
                    break;
                end;
            end;
            task.wait(0.1);
        end;
        v80:Destroy();
        return;
    end;
end;
v8._tryDoChestStage = function(v84) --[[ Line: 434 ]] --[[ Name: _tryDoChestStage ]]
    if v84.chestStageRunning then
        return;
    elseif v84:_hasClaimedFirstChest() then
        return;
    elseif not v84:_isChestReady() then
        return;
    else
        v84.chestStageRunning = true;
        local l_status_3, l_result_3 = pcall(function() --[[ Line: 449 ]]
            -- upvalues: v84 (copy)
            v84:_stageFirstChestClaim();
        end);
        v84.chestStageRunning = false;
        if not l_status_3 then
            warn("[Tutorial Chest] crashed:", l_result_3);
        end;
        return;
    end;
end;
v8._runTutorial = function(v87) --[[ Line: 460 ]] --[[ Name: _runTutorial ]]
    local v88 = v87:_getTutorialData();
    local v89 = v88 and v88.Zones or {};
    v87:_startAreaUnlockNotifier(v89);
    v87.TutorialGui.Enabled = true;
    v87.Arrow.Visible = false;
    if not v88 or not v88.GotRebirth then
        v87:_stageRebirth();
        task.wait(0.25);
    end;
    v87:_tryDoChestStage();
    for _, v91 in ipairs(v87.TrainingAreaReqOrdered) do
        if not v89[v91.name:gsub("%s+", "")] then
            v87:_waitForAuraAtLeast(v91.req, function() --[[ Line: 480 ]]
                -- upvalues: v87 (copy)
                v87:_tryDoChestStage();
            end);
            v87:_tryDoChestStage();
            v87:_stageEnterZone(v91.name);
            task.wait(0.25);
            v87:_tryDoChestStage();
        end;
    end;
    if not v87:_hasClaimedFirstChest() then
        while not v87:_isChestReady() and not v87:_hasClaimedFirstChest() do
            task.wait(0.25);
        end;
        v87:_tryDoChestStage();
    end;
    v87.TutorialGui.Enabled = false;
end;
return v8;