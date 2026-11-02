-- Generated from ui/ServerScriptService/Fake Purchases/FakePurchase/StartNew.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "StartNew", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(39, 41, 48), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, ImageColor3 = Color3.fromRGB(39, 41, 48), ImageContent = Content.fromUri("rbxassetid://73401554613866"), ImageRectOffset = Vector2.new(83, 494), ImageRectSize = Vector2.new(17, 17), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromOffset(400, 250), SliceCenter = Rect.new(8, 8, 9, 9) })
		I[2] = new("ImageLabel", I[1], "AlertContents", { BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromOffset(400, 250) })
			I[3] = new("ImageLabel", I[2], "Footer", { BackgroundTransparency = 1, LayoutOrder = 3, Size = UDim2.new(1, 0, 0, 48) })
				I[4] = new("ImageLabel", I[3], "FooterContent", { BackgroundTransparency = 1, LayoutOrder = 5, Size = UDim2.fromScale(1, 0) })
					I[5] = new("UIListLayout", I[4], "$layout", { SortOrder = Enum.SortOrder.LayoutOrder })
					I[6] = new("UIPadding", I[4], "$margin")
				I[7] = new("UIListLayout", I[3], "$layout", { Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder })
				I[8] = new("UIPadding", I[3], "$margin")
				I[9] = new("ImageLabel", I[3], "Buttons", { BackgroundTransparency = 1, LayoutOrder = 3, Size = UDim2.new(1, 0, 0, 36) })
					I[10] = new("ImageButton", I[9], "2", { AutoButtonColor = false, BackgroundTransparency = 1, ClipsDescendants = true, ImageColor3 = Color3.fromRGB(51, 95, 255), ImageContent = Content.fromUri("rbxassetid://73401554613866"), ImageRectOffset = Vector2.new(83, 494), ImageRectSize = Vector2.new(17, 17), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(1, 0, 0, 36), SliceCenter = Rect.new(8, 8, 9, 9) })
						I[11] = new("Frame", I[10], "ButtonContent", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
							I[12] = new("Frame", I[11], "ButtonMiddleContent", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
								I[13] = new("UIListLayout", I[12], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
								I[14] = new("TextLabel", I[12], "Text", { AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromOffset(37, 22), Text = " 0", TextColor3 = Color3.fromRGB(247, 247, 248), TextSize = 20, TextWrapped = true })
								I[15] = new("ImageLabel", I[12], "Icon", { BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(32, 34, 39), ImageContent = Content.fromUri("rbxassetid://73216797750710"), ImageRectOffset = Vector2.new(38, 418), ImageRectSize = Vector2.new(36, 36), LayoutOrder = 1, Size = UDim2.fromOffset(36, 36), Visible = false })
						I[16] = new("ImageLabel", I[10], "LoadingImage", { AnchorPoint = Vector2.new(1, 0.5), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://73401554613866"), ImageRectOffset = Vector2.new(159, 494), ImageRectSize = Vector2.new(17, 17), ImageTransparency = 0.5, Position = UDim2.fromScale(1, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(8, 8, 9, 9) })
					I[17] = new("UIListLayout", I[9], "$layout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
					I[18] = new("UIPadding", I[9], "$margin")
					I[19] = new("ImageButton", I[9], "1", { AutoButtonColor = false, BackgroundTransparency = 1, ClipsDescendants = true, ImageColor3 = Color3.fromRGB(51, 95, 255), ImageContent = Content.fromUri("rbxassetid://73401554613866"), ImageRectOffset = Vector2.new(83, 494), ImageRectSize = Vector2.new(17, 17), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(1, 0, 0, 36), SliceCenter = Rect.new(8, 8, 9, 9), Visible = false })
						I[20] = new("Frame", I[19], "ButtonContent", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
							I[21] = new("Frame", I[20], "ButtonMiddleContent", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
								I[22] = new("UIListLayout", I[21], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
								I[23] = new("TextLabel", I[21], "Text", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromOffset(37, 22), Text = " 0", TextColor3 = Color3.fromRGB(247, 247, 248), TextSize = 20, TextWrapped = true })
						I[24] = new("ImageLabel", I[19], "LoadingImage", { AnchorPoint = Vector2.new(1, 0.5), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://73401554613866"), ImageRectOffset = Vector2.new(159, 494), ImageRectSize = Vector2.new(17, 17), ImageTransparency = 0.5, Position = UDim2.fromScale(1, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(8, 8, 9, 9) })
			I[25] = new("UIListLayout", I[2], "$layout", { Padding = UDim.new(0, 24), SortOrder = Enum.SortOrder.LayoutOrder })
			I[26] = new("ImageLabel", I[2], "MiddleContent", { BackgroundTransparency = 1, LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 80) })
				I[27] = new("UIListLayout", I[26], "$layout", { SortOrder = Enum.SortOrder.LayoutOrder })
				I[28] = new("Frame", I[26], "Content", { AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.fromScale(1, 0) }, nil, { "x-default-transparency", "gui-object-defaults", "align-x-left", "align-y-center", "gap-small", "auto-y", "row" })
					I[29] = new("UIListLayout", I[28], "ListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
					I[30] = new("Frame", I[28], "ItemDetailsFrame", { AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.fromScale(1, 0) }, nil, { "x-default-transparency", "gui-object-defaults", "col", "auto-y", "gap-small" })
						I[31] = new("UIListLayout", I[30], "ListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder })
						I[32] = new("Frame", I[30], "ItemDetails", { AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.XY, BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 2 }, nil, { "x-default-transparency", "auto-xy", "gui-object-defaults", "align-y-center", "row", "gap-small" })
							I[33] = new("UIListLayout", I[32], "ListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
						I[34] = new("TextLabel", I[30], "ItemName", { AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, LineHeight = 1.1109999, Size = UDim2.fromOffset(266, 0), Text = "Orange Beanie with Black Hair", TextColor3 = Color3.fromRGB(247, 247, 248), TextSize = 17, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, nil, { "x-default-transparency", "text-wrap", "gui-object-defaults", "text-title-medium", "text-size-defaults", "auto-y", "text-align-x-left", "content-emphasis", "text-color-defaults", "text-defaults" })
							I[35] = new("UIPadding", I[34], "Padding")
					I[36] = new("ImageLabel", I[28], "ItemIcon", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/thumbs/asset.ashx?assetid=1103003368&x=100&y=100&format=png"), Position = UDim2.fromOffset(5, 5), Size = UDim2.fromOffset(80, 80) })
				I[37] = new("UIPadding", I[26], "$margin")
			I[38] = new("ImageLabel", I[2], "TitleContainer", { BackgroundTransparency = 1, LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 50) })
				I[39] = new("ImageLabel", I[38], "TitleArea", { BackgroundTransparency = 1, LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 38) })
					I[40] = new("UIListLayout", I[39], "$layout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder })
					I[41] = new("Frame", I[39], "Title", { BackgroundTransparency = 1, LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 25) })
						I[42] = new("TextLabel", I[41], "TitleText", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -96, 0, 50), Text = "Buy Item", TextColor3 = Color3.fromRGB(247, 247, 248), TextSize = 25, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true })
						I[43] = new("ImageButton", I[41], "CloseButton", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(247, 247, 248), ImageContent = Content.fromUri("rbxassetid://115236271433982"), ImageRectOffset = Vector2.new(378, 240), ImageRectSize = Vector2.new(36, 36), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromOffset(36, 36) })
					I[44] = new("Frame", I[39], "Underline", { BackgroundColor3 = Color3.fromRGB(208, 217, 251), BackgroundTransparency = 0.84, BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 1) })
					I[45] = new("UIPadding", I[39], "$margin")
				I[46] = new("UIListLayout", I[38], "$layout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder })
				I[47] = new("UIPadding", I[38], "$margin", { PaddingTop = UDim.new(0, 12) })
			I[48] = new("UIPadding", I[2], "$margin", { PaddingBottom = UDim.new(0, 24), PaddingLeft = UDim.new(0, 24), PaddingRight = UDim.new(0, 24) })
	return I[1]
end

return build
