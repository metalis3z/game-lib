-- Generated from ui/ReplicatedStorage/Assets/OverheadLevelUIS/Tier9.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Tier9", { Active = true, ClipsDescendants = true, MaxDistance = 25, Size = UDim2.fromScale(6, 2), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "LevelBarGlow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://82528943718492"), ImageTransparency = 0.48, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[3] = new("Frame", I[2], "BarContainer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5000001, 0.5), Size = UDim2.fromScale(0.9, 0.2) })
				I[4] = new("Frame", I[3], "ProgressBar", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0000001, 0), Size = UDim2.fromScale(0.9095528, 1) })
					I[5] = new("ImageLabel", I[4], "BevelEffect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112886786873408"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(13, 13, 129, 129), SliceScale = 0.2, ZIndex = 99 })
					I[6] = new("UIGradient", I[4], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(227, 188, 26)), ColorSequenceKeypoint.new(0.1111111, Color3.fromRGB(219, 147, 3)), ColorSequenceKeypoint.new(0.2222222, Color3.fromRGB(239, 195, 1)), ColorSequenceKeypoint.new(0.3333333, Color3.fromRGB(231, 171, 19)), ColorSequenceKeypoint.new(0.4444444, Color3.fromRGB(227, 162, 31)), ColorSequenceKeypoint.new(0.5555556, Color3.fromRGB(235, 189, 29)), ColorSequenceKeypoint.new(0.6666667, Color3.fromRGB(241, 209, 46)), ColorSequenceKeypoint.new(0.7777778, Color3.fromRGB(244, 223, 82)), ColorSequenceKeypoint.new(0.8888889, Color3.fromRGB(238, 211, 66)), ColorSequenceKeypoint.new(1, Color3.fromRGB(227, 188, 26)) }), Rotation = -174 }, nil, { "InfiniteGradient" })
				I[7] = new("UIStroke", I[3], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.11 })
			I[8] = new("UIListLayout", I[2], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.075, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[9] = new("Frame", I[2], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.4) })
				I[10] = new("ImageLabel", I[9], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112854173028102"), LayoutOrder = 1, Size = UDim2.fromScale(1, 1) })
					I[11] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint")
				I[12] = new("TextLabel", I[9], "HeaderText", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(0.5, 1), Text = "Level 95", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
					I[13] = new("UIStroke", I[12], "UIStroke", { Color = Color3.fromRGB(0, 45, 1), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.06 })
					I[14] = new("UIPadding", I[12], "UIPadding", { PaddingLeft = UDim.new(0.025, 0), PaddingRight = UDim.new(0.025, 0) })
					I[15] = new("UIGradient", I[12], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(227, 188, 26)), ColorSequenceKeypoint.new(0.1111111, Color3.fromRGB(219, 147, 3)), ColorSequenceKeypoint.new(0.2222222, Color3.fromRGB(239, 195, 1)), ColorSequenceKeypoint.new(0.3333333, Color3.fromRGB(231, 171, 19)), ColorSequenceKeypoint.new(0.4444444, Color3.fromRGB(227, 162, 31)), ColorSequenceKeypoint.new(0.5555556, Color3.fromRGB(235, 189, 29)), ColorSequenceKeypoint.new(0.6666667, Color3.fromRGB(241, 209, 46)), ColorSequenceKeypoint.new(0.7777778, Color3.fromRGB(244, 223, 82)), ColorSequenceKeypoint.new(0.8888889, Color3.fromRGB(238, 211, 66)), ColorSequenceKeypoint.new(1, Color3.fromRGB(227, 188, 26)) }), Rotation = -174 }, nil, { "InfiniteGradient" })
				I[16] = new("UIListLayout", I[9], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[17] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(227, 188, 26)), ColorSequenceKeypoint.new(0.1111111, Color3.fromRGB(219, 147, 3)), ColorSequenceKeypoint.new(0.2222222, Color3.fromRGB(239, 195, 1)), ColorSequenceKeypoint.new(0.3333333, Color3.fromRGB(231, 171, 19)), ColorSequenceKeypoint.new(0.4444444, Color3.fromRGB(227, 162, 31)), ColorSequenceKeypoint.new(0.5555556, Color3.fromRGB(235, 189, 29)), ColorSequenceKeypoint.new(0.6666667, Color3.fromRGB(241, 209, 46)), ColorSequenceKeypoint.new(0.7777778, Color3.fromRGB(244, 223, 82)), ColorSequenceKeypoint.new(0.8888889, Color3.fromRGB(238, 211, 66)), ColorSequenceKeypoint.new(1, Color3.fromRGB(227, 188, 26)) }), Rotation = -174 }, nil, { "InfiniteGradient" })
	return I[1]
end

return build
