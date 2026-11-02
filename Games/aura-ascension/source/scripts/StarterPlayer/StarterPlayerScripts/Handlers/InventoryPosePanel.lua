-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_MarketplaceService_0 = game:GetService("MarketplaceService");
local l_Knit_0 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"));
local l_PoseConfig_0 = require(l_ReplicatedStorage_0:WaitForChild("Modules"):WaitForChild("PoseConfig"));
local v4 = require(l_ReplicatedStorage_0:WaitForChild("Math Utility"));
local v5 = require(l_ReplicatedStorage_0.Frameworks.Notifications);
local v6 = {};
v6.__index = v6;
local v7 = Color3.new(1, 1, 1);
v6.new = function(v8, v9, v10, v11) --[[ Line: 15 ]] --[[ Name: new ]]
    -- upvalues: v6 (copy)
    local v12 = setmetatable({}, v6);
    v12.ScrollingFrame = v8;
    v12.TitleLabel = v9;
    v12.InventoryRoomController = v10;
    v12.TopFrame = v11;
    v12.Template = v8:WaitForChild("Template");
    v12.BuyBtn = nil;
    v12.BuyBtnLabel = nil;
    v12.BuyRobuxBtn = nil;
    v12.BuyRobuxBtnLabel = nil;
    v12.EquipBtn = nil;
    v12.UnequipBtn = nil;
    if v12.TopFrame then
        v12.BuyBtn = v12.TopFrame:FindFirstChild("BuyBtn", true);
        if v12.BuyBtn and v12.BuyBtn:IsA("GuiButton") then
            v12.BuyBtnLabel = v12.BuyBtn:FindFirstChildWhichIsA("TextLabel");
        else
            v12.BuyBtn = nil;
        end;
        v12.BuyRobuxBtn = v12.TopFrame:FindFirstChild("BuyRobuxBtn", true);
        if v12.BuyRobuxBtn and v12.BuyRobuxBtn:IsA("GuiButton") then
            v12.BuyRobuxBtnLabel = v12.BuyRobuxBtn:FindFirstChildWhichIsA("TextLabel");
        else
            v12.BuyRobuxBtn = nil;
        end;
        local l_FirstChild_0 = v12.TopFrame:FindFirstChild("EquipBtn", true);
        if l_FirstChild_0 and l_FirstChild_0:IsA("GuiButton") then
            v12.EquipBtn = l_FirstChild_0;
        end;
        local l_FirstChild_1 = v12.TopFrame:FindFirstChild("UnequipBtn", true);
        if l_FirstChild_1 and l_FirstChild_1:IsA("GuiButton") then
            v12.UnequipBtn = l_FirstChild_1;
        end;
    end;
    v12.PoseService = nil;
    v12.EntryMap = {};
    v12.EntryConnections = {};
    v12.ProductPriceCache = {};
    v12.SelectedPoseId = nil;
    v12.SelectedEntry = nil;
    v12.ActiveTrack = nil;
    v12.ActiveViewportTracks = {};
    v12.LayoutConn = nil;
    v12.PoseDataConn = nil;
    v12.BuyBtnConn = nil;
    v12.BuyRobuxBtnConn = nil;
    v12.EquipBtnConn = nil;
    v12.UnequipBtnConn = nil;
    v12.PoseData = {
        OwnedPoses = {}, 
        EquippedPose = ""
    };
    return v12;
end;
v6.Init = function(v15) --[[ Line: 84 ]] --[[ Name: Init ]]
    -- upvalues: l_Knit_0 (copy), l_PoseConfig_0 (copy)
    v15.PoseService = l_Knit_0.GetService("PoseService");
    v15.Template.Visible = false;
    v15:_clearEntries();
    v15:_buildEntries();
    v15:_bindCanvasResize();
    v15:_bindActionButtons();
    v15:_bindPoseData();
    v15:_clearTopFrame();
    local v16 = l_PoseConfig_0.GetAllPoses()[1];
    if v16 then
        v15:SelectPose(v16.Id);
    end;
