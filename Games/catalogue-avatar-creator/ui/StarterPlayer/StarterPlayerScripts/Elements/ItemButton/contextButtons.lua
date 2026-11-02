-- Generated from ui/StarterPlayer/StarterPlayerScripts/Elements/ItemButton/contextButtons.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "contextButtons", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.358), Size = UDim2.fromScale(1, 0.716), ZIndex = 30 }, { ["SkipTheme"] = true })
		I[2] = new("TextButton", I[1], "tryOn", { AnchorPoint = Vector2.new(0.5, 0), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4975998, 0.0837023), Size = UDim2.fromScale(0.7431974, 0.2263889), Text = "Try On", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 30 }, { ["SkipTheme"] = true }, { "UIEffect" })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.175, 0), BottomRightRadius = UDim.new(0.175, 0), TopLeftRadius = UDim.new(0.175, 0), TopRightRadius = UDim.new(0.175, 0) }, { ["SkipTheme"] = true })
			I[4] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0.15, 0), PaddingTop = UDim.new(0.15, 0) }, { ["SkipTheme"] = true })
		I[5] = new("TextButton", I[1], "buy", { AnchorPoint = Vector2.new(0.5, 0), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(0, 216, 134), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4976, 0.3819857), Size = UDim2.fromScale(0.7431974, 0.2263888), Text = "Buy", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.8, TextWrapped = true, ZIndex = 30 }, { ["SkipTheme"] = true }, { "UIEffect" })
			I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0.175, 0), BottomRightRadius = UDim.new(0.175, 0), TopLeftRadius = UDim.new(0.175, 0), TopRightRadius = UDim.new(0.175, 0) }, { ["SkipTheme"] = true })
			I[7] = new("UIPadding", I[5], "UIPadding", { PaddingBottom = UDim.new(0.15, 0), PaddingTop = UDim.new(0.15, 0) }, { ["SkipTheme"] = true })
		I[8] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.075, 0), BottomRightRadius = UDim.new(0.075, 0), TopLeftRadius = UDim.new(0.075, 0), TopRightRadius = UDim.new(0.075, 0) }, { ["SkipTheme"] = true })
		I[9] = new("UIListLayout", I[1], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.07, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["SkipTheme"] = true })
		I[10] = new("Frame", I[1], "bottomButtons", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.743, 0.226) }, { ["SkipTheme"] = true })
			I[11] = new("TextButton", I[10], "inspect", { AnchorPoint = Vector2.new(1, 1), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8647219, 0.9110004), Size = UDim2.fromScale(0.45, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextTransparency = 1, ZIndex = 30 }, { ["SkipTheme"] = true }, { "UIEffect" })
				I[12] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(0.175, 0), BottomRightRadius = UDim.new(0.175, 0), TopLeftRadius = UDim.new(0.175, 0), TopRightRadius = UDim.new(0.175, 0) }, { ["SkipTheme"] = true })
				I[13] = new("ImageLabel", I[11], "image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(212, 212, 212), ImageContent = Content.fromUri("rbxassetid://89599939903201"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.8, 0.8) }, { ["SkipTheme"] = true })
				I[14] = new("UIStroke", I[11], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, BorderStrokePosition = Enum.BorderStrokePosition.Center, Color = Color3.fromRGB(212, 212, 212), Thickness = 1.5 }, { ["SkipTheme"] = true })
			I[15] = new("TextButton", I[10], "addToCart", { AnchorPoint = Vector2.new(0, 1), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.126, 0.911), Size = UDim2.fromScale(0.45, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextTransparency = 1, ZIndex = 30 }, { ["SkipTheme"] = true }, { "UIEffect" })
				I[16] = new("UICorner", I[15], "UICorner", { BottomLeftRadius = UDim.new(0.175, 0), BottomRightRadius = UDim.new(0.175, 0), TopLeftRadius = UDim.new(0.175, 0), TopRightRadius = UDim.new(0.175, 0) }, { ["SkipTheme"] = true })
				I[17] = new("ImageLabel", I[15], "image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(212, 212, 212), ImageContent = Content.fromUri("rbxassetid://80442995407260"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.8, 0.8) }, { ["SkipTheme"] = true })
				I[18] = new("UIStroke", I[15], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, BorderStrokePosition = Enum.BorderStrokePosition.Center, Color = Color3.fromRGB(212, 212, 212), Thickness = 1.5 }, { ["SkipTheme"] = true })
			I[19] = new("UIListLayout", I[10], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["SkipTheme"] = true })
	return I[1]
end

return build
