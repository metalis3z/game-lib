-- Generated from ui/ReplicatedStorage/Assets/UI/Clans/Quest.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Quest", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.1204879), Size = UDim2.fromScale(1, 0.2409758) })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 240, 255), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.95, 0.9) })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 0), BottomRightRadius = UDim.new(0, 0), TopLeftRadius = UDim.new(0, 0), TopRightRadius = UDim.new(0, 0) })
			I[4] = new("ImageButton", I[2], "ClaimBtn", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13804213417"), Position = UDim2.fromScale(0.9066717, 0.5222515), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.1611707, 0.6997055), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton" })
				I[5] = new("TextLabel", I[4], "Number", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(0.8520001, 0.45), Text = "CLAIM", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
					I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 1.5 })
			I[7] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(234, 237, 242)), ColorSequenceKeypoint.new(0.4966667, Color3.fromRGB(212, 221, 230)), ColorSequenceKeypoint.new(0.5133333, Color3.fromRGB(199, 205, 214)), ColorSequenceKeypoint.new(1, Color3.fromRGB(209, 218, 226)) }), Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(1, 0.15) }) })
			I[8] = new("UIStroke", I[2], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
			I[9] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(66, 65, 89), Position = UDim2.fromScale(0.055, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1, 0.9), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 2, ZIndex = 3 })
				I[10] = new("ImageLabel", I[9], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://14328304546"), Position = UDim2.fromScale(0.5, 0.525), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.6, 0.6), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 2, ZIndex = 3 })
			I[11] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3776034, 0.1998709), Size = UDim2.fromScale(0.4774179, 0.3), Text = "Kill Players 1,000 times", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 4 })
				I[12] = new("UIStroke", I[11], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2 })
				I[13] = new("UITextSizeConstraint", I[11], "UITextSizeConstraint", { MaxTextSize = 35 })
			I[14] = new("Frame", I[2], "Progress", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(20, 20, 20), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.4052226, 0.7000001), Size = UDim2.fromScale(0.5318282, 0.3941719) })
				I[15] = new("UIStroke", I[14], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
				I[16] = new("Frame", I[14], "Main", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 108, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1.0000001, 1) })
					I[17] = new("UIStroke", I[16], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
					I[18] = new("UIGradient", I[16], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 149, 0)), ColorSequenceKeypoint.new(0.4966667, Color3.fromRGB(255, 150, 56)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(238, 97, 43)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 50, 0)) }), Rotation = 90 })
				I[19] = new("TextLabel", I[14], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.8), Text = "0/0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
					I[20] = new("UIStroke", I[19], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2.1040318 })
					I[21] = new("UITextSizeConstraint", I[19], "UITextSizeConstraint", { MaxTextSize = 35 })
			I[22] = new("ImageLabel", I[2], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14350600707"), Position = UDim2.fromScale(0.7457777, 0.3967342), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.0980677, 0.6440918), ZIndex = 2 })
			I[23] = new("TextLabel", I[2], "Number", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7464546, 0.8173516), Size = UDim2.fromScale(0.1054843, 0.2906719), Text = "500", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
				I[24] = new("UIStroke", I[23], "UIStroke", { Thickness = 1.5 })
				I[25] = new("TextLabel", I[23], "Number", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), Text = "500", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 3 })
					I[26] = new("UIStroke", I[25], "UIStroke", { Thickness = 1.5 })
			I[27] = new("ImageLabel", I[2], "Checkmark", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 255, 0), ImageContent = Content.fromUri("rbxassetid://14292339333"), Position = UDim2.fromScale(0.907, 0.522), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.161, 0.7), Visible = false, ZIndex = 4 })
				I[28] = new("UIAspectRatioConstraint", I[27], "UIAspectRatioConstraint")
				I[29] = new("UIScale", I[27], "UIScale", { Scale = 0.75 })
		I[30] = new("Frame", I[1], "Bg", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 240, 255), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.8860529, 0.5), Size = UDim2.fromScale(0.1778943, 0.9) })
			I[31] = new("UIStroke", I[30], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
			I[32] = new("UIGradient", I[30], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 24, 46)), ColorSequenceKeypoint.new(0.4966667, Color3.fromRGB(25, 25, 47)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 30, 51)), ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 51)) }), Rotation = 90 })
	return I[1]
end

return build