end;
v6.Destroy = function(v17) --[[ Line: 102 ]] --[[ Name: Destroy ]]
    if v17.LayoutConn then
        v17.LayoutConn:Disconnect();
        v17.LayoutConn = nil;
    end;
    if v17.PoseDataConn then
        v17.PoseDataConn:Disconnect();
        v17.PoseDataConn = nil;
    end;
    if v17.BuyBtnConn then
        v17.BuyBtnConn:Disconnect();
        v17.BuyBtnConn = nil;
    end;
    if v17.BuyRobuxBtnConn then
        v17.BuyRobuxBtnConn:Disconnect();
        v17.BuyRobuxBtnConn = nil;
    end;
    if v17.EquipBtnConn then
        v17.EquipBtnConn:Disconnect();
        v17.EquipBtnConn = nil;
    end;
    if v17.UnequipBtnConn then
        v17.UnequipBtnConn:Disconnect();
        v17.UnequipBtnConn = nil;
    end;
    for _, v19 in pairs(v17.EntryConnections) do
        v19:Disconnect();
    end;
    v17.EntryConnections = {};
    for _, v21 in pairs(v17.ActiveViewportTracks) do
        pcall(function() --[[ Line: 139 ]]
            -- upvalues: v21 (copy)
            v21:Stop(0);
            v21:Destroy();
        end);
    end;
    v17.ActiveViewportTracks = {};
    v17:_stopActiveTrack();
    if v17.InventoryRoomController then
        v17.InventoryRoomController:ClearDisplayPoseProps();
    end;
    v17.EntryMap = {};
    v17.SelectedPoseId = nil;
    v17.SelectedEntry = nil;
end;
v6._clearEntries = function(v22) --[[ Line: 157 ]] --[[ Name: _clearEntries ]]
    for _, v24 in ipairs(v22.ScrollingFrame:GetChildren()) do
        if v24 ~= v22.Template and v24:IsA("GuiObject") then
            v24:Destroy();
        end;
    end;
end;
v6._buildEntries = function(v25) --[[ Line: 165 ]] --[[ Name: _buildEntries ]]
    -- upvalues: l_PoseConfig_0 (copy)
    local v26 = l_PoseConfig_0.GetAllPoses();
    for _, v28 in ipairs(v26) do
        local v29 = v25:_createEntry(v28);
        if v29 then
            v25.EntryMap[v28.Id] = {
                Frame = v29, 
                PoseData = v28
            };
        end;
    end;
    v25:_refreshAllEntryStates();
end;
v6._createEntry = function(v30, v31) --[[ Line: 181 ]] --[[ Name: _createEntry ]]
    local v32 = v30.Template:Clone();
    v32.Name = v31.Id;
    v32.Visible = true;
    v32.Parent = v30.ScrollingFrame;
    local l_v32_FirstChild_0 = v32:FindFirstChild("Name", true);
    if l_v32_FirstChild_0 and l_v32_FirstChild_0:IsA("TextLabel") then
        l_v32_FirstChild_0.Text = v31.DisplayName or v31.Id;
    end;
    local l_v32_FirstChild_1 = v32:FindFirstChild("ViewportFrame", true);
    if l_v32_FirstChild_1 and l_v32_FirstChild_1:IsA("ViewportFrame") then
        v30:_buildViewportPreview(l_v32_FirstChild_1, v31);
    end;
    v30:_setEntrySelected(v32, false);
    v30:_bindEntrySelection(v32, v31);
    v30:_refreshEntryState(v31.Id);
    return v32;
end;
v6._bindEntrySelection = function(v35, v36, v37) --[[ Line: 204 ]] --[[ Name: _bindEntrySelection ]]
    local v38 = nil;
    v38 = if v36:IsA("GuiButton") then v36 else v36:FindFirstChildWhichIsA("GuiButton", true);
    if not v38 then
        warn(("[InventoryPosePanel] No clickable button found for pose '%s'"):format((tostring(v37.Id))));
        return;
    else
        v35.EntryConnections[v36] = v38.MouseButton1Click:Connect(function() --[[ Line: 218 ]]
            -- upvalues: v35 (copy), v37 (copy)
            v35:SelectPose(v37.Id);
        end);
        return;
    end;
end;
v6._setEntrySelected = function(_, v40, v41) --[[ Line: 223 ]] --[[ Name: _setEntrySelected ]]
    -- upvalues: v7 (copy)
    local l_SelectionStroke_0 = v40:FindFirstChild("SelectionStroke");
    if v41 then
        if not l_SelectionStroke_0 then
            l_SelectionStroke_0 = Instance.new("UIStroke");
            l_SelectionStroke_0.Name = "SelectionStroke";
            l_SelectionStroke_0.Color = v7;
            l_SelectionStroke_0.Thickness = 2;
            l_SelectionStroke_0.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
            l_SelectionStroke_0.Parent = v40;
        end;
        l_SelectionStroke_0.Enabled = true;
        return;
    else
        if l_SelectionStroke_0 and l_SelectionStroke_0:IsA("UIStroke") then
            l_SelectionStroke_0.Enabled = false;
        end;
        return;
    end;
end;
v6._stopActiveTrack = function(v43) --[[ Line: 244 ]] --[[ Name: _stopActiveTrack ]]
    if v43.ActiveTrack then
        pcall(function() --[[ Line: 246 ]]
            -- upvalues: v43 (copy)
            v43.ActiveTrack:Stop(0.15);
            v43.ActiveTrack:Destroy();
        end);
        v43.ActiveTrack = nil;
    end;
