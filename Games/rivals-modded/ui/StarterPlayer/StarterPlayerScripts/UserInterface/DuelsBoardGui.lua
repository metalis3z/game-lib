-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/DuelsBoardGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "DuelsBoardGui", { Brightness = 2, ClipsDescendants = true, MaxDistance = 200, ResetOnSpawn = false, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ScrollingFrame", I[1], "List", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, BottomImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740413"), CanvasSize = UDim2.fromScale(0, 0), MidImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740296"), Position = UDim2.fromScale(0.5, 0.525), ScrollBarThickness = 0, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(0.87, 0.55), TopImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740150"), VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar })
			I[3] = new("Frame", I[2], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeXX })
				I[4] = new("UIListLayout", I[3], "Layout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder })
		I[5] = new("ImageLabel", I[1], "LiveBackground", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://13970862697"), Position = UDim2.fromScale(0.95, 0.075), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.2, 0.15), SliceCenter = Rect.new(31, 31, 31, 31), SliceScale = 0.5, ZIndex = 0 })
		I[6] = new("TextLabel", I[1], "Live", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.925, 0.075), Size = UDim2.fromScale(0.4, 0.1), Text = "• LIVE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
		I[7] = new("Frame", I[1], "Empty", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
			I[8] = new("ImageLabel", I[7], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(114, 140, 255), ImageContent = Content.fromUri("rbxassetid://18224589414"), Position = UDim2.fromScale(0.5, 0.475), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.75, 0.45) })
			I[9] = new("TextLabel", I[7], "Empty", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.75), Size = UDim2.fromScale(0.75, 0.1), Text = "No duels found", TextColor3 = Color3.fromRGB(114, 140, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[10] = new("Frame", I[1], "Background", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = -1 })
			I[11] = new("Frame", I[10], "BG", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(171, 171, 171), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
				I[12] = new("UIGradient", I[11], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(19, 41, 54)), ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 47, 63)) }), Rotation = -90 })
			I[13] = new("Frame", I[10], "BottomBar", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(171, 171, 171), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.1), ZIndex = 2 })
				I[14] = new("UIGradient", I[13], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(19, 41, 54)), ColorSequenceKeypoint.new(0.9429066, Color3.fromRGB(28, 62, 82)), ColorSequenceKeypoint.new(1, Color3.fromRGB(47, 103, 136)) }), Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.6092384, 0.35), NumberSequenceKeypoint.new(1, 0.2875) }) })
			I[15] = new("Frame", I[10], "TopBar", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(171, 171, 171), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.15), ZIndex = 2 })
				I[16] = new("UIGradient", I[15], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(19, 41, 54)), ColorSequenceKeypoint.new(0.9429066, Color3.fromRGB(28, 62, 82)), ColorSequenceKeypoint.new(1, Color3.fromRGB(47, 103, 136)) }), Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.6092384, 0.35), NumberSequenceKeypoint.new(1, 0.2875) }) })
		I[17] = new("TextLabel", I[1], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.075), Size = UDim2.fromScale(0.9, 0.125), Text = "Duels", TextColor3 = Color3.fromRGB(114, 140, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 4 })
		I[18] = new("Frame", I[1], "Hover", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.525), Size = UDim2.fromScale(0.9, 0.6), ZIndex = 3 })
			I[19] = new("UICorner", I[18], "UICorner")
			I[20] = new("UIStroke", I[18], "UIStroke", { Color = Color3.fromRGB(114, 140, 255), Thickness = 15 })
	return I[1]
end

return build
