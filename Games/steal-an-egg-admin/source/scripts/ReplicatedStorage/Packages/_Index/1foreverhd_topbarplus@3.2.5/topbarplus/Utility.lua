-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}
local LocalPlayer = game:GetService("Players").LocalPlayer

local function createStagger(v2, v3, v4) -- line 8
    local v5 = false
    local v6
    if v2 then
        if v2 == 0 then
            v6 = 0.01
        else
            v6 = v2
        end
    else
        v6 = 0.01
    end
    local v7

    function v7(...) -- line 19 | captures: v7, v6, v5, v3, v4
        if v5 then
            return
        end
        table.pack(...)
        v5 = true
        local v8 = false
        task.spawn(function() -- line 28 | captures: v8, v6, v3, v4
            if v4 then
                task.wait(v6)
            end
            v3(table.unpack(v8))
        end)
        task.delay(v6, function() -- line 34 | captures: v8, v7, v5
            v5 = false
            if not v8 then
                return
            end
            v7(table.unpack(v8))
        end)
    end

    return v7
end

v1.createStagger = createStagger

local function round(v9) -- line 43
    local v10 = v9 + 0.5
    return (math.floor(v10))
end

v1.round = round

local function reverseTable(v11) -- line 46
    local v12 = #v11 / 2
    local v13 = math.floor(v12)
    for v14 = 1, v13 do
        local v15 = #v11 - v14 + 1
        local v16 = v11[v14]
        v11[v14] = v11[v15]
        v11[v15] = v16
    end
end

v1.reverseTable = reverseTable