end;
v6._applyPosePropsToInventoryRig = function(v44, v45) --[[ Line: 254 ]] --[[ Name: _applyPosePropsToInventoryRig ]]
    if not v44.InventoryRoomController then
        return;
    else
        v44.InventoryRoomController:ClearDisplayPoseProps();
        local l_Prop_0 = v45.Prop;
        if type(l_Prop_0) ~= "table" then
            return;
        else
            if l_Prop_0.Type == "StoredProp" and type(l_Prop_0.PropId) == "string" and l_Prop_0.PropId ~= "" then
                v44.InventoryRoomController:AttachDisplayPoseProp(l_Prop_0.PropId);
            end;
            return;
        end;
    end;
end;
v6._playPoseOnInventoryRig = function(v47, v48) --[[ Line: 271 ]] --[[ Name: _playPoseOnInventoryRig ]]
    v47:_stopActiveTrack();
    if not v47.InventoryRoomController then
        return;
    else
        v47:_applyPosePropsToInventoryRig(v48);
        local l_DisplayAnimator_0 = v47.InventoryRoomController:GetDisplayAnimator();
        local l_DisplayHumanoid_0 = v47.InventoryRoomController:GetDisplayHumanoid();
        if not l_DisplayAnimator_0 or not l_DisplayHumanoid_0 then
            return;
        else
            local l_Animation_0 = v48.Animation;
            if type(l_Animation_0) ~= "table" or type(l_Animation_0.Id) ~= "string" or l_Animation_0.Id == "" then
                return;
            else
                local l_Animation_1 = Instance.new("Animation");
                l_Animation_1.AnimationId = l_Animation_0.Id;
                local l_status_0, l_result_0 = pcall(function() --[[ Line: 295 ]]
                    -- upvalues: l_DisplayAnimator_0 (copy), l_Animation_1 (copy)
                    return l_DisplayAnimator_0:LoadAnimation(l_Animation_1);
                end);
                if not l_status_0 or not l_result_0 then
                    return;
                else
                    l_result_0.Looped = true;
                    l_result_0.Priority = l_Animation_0.Priority or Enum.AnimationPriority.Action;
                    l_result_0:Play(0.15, 1, l_Animation_0.Speed or 1);
                    if typeof(l_Animation_0.HipHeight) == "number" then
                        l_DisplayHumanoid_0.HipHeight = l_Animation_0.HipHeight;
                    end;
                    v47.ActiveTrack = l_result_0;
                    return;
                end;
            end;
        end;
    end;
end;
v6._buildViewportPreview = function(v55, v56, v57) --[[ Line: 314 ]] --[[ Name: _buildViewportPreview ]]
    -- upvalues: l_ReplicatedStorage_0 (copy)
    local v58 = v55.ActiveViewportTracks[v56];
    if v58 then
        pcall(function() --[[ Line: 317 ]]
            -- upvalues: v58 (copy)
            v58:Stop(0);
            v58:Destroy();
        end);
        v55.ActiveViewportTracks[v56] = nil;
    end;
    v56:ClearAllChildren();
    local l_WorldModel_0 = Instance.new("WorldModel");
    l_WorldModel_0.Parent = v56;
    local l_FirstChild_2 = l_ReplicatedStorage_0:WaitForChild("Assets"):WaitForChild("Poses"):FindFirstChild(v57.Id);
    if not l_FirstChild_2 or not l_FirstChild_2:IsA("Model") then
        warn(("[InventoryPosePanel] Missing rig model for pose '%s'"):format((tostring(v57.Id))));
        return;
    else
        local v61 = l_FirstChild_2:Clone();
        v61.Parent = l_WorldModel_0;
        local v62 = v61.PrimaryPart or v61:FindFirstChild("HumanoidRootPart") or v61:FindFirstChildWhichIsA("BasePart");
        if v62 then
            v61.PrimaryPart = v62;
            v61:PivotTo(CFrame.new(0, 0, 0) * CFrame.Angles(0, 3.141592653589793, 0));
        end;
        local l_Humanoid_0 = v61:FindFirstChildOfClass("Humanoid");
        if l_Humanoid_0 then
            local l_Animator_0 = l_Humanoid_0:FindFirstChildOfClass("Animator");
            if not l_Animator_0 then
                l_Animator_0 = Instance.new("Animator");
                l_Animator_0.Parent = l_Humanoid_0;
            end;
            local l_Animation_2 = v57.Animation;
            do
                local l_l_Animator_0_0 = l_Animator_0;
                if l_Animation_2 and l_Animation_2.Id then
                    local l_Animation_3 = Instance.new("Animation");
                    l_Animation_3.AnimationId = l_Animation_2.Id;
                    local l_status_1, l_result_1 = pcall(function() --[[ Line: 359 ]]
                        -- upvalues: l_l_Animator_0_0 (ref), l_Animation_3 (copy)
                        return l_l_Animator_0_0:LoadAnimation(l_Animation_3);
                    end);
                    if l_status_1 and l_result_1 then
                        l_result_1.Looped = true;
                        l_result_1.Priority = l_Animation_2.Priority or Enum.AnimationPriority.Action3;
                        l_result_1:Play(0, 1, l_Animation_2.Speed or 1);
                        v55.ActiveViewportTracks[v56] = l_result_1;
                        l_Humanoid_0.HipHeight = l_Animation_2.HipHeight or l_Humanoid_0.HipHeight;
                    end;
                end;
            end;
        end;
        local l_Camera_0 = Instance.new("Camera");
        l_Camera_0.Parent = v56;
        v56.CurrentCamera = l_Camera_0;
        v55:_positionViewportCamera(l_Camera_0, v61);
        return;
    end;
