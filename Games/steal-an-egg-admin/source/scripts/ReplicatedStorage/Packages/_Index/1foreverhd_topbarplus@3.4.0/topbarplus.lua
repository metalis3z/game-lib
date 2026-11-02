-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local UserInputService = game:GetService("UserInputService")
local ContentProvider = game:GetService("ContentProvider")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
require(script.Types)
local script_2 = script
local Reference = require(script_2.Reference)
local v1 = Reference.getObject()
local v2 = v1 and v1.Value
local Elements, GoodSignal, v3, LocalPlayer, v4, v5, v6, v7, v8, v9, v10, GoodSignal_2, Gamepad, Overflow, v11, v12, Elements_2, getIcons, getIconByUID, getIcon, setTopbarEnabled, modifyBaseTheme, setDisplayOrder, new, setName, setState, getInstance, getCollective, getInstanceOrCollective, getStateGroup, refreshAppearance, refresh, updateParent, setBehaviour, modifyTheme, modifyChildTheme, removeModification, removeModificationWith, setTheme, setEnabled, select, deselect, notify, clearNotices, disableOverlay, setImage, setLabel, setOrder, setCornerRadius, align, setLeft, setMid, setRight, setWidth, setImageScale, setImageRatio, setTextSize, setTextFont, setTextColor, bindToggleItem, unbindToggleItem, _updateSelectionInstances, _setToggleItemsVisible, bindEvent, unbindEvent, bindToggleKey, unbindToggleKey, call, addToJanitor, lock, unlock, debounce, autoDeselect, oneClick, setCaption, setCaptionHint, leave, joinMenu, setMenu, setFixedMenu, freezeMenu, joinDropdown, getDropdown, setDropdown, clipOutside, setIndicator, convertLabelToNumberSpinner, destroy

