-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}
local LocalPlayer = game:GetService("Players").LocalPlayer

local function createStagger(v2, v3, v4) -- line 8
    local v5 = if not v2 or v2 == 0 then 0.01 else v2
    local v6 = false
    local v7
    local v8 = v5
    local staggeredCallback

    local function staggeredCallback_2(...) -- line 13 | captures: v6, v7, v3, v4, v8, staggeredCallback
        local v9 = table.pack(...)
        if v6 then
            v7 = v9
        else
            v6 = true
            v7 = nil
            task.spawn(function() -- line 22 | captures: v9, v3, v4, v8
                if v4 then
                    task.wait(v8)
                end
                local n = v9.n
                v3(table.unpack(v9, 1, n))
            end)
            task.delay(v8, function() -- line 29 | captures: v6, v7, staggeredCallback
                v6 = false
                local v10 = v7
                v7 = nil
                if not v10 then
                    return
                end
                local staggeredCallback_2 = staggeredCallback
                local n = v10.n
                staggeredCallback_2(table.unpack(v10, 1, n))
            end)
        end
    end

    staggeredCallback = staggeredCallback_2
    return staggeredCallback_2
end

v1.createStagger = createStagger

local function round(v11) -- line 41
    local v12 = v11 + 0.5
    return (math.floor(v12))
end

v1.round = round

local function reverseTable(v13) -- line 44
    local v14 = #v13 / 2
    local v15 = math.floor(v14)
    for v16 = 1, v15 do
        local v17 = #v13 - v16 + 1
        local v18 = v13[v16]
        v13[v16] = v13[v17]
        v13[v17] = v18
    end
end

v1.reverseTable = reverseTable