end;
v6._positionViewportCamera = function(_, v72, v73) --[[ Line: 381 ]] --[[ Name: _positionViewportCamera ]]
    local l_v73_BoundingBox_0, v75 = v73:GetBoundingBox();
    local l_Position_0 = l_v73_BoundingBox_0.Position;
    local v77 = math.max(6, math.max(v75.X, v75.Y, v75.Z) * 1.75);
    local v78 = Vector3.new(0, v75.Y * 0.15, 0);
    local v79 = Vector3.new(0, v75.Y * 0.15, v77);
    v72.CFrame = CFrame.new(l_Position_0 + v78 + v79, l_Position_0 + v78);
end;
v6._bindCanvasResize = function(v80) --[[ Line: 394 ]] --[[ Name: _bindCanvasResize ]]
    local l_UIListLayout_0 = v80.ScrollingFrame:FindFirstChildOfClass("UIListLayout");
    if not l_UIListLayout_0 then
        return;
    else
        local function v82() --[[ Line: 400 ]] --[[ Name: updateCanvas ]]
            -- upvalues: v80 (copy), l_UIListLayout_0 (copy)
            v80.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, l_UIListLayout_0.AbsoluteContentSize.Y + 40);
        end;
        v80.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, l_UIListLayout_0.AbsoluteContentSize.Y + 40);
        v80.LayoutConn = l_UIListLayout_0:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(v82);
        return;
    end;
end;
v6._bindActionButtons = function(v83) --[[ Line: 408 ]] --[[ Name: _bindActionButtons ]]
    if v83.BuyBtn then
        v83.BuyBtnConn = v83.BuyBtn.MouseButton1Click:Connect(function() --[[ Line: 410 ]]
            -- upvalues: v83 (copy)
            v83:_onBuyRebirthClicked();
        end);
    end;
    if v83.BuyRobuxBtn then
        v83.BuyRobuxBtnConn = v83.BuyRobuxBtn.MouseButton1Click:Connect(function() --[[ Line: 416 ]]
            -- upvalues: v83 (copy)
            v83:_onBuyRobuxClicked();
        end);
    end;
    if v83.EquipBtn then
        v83.EquipBtnConn = v83.EquipBtn.MouseButton1Click:Connect(function() --[[ Line: 422 ]]
            -- upvalues: v83 (copy)
            v83:_onEquipClicked();
        end);
    end;
    if v83.UnequipBtn then
        v83.UnequipBtnConn = v83.UnequipBtn.MouseButton1Click:Connect(function() --[[ Line: 428 ]]
            -- upvalues: v83 (copy)
            v83:_onUnequipClicked();
        end);
    end;
end;
v6._onBuyRebirthClicked = function(v84) --[[ Line: 434 ]] --[[ Name: _onBuyRebirthClicked ]]
    -- upvalues: v5 (copy), l_PoseConfig_0 (copy)
    if not v84.SelectedPoseId or not v84.PoseService then
        return;
    else
        local v85 = v84.PoseService:PurchasePoseWithRebirths(v84.SelectedPoseId);
        if not v85 or typeof(v85.andThen) ~= "function" then
            warn("[InventoryPosePanel] PurchasePoseWithRebirths did not return a promise-like object");
            v5.New("PURCHASE FAILED", "ErrorNotification");
            return;
        else
            v85:andThen(function(v86, v87) --[[ Line: 448 ]]
                -- upvalues: l_PoseConfig_0 (ref), v84 (copy), v5 (ref)
                if v86 then
                    local v88 = l_PoseConfig_0.GetPose(v84.SelectedPoseId);
                    local v89 = v88 and v88.DisplayName or v84.SelectedPoseId;
                    v5.New("PURCHASED " .. string.upper(v89), "SuccessNotification");
                    v84:_requestPoseDataRefresh();
                    return;
                elseif v87 == "NotEnoughRebirths" then
                    v5.New("NOT ENOUGH REBIRTHS", "ErrorNotification");
                    return;
                elseif v87 == "AlreadyOwned" then
                    v5.New("YOU ALREADY OWN THIS POSE", "ErrorNotification");
                    return;
                elseif v87 == "NotRebirthPurchasable" then
                    v5.New("THIS POSE IS NOT A REBIRTH PURCHASE", "ErrorNotification");
                    return;
                else
                    v5.New("PURCHASE FAILED", "ErrorNotification");
                    return;
                end;
            end):catch(function(v90) --[[ Line: 467 ]]
                -- upvalues: v5 (ref)
                warn("[InventoryPosePanel] PurchasePoseWithRebirths failed:", v90);
                v5.New("PURCHASE FAILED", "ErrorNotification");
            end);
            return;
        end;
    end;