if v2 then
    if v2 == script_2 then
        if not v1 then
            Reference.addToReplicatedStorage()
        end
        GoodSignal_2 = require(script_2.Packages.GoodSignal)
        GoodSignal = GoodSignal_2
        v3 = require(script_2.Packages.Janitor)
        v5 = require(script_2.Utility)
        v4 = require(script_2.Features.Themes)
        Gamepad = require(script_2.Features.Gamepad)
        Overflow = require(script_2.Features.Overflow)
        v11 = {}
        v6 = v11
        v11.__index = v11
        LocalPlayer = Players.LocalPlayer
        v12 = {}
        v7 = v12
        v8 = GoodSignal_2.new()
        Elements_2 = script_2.Elements
        Elements = Elements_2
        v9 = 0
        v10 = {
            mobile = Enum.PreferredInput.Touch,
            desktop = Enum.PreferredInput.KeyboardAndMouse,
            console = Enum.PreferredInput.Gamepad
        }
        v11.baseDisplayOrderChanged = GoodSignal_2.new()
        v11.baseDisplayOrder = 10
        v11.baseTheme = require(script_2.Features.Themes.Default)
        v11.isOldTopbar = false
        v11.iconsDictionary = v12
        v11.insetHeightChanged = GoodSignal_2.new()
        v11.container = require(Elements_2.Container)(v11)
        v11.topbarEnabled = true
        v11.iconAdded = GoodSignal_2.new()
        v11.iconRemoved = GoodSignal_2.new()
        v11.iconChanged = GoodSignal_2.new()

        function getIcons() -- line 1160 | captures: v6
            return v6.iconsDictionary
        end

        v6.getIcons = getIcons

        function getIconByUID(v13) -- line 1163 | captures: v6
            return v6.iconsDictionary[v13] or nil
        end

        v6.getIconByUID = getIconByUID

        function getIcon(v14) -- line 1170 | captures: v6, v7
            local v15 = v6.getIconByUID(v14)
            if v15 then
                return v15
            end
            for v16, v17 in pairs(v7) do
                if v17.name == v14 then
                    return v17
                end
            end
            return nil
        end

        v6.getIcon = getIcon

        function setTopbarEnabled(v18, v19) -- line 1182 | captures: v6
            local v20 = if typeof(v18) == "boolean" then v18 else v6.topbarEnabled
            if not v19 then
                v6.topbarEnabled = v20
            end
            for v21, v22 in pairs(v6.container) do
                v22.Enabled = v20
            end
        end

        v6.setTopbarEnabled = setTopbarEnabled

        function modifyBaseTheme(v23) -- line 1196 | captures: v4, v6, v7
            local v24 = v4.getModifications(v23)
            for v25, v26 in pairs(v24) do
                for v27, v28 in pairs(v6.baseTheme) do
                    v4.merge(v28, v26)
                end
            end
            for v29, v30 in pairs(v7) do
                v30:setTheme(v6.baseTheme)
            end
        end

        v6.modifyBaseTheme = modifyBaseTheme

        function setDisplayOrder(v31) -- line 1207 | captures: v6
            v6.baseDisplayOrder = v31
            v6.baseDisplayOrderChanged:Fire(v31)
        end

        v6.setDisplayOrder = setDisplayOrder
        task.defer(Gamepad.start, v6)
        task.defer(Overflow.start, v6)
        task.defer(function() -- line 1213 | captures: LocalPlayer, v6, script_2
            local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
            for v32, v33 in pairs(v6.container) do
                v33.Parent = PlayerGui
            end
            require(script_2.Attribute)
        end)

        function new() -- line 1220 | captures: Elements, GoodSignal, v3, v5, v6, v7, v8, v9, v10, UserInputService, StarterGui, script_2
            local v34 = {}
            local v35 = v6
            setmetatable(v34, v35)
            local v36 = v3.new()
            v34.janitor = v36
            v34.themesJanitor = v36:add(v3.new())
            v34.singleClickJanitor = v36:add(v3.new())
            v34.captionJanitor = v36:add(v3.new())
            v34.joinJanitor = v36:add(v3.new())
            v34.menuJanitor = v36:add(v3.new())
            v34.dropdownJanitor = v36:add(v3.new())
            local v37 = v5.generateUID()
            v7[v37] = v34
            v36:add(function() -- line 1233 | captures: v37, v7
                v7[v37] = nil
            end)
            v34.selected = v36:add(GoodSignal.new())
            v34.deselected = v36:add(GoodSignal.new())
            v34.toggled = v36:add(GoodSignal.new())
            v34.viewingStarted = v36:add(GoodSignal.new())
            v34.viewingEnded = v36:add(GoodSignal.new())
            v34.stateChanged = v36:add(GoodSignal.new())
            v34.notified = v36:add(GoodSignal.new())
            v34.noticeStarted = v36:add(GoodSignal.new())
            v34.noticeChanged = v36:add(GoodSignal.new())
            v34.endNotices = v36:add(GoodSignal.new())
            v34.toggleKeyAdded = v36:add(GoodSignal.new())
            v34.fakeToggleKeyChanged = v36:add(GoodSignal.new())
            v34.alignmentChanged = v36:add(GoodSignal.new())
            v34.updateSize = v36:add(GoodSignal.new())
            v34.resizingComplete = v36:add(GoodSignal.new())
            v34.joinedParent = v36:add(GoodSignal.new())
            v34.menuSet = v36:add(GoodSignal.new())
            v34.dropdownSet = v36:add(GoodSignal.new())
            v34.updateMenu = v36:add(GoodSignal.new())
            v34.startMenuUpdate = v36:add(GoodSignal.new())
            v34.childThemeModified = v36:add(GoodSignal.new())
            v34.indicatorSet = v36:add(GoodSignal.new())
            v34.dropdownChildAdded = v36:add(GoodSignal.new())
            v34.menuChildAdded = v36:add(GoodSignal.new())
            v34.iconModule = script_2
            v34.UID = v37
            v34.isEnabled = true
            v34.enabled = v34.isEnabled
            v34.isSelected = false
            v34.isViewing = false
            v34.joinedFrame = false
            v34.parentIconUID = false
            v34.deselectWhenOtherIconSelected = true
            v34.totalNotices = 0
            v34.activeState = "Deselected"
            v34.alignment = ""
            v34.originalAlignment = ""
            v34.appliedTheme = {}
            v34.appearance = {}
            v34.cachedInstances = {}
            v34.cachedNamesToInstances = {}
            v34.cachedCollectives = {}
            v34.bindedToggleKeys = {}
            v34.customBehaviours = {}
            v34.toggleItems = {}
            v34.bindedEvents = {}
            v34.notices = {}
            v34.menuIcons = {}
            v34.dropdownIcons = {}
            v34.childIconsDict = {}
            v34.creationTime = os.clock()
            v34.widget = v36:add(require(Elements.Widget)(v34, v6))
            v34:setAlignment()
            v9 += 1
            local v38 = v9 * 0.01 + 1
            v34:setOrder(v38, "deselected")
            v34:setOrder(v38, "selected")
            v34:setTheme(v6.baseTheme)
            local ClickRegion = v34:getInstance("ClickRegion")
            local v39 = false
            local v40 = 0

            local function handleToggle() -- line 1299 | captures: v40, v34
                if not v34.locked then
                    local v41 = tick()
                    if not (v41 - v40 < 0.1) then
                        v40 = v41
                        if v34.isSelected then
                            v34:deselect("User", v34)
                        else
                            v34:select("User", v34)
                        end
                    end
                end
            end

            ClickRegion.MouseButton1Click:Connect(function() -- line 1315 | captures: v39, v40, v34
                v39 = true
                if not v34.locked then
                    local v42 = tick()
                    if not (v42 - v40 < 0.1) then
                        v40 = v42
                        if v34.isSelected then
                            v34:deselect("User", v34)
                        else
                            v34:select("User", v34)
                        end
                    end
                end
            end)
            ClickRegion.TouchTap:Connect(function() -- line 1332 | captures: v39, v40, v34
                if not (v39 or v34.locked) then
                    local v43 = tick()
                    if not (v43 - v40 < 0.1) then
                        v40 = v43
                        if v34.isSelected then
                            v34:deselect("User", v34)
                        else
                            v34:select("User", v34)
                        end
                    end
                end
            end)
            v36:add(UserInputService.InputBegan:Connect(function(v44, v45) -- line 1348 | captures: v40, v34
                if v34.locked or not v34.bindedToggleKeys[v44.KeyCode] or v45 or v34.locked then
                    return
                end
                local v46 = tick()
                if not (v46 - v40 < 0.1) then
                    v40 = v46
                    if v34.isSelected then
                        v34:deselect("User", v34)
                    else
                        v34:select("User", v34)
                    end
                end
            end))

            local function viewingEnded() -- line 1364 | captures: v34
                if v34.locked then
                    return
                end
                v34.isViewing = false
                v34.viewingEnded:Fire(true)
                v34:setState(nil, "User", v34)
            end

            v34.joinedParent:Connect(function() -- line 1372 | captures: v34
                if not v34.isViewing or v34.locked then
                    return
                end
                v34.isViewing = false
                v34.viewingEnded:Fire(true)
                v34:setState(nil, "User", v34)
            end)
            ClickRegion.MouseEnter:Connect(function() -- line 1380 | captures: v34, v10, UserInputService
                local v47 = UserInputService.PreferredInput ~= v10.desktop
                if v34.locked then
                    return
                end
                v34.isViewing = true
                v34.viewingStarted:Fire(true)
                if not v47 then
                    v34:setState("Viewing", "User", v34)
                end
            end)
            local v48 = 0
            v36:add(UserInputService.TouchEnded:Connect(viewingEnded))
            ClickRegion.MouseLeave:Connect(viewingEnded)
            ClickRegion.SelectionGained:Connect(function(v49) -- line 1394 | captures: v34
                if v34.locked then
                    return
                end
                v34.isViewing = true
                v34.viewingStarted:Fire(true)
                if not v49 then
                    v34:setState("Viewing", "User", v34)
                end
            end)
            ClickRegion.SelectionLost:Connect(viewingEnded)
            ClickRegion.MouseButton1Down:Connect(function() -- line 1405 | captures: v48, v34, v10, UserInputService
                if v34.locked or not (UserInputService.PreferredInput == v10.mobile) then
                    return
                end
                v48 += 1
                local v50 = v48
                task.delay(0.2, function() -- line 1409 | captures: v50, v48, v34
                    if v50 ~= v48 or v34.locked then
                        return
                    end
                    v34.isViewing = true
                    v34.viewingStarted:Fire(true)
                    v34:setState("Viewing", "User", v34)
                end)
            end)
            ClickRegion.MouseButton1Up:Connect(function() -- line 1419 | captures: v48
                v48 += 1
            end)
            local IconOverlay = v34:getInstance("IconOverlay")
            v34.viewingStarted:Connect(function() -- line 1423 | captures: v34, IconOverlay
                IconOverlay.Visible = not v34.overlayDisabled
            end)
            v34.viewingEnded:Connect(function() -- line 1426 | captures: IconOverlay
                IconOverlay.Visible = false
            end)
            v36:add(v8:Connect(function(v51) -- line 1429 | captures: v34
                if v51 ~= v34 and v34.deselectWhenOtherIconSelected and v51.deselectWhenOtherIconSelected then
                    v34:deselect("AutoDeselect", v51)
                end
            end))
            local s = debug.info(2, "s")
            local v52 = string.split(s, ".")
            local game_2 = game
            local v53 = game_2
            local v54
            for v55, v56 in pairs(v52) do
                v53 = v53:FindFirstChild(v56)
                if v53 then
                    if v53:IsA("ScreenGui") then
                        v54 = v53
                    end
                else
                    game_2 = v53
                    break
                end
                game_2 = v53
            end
            if game_2 and v54 and v54.ResetOnSpawn == true then
                v34.originsScreenGui = v54
                v5.localPlayerRespawned(function() -- line 1449 | captures: v34
                    v34:destroy()
                end)
            end
            v34.toggled:Connect(function(v57) -- line 1453 | captures: v34, v6
                v34.noticeChanged:Fire(v34.totalNotices)
                for v58, v59 in pairs(v34.childIconsDict) do
                    local v60 = v6.getIconByUID(v58)
                    v60.noticeChanged:Fire(v60.totalNotices)
                    if not v57 and v60.isSelected then
                        for v61, v62 in pairs(v60.childIconsDict) do
                            v60:deselect("HideParentFeature", v34)
                        end
                    end
                end
            end)
            v34.selected:Connect(function() -- line 1467 | captures: v34, StarterGui
                if #v34.dropdownIcons > 0 then
                    if StarterGui:GetCore("ChatActive") and v34.alignment ~= "Right" then
                        v34.chatWasPreviouslyActive = true
                        StarterGui:SetCore("ChatActive", false)
                    end
                    if StarterGui:GetCoreGuiEnabled("PlayerList") and v34.alignment ~= "Left" then
                        v34.playerlistWasPreviouslyActive = true
                        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
                    end
                end
            end)
            v34.deselected:Connect(function() -- line 1481 | captures: v34, StarterGui
                if v34.chatWasPreviouslyActive then
                    v34.chatWasPreviouslyActive = nil
                    StarterGui:SetCore("ChatActive", true)
                end
                if v34.playerlistWasPreviouslyActive then
                    v34.playerlistWasPreviouslyActive = nil
                    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
                end
            end)
            task.delay(0.1, function() -- line 1491 | captures: v34
                if v34.activeState == "Deselected" then
                    v34.stateChanged:Fire("Deselected")
                    v34:refresh()
                end
            end)
            v6.iconAdded:Fire(v34)
            return v34
        end

        v6.new = new

        function setName(v63, v64) -- line 1500
            v63.widget.Name = v64
            v63.name = v64
            return v63
        end

        v6.setName = setName

        function setState(v65, v66, v67, v68) -- line 1505 | captures: v5, v8
            local v69
            if v66 then
                v69 = v66
            elseif v65.isSelected then
                v69 = "Selected"
            else
                v69 = "Deselected"
            end
            local v70 = v5.formatStateName(v69)
            if v65.activeState == v70 then
                return
            end
            local isSelected = v65.isSelected
            v65.activeState = v70
            if v70 == "Deselected" then
                v65.isSelected = false
                if isSelected then
                    v65.toggled:Fire(false, v67, v68)
                    v65.deselected:Fire(v67, v68)
                end
                v65:_setToggleItemsVisible(false, v67, v68)
            elseif v70 == "Selected" then
                v65.isSelected = true
                if not isSelected then
                    v65.toggled:Fire(true, v67, v68)
                    v65.selected:Fire(v67, v68)
                    v8:Fire(v65, v67, v68)
                end
                v65:_setToggleItemsVisible(true, v67, v68)
            end
            v65.stateChanged:Fire(v70, v67, v68)
        end

        v6.setState = setState

        function getInstance(v71, v72) -- line 1541 | captures: v4
            local v73
            local v74 = v71.cachedNamesToInstances[v72]
            if v74 then
                return v74
            end

            local function cacheInstance(v75, v76) -- line 1547 | captures: v71
                if v71.cachedInstances[v76] then
                    return
                end
                local Collective = v76:GetAttribute("Collective")
                local v77 = Collective and v71.cachedCollectives[Collective]
                if v77 then
                    table.insert(v77, v76)
                end
                v71.cachedNamesToInstances[v75] = v76
                v71.cachedInstances[v76] = true
                v76.Destroying:Once(function() -- line 1559 | captures: v75, v76, v71
                    v71.cachedNamesToInstances[v75] = nil
                    v71.cachedInstances[v76] = nil
                end)
            end

            local widget = v71.widget
            cacheInstance("Widget", widget)
            if v72 == "Widget" then
                return widget
            end
            local v78

            function v78(v79) -- line 1570 | captures: v78, v73, v71, v72, cacheInstance, v4
                for v80, v81 in pairs(v79:GetChildren()) do
                    local WidgetUID = v81:GetAttribute("WidgetUID")
                    if WidgetUID then
                        if WidgetUID == v71.UID then
                            local v82 = v4.getRealInstance(v81) or v81
                            v78(v82)
                            if v82:IsA("GuiBase") or v82:IsA("UIBase") or v82:IsA("ValueBase") then
                                local Name = v82.Name
                                cacheInstance(Name, v82)
                                if Name == v72 then
                                    v73 = v82
                                end
                            end
                        end
                    else
                        local v83 = v4.getRealInstance(v81) or v81
                        v78(v83)
                        if v83:IsA("GuiBase") or v83:IsA("UIBase") or v83:IsA("ValueBase") then
                            local Name = v83.Name
                            cacheInstance(Name, v83)
                            if Name == v72 then
                                v73 = v83
                            end
                        end
                    end
                end
            end

            v78(widget)
            return v73
        end

        v6.getInstance = getInstance

        function getCollective(v84, v85) -- line 1593
            local v86 = v84.cachedCollectives[v85]
            if v86 then
                return v86
            end
            local v87 = {}
            for v88, v89 in pairs(v84.cachedInstances) do
                if v88:GetAttribute("Collective") == v85 then
                    table.insert(v87, v88)
                end
            end
            v84.cachedCollectives[v85] = v87
            return v87
        end

        v6.getCollective = getCollective

        function getInstanceOrCollective(v90, v91) -- line 1607
            local v92 = {}
            local v93 = v90:getInstance(v91)
            if v93 then
                table.insert(v92, v93)
            end
            if #v92 == 0 then
                v92 = v90:getCollective(v91)
            end
            return v92
        end

        v6.getInstanceOrCollective = getInstanceOrCollective

        function getStateGroup(v94, v95) -- line 1618
            local v96 = v95 or v94.activeState
            local v97 = v94.appearance[v96]
            if not v97 then
                v97 = {}
                v94.appearance[v96] = v97
            end
            return v97
        end

        v6.getStateGroup = getStateGroup

        function refreshAppearance(v98, v99, v100) -- line 1630 | captures: v4
            v4.refresh(v98, v99, v100)
            return v98
        end

        v6.refreshAppearance = refreshAppearance

        function refresh(v101) -- line 1634
            v101:refreshAppearance(v101.widget)
            v101.updateSize:Fire()
            return v101
        end

        v6.refresh = refresh

        function updateParent(v102) -- line 1639 | captures: v6
            local v103 = v6.getIconByUID(v102.parentIconUID)
            if v103 then
                v103.updateSize:Fire()
            end
        end

        v6.updateParent = updateParent

        function setBehaviour(v104, v105, v106, v107, v108) -- line 1645
            v104.customBehaviours[v105 .. "-" .. v106] = v107
            if v108 then
                local v109 = v104:getInstanceOrCollective(v105)
                for v110, v111 in pairs(v109) do
                    v104:refreshAppearance(v111, v106)
                end
            end
        end

        v6.setBehaviour = setBehaviour

        function modifyTheme(v112, v113, v114) -- line 1654 | captures: v4
            return v112, (v4.modify(v112, v113, v114))
        end

        v6.modifyTheme = modifyTheme

        function modifyChildTheme(v115, v116, v117) -- line 1658 | captures: v6
            v115.childModifications = v116
            v115.childModificationsUID = v117
            for v118, v119 in pairs(v115.childIconsDict) do
                v6.getIconByUID(v118):modifyTheme(v116, v117)
            end
            v115.childThemeModified:Fire()
            return v115
        end

        v6.modifyChildTheme = modifyChildTheme

        function removeModification(v120, v121) -- line 1667 | captures: v4
            v4.remove(v120, v121)
            return v120
        end

        v6.removeModification = removeModification

        function removeModificationWith(v122, v123, v124, v125) -- line 1671 | captures: v4
            v4.removeWith(v122, v123, v124, v125)
            return v122
        end

        v6.removeModificationWith = removeModificationWith

        function setTheme(v126, v127) -- line 1675 | captures: v4
            v4.set(v126, v127)
            return v126
        end

        v6.setTheme = setTheme

        function setEnabled(v128, v129) -- line 1679
            v128.isEnabled = v129
            v128.enabled = v128.isEnabled
            v128.widget.Visible = v129
            v128:updateParent()
            return v128
        end

        v6.setEnabled = setEnabled

        function select(v130, v131, v132) -- line 1686
            v130:setState("Selected", v131, v132)
            return v130
        end

        v6.select = select

        function deselect(v133, v134, v135) -- line 1690
            v133:setState("Deselected", v134, v135)
            return v133
        end

        v6.deselect = deselect

        function notify(v136, v137, v138) -- line 1694 | captures: Elements, v6
            if not v136.notice then
                v136.notice = require(Elements.Notice)(v136, v6)
            end
            v136.noticeStarted:Fire(v137, v138)
            return v136
        end

        v6.notify = notify

        function clearNotices(v139) -- line 1702
            v139.endNotices:Fire()
            return v139
        end

        v6.clearNotices = clearNotices

        function disableOverlay(v140, v141) -- line 1706
            v140.overlayDisabled = v141
            return v140
        end

        v6.disableOverlay = disableOverlay
        Gamepad = v6.disableOverlay
        v6.disableStateOverlay = Gamepad

        function setImage(v142, v143, v144) -- line 1711 | captures: ContentProvider
            v142:modifyTheme({ "IconImage", "Image", v143, v144 })
            task.spawn(function() -- line 1713 | captures: v143, ContentProvider
                local v145
                if tonumber(v143) then
                    v145 = ("rbxassetid://%*"):format(v143)
                else
                    v145 = v143
                end
                if ContentProvider:GetAssetFetchStatus(v145) ~= Enum.AssetFetchStatus.Success then
                    pcall(ContentProvider.PreloadAsync, ContentProvider, { v145 })
                end
            end)
            return v142
        end

        v6.setImage = setImage

        function setLabel(v146, v147, v148) -- line 1727
            v146:modifyTheme({ "IconLabel", "Text", v147, v148 })
            return v146
        end

        v6.setLabel = setLabel

        function setOrder(v149, v150, v151) -- line 1731
            local v152 = v150 * 100
            v149:modifyTheme({ "IconSpot", "LayoutOrder", v152, v151 })
            v149:modifyTheme({ "Widget", "LayoutOrder", v152, v151 })
            return v149
        end

        v6.setOrder = setOrder

        function setCornerRadius(v153, v154, v155) -- line 1737
            v153:modifyTheme({ "IconCorners", "CornerRadius", v154, v155 })
            return v153
        end

        v6.setCornerRadius = setCornerRadius

        function align(v156, v157, v158) -- line 1741 | captures: v6
            local v159 = tostring(v157):lower()
            if v159 == "mid" then
                v159 = "center"
            end
            if not (v159 == "left" or v159 == "center" or v159 == "right") then
                v159 = "left"
            end
            local v160 = if v159 == "center" then v6.container.TopbarCentered else v6.container.TopbarStandard
            local v161 = string.upper((string.sub(v159, 1, 1))) .. string.sub(v159, 2)
            if not v158 then
                v156.originalAlignment = v161
            end
            local joinedFrame = v156.joinedFrame
            local v162 = v160.Holders[v161]
            v156.screenGui = v160
            v156.alignmentHolder = v162
            if not v156.isDestroyed then
                v156.widget.Parent = joinedFrame or v162
            end
            v156.alignment = v161
            v156.alignmentChanged:Fire(v161)
            v6.iconChanged:Fire(v156)
            return v156
        end

        v6.align = align
        Gamepad = v6.align
        v6.setAlignment = Gamepad

        function setLeft(v163) -- line 1774
            v163:setAlignment("Left")
            return v163
        end

        v6.setLeft = setLeft

        function setMid(v164) -- line 1778
            v164:setAlignment("Center")
            return v164
        end

        v6.setMid = setMid

        function setRight(v165) -- line 1782
            v165:setAlignment("Right")
            return v165
        end

        v6.setRight = setRight

        function setWidth(v166, v167, v168) -- line 1786
            v166:modifyTheme({ "Widget", "DesiredWidth", v167, v168 })
            return v166
        end

        v6.setWidth = setWidth

        function setImageScale(v169, v170, v171) -- line 1790
            v169:modifyTheme({ "IconImageScale", "Value", v170, v171 })
            return v169
        end

        v6.setImageScale = setImageScale

        function setImageRatio(v172, v173, v174) -- line 1794
            v172:modifyTheme({ "IconImageRatio", "AspectRatio", v173, v174 })
            return v172
        end

        v6.setImageRatio = setImageRatio

        function setTextSize(v175, v176, v177) -- line 1798
            v175:modifyTheme({ "IconLabel", "TextSize", v176, v177 })
            return v175
        end

        v6.setTextSize = setTextSize

        function setTextFont(v178, v179, v180, v181, v182) -- line 1802
            local v183 = v180 or Enum.FontWeight.Regular
            local v184 = v181 or Enum.FontStyle.Normal
            local v185 = typeof(v179)
            local v186
            if v185 == "number" then
                v186 = Font.fromId(v179, v183, v184)
            elseif v185 == "EnumItem" then
                v186 = Font.fromEnum(v179)
            elseif v185 == "string" then
                if v179:match("rbxasset") then
                else
                    v186 = Font.fromName(v179, v183, v184)
                end
            end
            v178:modifyTheme({
                "IconLabel",
                "FontFace",
                v186 or Font.new(v179, v183, v184),
                v182
            })
            return v178
        end

        v6.setTextFont = setTextFont

        function setTextColor(v187, v188, v189) -- line 1828
            local v190
            if v188 == nil then
                if v188 ~= nil and v188 ~= "" then
                    warn("setTextColor item must be a Color3 value! Changed the color to white.")
                end
                v190 = Color3.fromRGB(255, 255, 255)
            elseif v188 == "" then
            elseif type(v188) == "userdata" and typeof(v188) == "Color3" then
                v190 = v188
            end
            v187:modifyTheme({ "IconLabel", "TextColor3", v190, v189 })
            return v187
        end

        v6.setTextColor = setTextColor

        function bindToggleItem(v191, v192) -- line 1841
            if not v192:IsA("GuiObject") and not v192:IsA("LayerCollector") then
                error("Toggle item must be a GuiObject or LayerCollector!")
            end
            v191.toggleItems[v192] = true
            v191:_updateSelectionInstances()
            return v191
        end

        v6.bindToggleItem = bindToggleItem

        function unbindToggleItem(v193, v194) -- line 1849
            v193.toggleItems[v194] = nil
            v193:_updateSelectionInstances()
            return v193
        end

        v6.unbindToggleItem = unbindToggleItem

        function _updateSelectionInstances(v195) -- line 1854
            for v196, v197 in pairs(v195.toggleItems) do
                local v198 = {}
                for v199, v200 in pairs(v196:GetDescendants()) do
                    if v200:IsA("TextButton") then
                        if v200.Active then
                            table.insert(v198, v200)
                        end
                    elseif v200:IsA("ImageButton") then
                    end
                end
                v195.toggleItems[v196] = v198
            end
        end

        v6._updateSelectionInstances = _updateSelectionInstances

        function _setToggleItemsVisible(v201, v202, v203, v204) -- line 1870
            for v205, v206 in pairs(v201.toggleItems) do
                if v204 then
                    if v204 == v201 or v204.toggleItems[v205] == nil then
                    end
                else
                    local v207 = if v205:IsA("LayerCollector") then "Enabled" else "Visible"
                    v205[v207] = v202
                end
            end
        end

        v6._setToggleItemsVisible = _setToggleItemsVisible

        function bindEvent(v208, v209, v210) -- line 1881
            local v211 = v208[v209]
            local v212
            if v211 then
                if typeof(v211) == "table" then
                    v212 = v211.Connect
                else
                    v212 = false
                end
            else
                v212 = v211
            end
            assert(v212, "argument[1] must be a valid topbarplus icon event name!")
            local v213 = typeof(v210) == "function"
            assert(v213, "argument[2] must be a function!")
            v208.bindedEvents[v209] = v211:Connect(function(...) -- line 1891 | captures: v208, v210
                v210(v208, ...)
            end)
            return v208
        end

        v6.bindEvent = bindEvent

        function unbindEvent(v214, v215) -- line 1896
            local v216 = v214.bindedEvents[v215]
            if v216 then
                v216:Disconnect()
                v214.bindedEvents[v215] = nil
            end
            return v214
        end

        v6.unbindEvent = unbindEvent

        function bindToggleKey(v217, v218) -- line 1904
            local v219 = typeof(v218) == "EnumItem"
            assert(v219, "argument[1] must be a KeyCode EnumItem!")
            v217.bindedToggleKeys[v218] = true
            v217.toggleKeyAdded:Fire(v218)
            v217:setCaption("_hotkey_")
            return v217
        end

        v6.bindToggleKey = bindToggleKey

        function unbindToggleKey(v220, v221) -- line 1912
            local v222 = typeof(v221) == "EnumItem"
            assert(v222, "argument[1] must be a KeyCode EnumItem!")
            v220.bindedToggleKeys[v221] = nil
            return v220
        end

        v6.unbindToggleKey = unbindToggleKey

        function call(v223, v224, ...) -- line 1918
            local v225 = table.pack(...)
            task.spawn(function() -- line 1920 | captures: v223, v224, v225
                v224(v223, table.unpack(v225))
            end)
            return v223
        end

        v6.call = call

        function addToJanitor(v226, v227, v228, v229) -- line 1925
            v226.janitor:add(v227, v228, v229)
            return v226
        end

        v6.addToJanitor = addToJanitor

        function lock(v230) -- line 1929
            v230:getInstance("ClickRegion").Visible = false
            v230.locked = true
            return v230
        end

        v6.lock = lock

        function unlock(v231) -- line 1935
            v231:getInstance("ClickRegion").Visible = true
            v231.locked = false
            return v231
        end

        v6.unlock = unlock

        function debounce(v232, v233) -- line 1941
            v232:lock()
            task.wait(v233)
            v232:unlock()
            return v232
        end

        v6.debounce = debounce

        function autoDeselect(v234, v235) -- line 1947
            if v235 == nil then
                v234.deselectWhenOtherIconSelected = true
            else
                v234.deselectWhenOtherIconSelected = v235
            end
            return v234
        end

        v6.autoDeselect = autoDeselect

        function oneClick(v236, v237) -- line 1957
            local singleClickJanitor = v236.singleClickJanitor
            singleClickJanitor:clean()
            if v237 or v237 == nil then
                singleClickJanitor:add(v236.selected:Connect(function() -- line 1961 | captures: v236
                    v236:deselect("OneClick", v236)
                end))
            end
            v236.oneClickEnabled = true
            return v236
        end

        v6.oneClick = oneClick

        function setCaption(v238, v239) -- line 1972 | captures: Elements
            if v239 == "_hotkey_" then
                if not v238.captionText then
                    local captionJanitor = v238.captionJanitor
                    v238.captionJanitor:clean()
                    if not v239 or v239 == "" then
                        v238.caption = nil
                        v238.captionText = nil
                    else
                        local v240 = captionJanitor:add(require(Elements.Caption)(v238))
                        v240:SetAttribute("CaptionText", v239)
                        v238.caption = v240
                        v238.captionText = v239
                    end
                end
            else
                local captionJanitor = v238.captionJanitor
                v238.captionJanitor:clean()
                if v239 then
                    if v239 == "" then
                        v238.caption = nil
                        v238.captionText = nil
                    else
                        local v241 = captionJanitor:add(require(Elements.Caption)(v238))
                        v241:SetAttribute("CaptionText", v239)
                        v238.caption = v241
                        v238.captionText = v239
                    end
                else
                    v238.caption = nil
                    v238.captionText = nil
                end
            end
            return v238
        end

        v6.setCaption = setCaption

        function setCaptionHint(v242, v243) -- line 2011
            local v244 = typeof(v243) == "EnumItem"
            assert(v244, "argument[1] must be a KeyCode EnumItem!")
            v242.fakeToggleKey = v243
            v242.fakeToggleKeyChanged:Fire(v243)
            v242:setCaption("_hotkey_")
            return v242
        end

        v6.setCaptionHint = setCaptionHint

        function leave(v245) -- line 2019
            v245.joinJanitor:clean()
            return v245
        end

        v6.leave = leave

        function joinMenu(v246, v247) -- line 2023 | captures: v5
            v5.joinFeature(v246, v247, v247.menuIcons, v247:getInstance("Menu"))
            v247.menuChildAdded:Fire(v246)
            return v246
        end

        v6.joinMenu = joinMenu

        function setMenu(v248, v249) -- line 2028
            v248.menuSet:Fire(v249)
            return v248
        end

        v6.setMenu = setMenu

        function setFixedMenu(v250, v251) -- line 2032
            v250:freezeMenu(v251)
            v250:setMenu(v251)
        end

        v6.setFixedMenu = setFixedMenu
        Gamepad = v6.setFixedMenu
        v6.setFrozenMenu = Gamepad

        function freezeMenu(v252) -- line 2037
            v252:select("FrozenMenu", v252)
            v252:bindEvent("deselected", function(v253) -- line 2039 | captures: v252
                v253:select("FrozenMenu", v252)
            end)
            v252:modifyTheme({ "IconSpot", "Visible", false })
        end

        v6.freezeMenu = freezeMenu

        function joinDropdown(v254, v255) -- line 2044 | captures: v5
            v255:getDropdown()
            v5.joinFeature(v254, v255, v255.dropdownIcons, v255:getInstance("DropdownScroller"))
            v255.dropdownChildAdded:Fire(v254)
            return v254
        end

        v6.joinDropdown = joinDropdown

        function getDropdown(v256) -- line 2050 | captures: Elements
            local dropdown = v256.dropdown
            if not dropdown then
                dropdown = require(Elements.Dropdown)(v256)
                v256.dropdown = dropdown
                v256:clipOutside(dropdown)
            end
            return dropdown
        end

        v6.getDropdown = getDropdown

        function setDropdown(v257, v258) -- line 2060
            v257:getDropdown()
            v257.dropdownSet:Fire(v258)
            return v257
        end

        v6.setDropdown = setDropdown

        function clipOutside(v259, v260) -- line 2065 | captures: v5
            local v261 = v5.clipOutside(v259, v260)
            v259:refreshAppearance(v260)
            return v259, v261
        end

        v6.clipOutside = clipOutside

        function setIndicator(v262, v263) -- line 2070 | captures: Elements, v6
            if not v262.indicator then
                local Indicator = require(Elements.Indicator)
                v262.indicator = v262.janitor:add(Indicator(v262, v6))
            end
            v262.indicatorSet:Fire(v263)
        end

        v6.setIndicator = setIndicator

        function convertLabelToNumberSpinner(v264, v265, v266) -- line 2077
            task.defer(function() -- line 2078 | captures: v264, v265, v266
                local IconLabel = v264:getInstance("IconLabel")
                IconLabel.Transparency = 1
                v265.Parent = IconLabel.Parent
                v265.Size = UDim2.fromScale(1, 1)
                v265.AnchorPoint = Vector2.new(0.5, 0.5)
                v265.Position = UDim2.new(0.5, 0, 0.5, 0)
                v265.TextXAlignment = Enum.TextXAlignment.Center
                v265.ClipsDescendants = false
                local v267 = { "FontFace", "BorderSizePixel", "BorderColor3", "Rotation", "TextStrokeTransparency", "TextStrokeColor3", "TextStrokeTransparency", "TextColor3" }
                for v268, v269 in ipairs(v267) do
                    v265[v269] = IconLabel[v269]
                    local v270 = IconLabel:GetPropertyChangedSignal(v269)
                    local v271 = v269
                    v264:addToJanitor(v270:Connect(function() -- line 2101 | captures: IconLabel, v271, v265
                        v265[v271] = IconLabel[v271]
                    end))
                end

                local function getSpinnerSizeAndDigitCount() -- line 2105 | captures: v265
                    local v272 = 0
                    local v273 = 0
                    for v274, v275 in v265.Frame:GetChildren() do
                        local v276 = string.lower(v275.Name)
                        if v276 == "digit" or v276 == "prefix" and v275.Text ~= "" then
                            v272 += v275.AbsoluteSize.X
                            v273 += 1
                        end
                    end
                    return v272, v273
                end

                local function getLabelParentContainerXSize() -- line 2124 | captures: IconLabel, v265
                    local Parent = IconLabel.Parent
                    local v277 = Parent and Parent.Parent
                    if v277 == nil then
                        return 0
                    end
                    if v277.IconImage.Visible == true then
                        return v265.Frame.AbsoluteSize.X + IconLabel.Parent.Parent.IconImage.AbsoluteSize.X
                    end
                    return v277.AbsoluteSize.X
                end

                local function getNumberSpinnerXSize() -- line 2138 | captures: v265
                    return v265.Frame.AbsoluteSize.X
                end

                local function adjustSize() -- line 2141 | captures: IconLabel, getSpinnerSizeAndDigitCount, v264, v265
                    local v278, v279 = getSpinnerSizeAndDigitCount()
                    if v279 < 18 then
                        v264:setLabel(v265.Value)
                    end
                    local X = v265.Frame.AbsoluteSize.X
                    while v278 < X do
                        if v264.isDestroyed ~= true then
                            task.wait(0.05)
                            if not (v279 > 0 and v279 < 8) then
                                v265.TextSize += 1
                                X = v265.Frame.AbsoluteSize.X
                                v278, v279 = getSpinnerSizeAndDigitCount()
                                continue
                            end
                            v265.TextSize = IconLabel.TextSize
                        end
                        break
                    end
                    local Parent = IconLabel.Parent
                    local v280 = Parent and Parent.Parent
                    local v281
                    if v280 == nil then
                        v281 = 0
                    elseif v280.IconImage.Visible == true then
                        v281 = v265.Frame.AbsoluteSize.X + IconLabel.Parent.Parent.IconImage.AbsoluteSize.X
                    else
                        v281 = v280.AbsoluteSize.X
                    end
                    while true do
                        if v281 < v278 then
                            if v264.isDestroyed == true then
                                return
                            end
                            task.wait(0.05)
                            if v279 < 8 and v279 > 0 then
                                break
                            end
                            v265.TextSize -= 1
                            local Parent = IconLabel.Parent
                            Parent = Parent and Parent.Parent
                            if Parent == nil then
                                v281 = 0
                            elseif Parent.IconImage.Visible == true then
                                v281 = v265.Frame.AbsoluteSize.X + IconLabel.Parent.Parent.IconImage.AbsoluteSize.X
                            else
                                v281 = Parent.AbsoluteSize.X
                            end
                            v278, v279 = getSpinnerSizeAndDigitCount()
                            continue
                        end
                        return
                    end
                    v265.TextSize = IconLabel.TextSize
                end

                v264:addToJanitor(v265.Frame.ChildAdded:Connect(adjustSize))
                v264:addToJanitor(v265.Frame.ChildRemoved:Connect(adjustSize))
                local iconAdded = v264.iconAdded
                v264:addToJanitor(iconAdded:Connect(function() -- line 2206 | captures: adjustSize
                    task.wait(1)
                    adjustSize()
                end))
                v264:updateParent()
                v265.Name = "LabelSpinner"
                v265.Prefix = "$"
                v265.Commas = true
                v265.Decimals = 0
                v265.Duration = 0.25
                v265.Value = 10
                task.wait(0.2)
                if typeof(v266) == "function" then
                    v266()
                end
            end)
            return v264
        end

        v6.convertLabelToNumberSpinner = convertLabelToNumberSpinner

        function destroy(v282) -- line 2224 | captures: v6
            if v282.isDestroyed then
                return
            end
            v282:clearNotices()
            if v282.parentIconUID then
                v282:leave()
            end
            v282.isDestroyed = true
            v282.janitor:clean()
            v6.iconRemoved:Fire(v282)
        end

        v6.destroy = destroy
        Gamepad = v6.destroy
        v6.Destroy = Gamepad
        return v6
    end
    return require(v2)
