-- Generated from ui/ReplicatedStorage/Assets/NotificationUI/Notification_UI_Mobile.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Notification_UI_Mobile", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -3, Position = UDim2.fromScale(0.9220779, 0), Size = UDim2.fromScale(3.1558442, 0.65) }, { ["NotificationTimer"] = 1.5, ["OG"] = "Your inventory is full" })
		I[2] = new("ImageLabel", I[1], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=138037320970182"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[3] = new("UIGradient", I[2], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.0968, 0), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(0.9, 0), NumberSequenceKeypoint.new(1, 1) }) })
		I[4] = new("UIScale", I[1], "UIScale")
		I[5] = new("Frame", I[1], "Content", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[6] = new("TextButton", I[5], "DevProductInventory", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(238, 228, 218), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 9, Position = UDim2.fromScale(0.7, 0.4999999), Size = UDim2.fromScale(0.4892738, 0.7752729), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false }, nil, { "ClickSFX" })
				I[7] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint")
				I[8] = new("UIGradient", I[6], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 199, 13)), ColorSequenceKeypoint.new(0.1450777, Color3.fromRGB(0, 255, 17)), ColorSequenceKeypoint.new(1, Color3.fromRGB(89, 255, 100)) }), Rotation = -90 })
				I[9] = new("UIStroke", I[6], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(0, 63, 4), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.075 })
				I[10] = new("ImageLabel", I[6], "InletTexture", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://118449132151095"), ImageTransparency = 0.64, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromScale(0.5, 0.5), ZIndex = 0 })
				I[11] = new("ImageLabel", I[6], "BevelEffect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112886786873408"), ImageTransparency = 0.06, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(13, 13, 129, 129), SliceScale = 0.2, ZIndex = 0 })
				I[12] = new("TextLabel", I[6], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000002, 0.4377289), Size = UDim2.fromScale(1.5, 1.475456), Text = "+", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[13] = new("UIStroke", I[12], "UIStroke", { Color = Color3.fromRGB(0, 63, 4), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.045 })
					I[14] = new("TextLabel", I[12], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.465), Size = UDim2.fromScale(1, 1), Text = "+", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[15] = new("UIStroke", I[14], "UIStroke", { Color = Color3.fromRGB(0, 63, 4), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.045 })
			I[16] = new("TextLabel", I[5], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(0, 1), Text = "Your inventory is full", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
			I[17] = new("UIListLayout", I[5], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[18] = new("TextButton", I[5], "DevProductInventoryX10", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(238, 228, 218), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 10, Position = UDim2.fromScale(0.7, 0.4999999), Size = UDim2.fromScale(0.4892738, 0.7752729), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false }, nil, { "ClickSFX" })
				I[19] = new("ImageLabel", I[18], "InletTexture", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://118449132151095"), ImageTransparency = 0.64, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromScale(0.5, 0.5), ZIndex = 0 })
				I[20] = new("ImageLabel", I[18], "BevelEffect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112886786873408"), ImageTransparency = 0.06, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(13, 13, 129, 129), SliceScale = 0.2, ZIndex = 0 })
				I[21] = new("TextLabel", I[18], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000002, 0.4377289), Size = UDim2.fromScale(1.5, 1.475456), Text = "+", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[22] = new("UIStroke", I[21], "UIStroke", { Color = Color3.fromRGB(0, 63, 4), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.045 })
					I[23] = new("TextLabel", I[21], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.465), Size = UDim2.fromScale(1, 1), Text = "+", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[24] = new("UIStroke", I[23], "UIStroke", { Color = Color3.fromRGB(0, 63, 4), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.045 })
				I[25] = new("UIAspectRatioConstraint", I[18], "UIAspectRatioConstraint")
				I[26] = new("UIGradient", I[18], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 98)), ColorSequenceKeypoint.new(0.1111111, Color3.fromRGB(0, 229, 240)), ColorSequenceKeypoint.new(0.2222222, Color3.fromRGB(2, 70, 255)), ColorSequenceKeypoint.new(0.3333333, Color3.fromRGB(101, 0, 255)), ColorSequenceKeypoint.new(0.4444444, Color3.fromRGB(247, 0, 236)), ColorSequenceKeypoint.new(0.5555556, Color3.fromRGB(255, 2, 77)), ColorSequenceKeypoint.new(0.6666667, Color3.fromRGB(255, 95, 0)), ColorSequenceKeypoint.new(0.7777778, Color3.fromRGB(225, 237, 0)), ColorSequenceKeypoint.new(0.8888889, Color3.fromRGB(75, 255, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 98)) }) }, nil, { "InfiniteGradient" })
				I[27] = new("UIStroke", I[18], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.075 })
					I[28] = new("UIGradient", I[27], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 98)), ColorSequenceKeypoint.new(0.1111111, Color3.fromRGB(0, 229, 240)), ColorSequenceKeypoint.new(0.2222222, Color3.fromRGB(2, 70, 255)), ColorSequenceKeypoint.new(0.3333333, Color3.fromRGB(101, 0, 255)), ColorSequenceKeypoint.new(0.4444444, Color3.fromRGB(247, 0, 236)), ColorSequenceKeypoint.new(0.5555556, Color3.fromRGB(255, 2, 77)), ColorSequenceKeypoint.new(0.6666667, Color3.fromRGB(255, 95, 0)), ColorSequenceKeypoint.new(0.7777778, Color3.fromRGB(225, 237, 0)), ColorSequenceKeypoint.new(0.8888889, Color3.fromRGB(75, 255, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 98)) }) }, nil, { "InfiniteGradient" })
		I[29] = new("IntValue", I[1], "VAL_OBJ", { Value = 1 })
	return I[1]
end

return build
