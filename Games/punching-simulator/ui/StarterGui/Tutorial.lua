-- Generated from ui/StarterGui/Tutorial.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Tutorial", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 47, 182), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6, 0.6), Visible = false, ZIndex = 0 })
			I[3] = new("ImageButton", I[2], "Tutorial", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("rbxassetid://12489985753"), ImageTransparency = 1, Position = UDim2.fromScale(0.9954257, 0.0446514), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.09, 0.175), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 2, ZIndex = 6 }, nil, { "PopButton", "UIToggleButton" })
				I[4] = new("UIPadding", I[3], "UIPadding", { PaddingBottom = UDim.new(-0.05, 0) })
				I[5] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[6] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.64, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(188, 4, 0)) }), Rotation = 90 })
				I[7] = new("UIStroke", I[3], "UIStroke", { Thickness = 3 })
				I[8] = new("ImageLabel", I[3], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13704067744"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.55, 0.55), ZIndex = 6 })
				I[9] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint")
			I[10] = new("UIStroke", I[2], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5 })
			I[11] = new("Frame", I[2], "Top", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.0473147), Size = UDim2.fromScale(1.0000002, 0.0946295) })
				I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 4 })
				I[13] = new("UIGradient", I[11], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(234, 248, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 144, 0)) }), Rotation = 90 })
			I[14] = new("Frame", I[2], "Dark", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 5 })
			I[15] = new("TextLabel", I[2], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.055), Size = UDim2.fromScale(0.8, 0.06), Text = "TUTORIAL", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
				I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 2 })
				I[17] = new("TextLabel", I[15], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), Text = "TUTORIAL", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
					I[18] = new("UIStroke", I[17], "UIStroke", { Thickness = 2 })
			I[19] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.5383693 })
			I[20] = new("Frame", I[2], "Pages", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 0.9) })
				I[21] = new("Frame", I[20], "1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[22] = new("Frame", I[21], "Content", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(157, 147, 238), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.4221137), Size = UDim2.fromScale(0.9750001, 0.7274184), ZIndex = 0 })
						I[23] = new("Frame", I[22], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 80, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.6131676), Size = UDim2.fromScale(1, 1.3105454), ZIndex = 0 })
							I[24] = new("Frame", I[23], "Container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(157, 147, 238), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromScale(1.0000001, 0.8471602) })
								I[25] = new("Frame", I[24], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(157, 147, 238), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
									I[26] = new("UIListLayout", I[25], "UIListLayout", { Padding = UDim.new(0.025, 0), SortOrder = Enum.SortOrder.LayoutOrder })
				I[27] = new("UIPageLayout", I[20], "UIPageLayout", { EasingStyle = Enum.EasingStyle.Quart, GamepadInputEnabled = false, ScrollWheelInputEnabled = false, SortOrder = Enum.SortOrder.LayoutOrder, TouchInputEnabled = false, TweenTime = 0.5 })
			I[28] = new("ImageButton", I[2], "Skip", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.91), Selectable = false, Size = UDim2.fromScale(0.3, 0.09821) }, nil, { "PopButton" })
				I[29] = new("TextLabel", I[28], "Number", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.6), Size = UDim2.fromScale(1, 0.6), Text = "NEXT >>", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
					I[30] = new("UIStroke", I[29], "UIStroke", { Thickness = 1.5 })
					I[31] = new("TextLabel", I[29], "Number", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), Text = "NEXT >>", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 3 })
						I[32] = new("UIStroke", I[31], "UIStroke", { Thickness = 1.5 })
				I[33] = new("UIPadding", I[28], "UIPadding", { PaddingBottom = UDim.new(0.05, 0), PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0), PaddingTop = UDim.new(0.05, 0) })
				I[34] = new("UIStroke", I[28], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
				I[35] = new("UIGradient", I[28], "Select", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(6, 255, 0)), ColorSequenceKeypoint.new(0.4966667, Color3.fromRGB(53, 243, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(1, 229, 17)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 201, 15)) }), Rotation = 90 })
			I[36] = new("Frame", I[2], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 80, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5539905), Size = UDim2.fromScale(0.9750001, 0.8579834), ZIndex = 0 })
	return I[1]
end

return build
