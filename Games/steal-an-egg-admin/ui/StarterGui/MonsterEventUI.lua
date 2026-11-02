-- Generated from ui/StarterGui/MonsterEventUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "MonsterEventUI", { DisplayOrder = 6, Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "NyMZP06mNyMZ" })
		I[2] = new("Frame", I[1], "Board", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.085), Size = UDim2.fromScale(0.4, 0.06) }, { ["_lemonadeUniqueId"] = "7O637cIi7O63" })
			I[3] = new("ImageLabel", I[2], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://16857574577"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(2, 4.5) }, { ["_lemonadeUniqueId"] = "Hvi7GUdtHvi7" })
			I[4] = new("Frame", I[2], "Rows", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1.25), ZIndex = 2 }, { ["_lemonadeUniqueId"] = "AKN6yRfvAKN6" })
				I[5] = new("UIListLayout", I[4], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.025, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "ddLupnkCddLu" })
				I[6] = new("Frame", I[4], "First", { BackgroundColor3 = Color3.fromRGB(255, 214, 89), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.2, 1) }, { ["_lemonadeUniqueId"] = "TiBlER5rTiBl" })
					I[7] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height }, { ["_lemonadeUniqueId"] = "zVGAiHUKzVGA" })
					I[8] = new("ImageLabel", I[6], "Avatar", { BackgroundColor3 = Color3.fromRGB(35, 35, 45), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=89659291&w=100&h=100"), Size = UDim2.fromScale(1, 1), ZIndex = 5 }, { ["_lemonadeUniqueId"] = "4R8fc04y4R8f" })
						I[9] = new("UICorner", I[8], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "AhaLgfbPAhaL" })
						I[10] = new("UIStroke", I[8], "UIStroke", { Color = Color3.fromRGB(255, 214, 89), Thickness = 2, Transparency = 0.08 }, { ["_lemonadeUniqueId"] = "A42R0PfVA42R" })
						I[11] = new("TextLabel", I[8], "Amount", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1.1), Size = UDim2.fromScale(0.7, 0.3), Text = "0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 4 }, { ["_lemonadeUniqueId"] = "t9oP6GFtt9oP" })
							I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 2, Transparency = 0.04 }, { ["_lemonadeUniqueId"] = "702gEjKm702g" })
						I[13] = new("ImageLabel", I[8], "TrophyIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://82857133407630"), Position = UDim2.fromScale(0.177214, 0.94471), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3782957, 0.3975998) }, { ["_lemonadeUniqueId"] = "zMFosnj3zMFo" })
					I[14] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "KjAPKEwEKjAP" })
					I[15] = new("UIGradient", I[6], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) }, { ["_lemonadeUniqueId"] = "VkFqAxTJVkFq" })
				I[16] = new("Frame", I[4], "Second", { BackgroundColor3 = Color3.fromRGB(213, 213, 213), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.2, 0.85) }, { ["_lemonadeUniqueId"] = "vXAsElrDvXAs" })
					I[17] = new("UIAspectRatioConstraint", I[16], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height }, { ["_lemonadeUniqueId"] = "uSICWoLzuSIC" })
					I[18] = new("ImageLabel", I[16], "Avatar", { BackgroundColor3 = Color3.fromRGB(35, 35, 45), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=89659291&w=100&h=100"), Size = UDim2.fromScale(1, 1), ZIndex = 5 }, { ["_lemonadeUniqueId"] = "ScTIlHN1ScTI" })
						I[19] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "qN713ondqN71" })
						I[20] = new("UIStroke", I[18], "UIStroke", { Color = Color3.fromRGB(213, 213, 213), Thickness = 2, Transparency = 0.08 }, { ["_lemonadeUniqueId"] = "ElqkZWAUElqk" })
						I[21] = new("TextLabel", I[18], "Amount", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1.1), Size = UDim2.fromScale(0.7, 0.3), Text = "0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 4 }, { ["_lemonadeUniqueId"] = "IiNGs3uQIiNG" })
							I[22] = new("UIStroke", I[21], "UIStroke", { Thickness = 2, Transparency = 0.04 }, { ["_lemonadeUniqueId"] = "IUumGyWOIUum" })
						I[23] = new("ImageLabel", I[18], "TrophyIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://82857133407630"), Position = UDim2.fromScale(0.177214, 0.94471), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3782957, 0.3975998) }, { ["_lemonadeUniqueId"] = "gJYMxXpPgJYM" })
					I[24] = new("UICorner", I[16], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "sIZ6Z1issIZ6" })
					I[25] = new("UIGradient", I[16], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) }, { ["_lemonadeUniqueId"] = "WtPaNvSSWtPa" })
				I[26] = new("Frame", I[4], "Third", { BackgroundColor3 = Color3.fromRGB(204, 141, 96), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5224831, 0.0749999), Size = UDim2.fromScale(0.1131426, 0.8500001) }, { ["_lemonadeUniqueId"] = "axnzWyzLaxnz" })
					I[27] = new("UIAspectRatioConstraint", I[26], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height }, { ["_lemonadeUniqueId"] = "KGcsi1cmKGcs" })
					I[28] = new("ImageLabel", I[26], "Avatar", { BackgroundColor3 = Color3.fromRGB(35, 35, 45), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=89659291&w=100&h=100"), Size = UDim2.fromScale(1, 1), ZIndex = 5 }, { ["_lemonadeUniqueId"] = "ilS5wixHilS5" })
						I[29] = new("UICorner", I[28], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "qITr1R71qITr" })
						I[30] = new("UIStroke", I[28], "UIStroke", { Color = Color3.fromRGB(204, 141, 96), Thickness = 2, Transparency = 0.08 }, { ["_lemonadeUniqueId"] = "Q7IgCT5BQ7Ig" })
						I[31] = new("TextLabel", I[28], "Amount", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1.1), Size = UDim2.fromScale(0.7, 0.3), Text = "0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 4 }, { ["_lemonadeUniqueId"] = "Uvt7eEpxUvt7" })
							I[32] = new("UIStroke", I[31], "UIStroke", { Thickness = 2, Transparency = 0.04 }, { ["_lemonadeUniqueId"] = "2IxuOKJv2Ixu" })
						I[33] = new("ImageLabel", I[28], "TrophyIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://82857133407630"), Position = UDim2.fromScale(0.177214, 0.94471), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3782957, 0.3975998) }, { ["_lemonadeUniqueId"] = "8Bzs1TvX8Bzs" })
					I[34] = new("UICorner", I[26], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "twtTesb5twtT" })
					I[35] = new("UIGradient", I[26], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) }, { ["_lemonadeUniqueId"] = "oalIUZZfoalI" })
				I[36] = new("Frame", I[4], "You", { BackgroundColor3 = Color3.fromRGB(138, 138, 138), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.2, 0.85) }, { ["_lemonadeUniqueId"] = "vpOueUCsvpOu" })
					I[37] = new("UIAspectRatioConstraint", I[36], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height }, { ["_lemonadeUniqueId"] = "bSVS0lhfbSVS" })
					I[38] = new("ImageLabel", I[36], "Avatar", { BackgroundColor3 = Color3.fromRGB(35, 35, 45), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=89659291&w=100&h=100"), Size = UDim2.fromScale(1, 1), ZIndex = 5 }, { ["_lemonadeUniqueId"] = "E2MVsnqSE2MV" })
						I[39] = new("UICorner", I[38], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "FA2VQDMGFA2V" })
						I[40] = new("UIStroke", I[38], "UIStroke", { Color = Color3.fromRGB(138, 138, 138), Thickness = 2, Transparency = 0.08 }, { ["_lemonadeUniqueId"] = "0alGqrVl0alG" })
						I[41] = new("TextLabel", I[38], "YouLabel", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.1), Size = UDim2.fromScale(1, 0.3), Text = "YOU!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "pqmAgBjPpqmA" })
							I[42] = new("UIStroke", I[41], "UIStroke", { Thickness = 2, Transparency = 0.04 }, { ["_lemonadeUniqueId"] = "jvIJyBNdjvIJ" })
						I[43] = new("TextLabel", I[38], "Amount", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1.1), Size = UDim2.fromScale(0.7, 0.3), Text = "0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 4 }, { ["_lemonadeUniqueId"] = "V8dojottV8do" })
							I[44] = new("UIStroke", I[43], "UIStroke", { Thickness = 2, Transparency = 0.04 }, { ["_lemonadeUniqueId"] = "FamcSddFFamc" })
						I[45] = new("ImageLabel", I[38], "TrophyIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://82857133407630"), Position = UDim2.fromScale(0.177214, 0.94471), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3782957, 0.3975998) }, { ["_lemonadeUniqueId"] = "XgoJRJtrXgoJ" })
					I[46] = new("UICorner", I[36], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "CRS9DxfHCRS9" })
					I[47] = new("UIGradient", I[36], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) }, { ["_lemonadeUniqueId"] = "wR9btDHZwR9b" })
			I[48] = new("TextLabel", I[2], "Title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, -1.25), Size = UDim2.fromScale(0.5, 0.5), Text = "MONSTER OBBY", TextColor3 = Color3.fromRGB(255, 214, 89), TextScaled = true, TextWrapped = true, ZIndex = 4 }, { ["_lemonadeUniqueId"] = "mml3hM7dmml3" })
				I[49] = new("UIStroke", I[48], "UIStroke", { Color = Color3.fromRGB(35, 26, 5), Thickness = 2.5 }, { ["_lemonadeUniqueId"] = "sF0OY8KYsF0O" })
			I[50] = new("TextLabel", I[2], "Subtitle", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, -0.75), Size = UDim2.fromScale(0.5, 0.35), Text = "GET THE MOST WINS", TextColor3 = Color3.fromRGB(255, 244, 216), TextScaled = true, TextWrapped = true, ZIndex = 4 }, { ["_lemonadeUniqueId"] = "lJrhtBNHlJrh" })
				I[51] = new("UIStroke", I[50], "UIStroke", { Color = Color3.fromRGB(35, 26, 5), Thickness = 2.5 }, { ["_lemonadeUniqueId"] = "reMluqooreMl" })
		I[52] = new("Frame", I[1], "Cover", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(2.5, 0.5), Rotation = 30, Size = UDim2.fromScale(1.7, 4.5), ZIndex = 9999 }, { ["_lemonadeUniqueId"] = "9DLN4e3v9DLN" })
	return I[1]
end

return build
