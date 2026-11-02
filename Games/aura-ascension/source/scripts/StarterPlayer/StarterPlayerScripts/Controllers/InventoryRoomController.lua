-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_ProximityPromptService_0 = game:GetService("ProximityPromptService");
local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local l_Knit_0 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"));
local l_PosePropUtil_0 = require(l_ReplicatedStorage_0:WaitForChild("Modules"):WaitForChild("PosePropUtil"));
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v9 = l_Knit_0.CreateController({
    Name = "InventoryRoomController"
});
local v10 = TweenInfo.new(0.32, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
local v11 = TweenInfo.new(0.32, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
v9.KnitInit = function(v12) --[[ Line: 23 ]] --[[ Name: KnitInit ]]
    v12.IsOpen = false;
    v12.ActivePrompt = nil;
    v12.ActiveShopModel = nil;
    v12.ActiveCamPart = nil;
    v12.Camera = nil;
    v12.UIManager = nil;
    v12.InventoryHudController = nil;
    v12.PreviousCameraType = nil;
    v12.PreviousCameraSubject = nil;
    v12.PreviousCameraCFrame = nil;
    v12.PreviousCameraFocus = nil;
    v12.PreviousFieldOfView = nil;
    v12.PromptTriggeredConnection = nil;
    v12.CameraLockConnection = nil;
    v12.PlayerGui = nil;
    v12.TransitionGui = nil;
    v12.TransitionFrame = nil;
    v12.InventoryFolder = nil;
    v12.PedestalModel = nil;
    v12.DisplayFolder = nil;
    v12.DisplayCharacter = nil;
    v12._openCloseToken = 0;
end;
v9.KnitStart = function(v13) --[[ Line: 55 ]] --[[ Name: KnitStart ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_Knit_0 (copy)
    v13.Camera = workspace.CurrentCamera;
    v13.PlayerGui = l_LocalPlayer_0:WaitForChild("PlayerGui");
    v13.UIManager = l_Knit_0.GetController("UIManager");
    v13.InventoryHudController = l_Knit_0.GetController("InventoryHudController");
    v13.InventoryFolder = workspace:WaitForChild("Inventory");
    v13:_ensureTransitionGui();
    v13:_ensureDisplayFolder();
    v13:_bindPromptTriggered();
    l_LocalPlayer_0.CharacterAdded:Connect(function() --[[ Line: 67 ]]
        -- upvalues: v13 (copy)
        if v13.IsOpen then
            v13:Close(true);
            return;
        else
            v13:_destroyAllDisplayCharacters();
            return;
        end;
    end);
end;
v9._ensureTransitionGui = function(v14) --[[ Line: 76 ]] --[[ Name: _ensureTransitionGui ]]
    local l_InventoryTransitionGui_0 = v14.PlayerGui:FindFirstChild("InventoryTransitionGui");
    if not l_InventoryTransitionGui_0 then
        l_InventoryTransitionGui_0 = Instance.new("ScreenGui");
        l_InventoryTransitionGui_0.Name = "InventoryTransitionGui";
        l_InventoryTransitionGui_0.IgnoreGuiInset = true;
        l_InventoryTransitionGui_0.ResetOnSpawn = false;
        l_InventoryTransitionGui_0.DisplayOrder = 10000;
        l_InventoryTransitionGui_0.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        l_InventoryTransitionGui_0.Parent = v14.PlayerGui;
    end;
    local l_TransitionFrame_0 = l_InventoryTransitionGui_0:FindFirstChild("TransitionFrame");
    if not l_TransitionFrame_0 then
        l_TransitionFrame_0 = Instance.new("Frame");
        l_TransitionFrame_0.Name = "TransitionFrame";
        l_TransitionFrame_0.BackgroundColor3 = Color3.new(0, 0, 0);
        l_TransitionFrame_0.BorderSizePixel = 0;
        l_TransitionFrame_0.Size = UDim2.fromScale(1, 1);
        l_TransitionFrame_0.Position = UDim2.fromScale(1, 0);
        l_TransitionFrame_0.Visible = false;
        l_TransitionFrame_0.ZIndex = 10000;
        l_TransitionFrame_0.Parent = l_InventoryTransitionGui_0;
    end;
    v14.TransitionGui = l_InventoryTransitionGui_0;
    v14.TransitionFrame = l_TransitionFrame_0;
end;
v9._ensureDisplayFolder = function(v17) --[[ Line: 105 ]] --[[ Name: _ensureDisplayFolder ]]
    if not v17.InventoryFolder then
        return;
    else
        local l_InventoryDisplayCharacters_0 = v17.InventoryFolder:FindFirstChild("InventoryDisplayCharacters");
        if not l_InventoryDisplayCharacters_0 then
            l_InventoryDisplayCharacters_0 = Instance.new("Folder");
            l_InventoryDisplayCharacters_0.Name = "InventoryDisplayCharacters";
            l_InventoryDisplayCharacters_0.Parent = v17.InventoryFolder;
        end;
        v17.DisplayFolder = l_InventoryDisplayCharacters_0;
        return;
    end;
end;
v9._playTransition = function(v19) --[[ Line: 120 ]] --[[ Name: _playTransition ]]
    -- upvalues: l_TweenService_0 (copy), v10 (copy), v11 (copy)
    if not v19.TransitionFrame then
        return;
    else
        local l_TransitionFrame_1 = v19.TransitionFrame;
        l_TransitionFrame_1.Visible = true;
        l_TransitionFrame_1.Position = UDim2.fromScale(1, 0);
        local v21 = l_TweenService_0:Create(l_TransitionFrame_1, v10, {
            Position = UDim2.fromScale(0, 0)
        });
        v21:Play();
        v21.Completed:Wait();
        local v22 = l_TweenService_0:Create(l_TransitionFrame_1, v11, {
            Position = UDim2.fromScale(-1, 0)
        });
        v22:Play();
        v22.Completed:Wait();
        l_TransitionFrame_1.Visible = false;
        l_TransitionFrame_1.Position = UDim2.fromScale(1, 0);
        return;
    end;
end;
v9._bindPromptTriggered = function(v23) --[[ Line: 147 ]] --[[ Name: _bindPromptTriggered ]]
    -- upvalues: l_ProximityPromptService_0 (copy), l_LocalPlayer_0 (copy), l_CollectionService_0 (copy)
    v23.PromptTriggeredConnection = l_ProximityPromptService_0.PromptTriggered:Connect(function(v24, v25) --[[ Line: 148 ]]
        -- upvalues: l_LocalPlayer_0 (ref), l_CollectionService_0 (ref), v23 (copy)
        if v25 ~= l_LocalPlayer_0 then
            return;
        elseif not l_CollectionService_0:HasTag(v24, "InventoryPrompt") then
            return;
        else
            v23:OpenFromPrompt(v24);
            return;
        end;
    end);
end;
v9._findShopModelFromPrompt = function(_, v27) --[[ Line: 161 ]] --[[ Name: _findShopModelFromPrompt ]]
    local l_Parent_0 = v27.Parent;
    while true do
        if l_Parent_0 then
            if l_Parent_0:IsA("Model") then
                return l_Parent_0;
            else
                l_Parent_0 = l_Parent_0.Parent;
            end;
        else
            return nil;
        end;
    end;
end;
v9._findCamPartInShop = function(_, v30) --[[ Line: 174 ]] --[[ Name: _findCamPartInShop ]]
    -- upvalues: l_CollectionService_0 (copy)
    for _, v32 in ipairs(v30:GetDescendants()) do
        if v32:IsA("BasePart") and l_CollectionService_0:HasTag(v32, "CamPart") then
            return v32;
        end;
    end;
    local l_v30_FirstChild_0 = v30:FindFirstChild("CamPart", true);
    if l_v30_FirstChild_0 and l_v30_FirstChild_0:IsA("BasePart") then
        return l_v30_FirstChild_0;
    else
        return nil;
    end;
end;
v9._findPedestalModel = function(v34) --[[ Line: 189 ]] --[[ Name: _findPedestalModel ]]
    if not v34.InventoryFolder then
        return nil;
    else
        local v35 = v34.InventoryFolder:FindFirstChild("Pedestial") or v34.InventoryFolder:FindFirstChild("Pedestal");
        if v35 and v35:IsA("Model") then
            return v35;
        else
            return nil;
        end;
    end;
end;
v9._getPedestalCenterPart = function(v36) --[[ Line: 202 ]] --[[ Name: _getPedestalCenterPart ]]
    if not v36.PedestalModel then
        return nil;
    else
        local l_Center_0 = v36.PedestalModel:FindFirstChild("Center");
        if l_Center_0 and l_Center_0:IsA("BasePart") then
            return l_Center_0;
        else
            return nil;
        end;
    end;
end;
v9._getPrimaryPlacementPart = function(_, v39) --[[ Line: 215 ]] --[[ Name: _getPrimaryPlacementPart ]]
    if v39:IsA("BasePart") then
        return v39;
    else
        if v39:IsA("Model") then
            if v39.PrimaryPart then
                return v39.PrimaryPart;
            else
                local l_HumanoidRootPart_0 = v39:FindFirstChild("HumanoidRootPart");
                if l_HumanoidRootPart_0 and l_HumanoidRootPart_0:IsA("BasePart") then
                    return l_HumanoidRootPart_0;
                else
                    local l_v39_FirstChildWhichIsA_0 = v39:FindFirstChildWhichIsA("BasePart", true);
                    if l_v39_FirstChildWhichIsA_0 then
                        return l_v39_FirstChildWhichIsA_0;
                    end;
                end;
            end;
        end;
        return nil;
    end;
end;
v9._getRootPart = function(_, v43) --[[ Line: 239 ]] --[[ Name: _getRootPart ]]
    local l_HumanoidRootPart_1 = v43:FindFirstChild("HumanoidRootPart");
    if l_HumanoidRootPart_1 and l_HumanoidRootPart_1:IsA("BasePart") then
        return l_HumanoidRootPart_1;
    elseif v43.PrimaryPart and v43.PrimaryPart:IsA("BasePart") then
        return v43.PrimaryPart;
    else
        local l_v43_FirstChildWhichIsA_0 = v43:FindFirstChildWhichIsA("BasePart", true);
        if l_v43_FirstChildWhichIsA_0 then
            return l_v43_FirstChildWhichIsA_0;
        else
            return nil;
        end;
    end;
end;
v9._stopCharacterScripts = function(_, v47) --[[ Line: 257 ]] --[[ Name: _stopCharacterScripts ]]
    for _, v49 in ipairs(v47:GetDescendants()) do
        if v49:IsA("Script") or v49:IsA("LocalScript") then
            v49:Destroy();
        end;
    end;
end;
v9._configureDisplayCharacterPhysics = function(v50, v51) --[[ Line: 265 ]] --[[ Name: _configureDisplayCharacterPhysics ]]
    local v52 = v50:_getRootPart(v51);
    if v52 then
        v51.PrimaryPart = v52;
    end;
    for _, v54 in ipairs(v51:GetDescendants()) do
        if v54:IsA("BasePart") then
            v54.CanCollide = false;
            v54.CanTouch = false;
            v54.CanQuery = false;
            v54.Massless = true;
            v54.Anchored = false;
        end;
    end;
    if v52 then
        v52.Anchored = true;
        v52.Massless = false;
    end;
end;
v9._prepareDisplayCharacter = function(v55, v56) --[[ Line: 287 ]] --[[ Name: _prepareDisplayCharacter ]]
    local l_Humanoid_0 = v56:FindFirstChildOfClass("Humanoid");
    if l_Humanoid_0 then
        l_Humanoid_0.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        l_Humanoid_0.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff;
        l_Humanoid_0.NameDisplayDistance = 0;
        l_Humanoid_0.BreakJointsOnDeath = false;
        l_Humanoid_0.AutoRotate = false;
        pcall(function() --[[ Line: 296 ]]
            -- upvalues: l_Humanoid_0 (copy)
            l_Humanoid_0:BuildRigFromAttachments();
        end);
    end;
    v55:_stopCharacterScripts(v56);
    v55:_configureDisplayCharacterPhysics(v56);
end;
v9._pivotCharacterOntoPart = function(v58, v59, v60, v61) --[[ Line: 305 ]] --[[ Name: _pivotCharacterOntoPart ]]
    local v62 = v61 or 3;
    local v63 = v58:_getRootPart(v59);
    if not v63 then
        return;
    else
        v59.PrimaryPart = v63;
        local v64 = v60.Position + Vector3.new(0, v62, 0);
        local v65 = nil;
        v65 = if v58.ActiveCamPart and v58.ActiveCamPart:IsA("BasePart") then v58.ActiveCamPart.Position - v64 else v60.CFrame.LookVector;
        local v66 = Vector3.new(v65.X, 0, v65.Z);
        if v66.Magnitude <= 0 then
            v66 = Vector3.new(0, 0, -1, 0);
        end;
        v59:PivotTo(CFrame.lookAt(v64, v64 + v66.Unit));
        return;
    end;
end;
v9._createDisplayCharacterForLocalPlayer = function(_) --[[ Line: 331 ]] --[[ Name: _createDisplayCharacterForLocalPlayer ]]
    -- upvalues: l_Players_0 (copy), l_LocalPlayer_0 (copy)
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 332 ]]
        -- upvalues: l_Players_0 (ref), l_LocalPlayer_0 (ref)
        return l_Players_0:GetHumanoidDescriptionFromUserId(l_LocalPlayer_0.UserId);
    end);
    if not l_status_0 or not l_result_0 then
        warn("[InventoryRoomController] Failed to get humanoid description for local player");
        return nil;
    else
        local l_status_1, l_result_1 = pcall(function() --[[ Line: 341 ]]
            -- upvalues: l_Players_0 (ref), l_result_0 (copy)
            return l_Players_0:CreateHumanoidModelFromDescription(l_result_0, Enum.HumanoidRigType.R6);
        end);
        if l_status_1 and l_result_1 then
            return l_result_1;
        else
            warn("[InventoryRoomController] Failed to create display character for local player");
            return nil;
        end;
    end;
end;
v9._destroyDisplayCharacter = function(v72) --[[ Line: 353 ]] --[[ Name: _destroyDisplayCharacter ]]
    if v72.DisplayCharacter then
        v72.DisplayCharacter:Destroy();
        v72.DisplayCharacter = nil;
    end;
end;
v9._destroyAllDisplayCharacters = function(v73) --[[ Line: 360 ]] --[[ Name: _destroyAllDisplayCharacters ]]
    if v73.DisplayFolder then
        for _, v75 in ipairs(v73.DisplayFolder:GetChildren()) do
            if v75:IsA("Model") then
                v75:Destroy();
            end;
        end;
    end;
    v73.DisplayCharacter = nil;
end;
v9._spawnDisplayCharacter = function(v76) --[[ Line: 372 ]] --[[ Name: _spawnDisplayCharacter ]]
    v76:_destroyAllDisplayCharacters();
    v76.PedestalModel = v76:_findPedestalModel();
    if not v76.PedestalModel then
        warn("[InventoryRoomController] Could not find Pedestial/Pedestal under workspace.Inventory");
        return;
    else
        local v77 = v76:_getPedestalCenterPart() or v76:_getPrimaryPlacementPart(v76.PedestalModel);
        if not v77 then
            warn("[InventoryRoomController] Could not find placement part for pedestal");
            return;
        else
            local v78 = v76:_createDisplayCharacterForLocalPlayer();
            if not v78 then
                return;
            else
                v76:_prepareDisplayCharacter(v78);
                if not v76.DisplayFolder then
                    v76:_ensureDisplayFolder();
                end;
                v78.Name = "LocalInventoryRig";
                v78.Parent = v76.DisplayFolder or v76.InventoryFolder;
                if not v76.IsOpen then
                    v78:Destroy();
                    return;
                else
                    v76:_pivotCharacterOntoPart(v78, v77, 3);
                    v76.DisplayCharacter = v78;
                    return;
                end;
            end;
        end;
    end;
end;
v9._saveCameraState = function(v79) --[[ Line: 410 ]] --[[ Name: _saveCameraState ]]
    if not v79.Camera then
        v79.Camera = workspace.CurrentCamera;
    end;
    if not v79.Camera then
        return;
    else
        v79.PreviousCameraType = v79.Camera.CameraType;
        v79.PreviousCameraSubject = v79.Camera.CameraSubject;
        v79.PreviousCameraCFrame = v79.Camera.CFrame;
        v79.PreviousCameraFocus = v79.Camera.Focus;
        v79.PreviousFieldOfView = v79.Camera.FieldOfView;
        return;
    end;
end;
v9._stopCameraLock = function(v80) --[[ Line: 426 ]] --[[ Name: _stopCameraLock ]]
    if v80.CameraLockConnection then
        v80.CameraLockConnection:Disconnect();
        v80.CameraLockConnection = nil;
    end;
end;
v9._startCameraLock = function(v81, v82) --[[ Line: 433 ]] --[[ Name: _startCameraLock ]]
    -- upvalues: l_RunService_0 (copy)
    if not v81.Camera then
        v81.Camera = workspace.CurrentCamera;
    end;
    if not v81.Camera then
        return;
    else
        v81:_stopCameraLock();
        v81.Camera.CameraSubject = nil;
        v81.Camera.CameraType = Enum.CameraType.Scriptable;
        v81.Camera.CFrame = v82.CFrame;
        v81.Camera.Focus = v82.CFrame;
        v81.CameraLockConnection = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 449 ]]
            -- upvalues: v81 (copy), v82 (copy)
            if not v81.IsOpen then
                return;
            elseif not v81.Camera or not v82 or not v82.Parent then
                return;
            else
                v81.Camera.CameraType = Enum.CameraType.Scriptable;
                v81.Camera.CameraSubject = nil;
                v81.Camera.CFrame = v82.CFrame;
                v81.Camera.Focus = v82.CFrame;
                return;
            end;
        end);
        return;
    end;
