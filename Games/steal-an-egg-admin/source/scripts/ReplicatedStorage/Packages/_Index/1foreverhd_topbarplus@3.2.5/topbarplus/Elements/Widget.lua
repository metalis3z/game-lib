-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function(v1, v2) -- line 6
    local Frame = Instance.new("Frame")
    Frame:SetAttribute("WidgetUID", v1.UID)
    Frame.Name = "Widget"
    Frame.BackgroundTransparency = 1
    Frame.Visible = true
    Frame.ZIndex = 20
    Frame.Active = false
    Frame.ClipsDescendants = true
    local Frame_2 = Instance.new("Frame")
    Frame_2.Name = "IconButton"
    Frame_2.Visible = true
    Frame_2.ZIndex = 2
    Frame_2.BorderSizePixel = 0
    Frame_2.Parent = Frame
    Frame_2.ClipsDescendants = true
    Frame_2.Active = false
    v1.deselected:Connect(function() -- line 23 | captures: v1, Frame_2
        Frame_2.ClipsDescendants = true
        task.delay(0.2, function() -- line 25 | captures: v1, Frame_2
            if v1.isSelected then
                Frame_2.ClipsDescendants = false
            end
        end)
    end)
    local GuiService = game:GetService("GuiService")
    v1:setBehaviour("IconButton", "BackgroundTransparency", function(v3) -- line 32 | captures: GuiService
        if v3 == 1 then
            return v3
        end
        return v3 * GuiService.PreferredTransparency
    end)
    v1.janitor:add(GuiService:GetPropertyChangedSignal("PreferredTransparency"):Connect(function() -- line 40 | captures: v1, Frame_2
        v1:refreshAppearance(Frame_2, "BackgroundTransparency")
    end))
    local UICorner = Instance.new("UICorner")
    UICorner:SetAttribute("Collective", "IconCorners")
    UICorner.Name = "UICorner"
    UICorner.Parent = Frame_2
    local v4 = require(script.Parent.Menu)(v1)
    local MenuUIListLayout = v4.MenuUIListLayout
    local MenuGap = v4.MenuGap
    v4.Parent = Frame_2
    local Frame_3 = Instance.new("Frame")
    Frame_3.Name = "IconSpot"
    Frame_3.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
    Frame_3.BackgroundTransparency = 0.9
    Frame_3.Visible = true
    Frame_3.AnchorPoint = Vector2.new(0, 0.5)
    Frame_3.ZIndex = 5
    Frame_3.Parent = v4
    UICorner:Clone().Parent = Frame_3
    local v5 = Frame_3:Clone()
    v5.UICorner.Name = "OverlayUICorner"
    v5.Name = "IconOverlay"
    v5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    v5.ZIndex = Frame_3.ZIndex + 1
    v5.Size = UDim2.new(1, 0, 1, 0)
    v5.Position = UDim2.new(0, 0, 0, 0)
    v5.AnchorPoint = Vector2.new(0, 0)
    v5.Visible = false
    v5.Parent = Frame_3
    local TextButton = Instance.new("TextButton")
    TextButton:SetAttribute("CorrespondingIconUID", v1.UID)
    TextButton.Name = "ClickRegion"
    TextButton.BackgroundTransparency = 1
    TextButton.Visible = true
    TextButton.Text = ""
    TextButton.ZIndex = 20
    TextButton.Selectable = true
    TextButton.SelectionGroup = true
    TextButton.Parent = Frame_3
    require(script.Parent.Parent.Features.Gamepad).registerButton(TextButton)
    UICorner:Clone().Parent = TextButton
    local Frame_4 = Instance.new("Frame")
    Frame_4.Name = "Contents"
    Frame_4.BackgroundTransparency = 1
    Frame_4.Size = UDim2.fromScale(1, 1)
    Frame_4.Parent = Frame_3
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Name = "ContentsList"
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly
    UIListLayout.Padding = UDim.new(0, 3)
    UIListLayout.Parent = Frame_4
    local Frame_5 = Instance.new("Frame")
    Frame_5.Name = "PaddingLeft"
    Frame_5.LayoutOrder = 1
    Frame_5.ZIndex = 5
    Frame_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame_5.BackgroundTransparency = 1
    Frame_5.BorderSizePixel = 0
    Frame_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame_5.Parent = Frame_4
    local Frame_6 = Instance.new("Frame")
    Frame_6.Name = "PaddingCenter"
    Frame_6.LayoutOrder = 3
    Frame_6.ZIndex = 5
    Frame_6.Size = UDim2.new(0, 0, 1, 0)
    Frame_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame_6.BackgroundTransparency = 1
    Frame_6.BorderSizePixel = 0
    Frame_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame_6.Parent = Frame_4
    local Frame_7 = Instance.new("Frame")
    Frame_7.Name = "PaddingRight"
    Frame_7.LayoutOrder = 5
    Frame_7.ZIndex = 5
    Frame_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame_7.BackgroundTransparency = 1
    Frame_7.BorderSizePixel = 0
    Frame_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame_7.Parent = Frame_4
    local Frame_8 = Instance.new("Frame")
    Frame_8.Name = "IconLabelContainer"
    Frame_8.LayoutOrder = 4
    Frame_8.ZIndex = 3
    Frame_8.AnchorPoint = Vector2.new(0, 0.5)
    Frame_8.Size = UDim2.new(0, 0, 0.5, 0)
    Frame_8.BackgroundTransparency = 1
    Frame_8.Position = UDim2.new(0.5, 0, 0.5, 0)
    Frame_8.Parent = Frame_4
    local TextLabel = Instance.new("TextLabel")
    local v6 = workspace.CurrentCamera.ViewportSize.X + 200
    TextLabel.Name = "IconLabel"
    TextLabel.LayoutOrder = 4
    TextLabel.ZIndex = 15
    TextLabel.AnchorPoint = Vector2.new(0, 0)
    TextLabel.Size = UDim2.new(0, v6, 1, 0)
    TextLabel.ClipsDescendants = false
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.fromScale(0, 0)
    TextLabel.RichText = true
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Text = ""
    TextLabel.TextWrapped = true
    TextLabel.TextWrap = true
    TextLabel.TextScaled = false
    TextLabel.Active = false
    TextLabel.AutoLocalize = true
    TextLabel.Parent = Frame_8
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "IconImage"
    ImageLabel.LayoutOrder = 2
    ImageLabel.ZIndex = 15
    ImageLabel.AnchorPoint = Vector2.new(0, 0.5)
    ImageLabel.Size = UDim2.new(0, 0, 0.5, 0)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Position = UDim2.new(0, 11, 0.5, 0)
    ImageLabel.ScaleType = Enum.ScaleType.Stretch
    ImageLabel.Active = false
    ImageLabel.Parent = Frame_4
    local v7 = UICorner:Clone()
    v7:SetAttribute("Collective", nil)
    v7.CornerRadius = UDim.new(0, 0)
    v7.Name = "IconImageCorner"
    v7.Parent = ImageLabel
    local TweenService = game:GetService("TweenService")
    local v8 = 0
    local v9 = require(script.Parent.Parent.Utility).createStagger(0.01, function(v10) -- line 171 | captures: v8, v1, v2, Frame, Frame_2, v4, MenuUIListLayout, MenuGap, Frame_3, TextButton, Frame_4, UIListLayout, Frame_5, Frame_6, Frame_7, Frame_8, TextLabel, v6, ImageLabel, TweenService
        task.defer(function() -- line 172 | captures: v8, v1, v2, Frame, Frame_2, v4, MenuUIListLayout, MenuGap, Frame_3, TextButton, Frame_4, UIListLayout, Frame_5, Frame_6, Frame_7, Frame_8, TextLabel, v6, ImageLabel, TweenService
            local indicator = v1.indicator
            local v11 = indicator and indicator.Visible or TextLabel.Text ~= ""
            local v12 = if ImageLabel.Image == "" then false else ImageLabel.Image ~= nil
            local v13 = UDim2.fromScale(1, 1)
            if v12 then
                if not v11 then
                    Frame_8.Visible = false
                    ImageLabel.Visible = true
                    Frame_5.Visible = false
                    Frame_6.Visible = false
                    Frame_7.Visible = false
                end
            elseif v11 then
                Frame_8.Visible = true
                ImageLabel.Visible = false
                Frame_5.Visible = true
                Frame_6.Visible = false
                Frame_7.Visible = true
            end
            Frame_2.Size = v13

            local function getItemWidth(v14) -- line 209
                return v14:GetAttribute("TargetWidth") or v14.AbsoluteSize.X
            end

            local Offset = UIListLayout.Padding.Offset
            Frame_8.Size = UDim2.new(0, TextLabel.TextBounds.X, TextLabel.Size.Y.Scale, 0)
            local v15 = Offset
            for v16, v17 in pairs(Frame_4:GetChildren()) do
                if v17:IsA("GuiObject") and v17.Visible == true then
                    v15 += (v17:GetAttribute("TargetWidth") or v17.AbsoluteSize.X) + Offset
                end
            end
            local MinimumWidth = Frame:GetAttribute("MinimumWidth")
            local MinimumHeight = Frame:GetAttribute("MinimumHeight")
            local BorderSize = Frame:GetAttribute("BorderSize")
            local v18 = math.clamp(v15, MinimumWidth, v6)
            local v19 = #v1.menuIcons > 0 and v1.isSelected
            local v20
            if v19 then
                local v21 = 0
                for v22, v23 in pairs(v4:GetChildren()) do
                    if v23 ~= Frame_3 and v23:IsA("GuiObject") and v23.Visible then
                        v21 += (v23:GetAttribute("TargetWidth") or v23.AbsoluteSize.X) + MenuUIListLayout.Padding.Offset
                    end
                end
                local v24 = if Frame_3.Visible then v18 else v18 - ((Frame_3:GetAttribute("TargetWidth") or Frame_3.AbsoluteSize.X) + MenuUIListLayout.Padding.Offset * 2 + BorderSize)
                v20 = v21 - BorderSize * 0.5
                v18 = v24 + (v20 - BorderSize * 0.75)
                v19 = Frame_3.Visible
            else
                v20 = 0
            end
            MenuGap.Visible = v19
            local DesiredWidth = Frame:GetAttribute("DesiredWidth")
            if not (DesiredWidth and v18 < DesiredWidth) then
                DesiredWidth = v18
            end
            v1.updateMenu:Fire()
            local v25 = DesiredWidth - v20
            local v26 = math.max(v25, MinimumWidth) - BorderSize * 2
            local MenuWidth = v4:GetAttribute("MenuWidth")
            local v27 = MenuWidth and MenuWidth + v26 + MenuUIListLayout.Padding.Offset + 10
            if v27 then
                local MaxWidth = v4:GetAttribute("MaxWidth")
                if MaxWidth then
                    v27 = math.max(MaxWidth, MinimumWidth)
                end
                v4:SetAttribute("MenuCanvasWidth", DesiredWidth)
                if not (v27 < DesiredWidth) then
                    v27 = DesiredWidth
                end
            else
                v27 = DesiredWidth
            end
            local Quint = Enum.EasingStyle.Quint
            local Out = Enum.EasingDirection.Out
            local v28 = Frame_3:GetAttribute("TargetWidth") or Frame_3.AbsoluteSize.X
            local X = Frame_3.AbsoluteSize.X
            local v29 = math.max(v26, v28, X)
            local v30 = Frame:GetAttribute("TargetWidth") or Frame.AbsoluteSize.X
            local X_2 = Frame.AbsoluteSize.X
            local v31 = math.max(v27, v30, X_2)
            local v32 = TweenInfo.new(v29 / 750, Quint, Out)
            local v33 = TweenInfo.new(v31 / 750, Quint, Out)
            TweenService:Create(Frame_3, v32, {
                Position = UDim2.new(0, BorderSize, 0.5, 0),
                Size = UDim2.new(0, v26, 1, -BorderSize * 2)
            }):Play()
            TweenService:Create(TextButton, v32, { Size = UDim2.new(0, v26, 1, 0) }):Play()
            local v34 = UDim2.fromOffset(v27, MinimumHeight)
            if Frame.Size.Y.Offset ~= MinimumHeight then
                Frame.Size = v34
            end
            Frame:SetAttribute("TargetWidth", v34.X.Offset)
            TweenService:Create(Frame, v33, { Size = v34 }):Play()
            v8 += 1
            local v35 = v33.Time * 100
            for v36 = 1, v35 do
                task.delay(v36 / 100, function() -- line 316 | captures: v1, v2
                    v2.iconChanged:Fire(v1)
                end)
            end
            task.delay(v33.Time - 0.2, function() -- line 320 | captures: v8, v1
                v8 -= 1
                task.defer(function() -- line 322 | captures: v8, v1
                    if v8 == 0 then
                        v1.resizingComplete:Fire()
                    end
                end)
            end)
            v1:updateParent()
        end)
    end)
    local v37 = true
    v1:setBehaviour("IconLabel", "Text", v9)
    v1:setBehaviour("IconLabel", "FontFace", function(v38) -- line 333 | captures: v37, TextLabel, v9
        if TextLabel.FontFace ~= v38 then
            task.spawn(function() -- line 337 | captures: v37, v9
                v9()
                if v37 then
                    v37 = false
                    for v39 = 1, 10 do
                        task.wait(1)
                        v9()
                    end
                end
            end)
        end
    end)

    local function updateBorderSize() -- line 350 | captures: v1, Frame, v4, MenuUIListLayout, MenuGap, Frame_3, v9
        task.defer(function() -- line 351 | captures: v1, Frame, v4, MenuUIListLayout, MenuGap, Frame_3, v9
            local BorderSize = Frame:GetAttribute("BorderSize")
            local v40 = if Frame_3.Visible == false then 0 else v1.alignment == "Right" and -BorderSize or BorderSize
            v4.Position = UDim2.new(0, v40, 0, 0)
            MenuGap.Size = UDim2.fromOffset(BorderSize, 0)
            MenuUIListLayout.Padding = UDim.new(0, 0)
            v9()
        end)
    end

    v1:setBehaviour("Widget", "BorderSize", updateBorderSize)
    v1:setBehaviour("IconSpot", "Visible", updateBorderSize)
    v1.startMenuUpdate:Connect(v9)
    v1.updateSize:Connect(v9)
    v1:setBehaviour("ContentsList", "HorizontalAlignment", v9)
    v1:setBehaviour("Widget", "Visible", v9)
    v1:setBehaviour("Widget", "DesiredWidth", v9)
    v1:setBehaviour("Widget", "MinimumWidth", v9)
    v1:setBehaviour("Widget", "MinimumHeight", v9)
    v1:setBehaviour("Indicator", "Visible", v9)
    v1:setBehaviour("IconImageRatio", "AspectRatio", v9)
    v1:setBehaviour("IconImage", "Image", function(v41) -- line 381 | captures: ImageLabel, v9
        local v42 = if tonumber(v41) then "http://www.roblox.com/asset/?id=" .. v41 else v41 or ""
        if ImageLabel.Image ~= v42 then
            v9()
        end
        return v42
    end)
    v1.alignmentChanged:Connect(function(v43) -- line 396 | captures: v1, Frame, v4, MenuUIListLayout, MenuGap, Frame_3, v9
        local v44 = if v43 == "Center" then "Left" else v43
        MenuUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment[v44]
        task.defer(function() -- line 404 | captures: v1, Frame, v4, MenuUIListLayout, MenuGap, Frame_3, v9
            local BorderSize = Frame:GetAttribute("BorderSize")
            local v45 = if Frame_3.Visible == false then 0 else v1.alignment == "Right" and -BorderSize or BorderSize
            v4.Position = UDim2.new(0, v45, 0, 0)
            MenuGap.Size = UDim2.fromOffset(BorderSize, 0)
            MenuUIListLayout.Padding = UDim.new(0, 0)
            v9()
        end)
    end)
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local LocaleId = LocalPlayer.LocaleId
    v1.janitor:add(LocalPlayer:GetPropertyChangedSignal("LocaleId"):Connect(function() -- line 427 | captures: LocaleId, v1, LocalPlayer
        task.delay(0.2, function() -- line 428 | captures: LocaleId, v1, LocalPlayer
            local LocaleId_2 = LocalPlayer.LocaleId
            if LocaleId_2 == LocaleId then
                return
            end
            LocaleId = LocaleId_2
            v1:refresh()
            task.wait(0.5)
            v1:refresh()
        end)
    end))
    local NumberValue = Instance.new("NumberValue")
    NumberValue.Name = "IconImageScale"
    NumberValue.Parent = ImageLabel
    NumberValue:GetPropertyChangedSignal("Value"):Connect(function() -- line 442 | captures: ImageLabel, NumberValue
        ImageLabel.Size = UDim2.new(NumberValue.Value, 0, NumberValue.Value, 0)
    end)
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    UIAspectRatioConstraint.Name = "IconImageRatio"
    UIAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
    UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
    UIAspectRatioConstraint.Parent = ImageLabel
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Name = "IconGradient"
    UIGradient.Enabled = true
    UIGradient.Parent = Frame_2
    local UIGradient_2 = Instance.new("UIGradient")
    UIGradient_2.Name = "IconSpotGradient"
    UIGradient_2.Enabled = true
    UIGradient_2.Parent = Frame_3
    return Frame
end
