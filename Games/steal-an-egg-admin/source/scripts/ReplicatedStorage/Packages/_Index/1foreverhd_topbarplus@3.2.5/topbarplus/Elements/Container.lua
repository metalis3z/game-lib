-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = false
local v2 = 0
return function(v3) -- line 8 | captures: v1, v2
    local GuiService = game:GetService("GuiService")
    local v4 = {}
    local v5 = require(script.Parent.Parent.Packages.GoodSignal).new()
    local v6 = GuiService:GetGuiInset()
    local v7 = 0
    local v8 = 0
    local v9 = 0
    local v10 = 0
    local v11

    function v11(v12) -- line 18 | captures: v11, v7, v8, v9, v10, v3, GuiService, v5, v6, v1, v2
        local Height = GuiService.TopbarInset.Height
        local v13 = Height <= 36
        local v14 = GuiService:IsTenFootInterface()
        v3.isOldTopbar = v13
        v10 += 1
        if Height == 0 then
            if v12 == nil then
                task.delay(5, function() -- line 34 | captures: v11
                    v11("ForceConvertToOld")
                end)
            end
        elseif v10 == 1 then
            task.delay(5, function() -- line 27 | captures: v11, v10
                if v10 == 1 then
                    v11()
                end
            end)
        end
        if v3.isOldTopbar and not v14 and v1 == false and Height ~= 0 then
            v1 = true
            task.defer(function() -- line 41 | captures: v3, GuiService
                local Classic = require(script.Parent.Parent.Features.Themes.Classic)
                v3.modifyBaseTheme(Classic)
                GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(function() -- line 45 | captures: v3, GuiService
                    if GuiService.MenuIsOpen then
                        v3.setTopbarEnabled(false, true)
                    else
                        v3.setTopbarEnabled()
                    end
                end)
                if GuiService.MenuIsOpen then
                    v3.setTopbarEnabled(false, true)
                else
                    v3.setTopbarEnabled()
                end
            end)
        end
        if v13 then
            v7 = 12
            v8 = 2
        else
            v7 = v6.Y - 50
            v8 = 0
        end
        v9 = -2
        if v14 then
            v7 = 10
            v8 = -9
        end
        if GuiService.TopbarInset.Height == 0 and not v1 then
            v8 += 13
            v9 = 50
        end
        v5:Fire(v6)
        local Y = v6.Y
        if Y == v2 then
            return
        end
        v2 = Y
        task.defer(function() -- line 86 | captures: Y, v3
            v3.insetHeightChanged:Fire(Y)
        end)
    end

    GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(v11)
    v11("FirstTime")
    local ScreenGui = Instance.new("ScreenGui")
    v5:Connect(function() -- line 95 | captures: v7, ScreenGui
        ScreenGui:SetAttribute("StartInset", v7)
    end)
    ScreenGui.Name = "TopbarStandard"
    ScreenGui.Enabled = true
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets
    v4[ScreenGui.Name] = ScreenGui
    v3.baseDisplayOrderChanged:Connect(function() -- line 105 | captures: v3, ScreenGui
        ScreenGui.DisplayOrder = v3.baseDisplayOrder
    end)
    local Frame = Instance.new("Frame")
    Frame.Name = "Holders"
    Frame.BackgroundTransparency = 1
    v5:Connect(function() -- line 111 | captures: v8, v9, Frame
        Frame.Position = UDim2.new(0, 0, 0, v8)
        Frame.Size = UDim2.new(1, 0, 1, v9)
    end)
    Frame.Visible = true
    Frame.ZIndex = 1
    Frame.Parent = ScreenGui
    local v15 = ScreenGui:Clone()
    local Holders = v15.Holders
    v15.Name = "TopbarCentered"
    v15.ScreenInsets = Enum.ScreenInsets.None
    v3.baseDisplayOrderChanged:Connect(function() -- line 122 | captures: v3, v15
        v15.DisplayOrder = v3.baseDisplayOrder
    end)
    v4[v15.Name] = v15
    v5:Connect(function() -- line 126 | captures: v9, GuiService, Holders
        Holders.Size = UDim2.new(1, 0, 0, GuiService.TopbarInset.Height + v9)
    end)
    Holders.Size = UDim2.new(1, 0, 0, GuiService.TopbarInset.Height + v9)
    local v16 = ScreenGui:Clone()
    v16.Name ..= "Clipped"
    v16.DisplayOrder += 1
    v3.baseDisplayOrderChanged:Connect(function() -- line 133 | captures: v3, v16
        v16.DisplayOrder = v3.baseDisplayOrder + 1
    end)
    v4[v16.Name] = v16
    local v17 = v15:Clone()
    v17.Name ..= "Clipped"
    v17.DisplayOrder += 1
    v3.baseDisplayOrderChanged:Connect(function() -- line 140 | captures: v3, v17
        v17.DisplayOrder = v3.baseDisplayOrder + 1
    end)
    v4[v17.Name] = v17
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame:SetAttribute("IsAHolder", true)
    ScrollingFrame.Name = "Left"
    v5:Connect(function() -- line 147 | captures: v7, ScrollingFrame
        ScrollingFrame.Position = UDim2.fromOffset(v7, 0)
    end)
    ScrollingFrame.Size = UDim2.new(1, -24, 1, 0)
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.Visible = true
    ScrollingFrame.ZIndex = 1
    ScrollingFrame.Active = false
    ScrollingFrame.ClipsDescendants = true
    ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.None
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, -1)
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.X
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.X
    ScrollingFrame.ScrollBarThickness = 0
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.Selectable = false
    ScrollingFrame.ScrollingEnabled = false
    ScrollingFrame.ElasticBehavior = Enum.ElasticBehavior.Never
    ScrollingFrame.Parent = Frame
    local UIListLayout = Instance.new("UIListLayout")
    v5:Connect(function() -- line 167 | captures: v7, UIListLayout
        UIListLayout.Padding = UDim.new(0, v7)
    end)
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    UIListLayout.Parent = ScrollingFrame
    local v18 = ScrollingFrame:Clone()
    v5:Connect(function() -- line 176 | captures: v7, v18
        v18.UIListLayout.Padding = UDim.new(0, v7)
    end)
    v18.ScrollingEnabled = false
    v18.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    v18.Name = "Center"
    v18.Parent = Holders
    local v19 = ScrollingFrame:Clone()
    v5:Connect(function() -- line 184 | captures: v7, v19
        v19.UIListLayout.Padding = UDim.new(0, v7)
    end)
    v19.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    v19.Name = "Right"
    v19.AnchorPoint = Vector2.new(1, 0)
    v19.Position = UDim2.new(1, -12, 0, 0)
    v19.Parent = Frame
    v5:Fire(v6)
    return v4
end