function v1.copyTable(v17) -- line 57 | captures: v1
    local v18 = type(v17) == "table"
    assert(v18, "First argument must be a table")
    local v19 = table.create(#v17)
    for v20, v21 in pairs(v17) do
        if type(v21) == "table" then
            v19[v20] = v1.copyTable(v21)
        else
            v19[v20] = v21
        end
    end
    return v19
end

local v22 = {
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z",
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0",
    "<",
    ">",
    "?",
    "@",
    "{",
    "}",
    "[",
    "]",
    "!",
    "(",
    ")",
    "=",
    "+",
    "~",
    "#"
}

function v1.generateUID(v23) -- line 149 | captures: v22
    local v24 = v23 or 8
    local v25 = ""
    for v26 = 1, v24 do
        v25 ..= v22[math.random(1, #v22)]
    end
    return v25
end

local v27 = {}

function v1.setVisible(v28, v29, v30) -- line 162 | captures: v27
    local v31 = v27[v28]
    if not v31 then
        v27[v28] = {}
        v28.Destroying:Once(function() -- line 166 | captures: v28, v27
            v27[v28] = nil
        end)
    end
    local v32
    if v29 then
        v31[v30] = nil
        v32 = v29
        for v33, v34 in pairs(v31) do
            v32 = false
            break
        end
    else
        v31[v30] = true
        v32 = v29
    end
    v28.Visible = v32
end

local function formatStateName(v35) -- line 184
    return string.upper((string.sub(v35, 1, 1))) .. string.lower((string.sub(v35, 2)))
end

v1.formatStateName = formatStateName

function v1.localPlayerRespawned(v36) -- line 188 | captures: LocalPlayer
    LocalPlayer.CharacterRemoving:Connect(v36)
end

local function getClippedContainer(v37) -- line 191
    local ClippedContainer = v37:FindFirstChild("ClippedContainer")
    if not ClippedContainer then
        ClippedContainer = Instance.new("Folder")
        ClippedContainer.Name = "ClippedContainer"
        ClippedContainer.Parent = v37
    end
    return ClippedContainer
end

v1.getClippedContainer = getClippedContainer

local Janitor = require(script.Parent.Packages.Janitor)
local GuiService = game:GetService("GuiService")

function v1.clipOutside(v38, v39) -- line 202 | captures: v1, Janitor, GuiService
    local v40 = v38.janitor:add(Janitor.new())
    v39.Destroying:Once(function() -- line 205 | captures: v40
        v40:Destroy()
    end)
    v38.janitor:add(v39)
    local Parent = v39.Parent
    local v41 = v40:add(Instance.new("Frame"))
    v41:SetAttribute("IsAClippedClone", true)
    v41.Name = v39.Name
    v41.AnchorPoint = v39.AnchorPoint
    v41.Size = v39.Size
    v41.Position = v39.Position
    v41.BackgroundTransparency = 1
    v41.LayoutOrder = v39.LayoutOrder
    v41.Parent = Parent
    local ObjectValue = Instance.new("ObjectValue")
    ObjectValue.Name = "OriginalInstance"
    ObjectValue.Value = v39
    ObjectValue.Parent = v41
    local v42 = ObjectValue:Clone()
    v39:SetAttribute("HasAClippedClone", true)
    v42.Name = "ClippedClone"
    v42.Value = v41
    v42.Parent = v39
    local ScreenGui
    local iconModule = require(v38.iconModule)
    local container = iconModule.container

    local function updateScreenGui() -- line 231 | captures: ScreenGui, v39, Parent, container, v1
        local ScreenGui_2 = Parent:FindFirstAncestorWhichIsA("ScreenGui")
        if not string.match(ScreenGui_2.Name, "Clipped") then
            ScreenGui_2 = container[ScreenGui_2.Name .. "Clipped"]
        end
        ScreenGui = ScreenGui_2
        v39.AnchorPoint = Vector2.new(0, 0)
        v39.Parent = v1.getClippedContainer(ScreenGui)
    end

    v40:add(v38.alignmentChanged:Connect(updateScreenGui))
    updateScreenGui()
    for v43, v44 in pairs(v39:GetChildren()) do
        if v44:IsA("UIAspectRatioConstraint") then
            v44:Clone().Parent = v41
        end
    end
    local widget = v38.widget
    local v45 = false
    local IgnoreVisibilityUpdater = v39:GetAttribute("IgnoreVisibilityUpdater")
    local Visible = widget:GetPropertyChangedSignal("Visible")
    v40:add(Visible:Connect(function() -- line 254 | captures: v45, v39, widget, IgnoreVisibilityUpdater, v1
        if not IgnoreVisibilityUpdater then
            local v46 = if v45 then false else widget.Visible
            v1.setVisible(v39, v46, "ClipHandler")
        end
    end))
    local joinedFrame, v47

    function v47() -- line 263 | captures: v47, v45, joinedFrame, v38, v39, v40, iconModule, widget, IgnoreVisibilityUpdater, v1
        task.defer(function() -- line 264 | captures: v47, v45, joinedFrame, v38, v39, v40, iconModule, widget, IgnoreVisibilityUpdater, v1
            local UID = v38.UID
            local joinedFrame_2
            if v39:GetAttribute("ClipToJoinedParent") then
                local v48 = UID
                for v49 = 1, 10 do
                    local v50 = iconModule.getIconByUID(v48)
                    local joinedFrame
                    if v50 then
                        joinedFrame = v50.joinedFrame
                        v48 = v50.parentIconUID
                        if joinedFrame then
                            if joinedFrame.Name == "DropdownScroller" then
                                joinedFrame_2 = joinedFrame
                                break
                            end
                        else
                            break
                        end
                    else
                        break
                    end
                    joinedFrame_2 = joinedFrame
                end
            end
            if joinedFrame_2 then
                local AbsolutePosition = joinedFrame_2.AbsolutePosition
                local AbsoluteSize = joinedFrame_2.AbsoluteSize
                local v51 = v39.AbsolutePosition + v39.AbsoluteSize / 2
                local v52 = v51.X < AbsolutePosition.X
                local v53 = AbsolutePosition.X + AbsoluteSize.X < v51.X
                local v54 = v51.Y < AbsolutePosition.Y
                local v55 = AbsolutePosition.Y + AbsoluteSize.Y < v51.Y
                local v56 = v52 or v53 or v54 or v55
                local v57, v58
                if v56 == v45 then
                    v58 = true
                else
                    v45 = v56
                    if IgnoreVisibilityUpdater then
                        v58 = true
                    else
                        if v45 then
                            v57 = false
                        else
                            v57 = widget.Visible
                        end
                        v58 = false
                    end
                end
                if not v58 then
                    v1.setVisible(v39, v57, "ClipHandler")
                end
                if joinedFrame_2:IsA("ScrollingFrame") and joinedFrame ~= joinedFrame_2 then
                    joinedFrame = joinedFrame_2
                    local v59 = joinedFrame_2:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() -- line 325 | captures: v47
                        v47()
                    end)
                    v40:add(v59, "Disconnect", "TrackUtilityScroller-" .. UID)
                end
            else
                v45 = false
                if not IgnoreVisibilityUpdater then
                    local v60 = if v45 then false else widget.Visible
                    v1.setVisible(v39, v60, "ClipHandler")
                end
            end
        end)
    end

    local CurrentCamera = workspace.CurrentCamera
    local v61 = v39:GetAttribute("AdditionalOffsetX") or 0

    local function trackProperty(v62) -- line 334 | captures: v47, ScreenGui, v45, joinedFrame, v38, v39, v40, v41, iconModule, widget, IgnoreVisibilityUpdater, CurrentCamera, v61, v1, GuiService
        local v63 = "Absolute" .. v62

        local function updateProperty() -- line 337 | captures: v62, v63, v47, ScreenGui, v45, joinedFrame, v38, v39, v40, v41, iconModule, widget, IgnoreVisibilityUpdater, CurrentCamera, v61, v1, GuiService
            local v64 = v41[v63]
            local v65 = UDim2.fromOffset(v64.X, v64.Y)
            local v66
            if v62 == "Position" then
                local v67 = CurrentCamera.ViewportSize.X - v39.AbsoluteSize.X - 4
                local Offset = v65.X.Offset
                if Offset < 4 then
                    v67 = 4
                elseif not (v67 < Offset) then
                    v67 = Offset
                end
                local v68 = if iconModule.isOldTopbar then ScreenGui.AbsolutePosition.X else workspace.CurrentCamera.ViewportSize.X - ScreenGui.AbsoluteSize.X - 0
                local v69 = v68 - v61
                v66 = UDim2.fromOffset(v67, v65.Y.Offset) + UDim2.fromOffset(-v69, GuiService.TopbarInset.Height)
                task.defer(function() -- line 356 | captures: v47, v45, joinedFrame, v38, v39, v40, iconModule, widget, IgnoreVisibilityUpdater, v1
                    local UID = v38.UID
                    local joinedFrame_2
                    if v39:GetAttribute("ClipToJoinedParent") then
                        local v70 = UID
                        for v71 = 1, 10 do
                            local v72 = iconModule.getIconByUID(v70)
                            local joinedFrame
                            if v72 then
                                joinedFrame = v72.joinedFrame
                                v70 = v72.parentIconUID
                                if joinedFrame then
                                    if joinedFrame.Name == "DropdownScroller" then
                                        joinedFrame_2 = joinedFrame
                                        break
                                    end
                                else
                                    break
                                end
                            else
                                break
                            end
                            joinedFrame_2 = joinedFrame
                        end
                    end
                    if joinedFrame_2 then
                        local AbsolutePosition = joinedFrame_2.AbsolutePosition
                        local AbsoluteSize = joinedFrame_2.AbsoluteSize
                        local v73 = v39.AbsolutePosition + v39.AbsoluteSize / 2
                        local v74 = v73.X < AbsolutePosition.X
                        local v75 = AbsolutePosition.X + AbsoluteSize.X < v73.X
                        local v76 = v73.Y < AbsolutePosition.Y
                        local v77 = AbsolutePosition.Y + AbsoluteSize.Y < v73.Y
                        local v78 = v74 or v75 or v76 or v77
                        local v79, v80
                        if v78 == v45 then
                            v80 = true
                        else
                            v45 = v78
                            if IgnoreVisibilityUpdater then
                                v80 = true
                            else
                                if v45 then
                                    v79 = false
                                else
                                    v79 = widget.Visible
                                end
                                v80 = false
                            end
                        end
                        if not v80 then
                            v1.setVisible(v39, v79, "ClipHandler")
                        end
                        if joinedFrame_2:IsA("ScrollingFrame") and joinedFrame ~= joinedFrame_2 then
                            joinedFrame = joinedFrame_2
                            local v81 = joinedFrame_2:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() -- line 417 | captures: v47
                                v47()
                            end)
                            v40:add(v81, "Disconnect", "TrackUtilityScroller-" .. UID)
                        end
                    else
                        v45 = false
                        if not IgnoreVisibilityUpdater then
                            local v82 = if v45 then false else widget.Visible
                            v1.setVisible(v39, v82, "ClipHandler")
                        end
                    end
                end)
            else
                v66 = v65
            end
            v39[v62] = v66
        end

        local v83 = v1.createStagger(0.01, updateProperty)
        local v84 = v41:GetPropertyChangedSignal(v63)
        v40:add(v84:Connect(v83))
        local ForceUpdate = v41:GetAttributeChangedSignal("ForceUpdate")
        v40:add(ForceUpdate:Connect(function() -- line 430 | captures: v83
            v83()
        end))
        local v85 = v1.createStagger(0.5, updateProperty, true)
        local v86 = v41:GetPropertyChangedSignal(v63)
        v40:add(v86:Connect(v85))
        if v62 == "Position" then
            local AbsoluteSize = ScreenGui:GetPropertyChangedSignal("AbsoluteSize")
            v40:add(AbsoluteSize:Connect(function() -- line 438 | captures: v83
                v83()
            end))
        end
    end

    task.delay(0.1, v47)
    task.defer(function() -- line 444 | captures: v47, v45, joinedFrame, v38, v39, v40, iconModule, widget, IgnoreVisibilityUpdater, v1
        local UID = v38.UID
        local joinedFrame_2
        if v39:GetAttribute("ClipToJoinedParent") then
            local v87 = UID
            for v88 = 1, 10 do
                local v89 = iconModule.getIconByUID(v87)
                local joinedFrame
                if v89 then
                    joinedFrame = v89.joinedFrame
                    v87 = v89.parentIconUID
                    if joinedFrame then
                        if joinedFrame.Name == "DropdownScroller" then
                            joinedFrame_2 = joinedFrame
                            break
                        end
                    else
                        break
                    end
                else
                    break
                end
                joinedFrame_2 = joinedFrame
            end
        end
        if joinedFrame_2 then
            local AbsolutePosition = joinedFrame_2.AbsolutePosition
            local AbsoluteSize = joinedFrame_2.AbsoluteSize
            local v90 = v39.AbsolutePosition + v39.AbsoluteSize / 2
            local v91 = v90.X < AbsolutePosition.X
            local v92 = AbsolutePosition.X + AbsoluteSize.X < v90.X
            local v93 = v90.Y < AbsolutePosition.Y
            local v94 = AbsolutePosition.Y + AbsoluteSize.Y < v90.Y
            local v95 = v91 or v92 or v93 or v94
            local v96, v97
            if v95 == v45 then
                v97 = true
            else
                v45 = v95
                if IgnoreVisibilityUpdater then
                    v97 = true
                else
                    if v45 then
                        v96 = false
                    else
                        v96 = widget.Visible
                    end
                    v97 = false
                end
            end
            if not v97 then
                v1.setVisible(v39, v96, "ClipHandler")
            end
            if joinedFrame_2:IsA("ScrollingFrame") and joinedFrame ~= joinedFrame_2 then
                joinedFrame = joinedFrame_2
                local v98 = joinedFrame_2:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() -- line 505 | captures: v47
                    v47()
                end)
                v40:add(v98, "Disconnect", "TrackUtilityScroller-" .. UID)
            end
        else
            v45 = false
            if not IgnoreVisibilityUpdater then
                local v99 = if v45 then false else widget.Visible
                v1.setVisible(v39, v99, "ClipHandler")
            end
        end
    end)
    if not IgnoreVisibilityUpdater then
        local v100 = if v45 then false else widget.Visible
        v1.setVisible(v39, v100, "ClipHandler")
    end
    trackProperty("Position")
    v40:add(v39:GetPropertyChangedSignal("Visible"):Connect(function() -- line 517
    end))
    if v39:GetAttribute("TrackCloneSize") then
        trackProperty("Size")
    else
        local AbsoluteSize = v39:GetPropertyChangedSignal("AbsoluteSize")
        v40:add(AbsoluteSize:Connect(function() -- line 520 | captures: v39, v41
            local AbsoluteSize = v39.AbsoluteSize
            v41.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y)
        end))
    end
    return v41
