-- Generated from ui/StarterGui/RainbowEggs.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "RainbowEggs", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "Main", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6, 0.525), Visible = false, ZIndex = 0 })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.9469727 })
			I[4] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14474281804"), Position = UDim2.fromScale(0.1565389, 0.4441176), Size = UDim2.fromScale(0.2853799, 0.5604701), ZIndex = 2 })
				I[5] = new("ImageLabel", I[4], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(207, 0, 255), ImageContent = Content.fromUri("rbxassetid://8574506083"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.75, 1.75) })
					I[6] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint")
					I[7] = new("UIScale", I[5], "UIScale", { Scale = 0.9 })
			I[8] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1572572, 0.9072409), Size = UDim2.fromScale(0.2841454, 0.1664552), Text = "RAINBOW EGGS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
				I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 3 })
			I[10] = new("UIStroke", I[2], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5 })
			I[11] = new("ImageButton", I[2], "Rainbow_Eggs", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 255, 0), ImageContent = Content.fromUri("rbxassetid://13651868063"), Position = UDim2.fromScale(0.635, 0.9), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.475, 0.189), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton", "GamepassButton" })
				I[12] = new("TextLabel", I[11], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.35, 0.5499994), Size = UDim2.fromScale(0.6256413, 0.8), Text = "BUY 1,295", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 4 })
					I[13] = new("UIStroke", I[12], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2 })
				I[14] = new("Frame", I[11], "Effect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.9), ZIndex = 2 })
					I[15] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
					I[16] = new("UIGradient", I[14], "UIGradient", { Offset = Vector2.new(-1, 0), Rotation = 30, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.38, 1), NumberSequenceKeypoint.new(0.4, 0.3), NumberSequenceKeypoint.new(0.6, 0.3), NumberSequenceKeypoint.new(0.62, 1), NumberSequenceKeypoint.new(1, 1) }) })
					I[17] = new("TextLabel", I[14], "BtnText", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.843776, 0.4500002), Size = UDim2.fromScale(0.2765743, 0.6805609), Text = "17,000", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
						I[18] = new("Frame", I[17], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 0, 4), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.4720245), Rotation = -5, Size = UDim2.fromScale(1.1, 0.075), ZIndex = 2 })
				I[19] = new("TextLabel", I[11], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4999999, -0.25), Size = UDim2.fromScale(1, 0.4), Text = "💪 BECOME VERY OP 💪", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
					I[20] = new("UIStroke", I[19], "UIStroke", { Thickness = 3 })
			I[21] = new("ImageButton", I[2], "RainbowEggs", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 170, 255), ImageContent = Content.fromUri("rbxassetid://13651868063"), Position = UDim2.fromScale(0.9076594, 0.0748253), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.1653323, 0.1212167), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "ProductButton", "UICloseButton" })
				I[22] = new("TextLabel", I[21], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromScale(0.789304, 0.7016041), Text = "CLOSE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
					I[23] = new("UIStroke", I[22], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2 })
			I[24] = new("Frame", I[2], "Top", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.4050225, 0.0473147), Size = UDim2.fromScale(0.8100452, 0.0946295) })
				I[25] = new("UIStroke", I[24], "UIStroke", { Thickness = 4 })
				I[26] = new("UIGradient", I[24], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(192, 0, 245)), ColorSequenceKeypoint.new(1, Color3.fromRGB(156, 0, 243)) }), Rotation = 90 })
			I[27] = new("TextLabel", I[2], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.055), Size = UDim2.fromScale(0.8, 0.06), Text = "RAINBOW EGGS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
				I[28] = new("UIStroke", I[27], "UIStroke", { Thickness = 2 })
				I[29] = new("TextLabel", I[27], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), Text = "RAINBOW EGGS", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
					I[30] = new("UIStroke", I[29], "UIStroke", { Thickness = 2 })
			I[31] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 164, 0), ImageContent = Content.fromUri("rbxassetid://14386753041"), Position = UDim2.fromScale(0.1194905, 0.0356054), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.265951, 0.1240797), SliceCenter = Rect.new(23, 29, 27, 41), SliceScale = 0.5, ZIndex = 4 })
				I[32] = new("TextLabel", I[31], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4765651, 0.5000001), Size = UDim2.fromScale(0.8517218, 0.69243), Text = "BECOME OP!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
					I[33] = new("UIStroke", I[32], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 1.5 })
			I[34] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6376966, 0.438341), Size = UDim2.fromScale(0.4944749, 0.4040926), Text = "GET RAINBOW PETS EVERY TIME YOU OPEN AN EGG", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
				I[35] = new("UIStroke", I[34], "UIStroke", { Thickness = 3 })
			I[36] = new("Frame", I[2], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.2, BorderSizePixel = 0, Position = UDim2.fromScale(0.6380466, 0.4288957), Size = UDim2.fromScale(0.5278952, 0.3467192), ZIndex = 0 })
				I[37] = new("UICorner", I[36], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
			I[38] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13859487181"), Position = UDim2.fromScale(0.2945657, 0.6995171), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1074269, 0.3045675), ZIndex = 4 })
			I[39] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 99, 255)), ColorSequenceKeypoint.new(0.205, Color3.fromRGB(11, 237, 0)), ColorSequenceKeypoint.new(0.4533333, Color3.fromRGB(130, 255, 0)), ColorSequenceKeypoint.new(0.6583334, Color3.fromRGB(249, 255, 0)), ColorSequenceKeypoint.new(0.8416667, Color3.fromRGB(237, 121, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 31, 0)) }) })
	return I[1]
end

return build
