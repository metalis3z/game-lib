-- Generated from ui/ServerStorage/3.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "3", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, LayoutOrder = 1, Position = UDim2.fromScale(0.1560998, 0.5680623), Selectable = true, Size = UDim2.fromScale(0.285, 0.95) })
		I[2] = new("ImageButton", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.95, 0.95) }, nil, { "ProductButton" })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 1.5 })
			I[4] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
			I[5] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000002, 0.1285692), Size = UDim2.fromScale(0.8999999, 0.19046), Text = "WOODEN CASE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
				I[6] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(96, 11, 0), Thickness = 3 })
			I[7] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 172, 3)), ColorSequenceKeypoint.new(1, Color3.fromRGB(239, 130, 0)) }), Rotation = -90 })
			I[8] = new("ImageButton", I[2], "Button", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13645841920"), Position = UDim2.fromScale(0.5, 0.875), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.9, 0.2), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton" })
				I[9] = new("ImageLabel", I[8], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13784127821"), Position = UDim2.fromScale(0.223, 0.45), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2, 0.8), ZIndex = 2 })
				I[10] = new("TextLabel", I[8], "Number", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6791979, 0.5249995), Size = UDim2.fromScale(0.591604, 0.45), Text = "   10K", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 4 })
					I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 1.5 })
			I[12] = new("ImageButton", I[2], "Icon", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14315882488"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Selectable = false, Size = UDim2.fromScale(0.9, 0.5), ZIndex = 4 }, nil, { "PopButton" })
				I[13] = new("ImageLabel", I[12], "Sunburst", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://8574506083"), Position = UDim2.fromScale(0.5, 0.45), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.75, 1.75) })
					I[14] = new("UIAspectRatioConstraint", I[13], "UIAspectRatioConstraint")
					I[15] = new("UIScale", I[13], "UIScale", { Scale = 0.9 })
					I[16] = new("UIGradient", I[13], "UIGradient", { Rotation = 90 })
				I[17] = new("ImageLabel", I[12], "Dark", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://14315882488"), ImageTransparency = 0.3, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 5 })
					I[18] = new("TextLabel", I[17], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.25), Text = "View", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
						I[19] = new("UIStroke", I[18], "UIStroke", { Thickness = 3 })
	return I[1]
end

return build
