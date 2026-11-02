-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
require(script.Types)
local script_2 = script
local Reference = require(script_2.Reference)
local v1 = Reference.getObject()
local v2 = v1 and v1.Value
local Elements, GoodSignal, v3, LocalPlayer, v4, v5, v6, v7, v8, v9, GoodSignal_2, Gamepad, Overflow, v10, v11, Elements_2, getIcons, getIconByUID, getIcon, setTopbarEnabled, modifyBaseTheme, setDisplayOrder, new, setName, setState, getInstance, getCollective, getInstanceOrCollective, getStateGroup, refreshAppearance, refresh, updateParent, setBehaviour, modifyTheme, modifyChildTheme, removeModification, removeModificationWith, setTheme, setEnabled, select, deselect, notify, clearNotices, disableOverlay, setImage, setLabel, setOrder, setCornerRadius, align, setLeft, setMid, setRight, setWidth, setImageScale, setImageRatio, setTextSize, setTextFont, bindToggleItem, unbindToggleItem, _updateSelectionInstances, _setToggleItemsVisible, bindEvent, unbindEvent, bindToggleKey, unbindToggleKey, call, addToJanitor, lock, unlock, debounce, autoDeselect, oneClick, setCaption, setCaptionHint, leave, joinMenu, setMenu, setFrozenMenu, freezeMenu, joinDropdown, getDropdown, setDropdown, clipOutside, setIndicator, convertLabelToNumberSpinner, destroy

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
        v10 = {}
        v6 = v10
        v10.__index = v10
        LocalPlayer = Players.LocalPlayer
        v11 = {}
        v7 = v11
        v8 = GoodSignal_2.new()
        Elements_2 = script_2.Elements
        Elements = Elements_2
        v9 = 0
        v10.baseDisplayOrderChanged = GoodSignal_2.new()
        v10.baseDisplayOrder = 10
        v10.baseTheme = require(script_2.Features.Themes.Default)
        v10.isOldTopbar = false
        v10.iconsDictionary = v11
        v10.insetHeightChanged = GoodSignal_2.new()
        v10.container = require(Elements_2.Container)(v10)
        v10.topbarEnabled = true
        v10.iconAdded = GoodSignal_2.new()
        v10.iconRemoved = GoodSignal_2.new()
        v10.iconChanged = GoodSignal_2.new()

        function getIcons() -- line 1099 | captures: v6
            return v6.iconsDictionary
        end

        v6.getIcons = getIcons

        function getIconByUID(v12) -- line 1102 | captures: v6
            return v6.iconsDictionary[v12] or nil
        end

        v6.getIconByUID = getIconByUID

        function getIcon(v13) -- line 1109 | captures: v6, v7
            local v14 = v6.getIconByUID(v13)
            if v14 then
                return v14
            end
            for v15, v16 in pairs(v7) do
                if v16.name == v13 then
                    return v16
                end
            end
            return nil
        end

        v6.getIcon = getIcon

        function setTopbarEnabled(v17, v18) -- line 1121 | captures: v6
            local v19 = if typeof(v17) == "boolean" then v17 else v6.topbarEnabled
            if not v18 then
                v6.topbarEnabled = v19
            end
            for v20, v21 in pairs(v6.container) do
                v21.Enabled = v19
            end
        end

        v6.setTopbarEnabled = setTopbarEnabled

        function modifyBaseTheme(v22) -- line 1135 | captures: v4, v6, v7
            local v23 = v4.getModifications(v22)
            for v24, v25 in pairs(v23) do
                for v26, v27 in pairs(v6.baseTheme) do
                    v4.merge(v27, v25)
                end
            end
            for v28, v29 in pairs(v7) do
                v29:setTheme(v6.baseTheme)
            end
        end

        v6.modifyBaseTheme = modifyBaseTheme

        function setDisplayOrder(v30) -- line 1146 | captures: v6
            v6.baseDisplayOrder = v30
            v6.baseDisplayOrderChanged:Fire(v30)
        end

        v6.setDisplayOrder = setDisplayOrder
        task.defer(Gamepad.start, v6)
        task.defer(Overflow.start, v6)
        task.defer(function() -- line 1152 | captures: LocalPlayer, v6, script_2
            local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
            for v31, v32 in pairs(v6.container) do
                v32.Parent = PlayerGui
            end
            require(script_2.Attribute)
        end)

        function new() -- line 1159 | captures: Elements, GoodSignal, v3, v5, v6, v7, v8, v9, UserInputService, StarterGui, script_2
            local v33 = {}
            local v34 = v6
            setmetatable(v33, v34)
            local v35 = v3.new()
            v33.janitor = v35
            v33.themesJanitor = v35:add(v3.new())
            v33.singleClickJanitor = v35:add(v3.new())
            v33.captionJanitor = v35:add(v3.new())
            v33.joinJanitor = v35:add(v3.new())
            v33.menuJanitor = v35:add(v3.new())
            v33.dropdownJanitor = v35:add(v3.new())
            local v36 = v5.generateUID()
            v7[v36] = v33
            v35:add(function() -- line 1172 | captures: v36, v7
                v7[v36] = nil
            end)
            v33.selected = v35:add(GoodSignal.new())
            v33.deselected = v35:add(GoodSignal.new())
            v33.toggled = v35:add(GoodSignal.new())
            v33.viewingStarted = v35:add(GoodSignal.new())
            v33.viewingEnded = v35:add(GoodSignal.new())
            v33.stateChanged = v35:add(GoodSignal.new())
            v33.notified = v35:add(GoodSignal.new())
            v33.noticeStarted = v35:add(GoodSignal.new())
            v33.noticeChanged = v35:add(GoodSignal.new())
            v33.endNotices = v35:add(GoodSignal.new())
            v33.toggleKeyAdded = v35:add(GoodSignal.new())
            v33.fakeToggleKeyChanged = v35:add(GoodSignal.new())
            v33.alignmentChanged = v35:add(GoodSignal.new())
            v33.updateSize = v35:add(GoodSignal.new())
            v33.resizingComplete = v35:add(GoodSignal.new())
            v33.joinedParent = v35:add(GoodSignal.new())
            v33.menuSet = v35:add(GoodSignal.new())
            v33.dropdownSet = v35:add(GoodSignal.new())
            v33.updateMenu = v35:add(GoodSignal.new())
            v33.startMenuUpdate = v35:add(GoodSignal.new())
            v33.childThemeModified = v35:add(GoodSignal.new())
            v33.indicatorSet = v35:add(GoodSignal.new())
            v33.dropdownChildAdded = v35:add(GoodSignal.new())
            v33.menuChildAdded = v35:add(GoodSignal.new())
            v33.iconModule = script_2
            v33.UID = v36
            v33.isEnabled = true
            v33.enabled = v33.isEnabled
            v33.isSelected = false
            v33.isViewing = false
            v33.joinedFrame = false
            v33.parentIconUID = false
            v33.deselectWhenOtherIconSelected = true
            v33.totalNotices = 0
            v33.activeState = "Deselected"
            v33.alignment = ""
            v33.originalAlignment = ""
            v33.appliedTheme = {}
            v33.appearance = {}
            v33.cachedInstances = {}
            v33.cachedNamesToInstances = {}
            v33.cachedCollectives = {}
            v33.bindedToggleKeys = {}
            v33.customBehaviours = {}
            v33.toggleItems = {}
            v33.bindedEvents = {}
            v33.notices = {}
            v33.menuIcons = {}
            v33.dropdownIcons = {}
            v33.childIconsDict = {}
            v33.creationTime = os.clock()
            v33.widget = v35:add(require(Elements.Widget)(v33, v6))
            v33:setAlignment()
            v9 += 1
            local v37 = v9 * 0.01 + 1
            v33:setOrder(v37, "deselected")
            v33:setOrder(v37, "selected")
            v33:setTheme(v6.baseTheme)
            local ClickRegion = v33:getInstance("ClickRegion")

            local function handleToggle() -- line 1235 | captures: v33
                if not v33.locked then
                    if v33.isSelected then
                        v33:deselect("User", v33)
                    else
                        v33:select("User", v33)
                    end
                end
            end

            local v38 = false
            local v39 = false
            ClickRegion.MouseButton1Click:Connect(function() -- line 1247 | captures: v38, v39, v33
                if v38 then
                    return
                end
                v39 = true
                task.delay(0.01, function() -- line 1252 | captures: v39
                    v39 = false
                end)
                if not v33.locked then
                    if v33.isSelected then
                        v33:deselect("User", v33)
                    else
                        v33:select("User", v33)
                    end
                end
            end)
            ClickRegion.TouchTap:Connect(function() -- line 1264 | captures: v38, v39, v33
                if v39 then
                    return
                end
                v38 = true
                task.delay(0.01, function() -- line 1269 | captures: v38
                    v38 = false
                end)
                if not v33.locked then
                    if v33.isSelected then
                        v33:deselect("User", v33)
                    else
                        v33:select("User", v33)
                    end
                end
            end)
            v35:add(UserInputService.InputBegan:Connect(function(v40, v41) -- line 1281 | captures: v33
                if not v33.locked and v33.bindedToggleKeys[v40.KeyCode] and not v41 and not v33.locked then
                    if v33.isSelected then
                        v33:deselect("User", v33)
                    else
                        v33:select("User", v33)
                    end
                end
            end))

            local function viewingEnded() -- line 1291 | captures: v33
                if v33.locked then
                    return
                end
                v33.isViewing = false
                v33.viewingEnded:Fire(true)
                v33:setState(nil, "User", v33)
            end

            v33.joinedParent:Connect(function() -- line 1299 | captures: v33
                if not v33.isViewing or v33.locked then
                    return
                end
                v33.isViewing = false
                v33.viewingEnded:Fire(true)
                v33:setState(nil, "User", v33)
            end)
            ClickRegion.MouseEnter:Connect(function() -- line 1307 | captures: v33, UserInputService
                local v42 = not UserInputService.KeyboardEnabled
                if v33.locked then
                    return
                end
                v33.isViewing = true
                v33.viewingStarted:Fire(true)
                if not v42 then
                    v33:setState("Viewing", "User", v33)
                end
            end)
            local v43 = 0
            v35:add(UserInputService.TouchEnded:Connect(viewingEnded))
            ClickRegion.MouseLeave:Connect(viewingEnded)
            ClickRegion.SelectionGained:Connect(function(v44) -- line 1321 | captures: v33
                if v33.locked then
                    return
                end
                v33.isViewing = true
                v33.viewingStarted:Fire(true)
                if not v44 then
                    v33:setState("Viewing", "User", v33)
                end
            end)
            ClickRegion.SelectionLost:Connect(viewingEnded)
            ClickRegion.MouseButton1Down:Connect(function() -- line 1332 | captures: v43, v33, UserInputService
                if v33.locked or not UserInputService.TouchEnabled then
                    return
                end
                v43 += 1
                local v45 = v43
                task.delay(0.2, function() -- line 1336 | captures: v45, v43, v33
                    if v45 ~= v43 or v33.locked then
                        return
                    end
                    v33.isViewing = true
                    v33.viewingStarted:Fire(true)
                    v33:setState("Viewing", "User", v33)
                end)
            end)
            ClickRegion.MouseButton1Up:Connect(function() -- line 1346 | captures: v43
                v43 += 1
            end)
            local IconOverlay = v33:getInstance("IconOverlay")
            v33.viewingStarted:Connect(function() -- line 1350 | captures: v33, IconOverlay
                IconOverlay.Visible = not v33.overlayDisabled
            end)
            v33.viewingEnded:Connect(function() -- line 1353 | captures: IconOverlay
                IconOverlay.Visible = false
            end)
            v35:add(v8:Connect(function(v46) -- line 1356 | captures: v33
                if v46 ~= v33 and v33.deselectWhenOtherIconSelected and v46.deselectWhenOtherIconSelected then
                    v33:deselect("AutoDeselect", v46)
                end
            end))
            local s = debug.info(2, "s")
            local v47 = string.split(s, ".")
            local game_2 = game
            local v48 = game_2
            local v49
            for v50, v51 in pairs(v47) do
                v48 = v48:FindFirstChild(v51)
                if v48 then
                    if v48:IsA("ScreenGui") then
                        v49 = v48
                    end
                else
                    game_2 = v48
                    break
                end
                game_2 = v48
            end
            if game_2 and v49 and v49.ResetOnSpawn == true then
                v5.localPlayerRespawned(function() -- line 1375 | captures: v33
                    v33:destroy()
                end)
            end
            v33.toggled:Connect(function(v52) -- line 1379 | captures: v33, v6
                v33.noticeChanged:Fire(v33.totalNotices)
                for v53, v54 in pairs(v33.childIconsDict) do
                    local v55 = v6.getIconByUID(v53)
                    v55.noticeChanged:Fire(v55.totalNotices)
                    if not v52 and v55.isSelected then
                        for v56, v57 in pairs(v55.childIconsDict) do
                            v55:deselect("HideParentFeature", v33)
                        end
                    end
                end
            end)
            v33.selected:Connect(function() -- line 1393 | captures: v33, StarterGui
                if #v33.dropdownIcons > 0 then
                    if StarterGui:GetCore("ChatActive") and v33.alignment ~= "Right" then
                        v33.chatWasPreviouslyActive = true
                        StarterGui:SetCore("ChatActive", false)
                    end
                    if StarterGui:GetCoreGuiEnabled("PlayerList") and v33.alignment ~= "Left" then
                        v33.playerlistWasPreviouslyActive = true
                        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
                    end
                end
            end)
            v33.deselected:Connect(function() -- line 1407 | captures: v33, StarterGui
                if v33.chatWasPreviouslyActive then
                    v33.chatWasPreviouslyActive = nil
                    StarterGui:SetCore("ChatActive", true)
                end
                if v33.playerlistWasPreviouslyActive then
                    v33.playerlistWasPreviouslyActive = nil
                    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
                end
            end)
            task.delay(0.1, function() -- line 1417 | captures: v33
                if v33.activeState == "Deselected" then
                    v33.stateChanged:Fire("Deselected")
                    v33:refresh()
                end
            end)
            v6.iconAdded:Fire(v33)
            return v33
        end

        v6.new = new

        function setName(v58, v59) -- line 1426
            v58.widget.Name = v59
            v58.name = v59
            return v58
        end

        v6.setName = setName

        function setState(v60, v61, v62, v63) -- line 1431 | captures: v5, v8
            local v64
            if v61 then
                v64 = v61
            elseif v60.isSelected then
                v64 = "Selected"
            else
                v64 = "Deselected"
            end
            local v65 = v5.formatStateName(v64)
            if v60.activeState == v65 then
                return
            end
            local isSelected = v60.isSelected
            v60.activeState = v65
            if v65 == "Deselected" then
                v60.isSelected = false
                if isSelected then
                    v60.toggled:Fire(false, v62, v63)
                    v60.deselected:Fire(v62, v63)
                end
                v60:_setToggleItemsVisible(false, v62, v63)
            elseif v65 == "Selected" then
                v60.isSelected = true
                if not isSelected then
                    v60.toggled:Fire(true, v62, v63)
                    v60.selected:Fire(v62, v63)
                    v8:Fire(v60, v62, v63)
                end
                v60:_setToggleItemsVisible(true, v62, v63)
            end
            v60.stateChanged:Fire(v65, v62, v63)
        end

        v6.setState = setState

        function getInstance(v66, v67) -- line 1467 | captures: v4
            local v68
            local v69 = v66.cachedNamesToInstances[v67]
            if v69 then
                return v69
            end

            local function cacheInstance(v70, v71) -- line 1473 | captures: v66
                if v66.cachedInstances[v71] then
                    return
                end
                local Collective = v71:GetAttribute("Collective")
                local v72 = Collective and v66.cachedCollectives[Collective]
                if v72 then
                    table.insert(v72, v71)
                end
                v66.cachedNamesToInstances[v70] = v71
                v66.cachedInstances[v71] = true
                v71.Destroying:Once(function() -- line 1485 | captures: v70, v71, v66
                    v66.cachedNamesToInstances[v70] = nil
                    v66.cachedInstances[v71] = nil
                end)
            end

            local widget = v66.widget
            cacheInstance("Widget", widget)
            if v67 == "Widget" then
                return widget
            end
            local v73

            function v73(v74) -- line 1496 | captures: v73, v68, v66, v67, cacheInstance, v4
                for v75, v76 in pairs(v74:GetChildren()) do
                    local WidgetUID = v76:GetAttribute("WidgetUID")
                    if WidgetUID then
                        if WidgetUID == v66.UID then
                        end
                    else
                        local v77 = v4.getRealInstance(v76) or v76
                        v73(v77)
                        if v77:IsA("GuiBase") then
                            local Name = v77.Name
                            cacheInstance(Name, v77)
                            if Name == v67 then
                                v68 = v77
                            end
                        elseif v77:IsA("UIBase") or v77:IsA("ValueBase") then
                        end
                    end
                end
            end

            v73(widget)
            return nil
        end

        v6.getInstance = getInstance

        function getCollective(v78, v79) -- line 1521
            local v80 = v78.cachedCollectives[v79]
            if v80 then
                return v80
            end
            local v81 = {}
            for v82, v83 in pairs(v78.cachedInstances) do
                if v82:GetAttribute("Collective") == v79 then
                    table.insert(v81, v82)
                end
            end
            v78.cachedCollectives[v79] = v81
            return v81
        end

        v6.getCollective = getCollective

        function getInstanceOrCollective(v84, v85) -- line 1535
            local v86 = {}
            local v87 = v84:getInstance(v85)
            if v87 then
                table.insert(v86, v87)
            end
            if #v86 == 0 then
                v86 = v84:getCollective(v85)
            end
            return v86
        end

        v6.getInstanceOrCollective = getInstanceOrCollective

        function getStateGroup(v88, v89) -- line 1546
            local v90 = v89 or v88.activeState
            local v91 = v88.appearance[v90]
            if not v91 then
                v91 = {}
                v88.appearance[v90] = v91
            end
            return v91
        end

        v6.getStateGroup = getStateGroup

        function refreshAppearance(v92, v93, v94) -- line 1558 | captures: v4
            v4.refresh(v92, v93, v94)
            return v92
        end

        v6.refreshAppearance = refreshAppearance

        function refresh(v95) -- line 1562
            v95:refreshAppearance(v95.widget)
            v95.updateSize:Fire()
            return v95
        end

        v6.refresh = refresh

        function updateParent(v96) -- line 1567 | captures: v6
            local v97 = v6.getIconByUID(v96.parentIconUID)
            if v97 then
                v97.updateSize:Fire()
            end
        end

        v6.updateParent = updateParent

        function setBehaviour(v98, v99, v100, v101, v102) -- line 1573
            v98.customBehaviours[v99 .. "-" .. v100] = v101
            if v102 then
                local v103 = v98:getInstanceOrCollective(v99)
                for v104, v105 in pairs(v103) do
                    v98:refreshAppearance(v105, v100)
                end
            end
        end

        v6.setBehaviour = setBehaviour

        function modifyTheme(v106, v107, v108) -- line 1582 | captures: v4
            return v106, (v4.modify(v106, v107, v108))
        end

        v6.modifyTheme = modifyTheme

        function modifyChildTheme(v109, v110, v111) -- line 1586 | captures: v6
            v109.childModifications = v110
            v109.childModificationsUID = v111
            for v112, v113 in pairs(v109.childIconsDict) do
                v6.getIconByUID(v112):modifyTheme(v110, v111)
            end
            v109.childThemeModified:Fire()
            return v109
        end

        v6.modifyChildTheme = modifyChildTheme

        function removeModification(v114, v115) -- line 1595 | captures: v4
            v4.remove(v114, v115)
            return v114
        end

        v6.removeModification = removeModification

        function removeModificationWith(v116, v117, v118, v119) -- line 1599 | captures: v4
            v4.removeWith(v116, v117, v118, v119)
            return v116
        end

        v6.removeModificationWith = removeModificationWith

        function setTheme(v120, v121) -- line 1603 | captures: v4
            v4.set(v120, v121)
            return v120
        end

        v6.setTheme = setTheme

        function setEnabled(v122, v123) -- line 1607
            v122.isEnabled = v123
            v122.enabled = v122.isEnabled
            v122.widget.Visible = v123
            v122:updateParent()
            return v122
        end

        v6.setEnabled = setEnabled

        function select(v124, v125, v126) -- line 1614
            v124:setState("Selected", v125, v126)
            return v124
        end

        v6.select = select

        function deselect(v127, v128, v129) -- line 1618
            v127:setState("Deselected", v128, v129)
            return v127
        end

        v6.deselect = deselect

        function notify(v130, v131, v132) -- line 1622 | captures: Elements, v6
            if not v130.notice then
                v130.notice = require(Elements.Notice)(v130, v6)
            end
            v130.noticeStarted:Fire(v131, v132)
            return v130
        end

        v6.notify = notify

        function clearNotices(v133) -- line 1630
            v133.endNotices:Fire()
            return v133
        end

        v6.clearNotices = clearNotices

        function disableOverlay(v134, v135) -- line 1634
            v134.overlayDisabled = v135
            return v134
        end

        v6.disableOverlay = disableOverlay
        Gamepad = v6.disableOverlay
        v6.disableStateOverlay = Gamepad

        function setImage(v136, v137, v138) -- line 1639
            v136:modifyTheme({ "IconImage", "Image", v137, v138 })
            return v136
        end

        v6.setImage = setImage

        function setLabel(v139, v140, v141) -- line 1643
            v139:modifyTheme({ "IconLabel", "Text", v140, v141 })
            return v139
        end

        v6.setLabel = setLabel

        function setOrder(v142, v143, v144) -- line 1647
            local v145 = v143 * 100
            v142:modifyTheme({ "IconSpot", "LayoutOrder", v145, v144 })
            v142:modifyTheme({ "Widget", "LayoutOrder", v145, v144 })
            return v142
        end

        v6.setOrder = setOrder

        function setCornerRadius(v146, v147, v148) -- line 1653
            v146:modifyTheme({ "IconCorners", "CornerRadius", v147, v148 })
            return v146
        end

        v6.setCornerRadius = setCornerRadius

        function align(v149, v150, v151) -- line 1657 | captures: v6
            local v152 = tostring(v150):lower()
            if v152 == "mid" then
                v152 = "center"
            end
            if not (v152 == "left" or v152 == "center" or v152 == "right") then
                v152 = "left"
            end
            local v153 = if v152 == "center" then v6.container.TopbarCentered else v6.container.TopbarStandard
            local v154 = string.upper((string.sub(v152, 1, 1))) .. string.sub(v152, 2)
            if not v151 then
                v149.originalAlignment = v154
            end
            local joinedFrame = v149.joinedFrame
            local v155 = v153.Holders[v154]
            v149.screenGui = v153
            v149.alignmentHolder = v155
            if not v149.isDestroyed then
                v149.widget.Parent = joinedFrame or v155
            end
            v149.alignment = v154
            v149.alignmentChanged:Fire(v154)
            v6.iconChanged:Fire(v149)
            return v149
        end

        v6.align = align
        Gamepad = v6.align
        v6.setAlignment = Gamepad

        function setLeft(v156) -- line 1690
            v156:setAlignment("Left")
            return v156
        end

        v6.setLeft = setLeft

        function setMid(v157) -- line 1694
            v157:setAlignment("Center")
            return v157
        end

        v6.setMid = setMid

        function setRight(v158) -- line 1698
            v158:setAlignment("Right")
            return v158
        end

        v6.setRight = setRight

        function setWidth(v159, v160, v161) -- line 1702
            v159:modifyTheme({ "Widget", "DesiredWidth", v160, v161 })
            return v159
        end

        v6.setWidth = setWidth

        function setImageScale(v162, v163, v164) -- line 1706
            v162:modifyTheme({ "IconImageScale", "Value", v163, v164 })
            return v162
        end

        v6.setImageScale = setImageScale

        function setImageRatio(v165, v166, v167) -- line 1710
            v165:modifyTheme({ "IconImageRatio", "AspectRatio", v166, v167 })
            return v165
        end

        v6.setImageRatio = setImageRatio

        function setTextSize(v168, v169, v170) -- line 1714
            v168:modifyTheme({ "IconLabel", "TextSize", v169, v170 })
            return v168
        end

        v6.setTextSize = setTextSize

        function setTextFont(v171, v172, v173, v174, v175) -- line 1718
            local v176 = v173 or Enum.FontWeight.Regular
            local v177 = v174 or Enum.FontStyle.Normal
            local v178 = typeof(v172)
            local v179
            if v178 == "number" then
                v179 = Font.fromId(v172, v176, v177)
            elseif v178 == "EnumItem" then
                v179 = Font.fromEnum(v172)
            elseif v178 == "string" then
                if v172:match("rbxasset") then
                else
                    v179 = Font.fromName(v172, v176, v177)
                end
            end
            v171:modifyTheme({
                "IconLabel",
                "FontFace",
                v179 or Font.new(v172, v176, v177),
                v175
            })
            return v171
        end

        v6.setTextFont = setTextFont

        function bindToggleItem(v180, v181) -- line 1744
            if not v181:IsA("GuiObject") and not v181:IsA("LayerCollector") then
                error("Toggle item must be a GuiObject or LayerCollector!")
            end
            v180.toggleItems[v181] = true
            v180:_updateSelectionInstances()
            return v180
        end

        v6.bindToggleItem = bindToggleItem

        function unbindToggleItem(v182, v183) -- line 1752
            v182.toggleItems[v183] = nil
            v182:_updateSelectionInstances()
            return v182
        end

        v6.unbindToggleItem = unbindToggleItem

        function _updateSelectionInstances(v184) -- line 1757
            for v185, v186 in pairs(v184.toggleItems) do
                local v187 = {}
                for v188, v189 in pairs(v185:GetDescendants()) do
                    if v189:IsA("TextButton") then
                        if v189.Active then
                            table.insert(v187, v189)
                        end
                    elseif v189:IsA("ImageButton") then
                    end
                end
                v184.toggleItems[v185] = v187
            end
        end

        v6._updateSelectionInstances = _updateSelectionInstances

        function _setToggleItemsVisible(v190, v191, v192, v193) -- line 1773
            for v194, v195 in pairs(v190.toggleItems) do
                if v193 then
                    if v193 == v190 or v193.toggleItems[v194] == nil then
                    end
                else
                    local v196 = if v194:IsA("LayerCollector") then "Enabled" else "Visible"
                    v194[v196] = v191
                end
            end
        end

        v6._setToggleItemsVisible = _setToggleItemsVisible

        function bindEvent(v197, v198, v199) -- line 1784
            local v200 = v197[v198]
            local v201
            if v200 then
                if typeof(v200) == "table" then
                    v201 = v200.Connect
                else
                    v201 = false
                end
            else
                v201 = v200
            end
            assert(v201, "argument[1] must be a valid topbarplus icon event name!")
            local v202 = typeof(v199) == "function"
            assert(v202, "argument[2] must be a function!")
            v197.bindedEvents[v198] = v200:Connect(function(...) -- line 1794 | captures: v197, v199
                v199(v197, ...)
            end)
            return v197
        end

        v6.bindEvent = bindEvent

        function unbindEvent(v203, v204) -- line 1799
            local v205 = v203.bindedEvents[v204]
            if v205 then
                v205:Disconnect()
                v203.bindedEvents[v204] = nil
            end
            return v203
        end

        v6.unbindEvent = unbindEvent

        function bindToggleKey(v206, v207) -- line 1807
            local v208 = typeof(v207) == "EnumItem"
            assert(v208, "argument[1] must be a KeyCode EnumItem!")
            v206.bindedToggleKeys[v207] = true
            v206.toggleKeyAdded:Fire(v207)
            v206:setCaption("_hotkey_")
            return v206
        end

        v6.bindToggleKey = bindToggleKey

        function unbindToggleKey(v209, v210) -- line 1815
            local v211 = typeof(v210) == "EnumItem"
            assert(v211, "argument[1] must be a KeyCode EnumItem!")
            v209.bindedToggleKeys[v210] = nil
            return v209
        end

        v6.unbindToggleKey = unbindToggleKey

        function call(v212, v213, ...) -- line 1821
            local v214 = table.pack(...)
            task.spawn(function() -- line 1823 | captures: v212, v213, v214
                v213(v212, table.unpack(v214))
            end)
            return v212
        end

        v6.call = call

        function addToJanitor(v215, v216, v217, v218) -- line 1828
            v215.janitor:add(v216, v217, v218)
            return v215
        end

        v6.addToJanitor = addToJanitor

        function lock(v219) -- line 1832
            v219:getInstance("ClickRegion").Visible = false
            v219.locked = true
            return v219
        end

        v6.lock = lock

        function unlock(v220) -- line 1838
            v220:getInstance("ClickRegion").Visible = true
            v220.locked = false
            return v220
        end

        v6.unlock = unlock

        function debounce(v221, v222) -- line 1844
            v221:lock()
            task.wait(v222)
            v221:unlock()
            return v221
        end

        v6.debounce = debounce

        function autoDeselect(v223, v224) -- line 1850
            if v224 == nil then
                v223.deselectWhenOtherIconSelected = true
            else
                v223.deselectWhenOtherIconSelected = v224
            end
            return v223
        end

        v6.autoDeselect = autoDeselect

        function oneClick(v225, v226) -- line 1860
            local singleClickJanitor = v225.singleClickJanitor
            singleClickJanitor:clean()
            if v226 or v226 == nil then
                singleClickJanitor:add(v225.selected:Connect(function() -- line 1864 | captures: v225
                    v225:deselect("OneClick", v225)
                end))
            end
            v225.oneClickEnabled = true
            return v225
        end

        v6.oneClick = oneClick

        function setCaption(v227, v228) -- line 1875 | captures: Elements
            if v228 == "_hotkey_" then
                if not v227.captionText then
                    local captionJanitor = v227.captionJanitor
                    v227.captionJanitor:clean()
                    if not v228 or v228 == "" then
                        v227.caption = nil
                        v227.captionText = nil
                    else
                        local v229 = captionJanitor:add(require(Elements.Caption)(v227))
                        v229:SetAttribute("CaptionText", v228)
                        v227.caption = v229
                        v227.captionText = v228
                    end
                end
            else
                local captionJanitor = v227.captionJanitor
                v227.captionJanitor:clean()
                if v228 then
                    if v228 == "" then
                        v227.caption = nil
                        v227.captionText = nil
                    else
                        local v230 = captionJanitor:add(require(Elements.Caption)(v227))
                        v230:SetAttribute("CaptionText", v228)
                        v227.caption = v230
                        v227.captionText = v228
                    end
                else
                    v227.caption = nil
                    v227.captionText = nil
                end
            end
            return v227
        end

        v6.setCaption = setCaption

        function setCaptionHint(v231, v232) -- line 1914
            local v233 = typeof(v232) == "EnumItem"
            assert(v233, "argument[1] must be a KeyCode EnumItem!")
            v231.fakeToggleKey = v232
            v231.fakeToggleKeyChanged:Fire(v232)
            v231:setCaption("_hotkey_")
            return v231
        end

        v6.setCaptionHint = setCaptionHint

        function leave(v234) -- line 1922
            v234.joinJanitor:clean()
            return v234
        end

        v6.leave = leave

        function joinMenu(v235, v236) -- line 1926 | captures: v5
            v5.joinFeature(v235, v236, v236.menuIcons, v236:getInstance("Menu"))
            v236.menuChildAdded:Fire(v235)
            return v235
        end

        v6.joinMenu = joinMenu

        function setMenu(v237, v238) -- line 1931
            v237.menuSet:Fire(v238)
            return v237
        end

        v6.setMenu = setMenu

        function setFrozenMenu(v239, v240) -- line 1935
            v239:freezeMenu(v240)
            v239:setMenu(v240)
        end

        v6.setFrozenMenu = setFrozenMenu

        function freezeMenu(v241) -- line 1939
            v241:select("FrozenMenu", v241)
            v241:bindEvent("deselected", function(v242) -- line 1941 | captures: v241
                v242:select("FrozenMenu", v241)
            end)
            v241:modifyTheme({ "IconSpot", "Visible", false })
        end

        v6.freezeMenu = freezeMenu

        function joinDropdown(v243, v244) -- line 1946 | captures: v5
            v244:getDropdown()
            v5.joinFeature(v243, v244, v244.dropdownIcons, v244:getInstance("DropdownScroller"))
            v244.dropdownChildAdded:Fire(v243)
            return v243
        end

        v6.joinDropdown = joinDropdown

        function getDropdown(v245) -- line 1952 | captures: Elements
            local dropdown = v245.dropdown
            if not dropdown then
                dropdown = require(Elements.Dropdown)(v245)
                v245.dropdown = dropdown
                v245:clipOutside(dropdown)
            end
            return dropdown
        end

        v6.getDropdown = getDropdown

        function setDropdown(v246, v247) -- line 1962
            v246:getDropdown()
            v246.dropdownSet:Fire(v247)
            return v246
        end

        v6.setDropdown = setDropdown

        function clipOutside(v248, v249) -- line 1967 | captures: v5
            local v250 = v5.clipOutside(v248, v249)
            v248:refreshAppearance(v249)
            return v248, v250
        end

        v6.clipOutside = clipOutside

        function setIndicator(v251, v252) -- line 1972 | captures: Elements, v6
            if not v251.indicator then
                local Indicator = require(Elements.Indicator)
                v251.indicator = v251.janitor:add(Indicator(v251, v6))
            end
            v251.indicatorSet:Fire(v252)
        end

        v6.setIndicator = setIndicator

        function convertLabelToNumberSpinner(v253, v254) -- line 1979
            local IconLabel = v253:getInstance("IconLabel")
            IconLabel.Transparency = 1
            v254.Parent = IconLabel.Parent
            v254.Size = UDim2.fromScale(1, 1)
            v254.AnchorPoint = Vector2.new(0.5, 0.5)
            v254.Position = UDim2.new(0.5, 0, 0.5, 0)
            v254.TextXAlignment = Enum.TextXAlignment.Center
            v254.ClipsDescendants = false
            local v255 = { "FontFace", "BorderSizePixel", "BorderColor3", "Rotation", "TextStrokeTransparency", "TextStrokeColor3", "TextStrokeTransparency", "TextColor3" }
            for v256, v257 in ipairs(v255) do
                v254[v257] = IconLabel[v257]
                local v258 = IconLabel:GetPropertyChangedSignal(v257)
                local v259 = v257
                v253:addToJanitor(v258:Connect(function() -- line 2002 | captures: v254, IconLabel, v259
                    v254[v259] = IconLabel[v259]
                end))
            end

            local function getSpinnerSizeAndDigitCount() -- line 2006 | captures: v254
                local v260 = 0
                local v261 = 0
                for v262, v263 in v254.Frame:GetChildren() do
                    local v264 = string.lower(v263.Name)
                    if v264 == "digit" or v264 == "prefix" and v263.Text ~= "" then
                        v260 += v263.AbsoluteSize.X
                        v261 += 1
                    end
                end
                return v260, v261
            end

            local function getLabelParentContainerXSize() -- line 2025 | captures: v254, IconLabel
                local Parent = IconLabel.Parent.Parent
                if Parent == nil then
                    return 0
                end
                if Parent.IconImage.Visible == true then
                    return v254.Frame.AbsoluteSize.X + IconLabel.Parent.Parent.IconImage.AbsoluteSize.X
                end
                return Parent.AbsoluteSize.X
            end

            local function getNumberSpinnerXSize() -- line 2035 | captures: v254
                return v254.Frame.AbsoluteSize.X
            end

            local function adjustSize() -- line 2038 | captures: v253, v254, IconLabel, getSpinnerSizeAndDigitCount
                local v265, v266 = getSpinnerSizeAndDigitCount()
                if v266 < 18 then
                    v253:setLabel(v254.Value)
                end
                local X = v254.Frame.AbsoluteSize.X
                while v265 < X do
                    if v253.isDestroyed ~= true then
                        task.wait(0.05)
                        if not (v266 > 0 and v266 < 8) then
                            v254.TextSize += 1
                            X = v254.Frame.AbsoluteSize.X
                            v265, v266 = getSpinnerSizeAndDigitCount()
                            continue
                        end
                        v254.TextSize = IconLabel.TextSize
                    end
                    break
                end
                local Parent = IconLabel.Parent.Parent
                local v267
                if Parent == nil then
                    v267 = 0
                elseif Parent.IconImage.Visible == true then
                    v267 = v254.Frame.AbsoluteSize.X + IconLabel.Parent.Parent.IconImage.AbsoluteSize.X
                else
                    v267 = Parent.AbsoluteSize.X
                end
                while true do
                    if v267 < v265 then
                        if v253.isDestroyed == true then
                            return
                        end
                        task.wait(0.05)
                        if v266 < 8 and v266 > 0 then
                            break
                        end
                        v254.TextSize -= 1
                        local Parent = IconLabel.Parent.Parent
                        local v268
                        if Parent == nil then
                            v268 = 0
                        elseif Parent.IconImage.Visible == true then
                            v268 = v254.Frame.AbsoluteSize.X + IconLabel.Parent.Parent.IconImage.AbsoluteSize.X
                        else
                            v268 = Parent.AbsoluteSize.X
                        end
                        v265, v266 = getSpinnerSizeAndDigitCount()
                        v267 = v268
                        continue
                    end
                    return
                end
                v254.TextSize = IconLabel.TextSize
            end

            v253:addToJanitor(v254.Frame.ChildAdded:Connect(adjustSize))
            v253:addToJanitor(v254.Frame.ChildRemoved:Connect(adjustSize))
            local iconAdded = v253.iconAdded
            v253:addToJanitor(iconAdded:Connect(function() -- line 2095 | captures: adjustSize
                task.wait(1)
                adjustSize()
            end))
            v253:updateParent()
            v254.Name = "LabelSpinner"
            v254.Prefix = "$"
            v254.Commas = true
            v254.Decimals = 0
            v254.Duration = 0.25
            v254.Value = 10
            task.wait(0.2)
            return v253
        end

        v6.convertLabelToNumberSpinner = convertLabelToNumberSpinner

        function destroy(v269) -- line 2109 | captures: v6
            if v269.isDestroyed then
                return
            end
            v269:clearNotices()
            if v269.parentIconUID then
                v269:leave()
            end
            v269.isDestroyed = true
            v269.janitor:clean()
            v6.iconRemoved:Fire(v269)
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
v10 = {}
v6 = v10
v10.__index = v10
LocalPlayer = Players.LocalPlayer
v11 = {}
v7 = v11
v8 = GoodSignal_2.new()
Elements_2 = script_2.Elements
Elements = Elements_2
v9 = 0
v10.baseDisplayOrderChanged = GoodSignal_2.new()
v10.baseDisplayOrder = 10
v10.baseTheme = require(script_2.Features.Themes.Default)
v10.isOldTopbar = false
v10.iconsDictionary = v11
v10.insetHeightChanged = GoodSignal_2.new()
v10.container = require(Elements_2.Container)(v10)
v10.topbarEnabled = true
v10.iconAdded = GoodSignal_2.new()
v10.iconRemoved = GoodSignal_2.new()
v10.iconChanged = GoodSignal_2.new()

