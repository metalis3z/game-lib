-- Generated from ui/StarterPlayer/StarterPlayerScripts/Elements/ItemButton/contextButtonsEmote.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "contextButtonsEmote", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.3699999), Size = UDim2.fromScale(0.9999999, 0.7400001), ZIndex = 30 }, { ["SkipTheme"] = true })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.075, 0), BottomRightRadius = UDim.new(0.075, 0), TopLeftRadius = UDim.new(0.075, 0), TopRightRadius = UDim.new(0.075, 0) }, { ["SkipTheme"] = true })
		I[3] = new("TextButton", I[1], "pose", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(39, 163, 216), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 3, Size = UDim2.fromScale(1, 0.28), Text = "Pose", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 30 }, { ["SkipTheme"] = true }, { "UIEffect" })
			I[4] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0.175, 0), BottomRightRadius = UDim.new(0.175, 0), TopLeftRadius = UDim.new(0.175, 0), TopRightRadius = UDim.new(0.175, 0) }, { ["SkipTheme"] = true })
			I[5] = new("UIPadding", I[3], "UIPadding", { PaddingBottom = UDim.new(0.15, 0), PaddingTop = UDim.new(0.15, 0) }, { ["SkipTheme"] = true })
		I[6] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0.09, 0), PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0), PaddingTop = UDim.new(0.09, 0) })
		I[7] = new("UIListLayout", I[1], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.08, 0), SortOrder = Enum.SortOrder.LayoutOrder })
		I[8] = new("Frame", I[1], "row1", { BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.fromScale(1, 0.28) })
			I[9] = new("UIListLayout", I[8], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[10] = new("TextButton", I[8], "tryOn", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.fromScale(0.65, 1), Text = "Try On", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 30 }, { ["SkipTheme"] = true }, { "UIEffect" })
				I[11] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(0.175, 0), BottomRightRadius = UDim.new(0.175, 0), TopLeftRadius = UDim.new(0.175, 0), TopRightRadius = UDim.new(0.175, 0) }, { ["SkipTheme"] = true })
				I[12] = new("UIPadding", I[10], "UIPadding", { PaddingBottom = UDim.new(0.15, 0), PaddingTop = UDim.new(0.15, 0) }, { ["SkipTheme"] = true })
			I[13] = new("TextButton", I[8], "inspect", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromScale(0.3, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextTransparency = 1, ZIndex = 30 }, { ["SkipTheme"] = true }, { "UIEffect" })
				I[14] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0.175, 0), BottomRightRadius = UDim.new(0.175, 0), TopLeftRadius = UDim.new(0.175, 0), TopRightRadius = UDim.new(0.175, 0) }, { ["SkipTheme"] = true })
				I[15] = new("ImageLabel", I[13], "image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(212, 212, 212), ImageContent = Content.fromUri("rbxassetid://89599939903201"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.8, 0.8) }, { ["SkipTheme"] = true })
				I[16] = new("UIStroke", I[13], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, BorderStrokePosition = Enum.BorderStrokePosition.Center, Color = Color3.fromRGB(212, 212, 212), Thickness = 1.5 }, { ["SkipTheme"] = true })
		I[17] = new("Frame", I[1], "row2", { BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.fromScale(1, 0.28) })
			I[18] = new("UIListLayout", I[17], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[19] = new("TextButton", I[17], "buy", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(0, 216, 134), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.fromScale(0.65, 1), Text = "Buy", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.8, TextWrapped = true, ZIndex = 30 }, { ["SkipTheme"] = true }, { "UIEffect" })
				I[20] = new("UICorner", I[19], "UICorner", { BottomLeftRadius = UDim.new(0.175, 0), BottomRightRadius = UDim.new(0.175, 0), TopLeftRadius = UDim.new(0.175, 0), TopRightRadius = UDim.new(0.175, 0) }, { ["SkipTheme"] = true })
				I[21] = new("UIPadding", I[19], "UIPadding", { PaddingBottom = UDim.new(0.15, 0), PaddingTop = UDim.new(0.15, 0) }, { ["SkipTheme"] = true })
			I[22] = new("TextButton", I[17], "addToCart", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromScale(0.3, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextTransparency = 1, ZIndex = 30 }, { ["SkipTheme"] = true }, { "UIEffect" })
				I[23] = new("UICorner", I[22], "UICorner", { BottomLeftRadius = UDim.new(0.175, 0), BottomRightRadius = UDim.new(0.175, 0), TopLeftRadius = UDim.new(0.175, 0), TopRightRadius = UDim.new(0.175, 0) }, { ["SkipTheme"] = true })
				I[24] = new("ImageLabel", I[22], "image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(212, 212, 212), ImageContent = Content.fromUri("rbxassetid://80442995407260"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.8, 0.8) }, { ["SkipTheme"] = true })
				I[25] = new("UIStroke", I[22], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, BorderStrokePosition = Enum.BorderStrokePosition.Center, Color = Color3.fromRGB(212, 212, 212), Thickness = 1.5 }, { ["SkipTheme"] = true })
	return I[1]
end

return build
