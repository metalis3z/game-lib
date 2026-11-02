-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Knit_0 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"));
local l_Ranked_0 = require(l_ReplicatedStorage_0:WaitForChild("Ranked"));
local v3 = require(l_ReplicatedStorage_0.Frameworks.Notifications);
local v4 = {};
v4.__index = v4;
v4.new = function(v5) --[[ Line: 11 ]] --[[ Name: new ]]
    -- upvalues: v4 (copy)
    local v6 = setmetatable({}, v4);
    v6.Frame = v5;
    v6.Container = v5:WaitForChild("Container");
    v6.Template = v6.Container:WaitForChild("Template");
    v6.RankTitleService = nil;
    v6.EntryMap = {};
    v6.EntryConnections = {};
    v6.LayoutConn = nil;
    v6.RankTitleDataConn = nil;
    v6.SelectedRankIndex = nil;
    v6.SelectedEntry = nil;
    v6.RankTitleData = {
        UnlockedRankIndex = 1, 
        EquippedRankIndex = 0, 
        EffectiveRankIndex = 1, 
        DisplayRankIndex = 1, 
        Ranks = {}
    };
    return v6;
end;
v4.Init = function(v7) --[[ Line: 38 ]] --[[ Name: Init ]]
    -- upvalues: l_Knit_0 (copy)
    v7.RankTitleService = l_Knit_0.GetService("RankTitleService");
    v7.Template.Visible = false;
    v7:_clearOldEntries();
    v7:_bindLayoutResize();
    v7:_bindRankTitleData();
    v7:_requestRankTitleDataRefresh();
end;
v4.Destroy = function(v8) --[[ Line: 49 ]] --[[ Name: Destroy ]]
    if v8.LayoutConn then
        v8.LayoutConn:Disconnect();
        v8.LayoutConn = nil;
    end;
    if v8.RankTitleDataConn then
        v8.RankTitleDataConn:Disconnect();
        v8.RankTitleDataConn = nil;
    end;
    for _, v10 in pairs(v8.EntryConnections) do
        v10:Disconnect();
    end;
    v8.EntryConnections = {};
    v8.EntryMap = {};
    v8.SelectedRankIndex = nil;
    v8.SelectedEntry = nil;
end;
v4._requestRankTitleDataRefresh = function(v11) --[[ Line: 70 ]] --[[ Name: _requestRankTitleDataRefresh ]]
    if not v11.RankTitleService then
        return;
    else
        local l_RankTitleData_0 = v11.RankTitleService:GetRankTitleData();
        if not l_RankTitleData_0 or typeof(l_RankTitleData_0.andThen) ~= "function" then
            return;
        else
            l_RankTitleData_0:andThen(function(v13) --[[ Line: 81 ]]
                -- upvalues: v11 (copy)
                if typeof(v13) ~= "table" then
                    return;
                else
                    v11.RankTitleData = v13;
                    v11:_rebuildEntriesFromData();
                    return;
                end;
            end):catch(function(v14) --[[ Line: 89 ]]
                warn("[TitlesFrame] GetRankTitleData failed:", v14);
            end);
            return;
        end;
    end;
end;
v4._bindRankTitleData = function(v15) --[[ Line: 94 ]] --[[ Name: _bindRankTitleData ]]
    if not v15.RankTitleService or not v15.RankTitleService.RankTitleDataUpdated then
        return;
    else
        v15.RankTitleDataConn = v15.RankTitleService.RankTitleDataUpdated:Connect(function(v16) --[[ Line: 99 ]]
            -- upvalues: v15 (copy)
            if typeof(v16) ~= "table" then
                return;
            else
                v15.RankTitleData = v16;
                v15:_rebuildEntriesFromData();
                return;
            end;
        end);
        return;
    end;
end;
v4._clearOldEntries = function(v17) --[[ Line: 109 ]] --[[ Name: _clearOldEntries ]]
    for _, v19 in ipairs(v17.Container:GetChildren()) do
        if v19 ~= v17.Template and v19:IsA("GuiObject") then
            v19:Destroy();
        end;
    end;
end;
v4._bindLayoutResize = function(v20) --[[ Line: 117 ]] --[[ Name: _bindLayoutResize ]]
    local l_UIListLayout_0 = v20.Container:FindFirstChildOfClass("UIListLayout");
    if not l_UIListLayout_0 then
        return;
    else
        local function v22() --[[ Line: 123 ]] --[[ Name: updateCanvas ]]
            -- upvalues: v20 (copy), l_UIListLayout_0 (copy)
            v20.Container.CanvasSize = UDim2.new(0, 0, 0, l_UIListLayout_0.AbsoluteContentSize.Y + 20);
        end;
        v20.Container.CanvasSize = UDim2.new(0, 0, 0, l_UIListLayout_0.AbsoluteContentSize.Y + 20);
        v20.LayoutConn = l_UIListLayout_0:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(v22);
        return;
    end;
