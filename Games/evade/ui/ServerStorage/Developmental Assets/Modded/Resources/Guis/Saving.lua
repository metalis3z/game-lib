-- Generated from ui/ServerStorage/Developmental Assets/Modded/Resources/Guis/Saving.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Saving", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets }, nil, { "ScreenGui", "requiredtag" })
		I[2] = new("Frame", I[1], "Saving", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.4480469, 0.5368568), Visible = false }, nil, { "requiredtag" })
			I[3] = new("ImageLabel", I[2], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://76660575181533"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = -1 }, nil, { "requiredtag" })
				I[4] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(51, 66, 73)), ColorSequenceKeypoint.new(1, Color3.fromRGB(51, 66, 73)) }), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0.3) }) }, nil, { "requiredtag" })
			I[5] = new("Frame", I[2], "Header", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.0012953), Size = UDim2.fromScale(0.9982563, 0.1476684) }, nil, { "requiredtag" })
				I[6] = new("ImageButton", I[5], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://137110183435251"), ImageContent = Content.fromUri("rbxassetid://105016554772347"), Position = UDim2.fromScale(0.9502183, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.0873362, 0.877193) }, nil, { "requiredtag" })
					I[7] = new("ImageButton", I[6], "Saves", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://86947637796850"), ImageContent = Content.fromUri("rbxassetid://79371787677745"), LayoutOrder = 4, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.3015267) }, nil, { "requiredtag" })
						I[8] = new("ImageLabel", I[7], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://18443891611"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.76055, 0.76055), ZIndex = 0 }, nil, { "requiredtag" })
						I[9] = new("TextLabel", I[7], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1, 0.2278481), Text = "Save Game", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, nil, { "requiredtag" })
							I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 2, Transparency = 0.35 }, nil, { "requiredtag" })
					I[11] = new("TextLabel", I[6], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.56), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, nil, { "requiredtag" })
						I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 3 }, nil, { "requiredtag" })
						I[13] = new("UIPadding", I[11], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(-0.03, 0) }, nil, { "requiredtag" })
				I[14] = new("Frame", I[5], "Txts", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0218341, 0.5), Size = UDim2.fromScale(0.5, 1) }, nil, { "requiredtag" })
					I[15] = new("UIListLayout", I[14], "UIListLayout", { Padding = UDim.new(0.0350877, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, nil, { "requiredtag" })
					I[16] = new("TextLabel", I[14], "Txt1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.839039, 0.4999999), Size = UDim2.fromScale(1.6780779, 0.7), Text = "SAVES", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, nil, { "requiredtag" })
						I[17] = new("UIStroke", I[16], "UIStroke", { Thickness = 2 }, nil, { "requiredtag" })
				I[18] = new("ImageLabel", I[5], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(200, 200, 200), ImageContent = Content.fromUri("rbxassetid://137573329562191"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 0 }, nil, { "requiredtag" })
					I[19] = new("UIGradient", I[18], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)) }) }, nil, { "requiredtag" })
			I[20] = new("ImageLabel", I[2], "Outline", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://139489652867400"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.0034873, 1.0051813), Visible = false, ZIndex = 2 }, nil, { "requiredtag" })
				I[21] = new("UIGradient", I[20], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }) }, nil, { "requiredtag" })
			I[22] = new("Frame", I[2], "Content", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.8523316) }, nil, { "requiredtag" })
				I[23] = new("Frame", I[22], "Decoration", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.0015195), Size = UDim2.fromScale(0.9825632, 0.9832829), ZIndex = 0 }, nil, { "requiredtag" })
				I[24] = new("ImageButton", I[22], "Restore", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://100703312924377"), ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://83673098636246"), Position = UDim2.fromScale(0.7611898, 0.7276977), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3257537, 0.1704432), ZIndex = 999 }, nil, { "requiredtag" })
					I[25] = new("TextLabel", I[24], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.4999998), Size = UDim2.fromScale(1, 0.5600001), Text = "RESTORE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 999 }, nil, { "requiredtag" })
						I[26] = new("UIStroke", I[25], "UIStroke", { Thickness = 2 }, nil, { "requiredtag" })
						I[27] = new("UITextSizeConstraint", I[25], "UITextSizeConstraint", { MaxTextSize = 20 }, nil, { "requiredtag" })
				I[28] = new("ImageButton", I[22], "Save", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://100703312924377"), ImageContent = Content.fromUri("rbxassetid://83673098636246"), Position = UDim2.fromScale(0.2389647, 0.7276977), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3257537, 0.1704432), ZIndex = 999 }, nil, { "requiredtag" })
					I[29] = new("TextLabel", I[28], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.4999998), Size = UDim2.fromScale(1, 0.5600001), Text = "SAVE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 999 }, nil, { "requiredtag" })
						I[30] = new("UIStroke", I[29], "UIStroke", { Thickness = 2 }, nil, { "requiredtag" })
						I[31] = new("UITextSizeConstraint", I[29], "UITextSizeConstraint", { MaxTextSize = 20 }, nil, { "requiredtag" })
				I[32] = new("TextLabel", I[22], "Txt1", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.0840298), Size = UDim2.fromScale(0.8, 0.5126489), Text = "Easily save your data which can be restored!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, nil, { "requiredtag" })
					I[33] = new("UIStroke", I[32], "UIStroke", { Thickness = 2 }, nil, { "requiredtag" })
				I[34] = new("TextLabel", I[22], "Txt1", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.2389648, 0.8129193), Size = UDim2.fromScale(0.3257538, 0.0603574), Text = "(once every hour)", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true }, nil, { "requiredtag" })
					I[35] = new("UIStroke", I[34], "UIStroke", { Thickness = 2 }, nil, { "requiredtag" })
				I[36] = new("ImageButton", I[22], "Hide", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://100703312924377"), ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://83673098636246"), Position = UDim2.fromScale(0.4971939, 0.93), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2190706, 0.1007306), ZIndex = 999 }, nil, { "requiredtag" })
					I[37] = new("TextLabel", I[36], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.4999998), Size = UDim2.fromScale(1, 0.5600001), Text = "HIDE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 999 }, nil, { "requiredtag" })
						I[38] = new("UIStroke", I[37], "UIStroke", { Thickness = 2 }, nil, { "requiredtag" })
						I[39] = new("UITextSizeConstraint", I[37], "UITextSizeConstraint", { MaxTextSize = 20 }, nil, { "requiredtag" })
			I[40] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.4857513 }, nil, { "requiredtag" })
	return I[1]
end

return build
