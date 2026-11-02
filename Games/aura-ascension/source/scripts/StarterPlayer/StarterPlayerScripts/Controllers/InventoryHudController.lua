-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Lighting_0 = game:GetService("Lighting");
local l_TweenService_0 = game:GetService("TweenService");
local l_Knit_0 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"));
local l_InventoryPosePanel_0 = require(script.Parent.Parent.Handlers:WaitForChild("InventoryPosePanel"));
local l_InventoryTitlesPanel_0 = require(script.Parent.Parent.Handlers:WaitForChild("InventoryTitlesPanel"));
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v8 = l_Knit_0.CreateController({
    Name = "InventoryHudController"
});
local v9 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
local v10 = TweenInfo.new(0.18, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
v8.KnitInit = function(v11) --[[ Line: 26 ]] --[[ Name: KnitInit ]]
    v11.PlayerGui = nil;
    v11.InventoryHud = nil;
    v11.UIManager = nil;
    v11.InventoryRoomController = nil;
    v11.PlayerService = nil;
    v11.CloseBtn = nil;
    v11.CloseConnection = nil;
    v11.LeftSide = nil;
    v11.MenuBtns = nil;
    v11.PoseBtn = nil;
    v11.TitlesBtn = nil;
    v11.Holder = nil;
    v11.TopFrame = nil;
    v11.TitleName = nil;
    v11.ContentsPoses = nil;
    v11.ContainerTitles = nil;
    v11.PoseButtonConnection = nil;
    v11.TitlesButtonConnection = nil;
    v11.InventoryPosePanel = nil;
    v11.InventoryTitlesPanel = nil;
    v11.ProfileLoadedConn = nil;
    v11.DepthOfField = nil;
    v11.InventoryHudEnabledConn = nil;
end;
v8.KnitStart = function(v12) --[[ Line: 60 ]] --[[ Name: KnitStart ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_Knit_0 (copy), l_InventoryPosePanel_0 (copy), l_InventoryTitlesPanel_0 (copy)
    v12.PlayerGui = l_LocalPlayer_0:WaitForChild("PlayerGui");
    v12.UIManager = l_Knit_0.GetController("UIManager");
    v12.InventoryRoomController = l_Knit_0.GetController("InventoryRoomController");
    v12.PlayerService = l_Knit_0.GetService("PlayerService");
    v12:_grabRefs();
    v12:_setupDepthOfField();
    v12.InventoryPosePanel = l_InventoryPosePanel_0.new(v12.ContentsPoses, v12.TitleName, v12.InventoryRoomController, v12.TopFrame);
    v12.InventoryPosePanel:Init();
    v12.InventoryTitlesPanel = l_InventoryTitlesPanel_0.new(v12.ContainerTitles, v12.InventoryRoomController);
    v12.InventoryTitlesPanel:Init();
    v12:_bindInventoryHudButtons();
    v12:_bindCloseButton();
    v12:_bindPoseButton();
    v12:_bindTitlesButton();
    v12:_bindInventoryHudVisibility();
    v12:_setupDefaultState();
    if v12.PlayerService and v12.PlayerService.ProfileLoaded then
        v12.ProfileLoadedConn = v12.PlayerService.ProfileLoaded:Connect(function() --[[ Line: 92 ]]
            -- upvalues: v12 (copy)
            if v12.InventoryPosePanel then
                v12.InventoryPosePanel:_requestPoseDataRefresh();
            end;
            if v12.InventoryTitlesPanel then
                v12.InventoryTitlesPanel:_requestRankTitleDataRefresh();
            end;
        end);
    end;
    task.defer(function() --[[ Line: 103 ]]
        -- upvalues: v12 (copy)
        if v12.InventoryPosePanel then
            v12.InventoryPosePanel:_requestPoseDataRefresh();
        end;
        if v12.InventoryTitlesPanel then
            v12.InventoryTitlesPanel:_requestRankTitleDataRefresh();
        end;
        v12:_updateDepthOfFieldState();
    end);
end;
v8._grabRefs = function(v13) --[[ Line: 116 ]] --[[ Name: _grabRefs ]]
    v13.InventoryHud = v13.PlayerGui:WaitForChild("InventoryHud");
    v13.LeftSide = v13.InventoryHud:WaitForChild("LeftSide");
    v13.MenuBtns = v13.LeftSide:WaitForChild("MenuBtns");
    v13.PoseBtn = v13.MenuBtns:WaitForChild("PoseBtn");
    v13.TitlesBtn = v13.MenuBtns:WaitForChild("TitlesBtn");
    v13.Holder = v13.InventoryHud:WaitForChild("Holder");
    v13.CloseBtn = v13.Holder:WaitForChild("CloseBtn");
    v13.TitleName = v13.Holder:WaitForChild("TitleName");
    v13.ContentsPoses = v13.Holder:WaitForChild("ContentsPoses");
    v13.ContainerTitles = v13.Holder:WaitForChild("ContainerTitles");
    v13.TopFrame = v13.InventoryHud:WaitForChild("TopFrame");
end;
v8._setupDepthOfField = function(v14) --[[ Line: 133 ]] --[[ Name: _setupDepthOfField ]]
    -- upvalues: l_Lighting_0 (copy)
    local l_InventoryHudDepthOfField_0 = l_Lighting_0:FindFirstChild("InventoryHudDepthOfField");
    if not l_InventoryHudDepthOfField_0 then
        l_InventoryHudDepthOfField_0 = Instance.new("DepthOfFieldEffect");
        l_InventoryHudDepthOfField_0.Name = "InventoryHudDepthOfField";
        l_InventoryHudDepthOfField_0.Enabled = false;
        l_InventoryHudDepthOfField_0.FarIntensity = 0;
        l_InventoryHudDepthOfField_0.NearIntensity = 0;
        l_InventoryHudDepthOfField_0.InFocusRadius = 18;
        l_InventoryHudDepthOfField_0.FocusDistance = 12;
        l_InventoryHudDepthOfField_0.Parent = l_Lighting_0;
    end;
    v14.DepthOfField = l_InventoryHudDepthOfField_0;
end;
v8._enableDepthOfField = function(v16) --[[ Line: 149 ]] --[[ Name: _enableDepthOfField ]]
    -- upvalues: l_TweenService_0 (copy), v9 (copy)
    if not v16.DepthOfField then
        return;
    else
        v16.DepthOfField.Enabled = true;
        l_TweenService_0:Create(v16.DepthOfField, v9, {
            FarIntensity = 0.35, 
            NearIntensity = 0.2, 
            InFocusRadius = 18, 
            FocusDistance = 12
        }):Play();
        return;
    end;
end;
v8._disableDepthOfField = function(v17) --[[ Line: 164 ]] --[[ Name: _disableDepthOfField ]]
    -- upvalues: l_TweenService_0 (copy), v10 (copy)
    if not v17.DepthOfField then
        return;
    else
        local v18 = l_TweenService_0:Create(v17.DepthOfField, v10, {
            FarIntensity = 0, 
            NearIntensity = 0, 
            InFocusRadius = 18, 
            FocusDistance = 12
        });
        v18:Play();
        v18.Completed:Once(function() --[[ Line: 177 ]]
            -- upvalues: v17 (copy)
            if v17.DepthOfField then
                v17.DepthOfField.Enabled = false;
            end;
        end);
        return;
    end;
end;
v8._updateDepthOfFieldState = function(v19) --[[ Line: 184 ]] --[[ Name: _updateDepthOfFieldState ]]
    if not v19.InventoryHud then
        return;
    elseif v19.InventoryHud.Enabled then
        v19:_enableDepthOfField();
        return;
    else
        v19:_disableDepthOfField();
        return;
    end;
end;
v8._bindInventoryHudVisibility = function(v20) --[[ Line: 196 ]] --[[ Name: _bindInventoryHudVisibility ]]
    if not v20.InventoryHud then
        return;
    else
        if v20.InventoryHudEnabledConn then
            v20.InventoryHudEnabledConn:Disconnect();
            v20.InventoryHudEnabledConn = nil;
        end;
        v20.InventoryHudEnabledConn = v20.InventoryHud:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 206 ]]
            -- upvalues: v20 (copy)
            v20:_updateDepthOfFieldState();
        end);
        return;
    end;
