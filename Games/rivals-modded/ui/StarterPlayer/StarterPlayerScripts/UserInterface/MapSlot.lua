-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/MapSlot.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "MapSlot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.4, 0.267), SizeConstraint = Enum.SizeConstraint.RelativeYY })
		I[2] = new("ImageButton", I[1], "Button", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Modal = true, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[3] = new("ImageLabel", I[2], "Picture", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://108088064658436"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(1, 1), ZIndex = -2 })
				I[4] = new("UICorner", I[3], "UICorner")
				I[5] = new("UIGradient", I[3], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.9002494, 0.23125), NumberSequenceKeypoint.new(1, 1) }) })
			I[6] = new("TextLabel", I[2], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.9), Size = UDim2.fromScale(1, 0.15), Text = "Arena", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[7] = new("UIStroke", I[6], "UIStroke", { Transparency = 0.875 })
			I[8] = new("ImageLabel", I[2], "Random", { BackgroundColor3 = Color3.fromRGB(31, 31, 31), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = -1 })
				I[9] = new("UICorner", I[8], "UICorner")
				I[10] = new("ImageLabel", I[8], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://94238795177693"), Position = UDim2.fromScale(0.5, 0.425), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.5, 0.5) })
			I[11] = new("Frame", I[2], "Votes", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeXX, Visible = false })
				I[12] = new("UIGridLayout", I[11], "Layout", { CellPadding = UDim2.fromScale(0, 0), CellSize = UDim2.fromScale(0.2, 0.2), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[13] = new("Frame", I[11], "Chance", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -2, Size = UDim2.fromOffset(100, 100), Visible = false })
					I[14] = new("TextLabel", I[13], "Chance", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = -1, Position = UDim2.fromScale(1, 0.4), Size = UDim2.fromScale(1, 0.5), Text = "40%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[15] = new("UIStroke", I[14], "UIStroke", { Transparency = 0.75 })
					I[16] = new("TextLabel", I[13], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal), LayoutOrder = -1, Position = UDim2.fromScale(1, 0.65), Size = UDim2.fromScale(1, 0.25), Text = "chance", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[17] = new("UIStroke", I[16], "UIStroke", { Transparency = 0.75 })
				I[18] = new("Frame", I[11], "ChanceBuffer", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -1, Size = UDim2.fromOffset(100, 100), Visible = false })
			I[19] = new("ImageLabel", I[2], "Difficulty", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(100, 255, 50), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(100, 255, 50), ImageTransparency = 0.25, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, ZIndex = -3 })
				I[20] = new("UIGradient", I[19], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }), Rotation = -90 })
				I[21] = new("UICorner", I[19], "UICorner")
				I[22] = new("UIStroke", I[19], "UIStroke", { Color = Color3.fromRGB(100, 255, 50), Thickness = 2 })
					I[23] = new("UIGradient", I[22], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.4125), NumberSequenceKeypoint.new(1, 0) }) })
			I[24] = new("ImageLabel", I[2], "DifficultyVignette", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(100, 255, 50), ImageContent = Content.fromUri("rbxassetid://14824249410"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = -1 })
				I[25] = new("UICorner", I[24], "UICorner")
			I[26] = new("ImageLabel", I[2], "Background", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=8369869661"), ImageTransparency = 0.25, Position = UDim2.fromScale(0.5, 1), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 0.2), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, ZIndex = 0 })
				I[27] = new("ImageLabel", I[26], "Texture", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(100, 255, 50), ImageContent = Content.fromUri("rbxassetid://136887158756561"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, TileSize = UDim2.fromScale(0.122807, 1), ZIndex = 0 })
					I[28] = new("UIGradient", I[27], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) })
					I[29] = new("UICorner", I[27], "UICorner")
			I[30] = new("Frame", I[2], "Tag", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.975, 0.125), Size = UDim2.fromScale(0.15, 0.15), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[31] = new("ImageLabel", I[30], "Background", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 50, 50), ImageContent = Content.fromUri("rbxassetid://17277885692"), Position = UDim2.fromScale(1, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(0.5, 189, 1, 0), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, ZIndex = 0 })
				I[32] = new("TextLabel", I[30], "Title", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.75, 0.5), Size = UDim2.fromScale(4, 0.625), Text = "Experimental", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(31, 31, 31), TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 3 })
	return I[1]
end

return build