function getIcons() -- line 43 | captures: v6
    return v6.iconsDictionary
end

v6.getIcons = getIcons

function getIconByUID(v270) -- line 46 | captures: v6
    return v6.iconsDictionary[v270] or nil
end

v6.getIconByUID = getIconByUID

function getIcon(v271) -- line 53 | captures: v6, v7
    local v272 = v6.getIconByUID(v271)
    if v272 then
        return v272
    end
    for v273, v274 in pairs(v7) do
        if v274.name == v271 then
            return v274
        end
    end
    return nil
end

v6.getIcon = getIcon

function setTopbarEnabled(v275, v276) -- line 65 | captures: v6
    local v277 = if typeof(v275) == "boolean" then v275 else v6.topbarEnabled
    if not v276 then
        v6.topbarEnabled = v277
    end
    for v278, v279 in pairs(v6.container) do
        v279.Enabled = v277
    end
end

v6.setTopbarEnabled = setTopbarEnabled

function modifyBaseTheme(v280) -- line 79 | captures: v4, v6, v7
    local v281 = v4.getModifications(v280)
    for v282, v283 in pairs(v281) do
        for v284, v285 in pairs(v6.baseTheme) do
            v4.merge(v285, v283)
        end
    end
    for v286, v287 in pairs(v7) do
        v287:setTheme(v6.baseTheme)
    end
