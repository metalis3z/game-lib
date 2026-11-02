-- Generated from ui/StarterGui/RunCharge.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "RunCharge", { DisplayOrder = 30, Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.721, 0.5), Size = UDim2.fromScale(0.039, 0.463) })
			I[3] = new("ImageLabel", I[2], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://128513130493559"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1.1, 1), SliceCenter = Rect.new(512, 64, 512, 64), Visible = false, ZIndex = -10000 })
			I[4] = new("CanvasGroup", I[2], "CanvasGroup", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = -150 })
				I[5] = new("Frame", I[4], "Bar", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 255, 38), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.5970343), ZIndex = -150 })
					I[6] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(209, 209, 209)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(214, 214, 214)) }) })
				I[7] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
				I[8] = new("Frame", I[4], "Rows", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, 4, 1, 4), ZIndex = 1000 })
					I[9] = new("Frame", I[8], "Frame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(54, 54, 54), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.fromScale(0.5, 0.1927104), Size = UDim2.fromScale(1, 0.01), ZIndex = 5 })
					I[10] = new("Frame", I[8], "Frame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(54, 54, 54), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.fromScale(0.5, 0.5974904), Size = UDim2.fromScale(1, 0.01), ZIndex = 5 })
					I[11] = new("Frame", I[8], "Frame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(54, 54, 54), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.fromScale(0.5, 0.3951004), Size = UDim2.fromScale(1, 0.01), ZIndex = 5 })
					I[12] = new("Frame", I[8], "Frame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(54, 54, 54), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.fromScale(0.5, 0.7998804), Size = UDim2.fromScale(1, 0.01), ZIndex = 5 })
			I[13] = new("Frame", I[2], "Top", { BackgroundColor3 = Color3.fromRGB(34, 255, 0), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.1), ZIndex = 10 })
				I[14] = new("UIGradient", I[13], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) }) })
				I[15] = new("UIStroke", I[13], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(0, 255, 200), Thickness = 2 })
					I[16] = new("UIGradient", I[15], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) }) })
				I[17] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
			I[18] = new("TextLabel", I[2], "QuestLabel", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 1, 5), Size = UDim2.new(4, 0, 0, 12), Text = "CHARGE", TextColor3 = Color3.fromRGB(0, 255, 51), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
				I[19] = new("UIStroke", I[18], "UIStroke", { Color = Color3.fromRGB(33, 33, 33), Thickness = 1.6 })
			I[20] = new("Frame", I[2], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 50000 })
				I[21] = new("Frame", I[20], "Bottom", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(1, 6, 1, 0), Size = UDim2.new(4, 0, 0, 13), Visible = false })
					I[22] = new("TextLabel", I[21], "BaseLuck", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(0, 1), Text = "x1 Luck", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[23] = new("UIStroke", I[22], "UIStroke", { Color = Color3.fromRGB(33, 33, 33), Thickness = 1.6 })
					I[24] = new("Frame", I[21], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -100, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
						I[25] = new("ImageLabel", I[24], "Vector", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://88691288219384"), ImageTransparency = 0.5, Rotation = 90, Size = UDim2.fromScale(1, 1) })
					I[26] = new("UIListLayout", I[21], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[27] = new("UICorner", I[20], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
				I[28] = new("Frame", I[20], "Top", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(1, 6, 0, 0), Size = UDim2.new(6, 0, 0, 20) })
					I[29] = new("TextLabel", I[28], "BaseLuck", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(0, 1), Text = "x2 Speed", TextColor3 = Color3.fromRGB(255, 238, 0), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[30] = new("UIStroke", I[29], "UIStroke", { Color = Color3.fromRGB(125, 77, 0), Thickness = 1.5, Transparency = 0.2 }, { ["oldp_Thickness"] = 1.6 })
					I[31] = new("Frame", I[28], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -100, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
						I[32] = new("ImageLabel", I[31], "Vector", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://88691288219384"), ImageTransparency = 0.5, Position = UDim2.fromOffset(0, 2), Rotation = 90, Size = UDim2.fromScale(1, 1) })
						I[33] = new("TextLabel", I[31], "Below", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, 5, 1, 0), Size = UDim2.fromScale(5, 0.7), Text = "BOOST", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
							I[34] = new("UIStroke", I[33], "UIStroke", { Thickness = 1.6, Transparency = 0.5 })
					I[35] = new("UIScale", I[28], "UIScale")
					I[36] = new("UIListLayout", I[28], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
						I[37] = new("UIGradient", I[36], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(56, 255, 69)), ColorSequenceKeypoint.new(1, Color3.fromRGB(26, 255, 141)) }), Enabled = false, Rotation = 64 })
			I[38] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
			I[39] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 0.15 })
			I[40] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://121310049691302"), ImageTransparency = 0.49, Size = UDim2.fromScale(1, 1), ZIndex = -1000 })
				I[41] = new("UICorner", I[40], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
			I[42] = new("Frame", I[2], "Background", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = -10000 })
				I[43] = new("UICorner", I[42], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
			I[44] = new("UIStroke", I[2], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.07 })
			I[45] = new("Frame", I[2], "ChargeResultEffects", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, -0.15), Size = UDim2.fromScale(5.177206, 0.1712326) })
				I[46] = new("TextLabel", I[45], "Perfect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "PERFECT!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
					I[47] = new("UIStroke", I[46], "UIStroke", { Color = Color3.fromRGB(132, 66, 66), Thickness = 3.5999999 })
					I[48] = new("UIGradient", I[46], "Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.142857, Color3.fromRGB(255, 127, 0)), ColorSequenceKeypoint.new(0.285714, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.428571, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.571429, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.714286, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.857143, Color3.fromRGB(255, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }), Rotation = -14 }, { ["__custom_rotation"] = -35 })
				I[49] = new("TextLabel", I[45], "Excellent", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "EXCELLENT!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
					I[50] = new("UIStroke", I[49], "UIStroke", { Color = Color3.fromRGB(103, 0, 132), Thickness = 3.5999999 })
						I[51] = new("UIGradient", I[50], "Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 153, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 29, 251)) }), Rotation = 100 })
					I[52] = new("UIGradient", I[49], "Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 0, 255)), ColorSequenceKeypoint.new(0.2404844, Color3.fromRGB(255, 0, 255)), ColorSequenceKeypoint.new(0.4013841, Color3.fromRGB(255, 85, 255)), ColorSequenceKeypoint.new(0.6262976, Color3.fromRGB(255, 85, 255)), ColorSequenceKeypoint.new(0.799308, Color3.fromRGB(255, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 0, 255)) }), Rotation = -99 })
				I[53] = new("TextLabel", I[45], "Good", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "Good!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
					I[54] = new("UIStroke", I[53], "UIStroke", { Color = Color3.fromRGB(0, 35, 132), Thickness = 3.5999999 })
					I[55] = new("UIGradient", I[53], "Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 136, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 132, 255)) }), Rotation = 123 })
				I[56] = new("TextLabel", I[45], "Great", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "GREAT!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
					I[57] = new("UIStroke", I[56], "UIStroke", { Color = Color3.fromRGB(132, 81, 0), Thickness = 3.5999999 })
					I[58] = new("UIGradient", I[56], "Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 1)), ColorSequenceKeypoint.new(0.2629758, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.3321799, Color3.fromRGB(255, 200, 0)), ColorSequenceKeypoint.new(0.4186851, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.5155709, Color3.fromRGB(255, 255, 127)), ColorSequenceKeypoint.new(0.5968859, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.6591696, Color3.fromRGB(255, 217, 0)), ColorSequenceKeypoint.new(0.7785468, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 170, 0)) }), Rotation = -35 })
				I[59] = new("TextLabel", I[45], "Bad", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "Bad", TextColor3 = Color3.fromRGB(255, 103, 103), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
					I[60] = new("UIStroke", I[59], "UIStroke", { Color = Color3.fromRGB(132, 0, 0), Thickness = 3.5999999 })
					I[61] = new("UIGradient", I[59], "Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 136, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 132, 255)) }), Enabled = false, Rotation = 123 })
				I[62] = new("TextLabel", I[45], "Mid", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "Mid!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
					I[63] = new("UIStroke", I[62], "UIStroke", { Color = Color3.fromRGB(132, 81, 0), Thickness = 3.5999999 })
					I[64] = new("UIGradient", I[62], "Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 1)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 170, 0)) }), Rotation = -35 })
	return I[1]
end

return build
