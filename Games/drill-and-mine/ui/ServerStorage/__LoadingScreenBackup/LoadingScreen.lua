-- Generated from ui/ServerStorage/__LoadingScreenBackup/LoadingScreen.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "LoadingScreen", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 100 })
		I[2] = new("Frame", I[1], "Dots", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.84), Size = UDim2.fromScale(0.3, 0.08) })
			I[3] = new("UIListLayout", I[2], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 9), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[4] = new("Frame", I[2], "1", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.8, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.75), Size = UDim2.fromScale(0.95, 0.95), ZIndex = 105 })
				I[5] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(0, 100), BottomRightRadius = UDim.new(0, 100), TopLeftRadius = UDim.new(0, 100), TopRightRadius = UDim.new(0, 100) })
				I[6] = new("Frame", I[4], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.7419355, 0.7419355), ZIndex = 106 })
					I[7] = new("UIGradient", I[6], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 185, 255)) }), Rotation = 90 })
					I[8] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0, 100), BottomRightRadius = UDim.new(0, 100), TopLeftRadius = UDim.new(0, 100), TopRightRadius = UDim.new(0, 100) })
					I[9] = new("UIStroke", I[6], "UIStroke", { BorderStrokePosition = Enum.BorderStrokePosition.Inner, Color = Color3.fromRGB(255, 255, 255), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1, Transparency = 0.5 })
					I[10] = new("UIStroke", I[6], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1 })
					I[11] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint")
				I[12] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint")
			I[13] = new("Frame", I[2], "2", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.8, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.75), Size = UDim2.fromScale(0.95, 0.95), ZIndex = 105 })
				I[14] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0, 100), BottomRightRadius = UDim.new(0, 100), TopLeftRadius = UDim.new(0, 100), TopRightRadius = UDim.new(0, 100) })
				I[15] = new("Frame", I[13], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.7419355, 0.7419355), ZIndex = 106 })
					I[16] = new("UIGradient", I[15], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 185, 255)) }), Rotation = 90 })
					I[17] = new("UICorner", I[15], "UICorner", { BottomLeftRadius = UDim.new(0, 100), BottomRightRadius = UDim.new(0, 100), TopLeftRadius = UDim.new(0, 100), TopRightRadius = UDim.new(0, 100) })
					I[18] = new("UIStroke", I[15], "UIStroke", { BorderStrokePosition = Enum.BorderStrokePosition.Inner, Color = Color3.fromRGB(255, 255, 255), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1, Transparency = 0.5 })
					I[19] = new("UIStroke", I[15], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1 })
					I[20] = new("UIAspectRatioConstraint", I[15], "UIAspectRatioConstraint")
				I[21] = new("UIAspectRatioConstraint", I[13], "UIAspectRatioConstraint")
			I[22] = new("Frame", I[2], "3", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.8, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0.75), Size = UDim2.fromScale(0.95, 0.95), ZIndex = 105 })
				I[23] = new("UICorner", I[22], "UICorner", { BottomLeftRadius = UDim.new(0, 100), BottomRightRadius = UDim.new(0, 100), TopLeftRadius = UDim.new(0, 100), TopRightRadius = UDim.new(0, 100) })
				I[24] = new("Frame", I[22], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.7419355, 0.7419355), ZIndex = 106 })
					I[25] = new("UIGradient", I[24], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 185, 255)) }), Rotation = 90 })
					I[26] = new("UICorner", I[24], "UICorner", { BottomLeftRadius = UDim.new(0, 100), BottomRightRadius = UDim.new(0, 100), TopLeftRadius = UDim.new(0, 100), TopRightRadius = UDim.new(0, 100) })
					I[27] = new("UIStroke", I[24], "UIStroke", { BorderStrokePosition = Enum.BorderStrokePosition.Inner, Color = Color3.fromRGB(255, 255, 255), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1, Transparency = 0.5 })
					I[28] = new("UIStroke", I[24], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1 })
					I[29] = new("UIAspectRatioConstraint", I[24], "UIAspectRatioConstraint")
				I[30] = new("UIAspectRatioConstraint", I[22], "UIAspectRatioConstraint")
			I[31] = new("Frame", I[2], "4", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.8, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 4, Position = UDim2.fromScale(0.5, 0.75), Size = UDim2.fromScale(0.95, 0.95), ZIndex = 105 })
				I[32] = new("UICorner", I[31], "UICorner", { BottomLeftRadius = UDim.new(0, 100), BottomRightRadius = UDim.new(0, 100), TopLeftRadius = UDim.new(0, 100), TopRightRadius = UDim.new(0, 100) })
				I[33] = new("Frame", I[31], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.7419355, 0.7419355), ZIndex = 106 })
					I[34] = new("UIGradient", I[33], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 185, 255)) }), Rotation = 90 })
					I[35] = new("UICorner", I[33], "UICorner", { BottomLeftRadius = UDim.new(0, 100), BottomRightRadius = UDim.new(0, 100), TopLeftRadius = UDim.new(0, 100), TopRightRadius = UDim.new(0, 100) })
					I[36] = new("UIStroke", I[33], "UIStroke", { BorderStrokePosition = Enum.BorderStrokePosition.Inner, Color = Color3.fromRGB(255, 255, 255), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1, Transparency = 0.5 })
					I[37] = new("UIStroke", I[33], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1 })
					I[38] = new("UIAspectRatioConstraint", I[33], "UIAspectRatioConstraint")
				I[39] = new("UIAspectRatioConstraint", I[31], "UIAspectRatioConstraint")
			I[40] = new("Frame", I[2], "5", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.8, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 5, Position = UDim2.fromScale(0.5, 0.75), Size = UDim2.fromScale(0.95, 0.95), ZIndex = 105 })
				I[41] = new("UICorner", I[40], "UICorner", { BottomLeftRadius = UDim.new(0, 100), BottomRightRadius = UDim.new(0, 100), TopLeftRadius = UDim.new(0, 100), TopRightRadius = UDim.new(0, 100) })
				I[42] = new("Frame", I[40], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.7419355, 0.7419355), ZIndex = 106 })
					I[43] = new("UIGradient", I[42], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 185, 255)) }), Rotation = 90 })
					I[44] = new("UICorner", I[42], "UICorner", { BottomLeftRadius = UDim.new(0, 100), BottomRightRadius = UDim.new(0, 100), TopLeftRadius = UDim.new(0, 100), TopRightRadius = UDim.new(0, 100) })
					I[45] = new("UIStroke", I[42], "UIStroke", { BorderStrokePosition = Enum.BorderStrokePosition.Inner, Color = Color3.fromRGB(255, 255, 255), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1, Transparency = 0.5 })
					I[46] = new("UIStroke", I[42], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1 })
					I[47] = new("UIAspectRatioConstraint", I[42], "UIAspectRatioConstraint")
				I[48] = new("UIAspectRatioConstraint", I[40], "UIAspectRatioConstraint")
			I[49] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 7.7364445 })
		I[50] = new("ImageLabel", I[1], "GameIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://110554780271641"), Position = UDim2.fromScale(0.5, 0.4), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.51, 0.51) })
			I[51] = new("UICorner", I[50], "UICorner", { BottomLeftRadius = UDim.new(0.04, 0), BottomRightRadius = UDim.new(0.04, 0), TopLeftRadius = UDim.new(0.04, 0), TopRightRadius = UDim.new(0.04, 0) })
			I[52] = new("UIStroke", I[50], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 10, Transparency = 0.5, ZIndex = 0 })
			I[53] = new("UIStroke", I[50], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 6 })
			I[54] = new("UIAspectRatioConstraint", I[50], "UIAspectRatioConstraint")
		I[55] = new("ImageLabel", I[1], "GameThumbnail", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 103 })
			I[56] = new("UIAspectRatioConstraint", I[55], "UIAspectRatioConstraint", { AspectRatio = 2.0630517 })
		I[57] = new("TextLabel", I[1], "Loading", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.71), Size = UDim2.fromScale(0.26, 0.05), Text = "Loading...", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 104 })
			I[58] = new("UIGradient", I[57], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(205, 208, 255)) }), Rotation = 90 })
			I[59] = new("UIAspectRatioConstraint", I[57], "UIAspectRatioConstraint", { AspectRatio = 10.7278681 })
			I[60] = new("UIStroke", I[57], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3.5 })
		I[61] = new("TextLabel", I[1], "Version", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.005, 1), Size = UDim2.fromScale(0.1646904, 0.060241), Text = "v1.0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[62] = new("UIGradient", I[61], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(205, 208, 255)) }), Rotation = 90 })
			I[63] = new("UIAspectRatioConstraint", I[61], "UIAspectRatioConstraint", { AspectRatio = 5.6400948 })
			I[64] = new("UIStroke", I[61], "UIStroke", { Color = Color3.fromRGB(15, 17, 51), LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3.5 })
		I[65] = new("Frame", I[1], "Darker", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 0 })
			I[66] = new("ImageLabel", I[65], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://16756014301"), ImageTransparency = 0.7, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 102 })
				I[67] = new("UIGradient", I[66], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 30, 86)), ColorSequenceKeypoint.new(0.2, Color3.fromRGB(161, 30, 255)), ColorSequenceKeypoint.new(0.4, Color3.fromRGB(30, 180, 255)), ColorSequenceKeypoint.new(0.6, Color3.fromRGB(49, 255, 30)), ColorSequenceKeypoint.new(0.8, Color3.fromRGB(255, 255, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 143, 30)) }) })
	return I[1]
end

return build