end

v6.modifyBaseTheme = modifyBaseTheme

function setDisplayOrder(v288) -- line 90 | captures: v6
    v6.baseDisplayOrder = v288
    v6.baseDisplayOrderChanged:Fire(v288)
end

v6.setDisplayOrder = setDisplayOrder
task.defer(Gamepad.start, v6)
task.defer(Overflow.start, v6)
task.defer(function() -- line 96 | captures: LocalPlayer, v6, script_2
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    for v289, v290 in pairs(v6.container) do
        v290.Parent = PlayerGui
    end
    require(script_2.Attribute)
end)

function new() -- line 103 | captures: Elements, GoodSignal, v3, v5, v6, v7, v8, v9, UserInputService, StarterGui, script_2
    local v291 = {}
    local v292 = v6
    setmetatable(v291, v292)
    local v293 = v3.new()
    v291.janitor = v293
    v291.themesJanitor = v293:add(v3.new())
    v291.singleClickJanitor = v293:add(v3.new())
    v291.captionJanitor = v293:add(v3.new())
    v291.joinJanitor = v293:add(v3.new())
    v291.menuJanitor = v293:add(v3.new())
    v291.dropdownJanitor = v293:add(v3.new())
    local v294 = v5.generateUID()
    v7[v294] = v291
    v293:add(function() -- line 116 | captures: v294, v7
        v7[v294] = nil
    end)
    v291.selected = v293:add(GoodSignal.new())
    v291.deselected = v293:add(GoodSignal.new())
    v291.toggled = v293:add(GoodSignal.new())
    v291.viewingStarted = v293:add(GoodSignal.new())
    v291.viewingEnded = v293:add(GoodSignal.new())
    v291.stateChanged = v293:add(GoodSignal.new())
    v291.notified = v293:add(GoodSignal.new())
    v291.noticeStarted = v293:add(GoodSignal.new())
    v291.noticeChanged = v293:add(GoodSignal.new())
    v291.endNotices = v293:add(GoodSignal.new())
    v291.toggleKeyAdded = v293:add(GoodSignal.new())
    v291.fakeToggleKeyChanged = v293:add(GoodSignal.new())
    v291.alignmentChanged = v293:add(GoodSignal.new())
    v291.updateSize = v293:add(GoodSignal.new())
    v291.resizingComplete = v293:add(GoodSignal.new())
    v291.joinedParent = v293:add(GoodSignal.new())
    v291.menuSet = v293:add(GoodSignal.new())
    v291.dropdownSet = v293:add(GoodSignal.new())
    v291.updateMenu = v293:add(GoodSignal.new())
    v291.startMenuUpdate = v293:add(GoodSignal.new())
    v291.childThemeModified = v293:add(GoodSignal.new())
    v291.indicatorSet = v293:add(GoodSignal.new())
    v291.dropdownChildAdded = v293:add(GoodSignal.new())
    v291.menuChildAdded = v293:add(GoodSignal.new())
    v291.iconModule = script_2
    v291.UID = v294
    v291.isEnabled = true
    v291.enabled = v291.isEnabled
    v291.isSelected = false
    v291.isViewing = false
    v291.joinedFrame = false
    v291.parentIconUID = false
    v291.deselectWhenOtherIconSelected = true
    v291.totalNotices = 0
    v291.activeState = "Deselected"
    v291.alignment = ""
    v291.originalAlignment = ""
    v291.appliedTheme = {}
    v291.appearance = {}
    v291.cachedInstances = {}
    v291.cachedNamesToInstances = {}
    v291.cachedCollectives = {}
    v291.bindedToggleKeys = {}
    v291.customBehaviours = {}
    v291.toggleItems = {}
    v291.bindedEvents = {}
    v291.notices = {}
    v291.menuIcons = {}
    v291.dropdownIcons = {}
    v291.childIconsDict = {}
    v291.creationTime = os.clock()
    v291.widget = v293:add(require(Elements.Widget)(v291, v6))
    v291:setAlignment()
    v9 += 1
    local v295 = v9 * 0.01 + 1
    v291:setOrder(v295, "deselected")
    v291:setOrder(v295, "selected")
    v291:setTheme(v6.baseTheme)
    local ClickRegion = v291:getInstance("ClickRegion")

    local function handleToggle() -- line 179 | captures: v291
        if not v291.locked then
            if v291.isSelected then
                v291:deselect("User", v291)
            else
                v291:select("User", v291)
            end
        end
    end

    local v296 = false
    local v297 = false
    ClickRegion.MouseButton1Click:Connect(function() -- line 191 | captures: v296, v297, v291
        if v296 then
            return
        end
        v297 = true
        task.delay(0.01, function() -- line 196 | captures: v297
            v297 = false
        end)
        if not v291.locked then
            if v291.isSelected then
                v291:deselect("User", v291)
            else
                v291:select("User", v291)
            end
        end
    end)
    ClickRegion.TouchTap:Connect(function() -- line 208 | captures: v296, v297, v291
        if v297 then
            return
        end
        v296 = true
        task.delay(0.01, function() -- line 213 | captures: v296
            v296 = false
        end)
        if not v291.locked then
            if v291.isSelected then
                v291:deselect("User", v291)
            else
                v291:select("User", v291)
            end
        end
    end)
    v293:add(UserInputService.InputBegan:Connect(function(v298, v299) -- line 225 | captures: v291
        if not v291.locked and v291.bindedToggleKeys[v298.KeyCode] and not v299 and not v291.locked then
            if v291.isSelected then
                v291:deselect("User", v291)
            else
                v291:select("User", v291)
            end
        end
    end))

    local function viewingEnded() -- line 235 | captures: v291
        if v291.locked then
            return
        end
        v291.isViewing = false
        v291.viewingEnded:Fire(true)
        v291:setState(nil, "User", v291)
    end

    v291.joinedParent:Connect(function() -- line 243 | captures: v291
        if not v291.isViewing or v291.locked then
            return
        end
        v291.isViewing = false
        v291.viewingEnded:Fire(true)
        v291:setState(nil, "User", v291)
    end)
    ClickRegion.MouseEnter:Connect(function() -- line 251 | captures: v291, UserInputService
        local v300 = not UserInputService.KeyboardEnabled
        if v291.locked then
            return
        end
        v291.isViewing = true
        v291.viewingStarted:Fire(true)
        if not v300 then
            v291:setState("Viewing", "User", v291)
        end
    end)
    local v301 = 0
    v293:add(UserInputService.TouchEnded:Connect(viewingEnded))
    ClickRegion.MouseLeave:Connect(viewingEnded)
    ClickRegion.SelectionGained:Connect(function(v302) -- line 265 | captures: v291
        if v291.locked then
            return
        end
        v291.isViewing = true
        v291.viewingStarted:Fire(true)
        if not v302 then
            v291:setState("Viewing", "User", v291)
        end
    end)
    ClickRegion.SelectionLost:Connect(viewingEnded)
    ClickRegion.MouseButton1Down:Connect(function() -- line 276 | captures: v301, v291, UserInputService
        if v291.locked or not UserInputService.TouchEnabled then
            return
        end
        v301 += 1
        local v303 = v301
        task.delay(0.2, function() -- line 280 | captures: v303, v301, v291
            if v303 ~= v301 or v291.locked then
                return
            end
            v291.isViewing = true
            v291.viewingStarted:Fire(true)
            v291:setState("Viewing", "User", v291)
        end)
    end)
    ClickRegion.MouseButton1Up:Connect(function() -- line 290 | captures: v301
        v301 += 1
    end)
    local IconOverlay = v291:getInstance("IconOverlay")
    v291.viewingStarted:Connect(function() -- line 294 | captures: v291, IconOverlay
        IconOverlay.Visible = not v291.overlayDisabled
    end)
    v291.viewingEnded:Connect(function() -- line 297 | captures: IconOverlay
        IconOverlay.Visible = false
    end)
    v293:add(v8:Connect(function(v304) -- line 300 | captures: v291
        if v304 ~= v291 and v291.deselectWhenOtherIconSelected and v304.deselectWhenOtherIconSelected then
            v291:deselect("AutoDeselect", v304)
        end
    end))
    local s = debug.info(2, "s")
    local v305 = string.split(s, ".")
    local game_2 = game
    local v306 = game_2
    local v307
    for v308, v309 in pairs(v305) do
        v306 = v306:FindFirstChild(v309)
        if v306 then
            if v306:IsA("ScreenGui") then
                v307 = v306
            end
        else
            game_2 = v306
            break
        end
        game_2 = v306
    end
    if game_2 and v307 and v307.ResetOnSpawn == true then
        v5.localPlayerRespawned(function() -- line 319 | captures: v291
            v291:destroy()
        end)
    end
    v291.toggled:Connect(function(v310) -- line 323 | captures: v291, v6
        v291.noticeChanged:Fire(v291.totalNotices)
        for v311, v312 in pairs(v291.childIconsDict) do
            local v313 = v6.getIconByUID(v311)
            v313.noticeChanged:Fire(v313.totalNotices)
            if not v310 and v313.isSelected then
                for v314, v315 in pairs(v313.childIconsDict) do
                    v313:deselect("HideParentFeature", v291)
                end
            end
        end
    end)
    v291.selected:Connect(function() -- line 337 | captures: v291, StarterGui
        if #v291.dropdownIcons > 0 then
            if StarterGui:GetCore("ChatActive") and v291.alignment ~= "Right" then
                v291.chatWasPreviouslyActive = true
                StarterGui:SetCore("ChatActive", false)
            end
            if StarterGui:GetCoreGuiEnabled("PlayerList") and v291.alignment ~= "Left" then
                v291.playerlistWasPreviouslyActive = true
                StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
            end
        end
    end)
    v291.deselected:Connect(function() -- line 351 | captures: v291, StarterGui
        if v291.chatWasPreviouslyActive then
            v291.chatWasPreviouslyActive = nil
            StarterGui:SetCore("ChatActive", true)
        end
        if v291.playerlistWasPreviouslyActive then
            v291.playerlistWasPreviouslyActive = nil
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
        end
    end)
    task.delay(0.1, function() -- line 361 | captures: v291
        if v291.activeState == "Deselected" then
            v291.stateChanged:Fire("Deselected")
            v291:refresh()
        end
    end)
    v6.iconAdded:Fire(v291)
    return v291