end

if not v1 then
    Reference.addToReplicatedStorage()
end
GoodSignal_2 = require(script_2.Packages.GoodSignal)
GoodSignal = GoodSignal_2
v3 = require(script_2.Packages.Janitor)
v5 = require(script_2.Utility)
v4 = require(script_2.Features.Themes)
Gamepad = require(script_2.Features.Gamepad)
Overflow = require(script_2.Features.Overflow)
v11 = {}
v6 = v11
v11.__index = v11
LocalPlayer = Players.LocalPlayer
v12 = {}
v7 = v12
v8 = GoodSignal_2.new()
Elements_2 = script_2.Elements
Elements = Elements_2
v9 = 0
v10 = {
    mobile = Enum.PreferredInput.Touch,
    desktop = Enum.PreferredInput.KeyboardAndMouse,
    console = Enum.PreferredInput.Gamepad
}
v11.baseDisplayOrderChanged = GoodSignal_2.new()
v11.baseDisplayOrder = 10
v11.baseTheme = require(script_2.Features.Themes.Default)
v11.isOldTopbar = false
v11.iconsDictionary = v12
v11.insetHeightChanged = GoodSignal_2.new()
v11.container = require(Elements_2.Container)(v11)
v11.topbarEnabled = true
v11.iconAdded = GoodSignal_2.new()
v11.iconRemoved = GoodSignal_2.new()
v11.iconChanged = GoodSignal_2.new()

