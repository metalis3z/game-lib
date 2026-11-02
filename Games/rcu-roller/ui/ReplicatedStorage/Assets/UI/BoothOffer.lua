-- Generated from ui/ReplicatedStorage/Assets/UI/BoothOffer.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "BoothOffer", { BackgroundColor3 = Color3.fromRGB(255, 11, 11), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4291626, 0), Size = UDim2.fromScale(0.1416749, 1), ZIndex = 505 })
		I[2] = new("Frame", I[1], "Buy", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.8685), Size = UDim2.fromScale(0.9002224, 0.2), ZIndex = 950 })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
			I[4] = new("Frame", I[2], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(117, 48, 21), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), ZIndex = 940 })
				I[5] = new("UIStroke", I[4], "UIStroke", { Color = Color3.fromRGB(117, 48, 21), Thickness = 5 })
				I[6] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
				I[7] = new("UIGradient", I[4], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 132, 244)), ColorSequenceKeypoint.new(1, Color3.fromRGB(217, 29, 255)) }), Rotation = 90 })
			I[8] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(117, 48, 21), Thickness = 5 })
			I[9] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 229, 37)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 112, 10)) }), Rotation = 90 })
			I[10] = new("Frame", I[2], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(199, 199, 199), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 7, Position = UDim2.fromScale(0.48, 0.48), Size = UDim2.fromScale(1, 1), ZIndex = 950 })
				I[11] = new("UIListLayout", I[10], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[12] = new("ImageLabel", I[10], "CurrencyIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://126750168365573"), Position = UDim2.fromScale(0.035, 0.0304878), Size = UDim2.fromScale(0.2183908, 0.696925), ZIndex = 950 })
				I[13] = new("TextLabel", I[10], "Label", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 7, Position = UDim2.fromScale(0.2860404, 0.0853652), Size = UDim2.fromScale(0.2241379, 0.8091644), SizeConstraint = Enum.SizeConstraint.RelativeYY, Text = "1K", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 950 })
					I[14] = new("UIStroke", I[13], "UIStroke", { Color = Color3.fromRGB(85, 41, 19), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
			I[15] = new("TextButton", I[2], "Click", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 600 })
		I[16] = new("Frame", I[1], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.580501), Size = UDim2.fromScale(1, 0.28125), Visible = false, ZIndex = 950 })
			I[17] = new("Frame", I[16], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.485, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 950 })
				I[18] = new("UIListLayout", I[17], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.07, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[19] = new("ImageLabel", I[17], "CurrencyIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://126750168365573"), Position = UDim2.fromScale(0.035, 0.0304878), Size = UDim2.fromScale(0.2172951, 0.5477586), ZIndex = 950 })
				I[20] = new("TextLabel", I[17], "Label", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 7, Position = UDim2.fromScale(0.2860404, 0.0853652), Size = UDim2.fromScale(0.2793793, 0.8091644), SizeConstraint = Enum.SizeConstraint.RelativeYY, Text = "1K", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 950 })
					I[21] = new("UIStroke", I[20], "UIStroke", { Color = Color3.fromRGB(85, 41, 19), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
					I[22] = new("UIGradient", I[20], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 245, 125)), ColorSequenceKeypoint.new(1, Color3.fromRGB(253, 127, 2)) }), Rotation = 90 })
	return I[1]
end

return build
