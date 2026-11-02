-- Generated from ui/ServerStorage/Removed_DragonSystem/DragonShopGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "DragonShopGui", { DisplayOrder = 20, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "CardTemplate", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.fromOffset(246, 268) })
			I[3] = new("ImageLabel", I[2], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), ZIndex = 0 })
				I[4] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[5] = new("UIGradient", I[3], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 150, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(210, 88, 14)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 226, 160)), ColorSequenceKeypoint.new(1, Color3.fromRGB(232, 168, 100)) }) })
			I[6] = new("UIGradient", I[2], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 150, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(210, 88, 14)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 226, 160)), ColorSequenceKeypoint.new(1, Color3.fromRGB(232, 168, 100)) }) })
			I[7] = new("ViewportFrame", I[2], "View", { Ambient = Color3.fromRGB(210, 210, 210), BackgroundColor3 = Color3.fromRGB(255, 255, 255), LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.fromOffset(12, 12), Size = UDim2.new(1, -24, 0, 134) })
				I[8] = new("UIGradient", I[7], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(236, 232, 244)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(190, 232, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 190, 250)) }) })
				I[9] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[10] = new("UIStroke", I[7], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3.5 })
			I[11] = new("TextLabel", I[2], "DragonName", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(10, 150), Size = UDim2.new(1, -20, 0, 30), Text = "Fire Dragon", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
				I[12] = new("UITextSizeConstraint", I[11], "UITextSizeConstraint", { MaxTextSize = 26 })
				I[13] = new("UIStroke", I[11], "TextStroke", { Thickness = 3 })
			I[14] = new("TextLabel", I[2], "Tagline", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(10, 180), Size = UDim2.new(1, -20, 0, 20), Text = "Your first dragon", TextColor3 = Color3.fromRGB(255, 248, 225), TextSize = 13 }, { ["MontFix"] = true })
				I[15] = new("UIStroke", I[14], "TextStroke", { Thickness = 1.8 })
			I[16] = new("TextButton", I[2], "Action", { AnchorPoint = Vector2.new(0.5, 1), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 1, -12), Size = UDim2.new(1, -24, 0, 46), Text = "EQUIPPED", TextTransparency = 1 }, { ["MontFix"] = true }, { "UIButton" })
				I[17] = new("ImageLabel", I[16], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), ZIndex = 0 })
					I[18] = new("UICorner", I[17], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[19] = new("UIGradient", I[17], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 240, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(54, 176, 70)) }), Rotation = 90 })
				I[20] = new("UIGradient", I[16], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 240, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(54, 176, 70)) }), Rotation = 90 })
				I[21] = new("TextLabel", I[16], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "EQUIPPED", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 21, ZIndex = 2 }, { ["MirrorText"] = true, ["MontFix"] = true })
					I[22] = new("UIStroke", I[21], "TextStroke", { Thickness = 2.5 })
				I[23] = new("UICorner", I[16], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[24] = new("UIStroke", I[16], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
			I[25] = new("TextLabel", I[2], "Bonus", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(18, 18), Size = UDim2.fromOffset(112, 26), Text = "Stamina x1.2", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 13, ZIndex = 4 }, { ["MontFix"] = true })
				I[26] = new("UIGradient", I[25], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 222, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 140, 240)) }), Rotation = 90 })
				I[27] = new("UIStroke", I[25], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2.5 })
				I[28] = new("UIStroke", I[25], "TextStroke", { Thickness = 2 })
				I[29] = new("UICorner", I[25], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
			I[30] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
			I[31] = new("UIStroke", I[2], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 4 })
		I[32] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.47), Size = UDim2.fromOffset(820, 560), Visible = false }, nil, { "AutoScale" })
			I[33] = new("ImageLabel", I[32], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), ZIndex = 0 })
				I[34] = new("UICorner", I[33], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[35] = new("UIGradient", I[33], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 44, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 24, 58)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 228, 238)) }) })
			I[36] = new("Frame", I[32], "Band", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromOffset(10, 10), Size = UDim2.new(1, -20, 0, 64) })
				I[37] = new("ImageLabel", I[36], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), ZIndex = 0 })
					I[38] = new("UICorner", I[37], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[39] = new("UIGradient", I[37], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 136, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(222, 88, 12)) }) }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 60, 40)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 190, 40)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 60, 40)) }) })
				I[40] = new("TextLabel", I[36], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(76, 6), Size = UDim2.new(0, 360, 1, -12), Text = "Dragon Shop", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
					I[41] = new("UIStroke", I[40], "TextStroke", { Thickness = 4.5 })
				I[42] = new("TextLabel", I[36], "Subtitle", { AnchorPoint = Vector2.new(1, 0), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(1, -70, 0, 20), Size = UDim2.fromOffset(280, 26), Text = "Pick the dragon you ride", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 15, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 2 }, { ["MontFix"] = true })
					I[43] = new("UIStroke", I[42], "TextStroke", { Thickness = 2.5 })
				I[44] = new("TextButton", I[36], "Close", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(1, -9, 0.5, 0), Size = UDim2.fromOffset(44, 44), Text = "", ZIndex = 3 }, { ["MontFix"] = true }, { "UIButton" })
					I[45] = new("Frame", I[44], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Rotation = 45, Size = UDim2.fromOffset(26, 7), Visible = false, ZIndex = 4 })
						I[46] = new("UIStroke", I[45], "UIStroke", { Thickness = 1.5 })
						I[47] = new("UICorner", I[45], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[48] = new("Frame", I[44], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Rotation = -45, Size = UDim2.fromOffset(26, 7), Visible = false, ZIndex = 4 })
						I[49] = new("UIStroke", I[48], "UIStroke", { Thickness = 1.5 })
						I[50] = new("UICorner", I[48], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[51] = new("UICorner", I[44], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[52] = new("UIStroke", I[44], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
					I[53] = new("UIGradient", I[44], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 70, 70)), ColorSequenceKeypoint.new(1, Color3.fromRGB(196, 0, 26)) }), Rotation = 90 })
					I[54] = new("TextLabel", I[44], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 5 })
						I[55] = new("UIPadding", I[54], "UIPadding", { PaddingBottom = UDim.new(0.12, 0), PaddingLeft = UDim.new(0.12, 0), PaddingRight = UDim.new(0.12, 0), PaddingTop = UDim.new(0.12, 0) })
						I[56] = new("UIStroke", I[54], "UIStroke", { Thickness = 3 })
					I[57] = new("ImageLabel", I[44], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), ZIndex = 3 })
						I[58] = new("UICorner", I[57], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
						I[59] = new("UIGradient", I[57], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 70, 70)), ColorSequenceKeypoint.new(1, Color3.fromRGB(196, 0, 26)) }), Rotation = 90 })
				I[60] = new("ViewportFrame", I[36], "HeaderView", { Ambient = Color3.fromRGB(220, 220, 220), AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.new(0, 8, 0.5, 0), Size = UDim2.fromOffset(60, 56), ZIndex = 3 })
				I[61] = new("UICorner", I[36], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[62] = new("UIStroke", I[36], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
				I[63] = new("UIGradient", I[36], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 136, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(222, 88, 12)) }) }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 60, 40)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 190, 40)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 60, 40)) }) })
				I[64] = new("CanvasGroup", I[36], "Shine", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
					I[65] = new("UICorner", I[64], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[66] = new("Frame", I[64], "Stripe", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.68, BorderSizePixel = 0, Position = UDim2.fromScale(0.52, 0.5), Rotation = 28, Size = UDim2.new(0, 44, 2.5999999, 0) })
					I[67] = new("Frame", I[64], "Stripe", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.68, BorderSizePixel = 0, Position = UDim2.fromScale(0.595, 0.5), Rotation = 28, Size = UDim2.new(0, 38, 2.5999999, 0) })
					I[68] = new("Frame", I[64], "Stripe", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.68, BorderSizePixel = 0, Position = UDim2.fromScale(0.67, 0.5), Rotation = 28, Size = UDim2.new(0, 32, 2.5999999, 0) })
			I[69] = new("ScrollingFrame", I[32], "List", { AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromOffset(14, 86), ScrollBarImageColor3 = Color3.fromRGB(150, 70, 50), ScrollBarThickness = 8, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.new(1, -28, 1, -100) })
				I[70] = new("UIGridLayout", I[69], "UIGridLayout", { CellPadding = UDim2.fromOffset(12, 12), CellSize = UDim2.fromOffset(246, 268), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
				I[71] = new("UIPadding", I[69], "UIPadding", { PaddingBottom = UDim.new(0, 8), PaddingTop = UDim.new(0, 4) })
			I[72] = new("UICorner", I[32], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
			I[73] = new("UIStroke", I[32], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 4 })
			I[74] = new("UIGradient", I[32], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 44, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 24, 58)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 228, 238)) }) })
	return I[1]
end

return build
