-- Generated from ui/ServerStorage/Gui_BeforeNoCorners/left bottom.rbxm by _tools/rbxm2lua.luau
-- UI builder: local gui = require(this)(); gui.Parent = game.Players.LocalPlayer.PlayerGui (or StarterGui)

local function new(class, parent, name, props, attrs, tags)
	local o = Instance.new(class)
	o.Name = name
	if props then
		for k, v in props do
			o[k] = v
		end
	end
	if attrs then
		for k, v in attrs do
			o:SetAttribute(k, v)
		end
	end
	if tags then
		for _, t in tags do
			o:AddTag(t)
		end
	end
	if parent then
		o.Parent = parent
	end
	return o
end

local function build()
	local I = {}
	I[1] = new("ScreenGui", nil, "left bottom", { ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Holder", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Position = UDim2.new(0, 14, 0.5, 0), Size = UDim2.fromOffset(180, 310) }, nil, { "AutoScale" })
			I[3] = new("TextButton", I[2], "IndexButton", { AutoButtonColor = false, BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromOffset(86, 98), Text = "" }, { ["MontFix"] = true }, { "UIButton" })
				I[4] = new("Frame", I[3], "Face", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(1, 0, 1, -7), ZIndex = 2 })
					I[5] = new("ImageLabel", I[4], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.8, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(14, 14), ZIndex = 0 })
						I[6] = new("UIGradient", I[5], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 236, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 164, 74)) }), Rotation = 90 })
						I[7] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[8] = new("ImageLabel", I[4], "Icon", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://79640278698024"), Position = UDim2.new(0.1882948, 0, -0.0189652, 6), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(44, 48), ZIndex = 3 })
					I[9] = new("TextLabel", I[4], "Label", { AnchorPoint = Vector2.new(0.5, 1), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.6591667, 0, 0.4811321, 13), Size = UDim2.new(1.025, -8, 0, 26), Text = "Index", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 25, ZIndex = 4 }, { ["MontFix"] = true })
						I[10] = new("UIStroke", I[9], "TextStroke", { Color = Color3.fromRGB(40, 47, 57), Thickness = 2.5 })
					I[11] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[12] = new("UIStroke", I[4], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(40, 47, 57), Thickness = 3 })
					I[13] = new("UIGradient", I[4], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 236, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 164, 74)) }), Rotation = 90 })
				I[14] = new("Frame", I[3], "Lip", { BackgroundColor3 = Color3.fromRGB(40, 116, 54), Size = UDim2.new(1, 0, 1.03, -7) })
					I[15] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[16] = new("UIStroke", I[14], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(40, 47, 57), Thickness = 3 })
			I[17] = new("TextButton", I[2], "ShopButton", { AutoButtonColor = false, BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.new(0.5222222, 0, -0.3225806, 114), Size = UDim2.fromOffset(137, 190), Text = "" }, { ["MontFix"] = true }, { "UIButton" })
				I[18] = new("Frame", I[17], "Face", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(1, 0, 1, -7), ZIndex = 2 })
					I[19] = new("ImageLabel", I[18], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.8, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(14, 14), ZIndex = 0 })
						I[20] = new("UIGradient", I[19], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 224, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(79, 176, 245)) }), Rotation = 90 })
						I[21] = new("UICorner", I[19], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[22] = new("TextLabel", I[18], "Label", { AnchorPoint = Vector2.new(0.5, 1), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.6466666, 0, 0.8344997, -5), Size = UDim2.new(1, -8, 0, 26), Text = "Shop", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 25, ZIndex = 4 }, { ["MontFix"] = true })
						I[23] = new("UIStroke", I[22], "TextStroke", { Color = Color3.fromRGB(40, 47, 57), Thickness = 2.5 })
					I[24] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[25] = new("UIStroke", I[18], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(40, 47, 57), Thickness = 3 })
					I[26] = new("UIGradient", I[18], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 224, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(79, 176, 245)) }), Rotation = 90 })
					I[27] = new("Frame", I[18], "Icon", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0, 7), Size = UDim2.fromOffset(52, 52), ZIndex = 3 })
						I[28] = new("ImageLabel", I[27], "IconImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://84499021410249"), Position = UDim2.fromScale(-0.4423077, 0.4182692), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(44, 48), ZIndex = 3 })
				I[29] = new("Frame", I[17], "Lip", { BackgroundColor3 = Color3.fromRGB(0, 170, 255), Position = UDim2.fromOffset(0, 7), Size = UDim2.new(1, 0, 0.86, -7) })
					I[30] = new("UICorner", I[29], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[31] = new("UIStroke", I[29], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(40, 47, 57), Thickness = 3 })
			I[32] = new("UIGridLayout", I[2], "UIGridLayout", { CellPadding = UDim2.fromOffset(8, 8), CellSize = UDim2.fromOffset(150, 60), FillDirection = Enum.FillDirection.Vertical, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[33] = new("TextButton", I[2], "Slow Mode", { AutoButtonColor = false, BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.new(0.5222222, 0, -0.3225806, 114), Size = UDim2.fromOffset(137, 190), Text = "" }, { ["MontFix"] = true }, { "UIButton" })
				I[34] = new("Frame", I[33], "Face", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(1, 0, 1, -7), ZIndex = 2 })
					I[35] = new("ImageLabel", I[34], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.8, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(14, 14), ZIndex = 0 })
						I[36] = new("UIGradient", I[35], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 224, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(79, 176, 245)) }), Rotation = 90 })
						I[37] = new("UICorner", I[35], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[38] = new("TextLabel", I[34], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(50, 3), Size = UDim2.new(1, -56, 0, 20), Text = "Slow Mode", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 25, TextWrapped = true, ZIndex = 4 }, { ["MontFix"] = true })
						I[39] = new("UIStroke", I[38], "TextStroke", { Color = Color3.fromRGB(40, 47, 57), Thickness = 2.5 })
					I[40] = new("UICorner", I[34], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[41] = new("UIStroke", I[34], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(40, 47, 57), Thickness = 3 })
					I[42] = new("UIGradient", I[34], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(196, 150, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 70, 220)) }), Rotation = 90 })
					I[43] = new("TextLabel", I[34], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Position = UDim2.new(0, 6, 0.5, 0), Size = UDim2.fromOffset(40, 40), Text = "🐢", TextScaled = true, TextWrapped = true, ZIndex = 3 })
				I[44] = new("Frame", I[33], "Lip", { BackgroundColor3 = Color3.fromRGB(70, 36, 150), Position = UDim2.fromOffset(0, 7), Size = UDim2.new(1, 0, 0.86, -7) })
					I[45] = new("UICorner", I[44], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[46] = new("UIStroke", I[44], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(40, 47, 57), Thickness = 3 })
				I[47] = new("Frame", I[33], "ToggleOn", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Interactable = false, LayoutOrder = 2, Position = UDim2.fromOffset(97, 25), Selectable = true, Size = UDim2.fromOffset(74, 22), ZIndex = 4 })
					I[48] = new("UIGradient", I[47], "UiGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 120, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 40, 50)) }), Rotation = 90 })
					I[49] = new("UIStroke", I[47], "Outer", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(22, 26, 33), Thickness = 3 })
					I[50] = new("UICorner", I[47], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) })
					I[51] = new("ImageLabel", I[47], "Bevel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://136393561370347"), ImageTransparency = 0.25, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(200, 200, 220, 220), SliceScale = 0.1, ZIndex = 5 })
					I[52] = new("TextLabel", I[47], "State", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.18), Size = UDim2.fromScale(0.44, 0.64), Text = "OFF", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 5 })
						I[53] = new("UIStroke", I[52], "UIStroke", { Thickness = 2 })
					I[54] = new("Frame", I[47], "Knob", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.26, 0.5), Size = UDim2.fromScale(0.44, 0.82), ZIndex = 6 })
						I[55] = new("UIAspectRatioConstraint", I[54], "UIAspectRatioConstraint")
						I[56] = new("UICorner", I[54], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) })
						I[57] = new("UIStroke", I[54], "UIStroke", { Thickness = 2.5 })
						I[58] = new("UIGradient", I[54], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 204, 214)) }), Rotation = 90 })
		I[59] = new("Frame", I[1], "LeftHUD", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.01, 0.5000001), Size = UDim2.fromScale(0.1482663, 0.4146695) })
	return I[1]
end

return build