function getIcons() -- line 49 | captures: v6
    return v6.iconsDictionary
end

v6.getIcons = getIcons

function getIconByUID(v283) -- line 52 | captures: v6
    return v6.iconsDictionary[v283] or nil
end

v6.getIconByUID = getIconByUID

function getIcon(v284) -- line 59 | captures: v6, v7
    local v285 = v6.getIconByUID(v284)
    if v285 then
        return v285
    end
    for v286, v287 in pairs(v7) do
        if v287.name == v284 then
            return v287
        end
    end
    return nil
end

v6.getIcon = getIcon

function setTopbarEnabled(v288, v289) -- line 71 | captures: v6
    local v290 = if typeof(v288) == "boolean" then v288 else v6.topbarEnabled
    if not v289 then
        v6.topbarEnabled = v290
    end
    for v291, v292 in pairs(v6.container) do
        v292.Enabled = v290
    end
end

v6.setTopbarEnabled = setTopbarEnabled

function modifyBaseTheme(v293) -- line 85 | captures: v4, v6, v7
    local v294 = v4.getModifications(v293)
    for v295, v296 in pairs(v294) do
        for v297, v298 in pairs(v6.baseTheme) do
            v4.merge(v298, v296)
        end
    end
    for v299, v300 in pairs(v7) do
        v300:setTheme(v6.baseTheme)
    end