end

v6.new = new

function setName(v316, v317) -- line 370
    v316.widget.Name = v317
    v316.name = v317
    return v316
end

v6.setName = setName

function setState(v318, v319, v320, v321) -- line 375 | captures: v5, v8
    local v322
    if v319 then
        v322 = v319
    elseif v318.isSelected then
        v322 = "Selected"
    else
        v322 = "Deselected"
    end
    local v323 = v5.formatStateName(v322)
    if v318.activeState == v323 then
        return
    end
    local isSelected = v318.isSelected
    v318.activeState = v323
    if v323 == "Deselected" then
        v318.isSelected = false
        if isSelected then
            v318.toggled:Fire(false, v320, v321)
            v318.deselected:Fire(v320, v321)
        end
        v318:_setToggleItemsVisible(false, v320, v321)
    elseif v323 == "Selected" then
        v318.isSelected = true
        if not isSelected then
            v318.toggled:Fire(true, v320, v321)
            v318.selected:Fire(v320, v321)
            v8:Fire(v318, v320, v321)
        end
        v318:_setToggleItemsVisible(true, v320, v321)
    end
    v318.stateChanged:Fire(v323, v320, v321)
end

v6.setState = setState

function getInstance(v324, v325) -- line 411 | captures: v4
    local v326
    local v327 = v324.cachedNamesToInstances[v325]
    if v327 then
        return v327
    end

    local function cacheInstance(v328, v329) -- line 417 | captures: v324
        if v324.cachedInstances[v329] then
            return
        end
        local Collective = v329:GetAttribute("Collective")
        local v330 = Collective and v324.cachedCollectives[Collective]
        if v330 then
            table.insert(v330, v329)
        end
        v324.cachedNamesToInstances[v328] = v329
        v324.cachedInstances[v329] = true
        v329.Destroying:Once(function() -- line 429 | captures: v328, v329, v324
            v324.cachedNamesToInstances[v328] = nil
            v324.cachedInstances[v329] = nil
        end)
    end

    local widget = v324.widget
    cacheInstance("Widget", widget)
    if v325 == "Widget" then
        return widget
    end
    local v331

    function v331(v332) -- line 440 | captures: v331, v326, v324, v325, cacheInstance, v4
        for v333, v334 in pairs(v332:GetChildren()) do
            local WidgetUID = v334:GetAttribute("WidgetUID")
            if WidgetUID then
                if WidgetUID == v324.UID then
                end
            else
                local v335 = v4.getRealInstance(v334) or v334
                v331(v335)
                if v335:IsA("GuiBase") then
                    local Name = v335.Name
                    cacheInstance(Name, v335)
                    if Name == v325 then
                        v326 = v335
                    end
                elseif v335:IsA("UIBase") or v335:IsA("ValueBase") then
                end
            end
        end
    end

    v331(widget)
    return nil
