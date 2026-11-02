-- Generated from ui/ReplicatedStorage/FakePurchase/Finish.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "Finish", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(39, 41, 48), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, ImageColor3 = Color3.fromRGB(39, 41, 48), ImageContent = Content.fromUri("rbxassetid://82359829738014"), ImageRectOffset = Vector2.new(83, 494), ImageRectSize = Vector2.new(17, 17), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromOffset(400, 201), SliceCenter = Rect.new(8, 8, 9, 9) }, { ["_lemonadeUniqueId"] = "OBBUncNnOBBU" })
		I[2] = new("ImageLabel", I[1], "AlertContents", { BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromOffset(400, 201) }, { ["_lemonadeUniqueId"] = "36Pc412U36Pc" })
			I[3] = new("ImageLabel", I[2], "Footer", { BackgroundTransparency = 1, LayoutOrder = 3, Size = UDim2.new(1, 0, 0, 36) }, { ["_lemonadeUniqueId"] = "ThlsVvoKThls" })
				I[4] = new("UIListLayout", I[3], "$layout", { Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "NZBRkZJnNZBR" })
				I[5] = new("UIPadding", I[3], "$margin", nil, { ["_lemonadeUniqueId"] = "2als8m3f2als" })
				I[6] = new("ImageLabel", I[3], "Buttons", { BackgroundTransparency = 1, LayoutOrder = 3, Size = UDim2.new(1, 0, 0, 36) }, { ["_lemonadeUniqueId"] = "NnSVYjV9NnSV" })
					I[7] = new("ImageButton", I[6], "1", { AutoButtonColor = false, BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(247, 247, 248), ImageContent = Content.fromUri("rbxassetid://82359829738014"), ImageRectOffset = Vector2.new(83, 494), ImageRectSize = Vector2.new(17, 17), LayoutOrder = 1, ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromOffset(352, 36), SliceCenter = Rect.new(8, 8, 9, 9) }, { ["_lemonadeUniqueId"] = "MjL9HoD7MjL9" })
						I[8] = new("Frame", I[7], "ButtonContent", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "txooxMoetxoo" })
							I[9] = new("Frame", I[8], "ButtonMiddleContent", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "F50AqgPxF50A" })
								I[10] = new("UIListLayout", I[9], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "iaZHmsVFiaZH" })
								I[11] = new("TextLabel", I[9], "Text", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromOffset(24, 22), Text = "OK", TextColor3 = Color3.fromRGB(32, 34, 39), TextSize = 20, TextWrapped = true }, { ["_lemonadeUniqueId"] = "HTgoaG7ZHTgo" })
					I[12] = new("UIListLayout", I[6], "$layout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "vMqRPm53vMqR" })
					I[13] = new("UIPadding", I[6], "$margin", nil, { ["_lemonadeUniqueId"] = "npqEErVtnpqE" })
			I[14] = new("UIListLayout", I[2], "$layout", { Padding = UDim.new(0, 24), SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "J0wy4QyyJ0wy" })
			I[15] = new("ImageLabel", I[2], "MiddleContent", { BackgroundTransparency = 1, LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 42) }, { ["_lemonadeUniqueId"] = "vEcyqdG6vEcy" })
				I[16] = new("UIListLayout", I[15], "$layout", { SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "y2BtsMHdy2Bt" })
				I[17] = new("ImageLabel", I[15], "Content", { BackgroundTransparency = 1, LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 42) }, { ["_lemonadeUniqueId"] = "186pE3LH186p" })
					I[18] = new("TextLabel", I[17], "BodyText", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 42), Text = "Your purchase of [Rainbow Machine] Fill Now succeeded!", TextColor3 = Color3.fromRGB(213, 215, 221), TextSize = 20, TextWrapped = true }, { ["_lemonadeUniqueId"] = "OhGhddJ5OhGh" })
					I[19] = new("UIListLayout", I[17], "$layout", { Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "OaH6KjxfOaH6" })
					I[20] = new("UIPadding", I[17], "$margin", nil, { ["_lemonadeUniqueId"] = "yn9MGytVyn9M" })
				I[21] = new("UIPadding", I[15], "$margin", nil, { ["_lemonadeUniqueId"] = "db4hNIpzdb4h" })
			I[22] = new("ImageLabel", I[2], "TitleContainer", { BackgroundTransparency = 1, LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 51) }, { ["_lemonadeUniqueId"] = "QGbn1HDhQGbn" })
				I[23] = new("ImageLabel", I[22], "TitleArea", { BackgroundTransparency = 1, LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 39) }, { ["_lemonadeUniqueId"] = "XmbInPrNXmbI" })
					I[24] = new("UIListLayout", I[23], "$layout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "Od6tJY8sOd6t" })
					I[25] = new("TextLabel", I[23], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.fromOffset(98, 26), Text = "Buy Item", TextColor3 = Color3.fromRGB(247, 247, 248), TextSize = 25, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true }, { ["_lemonadeUniqueId"] = "IgKsoNsIIgKs" })
					I[26] = new("Frame", I[23], "Underline", { BackgroundColor3 = Color3.fromRGB(208, 217, 251), BackgroundTransparency = 0.84, BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 1) }, { ["_lemonadeUniqueId"] = "Kq0zAO8EKq0z" })
					I[27] = new("UIPadding", I[23], "$margin", nil, { ["_lemonadeUniqueId"] = "IuyLIDTBIuyL" })
				I[28] = new("UIListLayout", I[22], "$layout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "6s6M2URR6s6M" })
				I[29] = new("UIPadding", I[22], "$margin", { PaddingTop = UDim.new(0, 12) }, { ["_lemonadeUniqueId"] = "LTPAkUaqLTPA" })
			I[30] = new("UIPadding", I[2], "$margin", { PaddingBottom = UDim.new(0, 24), PaddingLeft = UDim.new(0, 24), PaddingRight = UDim.new(0, 24) }, { ["_lemonadeUniqueId"] = "l1QmWRzjl1Qm" })
	return I[1]
end

return build
