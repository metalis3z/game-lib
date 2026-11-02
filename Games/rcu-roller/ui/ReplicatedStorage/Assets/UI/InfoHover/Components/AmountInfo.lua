-- Generated from ui/ReplicatedStorage/Assets/UI/InfoHover/Components/AmountInfo.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "AmountInfo", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(199, 199, 199), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 7, Position = UDim2.fromScale(0.49, 0.4), Size = UDim2.fromScale(1, 0.094), ZIndex = 1550 })
		I[2] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.025, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[3] = new("ImageLabel", I[1], "Arrow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageTransparency = 1, LayoutOrder = 5, Position = UDim2.fromScale(0.3804581, 0.0829739), Size = UDim2.fromScale(0.18, 1), ZIndex = 1550 })
			I[4] = new("ImageLabel", I[3], "CurrencyIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(179, 179, 179), ImageContent = Content.fromUri("rbxassetid://135902205221209"), LayoutOrder = 5, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6875, 1.0232558), ZIndex = 1550 })
		I[5] = new("TextLabel", I[1], "Amount", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1500, Position = UDim2.fromScale(0.5, 0.325), Size = UDim2.new(0, 10, 0.83, 0), Text = "5 XP", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 36, ZIndex = 1550 })
			I[6] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(82, 20, 86), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
			I[7] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 202, 245)), ColorSequenceKeypoint.new(1, Color3.fromRGB(241, 44, 255)) }), Rotation = 90 })
		I[8] = new("TextLabel", I[1], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.325), Size = UDim2.new(0, 10, 0.83, 0), Text = "Craft Toxic Pet", TextColor3 = Color3.fromRGB(0, 32, 54), TextSize = 25, ZIndex = 1550 })
	return I[1]
end

return build
