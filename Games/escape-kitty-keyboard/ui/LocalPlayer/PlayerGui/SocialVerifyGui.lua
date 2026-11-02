-- Generated from ui/LocalPlayer/PlayerGui/SocialVerifyGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "SocialVerifyGui", { Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, nil, { "SocialVerifyGui" })
		I[2] = new("ImageLabel", I[1], "Panel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(35, 39, 42), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://6927295847"), ImageTransparency = 0.8, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(0.4, 0.3), TileSize = UDim2.fromScale(0.305, 0.8) })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 3.0599999 })
			I[4] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
			I[5] = new("Frame", I[2], "Boxes", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4999998, 0.4835885), Size = UDim2.fromScale(0.9000003, 0.3371795) })
				I[6] = new("TextBox", I[5], "Digit1", { BackgroundColor3 = Color3.fromRGB(72, 78, 84), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, PlaceholderText = "0", Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[7] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint", { AspectRatio = 0.87 })
					I[8] = new("UIPadding", I[6], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.1, 0), PaddingRight = UDim.new(0.1, 0), PaddingTop = UDim.new(0.1, 0) })
					I[9] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
				I[10] = new("UIListLayout", I[5], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.02, 0), SortOrder = Enum.SortOrder.LayoutOrder })
				I[11] = new("TextBox", I[5], "Digit2", { BackgroundColor3 = Color3.fromRGB(72, 78, 84), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, PlaceholderText = "0", Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[12] = new("UIAspectRatioConstraint", I[11], "UIAspectRatioConstraint", { AspectRatio = 0.87 })
					I[13] = new("UIPadding", I[11], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.1, 0), PaddingRight = UDim.new(0.1, 0), PaddingTop = UDim.new(0.1, 0) })
					I[14] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
				I[15] = new("TextBox", I[5], "Digit3", { BackgroundColor3 = Color3.fromRGB(72, 78, 84), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 3, PlaceholderText = "0", Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[16] = new("UIAspectRatioConstraint", I[15], "UIAspectRatioConstraint", { AspectRatio = 0.87 })
					I[17] = new("UIPadding", I[15], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.1, 0), PaddingRight = UDim.new(0.1, 0), PaddingTop = UDim.new(0.1, 0) })
					I[18] = new("UICorner", I[15], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
				I[19] = new("TextBox", I[5], "Digit4", { BackgroundColor3 = Color3.fromRGB(72, 78, 84), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 4, PlaceholderText = "0", Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[20] = new("UIAspectRatioConstraint", I[19], "UIAspectRatioConstraint", { AspectRatio = 0.87 })
					I[21] = new("UIPadding", I[19], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.1, 0), PaddingRight = UDim.new(0.1, 0), PaddingTop = UDim.new(0.1, 0) })
					I[22] = new("UICorner", I[19], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
				I[23] = new("TextBox", I[5], "Digit5", { BackgroundColor3 = Color3.fromRGB(72, 78, 84), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 5, PlaceholderText = "0", Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[24] = new("UIAspectRatioConstraint", I[23], "UIAspectRatioConstraint", { AspectRatio = 0.87 })
					I[25] = new("UIPadding", I[23], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.1, 0), PaddingRight = UDim.new(0.1, 0), PaddingTop = UDim.new(0.1, 0) })
					I[26] = new("UICorner", I[23], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
				I[27] = new("TextBox", I[5], "Digit6", { BackgroundColor3 = Color3.fromRGB(72, 78, 84), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 6, PlaceholderText = "0", Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[28] = new("UIAspectRatioConstraint", I[27], "UIAspectRatioConstraint", { AspectRatio = 0.87 })
					I[29] = new("UIPadding", I[27], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.1, 0), PaddingRight = UDim.new(0.1, 0), PaddingTop = UDim.new(0.1, 0) })
					I[30] = new("UICorner", I[27], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
				I[31] = new("TextBox", I[5], "Digit7", { BackgroundColor3 = Color3.fromRGB(72, 78, 84), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 7, PlaceholderText = "0", Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[32] = new("UIAspectRatioConstraint", I[31], "UIAspectRatioConstraint", { AspectRatio = 0.87 })
					I[33] = new("UIPadding", I[31], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.1, 0), PaddingRight = UDim.new(0.1, 0), PaddingTop = UDim.new(0.1, 0) })
					I[34] = new("UICorner", I[31], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
				I[35] = new("TextBox", I[5], "Digit8", { BackgroundColor3 = Color3.fromRGB(72, 78, 84), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 8, PlaceholderText = "0", Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[36] = new("UIAspectRatioConstraint", I[35], "UIAspectRatioConstraint", { AspectRatio = 0.87 })
					I[37] = new("UIPadding", I[35], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.1, 0), PaddingRight = UDim.new(0.1, 0), PaddingTop = UDim.new(0.1, 0) })
					I[38] = new("UICorner", I[35], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
			I[39] = new("TextButton", I[2], "Submit", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(93, 109, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.95, 0.95), Size = UDim2.fromScale(0.25, 0.2447217), Text = "OK", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[40] = new("UICorner", I[39], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
				I[41] = new("UIPadding", I[39], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.1, 0), PaddingRight = UDim.new(0.1, 0), PaddingTop = UDim.new(0.1, 0) })
			I[42] = new("TextLabel", I[2], "Status", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.05, 0.95), Size = UDim2.fromScale(0.4, 0.15), Text = "Request sent.", TextColor3 = Color3.fromRGB(79, 184, 61), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[43] = new("TextLabel", I[2], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.05, 0.05), Size = UDim2.fromScale(0.4, 0.2), Text = "Social Code", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[44] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(25, 27, 29), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.04 })
			I[45] = new("Frame", I[2], "CloseButtonFrame", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.95, 0.05), Size = UDim2.fromScale(0.2, 0.2), ZIndex = 2 })
				I[46] = new("TextButton", I[45], "CloseButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(220, 50, 50), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 3 }, nil, { "SocialVerifyButton" })
					I[47] = new("UICorner", I[46], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
					I[48] = new("UIStroke", I[46], "UIStroke", { Color = Color3.fromRGB(84, 0, 0), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.03 })
				I[49] = new("UIAspectRatioConstraint", I[45], "UIAspectRatioConstraint")
				I[50] = new("UICorner", I[45], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
				I[51] = new("UIStroke", I[45], "UIStroke", { Color = Color3.fromRGB(84, 0, 0), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.05 })
				I[52] = new("UIGradient", I[45], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(214, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(109, 0, 0)) }), Rotation = 90 })
			I[53] = new("Frame", I[2], "Reward", { BackgroundTransparency = 1, Position = UDim2.fromScale(0.4, 0.05), Size = UDim2.fromScale(0.4, 0.2) })
				I[54] = new("UIListLayout", I[53], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[55] = new("TextLabel", I[53], "RewardText", { AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(0.55, 1), Text = "+15,000 Speed!", TextColor3 = Color3.fromRGB(255, 255, 0), TextScaled = true, TextWrapped = true })
					I[56] = new("UIStroke", I[55], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.08 })
					I[57] = new("UIPadding", I[55], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.02, 0), PaddingTop = UDim.new(0.1, 0) })
				I[58] = new("ImageLabel", I[53], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://16408406294"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.15, 1) })
	return I[1]
end

return build
