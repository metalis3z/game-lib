-- Generated from ui/StarterGui/Season.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Season", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(132, 40, 246), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6, 0.525), Visible = false, ZIndex = 0 })
			I[3] = new("ImageButton", I[2], "Season", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("rbxassetid://12489985753"), ImageTransparency = 1, Position = UDim2.fromScale(0.9954257, 0.0446514), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.1000238, 0.1750417), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 2, ZIndex = 6 }, nil, { "PopButton", "UIToggleButton" })
				I[4] = new("UIPadding", I[3], "UIPadding", { PaddingBottom = UDim.new(-0.05, 0) })
				I[5] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[6] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.64, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(188, 4, 0)) }), Rotation = 90 })
				I[7] = new("UIStroke", I[3], "UIStroke", { Thickness = 3 })
				I[8] = new("ImageLabel", I[3], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13704067744"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.55, 0.55), ZIndex = 6 })
				I[9] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint")
			I[10] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.9469727 })
			I[11] = new("TextLabel", I[2], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.0550782), RichText = true, Size = UDim2.fromScale(0.8, 0.07), Text = "<stroke color= \"rgb(0, 0, 0)\" joins=\"round\" thickness=\"2\" transparency=\"0\">Season ends in <font color= \"rgb(0, 255, 0)\">00d 00h 00m 00s</font> </stroke>", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 2 })
			I[13] = new("UIStroke", I[2], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5 })
			I[14] = new("Frame", I[2], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(104, 42, 160), Position = UDim2.fromScale(0.5, 0.05), Size = UDim2.fromScale(0.4228998, 0.0694323) })
				I[15] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[16] = new("ImageLabel", I[2], "PremiumIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14290584744"), Position = UDim2.fromScale(0.0949318, 0.2615196), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.125, 0.25), ZIndex = 4 })
				I[17] = new("TextLabel", I[16], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5072061, 1.0567269), Size = UDim2.fromScale(1.4, 0.225), Text = "PREMIUM!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
					I[18] = new("UIStroke", I[17], "UIStroke", { Thickness = 2 })
				I[19] = new("ImageLabel", I[16], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://8574506083"), Position = UDim2.fromScale(0.5, 0.45), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.75, 1.75), ZIndex = 2 })
					I[20] = new("UIAspectRatioConstraint", I[19], "UIAspectRatioConstraint")
					I[21] = new("UIScale", I[19], "UIScale", { Scale = 0.9 })
					I[22] = new("UIGradient", I[19], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 197, 147)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 197, 147)) }), Rotation = 90 })
			I[23] = new("ImageLabel", I[2], "FreeIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14290583117"), Position = UDim2.fromScale(0.0949318, 0.7519853), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.125, 0.25), ZIndex = 4 })
				I[24] = new("TextLabel", I[23], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5072058, 1.087244), Size = UDim2.fromScale(0.75, 0.225), Text = "FREE!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
					I[25] = new("UIStroke", I[24], "UIStroke", { Thickness = 2 })
			I[26] = new("Frame", I[2], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.0948972, 0.3350457), Size = UDim2.fromScale(0.19, 0.441), ZIndex = 0 })
				I[27] = new("UIGradient", I[26], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(210, 0, 255)), ColorSequenceKeypoint.new(0.3833334, Color3.fromRGB(230, 103, 240)), ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 0, 255)) }), Rotation = 90 })
				I[28] = new("UIStroke", I[26], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 4 })
			I[29] = new("Frame", I[2], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.0948972, 0.7769457), Size = UDim2.fromScale(0.19, 0.4410262), ZIndex = 0 })
				I[30] = new("UIGradient", I[29], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(104, 0, 255)), ColorSequenceKeypoint.new(0.3833334, Color3.fromRGB(136, 38, 238)), ColorSequenceKeypoint.new(1, Color3.fromRGB(102, 0, 239)) }), Rotation = 90 })
				I[31] = new("UIStroke", I[29], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 4 })
			I[32] = new("Frame", I[2], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.0572073), Size = UDim2.fromScale(1.0000001, 0.1144146) })
				I[33] = new("UIStroke", I[32], "UIStroke", { Thickness = 4 })
				I[34] = new("UIGradient", I[32], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(234, 248, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 144, 0)) }), Rotation = 90 })
			I[35] = new("Frame", I[2], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(157, 147, 238), Position = UDim2.fromScale(0.5989812, 0.3350457), Size = UDim2.fromScale(0.8020377, 0.441), ZIndex = 0 })
				I[36] = new("UIGradient", I[35], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(210, 0, 255)), ColorSequenceKeypoint.new(0.3833334, Color3.fromRGB(230, 103, 240)), ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 0, 255)) }), Rotation = 90 })
				I[37] = new("UIStroke", I[35], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 4 })
				I[38] = new("UIPadding", I[35], "UIPadding", { PaddingLeft = UDim.new(0.01, 0) })
			I[39] = new("Frame", I[2], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(157, 147, 238), Position = UDim2.fromScale(0.5989812, 0.7769456), Size = UDim2.fromScale(0.8020375, 0.4410263), ZIndex = 0 })
				I[40] = new("UIGradient", I[39], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(104, 0, 255)), ColorSequenceKeypoint.new(0.3833334, Color3.fromRGB(136, 38, 238)), ColorSequenceKeypoint.new(1, Color3.fromRGB(102, 0, 239)) }), Rotation = 90 })
				I[41] = new("UIStroke", I[39], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 4 })
			I[42] = new("Frame", I[2], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(157, 147, 238), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5989811, 0.5591999), Size = UDim2.fromScale(0.8020375, 0.8765175), ZIndex = 0 })
				I[43] = new("UIGradient", I[42], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(104, 0, 255)), ColorSequenceKeypoint.new(0.3833334, Color3.fromRGB(136, 38, 238)), ColorSequenceKeypoint.new(1, Color3.fromRGB(102, 0, 239)) }), Rotation = 90 })
				I[44] = new("ScrollingFrame", I[42], "Container", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(157, 147, 238), BackgroundTransparency = 1, BorderSizePixel = 0, BottomImageContent = Content.fromUri("rbxasset://textures/ui/Scroll/scroll-middle.png"), CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromScale(0.5, 0.5), ScrollBarThickness = 5, Selectable = false, Size = UDim2.fromScale(1, 1), TopImageContent = Content.fromUri("rbxasset://textures/ui/Scroll/scroll-middle.png"), ZIndex = 0 })
					I[45] = new("UIListLayout", I[44], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.02, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[46] = new("UIPadding", I[42], "UIPadding", { PaddingLeft = UDim.new(0.01, 0) })
			I[47] = new("ImageButton", I[2], "Season_Premium", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(51, 226, 0), ImageContent = Content.fromUri("rbxassetid://13651868063"), Position = UDim2.fromScale(0.0947753, 0.4875514), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.175, 0.1), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton", "ProductButton" })
				I[48] = new("TextLabel", I[47], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(0.9, 0.5), Text = "ACTIVATE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
					I[49] = new("UIStroke", I[48], "UIStroke", { Thickness = 1.5 })
				I[50] = new("Frame", I[47], "Effect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
					I[51] = new("UICorner", I[50], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
					I[52] = new("UIGradient", I[50], "UIGradient", { Offset = Vector2.new(-1, 0), Rotation = 30, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.38, 1), NumberSequenceKeypoint.new(0.4, 0.3), NumberSequenceKeypoint.new(0.6, 0.3), NumberSequenceKeypoint.new(0.62, 1), NumberSequenceKeypoint.new(1, 1) }) })
			I[53] = new("ImageButton", I[2], "PremiumRequired", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.4, BorderSizePixel = 0, Position = UDim2.fromScale(0.6, 0.335), Selectable = false, Size = UDim2.fromScale(0.81, 0.425), ZIndex = 5 })
				I[54] = new("TextLabel", I[53], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.45), RichText = true, Size = UDim2.fromScale(0.9000001, 0.5815558), Text = "<stroke color= \"rgb(0, 0, 0)\" joins=\"round\" thickness=\"2\" transparency=\"0\">Activate <font color= \"rgb(255, 255, 0)\">PREMIUM</font> to unlock more rewards! </stroke>", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
					I[55] = new("NumberValue", I[54], "T")
			I[56] = new("Frame", I[2], "Bottom", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(163, 163, 163), Position = UDim2.fromScale(0.5, 1.1), Size = UDim2.fromScale(0.8, 0.148), ZIndex = -1 })
				I[57] = new("UIStroke", I[56], "UIStroke", { Thickness = 4 })
				I[58] = new("UIGradient", I[56], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(104, 0, 255)), ColorSequenceKeypoint.new(0.3833334, Color3.fromRGB(136, 38, 238)), ColorSequenceKeypoint.new(1, Color3.fromRGB(102, 0, 239)) }), Rotation = 90 })
				I[59] = new("UICorner", I[56], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
				I[60] = new("ImageButton", I[56], "Season_Unlock_All_Tiers", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(51, 226, 0), ImageContent = Content.fromUri("rbxassetid://13651868063"), LayoutOrder = 4, Position = UDim2.fromScale(0.8653324, 0.5000003), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.27, 0.741), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton", "ProductButton" })
					I[61] = new("TextLabel", I[60], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(0.9, 0.5), Text = "UNLOCK ALL", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
						I[62] = new("UIStroke", I[61], "UIStroke", { Thickness = 1.5 })
				I[63] = new("ImageLabel", I[56], "ProgressBar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://12445578494"), LayoutOrder = 2, Position = UDim2.fromScale(0.3783239, 0.4999998), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.5664313, 0.7407686), SliceCenter = Rect.new(50, 47, 50, 47), ZIndex = 0 })
					I[64] = new("ImageLabel", I[63], "Progress", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13549999963"), Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.164, 1), SliceCenter = Rect.new(50, 47, 50, 47) })
						I[65] = new("UIGradient", I[64], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.0011601, 0), NumberSequenceKeypoint.new(0.0023202, 1), NumberSequenceKeypoint.new(0.4709977, 1), NumberSequenceKeypoint.new(1, 1) }) })
					I[66] = new("TextLabel", I[63], "ProgressText", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.6), Text = "MAX TIER", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
						I[67] = new("UIStroke", I[66], "UIStroke", { Color = Color3.fromRGB(40, 40, 40), Thickness = 2 })
						I[68] = new("UITextSizeConstraint", I[66], "UITextSizeConstraint", { MaxTextSize = 39 })
					I[69] = new("ImageLabel", I[63], "Current", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(93, 89, 134), ImageContent = Content.fromUri("rbxassetid://14291113184"), LayoutOrder = 3, Position = UDim2.fromScale(0.0198529, 0.4999986), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1570599, 1.2551444), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 2, ZIndex = 7 })
						I[70] = new("UIPadding", I[69], "UIPadding", { PaddingBottom = UDim.new(-0.05, 0) })
						I[71] = new("UIAspectRatioConstraint", I[69], "UIAspectRatioConstraint")
						I[72] = new("TextLabel", I[69], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.575), Size = UDim2.fromScale(1, 0.6), Text = "1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 8 })
							I[73] = new("UIStroke", I[72], "UIStroke", { Thickness = 3.0999999 })
							I[74] = new("UIScale", I[72], "UIScale")
					I[75] = new("ImageLabel", I[63], "Next", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(93, 89, 134), ImageContent = Content.fromUri("rbxassetid://14291113184"), LayoutOrder = 3, Position = UDim2.fromScale(0.98, 0.4999986), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1570599, 1.2551444), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 2, ZIndex = 7 })
						I[76] = new("UIPadding", I[75], "UIPadding", { PaddingBottom = UDim.new(-0.05, 0) })
						I[77] = new("UIAspectRatioConstraint", I[75], "UIAspectRatioConstraint")
						I[78] = new("TextLabel", I[75], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.575), Size = UDim2.fromScale(1, 0.6), Text = "2", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 8 })
							I[79] = new("UIStroke", I[78], "UIStroke", { Thickness = 3.0999999 })
							I[80] = new("UIScale", I[78], "UIScale")
				I[81] = new("UIListLayout", I[56], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
	return I[1]
end

return build
