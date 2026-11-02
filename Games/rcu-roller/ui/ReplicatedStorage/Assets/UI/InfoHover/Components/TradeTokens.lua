-- Generated from ui/ReplicatedStorage/Assets/UI/InfoHover/Components/TradeTokens.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "TradeTokens", { BackgroundColor3 = Color3.fromRGB(199, 199, 199), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 15, Position = UDim2.fromScale(0.1068534, 0.2902488), Size = UDim2.fromScale(0.7862929, 0.1064813), ZIndex = 1550 })
		I[2] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[3] = new("TextLabel", I[1], "Amount", { AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.1066488, 0.0242887), Size = UDim2.fromScale(0.01, 0.769), Text = "10.4K", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 39, ZIndex = 1550 })
			I[4] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(54, 39, 23), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
			I[5] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(252, 255, 49)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 157, 0)) }), Rotation = 90 })
		I[6] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://138788240428195"), Position = UDim2.fromScale(0.2670468, 0.5), Size = UDim2.fromScale(0.2073026, 0.9617685), ZIndex = 1551 })
	return I[1]
end

return build