end

v6.modifyBaseTheme = modifyBaseTheme

function setDisplayOrder(v301) -- line 96 | captures: v6
    v6.baseDisplayOrder = v301
    v6.baseDisplayOrderChanged:Fire(v301)
end

v6.setDisplayOrder = setDisplayOrder
task.defer(Gamepad.start, v6)
task.defer(Overflow.start, v6)
task.defer(function() -- line 102 | captures: LocalPlayer, v6, script_2
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    for v302, v303 in pairs(v6.container) do
        v303.Parent = PlayerGui
    end
    require(script_2.Attribute)
end)

function new() -- line 109 | captures: Elements, GoodSignal, v3, v5, v6, v7, v8, v9, v10, UserInputService, StarterGui, script_2
    local v304 = {}
    local v305 = v6
    setmetatable(v304, v305)
    local v306 = v3.new()
    v304.janitor = v306
    v304.themesJanitor = v306:add(v3.new())
    v304.singleClickJanitor = v306:add(v3.new())
    v304.captionJanitor = v306:add(v3.new())
    v304.joinJanitor = v306:add(v3.new())
    v304.menuJanitor = v306:add(v3.new())
    v304.dropdownJanitor = v306:add(v3.new())
    local v307 = v5.generateUID()
    v7[v307] = v304
    v306:add(function() -- line 122 | captures: v307, v7
        v7[v307] = nil
    end)
    v304.selected = v306:add(GoodSignal.new())
    v304.deselected = v306:add(GoodSignal.new())
    v304.toggled = v306:add(GoodSignal.new())
    v304.viewingStarted = v306:add(GoodSignal.new())
    v304.viewingEnded = v306:add(GoodSignal.new())
    v304.stateChanged = v306:add(GoodSignal.new())
    v304.notified = v306:add(GoodSignal.new())
    v304.noticeStarted = v306:add(GoodSignal.new())
    v304.noticeChanged = v306:add(GoodSignal.new())
    v304.endNotices = v306:add(GoodSignal.new())
    v304.toggleKeyAdded = v306:add(GoodSignal.new())
    v304.fakeToggleKeyChanged = v306:add(GoodSignal.new())
    v304.alignmentChanged = v306:add(GoodSignal.new())
    v304.updateSize = v306:add(GoodSignal.new())
    v304.resizingComplete = v306:add(GoodSignal.new())
    v304.joinedParent = v306:add(GoodSignal.new())
    v304.menuSet = v306:add(GoodSignal.new())
    v304.dropdownSet = v306:add(GoodSignal.new())
    v304.updateMenu = v306:add(GoodSignal.new())
    v304.startMenuUpdate = v306:add(GoodSignal.new())
    v304.childThemeModified = v306:add(GoodSignal.new())
    v304.indicatorSet = v306:add(GoodSignal.new())
    v304.dropdownChildAdded = v306:add(GoodSignal.new())
    v304.menuChildAdded = v306:add(GoodSignal.new())
    v304.iconModule = script_2
    v304.UID = v307
    v304.isEnabled = true
    v304.enabled = v304.isEnabled
    v304.isSelected = false
    v304.isViewing = false
    v304.joinedFrame = false
    v304.parentIconUID = false
    v304.deselectWhenOtherIconSelected = true
    v304.totalNotices = 0
    v304.activeState = "Deselected"
    v304.alignment = ""
    v304.originalAlignment = ""
    v304.appliedTheme = {}
    v304.appearance = {}
    v304.cachedInstances = {}
    v304.cachedNamesToInstances = {}
    v304.cachedCollectives = {}
    v304.bindedToggleKeys = {}
    v304.customBehaviours = {}
    v304.toggleItems = {}
    v304.bindedEvents = {}
    v304.notices = {}
    v304.menuIcons = {}
    v304.dropdownIcons = {}
    v304.childIconsDict = {}
    v304.creationTime = os.clock()
    v304.widget = v306:add(require(Elements.Widget)(v304, v6))
    v304:setAlignment()
    v9 += 1
    local v308 = v9 * 0.01 + 1
    v304:setOrder(v308, "deselected")
    v304:setOrder(v308, "selected")
    v304:setTheme(v6.baseTheme)
    local ClickRegion = v304:getInstance("ClickRegion")
    local v309 = false
    local v310 = 0

    local function handleToggle() -- line 188 | captures: v310, v304
        if not v304.locked then
            local v311 = tick()
            if not (v311 - v310 < 0.1) then
                v310 = v311
                if v304.isSelected then
                    v304:deselect("User", v304)
                else
                    v304:select("User", v304)
                end
            end
        end
    end

    ClickRegion.MouseButton1Click:Connect(function() -- line 204 | captures: v309, v310, v304
        v309 = true
        if not v304.locked then
            local v312 = tick()
            if not (v312 - v310 < 0.1) then
                v310 = v312
                if v304.isSelected then
                    v304:deselect("User", v304)
                else
                    v304:select("User", v304)
                end
            end
        end
    end)
    ClickRegion.TouchTap:Connect(function() -- line 221 | captures: v309, v310, v304
        if not (v309 or v304.locked) then
            local v313 = tick()
            if not (v313 - v310 < 0.1) then
                v310 = v313
                if v304.isSelected then
                    v304:deselect("User", v304)
                else
                    v304:select("User", v304)
                end
            end
        end
    end)
    v306:add(UserInputService.InputBegan:Connect(function(v314, v315) -- line 237 | captures: v310, v304
        if v304.locked or not v304.bindedToggleKeys[v314.KeyCode] or v315 or v304.locked then
            return
        end
        local v316 = tick()
        if not (v316 - v310 < 0.1) then
            v310 = v316
            if v304.isSelected then
                v304:deselect("User", v304)
            else
                v304:select("User", v304)
            end
        end
    end))

    local function viewingEnded() -- line 253 | captures: v304
        if v304.locked then
            return
        end
        v304.isViewing = false
        v304.viewingEnded:Fire(true)
        v304:setState(nil, "User", v304)
    end

    v304.joinedParent:Connect(function() -- line 261 | captures: v304
        if not v304.isViewing or v304.locked then
            return
        end
        v304.isViewing = false
        v304.viewingEnded:Fire(true)
        v304:setState(nil, "User", v304)
    end)
    ClickRegion.MouseEnter:Connect(function() -- line 269 | captures: v304, v10, UserInputService
        local v317 = UserInputService.PreferredInput ~= v10.desktop
        if v304.locked then
            return
        end
        v304.isViewing = true
        v304.viewingStarted:Fire(true)
        if not v317 then
            v304:setState("Viewing", "User", v304)
        end
    end)
    local v318 = 0
    v306:add(UserInputService.TouchEnded:Connect(viewingEnded))
    ClickRegion.MouseLeave:Connect(viewingEnded)
    ClickRegion.SelectionGained:Connect(function(v319) -- line 283 | captures: v304
        if v304.locked then
            return
        end
        v304.isViewing = true
        v304.viewingStarted:Fire(true)
        if not v319 then
            v304:setState("Viewing", "User", v304)
        end
    end)
    ClickRegion.SelectionLost:Connect(viewingEnded)
    ClickRegion.MouseButton1Down:Connect(function() -- line 294 | captures: v318, v304, v10, UserInputService
        if v304.locked or not (UserInputService.PreferredInput == v10.mobile) then
            return
        end
        v318 += 1
        local v320 = v318
        task.delay(0.2, function() -- line 298 | captures: v320, v318, v304
            if v320 ~= v318 or v304.locked then
                return
            end
            v304.isViewing = true
            v304.viewingStarted:Fire(true)
            v304:setState("Viewing", "User", v304)
        end)
    end)
    ClickRegion.MouseButton1Up:Connect(function() -- line 308 | captures: v318
        v318 += 1
    end)
    local IconOverlay = v304:getInstance("IconOverlay")
    v304.viewingStarted:Connect(function() -- line 312 | captures: v304, IconOverlay
        IconOverlay.Visible = not v304.overlayDisabled
    end)
    v304.viewingEnded:Connect(function() -- line 315 | captures: IconOverlay
        IconOverlay.Visible = false
    end)
    v306:add(v8:Connect(function(v321) -- line 318 | captures: v304
        if v321 ~= v304 and v304.deselectWhenOtherIconSelected and v321.deselectWhenOtherIconSelected then
            v304:deselect("AutoDeselect", v321)
        end
    end))
    local s = debug.info(2, "s")
    local v322 = string.split(s, ".")
    local game_2 = game
    local v323 = game_2
    local v324
    for v325, v326 in pairs(v322) do
        v323 = v323:FindFirstChild(v326)
        if v323 then
            if v323:IsA("ScreenGui") then
                v324 = v323
            end
        else
            game_2 = v323
            break
        end
        game_2 = v323
    end
    if game_2 and v324 and v324.ResetOnSpawn == true then
        v304.originsScreenGui = v324
        v5.localPlayerRespawned(function() -- line 338 | captures: v304
            v304:destroy()
        end)
    end
    v304.toggled:Connect(function(v327) -- line 342 | captures: v304, v6
        v304.noticeChanged:Fire(v304.totalNotices)
        for v328, v329 in pairs(v304.childIconsDict) do
            local v330 = v6.getIconByUID(v328)
            v330.noticeChanged:Fire(v330.totalNotices)
            if not v327 and v330.isSelected then
                for v331, v332 in pairs(v330.childIconsDict) do
                    v330:deselect("HideParentFeature", v304)
                end
            end
        end
    end)
    v304.selected:Connect(function() -- line 356 | captures: v304, StarterGui
        if #v304.dropdownIcons > 0 then
            if StarterGui:GetCore("ChatActive") and v304.alignment ~= "Right" then
                v304.chatWasPreviouslyActive = true
                StarterGui:SetCore("ChatActive", false)
            end
            if StarterGui:GetCoreGuiEnabled("PlayerList") and v304.alignment ~= "Left" then
                v304.playerlistWasPreviouslyActive = true
                StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
            end
        end
    end)
    v304.deselected:Connect(function() -- line 370 | captures: v304, StarterGui
        if v304.chatWasPreviouslyActive then
            v304.chatWasPreviouslyActive = nil
            StarterGui:SetCore("ChatActive", true)
        end
        if v304.playerlistWasPreviouslyActive then
            v304.playerlistWasPreviouslyActive = nil
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
        end
    end)
    task.delay(0.1, function() -- line 380 | captures: v304
        if v304.activeState == "Deselected" then
            v304.stateChanged:Fire("Deselected")
            v304:refresh()
        end
    end)
    v6.iconAdded:Fire(v304)
    return v304
