-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("LocalizationService");
local l_UserInputService_0 = game:GetService("UserInputService");
local _ = game:GetService("RunService");
local _ = game:GetService("TextService");
local l_StarterGui_0 = game:GetService("StarterGui");
local l_GuiService_0 = game:GetService("GuiService");
local l_Players_0 = game:GetService("Players");
local l_script_0 = script;
local v8 = require(l_script_0.Reference);
local v9 = v8.getObject();
local v10 = v9 and v9.Value;
if v10 and v10 ~= l_script_0 then
    return require(v10);
else
    if not v9 then
        v8.addToReplicatedStorage();
    end;
    local v11 = require(l_script_0.Packages.GoodSignal);
    local v12 = require(l_script_0.Packages.Janitor);
    local v13 = require(l_script_0.Utility);
    local _ = require(l_script_0.Attribute);
    local v15 = require(l_script_0.Features.Themes);
    local v16 = require(l_script_0.Features.Gamepad);
    local v17 = require(l_script_0.Features.Overflow);
    local v18 = {};
    v18.__index = v18;
    local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
    local l_Themes_0 = l_script_0.Features.Themes;
    local l_PlayerGui_0 = l_LocalPlayer_0:WaitForChild("PlayerGui");
    local v22 = {};
    local v23 = v11.new();
    local l_Elements_0 = l_script_0.Elements;
    local v25 = 0;
    if l_GuiService_0.TopbarInset.Height == 0 then
        l_GuiService_0:GetPropertyChangedSignal("TopbarInset"):Wait();
    end;
    v18.baseDisplayOrderChanged = v11.new();
    v18.baseDisplayOrder = 10;
    v18.baseTheme = require(l_Themes_0.Default);
    v18.isOldTopbar = l_GuiService_0.TopbarInset.Height == 36;
    v18.iconsDictionary = v22;
    v18.container = require(l_Elements_0.Container)(v18);
    v18.topbarEnabled = true;
    v18.iconAdded = v11.new();
    v18.iconRemoved = v11.new();
    v18.iconChanged = v11.new();
    v18.getIcons = function() --[[ Line: 112 ]] --[[ Name: getIcons ]]
        -- upvalues: v18 (copy)
        return v18.iconsDictionary;
    end;
    v18.getIconByUID = function(v26) --[[ Line: 116 ]] --[[ Name: getIconByUID ]]
        -- upvalues: v18 (copy)
        local v27 = v18.iconsDictionary[v26];
        if v27 then
            return v27;
        else
            return;
        end;
    end;
    v18.getIcon = function(v28) --[[ Line: 123 ]] --[[ Name: getIcon ]]
        -- upvalues: v18 (copy), v22 (copy)
        local v29 = v18.getIconByUID(v28);
        if v29 then
            return v29;
        else
            for _, v31 in pairs(v22) do
                if v31.name == v28 then
                    return v31;
                end;
            end;
            return;
        end;
    end;
    v18.setTopbarEnabled = function(v32, v33) --[[ Line: 135 ]] --[[ Name: setTopbarEnabled ]]
        -- upvalues: v18 (copy)
        if typeof(v32) ~= "boolean" then
            v32 = v18.topbarEnabled;
        end;
        if not v33 then
            v18.topbarEnabled = v32;
        end;
        for _, v35 in pairs(v18.container) do
            v35.Enabled = v32;
        end;
    end;
    v18.modifyBaseTheme = function(v36) --[[ Line: 147 ]] --[[ Name: modifyBaseTheme ]]
        -- upvalues: v15 (copy), v18 (copy), v22 (copy)
        v36 = v15.getModifications(v36);
        for _, v38 in pairs(v36) do
            for _, v40 in pairs(v18.baseTheme) do
                v15.merge(v40, v38);
            end;
        end;
        for _, v42 in pairs(v22) do
            v42:setTheme(v18.baseTheme);
        end;
    end;
    v18.setDisplayOrder = function(v43) --[[ Line: 159 ]] --[[ Name: setDisplayOrder ]]
        -- upvalues: v18 (copy)
        v18.baseDisplayOrder = v43;
        v18.baseDisplayOrderChanged:Fire(v43);
    end;
    task.defer(v16.start, v18);
    task.defer(v17.start, v18);
    for _, v45 in pairs(v18.container) do
        v45.Parent = l_PlayerGui_0;
    end;
    if v18.isOldTopbar then
        v18.modifyBaseTheme(require(l_Themes_0.Classic));
    end;
    v18.new = function() --[[ Line: 179 ]] --[[ Name: new ]]
        -- upvalues: v18 (copy), v12 (copy), v13 (copy), v22 (copy), v11 (copy), l_script_0 (copy), l_Elements_0 (copy), v25 (ref), l_UserInputService_0 (copy), v23 (copy), l_StarterGui_0 (copy)
        local v46 = {};
        setmetatable(v46, v18);
        local v47 = v12.new();
        v46.janitor = v47;
        v46.themesJanitor = v47:add(v12.new());
        v46.singleClickJanitor = v47:add(v12.new());
        v46.captionJanitor = v47:add(v12.new());
        v46.joinJanitor = v47:add(v12.new());
        v46.menuJanitor = v47:add(v12.new());
        v46.dropdownJanitor = v47:add(v12.new());
        local v48 = v13.generateUID();
        v22[v48] = v46;
        v47:add(function() --[[ Line: 196 ]]
            -- upvalues: v22 (ref), v48 (copy)
            v22[v48] = nil;
        end);
        v46.selected = v47:add(v11.new());
        v46.deselected = v47:add(v11.new());
        v46.toggled = v47:add(v11.new());
        v46.viewingStarted = v47:add(v11.new());
        v46.viewingEnded = v47:add(v11.new());
        v46.stateChanged = v47:add(v11.new());
        v46.notified = v47:add(v11.new());
        v46.noticeStarted = v47:add(v11.new());
        v46.noticeChanged = v47:add(v11.new());
        v46.endNotices = v47:add(v11.new());
        v46.toggleKeyAdded = v47:add(v11.new());
        v46.fakeToggleKeyChanged = v47:add(v11.new());
        v46.alignmentChanged = v47:add(v11.new());
        v46.updateSize = v47:add(v11.new());
        v46.resizingComplete = v47:add(v11.new());
        v46.joinedParent = v47:add(v11.new());
        v46.menuSet = v47:add(v11.new());
        v46.dropdownSet = v47:add(v11.new());
        v46.updateMenu = v47:add(v11.new());
        v46.startMenuUpdate = v47:add(v11.new());
        v46.childThemeModified = v47:add(v11.new());
        v46.indicatorSet = v47:add(v11.new());
        v46.dropdownChildAdded = v47:add(v11.new());
        v46.menuChildAdded = v47:add(v11.new());
        v46.iconModule = l_script_0;
        v46.UID = v48;
        v46.isEnabled = true;
        v46.isSelected = false;
        v46.isViewing = false;
        v46.joinedFrame = false;
        v46.parentIconUID = false;
        v46.deselectWhenOtherIconSelected = true;
        v46.totalNotices = 0;
        v46.activeState = "Deselected";
        v46.alignment = "";
        v46.originalAlignment = "";
        v46.appliedTheme = {};
        v46.appearance = {};
        v46.cachedInstances = {};
        v46.cachedNamesToInstances = {};
        v46.cachedCollectives = {};
        v46.bindedToggleKeys = {};
        v46.customBehaviours = {};
        v46.toggleItems = {};
        v46.bindedEvents = {};
        v46.notices = {};
        v46.menuIcons = {};
        v46.dropdownIcons = {};
        v46.childIconsDict = {};
        v46.isOldTopbar = v18.isOldTopbar;
        v46.creationTime = os.clock();
        v46.widget = v47:add(require(l_Elements_0.Widget)(v46, v18));
        v46:setAlignment();
        v25 = v25 + 1;
        v46:setOrder(v25);
        v46:setTheme(v18.baseTheme);
        local v49 = v46:getInstance("ClickRegion");
        local function _() --[[ Line: 271 ]] --[[ Name: handleToggle ]]
            -- upvalues: v46 (copy)
            if v46.locked then
                return;
            elseif v46.isSelected then
                v46:deselect("User", v46);
                return;
            else
                v46:select("User", v46);
                return;
            end;
        end;
        local v51 = false;
        local v52 = false;
        v49.MouseButton1Click:Connect(function() --[[ Line: 283 ]]
            -- upvalues: v51 (ref), v52 (ref), v46 (copy)
            if v51 then
                return;
            else
                v52 = true;
                task.delay(0.01, function() --[[ Line: 288 ]]
                    -- upvalues: v52 (ref)
                    v52 = false;
                end);
                if v46.locked then
                    return;
                elseif v46.isSelected then
                    v46:deselect("User", v46);
                    return;
                else
                    v46:select("User", v46);
                    return;
                end;
            end;
        end);
        v49.TouchTap:Connect(function() --[[ Line: 293 ]]
            -- upvalues: v52 (ref), v51 (ref), v46 (copy)
            if v52 then
                return;
            else
                v51 = true;
                task.delay(0.01, function() --[[ Line: 300 ]]
                    -- upvalues: v51 (ref)
                    v51 = false;
                end);
                if v46.locked then
                    return;
                elseif v46.isSelected then
                    v46:deselect("User", v46);
                    return;
                else
                    v46:select("User", v46);
                    return;
                end;
            end;
        end);
        v47:add(l_UserInputService_0.InputBegan:Connect(function(v53, v54) --[[ Line: 307 ]]
            -- upvalues: v46 (copy)
            if v46.locked then
                return;
            else
                if v46.bindedToggleKeys[v53.KeyCode] and not v54 then
                    if v46.locked then
                        return;
                    elseif v46.isSelected then
                        v46:deselect("User", v46);
                        return;
                    else
                        v46:select("User", v46);
                    end;
                end;
                return;
            end;
        end));
        local function v56(v55) --[[ Line: 319 ]] --[[ Name: viewingStarted ]]
            -- upvalues: v46 (copy)
            if v46.locked then
                return;
            else
                v46.isViewing = true;
                v46.viewingStarted:Fire(true);
                if not v55 then
                    v46:setState("Viewing", "User", v46);
                end;
                return;
            end;
        end;
        local function v57() --[[ Line: 329 ]] --[[ Name: viewingEnded ]]
            -- upvalues: v46 (copy)
            if v46.locked then
                return;
            else
                v46.isViewing = false;
                v46.viewingEnded:Fire(true);
                v46:setState(nil, "User", v46);
                return;
            end;
        end;
        v46.joinedParent:Connect(function() --[[ Line: 337 ]]
            -- upvalues: v46 (copy)
            if v46.isViewing then
                if v46.locked then
                    return;
                else
                    v46.isViewing = false;
                    v46.viewingEnded:Fire(true);
                    v46:setState(nil, "User", v46);
                end;
            end;
        end);
        v49.MouseEnter:Connect(function() --[[ Line: 342 ]]
            -- upvalues: l_UserInputService_0 (ref), v46 (copy)
            local v58 = not l_UserInputService_0.KeyboardEnabled;
            if v46.locked then
                return;
            else
                v46.isViewing = true;
                v46.viewingStarted:Fire(true);
                if not v58 then
                    v46:setState("Viewing", "User", v46);
                end;
                return;
            end;
        end);
        local v59 = 0;
        v47:add(l_UserInputService_0.TouchEnded:Connect(v57));
        v49.MouseLeave:Connect(v57);
        v49.SelectionGained:Connect(v56);
        v49.SelectionLost:Connect(v57);
        v49.MouseButton1Down:Connect(function() --[[ Line: 351 ]]
            -- upvalues: v46 (copy), l_UserInputService_0 (ref), v59 (ref)
            if not v46.locked and l_UserInputService_0.TouchEnabled then
                v59 = v59 + 1;
                local l_v59_0 = v59;
                task.delay(0.2, function() --[[ Line: 355 ]]
                    -- upvalues: l_v59_0 (copy), v59 (ref), v46 (ref)
                    if l_v59_0 == v59 then
                        if v46.locked then
                            return;
                        else
                            v46.isViewing = true;
                            v46.viewingStarted:Fire(true);
                            v46:setState("Viewing", "User", v46);
                        end;
                    end;
                end);
            end;
        end);
        v49.MouseButton1Up:Connect(function() --[[ Line: 362 ]]
            -- upvalues: v59 (ref)
            v59 = v59 + 1;
        end);
        local v61 = v46:getInstance("IconOverlay");
        v46.viewingStarted:Connect(function() --[[ Line: 368 ]]
            -- upvalues: v61 (copy), v46 (copy)
            v61.Visible = not v46.overlayDisabled;
        end);
        v46.viewingEnded:Connect(function() --[[ Line: 371 ]]
            -- upvalues: v61 (copy)
            v61.Visible = false;
        end);
        v47:add(v23:Connect(function(v62) --[[ Line: 376 ]]
            -- upvalues: v46 (copy)
            if v62 ~= v46 and v46.deselectWhenOtherIconSelected and v62.deselectWhenOtherIconSelected then
                v46:deselect("AutoDeselect", v62);
            end;
        end));
        local v63 = debug.info(2, "s");
        local v64 = string.split(v63, ".");
        local l_game_0 = game;
        local v66 = nil;
        for _, v68 in pairs(v64) do
            l_game_0 = l_game_0:FindFirstChild(v68);
            if l_game_0 then
                if l_game_0:IsA("ScreenGui") then
                    v66 = l_game_0;
                end;
            else
                break;
            end;
        end;
        if l_game_0 and v66 and v66.ResetOnSpawn == true then
            v13.localPlayerRespawned(function() --[[ Line: 401 ]]
                -- upvalues: v46 (copy)
                v46:destroy();
            end);
        end;
        local _ = v46:getInstance("NoticeLabel");
        v46.toggled:Connect(function(v70) --[[ Line: 408 ]]
            -- upvalues: v46 (copy), v18 (ref)
            v46.noticeChanged:Fire(v46.totalNotices);
            for v71, _ in pairs(v46.childIconsDict) do
                local v73 = v18.getIconByUID(v71);
                v73.noticeChanged:Fire(v73.totalNotices);
                if not v70 and v73.isSelected then
                    for _, _ in pairs(v73.childIconsDict) do
                        v73:deselect("HideParentFeature", v46);
                    end;
                end;
            end;
        end);
        v46.selected:Connect(function() --[[ Line: 431 ]]
            -- upvalues: v46 (copy), l_StarterGui_0 (ref)
            if #v46.dropdownIcons > 0 then
                if l_StarterGui_0:GetCore("ChatActive") and v46.alignment ~= "Right" then
                    v46.chatWasPreviouslyActive = true;
                    l_StarterGui_0:SetCore("ChatActive", false);
                end;
                if l_StarterGui_0:GetCoreGuiEnabled("PlayerList") and v46.alignment ~= "Left" then
                    v46.playerlistWasPreviouslyActive = true;
                    l_StarterGui_0:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
                end;
            end;
        end);
        v46.deselected:Connect(function() --[[ Line: 444 ]]
            -- upvalues: v46 (copy), l_StarterGui_0 (ref)
            if v46.chatWasPreviouslyActive then
                v46.chatWasPreviouslyActive = nil;
                l_StarterGui_0:SetCore("ChatActive", true);
            end;
            if v46.playerlistWasPreviouslyActive then
                v46.playerlistWasPreviouslyActive = nil;
                l_StarterGui_0:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true);
            end;
        end);
        task.delay(0.1, function() --[[ Line: 459 ]]
            -- upvalues: v46 (copy)
            if v46.activeState == "Deselected" then
                v46.stateChanged:Fire("Deselected");
                v46:refresh();
            end;
        end);
        v18.iconAdded:Fire(v46);
        return v46;
    end;
    v18.setName = function(v76, v77) --[[ Line: 475 ]] --[[ Name: setName ]]
        v76.widget.Name = v77;
        v76.name = v77;
        return v76;
    end;
    v18.setState = function(v78, v79, v80, v81) --[[ Line: 481 ]] --[[ Name: setState ]]
        -- upvalues: v13 (copy), v23 (copy)
        if not v79 then
            v79 = v78.isSelected and "Selected" or "Deselected";
        end;
        local v82 = v13.formatStateName(v79);
        if v78.activeState == v82 then
            return;
        else
            local l_isSelected_0 = v78.isSelected;
            v78.activeState = v82;
            if v82 == "Deselected" then
                v78.isSelected = false;
                if l_isSelected_0 then
                    v78.toggled:Fire(false, v80, v81);
                    v78.deselected:Fire(v80, v81);
                end;
                v78:_setToggleItemsVisible(false, v80, v81);
            elseif v82 == "Selected" then
                v78.isSelected = true;
                if not l_isSelected_0 then
                    v78.toggled:Fire(true, v80, v81);
                    v78.selected:Fire(v80, v81);
                    v23:Fire(v78, v80, v81);
                end;
                v78:_setToggleItemsVisible(true, v80, v81);
            end;
            v78.stateChanged:Fire(v82, v80, v81);
            return;
        end;
    end;
    v18.getInstance = function(v84, v85) --[[ Line: 514 ]] --[[ Name: getInstance ]]
        -- upvalues: v15 (copy)
        local v86 = v84.cachedNamesToInstances[v85];
        if v86 then
            return v86;
        else
            local function v91(v87, v88) --[[ Line: 522 ]] --[[ Name: cacheInstance ]]
                -- upvalues: v84 (copy)
                if not v84.cachedInstances[v88] then
                    local l_v88_Attribute_0 = v88:GetAttribute("Collective");
                    local v90 = l_v88_Attribute_0 and v84.cachedCollectives[l_v88_Attribute_0];
                    if v90 then
                        table.insert(v90, v88);
                    end;
                    v84.cachedNamesToInstances[v87] = v88;
                    v84.cachedInstances[v88] = true;
                    v88.Destroying:Once(function() --[[ Line: 532 ]]
                        -- upvalues: v84 (ref), v87 (copy), v88 (copy)
                        v84.cachedNamesToInstances[v87] = nil;
                        v84.cachedInstances[v88] = nil;
                    end);
                end;
            end;
            local l_widget_0 = v84.widget;
            v91("Widget", l_widget_0);
            if v85 == "Widget" then
                return l_widget_0;
            else
                local v93 = nil;
                local function v94(v95) --[[ Line: 545 ]] --[[ Name: scanChildren ]]
                    -- upvalues: v84 (copy), v15 (ref), v94 (copy), v91 (copy), v85 (copy), v93 (ref)
                    for _, v97 in pairs(v95:GetChildren()) do
                        local l_v97_Attribute_0 = v97:GetAttribute("WidgetUID");
                        if not l_v97_Attribute_0 or l_v97_Attribute_0 == v84.UID then
                            local _ = v97;
                            local v100 = v15.getRealInstance(v97);
                            if v100 then
                                v97 = v100;
                            end;
                            v94(v97);
                            if v97:IsA("GuiBase") or v97:IsA("UIBase") or v97:IsA("ValueBase") then
                                local l_Name_0 = v97.Name;
                                v91(l_Name_0, v97);
                                if l_Name_0 == v85 then
                                    v93 = v97;
                                end;
                            end;
                        end;
                    end;
                end;
                v94(l_widget_0);
                return v93;
            end;
        end;
    end;
    v18.getCollective = function(v102, v103) --[[ Line: 575 ]] --[[ Name: getCollective ]]
        local v104 = v102.cachedCollectives[v103];
        if v104 then
            return v104;
        else
            v104 = {};
            for v105, _ in pairs(v102.cachedInstances) do
                if v105:GetAttribute("Collective") == v103 then
                    table.insert(v104, v105);
                end;
            end;
            v102.cachedCollectives[v103] = v104;
            return v104;
        end;
    end;
    v18.getInstanceOrCollective = function(v107, v108) --[[ Line: 596 ]] --[[ Name: getInstanceOrCollective ]]
        local v109 = {};
        local v110 = v107:getInstance(v108);
        if v110 then
            table.insert(v109, v110);
        end;
        if #v109 == 0 then
            v109 = v107:getCollective(v108);
        end;
        return v109;
    end;
    v18.getStateGroup = function(v111, v112) --[[ Line: 610 ]] --[[ Name: getStateGroup ]]
        local v113 = v112 or v111.activeState;
        local v114 = v111.appearance[v113];
        if not v114 then
            v114 = {};
            v111.appearance[v113] = v114;
        end;
        return v114;
    end;
    v18.refreshAppearance = function(v115, v116, v117) --[[ Line: 620 ]] --[[ Name: refreshAppearance ]]
        -- upvalues: v15 (copy)
        v15.refresh(v115, v116, v117);
        return v115;
    end;
    v18.refresh = function(v118) --[[ Line: 625 ]] --[[ Name: refresh ]]
        v118:refreshAppearance(v118.widget);
        v118.updateSize:Fire();
        return v118;
    end;
    v18.updateParent = function(v119) --[[ Line: 631 ]] --[[ Name: updateParent ]]
        -- upvalues: v18 (copy)
        local v120 = v18.getIconByUID(v119.parentIconUID);
        if v120 then
            v120.updateSize:Fire();
        end;
    end;
    v18.setBehaviour = function(v121, v122, v123, v124, v125) --[[ Line: 638 ]] --[[ Name: setBehaviour ]]
        local v126 = v122 .. "-" .. v123;
        v121.customBehaviours[v126] = v124;
        if v125 then
            local v127 = v121:getInstanceOrCollective(v122);
            for _, v129 in pairs(v127) do
                v121:refreshAppearance(v129, v123);
            end;
        end;
    end;
    v18.modifyTheme = function(v130, v131, v132) --[[ Line: 651 ]] --[[ Name: modifyTheme ]]
        -- upvalues: v15 (copy)
        return v130, (v15.modify(v130, v131, v132));
    end;
    v18.modifyChildTheme = function(v133, v134, v135) --[[ Line: 656 ]] --[[ Name: modifyChildTheme ]]
        -- upvalues: v18 (copy)
        v133.childModifications = v134;
        v133.childModificationsUID = v135;
        for v136, _ in pairs(v133.childIconsDict) do
            v18.getIconByUID(v136):modifyTheme(v134, v135);
        end;
        v133.childThemeModified:Fire();
        return v133;
    end;
    v18.removeModification = function(v138, v139) --[[ Line: 669 ]] --[[ Name: removeModification ]]
        -- upvalues: v15 (copy)
        v15.remove(v138, v139);
        return v138;
    end;
    v18.removeModificationWith = function(v140, v141, v142, v143) --[[ Line: 674 ]] --[[ Name: removeModificationWith ]]
        -- upvalues: v15 (copy)
        v15.removeWith(v140, v141, v142, v143);
        return v140;
    end;
    v18.setTheme = function(v144, v145) --[[ Line: 679 ]] --[[ Name: setTheme ]]
        -- upvalues: v15 (copy)
        v15.set(v144, v145);
        return v144;
    end;
    v18.setEnabled = function(v146, v147) --[[ Line: 684 ]] --[[ Name: setEnabled ]]
        v146.isEnabled = v147;
        v146.widget.Visible = v147;
        v146:updateParent();
        return v146;
    end;
    v18.select = function(v148, v149, v150) --[[ Line: 691 ]] --[[ Name: select ]]
        v148:setState("Selected", v149, v150);
        return v148;
    end;
    v18.deselect = function(v151, v152, v153) --[[ Line: 696 ]] --[[ Name: deselect ]]
        v151:setState("Deselected", v152, v153);
        return v151;
    end;
    v18.notify = function(v154, v155, v156) --[[ Line: 701 ]] --[[ Name: notify ]]
        -- upvalues: l_Elements_0 (copy), v18 (copy)
        if not v154.notice then
            v154.notice = require(l_Elements_0.Notice)(v154, v18);
        end;
        v154.noticeStarted:Fire(v155, v156);
        return v154;
    end;
    v18.clearNotices = function(v157) --[[ Line: 715 ]] --[[ Name: clearNotices ]]
        v157.endNotices:Fire();
        return v157;
    end;
    v18.disableOverlay = function(v158, v159) --[[ Line: 720 ]] --[[ Name: disableOverlay ]]
        v158.overlayDisabled = v159;
        return v158;
    end;
    v18.disableStateOverlay = v18.disableOverlay;
    v18.setImage = function(v160, v161, v162) --[[ Line: 726 ]] --[[ Name: setImage ]]
        v160:modifyTheme({
            "IconImage", 
            "Image", 
            v161, 
            v162
        });
        return v160;
    end;
    v18.setLabel = function(v163, v164, v165) --[[ Line: 731 ]] --[[ Name: setLabel ]]
        v163:modifyTheme({
            "IconLabel", 
            "Text", 
            v164, 
            v165
        });
        return v163;
    end;
    v18.setOrder = function(v166, v167, v168) --[[ Line: 736 ]] --[[ Name: setOrder ]]
        v166:modifyTheme({
            "Widget", 
            "LayoutOrder", 
            v167, 
            v168
        });
        return v166;
    end;
    v18.setCornerRadius = function(v169, v170, v171) --[[ Line: 741 ]] --[[ Name: setCornerRadius ]]
        v169:modifyTheme({
            "IconCorners", 
            "CornerRadius", 
            v170, 
            v171
        });
        return v169;
    end;
    v18.align = function(v172, v173, v174) --[[ Line: 746 ]] --[[ Name: align ]]
        -- upvalues: v18 (copy)
        local v175 = tostring(v173):lower();
        if v175 == "mid" or v175 == "centre" then
            v175 = "center";
        end;
        if v175 ~= "left" and v175 ~= "center" and v175 ~= "right" then
            v175 = "left";
        end;
        local v176 = v175 == "center" and v18.container.TopbarCentered or v18.container.TopbarStandard;
        local l_Holders_0 = v176.Holders;
        local v178 = string.upper((string.sub(v175, 1, 1))) .. string.sub(v175, 2);
        if not v174 then
            v172.originalAlignment = v178;
        end;
        local l_joinedFrame_0 = v172.joinedFrame;
        local v180 = l_Holders_0[v178];
        v172.screenGui = v176;
        v172.alignmentHolder = v180;
        if not v172.isDestroyed then
            v172.widget.Parent = l_joinedFrame_0 or v180;
        end;
        v172.alignment = v178;
        v172.alignmentChanged:Fire(v178);
        v18.iconChanged:Fire(v172);
        return v172;
    end;
    v18.setAlignment = v18.align;
    v18.setLeft = function(v181) --[[ Line: 775 ]] --[[ Name: setLeft ]]
        v181:setAlignment("Left");
        return v181;
    end;
    v18.setMid = function(v182) --[[ Line: 780 ]] --[[ Name: setMid ]]
        v182:setAlignment("Center");
        return v182;
    end;
    v18.setRight = function(v183) --[[ Line: 785 ]] --[[ Name: setRight ]]
        v183:setAlignment("Right");
        return v183;
    end;
    v18.setWidth = function(v184, v185, v186) --[[ Line: 790 ]] --[[ Name: setWidth ]]
        v184:modifyTheme({
            "Widget", 
            "Size", 
            UDim2.fromOffset(v185, v184.widget.Size.Y.Offset), 
            v186
        });
        v184:modifyTheme({
            "Widget", 
            "DesiredWidth", 
            v185, 
            v186
        });
        return v184;
    end;
    v18.setImageScale = function(v187, v188, v189) --[[ Line: 800 ]] --[[ Name: setImageScale ]]
        v187:modifyTheme({
            "IconImageScale", 
            "Value", 
            v188, 
            v189
        });
        return v187;
    end;
    v18.setImageRatio = function(v190, v191, v192) --[[ Line: 805 ]] --[[ Name: setImageRatio ]]
        v190:modifyTheme({
            "IconImageRatio", 
            "AspectRatio", 
            v191, 
            v192
        });
        return v190;
    end;
    v18.setTextSize = function(v193, v194, v195) --[[ Line: 810 ]] --[[ Name: setTextSize ]]
        v193:modifyTheme({
            "IconLabel", 
            "TextSize", 
            v194, 
            v195
        });
        return v193;
    end;
    v18.setTextFont = function(v196, v197, v198, v199, v200) --[[ Line: 815 ]] --[[ Name: setTextFont ]]
        v198 = v198 or Enum.FontWeight.Regular;
        v199 = v199 or Enum.FontStyle.Normal;
        local v201 = nil;
        local v202 = typeof(v197);
        if v202 == "number" then
            v201 = Font.fromId(v197, v198, v199);
        elseif v202 == "EnumItem" then
            v201 = Font.fromEnum(v197);
        elseif v202 == "string" and not v197:match("rbxasset") then
            v201 = Font.fromName(v197, v198, v199);
        end;
        if not v201 then
            v201 = Font.new(v197, v198, v199);
        end;
        v196:modifyTheme({
            "IconLabel", 
            "FontFace", 
            v201, 
            v200
        });
        return v196;
    end;
    v18.bindToggleItem = function(v203, v204) --[[ Line: 836 ]] --[[ Name: bindToggleItem ]]
        if not v204:IsA("GuiObject") and not v204:IsA("LayerCollector") then
            error("Toggle item must be a GuiObject or LayerCollector!");
        end;
        v203.toggleItems[v204] = true;
        v203:_updateSelectionInstances();
        return v203;
    end;
    v18.unbindToggleItem = function(v205, v206) --[[ Line: 845 ]] --[[ Name: unbindToggleItem ]]
        v205.toggleItems[v206] = nil;
        v205:_updateSelectionInstances();
        return v205;
    end;
    v18._updateSelectionInstances = function(v207) --[[ Line: 851 ]] --[[ Name: _updateSelectionInstances ]]
        for v208, _ in pairs(v207.toggleItems) do
            local v210 = {};
            for _, v212 in pairs(v208:GetDescendants()) do
                if (v212:IsA("TextButton") or v212:IsA("ImageButton")) and v212.Active then
                    table.insert(v210, v212);
                end;
            end;
            v207.toggleItems[v208] = v210;
        end;
    end;
    v18._setToggleItemsVisible = function(v213, v214, _, v216) --[[ Line: 865 ]] --[[ Name: _setToggleItemsVisible ]]
        for v217, _ in pairs(v213.toggleItems) do
            if not v216 or v216 == v213 or v216.toggleItems[v217] == nil then
                local v219 = "Visible";
                if v217:IsA("LayerCollector") then
                    v219 = "Enabled";
                end;
                v217[v219] = v214;
            end;
        end;
    end;
    v18.bindEvent = function(v220, v221, v222) --[[ Line: 877 ]] --[[ Name: bindEvent ]]
        local v223 = v220[v221];
        assert(v223 and typeof(v223) == "table" and v223.Connect, "argument[1] must be a valid topbarplus icon event name!");
        assert(typeof(v222) == "function", "argument[2] must be a function!");
        v220.bindedEvents[v221] = v223:Connect(function(...) --[[ Line: 881 ]]
            -- upvalues: v222 (copy), v220 (copy)
            v222(v220, ...);
        end);
        return v220;
    end;
    v18.unbindEvent = function(v224, v225) --[[ Line: 887 ]] --[[ Name: unbindEvent ]]
        local v226 = v224.bindedEvents[v225];
        if v226 then
            v226:Disconnect();
            v224.bindedEvents[v225] = nil;
        end;
        return v224;
    end;
    v18.bindToggleKey = function(v227, v228) --[[ Line: 896 ]] --[[ Name: bindToggleKey ]]
        assert(typeof(v228) == "EnumItem", "argument[1] must be a KeyCode EnumItem!");
        v227.bindedToggleKeys[v228] = true;
        v227.toggleKeyAdded:Fire(v228);
        v227:setCaption("_hotkey_");
        return v227;
    end;
    v18.unbindToggleKey = function(v229, v230) --[[ Line: 904 ]] --[[ Name: unbindToggleKey ]]
        assert(typeof(v230) == "EnumItem", "argument[1] must be a KeyCode EnumItem!");
        v229.bindedToggleKeys[v230] = nil;
        return v229;
    end;
    v18.call = function(v231, v232, ...) --[[ Line: 910 ]] --[[ Name: call ]]
        local v233 = table.pack(...);
        task.spawn(function() --[[ Line: 912 ]]
            -- upvalues: v232 (copy), v231 (copy), v233 (copy)
            v232(v231, table.unpack(v233));
        end);
        return v231;
    end;
    v18.addToJanitor = function(v234, v235) --[[ Line: 918 ]] --[[ Name: addToJanitor ]]
        v234.janitor:add(v235);
        return v234;
    end;
    v18.lock = function(v236) --[[ Line: 923 ]] --[[ Name: lock ]]
        v236:getInstance("ClickRegion").Visible = false;
        v236.locked = true;
        return v236;
    end;
    v18.unlock = function(v237) --[[ Line: 931 ]] --[[ Name: unlock ]]
        v237:getInstance("ClickRegion").Visible = true;
        v237.locked = false;
        return v237;
    end;
    v18.debounce = function(v238, v239) --[[ Line: 938 ]] --[[ Name: debounce ]]
        v238:lock();
        task.wait(v239);
        v238:unlock();
        return v238;
    end;
    v18.autoDeselect = function(v240, v241) --[[ Line: 945 ]] --[[ Name: autoDeselect ]]
        if v241 == nil then
            v241 = true;
        end;
        v240.deselectWhenOtherIconSelected = v241;
        return v240;
    end;
    v18.oneClick = function(v242, v243) --[[ Line: 955 ]] --[[ Name: oneClick ]]
        local l_singleClickJanitor_0 = v242.singleClickJanitor;
        l_singleClickJanitor_0:clean();
        if v243 or v243 == nil then
            l_singleClickJanitor_0:add(v242.selected:Connect(function() --[[ Line: 961 ]]
                -- upvalues: v242 (copy)
                v242:deselect("OneClick", v242);
            end));
        end;
        v242.oneClickEnabled = true;
        return v242;
    end;
    v18.setCaption = function(v245, v246) --[[ Line: 969 ]] --[[ Name: setCaption ]]
        -- upvalues: l_Elements_0 (copy)
        if v246 == "_hotkey_" and v245.captionText then
            return v245;
        else
            local l_captionJanitor_0 = v245.captionJanitor;
            v245.captionJanitor:clean();
            if not v246 or v246 == "" then
                v245.caption = nil;
                v245.captionText = nil;
                return v245;
            else
                local v248 = l_captionJanitor_0:add(require(l_Elements_0.Caption)(v245));
                v248:SetAttribute("CaptionText", v246);
                v245.caption = v248;
                v245.captionText = v246;
                return v245;
            end;
        end;
    end;
    v18.setCaptionHint = function(v249, v250) --[[ Line: 987 ]] --[[ Name: setCaptionHint ]]
        assert(typeof(v250) == "EnumItem", "argument[1] must be a KeyCode EnumItem!");
        v249.fakeToggleKey = v250;
        v249.fakeToggleKeyChanged:Fire(v250);
        v249:setCaption("_hotkey_");
        return v249;
    end;
    v18.leave = function(v251) --[[ Line: 995 ]] --[[ Name: leave ]]
        v251.joinJanitor:clean();
        return v251;
    end;
    v18.joinMenu = function(v252, v253) --[[ Line: 1001 ]] --[[ Name: joinMenu ]]
        -- upvalues: v13 (copy)
        v13.joinFeature(v252, v253, v253.menuIcons, v253:getInstance("Menu"));
        v253.menuChildAdded:Fire(v252);
        return v252;
    end;
    v18.setMenu = function(v254, v255) --[[ Line: 1007 ]] --[[ Name: setMenu ]]
        v254.menuSet:Fire(v255);
        return v254;
    end;
    v18.setFrozenMenu = function(v256, v257) --[[ Line: 1012 ]] --[[ Name: setFrozenMenu ]]
        v256:freezeMenu(v257);
        v256:setMenu(v257);
    end;
    v18.freezeMenu = function(v258) --[[ Line: 1017 ]] --[[ Name: freezeMenu ]]
        v258:select("FrozenMenu", v258);
        v258:bindEvent("deselected", function(v259) --[[ Line: 1021 ]]
            -- upvalues: v258 (copy)
            v259:select("FrozenMenu", v258);
        end);
        v258:modifyTheme({
            "IconSpot", 
            "Visible", 
            false
        });
    end;
    v18.joinDropdown = function(v260, v261) --[[ Line: 1027 ]] --[[ Name: joinDropdown ]]
        -- upvalues: v13 (copy)
        v261:getDropdown();
        v13.joinFeature(v260, v261, v261.dropdownIcons, v261:getInstance("DropdownScroller"));
        v261.dropdownChildAdded:Fire(v260);
        return v260;
    end;
    v18.getDropdown = function(v262) --[[ Line: 1034 ]] --[[ Name: getDropdown ]]
        -- upvalues: l_Elements_0 (copy)
        local l_dropdown_0 = v262.dropdown;
        if not l_dropdown_0 then
            l_dropdown_0 = require(l_Elements_0.Dropdown)(v262);
            v262.dropdown = l_dropdown_0;
            v262:clipOutside(l_dropdown_0);
        end;
        return l_dropdown_0;
    end;
    v18.setDropdown = function(v264, v265) --[[ Line: 1044 ]] --[[ Name: setDropdown ]]
        v264:getDropdown();
        v264.dropdownSet:Fire(v265);
        return v264;
    end;
    v18.clipOutside = function(v266, v267) --[[ Line: 1050 ]] --[[ Name: clipOutside ]]
        -- upvalues: v13 (copy)
        local v268 = v13.clipOutside(v266, v267);
        v266:refreshAppearance(v267);
        return v266, v268;
    end;
    v18.setIndicator = function(v269, v270) --[[ Line: 1061 ]] --[[ Name: setIndicator ]]
        -- upvalues: l_Elements_0 (copy), v18 (copy)
        if not v269.indicator then
            v269.indicator = v269.janitor:add(require(l_Elements_0.Indicator)(v269, v18));
        end;
        v269.indicatorSet:Fire(v270);
    end;
    v18.destroy = function(v271) --[[ Line: 1076 ]] --[[ Name: destroy ]]
        -- upvalues: v18 (copy)
        if v271.isDestroyed then
            return;
        else
            v271:clearNotices();
            if v271.parentIconUID then
                v271:leave();
            end;
            v271.isDestroyed = true;
            v271.janitor:clean();
            v18.iconRemoved:Fire(v271);
            return;
        end;
    end;
    v18.Destroy = v18.destroy;
    return v18;
end;