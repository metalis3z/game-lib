-- Generated from ui/StarterGui/RollFrame_New.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "RollFrame_New", { Enabled = false, ResetOnSpawn = false, SafeAreaCompatibility = Enum.SafeAreaCompatibility.None, ScreenInsets = Enum.ScreenInsets.None, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5165269), Size = UDim2.fromScale(1, 0.4179462) })
			I[3] = new("Frame", I[2], "Spinner", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.9) })
				I[4] = new("UIListLayout", I[3], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.02, 0), SortOrder = Enum.SortOrder.LayoutOrder })
					I[5] = new("Frame", I[4], "Template", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(156, 156, 156), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0.249), Size = UDim2.fromScale(1, 1), Visible = false })
						I[6] = new("TextLabel", I[5], "ItemName", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.028), Size = UDim2.fromScale(0.943957, 0.1752177), Text = "Berry Seed", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 3 })
							I[7] = new("UIStroke", I[6], "UIStroke", { Color = Color3.fromRGB(40, 22, 1), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.045 })
						I[8] = new("ImageLabel", I[5], "BevelEffect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112886786873408"), ImageTransparency = 0.48, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(13, 13, 129, 129), SliceScale = 0.25, ZIndex = 0 })
						I[9] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(121, 62, 35)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(153, 77, 44)), ColorSequenceKeypoint.new(1, Color3.fromRGB(121, 62, 35)) }) })
						I[10] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(40, 27, 0), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.012 })
						I[11] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint")
						I[12] = new("ImageLabel", I[5], "Image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://114229465393296"), Position = UDim2.fromScale(0.5000002, 0.5758211), Size = UDim2.fromScale(0.7, 0.7) })
						I[13] = new("ImageLabel", I[5], "Sunburst", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(222, 112, 61), ImageContent = Content.fromUri("rbxassetid://72721804838845"), Position = UDim2.fromScale(0.5, 0.575821), Size = UDim2.fromScale(1, 1), ZIndex = 0 })
				I[14] = new("UIPadding", I[3], "UIPadding", { PaddingBottom = UDim.new(0.02, 0), PaddingTop = UDim.new(0.02, 0) })
			I[15] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(121, 62, 35)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(153, 77, 44)), ColorSequenceKeypoint.new(1, Color3.fromRGB(121, 62, 35)) }) })
			I[16] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(40, 27, 0), Thickness = 2 })
			I[17] = new("ImageLabel", I[2], "BevelEffect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112886786873408"), ImageTransparency = 0.2, Position = UDim2.fromScale(0.5, 0.498627), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(13, 13, 129, 128), SliceScale = 0.3, ZIndex = 0 })
			I[18] = new("ImageLabel", I[2], "InletTexture", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://118449132151095"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromScale(0.045, 0.2), ZIndex = -9 })
			I[19] = new("ImageLabel", I[2], "PointerArrow", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://80458369152321"), Position = UDim2.fromScale(0.5, -0.1001949), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.046, 0.149) })
				I[20] = new("UIGradient", I[19], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.417962, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 222, 189)) }), Rotation = 90 })
			I[21] = new("ImageLabel", I[2], "PointerArrow", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://110831929486490"), Position = UDim2.fromScale(0.4992676, 0.9499999), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.0463387, 0.1494436) })
				I[22] = new("UIGradient", I[21], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.417962, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 222, 189)) }), Rotation = 90 })
		I[23] = new("Frame", I[1], "BlackBackdrop", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 0 })
			I[24] = new("TextLabel", I[23], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.1195896), Size = UDim2.fromScale(0.7, 0.0971792), Text = "Opening Seed Pack...", TextColor3 = Color3.fromRGB(62, 34, 2), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[25] = new("TextLabel", I[24], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromScale(1, 1), Text = "Opening Seed Pack...", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[26] = new("UIGradient", I[25], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.417962, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 222, 189)) }), Rotation = 90 })
					I[27] = new("UIStroke", I[25], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.045 })
				I[28] = new("UIStroke", I[24], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.045 })
			I[29] = new("TextButton", I[23], "SkipButton", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(238, 228, 218), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = -9, Position = UDim2.fromScale(0.5, 0.95), Size = UDim2.fromScale(0.2233204, 0.2377308), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[30] = new("UIGradient", I[29], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(57, 179, 0)), ColorSequenceKeypoint.new(0.1468048, Color3.fromRGB(57, 179, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }), Rotation = -90 })
				I[31] = new("ImageLabel", I[29], "InletTexture", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://118449132151095"), ImageTransparency = 0.64, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromScale(0.175, 0.525), ZIndex = 0 })
				I[32] = new("UIStroke", I[29], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(20, 48, 0), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.045 })
				I[33] = new("ImageLabel", I[29], "BevelEffect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112886786873408"), ImageTransparency = 0.08, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(13, 13, 129, 129), SliceScale = 0.25, ZIndex = 0 })
				I[34] = new("UIAspectRatioConstraint", I[29], "UIAspectRatioConstraint", { AspectRatio = 3 })
				I[35] = new("TextLabel", I[29], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.475, 0.55), Size = UDim2.fromScale(0.9, 0.85), Text = "Skip", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[36] = new("UIStroke", I[35], "UIStroke", { Color = Color3.fromRGB(20, 48, 0), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.045 })
					I[37] = new("TextLabel", I[35], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromScale(1, 1), Text = "Skip", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[38] = new("UIStroke", I[37], "UIStroke", { Color = Color3.fromRGB(20, 48, 0), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.045 })
						I[39] = new("UIGradient", I[37], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.417962, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(209, 255, 208)) }), Rotation = 90 })
	return I[1]
end

return build