end;
v6._onBuyRobuxClicked = function(v91) --[[ Line: 473 ]] --[[ Name: _onBuyRobuxClicked ]]
    -- upvalues: v5 (copy)
    if not v91.SelectedPoseId or not v91.PoseService then
        return;
    else
        local v92 = v91.PoseService:PromptPosePurchase(v91.SelectedPoseId);
        if not v92 or typeof(v92.andThen) ~= "function" then
            warn("[InventoryPosePanel] PromptPosePurchase did not return a promise-like object");
            v5.New("ROBLOX PURCHASE FAILED", "ErrorNotification");
            return;
        else
            v92:andThen(function(v93, v94) --[[ Line: 487 ]]
                -- upvalues: v5 (ref)
                if not v93 then
                    if v94 == "AlreadyOwned" then
                        v5.New("YOU ALREADY OWN THIS POSE", "ErrorNotification");
                        return;
                    elseif v94 == "PackOnly" then
                        v5.New("THIS POSE COMES FROM A PACK", "ErrorNotification");
                        return;
                    else
                        v5.New("ROBLOX PURCHASE FAILED", "ErrorNotification");
                    end;
                end;
            end):catch(function(v95) --[[ Line: 498 ]]
                -- upvalues: v5 (ref)
                warn("[InventoryPosePanel] PromptPosePurchase failed:", v95);
                v5.New("ROBLOX PURCHASE FAILED", "ErrorNotification");
            end);
            return;
        end;
    end;
end;
v6._onEquipClicked = function(v96) --[[ Line: 504 ]] --[[ Name: _onEquipClicked ]]
    -- upvalues: v5 (copy), l_PoseConfig_0 (copy)
    if not v96.SelectedPoseId or not v96.PoseService then
        return;
    else
        local v97 = v96.PoseService:EquipPose(v96.SelectedPoseId);
        if not v97 or typeof(v97.andThen) ~= "function" then
            warn("[InventoryPosePanel] EquipPose did not return a promise-like object");
            v5.New("COULD NOT EQUIP POSE", "ErrorNotification");
            return;
        else
            v97:andThen(function(v98) --[[ Line: 518 ]]
                -- upvalues: l_PoseConfig_0 (ref), v96 (copy), v5 (ref)
                if v98 then
                    local v99 = l_PoseConfig_0.GetPose(v96.SelectedPoseId);
                    local v100 = v99 and v99.DisplayName or v96.SelectedPoseId;
                    v5.New("EQUIPPED " .. string.upper(v100), "SuccessNotification");
                    v96:_requestPoseDataRefresh();
                    return;
                else
                    v5.New("COULD NOT EQUIP POSE", "ErrorNotification");
                    return;
                end;
            end):catch(function(v101) --[[ Line: 528 ]]
                -- upvalues: v5 (ref)
                warn("[InventoryPosePanel] EquipPose failed:", v101);
                v5.New("COULD NOT EQUIP POSE", "ErrorNotification");
            end);
            return;
        end;
    end;
end;
v6._onUnequipClicked = function(v102) --[[ Line: 534 ]] --[[ Name: _onUnequipClicked ]]
    -- upvalues: v5 (copy)
    if not v102.PoseService then
        return;
    else
        local v103 = v102.PoseService:UnequipPose();
        if not v103 or typeof(v103.andThen) ~= "function" then
            warn("[InventoryPosePanel] UnequipPose did not return a promise-like object");
            v5.New("COULD NOT UNEQUIP POSE", "ErrorNotification");
            return;
        else
            v103:andThen(function(v104) --[[ Line: 548 ]]
                -- upvalues: v5 (ref), v102 (copy)
                if v104 then
                    v5.New("UNEQUIPPED POSE", "SuccessNotification");
                    v102:_requestPoseDataRefresh();
                    return;
                else
                    v5.New("COULD NOT UNEQUIP POSE", "ErrorNotification");
                    return;
                end;
            end):catch(function(v105) --[[ Line: 556 ]]
                -- upvalues: v5 (ref)
                warn("[InventoryPosePanel] UnequipPose failed:", v105);
                v5.New("COULD NOT UNEQUIP POSE", "ErrorNotification");
            end);
            return;
        end;
    end;