end

local function joinFeature(v101, v102, v103, v104) -- line 529
    local joinJanitor = v101.joinJanitor
    joinJanitor:clean()
    if v104 then
        v101.parentIconUID = v102.UID
        v101.joinedFrame = v104
        joinJanitor:add(v102.alignmentChanged:Connect(function() -- line 539 | captures: v101, v102
            local alignment = v102.alignment
            if alignment == "Center" then
                alignment = "Left"
            end
            v101:setAlignment(alignment, true)
        end))
        local alignment = v102.alignment
        if alignment == "Center" then
            alignment = "Left"
        end
        v101:setAlignment(alignment, true)
        v101:modifyTheme({ "IconButton", "BackgroundTransparency", 1 }, "JoinModification")
        v101:modifyTheme({ "ClickRegion", "Active", false }, "JoinModification")
        if v102.childModifications then
            task.defer(function() -- line 554 | captures: v101, v102
                v101:modifyTheme(v102.childModifications, v102.childModificationsUID)
            end)
        end
        local ClickRegion = v101:getInstance("ClickRegion")

        local function makeSelectable() -- line 559 | captures: v102, ClickRegion
            ClickRegion.Selectable = v102.isSelected
        end

        joinJanitor:add(v102.toggled:Connect(makeSelectable))
        task.defer(makeSelectable)
        joinJanitor:add(function() -- line 564 | captures: ClickRegion
            ClickRegion.Selectable = true
        end)
        local UID = v101.UID
        table.insert(v103, UID)
        v102:autoDeselect(false)
        v102.childIconsDict[UID] = true
        if not v102.isEnabled then
            v102:setEnabled(true)
        end
        v101.joinedParent:Fire(v102)
        joinJanitor:add(function() -- line 575 | captures: v101, v102, v103, UID
            if not v101.joinedFrame then
                return
            end
            for v105, v106 in pairs(v103) do
                if v106 == UID then
                    table.remove(v103, v105)
                    break
                end
            end
            local v107 = require(v101.iconModule).getIconByUID(v101.parentIconUID)
            if not v107 then
                return
            end
            v101:setAlignment(v101.originalAlignment)
            v101.parentIconUID = false
            v101.joinedFrame = false
            v101:removeModification("JoinModification")
            local childIconsDict = v107.childIconsDict
            childIconsDict[UID] = nil
            local v108 = true
            for v109, v110 in pairs(childIconsDict) do
                v108 = false
                break
            end
            if v108 and not v107.isAnOverflow then
                v107:setEnabled(false)
            end
            local alignment = v102.alignment
            if alignment == "Center" then
                alignment = "Left"
            end
            v101:setAlignment(alignment, true)
        end)
    else
        v101:leave()
    end
end

v1.joinFeature = joinFeature
return v1
