-- Generated from ui/ServerStorage/Removed_SeedShopGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Removed_SeedShopGui", { DisplayOrder = 20, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "RowTemplate", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(1, 0, 0, 104), Visible = false })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 18), BottomRightRadius = UDim.new(0, 18), TopLeftRadius = UDim.new(0, 18), TopRightRadius = UDim.new(0, 18) })
			I[4] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 4 })
			I[5] = new("UIGradient", I[2], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(184, 238, 138)), ColorSequenceKeypoint.new(1, Color3.fromRGB(96, 184, 90)) }), Rotation = 90 })
			I[6] = new("Frame", I[2], "Accent", { BackgroundColor3 = Color3.fromRGB(96, 190, 84), BorderSizePixel = 0, Position = UDim2.fromOffset(6, 6), Size = UDim2.new(0, 8, 1, -12) })
				I[7] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0, 4), BottomRightRadius = UDim.new(0, 4), TopLeftRadius = UDim.new(0, 4), TopRightRadius = UDim.new(0, 4) })
			I[8] = new("ViewportFrame", I[2], "View", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.fromOffset(22, 9), Size = UDim2.fromOffset(86, 86) })
				I[9] = new("UICorner", I[8], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) })
				I[10] = new("UIStroke", I[8], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 3 })
				I[11] = new("UIGradient", I[8], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 252, 240)), ColorSequenceKeypoint.new(1, Color3.fromRGB(238, 226, 200)) }), Rotation = 90 })
			I[12] = new("TextLabel", I[2], "SeedName", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(120, 8), Size = UDim2.new(1, -274, 0, 28), Text = "Carrot Seed", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[13] = new("UIStroke", I[12], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 2.5 })
				I[14] = new("UIGradient", I[12], "UIGradient", { Enabled = false })
			I[15] = new("TextLabel", I[2], "Rarity", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(120, 37), Size = UDim2.new(1, -274, 0, 15), Text = "Common", TextColor3 = Color3.fromRGB(255, 236, 170), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[16] = new("UIStroke", I[15], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 1.5 })
			I[17] = new("TextLabel", I[2], "Grow", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(120, 55), Size = UDim2.new(1, -274, 0, 16), Text = "Grows in 0:20", TextColor3 = Color3.fromRGB(190, 240, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[18] = new("UIStroke", I[17], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 1.5 })
			I[19] = new("TextLabel", I[2], "Sell", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(120, 74), Size = UDim2.new(1, -274, 0, 18), Text = "Gives 10 XP to a pet", TextColor3 = Color3.fromRGB(140, 255, 130), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[20] = new("UIStroke", I[19], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 1.5 })
			I[21] = new("TextButton", I[2], "Buy", { AnchorPoint = Vector2.new(1, 0), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(1, -12, 0, 12), Size = UDim2.fromOffset(132, 56), Text = "$25", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextTransparency = 1, TextWrapped = true }, nil, { "UIButton" })
				I[22] = new("UICorner", I[21], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) })
				I[23] = new("UIStroke", I[21], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(36, 23, 51), Thickness = 3.5 })
				I[24] = new("UIGradient", I[21], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 214, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(245, 150, 50)) }), Rotation = 90 })
				I[25] = new("TextLabel", I[21], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "$25", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 2 }, { ["MirrorText"] = true })
					I[26] = new("UIStroke", I[25], "TextStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 2.5 })
					I[27] = new("UIPadding", I[25], "UIPadding", { PaddingBottom = UDim.new(0, 7), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 6) })
				I[28] = new("Frame", I[21], "FxGloss", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.72, BorderSizePixel = 0, Position = UDim2.fromOffset(6, 4), Size = UDim2.new(1, -12, 0.34, 0), ZIndex = 0 })
					I[29] = new("UICorner", I[28], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
				I[30] = new("Frame", I[21], "FxStitch", { BackgroundTransparency = 1, Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 1, -8), ZIndex = 0 })
					I[31] = new("UICorner", I[30], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
					I[32] = new("UIStroke", I[30], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 1.5, Transparency = 0.5 })
			I[33] = new("TextLabel", I[2], "Owned", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(1, -144, 0, 74), Size = UDim2.fromOffset(132, 18), Text = "Owned: 0", TextColor3 = Color3.fromRGB(255, 246, 220), TextScaled = true, TextWrapped = true })
				I[34] = new("UIStroke", I[33], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 1.5 })
			I[35] = new("ImageLabel", I[2], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.9, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(28, 28), ZIndex = 0 })
				I[36] = new("UICorner", I[35], "UICorner", { BottomLeftRadius = UDim.new(0, 18), BottomRightRadius = UDim.new(0, 18), TopLeftRadius = UDim.new(0, 18), TopRightRadius = UDim.new(0, 18) })
			I[37] = new("Frame", I[2], "FxGloss", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.72, BorderSizePixel = 0, Position = UDim2.fromOffset(6, 4), Size = UDim2.new(1, -12, 0.3, 0), ZIndex = 0 })
				I[38] = new("UICorner", I[37], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) })
			I[39] = new("Frame", I[2], "FxStitch", { BackgroundTransparency = 1, Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 1, -8), ZIndex = 0 })
				I[40] = new("UICorner", I[39], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) })
				I[41] = new("UIStroke", I[39], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 1.5, Transparency = 0.5 })
		I[42] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromOffset(640, 680), Visible = false }, nil, { "AutoScale" })
			I[43] = new("UICorner", I[42], "UICorner", { BottomLeftRadius = UDim.new(0, 26), BottomRightRadius = UDim.new(0, 26), TopLeftRadius = UDim.new(0, 26), TopRightRadius = UDim.new(0, 26) })
			I[44] = new("UIStroke", I[42], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 4.5 })
			I[45] = new("UIGradient", I[42], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(206, 150, 94)), ColorSequenceKeypoint.new(1, Color3.fromRGB(132, 84, 46)) }), Rotation = 90 })
			I[46] = new("ImageLabel", I[42], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.86, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(32, 32), ZIndex = 0 })
				I[47] = new("UICorner", I[46], "UICorner", { BottomLeftRadius = UDim.new(0, 20), BottomRightRadius = UDim.new(0, 20), TopLeftRadius = UDim.new(0, 20), TopRightRadius = UDim.new(0, 20) })
			I[48] = new("Frame", I[42], "Header", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromOffset(10, 10), Size = UDim2.new(1, -20, 0, 62) })
				I[49] = new("UICorner", I[48], "UICorner", { BottomLeftRadius = UDim.new(0, 18), BottomRightRadius = UDim.new(0, 18), TopLeftRadius = UDim.new(0, 18), TopRightRadius = UDim.new(0, 18) })
				I[50] = new("UIStroke", I[48], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 3.5 })
				I[51] = new("UIGradient", I[48], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 226, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(66, 170, 70)) }), Rotation = 90 })
				I[52] = new("ImageLabel", I[48], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.86, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(32, 32), ZIndex = 0 })
					I[53] = new("UICorner", I[52], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) })
				I[54] = new("Frame", I[48], "Trim", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 250, 236), BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 1, -6), Size = UDim2.new(1, -24, 0, 4) })
					I[55] = new("UICorner", I[54], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[56] = new("TextLabel", I[48], "Icon", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(12, 8), Size = UDim2.fromOffset(42, 42), Text = "🌱", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
					I[57] = new("UIStroke", I[56], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 2 })
				I[58] = new("TextLabel", I[48], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(60, 8), Size = UDim2.new(1, -130, 0, 42), Text = "Seed Shop", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[59] = new("UIStroke", I[58], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 4 })
				I[60] = new("TextButton", I[48], "Close", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.new(1, -9, 0.5, 0), Size = UDim2.fromOffset(44, 44), Text = "" }, nil, { "UIButton" })
					I[61] = new("UICorner", I[60], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) })
					I[62] = new("UIStroke", I[60], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(36, 23, 51), Thickness = 3.5 })
					I[63] = new("Frame", I[60], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Rotation = 45, Size = UDim2.fromOffset(26, 7) })
						I[64] = new("UICorner", I[63], "UICorner", { BottomLeftRadius = UDim.new(0, 3), BottomRightRadius = UDim.new(0, 3), TopLeftRadius = UDim.new(0, 3), TopRightRadius = UDim.new(0, 3) })
						I[65] = new("UIStroke", I[63], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 1.5 })
					I[66] = new("Frame", I[60], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Rotation = -45, Size = UDim2.fromOffset(26, 7) })
						I[67] = new("UICorner", I[66], "UICorner", { BottomLeftRadius = UDim.new(0, 3), BottomRightRadius = UDim.new(0, 3), TopLeftRadius = UDim.new(0, 3), TopRightRadius = UDim.new(0, 3) })
						I[68] = new("UIStroke", I[66], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 1.5 })
					I[69] = new("UIGradient", I[60], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 130, 120)), ColorSequenceKeypoint.new(1, Color3.fromRGB(214, 56, 66)) }), Rotation = 90 })
					I[70] = new("Frame", I[60], "FxGloss", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.72, BorderSizePixel = 0, Position = UDim2.fromOffset(6, 4), Size = UDim2.new(1, -12, 0.34, 0), ZIndex = 0 })
						I[71] = new("UICorner", I[70], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
				I[72] = new("Frame", I[48], "FxPlank", { BackgroundColor3 = Color3.fromRGB(43, 111, 46), BackgroundTransparency = 0.65, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.3333333), Size = UDim2.new(1, 0, 0, 2), ZIndex = 0 })
				I[73] = new("Frame", I[48], "FxPlank", { BackgroundColor3 = Color3.fromRGB(43, 111, 46), BackgroundTransparency = 0.65, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.6666667), Size = UDim2.new(1, 0, 0, 2), ZIndex = 0 })
				I[74] = new("Frame", I[48], "FxGloss", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.72, BorderSizePixel = 0, Position = UDim2.fromOffset(6, 4), Size = UDim2.new(1, -12, 0.3, 0), ZIndex = 0 })
					I[75] = new("UICorner", I[74], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) })
				I[76] = new("Frame", I[48], "FxStitch", { BackgroundTransparency = 1, Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 1, -8), ZIndex = 0 })
					I[77] = new("UICorner", I[76], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) })
					I[78] = new("UIStroke", I[76], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 1.5, Transparency = 0.5 })
			I[79] = new("TextLabel", I[42], "Subtitle", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(16, 78), Size = UDim2.new(1, -32, 0, 20), Text = "Plant seeds, harvest the crops and feed your pets to level them up!", TextColor3 = Color3.fromRGB(255, 246, 220), TextScaled = true, TextWrapped = true })
				I[80] = new("UIStroke", I[79], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 2 })
			I[81] = new("ScrollingFrame", I[42], "List", { AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromOffset(12, 104), ScrollBarImageColor3 = Color3.fromRGB(74, 44, 20), ScrollBarThickness = 6, Size = UDim2.new(1, -24, 1, -180) })
				I[82] = new("UIListLayout", I[81], "UIListLayout", { Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder })
				I[83] = new("UIPadding", I[81], "UIPadding", { PaddingBottom = UDim.new(0, 4), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 10), PaddingTop = UDim.new(0, 4) })
				I[84] = new("UIGradient", I[81], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 247, 224)), ColorSequenceKeypoint.new(1, Color3.fromRGB(243, 224, 178)) }), Rotation = 90 })
				I[85] = new("UICorner", I[81], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) })
				I[86] = new("UIStroke", I[81], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 3 })
			I[87] = new("Frame", I[42], "Grass", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.new(0, 10, 1, -10), Size = UDim2.new(1, -20, 0, 60) })
				I[88] = new("UICorner", I[87], "UICorner", { BottomLeftRadius = UDim.new(0, 16), BottomRightRadius = UDim.new(0, 16), TopLeftRadius = UDim.new(0, 16), TopRightRadius = UDim.new(0, 16) })
				I[89] = new("UIStroke", I[87], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 3 })
				I[90] = new("UIGradient", I[87], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 226, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(66, 170, 70)) }), Rotation = 90 })
				I[91] = new("TextLabel", I[87], "Weights", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(12, 6), Size = UDim2.new(1, -24, 0, 22), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
					I[92] = new("UIStroke", I[91], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 2 })
				I[93] = new("TextLabel", I[87], "Mutations", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(12, 31), Size = UDim2.new(1, -24, 0, 22), Text = "", TextColor3 = Color3.fromRGB(255, 246, 180), TextScaled = true, TextWrapped = true })
					I[94] = new("UIStroke", I[93], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 2 })
				I[95] = new("Frame", I[87], "FxGloss", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.72, BorderSizePixel = 0, Position = UDim2.fromOffset(6, 4), Size = UDim2.new(1, -12, 0.3, 0), ZIndex = 0 })
					I[96] = new("UICorner", I[95], "UICorner", { BottomLeftRadius = UDim.new(0, 12), BottomRightRadius = UDim.new(0, 12), TopLeftRadius = UDim.new(0, 12), TopRightRadius = UDim.new(0, 12) })
				I[97] = new("Frame", I[87], "FxStitch", { BackgroundTransparency = 1, Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 1, -8), ZIndex = 0 })
					I[98] = new("UICorner", I[97], "UICorner", { BottomLeftRadius = UDim.new(0, 12), BottomRightRadius = UDim.new(0, 12), TopLeftRadius = UDim.new(0, 12), TopRightRadius = UDim.new(0, 12) })
					I[99] = new("UIStroke", I[97], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 1.5, Transparency = 0.5 })
			I[100] = new("Frame", I[42], "FxPlank", { BackgroundColor3 = Color3.fromRGB(110, 66, 34), BackgroundTransparency = 0.6, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.1666667), Size = UDim2.new(1, 0, 0, 2), ZIndex = 0 })
			I[101] = new("Frame", I[42], "FxPlank", { BackgroundColor3 = Color3.fromRGB(110, 66, 34), BackgroundTransparency = 0.6, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.3333333), Size = UDim2.new(1, 0, 0, 2), ZIndex = 0 })
			I[102] = new("Frame", I[42], "FxPlank", { BackgroundColor3 = Color3.fromRGB(110, 66, 34), BackgroundTransparency = 0.6, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0, 2), ZIndex = 0 })
			I[103] = new("Frame", I[42], "FxPlank", { BackgroundColor3 = Color3.fromRGB(110, 66, 34), BackgroundTransparency = 0.6, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.6666667), Size = UDim2.new(1, 0, 0, 2), ZIndex = 0 })
			I[104] = new("Frame", I[42], "FxPlank", { BackgroundColor3 = Color3.fromRGB(110, 66, 34), BackgroundTransparency = 0.6, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.8333333), Size = UDim2.new(1, 0, 0, 2), ZIndex = 0 })
	return I[1]
end

return build