end

v6.getInstance = getInstance

function getCollective(v336, v337) -- line 465
    local v338 = v336.cachedCollectives[v337]
    if v338 then
        return v338
    end
    local v339 = {}
    for v340, v341 in pairs(v336.cachedInstances) do
        if v340:GetAttribute("Collective") == v337 then
            table.insert(v339, v340)
        end
    end
    v336.cachedCollectives[v337] = v339
    return v339
end

v6.getCollective = getCollective

function getInstanceOrCollective(v342, v343) -- line 479
    local v344 = {}
    local v345 = v342:getInstance(v343)
    if v345 then
        table.insert(v344, v345)
    end
    if #v344 == 0 then
        v344 = v342:getCollective(v343)
    end
    return v344
end

v6.getInstanceOrCollective = getInstanceOrCollective

function getStateGroup(v346, v347) -- line 490
    local v348 = v347 or v346.activeState
    local v349 = v346.appearance[v348]
    if not v349 then
        v349 = {}
        v346.appearance[v348] = v349
    end
    return v349
end

v6.getStateGroup = getStateGroup

function refreshAppearance(v350, v351, v352) -- line 502 | captures: v4
    v4.refresh(v350, v351, v352)
    return v350
end

v6.refreshAppearance = refreshAppearance

function refresh(v353) -- line 506
    v353:refreshAppearance(v353.widget)
    v353.updateSize:Fire()
    return v353
