-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Knit_0 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"));
local l_Ranked_0 = require(l_ReplicatedStorage_0:WaitForChild("Ranked"));
local l_RankAuraUtil_0 = require(l_ReplicatedStorage_0:WaitForChild("Modules"):WaitForChild("RankAuraUtil"));
local l_AuraCore_0 = require(l_ReplicatedStorage_0:WaitForChild("Modules"):WaitForChild("AuraCore"));
local v5 = require(l_ReplicatedStorage_0.Frameworks.Notifications);
local v6 = {};
v6.__index = v6;
local v7 = Color3.new(1, 1, 1);
local function _(v8) --[[ Line: 17 ]] --[[ Name: makeEntryKey ]]
    if v8.EntryKey and type(v8.EntryKey) == "string" and v8.EntryKey ~= "" then
        return v8.EntryKey;
    elseif v8.EntryType == "Rank" then
        return "Rank:" .. tostring(v8.RankIndex);
    else
        return "PackTitle:" .. tostring(v8.TitleId);
    end;
end;
v6.new = function(v10, v11) --[[ Line: 29 ]] --[[ Name: new ]]
    -- upvalues: v6 (copy)
    local v12 = setmetatable({}, v6);
    v12.Container = v10;
    v12.InventoryRoomController = v11;
    v12.Template = v10:WaitForChild("Template");
    v12.RankTitleService = nil;
    v12.EntryMap = {};
    v12.EntryConnections = {};
    v12.LayoutConn = nil;
    v12.RankTitleDataConn = nil;
    v12.SelectedEntryKey = nil;
    v12.SelectedEntry = nil;
    v12.ActivePreviewBillboard = nil;
    v12.ActivePreviewAura = nil;
    v12.RankTitleData = {
        UnlockedRankIndex = 1, 
        EquippedRankIndex = 0, 
        EffectiveRankIndex = 1, 
        DisplayRankIndex = 1, 
        EquippedPackTitleId = "", 
        Entries = {}
    };
    return v12;
end;
v6.Init = function(v13) --[[ Line: 61 ]] --[[ Name: Init ]]
    -- upvalues: l_Knit_0 (copy), l_AuraCore_0 (copy)
    v13.RankTitleService = l_Knit_0.GetService("RankTitleService");
    if not l_AuraCore_0.IsInitialized() then
        l_AuraCore_0.Init();
    end;
    v13.Template.Visible = false;
    v13:_clearOldEntries();
    v13:_bindLayoutResize();
    v13:_bindRankTitleData();
    v13:_requestRankTitleDataRefresh();
end;
v6.Destroy = function(v14) --[[ Line: 75 ]] --[[ Name: Destroy ]]
    if v14.LayoutConn then
        v14.LayoutConn:Disconnect();
        v14.LayoutConn = nil;
    end;
    if v14.RankTitleDataConn then
        v14.RankTitleDataConn:Disconnect();
        v14.RankTitleDataConn = nil;
    end;
    for _, v16 in pairs(v14.EntryConnections) do
        v16:Disconnect();
    end;
    v14.EntryConnections = {};
    v14.EntryMap = {};
    v14.SelectedEntryKey = nil;
    v14.SelectedEntry = nil;
    v14:_clearRigPreview();
    v14:_clearAuraPreviewFromRig();
end;
v6._requestRankTitleDataRefresh = function(v17) --[[ Line: 99 ]] --[[ Name: _requestRankTitleDataRefresh ]]
    if not v17.RankTitleService then
        return;
    else
        local l_RankTitleData_0 = v17.RankTitleService:GetRankTitleData();
        if not l_RankTitleData_0 or typeof(l_RankTitleData_0.andThen) ~= "function" then
            return;
        else
            l_RankTitleData_0:andThen(function(v19) --[[ Line: 110 ]]
                -- upvalues: v17 (copy)
                if typeof(v19) ~= "table" then
                    return;
                else
                    v17.RankTitleData = v19;
                    v17:_rebuildEntriesFromData();
                    return;
                end;
            end):catch(function(v20) --[[ Line: 118 ]]
                warn("[InventoryTitlesPanel] GetRankTitleData failed:", v20);
            end);
            return;
        end;
    end;
