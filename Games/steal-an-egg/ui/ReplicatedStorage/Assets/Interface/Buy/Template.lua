-- Generated from ui/ReplicatedStorage/Assets/Interface/Buy/Template.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Template", { BackgroundColor3 = Color3.fromRGB(66, 89, 102), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0257143, -0.0025361), Size = UDim2.fromScale(1, 0.42) })
		I[2] = new("Frame", I[1], "Selected", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5002034, 1.061166), Size = UDim2.fromScale(0.97942, 2.1223292), Visible = false, ZIndex = 21 })
			I[3] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 3 })
		I[4] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://80101472460430"), LayoutOrder = 2, Position = UDim2.fromScale(0.012, 0.5), Size = UDim2.fromScale(0.75, 0.75), ZIndex = 2 })
			I[5] = new("Frame", I[4], "Noti", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(212, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(0.4, 0.4), Visible = false, ZIndex = 10 })
				I[6] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint")
				I[7] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
				I[8] = new("TextLabel", I[5], "ButtonName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 11 })
			I[9] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint")
		I[10] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.21, 0.05), RichText = true, Size = UDim2.fromScale(0.6939248, 0.2593178), Text = "Cardboard Boombox", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 2.2 })
		I[12] = new("TextLabel", I[1], "Desc", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.221, 0.3097486), RichText = true, Size = UDim2.fromScale(0.74, 0.2513485), Text = "+2% SIZE LUCK every second! Lasts for 10 minutes!", TextColor3 = Color3.fromRGB(220, 220, 220), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[13] = new("UIStroke", I[12], "UIStroke", { Thickness = 2.2 })
		I[14] = new("Frame", I[1], "Buttons", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.725, 0.93), Size = UDim2.fromScale(0.23, 0.3) })
			I[15] = new("Frame", I[14], "Buy", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -1, Position = UDim2.fromScale(0.87, 0.93), Size = UDim2.fromScale(1, 1) })
				I[16] = new("Frame", I[15], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(129, 204, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 10 })
					I[17] = new("Frame", I[16], "TooMuch", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.7, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 20 })
					I[18] = new("UIGradient", I[16], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(187, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(41, 222, 0)) }), Rotation = 90 })
					I[19] = new("UIStroke", I[16], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
					I[20] = new("TextLabel", I[16], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.95, 0.7), Text = "$50,000", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 11 })
						I[21] = new("UIStroke", I[20], "UIStroke", { Thickness = 2.4000001 })
				I[22] = new("TextButton", I[15], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 15 })
			I[23] = new("Frame", I[14], "Robux", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
				I[24] = new("Frame", I[23], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(227, 227, 227), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 10 })
					I[25] = new("Frame", I[24], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.8) })
						I[26] = new("TextLabel", I[25], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3618595, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 10 })
							I[27] = new("UIStroke", I[26], "UIStroke", { Thickness = 2.4000001 })
							I[28] = new("UIAspectRatioConstraint", I[26], "UIAspectRatioConstraint")
						I[29] = new("TextLabel", I[25], "PriceLabel", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6045946, 0.4999995), Size = UDim2.fromScale(0.1961444, 0.9), Text = "-", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 10 })
							I[30] = new("UIStroke", I[29], "UIStroke", { Thickness = 2.4000001 })
						I[31] = new("UIListLayout", I[25], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
					I[32] = new("UIStroke", I[24], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
					I[33] = new("UIGradient", I[24], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(227, 124, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(161, 49, 226)) }), Rotation = 90 })
				I[34] = new("TextButton", I[23], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 15 })
			I[35] = new("UIListLayout", I[14], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.1, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[36] = new("UIStroke", I[1], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
	return I[1]
end

return build
