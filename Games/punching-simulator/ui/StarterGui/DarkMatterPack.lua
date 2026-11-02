-- Generated from ui/StarterGui/DarkMatterPack.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "DarkMatterPack", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "Main", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(39, 0, 108), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6, 0.525), Visible = false, ZIndex = 0 })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.9469727 })
			I[4] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14386546433"), Position = UDim2.fromScale(0.1565389, 0.4441176), Size = UDim2.fromScale(0.2853799, 0.5604701), ZIndex = 2 })
				I[5] = new("ImageLabel", I[4], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(207, 0, 255), ImageContent = Content.fromUri("rbxassetid://8574506083"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.75, 1.75) })
					I[6] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint")
					I[7] = new("UIScale", I[5], "UIScale", { Scale = 0.9 })
				I[8] = new("ImageLabel", I[4], "Effect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://11970619027"), Position = UDim2.fromScale(0.4996798, 0.5), Size = UDim2.fromScale(0.99, 0.715), ZIndex = 2 })
				I[9] = new("ImageLabel", I[4], "Effect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://11970619027"), Position = UDim2.fromScale(0.4996798, 0.5), Size = UDim2.fromScale(0.99, 0.715), ZIndex = 2 })
			I[10] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1572572, 0.9072409), Size = UDim2.fromScale(0.2841454, 0.1664552), Text = "DARK MATTER POWER", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
				I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 3 })
			I[12] = new("UIStroke", I[2], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5 })
			I[13] = new("ImageButton", I[2], "Dark_Matter_Pack", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 255, 0), ImageContent = Content.fromUri("rbxassetid://13651868063"), Position = UDim2.fromScale(0.635, 0.9), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.475, 0.189), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton", "ProductButton" })
				I[14] = new("TextLabel", I[13], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.35, 0.5499994), Size = UDim2.fromScale(0.6256413, 0.8), Text = "BUY 395", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 4 })
					I[15] = new("UIStroke", I[14], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2 })
				I[16] = new("Frame", I[13], "Effect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.9), ZIndex = 2 })
					I[17] = new("UICorner", I[16], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
					I[18] = new("UIGradient", I[16], "UIGradient", { Offset = Vector2.new(-1, 0), Rotation = 30, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.38, 1), NumberSequenceKeypoint.new(0.4, 0.3), NumberSequenceKeypoint.new(0.6, 0.3), NumberSequenceKeypoint.new(0.62, 1), NumberSequenceKeypoint.new(1, 1) }) })
					I[19] = new("TextLabel", I[16], "BtnText", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8316983, 0.45), Size = UDim2.fromScale(0.2459909, 0.680561), Text = "9,000", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
						I[20] = new("Frame", I[19], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 0, 4), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.4720245), Rotation = -5, Size = UDim2.fromScale(1.1, 0.075), ZIndex = 2 })
				I[21] = new("TextLabel", I[13], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4999999, -0.25), Size = UDim2.fromScale(1, 0.4), Text = "💪 BECOME THE STRONGEST 💪", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
					I[22] = new("UIStroke", I[21], "UIStroke", { Thickness = 3 })
			I[23] = new("ImageButton", I[2], "DarkMatterPack", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(96, 53, 255), ImageContent = Content.fromUri("rbxassetid://13651868063"), Position = UDim2.fromScale(0.9076594, 0.0748253), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.1653323, 0.1212167), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "ProductButton", "UICloseButton" })
				I[24] = new("TextLabel", I[23], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromScale(0.789304, 0.7016041), Text = "CLOSE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
					I[25] = new("UIStroke", I[24], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2 })
			I[26] = new("Frame", I[2], "Top", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.4050225, 0.0473147), Size = UDim2.fromScale(0.8100452, 0.0946295) })
				I[27] = new("UIStroke", I[26], "UIStroke", { Thickness = 4 })
				I[28] = new("UIGradient", I[26], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(192, 0, 245)), ColorSequenceKeypoint.new(1, Color3.fromRGB(156, 0, 243)) }), Rotation = 90 })
			I[29] = new("TextLabel", I[2], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.055), Size = UDim2.fromScale(0.8, 0.06), Text = "DARK MATTER PACK", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
				I[30] = new("UIStroke", I[29], "UIStroke", { Thickness = 2 })
				I[31] = new("TextLabel", I[29], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), Text = "DARK MATTER PACK", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
					I[32] = new("UIStroke", I[31], "UIStroke", { Thickness = 2 })
			I[33] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 50, 0), ImageContent = Content.fromUri("rbxassetid://14386753041"), Position = UDim2.fromScale(0.1194905, 0.0356054), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.265951, 0.1240797), SliceCenter = Rect.new(23, 29, 27, 41), SliceScale = 0.5, ZIndex = 4 })
				I[34] = new("TextLabel", I[33], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.804852, 0.69243), Text = "SAVE 98%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
					I[35] = new("UIStroke", I[34], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 1.5 })
			I[36] = new("Frame", I[2], "Products", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.6583126, 0.4415502), Size = UDim2.fromScale(0.6317976, 0.1524516) })
				I[37] = new("UIListLayout", I[36], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[38] = new("TextLabel", I[36], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 4, Position = UDim2.fromScale(0.8446702, 0.4999999), Size = UDim2.fromScale(0.075, 0.95), Text = "+", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
					I[39] = new("UIStroke", I[38], "UIStroke", { Thickness = 2 })
				I[40] = new("ImageLabel", I[36], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 7, Position = UDim2.fromScale(0.2486241, 0.4227598), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1655236, 1.1544802) })
					I[41] = new("ImageLabel", I[40], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14388970910"), LayoutOrder = 5, Position = UDim2.fromScale(0.5000015, 0.4970656), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.3871193, 1.2067981) })
					I[42] = new("TextLabel", I[40], "TextLabel", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000001, 1.3166384), Size = UDim2.fromScale(0.95, 0.3), Text = "+5M", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
						I[43] = new("UIStroke", I[42], "UIStroke", { Thickness = 2 })
				I[44] = new("ImageLabel", I[36], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 5, Position = UDim2.fromScale(0.2486241, 0.4227598), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1655236, 1.1544802) })
					I[45] = new("TextLabel", I[44], "TextLabel", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000001, 1.3166384), Size = UDim2.fromScale(0.95, 0.3), Text = "+999B", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
						I[46] = new("UIStroke", I[45], "UIStroke", { Thickness = 2 })
					I[47] = new("ImageLabel", I[44], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14263763337"), LayoutOrder = 5, Position = UDim2.fromScale(0.5000015, 0.4069048), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.3871193, 1.3871193) })
				I[48] = new("TextLabel", I[36], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 6, Position = UDim2.fromScale(0.8446702, 0.4999999), Size = UDim2.fromScale(0.075, 0.95), Text = "+", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
					I[49] = new("UIStroke", I[48], "UIStroke", { Thickness = 2 })
				I[50] = new("ImageLabel", I[36], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14352328410"), LayoutOrder = 2, Position = UDim2.fromScale(0.9429227, 0.8272197), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2, 1.4) })
					I[51] = new("Frame", I[50], "Effect", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.fromScale(1, 1) })
						I[52] = new("UIGradient", I[51], "UIGradient", { Offset = Vector2.new(-1, 0), Rotation = 30, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.38, 1), NumberSequenceKeypoint.new(0.4, 0.3), NumberSequenceKeypoint.new(0.6, 0.3), NumberSequenceKeypoint.new(0.62, 1), NumberSequenceKeypoint.new(1, 1) }) })
						I[53] = new("TextLabel", I[51], "TextLabel", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.2837186), Size = UDim2.fromScale(0.95, 0.3), Text = "OP!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 2 })
							I[54] = new("UIStroke", I[53], "UIStroke", { Thickness = 2 })
						I[55] = new("TextLabel", I[51], "TextLabel", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.521417, 1.1454173), Size = UDim2.fromScale(0.9500001, 0.2663485), Text = "x165", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
							I[56] = new("UIStroke", I[55], "UIStroke", { Thickness = 2 })
			I[57] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6323564, 0.2413835), Size = UDim2.fromScale(0.4427528, 0.0861125), Text = "✨ FREE BONUS ✨", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
				I[58] = new("UIStroke", I[57], "UIStroke", { Thickness = 3 })
			I[59] = new("Frame", I[2], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(27, 1, 83), BorderSizePixel = 0, Position = UDim2.fromScale(0.6253952, 0.4470971), Size = UDim2.fromScale(0.6, 0.288), ZIndex = 0 })
			I[60] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13859487181"), Position = UDim2.fromScale(0.2945657, 0.6995171), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1074269, 0.3045675), ZIndex = 4 })
	return I[1]
end

return build
