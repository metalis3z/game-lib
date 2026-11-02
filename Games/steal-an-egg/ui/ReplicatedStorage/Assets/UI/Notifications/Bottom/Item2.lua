-- Generated from ui/ReplicatedStorage/Assets/UI/Notifications/Bottom/Item2.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("CanvasGroup", nil, "Item2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.65) })
		I[2] = new("Frame", I[1], "Entry", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint")
			I[4] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.02), Size = UDim2.fromScale(1, 0.275), Text = "New Item!", TextColor3 = Color3.fromRGB(255, 238, 49), TextScaled = true, TextSize = 18, TextWrapped = true, Visible = false, ZIndex = 2 })
				I[5] = new("UIStroke", I[4], "UIStroke", { Color = Color3.fromRGB(23, 43, 57), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.4000001 })
			I[6] = new("ImageLabel", I[2], "Glow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://90683431509636"), ImageTransparency = 0.1, Position = UDim2.fromScale(0.5, 0.675), Size = UDim2.fromScale(0.3, 1) })
				I[7] = new("UIScale", I[6], "UIScale")
			I[8] = new("Frame", I[2], "Frame", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.95), Size = UDim2.fromScale(1, 0.65), ZIndex = 2 })
				I[9] = new("UIListLayout", I[8], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[10] = new("Frame", I[8], "ItemHolder", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 4 })
					I[11] = new("Frame", I[10], "Item", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 4 })
						I[12] = new("UIAspectRatioConstraint", I[11], "UIAspectRatioConstraint")
						I[13] = new("ImageLabel", I[11], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://101971762454454"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 5 })
					I[14] = new("UIStroke", I[10], "UIStroke", { Enabled = false, Thickness = 4.1999998 })
					I[15] = new("UIPadding", I[10], "UIPadding", { PaddingBottom = UDim.new(0.05, 0), PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0), PaddingTop = UDim.new(0.05, 0) })
					I[16] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint")
					I[17] = new("ImageLabel", I[10], "glow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://130304595536693"), ImageTransparency = 0.8, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1.8, 1.8), SliceCenter = Rect.new(50, 50, 150, 150), SliceScale = 0.9, ZIndex = 2 })
						I[18] = new("UIGradient", I[17], "Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(41, 216, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(41, 226, 255)) }), Rotation = 100 })
					I[19] = new("UIGradient", I[10], "Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(41, 216, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(41, 226, 255)) }), Rotation = 100 })
					I[20] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
					I[21] = new("ImageLabel", I[10], "coreImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://125192115551934"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.3, 1.3) })
						I[22] = new("CanvasGroup", I[21], "CanvasGroup", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8) })
							I[23] = new("UICorner", I[22], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
							I[24] = new("ImageLabel", I[22], "InletTexture", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://103855926983380"), ImageTransparency = 0.39, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromScale(0.3, 0.3), ZIndex = 2 })
				I[25] = new("TextLabel", I[8], "Quanity", { AnchorPoint = Vector2.new(0.5, 0), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0), RichText = true, Size = UDim2.fromScale(0, 0.6), Text = "x5", TextColor3 = Color3.fromRGB(23, 43, 57), TextScaled = true, TextSize = 18, TextWrapped = true, Visible = false, ZIndex = 2 })
		I[26] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
	return I[1]
end

return build
