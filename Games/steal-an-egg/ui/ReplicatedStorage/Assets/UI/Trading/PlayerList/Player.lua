-- Generated from ui/ReplicatedStorage/Assets/UI/Trading/PlayerList/Player.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Player", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.fromScale(1, 1), ZIndex = 3 })
		I[2] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 6 })
		I[3] = new("Frame", I[1], "NameHolder", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.142, 0.5), Size = UDim2.fromScale(0.52, 0.8), ZIndex = 3 })
			I[4] = new("TextLabel", I[3], "Username", { AnchorPoint = Vector2.new(0, 1), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.4), Text = "@Group", TextColor3 = Color3.fromRGB(204, 204, 204), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
			I[5] = new("TextLabel", I[3], "Display", { AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.6), Text = "User", TextColor3 = Color3.fromRGB(112, 237, 252), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
				I[6] = new("UIStroke", I[5], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
		I[7] = new("Frame", I[1], "ButtonHolder", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(1, 0, 0.5, 2), Size = UDim2.fromScale(0.32, 0.9) })
			I[8] = new("ImageButton", I[7], "Trade", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://126875624960627"), Position = UDim2.fromScale(0.5, 0.5), PressedImageContent = Content.fromUri("rbxassetid://124217248402069"), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(20, 20, 80, 80), ZIndex = 3 })
				I[9] = new("TextLabel", I[8], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.825, 0.6), Text = "Trade!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 4 })
					I[10] = new("UIStroke", I[9], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
				I[11] = new("UIGradient", I[8], "green gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 17)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 253, 59)) }), Rotation = -90 })
		I[12] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(144, 144, 144), BackgroundTransparency = 0.75, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.7), ZIndex = 3 })
			I[13] = new("UICorner", I[12], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[14] = new("UIAspectRatioConstraint", I[12], "UIAspectRatioConstraint")
			I[15] = new("UIStroke", I[12], "UIStroke", { Color = Color3.fromRGB(31, 32, 36), Thickness = 3.3 })
			I[16] = new("Frame", I[12], "Rank", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.1, 0.95), Size = UDim2.fromScale(0.4, 0.4), Visible = false, ZIndex = 10 })
				I[17] = new("UICorner", I[16], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[18] = new("TextLabel", I[16], "Display", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.55, 0.5), Size = UDim2.fromScale(0.9, 1), Text = "9", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, ZIndex = 11 })
					I[19] = new("UIAspectRatioConstraint", I[18], "UIAspectRatioConstraint")
			I[20] = new("Frame", I[12], "Friend", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 2, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.9, 0.95), Size = UDim2.fromScale(0.5, 0.5), ZIndex = 10 })
				I[21] = new("UICorner", I[20], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[22] = new("ImageLabel", I[20], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(13, 255, 0), ImageContent = Content.fromUri("rbxassetid://95655411323094"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.925, 0.925), ZIndex = 11 })
					I[23] = new("UIAspectRatioConstraint", I[22], "UIAspectRatioConstraint")
	return I[1]
end

return build