end;
v6._bindRankTitleData = function(v21) --[[ Line: 123 ]] --[[ Name: _bindRankTitleData ]]
    if not v21.RankTitleService or not v21.RankTitleService.RankTitleDataUpdated then
        return;
    else
        v21.RankTitleDataConn = v21.RankTitleService.RankTitleDataUpdated:Connect(function(v22) --[[ Line: 128 ]]
            -- upvalues: v21 (copy)
            if typeof(v22) ~= "table" then
                return;
            else
                v21.RankTitleData = v22;
                v21:_rebuildEntriesFromData();
                return;
            end;
        end);
        return;
    end;
end;
v6._clearOldEntries = function(v23) --[[ Line: 138 ]] --[[ Name: _clearOldEntries ]]
    for _, v25 in ipairs(v23.Container:GetChildren()) do
        if v25 ~= v23.Template and v25:IsA("GuiObject") then
            v25:Destroy();
        end;
    end;
end;
v6._bindLayoutResize = function(v26) --[[ Line: 146 ]] --[[ Name: _bindLayoutResize ]]
    local l_UIListLayout_0 = v26.Container:FindFirstChildOfClass("UIListLayout");
    if not l_UIListLayout_0 then
        return;
    else
        local function v28() --[[ Line: 152 ]] --[[ Name: updateCanvas ]]
            -- upvalues: v26 (copy), l_UIListLayout_0 (copy)
            v26.Container.CanvasSize = UDim2.new(0, 0, 0, l_UIListLayout_0.AbsoluteContentSize.Y + 20);
        end;
        v26.Container.CanvasSize = UDim2.new(0, 0, 0, l_UIListLayout_0.AbsoluteContentSize.Y + 20);
        v26.LayoutConn = l_UIListLayout_0:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(v28);
        return;
    end;
end;
v6._rebuildEntriesFromData = function(v29) --[[ Line: 160 ]] --[[ Name: _rebuildEntriesFromData ]]
    v29:_clearOldEntries();
    for _, v31 in pairs(v29.EntryConnections) do
        v31:Disconnect();
    end;
    v29.EntryConnections = {};
    v29.EntryMap = {};
    local v32 = v29.RankTitleData and v29.RankTitleData.Entries;
    if typeof(v32) ~= "table" then
        return;
    else
        for _, v34 in ipairs(v32) do
            local v35 = v29:_createTitleEntry(v34);
            if v35 then
                local v36 = if v34.EntryKey and type(v34.EntryKey) == "string" and v34.EntryKey ~= "" then v34.EntryKey else if v34.EntryType == "Rank" then "Rank:" .. tostring(v34.RankIndex) else "PackTitle:" .. tostring(v34.TitleId);
                v29.EntryMap[v36] = {
                    Frame = v35, 
                    TitleData = v34
                };
            end;
        end;
        local l_SelectedEntryKey_0 = v29.SelectedEntryKey;
        if l_SelectedEntryKey_0 and v29.EntryMap[l_SelectedEntryKey_0] then
            v29:SelectEntry(l_SelectedEntryKey_0);
            return;
        else
            local v38 = nil;
            for _, v40 in ipairs(v32) do
                if v40.Equipped == true or v40.IsDefaultDisplay == true then
                    v38 = if v40.EntryKey and type(v40.EntryKey) == "string" and v40.EntryKey ~= "" then v40.EntryKey else if v40.EntryType == "Rank" then "Rank:" .. tostring(v40.RankIndex) else "PackTitle:" .. tostring(v40.TitleId);
                    break;
                end;
            end;
            if v38 and v29.EntryMap[v38] then
                v29:SelectEntry(v38);
                return;
            else
                if v32[1] then
                    local v41 = v32[1];
                    local v42 = if v41.EntryKey and type(v41.EntryKey) == "string" and v41.EntryKey ~= "" then v41.EntryKey else if v41.EntryType == "Rank" then "Rank:" .. tostring(v41.RankIndex) else "PackTitle:" .. tostring(v41.TitleId);
                    if v29.EntryMap[v42] then
                        v29:SelectEntry(v42);
                    end;
                end;
                return;
            end;
        end;
    end;