end

v6.refresh = refresh

function updateParent(v354) -- line 511 | captures: v6
    local v355 = v6.getIconByUID(v354.parentIconUID)
    if v355 then
        v355.updateSize:Fire()
    end
end

v6.updateParent = updateParent

function setBehaviour(v356, v357, v358, v359, v360) -- line 517
    v356.customBehaviours[v357 .. "-" .. v358] = v359
    if v360 then
        local v361 = v356:getInstanceOrCollective(v357)
        for v362, v363 in pairs(v361) do
            v356:refreshAppearance(v363, v358)
        end
    end
end

v6.setBehaviour = setBehaviour

function modifyTheme(v364, v365, v366) -- line 526 | captures: v4
    return v364, (v4.modify(v364, v365, v366))
end

v6.modifyTheme = modifyTheme

function modifyChildTheme(v367, v368, v369) -- line 530 | captures: v6
    v367.childModifications = v368
    v367.childModificationsUID = v369
    for v370, v371 in pairs(v367.childIconsDict) do
        v6.getIconByUID(v370):modifyTheme(v368, v369)
    end
    v367.childThemeModified:Fire()
    return v367
end

v6.modifyChildTheme = modifyChildTheme

function removeModification(v372, v373) -- line 539 | captures: v4
    v4.remove(v372, v373)
    return v372
