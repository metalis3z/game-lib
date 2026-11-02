-- Generated from ui/ServerStorage/Removed_EggShopGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Removed_EggShopGui", { DisplayOrder = 20, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "RowTemplate", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(1, 0, 0, 106), Visible = false })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 18), BottomRightRadius = UDim.new(0, 18), TopLeftRadius = UDim.new(0, 18), TopRightRadius = UDim.new(0, 18) })
			I[4] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 4 })
			I[5] = new("UIGradient", I[2], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(176, 228, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(104, 166, 240)) }), Rotation = 90 })
			I[6] = new("ViewportFrame", I[2], "View", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.fromOffset(10, 10), Size = UDim2.fromOffset(86, 86) })
				I[7] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) })
				I[8] = new("UIStroke", I[6], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 3 })
				I[9] = new("UIGradient", I[6], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 252, 240)), ColorSequenceKeypoint.new(1, Color3.fromRGB(238, 226, 200)) }), Rotation = 90 })
			I[10] = new("TextLabel", I[2], "EggName", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(108, 8), Size = UDim2.new(1, -346, 0, 30), Text = "Common Egg", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[11] = new("UIStroke", I[10], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 2.5 })
				I[12] = new("UIGradient", I[10], "UIGradient", { Enabled = false })
			I[13] = new("TextLabel", I[2], "Info", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(108, 39), Size = UDim2.new(1, -346, 0, 16), Text = "1 kg · hatches in 0:30", TextColor3 = Color3.fromRGB(200, 235, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[14] = new("UIStroke", I[13], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 1.5 })
			I[15] = new("TextLabel", I[2], "Chances", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(108, 57), Size = UDim2.new(1, -346, 0, 44), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 13, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top })
				I[16] = new("UIStroke", I[15], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 1.5 })
			I[17] = new("TextButton", I[2], "Buy", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(1, -12, 0.5, 0), Size = UDim2.fromOffset(128, 62), Text = "$100", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextTransparency = 1, TextWrapped = true }, nil, { "UIButton" })
				I[18] = new("UICorner", I[17], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) })
				I[19] = new("UIStroke", I[17], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(36, 23, 51), Thickness = 3.5 })
				I[20] = new("UIGradient", I[17], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 214, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(245, 150, 50)) }), Rotation = 90 })
				I[21] = new("TextLabel", I[17], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "$100", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 2 }, { ["MirrorText"] = true })
					I[22] = new("UIStroke", I[21], "TextStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 2.5 })
					I[23] = new("UIPadding", I[21], "UIPadding", { PaddingBottom = UDim.new(0, 7), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 6) })
				I[24] = new("Frame", I[17], "FxGloss", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.72, BorderSizePixel = 0, Position = UDim2.fromOffset(6, 4), Size = UDim2.new(1, -12, 0.34, 0), ZIndex = 0 })
					I[25] = new("UICorner", I[24], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
				I[26] = new("Frame", I[17], "FxStitch", { BackgroundTransparency = 1, Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 1, -8), ZIndex = 0 })
					I[27] = new("UICorner", I[26], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
					I[28] = new("UIStroke", I[26], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 1.5, Transparency = 0.5 })
			I[29] = new("ImageLabel", I[2], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.9, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(28, 28), ZIndex = 0 })
				I[30] = new("UICorner", I[29], "UICorner", { BottomLeftRadius = UDim.new(0, 18), BottomRightRadius = UDim.new(0, 18), TopLeftRadius = UDim.new(0, 18), TopRightRadius = UDim.new(0, 18) })
			I[31] = new("Frame", I[2], "FxGloss", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.72, BorderSizePixel = 0, Position = UDim2.fromOffset(6, 4), Size = UDim2.new(1, -12, 0.3, 0), ZIndex = 0 })
				I[32] = new("UICorner", I[31], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) })
			I[33] = new("Frame", I[2], "FxStitch", { BackgroundTransparency = 1, Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 1, -8), ZIndex = 0 })
				I[34] = new("UICorner", I[33], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) })
				I[35] = new("UIStroke", I[33], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 1.5, Transparency = 0.5 })
			I[36] = new("ViewportFrame", I[2], "PetView", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.new(1, -152, 0.5, 0), Size = UDim2.fromOffset(74, 74) })
				I[37] = new("UICorner", I[36], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) })
				I[38] = new("UIStroke", I[36], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 3 })
				I[39] = new("UIGradient", I[36], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 252, 240)), ColorSequenceKeypoint.new(1, Color3.fromRGB(238, 226, 200)) }), Rotation = 90 })
		I[40] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromOffset(600, 640), Visible = false }, nil, { "AutoScale" })
			I[41] = new("UICorner", I[40], "UICorner", { BottomLeftRadius = UDim.new(0, 26), BottomRightRadius = UDim.new(0, 26), TopLeftRadius = UDim.new(0, 26), TopRightRadius = UDim.new(0, 26) })
			I[42] = new("UIStroke", I[40], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 4.5 })
			I[43] = new("UIGradient", I[40], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(206, 150, 94)), ColorSequenceKeypoint.new(1, Color3.fromRGB(132, 84, 46)) }), Rotation = 90 })
			I[44] = new("ImageLabel", I[40], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.86, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(32, 32), ZIndex = 0 })
				I[45] = new("UICorner", I[44], "UICorner", { BottomLeftRadius = UDim.new(0, 20), BottomRightRadius = UDim.new(0, 20), TopLeftRadius = UDim.new(0, 20), TopRightRadius = UDim.new(0, 20) })
			I[46] = new("Frame", I[40], "Header", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromOffset(10, 10), Size = UDim2.new(1, -20, 0, 58) })
				I[47] = new("UICorner", I[46], "UICorner", { BottomLeftRadius = UDim.new(0, 18), BottomRightRadius = UDim.new(0, 18), TopLeftRadius = UDim.new(0, 18), TopRightRadius = UDim.new(0, 18) })
				I[48] = new("UIStroke", I[46], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 3.5 })
				I[49] = new("UIGradient", I[46], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(130, 214, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 140, 236)) }), Rotation = 90 })
				I[50] = new("ImageLabel", I[46], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.86, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(32, 32), ZIndex = 0 })
					I[51] = new("UICorner", I[50], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) })
				I[52] = new("TextLabel", I[46], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(16, 9), Size = UDim2.new(1, -90, 1, -18), Text = "Egg Shop", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[53] = new("UIStroke", I[52], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 4 })
				I[54] = new("TextButton", I[46], "Close", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.new(1, -9, 0.5, 0), Size = UDim2.fromOffset(44, 44), Text = "" }, nil, { "UIButton" })
					I[55] = new("UICorner", I[54], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) })
					I[56] = new("UIStroke", I[54], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(36, 23, 51), Thickness = 3.5 })
					I[57] = new("Frame", I[54], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Rotation = 45, Size = UDim2.fromOffset(26, 7) })
						I[58] = new("UICorner", I[57], "UICorner", { BottomLeftRadius = UDim.new(0, 3), BottomRightRadius = UDim.new(0, 3), TopLeftRadius = UDim.new(0, 3), TopRightRadius = UDim.new(0, 3) })
						I[59] = new("UIStroke", I[57], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 1.5 })
					I[60] = new("Frame", I[54], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Rotation = -45, Size = UDim2.fromOffset(26, 7) })
						I[61] = new("UICorner", I[60], "UICorner", { BottomLeftRadius = UDim.new(0, 3), BottomRightRadius = UDim.new(0, 3), TopLeftRadius = UDim.new(0, 3), TopRightRadius = UDim.new(0, 3) })
						I[62] = new("UIStroke", I[60], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 1.5 })
					I[63] = new("UIGradient", I[54], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 130, 120)), ColorSequenceKeypoint.new(1, Color3.fromRGB(214, 56, 66)) }), Rotation = 90 })
					I[64] = new("Frame", I[54], "FxGloss", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.72, BorderSizePixel = 0, Position = UDim2.fromOffset(6, 4), Size = UDim2.new(1, -12, 0.34, 0), ZIndex = 0 })
						I[65] = new("UICorner", I[64], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
				I[66] = new("Frame", I[46], "FxPlank", { BackgroundColor3 = Color3.fromRGB(46, 91, 153), BackgroundTransparency = 0.65, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.3333333), Size = UDim2.new(1, 0, 0, 2), ZIndex = 0 })
				I[67] = new("Frame", I[46], "FxPlank", { BackgroundColor3 = Color3.fromRGB(46, 91, 153), BackgroundTransparency = 0.65, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.6666667), Size = UDim2.new(1, 0, 0, 2), ZIndex = 0 })
				I[68] = new("Frame", I[46], "FxGloss", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.72, BorderSizePixel = 0, Position = UDim2.fromOffset(6, 4), Size = UDim2.new(1, -12, 0.3, 0), ZIndex = 0 })
					I[69] = new("UICorner", I[68], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) })
				I[70] = new("Frame", I[46], "FxStitch", { BackgroundTransparency = 1, Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 1, -8), ZIndex = 0 })
					I[71] = new("UICorner", I[70], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) })
					I[72] = new("UIStroke", I[70], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 1.5, Transparency = 0.5 })
			I[73] = new("ScrollingFrame", I[40], "List", { AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromOffset(12, 80), ScrollBarImageColor3 = Color3.fromRGB(52, 30, 14), ScrollBarThickness = 6, Size = UDim2.new(1, -24, 1, -150) })
				I[74] = new("UIListLayout", I[73], "UIListLayout", { Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder })
				I[75] = new("UIPadding", I[73], "UIPadding", { PaddingBottom = UDim.new(0, 4), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 10), PaddingTop = UDim.new(0, 4) })
				I[76] = new("UIGradient", I[73], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 247, 224)), ColorSequenceKeypoint.new(1, Color3.fromRGB(243, 224, 178)) }), Rotation = 90 })
				I[77] = new("UICorner", I[73], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) })
				I[78] = new("UIStroke", I[73], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 3 })
			I[79] = new("TextLabel", I[40], "Sizes", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0, 14, 1, -64), Size = UDim2.new(1, -28, 0, 24), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
				I[80] = new("UIStroke", I[79], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 2 })
			I[81] = new("TextLabel", I[40], "Mutations", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0, 14, 1, -36), Size = UDim2.new(1, -28, 0, 24), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
				I[82] = new("UIStroke", I[81], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 2 })
			I[83] = new("Frame", I[40], "FxPlank", { BackgroundColor3 = Color3.fromRGB(110, 66, 34), BackgroundTransparency = 0.6, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.1666667), Size = UDim2.new(1, 0, 0, 2), ZIndex = 0 })
			I[84] = new("Frame", I[40], "FxPlank", { BackgroundColor3 = Color3.fromRGB(110, 66, 34), BackgroundTransparency = 0.6, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.3333333), Size = UDim2.new(1, 0, 0, 2), ZIndex = 0 })
			I[85] = new("Frame", I[40], "FxPlank", { BackgroundColor3 = Color3.fromRGB(110, 66, 34), BackgroundTransparency = 0.6, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0, 2), ZIndex = 0 })
			I[86] = new("Frame", I[40], "FxPlank", { BackgroundColor3 = Color3.fromRGB(110, 66, 34), BackgroundTransparency = 0.6, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.6666667), Size = UDim2.new(1, 0, 0, 2), ZIndex = 0 })
			I[87] = new("Frame", I[40], "FxPlank", { BackgroundColor3 = Color3.fromRGB(110, 66, 34), BackgroundTransparency = 0.6, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.8333333), Size = UDim2.new(1, 0, 0, 2), ZIndex = 0 })
	return I[1]
end

return build
