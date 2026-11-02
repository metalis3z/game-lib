-- Generated from ui/ServerStorage/Gui_Before3Dv2/left bottom.rbxm by _tools/rbxm2lua.luau
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
					I[7] = new("ImageLabel", I[4], "Icon", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://79640278698024"), Position = UDim2.new(0.1882948, 0, -0.0189652, 6), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(44, 48), ZIndex = 3 })
					I[8] = new("TextLabel", I[4], "Label", { AnchorPoint = Vector2.new(0.5, 1), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.6591667, 0, 0.4811321, 13), Size = UDim2.new(1.025, -8, 0, 26), Text = "Index", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 25, ZIndex = 4 }, { ["MontFix"] = true })
						I[9] = new("UIStroke", I[8], "TextStroke", { Color = Color3.fromRGB(40, 47, 57), Thickness = 2.5 })
					I[10] = new("UIStroke", I[4], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(40, 47, 57), Thickness = 3 })
					I[11] = new("UIGradient", I[4], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 236, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 164, 74)) }), Rotation = 90 })
				I[12] = new("Frame", I[3], "Lip", { BackgroundColor3 = Color3.fromRGB(40, 116, 54), Size = UDim2.new(1, 0, 1.03, -7) })
					I[13] = new("UIStroke", I[12], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(40, 47, 57), Thickness = 3 })
			I[14] = new("TextButton", I[2], "ShopButton", { AutoButtonColor = false, BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.new(0.5222222, 0, -0.3225806, 114), Size = UDim2.fromOffset(137, 190), Text = "" }, { ["MontFix"] = true }, { "UIButton" })
				I[15] = new("Frame", I[14], "Face", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(1, 0, 1, -7), ZIndex = 2 })
					I[16] = new("ImageLabel", I[15], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.8, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(14, 14), ZIndex = 0 })
						I[17] = new("UIGradient", I[16], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 224, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(79, 176, 245)) }), Rotation = 90 })
					I[18] = new("TextLabel", I[15], "Label", { AnchorPoint = Vector2.new(0.5, 1), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.6466666, 0, 0.8344997, -5), Size = UDim2.new(1, -8, 0, 26), Text = "Shop", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 25, ZIndex = 4 }, { ["MontFix"] = true })
						I[19] = new("UIStroke", I[18], "TextStroke", { Color = Color3.fromRGB(40, 47, 57), Thickness = 2.5 })
					I[20] = new("UIStroke", I[15], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(40, 47, 57), Thickness = 3 })
					I[21] = new("UIGradient", I[15], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 224, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(79, 176, 245)) }), Rotation = 90 })
					I[22] = new("Frame", I[15], "Icon", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0, 7), Size = UDim2.fromOffset(52, 52), ZIndex = 3 })
						I[23] = new("ImageLabel", I[22], "IconImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://84499021410249"), Position = UDim2.fromScale(-0.4423077, 0.4182692), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(44, 48), ZIndex = 3 })
				I[24] = new("Frame", I[14], "Lip", { BackgroundColor3 = Color3.fromRGB(0, 170, 255), Position = UDim2.fromOffset(0, 7), Size = UDim2.new(1, 0, 0.86, -7) })
					I[25] = new("UIStroke", I[24], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(40, 47, 57), Thickness = 3 })
			I[26] = new("UIGridLayout", I[2], "UIGridLayout", { CellPadding = UDim2.fromOffset(8, 8), CellSize = UDim2.fromOffset(150, 60), FillDirection = Enum.FillDirection.Vertical, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[27] = new("Frame", I[2], "SlowModeSlot", { BackgroundTransparency = 1, LayoutOrder = 3 })
				I[28] = new("TextButton", I[27], "Slow Mode", { BackgroundColor3 = Color3.fromRGB(46, 50, 64), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Position = UDim2.fromOffset(0, 4), Size = UDim2.new(1, 0, 0, 46), Text = "" })
					I[29] = new("TextLabel", I[28], "Title", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.07, 0.5), RichText = true, Size = UDim2.fromScale(0.52, 0.56), Text = "Slow Mode", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
						I[30] = new("UIStroke", I[29], "Outer", { LineJoinMode = Enum.LineJoinMode.Miter, StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.12 })
					I[31] = new("UIStroke", I[28], "Outer", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(22, 26, 33), Thickness = 3 })
					I[32] = new("Frame", I[28], "ToggleOn", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Interactable = false, LayoutOrder = 2, Position = UDim2.fromScale(0.955, 0.5), Selectable = true, Size = UDim2.fromScale(0.36, 0.62), ZIndex = 2 })
						I[33] = new("UIGradient", I[32], "UiGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 120, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 40, 50)) }), Rotation = 90 })
						I[34] = new("UIStroke", I[32], "Outer", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(22, 26, 33), Thickness = 3 })
						I[35] = new("ImageLabel", I[32], "Bevel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://136393561370347"), ImageTransparency = 0.25, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(200, 200, 220, 220), SliceScale = 0.1, Visible = false, ZIndex = 0 })
						I[36] = new("TextLabel", I[32], "State", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.18), Size = UDim2.fromScale(0.44, 0.64), Text = "OFF", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 3 })
							I[37] = new("UIStroke", I[36], "UIStroke", { Thickness = 2 })
						I[38] = new("Frame", I[32], "Knob", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.26, 0.5), Size = UDim2.fromScale(0.42, 0.78), ZIndex = 4 })
							I[39] = new("UIAspectRatioConstraint", I[38], "UIAspectRatioConstraint")
							I[40] = new("UIStroke", I[38], "UIStroke", { Thickness = 2.5 })
							I[41] = new("UIGradient", I[38], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 204, 214)) }), Rotation = 90 })
					I[42] = new("ImageLabel", I[28], "Bevel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://136393561370347"), ImageTransparency = 0.82, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(200, 200, 220, 220), SliceScale = 0.1, Visible = false, ZIndex = 0 })
					I[43] = new("UIGradient", I[28], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 176, 200)) }), Rotation = 90 })
		I[44] = new("Frame", I[1], "LeftHUD", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.01, 0.5000001), Size = UDim2.fromScale(0.1482663, 0.4146695) })
	return I[1]
end

return build
