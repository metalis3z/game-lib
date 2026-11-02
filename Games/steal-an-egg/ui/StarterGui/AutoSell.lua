-- Generated from ui/StarterGui/AutoSell.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "AutoSell", { AutoLocalize = false, DisplayOrder = 4, Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 0.5), ZIndex = -1 })
			I[3] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -0.1131871), Size = UDim2.fromScale(0.3509387, 0.0949313), Text = "Auto Sell", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 10 })
				I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 2 })
			I[5] = new("Frame", I[2], "Outline", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = -1 })
				I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0.025, 0), BottomRightRadius = UDim.new(0.025, 0), TopLeftRadius = UDim.new(0.025, 0), TopRightRadius = UDim.new(0.025, 0) })
				I[7] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(48, 48, 48), Thickness = 4 })
			I[8] = new("ImageLabel", I[2], "DropShadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://96735047582734"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.4993009, 0.5018604), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1.1112911, 1.1074479), SliceCenter = Rect.new(256, 256, 256, 256), SliceScale = 0.4, ZIndex = -2 })
			I[9] = new("Frame", I[2], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = -1 })
				I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0.025, 0), BottomRightRadius = UDim.new(0.025, 0), TopLeftRadius = UDim.new(0.025, 0), TopRightRadius = UDim.new(0.025, 0) })
			I[11] = new("ImageLabel", I[2], "Pattern", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(254, 253, 255), ImageTransparency = 0.93, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromScale(0.25, 0.15), ZIndex = 0 })
			I[12] = new("TextLabel", I[2], "Title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000001, 0.0296841), Size = UDim2.fromScale(0.8174362, 0.0771188), Text = "Select brainrot rarities to sell:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 10 })
				I[13] = new("UIStroke", I[12], "UIStroke", { Thickness = 2 })
			I[14] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.1508144 })
			I[15] = new("TextLabel", I[2], "TextLabel_2", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000001, 0.1061773), Size = UDim2.fromScale(0.8174362, 0.060386), Text = "(colored = keep, white = auto sell)", TextColor3 = Color3.fromRGB(192, 191, 193), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 10 })
				I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 2 })
			I[17] = new("ScrollingFrame", I[2], "Frame", { AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, BottomImageContent = Content.fromUri("rbxassetid://17304955263"), CanvasSize = UDim2.fromScale(0, 0), ElasticBehavior = Enum.ElasticBehavior.Always, MidImageContent = Content.fromUri("rbxassetid://17304955792"), Position = UDim2.fromScale(0, 0.2040423), ScrollBarImageColor3 = Color3.fromRGB(48, 48, 48), ScrollBarThickness = 6, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.new(0.9958456, 11, 0.7871069, 0), TopImageContent = Content.fromUri("rbxassetid://17304955539"), VerticalScrollBarInset = Enum.ScrollBarInset.Always })
				I[18] = new("UIGridLayout", I[17], "UIGridLayout", { CellPadding = UDim2.fromScale(0.03, 0.05), CellSize = UDim2.fromScale(0.4, 0.2), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
					I[19] = new("Frame", I[18], "Template", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -1, Position = UDim2.fromScale(0.5545452, 0.4247151), Size = UDim2.fromScale(0.8909099, 0.2292624), ZIndex = 13 }, { ["AutoTween"] = "" })
						I[20] = new("ImageButton", I[19], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://73214197551985"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(64, 64, 64, 64), SliceScale = 0.2, ZIndex = 10 })
							I[21] = new("UIGradient", I[20], "selected", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(240, 249, 243)), ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 175, 170)) }), Rotation = 90 })
						I[22] = new("TextLabel", I[19], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Interactable = false, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9289218, 0.6484563), Text = "Garden", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 12 })
							I[23] = new("UIStroke", I[22], "UIStroke", { Thickness = 2 })
						I[24] = new("ImageLabel", I[19], "Glow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://96735047582734"), ImageTransparency = 0.85, Position = UDim2.fromScale(0.4915327, 0.4806248), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1.2130487, 1.5039177), SliceCenter = Rect.new(256, 256, 256, 256), SliceScale = 0.4, ZIndex = 9 })
						I[25] = new("UIScale", I[19], "UIScale")
			I[26] = new("UIScale", I[2], "UIScale")
			I[27] = new("ImageButton", I[2], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.993, 0.021), Selectable = false, Size = UDim2.fromScale(0.1, 0.1), ZIndex = 5 })
				I[28] = new("TextLabel", I[27], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 15 })
					I[29] = new("UIStroke", I[28], "UIStroke", { Thickness = 2 })
				I[30] = new("ImageLabel", I[27], "DropShadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 4), ImageContent = Content.fromUri("rbxassetid://96735047582734"), ImageTransparency = 0.8, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1.5088595, 1.7296873), SliceCenter = Rect.new(256, 256, 256, 256), SliceScale = 0.4, ZIndex = 12 })
				I[31] = new("UIAspectRatioConstraint", I[27], "UIAspectRatioConstraint", { AspectRatio = 1.1441339 })
				I[32] = new("ImageLabel", I[27], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://73214197551985"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Selectable = true, Size = UDim2.fromScale(1.1349496, 1.3059219), SliceCenter = Rect.new(64, 64, 64, 64), SliceScale = 0.2, ZIndex = 13 })
					I[33] = new("UIGradient", I[32], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 9, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(210, 0, 8)) }), Rotation = 90 })
	return I[1]
end

return build
