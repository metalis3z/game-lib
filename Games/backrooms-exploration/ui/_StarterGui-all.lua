-- Generated from ui/_StarterGui-all.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Slotsforinventory", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "Slot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://98920609911971"), Position = UDim2.fromScale(0.4443807, 0.05), Size = UDim2.fromOffset(115, 115), Visible = false })
			I[3] = new("ImageLabel", I[2], "Itemimage", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -4, Position = UDim2.fromScale(0.2347826, 0.2347826), Size = UDim2.fromOffset(61, 61) })
			I[4] = new("TextLabel", I[2], "Number", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/IndieFlower.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 5, Position = UDim2.fromScale(-0.5391304, 0.1652174), Size = UDim2.fromOffset(200, 50), Text = "1", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 70 })
		I[5] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
	I[6] = new("ScreenGui", nil, "MainInventory", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[7] = new("Frame", I[6], "Holder", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.1585478, 0.2125), Size = UDim2.fromOffset(584, 351), Visible = false })
			I[8] = new("ImageLabel", I[7], "Slot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://98920609911971"), Position = UDim2.fromScale(0.4776376, 0.4993055), Size = UDim2.fromOffset(790, 430) })
				I[9] = new("UIListLayout", I[8], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center, VerticalFlex = Enum.UIFlexAlignment.SpaceAround, Wraps = true })
				I[10] = new("ImageLabel", I[8], "Slot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://98920609911971"), Position = UDim2.fromScale(0.4443807, 0.05), Size = UDim2.fromOffset(115, 115) })
					I[11] = new("ImageLabel", I[10], "Itemimage", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -4, Position = UDim2.fromScale(0.2347826, 0.2347826), Size = UDim2.fromOffset(61, 61) })
					I[12] = new("TextLabel", I[10], "Number", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/IndieFlower.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 5, Position = UDim2.fromScale(-0.5391304, 0.1652174), Size = UDim2.fromOffset(200, 50), Text = "1", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 70 })
			I[13] = new("ImageLabel", I[7], "Slot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://98920609911971"), Position = UDim2.fromScale(0.1532826, 0.0455484), Size = UDim2.fromOffset(207, 94) })
				I[14] = new("TextLabel", I[13], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/IndieFlower.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0307914, 0.2300154), Size = UDim2.fromOffset(200, 50), Text = "Inventory", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 40 })
	I[15] = new("ScreenGui", nil, "TitleScreen", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[16] = new("Frame", I[15], "Holder", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4995769, 0.6458333), Size = UDim2.fromOffset(1397, 712) })
			I[17] = new("TextLabel", I[16], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/PressStart2P.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5010737, 0.2219101), Size = UDim2.fromOffset(200, 50), Text = "Backrooms", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 88 })
				I[18] = new("UIStroke", I[17], "UIStroke", { Thickness = 3 })
				I[19] = new("TextLabel", I[17], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/PressStart2P.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4967895, 1.4864044), Size = UDim2.fromOffset(200, 50), Text = "The Exploration", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 44 })
					I[20] = new("UIStroke", I[19], "UIStroke", { Thickness = 3 })
			I[21] = new("TextButton", I[16], "Startbutton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/PressStart2P.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5003579, 0.4073034), Size = UDim2.fromOffset(200, 50), Text = "Start", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 44 })
				I[22] = new("Frame", I[21], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4975, 0.57), Size = UDim2.fromOffset(181, 43) })
					I[23] = new("UIStroke", I[22], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
				I[24] = new("UIStroke", I[21], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
	I[25] = new("ScreenGui", nil, "VHSSTYLE", { SafeAreaCompatibility = Enum.SafeAreaCompatibility.None, ScreenInsets = Enum.ScreenInsets.None, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[26] = new("UIListLayout", I[25], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, HorizontalFlex = Enum.UIFlexAlignment.Fill, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[27] = new("CanvasGroup", I[25], "Holder", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.98, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5446097, 0.5), Size = UDim2.fromScale(0.8966504, 1) })
			I[28] = new("ImageLabel", I[27], "Static1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://135927051711724"), ImageTransparency = 0.91, Position = UDim2.fromScale(0.5, 0.5), ResampleMode = Enum.ResamplerMode.Pixelated, Size = UDim2.fromScale(1, 1), ZIndex = 3 })
			I[29] = new("ImageLabel", I[27], "Static2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://137864525305507"), ImageTransparency = 0.9, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 4 })
			I[30] = new("ImageLabel", I[27], "Static3", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://77041023963523"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Rotation = 180, ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(50, 79, 75, 88), SliceScale = 6, ZIndex = 5 })
			I[31] = new("ImageLabel", I[27], "Static4", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://13928716599"), ImageTransparency = 0.98, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(50, 79, 75, 88), ZIndex = 6 })
			I[32] = new("ImageLabel", I[27], "Static", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://135927051711724"), ImageTransparency = 0.74, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(4, 1), TileSize = UDim2.fromOffset(400, 400), ZIndex = -3 })
			I[33] = new("ImageLabel", I[27], "Vignette", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://12754479702"), ImageTransparency = 0.96, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 25 })
	I[34] = new("ScreenGui", nil, "DELETEME", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[35] = new("Frame", I[34], "Frame", { BackgroundColor3 = Color3.fromRGB(252, 255, 55), BackgroundTransparency = 0.55, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.1018077, 0.1069444), Size = UDim2.fromScale(0.8120736, 0.7944444), Visible = false })
			I[36] = new("UICorner", I[35], "UICorner")
			I[37] = new("UIStroke", I[35], "UIStroke", { Thickness = 4, Transparency = 0.55 })
			I[38] = new("TextLabel", I[35], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.400042, 0.3146853), Size = UDim2.fromOffset(172, 46), Text = "Cheese Uncopylocked", TextColor3 = Color3.fromRGB(249, 209, 27), TextSize = 80 })
				I[39] = new("UIStroke", I[38], "UIStroke", { Color = Color3.fromRGB(96, 36, 1), Thickness = 4 })
			I[40] = new("TextLabel", I[35], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8389332, 0.222028), Rotation = 35, Size = UDim2.fromOffset(172, 46), Text = "👑", TextColor3 = Color3.fromRGB(249, 209, 27), TextSize = 81 })
				I[41] = new("UIStroke", I[40], "UIStroke", { Color = Color3.fromRGB(96, 36, 1), Thickness = 4 })
			I[42] = new("TextLabel", I[35], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4094918, 0.4440559), Size = UDim2.fromOffset(172, 46), Text = "Made This File", TextColor3 = Color3.fromRGB(249, 209, 27), TextSize = 75 })
				I[43] = new("UIStroke", I[42], "UIStroke", { Color = Color3.fromRGB(96, 36, 1), Thickness = 4 })
			I[44] = new("TextLabel", I[35], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.8951049), Size = UDim2.fromOffset(172, 46), Text = "VIP", TextColor3 = Color3.fromRGB(249, 209, 27), TextSize = 80 })
				I[45] = new("UIStroke", I[44], "UIStroke", { Color = Color3.fromRGB(96, 36, 1), Thickness = 4 })
			I[46] = new("ImageLabel", I[35], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://111926035480507"), Size = UDim2.fromOffset(230, 151) })
			I[47] = new("TextLabel", I[35], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4094918, 0.5681819), Size = UDim2.fromOffset(172, 46), Text = "DO NOT LEAK", TextColor3 = Color3.fromRGB(249, 209, 27), TextSize = 65 })
				I[48] = new("UIStroke", I[47], "UIStroke", { Color = Color3.fromRGB(96, 36, 1), Thickness = 4 })
			I[49] = new("ImageLabel", I[35], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://111926035480507"), Position = UDim2.fromScale(0.7580848, 0.7797203), Size = UDim2.fromOffset(230, 151) })
			I[50] = new("TextLabel", I[35], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.400042, 0.9090909), Size = UDim2.fromOffset(172, 46), Text = "https://discord.gg/uu3TXW5Se3", TextColor3 = Color3.fromRGB(249, 209, 27), TextSize = 30 })
				I[51] = new("UIStroke", I[50], "UIStroke", { Color = Color3.fromRGB(96, 36, 1), Thickness = 4 })
			I[52] = new("TextLabel", I[35], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8189836, 0.0594406), Size = UDim2.fromOffset(172, 46), Text = "VIP", TextColor3 = Color3.fromRGB(249, 209, 27), TextSize = 80 })
				I[53] = new("UIStroke", I[52], "UIStroke", { Color = Color3.fromRGB(96, 36, 1), Thickness = 4 })
	return { I[1], I[6], I[15], I[25], I[34] }
end

return build
