-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/Pages/Party.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Party", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(0.6, 150, 0.5, 125) })
		I[2] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 2 })
		I[3] = new("ScrollingFrame", I[1], "List", { Active = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, BottomImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740413"), ClipsDescendants = false, MidImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740296"), Position = UDim2.new(0.3, 9, 0, 0), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarImageTransparency = 0.5, ScrollBarThickness = 10, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(0.7, 1), TopImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740150"), VerticalScrollBarInset = Enum.ScrollBarInset.Always })
			I[4] = new("Frame", I[3], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.new(1, -8, 1, -8), SizeConstraint = Enum.SizeConstraint.RelativeXX })
				I[5] = new("UIListLayout", I[4], "Layout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.025, 0), SortOrder = Enum.SortOrder.LayoutOrder })
				I[6] = new("Frame", I[4], "Top", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.065) })
					I[7] = new("Frame", I[6], "Search", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.225, 0.5), Size = UDim2.fromScale(0.45, 1) })
						I[8] = new("ImageLabel", I[7], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://17277885692"), ImageTransparency = 0.25, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, ZIndex = -1 }, nil, { "UIBackground" })
							I[9] = new("UIGradient", I[8], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0.5) }) })
						I[10] = new("TextBox", I[7], "Box", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ClearTextOnFocus = false, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(127, 127, 127), PlaceholderText = "Search", Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.5), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 15, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[11] = new("Frame", I[6], "Tabs", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = -99999, Position = UDim2.fromScale(0.785, 0.5), Size = UDim2.fromScale(0.55, 1) })
						I[12] = new("ImageButton", I[11], "All", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.125, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.2, 0.875), SliceCenter = Rect.new(15, 15, 16, 16) })
							I[13] = new("TextLabel", I[12], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.6), Text = "All", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
							I[14] = new("ImageLabel", I[12], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://17277885692"), ImageTransparency = 0.25, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, ZIndex = -2 })
								I[15] = new("UIGradient", I[14], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0.5) }) })
						I[16] = new("ImageButton", I[11], "Lobby", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 2, Position = UDim2.fromScale(0.4, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.275, 0.875), SliceCenter = Rect.new(15, 15, 16, 16) })
							I[17] = new("TextLabel", I[16], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.6), Text = "Lobby", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
							I[18] = new("ImageLabel", I[16], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://17277885692"), ImageTransparency = 0.25, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, ZIndex = -2 })
								I[19] = new("UIGradient", I[18], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0.5) }) })
						I[20] = new("UIListLayout", I[11], "Layout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
						I[21] = new("ImageButton", I[11], "Friends", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 1, Position = UDim2.fromScale(0.4, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.275, 0.875), SliceCenter = Rect.new(15, 15, 16, 16) })
							I[22] = new("TextLabel", I[21], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.6), Text = "Friends", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
							I[23] = new("ImageLabel", I[21], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17277885692"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, ZIndex = -2 })
								I[24] = new("UIGradient", I[23], "UIGradient", { Enabled = false, Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0.5) }) })
				I[25] = new("Frame", I[4], "Empty", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.fromScale(1, 0.6) })
					I[26] = new("TextLabel", I[25], "Empty", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Italic), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.1), Text = "No players found", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(31, 31, 31), TextTransparency = 0.5, TextWrapped = true, ZIndex = 3 })
					I[27] = new("ImageLabel", I[25], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://17277885692"), ImageTransparency = 0.25, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, Visible = false, ZIndex = -1 }, nil, { "UIBackground" })
						I[28] = new("UIGradient", I[27], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0.5) }) })
					I[29] = new("ImageLabel", I[25], "Shaded", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://98733034699805"), ImageTransparency = 0.875, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(25, 25), ZIndex = -999 })
						I[30] = new("UICorner", I[29], "UICorner")
				I[31] = new("Frame", I[4], "Players", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.fromScale(1, 0), ZIndex = 2 })
					I[32] = new("Frame", I[31], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeXX })
						I[33] = new("UIGridLayout", I[32], "Layout", { CellPadding = UDim2.fromScale(0.01, 0.01), CellSize = UDim2.fromScale(0.325, 0.125), SortOrder = Enum.SortOrder.LayoutOrder })
		I[34] = new("ImageButton", I[1], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1.05, 0.05), Size = UDim2.fromScale(0.063, 0.075) })
			I[35] = new("ImageLabel", I[34], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 50, 50), ImageContent = Content.fromUri("rbxassetid://17277885692"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, ZIndex = -2 })
				I[36] = new("UIGradient", I[35], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(152, 152, 152)) }), Rotation = 90 })
			I[37] = new("ImageLabel", I[34], "Shine", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17277885692"), ImageTransparency = 0.75, Position = UDim2.new(0.5, 0, 0, 3), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(1, -6, 0.5, 0), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.35, ZIndex = -1 })
				I[38] = new("UIGradient", I[37], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.3903559, 0.5625), NumberSequenceKeypoint.new(0.8208955, 1), NumberSequenceKeypoint.new(1, 1) }) })
			I[39] = new("ImageLabel", I[34], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://17838290166"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.875, 0.6) })
		I[40] = new("Frame", I[1], "Members", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.075), Size = UDim2.fromScale(0.25, 0.17) })
			I[41] = new("UIListLayout", I[40], "Layout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.1, 0), SortOrder = Enum.SortOrder.LayoutOrder })
		I[42] = new("TextLabel", I[1], "Title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.125, 0), Size = UDim2.fromScale(0.25, 0.0625), Text = "Your Party", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(31, 31, 31), TextWrapped = true, ZIndex = 3 })
			I[43] = new("UIStroke", I[42], "UIStroke", { Thickness = 2, Transparency = 0.875 })
	return I[1]
end

return build