end

v6.removeModification = removeModification

function removeModificationWith(v374, v375, v376, v377) -- line 543 | captures: v4
    v4.removeWith(v374, v375, v376, v377)
    return v374
end

v6.removeModificationWith = removeModificationWith

function setTheme(v378, v379) -- line 547 | captures: v4
    v4.set(v378, v379)
    return v378
end

v6.setTheme = setTheme

function setEnabled(v380, v381) -- line 551
    v380.isEnabled = v381
    v380.enabled = v380.isEnabled
    v380.widget.Visible = v381
    v380:updateParent()
    return v380
end

v6.setEnabled = setEnabled

function select(v382, v383, v384) -- line 558
    v382:setState("Selected", v383, v384)
    return v382
end

v6.select = select

function deselect(v385, v386, v387) -- line 562
    v385:setState("Deselected", v386, v387)
    return v385
end

v6.deselect = deselect

function notify(v388, v389, v390) -- line 566 | captures: Elements, v6
    if not v388.notice then
        v388.notice = require(Elements.Notice)(v388, v6)
    end
    v388.noticeStarted:Fire(v389, v390)
    return v388
end

v6.notify = notify

function clearNotices(v391) -- line 574
    v391.endNotices:Fire()
    return v391
end

v6.clearNotices = clearNotices

function disableOverlay(v392, v393) -- line 578
    v392.overlayDisabled = v393
    return v392
end

v6.disableOverlay = disableOverlay
Gamepad = v6.disableOverlay
v6.disableStateOverlay = Gamepad

function setImage(v394, v395, v396) -- line 583
    v394:modifyTheme({ "IconImage", "Image", v395, v396 })
    return v394
end

v6.setImage = setImage

function setLabel(v397, v398, v399) -- line 587
    v397:modifyTheme({ "IconLabel", "Text", v398, v399 })
    return v397
end

v6.setLabel = setLabel

function setOrder(v400, v401, v402) -- line 591
    local v403 = v401 * 100
    v400:modifyTheme({ "IconSpot", "LayoutOrder", v403, v402 })
    v400:modifyTheme({ "Widget", "LayoutOrder", v403, v402 })
    return v400
end

v6.setOrder = setOrder

function setCornerRadius(v404, v405, v406) -- line 597
    v404:modifyTheme({ "IconCorners", "CornerRadius", v405, v406 })
    return v404
end

v6.setCornerRadius = setCornerRadius

function align(v407, v408, v409) -- line 601 | captures: v6
    local v410 = tostring(v408):lower()
    if v410 == "mid" then
        v410 = "center"
    end
    if not (v410 == "left" or v410 == "center" or v410 == "right") then
        v410 = "left"
    end
    local v411 = if v410 == "center" then v6.container.TopbarCentered else v6.container.TopbarStandard
    local v412 = string.upper((string.sub(v410, 1, 1))) .. string.sub(v410, 2)
    if not v409 then
        v407.originalAlignment = v412
    end
    local joinedFrame = v407.joinedFrame
    local v413 = v411.Holders[v412]
    v407.screenGui = v411
    v407.alignmentHolder = v413
    if not v407.isDestroyed then
        v407.widget.Parent = joinedFrame or v413
    end
    v407.alignment = v412
    v407.alignmentChanged:Fire(v412)
    v6.iconChanged:Fire(v407)
    return v407
end

v6.align = align
Gamepad = v6.align
v6.setAlignment = Gamepad

function setLeft(v414) -- line 634
    v414:setAlignment("Left")
    return v414
end

v6.setLeft = setLeft

function setMid(v415) -- line 638
    v415:setAlignment("Center")
    return v415
end

v6.setMid = setMid

function setRight(v416) -- line 642
    v416:setAlignment("Right")
    return v416
end

v6.setRight = setRight

function setWidth(v417, v418, v419) -- line 646
    v417:modifyTheme({ "Widget", "DesiredWidth", v418, v419 })
    return v417
end

v6.setWidth = setWidth

function setImageScale(v420, v421, v422) -- line 650
    v420:modifyTheme({ "IconImageScale", "Value", v421, v422 })
    return v420
end

v6.setImageScale = setImageScale

function setImageRatio(v423, v424, v425) -- line 654
    v423:modifyTheme({ "IconImageRatio", "AspectRatio", v424, v425 })
    return v423
end

v6.setImageRatio = setImageRatio

function setTextSize(v426, v427, v428) -- line 658
    v426:modifyTheme({ "IconLabel", "TextSize", v427, v428 })
    return v426
end

v6.setTextSize = setTextSize

function setTextFont(v429, v430, v431, v432, v433) -- line 662
    local v434 = v431 or Enum.FontWeight.Regular
    local v435 = v432 or Enum.FontStyle.Normal
    local v436 = typeof(v430)
    local v437
    if v436 == "number" then
        v437 = Font.fromId(v430, v434, v435)
    elseif v436 == "EnumItem" then
        v437 = Font.fromEnum(v430)
    elseif v436 == "string" then
        if v430:match("rbxasset") then
        else
            v437 = Font.fromName(v430, v434, v435)
        end
    end
    v429:modifyTheme({
        "IconLabel",
        "FontFace",
        v437 or Font.new(v430, v434, v435),
        v433
    })
    return v429
end

v6.setTextFont = setTextFont

function bindToggleItem(v438, v439) -- line 688
    if not v439:IsA("GuiObject") and not v439:IsA("LayerCollector") then
        error("Toggle item must be a GuiObject or LayerCollector!")
    end
    v438.toggleItems[v439] = true
    v438:_updateSelectionInstances()
    return v438
end

v6.bindToggleItem = bindToggleItem

function unbindToggleItem(v440, v441) -- line 696
    v440.toggleItems[v441] = nil
    v440:_updateSelectionInstances()
    return v440
end

v6.unbindToggleItem = unbindToggleItem

function _updateSelectionInstances(v442) -- line 701
    for v443, v444 in pairs(v442.toggleItems) do
        local v445 = {}
        for v446, v447 in pairs(v443:GetDescendants()) do
            if v447:IsA("TextButton") then
                if v447.Active then
                    table.insert(v445, v447)
                end
            elseif v447:IsA("ImageButton") then
            end
        end
        v442.toggleItems[v443] = v445
    end
end

v6._updateSelectionInstances = _updateSelectionInstances

function _setToggleItemsVisible(v448, v449, v450, v451) -- line 717
    for v452, v453 in pairs(v448.toggleItems) do
        if v451 then
            if v451 == v448 or v451.toggleItems[v452] == nil then
            end
        else
            local v454 = if v452:IsA("LayerCollector") then "Enabled" else "Visible"
            v452[v454] = v449
        end
    end
end

v6._setToggleItemsVisible = _setToggleItemsVisible

function bindEvent(v455, v456, v457) -- line 728
    local v458 = v455[v456]
    local v459
    if v458 then
        if typeof(v458) == "table" then
            v459 = v458.Connect
        else
            v459 = false
        end
    else
        v459 = v458
    end
    assert(v459, "argument[1] must be a valid topbarplus icon event name!")
    local v460 = typeof(v457) == "function"
    assert(v460, "argument[2] must be a function!")
    v455.bindedEvents[v456] = v458:Connect(function(...) -- line 738 | captures: v455, v457
        v457(v455, ...)
    end)
    return v455
end

v6.bindEvent = bindEvent

function unbindEvent(v461, v462) -- line 743
    local v463 = v461.bindedEvents[v462]
    if v463 then
        v463:Disconnect()
        v461.bindedEvents[v462] = nil
    end
    return v461
end

v6.unbindEvent = unbindEvent

function bindToggleKey(v464, v465) -- line 751
    local v466 = typeof(v465) == "EnumItem"
    assert(v466, "argument[1] must be a KeyCode EnumItem!")
    v464.bindedToggleKeys[v465] = true
    v464.toggleKeyAdded:Fire(v465)
    v464:setCaption("_hotkey_")
    return v464
end

v6.bindToggleKey = bindToggleKey

function unbindToggleKey(v467, v468) -- line 759
    local v469 = typeof(v468) == "EnumItem"
    assert(v469, "argument[1] must be a KeyCode EnumItem!")
    v467.bindedToggleKeys[v468] = nil
    return v467
end

v6.unbindToggleKey = unbindToggleKey

function call(v470, v471, ...) -- line 765
    local v472 = table.pack(...)
    task.spawn(function() -- line 767 | captures: v470, v471, v472
        v471(v470, table.unpack(v472))
    end)
    return v470
end

v6.call = call

function addToJanitor(v473, v474, v475, v476) -- line 772
    v473.janitor:add(v474, v475, v476)
    return v473
end

v6.addToJanitor = addToJanitor

function lock(v477) -- line 776
    v477:getInstance("ClickRegion").Visible = false
    v477.locked = true
    return v477
end

v6.lock = lock

function unlock(v478) -- line 782
    v478:getInstance("ClickRegion").Visible = true
    v478.locked = false
    return v478
end

v6.unlock = unlock

function debounce(v479, v480) -- line 788
    v479:lock()
    task.wait(v480)
    v479:unlock()
    return v479
