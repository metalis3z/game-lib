

local u1 = game:GetService("TweenService")
local u2 = game:GetService("RunService")
local u3 = require(script.Parent.Parent.Features.Themes)
return function(u4)

	local u5 = Instance.new("Frame")
	u5.Name = "Dropdown"
	u5.AutomaticSize = Enum.AutomaticSize.X
	u5.BackgroundTransparency = 1
	u5.BorderSizePixel = 0
	u5.AnchorPoint = Vector2.new(0.5, 0)
	u5.Position = UDim2.new(0.5, 0, 1, 10)
	u5.ZIndex = -2
	u5.ClipsDescendants = true
	u5.Parent = u4.widget
	local u6 = game:GetService("GuiService")
	u4:setBehaviour("Dropdown", "BackgroundTransparency", function(p7)

		local v8 = p7 * u6.PreferredTransparency
		if p7 == 1 then
			return p7
		else
			return v8
		end
	end)
	u4.janitor:add(u6:GetPropertyChangedSignal("PreferredTransparency"):Connect(function()

		u4:refreshAppearance(u5, "BackgroundTransparency")
	end))
	local v9 = Instance.new("UICorner")
	v9.Name = "DropdownCorner"
	v9.CornerRadius = UDim.new(0, 10)
	v9.Parent = u5
	local u10 = Instance.new("ScrollingFrame")
	u10.Name = "DropdownScroller"
	u10.AutomaticSize = Enum.AutomaticSize.X
	u10.BackgroundTransparency = 1
	u10.BorderSizePixel = 0
	u10.AnchorPoint = Vector2.new(0, 0)
	u10.Position = UDim2.new(0, 0, 0, 0)
	u10.ZIndex = -1
	u10.ClipsDescendants = true
	u10.Visible = true
	u10.VerticalScrollBarInset = Enum.ScrollBarInset.None
	u10.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
	u10.Active = false
	u10.ScrollingEnabled = true
	u10.AutomaticCanvasSize = Enum.AutomaticSize.Y
	u10.ScrollBarThickness = 5
	u10.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
	u10.ScrollBarImageTransparency = 0.8
	u10.CanvasSize = UDim2.new(0, 0, 0, 0)
	u10.Selectable = false
	u10.Active = true
	u10.Parent = u5
	local u11 = Instance.new("NumberValue")
	u11.Name = "DropdownSpeed"
	u11.Value = 0.07
	u11.Parent = u5
	local u12 = Instance.new("UIPadding")
	u12.Name = "DropdownPadding"
	u12.PaddingTop = UDim.new(0, 0)
	u12.PaddingBottom = UDim.new(0, 0)
	u12.Parent = u10
	local v13 = Instance.new("UIListLayout")
	v13.Name = "DropdownList"
	v13.FillDirection = Enum.FillDirection.Vertical
	v13.SortOrder = Enum.SortOrder.LayoutOrder
	v13.HorizontalAlignment = Enum.HorizontalAlignment.Center
	v13.HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly
	v13.Parent = u10
	local v14 = u4.dropdownJanitor
	local u15 = require(u4.iconModule)
	u4.dropdownChildAdded:Connect(function(u16)
		local _, u17 = u16:modifyTheme({
			{ "Widget", "BorderSize", 0 },
			{ "IconCorners", "CornerRadius", UDim.new(0, 10) },
			{ "Widget", "MinimumWidth", 190 },
			{ "Widget", "MinimumHeight", 58 },
			{ "IconLabel", "TextSize", 20 },
			{ "IconOverlay", "Size", UDim2.new(1, 0, 1, 0) },
			{ "PaddingLeft", "Size", UDim2.fromOffset(25, 0) },
			{ "Notice", "Position", UDim2.new(1, -24, 0, 5) },
			{ "ContentsList", "HorizontalAlignment", Enum.HorizontalAlignment.Left },
			{ "Selection", "Size", UDim2.new(1, -0, 1, -0) },
			{ "Selection", "Position", UDim2.new(0, 0, 0, 0) }
		})
		task.defer(function()

			u16.joinJanitor:add(function()

				u16:removeModification(u17)
			end)
		end)
	end)
	u4.dropdownSet:Connect(function(p18)

		for _, v19 in pairs(u4.dropdownIcons) do
			u15.getIconByUID(v19):destroy()
		end
		if type(p18) == "table" then
			for _, v20 in pairs(p18) do
				v20:joinDropdown(u4)
			end
		end
	end)
	local function u32() 

		local v21 = u5:GetAttribute("MaxIcons")
		if not v21 then
			return 0
		end
		local v22 = {}
		for _, v23 in pairs(u10:GetChildren()) do
			if v23:IsA("GuiObject") and v23.Visible then
				table.insert(v22, v23)
			end
		end
		table.sort(v22, function(p24, p25)
			return p24.AbsolutePosition.Y < p25.AbsolutePosition.Y
		end)
		local v26 = math.ceil(v21)
		local v27 = 0
		for v28 = 1, v26 do
			local v29 = v22[v28]
			if not v29 then
				break
			end
			local v30 = v29.AbsoluteSize.Y
			local v31
			if v28 == v26 then
				v31 = v26 ~= v21
			else
				v31 = false
			end
			if v31 then
				v30 = v30 * (v21 - v26 + 1)
			end
			v27 = v27 + v30
		end
		return v27 + (u12.PaddingTop.Offset + u12.PaddingBottom.Offset)
	end
	local u33 = nil
	local u34 = nil
	local u35 = nil
	local u36 = nil
	local function v40() 

		local v37 = u3.getInstanceValue(u5, "MaxIcons") or 1
		local v38
		if u35 and (u35 == v37 and u36) then
			v38 = u36
		else
			v38 = TweenInfo.new(u11.Value * v37, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
			u36 = v38
			u35 = v37
		end
		if u33 then
			u33:Cancel()
			u33 = nil
		end
		if u34 then
			u34:Cancel()
			u34 = nil
		end
		if u4.isSelected then
			local v39 = u32()
			u5.Visible = true
			u5.BackgroundTransparency = 0
			u5.Size = UDim2.new(0, u5.Size.X.Offset, 0, 0)
			u33 = u1:Create(u5, v38, {
				["Size"] = UDim2.new(0, u5.Size.X.Offset, 0, v39)
			})
			u33:Play()
			u33.Completed:Connect(function()

				u33 = nil
			end)
		else
			u34 = u1:Create(u5, TweenInfo.new(0), {
				["Size"] = UDim2.new(0, u5.Size.X.Offset, 0, 0)
			})
			u34:Play()
			u34.Completed:Connect(function()

				u34 = nil
			end)
		end
	end
	v14:add(u4.toggled:Connect(v40))
	v40()
	local function u44() 

		local v41 = u3.getInstanceValue(u5, "MaxIcons") or 1
		local v42
		if u35 and (u35 == v41 and u36) then
			v42 = u36
		else
			v42 = TweenInfo.new(u11.Value * v41, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
			u36 = v42
			u35 = v41
		end
		if u4.isSelected then
			if u33 then
				u33:Cancel()
				u33 = nil
			end
			if u34 then
				u34:Cancel()
				u34 = nil
			end
			u2.Heartbeat:Wait()
			local v43 = u32()
			u33 = u1:Create(u5, v42, {
				["Size"] = UDim2.new(0, u5.Size.X.Offset, 0, v43)
			})
			u33:Play()
			u33.Completed:Connect(function()

				u33 = nil
			end)
		end
	end
	v14:add(u4.toggled:Connect(v40))
	local u45 = 0
	local u46 = false
	local function u65() 

		u45 = u45 + 1
		if u46 then
			return
		end
		local u47 = u45
		u46 = true
		task.defer(function()

			u46 = false
			if u45 ~= u47 then
				u65()
			end
		end)
		local v48 = u5:GetAttribute("MaxIcons")
		if not v48 then
			return
		end
		local v49 = {}
		for _, v50 in pairs(u10:GetChildren()) do
			if v50:IsA("GuiObject") and v50.Visible then
				local v51 = { v50, v50.AbsolutePosition.Y }
				table.insert(v49, v51)
			end
		end
		table.sort(v49, function(p52, p53)
			return p52[2] < p53[2]
		end)
		local v54 = math.ceil(v48)
		local v55 = 0
		local v56 = false
		for v57 = 1, v54 do
			local v58 = v49[v57]
			if not v58 then
				break
			end
			local v59 = v58[1]
			local v60 = v59.AbsoluteSize.Y
			local v61
			if v57 == v54 then
				v61 = v54 ~= v48
			else
				v61 = false
			end
			if v61 then
				v60 = v60 * (v48 - v54 + 1)
			end
			v55 = v55 + v60
			if not v61 then
				local v62 = v59:GetAttribute("WidgetUID")
				if v62 then
					v62 = u15.getIconByUID(v62)
				end
				if v62 then
					local v63
					if v56 then
						v63 = nil
					else
						v63 = u4:getInstance("ClickRegion")
						v56 = true
					end
					v62:getInstance("ClickRegion").NextSelectionUp = v63
				end
			end
		end
		local v64 = v55 + (u12.PaddingTop.Offset + u12.PaddingBottom.Offset)
		u10.Size = UDim2.fromOffset(0, v64)
	end
	v14:add(u10:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(u65))
	v14:add(u10.ChildAdded:Connect(u65))
	v14:add(u10.ChildRemoved:Connect(u44))
	v14:add(u10.ChildRemoved:Connect(u65))
	v14:add(u5:GetAttributeChangedSignal("MaxIcons"):Connect(u65))
	v14:add(u5:GetAttributeChangedSignal("MaxIcons"):Connect(u44))
	v14:add(u4.childThemeModified:Connect(u65))
	u65()
	for _, v66 in pairs(u10:GetChildren()) do
		if v66:IsA("GuiObject") then
			v66:GetPropertyChangedSignal("Visible"):Connect(u44)
			v66:GetPropertyChangedSignal("Size"):Connect(u44)
		end
	end
	u10.ChildAdded:Connect(function(p67)

		u2.Heartbeat:Wait()
		if p67:IsA("GuiObject") then
			p67:GetPropertyChangedSignal("Visible"):Connect(u44)
			p67:GetPropertyChangedSignal("Size"):Connect(u44)
		end
		u44()
	end)
	u5.Visible = false
	return u5
end