-- Generated from ui/StarterPlayer/StarterPlayerScripts/ProximityPromptScript/Default.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Default", { Active = true, AlwaysOnTop = true, Enabled = false, MaxDistance = 30, Size = UDim2.fromOffset(193, 72), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["Theme"] = "" })
		I[2] = new("TextButton", I[1], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Selectable = false, Size = UDim2.fromScale(1, 1), TextTransparency = 1, ZIndex = 5 })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 2.6805556 })
		I[4] = new("CanvasGroup", I[1], "LongPrompt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(11, 11, 11), BackgroundTransparency = 0.75, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[5] = new("ImageLabel", I[4], "Keybind", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://90511066205924"), ImageTransparency = 0.65, Position = UDim2.new(0, 10, 0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(50, 50), ZIndex = 7 })
				I[6] = new("TextLabel", I[5], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187361378", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(0.45, 0.8), Text = "E", TextColor3 = Color3.fromRGB(221, 221, 221), TextScaled = true, TextSize = 14, TextTransparency = 0.35, TextWrapped = true, ZIndex = 6 })
				I[7] = new("ImageLabel", I[5], "ButtonImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[8] = new("UIAspectRatioConstraint", I[7], "UIAspectRatioConstraint")
				I[9] = new("ImageLabel", I[5], "ButtonTextImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[10] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint")
				I[11] = new("UIGradient", I[5], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.10567, 0.768421), NumberSequenceKeypoint.new(0.113402, 0.657895), NumberSequenceKeypoint.new(0.248711, 1), NumberSequenceKeypoint.new(0.606959, 0.684211), NumberSequenceKeypoint.new(0.878866, 0.926316), NumberSequenceKeypoint.new(1, 0) }) })
			I[12] = new("TextLabel", I[4], "ObjectText", { BackgroundColor3 = Color3.fromRGB(249, 248, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187369639", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.34, 0.24), Size = UDim2.fromScale(0.61, 0.3), Text = "Object Text", TextColor3 = Color3.fromRGB(178, 178, 178), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
			I[13] = new("TextLabel", I[4], "ActionText", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(249, 248, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187361116", Enum.FontWeight.Medium, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.34, 0.65), Size = UDim2.fromScale(0.61, 0.3), Text = "Action Text", TextColor3 = Color3.fromRGB(122, 122, 122), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
			I[14] = new("ImageLabel", I[4], "Vignette", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://74597409610151"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.96, 0.9), SliceCenter = Rect.new(160, 146, 426, 237), SliceScale = 0.1, ZIndex = -1 })
			I[15] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
			I[16] = new("UIStroke", I[4], "UIStroke", { BorderOffset = UDim.new(-0.03, 0), BorderStrokePosition = Enum.BorderStrokePosition.Inner, Color = Color3.fromRGB(255, 255, 255), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.02, Transparency = 0.85 })
				I[17] = new("UIGradient", I[16], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.10567, 0.768421), NumberSequenceKeypoint.new(0.41366, 0.847368), NumberSequenceKeypoint.new(0.506443, 1), NumberSequenceKeypoint.new(0.856959, 0.836842), NumberSequenceKeypoint.new(1, 0) }) })
			I[18] = new("ImageLabel", I[4], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://6150493168"), ImageTransparency = 0.14, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1.2, 1.2), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.4, ZIndex = -10 })
				I[19] = new("UIGradient", I[18], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.391753, 0.389474), NumberSequenceKeypoint.new(1, 0) }) })
			I[20] = new("Frame", I[4], "Fill", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.7, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.95, 0.9) })
				I[21] = new("UICorner", I[20], "UICorner", { BottomLeftRadius = UDim.new(0.105, 0), BottomRightRadius = UDim.new(0.105, 0), TopLeftRadius = UDim.new(0.105, 0), TopRightRadius = UDim.new(0.105, 0) })
				I[22] = new("UIGradient", I[20], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.0025773, 1), NumberSequenceKeypoint.new(1, 1) }) })
		I[23] = new("NumberValue", I[1], "Progress")
		I[24] = new("CanvasGroup", I[1], "SquarePrompt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(11, 11, 11), BackgroundTransparency = 0.75, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, GroupTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.38, 1) })
			I[25] = new("ImageLabel", I[24], "Keybind", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://90511066205924"), ImageTransparency = 0.65, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.65, 0.65), ZIndex = 7 })
				I[26] = new("TextLabel", I[25], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187361378", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(0.45, 0.8), Text = "E", TextColor3 = Color3.fromRGB(221, 221, 221), TextScaled = true, TextSize = 14, TextTransparency = 0.35, TextWrapped = true, ZIndex = 6 })
				I[27] = new("ImageLabel", I[25], "ButtonImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[28] = new("UIAspectRatioConstraint", I[27], "UIAspectRatioConstraint")
				I[29] = new("ImageLabel", I[25], "ButtonTextImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[30] = new("UIAspectRatioConstraint", I[29], "UIAspectRatioConstraint")
				I[31] = new("UIGradient", I[25], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.10567, 0.768421), NumberSequenceKeypoint.new(0.113402, 0.657895), NumberSequenceKeypoint.new(0.248711, 1), NumberSequenceKeypoint.new(0.606959, 0.684211), NumberSequenceKeypoint.new(0.878866, 0.926316), NumberSequenceKeypoint.new(1, 0) }) })
				I[32] = new("UIScale", I[25], "UIScale", { Scale = 0.95 })
			I[33] = new("Frame", I[24], "Fill", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.7, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.95, 0.9) })
				I[34] = new("UICorner", I[33], "UICorner", { BottomLeftRadius = UDim.new(0.105, 0), BottomRightRadius = UDim.new(0.105, 0), TopLeftRadius = UDim.new(0.105, 0), TopRightRadius = UDim.new(0.105, 0) })
				I[35] = new("UIGradient", I[33], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.0025773, 1), NumberSequenceKeypoint.new(1, 1) }) })
			I[36] = new("ImageLabel", I[24], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://6150493168"), ImageTransparency = 0.14, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1.2, 1.2), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.4, ZIndex = -10 })
				I[37] = new("UIGradient", I[36], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.391753, 0.389474), NumberSequenceKeypoint.new(1, 0) }) })
			I[38] = new("ImageLabel", I[24], "Vignette", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://74597409610151"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.9, 0.9), SliceCenter = Rect.new(160, 146, 426, 237), SliceScale = 0.1, ZIndex = -1 })
			I[39] = new("UICorner", I[24], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
			I[40] = new("UIAspectRatioConstraint", I[24], "UIAspectRatioConstraint", { AspectRatio = 1.0186111 })
			I[41] = new("Frame", I[24], "StrokeContainer", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
				I[42] = new("UIStroke", I[41], "UIStroke", { BorderOffset = UDim.new(-0.03, 0), BorderStrokePosition = Enum.BorderStrokePosition.Inner, Color = Color3.fromRGB(255, 255, 255), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.02, Transparency = 0.85 })
					I[43] = new("UIGradient", I[42], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.10567, 0.768421), NumberSequenceKeypoint.new(0.41366, 0.847368), NumberSequenceKeypoint.new(0.506443, 1), NumberSequenceKeypoint.new(0.856959, 0.836842), NumberSequenceKeypoint.new(1, 0) }) })
	return I[1]
end

return build
