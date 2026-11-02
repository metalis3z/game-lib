-- Generated from ui/StarterGui/Odds_UI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Odds_UI", { Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["bruh"] = false })
		I[2] = new("ImageLabel", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.55, 0.55) })
			I[3] = new("ImageLabel", I[2], "Main", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.45, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
				I[4] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0.08, 0), BottomRightRadius = UDim.new(0.08, 0), TopLeftRadius = UDim.new(0.08, 0), TopRightRadius = UDim.new(0.08, 0) })
					I[5] = new("Frame", I[4], "PaddingPadding", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 10000, Position = UDim2.fromScale(0, 0.2853938), Size = UDim2.fromScale(0.002, 1) })
						I[6] = new("UIListLayout", I[5], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.02, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
					I[7] = new("Frame", I[4], "PaddingStart", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -10000, Position = UDim2.fromScale(0, 0.2853938), Size = UDim2.fromScale(0.002, 1) })
					I[8] = new("UIGridLayout", I[4], "UIGridLayout", { CellSize = UDim2.fromScale(0.22, 0.5), FillDirection = Enum.FillDirection.Vertical })
				I[9] = new("Frame", I[3], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(26, 26, 26), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5730099), Size = UDim2.fromScale(0.965, 0.7789801), ZIndex = 3 })
					I[10] = new("ScrollingFrame", I[9], "Items", { Active = true, AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), ClipsDescendants = false, Position = UDim2.fromScale(0, 0.024187), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 0, Size = UDim2.fromScale(1, 0.9758129) })
						I[11] = new("UIGridLayout", I[10], "UIListLayout", { CellPadding = UDim2.fromScale(0.01, 0.02), CellSize = UDim2.fromScale(0.1804719, 0.3849432), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
							I[12] = new("UIAspectRatioConstraint", I[11], "UIAspectRatioConstraint")
							I[13] = new("ImageLabel", I[11], "TemplateRainbow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(58, 58, 58), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 4, Position = UDim2.fromScale(0.1044458, 0.4999999), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2198675, 0.8558772) })
								I[14] = new("ImageLabel", I[13], "Vector", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.8, 0.8) })
								I[15] = new("TextLabel", I[13], "Odds", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4971521, 0.8451858), Size = UDim2.fromScale(0.821176, 0.1944831), Text = "25%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 15 })
									I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 2, Transparency = 0.4 })
								I[17] = new("TextLabel", I[13], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000001, 0.1488914), Size = UDim2.fromScale(0.827766, 0.1960438), Text = "Basic Sack2", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 15 })
									I[18] = new("UIStroke", I[17], "UIStroke", { Thickness = 2, Transparency = 0.4 })
								I[19] = new("ImageLabel", I[13], "TwoItemIcons", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5085669, 0.4999999), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.8671338, 0.7463596), Visible = false })
									I[20] = new("UIAspectRatioConstraint", I[19], "UIAspectRatioConstraint")
									I[21] = new("ImageLabel", I[19], "Gun", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageContent = Content.fromUri("rbxassetid://76545604145544"), Position = UDim2.fromScale(0.6982104, 0.5153217), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.6, 0.6) })
										I[22] = new("UIAspectRatioConstraint", I[21], "UIAspectRatioConstraint")
										I[23] = new("UIScale", I[21], "UIScale")
									I[24] = new("ImageLabel", I[19], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.4954929, 0.538), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3, 0.3), Visible = false })
										I[25] = new("UIAspectRatioConstraint", I[24], "UIAspectRatioConstraint")
									I[26] = new("ImageLabel", I[19], "Knife", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageContent = Content.fromUri("rbxassetid://118873900274244"), Position = UDim2.fromScale(0.2568398, 0.5337623), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.6, 0.6) })
										I[27] = new("UIAspectRatioConstraint", I[26], "UIAspectRatioConstraint")
										I[28] = new("UIScale", I[26], "UIScale")
									I[29] = new("UIScale", I[19], "UIScale")
								I[30] = new("UICorner", I[13], "UICorner")
								I[31] = new("UIStroke", I[13], "UIStroke", { Color = Color3.fromRGB(35, 35, 35), Thickness = 2.9000001 })
								I[32] = new("UIGradient", I[13], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.617207, 0.18125), NumberSequenceKeypoint.new(1, 1) }) })
							I[33] = new("ImageLabel", I[11], "TemplateSmaller", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(58, 58, 58), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 4, Position = UDim2.fromScale(0.1044458, 0.4999999), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2198675, 0.8558772) })
								I[34] = new("ImageLabel", I[33], "Vector", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.8, 0.8) })
								I[35] = new("TextLabel", I[33], "Odds", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4971521, 0.8451858), Size = UDim2.fromScale(0.821176, 0.1944831), Text = "25%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 15 })
									I[36] = new("UIStroke", I[35], "UIStroke", { Thickness = 2, Transparency = 0.4 })
								I[37] = new("TextLabel", I[33], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000001, 0.1488914), Size = UDim2.fromScale(0.827766, 0.1960438), Text = "Basic Sack2", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 15 })
									I[38] = new("UIStroke", I[37], "UIStroke", { Thickness = 2, Transparency = 0.4 })
								I[39] = new("ImageLabel", I[33], "TwoItemIcons", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5085669, 0.4999999), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.8671338, 0.7463596), Visible = false })
									I[40] = new("UIAspectRatioConstraint", I[39], "UIAspectRatioConstraint")
									I[41] = new("ImageLabel", I[39], "Gun", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageContent = Content.fromUri("rbxassetid://76545604145544"), Position = UDim2.fromScale(0.6982104, 0.5153217), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.6, 0.6) })
										I[42] = new("UIAspectRatioConstraint", I[41], "UIAspectRatioConstraint")
										I[43] = new("UIScale", I[41], "UIScale")
									I[44] = new("ImageLabel", I[39], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.4954929, 0.538), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3, 0.3), Visible = false })
										I[45] = new("UIAspectRatioConstraint", I[44], "UIAspectRatioConstraint")
									I[46] = new("ImageLabel", I[39], "Knife", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageContent = Content.fromUri("rbxassetid://118873900274244"), Position = UDim2.fromScale(0.2568398, 0.5337623), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.6, 0.6) })
										I[47] = new("UIAspectRatioConstraint", I[46], "UIAspectRatioConstraint")
										I[48] = new("UIScale", I[46], "UIScale")
									I[49] = new("UIScale", I[39], "UIScale")
								I[50] = new("UICorner", I[33], "UICorner")
								I[51] = new("UIStroke", I[33], "UIStroke", { Color = Color3.fromRGB(35, 35, 35), Thickness = 2.9000001 })
								I[52] = new("UIGradient", I[33], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.617207, 0.18125), NumberSequenceKeypoint.new(1, 1) }) })
							I[53] = new("ImageLabel", I[11], "TemplateBigger", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(58, 58, 58), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 4, Position = UDim2.fromScale(0.1044458, 0.4999999), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2198675, 0.8558772) })
								I[54] = new("ImageLabel", I[53], "Vector", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.8, 0.8) })
								I[55] = new("TextLabel", I[53], "Odds", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4971521, 0.8451858), Size = UDim2.fromScale(0.821176, 0.1944831), Text = "25%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 15 })
									I[56] = new("UIStroke", I[55], "UIStroke", { Thickness = 2, Transparency = 0.4 })
								I[57] = new("TextLabel", I[53], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000001, 0.1488914), Size = UDim2.fromScale(0.827766, 0.1960438), Text = "Basic Sack2", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 15 })
									I[58] = new("UIStroke", I[57], "UIStroke", { Thickness = 2, Transparency = 0.4 })
								I[59] = new("ImageLabel", I[53], "TwoItemIcons", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5085669, 0.4999999), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.8671338, 0.7463596), Visible = false })
									I[60] = new("UIAspectRatioConstraint", I[59], "UIAspectRatioConstraint")
									I[61] = new("ImageLabel", I[59], "Gun", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageContent = Content.fromUri("rbxassetid://76545604145544"), Position = UDim2.fromScale(0.6982104, 0.5153217), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.6, 0.6) })
										I[62] = new("UIAspectRatioConstraint", I[61], "UIAspectRatioConstraint")
										I[63] = new("UIScale", I[61], "UIScale")
									I[64] = new("ImageLabel", I[59], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.4954929, 0.538), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3, 0.3), Visible = false })
										I[65] = new("UIAspectRatioConstraint", I[64], "UIAspectRatioConstraint")
									I[66] = new("ImageLabel", I[59], "Knife", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageContent = Content.fromUri("rbxassetid://118873900274244"), Position = UDim2.fromScale(0.2568398, 0.5337623), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.6, 0.6) })
										I[67] = new("UIAspectRatioConstraint", I[66], "UIAspectRatioConstraint")
										I[68] = new("UIScale", I[66], "UIScale")
									I[69] = new("UIScale", I[59], "UIScale")
								I[70] = new("UICorner", I[53], "UICorner")
								I[71] = new("UIStroke", I[53], "UIStroke", { Color = Color3.fromRGB(35, 35, 35), Thickness = 2.9000001 })
								I[72] = new("UIGradient", I[53], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.617207, 0.18125), NumberSequenceKeypoint.new(1, 1) }) })
			I[73] = new("ImageButton", I[2], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.945587, 0.0882242), Selectable = false, Size = UDim2.fromScale(0.0559386, 0.1060825), ZIndex = 5 })
				I[74] = new("TextLabel", I[73], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 15 })
					I[75] = new("UIStroke", I[74], "UIStroke", { Thickness = 2 })
				I[76] = new("ImageLabel", I[73], "DropShadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 4), ImageContent = Content.fromUri("rbxassetid://96735047582734"), ImageTransparency = 0.8, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1.5088595, 1.7296873), SliceCenter = Rect.new(256, 256, 256, 256), SliceScale = 0.4, ZIndex = 12 })
				I[77] = new("UIAspectRatioConstraint", I[73], "UIAspectRatioConstraint", { AspectRatio = 1.1441339 })
				I[78] = new("ImageLabel", I[73], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://73214197551985"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Selectable = true, Size = UDim2.fromScale(1.1349496, 1.3059219), SliceCenter = Rect.new(64, 64, 64, 64), SliceScale = 0.2, ZIndex = 13 })
					I[79] = new("UIGradient", I[78], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 9, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(210, 0, 8)) }), Rotation = 90 })
			I[80] = new("Frame", I[2], "Header", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.0012953), Size = UDim2.fromScale(0.9982565, 0.1664023) })
				I[81] = new("Frame", I[80], "Txts", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0218341, 0.5), Size = UDim2.fromScale(0.5, 1) })
					I[82] = new("TextLabel", I[81], "Txt1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.4545856, 0.4853389), Size = UDim2.fromScale(0.9, 0.649), Text = "CHANCES!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[83] = new("UIStroke", I[82], "UIStroke", { Thickness = 2.5185184 }, { ["OriginalThickness"] = 2 })
				I[84] = new("CanvasGroup", I[80], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.7995195), Size = UDim2.fromScale(1.0017468, 1.6121733), ZIndex = 0 })
					I[85] = new("UIGradient", I[84], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(66, 66, 66)), ColorSequenceKeypoint.new(1, Color3.fromRGB(66, 66, 66)) }), Enabled = false })
					I[86] = new("UICorner", I[84], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
					I[87] = new("Frame", I[84], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.2359769), Size = UDim2.fromScale(1.0000001, 0.7861948) })
			I[88] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.6010362 })
	return I[1]
end

return build