end;
v6._createTitleEntry = function(v43, v44) --[[ Line: 209 ]] --[[ Name: _createTitleEntry ]]
    local v45 = v43.Template:Clone();
    v45.Name = tostring(v44.Name or v44.TitleId or v44.RankIndex or "Title");
    v45.Visible = true;
    v45.Parent = v43.Container;
    local l_v45_FirstChild_0 = v45:FindFirstChild("TitleName", true);
    local l_v45_FirstChild_1 = v45:FindFirstChild("TitleImage", true);
    v43:_applyTitleDisplayStyle(l_v45_FirstChild_0 and l_v45_FirstChild_0:IsA("TextLabel") and l_v45_FirstChild_0 or nil, l_v45_FirstChild_1 and l_v45_FirstChild_1:IsA("ImageLabel") and l_v45_FirstChild_1 or nil, v44);
    v43:_setEntrySelected(v45, false);
    v43:_refreshEntryButtons(v45, v44);
    v43:_bindEntryButtons(v45, v44);
    return v45;
end;
v6._applyTitleDisplayStyle = function(_, v49, v50, v51) --[[ Line: 230 ]] --[[ Name: _applyTitleDisplayStyle ]]
    -- upvalues: l_Ranked_0 (copy)
    local v52 = v51.TemplateName or v51.Name or "";
    local v53 = v51.Name or "";
    if l_Ranked_0.ApplyRankDisplay(v52, v49, v50) == "Text" and v49 then
        v49.Text = v53;
    end;
end;
v6._bindEntryButtons = function(v54, v55, v56) --[[ Line: 241 ]] --[[ Name: _bindEntryButtons ]]
    local v57 = if v56.EntryKey and type(v56.EntryKey) == "string" and v56.EntryKey ~= "" then v56.EntryKey else if v56.EntryType == "Rank" then "Rank:" .. tostring(v56.RankIndex) else "PackTitle:" .. tostring(v56.TitleId);
    local l_v55_FirstChild_0 = v55:FindFirstChild("EquipBtn", true);
    local l_v55_FirstChild_1 = v55:FindFirstChild("UnequipBtn", true);
    if l_v55_FirstChild_0 and l_v55_FirstChild_0:IsA("GuiButton") then
        table.insert(v54.EntryConnections, l_v55_FirstChild_0.MouseButton1Click:Connect(function() --[[ Line: 248 ]]
            -- upvalues: v54 (copy), v57 (copy)
            v54:_onEquipClicked(v57);
        end));
    end;
    if l_v55_FirstChild_1 and l_v55_FirstChild_1:IsA("GuiButton") then
        table.insert(v54.EntryConnections, l_v55_FirstChild_1.MouseButton1Click:Connect(function() --[[ Line: 254 ]]
            -- upvalues: v54 (copy), v57 (copy)
            v54:_onUnequipClicked(v57);
        end));
    end;
    local v60 = nil;
    v60 = if v55:IsA("GuiButton") then v55 else v55:FindFirstChildWhichIsA("GuiButton", true);
    if v60 then
        table.insert(v54.EntryConnections, v60.MouseButton1Click:Connect(function() --[[ Line: 268 ]]
            -- upvalues: v54 (copy), v57 (copy)
            v54:SelectEntry(v57);
        end));
    end;
end;
v6._setEntrySelected = function(_, v62, v63) --[[ Line: 274 ]] --[[ Name: _setEntrySelected ]]
    -- upvalues: v7 (copy)
    local l_SelectionStroke_0 = v62:FindFirstChild("SelectionStroke");
    if v63 then
        if not l_SelectionStroke_0 then
            l_SelectionStroke_0 = Instance.new("UIStroke");
            l_SelectionStroke_0.Name = "SelectionStroke";
            l_SelectionStroke_0.Color = v7;
            l_SelectionStroke_0.Thickness = 2;
            l_SelectionStroke_0.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
            l_SelectionStroke_0.Parent = v62;
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
v6.SelectEntry = function(v65, v66) --[[ Line: 295 ]] --[[ Name: SelectEntry ]]
    local v67 = v65.EntryMap[v66];
    if not v67 then
        return;
    else
        if v65.SelectedEntry and v65.SelectedEntry ~= v67.Frame then
            v65:_setEntrySelected(v65.SelectedEntry, false);
        end;
        v65.SelectedEntryKey = v66;
        v65.SelectedEntry = v67.Frame;
        v65:_setEntrySelected(v67.Frame, true);
        local v68 = v65:_findLiveEntryData(v66) or v67.TitleData;
        v65:_applyTitlePreviewToRig(v68);
        v65:_applyAuraPreviewToRig(v68);
        return;
    end;
