-- Generated from ui/ReplicatedStorage/Assets/UI/Achievement.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Achievement", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromOffset(624, 123), ZIndex = 505 })
		I[2] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(20, 93, 120), Thickness = 6 })
			I[3] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(188, 252, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(214, 252, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(197, 249, 255)) }), Rotation = 60 })
		I[4] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
		I[5] = new("ImageLabel", I[1], "AchivementIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://140644194963950"), Position = UDim2.fromScale(0.106, 0.5), Size = UDim2.fromScale(0.165, 0.777), ZIndex = 550 })
		I[6] = new("TextLabel", I[1], "AchivementName", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.3898474, 0.0683806), Size = UDim2.fromScale(0.36096, 0.3149526), Text = "Eggs I", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 552 })
			I[7] = new("UIStroke", I[6], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4.5 })
		I[8] = new("TextLabel", I[1], "AchivementDescription", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.3784462, 0.3994441), Size = UDim2.fromScale(0.3461725, 0.1799999), Text = "Hatch 100 Eggs!", TextColor3 = Color3.fromRGB(0, 32, 54), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 552 })
		I[9] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(188, 252, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(214, 252, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(197, 249, 255)) }), Rotation = 60 })
		I[10] = new("Frame", I[1], "Progress", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 32, 54), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.45, 0.7677779), Size = UDim2.fromScale(0.4847765, 0.2068091), ZIndex = 550 })
			I[11] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(0.32, 0), BottomRightRadius = UDim.new(0.32, 0), TopLeftRadius = UDim.new(0.32, 0), TopRightRadius = UDim.new(0.32, 0) })
			I[12] = new("Frame", I[10], "Bar", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.6, 1), ZIndex = 551 })
				I[13] = new("UICorner", I[12], "UICorner", { BottomLeftRadius = UDim.new(0.32, 0), BottomRightRadius = UDim.new(0.32, 0), TopLeftRadius = UDim.new(0.32, 0), TopRightRadius = UDim.new(0.32, 0) })
				I[14] = new("UIGradient", I[12], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 255, 246)), ColorSequenceKeypoint.new(1, Color3.fromRGB(37, 153, 255)) }), Rotation = 90 })
				I[15] = new("UIStroke", I[12], "UIStroke", { Color = Color3.fromRGB(0, 68, 141), Thickness = 3.5 })
			I[16] = new("UIStroke", I[10], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), Thickness = 4 })
			I[17] = new("TextLabel", I[10], "Amount", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.02, 0.5), Size = UDim2.fromScale(0.971, 0.88), Text = "0/100", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 552 })
				I[18] = new("UIStroke", I[17], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
		I[19] = new("Frame", I[1], "Rewards", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.984, 0.325), Size = UDim2.fromScale(0.1057257, 0.4972481), ZIndex = 510 })
			I[20] = new("UIGridLayout", I[19], "UIGridLayout", { CellPadding = UDim2.fromScale(0.1111111, 0.0555556), CellSize = UDim2.fromScale(0.8888889, 0.8888889), FillDirection = Enum.FillDirection.Vertical, HorizontalAlignment = Enum.HorizontalAlignment.Right, SortOrder = Enum.SortOrder.LayoutOrder })
				I[21] = new("UIAspectRatioConstraint", I[20], "UIAspectRatioConstraint")
		I[22] = new("Frame", I[1], "State", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.88, 0.76), Size = UDim2.fromScale(0.204, 0.276), ZIndex = 950 })
			I[23] = new("Frame", I[22], "Waiting", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 950 })
				I[24] = new("UIStroke", I[23], "UIStroke", { Color = Color3.fromRGB(86, 86, 86), Thickness = 5 })
				I[25] = new("UICorner", I[23], "UICorner", { BottomLeftRadius = UDim.new(0.24, 0), BottomRightRadius = UDim.new(0.24, 0), TopLeftRadius = UDim.new(0.24, 0), TopRightRadius = UDim.new(0.24, 0) })
				I[26] = new("Frame", I[23], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(80, 80, 80), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), ZIndex = 940 })
					I[27] = new("UIStroke", I[26], "UIStroke", { Color = Color3.fromRGB(80, 80, 80), Thickness = 5 })
					I[28] = new("UICorner", I[26], "UICorner", { BottomLeftRadius = UDim.new(0.24, 0), BottomRightRadius = UDim.new(0.24, 0), TopLeftRadius = UDim.new(0.24, 0), TopRightRadius = UDim.new(0.24, 0) })
				I[29] = new("ImageLabel", I[23], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://103636235196677"), Position = UDim2.fromScale(0.54, 0.5), Size = UDim2.fromScale(0.9520534, 0.9520534), ZIndex = 250 })
				I[30] = new("UIGradient", I[23], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(245, 245, 245)), ColorSequenceKeypoint.new(1, Color3.fromRGB(181, 181, 181)) }), Rotation = 90 })
				I[31] = new("TextLabel", I[23], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.8), Text = "Claim", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 960 })
					I[32] = new("UIStroke", I[31], "UIStroke", { Color = Color3.fromRGB(80, 80, 80), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
			I[33] = new("Frame", I[22], "Claim", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 950 })
				I[34] = new("UIStroke", I[33], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), Thickness = 5 })
				I[35] = new("UICorner", I[33], "UICorner", { BottomLeftRadius = UDim.new(0.24, 0), BottomRightRadius = UDim.new(0.24, 0), TopLeftRadius = UDim.new(0.24, 0), TopRightRadius = UDim.new(0.24, 0) })
				I[36] = new("Frame", I[33], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 32, 54), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), ZIndex = 940 })
					I[37] = new("UIStroke", I[36], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), Thickness = 5 })
					I[38] = new("UICorner", I[36], "UICorner", { BottomLeftRadius = UDim.new(0.24, 0), BottomRightRadius = UDim.new(0.24, 0), TopLeftRadius = UDim.new(0.24, 0), TopRightRadius = UDim.new(0.24, 0) })
				I[39] = new("ImageLabel", I[33], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://103636235196677"), Position = UDim2.fromScale(0.54, 0.5), Size = UDim2.fromScale(0.9520534, 0.9520534), ZIndex = 250 })
				I[40] = new("UIGradient", I[33], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(161, 254, 55)), ColorSequenceKeypoint.new(1, Color3.fromRGB(34, 216, 14)) }), Rotation = 90 })
				I[41] = new("TextLabel", I[33], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.8), Text = "Claim", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 960 })
					I[42] = new("UIStroke", I[41], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
			I[43] = new("TextButton", I[22], "Click", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 1000 })
	return I[1]
end

return build
