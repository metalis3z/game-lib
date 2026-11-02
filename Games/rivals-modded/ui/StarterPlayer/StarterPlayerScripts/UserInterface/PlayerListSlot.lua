-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/PlayerListSlot.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "PlayerListSlot", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.125) })
		I[2] = new("Frame", I[1], "Player", { BackgroundTransparency = 1, ClipsDescendants = true, LayoutOrder = 3, Size = UDim2.fromScale(0.75, 1) })
			I[3] = new("Frame", I[2], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[4] = new("TextLabel", I[3], "Title", { AnchorPoint = Vector2.new(0, 0.5), AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9, 0.5), Size = UDim2.fromScale(5.5, 0.375), Text = "OnlyTwentyCharacters ", TextColor3 = Color3.fromRGB(247, 247, 248), TextScaled = true, TextSize = 15, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[5] = new("ImageLabel", I[4], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://88012714630436"), Position = UDim2.new(0, 159, 0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(2, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[6] = new("ImageLabel", I[3], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://140099562989635"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.625, 0.625) })
		I[7] = new("Frame", I[1], "Leaderstat", { AnchorPoint = Vector2.new(1, 0), BackgroundTransparency = 1, ClipsDescendants = true, LayoutOrder = 3, Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(0.2, 1) })
			I[8] = new("TextLabel", I[7], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.4), Text = "0", TextColor3 = Color3.fromRGB(247, 247, 248), TextScaled = true, TextSize = 15, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true })
			I[9] = new("Frame", I[7], "RankContainer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
		I[10] = new("Frame", I[1], "Highlight", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(247, 247, 248), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.new(1, 0, 1, -1) })
		I[11] = new("ImageButton", I[1], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
		I[12] = new("Frame", I[1], "Line", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(247, 247, 248), BackgroundTransparency = 0.875, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.new(1, 0, 0, 1) })
		I[13] = new("Frame", I[1], "Requests", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -8, 1, -8), ZIndex = 2 })
			I[14] = new("Frame", I[13], "Party", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2 })
				I[15] = new("UIStroke", I[14], "UIStroke", { BorderStrokePosition = Enum.BorderStrokePosition.Inner, Color = Color3.fromRGB(100, 255, 0), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.05 })
					I[16] = new("UIGradient", I[15], "UIGradient", { Rotation = 8, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.25, 1), NumberSequenceKeypoint.new(1, 1) }) })
				I[17] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(0, 4), BottomRightRadius = UDim.new(0, 4), TopLeftRadius = UDim.new(0, 4), TopRightRadius = UDim.new(0, 4) })
			I[18] = new("Frame", I[13], "Challenge", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2 })
				I[19] = new("UIStroke", I[18], "UIStroke", { BorderStrokePosition = Enum.BorderStrokePosition.Inner, Color = Color3.fromRGB(255, 150, 0), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.05 })
					I[20] = new("UIGradient", I[19], "UIGradient", { Rotation = 8, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.75, 1), NumberSequenceKeypoint.new(1, 0) }) })
				I[21] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(0, 4), BottomRightRadius = UDim.new(0, 4), TopLeftRadius = UDim.new(0, 4), TopRightRadius = UDim.new(0, 4) })
	return I[1]
end

return build
