-- Generated from ui/StarterGui/ShopGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ShopGui", { Enabled = false })
		I[2] = new("Frame", I[1], "ShopBG", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromScale(0.4995455, 0.499686), Size = UDim2.fromScale(0.525974, 0.5443095) })
			I[3] = new("ScrollingFrame", I[2], "ItemScroller", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 7), Position = UDim2.fromScale(0.3474692, 0.5331534), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 3, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(0.6307678, 0.8498576) })
				I[4] = new("UIGridLayout", I[3], "UIGridLayout", { CellPadding = UDim2.fromOffset(5, 2), CellSize = UDim2.fromOffset(150, 120), FillDirectionMaxCells = 10, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
			I[5] = new("Frame", I[2], "ItemPreview", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(49, 49, 53), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromScale(0.8316443, 0.5007311), Size = UDim2.fromScale(0.3136283, 0.9560574) })
				I[6] = new("TextLabel", I[5], "ItemName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4988818, 0.6027921), Size = UDim2.fromScale(0.8762718, 0.0896324), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top })
				I[7] = new("TextLabel", I[5], "ItemDescription", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4988818, 0.7361477), RichText = true, Size = UDim2.fromScale(0.8762718, 0.1770787), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 20, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top })
				I[8] = new("TextButton", I[5], "BuyButton", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 255, 0), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5046182, 0.9167157), Selectable = false, Size = UDim2.fromScale(0.943527, 0.1184729), Text = "", TextColor3 = Color3.fromRGB(0, 255, 0), TextScaled = true, TextWrapped = true })
				I[9] = new("TextLabel", I[5], "ItemPrice", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.7, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.500941, 0.4965219), Size = UDim2.fromScale(0.9508816, 0.0909561), Text = "", TextColor3 = Color3.fromRGB(0, 255, 0), TextScaled = true, TextSize = 14, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 2 })
				I[10] = new("ImageLabel", I[5], "ItemImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(36, 36, 39), BackgroundTransparency = 0.5, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Position = UDim2.fromScale(0.501, 0.278), Size = UDim2.fromScale(0.951, 0.528) })
			I[11] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.6929737 })
			I[12] = new("Sound", I[2], "PurchaseSound", { Volume = 1.5 })
			I[13] = new("Sound", I[2], "ErrorSound", { Volume = 1 })
			I[14] = new("Sound", I[2], "ClickSound2", { Volume = 1 })
			I[15] = new("Sound", I[2], "ClickSound", { Volume = 1 })
			I[16] = new("TextLabel", I[2], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.4, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Light, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1253, -0.0477194), Size = UDim2.fromScale(0.2528819, 0.0909561), Text = "0 Points", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 2 })
		I[17] = new("ImageButton", I[1], "ItemSelection", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(49, 49, 53), BackgroundTransparency = 0.5, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.045, 0.112), Size = UDim2.fromScale(0.1957246, 0.2459343) })
			I[18] = new("ImageLabel", I[17], "ItemView", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Position = UDim2.fromScale(0.499, 0.497), Size = UDim2.fromScale(1.002, 1.006) })
	return I[1]
end

return build