end

v6.new = new

function setName(v333, v334) -- line 389
    v333.widget.Name = v334
    v333.name = v334
    return v333
end

v6.setName = setName

function setState(v335, v336, v337, v338) -- line 394 | captures: v5, v8
    local v339
    if v336 then
        v339 = v336
    elseif v335.isSelected then
        v339 = "Selected"
    else
        v339 = "Deselected"
    end
    local v340 = v5.formatStateName(v339)
    if v335.activeState == v340 then
        return
    end
    local isSelected = v335.isSelected
    v335.activeState = v340
    if v340 == "Deselected" then
        v335.isSelected = false
        if isSelected then
            v335.toggled:Fire(false, v337, v338)
            v335.deselected:Fire(v337, v338)
        end
        v335:_setToggleItemsVisible(false, v337, v338)
    elseif v340 == "Selected" then
        v335.isSelected = true
        if not isSelected then
            v335.toggled:Fire(true, v337, v338)
            v335.selected:Fire(v337, v338)
            v8:Fire(v335, v337, v338)
        end
        v335:_setToggleItemsVisible(true, v337, v338)
    end
    v335.stateChanged:Fire(v340, v337, v338)
end

v6.setState = setState

function getInstance(v341, v342) -- line 430 | captures: v4
    local v343
    local v344 = v341.cachedNamesToInstances[v342]
    if v344 then
        return v344
    end

    local function cacheInstance(v345, v346) -- line 436 | captures: v341
        if v341.cachedInstances[v346] then
            return
        end
        local Collective = v346:GetAttribute("Collective")
        local v347 = Collective and v341.cachedCollectives[Collective]
        if v347 then
            table.insert(v347, v346)
        end
        v341.cachedNamesToInstances[v345] = v346
        v341.cachedInstances[v346] = true
        v346.Destroying:Once(function() -- line 448 | captures: v345, v346, v341
            v341.cachedNamesToInstances[v345] = nil
            v341.cachedInstances[v346] = nil
        end)
    end

    local widget = v341.widget
    cacheInstance("Widget", widget)
    if v342 == "Widget" then
        return widget
    end
    local v348

    function v348(v349) -- line 459 | captures: v348, v343, v341, v342, cacheInstance, v4
        for v350, v351 in pairs(v349:GetChildren()) do
            local WidgetUID = v351:GetAttribute("WidgetUID")
            if WidgetUID then
                if WidgetUID == v341.UID then
                    local v352 = v4.getRealInstance(v351) or v351
                    v348(v352)
                    if v352:IsA("GuiBase") or v352:IsA("UIBase") or v352:IsA("ValueBase") then
                        local Name = v352.Name
                        cacheInstance(Name, v352)
                        if Name == v342 then
                            v343 = v352
                        end
                    end
                end
            else
                local v353 = v4.getRealInstance(v351) or v351
                v348(v353)
                if v353:IsA("GuiBase") or v353:IsA("UIBase") or v353:IsA("ValueBase") then
                    local Name = v353.Name
                    cacheInstance(Name, v353)
                    if Name == v342 then
                        v343 = v353
                    end
                end
            end
        end
    end

    v348(widget)
    return v343
end

v6.getInstance = getInstance

function getCollective(v354, v355) -- line 482
    local v356 = v354.cachedCollectives[v355]
    if v356 then
        return v356
    end
    local v357 = {}
    for v358, v359 in pairs(v354.cachedInstances) do
        if v358:GetAttribute("Collective") == v355 then
            table.insert(v357, v358)
        end
    end
    v354.cachedCollectives[v355] = v357
    return v357
end

v6.getCollective = getCollective

function getInstanceOrCollective(v360, v361) -- line 496
    local v362 = {}
    local v363 = v360:getInstance(v361)
    if v363 then
        table.insert(v362, v363)
    end
    if #v362 == 0 then
        v362 = v360:getCollective(v361)
    end
    return v362
end

v6.getInstanceOrCollective = getInstanceOrCollective

function getStateGroup(v364, v365) -- line 507
    local v366 = v365 or v364.activeState
    local v367 = v364.appearance[v366]
    if not v367 then
        v367 = {}
        v364.appearance[v366] = v367
    end
    return v367
end

v6.getStateGroup = getStateGroup

function refreshAppearance(v368, v369, v370) -- line 519 | captures: v4
    v4.refresh(v368, v369, v370)
    return v368
end

v6.refreshAppearance = refreshAppearance

function refresh(v371) -- line 523
    v371:refreshAppearance(v371.widget)
    v371.updateSize:Fire()
    return v371
end

v6.refresh = refresh

function updateParent(v372) -- line 528 | captures: v6
    local v373 = v6.getIconByUID(v372.parentIconUID)
    if v373 then
        v373.updateSize:Fire()
    end
end

v6.updateParent = updateParent

function setBehaviour(v374, v375, v376, v377, v378) -- line 534
    v374.customBehaviours[v375 .. "-" .. v376] = v377
    if v378 then
        local v379 = v374:getInstanceOrCollective(v375)
        for v380, v381 in pairs(v379) do
            v374:refreshAppearance(v381, v376)
        end
    end
end

v6.setBehaviour = setBehaviour

function modifyTheme(v382, v383, v384) -- line 543 | captures: v4
    return v382, (v4.modify(v382, v383, v384))
end

v6.modifyTheme = modifyTheme

