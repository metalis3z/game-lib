-- Generated from ui/ServerStorage/Removed_RebirthTradeGuide/RebirthGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "RebirthGui", { DisplayOrder = 5, Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "NeedTemplate", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(0.5, -5, 1, 0) })
			I[3] = new("ViewportFrame", I[2], "View", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.new(0.5, 0, 0, 8), Size = UDim2.fromOffset(96, 96) })
				I[4] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[5] = new("UIStroke", I[3], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
				I[6] = new("UIGradient", I[3], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(236, 232, 244)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 252, 240)), ColorSequenceKeypoint.new(1, Color3.fromRGB(238, 226, 200)) }) })
			I[7] = new("TextLabel", I[2], "EggName", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(6, 108), Size = UDim2.new(1, -12, 0, 22), Text = "1 Common Egg pet", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
				I[8] = new("UIStroke", I[7], "TextStroke", { Thickness = 2.2 })
			I[9] = new("TextLabel", I[2], "Status", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(6, 150), Size = UDim2.new(1, -12, 0, 20), Text = "MISSING", TextColor3 = Color3.fromRGB(255, 130, 120), TextSize = 14 }, { ["MontFix"] = true })
				I[10] = new("UIStroke", I[9], "TextStroke", { Thickness = 2 })
			I[11] = new("TextLabel", I[2], "Source", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(6, 130), Size = UDim2.new(1, -12, 0, 20), Text = "Common Egg · 30%", TextColor3 = Color3.fromRGB(255, 248, 225), TextSize = 12 }, { ["MontFix"] = true })
				I[12] = new("UIStroke", I[11], "TextStroke", { Thickness = 2 })
			I[13] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
			I[14] = new("UIStroke", I[2], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
			I[15] = new("UIGradient", I[2], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 150, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(210, 88, 14)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 226, 160)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 168, 100)) }) })
		I[16] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromOffset(600, 500), Visible = false }, nil, { "AutoScale" })
			I[17] = new("ImageLabel", I[16], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(28, 28), ZIndex = 0 })
				I[18] = new("UIGradient", I[17], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 44, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 24, 58)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 228, 238)) }) })
				I[19] = new("UICorner", I[17], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
			I[20] = new("Frame", I[16], "Header", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromOffset(10, 10), Size = UDim2.new(1, -20, 0, 58) })
				I[21] = new("ImageLabel", I[20], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(28, 28), ZIndex = 0 })
					I[22] = new("UIGradient", I[21], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 136, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(222, 88, 12)) }) }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 70, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 120, 230)), ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 70, 255)) }) })
					I[23] = new("UICorner", I[21], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[24] = new("TextLabel", I[20], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(68, 9), Size = UDim2.new(0, 260, 1, -18), Text = "Rebirth", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
					I[25] = new("UIStroke", I[24], "TextStroke", { Thickness = 4.5 })
				I[26] = new("TextButton", I[20], "Close", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(1, -9, 0.5, 0), Size = UDim2.fromOffset(44, 44), Text = "", ZIndex = 2 }, { ["MontFix"] = true }, { "UIButton" })
					I[27] = new("Frame", I[26], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Rotation = 45, Size = UDim2.fromOffset(26, 7), Visible = false, ZIndex = 3 })
						I[28] = new("UICorner", I[27], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
						I[29] = new("UIStroke", I[27], "UIStroke", { Thickness = 1.5 })
					I[30] = new("Frame", I[26], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Rotation = -45, Size = UDim2.fromOffset(26, 7), Visible = false, ZIndex = 3 })
						I[31] = new("UICorner", I[30], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
						I[32] = new("UIStroke", I[30], "UIStroke", { Thickness = 1.5 })
					I[33] = new("TextLabel", I[26], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 5 })
						I[34] = new("UIPadding", I[33], "UIPadding", { PaddingBottom = UDim.new(0.12, 0), PaddingLeft = UDim.new(0.12, 0), PaddingRight = UDim.new(0.12, 0), PaddingTop = UDim.new(0.12, 0) })
						I[35] = new("UIStroke", I[33], "UIStroke", { Thickness = 3 })
					I[36] = new("ImageLabel", I[26], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), ZIndex = 2 })
						I[37] = new("UICorner", I[36], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
						I[38] = new("UIGradient", I[36], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 70, 70)), ColorSequenceKeypoint.new(1, Color3.fromRGB(196, 0, 26)) }), Rotation = 90 })
					I[39] = new("UICorner", I[26], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[40] = new("UIStroke", I[26], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
					I[41] = new("UIGradient", I[26], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 70, 70)), ColorSequenceKeypoint.new(1, Color3.fromRGB(196, 0, 26)) }), Rotation = 90 })
				I[42] = new("ImageLabel", I[20], "HeaderIcon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://105823629876720"), Position = UDim2.new(0, 10, 0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(50, 50), ZIndex = 3 })
				I[43] = new("CanvasGroup", I[20], "Shine", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
					I[44] = new("UICorner", I[43], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[45] = new("Frame", I[43], "Stripe", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.68, BorderSizePixel = 0, Position = UDim2.fromScale(0.52, 0.5), Rotation = 28, Size = UDim2.new(0, 44, 2.5999999, 0) })
					I[46] = new("Frame", I[43], "Stripe", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.68, BorderSizePixel = 0, Position = UDim2.fromScale(0.595, 0.5), Rotation = 28, Size = UDim2.new(0, 38, 2.5999999, 0) })
					I[47] = new("Frame", I[43], "Stripe", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.68, BorderSizePixel = 0, Position = UDim2.fromScale(0.67, 0.5), Rotation = 28, Size = UDim2.new(0, 32, 2.5999999, 0) })
				I[48] = new("UICorner", I[20], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[49] = new("UIStroke", I[20], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
				I[50] = new("UIGradient", I[20], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 136, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(222, 88, 12)) }) }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 70, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 120, 230)), ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 70, 255)) }) })
			I[51] = new("UICorner", I[16], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
			I[52] = new("UIStroke", I[16], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 4 })
			I[53] = new("UIGradient", I[16], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 44, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 24, 58)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 228, 238)) }) })
			I[54] = new("Frame", I[16], "Current", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromOffset(14, 80), Size = UDim2.new(1, -28, 0, 56) })
				I[55] = new("TextLabel", I[54], "Level", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(14, 0), Size = UDim2.new(0.5, -14, 1, 0), Text = "Rebirth 0/2", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 21, TextXAlignment = Enum.TextXAlignment.Left }, { ["MontFix"] = true })
					I[56] = new("UIStroke", I[55], "TextStroke", { Thickness = 2.5 })
				I[57] = new("TextLabel", I[54], "Mult", { AnchorPoint = Vector2.new(1, 0), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(1, -14, 0, 0), Size = UDim2.new(0.5, -14, 1, 0), Text = "Money x1", TextColor3 = Color3.fromRGB(170, 255, 150), TextSize = 21, TextXAlignment = Enum.TextXAlignment.Right }, { ["MontFix"] = true })
					I[58] = new("UIStroke", I[57], "TextStroke", { Thickness = 2.5 })
				I[59] = new("UICorner", I[54], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[60] = new("UIStroke", I[54], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
				I[61] = new("UIGradient", I[54], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 54, 108)), ColorSequenceKeypoint.new(1, Color3.fromRGB(46, 30, 66)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(206, 206, 212)), ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 128, 138)) }) })
			I[62] = new("Frame", I[16], "Next", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromOffset(14, 146), Size = UDim2.new(1, -28, 1, -226) })
				I[63] = new("ImageLabel", I[62], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(28, 28), ZIndex = 0 })
					I[64] = new("UIGradient", I[63], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 54, 108)), ColorSequenceKeypoint.new(1, Color3.fromRGB(46, 30, 66)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(206, 206, 212)), ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 128, 138)) }) })
					I[65] = new("UICorner", I[63], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[66] = new("TextLabel", I[62], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(14, 10), Size = UDim2.new(1, -28, 0, 30), Text = "Next: Rebirth 1  ·  Money x1.5", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 21 }, { ["MontFix"] = true })
					I[67] = new("UIStroke", I[66], "TextStroke", { Thickness = 2.5 })
				I[68] = new("TextLabel", I[62], "Cost", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(14, 40), Size = UDim2.new(1, -28, 0, 20), Text = "Cost: one pet from each egg below", TextColor3 = Color3.fromRGB(255, 248, 225), TextSize = 14 }, { ["MontFix"] = true })
					I[69] = new("UIStroke", I[68], "TextStroke", { Thickness = 1.8 })
				I[70] = new("Frame", I[62], "Needs", { BackgroundTransparency = 1, Position = UDim2.fromOffset(12, 66), Size = UDim2.new(1, -24, 1, -78) })
					I[71] = new("UIListLayout", I[70], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder })
				I[72] = new("TextLabel", I[62], "Maxed", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "MAX REBIRTH REACHED!", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 26, Visible = false, ZIndex = 3 }, { ["MontFix"] = true })
					I[73] = new("UIStroke", I[72], "TextStroke", { Thickness = 3 })
				I[74] = new("UICorner", I[62], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[75] = new("UIStroke", I[62], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
				I[76] = new("UIGradient", I[62], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 54, 108)), ColorSequenceKeypoint.new(1, Color3.fromRGB(46, 30, 66)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(206, 206, 212)), ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 128, 138)) }) })
			I[77] = new("TextButton", I[16], "RebirthNow", { AnchorPoint = Vector2.new(0.5, 1), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 1, -14), Size = UDim2.fromOffset(280, 54), Text = "Rebirth", TextTransparency = 1 }, { ["MontFix"] = true }, { "UIButton" })
				I[78] = new("TextLabel", I[77], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Rebirth", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 2 }, { ["MirrorText"] = true })
					I[79] = new("UIStroke", I[78], "TextStroke", { Thickness = 2.5 })
					I[80] = new("UIPadding", I[78], "UIPadding", { PaddingBottom = UDim.new(0, 7), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 7) })
				I[81] = new("ImageLabel", I[77], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26) })
					I[82] = new("UICorner", I[81], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[83] = new("UIGradient", I[81], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 226, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(66, 170, 70)) }), Rotation = 90 })
				I[84] = new("UICorner", I[77], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[85] = new("UIStroke", I[77], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3.5 })
				I[86] = new("UIGradient", I[77], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 226, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(66, 170, 70)) }), Rotation = 90 })
	return I[1]
end

return build
