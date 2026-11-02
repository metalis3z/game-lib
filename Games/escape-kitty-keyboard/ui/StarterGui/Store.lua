-- Generated from ui/StarterGui/Store.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Store", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Store", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.64, 0.64), Visible = false }, nil, { "Frame" })
			I[3] = new("UIStroke", I[2], "UIStroke", { BorderStrokePosition = Enum.BorderStrokePosition.Inner, StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.005291 })
			I[4] = new("ImageLabel", I[2], "Header", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://100447503406361"), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.1296296) })
				I[5] = new("Frame", I[4], "Holder", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.0408163), Size = UDim2.fromScale(1, 0.8163266) })
					I[6] = new("ImageButton", I[5], "ExitButton", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://88014274426057"), Position = UDim2.fromScale(0.987152, 0.5), Size = UDim2.fromScale(0.0620985, 0.8) }, nil, { "Button" })
						I[7] = new("TextLabel", I[6], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.46875), Size = UDim2.fromScale(1, 0.65625), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
							I[8] = new("UIStroke", I[7], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.0714286 })
						I[9] = new("UIScale", I[6], "UIScale")
					I[10] = new("ImageLabel", I[5], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://103248461436758"), Position = UDim2.fromScale(0.012848, 0.5), Size = UDim2.fromScale(0.0835118, 0.85) })
					I[11] = new("TextLabel", I[5], "Txt", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1092077, 0.46875), Size = UDim2.fromScale(0.6, 0.65625), Text = "Store", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[12] = new("UIStroke", I[11], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.0761905 })
			I[13] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.2354498 })
			I[14] = new("UIScale", I[2], "UIScale")
			I[15] = new("Frame", I[2], "Content", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.994709), Size = UDim2.fromScale(1.2, 0.8650793) })
				I[16] = new("ScrollingFrame", I[15], "ScrollingFrame", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, BottomImageContent = Content.fromUri("rbxassetid://93079608146987"), CanvasSize = UDim2.fromScale(0, 0), ClipsDescendants = false, MidImageContent = Content.fromUri("rbxassetid://103921755022681"), Position = UDim2.fromScale(0.5, 0.5), ScrollBarImageTransparency = 1, ScrollBarThickness = 0, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(1, 0.9541284), TopImageContent = Content.fromUri("rbxassetid://132456408835496") })
					I[17] = new("UIListLayout", I[16], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.0160256, 0), SortOrder = Enum.SortOrder.LayoutOrder })
					I[18] = new("ImageLabel", I[16], "LuckyBlock", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://120836836640208"), LayoutOrder = 1, Position = UDim2.fromScale(0.0135021, 0.0046668), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.7976445, 0.5064102) }, nil, { "PaidRandomItem" })
						I[19] = new("Frame", I[18], "Content", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.0158228), Size = UDim2.fromScale(0.9888143, 0.9113924) })
							I[20] = new("TextLabel", I[19], "Header", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4431794, 0.0195312), Size = UDim2.fromScale(0.635, 0.185), Text = "x2 wins", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
								I[21] = new("UIStroke", I[20], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.06 })
							I[22] = new("TextButton", I[19], "TextButton", { BackgroundColor3 = Color3.fromRGB(124, 255, 42), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5391456, 0.4592483), Size = UDim2.fromOffset(120, 35), Text = "49", TextColor3 = Color3.fromRGB(252, 252, 252), TextSize = 25 })
								I[23] = new("UICorner", I[22], "UICorner")
							I[24] = new("ImageLabel", I[19], "TrophyIcon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://15540211845"), LayoutOrder = 1, Position = UDim2.fromScale(0.2424865, 0.5791807), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2, 1) })
							I[25] = new("UIStroke", I[19], "UIStroke")
					I[26] = new("ImageLabel", I[16], "LuckyBlock", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://114608380294269"), ImageRectOffset = Vector2.new(1, 1), ImageTransparency = 1, LayoutOrder = 1, Position = UDim2.fromScale(0.0135021, 0.0046668), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.7976445, 0.5064102) }, nil, { "PaidRandomItem" })
						I[27] = new("ImageLabel", I[26], "LuckyBlock", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://120836836640208"), ImageTransparency = 1, LayoutOrder = 1, Position = UDim2.new(-0.3, 105, 0.004, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.0654773, 0.9368345) }, nil, { "PaidRandomItem" })
							I[28] = new("Frame", I[27], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0761941, -0.0462182), Size = UDim2.fromOffset(309, 95) })
								I[29] = new("Frame", I[28], "Content", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.0158228), Size = UDim2.new(0.989, 2, 0.911, 0) })
									I[30] = new("TextLabel", I[29], "Header", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4431794, 0.0195312), Size = UDim2.fromScale(0.635, 0.185), Text = "vip afk zone", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
										I[31] = new("UIStroke", I[30], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.06 })
									I[32] = new("TextButton", I[29], "TextButton", { BackgroundColor3 = Color3.fromRGB(124, 255, 42), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5391456, 0.4592483), Size = UDim2.fromOffset(120, 35), Text = "49", TextColor3 = Color3.fromRGB(252, 252, 252), TextSize = 25 })
										I[33] = new("UICorner", I[32], "UICorner")
									I[34] = new("TextLabel", I[29], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.1311472, -0.023967), Size = UDim2.fromOffset(201, 112), Text = "👑", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 100 })
								I[35] = new("UICorner", I[28], "UICorner")
								I[36] = new("UIStroke", I[28], "UIStroke")
					I[37] = new("ImageLabel", I[16], "LuckyBlock", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://114608380294269"), ImageTransparency = 1, LayoutOrder = 1, Position = UDim2.fromScale(0.0135021, 0.0046668), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.7976445, 0.5064102) }, nil, { "PaidRandomItem" })
						I[38] = new("Frame", I[37], "Frame", { BackgroundColor3 = Color3.fromRGB(0, 170, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromOffset(22, -19), Size = UDim2.fromOffset(320, 120) })
							I[39] = new("Frame", I[38], "Content", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.0158228), Size = UDim2.fromScale(0.9888143, 0.9113924) })
								I[40] = new("TextLabel", I[39], "Header", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4431794, 0.0195312), Size = UDim2.fromScale(0.635, 0.185), Text = "Diamond Treadmill", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
									I[41] = new("UIStroke", I[40], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.06 })
								I[42] = new("TextButton", I[39], "TextButton", { BackgroundColor3 = Color3.fromRGB(124, 255, 42), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4875527, 0.4038218), Size = UDim2.fromOffset(129, 38), Text = "149", TextColor3 = Color3.fromRGB(252, 252, 252), TextSize = 25 })
									I[43] = new("UICorner", I[42], "UICorner")
							I[44] = new("ImageLabel", I[38], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81314075475305"), Position = UDim2.fromScale(0.0438539, 0.0682684), Size = UDim2.fromOffset(122, 113) })
							I[45] = new("UICorner", I[38], "UICorner")
							I[46] = new("UIStroke", I[38], "UIStroke")
					I[47] = new("ImageLabel", I[16], "LuckyBlock", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://114608380294269"), ImageTransparency = 1, LayoutOrder = 1, Position = UDim2.fromScale(0.0135021, 0.0046668), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.7976445, 0.5064102) }, nil, { "PaidRandomItem" })
						I[48] = new("Frame", I[47], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromOffset(22, -20), Size = UDim2.fromOffset(320, 130) })
							I[49] = new("Frame", I[48], "Content", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.0158228), Size = UDim2.fromScale(0.9888143, 0.9113924) })
								I[50] = new("TextLabel", I[49], "Header", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4431794, 0.0195312), Size = UDim2.fromScale(0.635, 0.185), Text = "Gold Treadmill", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
									I[51] = new("UIStroke", I[50], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.06 })
								I[52] = new("TextButton", I[49], "TextButton", { BackgroundColor3 = Color3.fromRGB(124, 255, 42), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4875527, 0.3721495), Size = UDim2.fromOffset(129, 34), Text = "79", TextColor3 = Color3.fromRGB(252, 252, 252), TextSize = 25 })
									I[53] = new("UICorner", I[52], "UICorner")
							I[54] = new("ImageLabel", I[48], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://84222643376823"), Position = UDim2.fromScale(0.0438539, 0.0682684), Size = UDim2.fromOffset(122, 113) })
							I[55] = new("UICorner", I[48], "UICorner")
							I[56] = new("UIStroke", I[48], "UIStroke")
					I[57] = new("ImageLabel", I[16], "LuckyBlock", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://114608380294269"), ImageTransparency = 1, LayoutOrder = 1, Position = UDim2.fromScale(0.0135021, 0.0046668), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.7976445, 0.5064102) }, nil, { "PaidRandomItem" })
						I[58] = new("Frame", I[57], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 85, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromOffset(22, -4), Size = UDim2.fromOffset(320, 118) })
							I[59] = new("Frame", I[58], "Content", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.0158228), Size = UDim2.fromScale(0.9888143, 0.9113924) })
								I[60] = new("TextLabel", I[59], "Header", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4431794, 0.0195312), Size = UDim2.fromScale(0.635, 0.185), Text = "Kitty Treadmill", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
									I[61] = new("UIStroke", I[60], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.06 })
								I[62] = new("TextButton", I[59], "TextButton", { BackgroundColor3 = Color3.fromRGB(124, 255, 42), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5391456, 0.4592483), Size = UDim2.fromOffset(120, 35), Text = "499", TextColor3 = Color3.fromRGB(252, 252, 252), TextSize = 25 })
									I[63] = new("UICorner", I[62], "UICorner")
								I[64] = new("ImageLabel", I[59], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://75551902361314"), Position = UDim2.fromScale(-0.0077389, 0.1123164), Size = UDim2.fromOffset(134, 102) })
							I[65] = new("UICorner", I[58], "UICorner")
							I[66] = new("UIStroke", I[58], "UIStroke")
					I[67] = new("ImageLabel", I[16], "LuckyBlock", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://114608380294269"), ImageTransparency = 1, LayoutOrder = 1, Position = UDim2.fromScale(0.0135021, 0.0046668), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.7976445, 0.5064102) }, nil, { "PaidRandomItem" })
						I[68] = new("Frame", I[67], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 170, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(-0.002, 22, 0.0316055, 0), Size = UDim2.fromOffset(320, 126) })
							I[69] = new("Frame", I[68], "Content", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.0158228), Size = UDim2.fromScale(0.9888143, 0.9113924) })
								I[70] = new("TextLabel", I[69], "Header", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4431794, 0.0195312), Size = UDim2.fromScale(0.635, 0.185), Text = "Candy Treadmill", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
									I[71] = new("UIStroke", I[70], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.06 })
								I[72] = new("TextButton", I[69], "TextButton", { BackgroundColor3 = Color3.fromRGB(124, 255, 42), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5391456, 0.4830025), Size = UDim2.fromOffset(124, 33), Text = "249", TextColor3 = Color3.fromRGB(252, 252, 252), TextSize = 25 })
									I[73] = new("UICorner", I[72], "UICorner")
							I[74] = new("ImageLabel", I[68], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://139264113506039"), Position = UDim2.fromScale(0.0438539, 0.0682684), Size = UDim2.fromOffset(122, 113) })
							I[75] = new("UICorner", I[68], "UICorner")
							I[76] = new("UIStroke", I[68], "UIStroke")
	return I[1]
end

return build
