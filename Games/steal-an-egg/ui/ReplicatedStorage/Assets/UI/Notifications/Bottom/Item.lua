-- Generated from ui/ReplicatedStorage/Assets/UI/Notifications/Bottom/Item.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("CanvasGroup", nil, "Item", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.65) })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.95), Size = UDim2.fromScale(1, 0.65), ZIndex = 2 })
			I[3] = new("UIListLayout", I[2], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[4] = new("Frame", I[2], "ItemHolder", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 4 })
				I[5] = new("Frame", I[4], "Item", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 4 })
					I[6] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint")
					I[7] = new("ImageLabel", I[5], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://101971762454454"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 5 })
				I[8] = new("UIStroke", I[4], "UIStroke", { Thickness = 3 })
				I[9] = new("UIPadding", I[4], "UIPadding", { PaddingBottom = UDim.new(0.05, 0), PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0), PaddingTop = UDim.new(0.05, 0) })
				I[10] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint")
				I[11] = new("ImageLabel", I[4], "glow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://130304595536693"), ImageTransparency = 0.8, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1.8, 1.8), SliceCenter = Rect.new(50, 50, 150, 150), SliceScale = 0.9, ZIndex = 2 })
					I[12] = new("UIGradient", I[11], "Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(41, 216, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(41, 226, 255)) }), Rotation = 100 })
				I[13] = new("UIGradient", I[4], "Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(41, 216, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(41, 226, 255)) }), Rotation = 100 })
				I[14] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
			I[15] = new("TextLabel", I[2], "Quanity", { AnchorPoint = Vector2.new(0.5, 0), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0), RichText = true, Size = UDim2.fromScale(0, 0.6), Text = "x5", TextColor3 = Color3.fromRGB(23, 43, 57), TextScaled = true, TextSize = 18, TextWrapped = true, Visible = false, ZIndex = 2 })
		I[16] = new("ImageLabel", I[1], "Glow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://90683431509636"), ImageTransparency = 0.1, Position = UDim2.fromScale(0.5, 0.675), Size = UDim2.fromScale(0.3, 1) })
			I[17] = new("UIScale", I[16], "UIScale")
		I[18] = new("TextLabel", I[1], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.02), Size = UDim2.fromScale(0, 0.275), Text = "New Item!", TextColor3 = Color3.fromRGB(255, 238, 49), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 2 })
			I[19] = new("UIStroke", I[18], "UIStroke", { Color = Color3.fromRGB(23, 43, 57), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
	return I[1]
end

return build
