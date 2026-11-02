-- Generated from ui/ReplicatedStorage/FakePurchase/Start.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "Start", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(39, 41, 48), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, ImageColor3 = Color3.fromRGB(39, 41, 48), ImageContent = Content.fromUri("rbxassetid://82359829738014"), ImageRectOffset = Vector2.new(83, 494), ImageRectSize = Vector2.new(17, 17), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromOffset(400, 336), SliceCenter = Rect.new(8, 8, 9, 9) }, { ["_lemonadeUniqueId"] = "SJmu8DyiSJmu" })
		I[2] = new("ImageLabel", I[1], "AlertContents", { BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromOffset(400, 336) }, { ["_lemonadeUniqueId"] = "XmxutRxFXmxu" })
			I[3] = new("ImageLabel", I[2], "Footer", { BackgroundTransparency = 1, LayoutOrder = 3, Size = UDim2.new(1, 0, 0, 62) }, { ["_lemonadeUniqueId"] = "zfkHTrpNzfkH" })
				I[4] = new("ImageLabel", I[3], "FooterContent", { BackgroundTransparency = 1, LayoutOrder = 5, Size = UDim2.new(1, 0, 0, 14) }, { ["_lemonadeUniqueId"] = "oGMjjff5oGMj" })
					I[5] = new("UIListLayout", I[4], "$layout", { SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "9ttnJP6e9ttn" })
					I[6] = new("ImageLabel", I[4], "Content", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 14) }, { ["_lemonadeUniqueId"] = "aTASVxD5aTAS" })
						I[7] = new("TextLabel", I[6], "Amount", { AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.fromOffset(282, 14), Text = "This is a test purchase. Your account will not be charged.", TextColor3 = Color3.fromRGB(213, 215, 221), TextSize = 12, TextWrapped = true }, { ["_lemonadeUniqueId"] = "A7NWjH8gA7NW" })
						I[8] = new("UIListLayout", I[6], "$layout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "SkYpEM2CSkYp" })
						I[9] = new("UIPadding", I[6], "$margin", nil, { ["_lemonadeUniqueId"] = "x9d0CyH5x9d0" })
					I[10] = new("UIPadding", I[4], "$margin", nil, { ["_lemonadeUniqueId"] = "lFRmVUA4lFRm" })
				I[11] = new("UIListLayout", I[3], "$layout", { Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "xSa8OPNLxSa8" })
				I[12] = new("UIPadding", I[3], "$margin", nil, { ["_lemonadeUniqueId"] = "Dr4aTyCKDr4a" })
				I[13] = new("ImageLabel", I[3], "Buttons", { BackgroundTransparency = 1, LayoutOrder = 3, Size = UDim2.new(1, 0, 0, 36) }, { ["_lemonadeUniqueId"] = "d5hNpEgMd5hN" })
					I[14] = new("ImageButton", I[13], "1", { AutoButtonColor = false, BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://82359829738014"), ImageRectOffset = Vector2.new(45, 494), ImageRectSize = Vector2.new(17, 17), ImageTransparency = 0.3, LayoutOrder = 1, ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromOffset(170, 36), SliceCenter = Rect.new(8, 8, 9, 9) }, { ["_lemonadeUniqueId"] = "rzuzHb4Yrzuz" })
						I[15] = new("Frame", I[14], "ButtonContent", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "ZJdmQpb1ZJdm" })
							I[16] = new("Frame", I[15], "ButtonMiddleContent", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "oWlRgci8oWlR" })
								I[17] = new("UIListLayout", I[16], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "oK7wf6JRoK7w" })
								I[18] = new("TextLabel", I[16], "Text", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromOffset(54, 22), Text = "Cancel", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 20, TextTransparency = 0.3, TextWrapped = true }, { ["_lemonadeUniqueId"] = "mP5NpTpBmP5N" })
					I[19] = new("ImageButton", I[13], "2", { AutoButtonColor = false, BackgroundTransparency = 1, ClipsDescendants = true, ImageColor3 = Color3.fromRGB(247, 247, 248), ImageContent = Content.fromUri("rbxassetid://82359829738014"), ImageRectOffset = Vector2.new(83, 494), ImageRectSize = Vector2.new(17, 17), LayoutOrder = 2, ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromOffset(170, 36), SliceCenter = Rect.new(8, 8, 9, 9) }, { ["_lemonadeUniqueId"] = "guqtqB5Fguqt" })
						I[20] = new("Frame", I[19], "ButtonContent", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "KSI0U2cYKSI0" })
							I[21] = new("Frame", I[20], "ButtonMiddleContent", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "Sl0wKnSaSl0w" })
								I[22] = new("UIListLayout", I[21], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "W8mDY7pzW8mD" })
								I[23] = new("TextLabel", I[21], "Text", { AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromOffset(27, 22), Text = "199", TextColor3 = Color3.fromRGB(32, 34, 39), TextSize = 20, TextWrapped = true }, { ["_lemonadeUniqueId"] = "S3XM65HZS3XM" })
								I[24] = new("ImageLabel", I[21], "Icon", { BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(32, 34, 39), ImageContent = Content.fromUri("rbxassetid://73216797750710"), ImageRectOffset = Vector2.new(38, 418), ImageRectSize = Vector2.new(36, 36), LayoutOrder = 1, Size = UDim2.fromOffset(36, 36) }, { ["_lemonadeUniqueId"] = "YJcQRaqIYJcQ" })
						I[25] = new("ImageLabel", I[19], "LoadingImage", { AnchorPoint = Vector2.new(1, 0.5), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://82359829738014"), ImageRectOffset = Vector2.new(159, 494), ImageRectSize = Vector2.new(17, 17), ImageTransparency = 0.5, Position = UDim2.fromScale(1, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(8, 8, 9, 9) }, { ["_lemonadeUniqueId"] = "2FXYE39J2FXY" })
					I[26] = new("UIListLayout", I[13], "$layout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "X3I9pSEmX3I9" })
					I[27] = new("UIPadding", I[13], "$margin", nil, { ["_lemonadeUniqueId"] = "KKOxdXVxKKOx" })
			I[28] = new("UIListLayout", I[2], "$layout", { Padding = UDim.new(0, 24), SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "VZJ27b9rVZJ2" })
			I[29] = new("ImageLabel", I[2], "MiddleContent", { BackgroundTransparency = 1, LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 151) }, { ["_lemonadeUniqueId"] = "mMJzwXeqmMJz" })
				I[30] = new("UIListLayout", I[29], "$layout", { SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "6Zl6jeVl6Zl6" })
				I[31] = new("ImageLabel", I[29], "Content", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 151) }, { ["_lemonadeUniqueId"] = "EO3iStEkEO3i" })
					I[32] = new("UIListLayout", I[31], "$layout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 24), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "cajvbxMWcajv" })
					I[33] = new("TextLabel", I[31], "ItemName", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromOffset(352, 42), Text = "Would you like to buy \"[Rainbow Machine] Fill Now\"?", TextColor3 = Color3.fromRGB(213, 215, 221), TextSize = 20, TextWrapped = true }, { ["_lemonadeUniqueId"] = "ggdh2BWKggdh" })
						I[34] = new("UISizeConstraint", I[33], "sizeConstraint", { MaxSize = Vector2.new(352, math.huge) }, { ["_lemonadeUniqueId"] = "x1ErpRSmx1Er" })
					I[35] = new("UIPadding", I[31], "$margin", nil, { ["_lemonadeUniqueId"] = "DJIU417LDJIU" })
					I[36] = new("ImageLabel", I[31], "ItemIcon", { BackgroundTransparency = 1, ImageContent = Content.fromUri("https://www.roblox.com/thumbs/asset.ashx?assetid=121866986699598&x=100&y=100&format=png"), LayoutOrder = 1, Position = UDim2.fromOffset(5, 5), Size = UDim2.fromOffset(85, 85) }, { ["_lemonadeUniqueId"] = "eKCcKr44eKCc" })
				I[37] = new("UIPadding", I[29], "$margin", nil, { ["_lemonadeUniqueId"] = "nABjhgzrnABj" })
			I[38] = new("ImageLabel", I[2], "TitleContainer", { BackgroundTransparency = 1, LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 51) }, { ["_lemonadeUniqueId"] = "NZ40tcxVNZ40" })
				I[39] = new("ImageLabel", I[38], "TitleArea", { BackgroundTransparency = 1, LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 39) }, { ["_lemonadeUniqueId"] = "oCU6HzYKoCU6" })
					I[40] = new("UIListLayout", I[39], "$layout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "cbLtU3K2cbLt" })
					I[41] = new("TextLabel", I[39], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.fromOffset(98, 26), Text = "Buy Item", TextColor3 = Color3.fromRGB(247, 247, 248), TextSize = 25, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true }, { ["_lemonadeUniqueId"] = "jkehtHKkjkeh" })
					I[42] = new("Frame", I[39], "Underline", { BackgroundColor3 = Color3.fromRGB(208, 217, 251), BackgroundTransparency = 0.84, BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 1) }, { ["_lemonadeUniqueId"] = "2lqMkhzx2lqM" })
					I[43] = new("UIPadding", I[39], "$margin", nil, { ["_lemonadeUniqueId"] = "CnYrVBh3CnYr" })
				I[44] = new("UIListLayout", I[38], "$layout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "8MdwCNlj8Mdw" })
				I[45] = new("UIPadding", I[38], "$margin", { PaddingTop = UDim.new(0, 12) }, { ["_lemonadeUniqueId"] = "gRr9iL4UgRr9" })
			I[46] = new("UIPadding", I[2], "$margin", { PaddingBottom = UDim.new(0, 24), PaddingLeft = UDim.new(0, 24), PaddingRight = UDim.new(0, 24) }, { ["_lemonadeUniqueId"] = "9SSmtVWe9SSm" })
	return I[1]
end

return build