function v1.copyTable(v19) -- line 55 | captures: v1
    local v20 = type(v19) == "table"
    assert(v20, "First argument must be a table")
    local v21 = table.create(#v19)
    for v22, v23 in pairs(v19) do
        if type(v23) == "table" then
            v21[v22] = v1.copyTable(v23)
        else
            v21[v22] = v23
        end
    end
    return v21
end

local v24 = {
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

function v1.generateUID(v25) -- line 147 | captures: v24
    local v26 = v25 or 8
    local v27 = ""
    for v28 = 1, v26 do
        v27 ..= v24[math.random(1, #v24)]
    end
    return v27
end

local v29 = {}

function v1.setVisible(v30, v31, v32) -- line 160 | captures: v29
    local v33 = v29[v30]
    if not v33 then
        v33 = {}
        v29[v30] = v33
        v30.Destroying:Once(function() -- line 165 | captures: v30, v29
            v29[v30] = nil
        end)
    end
    local v34
    if v31 then
        v33[v32] = nil
        v34 = v31
        for v35, v36 in pairs(v33) do
            v34 = false
            break
        end
    else
        v33[v32] = true
        v34 = v31
    end
    v30.Visible = v34
end

local function formatStateName(v37) -- line 183
    return string.upper((string.sub(v37, 1, 1))) .. string.lower((string.sub(v37, 2)))
end

v1.formatStateName = formatStateName

function v1.localPlayerRespawned(v38) -- line 187 | captures: LocalPlayer
    LocalPlayer.CharacterRemoving:Connect(v38)
end

local function getClippedContainer(v39) -- line 190
    local ClippedContainer = v39:FindFirstChild("ClippedContainer")
    if not ClippedContainer then
        ClippedContainer = Instance.new("Folder")
        ClippedContainer.Name = "ClippedContainer"
        ClippedContainer.Parent = v39
    end
    return ClippedContainer
end

v1.getClippedContainer = getClippedContainer

local Janitor = require(script.Parent.Packages.Janitor)
local GuiService = game:GetService("GuiService")

function v1.clipOutside(v40, v41) -- line 201 | captures: v1, Janitor, GuiService
    local v42 = v40.janitor:add(Janitor.new())
    v41.Destroying:Once(function() -- line 204 | captures: v42
        v42:Destroy()
    end)
    v40.janitor:add(v41)
    local Parent = v41.Parent
    local v43 = v42:add(Instance.new("Frame"))
    v43:SetAttribute("IsAClippedClone", true)
    v43.Name = v41.Name
    v43.AnchorPoint = v41.AnchorPoint
    v43.Size = v41.Size
    v43.Position = v41.Position
    v43.BackgroundTransparency = 1
    v43.LayoutOrder = v41.LayoutOrder
    v43.Parent = Parent
    local ObjectValue = Instance.new("ObjectValue")
    ObjectValue.Name = "OriginalInstance"
    ObjectValue.Value = v41
    ObjectValue.Parent = v43
    local v44 = ObjectValue:Clone()
    v41:SetAttribute("HasAClippedClone", true)
    v44.Name = "ClippedClone"
    v44.Value = v43
    v44.Parent = v41
    local ScreenGui
    local iconModule = require(v40.iconModule)
    local container = iconModule.container

    local function updateScreenGui() -- line 230 | captures: ScreenGui, v41, Parent, container, v1
        local ScreenGui_2 = Parent:FindFirstAncestorWhichIsA("ScreenGui")
        if not string.match(ScreenGui_2.Name, "Clipped") then
            ScreenGui_2 = container[ScreenGui_2.Name .. "Clipped"]
        end
        ScreenGui = ScreenGui_2
        v41.AnchorPoint = Vector2.new(0, 0)
        v41.Parent = v1.getClippedContainer(ScreenGui)
    end

    v42:add(v40.alignmentChanged:Connect(updateScreenGui))
    updateScreenGui()
    for v45, v46 in pairs(v41:GetChildren()) do
        if v46:IsA("UIAspectRatioConstraint") then
            v46:Clone().Parent = v43
        end
    end
    local widget = v40.widget
    local v47 = false
    local IgnoreVisibilityUpdater = v41:GetAttribute("IgnoreVisibilityUpdater")
    local Visible = widget:GetPropertyChangedSignal("Visible")
    v42:add(Visible:Connect(function() -- line 253 | captures: v47, v41, widget, IgnoreVisibilityUpdater, v1
        if not IgnoreVisibilityUpdater then
            local v48 = if v47 then false else widget.Visible
            v1.setVisible(v41, v48, "ClipHandler")
        end
    end))
    local joinedFrame, v49

    function v49() -- line 262 | captures: v49, v47, joinedFrame, v40, v41, v42, iconModule, widget, IgnoreVisibilityUpdater, v1
        task.defer(function() -- line 263 | captures: v49, v47, joinedFrame, v40, v41, v42, iconModule, widget, IgnoreVisibilityUpdater, v1
            local UID = v40.UID
            local joinedFrame_2
            if v41:GetAttribute("ClipToJoinedParent") then
                local v50 = UID
                for v51 = 1, 10 do
                    local v52 = iconModule.getIconByUID(v50)
                    local joinedFrame
                    if v52 then
                        joinedFrame = v52.joinedFrame
                        v50 = v52.parentIconUID
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
                local v53 = v41.AbsolutePosition + v41.AbsoluteSize / 2
                local v54 = v53.X < AbsolutePosition.X
                local v55 = AbsolutePosition.X + AbsoluteSize.X < v53.X
                local v56 = v53.Y < AbsolutePosition.Y
                local v57 = AbsolutePosition.Y + AbsoluteSize.Y < v53.Y
                local v58 = v54 or v55 or v56 or v57
                local v59, v60
                if v58 == v47 then
                    v60 = true
                else
                    v47 = v58
                    if IgnoreVisibilityUpdater then
                        v60 = true
                    else
                        if v47 then
                            v59 = false
                        else
                            v59 = widget.Visible
                        end
                        v60 = false
                    end
                end
                if not v60 then
                    v1.setVisible(v41, v59, "ClipHandler")
                end
                if joinedFrame_2:IsA("ScrollingFrame") and joinedFrame ~= joinedFrame_2 then
                    joinedFrame = joinedFrame_2
                    local v61 = joinedFrame_2:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() -- line 324 | captures: v49
                        v49()
                    end)
                    v42:add(v61, "Disconnect", "TrackUtilityScroller-" .. UID)
                end
            else
                v47 = false
                if not IgnoreVisibilityUpdater then
                    local v62 = if v47 then false else widget.Visible
                    v1.setVisible(v41, v62, "ClipHandler")
                end
            end
        end)
    end

    local CurrentCamera = workspace.CurrentCamera
    local v63 = v41:GetAttribute("AdditionalOffsetX") or 0

    local function trackProperty(v64) -- line 333 | captures: v49, ScreenGui, v47, joinedFrame, v40, v41, v42, v43, iconModule, widget, IgnoreVisibilityUpdater, CurrentCamera, v63, v1, GuiService
        local v65 = "Absolute" .. v64

        local function updateProperty() -- line 336 | captures: v64, v65, v49, ScreenGui, v47, joinedFrame, v40, v41, v42, v43, iconModule, widget, IgnoreVisibilityUpdater, CurrentCamera, v63, v1, GuiService
            local v66 = v43[v65]
            local v67 = UDim2.fromOffset(v66.X, v66.Y)
            local v68
            if v64 == "Position" then
                local v69 = CurrentCamera.ViewportSize.X - v41.AbsoluteSize.X - 4
                local Offset = v67.X.Offset
                if Offset < 4 then
                    v69 = 4
                elseif not (v69 < Offset) then
                    v69 = Offset
                end
                local v70 = if iconModule.isOldTopbar then ScreenGui.AbsolutePosition.X else workspace.CurrentCamera.ViewportSize.X - ScreenGui.AbsoluteSize.X - 0
                local v71 = v70 - v63
                v68 = UDim2.fromOffset(v69, v67.Y.Offset) + UDim2.fromOffset(-v71, GuiService.TopbarInset.Height)
                task.defer(function() -- line 355 | captures: v49, v47, joinedFrame, v40, v41, v42, iconModule, widget, IgnoreVisibilityUpdater, v1
                    local UID = v40.UID
                    local joinedFrame_2
                    if v41:GetAttribute("ClipToJoinedParent") then
                        local v72 = UID
                        for v73 = 1, 10 do
                            local v74 = iconModule.getIconByUID(v72)
                            local joinedFrame
                            if v74 then
                                joinedFrame = v74.joinedFrame
                                v72 = v74.parentIconUID
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
                        local v75 = v41.AbsolutePosition + v41.AbsoluteSize / 2
                        local v76 = v75.X < AbsolutePosition.X
                        local v77 = AbsolutePosition.X + AbsoluteSize.X < v75.X
                        local v78 = v75.Y < AbsolutePosition.Y
                        local v79 = AbsolutePosition.Y + AbsoluteSize.Y < v75.Y
                        local v80 = v76 or v77 or v78 or v79
                        local v81, v82
                        if v80 == v47 then
                            v82 = true
                        else
                            v47 = v80
                            if IgnoreVisibilityUpdater then
                                v82 = true
                            else
                                if v47 then
                                    v81 = false
                                else
                                    v81 = widget.Visible
                                end
                                v82 = false
                            end
                        end
                        if not v82 then
                            v1.setVisible(v41, v81, "ClipHandler")
                        end
                        if joinedFrame_2:IsA("ScrollingFrame") and joinedFrame ~= joinedFrame_2 then
                            joinedFrame = joinedFrame_2
                            local v83 = joinedFrame_2:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() -- line 416 | captures: v49
                                v49()
                            end)
                            v42:add(v83, "Disconnect", "TrackUtilityScroller-" .. UID)
                        end
                    else
                        v47 = false
                        if not IgnoreVisibilityUpdater then
                            local v84 = if v47 then false else widget.Visible
                            v1.setVisible(v41, v84, "ClipHandler")
                        end
                    end
                end)
            else
                v68 = v67
            end
            v41[v64] = v68
        end

        local v85 = v1.createStagger(0.01, updateProperty)
        local v86 = v43:GetPropertyChangedSignal(v65)
        v42:add(v86:Connect(v85))
        local ForceUpdate = v43:GetAttributeChangedSignal("ForceUpdate")
        v42:add(ForceUpdate:Connect(function() -- line 429 | captures: v85
            v85()
        end))
        local v87 = v1.createStagger(0.5, updateProperty, true)
        local v88 = v43:GetPropertyChangedSignal(v65)
        v42:add(v88:Connect(v87))
        if v64 == "Position" then
            local AbsoluteSize = ScreenGui:GetPropertyChangedSignal("AbsoluteSize")
            v42:add(AbsoluteSize:Connect(function() -- line 437 | captures: v85
                v85()
            end))
        end
    end

    task.delay(0.1, v49)
    task.defer(function() -- line 443 | captures: v49, v47, joinedFrame, v40, v41, v42, iconModule, widget, IgnoreVisibilityUpdater, v1
        local UID = v40.UID
        local joinedFrame_2
        if v41:GetAttribute("ClipToJoinedParent") then
            local v89 = UID
            for v90 = 1, 10 do
                local v91 = iconModule.getIconByUID(v89)
                local joinedFrame
                if v91 then
                    joinedFrame = v91.joinedFrame
                    v89 = v91.parentIconUID
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
            local v92 = v41.AbsolutePosition + v41.AbsoluteSize / 2
            local v93 = v92.X < AbsolutePosition.X
            local v94 = AbsolutePosition.X + AbsoluteSize.X < v92.X
            local v95 = v92.Y < AbsolutePosition.Y
            local v96 = AbsolutePosition.Y + AbsoluteSize.Y < v92.Y
            local v97 = v93 or v94 or v95 or v96
            local v98, v99
            if v97 == v47 then
                v99 = true
            else
                v47 = v97
                if IgnoreVisibilityUpdater then
                    v99 = true
                else
                    if v47 then
                        v98 = false
                    else
                        v98 = widget.Visible
                    end
                    v99 = false
                end
            end
            if not v99 then
                v1.setVisible(v41, v98, "ClipHandler")
            end
            if joinedFrame_2:IsA("ScrollingFrame") and joinedFrame ~= joinedFrame_2 then
                joinedFrame = joinedFrame_2
                local v100 = joinedFrame_2:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() -- line 504 | captures: v49
                    v49()
                end)
                v42:add(v100, "Disconnect", "TrackUtilityScroller-" .. UID)
            end
        else
            v47 = false
            if not IgnoreVisibilityUpdater then
                local v101 = if v47 then false else widget.Visible
                v1.setVisible(v41, v101, "ClipHandler")
            end
        end
    end)
    if not IgnoreVisibilityUpdater then
        local v102 = if v47 then false else widget.Visible
        v1.setVisible(v41, v102, "ClipHandler")
    end
    trackProperty("Position")
    v42:add(v41:GetPropertyChangedSignal("Visible"):Connect(function() -- line 516
    end))
    if v41:GetAttribute("TrackCloneSize") then
        trackProperty("Size")
    else
        local AbsoluteSize = v41:GetPropertyChangedSignal("AbsoluteSize")
        v42:add(AbsoluteSize:Connect(function() -- line 519 | captures: v41, v43
            local AbsoluteSize = v41.AbsoluteSize
            v43.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y)
        end))
    end
    return v43
