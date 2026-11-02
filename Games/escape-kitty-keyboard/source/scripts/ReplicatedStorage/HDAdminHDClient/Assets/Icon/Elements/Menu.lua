

return function(u1)
	local u2 = Instance.new("ScrollingFrame")
	u2.Name = "Menu"
	u2.BackgroundTransparency = 1
	u2.Visible = true
	u2.ZIndex = 1
	u2.Size = UDim2.fromScale(1, 1)
	u2.ClipsDescendants = true
	u2.TopImage = ""
	u2.BottomImage = ""
	u2.HorizontalScrollBarInset = Enum.ScrollBarInset.Always
	u2.CanvasSize = UDim2.new(0, 0, 1, -1)
	u2.ScrollingEnabled = true
	u2.ScrollingDirection = Enum.ScrollingDirection.X
	u2.ZIndex = 20
	u2.ScrollBarThickness = 3
	u2.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
	u2.ScrollBarImageTransparency = 0.8
	u2.BorderSizePixel = 0
	u2.Selectable = false
	local u3 = require(u1.iconModule)
	local u4 = u3.container.TopbarStandard:FindFirstChild("UIListLayout", true):Clone()
	u4.Name = "MenuUIListLayout"
	u4.VerticalAlignment = Enum.VerticalAlignment.Center
	u4.Parent = u2
	local v5 = Instance.new("Frame")
	v5.Name = "MenuGap"
	v5.BackgroundTransparency = 1
	v5.Visible = false
	v5.AnchorPoint = Vector2.new(0, 0.5)
	v5.ZIndex = 5
	v5.Parent = u2
	local u6 = false
	local u7 = require(script.Parent.Parent.Features.Themes)
	local function v35() 

		local u8 = u1.menuJanitor
		local v9 = #u1.menuIcons
		if u6 then
			if v9 <= 0 then
				u8:clean()
				u6 = false
			end
		else
			u6 = true
			u8:add(u1.toggled:Connect(function()

				if #u1.menuIcons > 0 then
					u1.updateSize:Fire()
				end
			end))
			local _, u10 = u1:modifyTheme({
				{ "Menu", "Active", true }
			})
			task.defer(function()

				u8:add(function()

					u1:removeModification(u10)
				end)
			end)
			local u11 = u2.AbsoluteCanvasSize.X
			local function v14() 

				if u1.alignment == "Right" then
					local v12 = u2.AbsoluteCanvasSize.X
					local v13 = u11 - v12
					u11 = v12
					u2.CanvasPosition = Vector2.new(u2.CanvasPosition.X - v13, 0)
				end
			end
			u8:add(u1.selected:Connect(v14))
			u8:add(u2:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(v14))
			local v15 = u1:getStateGroup()
			if u7.getThemeValue(v15, "IconImage", "Image", "Deselected") == u7.getThemeValue(v15, "IconImage", "Image", "Selected") then
				local v16 = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Light, Enum.FontStyle.Normal)
				u1:removeModificationWith("IconLabel", "Text", "Viewing")
				u1:removeModificationWith("IconLabel", "Image", "Viewing")
				u1:modifyTheme({
					{
						"IconLabel",
						"FontFace",
						v16,
						"Selected"
					},
					{
						"IconLabel",
						"Text",
						"X",
						"Selected"
					},
					{
						"IconLabel",
						"TextSize",
						20,
						"Selected"
					},
					{
						"IconLabel",
						"TextStrokeTransparency",
						0.8,
						"Selected"
					},
					{
						"IconImage",
						"Image",
						"",
						"Selected"
					}
				})
			end
			local u17 = u1:getInstance("MenuGap")
			local function v20() 

				local v18, v19
				if u1.alignment == "Right" then
					v18 = 99999
					v19 = 99998
				else
					v18 = -99999
					v19 = -99998
				end
				u1:modifyTheme({ "IconSpot", "LayoutOrder", v18 })
				u17.LayoutOrder = v19
			end
			u8:add(u1.alignmentChanged:Connect(v20))
			local v21, v22
			if u1.alignment == "Right" then
				v21 = 99999
				v22 = 99998
			else
				v21 = -99999
				v22 = -99998
			end
			u1:modifyTheme({ "IconSpot", "LayoutOrder", v21 })
			u17.LayoutOrder = v22
			u2:GetAttributeChangedSignal("MenuCanvasWidth"):Connect(function()

				local v23 = u2:GetAttribute("MenuCanvasWidth")
				local v24 = u2.CanvasSize.Y
				u2.CanvasSize = UDim2.new(0, v23, v24.Scale, v24.Offset)
			end)
			u8:add(u1.updateMenu:Connect(function()

				local v25 = u2:GetAttribute("MaxIcons")
				if not v25 then
					return
				end
				local v26 = {}
				for _, v27 in pairs(u2:GetChildren()) do
					if v27:GetAttribute("WidgetUID") and v27.Visible then
						local v28 = { v27, v27.AbsolutePosition.X }
						table.insert(v26, v28)
					end
				end
				table.sort(v26, function(p29, p30)
					return p29[2] < p30[2]
				end)
				local v31 = 0
				for v32 = 1, v25 do
					local v33 = v26[v32]
					if not v33 then
						break
					end
					v31 = v31 + (v33[1].AbsoluteSize.X + u4.Padding.Offset)
				end
				u2:SetAttribute("MenuWidth", v31)
			end))
			local function v34() 

				task.delay(0.1, function()

					u1.startMenuUpdate:Fire()
				end)
			end
			u8:add(u2.ChildAdded:Connect(v34))
			u8:add(u2.ChildRemoved:Connect(v34))
			u8:add(u2:GetAttributeChangedSignal("MaxIcons"):Connect(v34))
			u8:add(u2:GetAttributeChangedSignal("MaxWidth"):Connect(v34))
			task.delay(0.1, function()

				u1.startMenuUpdate:Fire()
			end)
		end
	end
	u1.menuChildAdded:Connect(v35)
	u1.menuSet:Connect(function(p36)

		for _, v37 in pairs(u1.menuIcons) do
			u3.getIconByUID(v37):destroy()
		end
		if type(p36) == "table" then
			for _, v38 in pairs(p36) do
				v38:joinMenu(u1)
			end
		end
	end)
	return u2
end