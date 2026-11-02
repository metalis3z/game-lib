-- Generated from ui/ReplicatedStorage/Assets/UI/Leaderboard.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Leaderboard", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.95, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.935, 0.16) })
		I[2] = new("Frame", I[1], "Player", { BackgroundColor3 = Color3.fromRGB(138, 138, 138), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.148, 0), Size = UDim2.fromScale(0.59, 1) })
			I[3] = new("ImageLabel", I[2], "Headshot", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112951947643512"), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.2, 0.8) })
			I[4] = new("TextLabel", I[2], "DisplayName", { AnchorPoint = Vector2.new(0, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.243, 0.38), Size = UDim2.fromScale(0.57, 0.53), Text = "Woiz", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.8, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 5, Transparency = 0.1 })
			I[6] = new("TextLabel", I[2], "Username", { AnchorPoint = Vector2.new(0, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.24, 0.75), Size = UDim2.fromScale(0.57, 0.21), Text = "@Woiizz", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.8, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 3.7, Transparency = 0.1 })
		I[8] = new("Frame", I[1], "Rank", { BackgroundColor3 = Color3.fromRGB(138, 138, 138), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.135, 1) })
			I[9] = new("TextLabel", I[8], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), Text = "#1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.8, TextWrapped = true })
				I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 5, Transparency = 0.1 })
		I[11] = new("Frame", I[1], "Val", { BackgroundColor3 = Color3.fromRGB(138, 138, 138), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.75, 0), Size = UDim2.fromScale(0.22, 1) })
			I[12] = new("TextLabel", I[11], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.6), Text = "1/250,000", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.8, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
				I[13] = new("UIStroke", I[12], "UIStroke", { Thickness = 5, Transparency = 0.1 })
			I[14] = new("ImageLabel", I[11], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), LayoutOrder = 1, Position = UDim2.fromScale(-0.55, 0), Size = UDim2.new(0.2, 100, 0.85, 0), Visible = false })
			I[15] = new("UIListLayout", I[11], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[16] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
		I[17] = new("UIGradient", I[1], "1", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 195, 14)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 228, 92)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 195, 14)) }), Enabled = false, Rotation = 268 })
		I[18] = new("UIStroke", I[1], "UIStroke", { Thickness = 5, Transparency = 0.75 })
			I[19] = new("UIGradient", I[18], "1", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 195, 14)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 228, 92)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 195, 14)) }), Enabled = false, Rotation = 268 })
			I[20] = new("UIGradient", I[18], "2", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(240, 240, 240)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 240, 240)) }), Enabled = false, Rotation = 268 })
			I[21] = new("UIGradient", I[18], "3", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 138, 59)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 179, 102)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 138, 59)) }), Enabled = false, Rotation = 268 })
		I[22] = new("UIGradient", I[1], "2", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(240, 240, 240)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 240, 240)) }), Enabled = false, Rotation = 268 })
		I[23] = new("UIGradient", I[1], "3", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 138, 59)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 179, 102)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 138, 59)) }), Enabled = false, Rotation = 268 })
		I[24] = new("ImageLabel", I[1], "Country", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://6764345672"), Position = UDim2.fromScale(0.253, 0.84), Size = UDim2.fromScale(0.0478327, 0.2311051) })
			I[25] = new("UICorner", I[24], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
	return I[1]
end

return build