function modifyChildTheme(v385, v386, v387) -- line 547 | captures: v6
    v385.childModifications = v386
    v385.childModificationsUID = v387
    for v388, v389 in pairs(v385.childIconsDict) do
        v6.getIconByUID(v388):modifyTheme(v386, v387)
    end
    v385.childThemeModified:Fire()
    return v385
end

v6.modifyChildTheme = modifyChildTheme

function removeModification(v390, v391) -- line 556 | captures: v4
    v4.remove(v390, v391)
    return v390
end

v6.removeModification = removeModification

function removeModificationWith(v392, v393, v394, v395) -- line 560 | captures: v4
    v4.removeWith(v392, v393, v394, v395)
    return v392
end

v6.removeModificationWith = removeModificationWith

function setTheme(v396, v397) -- line 564 | captures: v4
    v4.set(v396, v397)
    return v396
end

v6.setTheme = setTheme

function setEnabled(v398, v399) -- line 568
    v398.isEnabled = v399
    v398.enabled = v398.isEnabled
    v398.widget.Visible = v399
    v398:updateParent()
    return v398
end

v6.setEnabled = setEnabled

function select(v400, v401, v402) -- line 575
    v400:setState("Selected", v401, v402)
    return v400
end

v6.select = select

function deselect(v403, v404, v405) -- line 579
    v403:setState("Deselected", v404, v405)
    return v403
end

v6.deselect = deselect

function notify(v406, v407, v408) -- line 583 | captures: Elements, v6
    if not v406.notice then
        v406.notice = require(Elements.Notice)(v406, v6)
    end
    v406.noticeStarted:Fire(v407, v408)
    return v406
end

v6.notify = notify

function clearNotices(v409) -- line 591
    v409.endNotices:Fire()
    return v409
end

v6.clearNotices = clearNotices

function disableOverlay(v410, v411) -- line 595
    v410.overlayDisabled = v411
    return v410
end

v6.disableOverlay = disableOverlay
Gamepad = v6.disableOverlay
v6.disableStateOverlay = Gamepad

function setImage(v412, v413, v414) -- line 600 | captures: ContentProvider
    v412:modifyTheme({ "IconImage", "Image", v413, v414 })
    task.spawn(function() -- line 602 | captures: v413, ContentProvider
        local v415
        if tonumber(v413) then
            v415 = ("rbxassetid://%*"):format(v413)
        else
            v415 = v413
        end
        if ContentProvider:GetAssetFetchStatus(v415) ~= Enum.AssetFetchStatus.Success then
            pcall(ContentProvider.PreloadAsync, ContentProvider, { v415 })
        end
    end)
    return v412
end

v6.setImage = setImage

function setLabel(v416, v417, v418) -- line 616
    v416:modifyTheme({ "IconLabel", "Text", v417, v418 })
    return v416
end

v6.setLabel = setLabel

function setOrder(v419, v420, v421) -- line 620
    local v422 = v420 * 100
    v419:modifyTheme({ "IconSpot", "LayoutOrder", v422, v421 })
    v419:modifyTheme({ "Widget", "LayoutOrder", v422, v421 })
    return v419
end

v6.setOrder = setOrder

function setCornerRadius(v423, v424, v425) -- line 626
    v423:modifyTheme({ "IconCorners", "CornerRadius", v424, v425 })
    return v423
end

v6.setCornerRadius = setCornerRadius

function align(v426, v427, v428) -- line 630 | captures: v6
    local v429 = tostring(v427):lower()
    if v429 == "mid" then
        v429 = "center"
    end
    if not (v429 == "left" or v429 == "center" or v429 == "right") then
        v429 = "left"
    end
    local v430 = if v429 == "center" then v6.container.TopbarCentered else v6.container.TopbarStandard
    local v431 = string.upper((string.sub(v429, 1, 1))) .. string.sub(v429, 2)
    if not v428 then
        v426.originalAlignment = v431
    end
    local joinedFrame = v426.joinedFrame
    local v432 = v430.Holders[v431]
    v426.screenGui = v430
    v426.alignmentHolder = v432
    if not v426.isDestroyed then
        v426.widget.Parent = joinedFrame or v432
    end
    v426.alignment = v431
    v426.alignmentChanged:Fire(v431)
    v6.iconChanged:Fire(v426)
    return v426
end

v6.align = align
Gamepad = v6.align
v6.setAlignment = Gamepad

function setLeft(v433) -- line 663
    v433:setAlignment("Left")
    return v433
end

v6.setLeft = setLeft

function setMid(v434) -- line 667
    v434:setAlignment("Center")
    return v434
end

v6.setMid = setMid

function setRight(v435) -- line 671
    v435:setAlignment("Right")
    return v435
end

v6.setRight = setRight

function setWidth(v436, v437, v438) -- line 675
    v436:modifyTheme({ "Widget", "DesiredWidth", v437, v438 })
    return v436
end

v6.setWidth = setWidth

function setImageScale(v439, v440, v441) -- line 679
    v439:modifyTheme({ "IconImageScale", "Value", v440, v441 })
    return v439
end

v6.setImageScale = setImageScale

function setImageRatio(v442, v443, v444) -- line 683
    v442:modifyTheme({ "IconImageRatio", "AspectRatio", v443, v444 })
    return v442
end

v6.setImageRatio = setImageRatio

function setTextSize(v445, v446, v447) -- line 687
    v445:modifyTheme({ "IconLabel", "TextSize", v446, v447 })
    return v445
end

v6.setTextSize = setTextSize

function setTextFont(v448, v449, v450, v451, v452) -- line 691
    local v453 = v450 or Enum.FontWeight.Regular
    local v454 = v451 or Enum.FontStyle.Normal
    local v455 = typeof(v449)
    local v456
    if v455 == "number" then
        v456 = Font.fromId(v449, v453, v454)
    elseif v455 == "EnumItem" then
        v456 = Font.fromEnum(v449)
    elseif v455 == "string" then
        if v449:match("rbxasset") then
        else
            v456 = Font.fromName(v449, v453, v454)
        end
    end
    v448:modifyTheme({
        "IconLabel",
        "FontFace",
        v456 or Font.new(v449, v453, v454),
        v452
    })
    return v448
end

v6.setTextFont = setTextFont

function setTextColor(v457, v458, v459) -- line 717
    local v460
    if v458 == nil then
        if v458 ~= nil and v458 ~= "" then
            warn("setTextColor item must be a Color3 value! Changed the color to white.")
        end
        v460 = Color3.fromRGB(255, 255, 255)
    elseif v458 == "" then
    elseif type(v458) == "userdata" and typeof(v458) == "Color3" then
        v460 = v458
    end
    v457:modifyTheme({ "IconLabel", "TextColor3", v460, v459 })
    return v457
end

v6.setTextColor = setTextColor

function bindToggleItem(v461, v462) -- line 730
    if not v462:IsA("GuiObject") and not v462:IsA("LayerCollector") then
        error("Toggle item must be a GuiObject or LayerCollector!")
    end
    v461.toggleItems[v462] = true
    v461:_updateSelectionInstances()
    return v461
end

v6.bindToggleItem = bindToggleItem

function unbindToggleItem(v463, v464) -- line 738
    v463.toggleItems[v464] = nil
    v463:_updateSelectionInstances()
    return v463
end

v6.unbindToggleItem = unbindToggleItem

function _updateSelectionInstances(v465) -- line 743
    for v466, v467 in pairs(v465.toggleItems) do
        local v468 = {}
        for v469, v470 in pairs(v466:GetDescendants()) do
            if v470:IsA("TextButton") then
                if v470.Active then
                    table.insert(v468, v470)
                end
            elseif v470:IsA("ImageButton") then
            end
        end
        v465.toggleItems[v466] = v468
    end
end

v6._updateSelectionInstances = _updateSelectionInstances

function _setToggleItemsVisible(v471, v472, v473, v474) -- line 759
    for v475, v476 in pairs(v471.toggleItems) do
        if v474 then
            if v474 == v471 or v474.toggleItems[v475] == nil then
            end
        else
            local v477 = if v475:IsA("LayerCollector") then "Enabled" else "Visible"
            v475[v477] = v472
        end
    end
end

v6._setToggleItemsVisible = _setToggleItemsVisible

function bindEvent(v478, v479, v480) -- line 770
    local v481 = v478[v479]
    local v482
    if v481 then
        if typeof(v481) == "table" then
            v482 = v481.Connect
        else
            v482 = false
        end
    else
        v482 = v481
    end
    assert(v482, "argument[1] must be a valid topbarplus icon event name!")
    local v483 = typeof(v480) == "function"
    assert(v483, "argument[2] must be a function!")
    v478.bindedEvents[v479] = v481:Connect(function(...) -- line 780 | captures: v478, v480
        v480(v478, ...)
    end)
    return v478
end

v6.bindEvent = bindEvent

function unbindEvent(v484, v485) -- line 785
    local v486 = v484.bindedEvents[v485]
    if v486 then
        v486:Disconnect()
        v484.bindedEvents[v485] = nil
    end
    return v484
end

v6.unbindEvent = unbindEvent

function bindToggleKey(v487, v488) -- line 793
    local v489 = typeof(v488) == "EnumItem"
    assert(v489, "argument[1] must be a KeyCode EnumItem!")
    v487.bindedToggleKeys[v488] = true
    v487.toggleKeyAdded:Fire(v488)
    v487:setCaption("_hotkey_")
    return v487
end

v6.bindToggleKey = bindToggleKey

function unbindToggleKey(v490, v491) -- line 801
    local v492 = typeof(v491) == "EnumItem"
    assert(v492, "argument[1] must be a KeyCode EnumItem!")
    v490.bindedToggleKeys[v491] = nil
    return v490
end

v6.unbindToggleKey = unbindToggleKey

function call(v493, v494, ...) -- line 807
    local v495 = table.pack(...)
    task.spawn(function() -- line 809 | captures: v493, v494, v495
        v494(v493, table.unpack(v495))
    end)
    return v493
end

v6.call = call

function addToJanitor(v496, v497, v498, v499) -- line 814
    v496.janitor:add(v497, v498, v499)
    return v496
end

v6.addToJanitor = addToJanitor