end;
v4._rebuildEntriesFromData = function(v23) --[[ Line: 131 ]] --[[ Name: _rebuildEntriesFromData ]]
    v23:_clearOldEntries();
    for _, v25 in pairs(v23.EntryConnections) do
        v25:Disconnect();
    end;
    v23.EntryConnections = {};
    v23.EntryMap = {};
    local v26 = v23.RankTitleData and v23.RankTitleData.Ranks;
    if typeof(v26) ~= "table" then
        return;
    else
        for _, v28 in ipairs(v26) do
            local v29 = v23:_createRankEntry(v28);
            if v29 then
                v23.EntryMap[v28.Index] = {
                    Frame = v29, 
                    RankData = v28
                };
            end;
        end;
        local l_SelectedRankIndex_0 = v23.SelectedRankIndex;
        if l_SelectedRankIndex_0 and v23.EntryMap[l_SelectedRankIndex_0] then
            v23:_selectRank(l_SelectedRankIndex_0);
            return;
        else
            local l_DisplayRankIndex_0 = v23.RankTitleData.DisplayRankIndex;
            if typeof(l_DisplayRankIndex_0) == "number" and v23.EntryMap[l_DisplayRankIndex_0] then
                v23:_selectRank(l_DisplayRankIndex_0);
                return;
            else
                if v26[1] and v26[1].Index then
                    v23:_selectRank(v26[1].Index);
                end;
                return;
            end;
        end;
    end;
end;
v4._createRankEntry = function(v32, v33) --[[ Line: 168 ]] --[[ Name: _createRankEntry ]]
    local v34 = v32.Template:Clone();
    v34.Name = tostring(v33.Name or v33.Index);
    v34.Visible = true;
    v34.Parent = v32.Container;
    local l_TitleName_0 = v34:FindFirstChild("TitleName");
    if l_TitleName_0 and l_TitleName_0:IsA("TextLabel") then
        v32:_applyRankLabelStyle(l_TitleName_0, v33.Name);
    end;
    v32:_setEntrySelected(v34, false);
    v32:_refreshEntryButtons(v34, v33);
    v32:_bindEntryButtons(v34, v33);
    return v34;
end;
v4._applyRankLabelStyle = function(_, v37, v38) --[[ Line: 186 ]] --[[ Name: _applyRankLabelStyle ]]
    -- upvalues: l_ReplicatedStorage_0 (copy), l_Ranked_0 (copy)
    v37.Text = v38 or "";
    local l_Assets_0 = l_ReplicatedStorage_0:FindFirstChild("Assets");
    if not l_Assets_0 then
        return;
    else
        l_Assets_0 = l_Assets_0:FindFirstChild("RankTexts");
        if not l_Assets_0 then
            return;
        else
            local l_l_Assets_0_FirstChild_0 = l_Assets_0:FindFirstChild(v38);
            if l_l_Assets_0_FirstChild_0 and l_l_Assets_0_FirstChild_0:IsA("TextLabel") then
                l_Ranked_0.MimicTextLabel(v37, l_l_Assets_0_FirstChild_0, true);
            end;
            return;
        end;
    end;
end;
v4._bindEntryButtons = function(v41, v42, v43) --[[ Line: 205 ]] --[[ Name: _bindEntryButtons ]]
    local l_EquipBtn_0 = v42:FindFirstChild("EquipBtn");
    local l_UnequipBtn_0 = v42:FindFirstChild("UnequipBtn");
    if l_EquipBtn_0 and l_EquipBtn_0:IsA("GuiButton") then
        table.insert(v41.EntryConnections, l_EquipBtn_0.MouseButton1Click:Connect(function() --[[ Line: 210 ]]
            -- upvalues: v41 (copy), v43 (copy)
            v41:_onEquipClicked(v43.Index);
        end));
    end;
    if l_UnequipBtn_0 and l_UnequipBtn_0:IsA("GuiButton") then
        table.insert(v41.EntryConnections, l_UnequipBtn_0.MouseButton1Click:Connect(function() --[[ Line: 216 ]]
            -- upvalues: v41 (copy), v43 (copy)
            v41:_onUnequipClicked(v43.Index);
        end));
    end;
    local v46 = nil;
    v46 = if v42:IsA("GuiButton") then v42 else v42:FindFirstChildWhichIsA("GuiButton", true);
    if v46 then
        table.insert(v41.EntryConnections, v46.MouseButton1Click:Connect(function() --[[ Line: 230 ]]
            -- upvalues: v41 (copy), v43 (copy)
            v41:_selectRank(v43.Index);
        end));
    end;
end;
v4._setEntrySelected = function(_, _, _) --[[ Line: 236 ]] --[[ Name: _setEntrySelected ]]

