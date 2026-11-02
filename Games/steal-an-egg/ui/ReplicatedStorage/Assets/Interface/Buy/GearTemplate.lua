-- Generated from ui/ReplicatedStorage/Assets/Interface/Buy/GearTemplate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "GearTemplate", { BackgroundColor3 = Color3.fromRGB(66, 89, 102), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Position = UDim2.fromScale(-0.0257143, -0.0025361), Size = UDim2.fromScale(1, 0.42) })
		I[2] = new("TextLabel", I[1], "Desc", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.221, 0.3097486), RichText = true, Size = UDim2.fromScale(0.74, 0.24), Text = "Increase <font color='#ffff00'>SIZE</font> and <font color='#00ff00'>HATCH LUCK</font> by placing this near your eggs!", TextColor3 = Color3.fromRGB(220, 220, 220), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 2.2 })
		I[4] = new("Frame", I[1], "Selected", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5002034, 1.061166), Size = UDim2.fromScale(0.97942, 2.1223292), Visible = false, ZIndex = 21 })
			I[5] = new("UIStroke", I[4], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 1.7289972 })
		I[6] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.21, 0.05), RichText = true, Size = UDim2.fromScale(0.6939248, 0.2593178), Text = "Dark Matter Boombox", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 2.2 })
		I[8] = new("Frame", I[1], "Buttons", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.95, 0.93), Size = UDim2.fromScale(0.425, 0.28) })
			I[9] = new("Frame", I[8], "Robux", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.4, 1) })
				I[10] = new("TextButton", I[9], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 15 })
				I[11] = new("Frame", I[9], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(227, 227, 227), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 10 })
					I[12] = new("UIGradient", I[11], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(227, 124, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(161, 49, 226)) }), Rotation = 90 })
					I[13] = new("Frame", I[11], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.8) })
						I[14] = new("TextLabel", I[13], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3618595, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 10 })
							I[15] = new("UIAspectRatioConstraint", I[14], "UIAspectRatioConstraint")
							I[16] = new("UIStroke", I[14], "UIStroke", { Thickness = 2.2 })
						I[17] = new("UIListLayout", I[13], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
						I[18] = new("TextLabel", I[13], "PriceLabel", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6045946, 0.4999995), Size = UDim2.fromScale(0, 0.9), Text = "-", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 10 })
							I[19] = new("UIStroke", I[18], "UIStroke", { Thickness = 2.2 })
					I[20] = new("UIStroke", I[11], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 1.7289972 })
			I[21] = new("Frame", I[8], "Currency", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.87, 0.93), Size = UDim2.fromScale(0.4, 1), Visible = false })
				I[22] = new("TextButton", I[21], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 15 })
				I[23] = new("Frame", I[21], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(170, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 10 })
					I[24] = new("Frame", I[23], "TooMuch", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.7, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 20 })
					I[25] = new("TextLabel", I[23], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.7), Text = "$0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 11 })
						I[26] = new("UIStroke", I[25], "UIStroke", { Thickness = 2.2 })
					I[27] = new("UIStroke", I[23], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 1.7289972 })
					I[28] = new("UIGradient", I[23], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 170, 0)) }), Rotation = 90 })
			I[29] = new("Frame", I[8], "Gems", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.87, 0.93), Size = UDim2.fromScale(0.4, 1), Visible = false })
				I[30] = new("Frame", I[29], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(170, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 10 })
					I[31] = new("Frame", I[30], "TooMuch", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.7, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 20 })
					I[32] = new("Frame", I[30], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.95, 0.7), ZIndex = 11 })
						I[33] = new("TextLabel", I[32], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0, 0.75), Text = "0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 11 })
							I[34] = new("UIStroke", I[33], "UIStroke", { Thickness = 2.2 })
						I[35] = new("ImageLabel", I[32], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://92632745224348"), LayoutOrder = -1, Position = UDim2.fromScale(0, 0.0560781), Size = UDim2.fromScale(0.2549026, 1.0196105), ZIndex = 15 })
							I[36] = new("ImageLabel", I[35], "glow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(170, 255, 255), ImageContent = Content.fromUri("rbxassetid://74593485329907"), Position = UDim2.fromScale(0.5384666, 0.5281982), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.9384798, 1.9600184), ZIndex = 11 })
							I[37] = new("UIAspectRatioConstraint", I[35], "UIAspectRatioConstraint")
						I[38] = new("UIListLayout", I[32], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
					I[39] = new("UIStroke", I[30], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 1.7289972 })
					I[40] = new("UIGradient", I[30], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 170, 255)) }), Rotation = 90 })
				I[41] = new("TextButton", I[29], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 15 })
			I[42] = new("UIListLayout", I[8], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, HorizontalFlex = Enum.UIFlexAlignment.Fill, Padding = UDim.new(0.06, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center, Wraps = true })
		I[43] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://118220187855958"), LayoutOrder = 2, Position = UDim2.fromScale(0.012, 0.5), Size = UDim2.fromScale(0.75, 0.75), ZIndex = 2 })
			I[44] = new("UIAspectRatioConstraint", I[43], "UIAspectRatioConstraint")
			I[45] = new("Frame", I[43], "Noti", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(212, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(0.4, 0.4), Visible = false, ZIndex = 10 })
				I[46] = new("UICorner", I[45], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
				I[47] = new("UIAspectRatioConstraint", I[45], "UIAspectRatioConstraint")
				I[48] = new("TextLabel", I[45], "ButtonName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 11 })
		I[49] = new("TextLabel", I[1], "SubDesc", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.221, 0.935), RichText = true, Size = UDim2.fromScale(0.245, 0.315), Text = "Up to <font color='#00ff00'>500% LUCK</font>\nLasts for <font color='#00ffff'>30 MINUTES</font>", TextColor3 = Color3.fromRGB(220, 220, 220), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[50] = new("UIStroke", I[49], "UIStroke", { Thickness = 2.2 })
		I[51] = new("UIStroke", I[1], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 1.7289972 })
	return I[1]
end

return build