end;
v6._clearTopFrame = function(v106) --[[ Line: 562 ]] --[[ Name: _clearTopFrame ]]
    if v106.TopFrame and v106.TopFrame:IsA("GuiObject") then
        v106.TopFrame.Visible = false;
    end;
    if v106.BuyBtnLabel then
        v106.BuyBtnLabel.Text = "";
    end;
    if v106.BuyRobuxBtnLabel then
        v106.BuyRobuxBtnLabel.Text = "";
    end;
    if v106.BuyBtn then
        v106.BuyBtn.Visible = false;
    end;
    if v106.BuyRobuxBtn then
        v106.BuyRobuxBtn.Visible = false;
    end;
    if v106.EquipBtn then
        v106.EquipBtn.Visible = false;
    end;
    if v106.UnequipBtn then
        v106.UnequipBtn.Visible = false;
    end;
end;
v6._getUnlockType = function(_, v108) --[[ Line: 592 ]] --[[ Name: _getUnlockType ]]
    -- upvalues: v4 (copy)
    if not v108 then
        return "Unknown";
    else
        local l_Unlock_0 = v108.Unlock;
        if type(l_Unlock_0) == "table" and type(l_Unlock_0.Type) == "string" then
            return l_Unlock_0.Type;
        else
            local l_Costs_0 = v108.Costs;
            if l_Costs_0 then
                local v111 = l_Costs_0.Rebirths and v4.Normalize(l_Costs_0.Rebirths) or nil;
                if v111 and not v4.IsZero(v111) then
                    return "Rebirths";
                elseif typeof(l_Costs_0.ProductId) == "number" and l_Costs_0.ProductId > 0 then
                    return "Product";
                end;
            end;
            return "Unknown";
        end;
    end;
end;
v6._updateActionButtonsForPose = function(v112, v113) --[[ Line: 617 ]] --[[ Name: _updateActionButtonsForPose ]]
    -- upvalues: l_PoseConfig_0 (copy), v4 (copy)
    if not v113 then
        if v112.BuyBtnLabel then
            v112.BuyBtnLabel.Text = "N/A";
        end;
        if v112.BuyRobuxBtnLabel then
            v112.BuyRobuxBtnLabel.Text = "\238\128\130 N/A";
        end;
        v112:_refreshTopFrameActionState();
        return;
    else
        local v114 = v112:_getUnlockType(v113);
        local v115 = l_PoseConfig_0.GetRebirthPrice(v113.Id);
        local v116 = l_PoseConfig_0.GetProductId(v113.Id);
        local v117 = v115 and v4.Normalize(v115) or nil;
        local v118 = false;
        if v117 ~= nil then
            v118 = not v4.IsZero(v117);
        end;
        local v119 = false;
        if typeof(v116) == "number" then
            v119 = v116 > 0;
        end;
        if v114 == "Pack" then
            if v112.BuyBtnLabel then
                v112.BuyBtnLabel.Text = "PACK";
            end;
            if v112.BuyRobuxBtnLabel then
                v112.BuyRobuxBtnLabel.Text = "PACK";
            end;
        else
            if v118 then
                v112:_updateRebirthButton(v113);
            elseif v112.BuyBtnLabel then
                v112.BuyBtnLabel.Text = "N/A";
            end;
            if v119 then
                v112:_updateRobuxButton(v113);
            elseif v112.BuyRobuxBtnLabel then
                v112.BuyRobuxBtnLabel.Text = "\238\128\130 N/A";
            end;
        end;
        v112:_refreshTopFrameActionState();
        return;
    end;
end;
v6._updateRebirthButton = function(v120, v121) --[[ Line: 662 ]] --[[ Name: _updateRebirthButton ]]
    -- upvalues: l_PoseConfig_0 (copy), v4 (copy)
    if not v120.BuyBtnLabel then
        return;
    else
        local v122 = l_PoseConfig_0.GetRebirthPrice(v121.Id);
        local v123 = v122 and v4.Normalize(v122) or nil;
        if v123 and not v4.IsZero(v123) then
            v120.BuyBtnLabel.Text = v4.FormatNumber(v123);
            return;
        else
            v120.BuyBtnLabel.Text = "N/A";
            return;
        end;
    end;