end

local function joinFeature(v103, v104, v105, v106) -- line 528
    local joinJanitor = v103.joinJanitor
    joinJanitor:clean()
    if v106 then
        v103.parentIconUID = v104.UID
        v103.joinedFrame = v106
        joinJanitor:add(v104.alignmentChanged:Connect(function() -- line 538 | captures: v103, v104
            local alignment = v104.alignment
            if alignment == "Center" then
                alignment = "Left"
            end
            v103:setAlignment(alignment, true)
        end))
        local alignment = v104.alignment
        if alignment == "Center" then
            alignment = "Left"
        end
        v103:setAlignment(alignment, true)
        v103:modifyTheme({ "IconButton", "BackgroundTransparency", 1 }, "JoinModification")
        v103:modifyTheme({ "ClickRegion", "Active", false }, "JoinModification")
        if v104.childModifications then
            task.defer(function() -- line 553 | captures: v103, v104
                v103:modifyTheme(v104.childModifications, v104.childModificationsUID)
            end)
        end
        local ClickRegion = v103:getInstance("ClickRegion")

        local function makeSelectable() -- line 558 | captures: v104, ClickRegion
            ClickRegion.Selectable = v104.isSelected
        end

        joinJanitor:add(v104.toggled:Connect(makeSelectable))
        task.defer(makeSelectable)
        joinJanitor:add(function() -- line 563 | captures: ClickRegion
            ClickRegion.Selectable = true
        end)
        local UID = v103.UID
        table.insert(v105, UID)
        v104:autoDeselect(false)
        v104.childIconsDict[UID] = true
        if not v104.isEnabled then
            v104:setEnabled(true)
        end
        v103.joinedParent:Fire(v104)
        joinJanitor:add(function() -- line 574 | captures: v103, v104, v105, UID
            if not v103.joinedFrame then
                return
            end
            for v107, v108 in pairs(v105) do
                if v108 == UID then
                    table.remove(v105, v107)
                    break
                end
            end
            local v109 = require(v103.iconModule).getIconByUID(v103.parentIconUID)
            if not v109 then
                return
            end
            v103:setAlignment(v103.originalAlignment)
            v103.parentIconUID = false
            v103.joinedFrame = false
            v103:removeModification("JoinModification")
            local childIconsDict = v109.childIconsDict
            childIconsDict[UID] = nil
            local v110 = true
            for v111, v112 in pairs(childIconsDict) do
                v110 = false
                break
            end
            if v110 and not v109.isAnOverflow then
                v109:setEnabled(false)
            end
            local alignment = v104.alignment
            if alignment == "Center" then
                alignment = "Left"
            end
            v103:setAlignment(alignment, true)
        end)
    else
        v103:leave()
    end
end

v1.joinFeature = joinFeature
return v1
