-- Generated from ui/ReplicatedStorage/UI/Notif.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Notif", { BackgroundColor3 = Color3.fromRGB(245, 146, 184), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(0, 81), Size = UDim2.fromOffset(280, 70) })
		I[2] = new("Frame", I[1], "BlockProgress", { BackgroundColor3 = Color3.fromRGB(255, 80, 80), BorderSizePixel = 0, Position = UDim2.fromOffset(74, 26), Size = UDim2.fromOffset(0, 2), Visible = false })
		I[3] = new("TextLabel", I[1], "Speech", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(76, 36), Size = UDim2.new(0.9400486, -152, -0.0412166, 22), Text = "Merry Christmas!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 2 })
		I[5] = new("ImageLabel", I[1], "Background", { BackgroundColor3 = Color3.fromRGB(245, 146, 184), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(245, 146, 184), ImageContent = Content.fromUri("rbxassetid://96094106483229"), ImageTransparency = 0.6, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1.1428572), TileSize = UDim2.fromOffset(64, 64), ZIndex = 0 })
			I[6] = new("UICorner", I[5], "UICorner")
			I[7] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.6027634, Color3.fromRGB(249, 249, 249)), ColorSequenceKeypoint.new(1, Color3.fromRGB(109, 109, 109)) }), Enabled = false, Rotation = 90 })
		I[8] = new("ImageLabel", I[1], "Portrait", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(72, 44, 76), ImageContent = Content.fromUri("rbxassetid://87154471381383"), Position = UDim2.new(0, 6, 0.5577507, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(60, 60) })
			I[9] = new("UIScale", I[8], "PortraitScale", { Scale = 1.0033195 })
			I[10] = new("UICorner", I[8], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[11] = new("UIStroke", I[8], "UIStroke", { Thickness = 2 })
		I[12] = new("ImageLabel", I[1], "StickerIconShadow", { AnchorPoint = Vector2.new(1, 0.5), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://114833380014648"), ImageTransparency = 0.5, Position = UDim2.new(1.0629997, -10, 0.4385716, 2), Rotation = 3.7507684, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(103, 94) })
			I[13] = new("UIScale", I[12], "StickerScale", { Scale = 1.0047159 })
		I[14] = new("ImageLabel", I[1], "StickerIcon", { AnchorPoint = Vector2.new(1, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://114833380014648"), Position = UDim2.new(1.0667834, -8, 0.4385594, 0), Rotation = 3.7507684, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(103, 94), ZIndex = 2 })
			I[15] = new("UIScale", I[14], "StickerScale", { Scale = 1.0047159 })
		I[16] = new("UICorner", I[1], "UICorner")
		I[17] = new("TextLabel", I[1], "Name", { Active = true, BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(76, 16), Selectable = true, Size = UDim2.new(1, -152, 0, 24), Text = "Scribels", TextColor3 = Color3.fromRGB(200, 200, 210), TextScaled = true, TextSize = 16, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[18] = new("UIStroke", I[17], "UIStroke", { Thickness = 2 })
			I[19] = new("UITextSizeConstraint", I[17], "UITextSizeConstraint", { MaxTextSize = 16, MinTextSize = 8 })
	return I[1]
end

return build
