-- Generated from ui/ReplicatedStorage/Assets/UI/Teleport.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Teleport", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.9486383, 0.3886115), ZIndex = 510 })
		I[2] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), Thickness = 5 })
		I[3] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
		I[4] = new("Frame", I[1], "Teleport", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.8124952, 0.7578012), Size = UDim2.fromScale(0.3308878, 0.2898308), ZIndex = 600 })
			I[5] = new("UIStroke", I[4], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), Thickness = 5 })
			I[6] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
			I[7] = new("Frame", I[4], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 32, 54), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), ZIndex = 590 })
				I[8] = new("UIStroke", I[7], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), Thickness = 5 })
				I[9] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
			I[10] = new("TextButton", I[4], "Click", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 620 })
			I[11] = new("UIGradient", I[4], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(161, 254, 55)), ColorSequenceKeypoint.new(1, Color3.fromRGB(34, 216, 14)) }), Rotation = 90 })
			I[12] = new("TextLabel", I[4], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Text = "Teleport", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 610 })
				I[13] = new("UIStroke", I[12], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
		I[14] = new("ImageLabel", I[1], "BG", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://74283123122093"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 511 })
			I[15] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
		I[16] = new("ImageLabel", I[1], "Fade", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://98936408569431"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 512 })
			I[17] = new("UICorner", I[16], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
			I[18] = new("UIGradient", I[16], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(192, 255, 250)), ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 202, 243)) }), Rotation = 60, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.6), NumberSequenceKeypoint.new(1, 0.6) }) })
		I[19] = new("TextLabel", I[1], "Title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.55, 0.0525631), Size = UDim2.fromScale(0.854, 0.27), Text = "Spawn", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 552 })
			I[20] = new("UIStroke", I[19], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4.5 })
		I[21] = new("Frame", I[1], "Tools", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.65, 0.336), Size = UDim2.fromScale(0.3239177, 0.2241472), ZIndex = 551 })
			I[22] = new("UIListLayout", I[21], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0.04, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[23] = new("Frame", I[21], "Template", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.1977874, 0.9962248), Visible = false, ZIndex = 560 })
				I[24] = new("ImageLabel", I[23], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://80174224466596"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 570 })
		I[25] = new("ImageLabel", I[1], "WorldIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112427240479104"), Position = UDim2.fromScale(0.06, 0.189), Size = UDim2.fromScale(0.097493, 0.3398058), ZIndex = 570 })
	return I[1]
end

return build