end;
v9._restoreCameraToPlayer = function(v83) --[[ Line: 465 ]] --[[ Name: _restoreCameraToPlayer ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    if not v83.Camera then
        v83.Camera = workspace.CurrentCamera;
    end;
    if not v83.Camera then
        return;
    else
        v83:_stopCameraLock();
        local l_Character_0 = l_LocalPlayer_0.Character;
        local v85 = l_Character_0 and l_Character_0:FindFirstChildOfClass("Humanoid");
        v83.Camera.CameraType = Enum.CameraType.Custom;
        v83.Camera.CameraSubject = v85 or v83.PreviousCameraSubject;
        if v83.PreviousFieldOfView then
            v83.Camera.FieldOfView = v83.PreviousFieldOfView;
        end;
        return;
    end;
end;
v9.OpenFromPrompt = function(v86, v87) --[[ Line: 487 ]] --[[ Name: OpenFromPrompt ]]
    if not v87 or not v87:IsA("ProximityPrompt") then
        return false;
    else
        v86._openCloseToken = v86._openCloseToken + 1;
        local l__openCloseToken_0 = v86._openCloseToken;
        if v86.IsOpen then
            v86:Close(true);
        end;
        local v89 = v86:_findShopModelFromPrompt(v87);
        if not v89 then
            warn("[InventoryRoomController] Could not find shop model from prompt:", v87:GetFullName());
            return false;
        else
            local v90 = v86:_findCamPartInShop(v89);
            if not v90 then
                warn("[InventoryRoomController] Could not find CamPart in shop model:", v89:GetFullName());
                return false;
            else
                v86.ActivePrompt = v87;
                v86.ActiveShopModel = v89;
                v86.ActiveCamPart = v90;
                v86:_saveCameraState();
                task.spawn(function() --[[ Line: 517 ]]
                    -- upvalues: v86 (copy)
                    v86:_playTransition();
                end);
                task.wait(0.11);
                if l__openCloseToken_0 ~= v86._openCloseToken then
                    return false;
                else
                    v86.IsOpen = true;
                    v86:_spawnDisplayCharacter();
                    if l__openCloseToken_0 ~= v86._openCloseToken then
                        v86:_destroyAllDisplayCharacters();
                        return false;
                    else
                        v86:_startCameraLock(v90);
                        if v86.UIManager then
                            v86.UIManager:EnterInventoryHud();
                        end;
                        if v86.InventoryHudController then
                            v86.InventoryHudController:ShowDefaultPage();
                        end;
                        return true;
                    end;
                end;
            end;
        end;
    end;
end;
v9.Close = function(v91, v92) --[[ Line: 548 ]] --[[ Name: Close ]]
    if not v91.IsOpen and not v91.DisplayCharacter then
        v91:_destroyAllDisplayCharacters();
        return;
    else
        v91._openCloseToken = v91._openCloseToken + 1;
        local l__openCloseToken_1 = v91._openCloseToken;
        if not v92 then
            task.spawn(function() --[[ Line: 558 ]]
                -- upvalues: v91 (copy)
                v91:_playTransition();
            end);
            task.wait(0.11);
            if l__openCloseToken_1 ~= v91._openCloseToken then
                return;
            end;
        end;
        v91.IsOpen = false;
        v91:_restoreCameraToPlayer();
        v91:_destroyAllDisplayCharacters();
        if v91.UIManager then
            v91.UIManager:ExitInventoryHud();
        end;
        v91.ActivePrompt = nil;
        v91.ActiveShopModel = nil;
        v91.ActiveCamPart = nil;
        v91.PedestalModel = nil;
        return;
    end;
end;
v9.GetDisplayCharacter = function(v94) --[[ Line: 583 ]] --[[ Name: GetDisplayCharacter ]]
    return v94.DisplayCharacter;
end;
v9.GetDisplayHumanoid = function(v95) --[[ Line: 587 ]] --[[ Name: GetDisplayHumanoid ]]
    if not v95.DisplayCharacter then
        return nil;
    else
        return v95.DisplayCharacter:FindFirstChildOfClass("Humanoid");
    end;
end;
v9.GetDisplayAnimator = function(v96) --[[ Line: 595 ]] --[[ Name: GetDisplayAnimator ]]
    local l_v96_DisplayHumanoid_0 = v96:GetDisplayHumanoid();
    if not l_v96_DisplayHumanoid_0 then
        return nil;
    else
        local l_Animator_0 = l_v96_DisplayHumanoid_0:FindFirstChildOfClass("Animator");
        if not l_Animator_0 then
            l_Animator_0 = Instance.new("Animator");
            l_Animator_0.Parent = l_v96_DisplayHumanoid_0;
        end;
        return l_Animator_0;
    end;
end;
v9.ClearDisplayPoseProps = function(v99) --[[ Line: 610 ]] --[[ Name: ClearDisplayPoseProps ]]
    -- upvalues: l_PosePropUtil_0 (copy)
    if not v99.DisplayCharacter then
        return;
    else
        l_PosePropUtil_0.Clear(v99.DisplayCharacter);
        return;
    end;
end;
v9.AttachDisplayPoseProp = function(v100, v101) --[[ Line: 618 ]] --[[ Name: AttachDisplayPoseProp ]]
    -- upvalues: l_PosePropUtil_0 (copy)
    if not v100.DisplayCharacter then
        return false;
    else
        return l_PosePropUtil_0.AttachStoredProp(v100.DisplayCharacter, v101);
    end;
end;
return v9;