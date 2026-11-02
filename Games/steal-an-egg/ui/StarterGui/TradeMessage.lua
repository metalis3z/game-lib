-- Generated from ui/StarterGui/TradeMessage.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "TradeMessage", { Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("UIPadding", I[1], "UIPadding", { PaddingTop = UDim.new(0, -12) })
		I[3] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.55, BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 0.03, 15), Size = UDim2.fromScale(1, 0.1475) })
			I[4] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(42, 43, 49), Thickness = 2.5999999 })
			I[5] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
			I[6] = new("Frame", I[3], "Message", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.55) })
				I[7] = new("TextLabel", I[6], "Title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.165), Size = UDim2.fromScale(1, 0.5), Text = "Trade from Satoshi", TextColor3 = Color3.fromRGB(112, 237, 252), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, ZIndex = 7 })
					I[8] = new("UIStroke", I[7], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.3 })
				I[9] = new("TextLabel", I[6], "Desc", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.165), Size = UDim2.fromScale(1, 0.5), Text = "Do you accept?", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, ZIndex = 7 })
				I[10] = new("UIListLayout", I[6], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[11] = new("UIPadding", I[6], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.025, 0), PaddingRight = UDim.new(0.025, 0), PaddingTop = UDim.new(0.1, 0) })
			I[12] = new("Frame", I[3], "Buttons", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.45) })
				I[13] = new("ImageButton", I[12], "Yes", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://126875624960627"), Position = UDim2.fromScale(0, 0.5), PressedImageContent = Content.fromUri("rbxassetid://124217248402069"), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.5, 1), SliceCenter = Rect.new(20, 20, 80, 80), ZIndex = 6 })
					I[14] = new("UIGradient", I[13], "green gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 8)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 8)) }), Rotation = -90 })
					I[15] = new("TextLabel", I[13], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.6), Text = "Yes!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 6 })
						I[16] = new("UIStroke", I[15], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 1.8 })
					I[17] = new("ImageLabel", I[13], "ConsoleButton", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxasset://textures/ui/Controls/DefaultController/ButtonA@2x.png"), Position = UDim2.fromScale(1, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.4), Visible = false, ZIndex = 10 }, { ["ConsoleButton"] = "ButtonX" })
						I[18] = new("UIAspectRatioConstraint", I[17], "UIAspectRatioConstraint")
				I[19] = new("ImageButton", I[12], "No", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://126875624960627"), Position = UDim2.fromScale(1, 0.5), PressedImageContent = Content.fromUri("rbxassetid://124217248402069"), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.5, 1), SliceCenter = Rect.new(20, 20, 80, 80), ZIndex = 6 })
					I[20] = new("TextLabel", I[19], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.6), Text = "No", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 6 })
						I[21] = new("UIStroke", I[20], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 1.8 })
					I[22] = new("UIGradient", I[19], "red gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }), Rotation = -90 })
					I[23] = new("ImageLabel", I[19], "ConsoleButton", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxasset://textures/ui/Controls/DefaultController/ButtonB@2x.png"), Position = UDim2.fromScale(1, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.4), Visible = false, ZIndex = 10 }, { ["ConsoleButton"] = "ButtonB" })
						I[24] = new("UIAspectRatioConstraint", I[23], "UIAspectRatioConstraint")
				I[25] = new("UIPadding", I[12], "UIPadding", { PaddingBottom = UDim.new(0.05, 0), PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0) })
				I[26] = new("UIListLayout", I[12], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.025, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[27] = new("ImageLabel", I[3], "SideIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://106925224662947"), Position = UDim2.fromScale(0.0032802, 0.0379084), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2042535, 0.5128399) })
			I[28] = new("ImageLabel", I[3], "shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://130304595536693"), ImageTransparency = 0.75, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(1, 35, 1, 35), SliceCenter = Rect.new(50, 50, 150, 150), ZIndex = -2 })
			I[29] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 2.4000001 })
	return I[1]
end

return build
