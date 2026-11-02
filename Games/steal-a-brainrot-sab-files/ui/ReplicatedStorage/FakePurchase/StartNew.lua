-- Generated from ui/ReplicatedStorage/FakePurchase/StartNew.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "StartNew", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(39, 41, 48), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, ImageColor3 = Color3.fromRGB(39, 41, 48), ImageContent = Content.fromUri("rbxassetid://73401554613866"), ImageRectOffset = Vector2.new(83, 494), ImageRectSize = Vector2.new(17, 17), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromOffset(400, 250), SliceCenter = Rect.new(8, 8, 9, 9) }, { ["_lemonadeUniqueId"] = "d7PVkXJbd7PV" })
		I[2] = new("ImageLabel", I[1], "AlertContents", { BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromOffset(400, 250) }, { ["_lemonadeUniqueId"] = "imGQdRuqimGQ" })
			I[3] = new("ImageLabel", I[2], "Footer", { BackgroundTransparency = 1, LayoutOrder = 3, Size = UDim2.new(1, 0, 0, 48) }, { ["_lemonadeUniqueId"] = "7phfI7R97phf" })
				I[4] = new("ImageLabel", I[3], "FooterContent", { BackgroundTransparency = 1, LayoutOrder = 5, Size = UDim2.fromScale(1, 0) }, { ["_lemonadeUniqueId"] = "Ld9uIOBDLd9u" })
					I[5] = new("UIListLayout", I[4], "$layout", { SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "khqtrWbjkhqt" })
					I[6] = new("UIPadding", I[4], "$margin", nil, { ["_lemonadeUniqueId"] = "cQSHQx5XcQSH" })
				I[7] = new("UIListLayout", I[3], "$layout", { Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "1SG4PhdJ1SG4" })
				I[8] = new("UIPadding", I[3], "$margin", nil, { ["_lemonadeUniqueId"] = "Rxgmv92oRxgm" })
				I[9] = new("ImageLabel", I[3], "Buttons", { BackgroundTransparency = 1, LayoutOrder = 3, Size = UDim2.new(1, 0, 0, 36) }, { ["_lemonadeUniqueId"] = "uzldqKyouzld" })
					I[10] = new("ImageButton", I[9], "2", { AutoButtonColor = false, BackgroundTransparency = 1, ClipsDescendants = true, ImageColor3 = Color3.fromRGB(51, 95, 255), ImageContent = Content.fromUri("rbxassetid://73401554613866"), ImageRectOffset = Vector2.new(83, 494), ImageRectSize = Vector2.new(17, 17), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(1, 0, 0, 36), SliceCenter = Rect.new(8, 8, 9, 9) }, { ["_lemonadeUniqueId"] = "YrUziQ9xYrUz" })
						I[11] = new("Frame", I[10], "ButtonContent", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "disc7wGcdisc" })
							I[12] = new("Frame", I[11], "ButtonMiddleContent", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "BKQLlYhFBKQL" })
								I[13] = new("UIListLayout", I[12], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "nNbwnPsgnNbw" })
								I[14] = new("TextLabel", I[12], "Buy", { AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromOffset(37, 22), Text = "Buy", TextColor3 = Color3.fromRGB(247, 247, 248), TextSize = 20, TextWrapped = true }, { ["_lemonadeUniqueId"] = "zuQNHdCSzuQN" })
								I[15] = new("ImageLabel", I[12], "Icon", { BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(32, 34, 39), ImageContent = Content.fromUri("rbxassetid://73216797750710"), ImageRectOffset = Vector2.new(38, 418), ImageRectSize = Vector2.new(36, 36), LayoutOrder = 1, Size = UDim2.fromOffset(36, 36), Visible = false }, { ["_lemonadeUniqueId"] = "W0cvHBzrW0cv" })
						I[16] = new("ImageLabel", I[10], "LoadingImage", { AnchorPoint = Vector2.new(1, 0.5), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://73401554613866"), ImageRectOffset = Vector2.new(159, 494), ImageRectSize = Vector2.new(17, 17), ImageTransparency = 0.5, Position = UDim2.fromScale(1, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(8, 8, 9, 9) }, { ["_lemonadeUniqueId"] = "idrFB20qidrF" })
					I[17] = new("UIListLayout", I[9], "$layout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "DrTFzIYiDrTF" })
					I[18] = new("UIPadding", I[9], "$margin", nil, { ["_lemonadeUniqueId"] = "fGVNn1DlfGVN" })
					I[19] = new("ImageButton", I[9], "1", { AutoButtonColor = false, BackgroundTransparency = 1, ClipsDescendants = true, ImageColor3 = Color3.fromRGB(51, 95, 255), ImageContent = Content.fromUri("rbxassetid://73401554613866"), ImageRectOffset = Vector2.new(83, 494), ImageRectSize = Vector2.new(17, 17), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(1, 0, 0, 36), SliceCenter = Rect.new(8, 8, 9, 9), Visible = false }, { ["_lemonadeUniqueId"] = "O1jyZsHtO1jy" })
						I[20] = new("Frame", I[19], "ButtonContent", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "7WOV40Mc7WOV" })
							I[21] = new("Frame", I[20], "ButtonMiddleContent", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "xGqdRKUixGqd" })
								I[22] = new("UIListLayout", I[21], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "uvNlNiI0uvNl" })
								I[23] = new("TextLabel", I[21], "Buy", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromOffset(37, 22), Text = "Buy", TextColor3 = Color3.fromRGB(247, 247, 248), TextSize = 20, TextWrapped = true }, { ["_lemonadeUniqueId"] = "fAIjLed7fAIj" })
						I[24] = new("ImageLabel", I[19], "LoadingImage", { AnchorPoint = Vector2.new(1, 0.5), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://73401554613866"), ImageRectOffset = Vector2.new(159, 494), ImageRectSize = Vector2.new(17, 17), ImageTransparency = 0.5, Position = UDim2.fromScale(1, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(8, 8, 9, 9) }, { ["_lemonadeUniqueId"] = "JkLLDrvlJkLL" })
			I[25] = new("UIListLayout", I[2], "$layout", { Padding = UDim.new(0, 24), SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "zdPophhhzdPo" })
			I[26] = new("ImageLabel", I[2], "MiddleContent", { BackgroundTransparency = 1, LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 80) }, { ["_lemonadeUniqueId"] = "WR373huiWR37" })
				I[27] = new("UIListLayout", I[26], "$layout", { SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "bj7odEkSbj7o" })
				I[28] = new("Frame", I[26], "Content", { AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.fromScale(1, 0) }, { ["_lemonadeUniqueId"] = "VKulvWDRVKul" }, { "x-default-transparency", "gui-object-defaults", "align-x-left", "align-y-center", "gap-small", "auto-y", "row" })
					I[29] = new("UIListLayout", I[28], "ListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "heegmS0Iheeg" })
					I[30] = new("Frame", I[28], "ItemDetailsFrame", { AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.fromScale(1, 0) }, { ["_lemonadeUniqueId"] = "eiyC8K8ueiyC" }, { "x-default-transparency", "gui-object-defaults", "col", "auto-y", "gap-small" })
						I[31] = new("UIListLayout", I[30], "ListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "arSvSDznarSv" })
						I[32] = new("Frame", I[30], "ItemDetails", { AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.XY, BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 2 }, { ["_lemonadeUniqueId"] = "CXPFgMoMCXPF" }, { "x-default-transparency", "auto-xy", "gui-object-defaults", "align-y-center", "row", "gap-small" })
							I[33] = new("UIListLayout", I[32], "ListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "2jL8HobN2jL8" })
						I[34] = new("TextLabel", I[30], "ItemName", { AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, LineHeight = 1.1109999, Size = UDim2.fromOffset(266, 0), Text = "Orange Beanie with Black Hair", TextColor3 = Color3.fromRGB(247, 247, 248), TextSize = 17, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "0MQlM7Db0MQl" }, { "x-default-transparency", "text-wrap", "gui-object-defaults", "text-title-medium", "text-size-defaults", "auto-y", "text-align-x-left", "content-emphasis", "text-color-defaults", "text-defaults" })
							I[35] = new("UIPadding", I[34], "Padding", nil, { ["_lemonadeUniqueId"] = "daWINz0EdaWI" })
						I[36] = new("TextLabel", I[30], "Price", { AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, LineHeight = 1.1109999, Size = UDim2.fromOffset(266, 0), Text = "Price", TextColor3 = Color3.fromRGB(247, 247, 248), TextSize = 17, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "Mz7rNe91Mz7r" }, { "x-default-transparency", "text-wrap", "gui-object-defaults", "text-title-medium", "text-size-defaults", "auto-y", "text-align-x-left", "content-emphasis", "text-color-defaults", "text-defaults" })
							I[37] = new("UIPadding", I[36], "Padding", nil, { ["_lemonadeUniqueId"] = "JytAPQ2YJytA" })
					I[38] = new("ImageLabel", I[28], "ItemIcon", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/thumbs/asset.ashx?assetid=1103003368&x=100&y=100&format=png"), Position = UDim2.fromOffset(5, 5), Size = UDim2.fromOffset(80, 80) }, { ["_lemonadeUniqueId"] = "XxYuiocWXxYu" })
				I[39] = new("UIPadding", I[26], "$margin", nil, { ["_lemonadeUniqueId"] = "piWTaNP5piWT" })
			I[40] = new("ImageLabel", I[2], "TitleContainer", { BackgroundTransparency = 1, LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 50) }, { ["_lemonadeUniqueId"] = "8Pj8aHBt8Pj8" })
				I[41] = new("UIListLayout", I[40], "$layout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "c0TZ7tuIc0TZ" })
				I[42] = new("UIPadding", I[40], "$margin", { PaddingTop = UDim.new(0, 12) }, { ["_lemonadeUniqueId"] = "dlxY9heQdlxY" })
				I[43] = new("ImageLabel", I[40], "TitleArea", { BackgroundTransparency = 1, LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 38) }, { ["_lemonadeUniqueId"] = "7NIGfEs87NIG" })
					I[44] = new("UIListLayout", I[43], "$layout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "hS54maPnhS54" })
					I[45] = new("Frame", I[43], "Title", { BackgroundTransparency = 1, LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 25) }, { ["_lemonadeUniqueId"] = "GKxWhVumGKxW" })
						I[46] = new("TextLabel", I[45], "TitleText", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.1221591, 0.6799999), Size = UDim2.new(0.6534091, -96, 0.1199998, 50), Text = "Buy Item", TextColor3 = Color3.fromRGB(247, 247, 248), TextSize = 25, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true }, { ["_lemonadeUniqueId"] = "m3I408k4m3I4" })
						I[47] = new("ImageButton", I[45], "CloseButton", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(247, 247, 248), ImageContent = Content.fromUri("rbxassetid://115236271433982"), ImageRectOffset = Vector2.new(378, 240), ImageRectSize = Vector2.new(36, 36), Position = UDim2.fromScale(0.9318182, 0.66), Size = UDim2.fromOffset(24, 26) }, { ["_lemonadeUniqueId"] = "UxCCMsayUxCC" })
						I[48] = new("TextLabel", I[45], "RobuxBalance", { AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, LineHeight = 1.1109999, Position = UDim2.fromScale(0.5, -0.18), Size = UDim2.fromOffset(134, 43), Text = "Balance", TextColor3 = Color3.fromRGB(247, 247, 248), TextSize = 17, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right }, { ["_lemonadeUniqueId"] = "ihcRQP11ihcR" }, { "x-default-transparency", "text-wrap", "gui-object-defaults", "text-title-medium", "text-size-defaults", "auto-y", "text-align-x-left", "content-emphasis", "text-color-defaults", "text-defaults" })
							I[49] = new("UIPadding", I[48], "Padding", nil, { ["_lemonadeUniqueId"] = "ABKHnhBPABKH" })
					I[50] = new("UIPadding", I[43], "$margin", nil, { ["_lemonadeUniqueId"] = "c8wPgmrdc8wP" })
			I[51] = new("UIPadding", I[2], "$margin", { PaddingBottom = UDim.new(0, 24), PaddingLeft = UDim.new(0, 24), PaddingRight = UDim.new(0, 24) }, { ["_lemonadeUniqueId"] = "6H6W2blZ6H6W" })
	return I[1]
end

return build