end;
v4._selectRank = function(v50, v51) --[[ Line: 239 ]] --[[ Name: _selectRank ]]
    local v52 = v50.EntryMap[v51];
    if not v52 then
        return;
    else
        if v50.SelectedEntry and v50.SelectedEntry ~= v52.Frame then
            v50:_setEntrySelected(v50.SelectedEntry, false);
        end;
        v50.SelectedRankIndex = v51;
        v50.SelectedEntry = v52.Frame;
        v50:_setEntrySelected(v52.Frame, true);
        return;
    end;
end;
v4._findLiveRankData = function(v53, v54) --[[ Line: 254 ]] --[[ Name: _findLiveRankData ]]
    local v55 = v53.RankTitleData and v53.RankTitleData.Ranks;
    if typeof(v55) ~= "table" then
        return nil;
    else
        for _, v57 in ipairs(v55) do
            if v57.Index == v54 then
                return v57;
            end;
        end;
        return nil;
    end;
end;
v4._refreshEntryButtons = function(_, v59, v60) --[[ Line: 269 ]] --[[ Name: _refreshEntryButtons ]]
    local l_Locked_0 = v59:FindFirstChild("Locked");
    local l_EquipBtn_1 = v59:FindFirstChild("EquipBtn");
    local l_UnequipBtn_1 = v59:FindFirstChild("UnequipBtn");
    local v64 = v60.Unlocked == true;
    local v65 = v60.Equipped == true;
    local v66 = v60.IsDefaultDisplay == true;
    if l_Locked_0 and l_Locked_0:IsA("GuiObject") then
        l_Locked_0.Visible = not v64;
    end;
    if l_EquipBtn_1 and l_EquipBtn_1:IsA("GuiObject") then
        l_EquipBtn_1.Visible = v64 and not v65 and not v66;
    end;
    if l_UnequipBtn_1 and l_UnequipBtn_1:IsA("GuiObject") then
        l_UnequipBtn_1.Visible = v65;
    end;
end;
v4._onEquipClicked = function(v67, v68) --[[ Line: 291 ]] --[[ Name: _onEquipClicked ]]
    -- upvalues: v3 (copy)
    if not v67.RankTitleService then
        return;
    else
        local v69 = v67.RankTitleService:EquipRankTitle(v68);
        if not v69 or typeof(v69.andThen) ~= "function" then
            warn("[TitlesFrame] EquipRankTitle did not return a promise-like object");
            v3.New("COULD NOT EQUIP TITLE", "ErrorNotification");
            return;
        else
            v69:andThen(function(v70, v71) --[[ Line: 304 ]]
                -- upvalues: v67 (copy), v68 (copy), v3 (ref)
                if v70 then
                    local v72 = v67:_findLiveRankData(v68);
                    local v73 = v72 and v72.Name or "RANK " .. tostring(v68);
                    v3.New("EQUIPPED " .. string.upper(v73), "SuccessNotification");
                    v67:_requestRankTitleDataRefresh();
                    return;
                elseif v71 == "NotUnlocked" then
                    v3.New("TITLE NOT UNLOCKED", "ErrorNotification");
                    return;
                else
                    v3.New("COULD NOT EQUIP TITLE", "ErrorNotification");
                    return;
                end;
            end):catch(function(v74) --[[ Line: 318 ]]
                -- upvalues: v3 (ref)
                warn("[TitlesFrame] EquipRankTitle failed:", v74);
                v3.New("COULD NOT EQUIP TITLE", "ErrorNotification");
            end);
            return;
        end;
    end;
end;
v4._onUnequipClicked = function(v75, _) --[[ Line: 324 ]] --[[ Name: _onUnequipClicked ]]
    -- upvalues: v3 (copy)
    if not v75.RankTitleService then
        return;
    else
        local v77 = v75.RankTitleService:UnequipRankTitle();
        if not v77 or typeof(v77.andThen) ~= "function" then
            warn("[TitlesFrame] UnequipRankTitle did not return a promise-like object");
            v3.New("COULD NOT UNEQUIP TITLE", "ErrorNotification");
            return;
        else
            v77:andThen(function(v78) --[[ Line: 337 ]]
                -- upvalues: v3 (ref), v75 (copy)
                if v78 then
                    v3.New("USING CURRENT RANK TITLE", "SuccessNotification");
                    v75:_requestRankTitleDataRefresh();
                    return;
                else
                    v3.New("COULD NOT UNEQUIP TITLE", "ErrorNotification");
                    return;
                end;
            end):catch(function(v79) --[[ Line: 345 ]]
                -- upvalues: v3 (ref)
                warn("[TitlesFrame] UnequipRankTitle failed:", v79);
                v3.New("COULD NOT UNEQUIP TITLE", "ErrorNotification");
            end);
            return;
        end;
    end;
end;
return v4;