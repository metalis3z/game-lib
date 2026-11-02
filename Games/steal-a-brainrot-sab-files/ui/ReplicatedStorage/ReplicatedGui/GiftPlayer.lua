-- Generated from ui/ReplicatedStorage/ReplicatedGui/GiftPlayer.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "GiftPlayer", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "FXDtUlM6FXDt" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "GiftPlayer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.2180707, 0.3906393), Visible = false }, { ["_lemonadeUniqueId"] = "ccd5QTOwccd5" }, { "GiftPlayer" })
			I[3] = new("ImageLabel", I[2], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://76660575181533"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = -1 }, { ["_lemonadeUniqueId"] = "v0QTdGYyv0QT" })
				I[4] = new("ScrollingFrame", I[3], "List", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 1.26), Position = UDim2.fromScale(0.4972176, 0.5636825), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(0.9620757, 0.8294181) }, { ["_lemonadeUniqueId"] = "JL4DdkmAJL4D" })
					I[5] = new("UIListLayout", I[4], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.02, 0), SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "WTCAJEc4WTCA" })
					I[6] = new("UIPadding", I[4], "UIPadding", { PaddingBottom = UDim.new(0.4, 0), PaddingLeft = UDim.new(0.001, 0), PaddingRight = UDim.new(0.02, 0), PaddingTop = UDim.new(0.018, 0) }, { ["_lemonadeUniqueId"] = "7Qr61pJV7Qr6" })
					I[7] = new("ImageLabel", I[4], "Template", { AnchorPoint = Vector2.new(0.495, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(29, 213, 207), ImageContent = Content.fromUri("rbxassetid://114231710514920"), LayoutOrder = 1, Position = UDim2.fromScale(0.4828457, 1.0750948), Size = UDim2.fromScale(0.9258147, 0.1832901), Visible = false }, { ["_lemonadeUniqueId"] = "edG2ZMW2edG2" }, { "GamepassProduct" })
						I[8] = new("ImageLabel", I[7], "PlayerImage", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.0199632, 0.1354225), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1971098, 0.7751405) }, { ["_lemonadeUniqueId"] = "t2t9L8hJt2t9" })
							I[9] = new("ImageLabel", I[8], "Headshot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=47528603&w=100&h=100"), Position = UDim2.fromScale(0.4421634, 0.4709952), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.8585866, 0.9130038), ZIndex = 0 }, { ["_lemonadeUniqueId"] = "rrBDz7g4rrBD" })
						I[10] = new("TextLabel", I[7], "PlayerName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4422639, 0.4934732), Size = UDim2.fromScale(0.4551531, 0.3999805), Text = "@Untopica", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 }, { ["_lemonadeUniqueId"] = "kQiM1X6SkQiM" })
							I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "MWsT5kSgMWsT" }, { "ScreenStroke", "UIStroke" })
						I[12] = new("ImageButton", I[7], "Gift", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://116408748714507"), ImageContent = Content.fromUri("rbxassetid://90752545879126"), Position = UDim2.fromScale(0.899, 0.517), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1759811, 0.7968798) }, { ["_lemonadeUniqueId"] = "R2iekF1bR2ie" })
				I[13] = new("Frame", I[3], "Decoration", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.55, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4992851, 0.1526844), Size = UDim2.fromScale(0.9579408, 0.8308581), ZIndex = 0 }, { ["_lemonadeUniqueId"] = "nPcsuMSgnPcs" })
				I[14] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(51, 66, 73)), ColorSequenceKeypoint.new(1, Color3.fromRGB(51, 66, 73)) }), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0.3) }) }, { ["_lemonadeUniqueId"] = "C4oxzg5dC4ox" })
			I[15] = new("ImageLabel", I[2], "Header", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://137573329562191"), Position = UDim2.fromScale(0.5, 0.0681341), Size = UDim2.fromScale(1, 0.1362681), ZIndex = 0 }, { ["_lemonadeUniqueId"] = "UedmLS0sUedm" })
				I[16] = new("UIGradient", I[15], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 112, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 112, 127)) }) }, { ["_lemonadeUniqueId"] = "uyALOSIsuyAL" })
				I[17] = new("Frame", I[15], "Txts", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5415205), Size = UDim2.fromScale(1, 1.0830411) }, { ["_lemonadeUniqueId"] = "6ZrYqHDr6ZrY" })
					I[18] = new("UIListLayout", I[17], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.035, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "SN5ZMOjTSN5Z" })
					I[19] = new("TextLabel", I[17], "Txt1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.443038, 0.5000002), Size = UDim2.fromScale(0.4849127, 0.5392358), Text = "GIFT PLAYER", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "iduHUafviduH" })
						I[20] = new("UIStroke", I[19], "UIStroke", { Thickness = 4 }, { ["OriginalThickness"] = 4, ["_lemonadeUniqueId"] = "HbWeqeFrHbWe" }, { "ScreenStroke", "UIStroke" })
				I[21] = new("ImageButton", I[15], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://137110183435251"), ImageContent = Content.fromUri("rbxassetid://105016554772347"), Position = UDim2.fromScale(0.915, 0.528839), Size = UDim2.fromScale(0.1351187, 0.8680573) }, { ["_lemonadeUniqueId"] = "fbDXXGsQfbDX" })
					I[22] = new("TextLabel", I[21], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.56), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "MLG5snM6MLG5" })
						I[23] = new("UIStroke", I[22], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "HmXvnLjnHmXv" }, { "ScreenStroke", "UIStroke" })
						I[24] = new("UIPadding", I[22], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(-0.03, 0) }, { ["_lemonadeUniqueId"] = "Y4bNLL5TY4bN" })
			I[25] = new("UIStroke", I[2], "UIStroke", { Transparency = 0.6 }, { ["OriginalThickness"] = 1, ["_lemonadeUniqueId"] = "N3uXtU4qN3uX" }, { "ScreenStroke", "UIStroke" })
			I[26] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 0.91 }, { ["_lemonadeUniqueId"] = "pk8lkC2gpk8l" })
	return I[1]
end

return build
