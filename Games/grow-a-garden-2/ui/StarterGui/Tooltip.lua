-- Generated from ui/StarterGui/Tooltip.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Tooltip", { DisplayOrder = 1000, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Tooltip", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.7531136, 0.2858616), Size = UDim2.fromScale(0.175, 0.15), Visible = false })
			I[3] = new("ImageLabel", I[2], "BevelEffect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112886786873408"), ImageTransparency = 0.69, Position = UDim2.fromScale(0.5, 0.5017465), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(13, 13, 129, 129), SliceScale = 0.2, ZIndex = -9999 })
			I[4] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(121, 62, 35)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(153, 77, 44)), ColorSequenceKeypoint.new(1, Color3.fromRGB(121, 62, 35)) }) })
			I[5] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(40, 27, 0), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.025 })
			I[6] = new("TextLabel", I[2], "ItemName", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.645, 0.0835159), Size = UDim2.fromScale(0.6432573, 0.2838531), Text = "Super Strawberry", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top })
				I[7] = new("UIStroke", I[6], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.065 })
			I[8] = new("TextLabel", I[2], "Rarity", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.645, 0.3815615), Size = UDim2.fromScale(0.6432572, 0.1917307), Text = "LEGENDARY", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top })
				I[9] = new("UIStroke", I[8], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.08 })
			I[10] = new("TextLabel", I[2], "Price", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9703208, 0.9219893), Size = UDim2.fromScale(0.6469504, 0.285), Text = "Base: $4,500", TextColor3 = Color3.fromRGB(38, 255, 0), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
				I[11] = new("UIStroke", I[10], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.065 })
			I[12] = new("Frame", I[2], "ItemImage", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(39, 20, 11), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.03, 0.5), Size = UDim2.fromScale(0.2643892, 0.8329681) })
				I[13] = new("UIStroke", I[12], "UIStroke", { Color = Color3.fromRGB(22, 9, 0), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.02 })
				I[14] = new("ImageLabel", I[12], "BevelEffect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://112886786873408"), ImageTransparency = 0.69, Position = UDim2.fromScale(0.5, 0.5017465), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(13, 13, 129, 129), SliceScale = 0.3, ZIndex = 0 })
				I[15] = new("ImageLabel", I[12], "Sunburst", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(76, 39, 21), ImageContent = Content.fromUri("rbxassetid://72721804838845"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.1, 1.1) })
				I[16] = new("ImageLabel", I[12], "Vector", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://137797876079469"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9) })
				I[17] = new("UIAspectRatioConstraint", I[12], "UIAspectRatioConstraint")
			I[18] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 2.5 })
		I[19] = new("Frame", I[1], "TextTooltip", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.753, 0.5), Size = UDim2.fromScale(0.175, 0.15), Visible = false })
			I[20] = new("ImageLabel", I[19], "BevelEffect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112886786873408"), ImageTransparency = 0.69, Position = UDim2.fromScale(0.5, 0.5017465), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(13, 13, 129, 129), SliceScale = 0.2, ZIndex = -9999 })
			I[21] = new("UIGradient", I[19], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(121, 62, 35)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(153, 77, 44)), ColorSequenceKeypoint.new(1, Color3.fromRGB(121, 62, 35)) }) })
			I[22] = new("UIStroke", I[19], "UIStroke", { Color = Color3.fromRGB(40, 27, 0), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.025 })
			I[23] = new("TextLabel", I[19], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.95, 0.95), Text = "Text Tooltip", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[24] = new("UIStroke", I[23], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.065 })
			I[25] = new("UIAspectRatioConstraint", I[19], "UIAspectRatioConstraint", { AspectRatio = 4.1900001 })
	return I[1]
end

return build
