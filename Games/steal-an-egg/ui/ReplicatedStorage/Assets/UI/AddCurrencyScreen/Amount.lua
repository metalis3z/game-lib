-- Generated from ui/ReplicatedStorage/Assets/UI/AddCurrencyScreen/Amount.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Amount", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(3, 3), Size = UDim2.fromOffset(0, 45), ZIndex = 10 }, { ["__ctf_identity"] = UDim2.fromScale(0.25, 1), ["__ctf_reference"] = "Tokens", ["__ctf_start"] = "Stars", ["__stroke_scale_visibility"] = true })
		I[2] = new("UIScale", I[1], "UIScale")
		I[3] = new("TextLabel", I[1], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0, 1), Text = "$299,999", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
			I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 2 })
			I[5] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(77, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(19, 194, 0)) }), Rotation = 90 })
			I[6] = new("TextLabel", I[3], "White", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "$299,999", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
		I[7] = new("ImageLabel", I[1], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://87505576905683"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.9), ZIndex = 10 })
			I[8] = new("UIAspectRatioConstraint", I[7], "UIAspectRatioConstraint")
			I[9] = new("UIScale", I[7], "UIScale")
		I[10] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
	return I[1]
end

return build