end;
v6._updateRobuxButton = function(v124, v125) --[[ Line: 677 ]] --[[ Name: _updateRobuxButton ]]
    -- upvalues: l_PoseConfig_0 (copy), l_MarketplaceService_0 (copy)
    if not v124.BuyRobuxBtnLabel then
        return;
    else
        local v126 = l_PoseConfig_0.GetProductId(v125.Id);
        if not v126 or v126 <= 0 then
            v124.BuyRobuxBtnLabel.Text = "\238\128\130 N/A";
            return;
        else
            local v127 = v124.ProductPriceCache[v126];
            if v127 ~= nil then
                v124.BuyRobuxBtnLabel.Text = "\238\128\130 " .. tostring(v127);
                return;
            else
                v124.BuyRobuxBtnLabel.Text = "\238\128\130 ...";
                task.spawn(function() --[[ Line: 696 ]]
                    -- upvalues: l_MarketplaceService_0 (ref), v126 (copy), v124 (copy), v125 (copy)
                    local l_status_2, l_result_2 = pcall(function() --[[ Line: 697 ]]
                        -- upvalues: l_MarketplaceService_0 (ref), v126 (ref)
                        return l_MarketplaceService_0:GetProductInfo(v126, Enum.InfoType.Product);
                    end);
                    local v130 = "N/A";
                    if l_status_2 and typeof(l_result_2) == "table" then
                        local l_PriceInRobux_0 = l_result_2.PriceInRobux;
                        if typeof(l_PriceInRobux_0) == "number" then
                            v130 = tostring(l_PriceInRobux_0);
                            v124.ProductPriceCache[v126] = v130;
                        end;
                    end;
                    if v124.SelectedPoseId == v125.Id and v124.BuyRobuxBtnLabel then
                        v124.BuyRobuxBtnLabel.Text = "\238\128\130 " .. v130;
                    end;
                end);
                return;
            end;
        end;
    end;
end;
v6.SelectPose = function(v132, v133) --[[ Line: 716 ]] --[[ Name: SelectPose ]]
    local v134 = v132.EntryMap[v133];
    if not v134 then
        return;
    else
        if v132.SelectedEntry and v132.SelectedEntry ~= v134.Frame then
            v132:_setEntrySelected(v132.SelectedEntry, false);
        end;
        v132.SelectedPoseId = v133;
        v132.SelectedEntry = v134.Frame;
        v132:_setEntrySelected(v134.Frame, true);
        if v132.TitleLabel then
            v132.TitleLabel.Visible = true;
            v132.TitleLabel.Text = v134.PoseData.DisplayName or "Poses";
        end;
        if v132.TopFrame and v132.TopFrame:IsA("GuiObject") then
            v132.TopFrame.Visible = true;
        end;
        v132:_playPoseOnInventoryRig(v134.PoseData);
        v132:_updateActionButtonsForPose(v134.PoseData);
        v132:_refreshAllEntryStates();
        return;
    end;
end;
v6._bindPoseData = function(v135) --[[ Line: 745 ]] --[[ Name: _bindPoseData ]]
    v135:_requestPoseDataRefresh();
    v135.PoseDataConn = v135.PoseService.PoseDataUpdated:Connect(function(v136) --[[ Line: 748 ]]
        -- upvalues: v135 (copy)
        if typeof(v136) ~= "table" then
            return;
        else
            v135.PoseData = v136;
            v135:_refreshAllEntryStates();
            v135:_refreshTopFrameActionState();
            return;
        end;
    end);
end;
v6._requestPoseDataRefresh = function(v137) --[[ Line: 759 ]] --[[ Name: _requestPoseDataRefresh ]]
    if not v137.PoseService then
        return;
    else
        local l_PoseData_0 = v137.PoseService:GetPoseData();
        if not l_PoseData_0 or typeof(l_PoseData_0.andThen) ~= "function" then
            return;
        else
            l_PoseData_0:andThen(function(v139) --[[ Line: 770 ]]
                -- upvalues: v137 (copy)
                if typeof(v139) ~= "table" then
                    return;
                else
                    v137.PoseData = v139;
                    v137:_refreshAllEntryStates();
                    v137:_refreshTopFrameActionState();
                    return;
                end;
            end):catch(function(v140) --[[ Line: 779 ]]
                warn("[InventoryPosePanel] GetPoseData failed:", v140);
            end);
            return;
        end;
    end;
end;
v6._playerOwnsPose = function(v141, v142) --[[ Line: 784 ]] --[[ Name: _playerOwnsPose ]]
    local v143 = v141.PoseData and v141.PoseData.OwnedPoses;
    if typeof(v143) ~= "table" then
        return false;
    else
        return v143[v142] == true;
    end;