end;
v8._bindInventoryHudButtons = function(v21) --[[ Line: 211 ]] --[[ Name: _bindInventoryHudButtons ]]
    if not v21.InventoryHud or not v21.UIManager then
        return;
    else
        v21.UIManager:WatchRoot(v21.InventoryHud);
        return;
    end;
end;
v8._bindCloseButton = function(v22) --[[ Line: 219 ]] --[[ Name: _bindCloseButton ]]
    if not v22.CloseBtn or not v22.InventoryRoomController then
        return;
    else
        if v22.CloseConnection then
            v22.CloseConnection:Disconnect();
            v22.CloseConnection = nil;
        end;
        v22.CloseConnection = v22.CloseBtn.Activated:Connect(function() --[[ Line: 229 ]]
            -- upvalues: v22 (copy)
            v22.InventoryRoomController:Close();
        end);
        return;
    end;
end;
v8._bindPoseButton = function(v23) --[[ Line: 234 ]] --[[ Name: _bindPoseButton ]]
    if not v23.PoseBtn then
        return;
    else
        if v23.PoseButtonConnection then
            v23.PoseButtonConnection:Disconnect();
            v23.PoseButtonConnection = nil;
        end;
        v23.PoseButtonConnection = v23.PoseBtn.Activated:Connect(function() --[[ Line: 244 ]]
            -- upvalues: v23 (copy)
            v23:OpenPosesPage();
        end);
        return;
    end;
