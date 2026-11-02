-- Generated from ui/StarterGui/OfflineCashOnly.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "OfflineCashOnly", { Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(44, 47, 51), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageTransparency = 0.1, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.4226529, 0.5567666), SliceCenter = Rect.new(372, 132, 372, 132), SliceScale = 0.7, TileSize = UDim2.fromScale(0.25, 0.25), ZIndex = 100 })
			I[3] = new("Frame", I[2], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.019), Size = UDim2.fromScale(0.9946208, 0.1353015), ZIndex = 5 })
				I[4] = new("TextLabel", I[3], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3050624, 0.607242), Size = UDim2.fromScale(0.5605385, 0.8520223), Text = "Welcome Back!", TextColor3 = Color3.fromRGB(22, 26, 33), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
					I[5] = new("TextLabel", I[4], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.4275362), Size = UDim2.fromScale(0.9999999, 0.9999999), Text = "Welcome Back!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[6] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(22, 26, 33), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.065 })
					I[7] = new("UIStroke", I[4], "UIStroke", { Color = Color3.fromRGB(22, 26, 33), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.065 })
				I[8] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
				I[9] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 9.6300001 })
				I[10] = new("CanvasGroup", I[3], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.49987, 0.8400216), Size = UDim2.fromScale(1.005668, 1.6799998), ZIndex = 0 })
					I[11] = new("UIGradient", I[10], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(66, 66, 66)), ColorSequenceKeypoint.new(1, Color3.fromRGB(66, 66, 66)) }), Enabled = false })
					I[12] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
					I[13] = new("Frame", I[10], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.3262432), Size = UDim2.fromScale(1.1, 0.831) })
						I[14] = new("UIGradient", I[13], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 242, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 184, 255)) }), Rotation = 90 })
						I[15] = new("ImageLabel", I[13], "Effect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://120892638432695"), ImageTransparency = 0.77, Position = UDim2.fromScale(0.3800669, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) })
						I[16] = new("ImageLabel", I[13], "StudPattern", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageContent = Content.fromUri("rbxassetid://117164658961906"), ImageTransparency = 0.75, Position = UDim2.fromScale(1, 0.9999998), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 0.9999998), TileSize = UDim2.fromScale(0.11, 0.9) })
							I[17] = new("UICorner", I[16], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
							I[18] = new("ImageLabel", I[16], "Effect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://120892638432695"), ImageTransparency = 0.77, Position = UDim2.fromScale(0.3800669, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) })
			I[19] = new("Frame", I[2], "ButtonsFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.8), Size = UDim2.fromScale(0.9864737, 0.3932629) })
				I[20] = new("UIListLayout", I[19], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.04, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[21] = new("ImageButton", I[19], "ClaimWithMultiplierPurchase", { AnchorPoint = Vector2.new(1, 0), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(239, 239, 239), ImageTransparency = 0.05, LayoutOrder = 1, Position = UDim2.fromScale(0.526111, 0.1249233), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.4094409, 0.6346425), SliceCenter = Rect.new(100, 100, 100, 100), ZIndex = 2 }, { ["ConsoleKey"] = "ButtonY" })
					I[22] = new("Frame", I[21], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.47), Size = UDim2.fromScale(1, 0.9444445) })
					I[23] = new("TextLabel", I[21], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1317416, 0.0394835), Size = UDim2.fromScale(0.7988076, 0.4089975), Text = "39", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
						I[24] = new("UIStroke", I[23], "UIStroke", { Color = Color3.fromRGB(115, 94, 20), Thickness = 3 })
					I[25] = new("TextLabel", I[21], "TextLabel_2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4947769, 0.4965488), Size = UDim2.fromScale(0.9596863, 0.8371298), Text = "Claim x10!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
						I[26] = new("UIStroke", I[25], "UIStroke", { Color = Color3.fromRGB(108, 81, 33), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.05 })
					I[27] = new("UIGradient", I[21], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 236, 24)), ColorSequenceKeypoint.new(1, Color3.fromRGB(248, 153, 45)) }), Rotation = 90 })
					I[28] = new("UICorner", I[21], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
					I[29] = new("UIStroke", I[21], "UIStroke", { Color = Color3.fromRGB(115, 94, 20), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.03 })
					I[30] = new("UIAspectRatioConstraint", I[21], "UIAspectRatioConstraint", { AspectRatio = 2.1199999 })
					I[31] = new("UIScale", I[21], "UIScale")
				I[32] = new("ImageButton", I[19], "Claim", { AnchorPoint = Vector2.new(1, 0), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageColor3 = Color3.fromRGB(239, 239, 239), ImageTransparency = 0.05, LayoutOrder = 2, Position = UDim2.fromScale(0.9117219, 0.2653525), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.3456109, 0.4692952), SliceCenter = Rect.new(100, 100, 100, 100), ZIndex = 2 }, { ["ConsoleKey"] = "ButtonX" })
					I[33] = new("TextLabel", I[32], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.51), Size = UDim2.fromScale(0.6620894, 0.6380914), Text = "Claim!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
						I[34] = new("UIStroke", I[33], "UIStroke", { Color = Color3.fromRGB(24, 86, 44), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.05 })
					I[35] = new("UIGradient", I[32], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(109, 225, 98)), ColorSequenceKeypoint.new(1, Color3.fromRGB(56, 200, 80)) }), Rotation = 90 })
					I[36] = new("UICorner", I[32], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
					I[37] = new("UIStroke", I[32], "UIStroke", { Color = Color3.fromRGB(80, 115, 48), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.05 })
					I[38] = new("UIAspectRatioConstraint", I[32], "UIAspectRatioConstraint", { AspectRatio = 2.4200001 })
					I[39] = new("UIScale", I[32], "UIScale")
			I[40] = new("ImageLabel", I[2], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://85663970745602"), Position = UDim2.fromScale(0.4937947, 0.4000866), Size = UDim2.fromScale(0.3861673, 0.5040527) })
				I[41] = new("UIAspectRatioConstraint", I[40], "UIAspectRatioConstraint")
			I[42] = new("TextLabel", I[2], "Cash", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 2, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.4961033, 0.5893825), Size = UDim2.fromScale(0.8638623, 0.1276959), Text = "61.8B$", TextColor3 = Color3.fromRGB(243, 243, 243), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[43] = new("UIGradient", I[42], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(74, 245, 44)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(140, 246, 101)), ColorSequenceKeypoint.new(1, Color3.fromRGB(105, 255, 79)) }), Rotation = 90 })
				I[44] = new("UIStroke", I[42], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.05 })
			I[45] = new("TextLabel", I[2], "Title_2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4913712, 0.1978042), Size = UDim2.fromScale(0.7941974, 0.1021498), Text = "OFFLINE MONEY", TextColor3 = Color3.fromRGB(22, 26, 33), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true, ZIndex = 2 })
				I[46] = new("TextLabel", I[45], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.4275362), Size = UDim2.fromScale(1, 1), Text = "OFFLINE MONEY", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true })
					I[47] = new("UIStroke", I[46], "UIStroke", { Color = Color3.fromRGB(22, 26, 33), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.065 })
					I[48] = new("UIGradient", I[46], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.1868512, Color3.fromRGB(4, 255, 0)), ColorSequenceKeypoint.new(0.3114187, Color3.fromRGB(129, 255, 127)), ColorSequenceKeypoint.new(0.399654, Color3.fromRGB(191, 255, 190)), ColorSequenceKeypoint.new(0.4550173, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5484429, Color3.fromRGB(229, 255, 235)), ColorSequenceKeypoint.new(0.6401384, Color3.fromRGB(0, 255, 8)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 131, 31)) }), Rotation = 90 })
				I[49] = new("UIStroke", I[45], "UIStroke", { Color = Color3.fromRGB(22, 26, 33), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.065 })
			I[50] = new("UICorner", I[2], "UICorner")
			I[51] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.3099999 })
			I[52] = new("ImageButton", I[2], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.932937, 0.0372226), Selectable = false, Size = UDim2.fromScale(0.0821227, 0.0911473), ZIndex = 5 })
				I[53] = new("TextLabel", I[52], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 15 })
					I[54] = new("UIStroke", I[53], "UIStroke", { Thickness = 2 })
				I[55] = new("ImageLabel", I[52], "DropShadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 4), ImageContent = Content.fromUri("rbxassetid://96735047582734"), ImageTransparency = 0.8, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1.5088595, 1.7296873), SliceCenter = Rect.new(256, 256, 256, 256), SliceScale = 0.4, ZIndex = 12 })
				I[56] = new("UIAspectRatioConstraint", I[52], "UIAspectRatioConstraint", { AspectRatio = 1.1441339 })
				I[57] = new("ImageLabel", I[52], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 0), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Selectable = true, Size = UDim2.fromScale(1.1349496, 1.3059219), SliceCenter = Rect.new(64, 64, 64, 64), SliceScale = 0.2, ZIndex = 13 })
					I[58] = new("ImageLabel", I[57], "Pattern", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://131176354845909"), ImageTransparency = 0.75, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1.0000001, 0.9999999), TileSize = UDim2.fromScale(1.325, 1.25), Visible = false, ZIndex = 14 })
					I[59] = new("UIGradient", I[57], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 9, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(210, 0, 8)) }), Rotation = 90 })
					I[60] = new("UICorner", I[57], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
					I[61] = new("UIStroke", I[57], "UIStroke", { Thickness = 1.5 })
			I[62] = new("ImageLabel", I[2], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.4756746), Size = UDim2.fromScale(1, 1.0486509), ZIndex = -1 })
				I[63] = new("UICorner", I[62], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
				I[64] = new("UIStroke", I[62], "UIStroke", { Thickness = 3 })
	return I[1]
end

return build
