-- Generated from ui/ReplicatedStorage/Assets/UI/InviteRewards/InviteReward.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "InviteReward", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.1447791), Size = UDim2.fromScale(0.9999999, 0.2895582) })
		I[2] = new("Frame", I[1], "Bg", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 240, 255), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.8860529, 0.5), Size = UDim2.fromScale(0.1778943, 0.9), ZIndex = 2 })
			I[3] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 24, 46)), ColorSequenceKeypoint.new(0.4966667, Color3.fromRGB(25, 25, 47)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 30, 51)), ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 51)) }), Rotation = 90 })
			I[4] = new("UIStroke", I[2], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
		I[5] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 240, 255), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.95, 0.9) })
			I[6] = new("UIStroke", I[5], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
			I[7] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(234, 237, 242)), ColorSequenceKeypoint.new(0.4966667, Color3.fromRGB(212, 221, 230)), ColorSequenceKeypoint.new(0.5133333, Color3.fromRGB(199, 205, 214)), ColorSequenceKeypoint.new(1, Color3.fromRGB(209, 218, 226)) }), Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(1, 0.15) }) })
			I[8] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0, 0), BottomRightRadius = UDim.new(0, 0), TopLeftRadius = UDim.new(0, 0), TopRightRadius = UDim.new(0, 0) })
			I[9] = new("ImageLabel", I[5], "Checkmark", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 255, 0), ImageContent = Content.fromUri("rbxassetid://14292339333"), Position = UDim2.fromScale(0.907, 0.522), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.161, 0.7), Visible = false, ZIndex = 4 })
				I[10] = new("UIScale", I[9], "UIScale", { Scale = 0.75 })
				I[11] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint")
			I[12] = new("TextLabel", I[5], "Number", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7240185, 0.8068756), Size = UDim2.fromScale(0.1054843, 0.2906719), Text = "500", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
				I[13] = new("UIStroke", I[12], "UIStroke", { Thickness = 1.5 })
				I[14] = new("TextLabel", I[12], "Number", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), Text = "500", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 3 })
					I[15] = new("UIStroke", I[14], "UIStroke", { Thickness = 1.5 })
			I[16] = new("ImageLabel", I[5], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14350600707"), Position = UDim2.fromScale(0.7233418, 0.3862583), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.0980677, 0.6440918), ZIndex = 2 })
			I[17] = new("Frame", I[5], "Progress", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(20, 20, 20), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.3207396, 0.6895242), Size = UDim2.fromScale(0.6111544, 0.3941718) })
				I[18] = new("UIStroke", I[17], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
				I[19] = new("TextLabel", I[17], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.8), Text = "0/0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
					I[20] = new("UITextSizeConstraint", I[19], "UITextSizeConstraint", { MaxTextSize = 35 })
					I[21] = new("UIStroke", I[19], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2.1040318 })
				I[22] = new("Frame", I[17], "Main", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 108, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1.0000001, 1) })
					I[23] = new("UIGradient", I[22], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 149, 0)), ColorSequenceKeypoint.new(0.4966667, Color3.fromRGB(255, 150, 56)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(238, 97, 43)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 50, 0)) }), Rotation = 90 })
					I[24] = new("UIStroke", I[22], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
			I[25] = new("TextLabel", I[5], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2534573, 0.2208225), Size = UDim2.fromScale(0.4774179, 0.3), Text = "Invite 1 friend", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 4 })
				I[26] = new("UITextSizeConstraint", I[25], "UITextSizeConstraint", { MaxTextSize = 35 })
				I[27] = new("UIStroke", I[25], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2 })
			I[28] = new("ImageButton", I[5], "InviteBtn", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14457136175"), Position = UDim2.fromScale(0.905176, 0.7623568), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.1611707, 0.4506802), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton", "InviteButton" })
				I[29] = new("TextLabel", I[28], "Number", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(0.8520001, 0.45), Text = "INVITE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
					I[30] = new("UIStroke", I[29], "UIStroke", { Thickness = 1.5 })
			I[31] = new("ImageButton", I[5], "ClaimBtn", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13804213417"), Position = UDim2.fromScale(0.905176, 0.2808541), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.1611707, 0.4506801), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton" })
				I[32] = new("TextLabel", I[31], "Number", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(0.8520001, 0.45), Text = "CLAIM", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
					I[33] = new("UIStroke", I[32], "UIStroke", { Thickness = 1.5 })
	return I[1]
end

return build
