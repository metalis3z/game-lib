-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Themes = require(script.Parent.Parent.Features.Themes)
return function(v1) -- line 9 | captures: TweenService, RunService, Themes
    local Frame = Instance.new("Frame")
    Frame.Name = "Dropdown"
    Frame.AutomaticSize = Enum.AutomaticSize.X
    Frame.BackgroundTransparency = 1
    Frame.BorderSizePixel = 0
    Frame.AnchorPoint = Vector2.new(0.5, 0)
    Frame.Position = UDim2.new(0.5, 0, 1, 10)
    Frame.ZIndex = -2
    Frame.ClipsDescendants = true
    Frame.Parent = v1.widget
    local GuiService = game:GetService("GuiService")
    v1:setBehaviour("Dropdown", "BackgroundTransparency", function(v2) -- line 22 | captures: GuiService
        if v2 == 1 then
            return v2
        end
        return v2 * GuiService.PreferredTransparency
    end)
    v1.janitor:add(GuiService:GetPropertyChangedSignal("PreferredTransparency"):Connect(function() -- line 30 | captures: v1, Frame
        v1:refreshAppearance(Frame, "BackgroundTransparency")
    end))
    local UICorner = Instance.new("UICorner")
    UICorner.Name = "DropdownCorner"
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = Frame
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Name = "DropdownScroller"
    ScrollingFrame.AutomaticSize = Enum.AutomaticSize.X
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.AnchorPoint = Vector2.new(0, 0)
    ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
    ScrollingFrame.ZIndex = -1
    ScrollingFrame.ClipsDescendants = true
    ScrollingFrame.Visible = true
    ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.None
    ScrollingFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
    ScrollingFrame.Active = false
    ScrollingFrame.ScrollingEnabled = true
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ScrollingFrame.ScrollBarThickness = 5
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    ScrollingFrame.ScrollBarImageTransparency = 0.8
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollingFrame.Selectable = false
    ScrollingFrame.Active = true
    ScrollingFrame.Parent = Frame
    local NumberValue = Instance.new("NumberValue")
    NumberValue.Name = "DropdownSpeed"
    NumberValue.Value = 0.07
    NumberValue.Parent = Frame
    local UIPadding = Instance.new("UIPadding")
    UIPadding.Name = "DropdownPadding"
    UIPadding.PaddingTop = UDim.new(0, 0)
    UIPadding.PaddingBottom = UDim.new(0, 0)
    UIPadding.Parent = ScrollingFrame
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Name = "DropdownList"
    UIListLayout.FillDirection = Enum.FillDirection.Vertical
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly
    UIListLayout.Parent = ScrollingFrame
    local dropdownJanitor = v1.dropdownJanitor
    local iconModule = require(v1.iconModule)
    v1.dropdownChildAdded:Connect(function(v3) -- line 77
        local v4 = {}
        local v5 = {
            "IconCorners",
            "CornerRadius",
            UDim.new(0, 10)
        }
        local v6 = {
            "IconOverlay",
            "Size",
            UDim2.new(1, 0, 1, 0)
        }
        local v7 = {
            "PaddingLeft",
            "Size",
            UDim2.fromOffset(25, 0)
        }
        local v8 = {
            "Notice",
            "Position",
            UDim2.new(1, -24, 0, 5)
        }
        local v9 = {
            "ContentsList",
            "HorizontalAlignment",
            Enum.HorizontalAlignment.Left
        }
        local v10 = {
            "Selection",
            "Size",
            UDim2.new(1, -0, 1, -0)
        }
        local v11 = {
            "Selection",
            "Position",
            UDim2.new(0, 0, 0, 0)
        }
        v4[1] = { "Widget", "BorderSize", 0 }
        v4[2] = v5
        v4[3] = { "Widget", "MinimumWidth", 190 }
        v4[4] = { "Widget", "MinimumHeight", 58 }
        v4[5] = { "IconLabel", "TextSize", 20 }
        v4[6] = v6
        v4[7] = v7
        v4[8] = v8
        v4[9] = v9
        v4[10] = v10
        v4[11] = v11
        local v12, v13 = v3:modifyTheme(v4)
        _ = v12
        task.defer(function() -- line 99 | captures: v3, v13
            v3.joinJanitor:add(function() -- line 100 | captures: v3, v13
                v3:removeModification(v13)
            end)
        end)
    end)
    v1.dropdownSet:Connect(function(v14) -- line 105 | captures: v1, iconModule
        for v15, v16 in pairs(v1.dropdownIcons) do
            iconModule.getIconByUID(v16):destroy()
        end
        if type(v14) == "table" then
            for v17, v18 in pairs(v14) do
                v18:joinDropdown(v1)
            end
        end
    end)

    local function updateMaxIcons() -- line 115 | captures: Frame, ScrollingFrame, UIPadding
        local MaxIcons = Frame:GetAttribute("MaxIcons")
        if MaxIcons then
            local v19 = {}
            for v20, v21 in pairs(ScrollingFrame:GetChildren()) do
                if v21:IsA("GuiObject") and v21.Visible then
                    table.insert(v19, v21)
                end
            end
            table.sort(v19, function(v22, v23) -- line 127
                return v22.AbsolutePosition.Y < v23.AbsolutePosition.Y
            end)
            local v24 = math.ceil(MaxIcons)
            local v25 = 0
            for v26 = 1, v24 do
                local v27 = v19[v26]
                local Y
                if v27 then
                    Y = v27.AbsoluteSize.Y
                    if v26 == v24 and v24 ~= MaxIcons then
                        Y *= MaxIcons - v24 + 1
                    end
                else
                    break
                end
                v25 += Y
            end
            return v25 + (UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Offset)
        end
        return 0
    end

    local v28, v29, v30, v31

    local function getTweenInfo() -- line 153 | captures: v30, v31, Frame, NumberValue, Themes
        local v32 = Themes.getInstanceValue(Frame, "MaxIcons") or 1
        if not (v30 and v30 == v32) then
            local v33 = TweenInfo.new(NumberValue.Value * v32, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
            v31 = v33
            v30 = v32
            return v33
        end
        if v31 then
            return v31
        end
        local v34 = TweenInfo.new(NumberValue.Value * v32, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
        v31 = v34
        v30 = v32
        return v34
    end

    local function updateVisibility() -- line 170 | captures: v28, v29, v30, v31, v1, Frame, NumberValue, updateMaxIcons, TweenService, Themes
        local v35 = Themes.getInstanceValue(Frame, "MaxIcons") or 1
        local v36
        if v30 then
            if v30 == v35 and v31 then
                v36 = v31
            end
        else
            v36 = TweenInfo.new(NumberValue.Value * v35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
            v31 = v36
            v30 = v35
        end
        if v28 then
            v28:Cancel()
            v28 = nil
        end
        if v29 then
            v29:Cancel()
            v29 = nil
        end
        if v1.isSelected then
            Frame.Visible = true
            Frame.BackgroundTransparency = 0
            Frame.Size = UDim2.new(0, Frame.Size.X.Offset, 0, 0)
            v28 = TweenService:Create(Frame, v36, { Size = UDim2.new(0, Frame.Size.X.Offset, 0, (updateMaxIcons())) })
            v28:Play()
            v28.Completed:Connect(function() -- line 203 | captures: v28
                v28 = nil
            end)
        else
            local v37 = TweenInfo.new(0)
            v29 = TweenService:Create(Frame, v37, { Size = UDim2.new(0, Frame.Size.X.Offset, 0, 0) })
            v29:Play()
            v29.Completed:Connect(function() -- line 193 | captures: v29
                v29 = nil
            end)
        end
    end

    dropdownJanitor:add(v1.toggled:Connect(updateVisibility))
    updateVisibility()

    local function updateChildSize() -- line 209 | captures: v28, v29, v30, v31, v1, Frame, NumberValue, updateMaxIcons, TweenService, RunService, Themes
        local v38 = Themes.getInstanceValue(Frame, "MaxIcons") or 1
        local v39
        if v30 then
            if v30 == v38 and v31 then
                v39 = v31
            end
        else
            v39 = TweenInfo.new(NumberValue.Value * v38, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
            v31 = v39
            v30 = v38
        end
        if not v1.isSelected then
            return
        end
        if v28 then
            v28:Cancel()
            v28 = nil
        end
        if v29 then
            v29:Cancel()
            v29 = nil
        end
        RunService.Heartbeat:Wait()
        v28 = TweenService:Create(Frame, v39, { Size = UDim2.new(0, Frame.Size.X.Offset, 0, (updateMaxIcons())) })
        v28:Play()
        v28.Completed:Connect(function() -- line 234 | captures: v28
            v28 = nil
        end)
    end

    dropdownJanitor:add(v1.toggled:Connect(updateVisibility))
    local v40 = 0
    local v41 = false
    local v42

    function v42() -- line 241 | captures: v42, v40, v41, v1, Frame, ScrollingFrame, UIPadding, iconModule
        v40 += 1
        if v41 then
            return
        end
        local v43 = v40
        v41 = true
        task.defer(function() -- line 249 | captures: v43, v42, v40, v41
            v41 = false
            if v40 ~= v43 then
                v42()
            end
        end)
        local MaxIcons = Frame:GetAttribute("MaxIcons")
        if not MaxIcons then
            return
        end
        local v44 = {}
        for v45, v46 in pairs(ScrollingFrame:GetChildren()) do
            if v46:IsA("GuiObject") and v46.Visible then
                local v47 = {
                    v46,
                    v46.AbsolutePosition.Y
                }
                table.insert(v44, v47)
            end
        end
        table.sort(v44, function(v48, v49) -- line 265
            return v48[2] < v49[2]
        end)
        local v50 = math.ceil(MaxIcons)
        local v51 = 0
        local v52 = false
        for v53 = 1, v50 do
            local v54 = v44[v53]
            if v54 then
                local v55 = v54[1]
                local Y = v55.AbsoluteSize.Y
                local v56 = if v53 == v50 then v50 ~= MaxIcons else false
                if v56 then
                    Y *= MaxIcons - v50 + 1
                end
                v51 += Y
                if not v56 then
                    local WidgetUID = v55:GetAttribute("WidgetUID")
                    local v57 = WidgetUID and iconModule.getIconByUID(WidgetUID)
                    if v57 then
                        local v58, v59
                        if v52 then
                            v59 = v52
                        else
                            v58 = v1:getInstance("ClickRegion")
                            v59 = true
                        end
                        v57:getInstance("ClickRegion").NextSelectionUp = v58
                        v52 = v59
                    end
                end
            else
                break
            end
        end
        local v60 = v51 + (UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Offset)
        ScrollingFrame.Size = UDim2.fromOffset(0, v60)
    end

    dropdownJanitor:add(ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(v42))
    dropdownJanitor:add(ScrollingFrame.ChildAdded:Connect(v42))
    dropdownJanitor:add(ScrollingFrame.ChildRemoved:Connect(updateChildSize))
    dropdownJanitor:add(ScrollingFrame.ChildRemoved:Connect(v42))
    dropdownJanitor:add(Frame:GetAttributeChangedSignal("MaxIcons"):Connect(v42))
    dropdownJanitor:add(Frame:GetAttributeChangedSignal("MaxIcons"):Connect(updateChildSize))
    dropdownJanitor:add(v1.childThemeModified:Connect(v42))
    v42()

    local function connectVisibilityListeners(v61) -- line 316 | captures: updateChildSize
        if v61:IsA("GuiObject") then
            v61:GetPropertyChangedSignal("Visible"):Connect(updateChildSize)
            v61:GetPropertyChangedSignal("Size"):Connect(updateChildSize)
        end
    end

    for v62, v63 in pairs(ScrollingFrame:GetChildren()) do
        if v63:IsA("GuiObject") then
            v63:GetPropertyChangedSignal("Visible"):Connect(updateChildSize)
            v63:GetPropertyChangedSignal("Size"):Connect(updateChildSize)
        end
    end
    ScrollingFrame.ChildAdded:Connect(function(v64) -- line 332 | captures: updateChildSize, RunService
        RunService.Heartbeat:Wait()
        if v64:IsA("GuiObject") then
            v64:GetPropertyChangedSignal("Visible"):Connect(updateChildSize)
            v64:GetPropertyChangedSignal("Size"):Connect(updateChildSize)
        end
        updateChildSize()
    end)
    Frame.Visible = false
    return Frame
end
