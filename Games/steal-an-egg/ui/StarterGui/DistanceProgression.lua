-- Generated from ui/StarterGui/DistanceProgression.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "DistanceProgression", { DisplayOrder = 5, Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "TopBar", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.04), Size = UDim2.fromScale(0.443, 0.115) })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 6.439394 })
			I[4] = new("ImageLabel", I[2], "DistanceBar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.2, 0.742) })
				I[5] = new("Folder", I[4], "Folder")
					I[6] = new("ImageLabel", I[5], "Player", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.063, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.0782464, 0.8711827), ZIndex = 4 })
						I[7] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
						I[8] = new("UIStroke", I[6], "UIStroke", { BorderStrokePosition = Enum.BorderStrokePosition.Inner, Thickness = 2.5 })
						I[9] = new("UIScale", I[6], "UIScale")
						I[10] = new("TextLabel", I[6], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1.5, 0.4), Text = "Luck: 1x", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 4 })
							I[11] = new("UIStroke", I[10], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
							I[12] = new("UIGradient", I[10], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 85)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 157)) }), Rotation = -90 })
						I[13] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint")
				I[14] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint", { AspectRatio = 10.414115 })
				I[15] = new("CanvasGroup", I[4], "Container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[16] = new("UICorner", I[15], "UICorner", { BottomLeftRadius = UDim.new(0.01, 0), BottomRightRadius = UDim.new(0.01, 0), TopLeftRadius = UDim.new(0.01, 0), TopRightRadius = UDim.new(0.01, 0) })
					I[17] = new("UIListLayout", I[15], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
					I[18] = new("Frame", I[15], "Template", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.1, 1), ZIndex = 2 })
						I[19] = new("TextLabel", I[18], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.005, 0.01), Size = UDim2.fromScale(1, 0.317), Text = "Common", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true, ZIndex = 5 })
							I[20] = new("UIStroke", I[19], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.12 })
							I[21] = new("UITextSizeConstraint", I[19], "UITextSizeConstraint", { MaxTextSize = 22 })
						I[22] = new("UIStroke", I[18], "UIStroke", { Thickness = 2.8, ZIndex = 2 })
						I[23] = new("UIStroke", I[18], "UIStroke", { BorderStrokePosition = Enum.BorderStrokePosition.Inner, Thickness = 4.9000001, Transparency = 0.75, ZIndex = 2 })
					I[24] = new("UIStroke", I[15], "UIStroke", { Thickness = 2.5, ZIndex = 6 })
		I[25] = new("Frame", I[1], "BottomLuck", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.83), Size = UDim2.fromScale(0.1254457, 0.1534884) })
			I[26] = new("UIAspectRatioConstraint", I[25], "UIAspectRatioConstraint")
			I[27] = new("ImageLabel", I[25], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112060345402891"), Position = UDim2.fromScale(0.5, 0.5982091), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.8035818) })
				I[28] = new("TextLabel", I[27], "Luck", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromScale(2, 0.4060373), Text = "X1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
					I[29] = new("UIStroke", I[28], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3.8 })
				I[30] = new("Frame", I[27], "MagmaMutaitonGIFHolder", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ClipsDescendants = true, Position = UDim2.fromScale(0.4999999, -0.2317951), Size = UDim2.fromScale(2.0999999, 2.6428885) })
					I[31] = new("ImageLabel", I[30], "GIF", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://86655919544454"), ImageTransparency = 0.2, Position = UDim2.fromScale(-1, -1), ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(4, 4) })
					I[32] = new("UIAspectRatioConstraint", I[30], "UIAspectRatioConstraint")
				I[33] = new("ImageLabel", I[27], "FrozenOverlay", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://108254976320338"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.511), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.92) })
				I[34] = new("TextLabel", I[27], "RainbowLuck", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromScale(2, 0.4060373), Text = "X1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true, Visible = false, ZIndex = 5 })
					I[35] = new("UIStroke", I[34], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3.8 })
				I[36] = new("Frame", I[27], "ShockedMutationGIFHolder", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ClipsDescendants = true, Position = UDim2.fromScale(0.5000001, 0.149825), Size = UDim2.fromScale(1.8, 1.9022584), Visible = false })
					I[37] = new("ImageLabel", I[36], "GIF", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://130029461460330"), ImageTransparency = 0.1, Position = UDim2.fromScale(0.5, 0.6830152), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.6339694) })
					I[38] = new("UIAspectRatioConstraint", I[36], "UIAspectRatioConstraint", { AspectRatio = 1.2444284 })
	return I[1]
end

return build
