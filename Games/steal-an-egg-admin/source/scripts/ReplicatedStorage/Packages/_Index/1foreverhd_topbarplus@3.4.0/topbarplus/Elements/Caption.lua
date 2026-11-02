-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = Color3.fromRGB(39, 41, 48)
return function(v2) -- line 7 | captures: v1
    local ClickRegion = v2:getInstance("ClickRegion")
    local CanvasGroup = Instance.new("CanvasGroup")
    CanvasGroup.Name = "Caption"
    CanvasGroup.AnchorPoint = Vector2.new(0.5, 0)
    CanvasGroup.BackgroundTransparency = 1
    CanvasGroup.BorderSizePixel = 0
    CanvasGroup.GroupTransparency = 1
    CanvasGroup.Position = UDim2.fromOffset(0, 0)
    CanvasGroup.Visible = true
    CanvasGroup.ZIndex = 30
    CanvasGroup.Parent = ClickRegion
    local Frame = Instance.new("Frame")
    Frame.Name = "Box"
    Frame.AutomaticSize = Enum.AutomaticSize.XY
    Frame.BackgroundColor3 = Color3.fromRGB(39, 41, 48)
    Frame.Position = UDim2.fromOffset(4, 7)
    Frame.ZIndex = 12
    Frame.Parent = CanvasGroup
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Name = "Header"
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
    TextLabel.Text = "Caption"
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextSize = 15
    TextLabel.TextTruncate = Enum.TextTruncate.None
    TextLabel.TextWrapped = false
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.AutomaticSize = Enum.AutomaticSize.X
    TextLabel.BackgroundTransparency = 1
    TextLabel.LayoutOrder = 1
    TextLabel.Size = UDim2.fromOffset(0, 16)
    TextLabel.ZIndex = 18
    TextLabel.Parent = Frame
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Name = "Layout"
    UIListLayout.Padding = UDim.new(0, 8)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = Frame
    local UICorner = Instance.new("UICorner")
    UICorner.Name = "CaptionCorner"
    UICorner.Parent = Frame
    local UIPadding = Instance.new("UIPadding")
    UIPadding.Name = "Padding"
    UIPadding.PaddingBottom = UDim.new(0, 12)
    UIPadding.PaddingLeft = UDim.new(0, 12)
    UIPadding.PaddingRight = UDim.new(0, 12)
    UIPadding.PaddingTop = UDim.new(0, 12)
    UIPadding.Parent = Frame
    local Frame_2 = Instance.new("Frame")
    Frame_2.Name = "Hotkeys"
    Frame_2.AutomaticSize = Enum.AutomaticSize.Y
    Frame_2.BackgroundTransparency = 1
    Frame_2.LayoutOrder = 3
    Frame_2.Size = UDim2.fromScale(1, 0)
    Frame_2.Visible = false
    Frame_2.Parent = Frame
    local UIListLayout_2 = Instance.new("UIListLayout")
    UIListLayout_2.Name = "Layout1"
    UIListLayout_2.Padding = UDim.new(0, 6)
    UIListLayout_2.FillDirection = Enum.FillDirection.Vertical
    UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout_2.HorizontalFlex = Enum.UIFlexAlignment.None
    UIListLayout_2.ItemLineAlignment = Enum.ItemLineAlignment.Automatic
    UIListLayout_2.VerticalFlex = Enum.UIFlexAlignment.None
    UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_2.Parent = Frame_2
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "Key1"
    ImageLabel.Image = "rbxasset://textures/ui/Controls/key_single.png"
    ImageLabel.ImageTransparency = 0.7
    ImageLabel.ScaleType = Enum.ScaleType.Slice
    ImageLabel.SliceCenter = Rect.new(5, 5, 23, 24)
    ImageLabel.AutomaticSize = Enum.AutomaticSize.X
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.LayoutOrder = 1
    ImageLabel.Size = UDim2.fromOffset(0, 30)
    ImageLabel.ZIndex = 15
    ImageLabel.Parent = Frame_2
    local UIPadding_2 = Instance.new("UIPadding")
    UIPadding_2.Name = "Inset"
    UIPadding_2.PaddingLeft = UDim.new(0, 8)
    UIPadding_2.PaddingRight = UDim.new(0, 8)
    UIPadding_2.Parent = ImageLabel
    local TextLabel_2 = Instance.new("TextLabel")
    TextLabel_2.AutoLocalize = false
    TextLabel_2.Name = "LabelContent"
    TextLabel_2.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
    TextLabel_2.Text = ""
    TextLabel_2.TextColor3 = Color3.fromRGB(189, 190, 190)
    TextLabel_2.TextSize = 15
    TextLabel_2.AutomaticSize = Enum.AutomaticSize.X
    TextLabel_2.BackgroundTransparency = 1
    TextLabel_2.Position = UDim2.fromOffset(0, -1)
    TextLabel_2.Size = UDim2.fromScale(1, 1)
    TextLabel_2.ZIndex = 16
    TextLabel_2.Parent = ImageLabel
    local ImageLabel_2 = Instance.new("ImageLabel")
    ImageLabel_2.Name = "Caret"
    ImageLabel_2.Image = "rbxassetid://101906294438076"
    ImageLabel_2.ImageColor3 = v1
    ImageLabel_2.AnchorPoint = Vector2.new(0, 0.5)
    ImageLabel_2.BackgroundTransparency = 1
    ImageLabel_2.Position = UDim2.new(0, 0, 0, 4)
    ImageLabel_2.Size = UDim2.fromOffset(16, 8)
    ImageLabel_2.ZIndex = 12
    ImageLabel_2.Parent = CanvasGroup
    local ImageLabel_3 = Instance.new("ImageLabel")
    ImageLabel_3.Visible = true
    ImageLabel_3.Name = "DropShadow"
    ImageLabel_3.Image = "rbxassetid://124920646932671"
    ImageLabel_3.ImageColor3 = Color3.fromRGB(0, 0, 0)
    ImageLabel_3.ImageTransparency = 0.45
    ImageLabel_3.ScaleType = Enum.ScaleType.Slice
    ImageLabel_3.SliceCenter = Rect.new(12, 12, 13, 13)
    ImageLabel_3.BackgroundTransparency = 1
    ImageLabel_3.Position = UDim2.fromOffset(0, 5)
    ImageLabel_3.Size = UDim2.new(1, 0, 0, 48)
    ImageLabel_3.Parent = CanvasGroup
    Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- line 128 | captures: Frame, ImageLabel_3
        ImageLabel_3.Size = UDim2.new(1, 0, 0, Frame.AbsoluteSize.Y + 8)
    end)
    local captionJanitor = v2.captionJanitor
    local v3, v4 = v2:clipOutside(CanvasGroup)
    _ = v3
    v4.AutomaticSize = Enum.AutomaticSize.None
    captionJanitor:add(CanvasGroup:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- line 135 | captures: CanvasGroup, v4
        local AbsoluteSize = CanvasGroup.AbsoluteSize
        v4.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y)
    end))
    local AbsoluteSize = CanvasGroup.AbsoluteSize
    local v5 = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y)
    v4.Size = v5
    local v6 = false
    local Header = CanvasGroup.Box.Header
    local UserInputService = game:GetService("UserInputService")

    local function updateHotkey(v7) -- line 144 | captures: v2, CanvasGroup, Frame_2, TextLabel_2, Header, UserInputService
        local KeyboardEnabled = UserInputService.KeyboardEnabled
        local v8 = CanvasGroup:GetAttribute("CaptionText") or ""
        local v9 = v8 == "_hotkey_"
        if KeyboardEnabled then
            Header.Text = v8
            Header.Visible = not v9
            if v7 then
                TextLabel_2.Text = v7.Name
                Frame_2.Visible = true
            end
        elseif v9 then
            v2:setCaption()
        end
    end

    CanvasGroup:GetAttributeChangedSignal("CaptionText"):Connect(updateHotkey)
    local Quad = Enum.EasingStyle.Quad
    local v10 = TweenInfo.new(0.2, Quad, Enum.EasingDirection.In)
    local v11 = TweenInfo.new(0.2, Quad, Enum.EasingDirection.Out)
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")

    local function getCaptionPosition(v12) -- line 171 | captures: v6
        local v13 = if v12 == nil then v6 else v12
        local v14 = if v13 then 10 else 2
        return UDim2.new(0.5, 0, 1, v14)
    end

    local function updatePosition(v15) -- line 185 | captures: v6, ClickRegion, CanvasGroup, ImageLabel_2, v4, v10, v11, TweenService, RunService
        if not v6 then
            return
        end
        local v16 = if v15 == nil then v6 else v15
        local v17 = if v16 == nil then v6 else v16
        local v18 = if v17 then 10 else 2
        local v19 = UDim2.new(0.5, 0, 1, v18)
        if v16 then
            ImageLabel_2.Position = UDim2.fromOffset(0, ImageLabel_2.Position.Y.Offset)
            CanvasGroup.AutomaticSize = Enum.AutomaticSize.XY
            CanvasGroup.Size = UDim2.fromOffset(32, 53)
        else
            local AbsoluteSize = CanvasGroup.AbsoluteSize
            CanvasGroup.AutomaticSize = Enum.AutomaticSize.Y
            CanvasGroup.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y)
        end
        local v20

        local function updateCaret() -- line 227 | captures: v20, ClickRegion, CanvasGroup, ImageLabel_2
            local v21 = ClickRegion.AbsolutePosition.X - CanvasGroup.AbsolutePosition.X + ClickRegion.AbsoluteSize.X / 2 - ImageLabel_2.AbsoluteSize.X / 2
            local Offset = ImageLabel_2.Position.Y.Offset
            local v22 = UDim2.fromOffset(v21, Offset)
            if v20 ~= v21 then
                v20 = v21
                ImageLabel_2.Position = UDim2.fromOffset(0, Offset)
                task.wait()
            end
            ImageLabel_2.Position = v22
        end

        v4.Position = UDim2.new(0.5, 0, 1, v18)
        updateCaret()
        local v23 = v16 and v10 or v11
        local v24 = TweenService:Create(v4, v23, { Position = v19 })
        local v25 = RunService.Heartbeat:Connect(updateCaret)
        v24:Play()
        v24.Completed:Once(function() -- line 251 | captures: v25
            v25:Disconnect()
        end)
    end

    captionJanitor:add(ClickRegion:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- line 256 | captures: updatePosition
        updatePosition()
    end))
    updatePosition(false)
    captionJanitor:add(v2.toggleKeyAdded:Connect(updateHotkey))
    for v26, v27 in pairs(v2.bindedToggleKeys) do
        local KeyboardEnabled = UserInputService.KeyboardEnabled
        local v28 = CanvasGroup:GetAttribute("CaptionText") or ""
        local v29 = v28 == "_hotkey_"
        local v30
        if KeyboardEnabled then
            Header.Text = v28
            Header.Visible = not v29
            if v26 then
                TextLabel_2.Text = v26.Name
                Frame_2.Visible = true
            end
            v30 = false
        elseif v29 then
            v30 = true
        else
            Header.Text = v28
            Header.Visible = not v29
            if v26 then
                TextLabel_2.Text = v26.Name
                Frame_2.Visible = true
            end
            v30 = false
        end
        if v30 then
            v2:setCaption()
        elseif not KeyboardEnabled then
            Frame_2.Visible = false
        end
        break
    end
    captionJanitor:add(v2.fakeToggleKeyChanged:Connect(updateHotkey))
    local fakeToggleKey = v2.fakeToggleKey
    if fakeToggleKey then
        local KeyboardEnabled = UserInputService.KeyboardEnabled
        local v31 = CanvasGroup:GetAttribute("CaptionText") or ""
        local v32 = v31 == "_hotkey_"
        if KeyboardEnabled then
            Header.Text = v31
            Header.Visible = not v32
            TextLabel_2.Text = fakeToggleKey.Name
            Frame_2.Visible = true
        elseif v32 then
            v2:setCaption()
        end
    end

    local function setCaptionEnabled(v33) -- line 301 | captures: v6, v2, CanvasGroup, Frame_2, v4, Header, UserInputService, v10, v11, TweenService, updatePosition
        if v6 == v33 then
            return
        end
        local joinedFrame = v2.joinedFrame
        local v34 = if joinedFrame and string.match(joinedFrame.Name, "Dropdown") then false else v33
        v6 = v34
        local v35, v36
        if v34 then
            v36 = 0
            v35 = v10
        else
            v36 = 1
            v35 = v11
        end
        TweenService:Create(CanvasGroup, v35, { GroupTransparency = v36 }):Play()
        if v34 then
            v4:SetAttribute("ForceUpdate", true)
        end
        updatePosition()
        local KeyboardEnabled = UserInputService.KeyboardEnabled
        local v37 = CanvasGroup:GetAttribute("CaptionText") or ""
        local v38 = v37 == "_hotkey_"
        if KeyboardEnabled then
            Header.Text = v37
            Header.Visible = not v38
        elseif v38 then
            v2:setCaption()
        else
            Header.Text = v37
            Header.Visible = not v38
            Frame_2.Visible = false
        end
    end

    local iconModule = require(v2.iconModule)
    captionJanitor:add(v2.stateChanged:Connect(function(v39) -- line 352 | captures: v2, setCaptionEnabled, iconModule
        if v39 == "Viewing" then
            local captionLastClosedClock = iconModule.captionLastClosedClock
            local v40 = if (captionLastClosedClock and os.clock() - captionLastClosedClock or 999) >= 0.3 then 0.5 else 0
            task.delay(v40, function() -- line 373 | captures: v2, setCaptionEnabled
                if v2.activeState == "Viewing" then
                    setCaptionEnabled(true)
                end
            end)
        else
            iconModule.captionLastClosedClock = os.clock()
            setCaptionEnabled(false)
        end
    end))
    return CanvasGroup
end
