-- Generated from ui/ReplicatedStorage/Assets/UI/Toolbar/ToolbarButton.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "ToolbarButton", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(46, 182, 255), Position = UDim2.fromScale(0.520195, 0.3416459), Size = UDim2.fromScale(0.058, 1) }, nil, { "PopButton" })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
		I[3] = new("UIStroke", I[1], "UIStroke", { Thickness = 3 })
		I[4] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13593661209"), Position = UDim2.fromScale(0.4977728, 0.4995317), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.7374207, 0.7461435), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 2, ZIndex = 2 })
			I[5] = new("UIScale", I[4], "UIScale", { Scale = 0.95 })
		I[6] = new("Frame", I[1], "Indicator", { BackgroundColor3 = Color3.fromRGB(240, 41, 1), Position = UDim2.fromScale(0.7680343, -0.0460837), Size = UDim2.fromScale(0.3924867, 0.3916084), ZIndex = 2 })
			I[7] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(5, 0), BottomRightRadius = UDim.new(5, 0), TopLeftRadius = UDim.new(5, 0), TopRightRadius = UDim.new(5, 0) })
			I[8] = new("UIStroke", I[6], "UIStroke", { Color = Color3.fromRGB(136, 0, 0), Thickness = 3 })
			I[9] = new("TextLabel", I[6], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Text = "2", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
				I[10] = new("UIStroke", I[9], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 1.5 })
		I[11] = new("ImageButton", I[1], "AutoPunchBtn", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13810832668"), Position = UDim2.fromScale(0.5, -0.5), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(2, 0.6), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, Visible = false, ZIndex = 2 }, nil, { "PopButton" })
			I[12] = new("TextLabel", I[11], "TextLabel", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.54, 0.475), Size = UDim2.fromScale(0.8, 0.7), Text = "AUTO PUNCH", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
				I[13] = new("UIStroke", I[12], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2 })
			I[14] = new("ImageLabel", I[11], "ImageLabel", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://13602409906"), Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2454058, 0.819566), ZIndex = 2 })
				I[15] = new("UIAspectRatioConstraint", I[14], "UIAspectRatioConstraint")
				I[16] = new("UIScale", I[14], "UIScale")
				I[17] = new("Frame", I[14], "Notification", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(48, 238, 40), Position = UDim2.fromScale(0.95, 0.15), Size = UDim2.fromScale(0.4, 0.4), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
					I[18] = new("TextLabel", I[17], "Notification", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 74, 77), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 4 })
						I[19] = new("UIStroke", I[18], "UIStroke", { Thickness = 2 })
					I[20] = new("UICorner", I[17], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[21] = new("UIStroke", I[17], "UIStroke", { Thickness = 2 })
					I[22] = new("UIGradient", I[17], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(75, 194, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 0)) }), Rotation = 90 })
	return I[1]
end

return build