end;
v6._findLiveEntryData = function(v69, v70) --[[ Line: 314 ]] --[[ Name: _findLiveEntryData ]]
    local v71 = v69.RankTitleData and v69.RankTitleData.Entries;
    if typeof(v71) ~= "table" then
        return nil;
    else
        for _, v73 in ipairs(v71) do
            if (if v73.EntryKey and type(v73.EntryKey) == "string" and v73.EntryKey ~= "" then v73.EntryKey else if v73.EntryType == "Rank" then "Rank:" .. tostring(v73.RankIndex) else "PackTitle:" .. tostring(v73.TitleId)) == v70 then
                return v73;
            end;
        end;
        return nil;
    end;
end;
v6._refreshEntryButtons = function(_, v75, v76) --[[ Line: 329 ]] --[[ Name: _refreshEntryButtons ]]
    local l_v75_FirstChild_0 = v75:FindFirstChild("Locked", true);
    local l_v75_FirstChild_1 = v75:FindFirstChild("EquipBtn", true);
    local l_v75_FirstChild_2 = v75:FindFirstChild("UnequipBtn", true);
    local v80 = v76.Unlocked == true;
    local v81 = v76.Equipped == true;
    local v82 = v76.IsDefaultDisplay == true;
    if l_v75_FirstChild_0 and l_v75_FirstChild_0:IsA("GuiObject") then
        l_v75_FirstChild_0.Visible = not v80;
    end;
    if l_v75_FirstChild_1 and l_v75_FirstChild_1:IsA("GuiObject") then
        l_v75_FirstChild_1.Visible = v80 and not v81 and not v82;
    end;
    if l_v75_FirstChild_2 and l_v75_FirstChild_2:IsA("GuiObject") then
        l_v75_FirstChild_2.Visible = v81;
    end;
end;
v6._onEquipClicked = function(v83, v84) --[[ Line: 351 ]] --[[ Name: _onEquipClicked ]]
    -- upvalues: v5 (copy)
    if not v83.RankTitleService then
        return;
    else
        v83:SelectEntry(v84);
        local v85 = v83:_findLiveEntryData(v84);
        if not v85 then
            v5.New("COULD NOT EQUIP TITLE", "ErrorNotification");
            return;
        else
            local v86 = nil;
            v86 = if v85.EntryType == "Rank" then v83.RankTitleService:EquipRankTitle(v85.RankIndex) else v83.RankTitleService:EquipPackTitle(v85.TitleId);
            if not v86 or typeof(v86.andThen) ~= "function" then
                warn("[InventoryTitlesPanel] Equip title call did not return a promise-like object");
                v5.New("COULD NOT EQUIP TITLE", "ErrorNotification");
                return;
            else
                v86:andThen(function(v87, v88) --[[ Line: 379 ]]
                    -- upvalues: v85 (copy), v5 (ref), v83 (copy), v84 (copy)
                    if v87 then
                        local v89 = v85.Name or v85.TitleId or "TITLE";
                        v5.New("EQUIPPED " .. string.upper(v89), "SuccessNotification");
                        v83.SelectedEntryKey = v84;
                        v83:_requestRankTitleDataRefresh();
                        task.defer(function() --[[ Line: 387 ]]
                            -- upvalues: v83 (ref), v84 (ref)
                            v83:SelectEntry(v84);
                        end);
                        return;
                    elseif v88 == "NotUnlocked" or v88 == "NotOwned" then
                        v5.New("TITLE NOT UNLOCKED", "ErrorNotification");
                        return;
                    else
                        v5.New("COULD NOT EQUIP TITLE", "ErrorNotification");
                        return;
                    end;
                end):catch(function(v90) --[[ Line: 398 ]]
                    -- upvalues: v5 (ref)
                    warn("[InventoryTitlesPanel] Equip title failed:", v90);
                    v5.New("COULD NOT EQUIP TITLE", "ErrorNotification");
                end);
                return;
            end;
        end;
    end;
