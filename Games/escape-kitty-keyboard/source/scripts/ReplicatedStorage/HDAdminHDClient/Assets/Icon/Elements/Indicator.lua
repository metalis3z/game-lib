

return function(u1, _)
	local u2 = u1.widget
	local v3 = u1:getInstance("Contents")
	local u4 = Instance.new("Frame")
	u4.Name = "Indicator"
	u4.LayoutOrder = 9999999
	u4.ZIndex = 6
	u4.Size = UDim2.new(0, 42, 0, 42)
	u4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	u4.BackgroundTransparency = 1
	u4.Position = UDim2.new(1, 0, 0.5, 0)
	u4.BorderSizePixel = 0
	u4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	u4.Parent = v3
	local u5 = Instance.new("Frame")
	u5.Name = "IndicatorButton"
	u5.BorderColor3 = Color3.fromRGB(0, 0, 0)
	u5.AnchorPoint = Vector2.new(0.5, 0.5)
	u5.BorderSizePixel = 0
	u5.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	u5.Parent = u4
	local u6 = game:GetService("GuiService")
	local u7 = game:GetService("GamepadService")
	local u8 = u1:getInstance("ClickRegion")
	local function v9() 

		if u6.SelectedObject == u8 then
			u5.BackgroundTransparency = 1
			u5.Position = UDim2.new(0.5, -2, 0.5, 0)
			u5.Size = UDim2.fromScale(1.2, 1.2)
		else
			u5.BackgroundTransparency = 0.75
			u5.Position = UDim2.new(0.5, 2, 0.5, 0)
			u5.Size = UDim2.fromScale(1, 1)
		end
	end
	u1.janitor:add(u6:GetPropertyChangedSignal("SelectedObject"):Connect(v9))
	v9()
	local u10 = Instance.new("ImageLabel")
	u10.LayoutOrder = 2
	u10.ZIndex = 15
	u10.AnchorPoint = Vector2.new(0.5, 0.5)
	u10.Size = UDim2.new(0.5, 0, 0.5, 0)
	u10.BackgroundTransparency = 1
	u10.Position = UDim2.new(0.5, 0, 0.5, 0)
	u10.Image = "rbxasset://textures/ui/Controls/XboxController/DPadUp@2x.png"
	u10.Parent = u5
	local v11 = Instance.new("UICorner")
	v11.CornerRadius = UDim.new(1, 0)
	v11.Parent = u5
	local u12 = game:GetService("UserInputService")
	local function u14(p13) 

		if p13 == nil then
			p13 = u4.Visible
		end
		if u7.GamepadCursorEnabled then
			p13 = false
		end
		if p13 then
			u1:modifyTheme({ "PaddingRight", "Size", UDim2.new(0, 0, 1, 0) }, "IndicatorPadding")
		elseif u4.Visible then
			u1:removeModification("IndicatorPadding")
		end
		u1:modifyTheme({ "Indicator", "Visible", p13 })
		u1.updateSize:Fire()
	end
	u1.janitor:add(u7:GetPropertyChangedSignal("GamepadCursorEnabled"):Connect(u14))
	u1.indicatorSet:Connect(function(p15)

		local v16
		if p15 then
			u10.Image = u12:GetImageForKeyCode(p15)
			v16 = true
		else
			v16 = false
		end
		u14(v16)
	end)
	u2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() 

		local v17 = u2.AbsoluteSize.Y * 0.96
		u4.Size = UDim2.new(0, v17, 0, v17)
	end)
	local v18 = u2.AbsoluteSize.Y * 0.96
	u4.Size = UDim2.new(0, v18, 0, v18)
	return u4
end