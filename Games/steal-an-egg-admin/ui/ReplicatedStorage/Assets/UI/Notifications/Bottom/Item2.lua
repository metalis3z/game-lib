-- Generated from ui/ReplicatedStorage/Assets/UI/Notifications/Bottom/Item2.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("CanvasGroup", nil, "Item2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.65) }, { ["_lemonadeUniqueId"] = "2QsxTQec2Qsx" })
		I[2] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "z572f7HHz572" })
		I[3] = new("Frame", I[1], "Entry", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "JwCWvP08JwCW" })
			I[4] = new("TextLabel", I[3], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.02), Size = UDim2.fromScale(1, 0.275), Text = "New Item!", TextColor3 = Color3.fromRGB(255, 238, 49), TextScaled = true, TextSize = 18, TextWrapped = true, Visible = false, ZIndex = 2 }, { ["_lemonadeUniqueId"] = "xSp6fJx5xSp6" })
				I[5] = new("UIStroke", I[4], "UIStroke", { Color = Color3.fromRGB(23, 43, 57), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.4000001 }, { ["_lemonadeUniqueId"] = "8apicZDj8api" })
			I[6] = new("ImageLabel", I[3], "Glow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://90683431509636"), ImageTransparency = 0.1, Position = UDim2.fromScale(0.5, 0.675), Size = UDim2.fromScale(0.3, 1) }, { ["_lemonadeUniqueId"] = "s3gmW6kas3gm" })
				I[7] = new("UIScale", I[6], "UIScale", nil, { ["_lemonadeUniqueId"] = "yMNKDss2yMNK" })
			I[8] = new("Frame", I[3], "Frame", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.95), Size = UDim2.fromScale(1, 0.65), ZIndex = 2 }, { ["_lemonadeUniqueId"] = "niKeDhaMniKe" })
				I[9] = new("Frame", I[8], "ItemHolder", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 4 }, { ["_lemonadeUniqueId"] = "INVsWrnDINVs" })
					I[10] = new("Frame", I[9], "Item", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 4 }, { ["_lemonadeUniqueId"] = "m8TZeU3Xm8TZ" })
						I[11] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "XqE6jqnxXqE6" })
						I[12] = new("ImageLabel", I[10], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://99458650446228"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 5 }, { ["_lemonadeUniqueId"] = "X3VmQJDXX3Vm" })
					I[13] = new("ImageLabel", I[9], "glow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://130304595536693"), ImageTransparency = 0.8, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1.8, 1.8), SliceCenter = Rect.new(50, 50, 150, 150), SliceScale = 0.9, ZIndex = 2 }, { ["_lemonadeUniqueId"] = "QE59gSc6QE59" })
						I[14] = new("UIGradient", I[13], "Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(41, 216, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(41, 226, 255)) }), Rotation = 100 }, { ["_lemonadeUniqueId"] = "uhdE3180uhdE" })
					I[15] = new("ImageLabel", I[9], "coreImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://125192115551934"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.3, 1.3) }, { ["_lemonadeUniqueId"] = "Tk4PsQ5RTk4P" })
						I[16] = new("CanvasGroup", I[15], "CanvasGroup", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8) }, { ["_lemonadeUniqueId"] = "7IppNu6U7Ipp" })
							I[17] = new("ImageLabel", I[16], "InletTexture", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://103855926983380"), ImageTransparency = 0.39, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromScale(0.3, 0.3), ZIndex = 2 }, { ["_lemonadeUniqueId"] = "jBaeTCmMjBae" })
							I[18] = new("UICorner", I[16], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) }, { ["_lemonadeUniqueId"] = "hl0zFOTbhl0z" })
					I[19] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) }, { ["_lemonadeUniqueId"] = "q1N9W6f7q1N9" })
					I[20] = new("UIGradient", I[9], "Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(41, 216, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(41, 226, 255)) }), Rotation = 100 }, { ["_lemonadeUniqueId"] = "c2jBWtxRc2jB" })
					I[21] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "A7RdjIt7A7Rd" })
					I[22] = new("UIPadding", I[9], "UIPadding", { PaddingBottom = UDim.new(0.05, 0), PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0), PaddingTop = UDim.new(0.05, 0) }, { ["_lemonadeUniqueId"] = "LiXtpKuGLiXt" })
					I[23] = new("UIStroke", I[9], "UIStroke", { Enabled = false, Thickness = 4.1999998 }, { ["_lemonadeUniqueId"] = "lvMQiNFPlvMQ" })
				I[24] = new("TextLabel", I[8], "Quanity", { AnchorPoint = Vector2.new(0.5, 0), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0), RichText = true, Size = UDim2.fromScale(0, 0.6), Text = "x5", TextColor3 = Color3.fromRGB(23, 43, 57), TextScaled = true, TextSize = 18, TextWrapped = true, Visible = false, ZIndex = 2 }, { ["_lemonadeUniqueId"] = "53FMILW853FM" })
				I[25] = new("UIListLayout", I[8], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "J1puTANXJ1pu" })
			I[26] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "I8dlemV5I8dl" })
	return I[1]
end

return build