end;
v6._onUnequipClicked = function(v91, v92) --[[ Line: 404 ]] --[[ Name: _onUnequipClicked ]]
    -- upvalues: v5 (copy)
    if not v91.RankTitleService then
        return;
    else
        v91:SelectEntry(v92);
        local v93 = v91:_findLiveEntryData(v92);
        if not v93 then
            v5.New("COULD NOT UNEQUIP TITLE", "ErrorNotification");
            return;
        else
            local v94 = nil;
            v94 = if v93.EntryType == "Rank" then v91.RankTitleService:UnequipRankTitle() else v91.RankTitleService:UnequipPackTitle();
            if not v94 or typeof(v94.andThen) ~= "function" then
                warn("[InventoryTitlesPanel] Unequip title call did not return a promise-like object");
                v5.New("COULD NOT UNEQUIP TITLE", "ErrorNotification");
                return;
            else
                v94:andThen(function(v95) --[[ Line: 432 ]]
                    -- upvalues: v93 (copy), v5 (ref), v91 (copy)
                    if v95 then
                        if v93.EntryType == "Rank" then
                            v5.New("USING CURRENT RANK TITLE", "SuccessNotification");
                        else
                            v5.New("UNEQUIPPED TITLE", "SuccessNotification");
                        end;
                        v91:_requestRankTitleDataRefresh();
                        task.defer(function() --[[ Line: 442 ]]
                            -- upvalues: v91 (ref)
                            local v96 = v91.RankTitleData and v91.RankTitleData.Entries;
                            if typeof(v96) ~= "table" then
                                return;
                            else
                                for _, v98 in ipairs(v96) do
                                    if v98.IsDefaultDisplay == true or v98.Equipped == true then
                                        local v99 = if v98.EntryKey and type(v98.EntryKey) == "string" and v98.EntryKey ~= "" then v98.EntryKey else if v98.EntryType == "Rank" then "Rank:" .. tostring(v98.RankIndex) else "PackTitle:" .. tostring(v98.TitleId);
                                        v91.SelectedEntryKey = v99;
                                        v91:SelectEntry(v99);
                                        return;
                                    end;
                                end;
                                return;
                            end;
                        end);
                        return;
                    else
                        v5.New("COULD NOT UNEQUIP TITLE", "ErrorNotification");
                        return;
                    end;
                end):catch(function(v100) --[[ Line: 461 ]]
                    -- upvalues: v5 (ref)
                    warn("[InventoryTitlesPanel] Unequip title failed:", v100);
                    v5.New("COULD NOT UNEQUIP TITLE", "ErrorNotification");
                end);
                return;
            end;
        end;
    end;
end;
v6._clearRigPreview = function(v101) --[[ Line: 467 ]] --[[ Name: _clearRigPreview ]]
    local v102 = v101.InventoryRoomController and v101.InventoryRoomController:GetDisplayCharacter();
    if v102 then
        for _, v104 in ipairs(v102:GetDescendants()) do
            if v104.Name == "InventoryTitlePreview" then
                v104:Destroy();
            end;
        end;
    end;
    v101.ActivePreviewBillboard = nil;
end;
v6._getDisplayRig = function(v105) --[[ Line: 480 ]] --[[ Name: _getDisplayRig ]]
    if not v105.InventoryRoomController then
        return nil;
    else
        return v105.InventoryRoomController:GetDisplayCharacter();
    end;
end;
v6._getDisplayRigHead = function(v106) --[[ Line: 488 ]] --[[ Name: _getDisplayRigHead ]]
    local v107 = v106:_getDisplayRig();
    if not v107 then
        return nil;
    else
        local l_Head_0 = v107:FindFirstChild("Head");
        if l_Head_0 and l_Head_0:IsA("BasePart") then
            return l_Head_0;
        else
            return nil;
        end;
    end;
