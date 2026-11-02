-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/LeaderboardGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "LeaderboardGui", { Brightness = 2, ClipsDescendants = true, MaxDistance = 200, ResetOnSpawn = false, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, ZOffset = -1 })
		I[2] = new("ScrollingFrame", I[1], "List", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, BottomImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740413"), CanvasSize = UDim2.fromScale(0, 0), MidImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740296"), Position = UDim2.fromScale(0.5, 0.4625), ScrollBarImageColor3 = Color3.fromRGB(114, 140, 255), ScrollBarThickness = 20, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(0.855, 0.613), TopImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740150"), VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar })
			I[3] = new("Frame", I[2], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(1, -20, 1, -20), SizeConstraint = Enum.SizeConstraint.RelativeXX })
				I[4] = new("UIListLayout", I[3], "Layout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 20), SortOrder = Enum.SortOrder.LayoutOrder })
				I[5] = new("Frame", I[3], "BottomBuffer", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 999999999, Size = UDim2.fromScale(1, 0.01) })
		I[6] = new("ImageLabel", I[1], "LiveBackground", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://13970862697"), Position = UDim2.fromScale(0.925, 0.05), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.26, 0.085), SliceCenter = Rect.new(31, 31, 31, 31), SliceScale = 0.5, ZIndex = 0 })
		I[7] = new("Frame", I[1], "Buttons", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.9125), Size = UDim2.fromScale(1, 0.1) })
			I[8] = new("UIListLayout", I[7], "Layout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[9] = new("TextLabel", I[1], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.05), Size = UDim2.fromScale(1, 0.08), Text = "Win Streaks                   ", TextColor3 = Color3.fromRGB(114, 140, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[10] = new("TextLabel", I[1], "Live", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.895, 0.05), Size = UDim2.fromScale(1, 0.065), Text = "• LIVE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
		I[11] = new("Frame", I[1], "Background", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = -1 })
			I[12] = new("Frame", I[11], "BottomBar", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(171, 171, 171), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.175), ZIndex = 2 })
				I[13] = new("UIGradient", I[12], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(19, 41, 54)), ColorSequenceKeypoint.new(0.9429066, Color3.fromRGB(28, 62, 82)), ColorSequenceKeypoint.new(1, Color3.fromRGB(47, 103, 136)) }), Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.6092384, 0.35), NumberSequenceKeypoint.new(1, 0.2875) }) })
			I[14] = new("Frame", I[11], "TopBar", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(171, 171, 171), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.1), ZIndex = 2 })
				I[15] = new("UIGradient", I[14], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(19, 41, 54)), ColorSequenceKeypoint.new(0.9429066, Color3.fromRGB(28, 62, 82)), ColorSequenceKeypoint.new(1, Color3.fromRGB(47, 103, 136)) }), Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.6092384, 0.35), NumberSequenceKeypoint.new(1, 0.2875) }) })
			I[16] = new("ImageLabel", I[11], "BGTxt", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://96968939344136"), ImageTransparency = 0.95, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromScale(0.2, 0.15) })
			I[17] = new("Frame", I[11], "BG", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(171, 171, 171), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 0 })
				I[18] = new("UIGradient", I[17], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(19, 41, 54)), ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 47, 63)) }), Rotation = -90 })
			I[19] = new("Frame", I[11], "Outline", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.4625), Size = UDim2.fromScale(0.875, 0.625), ZIndex = 3 })
				I[20] = new("UICorner", I[19], "UICorner")
				I[21] = new("UIStroke", I[19], "UIStroke", { Color = Color3.fromRGB(114, 140, 255), Thickness = 15 })
	return I[1]
end

return build
