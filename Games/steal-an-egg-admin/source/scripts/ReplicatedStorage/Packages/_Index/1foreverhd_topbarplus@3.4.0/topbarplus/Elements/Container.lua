-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = false
local v2 = 0
return function(v3) -- line 8 | captures: v1, v2
    local GuiService = game:GetService("GuiService")
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local v4 = {}
    local v5 = require(script.Parent.Parent.Packages.GoodSignal).new()
    local v6 = GuiService:GetGuiInset()
    local v7 = 0
    local v8 = 0
    local v9 = 0
    local v10 = 0
    local v11 = false
    local v12 = false
    local v13

    function v13(v14) -- line 22 | captures: v13, v6, v7, v8, v9, v10, v11, v12, v3, GuiService, Players, UserInputService, v5, v1, v2
        local Height = GuiService.TopbarInset.Height
        local v15 = Height <= 36
        v11 = GuiService:IsTenFootInterface()
        v12 = UserInputService.VREnabled
        v3.isOldTopbar = v15
        v10 += 1
        if Height == 0 then
            if v14 == nil then
                task.defer(function() -- line 40 | captures: v13
                    task.wait(8)
                    v13("ForceConvertToOld")
                end)
            end
        elseif v10 == 1 then
            task.delay(5, function() -- line 32 | captures: v13, v10, Players
                Players.LocalPlayer:WaitForChild("PlayerGui")
                if v10 == 1 then
                    v13()
                end
            end)
        end
        if v3.isOldTopbar and not v11 and not v12 and v1 == false and Height ~= 0 then
            v1 = true
            task.defer(function() -- line 48 | captures: v3, GuiService
                local Classic = require(script.Parent.Parent.Features.Themes.Classic)
                v3.modifyBaseTheme(Classic)
                GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(function() -- line 52 | captures: v3, GuiService
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
        v6 = GuiService:GetGuiInset()
        if v15 then
            v7 = 12
            v8 = 2
        else
            v7 = v6.Y - 50
            v8 = 0
        end
        v9 = -2
        if v11 then
            v7 = 10
            v8 = 0
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
        task.defer(function() -- line 94 | captures: Y, v3
            v3.insetHeightChanged:Fire(Y)
        end)
    end

    GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(v13)
    v13("FirstTime")
    local ScreenGui = Instance.new("ScreenGui")
    v5:Connect(function() -- line 103 | captures: v7, ScreenGui
        ScreenGui:SetAttribute("StartInset", v7)
    end)
    ScreenGui.Name = "TopbarStandard"
    ScreenGui.Enabled = true
    ScreenGui.DisplayOrder = v3.baseDisplayOrder
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets
    v4[ScreenGui.Name] = ScreenGui
    v3.baseDisplayOrderChanged:Connect(function() -- line 114 | captures: v3, ScreenGui
        ScreenGui.DisplayOrder = v3.baseDisplayOrder
    end)
    local Frame = Instance.new("Frame")
    Frame.Name = "Holders"
    Frame.BackgroundTransparency = 1
    v5:Connect(function() -- line 120 | captures: v8, v9, v11, v12, Frame
        local v16 = if v12 then 36 else 56
        local v17
        if v11 then
            v17 = UDim2.new(1, 0, 0, v16)
        else
            v17 = UDim2.new(1, 0, 1, v9)
        end
        Frame.Position = UDim2.new(0, 0, 0, v8)
        Frame.Size = v17
    end)
    Frame.Visible = true
    Frame.ZIndex = 1
    Frame.Parent = ScreenGui
    local v18 = ScreenGui:Clone()
    local Holders = v18.Holders
    v18.Name = "TopbarCentered"
    v18.DisplayOrder = v3.baseDisplayOrder
    v18.ScreenInsets = Enum.ScreenInsets.None
    v3.baseDisplayOrderChanged:Connect(function() -- line 143 | captures: v3, v18
        v18.DisplayOrder = v3.baseDisplayOrder
    end)
    v4[v18.Name] = v18
    v5:Connect(function() -- line 147 | captures: v9, GuiService, Holders
        Holders.Size = UDim2.new(1, 0, 0, GuiService.TopbarInset.Height + v9)
    end)
    Holders.Size = UDim2.new(1, 0, 0, GuiService.TopbarInset.Height + v9)
    local v19 = ScreenGui:Clone()
    v19.Name ..= "Clipped"
    v19.DisplayOrder = v3.baseDisplayOrder + 1
    v3.baseDisplayOrderChanged:Connect(function() -- line 154 | captures: v3, v19
        v19.DisplayOrder = v3.baseDisplayOrder + 1
    end)
    v4[v19.Name] = v19
    local v20 = v18:Clone()
    v20.Name ..= "Clipped"
    v20.DisplayOrder = v3.baseDisplayOrder + 1
    v3.baseDisplayOrderChanged:Connect(function() -- line 161 | captures: v3, v20
        v20.DisplayOrder = v3.baseDisplayOrder + 1
    end)
    v4[v20.Name] = v20
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame:SetAttribute("IsAHolder", true)
    ScrollingFrame.Name = "Left"
    v5:Connect(function() -- line 168 | captures: v7, ScrollingFrame
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
    v5:Connect(function() -- line 188 | captures: v7, UIListLayout
        UIListLayout.Padding = UDim.new(0, v7)
    end)
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    UIListLayout.Parent = ScrollingFrame
    local v21 = ScrollingFrame:Clone()
    v5:Connect(function() -- line 197 | captures: v7, v21
        v21.UIListLayout.Padding = UDim.new(0, v7)
    end)
    v21.ScrollingEnabled = false
    v21.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    v21.Name = "Center"
    v21.Parent = Holders
    local v22 = ScrollingFrame:Clone()
    v5:Connect(function() -- line 205 | captures: v7, v22
        v22.UIListLayout.Padding = UDim.new(0, v7)
    end)
    v22.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    v22.Name = "Right"
    v22.AnchorPoint = Vector2.new(1, 0)
    v22.Position = UDim2.new(1, -12, 0, 0)
    v22.Parent = Frame
    v5:Fire(v6)
    return v4
end
