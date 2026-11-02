-- Generated from ui/ServerScriptService/Fake Purchases/FakePurchase/Start.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "Start", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(39, 41, 48), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, ImageColor3 = Color3.fromRGB(39, 41, 48), ImageContent = Content.fromUri("rbxassetid://82359829738014"), ImageRectOffset = Vector2.new(83, 494), ImageRectSize = Vector2.new(17, 17), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromOffset(400, 336), SliceCenter = Rect.new(8, 8, 9, 9) })
		I[2] = new("ImageLabel", I[1], "AlertContents", { BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromOffset(400, 336) })
			I[3] = new("ImageLabel", I[2], "Footer", { BackgroundTransparency = 1, LayoutOrder = 3, Size = UDim2.new(1, 0, 0, 62) })
				I[4] = new("ImageLabel", I[3], "FooterContent", { BackgroundTransparency = 1, LayoutOrder = 5, Size = UDim2.new(1, 0, 0, 14) })
					I[5] = new("UIListLayout", I[4], "$layout", { SortOrder = Enum.SortOrder.LayoutOrder })
					I[6] = new("ImageLabel", I[4], "Content", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 14) })
						I[7] = new("TextLabel", I[6], "Amount", { AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.fromOffset(282, 14), Text = "This is a test purchase. Your account will not be charged.", TextColor3 = Color3.fromRGB(213, 215, 221), TextSize = 12, TextWrapped = true })
						I[8] = new("UIListLayout", I[6], "$layout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
						I[9] = new("UIPadding", I[6], "$margin")
					I[10] = new("UIPadding", I[4], "$margin")
				I[11] = new("UIListLayout", I[3], "$layout", { Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder })
				I[12] = new("UIPadding", I[3], "$margin")
				I[13] = new("ImageLabel", I[3], "Buttons", { BackgroundTransparency = 1, LayoutOrder = 3, Size = UDim2.new(1, 0, 0, 36) })
					I[14] = new("ImageButton", I[13], "1", { AutoButtonColor = false, BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://82359829738014"), ImageRectOffset = Vector2.new(45, 494), ImageRectSize = Vector2.new(17, 17), ImageTransparency = 0.3, LayoutOrder = 1, ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromOffset(170, 36), SliceCenter = Rect.new(8, 8, 9, 9) })
						I[15] = new("Frame", I[14], "ButtonContent", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
							I[16] = new("Frame", I[15], "ButtonMiddleContent", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
								I[17] = new("UIListLayout", I[16], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
								I[18] = new("TextLabel", I[16], "Text", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromOffset(54, 22), Text = "Cancel", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 20, TextTransparency = 0.3, TextWrapped = true })
					I[19] = new("ImageButton", I[13], "2", { AutoButtonColor = false, BackgroundTransparency = 1, ClipsDescendants = true, ImageColor3 = Color3.fromRGB(247, 247, 248), ImageContent = Content.fromUri("rbxassetid://82359829738014"), ImageRectOffset = Vector2.new(83, 494), ImageRectSize = Vector2.new(17, 17), LayoutOrder = 2, ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromOffset(170, 36), SliceCenter = Rect.new(8, 8, 9, 9) })
						I[20] = new("Frame", I[19], "ButtonContent", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
							I[21] = new("Frame", I[20], "ButtonMiddleContent", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
								I[22] = new("UIListLayout", I[21], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
								I[23] = new("TextLabel", I[21], "Text", { AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromOffset(27, 22), Text = "199", TextColor3 = Color3.fromRGB(32, 34, 39), TextSize = 20, TextWrapped = true })
								I[24] = new("ImageLabel", I[21], "Icon", { BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(32, 34, 39), ImageContent = Content.fromUri("rbxassetid://73216797750710"), ImageRectOffset = Vector2.new(38, 418), ImageRectSize = Vector2.new(36, 36), LayoutOrder = 1, Size = UDim2.fromOffset(36, 36) })
						I[25] = new("ImageLabel", I[19], "LoadingImage", { AnchorPoint = Vector2.new(1, 0.5), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://82359829738014"), ImageRectOffset = Vector2.new(159, 494), ImageRectSize = Vector2.new(17, 17), ImageTransparency = 0.5, Position = UDim2.fromScale(1, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(8, 8, 9, 9) })
					I[26] = new("UIListLayout", I[13], "$layout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder })
					I[27] = new("UIPadding", I[13], "$margin")
			I[28] = new("UIListLayout", I[2], "$layout", { Padding = UDim.new(0, 24), SortOrder = Enum.SortOrder.LayoutOrder })
			I[29] = new("ImageLabel", I[2], "MiddleContent", { BackgroundTransparency = 1, LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 151) })
				I[30] = new("UIListLayout", I[29], "$layout", { SortOrder = Enum.SortOrder.LayoutOrder })
				I[31] = new("ImageLabel", I[29], "Content", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 151) })
					I[32] = new("UIListLayout", I[31], "$layout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 24), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
					I[33] = new("TextLabel", I[31], "ItemName", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromOffset(352, 42), Text = "Would you like to buy \"[Rainbow Machine] Fill Now\"?", TextColor3 = Color3.fromRGB(213, 215, 221), TextSize = 20, TextWrapped = true })
						I[34] = new("UISizeConstraint", I[33], "sizeConstraint", { MaxSize = Vector2.new(352, math.huge) })
					I[35] = new("UIPadding", I[31], "$margin")
					I[36] = new("ImageLabel", I[31], "ItemIcon", { BackgroundTransparency = 1, ImageContent = Content.fromUri("https://www.roblox.com/thumbs/asset.ashx?assetid=121866986699598&x=100&y=100&format=png"), LayoutOrder = 1, Position = UDim2.fromOffset(5, 5), Size = UDim2.fromOffset(85, 85) })
				I[37] = new("UIPadding", I[29], "$margin")
			I[38] = new("ImageLabel", I[2], "TitleContainer", { BackgroundTransparency = 1, LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 51) })
				I[39] = new("ImageLabel", I[38], "TitleArea", { BackgroundTransparency = 1, LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 39) })
					I[40] = new("UIListLayout", I[39], "$layout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder })
					I[41] = new("TextLabel", I[39], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.fromOffset(98, 26), Text = "Buy Item", TextColor3 = Color3.fromRGB(247, 247, 248), TextSize = 25, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true })
					I[42] = new("Frame", I[39], "Underline", { BackgroundColor3 = Color3.fromRGB(208, 217, 251), BackgroundTransparency = 0.84, BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 1) })
					I[43] = new("UIPadding", I[39], "$margin")
				I[44] = new("UIListLayout", I[38], "$layout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder })
				I[45] = new("UIPadding", I[38], "$margin", { PaddingTop = UDim.new(0, 12) })
			I[46] = new("UIPadding", I[2], "$margin", { PaddingBottom = UDim.new(0, 24), PaddingLeft = UDim.new(0, 24), PaddingRight = UDim.new(0, 24) })
	return I[1]
end

return build
