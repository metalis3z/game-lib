-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function(v1) -- line 6
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Name = "Menu"
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.Visible = true
    ScrollingFrame.ZIndex = 1
    ScrollingFrame.Size = UDim2.fromScale(1, 1)
    ScrollingFrame.ClipsDescendants = true
    ScrollingFrame.TopImage = ""
    ScrollingFrame.BottomImage = ""
    ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.Always
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, -1)
    ScrollingFrame.ScrollingEnabled = true
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.X
    ScrollingFrame.ZIndex = 20
    ScrollingFrame.ScrollBarThickness = 3
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    ScrollingFrame.ScrollBarImageTransparency = 0.8
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.Selectable = false
    local iconModule = require(v1.iconModule)
    local v2 = iconModule.container.TopbarStandard:FindFirstChild("UIListLayout", true):Clone()
    v2.Name = "MenuUIListLayout"
    v2.VerticalAlignment = Enum.VerticalAlignment.Center
    v2.Parent = ScrollingFrame
    local Frame = Instance.new("Frame")
    Frame.Name = "MenuGap"
    Frame.BackgroundTransparency = 1
    Frame.Visible = false
    Frame.AnchorPoint = Vector2.new(0, 0.5)
    Frame.ZIndex = 5
    Frame.Parent = ScrollingFrame
    local v3 = false
    local Themes = require(script.Parent.Parent.Features.Themes)
    v1.menuChildAdded:Connect(function() -- line 40 | captures: v3, v1, ScrollingFrame, v2, Themes
        local menuJanitor = v1.menuJanitor
        local v4 = #v1.menuIcons
        if v3 then
            if v4 <= 0 then
                menuJanitor:clean()
                v3 = false
            end
        else
            v3 = true
            menuJanitor:add(v1.toggled:Connect(function() -- line 52 | captures: v1
                if #v1.menuIcons > 0 then
                    v1.updateSize:Fire()
                end
            end))
            local v5 = { { "Menu", "Active", true } }
            local v6, v7 = v1:modifyTheme(v5)
            _ = v6
            task.defer(function() -- line 62 | captures: menuJanitor, v7, v1
                menuJanitor:add(function() -- line 63 | captures: v7, v1
                    v1:removeModification(v7)
                end)
            end)
            local X = ScrollingFrame.AbsoluteCanvasSize.X

            local function rightAlignCanvas() -- line 68 | captures: X, v1, ScrollingFrame
                if v1.alignment ~= "Right" then
                    return
                end
                local X_2 = ScrollingFrame.AbsoluteCanvasSize.X
                local v8 = X - X_2
                X = X_2
                ScrollingFrame.CanvasPosition = Vector2.new(ScrollingFrame.CanvasPosition.X - v8, 0)
            end

            menuJanitor:add(v1.selected:Connect(rightAlignCanvas))
            menuJanitor:add(ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(rightAlignCanvas))
            local v9 = v1:getStateGroup()
            if Themes.getThemeValue(v9, "IconImage", "Image", "Deselected") == Themes.getThemeValue(v9, "IconImage", "Image", "Selected") then
                local v10 = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Light, Enum.FontStyle.Normal)
                v1:removeModificationWith("IconLabel", "Text", "Viewing")
                v1:removeModificationWith("IconLabel", "Image", "Viewing")
                v1:modifyTheme({
                    { "IconLabel", "FontFace", v10, "Selected" },
                    { "IconLabel", "Text", "X", "Selected" },
                    { "IconLabel", "TextSize", 20, "Selected" },
                    { "IconLabel", "TextStrokeTransparency", 0.8, "Selected" },
                    { "IconImage", "Image", "", "Selected" }
                })
            end
            local MenuGap = v1:getInstance("MenuGap")
            local alignmentChanged = v1.alignmentChanged
            menuJanitor:add(alignmentChanged:Connect(function() -- line 94 | captures: MenuGap, v1
                local v11, v12
                if v1.alignment == "Right" then
                    v11 = 99999
                    v12 = 99998
                else
                    v11 = -99999
                    v12 = -99998
                end
                v1:modifyTheme({ "IconSpot", "LayoutOrder", v11 })
                MenuGap.LayoutOrder = v12
            end))
            local v13, v14
            if v1.alignment == "Right" then
                v13 = 99999
                v14 = 99998
            else
                v13 = -99999
                v14 = -99998
            end
            v1:modifyTheme({ "IconSpot", "LayoutOrder", v13 })
            MenuGap.LayoutOrder = v14
            ScrollingFrame:GetAttributeChangedSignal("MenuCanvasWidth"):Connect(function() -- line 113 | captures: ScrollingFrame
                local MenuCanvasWidth = ScrollingFrame:GetAttribute("MenuCanvasWidth")
                local Y = ScrollingFrame.CanvasSize.Y
                ScrollingFrame.CanvasSize = UDim2.new(0, MenuCanvasWidth, Y.Scale, Y.Offset)
            end)
            menuJanitor:add(v1.updateMenu:Connect(function() -- line 118 | captures: ScrollingFrame, v2
                local MaxIcons = ScrollingFrame:GetAttribute("MaxIcons")
                if not MaxIcons then
                    return
                end
                local v15 = {}
                for v16, v17 in pairs(ScrollingFrame:GetChildren()) do
                    if v17:GetAttribute("WidgetUID") and v17.Visible then
                        local v18 = {
                            v17,
                            v17.AbsolutePosition.X
                        }
                        table.insert(v15, v18)
                    end
                end
                table.sort(v15, function(v19, v20) -- line 130
                    return v19[2] < v20[2]
                end)
                local v21 = 0
                for v22 = 1, MaxIcons do
                    local v23 = v15[v22]
                    if not v23 then
                        break
                    end
                    v21 += v23[1].AbsoluteSize.X + v2.Padding.Offset
                end
                ScrollingFrame:SetAttribute("MenuWidth", v21)
            end))

            local function startMenuUpdate() -- line 146 | captures: v1
                task.delay(0.1, function() -- line 147 | captures: v1
                    v1.startMenuUpdate:Fire()
                end)
            end

            menuJanitor:add(ScrollingFrame.ChildAdded:Connect(startMenuUpdate))
            menuJanitor:add(ScrollingFrame.ChildRemoved:Connect(startMenuUpdate))
            menuJanitor:add(ScrollingFrame:GetAttributeChangedSignal("MaxIcons"):Connect(startMenuUpdate))
            menuJanitor:add(ScrollingFrame:GetAttributeChangedSignal("MaxWidth"):Connect(startMenuUpdate))
            task.delay(0.1, function() -- line 157 | captures: v1
                v1.startMenuUpdate:Fire()
            end)
        end
    end)
    v1.menuSet:Connect(function(v24) -- line 161 | captures: v1, iconModule
        for v25, v26 in pairs(v1.menuIcons) do
            iconModule.getIconByUID(v26):destroy()
        end
        if type(v24) == "table" then
            for v27, v28 in pairs(v24) do
                v28:joinMenu(v1)
            end
        end
    end)
    return ScrollingFrame
end