end

v6.debounce = debounce

function autoDeselect(v481, v482) -- line 794
    if v482 == nil then
        v481.deselectWhenOtherIconSelected = true
    else
        v481.deselectWhenOtherIconSelected = v482
    end
    return v481
end

v6.autoDeselect = autoDeselect

function oneClick(v483, v484) -- line 804
    local singleClickJanitor = v483.singleClickJanitor
    singleClickJanitor:clean()
    if v484 or v484 == nil then
        singleClickJanitor:add(v483.selected:Connect(function() -- line 808 | captures: v483
            v483:deselect("OneClick", v483)
        end))
    end
    v483.oneClickEnabled = true
    return v483
end

v6.oneClick = oneClick

function setCaption(v485, v486) -- line 819 | captures: Elements
    if v486 == "_hotkey_" then
        if not v485.captionText then
            local captionJanitor = v485.captionJanitor
            v485.captionJanitor:clean()
            if not v486 or v486 == "" then
                v485.caption = nil
                v485.captionText = nil
            else
                local v487 = captionJanitor:add(require(Elements.Caption)(v485))
                v487:SetAttribute("CaptionText", v486)
                v485.caption = v487
                v485.captionText = v486
            end
        end
    else
        local captionJanitor = v485.captionJanitor
        v485.captionJanitor:clean()
        if v486 then
            if v486 == "" then
                v485.caption = nil
                v485.captionText = nil
            else
                local v488 = captionJanitor:add(require(Elements.Caption)(v485))
                v488:SetAttribute("CaptionText", v486)
                v485.caption = v488
                v485.captionText = v486
            end
        else
            v485.caption = nil
            v485.captionText = nil
        end
    end
    return v485
end

v6.setCaption = setCaption

function setCaptionHint(v489, v490) -- line 858
    local v491 = typeof(v490) == "EnumItem"
    assert(v491, "argument[1] must be a KeyCode EnumItem!")
    v489.fakeToggleKey = v490
    v489.fakeToggleKeyChanged:Fire(v490)
    v489:setCaption("_hotkey_")
    return v489
end

v6.setCaptionHint = setCaptionHint

function leave(v492) -- line 866
    v492.joinJanitor:clean()
    return v492
end

v6.leave = leave

function joinMenu(v493, v494) -- line 870 | captures: v5
    v5.joinFeature(v493, v494, v494.menuIcons, v494:getInstance("Menu"))
    v494.menuChildAdded:Fire(v493)
    return v493
end

v6.joinMenu = joinMenu

function setMenu(v495, v496) -- line 875
    v495.menuSet:Fire(v496)
    return v495
end

v6.setMenu = setMenu

function setFrozenMenu(v497, v498) -- line 879
    v497:freezeMenu(v498)
    v497:setMenu(v498)
end

v6.setFrozenMenu = setFrozenMenu

function freezeMenu(v499) -- line 883
    v499:select("FrozenMenu", v499)
    v499:bindEvent("deselected", function(v500) -- line 885 | captures: v499
        v500:select("FrozenMenu", v499)
    end)
    v499:modifyTheme({ "IconSpot", "Visible", false })
end

v6.freezeMenu = freezeMenu

function joinDropdown(v501, v502) -- line 890 | captures: v5
    v502:getDropdown()
    v5.joinFeature(v501, v502, v502.dropdownIcons, v502:getInstance("DropdownScroller"))
    v502.dropdownChildAdded:Fire(v501)
    return v501
end

v6.joinDropdown = joinDropdown

function getDropdown(v503) -- line 896 | captures: Elements
    local dropdown = v503.dropdown
    if not dropdown then
        dropdown = require(Elements.Dropdown)(v503)
        v503.dropdown = dropdown
        v503:clipOutside(dropdown)
    end
    return dropdown
end

v6.getDropdown = getDropdown

function setDropdown(v504, v505) -- line 906
    v504:getDropdown()
    v504.dropdownSet:Fire(v505)
    return v504
end

v6.setDropdown = setDropdown

function clipOutside(v506, v507) -- line 911 | captures: v5
    local v508 = v5.clipOutside(v506, v507)
    v506:refreshAppearance(v507)
    return v506, v508
end

v6.clipOutside = clipOutside

function setIndicator(v509, v510) -- line 916 | captures: Elements, v6
    if not v509.indicator then
        local Indicator = require(Elements.Indicator)
        v509.indicator = v509.janitor:add(Indicator(v509, v6))
    end
    v509.indicatorSet:Fire(v510)
end

v6.setIndicator = setIndicator

function convertLabelToNumberSpinner(v511, v512) -- line 923
    local IconLabel = v511:getInstance("IconLabel")
    IconLabel.Transparency = 1
    v512.Parent = IconLabel.Parent
    v512.Size = UDim2.fromScale(1, 1)
    v512.AnchorPoint = Vector2.new(0.5, 0.5)
    v512.Position = UDim2.new(0.5, 0, 0.5, 0)
    v512.TextXAlignment = Enum.TextXAlignment.Center
    v512.ClipsDescendants = false
    local v513 = { "FontFace", "BorderSizePixel", "BorderColor3", "Rotation", "TextStrokeTransparency", "TextStrokeColor3", "TextStrokeTransparency", "TextColor3" }
    for v514, v515 in ipairs(v513) do
        v512[v515] = IconLabel[v515]
        local v516 = IconLabel:GetPropertyChangedSignal(v515)
        local v517 = v515
        v511:addToJanitor(v516:Connect(function() -- line 946 | captures: v512, IconLabel, v517
            v512[v517] = IconLabel[v517]
        end))
    end

    local function getSpinnerSizeAndDigitCount() -- line 950 | captures: v512
        local v518 = 0
        local v519 = 0
        for v520, v521 in v512.Frame:GetChildren() do
            local v522 = string.lower(v521.Name)
            if v522 == "digit" or v522 == "prefix" and v521.Text ~= "" then
                v518 += v521.AbsoluteSize.X
                v519 += 1
            end
        end
        return v518, v519
    end

    local function getLabelParentContainerXSize() -- line 969 | captures: v512, IconLabel
        local Parent = IconLabel.Parent.Parent
        if Parent == nil then
            return 0
        end
        if Parent.IconImage.Visible == true then
            return v512.Frame.AbsoluteSize.X + IconLabel.Parent.Parent.IconImage.AbsoluteSize.X
        end
        return Parent.AbsoluteSize.X
    end

    local function getNumberSpinnerXSize() -- line 979 | captures: v512
        return v512.Frame.AbsoluteSize.X
    end

    local function adjustSize() -- line 982 | captures: v511, v512, IconLabel, getSpinnerSizeAndDigitCount
        local v523, v524 = getSpinnerSizeAndDigitCount()
        if v524 < 18 then
            v511:setLabel(v512.Value)
        end
        local X = v512.Frame.AbsoluteSize.X
        while v523 < X do
            if v511.isDestroyed ~= true then
                task.wait(0.05)
                if not (v524 > 0 and v524 < 8) then
                    v512.TextSize += 1
                    X = v512.Frame.AbsoluteSize.X
                    v523, v524 = getSpinnerSizeAndDigitCount()
                    continue
                end
                v512.TextSize = IconLabel.TextSize
            end
            break
        end
        local Parent = IconLabel.Parent.Parent
        local v525
        if Parent == nil then
            v525 = 0
        elseif Parent.IconImage.Visible == true then
            v525 = v512.Frame.AbsoluteSize.X + IconLabel.Parent.Parent.IconImage.AbsoluteSize.X
        else
            v525 = Parent.AbsoluteSize.X
        end
        while true do
            if v525 < v523 then
                if v511.isDestroyed == true then
                    return
                end
                task.wait(0.05)
                if v524 < 8 and v524 > 0 then
                    break
                end
                v512.TextSize -= 1
                local Parent = IconLabel.Parent.Parent
                local v526
                if Parent == nil then
                    v526 = 0
                elseif Parent.IconImage.Visible == true then
                    v526 = v512.Frame.AbsoluteSize.X + IconLabel.Parent.Parent.IconImage.AbsoluteSize.X
                else
                    v526 = Parent.AbsoluteSize.X
                end
                v523, v524 = getSpinnerSizeAndDigitCount()
                v525 = v526
                continue
            end
            return
        end
        v512.TextSize = IconLabel.TextSize
    end

    v511:addToJanitor(v512.Frame.ChildAdded:Connect(adjustSize))
    v511:addToJanitor(v512.Frame.ChildRemoved:Connect(adjustSize))
    local iconAdded = v511.iconAdded
    v511:addToJanitor(iconAdded:Connect(function() -- line 1039 | captures: adjustSize
        task.wait(1)
        adjustSize()
    end))
    v511:updateParent()
    v512.Name = "LabelSpinner"
    v512.Prefix = "$"
    v512.Commas = true
    v512.Decimals = 0
    v512.Duration = 0.25
    v512.Value = 10
    task.wait(0.2)
    return v511
end

v6.convertLabelToNumberSpinner = convertLabelToNumberSpinner

function destroy(v527) -- line 1053 | captures: v6
    if v527.isDestroyed then
        return
    end
    v527:clearNotices()
    if v527.parentIconUID then
        v527:leave()
    end
    v527.isDestroyed = true
    v527.janitor:clean()
    v6.iconRemoved:Fire(v527)
end

v6.destroy = destroy
Gamepad = v6.destroy
v6.Destroy = Gamepad
return v6