end;
v6._applyTitlePreviewToRig = function(v109, v110) --[[ Line: 502 ]] --[[ Name: _applyTitlePreviewToRig ]]
    -- upvalues: l_Ranked_0 (copy)
    v109:_clearRigPreview();
    local v111 = v109:_getDisplayRigHead();
    if not v111 or not v110 then
        return;
    else
        local l_BillboardGui_0 = Instance.new("BillboardGui");
        l_BillboardGui_0.Name = "InventoryTitlePreview";
        l_BillboardGui_0.Size = UDim2.new(0, 200, 0, 50);
        l_BillboardGui_0.StudsOffset = Vector3.new(0, 2.5, 0, 0);
        l_BillboardGui_0.AlwaysOnTop = true;
        l_BillboardGui_0.Adornee = v111;
        l_BillboardGui_0.Parent = v111;
        local l_TextLabel_0 = Instance.new("TextLabel");
        l_TextLabel_0.Name = "TitleLabel";
        l_TextLabel_0.Size = UDim2.new(1, 0, 1, 0);
        l_TextLabel_0.BackgroundTransparency = 1;
        l_TextLabel_0.TextScaled = true;
        l_TextLabel_0.Font = Enum.Font.GothamBold;
        l_TextLabel_0.Text = v110.Name or "";
        l_TextLabel_0.Visible = true;
        l_TextLabel_0.Parent = l_BillboardGui_0;
        local l_ImageLabel_0 = Instance.new("ImageLabel");
        l_ImageLabel_0.Name = "TitleImage";
        l_ImageLabel_0.Size = UDim2.new(1, 0, 1, 0);
        l_ImageLabel_0.BackgroundTransparency = 1;
        l_ImageLabel_0.Visible = false;
        l_ImageLabel_0.Parent = l_BillboardGui_0;
        local v115 = v110.TemplateName or v110.Name or "";
        local v116 = v110.Name or "";
        if l_Ranked_0.ApplyRankDisplay(v115, l_TextLabel_0, l_ImageLabel_0) == "Text" then
            l_TextLabel_0.Text = v116;
        end;
        v109.ActivePreviewBillboard = l_BillboardGui_0;
        return;
    end;
end;
v6._canPreviewAura = function(v117) --[[ Line: 546 ]] --[[ Name: _canPreviewAura ]]
    if not v117.InventoryRoomController then
        return false;
    elseif not v117.InventoryRoomController.IsOpen then
        return false;
    else
        return v117.InventoryRoomController:GetDisplayCharacter() ~= nil;
    end;
end;
v6._clearAuraPreviewFromRig = function(v118) --[[ Line: 559 ]] --[[ Name: _clearAuraPreviewFromRig ]]
    -- upvalues: l_AuraCore_0 (copy)
    local v119 = v118:_getDisplayRig();
    if v119 then
        l_AuraCore_0.DisableAuraFromModel(v119, "InventoryActiveAura");
    end;
    v118.ActivePreviewAura = nil;
end;
v6._applyAuraPreviewToRig = function(v120, v121) --[[ Line: 568 ]] --[[ Name: _applyAuraPreviewToRig ]]
    -- upvalues: l_RankAuraUtil_0 (copy), l_AuraCore_0 (copy)
    if not v120:_canPreviewAura() then
        return;
    else
        local v122 = v120:_getDisplayRig();
        if not v122 or not v121 then
            return;
        else
            local v123 = v121.AuraKey or v121.EntryType == "Rank" and v121.RankIndex and l_RankAuraUtil_0.GetAuraKeyForRankIndex(v121.RankIndex);
            if not v123 or v123 == "" then
                v120:_clearAuraPreviewFromRig();
                return;
            else
                v120:_clearAuraPreviewFromRig();
                if not l_AuraCore_0.EnableAuraOnModel(v122, v123, "InventoryActiveAura") then
                    v120.ActivePreviewAura = nil;
                    return;
                else
                    v120.ActivePreviewAura = v123;
                    return;
                end;
            end;
        end;
    end;
end;
return v6;