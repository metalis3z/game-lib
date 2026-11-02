-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/Pages/PrivateServerControls.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "PrivateServerControls", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(0.6, 150, 0.5, 125) })
		I[2] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 1.25 })
		I[3] = new("ImageButton", I[1], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(1.075, 16, 0.037, 0), Size = UDim2.fromScale(0.1, 0.075), ZIndex = 2 })
			I[4] = new("ImageLabel", I[3], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 50, 50), ImageContent = Content.fromUri("rbxassetid://17277885692"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, ZIndex = -2 })
				I[5] = new("UIGradient", I[4], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(152, 152, 152)) }), Rotation = 90 })
			I[6] = new("ImageLabel", I[3], "Shine", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17277885692"), ImageTransparency = 0.75, Position = UDim2.new(0.5, 0, 0, 3), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(1, -6, 0.5, 0), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.35, ZIndex = -1 })
				I[7] = new("UIGradient", I[6], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.3903559, 0.5625), NumberSequenceKeypoint.new(0.8208955, 1), NumberSequenceKeypoint.new(1, 1) }) })
			I[8] = new("ImageLabel", I[3], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://17838290166"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.875, 0.6) })
		I[9] = new("ScrollingFrame", I[1], "List", { Active = true, AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, BottomImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740413"), ClipsDescendants = false, MidImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740296"), Position = UDim2.new(0.5, 9, 0, 0), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarImageTransparency = 0.5, ScrollBarThickness = 10, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.new(1, 14, 1, 0), TopImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740150"), VerticalScrollBarInset = Enum.ScrollBarInset.Always })
			I[10] = new("Frame", I[9], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.new(1, -8, 1, -8), SizeConstraint = Enum.SizeConstraint.RelativeXX })
				I[11] = new("UIListLayout", I[10], "Layout", { HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder })
				I[12] = new("Frame", I[10], "Header", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -100, Position = UDim2.fromScale(0.5, 0.235), Size = UDim2.fromScale(1, 0.15) })
					I[13] = new("ImageLabel", I[12], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://17277885692"), ImageTransparency = 0.25, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, ZIndex = -1 }, nil, { "UIBackground" })
						I[14] = new("UIGradient", I[13], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0.5) }) })
					I[15] = new("TextLabel", I[12], "Description", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.586), Size = UDim2.fromScale(0.75, 0.214), Text = "Manage your private server using a variety of controls!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 0.5, TextWrapped = true, ZIndex = 3 })
					I[16] = new("ImageButton", I[12], "Modal", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Modal = true, Position = UDim2.fromScale(0.5, 0.5), Selectable = false, Size = UDim2.fromScale(1, 1), ZIndex = -1 })
					I[17] = new("TextLabel", I[12], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.266), Size = UDim2.fromScale(0.8, 0.426), Text = "Private Server", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
						I[18] = new("ImageLabel", I[17], "ImageLabel", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://17619445191"), Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.5, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
					I[19] = new("TextLabel", I[12], "Description", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.8), Size = UDim2.fromScale(0.75, 0.214), Text = "Kick & ban players from your private server!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 0.5, TextWrapped = true, ZIndex = 3 })
				I[20] = new("Frame", I[10], "Players", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 30, Position = UDim2.fromScale(0.5, 0.235), Size = UDim2.new(1, 0, 0, 233) })
					I[21] = new("ImageButton", I[20], "Modal", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Modal = true, Position = UDim2.fromScale(0.5, 0.5), Selectable = false, Size = UDim2.fromScale(1, 1), ZIndex = -1 })
					I[22] = new("Frame", I[20], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeXX })
						I[23] = new("UIGridLayout", I[22], "Layout", { CellPadding = UDim2.fromScale(0.025, 0.025), CellSize = UDim2.fromScale(0.316666, 0.12), SortOrder = Enum.SortOrder.LayoutOrder })
				I[24] = new("Frame", I[10], "BannedPlayers", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 31, Position = UDim2.fromScale(0.5, 0.235), Size = UDim2.fromScale(1, 0.16) })
					I[25] = new("ImageButton", I[24], "Modal", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Modal = true, Position = UDim2.fromScale(0.5, 0.5), Selectable = false, Size = UDim2.fromScale(1, 1), ZIndex = -1 })
					I[26] = new("Frame", I[24], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeXX })
						I[27] = new("UIGridLayout", I[26], "Layout", { CellPadding = UDim2.fromScale(0.025, 0.025), CellSize = UDim2.fromScale(0.316666, 0.12), SortOrder = Enum.SortOrder.LayoutOrder })
				I[28] = new("Frame", I[10], "HeaderBuffer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -99, Position = UDim2.fromScale(0.5, 0.235), Size = UDim2.fromScale(1, 0.05) })
					I[29] = new("ImageButton", I[28], "Modal", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Modal = true, Position = UDim2.fromScale(0.5, 0.5), Selectable = false, Size = UDim2.fromScale(1, 1), ZIndex = -1 })
		I[30] = new("Frame", I[1], "Locked", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false })
			I[31] = new("ImageButton", I[30], "Modal", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Modal = true, Position = UDim2.fromScale(0.5, 0.5), Selectable = false, Size = UDim2.fromScale(1, 1), ZIndex = -1 })
			I[32] = new("ImageLabel", I[30], "Shaded", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://98733034699805"), ImageTransparency = 0.875, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(25, 25), ZIndex = -999 })
				I[33] = new("UICorner", I[32], "UICorner")
			I[34] = new("TextLabel", I[30], "TItle", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.ExtraBold, Enum.FontStyle.Italic), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromScale(1, 0.2), Text = "LOCKED", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(31, 31, 31), TextTransparency = 0.5, TextWrapped = true, ZIndex = 3 })
			I[35] = new("ImageLabel", I[30], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://17277885692"), ImageTransparency = 0.25, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, Visible = false, ZIndex = -1 }, nil, { "UIBackground" })
				I[36] = new("UIGradient", I[35], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0.5) }) })
			I[37] = new("TextLabel", I[30], "Description", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Italic), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.6), Size = UDim2.fromScale(0.6, 0.2), Text = "Only the private server owner has access", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(31, 31, 31), TextTransparency = 0.5, TextWrapped = true, ZIndex = 3 })
	return I[1]
end

return build
