-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Menu, time of decompilation: Sun May  3 10:09:32 2026 ]]
return function(p1) -- line: 1
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

	local iconModule = require(p1.iconModule)
	local clone = iconModule.container.TopbarStandard:FindFirstChild("UIListLayout", true):Clone()

	clone.Name = "MenuUIListLayout"
	clone.VerticalAlignment = Enum.VerticalAlignment.Center
	clone.Parent = ScrollingFrame

	local Frame = Instance.new("Frame")

	Frame.Name = "MenuGap"
	Frame.BackgroundTransparency = 1
	Frame.Visible = false
	Frame.AnchorPoint = Vector2.new(0, 0.5)
	Frame.ZIndex = 5
	Frame.Parent = ScrollingFrame

	local u6 = false
	local Themes = require(script.Parent.Parent.Features.Themes)

	p1.menuChildAdded:Connect(function() --[[ totalChildrenChanged ]] -- line: 39
		-- upvalues: p1 (copy), u6 (ref), ScrollingFrame (copy), Themes (copy), clone (copy)
		local menuJanitor = p1.menuJanitor
		local v9 = #p1.menuIcons

		if u6 then
			if v9 <= 0 then
				menuJanitor:clean()
				u6 = false
			end

			return
		end

		u6 = true
		menuJanitor:add(p1.toggled:Connect(function() -- line: 53
			-- upvalues: p1 (copy)
			if #p1.menuIcons > 0 then
				p1.updateSize:Fire()
			end
		end))

		local _, v11 = p1:modifyTheme({{
			"Menu",
			"Active",
			true
		}})

		task.defer(function() -- line: 63
			-- upvalues: menuJanitor (copy), p1 (copy), v11 (copy)
			menuJanitor:add(function() -- line: 64
				-- upvalues: p1 (copy), v11 (copy)
				p1:removeModification(v11)
			end)
		end)

		local AbsoluteCanvasSizeX = ScrollingFrame.AbsoluteCanvasSize.X

		local function rightAlignCanvas() -- line: 73
			-- upvalues: p1 (copy), ScrollingFrame (copy), AbsoluteCanvasSizeX (ref)
			if p1.alignment == "Right" then
				local AbsoluteCanvasSizeX2 = ScrollingFrame.AbsoluteCanvasSize.X
				local v26 = AbsoluteCanvasSizeX - AbsoluteCanvasSizeX2

				AbsoluteCanvasSizeX = AbsoluteCanvasSizeX2
				ScrollingFrame.CanvasPosition = Vector2.new(ScrollingFrame.CanvasPosition.X - v26, 0)
			end
		end

		menuJanitor:add(p1.selected:Connect(rightAlignCanvas))
		menuJanitor:add(ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(rightAlignCanvas))

		local v14 = p1:getStateGroup()

		if Themes.getThemeValue(v14, "IconImage", "Image", "Deselected") == Themes.getThemeValue(v14, "IconImage", "Image", "Selected") then
			local font = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Light, Enum.FontStyle.Normal)

			p1:removeModificationWith("IconLabel", "Text", "Viewing")
			p1:removeModificationWith("IconLabel", "Image", "Viewing")
			p1:modifyTheme({
				{
					"IconLabel",
					"FontFace",
					font,
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

		local v16 = p1:getInstance("MenuGap")

		menuJanitor:add(p1.alignmentChanged:Connect(function() --[[ updateAlignent ]] -- line: 104
			-- upvalues: p1 (copy), v16 (copy)
			local n1 = -99999
			local n2 = -99998

			if p1.alignment == "Right" then
				n1 = 99999
				n2 = 99998
			end

			p1:modifyTheme({
				"IconSpot",
				"LayoutOrder",
				n1
			})
			v16.LayoutOrder = n2
		end))

		local n3 = -99999
		local n4 = -99998

		if p1.alignment == "Right" then
			n3 = 99999
			n4 = 99998
		end

		p1:modifyTheme({
			"IconSpot",
			"LayoutOrder",
			n3
		})
		v16.LayoutOrder = n4
		ScrollingFrame:GetAttributeChangedSignal("MenuCanvasWidth"):Connect(function() -- line: 120
			-- upvalues: ScrollingFrame (copy)
			local MenuCanvasWidth = ScrollingFrame:GetAttribute("MenuCanvasWidth")
			local CanvasSizeY = ScrollingFrame.CanvasSize.Y

			ScrollingFrame.CanvasSize = UDim2.new(0, MenuCanvasWidth, CanvasSizeY.Scale, CanvasSizeY.Offset)
		end)
		menuJanitor:add(p1.updateMenu:Connect(function() -- line: 125
			-- upvalues: ScrollingFrame (copy), clone (copy)
			local MaxIcons = ScrollingFrame:GetAttribute("MaxIcons")

			if not MaxIcons then
				return
			end

			local t1 = {}

			for _, v in pairs(ScrollingFrame:GetChildren()) do
				if v:GetAttribute("WidgetUID") and v.Visible then
					table.insert(t1, {
						v,
						v.AbsolutePosition.X
					})
				end
			end

			table.sort(t1, function(p2, p3) -- line: 137
				return p2[2] < p3[2]
			end)

			local n5 = 0

			for i = 1, MaxIcons do
				local v37 = t1[i]

				if not v37 then
					break
				end

				n5 += v37[1].AbsoluteSize.X + clone.Padding.Offset
			end

			ScrollingFrame:SetAttribute("MenuWidth", n5)
		end))

		local function startMenuUpdate() -- line: 152
			-- upvalues: p1 (copy)
			task.delay(0.1, function() -- line: 153
				-- upvalues: p1 (copy)
				p1.startMenuUpdate:Fire()
			end)
		end

		menuJanitor:add(ScrollingFrame.ChildAdded:Connect(startMenuUpdate))
		menuJanitor:add(ScrollingFrame.ChildRemoved:Connect(startMenuUpdate))
		menuJanitor:add(ScrollingFrame:GetAttributeChangedSignal("MaxIcons"):Connect(startMenuUpdate))
		menuJanitor:add(ScrollingFrame:GetAttributeChangedSignal("MaxWidth"):Connect(startMenuUpdate))
		task.delay(0.1, function() -- line: 153
			-- upvalues: p1 (copy)
			p1.startMenuUpdate:Fire()
		end)
	end)
	p1.menuSet:Connect(function(p4) -- line: 165
		-- upvalues: p1 (copy), iconModule (copy)
		for _, v in pairs(p1.menuIcons) do
			iconModule.getIconByUID(v):destroy()
		end

		if type(p4) == "table" then
			for _, v in pairs(p4) do
				v:joinMenu(p1)
			end
		end
	end)

	return ScrollingFrame
end