end;
v8._bindTitlesButton = function(v24) --[[ Line: 249 ]] --[[ Name: _bindTitlesButton ]]
    if not v24.TitlesBtn then
        return;
    else
        if v24.TitlesButtonConnection then
            v24.TitlesButtonConnection:Disconnect();
            v24.TitlesButtonConnection = nil;
        end;
        v24.TitlesButtonConnection = v24.TitlesBtn.Activated:Connect(function() --[[ Line: 259 ]]
            -- upvalues: v24 (copy)
            v24:OpenTitlesPage();
        end);
        return;
    end;
end;
v8._hideAllHolderPages = function(v25) --[[ Line: 264 ]] --[[ Name: _hideAllHolderPages ]]
    if not v25.Holder then
        return;
    else
        for _, v27 in ipairs(v25.Holder:GetChildren()) do
            if v27:IsA("ScrollingFrame") then
                v27.Visible = false;
            end;
        end;
        return;
    end;
end;
v8._setPage = function(v28, v29, v30) --[[ Line: 276 ]] --[[ Name: _setPage ]]
    v28:_hideAllHolderPages();
    if v28.TitleName then
        v28.TitleName.Visible = true;
        v28.TitleName.Text = v29;
    end;
    if v30 and v30:IsA("GuiObject") then
        v30.Visible = true;
    end;
end;
v8._setupDefaultState = function(v31) --[[ Line: 289 ]] --[[ Name: _setupDefaultState ]]
    if v31.TopFrame then
        v31.TopFrame.Visible = false;
    end;
    if v31.TitleName then
        v31.TitleName.Visible = false;
        v31.TitleName.Text = "";
    end;
    v31:_hideAllHolderPages();
end;
v8.ShowDefaultPage = function(v32) --[[ Line: 302 ]] --[[ Name: ShowDefaultPage ]]
    v32:OpenPosesPage();
end;
v8.OpenPosesPage = function(v33) --[[ Line: 306 ]] --[[ Name: OpenPosesPage ]]
    v33:_setPage("Poses", v33.ContentsPoses);
    if v33.InventoryPosePanel and v33.InventoryPosePanel.SelectedPoseId then
        v33.InventoryPosePanel:SelectPose(v33.InventoryPosePanel.SelectedPoseId);
        return;
    else
        if v33.InventoryPosePanel then
            v33.InventoryPosePanel:_requestPoseDataRefresh();
        end;
        return;
    end;
end;
v8.OpenTitlesPage = function(v34) --[[ Line: 318 ]] --[[ Name: OpenTitlesPage ]]
    v34:_setPage("Titles", v34.ContainerTitles);
    if v34.TopFrame then
        v34.TopFrame.Visible = false;
    end;
    if v34.InventoryTitlesPanel and v34.InventoryTitlesPanel.SelectedRankIndex then
        v34.InventoryTitlesPanel:SelectRank(v34.InventoryTitlesPanel.SelectedRankIndex);
        return;
    else
        if v34.InventoryTitlesPanel then
            v34.InventoryTitlesPanel:_requestRankTitleDataRefresh();
        end;
        return;
    end;
end;
return v8;