end;
v6._playerOwnsSelectedPose = function(v144) --[[ Line: 793 ]] --[[ Name: _playerOwnsSelectedPose ]]
    if not v144.SelectedPoseId then
        return false;
    else
        return v144:_playerOwnsPose(v144.SelectedPoseId);
    end;
end;
v6._poseIsEquipped = function(v145, v146) --[[ Line: 801 ]] --[[ Name: _poseIsEquipped ]]
    return (v145.PoseData and v145.PoseData.EquippedPose or "") == v146;
end;
v6._selectedPoseIsEquipped = function(v147) --[[ Line: 805 ]] --[[ Name: _selectedPoseIsEquipped ]]
    if not v147.SelectedPoseId then
        return false;
    else
        return v147:_poseIsEquipped(v147.SelectedPoseId);
    end;
end;
v6._refreshEntryState = function(v148, v149) --[[ Line: 813 ]] --[[ Name: _refreshEntryState ]]
    local v150 = v148.EntryMap[v149];
    if not v150 then
        return;
    else
        local l_Frame_0 = v150.Frame;
        local v152 = v148:_playerOwnsPose(v149);
        local v153 = v148:_poseIsEquipped(v149);
        local l_l_Frame_0_FirstChild_0 = l_Frame_0:FindFirstChild("isLocked", true);
        if l_l_Frame_0_FirstChild_0 and l_l_Frame_0_FirstChild_0:IsA("GuiObject") then
            l_l_Frame_0_FirstChild_0.Visible = not v152;
        end;
        local l_l_Frame_0_FirstChild_1 = l_Frame_0:FindFirstChild("isEquipped", true);
        if l_l_Frame_0_FirstChild_1 and l_l_Frame_0_FirstChild_1:IsA("GuiObject") then
            l_l_Frame_0_FirstChild_1.Visible = v153;
        end;
        return;
    end;
end;
v6._refreshAllEntryStates = function(v156) --[[ Line: 834 ]] --[[ Name: _refreshAllEntryStates ]]
    for v157, _ in pairs(v156.EntryMap) do
        v156:_refreshEntryState(v157);
    end;
end;
v6._refreshTopFrameActionState = function(v159) --[[ Line: 840 ]] --[[ Name: _refreshTopFrameActionState ]]
    -- upvalues: l_PoseConfig_0 (copy), v4 (copy)
    if not v159.SelectedPoseId then
        if v159.BuyBtn then
            v159.BuyBtn.Visible = false;
        end;
        if v159.BuyRobuxBtn then
            v159.BuyRobuxBtn.Visible = false;
        end;
        if v159.EquipBtn then
            v159.EquipBtn.Visible = false;
        end;
        if v159.UnequipBtn then
            v159.UnequipBtn.Visible = false;
        end;
        return;
    else
        local v160 = v159.EntryMap[v159.SelectedPoseId];
        local v161 = v160 and v160.PoseData;
        local v162 = v159:_playerOwnsSelectedPose();
        local v163 = v159:_selectedPoseIsEquipped();
        local v164 = v161 and l_PoseConfig_0.GetRebirthPrice(v161.Id) or nil;
        local v165 = v161 and l_PoseConfig_0.GetProductId(v161.Id) or nil;
        local v166 = v159:_getUnlockType(v161);
        local v167 = v164 and v4.Normalize(v164) or nil;
        local v168 = false;
        if v167 ~= nil then
            v168 = not v4.IsZero(v167);
        end;
        local v169 = false;
        if typeof(v165) == "number" then
            v169 = v165 > 0;
        end;
        local v170 = v166 == "Pack";
        if v159.TopFrame and v159.TopFrame:IsA("GuiObject") then
            v159.TopFrame.Visible = true;
        end;
        if v162 then
            if v159.BuyBtn then
                v159.BuyBtn.Visible = false;
            end;
            if v159.BuyRobuxBtn then
                v159.BuyRobuxBtn.Visible = false;
            end;
            if v159.EquipBtn then
                v159.EquipBtn.Visible = not v163;
            end;
            if v159.UnequipBtn then
                v159.UnequipBtn.Visible = v163;
            end;
            return;
        else
            if v159.EquipBtn then
                v159.EquipBtn.Visible = false;
            end;
            if v159.UnequipBtn then
                v159.UnequipBtn.Visible = false;
            end;
            if v170 then
                if v159.BuyBtn then
                    v159.BuyBtn.Visible = false;
                end;
                if v159.BuyRobuxBtn then
                    v159.BuyRobuxBtn.Visible = false;
                end;
                return;
            else
                if v159.BuyBtn then
                    v159.BuyBtn.Visible = v168;
                end;
                if v159.BuyRobuxBtn then
                    v159.BuyRobuxBtn.Visible = v169;
                end;
                return;
            end;
        end;
    end;
end;
return v6;