-- Generated from ui/ReplicatedStorage/Assets/UI/BoothPlayerOffer.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "BoothPlayerOffer", { BackgroundColor3 = Color3.fromRGB(255, 11, 11), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4291626, 0), Size = UDim2.fromScale(0.1416749, 1), ZIndex = 505 })
		I[2] = new("Frame", I[1], "Buy", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5019384, 0.8316513), Size = UDim2.fromScale(1, 0.25), ZIndex = 950 })
			I[3] = new("TextButton", I[2], "Click", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 600 })
			I[4] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 229, 37)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 112, 10)) }), Rotation = 90 })
			I[5] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(117, 48, 21), Thickness = 5 })
			I[6] = new("Frame", I[2], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(117, 48, 21), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), ZIndex = 940 })
				I[7] = new("UIGradient", I[6], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 132, 244)), ColorSequenceKeypoint.new(1, Color3.fromRGB(217, 29, 255)) }), Rotation = 90 })
				I[8] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
				I[9] = new("UIStroke", I[6], "UIStroke", { Color = Color3.fromRGB(117, 48, 21), Thickness = 5 })
			I[10] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
			I[11] = new("Frame", I[2], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(199, 199, 199), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 7, Position = UDim2.fromScale(0.48, 0.48), Size = UDim2.fromScale(1, 1), ZIndex = 950 })
				I[12] = new("UIListLayout", I[11], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[13] = new("TextLabel", I[11], "Label", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 7, Position = UDim2.fromScale(0.2860404, 0.0853652), Size = UDim2.fromScale(0.01, 0.809), Text = "1K", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 38, TextWrapped = true, ZIndex = 950 })
					I[14] = new("UIStroke", I[13], "UIStroke", { Color = Color3.fromRGB(85, 41, 19), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
				I[15] = new("ImageLabel", I[11], "CurrencyIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://126750168365573"), Position = UDim2.fromScale(0.035, 0.0304878), Size = UDim2.fromScale(0.3232824, 0.7900687), ZIndex = 950 })
	return I[1]
end

return build
