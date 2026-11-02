-- Generated from ui/StarterGui/LikeBoardGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "LikeBoardGui", { Brightness = 3, ClipsDescendants = true, MaxDistance = 200, PixelsPerStud = 30, ResetOnSpawn = false, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, ZOffset = -1 })
		I[2] = new("Frame", I[1], "Background", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = -1 })
			I[3] = new("Frame", I[2], "BG", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(171, 171, 171), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false })
				I[4] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(19, 41, 54)), ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 47, 63)) }), Rotation = -90 })
			I[5] = new("Frame", I[2], "BottomBar", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.15), ZIndex = 2 })
				I[6] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(19, 41, 54)), ColorSequenceKeypoint.new(0.942907, Color3.fromRGB(47, 95, 93)), ColorSequenceKeypoint.new(1, Color3.fromRGB(71, 157, 207)) }), Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.609238, 0.35), NumberSequenceKeypoint.new(1, 0.2875) }) })
			I[7] = new("Frame", I[2], "TopBar", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(171, 171, 171), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.2), ZIndex = 2 })
				I[8] = new("UIGradient", I[7], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(19, 41, 54)), ColorSequenceKeypoint.new(0.942907, Color3.fromRGB(0, 161, 176)), ColorSequenceKeypoint.new(1, Color3.fromRGB(71, 157, 207)) }), Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.609238, 0.35), NumberSequenceKeypoint.new(1, 0.2875) }) })
		I[9] = new("Frame", I[1], "MainFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
			I[10] = new("Frame", I[9], "Progress", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.76), Size = UDim2.fromScale(1, 0.125) })
				I[11] = new("Frame", I[10], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 95, 127), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.7, 0.7) })
					I[12] = new("Frame", I[11], "Bar", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(0, 190, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.90006, 1) })
						I[13] = new("UICorner", I[12], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
						I[14] = new("UIGradient", I[12], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(152, 152, 152)) }), Rotation = 90 })
					I[15] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[16] = new("UIStroke", I[11], "UIStroke", { Thickness = 7.3000002, Transparency = 0.25 })
					I[17] = new("UIGradient", I[11], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(152, 152, 152)) }), Rotation = -90 })
				I[18] = new("TextLabel", I[10], "NextReward", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.763, 1.9), Size = UDim2.fromScale(0.375, 0.5), Text = "Next reward:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 0.5, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 2 })
					I[19] = new("UIStroke", I[18], "UIStroke", { Thickness = 2, Transparency = 0.875 })
				I[20] = new("Frame", I[10], "Reward", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.85, 1.9), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
					I[21] = new("Frame", I[20], "FakeKeys", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
						I[22] = new("ImageButton", I[21], "Reward", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
							I[23] = new("ImageLabel", I[22], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(165, 165, 165), ImageContent = Content.fromUri("rbxassetid://115320188590205"), Position = UDim2.fromScale(0.5, 0.45), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.25, 1.25) })
							I[24] = new("TextLabel", I[22], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.75), Size = UDim2.fromScale(0.9, 0.4), Text = "???", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
								I[25] = new("UIStroke", I[24], "UIStroke", { Thickness = 2, Transparency = 0.75 })
				I[26] = new("TextLabel", I[10], "Progress", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.2, 0.5), Text = "400/1000", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 0.01, TextWrapped = true, ZIndex = 2 })
					I[27] = new("UIStroke", I[26], "UIStroke", { Color = Color3.fromRGB(0, 19, 63), Thickness = 6.3000002 })
				I[28] = new("TextLabel", I[10], "Percent", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.15, 1), Text = "90%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 2 })
					I[29] = new("UIStroke", I[28], "UIStroke", { Color = Color3.fromRGB(0, 29, 39), Thickness = 2, Transparency = 0.5 })
			I[30] = new("Frame", I[9], "Reward", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.525), Size = UDim2.fromScale(0.375, 0.375), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[31] = new("Frame", I[30], "RewardSlot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
					I[32] = new("ImageButton", I[31], "Reward", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
						I[33] = new("ImageLabel", I[32], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(159, 159, 159), ImageContent = Content.fromUri("rbxassetid://90890990412928"), Position = UDim2.fromScale(0.5, 0.45), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.9, 0.9) })
						I[34] = new("TextLabel", I[32], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.75), Size = UDim2.fromScale(0.9, 0.4), Text = "×3", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 2 })
							I[35] = new("UIStroke", I[34], "UIStroke", { Thickness = 2, Transparency = 0.75 })
						I[36] = new("Frame", I[32], "Weapon", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.875, 0.125), Size = UDim2.fromScale(0.75, 0.5), Visible = false })
							I[37] = new("Frame", I[36], "Container", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(0.5, 0.5) })
								I[38] = new("ImageLabel", I[37], "Outline", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(127, 127, 127), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(100, 255, 50), ImageTransparency = 0.25, Position = UDim2.fromScale(0, 1), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, ZIndex = 0 })
									I[39] = new("UICorner", I[38], "UICorner", { BottomLeftRadius = UDim.new(0, 4), BottomRightRadius = UDim.new(0, 4), TopLeftRadius = UDim.new(0, 4), TopRightRadius = UDim.new(0, 4) })
									I[40] = new("UIStroke", I[38], "UIStroke", { Color = Color3.fromRGB(127, 127, 127), Thickness = 2 })
										I[41] = new("UIGradient", I[40], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = -90 })
								I[42] = new("CanvasGroup", I[37], "IconCanvas", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(1, 1) })
									I[43] = new("ImageLabel", I[42], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://93712055208920"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(4, 4) })
									I[44] = new("UICorner", I[42], "UICorner", { BottomLeftRadius = UDim.new(0, 6), BottomRightRadius = UDim.new(0, 6), TopLeftRadius = UDim.new(0, 6), TopRightRadius = UDim.new(0, 6) })
								I[45] = new("ImageLabel", I[37], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(127, 127, 127), ImageContent = Content.fromUri("rbxassetid://74173287212106"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.25, ZIndex = 0 })
									I[46] = new("UIGradient", I[45], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }), Rotation = -90 })
							I[47] = new("UICorner", I[36], "UICorner")
			I[48] = new("TextLabel", I[9], "CurrentCode", { AnchorPoint = Vector2.new(0, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.45, 0.275), Size = UDim2.fromScale(0.45, 0.135), Text = "FREE154", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[49] = new("UIStroke", I[48], "UIStroke", { Color = Color3.fromRGB(2, 0, 56), Thickness = 5.3000002 })
			I[50] = new("TextLabel", I[9], "Description", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.425, 0.275), Size = UDim2.fromScale(0.75, 0.075), Text = "Code:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 0.5, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
				I[51] = new("UIStroke", I[50], "UIStroke", { Color = Color3.fromRGB(2, 0, 56), Thickness = 5.3000002 })
			I[52] = new("TextLabel", I[9], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.1), Size = UDim2.fromScale(0.75, 0.2), Text = "👍   Like the game!   👍", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 28, TextWrapped = true })
				I[53] = new("UIStroke", I[52], "UIStroke", { Color = Color3.fromRGB(2, 0, 56), Thickness = 5.3000002 })
		I[54] = new("Frame", I[1], "Waiting", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false })
			I[55] = new("Frame", I[54], "Dots", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 0.5), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[56] = new("UIAspectRatioConstraint", I[55], "UIAspectRatioConstraint")
				I[57] = new("ImageLabel", I[55], "1", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(114, 140, 255), ImageContent = Content.fromUri("rbxassetid://77916637497593"), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.333, 0.333) })
				I[58] = new("UIListLayout", I[55], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[59] = new("ImageLabel", I[55], "2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(114, 140, 255), ImageContent = Content.fromUri("rbxassetid://77916637497593"), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.333, 0.333) })
				I[60] = new("ImageLabel", I[55], "3", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(114, 140, 255), ImageContent = Content.fromUri("rbxassetid://77916637497593"), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.333, 0.333) })
	return I[1]
end

return build