function lock(v500) -- line 818
    v500:getInstance("ClickRegion").Visible = false
    v500.locked = true
    return v500
end

v6.lock = lock

function unlock(v501) -- line 824
    v501:getInstance("ClickRegion").Visible = true
    v501.locked = false
    return v501
end

v6.unlock = unlock

function debounce(v502, v503) -- line 830
    v502:lock()
    task.wait(v503)
    v502:unlock()
    return v502
end

v6.debounce = debounce

function autoDeselect(v504, v505) -- line 836
    if v505 == nil then
        v504.deselectWhenOtherIconSelected = true
    else
        v504.deselectWhenOtherIconSelected = v505
    end
    return v504
end

v6.autoDeselect = autoDeselect

function oneClick(v506, v507) -- line 846
    local singleClickJanitor = v506.singleClickJanitor
    singleClickJanitor:clean()
    if v507 or v507 == nil then
        singleClickJanitor:add(v506.selected:Connect(function() -- line 850 | captures: v506
            v506:deselect("OneClick", v506)
        end))
    end
    v506.oneClickEnabled = true
    return v506
end

v6.oneClick = oneClick

function setCaption(v508, v509) -- line 861 | captures: Elements
    if v509 == "_hotkey_" then
        if not v508.captionText then
            local captionJanitor = v508.captionJanitor
            v508.captionJanitor:clean()
            if not v509 or v509 == "" then
                v508.caption = nil
                v508.captionText = nil
            else
                local v510 = captionJanitor:add(require(Elements.Caption)(v508))
                v510:SetAttribute("CaptionText", v509)
                v508.caption = v510
                v508.captionText = v509
            end
        end
    else
        local captionJanitor = v508.captionJanitor
        v508.captionJanitor:clean()
        if v509 then
            if v509 == "" then
                v508.caption = nil
                v508.captionText = nil
            else
                local v511 = captionJanitor:add(require(Elements.Caption)(v508))
                v511:SetAttribute("CaptionText", v509)
                v508.caption = v511
                v508.captionText = v509
            end
        else
            v508.caption = nil
            v508.captionText = nil
        end
    end
    return v508
end

v6.setCaption = setCaption

function setCaptionHint(v512, v513) -- line 900
    local v514 = typeof(v513) == "EnumItem"
    assert(v514, "argument[1] must be a KeyCode EnumItem!")
    v512.fakeToggleKey = v513
    v512.fakeToggleKeyChanged:Fire(v513)
    v512:setCaption("_hotkey_")
    return v512
end

v6.setCaptionHint = setCaptionHint

function leave(v515) -- line 908
    v515.joinJanitor:clean()
    return v515
end

v6.leave = leave

function joinMenu(v516, v517) -- line 912 | captures: v5
    v5.joinFeature(v516, v517, v517.menuIcons, v517:getInstance("Menu"))
    v517.menuChildAdded:Fire(v516)
    return v516
end

v6.joinMenu = joinMenu

function setMenu(v518, v519) -- line 917
    v518.menuSet:Fire(v519)
    return v518
end

v6.setMenu = setMenu

function setFixedMenu(v520, v521) -- line 921
    v520:freezeMenu(v521)
    v520:setMenu(v521)
end

v6.setFixedMenu = setFixedMenu
Gamepad = v6.setFixedMenu
v6.setFrozenMenu = Gamepad

function freezeMenu(v522) -- line 926
    v522:select("FrozenMenu", v522)
    v522:bindEvent("deselected", function(v523) -- line 928 | captures: v522
        v523:select("FrozenMenu", v522)
    end)
    v522:modifyTheme({ "IconSpot", "Visible", false })
end

v6.freezeMenu = freezeMenu

function joinDropdown(v524, v525) -- line 933 | captures: v5
    v525:getDropdown()
    v5.joinFeature(v524, v525, v525.dropdownIcons, v525:getInstance("DropdownScroller"))
    v525.dropdownChildAdded:Fire(v524)
    return v524
end

v6.joinDropdown = joinDropdown

function getDropdown(v526) -- line 939 | captures: Elements
    local dropdown = v526.dropdown
    if not dropdown then
        dropdown = require(Elements.Dropdown)(v526)
        v526.dropdown = dropdown
        v526:clipOutside(dropdown)
    end
    return dropdown
end

v6.getDropdown = getDropdown

function setDropdown(v527, v528) -- line 949
    v527:getDropdown()
    v527.dropdownSet:Fire(v528)
    return v527
end

v6.setDropdown = setDropdown

function clipOutside(v529, v530) -- line 954 | captures: v5
    local v531 = v5.clipOutside(v529, v530)
    v529:refreshAppearance(v530)
    return v529, v531
end

v6.clipOutside = clipOutside

function setIndicator(v532, v533) -- line 959 | captures: Elements, v6
    if not v532.indicator then
        local Indicator = require(Elements.Indicator)
        v532.indicator = v532.janitor:add(Indicator(v532, v6))
    end
    v532.indicatorSet:Fire(v533)
end

v6.setIndicator = setIndicator

function convertLabelToNumberSpinner(v534, v535, v536) -- line 966
    task.defer(function() -- line 967 | captures: v534, v535, v536
        local IconLabel = v534:getInstance("IconLabel")
        IconLabel.Transparency = 1
        v535.Parent = IconLabel.Parent
        v535.Size = UDim2.fromScale(1, 1)
        v535.AnchorPoint = Vector2.new(0.5, 0.5)
        v535.Position = UDim2.new(0.5, 0, 0.5, 0)
        v535.TextXAlignment = Enum.TextXAlignment.Center
        v535.ClipsDescendants = false
        local v537 = { "FontFace", "BorderSizePixel", "BorderColor3", "Rotation", "TextStrokeTransparency", "TextStrokeColor3", "TextStrokeTransparency", "TextColor3" }
        for v538, v539 in ipairs(v537) do
            v535[v539] = IconLabel[v539]
            local v540 = IconLabel:GetPropertyChangedSignal(v539)
            local v541 = v539
            v534:addToJanitor(v540:Connect(function() -- line 990 | captures: IconLabel, v541, v535
                v535[v541] = IconLabel[v541]
            end))
        end

        local function getSpinnerSizeAndDigitCount() -- line 994 | captures: v535
            local v542 = 0
            local v543 = 0
            for v544, v545 in v535.Frame:GetChildren() do
                local v546 = string.lower(v545.Name)
                if v546 == "digit" or v546 == "prefix" and v545.Text ~= "" then
                    v542 += v545.AbsoluteSize.X
                    v543 += 1
                end
            end
            return v542, v543
        end

        local function getLabelParentContainerXSize() -- line 1013 | captures: IconLabel, v535
            local Parent = IconLabel.Parent
            local v547 = Parent and Parent.Parent
            if v547 == nil then
                return 0
            end
            if v547.IconImage.Visible == true then
                return v535.Frame.AbsoluteSize.X + IconLabel.Parent.Parent.IconImage.AbsoluteSize.X
            end
            return v547.AbsoluteSize.X
        end

        local function getNumberSpinnerXSize() -- line 1027 | captures: v535
            return v535.Frame.AbsoluteSize.X
        end

        local function adjustSize() -- line 1030 | captures: IconLabel, getSpinnerSizeAndDigitCount, v534, v535
            local v548, v549 = getSpinnerSizeAndDigitCount()
            if v549 < 18 then
                v534:setLabel(v535.Value)
            end
            local X = v535.Frame.AbsoluteSize.X
            while v548 < X do
                if v534.isDestroyed ~= true then
                    task.wait(0.05)
                    if not (v549 > 0 and v549 < 8) then
                        v535.TextSize += 1
                        X = v535.Frame.AbsoluteSize.X
                        v548, v549 = getSpinnerSizeAndDigitCount()
                        continue
                    end
                    v535.TextSize = IconLabel.TextSize
                end
                break
            end
            local Parent = IconLabel.Parent
            local v550 = Parent and Parent.Parent
            local v551
            if v550 == nil then
                v551 = 0
            elseif v550.IconImage.Visible == true then
                v551 = v535.Frame.AbsoluteSize.X + IconLabel.Parent.Parent.IconImage.AbsoluteSize.X
            else
                v551 = v550.AbsoluteSize.X
            end
            while true do
                if v551 < v548 then
                    if v534.isDestroyed == true then
                        return
                    end
                    task.wait(0.05)
                    if v549 < 8 and v549 > 0 then
                        break
                    end
                    v535.TextSize -= 1
                    local Parent = IconLabel.Parent
                    Parent = Parent and Parent.Parent
                    if Parent == nil then
                        v551 = 0
                    elseif Parent.IconImage.Visible == true then
                        v551 = v535.Frame.AbsoluteSize.X + IconLabel.Parent.Parent.IconImage.AbsoluteSize.X
                    else
                        v551 = Parent.AbsoluteSize.X
                    end
                    v548, v549 = getSpinnerSizeAndDigitCount()
                    continue
                end
                return
            end
            v535.TextSize = IconLabel.TextSize
        end

        v534:addToJanitor(v535.Frame.ChildAdded:Connect(adjustSize))
        v534:addToJanitor(v535.Frame.ChildRemoved:Connect(adjustSize))
        local iconAdded = v534.iconAdded
        v534:addToJanitor(iconAdded:Connect(function() -- line 1095 | captures: adjustSize
            task.wait(1)
            adjustSize()
        end))
        v534:updateParent()
        v535.Name = "LabelSpinner"
        v535.Prefix = "$"
        v535.Commas = true
        v535.Decimals = 0
        v535.Duration = 0.25
        v535.Value = 10
        task.wait(0.2)
        if typeof(v536) == "function" then
            v536()
        end
    end)
    return v534
end

v6.convertLabelToNumberSpinner = convertLabelToNumberSpinner

function destroy(v552) -- line 1113 | captures: v6
    if v552.isDestroyed then
        return
    end
    v552:clearNotices()
    if v552.parentIconUID then
        v552:leave()
    end
    v552.isDestroyed = true
    v552.janitor:clean()
    v6.iconRemoved:Fire(v552)
end

v6.destroy = destroy
Gamepad = v6.destroy
v6.Destroy = Gamepad
return v6
