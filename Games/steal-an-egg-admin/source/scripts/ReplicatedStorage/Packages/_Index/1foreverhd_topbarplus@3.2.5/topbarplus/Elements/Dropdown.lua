-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function(v1) -- line 6
    local Frame = Instance.new("Frame")
    Frame.Name = "Dropdown"
    Frame.AutomaticSize = Enum.AutomaticSize.XY
    Frame.BackgroundTransparency = 1
    Frame.BorderSizePixel = 0
    Frame.AnchorPoint = Vector2.new(0.5, 0)
    Frame.Position = UDim2.new(0.5, 0, 1, 10)
    Frame.ZIndex = -2
    Frame.ClipsDescendants = true
    Frame.Parent = v1.widget
    local GuiService = game:GetService("GuiService")
    v1:setBehaviour("Dropdown", "BackgroundTransparency", function(v2) -- line 19 | captures: GuiService
        if v2 == 1 then
            return v2
        end
        return v2 * GuiService.PreferredTransparency
    end)
    v1.janitor:add(GuiService:GetPropertyChangedSignal("PreferredTransparency"):Connect(function() -- line 27 | captures: v1, Frame
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
    v1.dropdownChildAdded:Connect(function(v3) -- line 70
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
        task.defer(function() -- line 92 | captures: v3, v13
            v3.joinJanitor:add(function() -- line 93 | captures: v3, v13
                v3:removeModification(v13)
            end)
        end)
    end)
    v1.dropdownSet:Connect(function(v14) -- line 98 | captures: v1, iconModule
        for v15, v16 in pairs(v1.dropdownIcons) do
            iconModule.getIconByUID(v16):destroy()
        end
        if type(v14) == "table" then
            for v17, v18 in pairs(v14) do
                v18:joinDropdown(v1)
            end
        end
    end)
    local Utility = require(script.Parent.Parent.Utility)
    dropdownJanitor:add(v1.toggled:Connect(function() -- line 109 | captures: v1, Frame, Utility
        Utility.setVisible(Frame, v1.isSelected, "InternalDropdown")
    end))
    Utility.setVisible(Frame, v1.isSelected, "InternalDropdown")
    local v19 = 0
    local v20 = false
    local v21

    function v21() -- line 115 | captures: v21, v19, v20, v1, Frame, ScrollingFrame, UIPadding, iconModule
        v19 += 1
        if v20 then
            return
        end
        local v22 = v19
        v20 = true
        task.defer(function() -- line 123 | captures: v22, v21, v19, v20
            v20 = false
            if v19 ~= v22 then
                v21()
            end
        end)
        local MaxIcons = Frame:GetAttribute("MaxIcons")
        if not MaxIcons then
            return
        end
        local v23 = {}
        for v24, v25 in pairs(ScrollingFrame:GetChildren()) do
            if v25:IsA("GuiObject") then
                local v26 = {
                    v25,
                    v25.AbsolutePosition.Y
                }
                table.insert(v23, v26)
            end
        end
        table.sort(v23, function(v27, v28) -- line 139
            return v27[2] < v28[2]
        end)
        local v29 = math.ceil(MaxIcons)
        local v30 = 0
        local v31 = false
        for v32 = 1, v29 do
            local v33 = v23[v32]
            if v33 then
                local v34 = v33[1]
                local Y = v34.AbsoluteSize.Y
                local v35 = if v32 == v29 then v29 ~= MaxIcons else false
                if v35 then
                    Y *= MaxIcons - v29 + 1
                end
                v30 += Y
                if not v35 then
                    local WidgetUID = v34:GetAttribute("WidgetUID")
                    local v36 = WidgetUID and iconModule.getIconByUID(WidgetUID)
                    if v36 then
                        local v37, v38
                        if v31 then
                            v38 = v31
                        else
                            v37 = v1:getInstance("ClickRegion")
                            v38 = true
                        end
                        v36:getInstance("ClickRegion").NextSelectionUp = v37
                        v31 = v38
                    end
                end
            else
                break
            end
        end
        local v39 = v30 + UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Offset
        ScrollingFrame.Size = UDim2.fromOffset(0, v39)
    end

    dropdownJanitor:add(ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(v21))
    dropdownJanitor:add(ScrollingFrame.ChildAdded:Connect(v21))
    dropdownJanitor:add(ScrollingFrame.ChildRemoved:Connect(v21))
    dropdownJanitor:add(Frame:GetAttributeChangedSignal("MaxIcons"):Connect(v21))
    dropdownJanitor:add(v1.childThemeModified:Connect(v21))
    v21()
    return Frame
end
