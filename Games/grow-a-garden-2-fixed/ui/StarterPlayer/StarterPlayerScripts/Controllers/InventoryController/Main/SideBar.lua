-- Generated from ui/StarterPlayer/StarterPlayerScripts/Controllers/InventoryController/Main/SideBar.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "SideBar", { Active = true, AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(31, 31, 31), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0, -10, 0.5, 0), Size = UDim2.new(0, 87, 1, 0) })
		I[2] = new("UICorner", I[1], "UICorner")
		I[3] = new("Frame", I[1], "Seeds", { Active = true, BackgroundColor3 = Color3.fromRGB(31, 31, 31), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(3.6458333, -327, 1.0946057, -390), Size = UDim2.fromOffset(73, 96) })
			I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint")
			I[5] = new("TextLabel", I[3], "ToolCount", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.3), Text = "SEEDS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[6] = new("UIPadding", I[5], "UIPadding")
			I[7] = new("ImageLabel", I[3], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://122155906298794"), Position = UDim2.fromScale(0.5, 0.6281118), Size = UDim2.fromScale(0.95, 0.95) })
				I[8] = new("UIAspectRatioConstraint", I[7], "UIAspectRatioConstraint")
			I[9] = new("ImageButton", I[3], "ImageButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[10] = new("UICorner", I[3], "UICorner")
			I[11] = new("UIStroke", I[3], "SelectedStroke", { Color = Color3.fromRGB(255, 255, 255), Enabled = false, Thickness = 2 })
		I[12] = new("Frame", I[1], "Fruits", { Active = true, BackgroundColor3 = Color3.fromRGB(31, 31, 31), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.new(3.6458333, -327, 1.4174448, -390), Size = UDim2.fromOffset(73, 96) })
			I[13] = new("UICorner", I[12], "UICorner")
			I[14] = new("UIAspectRatioConstraint", I[12], "UIAspectRatioConstraint")
			I[15] = new("ImageButton", I[12], "ImageButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[16] = new("TextLabel", I[12], "ToolCount", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.3), Text = "CROPS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[17] = new("UIPadding", I[16], "UIPadding")
			I[18] = new("ImageLabel", I[12], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://104492362693467"), Position = UDim2.fromScale(0.5, 0.6442644), Size = UDim2.fromScale(0.7635552, 0.7114719) })
				I[19] = new("UIAspectRatioConstraint", I[18], "UIAspectRatioConstraint")
			I[20] = new("UIStroke", I[12], "SelectedStroke", { Color = Color3.fromRGB(255, 255, 255), Enabled = false, Thickness = 2 })
		I[21] = new("Frame", I[1], "Gears", { Active = true, BackgroundColor3 = Color3.fromRGB(31, 31, 31), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.new(3.6458333, -327, 1.7402838, -390), Size = UDim2.fromOffset(73, 96) })
			I[22] = new("UIStroke", I[21], "SelectedStroke", { Color = Color3.fromRGB(255, 255, 255), Enabled = false, Thickness = 2 })
			I[23] = new("ImageButton", I[21], "ImageButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[24] = new("TextLabel", I[21], "ToolCount", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.3), Text = "GEARS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[25] = new("UIPadding", I[24], "UIPadding")
			I[26] = new("ImageLabel", I[21], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://101028841690883"), Position = UDim2.fromScale(0.5, 0.6570835), Size = UDim2.fromScale(0.8468881, 0.6858329) })
				I[27] = new("UIAspectRatioConstraint", I[26], "UIAspectRatioConstraint")
			I[28] = new("UIAspectRatioConstraint", I[21], "UIAspectRatioConstraint")
			I[29] = new("UICorner", I[21], "UICorner")
		I[30] = new("Frame", I[1], "All", { Active = true, BackgroundColor3 = Color3.fromRGB(31, 31, 31), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 4, Position = UDim2.new(3.6458333, -327, 2.063123, -390), Size = UDim2.fromOffset(73, 96) })
			I[31] = new("UICorner", I[30], "UICorner")
			I[32] = new("ImageButton", I[30], "ImageButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[33] = new("TextLabel", I[30], "ToolCount", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.3), Text = "ALL", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[34] = new("UIPadding", I[33], "UIPadding")
			I[35] = new("ImageLabel", I[30], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://114322987676977"), Position = UDim2.fromScale(0.5, 0.62), Size = UDim2.fromScale(0.8468881, 0.6858329) })
				I[36] = new("UIAspectRatioConstraint", I[35], "UIAspectRatioConstraint")
			I[37] = new("UIStroke", I[30], "SelectedStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 3 })
			I[38] = new("UIAspectRatioConstraint", I[30], "UIAspectRatioConstraint")
		I[39] = new("UIListLayout", I[1], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Right, HorizontalFlex = Enum.UIFlexAlignment.Fill, Padding = UDim.new(0.02, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center, VerticalFlex = Enum.UIFlexAlignment.Fill })
		I[40] = new("Frame", I[1], "Pets", { Active = true, BackgroundColor3 = Color3.fromRGB(31, 31, 31), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, LayoutOrder = 3, Position = UDim2.new(3.6458333, -327, 1.0946057, -390), Size = UDim2.fromOffset(73, 96) })
			I[41] = new("UIAspectRatioConstraint", I[40], "UIAspectRatioConstraint")
			I[42] = new("TextLabel", I[40], "ToolCount", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.3), Text = "PETS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[43] = new("UIPadding", I[42], "UIPadding")
			I[44] = new("ImageLabel", I[40], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://125578382174064"), Position = UDim2.fromScale(0.5, 0.6281118), Size = UDim2.fromScale(0.95, 0.95) })
				I[45] = new("UIAspectRatioConstraint", I[44], "UIAspectRatioConstraint")
			I[46] = new("ImageButton", I[40], "ImageButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[47] = new("UICorner", I[40], "UICorner")
			I[48] = new("UIStroke", I[40], "SelectedStroke", { Color = Color3.fromRGB(255, 255, 255), Enabled = false, Thickness = 2 })
	return I[1]
end

return build
